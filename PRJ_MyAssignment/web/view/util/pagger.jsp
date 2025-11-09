<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Pagination</title>

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Orbitron:wght@500&display=swap" rel="stylesheet">

        <style>
            /* === FUTURISTIC COLOR THEME === */
            :root {
                --accent: #00b4ff;
                --accent2: #8b5cf6;
                --text-main: #e5e7eb;
                --text-sub: #9ca3af;
                --bg-body: #0b0e17;
                --border: rgba(255,255,255,0.15);
                --button-glow: 0 0 10px rgba(0,180,255,0.5);
            }

            [data-theme="light"] {
                --accent: #2563eb;
                --accent2: #9333ea;
                --text-main: #1e1e1e;
                --text-sub: #4b5563;
                --bg-body: #f8fafc;
                --border: #e5e7eb;
                --button-glow: 0 0 6px rgba(37,99,235,0.25);
            }

            /* === BASE === */
            body {
                font-family: "Poppins", sans-serif;
                background: transparent;
                color: var(--text-main);
                text-align: center;
                margin-top: 20px;
            }

            form {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid var(--border);
                padding: 10px 20px;
                border-radius: 14px;
                box-shadow: 0 0 20px rgba(0,0,0,0.3);
                backdrop-filter: blur(12px);
                transition: 0.4s ease;
            }

            form:hover {
                box-shadow: 0 0 25px rgba(0,180,255,0.2);
            }

            /* === TEXT === */
            .page-label {
                font-family: "Orbitron", sans-serif;
                color: var(--accent);
                font-weight: 500;
                letter-spacing: 0.5px;
            }

            /* === INPUT === */
            input[type="number"] {
                width: 70px;
                text-align: center;
                border: 1px solid var(--border);
                border-radius: 10px;
                background: rgba(255,255,255,0.07);
                color: var(--text-main);
                padding: 6px;
                font-size: 16px;
                transition: all 0.3s ease;
            }

            input[type="number"]:focus {
                outline: none;
                border-color: var(--accent);
                box-shadow: 0 0 10px rgba(0,180,255,0.4);
            }

            /* === BUTTONS === */
            button {
                background: linear-gradient(90deg, var(--accent), var(--accent2));
                color: #fff;
                border: none;
                padding: 6px 12px;
                border-radius: 10px;
                cursor: pointer;
                font-size: 18px;
                font-weight: 500;
                transition: all 0.3s ease;
                box-shadow: var(--button-glow);
            }

            button:hover {
                transform: scale(1.08);
                box-shadow: 0 0 20px rgba(0,180,255,0.5);
            }

            button:disabled {
                opacity: 0.4;
                background: rgba(128,128,128,0.3);
                box-shadow: none;
                cursor: not-allowed;
            }

            /* === PAGE INFO === */
            .page-info {
                color: var(--text-sub);
                font-size: 15px;
            }

            /* === SLIDE-IN ANIMATION === */
            .fade-in {
                animation: fadeIn 0.6s ease;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(6px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body data-theme="dark">

        <!-- ✅ Tính toán trang trước / sau -->
        <c:set var="prevPage" value="${requestScope.pageindex - 1}" />
        <c:set var="nextPage" value="${requestScope.pageindex + 1}" />

        <!-- ✅ Pagination Form -->
        <form onsubmit="return goToPageFromInput(event)" class="fade-in">

            <!-- Nút Previous -->
            <c:choose>
                <c:when test="${requestScope.pageindex > 1}">
                    <button type="button" onclick="goPage(${prevPage})">
                        <i class="bi bi-chevron-left"></i>
                    </button>
                </c:when>
                <c:otherwise>
                    <button type="button" disabled>
                        <i class="bi bi-chevron-left"></i>
                    </button>
                </c:otherwise>
            </c:choose>

            <!-- Label + Input -->
            <span class="page-label">PAGE</span>
            <input id="pageInput" type="number"
                   value="${requestScope.pageindex}"
                   min="1"
                   max="${requestScope.totalPages}" />
            <span class="page-info">/ ${requestScope.totalPages}</span>

            <!-- Nút Next -->
            <c:choose>
                <c:when test="${requestScope.pageindex < requestScope.totalPages}">
                    <button type="button" onclick="goPage(${nextPage})">
                        <i class="bi bi-chevron-right"></i>
                    </button>
                </c:when>
                <c:otherwise>
                    <button type="button" disabled>
                        <i class="bi bi-chevron-right"></i>
                    </button>
                </c:otherwise>
            </c:choose>
        </form>

        <!-- ✅ JS -->
        <script>
            function goPage(p) {
                const total = ${requestScope.totalPages};
                if (p < 1)
                    p = 1;
                if (p > total)
                    p = total;
                window.location = '${pageContext.request.contextPath}/request/list?page=' + p;
            }

            function goToPageFromInput(e) {
                e.preventDefault();
                const input = document.getElementById('pageInput');
                let p = parseInt(input.value);
                if (isNaN(p))
                    return false;
                goPage(p);
                return false;
            }

            // Light/Dark mode sync
            const body = document.body;
            const savedTheme = localStorage.getItem("theme");
            if (savedTheme)
                body.setAttribute("data-theme", savedTheme);
        </script>

        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    </body>
</html>
