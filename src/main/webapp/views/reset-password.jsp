<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt Lại Mật Khẩu - Nhập Mã OTP</title>
    <style>
        .reset-box {
            max-width: 460px;
            margin: 40px auto;
            padding: 35px 30px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
        }
        .reset-box h2 {
            text-align: center;
            margin-bottom: 15px;
            color: #0f172a;
            font-weight: 700;
            font-size: 22px;
        }
        .otp-input {
            letter-spacing: 8px;
            font-size: 22px;
            font-weight: 700;
            text-align: center;
            height: 48px;
            border-radius: 8px;
            border: 2px solid #cbd5e1;
        }
        .btn-success {
            background-color: #0284c7;
            border-color: #0284c7;
            font-size: 16px;
            font-weight: 600;
            padding: 10px;
            border-radius: 6px;
            width: 100%;
        }
        .btn-success:hover {
            background-color: #0369a1;
        }
        .dev-badge {
            background: #fef3c7;
            border: 1px solid #f59e0b;
            color: #92400e;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="reset-box">
    <h2><i class="fa fa-shield text-primary"></i> Đặt Lại Mật Khẩu</h2>
    <p style="color: #64748b; font-size: 14px; text-align: center; margin-bottom: 20px;">
        Mã OTP đã được gửi đến: <strong style="color: #0284c7;">${email}</strong>
    </p>

    <c:if test="${not empty sessionScope.devResetOtp}">
        <div class="dev-badge">
            <i class="fa fa-info-circle"></i> <strong>Mã OTP kiểm thử:</strong> <span style="font-weight: bold; letter-spacing: 2px;">${sessionScope.devResetOtp}</span>
        </div>
    </c:if>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger" style="border-radius: 6px; padding: 10px 15px; font-size: 14px; margin-bottom: 20px;">
            <i class="fa fa-exclamation-circle"></i> ${alert}
        </div>
    </c:if>

    <c:if test="${not empty msgSuccess}">
        <div class="alert alert-success" style="border-radius: 6px; padding: 10px 15px; font-size: 14px; margin-bottom: 20px;">
            <i class="fa fa-check-circle"></i> ${msgSuccess}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        <div class="form-group" style="margin-bottom: 18px;">
            <label style="font-weight: 600; color: #334155; font-size: 13px;">Mã OTP 6 chữ số (*)</label>
            <input type="text" name="otp" class="form-control otp-input" maxlength="6" placeholder="------" autofocus required>
        </div>

        <div class="form-group" style="margin-bottom: 18px;">
            <label style="font-weight: 600; color: #334155; font-size: 13px;">Mật khẩu mới (*)</label>
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                <input type="password" name="newPassword" class="form-control" placeholder="Nhập mật khẩu mới" required>
            </div>
        </div>

        <div class="form-group" style="margin-bottom: 25px;">
            <label style="font-weight: 600; color: #334155; font-size: 13px;">Xác nhận mật khẩu mới (*)</label>
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-check"></i></span>
                <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" required>
            </div>
        </div>

        <button type="submit" class="btn btn-success">
            <i class="fa fa-save"></i> Đổi Mật Khẩu
        </button>

        <div style="margin-top: 20px; font-size: 13px; color: #64748b; display: flex; justify-content: space-between; align-items: center;">
            <span>Chưa nhận được mã?</span>
            <a href="${pageContext.request.contextPath}/resend-reset-otp" style="color: #0284c7; font-weight: 600; text-decoration: none;">
                <i class="fa fa-refresh"></i> Gửi lại OTP
            </a>
        </div>

        <div style="margin-top: 15px; border-top: 1px solid #f1f5f9; padding-top: 15px; text-align: center;">
            <a href="${pageContext.request.contextPath}/login" style="color: #94a3b8; font-size: 13px; text-decoration: none;">
                <i class="fa fa-arrow-left"></i> Quay lại Đăng nhập
            </a>
        </div>
    </form>
</div>
</body>
</html>
