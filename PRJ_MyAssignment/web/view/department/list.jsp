<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- === FUTURISTIC DEPARTMENT LIST === -->
<div class="container-fluid fade-in px-3">
    <!-- Title Section -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold futuristic-title mb-1">
                <i class="bi bi-cpu me-2"></i> Department Neural Network
            </h2>
        </div>
        <div class="neon-pulse"></div>
    </div>

    <!-- Table Section -->
    <div class="card futuristic-card p-3">
        <div class="table-responsive">
            <table class="table table-borderless align-middle text-center mb-0 futuristic-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Department Name</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="d" items="${departments}">
                        <tr class="row-hover">
                            <td class="fw-bold">${d.id}</td>
                            <td>${d.name}</td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty departments}">
                        <tr>
                            <td colspan="2" class="text-muted py-4">
                                <i class="bi bi-inboxes me-2"></i> No departments found.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- === CUSTOM STYLE === -->
<style>
    /* === EFFECTS === */
    .fade-in {
        animation: fadeInUp 0.6s ease-out;
    }
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(15px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* === TITLE === */
    .futuristic-title {
        background: linear-gradient(90deg, var(--accent), var(--accent2));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        letter-spacing: 1px;
        text-shadow: 0 0 20px rgba(0, 195, 255, 0.2);
        transition: 0.4s;
    }

    /* === CARD === */
    .futuristic-card {
        background: linear-gradient(145deg, var(--bg-card), rgba(255,255,255,0.03));
        border: 1px solid rgba(255,255,255,0.1);
        border-radius: 16px;
        box-shadow: 0 0 20px rgba(0, 195, 255, 0.08);
        transition: 0.4s;
    }

    .futuristic-card:hover {
        box-shadow: 0 0 35px rgba(0, 195, 255, 0.2);
        transform: translateY(-2px);
    }

    /* === TABLE === */
    .futuristic-table thead {
        background: linear-gradient(90deg, var(--accent), var(--accent2));
        color: white;
        border-radius: 12px;
    }

    .futuristic-table th {
        text-transform: uppercase;
        font-weight: 600;
        letter-spacing: 1px;
        font-size: 0.9rem;
    }

    .futuristic-table tbody td {
        color: var(--text-main);
        font-size: 1rem;
        transition: 0.3s ease;
    }

    .row-hover {
        position: relative;
        cursor: pointer;
    }

    .row-hover:hover {
        background: rgba(0, 195, 255, 0.08);
        box-shadow: inset 0 0 8px var(--accent);
        transform: scale(1.01);
    }

    .row-hover:hover td {
        color: var(--accent2);
        text-shadow: 0 0 6px rgba(139, 92, 246, 0.4);
    }

    /* === PULSE ELEMENT === */
    .neon-pulse {
        width: 16px;
        height: 16px;
        border-radius: 50%;
        background: var(--accent);
        box-shadow: 0 0 15px var(--accent);
        animation: pulse 1.5s infinite ease-in-out;
    }

    @keyframes pulse {
        0%, 100% {
            transform: scale(1);
            opacity: 1;
        }
        50% {
            transform: scale(1.4);
            opacity: 0.6;
        }
    }

    /* === LIGHT MODE OVERRIDES === */
    [data-theme="light"] .futuristic-card {
        background: linear-gradient(145deg, var(--bg-card), rgba(255,255,255,0.4));
        box-shadow: 0 0 12px rgba(37, 99, 235, 0.15);
    }

    [data-theme="light"] .row-hover:hover {
        background: rgba(37, 99, 235, 0.08);
        box-shadow: inset 0 0 6px var(--accent);
    }

    [data-theme="light"] .futuristic-title {
        text-shadow: none;
    }
</style>
