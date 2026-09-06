<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Sản Phẩm - Admin Dashboard</title>
</head>
<body>
    <div style="margin-bottom: 20px; border-bottom: 2px solid #0284c7; padding-bottom: 12px;">
        <h2 style="margin: 0; color: #0f172a; font-weight: 700; font-size: 22px;">
            <i class="fa fa-edit text-primary"></i> Chỉnh Sửa Sản Phẩm #${product.id}
        </h2>
        <small style="color: #64748b;">Cập nhật thông tin, thay đổi hình ảnh và danh mục sản phẩm</small>
    </div>

    <div class="panel panel-default" style="max-width: 800px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #e2e8f0;">
        <div class="panel-heading" style="background: #f8fafc; font-weight: 600; color: #334155; padding: 12px 20px;">
            <i class="fa fa-pencil-square-o"></i> Biểu mẫu cập nhật
        </div>
        <div class="panel-body" style="padding: 25px 30px;">
            <form action="${pageContext.request.contextPath}/admin/product/edit" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${product.id}">
                
                <div class="form-group" style="margin-bottom: 20px;">
                    <label style="font-weight: 600; color: #334155;">Tên sản phẩm (*)</label>
                    <input type="text" name="name" class="form-control" value="${product.name}" required>
                </div>

                <div class="row">
                    <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                        <label style="font-weight: 600; color: #334155;">Danh mục (*)</label>
                        <select name="categoryId" class="form-control" required>
                            <c:forEach items="${categoryList}" var="cat">
                                <option value="${cat.id}" ${product.category != null && product.category.id == cat.id ? 'selected' : ''}>
                                    ${cat.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                        <label style="font-weight: 600; color: #334155;">Đơn giá (VNĐ) (*)</label>
                        <input type="number" step="1000" name="price" class="form-control" value="${product.price}" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                        <label style="font-weight: 600; color: #334155;">Số lượng tồn kho</label>
                        <input type="number" name="quantity" class="form-control" value="${product.quantity}" min="0">
                    </div>

                    <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                        <label style="font-weight: 600; color: #334155;">Trạng thái hiển thị</label>
                        <select name="status" class="form-control">
                            <option value="1" ${product.status == 1 ? 'selected' : ''}>Đang bán (Hiển thị)</option>
                            <option value="0" ${product.status == 0 ? 'selected' : ''}>Tạm ẩn (Không hiển thị)</option>
                        </select>
                    </div>
                </div>

                <div class="form-group" style="margin-bottom: 20px;">
                    <label style="font-weight: 600; color: #334155;">Hình ảnh hiện tại</label>
                    <div style="margin-bottom: 10px;">
                        <c:choose>
                            <c:when test="${not empty product.image}">
                                <img src="${pageContext.request.contextPath}/image?fname=${product.image}" alt="${product.name}" style="height: 100px; width: 100px; object-fit: cover; border-radius: 8px; border: 1px solid #cbd5e1;" />
                            </c:when>
                            <c:otherwise>
                                <span class="label label-default">Chưa có ảnh</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <label style="font-weight: 600; color: #334155;">Thay đổi hình ảnh mới (Nếu có)</label>
                    <input type="file" name="image" class="form-control" accept="image/*" onchange="previewImage(this);">
                    <div id="imagePreviewContainer" style="margin-top: 10px; display: none;">
                        <img id="imagePreview" src="#" alt="Xem trước ảnh mới" style="max-height: 100px; border-radius: 6px; border: 1px solid #cbd5e1; object-fit: cover;" />
                    </div>
                </div>

                <div class="form-group" style="margin-bottom: 25px;">
                    <label style="font-weight: 600; color: #334155;">Mô tả chi tiết sản phẩm</label>
                    <textarea name="description" class="form-control" rows="4">${product.description}</textarea>
                </div>

                <div style="display: flex; gap: 10px;">
                    <button type="submit" class="btn btn-primary" style="background: #0284c7; border: none; font-weight: 600; padding: 10px 24px; border-radius: 6px;">
                        <i class="fa fa-save"></i> Cập Nhật Sản Phẩm
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-default" style="padding: 10px 20px; border-radius: 6px;">
                        <i class="fa fa-times"></i> Hủy Bỏ
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('imagePreview').src = e.target.result;
                    document.getElementById('imagePreviewContainer').style.display = 'block';
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>
