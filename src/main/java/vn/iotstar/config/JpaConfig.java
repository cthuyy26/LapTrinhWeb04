package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaConfig {

    private static EntityManagerFactory factory = null;

    static {
        try {
            factory = Persistence.createEntityManagerFactory("jpa-hibernate-sql");
        } catch (Throwable ex) {
            System.err.println("===============================================================");
            System.err.println(" [CẢNH BÁO JpaConfig] Không thể khởi tạo EntityManagerFactory!");
            System.err.println(" Chi tiết lỗi: " + ex.getMessage());
            System.err.println(" Gợi ý: Hãy kiểm tra tài khoản, mật khẩu SQL Server trong persistence.xml");
            System.err.println(" Hệ thống sẽ tự động chuyển sang chế độ Mock Data dự phòng để ứng dụng không bị lỗi 404/500.");
            System.err.println("===============================================================");
        }
    }

    // Lấy EntityManager phục vụ cho mỗi phiên truy vấn
    public static EntityManager getEntityManager() {
        if (factory == null) {
            try {
                factory = Persistence.createEntityManagerFactory("jpa-hibernate-sql");
            } catch (Throwable ignored) {}
        }
        if (factory != null) {
            return factory.createEntityManager();
        }
        return null;
    }
}
