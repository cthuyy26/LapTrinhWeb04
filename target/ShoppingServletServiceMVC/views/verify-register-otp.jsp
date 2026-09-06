<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác Thực OTP Kích Hoạt Tài Khoản</title>
    <style>
        .otp-card {
            max-width: 460px;
            margin: 40px auto;
            padding: 35px 30px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
            text-align: center;
        }
        .otp-icon {
            width: 64px;
            height: 64px;
            line-height: 64px;
            background: #e0f2fe;
            color: #0284c7;
            font-size: 28px;
            border-radius: 50%;
            display: inline-block;
            margin-bottom: 20px;
        }
        .otp-input {
            letter-spacing: 12px;
            font-size: 26px;
            font-weight: 700;
            text-align: center;
            height: 54px;
            border-radius: 8px;
            border: 2px solid #cbd5e1;
            transition: border-color 0.2s;
        }
        .otp-input:focus {
            border-color: #0284c7;
            outline: none;
            box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.2);
        }
        .btn-verify {
            background-color: #0284c7;
            border-color: #0284c7;
            font-size: 16px;
            font-weight: 600;
            padding: 12px;
            border-radius: 8px;
            width: 100%;
            margin-top: 20px;
            color: #fff;
        }
        .btn-verify:hover {
            background-color: #0369a1;
            color: #fff;
        }
        .dev-badge {
            background: #fef3c7;
            border: 1px solid #f59e0b;
            color: #92400e;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 20px;
            display: inline-block;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="otp-card">
        <div class="otp-icon">
            <i class="fa fa-envelope-open-o"></i>
        </div>

        <h3 style="margin-top: 0; color: #0f172a; font-weight: 700; font-size: 22px;">Xác Thực Tài Khoản</h3>
        <p style="color: #64748b; font-size: 14px; margin-bottom: 20px;">
            Hệ thống đã gửi mã OTP 6 chữ số đến email:<br>
            <strong style="color: #0284c7;">${email}</strong>
        </p>

        <c:if test="${not empty sessionScope.devOtp}">
            <div class="dev-badge">
                <i class="fa fa-info-circle"></i> <strong>Mã OTP kiểm thử:</strong> <span style="font-weight: bold; letter-spacing: 2px;">${sessionScope.devOtp}</span>
            </div>
        </c:if>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger" style="border-radius: 8px; padding: 10px 15px; font-size: 14px;">
                <i class="fa fa-exclamation-circle"></i> ${alert}
            </div>
        </c:if>

        <c:if test="${not empty msgSuccess}">
            <div class="alert alert-success" style="border-radius: 8px; padding: 10px 15px; font-size: 14px;">
                <i class="fa fa-check-circle"></i> ${msgSuccess}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/verify-register-otp" method="post">
            <div class="form-group" style="margin-bottom: 15px;">
                <input type="text" name="otp" class="form-control otp-input" maxlength="6" placeholder="------" autofocus required>
            </div>

            <button type="submit" class="btn btn-verify">
                <i class="fa fa-check"></i> Xác Nhận Kích Hoạt
            </button>
        </form>

        <div style="margin-top: 25px; font-size: 14px; color: #64748b; display: flex; justify-content: space-between; align-items: center;">
            <span>Chưa nhận được mã?</span>
            <a href="${pageContext.request.contextPath}/resend-register-otp" style="color: #0284c7; font-weight: 600; text-decoration: none;">
                <i class="fa fa-refresh"></i> Gửi lại mã OTP
            </a>
        </div>

        <div style="margin-top: 15px; border-top: 1px solid #f1f5f9; padding-top: 15px;">
            <a href="${pageContext.request.contextPath}/register" style="color: #94a3b8; font-size: 13px; text-decoration: none;">
                <i class="fa fa-arrow-left"></i> Quay lại trang Đăng ký
            </a>
        </div>
    </div>
</div>
</body>
</html>
