<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Quản Trị Hệ Thống (Admin)</title>
</head>
<body>
<div>
    <div class="panel panel-primary" style="border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #bae6fd;">
        <div class="panel-heading" style="background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%); color: #fff; font-weight: 700; font-size: 16px; padding: 15px 20px;">
            <i class="fa fa-shield"></i> Trang Quản Trị Hệ Thống (Admin Control Panel)
        </div>
        <div class="panel-body" style="padding: 25px;">
            <h4>Chào mừng Admin, <strong>${sessionScope.account.fullName}</strong> (@${sessionScope.account.userName})!</h4>
            <p style="color: #64748b;">Bạn có toàn quyền quản lý hệ thống danh mục, người dùng và video.</p>
            
            <div style="display: flex; gap: 12px; margin-top: 25px; flex-wrap: wrap;">
                <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-primary" style="background: #0284c7; border: none; padding: 10px 20px; font-weight: 600; border-radius: 6px;">
                    <i class="fa fa-folder-open"></i> Quản lý Danh Mục (Category)
                </a>
                <a href="${pageContext.request.contextPath}/profile" class="btn btn-info" style="background: #0ea5e9; border: none; padding: 10px 20px; font-weight: 600; border-radius: 6px;">
                    <i class="fa fa-user-circle"></i> Cập nhật Profile của bạn
                </a>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-default" style="padding: 10px 20px; border-radius: 6px;">
                    <i class="fa fa-home"></i> Xem Trang chủ
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>