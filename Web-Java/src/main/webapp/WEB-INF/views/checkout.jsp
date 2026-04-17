<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width,initial-scale=1.0" />
            <title>Thanh toán – TechZone</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
        </head>

        <body>
            <%@ include file="header.jsp" %>

                <section class="section">
                    <h1 class="section-title" style="margin-bottom:2rem">💳 Thanh toán</h1>

                    <c:if test="${not empty error}">
                        <div
                            style="background:rgba(255,107,107,.1);border:1px solid rgba(255,107,107,.3);border-radius:var(--radius-sm);padding:12px 16px;color:#ff6b6b;margin-bottom:1.5rem">
                            ❌ ${error}</div>
                    </c:if>

                    <div class="checkout-grid">
                        <!-- Shipping Form -->
                        <div>
                            <div class="glass-card" style="margin-bottom:1.5rem">
                                <h3 style="font-size:1.1rem;font-weight:700;margin-bottom:1.5rem">📦 Thông tin giao hàng
                                </h3>
                                <form method="post" action="${pageContext.request.contextPath}/checkout"
                                    id="checkoutForm">
                                    <div class="form-group">
                                        <label class="form-label">Họ và tên người nhận *</label>
                                        <input class="form-control" type="text" name="fullName"
                                            placeholder="Nguyễn Văn A" value="${currentUser.name}" required />
                                    </div>
                                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:1rem">
                                        <div class="form-group">
                                            <label class="form-label">Số điện thoại *</label>
                                            <input class="form-control" type="tel" name="phone" placeholder="0901234567"
                                                value="${currentUser.phone}" required />
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label">Phương thức thanh toán</label>
                                            <select class="form-control" name="payment">
                                                <option value="cod">💵 Thanh toán khi nhận hàng (COD)</option>
                                                <option value="bank">🏦 Chuyển khoản ngân hàng</option>
                                                <option value="momo">💜 Ví Momo</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Địa chỉ giao hàng *</label>
                                        <input class="form-control" type="text" name="address"
                                            placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành"
                                            value="${currentUser.address}" required />
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Ghi chú đơn hàng</label>
                                        <textarea class="form-control" name="note" rows="3"
                                            placeholder="Ghi chú thêm, ví dụ: giao giờ hành chính..."></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary btn-lg"
                                        style="width:100%;justify-content:center">
                                        🎉 Đặt hàng ngay
                                    </button>
                                </form>
                            </div>
                        </div>

                        <!-- Order Summary -->
                        <div class="order-summary">
                            <div class="order-summary-title">📋 Đơn hàng của bạn</div>
                            <c:forEach var="item" items="${cart}">
                                <c:if test="${not empty item.product}">
                                    <div
                                        style="display:flex;gap:10px;align-items:center;padding:8px 0;border-bottom:1px solid var(--border)">
                                        <div style="font-size:1.8rem;width:40px;text-align:center">${item.product.emoji}
                                        </div>
                                        <div style="flex:1">
                                            <div style="font-size:.85rem;font-weight:600">${item.product.name}</div>
                                            <div style="font-size:.78rem;color:var(--text-secondary)">SL:
                                                ${item.quantity}</div>
                                        </div>
                                        <div style="font-size:.9rem;font-weight:600;color:var(--primary)">
                                            ${item.formattedSubtotal}</div>
                                    </div>
                                </c:if>
                            </c:forEach>
                            <div class="summary-item" style="margin-top:8px">
                                <span>Phí vận chuyển</span><span style="color:#00b894">Miễn phí</span>
                            </div>
                            <% long total=(Long) request.getAttribute("total"); String formatted=String.format("%,d",
                                total).replace(",", "." ) + "đ" ; pageContext.setAttribute("formattedTotal", formatted);
                                %>
                                <div class="summary-total">
                                    <span>Tổng thanh toán</span>
                                    <span>${formattedTotal}</span>
                                </div>
                                <div
                                    style="background:rgba(108,99,255,.1);border:1px solid rgba(108,99,255,.2);border-radius:var(--radius-sm);padding:12px;margin-top:1rem;font-size:.82rem;color:var(--text-secondary)">
                                    🛡️ Đơn hàng được bảo vệ bởi chính sách đổi trả 30 ngày
                                </div>
                        </div>
                    </div>
                </section>

                <%@ include file="footer.jsp" %>
        </body>

        </html>