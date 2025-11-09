<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>${pageTitle}</title>

        <!-- Bootstrap + Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Orbitron:wght@500&display=swap" rel="stylesheet">

        <style>
            :root {
                --bg-main: #0b0e17;
                --bg-card: rgba(255, 255, 255, 0.04);
                --bg-sidebar: rgba(255, 255, 255, 0.06);
                --text-main: #e2e8f0;
                --text-sub: #9ca3af;
                --accent: #00c3ff;
                --accent2: #8b5cf6;
                --shadow: 0 0 20px rgba(0, 195, 255, 0.2);
                --glow: 0 0 12px rgba(0, 195, 255, 0.5);
            }

            [data-theme="light"] {
                --bg-main: #f6f9ff;
                --bg-card: rgba(255, 255, 255, 0.85);
                --bg-sidebar: rgba(255, 255, 255, 0.9);
                --text-main: #111827;
                --text-sub: #4b5563;
                --accent: #2563eb;
                --accent2: #9333ea;
                --shadow: 0 0 10px rgba(37, 99, 235, 0.2);
                --glow: none;
            }

            html, body {
                height: 100%;
                margin: 0;
                background: var(--bg-main);
                color: var(--text-main);
                font-family: "Poppins", sans-serif;
                transition: 0.5s ease-in-out;
            }

            /* === SIDEBAR === */
            .sidebar {
                width: 250px;
                background: var(--bg-sidebar);
                backdrop-filter: blur(16px);
                border-right: 1px solid rgba(255,255,255,0.08);
                position: fixed;
                top: 0;
                bottom: 0;
                left: 0;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                padding: 1.5rem 1rem;
                box-shadow: var(--shadow);
            }

            .sidebar .user-info {
                text-align: center;
                margin-bottom: 2rem;
            }

            .sidebar .user-info p {
                font-weight: 600;
                color: var(--accent);
            }

            .sidebar .nav-link {
                color: var(--text-main);
                border-radius: 10px;
                padding: 10px 14px;
                font-size: 15px;
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 8px;
                transition: all 0.25s ease;
            }

            .sidebar .nav-link i {
                color: var(--accent2);
                transition: color 0.3s;
            }

            .sidebar .nav-link:hover {
                background: linear-gradient(90deg, var(--accent), var(--accent2));
                color: white;
                transform: translateX(6px);
                box-shadow: var(--glow);
            }

            .sidebar .nav-link.active {
                background: linear-gradient(90deg, var(--accent), var(--accent2));
                color: white;
                box-shadow: var(--glow);
            }

            /* === NAVBAR === */
            .navbar {
                /*margin-left: 250px;*/
                background: var(--bg-card);
                backdrop-filter: blur(12px);
                border-bottom: 1px solid rgba(255,255,255,0.1);
                box-shadow: var(--shadow);
                transition: 0.4s ease;
            }

            .navbar-brand {
                font-family: "Orbitron", sans-serif;
                font-size: 1.2rem;
                letter-spacing: 1px;
                color: var(--accent);
            }

            .theme-toggle {
                cursor: pointer;
                font-size: 1.4rem;
                color: var(--accent);
                transition: all 0.3s;
            }
            .theme-toggle:hover {
                color: var(--accent2);
            }

            /* === CONTENT === */
            .page-wrapper {
                margin-left: 250px;
                min-height: 100vh;
                background: var(--bg-main);
            }

            main {
                padding: 2rem;
                animation: fadeUp 0.6s ease;
            }

            @keyframes fadeUp {
                from {
                    opacity: 0;
                    transform: translateY(15px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .card {
                background: var(--bg-card);
                border: none;
                border-radius: 14px;
                box-shadow: var(--shadow);
                transition: all 0.3s;
            }

            .card:hover {
                transform: translateY(-0.2px);
                box-shadow: 0 0 20px rgba(0,195,255,0.4);
            }

            /* === FOOTER === */
            footer {
                text-align: center;
                padding: 14px;
                color: var(--text-sub);
                background: var(--bg-card);
                border-top: 1px solid rgba(255,255,255,0.1);
                font-size: 0.9rem;
            }

            /* SCROLLBAR */
            ::-webkit-scrollbar {
                width: 8px;
            }
            ::-webkit-scrollbar-thumb {
                background: var(--accent);
                border-radius: 8px;
            }

        </style>
    </head>

    <body data-theme="dark">
        <aside class="sidebar">
            <div>
                <div class="user-info">
                    <p>${auth.employee.name}</p>
                    <small class="text-success">Online</small>
                </div>

                <ul class="nav flex-column">

                    <!-- ===== Tạo các biến kiểm tra quyền ===== -->
                    <c:set var="isAdmin" value="false"/>
                    <c:set var="isManager" value="false"/>
                    <c:set var="isEmployee" value="false"/>

                    <c:forEach var="r" items="${sessionScope.auth.roles}">
                        <c:if test="${r.id eq 1}">
                            <c:set var="isAdmin" value="true"/>
                        </c:if>
                        <c:if test="${r.id eq 2}">
                            <c:set var="isManager" value="true"/>
                        </c:if>
                        <c:if test="${r.id eq 3}">
                            <c:set var="isEmployee" value="true"/>
                        </c:if>
                    </c:forEach>

                    <!-- ===== Home (mọi người đều có) ===== -->
                    <li>
                        <a href="${pageContext.request.contextPath}/home" class="nav-link">
                            <i class="bi bi-cpu"></i> Home
                        </a>
                    </li>

                    <!-- ===== ADMIN ===== -->
                    <c:if test="${isAdmin}">
                        <li><a href="${pageContext.request.contextPath}/employee/list" class="nav-link"><i class="bi bi-person-badge"></i> Employees</a></li>
                        <li><a href="${pageContext.request.contextPath}/department/list" class="nav-link"><i class="bi bi-diagram-3"></i> Departments</a></li>
                        <li><a href="${pageContext.request.contextPath}/division/agenda" class="nav-link"><i class="bi bi-calendar-event"></i> Work Schedule</a></li>
                        <li><a href="${pageContext.request.contextPath}/request/list" class="nav-link"><i class="bi bi-robot"></i> Leave Requests</a></li>
                        <li><a href="${pageContext.request.contextPath}/request/create" class="nav-link"><i class="bi bi-plus-circle"></i> New Request</a></li>
                        </c:if>

                    <!-- ===== MANAGER ===== -->
                    <c:if test="${isManager}">
                        <li><a href="${pageContext.request.contextPath}/department/list" class="nav-link"><i class="bi bi-diagram-3"></i> Departments</a></li>

                        <li><a href="${pageContext.request.contextPath}/division/agenda" class="nav-link"><i class="bi bi-calendar-event"></i> Work Schedule</a></li>
                        <li><a href="${pageContext.request.contextPath}/request/list" class="nav-link"><i class="bi bi-robot"></i> Review Requests</a></li>
                        <li><a href="${pageContext.request.contextPath}/request/create" class="nav-link"><i class="bi bi-plus-circle"></i> New Request</a></li>

                    </c:if>

                    <!-- ===== EMPLOYEE ===== -->
                    <c:if test="${isEmployee}">
                        <li><a href="${pageContext.request.contextPath}/department/list" class="nav-link"><i class="bi bi-diagram-3"></i> Departments</a></li>

                        <li><a href="${pageContext.request.contextPath}/request/list" class="nav-link"><i class="bi bi-robot"></i> My Requests</a></li>
                        <li><a href="${pageContext.request.contextPath}/request/create" class="nav-link"><i class="bi bi-plus-circle"></i> New Request</a></li>
                        </c:if>

                </ul>


            </div>

            <a href="${pageContext.request.contextPath}/logout" class="nav-link text-danger mt-3"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </aside>

        <div class="page-wrapper">
            <nav class="navbar navbar-expand-lg px-4">
                <div class="container-fluid">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-cpu"></i> PRJ301 Project System
                    </a>
                    <div class="ms-auto d-flex align-items-center gap-3">
                        <i id="themeToggle" class="bi bi-brightness-high theme-toggle"></i>
                        <span><i class="bi bi-person-circle"></i> ${sessionScope.auth.displayname}</span>
                    </div>
                </div>
            </nav>

            <main>
                <jsp:include page="${contentPage}" />
            </main>

            <footer>🤖 Powered by Nhat Ngoc | Request Leave Management System 2025</footer>
        </div>

        <script>
            const toggle = document.getElementById("themeToggle");
            const body = document.body;
            const saved = localStorage.getItem("theme");
            if (saved)
                body.setAttribute("data-theme", saved);
            if (saved === "light")
                toggle.classList.replace("bi-brightness-high", "bi-moon-stars-fill");

            toggle.onclick = () => {
                const mode = body.getAttribute("data-theme") === "dark" ? "light" : "dark";
                body.setAttribute("data-theme", mode);
                localStorage.setItem("theme", mode);
                toggle.classList.toggle("bi-moon-stars-fill");
                toggle.classList.toggle("bi-brightness-high");
            };
        </script>
    </body>
</html>
