<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Review Leave Request</title>

        <!-- Google Fonts & Bootstrap -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Orbitron:wght@500&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

        <style>
            /* === COLOR SYSTEM === */
            :root {
                --accent: #00b4ff;
                --accent2: #8b5cf6;
                --text-main: #e5e7eb;
                --text-sub: #9ca3af;
                --bg-body: #0b0e17;
                --bg-card: rgba(255,255,255,0.05);
                --border: rgba(255,255,255,0.1);
                --approved: #22c55e;
                --rejected: #ef4444;
                --pending: #facc15;
            }
            [data-theme="light"] {
                --accent: #2563eb;
                --accent2: #9333ea;
                --text-main: #1e1e1e;
                --text-sub: #4b5563;
                --bg-body: #f8fafc;
                --bg-card: #ffffff;
                --border: #e5e7eb;
                --approved: #16a34a;
                --rejected: #dc2626;
                --pending: #eab308;
            }

            /* === BASE === */
            body {
                font-family: "Poppins", sans-serif;
                background: var(--bg-body);
                color: var(--text-main);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                transition: background 0.4s ease, color 0.4s ease;
                animation: fadeIn 0.6s ease;
            }
            @keyframes fadeIn {
                from {
                    opacity:0;
                    transform:translateY(10px);
                }
                to {
                    opacity:1;
                    transform:translateY(0);
                }
            }

            /* === CARD === */
            .review-card {
                background: var(--bg-card);
                border: 1px solid var(--border);
                border-radius: 18px;
                box-shadow: 0 0 25px rgba(0,0,0,0.25);
                backdrop-filter: blur(12px);
                padding: 2.5rem;
                width: 720px;
                transition: 0.4s ease;
                animation: floatCard 5s ease-in-out infinite;
            }
            @keyframes floatCard {
                0%,100% {
                    transform: translateY(0);
                }
                50% {
                    transform: translateY(-3px);
                }
            }
            .review-card:hover {
                box-shadow: 0 0 30px rgba(0,180,255,0.25);
            }

            /* === HEADER === */
            .review-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .review-header h4 {
                font-family: "Orbitron", sans-serif;
                color: var(--accent);
                text-shadow: 0 0 10px rgba(0,180,255,0.4);
                letter-spacing: 0.6px;
            }
            .theme-toggle {
                border: none;
                background: transparent;
                color: var(--accent);
                font-size: 1.4rem;
                cursor: pointer;
                transition: transform 0.3s ease, color 0.3s ease;
            }
            .theme-toggle:hover {
                transform: scale(1.15);
                color: var(--accent2);
            }

            .review-header a {
                border-radius: 10px;
                color: var(--accent);
                border: 1px solid var(--accent);
                transition: 0.3s;
            }
            .review-header a:hover {
                background: linear-gradient(90deg, var(--accent), var(--accent2));
                color: #fff;
                box-shadow: 0 0 12px rgba(0,195,255,0.3);
            }

            /* === INFO === */
            .info-line {
                margin-bottom: 0.8rem;
                font-size: 0.95rem;
            }
            .info-label {
                font-weight: 600;
                color: var(--text-sub);
                width: 150px;
                display: inline-block;
            }
            hr {
                border-top: 1px solid var(--border);
                margin: 1.5rem 0;
            }

            /* === STATUS BADGES === */
            .status-badge {
                display: inline-block;
                padding: 6px 16px;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.85rem;
                color: #fff;
                box-shadow: 0 0 12px rgba(255,255,255,0.08);
                animation: glowPulse 4s ease-in-out infinite;
            }
            @keyframes glowPulse {
                0%,100% {
                    box-shadow:0 0 10px rgba(0,195,255,0.2);
                }
                50% {
                    box-shadow:0 0 20px rgba(0,195,255,0.5);
                }
            }
            .status-approved {
                background: linear-gradient(90deg, #22c55e, #4ade80);
            }
            .status-rejected {
                background: linear-gradient(90deg, #ef4444, #f87171);
            }
            .status-pending  {
                background: linear-gradient(90deg, #facc15, #fde047);
                color: #111;
            }

            /* === BUTTONS === */
            .btn-modern {
                border-radius: 10px;
                font-weight: 500;
                letter-spacing: 0.3px;
                transition: 0.3s ease;
                padding: 8px 16px;
            }
            .btn-modern i {
                margin-right: 6px;
            }
            .btn-approve {
                background: linear-gradient(90deg, #16a34a, #22c55e);
                color: #fff;
                box-shadow: 0 0 12px rgba(34,197,94,0.25);
            }
            .btn-approve:hover {
                transform: scale(1.05);
                box-shadow: 0 0 18px rgba(34,197,94,0.4);
            }
            .btn-reject {
                background: linear-gradient(90deg, #ef4444, #f87171);
                color: #fff;
                box-shadow: 0 0 12px rgba(239,68,68,0.25);
            }
            .btn-reject:hover {
                transform: scale(1.05);
                box-shadow: 0 0 18px rgba(239,68,68,0.4);
            }
            .btn-modify {
                background: linear-gradient(90deg, #3b82f6, #8b5cf6);
                color: #fff;
                box-shadow: 0 0 12px rgba(59,130,246,0.25);
            }
            .btn-modify:hover {
                transform: scale(1.05);
                box-shadow: 0 0 18px rgba(59,130,246,0.4);
            }
            .btn-outline-danger {
                border-radius: 8px;
                border: 1px solid var(--rejected);
                color: var(--rejected);
                transition: 0.3s;
            }
            .btn-outline-danger:hover {
                background: var(--rejected);
                color: #fff;
                box-shadow: 0 0 15px rgba(239,68,68,0.3);
            }

            /* === RESPONSIVE === */
            @media (max-width: 576px) {
                .review-card {
                    padding: 1.5rem;
                    width: 95%;
                }
                .info-label {
                    width: 110px;
                }
            }

            /* === DELETE BUTTON (AI Neon Red Glow) === */
            .btn-delete {
                background: linear-gradient(90deg, #ef4444, #f87171);
                color: #fff;
                border-radius: 10px;
                font-weight: 500;
                letter-spacing: 0.3px;
                transition: all 0.3s ease;
                box-shadow: 0 0 12px rgba(239,68,68,0.25);
            }
            .btn-delete:hover {
                transform: scale(1.05);
                box-shadow: 0 0 20px rgba(239,68,68,0.4);
            }

            /* Pulse effect for Delete */
            @keyframes softPulseRed {
                0%,100% {
                    box-shadow: 0 0 12px rgba(239,68,68,0.25);
                }
                50% {
                    box-shadow: 0 0 20px rgba(239,68,68,0.5);
                }
            }
            .btn-delete {
                animation: softPulseRed 3s ease-in-out infinite;
            }

        </style>
    </head>

    <body data-theme="dark">
        <div class="review-card">
            <!-- Header -->
            <div class="review-header mb-3">
                <h4><i class="bi bi-file-earmark-text me-2"></i> Review Leave Request</h4>
                <div class="d-flex align-items-center gap-2">
                    <!-- Theme Toggle -->
                    <button id="themeToggle" class="theme-toggle" title="Toggle theme">
                        <i class="bi bi-moon-stars"></i>
                    </button>
                    <a href="${pageContext.request.contextPath}/request/list" class="btn btn-sm">
                        <i class="bi bi-arrow-left"></i> Back
                    </a>
                </div>
            </div>
            <hr>

            <!-- Request Info -->
            <div class="info-line"><span class="info-label">👤 Processed By:</span> <c:out value="${rfl.processed_by != null ? rfl.processed_by.name : '—'}"/></div>
            <div class="info-line"><span class="info-label">🧾 Created By:</span> ${rfl.created_by.name}</div>
            <div class="info-line"><span class="info-label">📅 From:</span> <fmt:formatDate value="${rfl.from}" pattern="dd/MM/yyyy"/></div>
            <div class="info-line"><span class="info-label">📅 To:</span> <fmt:formatDate value="${rfl.to}" pattern="dd/MM/yyyy"/></div>
            <div class="info-line"><span class="info-label">📝 Reason:</span> ${rfl.reason}</div>

            <div class="info-line mt-3">
                <span class="info-label">⚙️ Status:</span>
                <span class="status-badge
                      <c:choose>
                          <c:when test='${rfl.status eq 1}'> status-approved</c:when>
                          <c:when test='${rfl.status eq 2}'> status-rejected</c:when>
                          <c:otherwise> status-pending</c:otherwise>
                      </c:choose>">
                    <c:choose>
                        <c:when test='${rfl.status eq 1}'>Approved</c:when>
                        <c:when test='${rfl.status eq 2}'>Rejected</c:when>
                        <c:otherwise>Processing</c:otherwise>
                    </c:choose>
                </span>
            </div>

            <hr>

            <!-- === Actions === -->
            <div class="d-flex justify-content-between align-items-center flex-wrap mt-3">

                <!-- === Form xử lý Review (Approve / Reject / Modify) === -->
                <form action="review" method="post" class="d-flex flex-wrap gap-2 mb-0">
                    <input type="hidden" name="rid" value="${rfl.id}">

                    <!-- Kiểm tra quyền review -->
                    <c:set var="canReview" value="false"/>
                    <c:forEach var="r" items="${sessionScope.auth.roles}">
                        <c:if test="${r.id eq 1 or r.id eq 2}">
                            <c:set var="canReview" value="true"/>
                        </c:if>
                    </c:forEach>

                    <c:if test="${canReview}">
                        <button type="submit" name="action" value="approve" class="btn btn-modern btn-approve">
                            <i class="bi bi-check-circle"></i> Approve
                        </button>
                        <button type="submit" name="action" value="reject" class="btn btn-modern btn-reject">
                            <i class="bi bi-x-circle"></i> Reject
                        </button>
                    </c:if>

                    <c:if test="${rfl.status eq 0 and sessionScope.auth.employee.id eq rfl.created_by.id}">
                        <a href="${pageContext.request.contextPath}/request/modify?id=${rfl.id}" 
                           class="btn btn-modern btn-modify">
                            <i class="bi bi-pencil-square"></i> Modify
                        </a>
                    </c:if>
                </form>

                <!-- === Form Delete  === -->
                <c:set var="canDelete" value="false"/>
                <c:forEach var="r" items="${sessionScope.auth.roles}">
                    <c:if test="${r.id eq 1 or r.id eq 2}">
                        <c:set var="canDelete" value="true"/>
                    </c:if>
                </c:forEach>

                <c:if test="${canDelete or rfl.status eq 0}">
                    <form action="${pageContext.request.contextPath}/request/remove" method="post"
                          onsubmit="return confirm('Are you sure you want to delete this leave request?');" class="mb-0">
                        <input type="hidden" name="id" value="${rfl.id}">
                        <button type="submit" class="btn btn-modern btn-delete">
                            <i class="bi bi-trash3"></i> Delete
                        </button>
                    </form>
                </c:if>
            </div>
        </div>

        <!-- ✅ JS for Theme Toggle -->
        <script>
            const toggle = document.getElementById("themeToggle");
            const body = document.body;
            const savedTheme = localStorage.getItem("theme");
            if (savedTheme)
                body.setAttribute("data-theme", savedTheme);

            function updateIcon() {
                const mode = body.getAttribute("data-theme");
                toggle.innerHTML = mode === "light"
                        ? '<i class="bi bi-moon-stars"></i>'
                        : '<i class="bi bi-brightness-high"></i>';
            }
            updateIcon();

            toggle.addEventListener("click", () => {
                const current = body.getAttribute("data-theme") || "dark";
                const next = current === "dark" ? "light" : "dark";
                body.setAttribute("data-theme", next);
                localStorage.setItem("theme", next);
                updateIcon();
            });
        </script>
    </body>
</html>
