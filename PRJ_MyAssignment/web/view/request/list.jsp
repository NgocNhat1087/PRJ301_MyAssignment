<%-- 
    Document   : list
    Created on : Oct 31, 2025, 5:54:57 PM
    Author     : Nhat
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="../util/greeting.jsp"></jsp:include>
            <table border="1px solid">
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
                    <td>${r.created_time}</td>
                    <td>${r.from}</td>
                    <td>${r.to}</td>
                    <td>${r.reason}</td>
                    <td>
                        ${r.status eq 0?"processing":
                          r.status eq 1?"approved":"rejected"}
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
                                <a href="review?id=${r.id}">Rejected</a>
                            </c:if>
                            <c:if test="${r.status ne 1}">
                                <a href="review?id=${r.id}">Approved</a>
                            </c:if>
                        </c:if>

                        <c:if test="${r.processed_by eq null}">
                            <a href="review?id=${r.id}">Approved</a>
                            <a href="review?id=${r.id}">Rejected</a>

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
