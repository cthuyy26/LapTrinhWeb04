<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký Tài Khoản</title>
    <style>
        .register-box { max-width: 480px; margin: 40px auto; padding: 30px; background: #fff; border: 1px solid #e2e8f0; border-radius: 10px; box-shadow: 0 4px 20px rgba(0,0,0,0.06); }
        .register-box h2 { text-align: center; margin-bottom: 25px; color: #0f172a; font-weight: 700; font-size: 22px; }
        .alert-danger { padding: 10px 15px; margin-bottom: 20px; font-size: 14px; border-radius: 6px; }
        .input-group { margin-bottom: 16px; }
        .btn-info { background-color: #0284c7; border-color: #0284c7; font-size: 16px; font-weight: 600; padding: 10px; border-radius: 6px; color: #fff; }
        .btn-info:hover { background-color: #0369a1; color: #fff; }
    </style>
</head>
<body>
<div class="register-box">
    <form action="${pageContext.request.contextPath}/register" method="post">
        <h2><i class="fa fa-user-plus text-primary"></i> Tạo Tài Khoản Mới</h2>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ${alert}</div>
        </c:if>

        <section>
            <label class="input login-input" style="width: 100%;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    <input type="text" placeholder="Tên tài khoản (*)" name="username" class="form-control" required>
                </div>
            </label>
        </section>

        <section>
            <label class="input login-input" style="width: 100%;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-id-card"></i></span>
                    <input type="text" placeholder="Họ và tên (*)" name="fullname" class="form-control" required>
                </div>
            </label>
        </section>

        <section>
            <label class="input login-input" style="width: 100%;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                    <input type="email" placeholder="Địa chỉ Email (*)" name="email" class="form-control" required>
                </div>
            </label>
        </section>

        <section>
            <label class="input login-input" style="width: 100%;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    <input type="tel" placeholder="Số điện thoại" name="phone" class="form-control">
                </div>
            </label>
        </section>

        <section>
            <label class="input login-input" style="width: 100%;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <input type="password" placeholder="Mật khẩu (*)" name="password" class="form-control" required>
                </div>
            </label>
        </section>

        <button type="submit" class="btn btn-info btn-block" style="margin-top: 15px;">Tạo tài khoản</button>

        <p style="margin-top: 20px; text-align: center; color: #64748b;">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" style="color: #0284c7; font-weight: 600;">Đăng nhập ngay</a>
        </p>
    </form>
</div>
</body>
</html>