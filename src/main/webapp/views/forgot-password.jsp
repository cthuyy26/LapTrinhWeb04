<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu - Khôi Phục Tài Khoản</title>
    <style>
        .forgot-box {
            max-width: 440px;
            margin: 40px auto;
            padding: 30px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
        }
        .forgot-box h2 {
            text-align: center;
            margin-bottom: 15px;
            color: #0f172a;
            font-weight: 700;
            font-size: 22px;
        }
        .input-group { margin-bottom: 20px; }
        .btn-primary {
            background-color: #0284c7;
            border-color: #0284c7;
            font-size: 16px;
            font-weight: 600;
            padding: 10px;
            border-radius: 6px;
            width: 100%;
        }
        .btn-primary:hover {
            background-color: #0369a1;
        }
    </style>
</head>
<body>
<div class="forgot-box">
    <h2><i class="fa fa-key text-primary"></i> Quên Mật Khẩu</h2>
    <p style="color: #64748b; font-size: 14px; text-align: center; margin-bottom: 25px;">
        Nhập địa chỉ Email hoặc Tên tài khoản của bạn để nhận mã OTP khôi phục mật khẩu.
    </p>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger" style="border-radius: 6px; padding: 10px 15px; font-size: 14px; margin-bottom: 20px;">
            <i class="fa fa-exclamation-circle"></i> ${alert}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <div class="form-group">
            <label style="font-weight: 600; color: #334155; font-size: 14px; margin-bottom: 8px;">Email hoặc Tên tài khoản</label>
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-user-circle"></i></span>
                <input type="text" name="accountInput" class="form-control" placeholder="Ví dụ: user1 hoặc admin@ute.edu.vn" autofocus required>
            </div>
        </div>

        <button type="submit" class="btn btn-primary">
            <i class="fa fa-paper-plane"></i> Gửi Mã OTP Qua Email
        </button>

        <div style="margin-top: 25px; text-align: center;">
            <a href="${pageContext.request.contextPath}/login" style="color: #0284c7; font-weight: 600; text-decoration: none; font-size: 14px;">
                <i class="fa fa-arrow-left"></i> Quay lại Đăng nhập
            </a>
        </div>
    </form>
</div>
</body>
</html>
