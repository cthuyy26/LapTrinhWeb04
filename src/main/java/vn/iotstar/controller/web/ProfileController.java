package vn.iotstar.controller.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/profile", "/user/profile", "/admin/profile" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,        // 10MB
    maxRequestSize = 1024 * 1024 * 50      // 50MB
)
public class ProfileController extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("account");
        User user = userService.get(sessionUser.getId());
        if (user == null) {
            user = userService.get(sessionUser.getUserName());
        }
        if (user == null) {
            user = sessionUser;
        }

        req.setAttribute("user", user);
        RequestDispatcher dispatcher = req.getRequestDispatcher(Constant.Path.PROFILE);
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("account");
        User user = userService.get(sessionUser.getId());
        if (user == null) {
            user = userService.get(sessionUser.getUserName());
        }
        if (user == null) {
            user = sessionUser;
        }

        String fullName = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");

        if (fullName == null || fullName.trim().isEmpty()) {
            req.setAttribute("error", "Họ và tên không được để trống!");
            req.setAttribute("user", user);
            req.getRequestDispatcher(Constant.Path.PROFILE).forward(req, resp);
            return;
        }
        user.setFullName(fullName.trim());

        if (phone != null && !phone.trim().isEmpty()) {
            String cleanPhone = phone.trim();
            if (!cleanPhone.matches("^[0-9]{9,11}$")) {
                req.setAttribute("error", "Số điện thoại không hợp lệ! Vui lòng nhập từ 9 đến 11 chữ số.");
                req.setAttribute("user", user);
                req.getRequestDispatcher(Constant.Path.PROFILE).forward(req, resp);
                return;
            }
            user.setPhone(cleanPhone);
        } else {
            user.setPhone(null);
        }

        // Admin có quyền đổi email của chính admin
        if (user.getRoleid() == 1 && email != null && !email.trim().isEmpty()) {
            String newEmail = email.trim();
            if (!newEmail.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                req.setAttribute("error", "Định dạng email không hợp lệ!");
                req.setAttribute("user", user);
                req.getRequestDispatcher(Constant.Path.PROFILE).forward(req, resp);
                return;
            }
            if (!newEmail.equalsIgnoreCase(user.getEmail())) {
                if (userService.checkExistEmailExceptUser(newEmail, user.getId())) {
                    req.setAttribute("error", "Địa chỉ email '" + newEmail + "' đã được sử dụng bởi tài khoản khác!");
                    req.setAttribute("user", user);
                    req.getRequestDispatcher(Constant.Path.PROFILE).forward(req, resp);
                    return;
                } else {
                    user.setEmail(newEmail);
                }
            }
        }

        try {
            // Hỗ trợ cả 2 tên trường multipart: images và avatar
            Part filePart = req.getPart("images");
            if (filePart == null || filePart.getSize() == 0) {
                filePart = req.getPart("avatar");
            }

            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String ext = "";
                int idx = submittedFileName.lastIndexOf(".");
                if (idx >= 0) {
                    ext = submittedFileName.substring(idx).toLowerCase();
                }

                if (!ext.equals(".jpg") && !ext.equals(".jpeg") && !ext.equals(".png") && !ext.equals(".gif") && !ext.equals(".webp")) {
                    req.setAttribute("error", "Định dạng file ảnh không hợp lệ! Chỉ chấp nhận: JPG, JPEG, PNG, GIF, WEBP.");
                    req.setAttribute("user", user);
                    req.getRequestDispatcher(Constant.Path.PROFILE).forward(req, resp);
                    return;
                }

                String fileName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString().substring(0, 8) + ext;
                File uploadDir = new File(Constant.DIR + "/user");
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                File targetFile = new File(uploadDir, fileName);
                filePart.write(targetFile.getAbsolutePath());
                user.setAvatar("user/" + fileName);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi trong quá trình upload hình ảnh: " + e.getMessage());
            req.setAttribute("user", user);
            req.getRequestDispatcher(Constant.Path.PROFILE).forward(req, resp);
            return;
        }

        try {
            userService.update(user);
            // Cập nhật lại session để topbar và các trang khác nhận dữ liệu mới
            session.setAttribute("account", user);
            req.setAttribute("message", "Cập nhật thông tin cá nhân thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi lưu thông tin vào cơ sở dữ liệu: " + e.getMessage());
        }

        req.setAttribute("user", user);
        RequestDispatcher dispatcher = req.getRequestDispatcher(Constant.Path.PROFILE);
        dispatcher.forward(req, resp);
    }
}
