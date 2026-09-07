package vn.iotstar.controller.web;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;
import vn.iotstar.util.EmailUtil;
import vn.iotstar.util.OtpService;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/reset-password", "/resend-reset-otp" })
public class ResetPasswordController extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);
        String resetEmail = (session != null) ? (String) session.getAttribute("resetPasswordEmail") : null;

        if (resetEmail == null) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }

        // Xử lý gửi lại OTP
        if (uri.endsWith("/resend-reset-otp")) {
            String newOtp = OtpService.createAndSaveOtp(resetEmail, resetEmail);
            EmailUtil.sendOtpEmail(resetEmail, newOtp, "Gửi lại Mã Xác Thực Đặt Lại Mật Khẩu", "đặt lại mật khẩu tài khoản");
            if (session != null) {
                session.setAttribute("devResetOtp", newOtp);
            }
            req.setAttribute("msgSuccess", "Đã gửi lại mã OTP mới đến email: " + resetEmail);
        }

        req.setAttribute("email", resetEmail);
        req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        String resetEmail = (session != null) ? (String) session.getAttribute("resetPasswordEmail") : null;
        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (resetEmail == null) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }

        req.setAttribute("email", resetEmail);

        if (otp == null || otp.trim().isEmpty() || newPassword == null || newPassword.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng điền đầy đủ các thông tin!");
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
            return;
        }

        if (newPassword.length() < 6) {
            req.setAttribute("alert", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("alert", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
            return;
        }

        otp = otp.trim();
        boolean isValid = OtpService.verifyOtp(resetEmail, otp);

        if (isValid) {
            boolean isUpdated = userService.resetPassword(resetEmail, newPassword);
            if (isUpdated) {
                OtpService.clearOtp(resetEmail);
                if (session != null) {
                    session.removeAttribute("resetPasswordEmail");
                    session.removeAttribute("devResetOtp");
                }
                req.setAttribute("successAlert", "Đặt lại mật khẩu thành công! Hãy đăng nhập với mật khẩu mới.");
                req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
            } else {
                req.setAttribute("alert", "Lỗi cập nhật mật khẩu trên hệ thống. Vui lòng thử lại!");
                req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
            }
        } else {
            req.setAttribute("alert", "Mã OTP không chính xác hoặc đã hết hạn (5 phút). Vui lòng thử lại!");
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
        }
    }
}
