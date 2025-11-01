<%-- 
    Document   : modifine
    Created on : Nov 1, 2025, 1:29:16 PM
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

            <div class="container">
                <h2>Modify Request for Leave</h2>

                <form action="modify" method="post">
                    <input type="hidden" name="id" value="${r.id}"/>
                <br/>
                <label>Created By:</label>
                <input type="text" value="${r.created_by.name}" readonly/>
                <br/>
                <label>Created Time:</label>
                <input type="text" value="${r.created_time}" readonly/>
                <br/>
                <label>From Date:</label>
                <input type="date" name="from" value="${r.from}"/>
                <br/>
                <label>To Date:</label>
                <input type="date" name="to" value="${r.to}"/>
                <br/>
                <label>Reason:</label>
                <input type="text" name ="reason" value="${r.reason}"/>
                
                <br/>
                <div class="btn">
                    <input type="submit" value="Update Request"/>
                    <a href="list" class="button">Cancel</a>
                </div>
            </form>
        </div>
    </body>
</html>
