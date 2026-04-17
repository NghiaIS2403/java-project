-- ============================================================
-- TechZone - Database Schema
-- Chạy: mysql -u root -p < database.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS techzone CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE techzone;

-- ===================== BẢNG USERS =====================
CREATE TABLE IF NOT EXISTS users (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(100) NOT NULL,
    email    VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone    VARCHAR(20),
    address  TEXT,
    role     ENUM('admin','user') DEFAULT 'user',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ===================== BẢNG PRODUCTS =====================
CREATE TABLE IF NOT EXISTS products (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    category    VARCHAR(100) NOT NULL,
    brand       VARCHAR(100),
    price       BIGINT NOT NULL,
    old_price   BIGINT,
    description TEXT,
    specs       TEXT,
    emoji       VARCHAR(10) DEFAULT '📦',
    badge       VARCHAR(20),
    stock       INT DEFAULT 0,
    rating      DECIMAL(2,1) DEFAULT 5.0,
    reviews     INT DEFAULT 0,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ===================== BẢNG ORDERS =====================
CREATE TABLE IF NOT EXISTS orders (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    user_id      INT NOT NULL,
    full_name    VARCHAR(100) NOT NULL,
    phone        VARCHAR(20) NOT NULL,
    address      TEXT NOT NULL,
    total_amount BIGINT NOT NULL,
    status       ENUM('pending','processing','delivered','cancelled') DEFAULT 'pending',
    note         TEXT,
    created_at   DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- ===================== BẢNG ORDER_ITEMS =====================
CREATE TABLE IF NOT EXISTS order_items (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    order_id    INT NOT NULL,
    product_id  INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    price       BIGINT NOT NULL,
    quantity    INT NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(id)   ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
);

-- ===================== DỮ LIỆU MẪU =====================

-- Tài khoản (password lưu dạng plain text cho đơn giản - có thể hash MD5/BCrypt sau)
INSERT INTO users (name, email, password, phone, address, role) VALUES
('Admin TechZone', 'admin@techzone.vn', 'admin123', '0901234567', '123 Nguyễn Huệ, Q1, TP.HCM', 'admin'),
('Nguyễn Văn An',  'user@techzone.vn',  'user123',  '0912345678', '456 Lê Lợi, Q3, TP.HCM',    'user'),
('Trần Thị Bình',  'binh@gmail.com',    '123456',   '0923456789', '789 Trần Hưng Đạo, Q5, TP.HCM', 'user');

-- Sản phẩm
INSERT INTO products (name, category, brand, price, old_price, description, specs, emoji, badge, stock, rating, reviews) VALUES
('iPhone 15 Pro Max','Điện thoại','Apple',29990000,34990000,
 'iPhone 15 Pro Max với chip A17 Pro, màn hình Super Retina XDR 6.7 inch, camera 48MP.',
 'Chip: Apple A17 Pro|RAM: 8GB|Bộ nhớ: 256GB|Màn hình: 6.7" OLED|Pin: 4422mAh|Camera: 48MP','📱','sale',15,4.8,1240),

('Samsung Galaxy S24 Ultra','Điện thoại','Samsung',26990000,31990000,
 'Galaxy S24 Ultra bút S Pen tích hợp, AI Galaxy, camera 200MP.',
 'Chip: Snapdragon 8 Gen 3|RAM: 12GB|Bộ nhớ: 256GB|Màn hình: 6.8" AMOLED|Pin: 5000mAh|Camera: 200MP','📱','hot',20,4.7,980),

('MacBook Air M3','Laptop','Apple',32990000,NULL,
 'MacBook Air M3 mỏng nhẹ, pin 18 giờ, màn hình Liquid Retina 15.3".',
 'Chip: Apple M3|RAM: 16GB|Bộ nhớ: 512GB SSD|Màn hình: 15.3" Retina|Pin: 18 giờ|Trọng lượng: 1.51kg','💻','new',8,4.9,756),

('Sony WH-1000XM5','Tai nghe','Sony',7490000,9490000,
 'Tai nghe chống ồn hàng đầu, Hi-Res Audio, pin 30 giờ.',
 'Chống ồn: ANC|Pin: 30 giờ|Kết nối: Bluetooth 5.2|Driver: 30mm|Cổng sạc: USB-C|Trọng lượng: 250g','🎧','sale',30,4.8,2100),

('iPad Pro M4 13"','Máy tính bảng','Apple',28990000,31990000,
 'iPad Pro M4 siêu mỏng 5.1mm, màn hình Ultra Retina XDR OLED.',
 'Chip: Apple M4|RAM: 16GB|Bộ nhớ: 256GB|Màn hình: 13" OLED|Pin: 10 giờ|Camera: 12MP','📟','new',12,4.9,540),

('ASUS ROG Zephyrus G14','Laptop','ASUS',39990000,44990000,
 'Laptop gaming AMD Ryzen 9, RTX 4060, màn hình OLED 165Hz.',
 'CPU: AMD Ryzen 9 8945H|GPU: RTX 4060 8GB|RAM: 16GB DDR5|Bộ nhớ: 1TB|Màn hình: 14" OLED 165Hz|Pin: 72Wh','💻','hot',5,4.7,430),

('Xiaomi 14 Ultra','Điện thoại','Xiaomi',21990000,24990000,
 'Xiaomi 14 Ultra camera Leica, Snapdragon 8 Gen 3, sạc 90W.',
 'Chip: Snapdragon 8 Gen 3|RAM: 16GB|Bộ nhớ: 512GB|Màn hình: 6.73" AMOLED 120Hz|Pin: 5000mAh|Camera: 50MP Leica','📱','sale',25,4.6,670),

('Apple Watch Ultra 2','Đồng hồ','Apple',19990000,NULL,
 'Vỏ titan, GPS L1+L5, pin 60 giờ, chống nước 100m.',
 'Chip: S9|Màn hình: 49mm Always-On|Pin: 60 giờ|GPS: L1+L5|Chống nước: 100m|Vỏ: Titan hàng không','⌚','new',18,4.8,320),

('Samsung OLED 4K 55"','TV','Samsung',24990000,29990000,
 'TV OLED 4K 55 inch, Neural Quantum, Dolby Atmos.',
 'Màn hình: 55" 4K OLED|Tần số quét: 144Hz|Âm thanh: 60W Dolby Atmos|Hệ điều hành: Tizen|Cổng: HDMI 2.1 x4|HDR: HDR10+','📺','sale',10,4.7,890),

('JBL Charge 5','Loa','JBL',3490000,4490000,
 'Loa bluetooth chống nước IP67, pin 20 giờ.',
 'Công suất: 40W|Pin: 20 giờ|Chống nước: IP67|Kết nối: Bluetooth 5.1|USB: Có sạc thiết bị|Trọng lượng: 960g','🔊','sale',40,4.6,1560),

('AirPods Pro 2','Tai nghe','Apple',6490000,7490000,
 'H2 chip, chống ồn xuất sắc, sạc MagSafe.',
 'Chip: Apple H2|Chống ồn: ANC+Transparency|Pin: 6h (30h với hộp)|Kết nối: Bluetooth 5.3|Chống nước: IPX4|Sạc: MagSafe','🎧','hot',35,4.8,3200),

('Dell XPS 15 OLED','Laptop','Dell',45990000,49990000,
 'Màn hình OLED 3.5K, Core Ultra 9, RTX 4060, RAM 32GB.',
 'CPU: Intel Core Ultra 9|GPU: RTX 4060 8GB|RAM: 32GB DDR5|Bộ nhớ: 1TB SSD|Màn hình: 15.6" 3.5K OLED|Pin: 86Wh','💻','new',6,4.6,280);

-- Đơn hàng mẫu
INSERT INTO orders (user_id, full_name, phone, address, total_amount, status) VALUES
(2, 'Nguyễn Văn An', '0912345678', '456 Lê Lợi, Q3, TP.HCM', 29990000, 'delivered'),
(2, 'Nguyễn Văn An', '0912345678', '456 Lê Lợi, Q3, TP.HCM', 7490000,  'processing'),
(3, 'Trần Thị Bình', '0923456789', '789 Trần Hưng Đạo, Q5', 32990000, 'pending');

INSERT INTO order_items (order_id, product_id, product_name, price, quantity) VALUES
(1, 1, 'iPhone 15 Pro Max',     29990000, 1),
(2, 4, 'Sony WH-1000XM5',       7490000,  1),
(3, 3, 'MacBook Air M3',        32990000, 1);
