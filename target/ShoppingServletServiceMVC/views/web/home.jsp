<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Cửa Hàng Công Nghệ & Lap Trinh Web</title>
    <style>
        .hero-banner {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #0369a1 100%);
            color: #ffffff;
            border-radius: 16px;
            padding: 45px 35px;
            margin-bottom: 35px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }
        .hero-banner h1 {
            font-size: 28px;
            font-weight: 800;
            margin-top: 0;
            color: #f8fafc;
        }
        .hero-banner p {
            color: #cbd5e1;
            font-size: 15px;
            max-width: 650px;
            margin-bottom: 25px;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 12px;
        }
        .section-title {
            font-size: 22px;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 35px;
        }
        .product-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            flex-direction: column;
            text-decoration: none;
            color: inherit;
            position: relative;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
            border-color: #38bdf8;
            text-decoration: none;
            color: inherit;
        }
        .product-img-box {
            height: 180px;
            background: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            padding: 15px;
        }
        .product-img-box img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .product-card:hover .product-img-box img {
            transform: scale(1.08);
        }
        .product-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background: #ef4444;
            color: #fff;
            font-size: 11px;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 6px;
            text-transform: uppercase;
        }
        .product-info {
            padding: 15px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        .product-cate {
            font-size: 12px;
            color: #0284c7;
            font-weight: 600;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .product-name {
            font-size: 15px;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 8px;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            min-height: 42px;
        }
        .product-price {
            font-size: 17px;
            font-weight: 700;
            color: #dc2626;
            margin-top: auto;
            margin-bottom: 12px;
        }
        .btn-view-detail {
            background: #f0f9ff;
            color: #0284c7;
            border: 1px solid #bae6fd;
            text-align: center;
            padding: 8px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 13px;
            transition: all 0.2s;
        }
        .product-card:hover .btn-view-detail {
            background: #0284c7;
            color: #ffffff;
            border-color: #0284c7;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Hero Banner -->
    <div class="hero-banner">
        <div class="row" style="display: flex; align-items: center; flex-wrap: wrap;">
            <div class="col-md-8">
                <h1>HỆ THỐNG MUA SẮM CÔNG NGHỆ JPA</h1>
                <p>Khám phá các sản phẩm công nghệ đỉnh cao, laptop, điện thoại, phụ kiện chính hãng với giá ưu đãi nhất.</p>

                <c:choose>
                    <c:when test="${sessionScope.account != null}">
                        <div style="background: rgba(255,255,255,0.12); padding: 12px 20px; border-radius: 8px; display: inline-flex; align-items: center; gap: 12px; backdrop-filter: blur(5px);">
                            <img src="${pageContext.request.contextPath}/image?fname=${not empty sessionScope.account.avatar ? sessionScope.account.avatar : 'default'}" alt="Avatar" style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover; border: 2px solid #38bdf8;" />
                            <div>
                                <div style="font-weight: 600; font-size: 14px;">Xin chào, ${sessionScope.account.fullName}</div>
                                <div style="font-size: 12px; color: #93c5fd;">
                                    Vai trò: <strong>${sessionScope.account.roleid == 1 ? 'Quản Trị Viên (Admin)' : (sessionScope.account.roleid == 2 ? 'Quản Lý (Manager)' : 'Khách Hàng (User)')}</strong>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="display: flex; gap: 12px;">
                            <a href="${pageContext.request.contextPath}/product" class="btn btn-primary" style="background: #38bdf8; color: #0f172a; border: none; font-weight: 700; padding: 10px 22px; border-radius: 8px;">
                                <i class="fa fa-shopping-bag"></i> Mua sắm ngay
                            </a>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-default" style="background: rgba(255,255,255,0.15); color: #fff; border: 1px solid rgba(255,255,255,0.3); font-weight: 600; padding: 10px 22px; border-radius: 8px;">
                                <i class="fa fa-sign-in"></i> Đăng nhập
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col-md-4 text-right hidden-xs hidden-sm">
                <i class="fa fa-laptop" style="font-size: 120px; color: rgba(255,255,255,0.15);"></i>
            </div>
        </div>
    </div>

    <!-- Section: 10 Sản phẩm mới nhất -->
    <div class="section-header">
        <h2 class="section-title">
            <i class="fa fa-bolt" style="color: #f59e0b;"></i> 10 Sản Phẩm Mới Nhất
        </h2>
        <a href="${pageContext.request.contextPath}/product" style="color: #0284c7; font-weight: 600; text-decoration: none; font-size: 14px;">
            Xem tất cả (${top10Products.size()}+) <i class="fa fa-arrow-right"></i>
        </a>
    </div>

    <!-- Product Grid: 10 Newest Products -->
    <div class="product-grid">
        <c:forEach items="${top10Products}" var="p" varStatus="loop">
            <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="product-card" id="home-product-${p.id}">
                <div class="product-img-box">
                    <span class="product-badge">MỚI #${loop.index + 1}</span>
                    <c:choose>
                        <c:when test="${not empty p.image}">
                            <img src="${pageContext.request.contextPath}/image?fname=${p.image}" alt="${p.name}">
                        </c:when>
                        <c:otherwise>
                            <i class="fa fa-cube" style="font-size: 60px; color: #cbd5e1;"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="product-info">
                    <span class="product-cate">${not empty p.category ? p.category.name : 'Công nghệ'}</span>
                    <div class="product-name" title="${p.name}">${p.name}</div>
                    <div class="product-price">
                        <fmt:formatNumber value="${p.price}" pattern="#,###" /> ₫
                    </div>
                    <div class="btn-view-detail">
                        <i class="fa fa-eye"></i> Xem Chi Tiết
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>

    <div style="text-align: center; margin: 30px 0 50px 0;">
        <a href="${pageContext.request.contextPath}/product" class="btn btn-primary btn-lg" style="background: #0284c7; border: none; padding: 12px 35px; font-weight: 600; border-radius: 8px;">
            <i class="fa fa-th-large"></i> Xem Toàn Bộ Sản Phẩm (Phân Trang)
        </a>
    </div>
</div>
</body>
</html>
