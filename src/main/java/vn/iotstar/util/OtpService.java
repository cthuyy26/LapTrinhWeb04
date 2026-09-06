package vn.iotstar.util;

import java.security.SecureRandom;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class OtpService {

    private static final SecureRandom random = new SecureRandom();
    private static final long OTP_VALID_DURATION_MS = 5 * 60 * 1000; // 5 phút

    public static class OtpEntry {
        private String otp;
        private long expiryTime;
        private Object data; // Lưu thông tin bổ sung (ví dụ User tạm thời hoặc email)

        public OtpEntry(String otp, long expiryTime, Object data) {
            this.otp = otp;
            this.expiryTime = expiryTime;
            this.data = data;
        }

        public String getOtp() {
            return otp;
        }

        public long getExpiryTime() {
            return expiryTime;
        }

        public Object getData() {
            return data;
        }

        public boolean isExpired() {
            return System.currentTimeMillis() > expiryTime;
        }
    }

    // Map lưu mã OTP theo key (ví dụ email hoặc username)
    private static final Map<String, OtpEntry> otpStorage = new ConcurrentHashMap<>();

    /**
     * Sinh mã OTP 6 chữ số ngẫu nhiên
     */
    public static String generateOtp(int length) {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }

    /**
     * Tạo và lưu mã OTP cho một key (email/username)
     */
    public static String createAndSaveOtp(String key, Object extraData) {
        String otp = generateOtp(6);
        long expiry = System.currentTimeMillis() + OTP_VALID_DURATION_MS;
        otpStorage.put(key.toLowerCase().trim(), new OtpEntry(otp, expiry, extraData));
        return otp;
    }

    /**
     * Lấy OtpEntry hiện tại của key
     */
    public static OtpEntry getOtpEntry(String key) {
        if (key == null) return null;
        return otpStorage.get(key.toLowerCase().trim());
    }

    /**
     * Kiểm tra tính hợp lệ của mã OTP
     */
    public static boolean verifyOtp(String key, String inputOtp) {
        if (key == null || inputOtp == null) {
            return false;
        }
        OtpEntry entry = otpStorage.get(key.toLowerCase().trim());
        if (entry == null) {
            return false;
        }
        if (entry.isExpired()) {
            otpStorage.remove(key.toLowerCase().trim());
            return false;
        }
        if (entry.getOtp().equals(inputOtp.trim())) {
            // Không xóa ngay để có thể lấy data nếu cần, caller có thể gọi clearOtp
            return true;
        }
        return false;
    }

    /**
     * Xóa OTP sau khi xác thực thành công
     */
    public static void clearOtp(String key) {
        if (key != null) {
            otpStorage.remove(key.toLowerCase().trim());
        }
    }
}
