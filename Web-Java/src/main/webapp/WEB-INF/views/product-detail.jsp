<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width,initial-scale=1.0" />
            <title>${product.name} – TechZone</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=2" />
            <style>
                .specs-list {
                    background: var(--bg-card);
                    border: 1px solid var(--border);
                    border-radius: var(--radius);
                    overflow: hidden;
                    margin-bottom: 1.5rem;
                }

                .spec-row {
                    display: flex;
                    border-bottom: 1px solid var(--border);
                }

                .spec-row:last-child {
                    border-bottom: none;
                }

                .spec-label {
                    padding: 10px 16px;
                    background: var(--bg-card2);
                    font-size: .85rem;
                    font-weight: 600;
                    width: 140px;
                    flex-shrink: 0;
                    color: var(--text-secondary);
                }

                .spec-value {
                    padding: 10px 16px;
                    font-size: .85rem;
                }

                .qty-row {
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                    margin-bottom: 1.5rem;
                }

                .qty-btn {
                    width: 38px;
                    height: 38px;
                    background: var(--glass);
                    border: 1px solid var(--border);
                    border-radius: var(--radius-sm);
                    color: var(--text-primary);
                    font-size: 1.2rem;
                    cursor: pointer;
                    transition: var(--transition);
                }

                .qty-btn:hover {
                    border-color: var(--primary);
                }

                .qty-input {
                    width: 60px;
                    text-align: center;
                    background: var(--glass);
                    border: 1px solid var(--border);
                    border-radius: var(--radius-sm);
                    color: var(--text-primary);
                    padding: 8px;
                    font-size: 1rem;
                    font-family: 'Inter', sans-serif;
                }
            </style>
        </head>

        <body>
            <%@ include file="header.jsp" %>

                <section class="section">
                    <!-- Breadcrumb -->
                    <div style="font-size:.85rem;color:var(--text-secondary);margin-bottom:2rem">
                        <a href="${pageContext.request.contextPath}/"
                            style="color:var(--text-secondary);text-decoration:none">Trang chủ</a>
                        &nbsp;›&nbsp;
                        <a href="?category=${product.category}"
                            style="color:var(--text-secondary);text-decoration:none">${product.category}</a>
                        &nbsp;›&nbsp;
                        <span style="color:var(--text-primary)">${product.name}</span>
                    </div>

                    <div class="product-detail-grid">
                        <!-- Gallery -->
                        <div class="product-gallery">${product.emoji}</div>

                        <!-- Info -->
                        <div>
                            <div
                                style="font-size:.78rem;font-weight:700;text-transform:uppercase;letter-spacing:.8px;color:var(--primary);margin-bottom:.4rem">
                                ${product.category} · ${product.brand}
                                <c:if test="${not empty product.badge}">
                                    &nbsp;<span class="product-badge badge-${product.badge}"
                                        style="position:static;display:inline-flex">
                                        <c:choose>
                                            <c:when test="${product.badge eq 'sale'}">SALE ${product.discountPercent}%
                                            </c:when>
                                            <c:when test="${product.badge eq 'new'}">MỚI</c:when>
                                            <c:otherwise>HOT</c:otherwise>
                                        </c:choose>
                                    </span>
                                </c:if>
                            </div>

                            <h1 class="product-detail-name">${product.name}</h1>

                            <div class="product-rating" style="margin:.5rem 0">
                                <span class="stars">★★★★★</span>
                                <span class="rating-count">${product.rating} · ${product.reviews} đánh giá</span>
                                <c:choose>
                                    <c:when test="${product.stock gt 0}">
                                        <span style="font-size:.82rem;color:#00b894">✓ Còn hàng
                                            (${product.stock})</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="font-size:.82rem;color:#ff6b6b">✗ Hết hàng</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="product-detail-price">
                                ${product.formattedPrice}
                                <c:if test="${product.oldPrice > 0}">
                                    <span
                                        style="font-size:1rem;font-weight:400;color:var(--text-secondary);text-decoration:line-through">
                                        ${product.formattedOldPrice}</span>
                                    <span style="font-size:1rem;color:var(--accent);font-weight:700">
                                        -${product.discountPercent}%</span>
                                </c:if>
                            </div>

                            <p class="product-detail-desc">${product.description}</p>

                            <!-- Specs -->
                            <c:if test="${not empty product.specs}">
                                <div class="specs-list">
                                    <c:forTokens items="${product.specs}" delims="|" var="spec">
                                        <c:set var="parts" value="${spec}" />
                                        <div class="spec-row">
                                            <% String spec=(String) pageContext.getAttribute("spec"); String[]
                                                parts=spec !=null ? spec.split(":") : new String[]{"","?"};
                                                pageContext.setAttribute("specKey", parts.length> 0 ? parts[0].trim() :
                                                "");
                                                pageContext.setAttribute("specVal", parts.length > 1 ? parts[1].trim() :
                                                "?");
                                                %>
                                                <div class="spec-label">${specKey}</div>
                                                <div class="spec-value">${specVal}</div>
                                        </div>
                                    </c:forTokens>
                                </div>
                            </c:if>

                            <!-- Quantity + Add to cart -->
                            <form method="post" action="${pageContext.request.contextPath}/cart">
                                <input type="hidden" name="action" value="add" />
                                <input type="hidden" name="productId" value="${product.id}" />
                                <input type="hidden" name="redirect" value="${pageContext.request.contextPath}/cart" />
                                <div class="qty-row">
                                    <label style="font-weight:600">Số lượng:</label>
                                    <button type="button" class="qty-btn" onclick="changeQty(-1)">−</button>
                                    <input type="number" name="qty" id="qtyInput" class="qty-input" value="1" min="1"
                                        max="${product.stock}" />
                                    <button type="button" class="qty-btn" onclick="changeQty(1)">+</button>
                                    <span style="font-size:.85rem;color:var(--text-secondary)">Còn ${product.stock} sản
                                        phẩm</span>
                                </div>
                                <div style="display:flex;gap:1rem;flex-wrap:wrap">
                                    <c:choose>
                                        <c:when test="${product.stock gt 0}">
                                            <button type="submit" class="btn btn-primary btn-lg">🛒 Thêm vào giỏ
                                                hàng</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-primary btn-lg" disabled>🛒 Hết
                                                hàng</button>
                                        </c:otherwise>
                                    </c:choose>
                                    <a href="${pageContext.request.contextPath}/cart"
                                        class="btn btn-secondary btn-lg">Xem giỏ hàng</a>
                                </div>
                            </form>

                            <!-- Features -->
                            <div style="display:flex;gap:1rem;flex-wrap:wrap;margin-top:1.5rem">
                                <div
                                    style="display:flex;align-items:center;gap:6px;font-size:.82rem;color:var(--text-secondary)">
                                    🚚 Giao hàng nhanh 2–4h</div>
                                <div
                                    style="display:flex;align-items:center;gap:6px;font-size:.82rem;color:var(--text-secondary)">
                                    🛡️ Bảo hành 12 tháng</div>
                                <div
                                    style="display:flex;align-items:center;gap:6px;font-size:.82rem;color:var(--text-secondary)">
                                    🔄 Đổi trả 30 ngày</div>
                            </div>
                        </div>
                    </div>
                </section>

                <%@ include file="footer.jsp" %>
                    <script>
                        function changeQty(delta) {
                            const inp = document.getElementById('qtyInput');
                            let v = parseInt(inp.value) + delta;
                            const maxStock = parseInt('${product.stock}');
                            inp.value = Math.max(1, Math.min(maxStock, v));
                        }
                    </script>
        </body>

        </html>