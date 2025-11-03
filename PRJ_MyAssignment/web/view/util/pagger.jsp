<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagination</title>
        <style>
            form {
                margin-top: 20px;
                text-align: center;
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            }

            input[type="number"] {
                width: 50px;
                text-align: center;
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 4px;
            }

            button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 6px 12px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                margin: 0 4px;
            }

            button:hover {
                background-color: #0056b3;
            }

            button:disabled {
                background-color: #ccc;
                cursor: not-allowed;
            }
        </style>
    </head>
    <body>

        <!-- ✅ Tính toán trước giá trị trang kế và trước -->
        <c:set var="prevPage" value="${requestScope.pageindex - 1}" />
        <c:set var="nextPage" value="${requestScope.pageindex + 1}" />

        <!-- ✅ Form gửi đúng servlet /request/list -->
        <form action="${requestScope.action}" 
              method="${requestScope.method}">

            <!-- Nút mũi tên trái -->
            <button type="submit" name="page" value="${prevPage}"
                <c:if test="${requestScope.pageindex <= 1}">disabled</c:if>>
                &#9664;
            </button>

            Page:
            <input type="number" name="page" 
                   value="${requestScope.pageindex}" 
                   min="1" max="${requestScope.totalPages}" />

            / ${requestScope.totalPages}

            <!-- Nút mũi tên phải -->
            <button type="submit" name="page" value="${nextPage}"
                <c:if test="${requestScope.pageindex >= requestScope.totalPages}">disabled</c:if>>
                &#9654;
            </button>
        </form>
    </body>
</html>
