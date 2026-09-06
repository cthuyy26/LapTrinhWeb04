<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Sản Phẩm - Admin Dashboard</title>
</head>
<body>
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 2px solid #0284c7; padding-bottom: 12px; flex-wrap: wrap; gap: 15px;">
        <div>
            <h2 style="margin: 0; color: #0f172a; font-weight: 700; font-size: 22px;">
                <i class="fa fa-cubes text-primary"></i> Quản Lý Sản Phẩm
            </h2>
            <small style="color: #64748b;">Quản lý toàn bộ danh sách sản phẩm, giá cả, số lượng tồn kho và danh mục</small>
        </div>
        <div style="display: flex; gap: 10px;">
            <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-primary" style="background: #0284c7; border: none; font-weight: 600; border-radius: 6px;">
                <i class="fa fa-plus-circle"></i> Thêm sản phẩm mới
            </a>
        </div>
    </div>

    <!-- Thanh tìm kiếm sản phẩm -->
    <div style="margin-bottom: 20px;">
        <form action="${pageContext.request.contextPath}/admin/product/list" method="get" class="form-inline">
            <div class="input-group" style="width: 350px;">
                <input type="text" name="keyword" class="form-control" placeholder="Tìm theo tên sản phẩm..." value="${keyword}">
                <span class="input-group-btn">
                    <button class="btn btn-primary" type="submit" style="background: #0284c7; border-color: #0284c7;">
                        <i class="fa fa-search"></i> Tìm kiếm
                    </button>
                </span>
            </div>
            <c:if test="${not empty keyword}">
                <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-default" style="margin-left: 5px;">
                    <i class="fa fa-times"></i> Xóa lọc
                </a>
            </c:if>
        </form>
    </div>

    <div class="panel panel-default" style="border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); border: 1px solid #e2e8f0;">
        <div class="panel-heading" style="background: #f8fafc; font-weight: 600; color: #334155; border-bottom: 1px solid #e2e8f0; padding: 12px 20px; display: flex; justify-content: space-between; align-items: center;">
            <span><i class="fa fa-list"></i> Danh Sách Sản Phẩm</span>
            <span class="badge" style="background: #0284c7;">Tổng cộng: ${productList.size()}</span>
        </div>
        <div class="panel-body" style="padding: 0;">
            <div class="table-responsive">
                <table class="table table-striped table-hover" style="margin-bottom: 0;">
                    <thead>
                        <tr style="background: #f1f5f9; color: #475569;">
                            <th style="width: 60px; text-align: center;">STT</th>
                            <th style="width: 100px; text-align: center;">Hình ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th style="width: 150px;">Danh mục</th>
                            <th style="width: 130px; text-align: right;">Đơn giá (VNĐ)</th>
                            <th style="width: 90px; text-align: center;">Số lượng</th>
                            <th style="width: 110px; text-align: center;">Trạng thái</th>
                            <th style="width: 160px; text-align: center;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${productList}" var="p" varStatus="STT">
                            <tr>
                                <td style="text-align: center; vertical-align: middle; font-weight: 600; color: #64748b;">${STT.index + 1}</td>
                                <td style="text-align: center; vertical-align: middle;">
                                    <c:choose>
                                        <c:when test="${not empty p.image}">
                                            <img height="55" width="55" style="object-fit: cover; border-radius: 6px; border: 1px solid #e2e8f0;" src="${pageContext.request.contextPath}/image?fname=${p.image}" alt="${p.name}" />
                                        </c:when>
                                        <c:otherwise>
                                            <span class="label label-default" style="background: #94a3b8;">No img</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="vertical-align: middle;">
                                    <div style="font-weight: 600; color: #0f172a; font-size: 14px;">${p.name}</div>
                                    <small style="color: #64748b; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; max-width: 320px;">
                                        ${p.description}
                                    </small>
                                </td>
                                <td style="vertical-align: middle;">
                                    <span class="label label-info" style="background: #e0f2fe; color: #0369a1; border: 1px solid #bae6fd; font-weight: 600; padding: 4px 8px;">
                                        <i class="fa fa-tag"></i> ${not empty p.category ? p.category.name : 'Chưa phân loại'}
                                    </span>
                                </td>
                                <td style="vertical-align: middle; text-align: right; font-weight: 700; color: #dc2626;">
                                    <fmt:formatNumber value="${p.price}" pattern="#,###" /> ₫
                                </td>
                                <td style="vertical-align: middle; text-align: center; font-weight: 600; color: #334155;">
                                    ${p.quantity}
                                </td>
                                <td style="vertical-align: middle; text-align: center;">
                                    <c:choose>
                                        <c:when test="${p.status == 1}">
                                            <span class="label label-success" style="background: #10b981;">Đang bán</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="label label-default" style="background: #94a3b8;">Tạm ẩn</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align: center; vertical-align: middle;">
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" target="_blank" class="btn btn-xs btn-info" title="Xem chi tiết trên web" style="border-radius: 4px;">
                                        <i class="fa fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.id}" class="btn btn-xs btn-warning" title="Chỉnh sửa" style="border-radius: 4px;">
                                        <i class="fa fa-edit"></i> Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.id}" 
                                       class="btn btn-xs btn-danger" title="Xóa" style="border-radius: 4px;"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm: ${p.name}?');">
                                        <i class="fa fa-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
