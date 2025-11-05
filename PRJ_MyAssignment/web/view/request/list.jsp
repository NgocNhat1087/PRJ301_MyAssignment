<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- === LEAVE REQUEST LIST === -->
<div class="container-fluid py-3">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold text-primary mb-0">
            <i class="bi bi-journal-text"></i> Leave Request List
        </h3>
        <a href="${pageContext.request.contextPath}/request/create" 
           class="btn btn-primary">
            <i class="bi bi-plus-circle"></i> New Request
        </a>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle text-center mb-0">
                    <thead class="table-primary text-dark">
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
                            <tr>
                                <td class="fw-semibold">${r.id}</td>
                                <td>${r.created_by.name}</td>
                                <td><fmt:formatDate value="${r.created_time}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td><fmt:formatDate value="${r.from}" pattern="dd/MM/yyyy"/></td>
                                <td><fmt:formatDate value="${r.to}" pattern="dd/MM/yyyy"/></td>
                                <td class="text-start">${r.reason}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.status eq 0}">
                                            <span class="badge bg-warning text-dark px-3 py-2">Processing</span>
                                        </c:when>
                                        <c:when test="${r.status eq 1}">
                                            <span class="badge bg-success px-3 py-2">Approved</span>
                                        </c:when>
                                        <c:when test="${r.status eq 2}">
                                            <span class="badge bg-danger px-3 py-2">Rejected</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary px-3 py-2">Unknown</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:out value="${r.processed_by != null ? r.processed_by.name : '-'}"/>
                                </td>
                                <td>
                                    <a href="review?id=${r.id}" class="btn btn-outline-success btn-sm d-flex align-items-center justify-content-center gap-1">
                                        <i class="bi bi-eye"></i> <span>Review</span>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Pagination -->
    <div class="mt-3 text-center">
        <jsp:include page="../util/pagger.jsp"></jsp:include>
    </div>
</div>

<style>
    .table thead th {
        font-weight: 600;
        font-size: 0.95rem;
    }

    .table td {
        vertical-align: middle !important;
        font-size: 0.9rem;
    }

    .table-hover tbody tr:hover {
        background-color: #f8f9fa;
    }

    .card {
        border-radius: 12px;
    }

    .btn-sm span {
        font-size: 0.85rem;
    }

    .badge {
        font-size: 0.8rem;
        border-radius: 6px;
    }
</style>
