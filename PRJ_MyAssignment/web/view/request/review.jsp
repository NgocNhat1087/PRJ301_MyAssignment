<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Review Leave Request</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
</head>

<body class="bg-light">
    <div class="container py-5">
        <div class="card shadow-lg mx-auto p-4" style="max-width: 650px; border-radius: 12px;">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="fw-bold text-primary mb-0">
                    <i class="bi bi-file-earmark-text"></i> Duyệt đơn xin nghỉ phép
                </h4>
                <a href="${pageContext.request.contextPath}/request/list" class="btn btn-sm btn-outline-secondary">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>

            <hr>

            <p><strong>👤 Người duyệt:</strong> <jsp:include page="../util/greeting.jsp"/></p>
            <p><strong>📄 Người tạo đơn:</strong> ${rfl.created_by.name}</p>
            <p><strong>📅 Từ ngày:</strong> ${rfl.from}</p>
            <p><strong>📅 Đến ngày:</strong> ${rfl.to}</p>
            <p><strong>📝 Lý do:</strong> ${rfl.reason}</p>
            <p><strong>⚙️ Trạng thái:</strong>
                <span class="badge 
                      <c:choose>
                        <c:when test="${rfl.status eq 1}">bg-success</c:when>
                        <c:when test="${rfl.status eq 2}">bg-danger</c:when>
                        <c:otherwise>bg-warning text-dark</c:otherwise>
                      </c:choose>">
                    <c:if test="${rfl.status eq 1}">Approved</c:if>
                    <c:if test="${rfl.status eq 2}">Rejected</c:if>
                    <c:if test="${rfl.status eq 0}">Processing</c:if>
                </span>
            </p>

            <form action="review" method="post" class="mt-4">
                <input type="hidden" name="rid" value="${rfl.id}">
                <div class="d-flex flex-wrap gap-3">
                    <button type="submit" name="action" value="approve" class="btn btn-success px-4">
                        <i class="bi bi-check-circle"></i> Approve
                    </button>
                    <button type="submit" name="action" value="reject" class="btn btn-danger px-4">
                        <i class="bi bi-x-circle"></i> Reject
                    </button>

                    <!-- Hiện nút Modify nếu đơn đang Pending và người đăng nhập là người tạo -->
                    <c:if test="${rfl.status eq 0 and sessionScope.auth.employee.id eq rfl.created_by.id}">
                        <a href="${pageContext.request.contextPath}/request/modify?id=${rfl.id}"
                           class="btn btn-warning text-dark px-4">
                            <i class="bi bi-pencil-square"></i> Modify
                        </a>
                    </c:if>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
