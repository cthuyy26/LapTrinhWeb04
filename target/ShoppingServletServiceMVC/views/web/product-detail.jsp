<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.name} - Chi Tiết Sản Phẩm</title>
    <style>
        .breadcrumb {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 12px 18px;
            margin-bottom: 25px;
            font-size: 14px;
        }
        .breadcrumb > li + li:before {
            color: #94a3b8;
            content: "/\00a0";
        }
        .product-detail-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 35px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.04);
        }
        .product-gallery-box {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            height: 380px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 25px;
            overflow: hidden;
        }
        .product-gallery-box img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .product-gallery-box:hover img {
            transform: scale(1.05);
        }
        .detail-title {
            font-size: 24px;
            font-weight: 700;
            color: #0f172a;
            margin-top: 0;
            margin-bottom: 12px;
            line-height: 1.3;
        }
        .detail-price-box {
            background: #fef2f2;
            border: 1px solid #fee2e2;
            border-radius: 10px;
            padding: 15px 20px;
            margin: 20px 0;
        }
        .detail-price {
            font-size: 28px;
            font-weight: 800;
            color: #dc2626;
        }
        .stock-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
        }
        .stock-in { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .stock-out { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }

        .btn-buy-now {
            background: #dc2626;
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            padding: 12px 28px;
            border-radius: 8px;
            border: none;
            transition: background 0.2s;
        }
        .btn-buy-now:hover { background: #b91c1c; color: #fff; }

        .btn-add-cart {
            background: #0284c7;
            color: #fff;
            font-size: 16px;
            font-weight: 600;
            padding: 12px 24px;
            border-radius: 8px;
            border: none;
            transition: background 0.2s;
        }
        .btn-add-cart:hover { background: #0369a1; color: #fff; }

        .related-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            text-decoration: none;
            color: inherit;
            transition: all 0.3s;
        }
        .related-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
            border-color: #0284c7;
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Breadcrumb -->
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/home"><i class="fa fa-home"></i> Trang chủ</a></li>
        <li><a href="${pageContext.request.contextPath}/product">Sản phẩm</a></li>
        <c:if test="${not empty product.category}">
            <li><a href="${pageContext.request.contextPath}/product?categoryId=${product.category.id}">${product.category.name}</a></li>
        </c:if>
        <li class="active">${product.name}</li>
    </ol>

    <!-- Chi tiết sản phẩm chính -->
    <div class="product-detail-card">
        <div class="row">
            <!-- Cột Hình ảnh lớn -->
            <div class="col-md-5 col-sm-6">
                <div class="product-gallery-box">
                    <c:choose>
                        <c:when test="${not empty product.image}">
                            <img src="${pageContext.request.contextPath}/image?fname=${product.image}" alt="${product.name}">
                        </c:when>
                        <c:otherwise>
                            <i class="fa fa-cube" style="font-size: 100px; color: #cbd5e1;"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Cột Thông tin chi tiết -->
            <div class="col-md-7 col-sm-6">
                <div style="display: flex; gap: 8px; margin-bottom: 10px;">
                    <span class="label label-info" style="background: #e0f2fe; color: #0369a1; font-weight: 600; padding: 4px 10px; font-size: 12px; border: 1px solid #bae6fd;">
                        <i class="fa fa-tag"></i> ${not empty product.category ? product.category.name : 'Danh mục chung'}
                    </span>
                    <c:choose>
                        <c:when test="${product.quantity > 0}">
                            <span class="stock-badge stock-in"><i class="fa fa-check"></i> Còn hàng (${product.quantity})</span>
                        </c:when>
                        <c:otherwise>
                            <span class="stock-badge stock-out"><i class="fa fa-times"></i> Hết hàng</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <h1 class="detail-title">${product.name}</h1>
                <div style="font-size: 13px; color: #64748b; margin-bottom: 10px;">
                    Mã sản phẩm: <strong>#PRD-${product.id}</strong> &bull; Ngày cập nhật: 
                    <strong><fmt:formatDate value="${product.createDate}" pattern="dd/MM/yyyy" /></strong>
                </div>

                <div class="detail-price-box">
                    <div style="font-size: 13px; color: #64748b; margin-bottom: 4px;">Giá bán niêm yết:</div>
                    <div class="detail-price">
                        <fmt:formatNumber value="${product.price}" pattern="#,###" /> ₫
                    </div>
                </div>

                <div style="margin-bottom: 25px; line-height: 1.6; color: #334155; font-size: 14px;">
                    <h4 style="font-weight: 700; color: #0f172a; font-size: 15px; margin-bottom: 8px;">Tóm tắt nổi bật:</h4>
                    <p>${not empty product.description ? product.description : 'Sản phẩm chính hãng với chất lượng đảm bảo, bảo hành 12 tháng.'}</p>
                </div>

                <div style="display: flex; gap: 12px; flex-wrap: wrap; margin-top: 25px;">
                    <button type="button" class="btn btn-buy-now" onclick="alert('Đã chọn Mua Ngay sản phẩm: ${product.name}!');">
                        <i class="fa fa-bolt"></i> Mua Ngay
                    </button>
                    <button type="button" class="btn btn-add-cart" onclick="alert('Đã thêm sản phẩm vào giỏ hàng thành công!');">
                        <i class="fa fa-cart-plus"></i> Thêm Vào Giỏ Hàng
                    </button>
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-default" style="padding: 12px 18px; border-radius: 8px; font-weight: 600;">
                        <i class="fa fa-arrow-left"></i> Quay Lại
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Thông tin chi tiết mở rộng -->
    <div class="panel panel-default" style="border-radius: 12px; border: 1px solid #e2e8f0; margin-bottom: 40px;">
        <div class="panel-heading" style="background: #f8fafc; font-weight: 700; color: #0f172a; font-size: 16px; padding: 14px 20px; border-bottom: 1px solid #e2e8f0;">
            <i class="fa fa-info-circle text-primary"></i> Mô Tả Chi Tiết & Thông Số Sản Phẩm
        </div>
        <div class="panel-body" style="padding: 25px 30px; font-size: 15px; line-height: 1.7; color: #334155;">
            <p>${not empty product.description ? product.description : 'Không có mô tả bổ sung cho sản phẩm này.'}</p>
            <table class="table table-bordered" style="max-width: 600px; margin-top: 20px;">
                <tr>
                    <td style="width: 200px; font-weight: 600; background: #f8fafc;">Tên sản phẩm</td>
                    <td>${product.name}</td>
                </tr>
                <tr>
                    <td style="font-weight: 600; background: #f8fafc;">Danh mục</td>
                    <td>${not empty product.category ? product.category.name : 'Chưa phân loại'}</td>
                </tr>
                <tr>
                    <td style="font-weight: 600; background: #f8fafc;">Giá bán</td>
                    <td style="color: #dc2626; font-weight: 700;"><fmt:formatNumber value="${product.price}" pattern="#,###" /> VNĐ</td>
                </tr>
                <tr>
                    <td style="font-weight: 600; background: #f8fafc;">Số lượng sẵn có</td>
                    <td>${product.quantity} sản phẩm</td>
                </tr>
                <tr>
                    <td style="font-weight: 600; background: #f8fafc;">Trạng thái kinh doanh</td>
                    <td>${product.status == 1 ? 'Đang mở bán' : 'Tạm dừng kinh doanh'}</td>
                </tr>
            </table>
        </div>
    </div>

    <!-- Sản phẩm liên quan cùng danh mục -->
    <c:if test="${not empty relatedProducts}">
        <div style="margin-bottom: 20px; border-bottom: 2px solid #e2e8f0; padding-bottom: 10px;">
            <h3 style="margin: 0; font-weight: 700; font-size: 20px; color: #0f172a;">
                <i class="fa fa-tags text-primary"></i> Sản Phẩm Cùng Danh Mục Gợi Ý Cho Bạn
            </h3>
        </div>

        <div class="row" style="margin-bottom: 50px;">
            <c:forEach items="${relatedProducts}" var="rp">
                <div class="col-md-3 col-sm-6" style="margin-bottom: 20px;">
                    <a href="${pageContext.request.contextPath}/product/detail?id=${rp.id}" class="related-card" style="height: 100%;">
                        <div style="height: 160px; background: #f8fafc; display: flex; align-items: center; justify-content: center; padding: 10px;">
                            <c:choose>
                                <c:when test="${not empty rp.image}">
                                    <img src="${pageContext.request.contextPath}/image?fname=${rp.image}" alt="${rp.name}" style="max-height: 100%; max-width: 100%; object-fit: contain;">
                                </c:when>
                                <c:otherwise>
                                    <i class="fa fa-cube" style="font-size: 50px; color: #cbd5e1;"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div style="padding: 15px; display: flex; flex-direction: column; flex: 1;">
                            <div style="font-weight: 600; font-size: 14px; color: #0f172a; margin-bottom: 8px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; min-height: 38px;">
                                ${rp.name}
                            </div>
                            <div style="font-weight: 700; color: #dc2626; font-size: 15px; margin-top: auto;">
                                <fmt:formatNumber value="${rp.price}" pattern="#,###" /> ₫
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </c:if>
</div>
</body>
</html>
