package vn.iotstar.controller.web;

import java.io.IOException;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;
import vn.iotstar.util.EmailUtil;
import vn.iotstar.util.OtpService;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        // Check cookie Remember Me
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (Constant.COOKIE_REMEMBER.equals(cookie.getName())) {
                    String username = cookie.getValue();
                    if (username != null && !username.isEmpty()) {
                        UserService service = new UserServiceImpl();
                        User user = service.get(username);
                        if (user != null) {
                            session = req.getSession(true);
                            session.setAttribute("account", user);
                            session.setAttribute("username", username);
                            resp.sendRedirect(req.getContextPath() + "/waiting");
                            return;
                        }
                    }
                }
            }
        }
        req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        UserService service = new UserServiceImpl();
        String alertMsg = "";

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty() || email == null || email.trim().isEmpty() || fullname == null || fullname.trim().isEmpty()) {
            alertMsg = "Vui lòng nhập đầy đủ các trường bắt buộc (*)!";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        email = email.trim();
        username = username.trim();
        fullname = fullname.trim();

        if (username.length() < 3 || username.length() > 30) {
            alertMsg = "Tên tài khoản phải từ 3 đến 30 ký tự!";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            alertMsg = "Địa chỉ email không đúng định dạng!";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        if (password.length() < 6) {
            alertMsg = "Mật khẩu phải có độ dài từ 6 ký tự trở lên!";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        if (phone != null && !phone.trim().isEmpty()) {
            phone = phone.trim();
            if (!phone.matches("^[0-9]{9,11}$")) {
                alertMsg = "Số điện thoại không hợp lệ (từ 9 đến 11 chữ số)!";
                req.setAttribute("alert", alertMsg);
                req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
                return;
            }
        } else {
            phone = null;
        }

        if (service.checkExistEmail(email)) {
            alertMsg = "Email đã được đăng ký trong hệ thống!";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        if (service.checkExistUsername(username)) {
            alertMsg = "Tên tài khoản đã tồn tại!";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        // Tạo đối tượng User tạm thời chờ xác thực OTP
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        User pendingUser = new User(email, username, fullname, password, null, 5, phone, date);

        // Sinh mã OTP và lưu vào OtpService (kèm User data)
        String otp = OtpService.createAndSaveOtp(email, pendingUser);

        // Gửi email OTP
        EmailUtil.sendOtpEmail(email, otp, "Mã Xác Thực Kích Hoạt Tài Khoản - Lap Trinh Web", "kích hoạt tài khoản mới");

        // Lưu thông tin email chờ xác thực vào Session
        HttpSession session = req.getSession(true);
        session.setAttribute("pendingRegisterEmail", email);
        session.setAttribute("devOtp", otp); // Hỗ trợ hiển thị gợi ý test nhanh trên giao diện

        resp.sendRedirect(req.getContextPath() + "/verify-register-otp");
    }
}
