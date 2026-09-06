<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Quản Trị Hệ Thống - Admin Dashboard</sitemesh:write></title>
    
    <!-- Google Fonts & FontAwesome -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

    <style>
        body {
            background-color: #f1f5f9;
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        .admin-layout {
            display: flex;
            min-height: calc(100vh - 58px);
        }

        .admin-sidebar {
            width: 250px;
            background: #1e293b;
            color: #f8fafc;
            flex-shrink: 0;
            padding-top: 15px;
            box-shadow: 2px 0 8px rgba(0,0,0,0.06);
        }

        .admin-user-card {
            padding: 18px;
            text-align: center;
            border-bottom: 1px solid #334155;
            margin-bottom: 15px;
        }

        .admin-avatar {
            width: 54px;
            height: 54px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #38bdf8;
            margin-bottom: 8px;
        }

        .admin-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .admin-menu li a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 20px;
            color: #94a3b8;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            border-left: 3px solid transparent;
            transition: all 0.2s;
        }

        .admin-menu li a:hover, .admin-menu li.active a {
            background: #0f172a;
            color: #38bdf8;
            border-left-color: #38bdf8;
        }

        .admin-content-area {
            flex: 1;
            padding: 25px 30px;
            overflow-y: auto;
        }
    </style>

    <sitemesh:write property="head" />
</head>
<body>
    <!-- Topbar -->
    <jsp:include page="/common/topbar.jsp"></jsp:include>

    <div class="admin-layout">
        <!-- Sidebar Navigation -->
        <aside class="admin-sidebar">
            <div class="admin-user-card">
                <img src="${pageContext.request.contextPath}/image?fname=${not empty sessionScope.account.avatar ? sessionScope.account.avatar : 'default'}" alt="Admin Avatar" class="admin-avatar" />
                <div style="font-weight: 600; font-size: 15px;">${sessionScope.account.fullName}</div>
                <div style="font-size: 12px; color: #38bdf8; margin-top: 2px;"><i class="fa fa-shield"></i> Quản Trị Viên</div>
            </div>

            <ul class="admin-menu">
                <li><a href="${pageContext.request.contextPath}/admin/product/list"><i class="fa fa-cubes"></i> Quản lý Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/product/add"><i class="fa fa-plus-square"></i> Thêm sản phẩm mới</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/category/list"><i class="fa fa-folder-open"></i> Quản lý Danh mục</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/category/add"><i class="fa fa-plus-circle"></i> Thêm danh mục mới</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/user/list"><i class="fa fa-users"></i> Quản lý Người dùng</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/user/add"><i class="fa fa-user-plus"></i> Thêm tài khoản mới</a></li>
                <li><a href="${pageContext.request.contextPath}/profile"><i class="fa fa-user-circle"></i> Hồ sơ cá nhân (Profile)</a></li>
                <li><a href="${pageContext.request.contextPath}/home"><i class="fa fa-home"></i> Về trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/logout" style="color: #f87171;"><i class="fa fa-sign-out"></i> Đăng xuất</a></li>
            </ul>
        </aside>

        <!-- Dynamic Admin Content -->
        <main class="admin-content-area">
            <sitemesh:write property="body" />
        </main>
    </div>

    <!-- jQuery and Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>
