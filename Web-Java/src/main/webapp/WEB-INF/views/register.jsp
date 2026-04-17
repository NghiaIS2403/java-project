<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width,initial-scale=1.0" />
            <title>Đăng ký – TechZone</title>
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
                    max-width: 460px;
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

                .row-2 {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 1rem;
                }
            </style>
        </head>

        <body>
            <script>
                if (localStorage.getItem('theme') === 'dark') document.documentElement.classList.add('dark-mode');
                function toggleTheme() {
                    document.documentElement.classList.toggle('dark-mode');
                    const isDark = document.documentElement.classList.contains('dark-mode');
                    localStorage.setItem('theme', isDark ? 'dark' : 'light');
                    const btn = document.getElementById('theme-toggle');
                    if (btn) btn.innerHTML = isDark ? '🌞' : '🌙';
                }
            </script>
            <button id="theme-toggle" class="btn-icon" onclick="toggleTheme()" title="Đổi giao diện"
                style="position:fixed; top:20px; right:20px; z-index:1000;">
                <script>document.write(localStorage.getItem('theme') === 'dark' ? '🌞' : '🌙')</script>
            </button>
            <div class="auth-page">
                <div class="auth-card">
                    <div class="auth-logo">
                        <div class="auth-logo-icon">⚡</div>
                        <div class="auth-title">Tạo tài khoản</div>
                        <div class="auth-sub">Mua sắm điện tử chính hãng, giá tốt nhất</div>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="error-box">❌ ${error}</div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/register">
                        <div class="form-group">
                            <label class="form-label">Họ và tên *</label>
                            <input class="form-control" type="text" name="name" placeholder="Nguyễn Văn A"
                                value="${not empty name ? name : ''}" required />
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email *</label>
                            <input class="form-control" type="email" name="email" placeholder="email@example.com"
                                value="${not empty email ? email : ''}" required />
                        </div>
                        <div class="form-group">
                            <label class="form-label">Số điện thoại</label>
                            <input class="form-control" type="tel" name="phone" placeholder="0901234567" />
                        </div>
                        <div class="row-2">
                            <div class="form-group">
                                <label class="form-label">Mật khẩu *</label>
                                <input class="form-control" type="password" name="password"
                                    placeholder="Tối thiểu 6 ký tự" required minlength="6" />
                            </div>
                            <div class="form-group">
                                <label class="form-label">Xác nhận MK *</label>
                                <input class="form-control" type="password" name="confirm"
                                    placeholder="Nhập lại mật khẩu" required />
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary"
                            style="width:100%;justify-content:center;margin-top:.5rem">
                            🚀 Đăng ký ngay
                        </button>
                    </form>

                    <div class="auth-footer">
                        Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    </div>
                </div>
            </div>
        </body>

        </html>