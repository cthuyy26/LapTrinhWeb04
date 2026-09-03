<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Quản Lý (Manager)</title>
</head>
<body>
<div class="container" style="margin-top: 30px;">
    <div class="panel panel-warning" style="border-radius: 8px; border: 1px solid #fde047; box-shadow: 0 4px 15px rgba(0,0,0,0.05);">
        <div class="panel-heading" style="background: #fef08a; color: #854d0e; font-weight: 700; font-size: 16px;">
            <i class="fa fa-briefcase"></i> Trang Quản Lý (Manager Dashboard)
        </div>
        <div class="panel-body" style="padding: 25px;">
            <h4>Xin chào Manager, <strong>${sessionScope.account.fullName}</strong> (@${sessionScope.account.userName})!</h4>
            <div class="alert alert-warning" style="border-radius: 6px;">
                <i class="fa fa-info-circle"></i> Bạn đang truy cập tài nguyên dành cho tài khoản có Role ID = 2 (Manager).
            </div>
            <div style="display: flex; gap: 10px; margin-top: 20px;">
                <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary" style="background: #0284c7; border: none; border-radius: 6px; font-weight: 600;">
                    <i class="fa fa-user-circle"></i> Xem hồ sơ cá nhân
                </a>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-default" style="border-radius: 6px;">
                    <i class="fa fa-home"></i> Về trang chủ
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>