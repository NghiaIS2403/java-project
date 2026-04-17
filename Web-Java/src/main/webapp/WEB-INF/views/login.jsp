<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width,initial-scale=1.0" />
            <title>Đăng nhập – TechZone</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=2" />
            <style>
                .auth-page {
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 2rem;
                }

                .auth-card {
                    width: 100%;
                    max-width: 440px;
                    background: var(--bg-card);
                    border: 1px solid var(--border);
                    border-radius: var(--radius);
                    padding: 2.5rem;
                }

                .auth-logo {
                    text-align: center;
                    margin-bottom: 2rem;
                }

                .auth-logo-icon {
                    width: 60px;
                    height: 60px;
                    background: linear-gradient(135deg, var(--primary), var(--secondary));
                    border-radius: 16px;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 2rem;
                    margin-bottom: .8rem;
                }

                .auth-title {
                    font-size: 1.4rem;
                    font-weight: 800;
                    margin-bottom: .3rem;
                }

                .auth-sub {
                    font-size: .88rem;
                    color: var(--text-secondary);
                }

                .auth-footer {
                    text-align: center;
                    margin-top: 1.5rem;
                    font-size: .88rem;
                    color: var(--text-secondary);
                }

                .auth-footer a {
                    color: var(--primary);
                    text-decoration: none;
                    font-weight: 600;
                }

                .error-box {
                    background: rgba(255, 107, 107, .1);
                    border: 1px solid rgba(255, 107, 107, .3);
                    border-radius: var(--radius-sm);
                    padding: 12px 16px;
                    color: #ff6b6b;
                    font-size: .88rem;
                    margin-bottom: 1rem;
                }

                .divider {
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                    margin: 1.2rem 0;
                    color: var(--text-secondary);
                    font-size: .82rem;
                }

                .divider::before,
                .divider::after {
                    content: '';
                    flex: 1;
                    height: 1px;
                    background: var(--border);
                }

                .tab-switch {
                    display: flex;
                    background: var(--bg-card2);
                    border-radius: var(--radius-sm);
                    padding: 4px;
                    margin-bottom: 1.5rem;
                }

                .tab-btn {
                    flex: 1;
                    padding: 8px;
                    border: none;
                    background: transparent;
                    color: var(--text-secondary);
                    border-radius: 6px;
                    cursor: pointer;
                    font-family: 'Inter', sans-serif;
                    font-weight: 600;
                    font-size: .88rem;
                    transition: var(--transition);
                }

                .tab-btn.active {
                    background: var(--primary);
                    color: #fff;
                }
            </style>
        </head>

        <body>
            <div class="auth-page">
                <div class="auth-card">
                    <div class="auth-logo">
                        <div class="auth-logo-icon">⚡</div>
                        <div class="auth-title">TechZone</div>
                        <div class="auth-sub">Đăng nhập để tiếp tục</div>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="error-box">❌ ${error}</div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/login">
                        <input type="hidden" name="redirect" value="${param.redirect}" />
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input class="form-control" type="email" name="email" id="email"
                                value="${not empty email ? email : ''}" placeholder="admin@techzone.vn" required />
                        </div>
                        <div class="form-group">
                            <label class="form-label">Mật khẩu</label>
                            <input class="form-control" type="password" name="password" id="password"
                                placeholder="••••••••" required />
                        </div>
                        <button type="submit" class="btn btn-primary"
                            style="width:100%;justify-content:center;margin-top:.5rem" id="loginBtn">
                            🔑 Đăng nhập
                        </button>
                    </form>

                    <div class="divider">hoặc</div>

                    <div
                        style="background:var(--bg-card2);border-radius:var(--radius-sm);padding:1rem;font-size:.82rem;color:var(--text-secondary)">
                        <strong style="color:var(--text-primary)">Tài khoản demo:</strong><br />
                        👑 Admin: <code style="color:var(--primary)">admin@techzone.vn</code> / <code
                            style="color:var(--primary)">admin123</code><br />
                        👤 User: <code style="color:var(--secondary)">user@techzone.vn</code> / <code
                            style="color:var(--secondary)">user123</code>
                    </div>

                    <div class="auth-footer">
                        Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
                    </div>
                </div>
            </div>
        </body>

        </html>