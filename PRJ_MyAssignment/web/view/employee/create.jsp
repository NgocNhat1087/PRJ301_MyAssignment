<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="d-flex justify-content-center align-items-center min-vh-100">
    <div class="card futuristic-card p-4 shadow-lg" style="width: 700px; border-radius: 20px;">
        <h3 class="text-center text-accent mb-4">
            <i class="bi bi-robot"></i> Add New Employee
        </h3>

        <form action="create" method="post" class="row g-3">

            <!-- Employee ID -->
            <div class="col-md-6">
                <label class="form-label fw-semibold">Employee ID</label>
                <input type="text" name="eid" class="form-control futuristic-input" placeholder="e.g. E001" required>
            </div>

            <!-- Name -->
            <div class="col-md-6">
                <label class="form-label fw-semibold">Full Name</label>
                <input type="text" name="ename" class="form-control futuristic-input" placeholder="Enter full name" required>
            </div>

            <!-- Email -->
            <div class="col-md-6">
                <label class="form-label fw-semibold">Email</label>
                <input type="email" name="email" class="form-control futuristic-input" placeholder="example@company.com" required>
            </div>

            <!-- Phone -->
            <div class="col-md-6">
                <label class="form-label fw-semibold">Phone</label>
                <input type="text" name="phone" class="form-control futuristic-input" placeholder="0123456789">
            </div>

            <!-- Division -->
            <div class="col-md-6">
                <label class="form-label fw-semibold">Division</label>
                <select name="did" class="form-select futuristic-input">
                    <option value="">-- Select Division --</option>
                    <c:forEach var="d" items="${divisions}">
                        <option value="${d.id}">${d.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Supervisor -->
            <div class="col-md-6">
                <label class="form-label fw-semibold">Supervisor</label>
                <select name="supervisorid" class="form-select futuristic-input">
                    <option value="">-- None --</option>
                    <c:forEach var="s" items="${supervisors}">
                        <option value="${s.id}">${s.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Buttons -->
            <div class="col-12 d-flex justify-content-end mt-4">
                <a href="${pageContext.request.contextPath}/employee/list" class="btn btn-outline-secondary me-2 futuristic-cancel">
                    <i class="bi bi-arrow-left-circle"></i> Cancel
                </a>
                <button type="submit" class="btn btn-primary futuristic-save">
                    <i class="bi bi-check2-circle"></i> Save Employee
                </button>
            </div>
        </form>
    </div>
</div>

<style>
    :root {
        --accent: #00e0ff;
        --accent2: #9b5cf6;
        --bg-card: rgba(25, 28, 45, 0.75);
        --text-main: #f3f7ff;
        --text-sub: #a5b6d9;
    }

    body {
        background: radial-gradient(circle at 30% 20%, #0b1020, #050914 80%);
        font-family: 'Inter', sans-serif;
        color: var(--text-main);
        overflow-x: hidden;
    }

    /* === Futuristic Card === */
    .futuristic-card {
        position: relative;
        background: var(--bg-card);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255,255,255,0.08);
        box-shadow: 0 0 25px rgba(0, 195, 255, 0.08);
        overflow: hidden;
    }

    .futuristic-card::before {
        content: "";
        position: absolute;
        inset: 0;
        padding: 2px;
        border-radius: 20px;
        background: linear-gradient(135deg, var(--accent), var(--accent2), #00f0ff, var(--accent));
        background-size: 300% 300%;
        animation: borderFlow 8s ease infinite;
        mask: 
            linear-gradient(#000 0 0) content-box, 
            linear-gradient(#000 0 0);
        -webkit-mask-composite: xor;
        mask-composite: exclude;
        pointer-events: none;
    }

    @keyframes borderFlow {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    /* === Inputs === */
    .futuristic-input {
        background: rgba(255,255,255,0.07);
        border: 1px solid rgba(255,255,255,0.2);
        color: var(--text-main);
        border-radius: 10px;
        transition: all 0.3s ease;
    }

    .futuristic-input::placeholder {
        color: rgba(255,255,255,0.55);
    }

    .futuristic-input:focus {
        background: rgba(255,255,255,0.15);
        border-color: var(--accent);
        box-shadow: 0 0 18px rgba(0,224,255,0.4);
        transform: scale(1.02);
        outline: none;
        color: var(--text-main);
    }

    /* === Buttons === */
    .futuristic-save {
        background: linear-gradient(90deg, var(--accent), var(--accent2));
        border: none;
        color: #fff;
        font-weight: 600;
        letter-spacing: 0.5px;
        box-shadow: 0 0 15px rgba(0,195,255,0.3);
        transition: 0.3s;
    }

    .futuristic-save:hover {
        transform: scale(1.05);
        box-shadow: 0 0 30px rgba(0,195,255,0.6);
    }

    .futuristic-cancel {
        color: var(--text-sub);
        border: 1px solid var(--accent);
        transition: 0.3s;
    }

    .futuristic-cancel:hover {
        background: linear-gradient(90deg, var(--accent), var(--accent2));
        color: #fff;
        box-shadow: 0 0 20px rgba(0,195,255,0.4);
        transform: scale(1.03);
    }

    /* === Header Text === */
    .text-accent {
        font-family: 'Orbitron', sans-serif;
        letter-spacing: 1px;
        color: var(--accent);
        text-shadow: 0 0 10px rgba(0,224,255,0.9);
    }

    /* === Light sweep === */
    .futuristic-card::after {
        content: "";
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(0,224,255,0.1), transparent 70%);
        transform: rotate(25deg);
        animation: lightSweep 12s linear infinite;
        pointer-events: none;
    }

    @keyframes lightSweep {
        0% { transform: translateX(-50%) rotate(25deg); }
        50% { transform: translateX(50%) rotate(25deg); }
        100% { transform: translateX(-50%) rotate(25deg); }
    }
</style>
