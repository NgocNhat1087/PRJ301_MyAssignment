<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid py-3">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-semibold text-accent">
            <i class="bi bi-people"></i> Employee Directory
        </h3>
        <a href="${pageContext.request.contextPath}/employee/create" class="btn btn-primary shadow-sm">
            <i class="bi bi-plus-circle"></i> Add Employee
        </a>
    </div>

    <!-- Employee Table -->
    <div class="card p-3 shadow-sm" style="border-radius: 14px; background: var(--bg-card);">
        <table class="table table-hover align-middle text-center mb-0">
            <thead style="background: linear-gradient(90deg, var(--accent), var(--accent2)); color: white;">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Division</th>
                    <th>Supervisor</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="e" items="${employees}">
                    <tr class="table-row-glow">
                        <td>${e.id}</td>
                        <td class="fw-semibold text-accent">${e.name}</td>
                        <td>
                            <c:choose>
                                <c:when test="${e.dept != null}">
                                    ${e.dept.name}
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${e.supervisor != null}">
                                    ${e.supervisor.name}
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td><a href="mailto:${e.email}" color="#000">${e.email}</a></td>
                        <td>${e.phone}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/employee/edit?id=${e.id}" 
                               class="btn btn-outline-info btn-sm futuristic-btn me-1" 
                               title="Edit">
                                <i class="bi bi-pencil-square"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/employee/remove?id=${e.id}" 
                               class="btn btn-outline-danger btn-sm futuristic-btn" 
                               onclick="return confirm('Are you sure to delete this employee?');" 
                               title="Delete">
                                <i class="bi bi-trash3"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<style>
    /* Neon hover effect for each row */
    .table-row-glow {
        transition: all 0.25s ease;
    }

    .table-row-glow:hover {
        background: rgba(0, 195, 255, 0.08);
        box-shadow: 0 0 15px rgba(0, 195, 255, 0.3);
        transform: scale(1.01);
    }

    /* Buttons with futuristic glow */
    .futuristic-btn {
        border-color: var(--accent);
        color: var(--accent);
        transition: all 0.3s ease;
        font-weight: 500;
        letter-spacing: 0.5px;
    }

    .futuristic-btn:hover {
        background: linear-gradient(90deg, var(--accent), var(--accent2));
        color: white;
        box-shadow: 0 0 12px rgba(0, 195, 255, 0.6);
        transform: translateY(-2px);
    }

    .text-accent {
        color: var(--accent);
    }

    .btn-primary {
        background: linear-gradient(90deg, var(--accent), var(--accent2));
        border: none;
        box-shadow: 0 0 8px rgba(0,195,255,0.4);
        transition: 0.3s;
    }

    .btn-primary:hover {
        box-shadow: 0 0 15px rgba(0,195,255,0.8);
        transform: scale(1.03);
    }
</style>
