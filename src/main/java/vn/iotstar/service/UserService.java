package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface UserService {
    // Đăng nhập
    User login(String username, String password);

    // Lấy thông tin user
    User get(String username);
    User get(int id);

    // Đăng ký và thêm mới
    void insert(User user);
    boolean register(String username, String password, String email, String fullname, String phone);

    // Cập nhật thông tin
    void update(User user);
    boolean updateProfile(int id, String fullname, String phone, String avatar);

    // Quản lý danh sách người dùng
    java.util.List<User> findAll();
    java.util.List<User> search(String keyword);
    void delete(int id);

    // Kiểm tra tồn tại
    boolean checkExistEmail(String email);
    boolean checkExistEmailExceptUser(String email, int userId);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
}
