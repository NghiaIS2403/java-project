<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <% com.techzone.model.User cu=(com.techzone.model.User) session.getAttribute("currentUser"); // Đếm giỏ hàng
      java.util.List<?> cartSession = (java.util.List
      <?>) session.getAttribute("cart");
    int cartCount = 0;
    if (cartSession != null) {
        for (Object item : cartSession) {
            com.techzone.model.CartItem ci = (com.techzone.model.CartItem) item;
            cartCount += ci.getQuantity();
        }
    }
    String ctx = request.getContextPath();
%>
<script>
  if (localStorage.getItem('theme') === 'dark') {
    document.documentElement.classList.add('dark-mode');
  }
  function toggleTheme() {
    document.documentElement.classList.toggle('dark-mode');
    const isDark = document.documentElement.classList.contains('dark-mode');
    localStorage.setItem('theme', isDark ? 'dark' : 'light');
    document.getElementById('theme-toggle').innerHTML = isDark ? '🌞' : '🌙';
  }
</script>
<nav class="navbar">
  <a href="<%= ctx %>/" class="navbar-brand">
    <div class="brand-icon">⚡</div>
    Tech<span>Zone</span>
  </a>

  <form class="search-bar" action="<%= ctx %>/" method="get">
    <input type="text" name="search" placeholder="Tìm kiếm sản phẩm..." value="${param.search}"/>
    <button type="submit">🔍</button>
  </form>

  <button id="theme-toggle" class="btn-icon" onclick="toggleTheme()" title="Đổi giao diện" style="margin-left: 1rem;">
    <script>document.write(localStorage.getItem('theme') === 'dark' ? '🌞' : '🌙')</script>
  </button>

  <ul class="nav-links">
    <% if (cu == null || !cu.isAdmin()) { %>
    <li><a href="<%= ctx %>/#products">📦 Sản phẩm</a></li>
    <% if (cu != null) { %>
    <li><a href="<%= ctx %>/orders">📋 Đơn hàng</a></li>
    <% } %>
    <% } %>
  </ul>

  <div class="nav-actions">
    <% if (cu == null || !cu.isAdmin()) { %>
    <a href="<%= ctx %>/cart" class="btn-icon" title="Giỏ hàng" style="text-decoration:none;display:flex;align-items:center;justify-content:center">
      🛒
      <% if (cartCount > 0) { %><span class="badge cart-badge"><%= cartCount %></span><% } %>
    </a>
    <% } %>

    <% if (cu != null) { %>
    <div class="user-menu">
      <div class="user-avatar" onclick="this.closest('.user-menu').classList.toggle('active')">
        <%= cu.getInitial() %>
      </div>
      <div class="user-dropdown">
        <div style="padding:10px 12px;border-bottom:1px solid var(--border);margin-bottom:4px;">
          <div style="font-weight:600;font-size:.9rem"><%= cu.getName() %></div>
          <div style="font-size:.78rem;color:var(--text-secondary)"><%= cu.getEmail() %></div>
        </div>
        <a class="dropdown-item" href="<%= ctx %>/orders">📋 Đơn hàng của tôi</a>
        <% if (cu.isAdmin()) { %>
        <a class="dropdown-item" href="<%= ctx %>/admin">🛠️ Quản lý Admin</a>
        <% } %>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item" href="<%= ctx %>/logout">🚪 Đăng xuất</a>
      </div>
    </div>
    <% } else { %>
    <a href="<%= ctx %>/login" class="btn btn-primary btn-sm">Đăng nhập</a>
    <% } %>
  </div>
</nav>