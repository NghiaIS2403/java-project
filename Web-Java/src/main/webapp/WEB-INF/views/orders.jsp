<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width,initial-scale=1.0" />
            <title>Đơn hàng của tôi – TechZone</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=2" />
        </head>

        <body>
            <%@ include file="header.jsp" %>

                <section class="section">
                    <h1 class="section-title" style="margin-bottom:2rem">📋 Đơn hàng của tôi</h1>

                    <c:if test="${not empty successOrderId}">
                        <div
                            style="background:rgba(0,184,148,.1);border:1px solid rgba(0,184,148,.3);border-radius:var(--radius-sm);padding:16px 20px;color:#00b894;margin-bottom:1.5rem;display:flex;align-items:center;gap:12px">
                            <span style="font-size:1.5rem">🎉</span>
                            <span><strong>Đặt hàng thành công!</strong> Mã đơn hàng #${successOrderId}. Chúng tôi sẽ
                                liên hệ xác nhận sớm nhất.</span>
                        </div>
                    </c:if>

                    <c:choose>
                        <c:when test="${empty orders}">
                            <div class="glass-card" style="text-align:center;padding:4rem">
                                <div style="font-size:5rem;margin-bottom:1rem">📦</div>
                                <h3 style="margin-bottom:.5rem">Chưa có đơn hàng nào</h3>
                                <p style="color:var(--text-secondary);margin-bottom:1.5rem">Hãy mua sắm ngay!</p>
                                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">🛍️ Mua ngay</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="order" items="${orders}">
                                <div class="glass-card" style="margin-bottom:1.5rem">
                                    <!-- Order Header -->
                                    <div
                                        style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:1rem;margin-bottom:1rem;padding-bottom:1rem;border-bottom:1px solid var(--border)">
                                        <div>
                                            <div style="font-size:1rem;font-weight:700">Đơn hàng #${order.id}</div>
                                            <div style="font-size:.82rem;color:var(--text-secondary)">${order.createdAt}
                                                · ${order.fullName} · ${order.phone}</div>
                                            <div style="font-size:.82rem;color:var(--text-secondary)">📍
                                                ${order.address}</div>
                                        </div>
                                        <div style="display:flex;align-items:center;gap:1rem">
                                            <span
                                                class="status-badge status-${order.status}">${order.statusLabel}</span>
                                            <span
                                                style="font-size:1.1rem;font-weight:800;color:var(--primary)">${order.formattedTotal}</span>
                                        </div>
                                    </div>
                                    <!-- Order Items -->
                                    <c:forEach var="item" items="${order.items}">
                                        <div
                                            style="display:flex;justify-content:space-between;align-items:center;padding:6px 0;font-size:.9rem">
                                            <span>${item.productName} <span
                                                    style="color:var(--text-secondary)">×${item.quantity}</span></span>
                                            <span style="font-weight:600">${item.formattedSubtotal}</span>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </section>

                <%@ include file="footer.jsp" %>
        </body>

        </html>