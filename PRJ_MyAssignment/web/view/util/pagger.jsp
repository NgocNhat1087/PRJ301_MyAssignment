<%-- 
    Document   : pagger
    Created on : Nov 3, 2025, 8:38:40 AM
    Author     : sonnt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="${requestScope.action}" method="${requestScope.method}">
            Page: <input type="text" name="page" value="${requestScope.pageindex}"/> / ${requestScope.totalPages}
            
            <input type="submit"  value="View"/>
        </form>
    </body>
</html>
