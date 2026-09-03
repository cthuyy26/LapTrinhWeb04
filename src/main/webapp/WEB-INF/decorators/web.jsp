<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">Lap Trinh Web</sitemesh:write></title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome & Bootstrap -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
    <style>
        :root {
            --primary-color: #0284c7;
            --primary-hover: #0369a1;
            --bg-color: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            margin: 0;
            padding: 0;
        }

        .main-content {
            flex: 1 0 auto;
            padding: 25px 0 40px 0;
        }

        .footer {
            flex-shrink: 0;
            background: #0f172a;
            color: #94a3b8;
            padding: 20px 0;
            text-align: center;
            font-size: 13px;
            border-top: 1px solid #1e293b;
        }

        .footer a {
            color: #38bdf8;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }
    </style>

    <sitemesh:write property="head" />
</head>
<body>
    <!-- Topbar Navigation -->
    <jsp:include page="/common/topbar.jsp"></jsp:include>

    <!-- Main Content Area decorated by SiteMesh -->
    <main class="main-content">
        <sitemesh:write property="body" />
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p style="margin: 0;">&copy; 2026 <strong>Lap Trinh Web</strong>. Phát triển bởi <span style="color: #38bdf8; font-weight: 600;">HCMUTE / UTE</span>.</p>
        </div>
    </footer>

    <!-- jQuery and Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>
