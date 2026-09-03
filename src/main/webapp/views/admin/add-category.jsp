<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Danh Mục Mới - Admin</title>
</head>
<body>
<div style="max-width: 650px; margin: 20px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.06); border: 1px solid #e2e8f0;">
    <h3 style="margin-top: 0; border-bottom: 2px solid #0284c7; padding-bottom: 12px; color: #0f172a; font-weight: 700;">
        <i class="fa fa-plus-circle text-primary"></i> Thêm Danh Mục Mới
    </h3>
    
    <form role="form" action="${pageContext.request.contextPath}/admin/category/add" method="post" enctype="multipart/form-data">
        <div class="form-group" style="margin-bottom: 20px;">
            <label style="font-weight: 600; color: #334155;">Tên danh mục <span style="color: #ef4444;">*</span></label>
            <input class="form-control" placeholder="Nhập tên danh mục..." name="name" required />
        </div>
        <div class="form-group" style="margin-bottom: 25px;">
            <label style="font-weight: 600; color: #334155;">Hình ảnh biểu tượng (Icon)</label>
            <input type="file" name="icon" class="form-control" accept="image/*" />
        </div>
        <div style="display: flex; gap: 10px; align-items: center;">
            <button type="submit" class="btn btn-primary" style="background: #0284c7; border: none; font-weight: 600; padding: 8px 20px; border-radius: 6px;">
                <i class="fa fa-save"></i> Thêm mới
            </button>
            <button type="reset" class="btn btn-default" style="padding: 8px 18px; border-radius: 6px;">
                <i class="fa fa-refresh"></i> Làm mới
            </button>
            <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary" style="margin-left: auto; color: #64748b;">
                <i class="fa fa-arrow-left"></i> Quay lại danh sách
            </a>
        </div>
    </form>
</div>
</body>
</html>
