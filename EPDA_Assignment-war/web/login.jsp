<%-- Document : login Created on : 25-Apr-2025, 17:55:40 Author : Shifraz --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Car Sales System | Login</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
    <style>
      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: "Poppins", sans-serif;
      }

      body {
        background: linear-gradient(135deg, #4361ee, #3f37c9);
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
      }

      .login-container {
        background-color: #ffffff;
        padding: 2.5rem;
        width: 100%;
        max-width: 450px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
      }

      .login-container h2 {
        text-align: center;
        color: #4361ee;
        margin-bottom: 2rem;
        font-size: 1.8rem;
        font-weight: 600;
      }

      .form-group {
        margin-bottom: 1.5rem;
      }

      .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        color: #2c3e50;
        font-weight: 500;
      }

      .form-group input {
        width: 100%;
        padding: 0.8rem;
        border: 1px solid #ddd;
        border-radius: 10px;
        transition: all 0.3s ease;
        font-size: 1rem;
      }

      .form-group input:focus {
        outline: none;
        border-color: #4361ee;
        box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
      }

      .btn {
        width: 100%;
        padding: 0.8rem;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        font-weight: 500;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        font-size: 1rem;
      }

      .btn-primary {
        background-color: #4361ee;
        color: white;
      }

      .btn-primary:hover {
        background-color: #3f37c9;
        transform: translateY(-2px);
      }

      .register-link {
        text-align: center;
        margin-top: 1.5rem;
      }

      .register-link a {
        color: #4361ee;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s ease;
      }

      .register-link a:hover {
        color: #3f37c9;
      }

      .error-message {
        background-color: #f8d7da;
        color: #721c24;
        padding: 1rem;
        border-radius: 10px;
        margin-bottom: 1.5rem;
        border: 1px solid #f5c6cb;
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }

      .error-message i {
        font-size: 1.2rem;
      }
    </style>
  </head>
  <body>
    <div class="login-container">
      <h2>Car Sales System Login</h2>

      <form action="LoginServlet" method="POST">
        <c:if test="${not empty errorMessage}">
          <div class="error-message">
            <i class="fas fa-exclamation-circle"></i>
            ${errorMessage}
          </div>
        </c:if>

        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" id="username" name="username" required />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" required />
        </div>

        <button type="submit" class="btn btn-primary">
          <i class="fas fa-sign-in-alt"></i> Login
        </button>
      </form>

      <div class="register-link">
        Don't have an account? <a href="register.jsp">Register here</a>
      </div>
    </div>
  </body>
</html>
