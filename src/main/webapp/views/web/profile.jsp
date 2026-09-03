<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Cá Nhân - ${user.fullName}</title>
    <style>
        .profile-container {
            max-width: 1050px;
            margin: 20px auto;
        }

        .profile-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
            overflow: hidden;
            margin-bottom: 25px;
        }

        .profile-header-banner {
            background: linear-gradient(135deg, #0284c7 0%, #0369a1 50%, #0f172a 100%);
            padding: 30px 25px;
            color: #ffffff;
            position: relative;
        }

        .profile-header-banner h2 {
            margin: 0 0 5px 0;
            font-size: 24px;
            font-weight: 700;
        }

        .profile-header-banner p {
            margin: 0;
            color: #bae6fd;
            font-size: 14px;
        }

        .profile-body {
            padding: 30px;
        }

        .avatar-preview-box {
            text-align: center;
            padding: 20px;
            background: #f8fafc;
            border-radius: 12px;
            border: 1px dashed #cbd5e1;
            transition: all 0.3s ease;
        }

        .avatar-preview-box:hover {
            border-color: #0284c7;
            background: #f0f9ff;
        }

        .avatar-img {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
            margin-bottom: 15px;
            background: #e2e8f0;
        }

        .role-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .role-badge-admin {
            background: #fef08a;
            color: #854d0e;
            border: 1px solid #facc15;
        }

        .role-badge-manager {
            background: #fed7aa;
            color: #9a3412;
            border: 1px solid #fb923c;
        }

        .role-badge-user {
            background: #e0f2fe;
            color: #0369a1;
            border: 1px solid #7dd3fc;
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
            color: #1e293b;
            transition: border-color 0.2s, box-shadow 0.2s;
            box-sizing: border-box;
        }

        .form-control-custom:focus {
            border-color: #0284c7;
            box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.15);
            outline: none;
        }

        .form-control-custom[readonly], .form-control-custom[disabled] {
            background-color: #f1f5f9;
            color: #64748b;
            cursor: not-allowed;
        }

        .file-upload-wrapper {
            position: relative;
            margin-top: 10px;
        }

        .btn-upload-trigger {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            background: #ffffff;
            border: 1px solid #0284c7;
            color: #0284c7;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-upload-trigger:hover {
            background: #0284c7;
            color: #ffffff;
        }

        .btn-save {
            background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
            color: #ffffff;
            border: none;
            padding: 12px 28px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(2, 132, 199, 0.3);
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-save:hover {
            background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
            box-shadow: 0 6px 16px rgba(2, 132, 199, 0.4);
            transform: translateY(-1px);
        }

        .btn-cancel {
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
            padding: 12px 24px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-cancel:hover {
            background: #e2e8f0;
            color: #1e293b;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="container profile-container">
    
    <!-- Success / Error Alert Messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-success" style="border-radius: 8px; border-left: 5px solid #22c55e; margin-bottom: 20px;">
            <i class="fa fa-check-circle"></i> <strong>Thành công!</strong> ${message}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger" style="border-radius: 8px; border-left: 5px solid #ef4444; margin-bottom: 20px;">
            <i class="fa fa-exclamation-triangle"></i> <strong>Lỗi!</strong> ${error}
        </div>
    </c:if>

    <div class="profile-card">
        <div class="profile-header-banner">
            <h2><i class="fa fa-id-card-o"></i> Hồ Sơ Người Dùng</h2>
            <p>Quản lý và cập nhật thông tin cá nhân của bạn trong hệ thống</p>
        </div>

        <div class="profile-body">
            <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
                <div class="row">
                    
                    <!-- Left Column: Avatar & Summary Box -->
                    <div class="col-md-4 col-sm-12 text-center" style="margin-bottom: 25px;">
                        <div class="avatar-preview-box">
                            <img id="avatarPreview" src="${pageContext.request.contextPath}/image?fname=${not empty user.avatar ? user.avatar : 'default'}" alt="Avatar Preview" class="avatar-img" />

                            <h4 style="margin: 5px 0; font-weight: 700; color: #1e293b;">${user.fullName}</h4>
                            <p style="color: #64748b; font-size: 13px; margin-bottom: 12px;">@${user.userName}</p>

                            <div style="margin-bottom: 15px;">
                                <c:choose>
                                    <c:when test="${user.roleid == 1}">
                                        <span class="role-badge role-badge-admin"><i class="fa fa-shield"></i> Quản Trị Viên</span>
                                    </c:when>
                                    <c:when test="${user.roleid == 2}">
                                        <span class="role-badge role-badge-manager"><i class="fa fa-briefcase"></i> Quản Lý</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="role-badge role-badge-user"><i class="fa fa-user"></i> Người Dùng</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="file-upload-wrapper">
                                <label for="avatarInput" class="btn-upload-trigger">
                                    <i class="fa fa-camera"></i> Đổi ảnh đại diện
                                </label>
                                <!-- File input with multipart name 'images' -->
                                <input type="file" id="avatarInput" name="images" accept="image/*" style="display: none;" onchange="previewUserAvatar(this);" />
                            </div>
                            <small style="color: #94a3b8; display: block; margin-top: 8px;">Định dạng: JPG, PNG, GIF (Tối đa 10MB)</small>
                        </div>
                    </div>

                    <!-- Right Column: User Details Form -->
                    <div class="col-md-8 col-sm-12">
                        <div class="row">
                            <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                                <label class="form-label"><i class="fa fa-user"></i> Tên tài khoản</label>
                                <input type="text" class="form-control-custom" value="${user.userName}" readonly disabled title="Tên tài khoản không thể thay đổi" />
                            </div>

                            <div class="col-md-6 form-group" style="margin-bottom: 20px;">
                                <label class="form-label">
                                    <i class="fa fa-envelope"></i> Địa chỉ Email
                                    <c:choose>
                                        <c:when test="${user.roleid == 1}">
                                            <span class="badge" style="background: #fef08a; color: #854d0e; font-size: 11px; margin-left: 6px; border: 1px solid #facc15;"><i class="fa fa-shield"></i> Admin: Được phép đổi</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #94a3b8; font-size: 12px;">(Cố định)</span>
                                        </c:otherwise>
                                    </c:choose>
                                </label>
                                <c:choose>
                                    <c:when test="${user.roleid == 1}">
                                        <input type="email" name="email" class="form-control-custom" value="${user.email}" required placeholder="Nhập địa chỉ email mới..." style="background-color: #fff;" />
                                    </c:when>
                                    <c:otherwise>
                                        <input type="email" class="form-control-custom" value="${user.email}" readonly disabled title="Email đăng ký cố định" />
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="form-group" style="margin-bottom: 20px;">
                            <label class="form-label" for="fullNameInput"><i class="fa fa-id-badge"></i> Họ và Tên <span style="color: #ef4444;">*</span></label>
                            <input type="text" id="fullNameInput" name="fullname" class="form-control-custom" value="${user.fullName}" required placeholder="Nhập họ và tên đầy đủ..." />
                        </div>

                        <div class="form-group" style="margin-bottom: 20px;">
                            <label class="form-label" for="phoneInput"><i class="fa fa-phone"></i> Số Điện Thoại</label>
                            <input type="tel" id="phoneInput" name="phone" class="form-control-custom" value="${user.phone}" placeholder="Nhập số điện thoại liên hệ..." />
                        </div>

                        <div class="row">
                            <div class="col-md-6 form-group" style="margin-bottom: 25px;">
                                <label class="form-label"><i class="fa fa-calendar"></i> Ngày tham gia</label>
                                <input type="text" class="form-control-custom" value="${user.createdDate != null ? user.createdDate : 'N/A'}" readonly disabled />
                            </div>

                            <div class="col-md-6 form-group" style="margin-bottom: 25px;">
                                <label class="form-label"><i class="fa fa-key"></i> Mã định danh (ID)</label>
                                <input type="text" class="form-control-custom" value="#${user.id}" readonly disabled />
                            </div>
                        </div>

                        <hr style="margin: 15px 0 25px 0; border-color: #e2e8f0;" />

                        <div style="display: flex; gap: 15px; align-items: center;">
                            <button type="submit" class="btn-save">
                                <i class="fa fa-save"></i> Cập nhật hồ sơ
                            </button>
                            <a href="${pageContext.request.contextPath}/home" class="btn-cancel">
                                <i class="fa fa-arrow-left"></i> Quay lại Trang chủ
                            </a>
                        </div>
                    </div>

                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function previewUserAvatar(input) {
        if (input.files && input.files[0]) {
            const file = input.files[0];
            
            // Kiểm tra kích thước file (tối đa 10MB)
            if (file.size > 10 * 1024 * 1024) {
                alert('Kích thước ảnh không được vượt quá 10MB!');
                input.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                const previewImg = document.getElementById('avatarPreview');
                if (previewImg) {
                    previewImg.src = e.target.result;
                }
            };
            reader.readAsDataURL(file);
        }
    }
</script>
</body>
</html>
