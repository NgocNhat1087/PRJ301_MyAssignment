<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- === HOME CONTENT (sẽ được include vào layout.jsp) === -->

<div class="container bg-white shadow-sm p-4 rounded">
    <h2 class="text-primary mb-4 text-center">
        Welcome to Employee Management System
    </h2>

    <p class="text-muted text-center mb-4">
        Choose a function below:
    </p>

    <div class="list-group">
        <a href="${pageContext.request.contextPath}/employee/list" 
           class="list-group-item list-group-item-action">
           👨‍💼 Manage Employees
        </a>

        <a href="${pageContext.request.contextPath}/request/list" 
           class="list-group-item list-group-item-action">
           📄 View Leave Requests
        </a>

        <a href="${pageContext.request.contextPath}/request/create" 
           class="list-group-item list-group-item-action">
           ➕ Create New Request
        </a>

        <a href="${pageContext.request.contextPath}/division/agenda" 
           class="list-group-item list-group-item-action">
           📅 Division Agenda
        </a>
    </div>
</div>
