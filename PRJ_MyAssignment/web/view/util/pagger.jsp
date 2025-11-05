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
        width: 60px;
        text-align: center;
        border: 1px solid #ccc;
        border-radius: 4px;
        padding: 4px;
        font-size: 15px;
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

    <!-- ✅ Form chuyển trang -->
    <form onsubmit="return goToPageFromInput(event)">
      <!-- Nút mũi tên trái -->
      <c:choose>
        <c:when test="${requestScope.pageindex > 1}">
          <button type="button" onclick="goPage(${prevPage})">&#9664;</button>
        </c:when>
        <c:otherwise>
          <button type="button" disabled>&#9664;</button>
        </c:otherwise>
      </c:choose>

      Page:
      <input id="pageInput" type="number"
             value="${requestScope.pageindex}"
             min="1"
             max="${requestScope.totalPages}" />

      / ${requestScope.totalPages}

      <!-- Nút mũi tên phải -->
      <c:choose>
        <c:when test="${requestScope.pageindex < requestScope.totalPages}">
          <button type="button" onclick="goPage(${nextPage})">&#9654;</button>
        </c:when>
        <c:otherwise>
          <button type="button" disabled>&#9654;</button>
        </c:otherwise>
      </c:choose>
    </form>

    <!-- ✅ JavaScript -->
    <script>
      function goPage(p) {
        const total = ${requestScope.totalPages};
        if (p < 1) p = 1;
        if (p > total) p = total;
        window.location = '${pageContext.request.contextPath}/request/list?page=' + p;
      }

      // Khi nhấn Enter trong ô input
      function goToPageFromInput(e) {
        e.preventDefault(); // Ngăn submit mặc định
        const input = document.getElementById('pageInput');
        let p = parseInt(input.value);
        if (isNaN(p)) return false;
        goPage(p);
        return false;
      }
    </script>

  </body>
</html>
