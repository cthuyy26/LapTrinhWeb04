<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục - Admin Dashboard</title>
</head>
<body>
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 2px solid #0284c7; padding-bottom: 12px;">
        <div>
            <h2 style="margin: 0; color: #0f172a; font-weight: 700; font-size: 22px;">
                <i class="fa fa-folder-open text-primary"></i> Quản Lý Danh Mục
            </h2>
            <small style="color: #64748b;">Quản lý và cập nhật danh sách các danh mục trong hệ thống JPA</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary" style="background: #0284c7; border: none; font-weight: 600; border-radius: 6px;">
            <i class="fa fa-plus-circle"></i> Thêm danh mục mới
        </a>
    </div>

    <div class="panel panel-default" style="border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); border: 1px solid #e2e8f0;">
        <div class="panel-heading" style="background: #f8fafc; font-weight: 600; color: #334155; border-bottom: 1px solid #e2e8f0; padding: 12px 20px;">
            <i class="fa fa-list"></i> Danh Sách Danh Mục Hiện Tại
        </div>
        <div class="panel-body" style="padding: 0;">
            <table class="table table-striped table-hover" style="margin-bottom: 0;">
                <thead>
                    <tr style="background: #f1f5f9; color: #475569;">
                        <th style="width: 70px; text-align: center;">STT</th>
                        <th style="width: 140px; text-align: center;">Hình ảnh</th>
                        <th>Tên danh mục</th>
                        <th style="width: 160px; text-align: center;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cateList}" var="cate" varStatus="STT">
                        <tr>
                            <td style="text-align: center; vertical-align: middle; font-weight: 600; color: #64748b;">${STT.index + 1}</td>
                            <td style="text-align: center; vertical-align: middle;">
                                <c:choose>
                                    <c:when test="${not empty cate.icon}">
                                        <c:url value="/image?fname=${cate.icon}" var="imgUrl"></c:url>
                                        <img height="60" width="80" style="object-fit: cover; border-radius: 6px; border: 1px solid #e2e8f0;" src="${imgUrl}" alt="${cate.name}" />
                                    </c:when>
                                    <c:otherwise>
                                        <span class="label label-default" style="background: #94a3b8;">Không có ảnh</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="vertical-align: middle; font-weight: 600; color: #1e293b; font-size: 15px;">${cate.name}</td>
                            <td style="text-align: center; vertical-align: middle;">
                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.id}" class="btn btn-sm btn-warning" style="border-radius: 4px;">
                                    <i class="fa fa-edit"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.id}" 
                                   class="btn btn-sm btn-danger" style="border-radius: 4px;"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này không?');">
                                    <i class="fa fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
