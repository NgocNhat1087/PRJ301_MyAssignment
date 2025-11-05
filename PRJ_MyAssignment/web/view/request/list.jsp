<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid py-3 fade-in">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold page-title mb-0">
            <i class="bi bi-journal-text me-2"></i> Leave Request List
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
                        <th>Action</th>
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
                                        <span class="status-badge pending">Processing</span>
                                    </c:when>
                                    <c:when test="${r.status eq 1}">
                                        <span class="status-badge approved">Approved</span>
                                    </c:when>
                                    <c:when test="${r.status eq 2}">
                                        <span class="status-badge rejected">Rejected</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge unknown">Unknown</span>
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
    setTimeout(() => {
        window.location.href = 'review?id=' + id;
    }, 200);
}
</script>

<style>
/* ===== COLOR SYSTEM ===== */
:root {
    --accent: #3b82f6;
    --accent-hover: #2563eb;
    --text-main: #1e1e1e;
    --text-sub: #4b5563;
    --bg-body: #f5f7fb;
    --bg-card: #ffffff;
    --bg-table-head: #f0f2f5;
    --border: #e5e7eb;
    --row-hover-bg: rgba(59,130,246,0.06);
    --row-active: rgba(59,130,246,0.2);
}

[data-theme="dark"] {
    --accent: #60a5fa;
    --accent-hover: #3b82f6;
    --text-main: #e5e7eb;
    --text-sub: #9ca3af;
    --bg-body: #121418;
    --bg-card: #1d1f25;
    --bg-table-head: #2a2d35;
    --border: #2f3239;
    --row-hover-bg: rgba(96,165,250,0.12);
    --row-active: rgba(96,165,250,0.3);
}

/* ===== BASE ===== */
body {
    background: var(--bg-body);
    color: var(--text-main);
    font-family: "Inter", sans-serif;
}

.fade-in {
    animation: fadeIn 0.4s ease;
}
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(6px); }
    to { opacity: 1; transform: translateY(0); }
}

/* ===== HEADER ===== */
.page-title {
    color: var(--text-main);
    display: flex;
    align-items: center;
}
.page-title i {
    color: var(--accent);
    font-size: 1.4rem;
}

/* ===== BUTTONS ===== */
.btn-accent {
    background: var(--accent);
    color: #fff;
    border-radius: 10px;
    border: none;
    font-weight: 500;
    transition: 0.25s ease;
}
.btn-accent:hover {
    background: var(--accent-hover);
    box-shadow: 0 3px 8px rgba(59,130,246,0.25);
    transform: translateY(-1px);
}
.btn-outline-accent {
    border-color: var(--accent);
    color: var(--accent);
    border-radius: 6px;
    transition: all 0.25s ease;
}
.btn-outline-accent:hover {
    background: var(--accent);
    color: #fff;
}

/* ===== CARD ===== */
.list-card {
    background: var(--bg-card);
    border-radius: 14px;
    border: 1px solid var(--border);
    box-shadow: 0 3px 8px rgba(0,0,0,0.04);
}

/* ===== TABLE ===== */
.table-container {
    overflow-x: auto;
    white-space: nowrap;
}
.modern-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.9rem;
}
.modern-table thead {
    background: var(--bg-table-head);
    color: var(--text-main);
    text-transform: uppercase;
    letter-spacing: 0.4px;
    font-weight: 600;
}
.modern-table th, .modern-table td {
    border-color: var(--border);
    padding: 8px 14px;
    vertical-align: middle;
    color: var(--text-sub);
}

/* ===== ROW EFFECT - hiện đại, không lệch ===== */
.modern-table tbody tr {
    cursor: pointer;
    position: relative;
    transition: background-color 0.25s ease, box-shadow 0.25s ease;
}

/* Hover sáng nhẹ nhưng KHÔNG thay đổi layout */
.modern-table tbody tr:hover {
    background-color: var(--row-hover-bg);
    box-shadow: inset 3px 0 0 var(--accent), 0 1px 4px rgba(59,130,246,0.08);
    transform: scale(1.003);
    opacity: 0.8;
}

/* Click effect nhẹ */
.modern-table tbody tr.active-row {
    background-color: var(--row-active);
    animation: rowFlash 0.6s ease-out;
}

@keyframes rowFlash {
    0% { background-color: var(--row-active); }
    100% { background-color: transparent; }
}
/* ===== STATUS BADGES ===== */
.status-badge {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 8px;
    font-size: 0.75rem;
    font-weight: 600;
}
.status-badge.pending { background: #facc15; color: #1e1e1e; }
.status-badge.approved { background: #22c55e; color: #fff; }
.status-badge.rejected { background: #ef4444; color: #fff; }
.status-badge.unknown { background: #9ca3af; color: #fff; }

[data-theme="dark"] .status-badge.pending {
    background: #eab308;
    color: #111;
}

/* ===== SCROLLBAR ===== */
::-webkit-scrollbar { width: 8px; height: 0; }
::-webkit-scrollbar-thumb {
  background: var(--border);
  border-radius: 8px;
}
::-webkit-scrollbar-thumb:hover {
  background: var(--accent);
}
</style>
