<%-- 
    Document   : review
    Created on : Nov 1, 2025, 12:51:53 PM
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
        <div class="card">
            <h3>Duyệt đơn xin nghỉ phép</h3>
            <p>Duyệt bởi:  <jsp:include page="../util/greeting.jsp"></jsp:include></p>
            <p>Tạo bởi: ${rfl.created_by.name}</p>
            <label>From: </label>
            <input type="date" name="from" readonly="" value="${rfl.from}">
            <br/>
            <label>To: </label>
            <input type="date" name="to" readonly="" value="${rfl.to}">
            <br/>
            <label>Reason:</label>
            <input type="text" name="reason" readonly="" value="${rfl.reason}">
            <br/>

            <form action="review" method="post">
                <input type="hidden" name="rid" value="${rfl.id}">
                
                <div>
                    <button type="submit" name="action" value="reject" class="reject">Reject</button>
                    <button type="submit" name="action" value="approve" class="approve">Approve</button>
                </div>
            </form>
        </div>
    </body>
</html>
