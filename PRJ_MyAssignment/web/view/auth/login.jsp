<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login - Employee Leave System</title>

  <!-- Bootstrap + Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

  <style>
    /* ===== Background: Messi lifting the World Cup ===== */
    body {
      background: 
        linear-gradient(rgba(0, 0, 0, 0.55), rgba(0, 0, 0, 0.7)),
        url('https://th.bing.com/th/id/R.6fc5f97de00753815830c14510e7ad3d?rik=l5BizrYXcq7%2fHw&pid=ImgRaw&r=0')
        no-repeat center center fixed;
      background-size: cover;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: "Poppins", "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    }

    /* ===== Login card (glass effect) ===== */
    .login-card {
      width: 400px;
      background: rgba(255, 255, 255, 0.15);
      backdrop-filter: blur(15px);
      border-radius: 20px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
      padding: 40px 35px;
      color: #fff;
      text-align: center;
      animation: fadeIn 0.9s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    /* ===== Title ===== */
    .login-card h3 {
      font-weight: 700;
      color: #ffffff;
      text-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
      margin-bottom: 25px;
      letter-spacing: 0.5px;
    }

    /* ===== Inputs ===== */
    .form-control {
      border-radius: 10px;
      background: rgba(255, 255, 255, 0.2);
      border: 1px solid rgba(255, 255, 255, 0.4);
      color: #fff;
      font-size: 15px;
      padding: 10px;
      transition: all 0.3s ease;
    }

    .form-control::placeholder {
      color: rgba(255, 255, 255, 0.8);
    }

    .form-control:focus {
      background: rgba(255, 255, 255, 0.3);
      border-color: #00bfff;
      box-shadow: 0 0 8px rgba(0, 191, 255, 0.4);
      color: #fff;
    }

    label {
      font-weight: 500;
      font-size: 14px;
    }

    /* ===== Button ===== */
    .btn-login {
      background: linear-gradient(90deg, #007bff, #00c6ff);
      border: none;
      border-radius: 10px;
      color: white;
      font-weight: 600;
      letter-spacing: 0.5px;
      padding: 10px 0;
      width: 100%;
      margin-top: 10px;
      transition: all 0.3s ease;
    }

    .btn-login:hover {
      transform: translateY(-1px);
      background: linear-gradient(90deg, #0062cc, #00aaff);
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    }

    /* ===== Footer ===== */
    .footer-text {
      color: rgba(255, 255, 255, 0.8);
      font-size: 0.9rem;
      margin-top: 15px;
    }

    /* ===== Small animation for card shadow ===== */
    .login-card:hover {
      box-shadow: 0 10px 30px rgba(0, 191, 255, 0.4);
      transition: 0.4s ease;
    }
  </style>
</head>

<body>
  <div class="login-card">
    <h3><i class="bi bi-person-circle"></i> Login</h3>

    <form action="login" method="POST">
      <div class="mb-3 text-start">
        <label class="form-label text-light">Username</label>
        <input type="text" name="username" class="form-control" placeholder="Enter your username" required>
      </div>

      <div class="mb-3 text-start">
        <label class="form-label text-light">Password</label>
        <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
      </div>

      <button type="submit" class="btn-login">Login</button>
    </form>

    <div class="footer-text mt-3">
      © 2025 Employee Leave Management System
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
