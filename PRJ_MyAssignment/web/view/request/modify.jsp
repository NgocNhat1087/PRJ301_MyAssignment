<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Google Fonts + Icons -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Orbitron:wght@500&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

<div class="container-fluid py-5 fade-in">
    <!-- HEADER -->
    <div class="text-center mb-5">
        <h2 class="fw-bold page-title">
            <i class="bi bi-pencil-square me-2"></i> Modify Leave Request
        </h2>
        <p class="text-sub">Refine your request with futuristic precision 🚀</p>
    </div>

    <!-- FORM -->
    <div class="d-flex justify-content-center">
        <form action="modify" method="post" class="ai-card p-4 rounded-4 shadow-lg" onsubmit="return validateDates();">
            <input type="hidden" name="id" value="${r.id}"/>

            <div class="mb-3">
                <label class="form-label fw-semibold text-accent">Created By:</label>
                <input type="text" class="form-control ai-input" value="${r.created_by.name}" readonly>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold text-accent">Created Time:</label>
                <input type="text" class="form-control ai-input" value="${r.created_time}" readonly>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold text-accent">From:</label>
                <input type="date" id="from" name="from" class="form-control ai-input" value="${r.from}" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold text-accent">To:</label>
                <input type="date" id="to" name="to" class="form-control ai-input" value="${r.to}" required>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold text-accent">Reason:</label>
                <textarea name="reason" class="form-control ai-input" rows="3" required>${r.reason}</textarea>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-accent px-4 py-2 me-2">
                    <i class="bi bi-save2 me-1"></i> Update
                </button>
                <a href="list" class="btn btn-outline-accent px-4 py-2">
                    <i class="bi bi-x-circle me-1"></i> Cancel
                </a>
            </div>
        </form>
    </div>

    <!-- MESSAGE -->
    <c:if test="${not empty msg}">
        <div class="mt-5 text-center">
            <div class="ai-alert shadow-sm d-inline-block px-4 py-3 rounded-3">
                ${msg}
            </div>
        </div>
    </c:if>
</div>

<script>
    function validateDates() {
        const from = new Date(document.getElementById("from").value);
        const to = new Date(document.getElementById("to").value);
        if (from >= to) {
            alert("⚠️ 'From' date must be earlier than 'To' date!");
            return false;
        }
        return true;
    }
</script>

<style>
    /* === THEME VARIABLES === */
    :root {
        --accent: #00c3ff;
        --accent2: #8b5cf6;
        --text-main: #e5e7eb;
        --text-sub: #9ca3af;
        --bg-body: #0b0e17;
        --bg-card: rgba(255,255,255,0.06);
        --border: rgba(255,255,255,0.1);
        --glow-accent: 0 0 14px rgba(0,195,255,0.4);
    }

    [data-theme="light"] {
        --accent: #2563eb;
        --accent2: #9333ea;
        --text-main: #1e1e1e;
        --text-sub: #4b5563;
        --bg-body: #f6f9ff;
        --bg-card: #ffffff;
        --border: #e5e7eb;
        --glow-accent: 0 0 12px rgba(37,99,235,0.25);
    }

    /* === BASE === */
    body {
        background: var(--bg-body);
        color: var(--text-main);
        font-family: "Poppins", sans-serif;
        transition: background 0.4s ease, color 0.4s ease;
    }
    .fade-in {
        animation: fadeIn 0.6s ease;
    }
    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(12px);
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
        text-shadow: 0 0 12px rgba(0,180,255,0.5);
        letter-spacing: 0.8px;
        position: relative;
    }
    .page-title::after {
        content: "";
        display: block;
        width: 120px;
        height: 2px;
        background: linear-gradient(90deg, var(--accent), var(--accent2));
        margin: 10px auto 0;
        border-radius: 5px;
        box-shadow: var(--glow-accent);
    }

    /* === CARD === */
    .ai-card {
        background: var(--bg-card);
        border: 1px solid var(--border);
        border-radius: 18px;
        box-shadow: 0 0 25px rgba(0,0,0,0.25);
        backdrop-filter: blur(12px);
        width: 520px;
        transition: 0.5s;
        animation: cardFloat 4s ease-in-out infinite;
    }
    @keyframes cardFloat {
        0%,100% {
            transform: translateY(0);
        }
        50% {
            transform: translateY(-3px);
        }
    }

    /* === INPUTS === */
    .ai-input {
        background: rgba(255,255,255,0.07);
        border: 1px solid var(--border);
        border-radius: 10px;
        color: var(--text-main);
        transition: all 0.4s ease;
    }
    .ai-input:focus {
        border-color: var(--accent);
        box-shadow: 0 0 12px rgba(0,195,255,0.3);
        transform: scale(1.01);
    }

    /* === BUTTONS === */
    .btn-accent {
        background: linear-gradient(90deg, var(--accent), var(--accent2));
        color: #fff;
        border: none;
        border-radius: 10px;
        font-weight: 500;
        box-shadow: var(--glow-accent);
        transition: all 0.35s ease;
    }
    .btn-accent:hover {
        transform: scale(1.05);
        box-shadow: 0 0 22px rgba(0,195,255,0.6);
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
        box-shadow: 0 0 14px rgba(0,195,255,0.3);
    }

    /* === ALERT === */
    .ai-alert {
        background: linear-gradient(90deg, rgba(56,189,248,0.15), rgba(139,92,246,0.15));
        color: var(--accent);
        border: 1px solid rgba(56,189,248,0.3);
        text-shadow: 0 0 4px rgba(56,189,248,0.5);
        animation: glowPulse 3s ease-in-out infinite;
    }
    @keyframes glowPulse {
        0%,100% {
            box-shadow: 0 0 10px rgba(56,189,248,0.3);
        }
        50% {
            box-shadow: 0 0 25px rgba(56,189,248,0.5);
        }
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
