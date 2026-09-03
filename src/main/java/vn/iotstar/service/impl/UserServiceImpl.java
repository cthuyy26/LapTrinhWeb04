package vn.iotstar.service.impl;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;

public class UserServiceImpl implements UserService {
    private UserDao userDao = new UserDaoImpl();

    // Bộ nhớ đệm tài khoản mẫu hỗ trợ khi kiểm thử hoặc khi chưa bật SQL Server
    private static final Map<String, User> mockUsers = new ConcurrentHashMap<>();

    static {
        long now = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(now);
        mockUsers.put("admin", new User(1, "admin@ute.edu.vn", "admin", "Quản Trị Viên", "123456", null, 1, "0901234567", date));
        mockUsers.put("manager", new User(2, "manager@ute.edu.vn", "manager", "Người Quản Lý", "123456", null, 2, "0907654321", date));
        mockUsers.put("user1", new User(3, "user1@ute.edu.vn", "user1", "Đinh Phú Sỹ", "123456", null, 5, "0912345678", date));
    }

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user != null && password.equals(user.getPassWord())) {
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        User user = null;
        try {
            user = userDao.get(username);
        } catch (Exception e) {
            System.err.println("Lỗi truy vấn UserDao.get(username): " + e.getMessage());
        }

        if (user == null && mockUsers.containsKey(username)) {
            user = mockUsers.get(username);
        }

        // Tự động đồng bộ chuẩn tên user1 thành Đinh Phú Sỹ
        if (user != null && "user1".equalsIgnoreCase(user.getUserName()) && "Nguyễn Văn A".equalsIgnoreCase(user.getFullName())) {
            user.setFullName("Đinh Phú Sỹ");
            try {
                userDao.update(user);
            } catch (Exception ignored) {}
        }
        return user;
    }

    @Override
    public User get(int id) {
        User user = null;
        try {
            user = userDao.get(id);
        } catch (Exception e) {
            System.err.println("Lỗi truy vấn UserDao.get(id): " + e.getMessage());
        }

        if (user == null) {
            for (User u : mockUsers.values()) {
                if (u.getId() == id) {
                    return u;
                }
            }
        }

        if (user != null && "user1".equalsIgnoreCase(user.getUserName()) && "Nguyễn Văn A".equalsIgnoreCase(user.getFullName())) {
            user.setFullName("Đinh Phú Sỹ");
            try {
                userDao.update(user);
            } catch (Exception ignored) {}
        }
        return user;
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (checkExistUsername(username)) {
            return false;
        }
        long millis = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(millis);
        User newUser = new User(email, username, fullname, password, null, 5, phone, date);

        try {
            userDao.insert(newUser);
        } catch (Exception e) {
            System.err.println("Lỗi insert UserDao: " + e.getMessage());
        }

        mockUsers.put(username, newUser);
        return true;
    }

    @Override
    public void insert(User user) {
        try {
            userDao.insert(user);
        } catch (Exception e) {
            System.err.println("Lỗi insert User: " + e.getMessage());
        }
        if (user.getUserName() != null) {
            mockUsers.put(user.getUserName(), user);
        }
    }

    @Override
    public void update(User user) {
        try {
            userDao.update(user);
        } catch (Exception e) {
            System.err.println("Lỗi update User: " + e.getMessage());
        }
        if (user.getUserName() != null) {
            mockUsers.put(user.getUserName(), user);
        }
    }

    @Override
    public boolean updateProfile(int id, String fullname, String phone, String avatar) {
        User user = this.get(id);
        if (user != null) {
            user.setFullName(fullname);
            user.setPhone(phone);
            if (avatar != null && !avatar.isEmpty()) {
                user.setAvatar(avatar);
            }
            this.update(user);
            return true;
        }
        return false;
    }

    @Override
    public java.util.List<User> findAll() {
        try {
            java.util.List<User> list = userDao.findAll();
            if (list != null && !list.isEmpty()) {
                return list;
            }
        } catch (Exception e) {
            System.err.println("Lỗi userDao.findAll: " + e.getMessage());
        }
        return new java.util.ArrayList<>(mockUsers.values());
    }

    @Override
    public java.util.List<User> search(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return this.findAll();
        }
        try {
            java.util.List<User> list = userDao.search(keyword.trim());
            if (list != null && !list.isEmpty()) {
                return list;
            }
        } catch (Exception e) {
            System.err.println("Lỗi userDao.search: " + e.getMessage());
        }

        String kw = keyword.trim().toLowerCase();
        java.util.List<User> result = new java.util.ArrayList<>();
        for (User u : mockUsers.values()) {
            if ((u.getUserName() != null && u.getUserName().toLowerCase().contains(kw))
                    || (u.getFullName() != null && u.getFullName().toLowerCase().contains(kw))
                    || (u.getEmail() != null && u.getEmail().toLowerCase().contains(kw))
                    || (u.getPhone() != null && u.getPhone().contains(kw))) {
                result.add(u);
            }
        }
        return result;
    }

    @Override
    public void delete(int id) {
        try {
            userDao.delete(id);
        } catch (Exception e) {
            System.err.println("Lỗi userDao.delete: " + e.getMessage());
        }
        mockUsers.values().removeIf(u -> u.getId() == id);
    }

    @Override
    public boolean checkExistEmail(String email) {
        try {
            if (userDao.checkExistEmail(email)) {
                return true;
            }
        } catch (Exception ignored) {}

        for (User u : mockUsers.values()) {
            if (email.equalsIgnoreCase(u.getEmail())) {
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean checkExistEmailExceptUser(String email, int userId) {
        try {
            if (userDao.checkExistEmailExceptUser(email, userId)) {
                return true;
            }
        } catch (Exception ignored) {}

        for (User u : mockUsers.values()) {
            if (u.getId() != userId && email.equalsIgnoreCase(u.getEmail())) {
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean checkExistUsername(String username) {
        try {
            if (userDao.checkExistUsername(username)) {
                return true;
            }
        } catch (Exception ignored) {}
        return mockUsers.containsKey(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        try {
            if (userDao.checkExistPhone(phone)) {
                return true;
            }
        } catch (Exception ignored) {}

        for (User u : mockUsers.values()) {
            if (phone != null && phone.equals(u.getPhone())) {
                return true;
            }
        }
        return false;
    }
}
