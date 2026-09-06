<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập Vào Hệ Thống</title>
    <style>
        .login-box { max-width: 440px; margin: 40px auto; padding: 30px; background: #fff; border: 1px solid #e2e8f0; border-radius: 10px; box-shadow: 0 4px 20px rgba(0,0,0,0.06); }
        .login-box h2 { text-align: center; margin-bottom: 25px; color: #0f172a; font-weight: 700; font-size: 22px; }
        .alert-danger { padding: 10px 15px; margin-bottom: 20px; font-size: 14px; border-radius: 6px; }
        .alert-success { padding: 10px 15px; margin-bottom: 20px; font-size: 14px; border-radius: 6px; }
        .input-group { margin-bottom: 18px; }
        .btn-primary { background-color: #0284c7; border-color: #0284c7; font-size: 16px; font-weight: 600; padding: 10px; border-radius: 6px; }
        .btn-primary:hover { background-color: #0369a1; }
    </style>
</head>
<body>
<div class="login-box">
    <form action="${pageContext.request.contextPath}/login" method="post">
        <h2><i class="fa fa-lock text-primary"></i> Đăng Nhập Hệ Thống</h2>

        <c:if test="${not empty successAlert}">
            <div class="alert alert-success"><i class="fa fa-check-circle"></i> ${successAlert}</div>
        </c:if>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ${alert}</div>
        </c:if>

        <section>
            <label class="input login-input" style="width: 100%;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    <input type="text" placeholder="Tài khoản hoặc Email" name="username" class="form-control" required>
                </div>
            </label>
        </section>

        <section>
            <label class="input login-input" style="width: 100%;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <input type="password" placeholder="Mật khẩu" name="password" class="form-control" required>
                </div>
            </label>
        </section>

        <div style="margin-bottom: 18px; display: flex; justify-content: space-between; align-items: center;">
            <label style="font-weight: normal; margin-bottom: 0;">
                <input type="checkbox" name="remember"> Nhớ tôi
            </label>
            <a href="${pageContext.request.contextPath}/forgot-password" class="pull-right" style="color: #0284c7; font-weight: 500;">Quên mật khẩu?</a>
        </div>

        <button type="submit" class="btn btn-primary btn-block">Đăng nhập</button>

        <p style="margin-top: 20px; text-align: center; color: #64748b;">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" style="color: #0284c7; font-weight: 600;">Đăng ký ngay</a>
        </p>
    </form>
</div>
</body>
</html>