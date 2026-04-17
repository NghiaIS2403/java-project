// ===== DATA STORE =====
const DB = {
    products: [
        { id: 1, name: 'iPhone 15 Pro Max', category: 'Điện thoại', price: 29990000, oldPrice: 34990000, rating: 4.8, reviews: 1240, emoji: '📱', badge: 'sale', brand: 'Apple', stock: 15, desc: 'iPhone 15 Pro Max với chip A17 Pro, màn hình Super Retina XDR 6.7 inch, camera 48MP chuyên nghiệp.', specs: { 'Chip': 'Apple A17 Pro', 'RAM': '8GB', 'Bộ nhớ': '256GB', 'Màn hình': '6.7" OLED', 'Pin': '4422 mAh', 'Camera': '48MP + 12MP + 12MP' } },
        { id: 2, name: 'Samsung Galaxy S24 Ultra', category: 'Điện thoại', price: 26990000, oldPrice: 31990000, rating: 4.7, reviews: 980, emoji: '📱', badge: 'hot', brand: 'Samsung', stock: 20, desc: 'Galaxy S24 Ultra với bút S Pen tích hợp, AI Galaxy mạnh mẽ, camera 200MP.', specs: { 'Chip': 'Snapdragon 8 Gen 3', 'RAM': '12GB', 'Bộ nhớ': '256GB', 'Màn hình': '6.8" Dynamic AMOLED', 'Pin': '5000 mAh', 'Camera': '200MP + 10MP + 50MP + 12MP' } },
        { id: 3, name: 'MacBook Air M3', category: 'Laptop', price: 32990000, oldPrice: null, rating: 4.9, reviews: 756, emoji: '💻', badge: 'new', brand: 'Apple', stock: 8, desc: 'MacBook Air M3 mỏng nhẹ nhất, pin 18 giờ, màn hình Liquid Retina 15.3 inch.', specs: { 'Chip': 'Apple M3', 'RAM': '16GB', 'Bộ nhớ': '512GB SSD', 'Màn hình': '15.3" Liquid Retina', 'Pin': '18 giờ', 'Trọng lượng': '1.51 kg' } },
        { id: 4, name: 'Sony WH-1000XM5', category: 'Tai nghe', price: 7490000, oldPrice: 9490000, rating: 4.8, reviews: 2100, emoji: '🎧', badge: 'sale', brand: 'Sony', stock: 30, desc: 'Tai nghe chống ồn hàng đầu thế giới, âm thanh Hi-Res, pin 30 giờ.', specs: { 'Chống ồn': 'ANC thế hệ mới', 'Pin': '30 giờ', 'Kết nối': 'Bluetooth 5.2', 'Driver': '30mm', 'Cổng sạc': 'USB-C', 'Trọng lượng': '250g' } },
        { id: 5, name: 'iPad Pro M4 12.9"', category: 'Máy tính bảng', price: 28990000, oldPrice: 31990000, rating: 4.9, reviews: 540, emoji: '📟', badge: 'new', brand: 'Apple', stock: 12, desc: 'iPad Pro M4 siêu mỏng chỉ 5.1mm, màn hình Ultra Retina XDR OLED.', specs: { 'Chip': 'Apple M4', 'RAM': '16GB', 'Bộ nhớ': '256GB', 'Màn hình': '13" Ultra Retina XDR', 'Pin': '10 giờ', 'Camera': '12MP + 10MP TrueDepth' } },
        { id: 6, name: 'ASUS ROG Zephyrus G14', category: 'Laptop', price: 39990000, oldPrice: 44990000, rating: 4.7, reviews: 430, emoji: '💻', badge: 'hot', brand: 'ASUS', stock: 5, desc: 'Laptop gaming mạnh mẽ với AMD Ryzen 9, RTX 4060, màn hình 165Hz.', specs: { 'CPU': 'AMD Ryzen 9 8945H', 'GPU': 'RTX 4060 8GB', 'RAM': '16GB DDR5', 'Bộ nhớ': '1TB NVMe', 'Màn hình': '14" 165Hz OLED', 'Pin': '72Wh' } },
        { id: 7, name: 'Xiaomi 14 Ultra', category: 'Điện thoại', price: 21990000, oldPrice: 24990000, rating: 4.6, reviews: 670, emoji: '📱', badge: 'sale', brand: 'Xiaomi', stock: 25, desc: 'Xiaomi 14 Ultra với Leica camera, Snapdragon 8 Gen 3, sạc 90W.', specs: { 'Chip': 'Snapdragon 8 Gen 3', 'RAM': '16GB', 'Bộ nhớ': '512GB', 'Màn hình': '6.73" AMOLED 120Hz', 'Pin': '5000 mAh', 'Camera': '50MP Leica x4' } },
        { id: 8, name: 'Apple Watch Ultra 2', category: 'Đồng hồ', price: 19990000, oldPrice: null, rating: 4.8, reviews: 320, emoji: '⌚', badge: 'new', brand: 'Apple', stock: 18, desc: 'Apple Watch Ultra 2 với vỏ titan, GPS chính xác, pin 60 giờ.', specs: { 'Chip': 'S9 SiP', 'Màn hình': '49mm Always-On Retina', 'Pin': '60 giờ', 'GPS': 'L1 + L5', 'Chống nước': '100m WR100', 'Vỏ': 'Titan cấp hàng không' } },
        { id: 9, name: 'Samsung 4K OLED 55"', category: 'TV', price: 24990000, oldPrice: 29990000, rating: 4.7, reviews: 890, emoji: '📺', badge: 'sale', brand: 'Samsung', stock: 10, desc: 'TV OLED 4K 55 inch với công nghệ Neural Quantum, âm thanh Dolby Atmos.', specs: { 'Màn hình': '55" 4K OLED', 'Tần số quét': '144Hz', 'Âm thanh': 'Dolby Atmos 60W', 'Hệ điều hành': 'Tizen OS', 'Cổng kết nối': 'HDMI 2.1 x4', 'HDR': 'HDR10+' } },
        { id: 10, name: 'JBL Charge 5', category: 'Loa', price: 3490000, oldPrice: 4490000, rating: 4.6, reviews: 1560, emoji: '🔊', badge: 'sale', brand: 'JBL', stock: 40, desc: 'Loa bluetooth chống nước IP67, pin 20 giờ, âm thanh mạnh mẽ.', specs: { 'Công suất': '40W', 'Pin': '20 giờ', 'Chống nước': 'IP67', 'Kết nối': 'Bluetooth 5.1', 'USB': 'Có thể sạc thiết bị', 'Trọng lượng': '960g' } },
        { id: 11, name: 'AirPods Pro 2', category: 'Tai nghe', price: 6490000, oldPrice: 7490000, rating: 4.8, reviews: 3200, emoji: '🎧', badge: 'hot', brand: 'Apple', stock: 35, desc: 'AirPods Pro thế hệ 2 với H2 chip, chống ồn xuất sắc, sạc MagSafe.', specs: { 'Chip': 'Apple H2', 'Chống ồn': 'ANC + Transparency', 'Pin': '6h (30h với hộp sạc)', 'Kết nối': 'Bluetooth 5.3', 'Chống nước': 'IPX4', 'Cổng sạc': 'MagSafe / USB-C' } },
        { id: 12, name: 'Dell XPS 15 OLED', category: 'Laptop', price: 45990000, oldPrice: 49990000, rating: 4.6, reviews: 280, emoji: '💻', badge: 'new', brand: 'Dell', stock: 6, desc: 'XPS 15 với màn hình OLED 3.5K, Core Ultra 9, RTX 4060.', specs: { 'CPU': 'Intel Core Ultra 9 185H', 'GPU': 'RTX 4060 8GB', 'RAM': '32GB DDR5', 'Bộ nhớ': '1TB SSD', 'Màn hình': '15.6" 3.5K OLED', 'Pin': '86Wh' } },
    ],

    categories: ['Tất cả', 'Điện thoại', 'Laptop', 'Tai nghe', 'Máy tính bảng', 'Đồng hồ', 'TV', 'Loa'],

    orders: JSON.parse(localStorage.getItem('techzone_orders') || '[]'),
    users: JSON.parse(localStorage.getItem('techzone_users') || JSON.stringify([
        { id: 1, name: 'Admin', email: 'admin@techzone.vn', password: 'admin123', role: 'admin', createdAt: '2024-01-01' },
        { id: 2, name: 'Nguyễn Văn An', email: 'user@techzone.vn', password: 'user123', role: 'user', createdAt: '2024-02-15' },
        { id: 3, name: 'Trần Thị Bình', email: 'binh@gmail.com', password: '123456', role: 'user', createdAt: '2024-03-20' },
    ])),

    save() {
        localStorage.setItem('techzone_orders', JSON.stringify(this.orders));
        localStorage.setItem('techzone_users', JSON.stringify(this.users));
    }
};

// ===== AUTH =====
const Auth = {
    currentUser: null,

    init() {
        const saved = localStorage.getItem('techzone_session');
        if (saved) this.currentUser = JSON.parse(saved);
    },

    login(email, password) {
        const user = DB.users.find(u => u.email === email && u.password === password);
        if (user) {
            this.currentUser = user;
            localStorage.setItem('techzone_session', JSON.stringify(user));
            return { ok: true, user };
        }
        return { ok: false, message: 'Email hoặc mật khẩu không đúng!' };
    },

    register(name, email, password) {
        if (DB.users.find(u => u.email === email)) {
            return { ok: false, message: 'Email đã được đăng ký!' };
        }
        const newUser = { id: Date.now(), name, email, password, role: 'user', createdAt: new Date().toISOString().split('T')[0] };
        DB.users.push(newUser);
        DB.save();
        this.currentUser = newUser;
        localStorage.setItem('techzone_session', JSON.stringify(newUser));
        return { ok: true, user: newUser };
    },

    logout() {
        this.currentUser = null;
        localStorage.removeItem('techzone_session');
    },

    isAdmin() { return this.currentUser?.role === 'admin'; },
    isLoggedIn() { return !!this.currentUser; }
};

// ===== CART =====
const Cart = {
    items: JSON.parse(localStorage.getItem('techzone_cart') || '[]'),

    save() { localStorage.setItem('techzone_cart', JSON.stringify(this.items)); },

    add(productId, qty = 1) {
        const product = DB.products.find(p => p.id === productId);
        if (!product) return;
        const existing = this.items.find(i => i.id === productId);
        if (existing) {
            existing.qty = Math.min(existing.qty + qty, product.stock);
        } else {
            this.items.push({ id: productId, qty });
        }
        this.save();
        this.updateBadge();
    },

    remove(productId) {
        this.items = this.items.filter(i => i.id !== productId);
        this.save();
        this.updateBadge();
    },

    setQty(productId, qty) {
        const item = this.items.find(i => i.id === productId);
        if (item) {
            if (qty <= 0) this.remove(productId);
            else item.qty = qty;
        }
        this.save();
        this.updateBadge();
    },

    clear() { this.items = []; this.save(); this.updateBadge(); },

    getTotal() {
        return this.items.reduce((sum, item) => {
            const p = DB.products.find(p => p.id === item.id);
            return sum + (p ? p.price * item.qty : 0);
        }, 0);
    },

    getCount() { return this.items.reduce((s, i) => s + i.qty, 0); },

    updateBadge() {
        const badges = document.querySelectorAll('.cart-badge');
        badges.forEach(b => {
            const count = this.getCount();
            b.textContent = count;
            b.style.display = count > 0 ? 'flex' : 'none';
        });
    }
};

// ===== HELPERS =====
function formatPrice(n) {
    return n.toLocaleString('vi-VN') + 'đ';
}

function renderStars(rating) {
    const full = Math.floor(rating);
    let s = '';
    for (let i = 0; i < 5; i++) s += i < full ? '★' : '☆';
    return s;
}

function toast(message, type = 'info') {
    let container = document.querySelector('.toast-container');
    if (!container) {
        container = document.createElement('div');
        container.className = 'toast-container';
        document.body.appendChild(container);
    }
    const t = document.createElement('div');
    const icons = { success: '✅', error: '❌', info: 'ℹ️' };
    t.className = `toast toast-${type}`;
    t.innerHTML = `<span>${icons[type]}</span><span>${message}</span>`;
    container.appendChild(t);
    setTimeout(() => { t.classList.add('removing'); setTimeout(() => t.remove(), 300); }, 3000);
}

function $(selector) { return document.querySelector(selector); }
function $$(selector) { return document.querySelectorAll(selector); }

// Save cart product globally
window.DB = DB;
window.Auth = Auth;
window.Cart = Cart;
window.formatPrice = formatPrice;
window.renderStars = renderStars;
window.toast = toast;

// Init
Auth.init();
