USE master;
GO

-- 1. Tạo cơ sở dữ liệu nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ServletCRUDMVC')
BEGIN
    CREATE DATABASE ServletCRUDMVC;
END
GO

USE ServletCRUDMVC;
GO

-- 2. Xóa bảng cũ theo thứ tự ràng buộc khóa ngoại (Product -> Category -> User)
IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL
    DROP TABLE dbo.Product;
GO

IF OBJECT_ID('dbo.videos', 'U') IS NOT NULL
    DROP TABLE dbo.videos;
GO

IF OBJECT_ID('dbo.Category', 'U') IS NOT NULL
    DROP TABLE dbo.Category;
GO

IF OBJECT_ID('dbo.[User]', 'U') IS NOT NULL
    DROP TABLE dbo.[User];
GO

-- 3. Tạo bảng [User]
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

-- 4. Tạo bảng Category
CREATE TABLE dbo.Category (
    cate_id INT IDENTITY(1,1) PRIMARY KEY,
    cate_name NVARCHAR(255) NOT NULL,
    icons NVARCHAR(500) NULL,
    status INT DEFAULT 1
);
GO

-- 5. Tạo bảng Product (Quan hệ 1-n với Category)
CREATE TABLE dbo.Product (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX) NULL,
    price FLOAT NOT NULL,
    image NVARCHAR(500) NULL,
    quantity INT DEFAULT 0,
    createDate DATETIME DEFAULT GETDATE(),
    status INT DEFAULT 1,
    cate_id INT NOT NULL,
    CONSTRAINT FK_Product_Category FOREIGN KEY (cate_id) REFERENCES dbo.Category(cate_id) ON DELETE CASCADE
);
GO

-- 6. Thêm tài khoản người dùng mẫu
INSERT INTO dbo.[User] (email, username, fullname, password, avatar, roleid, phone, createddate)
VALUES 
('admin@ute.edu.vn', 'admin', N'Quản Trị Viên', '123456', NULL, 1, '0901234567', GETDATE()),
('manager@ute.edu.vn', 'manager', N'Người Quản Lý', '123456', NULL, 2, '0907654321', GETDATE()),
('user1@ute.edu.vn', 'user1', N'Đinh Phú Sỹ', '123456', NULL, 5, '0912345678', GETDATE());
GO

-- 7. Thêm danh mục mẫu
INSERT INTO dbo.Category (cate_name, icons, status)
VALUES 
(N'Điện Thoại & Tablet', 'category/phone.png', 1),
(N'Laptop & Máy Tính', 'category/laptop.png', 1),
(N'Phụ Kiện Công Nghệ', 'category/accessories.png', 1),
(N'Đồng Hồ Thông Minh', 'category/smartwatch.png', 1),
(N'Thiết Bị Âm Thanh', 'category/audio.png', 1);
GO

-- 8. Thêm sản phẩm mẫu (15 sản phẩm để test Top 10 trang chủ và phân trang 6 sp/trang)
INSERT INTO dbo.Product (name, description, price, image, quantity, createDate, status, cate_id)
VALUES 
(N'iPhone 15 Pro Max 256GB', N'Màn hình Super Retina XDR 6.7 inch, chip Apple A17 Pro mạnh mẽ, khung titan sang trọng siêu bền.', 29490000, 'product/iphone15promax.png', 50, DATEADD(minute, -1, GETDATE()), 1, 1),
(N'Samsung Galaxy S24 Ultra 5G', N'Màn hình Dynamic AMOLED 2X 6.8 inch, tích hợp Galaxy AI đột phá, camera 200MP, bút S-Pen chuyên nghiệp.', 27990000, 'product/s24ultra.png', 40, DATEADD(minute, -2, GETDATE()), 1, 1),
(N'MacBook Pro 14 M3 Pro 2024', N'Chip Apple M3 Pro 11-core CPU, 14-core GPU, màn hình Liquid Retina XDR 120Hz mượt mà, thời lượng pin 18h.', 49990000, 'product/macbookm3.png', 20, DATEADD(minute, -3, GETDATE()), 1, 2),
(N'Laptop Dell XPS 13 Plus 9320', N'Thiết kế nhôm nguyên khối siêu mỏng nhẹ, màn hình 13.4 inch OLED 3.5K cảm ứng, Intel Core i7 thế hệ 13.', 38500000, 'product/dellxps.png', 15, DATEADD(minute, -4, GETDATE()), 1, 2),
(N'iPad Pro M4 11 inch Wi-Fi 256GB', N'Màn hình Ultra Retina XDR OLED kép siêu sáng, độ mỏng ấn tượng chỉ 5.3mm, chip M4 đỉnh cao.', 26890000, 'product/ipadm4.png', 30, DATEADD(minute, -5, GETDATE()), 1, 1),
(N'Sony WH-1000XM5 Chống Ồn', N'Tai nghe chụp tai chống ồn hàng đầu thế giới, âm thanh Hi-Res Audio, thời lượng pin liên tục đến 30 giờ.', 7490000, 'product/sonywh1000.png', 60, DATEADD(minute, -6, GETDATE()), 1, 5),
(N'Apple Watch Ultra 2 GPS + Cellular', N'Vỏ titan 49mm chuẩn quân đội, GPS tần số kép chính xác, màn hình 3000 nits siêu sáng ngoài trời.', 19990000, 'product/applewatchultra.png', 25, DATEADD(minute, -7, GETDATE()), 1, 4),
(N'Tai nghe AirPods Pro 2 USB-C', N'Chíp H2, chống ồn chủ động gấp 2 lần thế hệ trước, âm thanh thích ứng và cổng sạc Type-C tiện lợi.', 5390000, 'product/airpodspro2.png', 100, DATEADD(minute, -8, GETDATE()), 1, 5),
(N'Laptop Asus ROG Zephyrus G16', N'Laptop gaming cao cấp màn hình ROG Nebula OLED 240Hz, CPU Intel Core Ultra 9, card đồ họa RTX 4070.', 54990000, 'product/asusrog.png', 12, DATEADD(minute, -9, GETDATE()), 1, 2),
(N'Samsung Galaxy Watch 6 Classic', N'Viền xoay vật lý trứ danh, màn hình Sapphire cao cấp, theo dõi thành phần cơ thể và phân tích giấc ngủ sâu.', 6990000, 'product/galaxywatch6.png', 35, DATEADD(minute, -10, GETDATE()), 1, 4),
(N'Bàn phím cơ không dây Logitech MX Mechanical', N'Tactile Quiet switch êm ái, kết nối đa thiết bị qua Bluetooth/Logi Bolt, đèn nền thông minh tự phát sáng.', 3690000, 'product/logitechmx.png', 80, DATEADD(minute, -11, GETDATE()), 1, 3),
(N'Chuột không dây Logitech MX Master 3S', N'Cảm biến 8000 DPI trên mọi bề mặt, cuộn MagSpeed 1000 dòng/giây siêu tốc, công tắc Quiet Clicks giảm 90% tiếng ồn.', 2190000, 'product/mxmaster3s.png', 90, DATEADD(minute, -12, GETDATE()), 1, 3),
(N'Loa Bluetooth Marshall Stanmore III', N'Âm thanh Stereo sống động trường âm rộng hơn, thiết kế cổ điển phong cách Vintage đậm chất Rock.', 8990000, 'product/marshall.png', 22, DATEADD(minute, -13, GETDATE()), 1, 5),
(N'Củ sạc nhanh Anker 735 GaNPrime 65W', N'Công nghệ sạc nhanh GaNPrime 3 cổng (2 USB-C, 1 USB-A), công suất tối đa 65W cho laptop và điện thoại.', 1190000, 'product/anker65w.png', 120, DATEADD(minute, -14, GETDATE()), 1, 3),
(N'Xiaomi 14 Ultra 5G Leica', N'Bộ 4 camera Leica 50MP cảm biến 1 inch khẩu độ vô cấp, chip Snapdragon 8 Gen 3 cực khủng.', 24990000, 'product/xiaomi14ultra.png', 18, DATEADD(minute, -15, GETDATE()), 1, 1);
GO

SELECT * FROM dbo.[User];
SELECT * FROM dbo.Category;
SELECT * FROM dbo.Product;
GO
