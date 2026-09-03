<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Lap Trinh Web</title>
</head>
<body>
<div class="container" style="margin-top: 30px;">
    <div class="jumbotron" style="background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%); border-radius: 12px; border: 1px solid #bae6fd; padding: 40px;">
        <h2 style="color: #0369a1; font-weight: 700; margin-top: 0;">
            <i class="fa fa-cubes"></i> HỆ THỐNG LẬP TRÌNH WEB - JPA - SITEMESH
        </h2>

        <hr style="border-color: #bae6fd; margin: 25px 0;" />

        <c:choose>
            <c:when test="${sessionScope.account != null}">
                <div class="alert alert-info" style="background: #ffffff; border: 1px solid #7dd3fc; border-radius: 8px; display: flex; align-items: center; gap: 15px; padding: 15px 20px;">
                    <img src="${pageContext.request.contextPath}/image?fname=${not empty sessionScope.account.avatar ? sessionScope.account.avatar : 'default'}" alt="Avatar" style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; border: 2px solid #0284c7; background: #e0f2fe;" />
                    <div>
                        <div style="font-size: 16px; font-weight: 600; color: #0f172a;">
                            Xin chào, ${sessionScope.account.fullName} (@${sessionScope.account.userName})
                        </div>
                        <div style="font-size: 13px; color: #64748b;">
                            Vai trò: <strong>${sessionScope.account.roleid == 1 ? 'Quản Trị Viên (Admin)' : (sessionScope.account.roleid == 2 ? 'Quản Lý (Manager)' : 'Khách Hàng (User)')}</strong>
                            <c:if test="${not empty sessionScope.account.phone}">
                                &bull; SĐT: <strong>${sessionScope.account.phone}</strong>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div style="display: flex; gap: 12px; flex-wrap: wrap; margin-top: 20px;">
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary" style="background: #0284c7; border: none; padding: 10px 20px; font-weight: 600; border-radius: 6px;">
                        <i class="fa fa-user-circle"></i> Xem & Cập nhật Hồ Sơ (Profile)
                    </a>
                    <c:if test="${sessionScope.account.roleid == 1}">
                        <a href="${pageContext.request.contextPath}/admin/user/list" class="btn btn-info" style="background: #0ea5e9; border: none; padding: 10px 20px; font-weight: 600; border-radius: 6px; color: #fff;">
                            <i class="fa fa-users"></i> Quản lý Người dùng (Admin Users)
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-warning" style="background: #f59e0b; border: none; padding: 10px 20px; font-weight: 600; border-radius: 6px; color: #fff;">
                            <i class="fa fa-cogs"></i> Quản trị Danh mục (Admin Category)
                        </a>
                    </c:if>
                    <c:if test="${sessionScope.account.roleid == 2}">
                        <a href="${pageContext.request.contextPath}/manager/home" class="btn btn-warning" style="background: #ea580c; border: none; padding: 10px 20px; font-weight: 600; border-radius: 6px; color: #fff;">
                            <i class="fa fa-briefcase"></i> Trang Quản Lý (Manager Dashboard)
                        </a>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div style="display: flex; gap: 12px; margin-top: 20px;">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary" style="background: #0284c7; border: none; padding: 10px 22px; font-weight: 600; border-radius: 6px;">
                        <i class="fa fa-sign-in"></i> Đăng nhập ngay
                    </a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-default" style="padding: 10px 22px; font-weight: 600; border-radius: 6px;">
                        <i class="fa fa-user-plus"></i> Đăng ký tài khoản
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
