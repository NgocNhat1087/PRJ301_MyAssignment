<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="d-flex justify-content-center align-items-center min-vh-100 fade-in">
    <div class="card futuristic-card p-4 shadow-lg" style="width: 700px; border-radius: 20px;">
        <h3 class="text-center text-accent mb-4">
            <i class="bi bi-gear-wide-connected"></i> Edit Employee Information
        </h3>

        <form action="${pageContext.request.contextPath}/employee/edit" method="post" class="row g-3">

            <!-- Employee ID (read-only) -->
            <div class="col-md-6">
                <label class="form-label fw-semibold">Employee ID</label>
                <input type="text" name="eid" class="form-control futuristic-input readonly-field" 
                       value="${employee.id}" readonly>
            </div>

            <!-- Full Name (read-only) -->
            <div class="col-md-6">
                <label class="form-label fw-semibold">Full Name</label>
                <input type="text" name="ename" class="form-control futuristic-input readonly-field" 
                       value="${employee.name}" readonly>
            </div>

            <!-- Email -->
            <div class="col-md-6">
                <label class="form-label fw-semibold">Email</label>
                <input type="email" name="email" class="form-control futuristic-input editable" 
                       value="${employee.email}" placeholder="example@company.com" required>
            </div>

            <!-- Phone -->
            <div class="col-md-6">
                <label class="form-label fw-semibold">Phone</label>
                <input type="text" name="phone" class="form-control futuristic-input editable" 
                       value="${employee.phone}" placeholder="0123456789">
            </div>

            <!-- Division -->
            <div class="col-md-6">
                <label class="form-label fw-semibold">Division</label>
                <select name="did" class="form-select futuristic-input editable">
                    <option value="">-- Select Division --</option>
                    <c:forEach var="d" items="${divisions}">
                        <option value="${d.id}" 
                            <c:if test="${employee.dept != null && employee.dept.id == d.id}">selected</c:if>>
                            ${d.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Supervisor -->
            <div class="col-md-6">
                <label class="form-label fw-semibold">Supervisor</label>
                <select name="supervisorid" class="form-select futuristic-input editable">
                    <option value="">-- None --</option>
                    <c:forEach var="s" items="${supervisors}">
                        <option value="${s.id}" 
                            <c:if test="${employee.supervisor != null && employee.supervisor.id == s.id}">selected</c:if>>
                            ${s.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Buttons -->
            <div class="col-12 d-flex justify-content-end mt-4">
                <a href="${pageContext.request.contextPath}/employee/list" 
                   class="btn btn-outline-secondary me-2 futuristic-cancel">
                    <i class="bi bi-arrow-left-circle"></i> Cancel
                </a>
                <button type="submit" class="btn btn-primary futuristic-save">
                    <i class="bi bi-check2-circle"></i> Save Changes
                </button>
            </div>
        </form>
    </div>
</div>

<style>
    /* === ANIMATION === */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(25px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .fade-in {
        animation: fadeInUp 0.7s ease-in-out;
    }

    /* === FUTURISTIC CARD === */
    .futuristic-card {
        background: var(--bg-card);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255,255,255,0.1);
        box-shadow: 0 0 30px rgba(0, 195, 255, 0.1);
        position: relative;
        overflow: hidden;
        transition: all 0.4s ease;
    }

    .futuristic-card:hover {
        box-shadow: 0 0 40px rgba(0,195,255,0.4);
        transform: translateY(-2px);
    }

    /* 🔧 Quan trọng: Cho phép click/nhập bên trong */
    .futuristic-card::before,
    .futuristic-card::after {
        content: "";
        position: absolute;
        inset: 0;
        border-radius: 20px;
        padding: 2px;
        background: linear-gradient(135deg, var(--accent), var(--accent2), #00f0ff, var(--accent));
        background-size: 400% 400%;
        animation: borderFlow 8s ease infinite;
        mask: 
            linear-gradient(#000 0 0) content-box, 
            linear-gradient(#000 0 0);
        -webkit-mask-composite: xor;
        mask-composite: exclude;
        pointer-events: none; /* ✅ Cho phép tương tác */
    }

    @keyframes borderFlow {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    /* === INPUTS === */
    .futuristic-input {
        background: rgba(255,255,255,0.06);
        border: 1px solid rgba(255,255,255,0.15);
        color: var(--text-main);
        border-radius: 10px;
        transition: all 0.3s ease;
    }

    .editable {
        pointer-events: auto; /* ✅ Cho phép nhập */
    }

    .futuristic-input.editable:focus {
        border-color: var(--accent);
        box-shadow: 0 0 15px rgba(0,195,255,0.5);
        background: rgba(255,255,255,0.12);
        transform: scale(1.02);
        color: var(--text-main);
    }

    /* Read-only fields */
    .readonly-field {
        background: rgba(255,255,255,0.03);
        border: 1px solid rgba(255,255,255,0.08);
        color: var(--text-sub);
        cursor: not-allowed;
        pointer-events: none; /* ❌ Không cho nhập */
    }

    /* === BUTTONS === */
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
        box-shadow: 0 0 15px rgba(0,195,255,0.5);
        transform: scale(1.03);
    }

    /* === HEADER TEXT === */
    .text-accent {
        font-family: 'Orbitron', sans-serif;
        color: var(--accent);
        text-shadow: 0 0 8px rgba(0,195,255,0.7);
        letter-spacing: 1px;
    }
</style>
