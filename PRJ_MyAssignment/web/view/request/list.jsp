<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Request List</title>
        <style>
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                margin: 40px;
            }

            h2 {
                text-align: center;
                color: #333;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            th, td {
                padding: 10px 12px;
                text-align: center;
                border: 1px solid #dee2e6;
            }

            th {
                background-color: #007bff;
                color: white;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #e9f5ff;
            }

            /* --- Status colors --- */
            .status-processing {
                color: #ffc107;
                font-weight: bold;
            }

            .status-approved {
                color: #28a745;
                font-weight: bold;
            }

            .status-rejected {
                color: #dc3545;
                font-weight: bold;
            }

            /* --- Links --- */
            a {
                text-decoration: none;
                color: #007bff;
            }

            a:hover {
                text-decoration: underline;
            }

            /* --- Pagination --- */
            form {
                margin-top: 20px;
                text-align: center;
            }

            input[type="number"], input[type="text"] {
                width: 50px;
                text-align: center;
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 4px;
            }

            input[type="submit"] {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 6px 12px;
                border-radius: 4px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../util/greeting.jsp"></jsp:include>
        
        <h2>Leave Request List</h2>
        
        <table>
            <tr>
                <th>Request Id</th>
                <th>Created By</th>
                <th>Created Time</th>
                <th>From</th>
                <th>To</th>
                <th>Reason</th>
                <th>Status</th>
                <th>Processed By</th>
                <th>Review</th>
                <th>Modify</th>
            </tr>
            
            <c:forEach items="${requestScope.rfls}" var="r">
                <tr>
                    <td>${r.id}</td>
                    <td>${r.created_by.name}</td>
                    <td><fmt:formatDate value="${r.created_time}" pattern="dd/MM/yyyy HH:mm"/></td>
                    <td><fmt:formatDate value="${r.from}" pattern="dd/MM/yyyy"/></td>
                    <td><fmt:formatDate value="${r.to}" pattern="dd/MM/yyyy"/></td>
                    <td>${r.reason}</td>
                    <td>
                        <c:choose>
                            <c:when test="${r.status eq 0}">
                                <span class="status-processing">Processing</span>
                            </c:when>
                            <c:when test="${r.status eq 1}">
                                <span class="status-approved">Approved</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-rejected">Rejected</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${r.processed_by ne null}">
                            ${r.processed_by.name}
                        </c:if>
                        <c:if test="${r.processed_by eq null}">
                            NULL
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${r.processed_by ne null}">
                            <c:if test="${r.status eq 1}">
                                <a href="review?id=${r.id}">Reject</a>
                            </c:if>
                            <c:if test="${r.status ne 1}">
                                <a href="review?id=${r.id}">Approve</a>
                            </c:if>
                        </c:if>

                        <c:if test="${r.processed_by eq null}">
                            <a href="review?id=${r.id}">Approve</a> |
                            <a href="review?id=${r.id}">Reject</a>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${r.status eq 0 
                                      && r.processed_by eq null 
                                      && r.created_by.id eq auth.employee.id}">
                              <a href="modify?id=${r.id}">Modify</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <jsp:include page="../util/pagger.jsp"></jsp:include>
    </body>
</html>