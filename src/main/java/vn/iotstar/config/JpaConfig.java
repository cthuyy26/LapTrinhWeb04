package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaConfig {

    // Khởi tạo một lần duy nhất khi ứng dụng bắt đầu chạy
    private static final EntityManagerFactory factory = Persistence.createEntityManagerFactory("jpa-hibernate-sql");

    // Lấy EntityManager phục vụ cho mỗi phiên truy vấn
    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }
}
