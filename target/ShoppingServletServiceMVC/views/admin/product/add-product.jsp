<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Sản Phẩm Mới - Admin Dashboard</title>
</head>
<body>
    <div style="margin-bottom: 20px; border-bottom: 2px solid #0284c7; padding-bottom: 12px;">
        <h2 style="margin: 0; color: #0f172a; font-weight: 700; font-size: 22px;">
            <i class="fa fa-plus-circle text-primary"></i> Thêm Sản Phẩm Mới
        </h2>
        <small style="color: #64748b;">Nhập thông tin sản phẩm và tải lên hình ảnh qua cơ chế Multipart Form</small>
    </div>

    <div class="panel panel-default" style="max-width: 800px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #e2e8f0;">
        <div class="panel-heading" style="background: #f8fafc; font-weight: 600; color: #334155; padding: 12px 20px;">
            <i class="fa fa-edit"></i> Biểu mẫu thông tin sản phẩm
        </div>
        <div class="panel-body" style="padding: 25px 30px;">
            <!-- QUAN TRỌNG: enctype="multipart/form-data" để upload file Multipart -->
            <form action="${pageContext.request.contextPath}/admin/product/add" method="post" enctype="multipart/form-data">
                
                <div class="form-group" style="margin-bottom: 20px;">
                    <label style="font-weight: 600; color: #334155;">Tên sản phẩm (*)</label>
                    <input type="text" name="name" class="form-control" placeholder="Ví dụ: iPhone 15 Pro Max 256GB" required>
                </div>

                <div class="row">
                    <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                        <label style="font-weight: 600; color: #334155;">Danh mục (*)</label>
                        <select name="categoryId" class="form-control" required>
                            <c:forEach items="${categoryList}" var="cat">
                                <option value="${cat.id}">${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                        <label style="font-weight: 600; color: #334155;">Đơn giá (VNĐ) (*)</label>
                        <input type="number" step="1000" name="price" class="form-control" placeholder="Ví dụ: 29490000" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                        <label style="font-weight: 600; color: #334155;">Số lượng tồn kho</label>
                        <input type="number" name="quantity" class="form-control" value="10" min="0">
                    </div>

                    <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                        <label style="font-weight: 600; color: #334155;">Trạng thái hiển thị</label>
                        <select name="status" class="form-control">
                            <option value="1" selected>Đang bán (Hiển thị)</option>
                            <option value="0">Tạm ẩn (Không hiển thị)</option>
                        </select>
                    </div>
                </div>

                <div class="form-group" style="margin-bottom: 20px;">
                    <label style="font-weight: 600; color: #334155;">Hình ảnh sản phẩm (Upload Multipart)</label>
                    <input type="file" name="image" class="form-control" accept="image/*" onchange="previewImage(this);">
                    <small style="color: #64748b;">Hỗ trợ định dạng: .jpg, .png, .jpeg, .webp (Tối đa 10MB)</small>
                    <div id="imagePreviewContainer" style="margin-top: 10px; display: none;">
                        <img id="imagePreview" src="#" alt="Xem trước ảnh" style="max-height: 120px; border-radius: 6px; border: 1px solid #cbd5e1; object-fit: cover;" />
                    </div>
                </div>

                <div class="form-group" style="margin-bottom: 25px;">
                    <label style="font-weight: 600; color: #334155;">Mô tả chi tiết sản phẩm</label>
                    <textarea name="description" class="form-control" rows="4" placeholder="Nhập thông số kỹ thuật, tính năng nổi bật..."></textarea>
                </div>

                <div style="display: flex; gap: 10px;">
                    <button type="submit" class="btn btn-primary" style="background: #0284c7; border: none; font-weight: 600; padding: 10px 24px; border-radius: 6px;">
                        <i class="fa fa-save"></i> Lưu Sản Phẩm
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
