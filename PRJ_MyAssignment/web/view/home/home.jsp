<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- === FUTURE TECH HOME === -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Orbitron:wght@600&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<div class="home-container text-center py-5 fade-in">
    <div class="ai-greeting mb-4">
        <i class="bi bi-robot fs-1 text-accent"></i>
        <h2 class="fw-bold mt-3 futuristic-title">Welcome to <span>Employee Management System</span></h2>
        <p class="subtitle text-muted" id="typewriter"></p>
    </div>

    <div class="action-panel row justify-content-center g-4 mt-4">
        <div class="col-md-5 col-lg-3">
            <a href="${pageContext.request.contextPath}/employee/list" class="action-card">
                <i class="bi bi-people-fill"></i>
                <h5>Manage Employees</h5>
                <p>View, edit and organize your team efficiently.</p>
            </a>
        </div>

        <div class="col-md-5 col-lg-3">
            <a href="${pageContext.request.contextPath}/request/list" class="action-card">
                <i class="bi bi-journal-text"></i>
                <h5>Leave Requests</h5>
                <p>Monitor, review and approve employee leave applications seamlessly.</p>
            </a>
        </div>

        <div class="col-md-5 col-lg-3">
            <a href="${pageContext.request.contextPath}/request/create" class="action-card">
                <i class="bi bi-plus-circle"></i>
                <h5>Create New Request</h5>
                <p>Submit your leave request instantly.</p>
            </a>
        </div>

        <div class="col-md-5 col-lg-3">
            <a href="${pageContext.request.contextPath}/division/agenda" class="action-card">
                <i class="bi bi-calendar3"></i>
                <h5>Division Agenda</h5>
                <p>Stay updated with your department’s future events and schedules.</p>
            </a>
        </div>
    </div>

    <div class="mt-5 text-accent small">
        <i class="bi bi-cpu"></i> Powered by <b>Nhat Ngoc AI Vision Engine</b> | v2.5 — 2025
    </div>
</div>

<!-- === EFFECTS === -->
<script>
    // Typewriter effect
    const text = [
        "Hello, human. I'm your AI assistant.",
        "I help you manage employees faster than ever.",
        "Let's optimize your workflow together 🚀"
    ];
    let i = 0, j = 0, current = '', isDeleting = false;

    function type() {
        const element = document.getElementById("typewriter");
        if (!element)
            return;

        if (i < text.length) {
            if (!isDeleting && j <= text[i].length) {
                current = text[i].substring(0, j++);
                element.textContent = current;
            } else if (isDeleting && j > 0) {
                current = text[i].substring(0, j--);
                element.textContent = current;
            } else if (!isDeleting && j > text[i].length) {
                isDeleting = true;
                setTimeout(type, 1000);
                return;
            } else if (isDeleting && j === 0) {
                isDeleting = false;
                i++;
                if (i >= text.length)
                    i = 0;
            }
            setTimeout(type, isDeleting ? 50 : 100);
        }
    }
    document.addEventListener("DOMContentLoaded", type);
</script>

<!-- === STYLE === -->
<style>
    :root {
        --bg-main: #0b0e17;
        --card-bg: rgba(255,255,255,0.05);
        --accent: #00c3ff;
        --accent2: #8b5cf6;
        --text-main: #e2e8f0;
        --text-sub: #94a3b8;
        --border: rgba(255,255,255,0.1);
    }
    [data-theme="light"] {
        --bg-main: #f7f9ff;
        --card-bg: #ffffff;
        --text-main: #1e1e1e;
        --text-sub: #4b5563;
        --border: #e5e7eb;
    }

    body {
        background: var(--bg-main);
        color: var(--text-main);
        font-family: "Poppins", sans-serif;
        transition: all 0.4s ease;
    }

    .fade-in {
        animation: fadeIn 0.6s ease;
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

    .home-container {
        min-height: 80vh;
    }

    .ai-greeting i {
        color: var(--accent);
        filter: drop-shadow(0 0 6px var(--accent2));
    }

    .futuristic-title {
        font-family: "Orbitron", sans-serif;
        color: var(--accent2);
        letter-spacing: 0.8px;
        text-shadow: 0 0 8px rgba(0,195,255,0.4);
    }
    .futuristic-title span {
        color: var(--accent);
    }

    #typewriter {
        font-size: 1rem;
        color: var(--text-sub);
        font-style: italic;
        margin-top: 8px;
        min-height: 24px;
    }

    .action-card {
        display: block;
        background: var(--card-bg);
        color: var(--text-main);
        border-radius: 14px;
        border: 1px solid var(--border);
        padding: 24px 18px;
        text-decoration: none;
        box-shadow: 0 0 20px rgba(0,0,0,0.3);
        transition: all 0.4s ease;
        height: 100%;
    }

    .action-card:hover {
        transform: translateY(-6px) scale(1.03);
        background: linear-gradient(90deg, var(--accent), var(--accent2));
        color: #fff;
        box-shadow: 0 0 25px rgba(0,195,255,0.6);
    }

    .action-card i {
        font-size: 2rem;
        margin-bottom: 10px;
        color: var(--accent);
        transition: transform 0.3s ease;
    }

    .action-card:hover i {
        transform: rotate(8deg) scale(1.1);
        color: #fff;
    }

    .action-card h5 {
        font-weight: 600;
        margin-bottom: 6px;
    }

    .action-card p {
        font-size: 0.85rem;
        color: var(--text-sub);
    }

    .text-accent {
        color: var(--accent);
    }
</style>
