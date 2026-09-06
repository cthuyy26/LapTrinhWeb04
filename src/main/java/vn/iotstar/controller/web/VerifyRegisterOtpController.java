package vn.iotstar.controller.web;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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
@WebServlet(urlPatterns = { "/verify-register-otp", "/resend-register-otp" })
public class VerifyRegisterOtpController extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);
        String pendingEmail = (session != null) ? (String) session.getAttribute("pendingRegisterEmail") : null;

        if (pendingEmail == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        // Xử lý gửi lại mã OTP (Resend OTP)
        if (uri.endsWith("/resend-register-otp")) {
            OtpService.OtpEntry entry = OtpService.getOtpEntry(pendingEmail);
            User pendingUser = (entry != null && entry.getData() instanceof User) ? (User) entry.getData() : null;
            if (pendingUser == null) {
                pendingUser = new User();
                pendingUser.setEmail(pendingEmail);
            }

            String newOtp = OtpService.createAndSaveOtp(pendingEmail, pendingUser);
            EmailUtil.sendOtpEmail(pendingEmail, newOtp, "Gửi lại Mã OTP Kích Hoạt Tài Khoản", "kích hoạt tài khoản mới");
            if (session != null) {
                session.setAttribute("devOtp", newOtp);
            }
            req.setAttribute("msgSuccess", "Đã gửi lại mã OTP mới đến email: " + pendingEmail);
        }

        req.setAttribute("email", pendingEmail);
        req.getRequestDispatcher(Constant.Path.VERIFY_REGISTER_OTP).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        String pendingEmail = (session != null) ? (String) session.getAttribute("pendingRegisterEmail") : null;
        String otp = req.getParameter("otp");

        if (pendingEmail == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        if (otp == null || otp.trim().isEmpty()) {
            req.setAttribute("email", pendingEmail);
            req.setAttribute("alert", "Vui lòng nhập đầy đủ mã OTP 6 chữ số!");
            req.getRequestDispatcher(Constant.Path.VERIFY_REGISTER_OTP).forward(req, resp);
            return;
        }

        otp = otp.trim();
        boolean isValid = OtpService.verifyOtp(pendingEmail, otp);

        if (isValid) {
            OtpService.OtpEntry entry = OtpService.getOtpEntry(pendingEmail);
            if (entry != null && entry.getData() instanceof User) {
                User newUser = (User) entry.getData();
                userService.insert(newUser);
            }
            OtpService.clearOtp(pendingEmail);
            if (session != null) {
                session.removeAttribute("pendingRegisterEmail");
                session.removeAttribute("devOtp");
            }
            req.setAttribute("successAlert", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay bây giờ.");
            req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
        } else {
            req.setAttribute("email", pendingEmail);
            req.setAttribute("alert", "Mã OTP không chính xác hoặc đã hết hạn (hiệu lực 5 phút). Vui lòng thử lại!");
            req.getRequestDispatcher(Constant.Path.VERIFY_REGISTER_OTP).forward(req, resp);
        }
    }
}
