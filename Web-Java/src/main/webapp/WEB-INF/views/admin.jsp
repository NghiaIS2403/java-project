<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width,initial-scale=1.0" />
                <title>Admin – TechZone</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3" />
                <style>
                    /* ── Admin Layout ── */
                    .admin-wrap {
                        display: flex;
                        min-height: calc(100vh - 75px);
                    }

                    /* ── Sidebar ── */
                    .a-sidebar {
                        width: 260px;
                        flex-shrink: 0;
                        background: #fff;
                        border-right: 1px solid var(--border);
                        padding: 1.5rem 1rem;
                        position: sticky;
                        top: 75px;
                        height: calc(100vh - 75px);
                        overflow-y: auto;
                        display: flex;
                        flex-direction: column;
                    }

                    .a-sidebar-brand {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        padding: .6rem .8rem 1.4rem;
                        border-bottom: 1px solid var(--border);
                        margin-bottom: 1rem;
                    }

                    .a-sidebar-brand .brand-icon {
                        width: 36px;
                        height: 36px;
                        font-size: 1.1rem;
                    }

                    .a-sidebar-brand-name {
                        font-size: 1rem;
                        font-weight: 800;
                        color: var(--text-primary);
                    }

                    .a-sidebar-brand-name span {
                        color: var(--primary);
                    }

                    .a-sidebar-section {
                        font-size: .7rem;
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: 1.2px;
                        color: var(--text-secondary);
                        padding: .5rem .8rem .3rem;
                        margin-top: .5rem;
                    }

                    .a-nav {
                        list-style: none;
                        display: flex;
                        flex-direction: column;
                        gap: .2rem;
                    }

                    .a-nav a {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        padding: 10px 14px;
                        border-radius: var(--radius-sm);
                        text-decoration: none;
                        color: var(--text-secondary);
                        font-size: .9rem;
                        font-weight: 600;
                        transition: var(--transition);
                    }

                    .a-nav a:hover {
                        background: rgba(79, 70, 229, .08);
                        color: var(--primary);
                    }

                    .a-nav a.active {
                        background: linear-gradient(135deg, var(--primary), var(--secondary));
                        color: #fff;
                        box-shadow: 0 4px 12px rgba(79, 70, 229, .3);
                    }

                    .a-nav a .nav-icon {
                        font-size: 1.1rem;
                        width: 22px;
                        text-align: center;
                    }

                    .a-sidebar-bottom {
                        margin-top: auto;
                        border-top: 1px solid var(--border);
                        padding-top: 1rem;
                    }

                    /* ── Main ── */
                    .a-main {
                        flex: 1;
                        padding: 2rem 2.5rem;
                        background: var(--bg-dark);
                        min-width: 0;
                    }

                    .a-page-header {
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        margin-bottom: 2rem;
                        flex-wrap: wrap;
                        gap: 1rem;
                    }

                    .a-page-title {
                        font-size: 1.6rem;
                        font-weight: 800;
                        color: var(--text-primary);
                        letter-spacing: -.5px;
                    }

                    .a-page-title span {
                        color: var(--primary);
                    }

                    /* ── Stat Cards ── */
                    .a-stat-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                        gap: 1.2rem;
                        margin-bottom: 1.5rem;
                    }

                    .a-stat-card {
                        background: #fff;
                        border: 1px solid var(--border);
                        border-radius: var(--radius);
                        padding: 1.4rem 1.6rem;
                        display: flex;
                        align-items: center;
                        gap: 1.2rem;
                        transition: var(--transition);
                        position: relative;
                        overflow: hidden;
                    }

                    .a-stat-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 4px;
                        height: 100%;
                        background: var(--stat-color, var(--primary));
                    }

                    .a-stat-card:hover {
                        transform: translateY(-3px);
                        box-shadow: var(--shadow);
                        border-color: rgba(79, 70, 229, .3);
                    }

                    .a-stat-icon {
                        width: 54px;
                        height: 54px;
                        border-radius: 14px;
                        background: var(--stat-bg, rgba(79, 70, 229, .1));
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.6rem;
                        flex-shrink: 0;
                    }

                    .a-stat-body {
                        flex: 1;
                        min-width: 0;
                    }

                    .a-stat-num {
                        font-size: 1.8rem;
                        font-weight: 800;
                        color: var(--stat-color, var(--primary));
                        line-height: 1.1;
                    }

                    .a-stat-label {
                        font-size: .8rem;
                        color: var(--text-secondary);
                        font-weight: 600;
                        margin-top: 3px;
                        text-transform: uppercase;
                        letter-spacing: .5px;
                    }

                    .a-stat-sub {
                        font-size: .78rem;
                        margin-top: 4px;
                        font-weight: 600;
                    }

                    /* ── Revenue Row ── */
                    .a-rev-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                        gap: 1.2rem;
                        margin-bottom: 1.5rem;
                    }

                    .a-rev-card {
                        background: #fff;
                        border: 1px solid var(--border);
                        border-radius: var(--radius);
                        padding: 1.4rem 1.6rem;
                        transition: var(--transition);
                    }

                    .a-rev-card:hover {
                        transform: translateY(-3px);
                        box-shadow: var(--shadow);
                    }

                    .a-rev-label {
                        font-size: .78rem;
                        text-transform: uppercase;
                        letter-spacing: .8px;
                        color: var(--text-secondary);
                        font-weight: 700;
                        margin-bottom: .5rem;
                    }

                    .a-rev-num {
                        font-size: 1.6rem;
                        font-weight: 800;
                        margin-bottom: .3rem;
                    }

                    .a-rev-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 4px;
                        font-size: .8rem;
                        font-weight: 700;
                        padding: 3px 10px;
                        border-radius: 20px;
                    }

                    .a-rev-badge.up {
                        background: rgba(16, 185, 129, .12);
                        color: #10B981;
                    }

                    .a-rev-badge.down {
                        background: rgba(244, 63, 94, .12);
                        color: #F43F5E;
                    }

                    .a-rev-badge.neutral {
                        background: rgba(79, 70, 229, .1);
                        color: var(--primary);
                    }

                    /* ── Card Wrapper ── */
                    .a-card {
                        background: #fff;
                        border: 1px solid var(--border);
                        border-radius: var(--radius);
                        overflow: hidden;
                        margin-bottom: 2rem;
                    }

                    .a-card-header {
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        padding: 1.1rem 1.5rem;
                        border-bottom: 1px solid var(--border);
                        background: #FAFAFA;
                        gap: 1rem;
                        flex-wrap: wrap;
                    }

                    .a-card-title {
                        font-size: 1rem;
                        font-weight: 700;
                        color: var(--text-primary);
                    }

                    /* ── Tables ── */
                    .a-table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    .a-table thead th {
                        padding: 12px 16px;
                        text-align: left;
                        font-size: .78rem;
                        text-transform: uppercase;
                        letter-spacing: .8px;
                        font-weight: 700;
                        color: var(--text-secondary);
                        background: #F9FAFB;
                        border-bottom: 1px solid var(--border);
                        white-space: nowrap;
                    }

                    .a-table tbody td {
                        padding: 14px 16px;
                        border-bottom: 1px solid #F3F4F6;
                        font-size: .9rem;
                        color: var(--text-primary);
                        vertical-align: middle;
                    }

                    .a-table tbody tr:last-child td {
                        border-bottom: none;
                    }

                    .a-table tbody tr:hover td {
                        background: #F8FAFC;
                    }

                    /* ── Product cell ── */
                    .prod-cell {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .prod-emoji {
                        font-size: 1.8rem;
                        width: 44px;
                        height: 44px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        background: var(--bg-card2);
                        border-radius: 10px;
                        flex-shrink: 0;
                    }

                    .prod-name {
                        font-weight: 700;
                        font-size: .9rem;
                    }

                    .prod-brand {
                        font-size: .78rem;
                        color: var(--text-secondary);
                        font-weight: 500;
                    }

                    /* ── Stock pill ── */
                    .stock-ok {
                        color: #10B981;
                        font-weight: 700;
                    }

                    .stock-low {
                        color: #F43F5E;
                        font-weight: 700;
                    }

                    /* ── Progress bar ── */
                    .progress-bar {
                        display: flex;
                        align-items: center;
                        gap: 8px;
                        min-width: 120px;
                    }

                    .progress-track {
                        flex: 1;
                        height: 7px;
                        background: #EEF2FF;
                        border-radius: 4px;
                        overflow: hidden;
                    }

                    .progress-fill {
                        height: 100%;
                        border-radius: 4px;
                        background: linear-gradient(90deg, var(--primary), var(--secondary));
                    }

                    /* ── Modal ── */
                    .a-modal-overlay {
                        position: fixed;
                        inset: 0;
                        z-index: 3000;
                        background: rgba(17, 24, 39, .6);
                        backdrop-filter: blur(6px);
                        display: none;
                        align-items: center;
                        justify-content: center;
                    }

                    .a-modal-overlay.show {
                        display: flex;
                    }

                    .a-modal {
                        background: #fff;
                        border-radius: var(--radius);
                        padding: 2rem;
                        width: 90%;
                        max-width: 540px;
                        max-height: 90vh;
                        overflow-y: auto;
                        box-shadow: 0 25px 60px rgba(0, 0, 0, .15);
                        animation: slideUp .3s cubic-bezier(.4, 0, .2, 1);
                    }

                    @keyframes slideUp {
                        from {
                            transform: translateY(20px);
                            opacity: 0;
                        }

                        to {
                            transform: translateY(0);
                            opacity: 1;
                        }
                    }

                    .a-modal-header {
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        margin-bottom: 1.5rem;
                        padding-bottom: 1rem;
                        border-bottom: 1px solid var(--border);
                    }

                    .a-modal-title {
                        font-size: 1.1rem;
                        font-weight: 800;
                    }

                    .a-modal-close {
                        width: 32px;
                        height: 32px;
                        border-radius: 50%;
                        border: 1px solid var(--border);
                        background: transparent;
                        cursor: pointer;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1rem;
                        color: var(--text-secondary);
                        transition: var(--transition);
                    }

                    .a-modal-close:hover {
                        background: var(--accent);
                        color: #fff;
                        border-color: var(--accent);
                    }

                    .form-row {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 1rem;
                    }

                    @media(max-width:768px) {
                        .a-sidebar {
                            display: none;
                        }

                        .a-main {
                            padding: 1.2rem;
                        }

                        .form-row {
                            grid-template-columns: 1fr;
                        }
                    }
                </style>
            </head>

            <body>
                <%@ include file="header.jsp" %>

                    <div class="admin-wrap">

                        <!-- ── SIDEBAR ── -->
                        <aside class="a-sidebar">

                            <div class="a-sidebar-section">Menu chính</div>
                            <ul class="a-nav">
                                <li><a href="${pageContext.request.contextPath}/admin"
                                        class="${tab eq 'dashboard' ? 'active' : ''}">
                                        <span class="nav-icon">📊</span> Dashboard
                                    </a></li>
                                <li><a href="${pageContext.request.contextPath}/admin?tab=products"
                                        class="${tab eq 'products' ? 'active' : ''}">
                                        <span class="nav-icon">📦</span> Sản phẩm
                                    </a></li>
                                <li><a href="${pageContext.request.contextPath}/admin?tab=orders"
                                        class="${tab eq 'orders' ? 'active' : ''}">
                                        <span class="nav-icon">🧾</span> Đơn hàng
                                    </a></li>
                                <li><a href="${pageContext.request.contextPath}/admin?tab=users"
                                        class="${tab eq 'users' ? 'active' : ''}">
                                        <span class="nav-icon">👥</span> Người dùng
                                    </a></li>
                            </ul>

                            <div class="a-sidebar-bottom">
                                <ul class="a-nav">
                                    <li><a href="${pageContext.request.contextPath}/logout">
                                            <span class="nav-icon">🚪</span> Đăng xuất
                                        </a></li>
                                </ul>
                            </div>
                        </aside>

                        <!-- ── MAIN CONTENT ── -->
                        <main class="a-main">

                            <!-- ===== DASHBOARD ===== -->
                            <c:if test="${tab eq 'dashboard'}">
                                <div class="a-page-header">
                                    <div class="a-page-title">📊 Dashboard <span>Overview</span></div>
                                    <div style="font-size:.85rem;color:var(--text-secondary)">Cập nhật mỗi lần tải trang
                                    </div>
                                </div>

                                <% Long _rev=(Long) request.getAttribute("totalRevenue"); Long _thisMonth=(Long)
                                    request.getAttribute("revenueThisMonth"); Long _lastMonth=(Long)
                                    request.getAttribute("revenueLastMonth"); long rev=_rev !=null ? _rev : 0L; long
                                    thisMonth=_thisMonth !=null ? _thisMonth : 0L; long lastMonth=_lastMonth !=null ?
                                    _lastMonth : 0L; long diff=thisMonth - lastMonth; String revFmt=String.format("%,d",
                                    rev).replace(",", "." ) + "đ" ; String thisMonthFmt=String.format("%,d",
                                    thisMonth).replace(",", "." ) + "đ" ; String lastMonthFmt=String.format("%,d",
                                    lastMonth).replace(",", "." ) + "đ" ; String diffSign=diff>= 0 ? "+" : "";
                                    String diffFmt = diffSign + String.format("%,d", diff).replace(",", ".") + "đ";
                                    String diffClass = diff >= 0 ? "up" : "down";
                                    String diffArrow = diff >= 0 ? "↑" : "↓";
                                    pageContext.setAttribute("revFmt", revFmt);
                                    pageContext.setAttribute("thisMonthFmt", thisMonthFmt);
                                    pageContext.setAttribute("lastMonthFmt", lastMonthFmt);
                                    pageContext.setAttribute("diffFmt", diffFmt);
                                    pageContext.setAttribute("diffClass", diffClass);
                                    pageContext.setAttribute("diffArrow", diffArrow);
                                    %>

                                    <!-- Stat Cards -->
                                    <div class="a-stat-grid">
                                        <div class="a-stat-card"
                                            style="--stat-color:#4F46E5;--stat-bg:rgba(79,70,229,.1)">
                                            <div class="a-stat-icon">📦</div>
                                            <div class="a-stat-body">
                                                <div class="a-stat-num">${totalProducts}</div>
                                                <div class="a-stat-label">Sản phẩm</div>
                                            </div>
                                        </div>
                                        <div class="a-stat-card"
                                            style="--stat-color:#06B6D4;--stat-bg:rgba(6,182,212,.1)">
                                            <div class="a-stat-icon">🧾</div>
                                            <div class="a-stat-body">
                                                <div class="a-stat-num">${totalOrders}</div>
                                                <div class="a-stat-label">Tổng đơn hàng</div>
                                            </div>
                                        </div>
                                        <div class="a-stat-card"
                                            style="--stat-color:#F59E0B;--stat-bg:rgba(245,158,11,.1)">
                                            <div class="a-stat-icon">📅</div>
                                            <div class="a-stat-body">
                                                <div class="a-stat-num">${ordersThisMonth}</div>
                                                <div class="a-stat-label">Đơn tháng này</div>
                                            </div>
                                        </div>
                                        <div class="a-stat-card"
                                            style="--stat-color:#10B981;--stat-bg:rgba(16,185,129,.1)">
                                            <div class="a-stat-icon">👥</div>
                                            <div class="a-stat-body">
                                                <div class="a-stat-num">${totalUsers}</div>
                                                <div class="a-stat-label">Người dùng</div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Revenue Cards -->
                                    <div class="a-rev-grid">
                                        <div class="a-rev-card">
                                            <div class="a-rev-label">💰 Tổng doanh thu (đã giao)</div>
                                            <div class="a-rev-num" style="color:var(--primary)">${revFmt}</div>
                                            <span class="a-rev-badge neutral">Toàn thời gian</span>
                                        </div>
                                        <div class="a-rev-card">
                                            <div class="a-rev-label">📈 Doanh thu tháng này</div>
                                            <div class="a-rev-num" style="color:#10B981">${thisMonthFmt}</div>
                                            <span class="a-rev-badge ${diffClass}">${diffArrow} ${diffFmt} so với tháng
                                                trước</span>
                                        </div>
                                        <div class="a-rev-card">
                                            <div class="a-rev-label">📉 Doanh thu tháng trước</div>
                                            <div class="a-rev-num" style="color:var(--secondary)">${lastMonthFmt}</div>
                                            <span class="a-rev-badge neutral">Tháng trước</span>
                                        </div>
                                    </div>

                                    <!-- Top Products -->
                                    <div class="a-card">
                                        <div class="a-card-header">
                                            <div class="a-card-title">🏆 Top 5 sản phẩm bán chạy nhất</div>
                                        </div>
                                        <div style="overflow-x:auto">
                                            <table class="a-table">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Sản phẩm</th>
                                                        <th>Số lượng bán</th>
                                                        <th>Doanh thu</th>
                                                        <th>Tỷ lệ doanh thu</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="tp" items="${topProducts}" varStatus="s">
                                                        <% java.util.Map<?,?> tpMap = (java.util.Map
                                                            <?,?>) pageContext.getAttribute("tp");
                                                            long tpRevenue = tpMap.get("total_revenue") != null ?
                                                            ((Number)tpMap.get("total_revenue")).longValue() : 0;
                                                            long tpQty = tpMap.get("total_qty") != null ?
                                                            ((Number)tpMap.get("total_qty")).longValue() : 0;
                                                            String tpRevFmt = String.format("%,d",
                                                            tpRevenue).replace(",", ".") + "đ";
                                                            Long _totalRevForPct = (Long)
                                                            request.getAttribute("totalRevenue");
                                                            long totalRevForPct = _totalRevForPct != null ?
                                                            _totalRevForPct : 0L;
                                                            int pct = totalRevForPct > 0 ? (int)(tpRevenue * 100 /
                                                            totalRevForPct) : 0;
                                                            pageContext.setAttribute("tpRevFmt", tpRevFmt);
                                                            pageContext.setAttribute("tpQty", tpQty);
                                                            pageContext.setAttribute("pct", pct);
                                                            %>
                                                            <tr>
                                                                <td><span
                                                                        style="background:linear-gradient(135deg,var(--primary),var(--secondary));color:#fff;width:28px;height:28px;display:inline-flex;align-items:center;justify-content:center;border-radius:50%;font-weight:800;font-size:.85rem">${s.index
                                                                        + 1}</span></td>
                                                                <td style="font-weight:700">${tp.product_name}</td>
                                                                <td><span
                                                                        style="background:rgba(79,70,229,.1);color:var(--primary);padding:4px 12px;border-radius:20px;font-weight:700;font-size:.85rem">${tpQty}
                                                                        sản phẩm</span></td>
                                                                <td style="font-weight:700;color:#10B981">${tpRevFmt}
                                                                </td>
                                                                <td>
                                                                    <div class="progress-bar">
                                                                        <div class="progress-track">
                                                                            <div class="progress-fill"
                                                                                style="width:${pct}%"></div>
                                                                        </div>
                                                                        <span
                                                                            style="font-size:.8rem;color:var(--text-secondary);font-weight:700;white-space:nowrap">${pct}%</span>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty topProducts}">
                                                        <tr>
                                                            <td colspan="5"
                                                                style="text-align:center;padding:3rem;color:var(--text-secondary)">
                                                                📦 Chưa có đơn hàng nào được giao</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <!-- Quick Actions -->
                                    <div style="display:flex;gap:1rem;flex-wrap:wrap">
                                        <a href="?tab=products" class="btn btn-primary">📦 Quản lý sản phẩm</a>
                                        <a href="?tab=orders" class="btn btn-secondary">🧾 Quản lý đơn hàng</a>
                                        <a href="?tab=users" class="btn btn-secondary">👥 Quản lý người dùng</a>
                                    </div>
                            </c:if>

                            <!-- ===== PRODUCTS ===== -->
                            <c:if test="${tab eq 'products'}">
                                <div class="a-page-header">
                                    <div class="a-page-title">📦 Sản phẩm <span>(${totalProducts})</span></div>
                                    <button class="btn btn-primary" onclick="showModal('addModal')">➕ Thêm sản
                                        phẩm</button>
                                </div>
                                <div class="a-card">
                                    <div style="overflow-x:auto">
                                        <table class="a-table">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
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
                                                    <tr>
                                                        <td style="color:var(--text-secondary);font-size:.85rem">
                                                            #${p.id}</td>
                                                        <td>
                                                            <div class="prod-cell">
                                                                <div class="prod-emoji">${p.emoji}</div>
                                                                <div>
                                                                    <div class="prod-name">${p.name}</div>
                                                                    <div class="prod-brand">${p.brand}</div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td><span
                                                                style="background:rgba(79,70,229,.08);color:var(--primary);padding:3px 10px;border-radius:20px;font-size:.8rem;font-weight:600">${p.category}</span>
                                                        </td>
                                                        <td style="font-weight:700;color:var(--primary)">
                                                            ${p.formattedPrice}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${p.stock > 5}"><span class="stock-ok">✓
                                                                        ${p.stock}</span></c:when>
                                                                <c:otherwise><span class="stock-low">⚠️
                                                                        ${p.stock}</span></c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:if test="${not empty p.badge}">
                                                                <span class="product-badge badge-${p.badge}"
                                                                    style="position:static;border:none">${p.badge}</span>
                                                            </c:if>
                                                            <c:if test="${empty p.badge}"><span
                                                                    style="color:var(--text-secondary)">—</span></c:if>
                                                        </td>
                                                        <td>
                                                            <div style="display:flex;gap:.5rem">
                                                                <button class="btn btn-secondary btn-sm edit-btn"
                                                                    data-id="${p.id}" data-name="${p.name}"
                                                                    data-category="${p.category}"
                                                                    data-brand="${p.brand}" data-price="${p.price}"
                                                                    data-oldprice="${p.oldPrice}"
                                                                    data-emoji="${p.emoji}" data-badge="${p.badge}"
                                                                    data-stock="${p.stock}" data-desc="${p.description}"
                                                                    data-specs="${p.specs}">✏️ Sửa</button>
                                                                <form method="post"
                                                                    action="${pageContext.request.contextPath}/admin"
                                                                    onsubmit="return confirm('Xóa sản phẩm này?')">
                                                                    <input type="hidden" name="action"
                                                                        value="deleteProduct" />
                                                                    <input type="hidden" name="id" value="${p.id}" />
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

                            <!-- ===== ORDERS ===== -->
                            <c:if test="${tab eq 'orders'}">
                                <div class="a-page-header">
                                    <div class="a-page-title">🧾 Đơn hàng <span>(${totalOrders})</span></div>
                                </div>
                                <div class="a-card">
                                    <div style="overflow-x:auto">
                                        <table class="a-table">
                                            <thead>
                                                <tr>
                                                    <th>Mã ĐH</th>
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
                                                        <td><span
                                                                style="font-weight:700;color:var(--primary)">#${o.id}</span>
                                                        </td>
                                                        <td>
                                                            <div style="font-weight:600">${o.fullName}</div>
                                                            <div style="font-size:.78rem;color:var(--text-secondary)">📞
                                                                ${o.phone}</div>
                                                        </td>
                                                        <td
                                                            style="font-size:.82rem;max-width:180px;color:var(--text-secondary)">
                                                            ${o.address}</td>
                                                        <td style="font-weight:700;color:#10B981">${o.formattedTotal}
                                                        </td>
                                                        <td style="font-size:.82rem;color:var(--text-secondary)">
                                                            ${o.createdAt}</td>
                                                        <td><span
                                                                class="status-badge status-${o.status}">${o.statusLabel}</span>
                                                        </td>
                                                        <td>
                                                            <form method="post"
                                                                action="${pageContext.request.contextPath}/admin"
                                                                style="display:flex;gap:.4rem;align-items:center">
                                                                <input type="hidden" name="action"
                                                                    value="updateOrderStatus" />
                                                                <input type="hidden" name="id" value="${o.id}" />
                                                                <select name="status" class="form-control"
                                                                    style="width:auto;padding:5px 10px;font-size:.82rem">
                                                                    <option value="pending" ${o.status eq 'pending'
                                                                        ? 'selected' : '' }>⏳ Chờ xác nhận</option>
                                                                    <option value="processing" ${o.status
                                                                        eq 'processing' ? 'selected' : '' }>🔄 Đang xử
                                                                        lý</option>
                                                                    <option value="delivered" ${o.status eq 'delivered'
                                                                        ? 'selected' : '' }>✅ Đã giao</option>
                                                                    <option value="cancelled" ${o.status eq 'cancelled'
                                                                        ? 'selected' : '' }>❌ Đã hủy</option>
                                                                </select>
                                                                <button type="submit"
                                                                    class="btn btn-success btn-sm">Lưu</button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:if>

                            <!-- ===== USERS ===== -->
                            <c:if test="${tab eq 'users'}">
                                <div class="a-page-header">
                                    <div class="a-page-title">👥 Người dùng <span>(${totalUsers})</span></div>
                                </div>
                                <div class="a-card">
                                    <div style="overflow-x:auto">
                                        <table class="a-table">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Tên</th>
                                                    <th>Email</th>
                                                    <th>Số điện thoại</th>
                                                    <th>Vai trò</th>
                                                    <th>Ngày tạo</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="u" items="${users}">
                                                    <tr>
                                                        <td style="color:var(--text-secondary)">#${u.id}</td>
                                                        <td>
                                                            <div style="display:flex;align-items:center;gap:10px">
                                                                <div
                                                                    style="width:36px;height:36px;border-radius:50%;background:linear-gradient(135deg,var(--primary),var(--secondary));display:flex;align-items:center;justify-content:center;font-weight:800;color:#fff;font-size:.9rem;flex-shrink:0">
                                                                    ${u.initial}</div>
                                                                <span style="font-weight:600">${u.name}</span>
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
                                                        <td style="font-size:.82rem;color:var(--text-secondary)">
                                                            ${u.createdAt}</td>
                                                        <td>
                                                            <c:if test="${!u.admin}">
                                                                <form method="post"
                                                                    action="${pageContext.request.contextPath}/admin"
                                                                    onsubmit="return confirm('Xóa người dùng này?')">
                                                                    <input type="hidden" name="action"
                                                                        value="deleteUser" />
                                                                    <input type="hidden" name="id" value="${u.id}" />
                                                                    <button type="submit"
                                                                        class="btn btn-danger btn-sm">🗑️ Xóa</button>
                                                                </form>
                                                            </c:if>
                                                            <c:if test="${u.admin}"><span
                                                                    style="color:var(--text-secondary);font-size:.82rem">Không
                                                                    thể xóa</span></c:if>
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

                    <!-- ===== MODAL: ADD PRODUCT ===== -->
                    <div class="a-modal-overlay" id="addModal">
                        <div class="a-modal">
                            <div class="a-modal-header">
                                <div class="a-modal-title">➕ Thêm sản phẩm mới</div>
                                <button class="a-modal-close" onclick="hideModal('addModal')">✕</button>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/admin">
                                <input type="hidden" name="action" value="addProduct" />
                                <div class="form-group">
                                    <label class="form-label">Tên sản phẩm *</label>
                                    <input class="form-control" type="text" name="name" required
                                        placeholder="iPhone 15 Pro Max" />
                                </div>
                                <div class="form-row">
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
                                <div class="form-row">
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
                                <div class="form-row">
                                    <div class="form-group">
                                        <label class="form-label">Tồn kho</label>
                                        <input class="form-control" type="number" name="stock" value="10" />
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
                                        <option value="">Không có</option>
                                        <option value="sale">SALE</option>
                                        <option value="new">MỚI</option>
                                        <option value="hot">HOT</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Mô tả ngắn</label>
                                    <textarea class="form-control" name="description" rows="2"
                                        placeholder="Mô tả ngắn về sản phẩm"></textarea>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Thông số (Key: Value|Key: Value)</label>
                                    <textarea class="form-control" name="specs" rows="2"
                                        placeholder="Chip: A17 Pro|RAM: 8GB|Bộ nhớ: 256GB"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary"
                                    style="width:100%;justify-content:center;margin-top:.5rem">➕ Thêm sản phẩm</button>
                            </form>
                        </div>
                    </div>

                    <!-- ===== MODAL: EDIT PRODUCT ===== -->
                    <div class="a-modal-overlay" id="editModal">
                        <div class="a-modal">
                            <div class="a-modal-header">
                                <div class="a-modal-title">✏️ Chỉnh sửa sản phẩm</div>
                                <button class="a-modal-close" onclick="hideModal('editModal')">✕</button>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/admin">
                                <input type="hidden" name="action" value="editProduct" />
                                <input type="hidden" name="id" id="editId" />
                                <div class="form-group">
                                    <label class="form-label">Tên sản phẩm *</label>
                                    <input class="form-control" type="text" name="name" id="editName" required />
                                </div>
                                <div class="form-row">
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
                                <div class="form-row">
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
                                <div class="form-row">
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
                                        <option value="">Không có</option>
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
                                    style="width:100%;justify-content:center;margin-top:.5rem">💾 Lưu thay đổi</button>
                            </form>
                        </div>
                    </div>

                    <script>
                        function showModal(id) { document.getElementById(id).classList.add('show'); }
                        function hideModal(id) { document.getElementById(id).classList.remove('show'); }
                        document.querySelectorAll('.a-modal-overlay').forEach(m => m.addEventListener('click', e => {
                            if (e.target === m) m.classList.remove('show');
                        }));

                        // Edit product – uses data-* attributes to avoid JS string escaping issues
                        document.addEventListener('click', function (e) {
                            const btn = e.target.closest('.edit-btn');
                            if (!btn) return;
                            const d = btn.dataset;
                            document.getElementById('editId').value = d.id;
                            document.getElementById('editName').value = d.name;
                            document.getElementById('editBrand').value = d.brand;
                            document.getElementById('editPrice').value = d.price;
                            document.getElementById('editOldPrice').value = d.oldprice || '';
                            document.getElementById('editEmoji').value = d.emoji || '';
                            document.getElementById('editStock').value = d.stock;
                            document.getElementById('editDesc').value = d.desc || '';
                            document.getElementById('editSpecs').value = d.specs || '';
                            const catSel = document.getElementById('editCategory');
                            for (let o of catSel.options) if (o.value === d.category || o.text === d.category) { o.selected = true; break; }
                            const bdgSel = document.getElementById('editBadge');
                            for (let o of bdgSel.options) if (o.value === d.badge) { o.selected = true; break; }
                            showModal('editModal');
                        });
                    </script>
            </body>

            </html>