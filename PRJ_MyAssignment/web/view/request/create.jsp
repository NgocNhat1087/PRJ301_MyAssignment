<%-- 
    Document   : create
    Created on : Nov 1, 2025, 12:52:08 PM
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
        
        
        <h3>Đơn Xin Nghỉ Phép</h3>
        <jsp:include page="../util/greeting.jsp"></jsp:include>
        
        <form action="create" method="post">
            <label>From: </label>
            <input type="date" name="from" required>

            <label>To: </label>
            <input type="date" name="to" required>

            <label>Reason:</label>
            <textarea name="reason" required></textarea>

            <input type="submit" value="Submit"/>
        </form>

        
    </body>
</html>
