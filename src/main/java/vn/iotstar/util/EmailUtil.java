package vn.iotstar.util;

import java.util.Date;
import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    // Cấu hình tài khoản gửi Email (Có thể cấu hình email Gmail & App Password thực tế tại đây)
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SENDER_EMAIL = "laptrinhweb.ute.noreply@gmail.com"; // Email gửi
    private static final String SENDER_PASSWORD = "xydm qrst uvwx yzab"; // App Password Gmail (16 ký tự)
    private static final String SENDER_NAME = "Hệ Thống Lap Trinh Web (UTE)";

    /**
     * Gửi email mã OTP (Kích hoạt tài khoản hoặc Đặt lại mật khẩu)
     */
    public static boolean sendOtpEmail(String recipientEmail, String otpCode, String subject, String purposeTitle) {
        System.out.println("=================================================");
        System.out.println(" [OTP EMAIL SERVICE] Đang xử lý gửi mã OTP...");
        System.out.println(" [Người nhận]: " + recipientEmail);
        System.out.println(" [Mục đích]: " + purposeTitle);
        System.out.println(" >>> MÃ OTP CỦA BẠN LÀ: [" + otpCode + "] <<<");
        System.out.println(" (Mã có hiệu lực trong vòng 5 phút)");
        System.out.println("=================================================");

        // Thử gửi qua giao thức SMTP thực tế
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.connectiontimeout", "5000");
            props.put("mail.smtp.timeout", "5000");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, SENDER_NAME, "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail, false));
            message.setSubject(subject, "UTF-8");
            message.setSentDate(new Date());

            String htmlContent = buildEmailTemplate(recipientEmail, otpCode, purposeTitle);
            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println(" [OTP EMAIL SERVICE] Đã gửi email thành công đến: " + recipientEmail);
            return true;
        } catch (Exception e) {
            System.err.println(" [OTP EMAIL SERVICE NOTE] Không thể gửi SMTP thật (Chi tiết: " + e.getMessage() + ").");
            System.err.println(" [DEV TEST MODE] Mã OTP [" + otpCode + "] đã được in ra console để phục vụ kiểm thử.");
            return false;
        }
    }

    /**
     * Tạo nội dung email HTML đẹp mắt và chuyên nghiệp
     */
    private static String buildEmailTemplate(String recipientEmail, String otpCode, String purposeTitle) {
        return "<div style=\"font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 600px; margin: 0 auto; padding: 25px; border: 1px solid #e2e8f0; border-radius: 12px; background: #ffffff;\">"
                + "<div style=\"text-align: center; margin-bottom: 25px;\">"
                + "<h2 style=\"color: #0284c7; margin: 0; font-size: 24px;\">HỆ THỐNG LẬP TRÌNH WEB</h2>"
                + "<p style=\"color: #64748b; font-size: 14px; margin-top: 5px;\">Xác thực bảo mật tài khoản</p>"
                + "</div>"
                + "<div style=\"background: #f0f9ff; padding: 20px; border-radius: 8px; border-left: 4px solid #0284c7; margin-bottom: 25px;\">"
                + "<p style=\"margin: 0 0 10px 0; color: #1e293b; font-size: 15px;\">Xin chào <strong>" + recipientEmail + "</strong>,</p>"
                + "<p style=\"margin: 0; color: #334155; font-size: 14px;\">Bạn vừa yêu cầu <strong>" + purposeTitle + "</strong>. Vui lòng sử dụng mã OTP dưới đây để hoàn tất:</p>"
                + "</div>"
                + "<div style=\"text-align: center; margin: 30px 0;\">"
                + "<span style=\"display: inline-block; font-size: 32px; font-weight: 700; letter-spacing: 8px; color: #0284c7; background: #e0f2fe; padding: 12px 30px; border-radius: 10px; border: 2px dashed #0284c7;\">"
                + otpCode + "</span>"
                + "<p style=\"color: #dc2626; font-size: 13px; margin-top: 10px;\"><i class=\"fa fa-clock-o\"></i> Mã OTP này có hiệu lực trong vòng <strong>5 phút</strong>.</p>"
                + "</div>"
                + "<p style=\"color: #64748b; font-size: 13px; line-height: 1.6;\">Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email hoặc liên hệ quản trị viên để được hỗ trợ.</p>"
                + "<hr style=\"border: none; border-top: 1px solid #e2e8f0; margin: 25px 0;\">"
                + "<div style=\"text-align: center; color: #94a3b8; font-size: 12px;\">"
                + "<p style=\"margin: 0;\">&copy; 2026 Lap Trinh Web - HCMUTE. Mọi quyền được bảo lưu.</p>"
                + "</div>"
                + "</div>";
    }
}
