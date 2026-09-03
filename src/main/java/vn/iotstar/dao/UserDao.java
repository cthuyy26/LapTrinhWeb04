package vn.iotstar.dao;

import vn.iotstar.entity.User;

public interface UserDao {
    // Tìm người dùng theo username
    User get(String username);

    // Tìm người dùng theo id
    User get(int id);

    // Thêm người dùng mới
    void insert(User user);

    // Cập nhật thông tin người dùng (JPA merge)
    void update(User user);

    // Quản lý danh sách người dùng
    java.util.List<User> findAll();
    java.util.List<User> search(String keyword);
    void delete(int id);

    // Kiểm tra trùng lặp
    boolean checkExistEmail(String email);
    boolean checkExistEmailExceptUser(String email, int userId);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
}
