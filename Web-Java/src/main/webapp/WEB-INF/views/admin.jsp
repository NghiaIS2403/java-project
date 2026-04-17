<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width,initial-scale=1.0" />
                <title>Admin – TechZone</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
                <style>
                    .admin-layout {
                        display: grid;
                        grid-template-columns: 240px 1fr;
                        min-height: 100vh;
                    }

                    .admin-sidebar {
                        background: var(--bg-card);
                        border-right: 1px solid var(--border);
                        padding: 1.5rem 1rem;
                        position: sticky;
                        top: 70px;
                        height: calc(100vh - 70px);
                        overflow-y: auto;
                    }

                    .sidebar-logo {
                        font-size: 1.2rem;
                        font-weight: 800;
                        margin-bottom: 2rem;
                        padding: .5rem;
                    }

                    .sidebar-logo span {
                        color: var(--primary);
                    }

                    .sidebar-nav {
                        list-style: none;
                        display: flex;
                        flex-direction: column;
                        gap: .3rem;
                    }

                    .sidebar-nav a {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        padding: 10px 14px;
                        border-radius: var(--radius-sm);
                        text-decoration: none;
                        color: var(--text-secondary);
                        font-size: .9rem;
                        font-weight: 500;
                        transition: var(--transition);
                    }

                    .sidebar-nav a:hover {
                        background: rgba(108, 99, 255, .1);
                        color: var(--text-primary);
                    }

                    .sidebar-nav a.active {
                        background: var(--primary);
                        color: #fff;
                    }

                    .admin-main {
                        padding: 2rem;
                    }

                    .stat-cards {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                        gap: 1.2rem;
                        margin-bottom: 2rem;
                    }

                    .stat-card {
                        background: var(--bg-card);
                        border: 1px solid var(--border);
                        border-radius: var(--radius);
                        padding: 1.5rem;
                        transition: var(--transition);
                    }

                    .stat-card:hover {
                        border-color: rgba(108, 99, 255, .5);
                        box-shadow: var(--shadow);
                    }

                    .stat-icon {
                        font-size: 2rem;
                        margin-bottom: .8rem;
                    }

                    .stat-num {
                        font-size: 2rem;
                        font-weight: 800;
                        color: var(--primary);
                    }

                    .stat-label {
                        font-size: .82rem;
                        color: var(--text-secondary);
                        margin-top: .2rem;
                    }

                    .admin-table-wrap {
                        background: var(--bg-card);
                        border: 1px solid var(--border);
                        border-radius: var(--radius);
                        overflow: hidden;
                    }

                    .admin-table-header {
                        padding: 1.2rem 1.5rem;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        border-bottom: 1px solid var(--border);
                        gap: 1rem;
                        flex-wrap: wrap;
                    }

                    .modal-overlay {
                        position: fixed;
                        inset: 0;
                        z-index: 2000;
                        background: rgba(0, 0, 0, .75);
                        backdrop-filter: blur(8px);
                        display: none;
                        align-items: center;
                        justify-content: center;
                    }

                    .modal-overlay.show {
                        display: flex;
                    }

                    .modal {
                        background: var(--bg-card);
                        border: 1px solid var(--border);
                        border-radius: var(--radius);
                        padding: 2rem;
                        width: 90%;
                        max-width: 520px;
                        max-height: 90vh;
                        overflow-y: auto;
                    }

                    .modal-header {
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        margin-bottom: 1.5rem;
                    }

                    .row-2 {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 1rem;
                    }

                    @media(max-width:768px) {
                        .admin-layout {
                            grid-template-columns: 1fr
                        }

                        .admin-sidebar {
                            display: none
                        }
                    }
                </style>
            </head>

            <body>
                <%@ include file="header.jsp" %>

                    <div class="admin-layout">
                        <!-- SIDEBAR -->
                        <aside class="admin-sidebar">
                            <div class="sidebar-logo">🛠️ Admin <span>Panel</span></div>
                            <ul class="sidebar-nav">
                                <li><a href="${pageContext.request.contextPath}/admin"
                                        class="${tab eq 'dashboard' ? 'active' : ''}">📊 Dashboard</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin?tab=products"
                                        class="${tab eq 'products' ? 'active' : ''}">📦 Sản phẩm</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin?tab=orders"
                                        class="${tab eq 'orders' ? 'active' : ''}">🧾 Đơn hàng</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin?tab=users"
                                        class="${tab eq 'users' ? 'active' : ''}">👥 Người dùng</a></li>
                                <li style="margin-top:auto;border-top:1px solid var(--border);padding-top:.8rem">
                                    <a href="${pageContext.request.contextPath}/">🏠 Về trang chủ</a>
                                </li>
                                <li><a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a></li>
                            </ul>
                        </aside>

                        <!-- MAIN CONTENT -->
                        <main class="admin-main">

                            <!-- ============ DASHBOARD ============ -->
                            <c:if test="${tab eq 'dashboard'}">
                                <h2 class="section-title" style="margin-bottom:1.5rem">📊 Dashboard</h2>
                                <div class="stat-cards">
                                    <div class="stat-card">
                                        <div class="stat-icon">📦</div>
                                        <div class="stat-num">${totalProducts}</div>
                                        <div class="stat-label">Sản phẩm</div>
                                    </div>
                                    <div class="stat-card">
                                        <div class="stat-icon">🧾</div>
                                        <div class="stat-num">${totalOrders}</div>
                                        <div class="stat-label">Đơn hàng</div>
                                    </div>
                                    <div class="stat-card">
                                        <div class="stat-icon">👥</div>
                                        <div class="stat-num">${totalUsers}</div>
                                        <div class="stat-label">Người dùng</div>
                                    </div>
                                    <div class="stat-card">
                                        <div class="stat-icon">💰</div>
                                        <% long rev=(Long) request.getAttribute("totalRevenue"); String
                                            revFmt=String.format("%,d", rev).replace(",", "." ) + "đ" ;
                                            pageContext.setAttribute("revFmt", revFmt); %>
                                            <div class="stat-num" style="font-size:1.3rem">${revFmt}</div>
                                            <div class="stat-label">Doanh thu (đã giao)</div>
                                    </div>
                                </div>
                                <div class="glass-card" style="text-align:center;padding:2rem">
                                    <p style="color:var(--text-secondary)">Chọn tab ở sidebar để quản lý sản phẩm, đơn
                                        hàng, người dùng.</p>
                                    <div
                                        style="display:flex;gap:1rem;justify-content:center;flex-wrap:wrap;margin-top:1.5rem">
                                        <a href="?tab=products" class="btn btn-primary">📦 Quản lý sản phẩm</a>
                                        <a href="?tab=orders" class="btn btn-secondary">🧾 Quản lý đơn hàng</a>
                                        <a href="?tab=users" class="btn btn-secondary">👥 Quản lý người dùng</a>
                                    </div>
                                </div>
                            </c:if>

                            <!-- ============ PRODUCTS ============ -->
                            <c:if test="${tab eq 'products'}">
                                <div class="admin-table-wrap">
                                    <div class="admin-table-header">
                                        <h2 style="font-size:1.1rem;font-weight:700">📦 Quản lý sản phẩm
                                            (${totalProducts})</h2>
                                        <button class="btn btn-primary btn-sm" onclick="showModal('addModal')">➕ Thêm
                                            sản phẩm</button>
                                    </div>
                                    <div style="overflow-x:auto">
                                        <table class="data-table">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Sản phẩm</th>
                                                    <th>Danh mục</th>
                                                    <th>Giá</th>
                                                    <th>Tồn kho</th>
                                                    <th>Badge</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="p" items="${products}">
                                                    <% com.techzone.model.Product pr=(com.techzone.model.Product)
                                                        pageContext.getAttribute("p"); %>
                                                        <tr>
                                                            <td>${p.id}</td>
                                                            <td>
                                                                <div style="display:flex;align-items:center;gap:10px">
                                                                    <span style="font-size:1.5rem">${p.emoji}</span>
                                                                    <div>
                                                                        <div style="font-weight:600;font-size:.9rem">
                                                                            ${p.name}</div>
                                                                        <div
                                                                            style="font-size:.78rem;color:var(--text-secondary)">
                                                                            ${p.brand}</div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>${p.category}</td>
                                                            <td style="font-weight:700;color:var(--primary)">
                                                                ${p.formattedPrice}</td>
                                                            <td><span
                                                                    style="color:${p.stock > 5 ? '#00b894' : '#ff6b6b'}">${p.stock}</span>
                                                            </td>
                                                            <td>${not empty p.badge ? p.badge : '-'}</td>
                                                            <td>
                                                                <div style="display:flex;gap:.4rem">
                                                                    <button class="btn btn-secondary btn-sm"
                                                                        onclick="editProduct(${p.id},'${p.name}','${p.category}','${p.brand}',${p.price},${p.oldPrice},'${p.emoji}','${p.badge}',${p.stock},'${p.description}','${p.specs}')">✏️</button>
                                                                    <form method="post"
                                                                        action="${pageContext.request.contextPath}/admin"
                                                                        onsubmit="return confirm('Xóa sản phẩm này?')">
                                                                        <input type="hidden" name="action"
                                                                            value="deleteProduct" />
                                                                        <input type="hidden" name="id"
                                                                            value="${p.id}" />
                                                                        <button type="submit"
                                                                            class="btn btn-danger btn-sm">🗑️</button>
                                                                    </form>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:if>

                            <!-- ============ ORDERS ============ -->
                            <c:if test="${tab eq 'orders'}">
                                <div class="admin-table-wrap">
                                    <div class="admin-table-header">
                                        <h2 style="font-size:1.1rem;font-weight:700">🧾 Quản lý đơn hàng
                                            (${totalOrders})</h2>
                                    </div>
                                    <div style="overflow-x:auto">
                                        <table class="data-table">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Khách hàng</th>
                                                    <th>Địa chỉ</th>
                                                    <th>Tổng tiền</th>
                                                    <th>Ngày đặt</th>
                                                    <th>Trạng thái</th>
                                                    <th>Cập nhật</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="o" items="${orders}">
                                                    <tr>
                                                        <td>#${o.id}</td>
                                                        <td>
                                                            <div style="font-weight:600;font-size:.9rem">${o.fullName}
                                                            </div>
                                                            <div style="font-size:.78rem;color:var(--text-secondary)">
                                                                ${o.phone}</div>
                                                        </td>
                                                        <td style="font-size:.82rem;max-width:180px">${o.address}</td>
                                                        <td style="font-weight:700;color:var(--primary)">
                                                            ${o.formattedTotal}</td>
                                                        <td style="font-size:.82rem">${o.createdAt}</td>
                                                        <td><span
                                                                class="status-badge status-${o.status}">${o.statusLabel}</span>
                                                        </td>
                                                        <td>
                                                            <form method="post"
                                                                action="${pageContext.request.contextPath}/admin"
                                                                style="display:flex;gap:.4rem">
                                                                <input type="hidden" name="action"
                                                                    value="updateOrderStatus" />
                                                                <input type="hidden" name="id" value="${o.id}" />
                                                                <select name="status" class="form-control"
                                                                    style="width:auto;padding:5px 8px;font-size:.8rem">
                                                                    <option value="pending" ${o.status eq 'pending'
                                                                        ? 'selected' : '' }>Chờ xác nhận</option>
                                                                    <option value="processing" ${o.status
                                                                        eq 'processing' ? 'selected' : '' }>Đang xử lý
                                                                    </option>
                                                                    <option value="delivered" ${o.status eq 'delivered'
                                                                        ? 'selected' : '' }>Đã giao</option>
                                                                    <option value="cancelled" ${o.status eq 'cancelled'
                                                                        ? 'selected' : '' }>Đã hủy</option>
                                                                </select>
                                                                <button type="submit"
                                                                    class="btn btn-success btn-sm">✓</button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:if>

                            <!-- ============ USERS ============ -->
                            <c:if test="${tab eq 'users'}">
                                <div class="admin-table-wrap">
                                    <div class="admin-table-header">
                                        <h2 style="font-size:1.1rem;font-weight:700">👥 Quản lý người dùng
                                            (${totalUsers})</h2>
                                    </div>
                                    <div style="overflow-x:auto">
                                        <table class="data-table">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Tên</th>
                                                    <th>Email</th>
                                                    <th>Số ĐT</th>
                                                    <th>Vai trò</th>
                                                    <th>Ngày tạo</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="u" items="${users}">
                                                    <tr>
                                                        <td>${u.id}</td>
                                                        <td>
                                                            <div style="display:flex;align-items:center;gap:8px">
                                                                <div
                                                                    style="width:32px;height:32px;border-radius:50%;background:linear-gradient(135deg,var(--primary),var(--secondary));display:flex;align-items:center;justify-content:center;font-weight:700;font-size:.85rem">
                                                                    ${u.initial}</div>
                                                                <span
                                                                    style="font-weight:600;font-size:.9rem">${u.name}</span>
                                                            </div>
                                                        </td>
                                                        <td style="font-size:.88rem">${u.email}</td>
                                                        <td style="font-size:.88rem">${u.phone}</td>
                                                        <td>
                                                            <span
                                                                class="status-badge ${u.admin ? 'status-processing' : 'status-delivered'}">
                                                                ${u.admin ? '👑 Admin' : '👤 User'}
                                                            </span>
                                                        </td>
                                                        <td style="font-size:.82rem">${u.createdAt}</td>
                                                        <td>
                                                            <c:if test="${!u.admin}">
                                                                <form method="post"
                                                                    action="${pageContext.request.contextPath}/admin"
                                                                    onsubmit="return confirm('Xóa người dùng này?')">
                                                                    <input type="hidden" name="action"
                                                                        value="deleteUser" />
                                                                    <input type="hidden" name="id" value="${u.id}" />
                                                                    <button type="submit"
                                                                        class="btn btn-danger btn-sm">🗑️</button>
                                                                </form>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:if>
                        </main>
                    </div>

                    <!-- ADD PRODUCT MODAL -->
                    <div class="modal-overlay" id="addModal">
                        <div class="modal">
                            <div class="modal-header">
                                <h3 class="modal-title">➕ Thêm sản phẩm</h3>
                                <button class="modal-close" onclick="hideModal('addModal')">✕</button>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/admin">
                                <input type="hidden" name="action" value="addProduct" />
                                <div class="form-group">
                                    <label class="form-label">Tên sản phẩm *</label>
                                    <input class="form-control" type="text" name="name" required
                                        placeholder="iPhone 15 Pro Max" />
                                </div>
                                <div class="row-2">
                                    <div class="form-group">
                                        <label class="form-label">Danh mục *</label>
                                        <select class="form-control" name="category" required>
                                            <option>Điện thoại</option>
                                            <option>Laptop</option>
                                            <option>Tai nghe</option>
                                            <option>Máy tính bảng</option>
                                            <option>Đồng hồ</option>
                                            <option>TV</option>
                                            <option>Loa</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Thương hiệu</label>
                                        <input class="form-control" type="text" name="brand" placeholder="Apple" />
                                    </div>
                                </div>
                                <div class="row-2">
                                    <div class="form-group">
                                        <label class="form-label">Giá bán (đ) *</label>
                                        <input class="form-control" type="number" name="price" required
                                            placeholder="29990000" />
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Giá gốc (đ)</label>
                                        <input class="form-control" type="number" name="oldPrice"
                                            placeholder="34990000" />
                                    </div>
                                </div>
                                <div class="row-2">
                                    <div class="form-group">
                                        <label class="form-label">Tồn kho</label>
                                        <input class="form-control" type="number" name="stock" placeholder="10"
                                            value="10" />
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Emoji</label>
                                        <input class="form-control" type="text" name="emoji" placeholder="📱"
                                            value="📦" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Badge</label>
                                    <select class="form-control" name="badge">
                                        <option value="">Không</option>
                                        <option value="sale">SALE</option>
                                        <option value="new">MỚI</option>
                                        <option value="hot">HOT</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Mô tả</label>
                                    <textarea class="form-control" name="description" rows="2"
                                        placeholder="Mô tả ngắn về sản phẩm"></textarea>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Thông số kỹ thuật (Key: Value|Key: Value)</label>
                                    <textarea class="form-control" name="specs" rows="2"
                                        placeholder="Chip: A17 Pro|RAM: 8GB|Bộ nhớ: 256GB"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary"
                                    style="width:100%;justify-content:center">➕ Thêm sản phẩm</button>
                            </form>
                        </div>
                    </div>

                    <!-- EDIT PRODUCT MODAL -->
                    <div class="modal-overlay" id="editModal">
                        <div class="modal">
                            <div class="modal-header">
                                <h3 class="modal-title">✏️ Sửa sản phẩm</h3>
                                <button class="modal-close" onclick="hideModal('editModal')">✕</button>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/admin">
                                <input type="hidden" name="action" value="editProduct" />
                                <input type="hidden" name="id" id="editId" />
                                <div class="form-group">
                                    <label class="form-label">Tên sản phẩm *</label>
                                    <input class="form-control" type="text" name="name" id="editName" required />
                                </div>
                                <div class="row-2">
                                    <div class="form-group">
                                        <label class="form-label">Danh mục *</label>
                                        <select class="form-control" name="category" id="editCategory">
                                            <option>Điện thoại</option>
                                            <option>Laptop</option>
                                            <option>Tai nghe</option>
                                            <option>Máy tính bảng</option>
                                            <option>Đồng hồ</option>
                                            <option>TV</option>
                                            <option>Loa</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Thương hiệu</label>
                                        <input class="form-control" type="text" name="brand" id="editBrand" />
                                    </div>
                                </div>
                                <div class="row-2">
                                    <div class="form-group">
                                        <label class="form-label">Giá bán (đ) *</label>
                                        <input class="form-control" type="number" name="price" id="editPrice"
                                            required />
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Giá gốc (đ)</label>
                                        <input class="form-control" type="number" name="oldPrice" id="editOldPrice" />
                                    </div>
                                </div>
                                <div class="row-2">
                                    <div class="form-group">
                                        <label class="form-label">Tồn kho</label>
                                        <input class="form-control" type="number" name="stock" id="editStock" />
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Emoji</label>
                                        <input class="form-control" type="text" name="emoji" id="editEmoji" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Badge</label>
                                    <select class="form-control" name="badge" id="editBadge">
                                        <option value="">Không</option>
                                        <option value="sale">SALE</option>
                                        <option value="new">MỚI</option>
                                        <option value="hot">HOT</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Mô tả</label>
                                    <textarea class="form-control" name="description" id="editDesc" rows="2"></textarea>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Thông số kỹ thuật</label>
                                    <textarea class="form-control" name="specs" id="editSpecs" rows="2"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary"
                                    style="width:100%;justify-content:center">💾 Lưu thay đổi</button>
                            </form>
                        </div>
                    </div>

                    <script>
                        function showModal(id) { document.getElementById(id).classList.add('show'); }
                        function hideModal(id) { document.getElementById(id).classList.remove('show'); }
                        document.querySelectorAll('.modal-overlay').forEach(m => m.addEventListener('click', e => { if (e.target === m) m.classList.remove('show'); }));

                        function editProduct(id, name, cat, brand, price, oldPrice, emoji, badge, stock, desc, specs) {
                            document.getElementById('editId').value = id;
                            document.getElementById('editName').value = name;
                            document.getElementById('editBrand').value = brand;
                            document.getElementById('editPrice').value = price;
                            document.getElementById('editOldPrice').value = oldPrice || '';
                            document.getElementById('editEmoji').value = emoji;
                            document.getElementById('editStock').value = stock;
                            document.getElementById('editDesc').value = desc;
                            document.getElementById('editSpecs').value = specs;
                            const catSel = document.getElementById('editCategory');
                            for (let o of catSel.options) if (o.value === cat) { o.selected = true; break; }
                            const bdgSel = document.getElementById('editBadge');
                            for (let o of bdgSel.options) if (o.value === badge) { o.selected = true; break; }
                            showModal('editModal');
                        }
                    </script>
            </body>

            </html>