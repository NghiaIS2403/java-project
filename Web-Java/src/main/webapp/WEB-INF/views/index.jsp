<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width,initial-scale=1.0" />
                <title>TechZone – Cửa Hàng Điện Tử Cao Cấp</title>
                <meta name="description"
                    content="Mua sắm điện tử chính hãng, giá tốt nhất. iPhone, Laptop, Tai nghe và nhiều hơn nữa." />
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
                <link rel="icon"
                    href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>⚡</text></svg>" />
            </head>

            <body>

                <%@ include file="header.jsp" %>

                    <!-- HERO -->
                    <section class="hero">
                        <div class="floating-badge">⚡ Flash Sale – Giảm đến 40%</div>
                        <h1 class="hero-title">Công Nghệ <span class="highlight">Đỉnh Cao</span><br />Giá Siêu Tốt</h1>
                        <p class="hero-subtitle">Khám phá hàng nghìn sản phẩm điện tử chính hãng. Bảo hành 12–24 tháng.
                        </p>
                        <div class="hero-actions">
                            <a href="#products" class="btn btn-primary btn-lg">🛒 Mua ngay</a>
                            <a href="#products" class="btn btn-secondary btn-lg">📱 Xem danh mục</a>
                        </div>
                        <div class="hero-stats">
                            <div class="hero-stat">
                                <div class="hero-stat-num">10K+</div>
                                <div class="hero-stat-label">Sản phẩm</div>
                            </div>
                            <div class="hero-stat">
                                <div class="hero-stat-num">50K+</div>
                                <div class="hero-stat-label">Khách hàng</div>
                            </div>
                            <div class="hero-stat">
                                <div class="hero-stat-num">99%</div>
                                <div class="hero-stat-label">Hài lòng</div>
                            </div>
                            <div class="hero-stat">
                                <div class="hero-stat-num">24/7</div>
                                <div class="hero-stat-label">Hỗ trợ</div>
                            </div>
                        </div>
                    </section>

                    <!-- FEATURES BAR -->
                    <section class="section" style="padding-top:0">
                        <div class="features-bar">
                            <div class="feature-item">
                                <div class="feature-icon">🚚</div>
                                <div class="feature-title">Giao hàng nhanh</div>
                                <div class="feature-desc">Trong 2–4 giờ nội thành</div>
                            </div>
                            <div class="feature-item">
                                <div class="feature-icon">🛡️</div>
                                <div class="feature-title">Bảo hành chính hãng</div>
                                <div class="feature-desc">12–24 tháng</div>
                            </div>
                            <div class="feature-item">
                                <div class="feature-icon">💳</div>
                                <div class="feature-title">Thanh toán an toàn</div>
                                <div class="feature-desc">Đa dạng hình thức</div>
                            </div>
                            <div class="feature-item">
                                <div class="feature-icon">🔄</div>
                                <div class="feature-title">Đổi trả 30 ngày</div>
                                <div class="feature-desc">Không cần lý do</div>
                            </div>
                        </div>
                    </section>

                    <!-- BANNER -->
                    <section class="section" style="padding-top:0">
                        <div class="banner-grid">
                            <div class="banner-card banner-card-purple">
                                <div class="banner-card-content">
                                    <div class="banner-card-tag">Flash Sale</div>
                                    <div class="banner-card-title">iPhone 15 Pro</div>
                                    <div class="banner-card-sub">Giảm đến 5 triệu đồng</div>
                                    <a href="?category=Điện+thoại" class="btn btn-primary btn-sm">Mua ngay</a>
                                </div>
                                <div class="banner-emoji">📱</div>
                            </div>
                            <div class="banner-card banner-card-cyan">
                                <div class="banner-card-content">
                                    <div class="banner-card-tag">Mới về</div>
                                    <div class="banner-card-title">MacBook Air M3</div>
                                    <div class="banner-card-sub">Chip mạnh mẽ nhất từ Apple</div>
                                    <a href="?category=Laptop" class="btn btn-primary btn-sm">Khám phá</a>
                                </div>
                                <div class="banner-emoji">💻</div>
                            </div>
                        </div>
                    </section>

                    <!-- PRODUCTS -->
                    <section class="section" id="products">
                        <div class="section-header">
                            <h2 class="section-title">Sản phẩm <span>nổi bật</span></h2>
                            <form method="get" action="${pageContext.request.contextPath}/"
                                style="display:flex;gap:.5rem;align-items:center">
                                <c:if test="${not empty param.search}">
                                    <input type="hidden" name="search" value="${param.search}" />
                                </c:if>
                                <c:if test="${not empty param.category}">
                                    <input type="hidden" name="category" value="${param.category}" />
                                </c:if>
                                <select name="sort" class="form-control" style="width:auto;padding:8px 12px;"
                                    onchange="this.form.submit()">
                                    <option value="">Sắp xếp</option>
                                    <option value="price-asc" ${param.sort eq 'price-asc' ? 'selected' : '' }>Giá tăng
                                        dần</option>
                                    <option value="price-desc" ${param.sort eq 'price-desc' ? 'selected' : '' }>Giá giảm
                                        dần</option>
                                    <option value="rating" ${param.sort eq 'rating' ? 'selected' : '' }>Đánh giá cao
                                    </option>
                                </select>
                            </form>
                        </div>

                        <!-- Tabs danh mục -->
                        <div class="category-tabs">
                            <a class="cat-tab ${empty param.category ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/">Tất cả</a>
                            <c:forEach var="cat" items="${categories}">
                                <a class="cat-tab ${param.category eq cat ? 'active' : ''}"
                                    href="?category=${cat}">${cat}</a>
                            </c:forEach>
                        </div>

                        <c:if test="${not empty search}">
                            <p style="color:var(--text-secondary);margin-bottom:1rem">
                                Kết quả tìm kiếm cho: <strong style="color:var(--primary)">"${search}"</strong>
                                – <strong>${products.size()}</strong> sản phẩm
                            </p>
                        </c:if>

                        <div class="products-grid">
                            <c:choose>
                                <c:when test="${empty products}">
                                    <div
                                        style="grid-column:1/-1;text-align:center;padding:3rem;color:var(--text-secondary)">
                                        😢 Không tìm thấy sản phẩm phù hợp
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="p" items="${products}">
                                        <div class="product-card"
                                            onclick="location.href='${pageContext.request.contextPath}/product?id=${p.id}'">
                                            <c:if test="${not empty p.badge}">
                                                <div class="product-badge badge-${p.badge}">
                                                    <c:choose>
                                                        <c:when test="${p.badge eq 'sale'}">SALE ${p.discountPercent}%
                                                        </c:when>
                                                        <c:when test="${p.badge eq 'new'}">MỚI</c:when>
                                                        <c:otherwise>HOT</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:if>
                                            <div class="product-img">${p.emoji}</div>
                                            <div class="product-info">
                                                <div class="product-category">${p.category}</div>
                                                <div class="product-name">${p.name}</div>
                                                <div class="product-rating">
                                                    <span class="stars">★★★★★</span>
                                                    <span class="rating-count">${p.rating} (${p.reviews})</span>
                                                </div>
                                                <div class="product-price">
                                                    <span class="price-current">${p.formattedPrice}</span>
                                                    <c:if test="${p.oldPrice > 0}">
                                                        <span class="price-old">${p.formattedOldPrice}</span>
                                                    </c:if>
                                                </div>
                                                <div class="product-actions">
                                                    <a href="${pageContext.request.contextPath}/product?id=${p.id}"
                                                        class="btn btn-secondary btn-sm"
                                                        onclick="event.stopPropagation()">Xem</a>
                                                    <form method="post" action="${pageContext.request.contextPath}/cart"
                                                        style="flex:1" onclick="event.stopPropagation()">
                                                        <input type="hidden" name="action" value="add" />
                                                        <input type="hidden" name="productId" value="${p.id}" />
                                                        <input type="hidden" name="redirect"
                                                            value="${pageContext.request.contextPath}/" />
                                                        <button type="submit" class="btn btn-primary btn-sm"
                                                            style="width:100%">🛒 Thêm</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </section>

                    <%@ include file="footer.jsp" %>
            </body>

            </html>