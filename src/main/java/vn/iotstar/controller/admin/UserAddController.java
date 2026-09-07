package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;
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
@WebServlet(urlPatterns = { "/admin/user/add" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class UserAddController extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User currentAdmin = (User) session.getAttribute("account");
        if (currentAdmin.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/user/add-user.jsp");
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

        User currentAdmin = (User) session.getAttribute("account");
        if (currentAdmin.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String roleidStr = req.getParameter("roleid");

        int roleid = 5; // Default User
        try {
            if (roleidStr != null) {
                roleid = Integer.parseInt(roleidStr);
            }
        } catch (NumberFormatException ignored) {}

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()
                || email == null || email.trim().isEmpty() || fullname == null || fullname.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ các thông tin bắt buộc (*)");
            req.getRequestDispatcher("/views/admin/user/add-user.jsp").forward(req, resp);
            return;
        }

        if (password.trim().length() < 6) {
            req.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
            req.getRequestDispatcher("/views/admin/user/add-user.jsp").forward(req, resp);
            return;
        }

        if (!email.trim().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            req.setAttribute("error", "Địa chỉ email không đúng định dạng!");
            req.getRequestDispatcher("/views/admin/user/add-user.jsp").forward(req, resp);
            return;
        }

        if (phone != null && !phone.trim().isEmpty()) {
            if (!phone.trim().matches("^[0-9]{9,11}$")) {
                req.setAttribute("error", "Số điện thoại không hợp lệ (từ 9 đến 11 số)!");
                req.getRequestDispatcher("/views/admin/user/add-user.jsp").forward(req, resp);
                return;
            }
        }

        if (userService.checkExistUsername(username.trim())) {
            req.setAttribute("error", "Tên tài khoản '" + username.trim() + "' đã tồn tại!");
            req.getRequestDispatcher("/views/admin/user/add-user.jsp").forward(req, resp);
            return;
        }

        if (userService.checkExistEmail(email.trim())) {
            req.setAttribute("error", "Địa chỉ email '" + email.trim() + "' đã được sử dụng!");
            req.getRequestDispatcher("/views/admin/user/add-user.jsp").forward(req, resp);
            return;
        }

        String avatar = null;
        try {
            Part filePart = req.getPart("images");
            if (filePart == null || filePart.getSize() == 0) {
                filePart = req.getPart("avatar");
            }

            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String ext = "";
                int idx = submittedFileName.lastIndexOf(".");
                if (idx >= 0) {
                    ext = submittedFileName.substring(idx);
                }

                String fileName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString().substring(0, 8) + ext;
                File uploadDir = new File(Constant.DIR + "/user");
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                File targetFile = new File(uploadDir, fileName);
                filePart.write(targetFile.getAbsolutePath());
                avatar = "user/" + fileName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        User newUser = new User();
        newUser.setUserName(username.trim());
        newUser.setPassWord(password.trim());
        newUser.setFullName(fullname.trim());
        newUser.setEmail(email.trim());
        newUser.setPhone(phone != null ? phone.trim() : null);
        newUser.setRoleid(roleid);
        newUser.setAvatar(avatar);
        newUser.setCreatedDate(new Date(System.currentTimeMillis()));

        try {
            userService.insert(newUser);
            resp.sendRedirect(req.getContextPath() + "/admin/user/list?msg=added");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi tạo tài khoản: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/user/add-user.jsp").forward(req, resp);
        }
    }
}
