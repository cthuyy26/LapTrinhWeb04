<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Người Dùng Mới - Admin</title>
    <style>
        .form-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
            overflow: hidden;
            max-width: 850px;
            margin: 0 auto;
        }

        .form-header {
            padding: 20px 25px;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
        }

        .form-header h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
        }

        .form-body {
            padding: 30px;
        }

        .form-label {
            font-weight: 600;
            color: #334155;
            font-size: 14px;
            margin-bottom: 6px;
            display: block;
        }

        .form-control-custom {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .form-control-custom:focus {
            border-color: #0284c7;
            box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.15);
            outline: none;
        }

        .avatar-preview-box {
            text-align: center;
            padding: 20px;
            background: #f8fafc;
            border-radius: 12px;
            border: 1px dashed #cbd5e1;
            margin-bottom: 20px;
        }

        .avatar-preview-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #0284c7;
            margin-bottom: 12px;
            background: #0284c7;
        }
    </style>
</head>
<body>

<c:if test="${not empty error}">
    <div class="alert alert-danger" style="border-radius: 8px; border-left: 5px solid #ef4444; max-width: 850px; margin: 0 auto 20px auto;">
        <i class="fa fa-exclamation-triangle"></i> <strong>Lỗi!</strong> ${error}
    </div>
</c:if>

<div class="form-card">
    <div class="form-header">
        <h3><i class="fa fa-user-plus" style="color: #0284c7;"></i> Thêm Tài Khoản Người Dùng Mới</h3>
    </div>

    <div class="form-body">
        <form action="${pageContext.request.contextPath}/admin/user/add" method="post" enctype="multipart/form-data">
            
            <div class="avatar-preview-box">
                <img id="avatarPreview" src="${pageContext.request.contextPath}/image?fname=default" alt="Avatar Preview" class="avatar-preview-img" />
                <div>
                    <label for="avatarInput" class="btn btn-default" style="border-radius: 6px; font-weight: 500;">
                        <i class="fa fa-camera"></i> Chọn Ảnh Đại Diện
                    </label>
                    <input type="file" id="avatarInput" name="images" accept="image/*" style="display: none;" onchange="previewAvatar(this);" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                    <label class="form-label" for="username"><i class="fa fa-user"></i> Tên tài khoản (Username) <span style="color: #ef4444;">*</span></label>
                    <input type="text" id="username" name="username" class="form-control-custom" required placeholder="Nhập username đăng nhập..." />
                </div>

                <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                    <label class="form-label" for="password"><i class="fa fa-lock"></i> Mật khẩu <span style="color: #ef4444;">*</span></label>
                    <input type="password" id="password" name="password" class="form-control-custom" required placeholder="Nhập mật khẩu..." />
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                    <label class="form-label" for="fullname"><i class="fa fa-id-badge"></i> Họ và Tên <span style="color: #ef4444;">*</span></label>
                    <input type="text" id="fullname" name="fullname" class="form-control-custom" required placeholder="Nhập họ và tên đầy đủ..." />
                </div>

                <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                    <label class="form-label" for="email"><i class="fa fa-envelope"></i> Địa chỉ Email <span style="color: #ef4444;">*</span></label>
                    <input type="email" id="email" name="email" class="form-control-custom" required placeholder="example@domain.com" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 form-group" style="margin-bottom: 25px;">
                    <label class="form-label" for="phone"><i class="fa fa-phone"></i> Số Điện Thoại</label>
                    <input type="tel" id="phone" name="phone" class="form-control-custom" placeholder="Nhập số điện thoại..." />
                </div>

                <div class="col-md-6 form-group" style="margin-bottom: 25px;">
                    <label class="form-label" for="roleid"><i class="fa fa-shield"></i> Phân Quyền (Vai Trò) <span style="color: #ef4444;">*</span></label>
                    <select id="roleid" name="roleid" class="form-control-custom">
                        <option value="5" selected>Người Dùng (User)</option>
                        <option value="2">Quản Lý (Manager)</option>
                        <option value="1">Quản Trị Viên (Admin)</option>
                    </select>
                </div>
            </div>

            <hr style="border-color: #e2e8f0; margin: 10px 0 25px 0;" />

            <div style="display: flex; gap: 15px; align-items: center;">
                <button type="submit" class="btn btn-primary" style="background: #0284c7; border: none; padding: 10px 24px; font-weight: 600; border-radius: 8px;">
                    <i class="fa fa-save"></i> Tạo Người Dùng
                </button>
                <a href="${pageContext.request.contextPath}/admin/user/list" class="btn btn-default" style="padding: 10px 20px; font-weight: 600; border-radius: 8px;">
                    <i class="fa fa-arrow-left"></i> Quay lại
                </a>
            </div>

        </form>
    </div>
</div>

<script>
    function previewAvatar(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('avatarPreview').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>

</body>
</html>
