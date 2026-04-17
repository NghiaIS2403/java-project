<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width,initial-scale=1.0" />
            <title>Giỏ hàng – TechZone</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=2" />
        </head>

        <body>
            <%@ include file="header.jsp" %>

                <section class="section">
                    <h1 class="section-title" style="margin-bottom:2rem">🛒 Giỏ hàng</h1>

                    <c:choose>
                        <c:when test="${empty cart}">
                            <div class="glass-card" style="text-align:center;padding:4rem">
                                <div style="font-size:5rem;margin-bottom:1rem">🛒</div>
                                <h3 style="font-size:1.3rem;margin-bottom:.5rem">Giỏ hàng trống</h3>
                                <p style="color:var(--text-secondary);margin-bottom:1.5rem">Hãy thêm sản phẩm vào giỏ
                                    hàng</p>
                                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">🛍️ Tiếp tục mua
                                    sắm</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="checkout-grid">
                                <!-- Cart Items -->
                                <div>
                                    <c:forEach var="item" items="${cart}">
                                        <c:if test="${not empty item.product}">
                                            <div class="glass-card"
                                                style="display:flex;gap:1.5rem;align-items:center;margin-bottom:1rem;flex-wrap:wrap">
                                                <div
                                                    style="font-size:3.5rem;width:80px;height:80px;background:var(--bg-card2);border-radius:12px;display:flex;align-items:center;justify-content:center;flex-shrink:0">
                                                    ${item.product.emoji}
                                                </div>
                                                <div style="flex:1;min-width:200px">
                                                    <a href="${pageContext.request.contextPath}/product?id=${item.productId}"
                                                        style="font-weight:600;text-decoration:none;color:var(--text-primary)">${item.product.name}</a>
                                                    <div style="font-size:.82rem;color:var(--text-secondary)">
                                                        ${item.product.category} · ${item.product.brand}</div>
                                                    <div
                                                        style="font-size:1rem;font-weight:700;color:var(--primary);margin-top:.3rem">
                                                        ${item.product.formattedPrice}</div>
                                                </div>
                                                <!-- Qty update -->
                                                <form method="post" action="${pageContext.request.contextPath}/cart"
                                                    style="display:flex;align-items:center;gap:.6rem">
                                                    <input type="hidden" name="action" value="update" />
                                                    <input type="hidden" name="productId" value="${item.productId}" />
                                                    <button type="button" class="qty-btn"
                                                        style="width:30px;height:30px;background:var(--glass);border:1px solid var(--border);border-radius:6px;cursor:pointer;color:var(--text-primary)"
                                                        onclick="this.form.querySelector('[name=qty]').value=Math.max(1,parseInt(this.form.querySelector('[name=qty]').value)-1)">−</button>
                                                    <input type="number" name="qty" value="${item.quantity}" min="1"
                                                        max="${item.product.stock}"
                                                        style="width:50px;text-align:center;background:var(--glass);border:1px solid var(--border);border-radius:6px;color:var(--text-primary);padding:5px;font-family:'Inter',sans-serif" />
                                                    <button type="button" class="qty-btn"
                                                        style="width:30px;height:30px;background:var(--glass);border:1px solid var(--border);border-radius:6px;cursor:pointer;color:var(--text-primary)"
                                                        onclick="this.form.querySelector('[name=qty]').value=Math.min(${item.product.stock},parseInt(this.form.querySelector('[name=qty]').value)+1)">+</button>
                                                    <button type="submit" class="btn btn-secondary btn-sm">Cập
                                                        nhật</button>
                                                </form>
                                                <div
                                                    style="font-weight:700;color:var(--primary);min-width:110px;text-align:right">
                                                    ${item.formattedSubtotal}</div>
                                                <!-- Remove -->
                                                <form method="post" action="${pageContext.request.contextPath}/cart">
                                                    <input type="hidden" name="action" value="remove" />
                                                    <input type="hidden" name="productId" value="${item.productId}" />
                                                    <button type="submit"
                                                        style="background:none;border:none;color:var(--text-secondary);cursor:pointer;font-size:1.2rem"
                                                        title="Xóa">🗑️</button>
                                                </form>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                    <form method="post" action="${pageContext.request.contextPath}/cart"
                                        style="margin-top:1rem">
                                        <input type="hidden" name="action" value="clear" />
                                        <button type="submit" class="btn btn-danger btn-sm">🗑️ Xóa tất cả</button>
                                    </form>
                                </div>

                                <!-- Order Summary -->
                                <div class="order-summary">
                                    <div class="order-summary-title">📋 Tóm tắt đơn hàng</div>
                                    <c:forEach var="item" items="${cart}">
                                        <c:if test="${not empty item.product}">
                                            <div class="summary-item">
                                                <span>${item.product.name} ×${item.quantity}</span>
                                                <span>${item.formattedSubtotal}</span>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                    <div class="summary-item"
                                        style="padding-top:8px;margin-top:4px;border-top:1px solid var(--border)">
                                        <span>Phí vận chuyển</span><span style="color:#00b894">Miễn phí</span>
                                    </div>
                                    <% long total=(Long) request.getAttribute("total"); String
                                        formatted=String.format("%,d", total).replace(",", "." ) + "đ" ;
                                        pageContext.setAttribute("formattedTotal", formatted); %>
                                        <div class="summary-total">
                                            <span>Tổng cộng</span>
                                            <span>${formattedTotal}</span>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/checkout"
                                            class="btn btn-primary btn-lg"
                                            style="width:100%;justify-content:center;margin-top:1rem">
                                            💳 Thanh toán ngay
                                        </a>
                                        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary"
                                            style="width:100%;justify-content:center;margin-top:.6rem">
                                            ← Tiếp tục mua sắm
                                        </a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </section>

                <%@ include file="footer.jsp" %>
        </body>

        </html>