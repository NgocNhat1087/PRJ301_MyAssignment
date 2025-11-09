<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>System Message</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex align-items-center justify-content-center vh-100 bg-light">
  <div class="alert alert-info text-center w-50 shadow-sm">
    <h5>${requestScope.message}</h5>
    <a href="javascript:history.back()" class="btn btn-outline-primary mt-3">Back</a>
  </div>
</body>
</html>
