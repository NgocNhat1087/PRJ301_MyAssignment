<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home - Employee Management System</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #f8fafc;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #2563eb;
            color: white;
            padding: 15px 30px;
            text-align: center;
            font-size: 24px;
            font-weight: 600;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #1e3a8a;
            margin-bottom: 20px;
        }
        ul {
            list-style-type: none;
            padding-left: 0;
        }
        li {
            background: #f1f5f9;
            margin: 10px 0;
            padding: 15px;
            border-radius: 8px;
            transition: 0.2s;
        }
        li:hover {
            background: #e2e8f0;
            transform: translateX(5px);
        }
        a {
            text-decoration: none;
            color: #2563eb;
            font-weight: 500;
        }
        a:hover {
            text-decoration: underline;
        }
        footer {
            margin-top: 30px;
            text-align: center;
            color: #6b7280;
        }
    </style>
</head>
<body>

<header>
    Welcome to Employee Management System
</header>

<div class="container">
    <h2>Danh sách các chức năng</h2>
    <ul>
        <li>👨‍💼 <a href="employee/list">Quản lý nhân viên (Employee)</a></li>
        <li>📝 <a href="request/list">Danh sách đơn nghỉ phép (Request For Leave)</a></li>
        <li>➕ <a href="request/create">Tạo đơn nghỉ phép mới (Create Request)</a></li>
<!--        <li>🧾 <a href="request/review">Duyệt đơn (Review Request)</a></li>-->
        <li>✏️ <a href="request/modify">Chỉnh sửa đơn (Modify Request)</a></li>
        <li>📅 <a href="division/agenda">Xem lịch làm việc (Agenda)</a></li>
        <li>🚪 <a href="logout">Đăng xuất</a></li>
    </ul>
</div>

<footer>
    © 2025 FPT University — Java Web PRJ301 Project
</footer>

</body>
</html>
