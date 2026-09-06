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
@WebServlet(urlPatterns = "/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher(Constant.Path.FORGOT_PASSWORD).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String accountInput = req.getParameter("accountInput");

        if (accountInput == null || accountInput.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập email hoặc tên tài khoản của bạn!");
            req.getRequestDispatcher(Constant.Path.FORGOT_PASSWORD).forward(req, resp);
            return;
        }

        accountInput = accountInput.trim();
        User user = userService.getByEmail(accountInput);
        if (user == null) {
            user = userService.get(accountInput);
        }

        if (user == null || user.getEmail() == null) {
            req.setAttribute("alert", "Không tìm thấy tài khoản tương ứng với thông tin bạn cung cấp!");
            req.getRequestDispatcher(Constant.Path.FORGOT_PASSWORD).forward(req, resp);
            return;
        }

        // Tạo mã OTP đặt lại mật khẩu
        String otp = OtpService.createAndSaveOtp(user.getEmail(), user);

        // Gửi email OTP
        EmailUtil.sendOtpEmail(user.getEmail(), otp, "Mã Xác Thực Đặt Lại Mật Khẩu - Lap Trinh Web", "đặt lại mật khẩu tài khoản");

        HttpSession session = req.getSession(true);
        session.setAttribute("resetPasswordEmail", user.getEmail());
        session.setAttribute("devResetOtp", otp);

        resp.sendRedirect(req.getContextPath() + "/reset-password");
    }
}
