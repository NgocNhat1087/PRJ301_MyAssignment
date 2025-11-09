<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- GOOGLE FONTS -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Orbitron:wght@500&display=swap" rel="stylesheet">

<div class="container-fluid py-4 fade-in">
    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold page-title mb-0">
            <i class="bi bi-calendar3 me-2"></i> Division Agenda
        </h3>
        <div class="d-flex align-items-center gap-2">
            <button type="button" class="btn btn-outline-accent" onclick="changeRange(-1)">
                <i class="bi bi-chevron-left"></i> Prev
            </button>
            <button type="button" class="btn btn-outline-accent" onclick="changeRange(1)">
                Next <i class="bi bi-chevron-right"></i>
            </button>
            <button id="themeToggle" class="btn btn-accent ms-2" title="Toggle Theme">
                <i class="bi bi-brightness-high"></i>
            </button>
        </div>
    </div>

    <!-- FORM -->
    <form action="agenda" method="get" class="row g-3 align-items-end futuristic-form mb-4" onsubmit="return validateDates()">
        <div class="col-md-3">
            <label class="form-label fw-semibold">From:</label>
            <input type="date" id="fromDate" name="from" value="${from}" class="form-control" required>
        </div>
        <div class="col-md-3">
            <label class="form-label fw-semibold">To:</label>
            <input type="date" id="toDate" name="to" value="${to}" class="form-control" required>
        </div>
        <div class="col-md-3">
            <button type="submit" class="btn btn-accent px-4 py-2">
                <i class="bi bi-search me-2"></i> View
            </button>
        </div>
    </form>

    <!-- TABLE -->
    <div class="card list-card border-0">
        <div class="table-container">
            <table class="table align-middle text-center modern-table mb-0">
                <thead>
                    <tr>
                        <th>Employee</th>
                            <c:set var="days" value="${(to.time - from.time)/(1000*60*60*24)}"/>
                            <c:if test="${days > 6}">
                                <c:set var="days" value="6" />
                            </c:if>
                            <c:forEach var="i" begin="0" end="${days}">
                                <c:set var="millis" value="${from.time + i*24*60*60*1000}" />
                                <jsp:useBean id="tmpDate" class="java.util.Date" />
                                <c:set target="${tmpDate}" property="time" value="${millis}" />
                            <th class="day-header">
                                <fmt:formatDate value="${tmpDate}" pattern="EEE" /><br>
                                <span class="day-num"><fmt:formatDate value="${tmpDate}" pattern="dd/MM" /></span>
                            </th>
                        </c:forEach>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="e" items="${employees}">
                        <tr>
                            <td class="fw-semibold text-start">${e.name}</td>
                            <c:forEach var="i" begin="0" end="${days}">
                                <c:set var="day" value="${from.time + i*24*60*60*1000}"/>
                                <c:set var="isLeave" value="false"/>
                                <c:forEach var="r" items="${map[e.id]}">
                                    <c:if test="${day >= r.from.time && day <= r.to.time}">
                                        <c:set var="isLeave" value="true"/>
                                    </c:if>
                                </c:forEach>
                                <td class="${isLeave ? 'leave-cell' : 'work-cell'}">
                                    <div class="status-icon">
                                        <c:if test="${isLeave}"><i class="bi bi-moon-stars"></i></c:if>
                                        <c:if test="${not isLeave}"><i class="bi bi-cpu"></i></c:if>
                                        </div>
                                    </td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- === JS FUNCTIONALITY === -->
<script>
    function validateDates() {
        const from = new Date(document.getElementById("fromDate").value);
        const to = new Date(document.getElementById("toDate").value);

        if (from > to) {
            alert("⚠️ 'From' date must be earlier than or equal to 'To' date!");
            return false;
        }

        const diff = (to - from) / (1000 * 60 * 60 * 24);
        if (diff > 6) {
            alert("⚠️ You can only view up to 7 days (1 week) at a time!");
            return false;
        }
        return true;
    }

// === RANGE SWITCH ===
    function changeRange(offset) {
        const fromEl = document.getElementById("fromDate");
        const toEl = document.getElementById("toDate");

        const from = new Date(fromEl.value);
        const to = new Date(toEl.value);
        const diffDays = (to - from) / (1000 * 60 * 60 * 24) + 1;

        const newFrom = new Date(from);
        const newTo = new Date(to);
        newFrom.setDate(from.getDate() + (offset * diffDays));
        newTo.setDate(to.getDate() + (offset * diffDays));

        fromEl.valueAsDate = newFrom;
        toEl.valueAsDate = newTo;
        document.querySelector("form").submit();
    }

// === THEME TOGGLE ===
    const toggle = document.getElementById("themeToggle");
    const body = document.body;
    const savedTheme = localStorage.getItem("theme");
    if (savedTheme)
        body.setAttribute("data-theme", savedTheme);
    if (savedTheme === "light")
        toggle.innerHTML = '<i class="bi bi-moon-stars-fill"></i>';

    toggle.onclick = () => {
        const mode = body.getAttribute("data-theme") === "dark" ? "light" : "dark";
        body.setAttribute("data-theme", mode);
        localStorage.setItem("theme", mode);
        toggle.innerHTML = mode === "light"
                ? '<i class="bi bi-moon-stars-fill"></i>'
                : '<i class="bi bi-brightness-high"></i>';
    };
</script>

<style>
    /* === COLOR THEME === */
    :root {
        --accent: #00b4ff;
        --accent2: #8b5cf6;
        --text-main: #e5e7eb;
        --text-sub: #9ca3af;
        --bg-body: #0b0e17;
        --bg-card: rgba(255,255,255,0.05);
        --border: rgba(255,255,255,0.1);
        --thead-bg: linear-gradient(90deg, rgba(0,180,255,0.18), rgba(139,92,246,0.18));
        --thead-text: #f3f4f6;
        --work-bg: rgba(56,189,248,0.1);
        --work-color: #38bdf8;
        --leave-bg: rgba(239,68,68,0.12);
        --leave-color: #f87171;
    }

    [data-theme="light"] {
        --accent: #2563eb;
        --accent2: #9333ea;
        --text-main: #1e1e1e;
        --text-sub: #4b5563;
        --bg-body: #f8fafc;
        --bg-card: #ffffff;
        --border: #e5e7eb;
        --thead-bg: linear-gradient(90deg, #e0e7ff, #f3e8ff);
        --thead-text: #1e1e1e;
        --work-bg: rgba(147,197,253,0.3);
        --work-color: #2563eb;
        --leave-bg: rgba(254,202,202,0.4);
        --leave-color: #ef4444;
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
        font-size: 1.3rem;
        color: var(--accent2);
        filter: drop-shadow(0 0 5px rgba(139,92,246,0.5));
    }

    /* === BUTTONS === */
    .btn-accent {
        background: linear-gradient(90deg, var(--accent), var(--accent2));
        color: #fff;
        border-radius: 10px;
        border: none;
        transition: all 0.3s ease;
    }
    .btn-accent:hover {
        transform: scale(1.04);
        box-shadow: 0 0 18px rgba(0,195,255,0.4);
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

    /* === FORM === */
    .futuristic-form .form-control {
        background: rgba(255,255,255,0.05);
        border: 1px solid var(--border);
        border-radius: 10px;
        color: var(--text-main);
        transition: 0.3s;
    }
    .futuristic-form .form-control:focus {
        border-color: var(--accent);
        box-shadow: 0 0 10px rgba(0,195,255,0.3);
    }

    /* === TABLE === */
    .list-card {
        background: var(--bg-card);
        border-radius: 14px;
        border: 1px solid var(--border);
        box-shadow: 0 0 20px rgba(0,0,0,0.2);
        backdrop-filter: blur(10px);
    }
    .table-container {
        overflow-x: auto;
        border-radius: 12px;
    }

    .modern-table {
        width: 100%;
        border-collapse: collapse;
        color: var(--text-sub);
        font-size: 0.9rem;
    }

    /* === HEADER === */
    .modern-table thead tr {
        background: var(--thead-bg);
        color: var(--thead-text);
        text-transform: uppercase;
        font-weight: 600;
        letter-spacing: 0.5px;
    }
    .day-header {
        font-family: "Orbitron", sans-serif;
        font-size: 0.85rem;
        border-bottom: 2px solid var(--accent2);
    }
    .day-num {
        font-size: 0.8rem;
        color: var(--accent);
    }

    /* === BODY === */
    .modern-table td {
        padding: 10px 12px;
        border-color: var(--border);
        border-radius: 6px;
        transition: background 0.25s ease, transform 0.25s ease;
    }

    /* Hover nhẹ từng ô */
    .modern-table td:hover {
        background: rgba(255,255,255,0.08);
        transform: scale(1.03);
    }

    /* === WORK & LEAVE CELLS === */
    .work-cell {
        background: linear-gradient(135deg, rgba(56,189,248,0.15), rgba(34,211,238,0.1));
        color: #38bdf8;
        border: 1px solid rgba(56,189,248,0.2);
        box-shadow: 0 0 10px rgba(56,189,248,0.15) inset;
    }
    .leave-cell {
        background: linear-gradient(135deg, rgba(239,68,68,0.18), rgba(248,113,113,0.12));
        color: #f87171;
        border: 1px solid rgba(248,113,113,0.25);
        box-shadow: 0 0 10px rgba(248,113,113,0.1) inset;
    }

    /* Hiệu ứng icon nhịp nhẹ */
    .status-icon {
        font-size: 1.3rem;
        animation: softPulse 2.8s infinite ease-in-out;
        transition: color 0.3s ease;
    }
    @keyframes softPulse {
        0%,100% {
            opacity: 1;
            transform: scale(1);
        }
        50% {
            opacity: 0.8;
            transform: scale(1.08);
        }
    }

    /* === LIGHT MODE OVERRIDES === */
    [data-theme="light"] .work-cell {
        background: linear-gradient(135deg, rgba(147,197,253,0.25), rgba(191,219,254,0.2));
        color: #2563eb;
        border: 1px solid rgba(147,197,253,0.4);
        box-shadow: 0 0 8px rgba(147,197,253,0.2) inset;
    }
    [data-theme="light"] .leave-cell {
        background: linear-gradient(135deg, rgba(254,202,202,0.35), rgba(252,165,165,0.25));
        color: #dc2626;
        border: 1px solid rgba(254,202,202,0.5);
        box-shadow: 0 0 8px rgba(252,165,165,0.25) inset;
    }

    /* === SCROLLBAR === */
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
</style>
