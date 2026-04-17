<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0" />
        <title>404 – Không tìm thấy – TechZone</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    </head>

    <body>
        <%@ include file="header.jsp" %>
            <section class="section" style="text-align:center;padding:6rem 2rem">
                <div style="font-size:6rem;margin-bottom:1rem">😢</div>
                <h1 style="font-size:2rem;margin-bottom:.5rem">404 – Trang không tìm thấy</h1>
                <p style="color:var(--text-secondary);margin-bottom:2rem">Trang bạn đang tìm kiếm không tồn tại hoặc đã
                    bị di chuyển.</p>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg">🏠 Về trang chủ</a>
            </section>
            <%@ include file="footer.jsp" %>
    </body>

    </html>