<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Agenda</title>
        <style>
            body {
                font-family: sans-serif;
            }
            table {
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #555;
                padding: 6px;
                text-align: center;
            }
            th {
                background-color: #eee;
            }
            .work {
                background-color: lightgreen;
            }
            .leave {
                background-color: red;
                color: white;
            }
        </style>
    </head>
    <body>

        <h2>Agenda from ${from} to ${to}</h2>

        <form action="agenda" method="get">
            <label>Từ ngày:</label>
            <input type="date" name="from" value="${from}">
            <label>Đến ngày:</label>
            <input type="date" name="to" value="${to}">
            <input type="submit" value="Xem">
        </form>

        <table>
            <tr>
                <th>Nhân sự</th>
                    <c:set var="days" value="${(to.time - from.time)/(1000*60*60*24)}"/>
                    <c:forEach var="i" begin="0" end="${days}">
                        <c:set var="millis" value="${from.time + i*24*60*60*1000}" />
                        <jsp:useBean id="tmpDate" class="java.util.Date" />
                        <c:set target="${tmpDate}" property="time" value="${millis}" />
                    <th><fmt:formatDate value="${tmpDate}" pattern="d/M" /></th>
                    </c:forEach>
            </tr>

            <c:forEach var="e" items="${employees}">
                <tr>
                    <td>${e.name}</td>
                    <c:forEach var="i" begin="0" end="${days}">
                        <c:set var="day" value="${from.time + i*24*60*60*1000}"/>
                        <c:set var="isLeave" value="false"/>
                        <c:forEach var="r" items="${map[e.id]}">
                            <c:if test="${day >= r.from.time && day <= r.to.time}">
                                <c:set var="isLeave" value="true"/>
                            </c:if>
                        </c:forEach>
                        <td class="${isLeave ? 'leave' : 'work'}"></td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>

    </body>
</html>
