<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Sản Phẩm (Phân Trang) - Lap Trinh Web</title>
    <style>
        .page-header-box {
            background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
            color: #ffffff;
            border-radius: 12px;
            padding: 25px 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(2, 132, 199, 0.15);
        }
        .filter-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.03);
        }
        .filter-title {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 15px;
            border-bottom: 2px solid #e0f2fe;
            padding-bottom: 8px;
        }
        .cate-filter-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .cate-filter-list li a {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 8px 12px;
            color: #334155;
            text-decoration: none;
            border-radius: 6px;
            margin-bottom: 4px;
            font-size: 14px;
            transition: all 0.2s;
        }
        .cate-filter-list li a:hover, .cate-filter-list li.active a {
            background: #e0f2fe;
            color: #0284c7;
            font-weight: 600;
        }
        .product-grid-6 {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 22px;
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
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px -5px rgba(0, 0, 0, 0.1);
            border-color: #0284c7;
            text-decoration: none;
            color: inherit;
        }
        .product-img-box {
            height: 200px;
            background: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
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
        .product-info {
            padding: 18px;
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
        }
        .product-name {
            font-size: 15px;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 10px;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            min-height: 42px;
        }
        .product-price {
            font-size: 18px;
            font-weight: 700;
            color: #dc2626;
            margin-top: auto;
            margin-bottom: 15px;
        }
        .btn-view-detail {
            background: #f0f9ff;
            color: #0284c7;
            border: 1px solid #bae6fd;
            text-align: center;
            padding: 9px;
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
        .pagination-container {
            text-align: center;
            margin: 30px 0 50px 0;
        }
        .pagination > li > a, .pagination > li > span {
            color: #0284c7;
            border-radius: 6px !important;
            margin: 0 3px;
            font-weight: 600;
            padding: 8px 16px;
        }
        .pagination > .active > a, .pagination > .active > a:hover {
            background-color: #0284c7;
            border-color: #0284c7;
            color: #ffffff;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Header Banner -->
    <div class="page-header-box">
        <h2 style="margin: 0 0 8px 0; font-weight: 700; font-size: 24px;">
            <i class="fa fa-shopping-bag"></i> Tất Cả Sản Phẩm
        </h2>
        <p style="margin: 0; opacity: 0.9; font-size: 14px;">
            Phân trang hiển thị chuẩn <strong>6 sản phẩm / trang</strong> &bull; Tổng cộng: <strong>${totalProducts}</strong> sản phẩm
        </p>
    </div>

    <div class="row">
        <!-- Sidebar Filter -->
        <div class="col-md-3">
            <!-- Search Widget -->
            <div class="filter-card">
                <div class="filter-title"><i class="fa fa-search"></i> Tìm kiếm</div>
                <form action="${pageContext.request.contextPath}/product" method="get">
                    <c:if test="${not empty selectedCategoryId}">
                        <input type="hidden" name="categoryId" value="${selectedCategoryId}">
                    </c:if>
                    <div class="input-group">
                        <input type="text" name="keyword" class="form-control" placeholder="Tên sản phẩm..." value="${keyword}">
                        <span class="input-group-btn">
                            <button class="btn btn-primary" type="submit" style="background: #0284c7; border-color: #0284c7;">
                                <i class="fa fa-search"></i>
                            </button>
                        </span>
                    </div>
                </form>
            </div>

            <!-- Category Filter Widget -->
            <div class="filter-card">
                <div class="filter-title"><i class="fa fa-folder-open"></i> Danh mục</div>
                <ul class="cate-filter-list">
                    <li class="${empty selectedCategoryId ? 'active' : ''}">
                        <a href="${pageContext.request.contextPath}/product<c:if test='${not empty keyword}'>?keyword=${keyword}</c:if>">
                            <span><i class="fa fa-th-large"></i> Tất cả danh mục</span>
                            <span class="badge" style="background: #94a3b8;">${totalProducts}</span>
                        </a>
                    </li>
                    <c:forEach items="${categoryList}" var="cat">
                        <li class="${selectedCategoryId == cat.id ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/product?categoryId=${cat.id}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">
                                <span><i class="fa fa-angle-right"></i> ${cat.name}</span>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <!-- Product List & Pagination Area -->
        <div class="col-md-9">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; background: #ffffff; padding: 12px 18px; border-radius: 8px; border: 1px solid #e2e8f0;">
                <div style="font-size: 14px; color: #64748b;">
                    Hiển thị trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
                    <c:if test="${not empty keyword}"> | Từ khóa: "<strong>${keyword}</strong>"</c:if>
                </div>
                <div style="font-size: 13px; color: #0284c7; font-weight: 600;">
                    <i class="fa fa-check-circle"></i> 6 sản phẩm / trang
                </div>
            </div>

            <!-- Product Grid (6 products per page) -->
            <c:choose>
                <c:when test="${not empty productList}">
                    <div class="product-grid-6">
                        <c:forEach items="${productList}" var="p">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="product-card" id="product-${p.id}">
                                <div class="product-img-box">
                                    <c:choose>
                                        <c:when test="${not empty p.image}">
                                            <img src="${pageContext.request.contextPath}/image?fname=${p.image}" alt="${p.name}">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa fa-cube" style="font-size: 64px; color: #cbd5e1;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="product-info">
                                    <span class="product-cate">${not empty p.category ? p.category.name : 'Chung'}</span>
                                    <div class="product-name" title="${p.name}">${p.name}</div>
                                    <div class="product-price">
                                        <fmt:formatNumber value="${p.price}" pattern="#,###" /> ₫
                                    </div>
                                    <div class="btn-view-detail">
                                        <i class="fa fa-shopping-cart"></i> Xem Chi Tiết
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </div>

                    <!-- Pagination Controls -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination-container">
                            <ul class="pagination">
                                <!-- Nút Previous -->
                                <li class="${currentPage == 1 ? 'disabled' : ''}">
                                    <c:choose>
                                        <c:when test="${currentPage > 1}">
                                            <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}<c:if test='${not empty selectedCategoryId}'>&categoryId=${selectedCategoryId}</c:if><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>" aria-label="Previous">
                                                <i class="fa fa-chevron-left"></i> Trước
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <span><i class="fa fa-chevron-left"></i> Trước</span>
                                        </c:otherwise>
                                    </c:choose>
                                </li>

                                <!-- Danh sách các trang 1, 2, 3... -->
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="${currentPage == i ? 'active' : ''}">
                                        <a href="${pageContext.request.contextPath}/product?page=${i}<c:if test='${not empty selectedCategoryId}'>&categoryId=${selectedCategoryId}</c:if><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">
                                            ${i}
                                        </a>
                                    </li>
                                </c:forEach>

                                <!-- Nút Next -->
                                <li class="${currentPage == totalPages ? 'disabled' : ''}">
                                    <c:choose>
                                        <c:when test="${currentPage < totalPages}">
                                            <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}<c:if test='${not empty selectedCategoryId}'>&categoryId=${selectedCategoryId}</c:if><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>" aria-label="Next">
                                                Sau <i class="fa fa-chevron-right"></i>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <span>Sau <i class="fa fa-chevron-right"></i></span>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </ul>
                        </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-warning" style="background: #fffbeb; border: 1px solid #fef3c7; color: #92400e; border-radius: 8px; padding: 30px; text-align: center;">
                        <i class="fa fa-info-circle" style="font-size: 32px; margin-bottom: 10px; display: block;"></i>
                        <h4 style="margin: 0 0 10px 0; font-weight: 700;">Không tìm thấy sản phẩm nào!</h4>
                        <p style="margin: 0;">Vui lòng chọn danh mục khác hoặc xóa bộ lọc tìm kiếm.</p>
                        <a href="${pageContext.request.contextPath}/product" class="btn btn-default" style="margin-top: 15px; border-radius: 6px;">
                            Xem tất cả sản phẩm
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>
