<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <!-- Bootstrap + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Custom admin style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <!-- ========== HEADER ========== -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
                <!--<i class="bi bi-speedometer2"></i>--> 
                PRJ301 ASSIGNMENT SYSTEM
            </a>
            <div class="ms-auto text-white">
                <c:if test="${sessionScope.auth ne null}">
                    <span class="me-2">
                        <i class="bi bi-person-circle"></i> ${sessionScope.auth.displayname}
                    </span>
                    |
                    <a href="${pageContext.request.contextPath}/logout" class="text-white text-decoration-underline ms-2">
                        Logout
                    </a>
                </c:if>
            </div>
        </div>
    </nav>

    <!-- ========== BODY (SIDEBAR + MAIN) ========== -->
    <div class="d-flex">
        <!-- Sidebar -->
        <aside class="sidebar bg-dark text-white p-3 vh-100" style="width:250px;">
            <div class="text-center mb-4">
<!--                <img src="${pageContext.request.contextPath}/img/admin_avatar.png"
                     alt="Admin" class="rounded-circle" width="80" height="80">-->
                <p class="fw-bold mt-2 mb-0">${auth.employee.name}</p>
                <small class="text-success">Online</small>
            </div>

            <ul class="nav flex-column">
                <li class="nav-item"><a href="${pageContext.request.contextPath}/home" class="nav-link text-white"><i class="bi bi-house-door"></i> Trang chủ</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/employee/list" class="nav-link text-white"><i class="bi bi-person-badge"></i> Nhân viên</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/department/list" class="nav-link text-white"><i class="bi bi-building"></i> Phòng ban</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/division/agenda" class="nav-link text-white"><i class="bi bi-calendar3"></i> Lịch làm việc</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/request/list" class="nav-link text-white"><i class="bi bi-file-earmark-text"></i> Đơn nghỉ phép</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/request/create" class="nav-link text-white"><i class="bi bi-plus-circle"></i> Tạo đơn</a></li>
                <li class="nav-item mt-2"><a href="${pageContext.request.contextPath}/logout" class="nav-link text-danger"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
            </ul>
        </aside>

        <!-- Main content -->
        <main class="flex-grow-1 p-4 bg-light">
            <jsp:include page="${contentPage}" />
        </main>
    </div>

    <!-- ========== FOOTER ========== -->
    <footer class="text-center bg-white text-secondary p-3 border-top">
        © 2025 FPT University | PRJ301 - Employee Leave Management
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
