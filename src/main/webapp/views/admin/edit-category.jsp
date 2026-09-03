<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Danh Mục - Admin</title>
</head>
<body>
<div style="max-width: 650px; margin: 20px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.06); border: 1px solid #e2e8f0;">
    <h3 style="margin-top: 0; border-bottom: 2px solid #f59e0b; padding-bottom: 12px; color: #0f172a; font-weight: 700;">
        <i class="fa fa-pencil-square-o text-warning"></i> Chỉnh Sửa Danh Mục
    </h3>
    
    <form role="form" action="${pageContext.request.contextPath}/admin/category/edit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${category.id}">
        
        <div class="form-group" style="margin-bottom: 20px;">
            <label style="font-weight: 600; color: #334155;">Tên danh mục <span style="color: #ef4444;">*</span></label>
            <input type="text" class="form-control" value="${category.name}" name="name" required />
        </div>
        
        <div class="form-group" style="margin-bottom: 25px;">
            <label style="font-weight: 600; color: #334155;">Ảnh hiện tại:</label><br/>
            <c:choose>
                <c:when test="${not empty category.icon}">
                    <c:url value="/image?fname=${category.icon}" var="imgUrl"></c:url>
                    <img class="img-responsive" width="120px" style="border-radius: 6px; border: 1px solid #e2e8f0; margin-bottom: 12px; object-fit: cover;" src="${imgUrl}" alt="${category.name}" />
                </c:when>
                <c:otherwise>
                    <p class="text-muted">Chưa có ảnh</p>
                </c:otherwise>
            </c:choose>
            <label style="font-weight: 600; color: #334155;">Chọn ảnh mới thay thế (tùy chọn):</label>
            <input type="file" name="icon" class="form-control" accept="image/*" />
        </div>
        
        <div style="display: flex; gap: 10px; align-items: center;">
            <button type="submit" class="btn btn-warning" style="background: #f59e0b; border: none; font-weight: 600; padding: 8px 20px; border-radius: 6px; color: #fff;">
                <i class="fa fa-save"></i> Lưu thay đổi
            </button>
            <button type="reset" class="btn btn-default" style="padding: 8px 18px; border-radius: 6px;">
                <i class="fa fa-refresh"></i> Reset
            </button>
            <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary" style="margin-left: auto; color: #64748b;">
                <i class="fa fa-arrow-left"></i> Quay lại danh sách
            </a>
        </div>
    </form>
</div>
</body>
</html>
