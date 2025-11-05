<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>

    <!-- Bootstrap + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        /* === FONT & VARIABLES === */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap');

        :root {
            --bg-main: #f5f7fb;
            --bg-card: rgba(255, 255, 255, 0.85);
            --bg-sidebar: rgba(255, 255, 255, 0.75);
            --text-main: #1e1e1e;
            --text-sub: #555;
            --accent: #3b82f6;
            --shadow: rgba(0, 0, 0, 0.08);
        }

        [data-theme="dark"] {
            --bg-main: #1e1f23;
            --bg-card: rgba(34, 35, 39, 0.85);
            --bg-sidebar: rgba(34, 35, 39, 0.9);
            --text-main: #e6e6e6;
            --text-sub: #9ca3af;
            --accent: #60a5fa;
            --shadow: rgba(0, 0, 0, 0.6);
        }

        html, body {
            height: 100%;
            margin: 0;
            font-family: "Inter", sans-serif;
            background: var(--bg-main);
            color: var(--text-main);
            transition: background 0.4s ease, color 0.4s ease;
        }

        /* === SIDEBAR === */
        .sidebar {
            width: 250px;
            background: var(--bg-sidebar);
            backdrop-filter: blur(10px);
            border-right: 1px solid rgba(255, 255, 255, 0.2);
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            padding: 1.5rem 1rem;
            display: flex;
            flex-direction: column;
            box-shadow: 4px 0 15px var(--shadow);
            transition: background 0.4s ease;
        }

        .sidebar .user-info {
            text-align: center;
            margin-bottom: 2rem;
        }

        .sidebar .user-info p {
            font-weight: 600;
            color: var(--accent);
        }

        .sidebar .text-success {
            color: #22c55e !important;
        }

        .sidebar .nav-link {
            color: var(--text-main);
            border-radius: 10px;
            padding: 10px 14px;
            font-size: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 6px;
            transition: all 0.3s ease;
        }

        .sidebar .nav-link i {
            color: var(--accent);
            font-size: 1.1rem;
        }

        .sidebar .nav-link:hover {
            background: rgba(59,130,246,0.1);
            color: var(--accent);
            transform: translateX(4px);
        }

        .sidebar .nav-link.active {
            background: var(--accent);
            color: #fff;
            font-weight: 500;
            box-shadow: 0 4px 12px rgba(59,130,246,0.4);
        }

        /* === NAVBAR === */
        .navbar {
            /*margin-left: 250px;*/
            background: var(--bg-card);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 10px var(--shadow);
            padding: 0.8rem 1.5rem;
            transition: all 0.4s ease;
        }

        .navbar .navbar-brand {
            color: var(--accent);
            font-weight: 600;
            letter-spacing: 0.4px;
        }

        .navbar .theme-toggle {
            cursor: pointer;
            font-size: 1.3rem;
            color: var(--accent);
            transition: color 0.3s ease;
        }

        .navbar .theme-toggle:hover {
            color: #2563eb;
        }

        /* === CONTENT === */
        .page-wrapper {
            margin-left: 250px;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background: var(--bg-main);
        }

        main {
            flex: 1;
            padding: 2rem;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card {
            border: none;
            border-radius: 16px;
            background: var(--bg-card);
            box-shadow: 0 8px 20px var(--shadow);
            transition: 0.3s ease;
        }

        .card:hover {
            /*transform: translateY(-3px);*/
            box-shadow: 0 10px 25px var(--shadow);
        }

        /* === FOOTER === */
        footer {
            text-align: center;
            font-size: 0.9rem;
            color: var(--text-sub);
            background: var(--bg-card);
            border-top: 1px solid rgba(255,255,255,0.1);
            padding: 12px;
            transition: background 0.4s ease;
        }

        /* === SCROLLBAR === */
        ::-webkit-scrollbar {
            width: 8px;
        }
        ::-webkit-scrollbar-thumb {
            background: var(--accent);
            border-radius: 10px;
        }
    </style>
</head>

<body data-theme="light">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="user-info">
            <p>${auth.employee.name}</p>
            <small class="text-success">Online</small>
        </div>

        <ul class="nav flex-column">
            <li class="nav-item"><a href="${pageContext.request.contextPath}/home" class="nav-link"><i class="bi bi-house-door"></i> Home</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/employee/list" class="nav-link"><i class="bi bi-person-badge"></i> Employees</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/department/list" class="nav-link"><i class="bi bi-building"></i> Departments</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/division/agenda" class="nav-link"><i class="bi bi-calendar3"></i> Work Schedule</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/request/list" class="nav-link"><i class="bi bi-file-earmark-text"></i> Leave Requests</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/request/create" class="nav-link"><i class="bi bi-plus-circle"></i> Create Request</a></li>
            <li class="nav-item mt-2"><a href="${pageContext.request.contextPath}/logout" class="nav-link text-danger"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
        </ul>
    </aside>

    <!-- Wrapper -->
    <div class="page-wrapper">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                    PRJ301 Employee Leave System
                </a>
                <div class="ms-auto d-flex align-items-center gap-3">
                    <i id="themeToggle" class="bi bi-moon-stars-fill theme-toggle" title="Toggle Theme"></i>
                    <c:if test="${sessionScope.auth ne null}">
                        <span><i class="bi bi-person-circle"></i> ${sessionScope.auth.displayname}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="text-decoration-none text-danger ms-2">
                            <i class="bi bi-box-arrow-right"></i> Logout
                        </a>
                    </c:if>
                </div>
            </div>
        </nav>

        <!-- Main -->
        <main>
            <jsp:include page="${contentPage}" />
        </main>

        <!-- Footer -->
        <footer>
            © 2025 FPT University | PRJ301 - Employee Leave Management System
        </footer>
    </div>

    <script>
        // === Theme Toggle ===
        const toggle = document.getElementById("themeToggle");
        const body = document.body;
        const savedTheme = localStorage.getItem("theme");

        if (savedTheme) body.setAttribute("data-theme", savedTheme);

        toggle.addEventListener("click", () => {
            const current = body.getAttribute("data-theme");
            const next = current === "light" ? "dark" : "light";
            body.setAttribute("data-theme", next);
            localStorage.setItem("theme", next);
            toggle.classList.toggle("bi-moon-stars-fill");
            toggle.classList.toggle("bi-brightness-high");
        });

        // sync icon with saved theme
        if (savedTheme === "dark") {
            toggle.classList.remove("bi-moon-stars-fill");
            toggle.classList.add("bi-brightness-high");
        }
    </script>
</body>
</html>
