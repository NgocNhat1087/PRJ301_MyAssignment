<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Orbitron:wght@500&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

<div class="container-fluid py-5 fade-in">
    <div class="text-center mb-5">
        <h2 class="fw-bold page-title">
            <i class="bi bi-robot me-2"></i> Create Leave Request
        </h2>
        <p class="text-sub">Plan your break smartly with our AI-powered leave manager 🤖</p>
    </div>

    <div class="d-flex justify-content-center">
        <form id="leaveForm"
              action="${pageContext.request.contextPath}/request/create"
              method="post"
              class="ai-card p-4 shadow-lg rounded-4"
              onsubmit="return validateDates();">

            <div class="mb-4">
                <label class="form-label fw-semibold text-accent">From:</label>
                <input type="date" id="from" name="from" class="form-control ai-input" required>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold text-accent">To:</label>
                <input type="date" id="to" name="to" class="form-control ai-input" required>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold text-accent">Reason:</label>
                <textarea name="reason" class="form-control ai-input" rows="3"
                          placeholder="Enter reason for leave..." required></textarea>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-accent px-4 py-2 me-2">
                    <i class="bi bi-send-check me-1"></i> Submit
                </button>
                <a href="${pageContext.request.contextPath}/request/list"
                   class="btn btn-outline-accent px-4 py-2">
                    <i class="bi bi-x-circle me-1"></i> Cancel
                </a>
            </div>
        </form>
    </div>

    <!-- Notification -->
    <c:if test="${not empty msg}">
        <div class="mt-5 text-center">
            <div class="alert 
                 <c:choose>
                    <c:when test='${msg ne null}'>alert-success ai-success</c:when>
                    <c:otherwise>alert-danger ai-error</c:otherwise>
                 </c:choose> shadow-sm d-inline-block px-4 py-3 rounded-3">
                ${msg}
            </div>
        </div>
    </c:if>
</div>

<!-- ✅ Date validation -->
<script>
  function validateDates() {
    const from = document.getElementById("from").value;
    const to = document.getElementById("to").value;

    if (!from || !to) return true;

    const fromDate = new Date(from);
    const toDate = new Date(to);

    if (fromDate >= toDate) {
      alert("⚠️ 'From' date must be earlier than 'To' date!");
      document.getElementById("to").focus();
      return false;
    }
    return true;
  }
</script>

<style>
/* === COLOR SYSTEM === */
:root {
    --accent: #00b4ff;
    --accent2: #8b5cf6;
    --text-main: #e5e7eb;
    --text-sub: #9ca3af;
    --bg-body: #0b0e17;
    --bg-card: rgba(255, 255, 255, 0.05);
    --border: rgba(255, 255, 255, 0.1);
}

[data-theme="light"] {
    --accent: #2563eb;
    --accent2: #9333ea;
    --text-main: #1e1e1e;
    --text-sub: #4b5563;
    --bg-body: #f8fafc;
    --bg-card: #ffffff;
    --border: #e5e7eb;
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
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* === TITLES === */
.page-title {
    font-family: "Orbitron", sans-serif;
    color: var(--accent);
    letter-spacing: 1px;
    text-shadow: 0 0 10px rgba(0,180,255,0.4);
}
.text-sub {
    color: var(--text-sub);
}

/* === CARD === */
.ai-card {
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 16px;
    box-shadow: 0 0 25px rgba(0,0,0,0.25);
    backdrop-filter: blur(12px);
    width: 460px;
    transition: 0.4s ease;
}
.ai-card:hover {
    box-shadow: 0 0 25px rgba(0,180,255,0.3);
}

/* === INPUTS === */
.ai-input {
    background: rgba(255,255,255,0.07);
    border: 1px solid var(--border);
    border-radius: 10px;
    color: var(--text-main);
    transition: all 0.3s ease;
}
.ai-input:focus {
    border-color: var(--accent);
    box-shadow: 0 0 10px rgba(0,195,255,0.3);
    outline: none;
}

/* === BUTTONS === */
.btn-accent {
    background: linear-gradient(90deg, var(--accent), var(--accent2));
    color: #fff;
    border: none;
    border-radius: 10px;
    font-weight: 500;
    transition: all 0.3s ease;
    box-shadow: 0 0 10px rgba(0,195,255,0.4);
}
.btn-accent:hover {
    transform: scale(1.03);
    box-shadow: 0 0 18px rgba(0,195,255,0.6);
}

.btn-outline-accent {
    border: 1px solid var(--accent);
    color: var(--accent);
    border-radius: 10px;
    background: transparent;
    transition: 0.3s;
}
.btn-outline-accent:hover {
    background: linear-gradient(90deg, var(--accent), var(--accent2));
    color: #fff;
    box-shadow: 0 0 12px rgba(0,195,255,0.3);
}

/* === ALERTS === */
.ai-success {
    background: rgba(34,197,94,0.15);
    color: #4ade80;
    border: 1px solid rgba(74,222,128,0.3);
    text-shadow: 0 0 4px rgba(74,222,128,0.4);
}
.ai-error {
    background: rgba(239,68,68,0.15);
    color: #f87171;
    border: 1px solid rgba(248,113,113,0.3);
    text-shadow: 0 0 4px rgba(248,113,113,0.4);
}

/* === SCROLLBAR === */
::-webkit-scrollbar {
    width: 8px;
}
::-webkit-scrollbar-thumb {
    background: var(--accent2);
    border-radius: 8px;
}
::-webkit-scrollbar-thumb:hover {
    background: var(--accent);
}
</style>
