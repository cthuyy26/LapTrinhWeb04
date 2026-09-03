package vn.iotstar.controller.admin;

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
@WebServlet(urlPatterns = { "/admin/user/edit" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class UserEditController extends HttpServlet {

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

        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/user/list");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            User user = userService.get(id);
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/user/list");
                return;
            }
            req.setAttribute("user", user);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/user/edit-user.jsp");
            dispatcher.forward(req, resp);
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin/user/list");
        }
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

        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/user/list");
            return;
        }

        int id = Integer.parseInt(idStr);
        User user = userService.get(id);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/user/list");
            return;
        }

        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String roleidStr = req.getParameter("roleid");

        if (fullname != null && !fullname.trim().isEmpty()) {
            user.setFullName(fullname.trim());
        }

        if (email != null && !email.trim().isEmpty()) {
            String newEmail = email.trim();
            if (!newEmail.equalsIgnoreCase(user.getEmail())) {
                if (userService.checkExistEmailExceptUser(newEmail, user.getId())) {
                    req.setAttribute("error", "Địa chỉ email '" + newEmail + "' đã được sử dụng bởi người dùng khác!");
                    req.setAttribute("user", user);
                    req.getRequestDispatcher("/views/admin/user/edit-user.jsp").forward(req, resp);
                    return;
                } else {
                    user.setEmail(newEmail);
                }
            }
        }

        if (phone != null) {
            user.setPhone(phone.trim());
        }

        if (password != null && !password.trim().isEmpty()) {
            user.setPassWord(password.trim());
        }

        if (roleidStr != null) {
            try {
                int roleid = Integer.parseInt(roleidStr);
                user.setRoleid(roleid);
            } catch (NumberFormatException ignored) {}
        }

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
                user.setAvatar("user/" + fileName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            userService.update(user);
            // Nếu admin tự sửa chính mình thì cập nhật lại session
            if (currentAdmin.getId() == user.getId() || currentAdmin.getUserName().equals(user.getUserName())) {
                session.setAttribute("account", user);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/user/list?msg=updated");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi cập nhật người dùng: " + e.getMessage());
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/admin/user/edit-user.jsp").forward(req, resp);
        }
    }
}
