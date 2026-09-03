USE master;
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ShoppingDB')
BEGIN
    CREATE DATABASE ShoppingDB;
END
GO

USE ShoppingDB;
GO

IF OBJECT_ID('dbo.[User]', 'U') IS NOT NULL
    DROP TABLE dbo.[User];
GO

CREATE TABLE dbo.[User] (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email NVARCHAR(150) NOT NULL,
    username NVARCHAR(50) NOT NULL UNIQUE,
    fullname NVARCHAR(100) NOT NULL,
    password NVARCHAR(100) NOT NULL,
    avatar NVARCHAR(255) NULL,
    roleid INT NOT NULL DEFAULT 5, -- 1: Admin, 2: Manager, 5: Normal User
    phone NVARCHAR(20) NULL,
    createddate DATE DEFAULT GETDATE()
);
GO

-- Thêm tài khoản mẫu để test đăng nhập
-- Admin: admin / 123456 (roleid = 1)
-- Manager: manager / 123456 (roleid = 2)
-- User: user1 / 123456 (roleid = 5)
INSERT INTO dbo.[User] (email, username, fullname, password, avatar, roleid, phone, createddate)
VALUES 
('admin@ute.edu.vn', 'admin', N'Quản Trị Viên', '123456', NULL, 1, '0901234567', GETDATE()),
('manager@ute.edu.vn', 'manager', N'Người Quản Lý', '123456', NULL, 2, '0907654321', GETDATE()),
('user1@ute.edu.vn', 'user1', N'Đinh Phú Sỹ', '123456', NULL, 5, '0912345678', GETDATE());
GO

SELECT * FROM dbo.[User];
GO
