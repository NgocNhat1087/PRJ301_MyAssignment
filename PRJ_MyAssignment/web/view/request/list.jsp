<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Orbitron:wght@500&display=swap" rel="stylesheet">

<div class="container-fluid py-3 fade-in">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold page-title mb-0">
            <i class="bi bi-cpu me-2"></i> Leave Request List
        </h3>
        <a href="${pageContext.request.contextPath}/request/create"
           class="btn btn-accent px-3 py-2 shadow-sm">
            <i class="bi bi-plus-circle me-1"></i> New Request
        </a>
    </div>

    <!-- Table Card -->
    <div class="card list-card border-0">
        <div class="table-container">
            <table class="table align-middle text-center modern-table mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Created By</th>
                        <th>Created Time</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Reason</th>
                        <th>Status</th>
                        <th>Processed By</th>
                        <th>View</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.rfls}" var="r">
                        <tr onclick="goReview(${r.id})">
                            <td>${r.id}</td>
                            <td>${r.created_by.name}</td>
                            <td><fmt:formatDate value="${r.created_time}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td><fmt:formatDate value="${r.from}" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatDate value="${r.to}" pattern="dd/MM/yyyy"/></td>
                            <td class="text-start">${r.reason}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${r.status eq 0}">
                                        <span class="status-badge pending">
                                            <i class="bi bi-cpu"></i> <span>Processing</span>
                                        </span>
                                    </c:when>
                                    <c:when test="${r.status eq 1}">
                                        <span class="status-badge approved">
                                            <i class="bi bi-check-circle"></i> <span>Approved</span>
                                        </span>
                                    </c:when>
                                    <c:when test="${r.status eq 2}">
                                        <span class="status-badge rejected">
                                            <i class="bi bi-x-octagon"></i> <span>Rejected</span>
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge unknown">
                                            <i class="bi bi-question-circle"></i> <span>Unknown</span>
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:out value="${r.processed_by != null ? r.processed_by.name : '-'}"/></td>
                            <td>
                                <a href="review?id=${r.id}" class="btn btn-outline-accent btn-sm" onclick="event.stopPropagation();">
                                    <i class="bi bi-eye"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-3 text-center">
        <jsp:include page="../util/pagger.jsp"></jsp:include>
    </div>
</div>

<script>
    function goReview(id) {
        const row = event.currentTarget;
        row.classList.add('active-row');
        setTimeout(() => window.location.href = 'review?id=' + id, 200);
    }
</script>

<style>
    /* === BASE THEME COLORS === */
    :root {
        --accent: #00c3ff;
        --accent2: #8b5cf6;
        --text-main: #e2e8f0;
        --text-sub: #94a3b8;
        --bg-body: #0b0e17;
        --bg-card: rgba(255,255,255,0.05);
        --bg-table-head: linear-gradient(90deg, rgba(0,195,255,0.15), rgba(139,92,246,0.15));
        --border: rgba(255,255,255,0.1);
        --glow: 0 0 12px rgba(0,195,255,0.4);
        --thead-text: #e5e7eb;
    }

    [data-theme="light"] {
        --accent: #2563eb;
        --accent2: #9333ea;
        --text-main: #1e1e1e;
        --text-sub: #4b5563;
        --bg-body: #f7f9ff;
        --bg-card: #ffffff;
        --bg-table-head: linear-gradient(90deg, #e8ecff, #f3e8ff);
        --border: #e5e7eb;
        --glow: none;
        --thead-text: #1e1e1e;
    }

    /* === BASE === */
    body {
        background: var(--bg-body);
        color: var(--text-main);
        font-family: "Poppins", sans-serif;
        transition: background 0.4s ease, color 0.4s ease;
    }

    .fade-in {
        animation: fadeIn 0.5s ease;
    }
    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(8px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* === HEADER === */
    .page-title {
        font-family: "Orbitron", sans-serif;
        color: var(--accent);
        letter-spacing: 0.6px;
    }
    .page-title i {
        color: var(--accent2);
        font-size: 1.4rem;
        filter: drop-shadow(0 0 6px rgba(139,92,246,0.5));
    }

    /* === BUTTONS === */
    .btn-accent {
        background: linear-gradient(90deg, var(--accent), var(--accent2));
        color: #fff;
        border: none;
        border-radius: 10px;
        font-weight: 500;
        box-shadow: var(--glow);
        transition: all 0.3s ease;
    }
    .btn-accent:hover {
        transform: scale(1.03);
        box-shadow: 0 0 20px rgba(0,195,255,0.5);
    }
    .btn-outline-accent {
        border: 1px solid var(--accent);
        color: var(--accent);
        border-radius: 8px;
        background: transparent;
        transition: 0.3s;
    }
    .btn-outline-accent:hover {
        background: linear-gradient(90deg, var(--accent), var(--accent2));
        color: #fff;
    }

    /* === CARD === */
    .list-card {
        background: var(--bg-card);
        border-radius: 16px;
        border: 1px solid var(--border);
        box-shadow: 0 0 25px rgba(0,0,0,0.3);
        backdrop-filter: blur(12px);
        transition: all 0.3s ease;
    }
    .list-card:hover {
        box-shadow: 0 0 30px rgba(0,195,255,0.25);
    }

    /* === TABLE === */
    .table-container {
        overflow-x: auto;
        border-radius: 12px;
    }

    .modern-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 0.9rem;
        color: var(--text-sub);
        border-radius: 10px;
        overflow: hidden;
    }

    /* Hàng tiêu đề đổi màu theo mode */
    .modern-table thead {
        background: var(--bg-table-head);
        color: var(--thead-text);
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        transition: background 0.4s ease, color 0.4s ease;
    }

    .modern-table th, .modern-table td {
        padding: 10px 14px;
        border-bottom: 1px solid var(--border);
        vertical-align: middle;
    }

    .modern-table tbody tr {
        cursor: pointer;
        transition: all 0.3s ease;
    }
    .modern-table tbody tr:hover {
        background: linear-gradient(90deg, rgba(0,195,255,0.07), rgba(139,92,246,0.07));
        box-shadow: inset 3px 0 0 var(--accent2), 0 0 10px rgba(0,195,255,0.8);
        transform: scale(1.009);
    }
    .modern-table tbody tr.active-row {
        background-color: rgba(139,92,246,0.25);
        animation: flashRow 0.5s ease;
    }
    @keyframes flashRow {
        0% {
            background-color: rgba(139,92,246,0.25);
        }
        100% {
            background-color: transparent;
        }
    }

    /* === STATUS BADGES (AI + DUAL MODE) === */
    .status-badge {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        padding: 6px 14px;
        /*border-radius: 20px;*/
        font-size: 0.8rem;
        font-weight: 600;
        position: relative;
        overflow: hidden;
        color: #fff;
        transition: all 0.4s ease;
        box-shadow: 0 0 10px rgba(255,255,255,0.08);
    }
    .status-badge::before {
        content: "";
        position: absolute;
        inset: -1px;
        /*border-radius: 25px;*/
        background: linear-gradient(120deg, var(--accent), var(--accent2), var(--accent));
        background-size: 200% 200%;
        animation: statusGlow 3s linear infinite;
        z-index: 0;
        opacity: 0.6;
    }
    .status-badge::after {
        content: "";
        position: absolute;
        inset: 2px;
        /*border-radius: 25px;*/
        background: rgba(255,255,255,0.05);
        z-index: 1;
    }
    .status-badge span, .status-badge i {
        position: relative;
        z-index: 2;
    }

    @keyframes statusGlow {
        0% {
            background-position: 0% 50%;
        }
        50% {
            background-position: 100% 50%;
        }
        100% {
            background-position: 0% 50%;
        }
    }

    /* Status variants */
    .status-badge.pending::before {
        background: linear-gradient(120deg, #38bdf8, #3b82f6, #0ea5e9);
    }
    .status-badge.pending::after {
        background: rgba(59,130,246,0.1);
    }
    .status-badge.pending i {
        color: #38bdf8;
        animation: pulse 1.8s infinite;
    }

    .status-badge.approved::before {
        background: linear-gradient(120deg, #22c55e, #16a34a, #4ade80);
    }
    .status-badge.approved::after {
        background: rgba(34,197,94,0.12);
    }
    .status-badge.approved i {
        color: #4ade80;
    }

    .status-badge.rejected::before {
        background: linear-gradient(120deg, #ef4444, #dc2626, #f87171);
    }
    .status-badge.rejected::after {
        background: rgba(239,68,68,0.12);
    }
    .status-badge.rejected i {
        color: #f87171;
    }

    .status-badge.unknown::before {
        background: linear-gradient(120deg, #64748b, #94a3b8, #64748b);
    }
    .status-badge.unknown::after {
        background: rgba(100,116,139,0.12);
    }
    .status-badge.unknown i {
        color: #a1a1aa;
    }

    @keyframes pulse {
        0% {
            opacity: 1;
            transform: scale(1);
        }
        50% {
            opacity: 0.7;
            transform: scale(1.15);
        }
        100% {
            opacity: 1;
            transform: scale(1);
        }
    }

    /* Light mode overrides */
    [data-theme="light"] .status-badge {
        color: #1e1e1e;
        text-shadow: none;
    }
    [data-theme="light"] .status-badge::after {
        background: rgba(255,255,255,0.9);
    }
    [data-theme="light"] .status-badge.pending::before {
        background: linear-gradient(120deg, #60a5fa, #93c5fd);
    }
    [data-theme="light"] .status-badge.approved::before {
        background: linear-gradient(120deg, #86efac, #4ade80);
    }
    [data-theme="light"] .status-badge.rejected::before {
        background: linear-gradient(120deg, #fca5a5, #f87171);
    }
    [data-theme="light"] .status-badge.unknown::before {
        background: linear-gradient(120deg, #cbd5e1, #94a3b8);
    }

    /* SCROLLBAR */
    ::-webkit-scrollbar {
        width: 8px;
        height: 6px;
    }
    ::-webkit-scrollbar-thumb {
        background: var(--accent2);
        border-radius: 8px;
    }
    ::-webkit-scrollbar-thumb:hover {
        background: var(--accent);
    }
    html, body {
        margin: 0 !important;
        padding: 0 !important;
        border: 0 !important;
        background: transparent !important;
    }

</style>
