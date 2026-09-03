<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Người Dùng - Admin Dashboard</title>
    <style>
        .admin-page-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
            overflow: hidden;
            margin-bottom: 25px;
        }

        .admin-page-header {
            padding: 20px 25px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            background: #f8fafc;
        }

        .admin-page-title {
            margin: 0;
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-table {
            width: 100%;
            margin-bottom: 0;
        }

        .user-table th {
            background: #f1f5f9;
            color: #475569;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 14px 18px !important;
            border-bottom: 2px solid #e2e8f0 !important;
        }

        .user-table td {
            padding: 14px 18px !important;
            vertical-align: middle !important;
            border-top: 1px solid #f1f5f9 !important;
            font-size: 14px;
            color: #334155;
        }

        .user-avatar-thumb {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e2e8f0;
            background: #0284c7;
        }

        .role-pill {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .role-pill-admin {
            background: #fef08a;
            color: #854d0e;
            border: 1px solid #facc15;
        }

        .role-pill-manager {
            background: #fed7aa;
            color: #9a3412;
            border: 1px solid #fb923c;
        }

        .role-pill-user {
            background: #e0f2fe;
            color: #0369a1;
            border: 1px solid #7dd3fc;
        }

        .btn-action-edit {
            background: #0ea5e9;
            color: #ffffff !important;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.2s;
        }

        .btn-action-edit:hover {
            background: #0284c7;
            transform: translateY(-1px);
        }

        .btn-action-delete {
            background: #ef4444;
            color: #ffffff !important;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.2s;
        }

        .btn-action-delete:hover {
            background: #dc2626;
            transform: translateY(-1px);
        }

        .search-box {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .search-input {
            padding: 8px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            min-width: 250px;
        }

        .search-input:focus {
            border-color: #0284c7;
            box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.15);
        }
    </style>
</head>
<body>

<!-- Alert Notifications -->
<c:if test="${param.msg == 'added'}">
    <div class="alert alert-success" style="border-radius: 8px; border-left: 5px solid #22c55e;">
        <i class="fa fa-check-circle"></i> Thêm tài khoản người dùng mới thành công!
    </div>
</c:if>
<c:if test="${param.msg == 'updated'}">
    <div class="alert alert-success" style="border-radius: 8px; border-left: 5px solid #22c55e;">
        <i class="fa fa-check-circle"></i> Cập nhật thông tin tài khoản thành công!
    </div>
</c:if>
<c:if test="${param.msg == 'deleted'}">
    <div class="alert alert-success" style="border-radius: 8px; border-left: 5px solid #22c55e;">
        <i class="fa fa-check-circle"></i> Đã xóa người dùng khỏi hệ thống thành công!
    </div>
</c:if>
<c:if test="${param.error == 'self_delete'}">
    <div class="alert alert-warning" style="border-radius: 8px; border-left: 5px solid #eab308;">
        <i class="fa fa-exclamation-triangle"></i> Bạn không thể tự xóa tài khoản Admin đang đăng nhập!
    </div>
</c:if>
<c:if test="${param.error == 'failed'}">
    <div class="alert alert-danger" style="border-radius: 8px; border-left: 5px solid #ef4444;">
        <i class="fa fa-exclamation-triangle"></i> Lỗi trong quá trình xử lý yêu cầu!
    </div>
</c:if>

<div class="admin-page-card">
    <div class="admin-page-header">
        <div>
            <h3 class="admin-page-title"><i class="fa fa-users" style="color: #0284c7;"></i> Quản Lý Danh Sách Người Dùng</h3>
            <p style="color: #64748b; font-size: 13px; margin: 4px 0 0 0;">Quản trị tài khoản, phân quyền và kiểm soát thành viên trong hệ thống</p>
        </div>

        <div style="display: flex; gap: 12px; align-items: center; flex-wrap: wrap;">
            <!-- Search Form -->
            <form action="${pageContext.request.contextPath}/admin/user/list" method="get" class="search-box">
                <input type="text" name="keyword" value="${keyword}" placeholder="Tìm theo tên, email, user..." class="search-input" />
                <button type="submit" class="btn btn-default" style="border-radius: 8px; padding: 8px 14px;">
                    <i class="fa fa-search"></i>
                </button>
            </form>

            <!-- Add User Button -->
            <a href="${pageContext.request.contextPath}/admin/user/add" class="btn btn-primary" style="background: #0284c7; border: none; padding: 8px 16px; border-radius: 8px; font-weight: 600; display: inline-flex; align-items: center; gap: 6px;">
                <i class="fa fa-user-plus"></i> Thêm Người Dùng
            </a>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table user-table">
            <thead>
                <tr>
                    <th style="width: 60px; text-align: center;">ID</th>
                    <th style="width: 70px; text-align: center;">Avatar</th>
                    <th>Tài Khoản</th>
                    <th>Họ và Tên</th>
                    <th>Email</th>
                    <th>Số Điện Thoại</th>
                    <th style="text-align: center;">Vai Trò</th>
                    <th style="text-align: center;">Ngày Tạo</th>
                    <th style="width: 170px; text-align: center;">Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty userList}">
                        <tr>
                            <td colspan="9" style="text-align: center; padding: 40px !important; color: #94a3b8;">
                                <i class="fa fa-folder-open-o" style="font-size: 32px; display: block; margin-bottom: 8px;"></i>
                                Không tìm thấy người dùng nào phù hợp.
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="u" items="${userList}">
                            <tr>
                                <td style="text-align: center; font-weight: 600; color: #64748b;">#${u.id}</td>
                                <td style="text-align: center;">
                                    <img src="${pageContext.request.contextPath}/image?fname=${not empty u.avatar ? u.avatar : 'default'}" alt="Avatar" class="user-avatar-thumb" />
                                </td>
                                <td>
                                    <strong>${u.userName}</strong>
                                </td>
                                <td style="font-weight: 500; color: #0f172a;">${u.fullName}</td>
                                <td style="color: #64748b;">${u.email}</td>
                                <td>${not empty u.phone ? u.phone : '<span style="color:#cbd5e1;">N/A</span>'}</td>
                                <td style="text-align: center;">
                                    <c:choose>
                                        <c:when test="${u.roleid == 1}">
                                            <span class="role-pill role-pill-admin"><i class="fa fa-shield"></i> Admin</span>
                                        </c:when>
                                        <c:when test="${u.roleid == 2}">
                                            <span class="role-pill role-pill-manager"><i class="fa fa-briefcase"></i> Manager</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="role-pill role-pill-user"><i class="fa fa-user"></i> User</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align: center; font-size: 13px; color: #64748b;">
                                    ${u.createdDate != null ? u.createdDate : 'N/A'}
                                </td>
                                <td style="text-align: center;">
                                    <div style="display: inline-flex; gap: 6px;">
                                        <a href="${pageContext.request.contextPath}/admin/user/edit?id=${u.id}" class="btn-action-edit" title="Chỉnh sửa">
                                            <i class="fa fa-pencil"></i> Sửa
                                        </a>
                                        <c:if test="${u.id != sessionScope.account.id}">
                                            <a href="${pageContext.request.contextPath}/admin/user/delete?id=${u.id}" class="btn-action-delete" title="Xóa" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng [${u.fullName} (@${u.userName})] không?');">
                                                <i class="fa fa-trash"></i> Xóa
                                            </a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
