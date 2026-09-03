<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header class="main-navbar" style="background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%); color: #fff; padding: 10px 0; box-shadow: 0 2px 10px rgba(0,0,0,0.15); position: sticky; top: 0; z-index: 1000;">
    <div class="container" style="display: flex; justify-content: space-between; align-items: center; max-width: 1200px; margin: 0 auto; padding: 0 15px;">
        <div class="brand-logo">
            <a href="${pageContext.request.contextPath}/home" style="color: #fff; text-decoration: none; font-weight: 700; font-size: 18px; display: flex; align-items: center; gap: 8px;">
                <span style="background: #0ea5e9; color: #fff; width: 34px; height: 34px; display: inline-flex; align-items: center; justify-content: center; border-radius: 8px;">
                    <i class="fa fa-cubes"></i>
                </span>
                <span>Lap Trinh <span style="color: #38bdf8;">Web</span></span>
            </a>
        </div>

        <nav class="nav-links" style="display: flex; align-items: center; gap: 20px;">
            <a href="${pageContext.request.contextPath}/home" style="color: #cbd5e1; text-decoration: none; font-weight: 500; font-size: 14px; transition: color 0.2s;" onmouseover="this.style.color='#38bdf8'" onmouseout="this.style.color='#cbd5e1'">
                <i class="fa fa-home"></i> Trang Chủ
            </a>

            <c:choose>
                <c:when test="${sessionScope.account == null}">
                    <div style="display: flex; gap: 10px; align-items: center;">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-sm btn-primary" style="background: #0284c7; border: none; padding: 6px 16px; border-radius: 6px; color: #fff; text-decoration: none; font-weight: 600;">
                            <i class="fa fa-sign-in"></i> Đăng nhập
                        </a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-sm btn-outline-light" style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); padding: 6px 16px; border-radius: 6px; color: #fff; text-decoration: none; font-weight: 600;">
                            <i class="fa fa-user-plus"></i> Đăng ký
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="user-menu" style="display: flex; align-items: center; gap: 15px;">
                        <c:if test="${sessionScope.account.roleid == 1}">
                            <a href="${pageContext.request.contextPath}/admin/category/list" style="background: rgba(234, 179, 8, 0.15); border: 1px solid #eab308; color: #fde047; padding: 5px 12px; border-radius: 6px; text-decoration: none; font-size: 13px; font-weight: 600;">
                                <i class="fa fa-cogs"></i> Quản trị Admin
                            </a>
                        </c:if>

                        <a href="${pageContext.request.contextPath}/profile" style="display: flex; align-items: center; gap: 8px; color: #f8fafc; text-decoration: none; background: rgba(255,255,255,0.08); padding: 4px 12px; border-radius: 20px; transition: background 0.2s;" onmouseover="this.style.background='rgba(255,255,255,0.15)'" onmouseout="this.style.background='rgba(255,255,255,0.08)'">
                            <img src="${pageContext.request.contextPath}/image?fname=${not empty sessionScope.account.avatar ? sessionScope.account.avatar : 'default'}" alt="Avatar" style="width: 28px; height: 28px; border-radius: 50%; object-fit: cover; border: 1.5px solid #38bdf8; background: #0284c7;" />
                            <span style="font-weight: 600; font-size: 14px;">${sessionScope.account.fullName}</span>
                            <span style="font-size: 11px; background: #0284c7; padding: 1px 6px; border-radius: 10px; color: #fff;">Profile</span>
                        </a>

                        <a href="${pageContext.request.contextPath}/logout" style="color: #f87171; text-decoration: none; font-size: 14px; font-weight: 500; display: flex; align-items: center; gap: 4px;" title="Đăng xuất" onmouseover="this.style.color='#ef4444'" onmouseout="this.style.color='#f87171'">
                            <i class="fa fa-sign-out"></i> Thoát
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>
