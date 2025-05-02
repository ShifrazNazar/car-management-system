<%-- Document : login Created on : 25-Apr-2025, 17:55:40 Author : Shifraz --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Car Sales System | Login</title>
    <style>
      * {
        box-sizing: border-box;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }
      body {
        background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
      }
      .login-container {
        background-color: #ffffff;
        padding: 40px;
        width: 100%;
        max-width: 400px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
      }
      .login-container h2 {
        text-align: center;
        color: #333;
        margin-bottom: 30px;
      }
      .login-container label {
        display: block;
        margin-bottom: 8px;
        color: #444;
      }
      .login-container input[type="text"],
      .login-container input[type="password"] {
        width: 100%;
        padding: 12px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 16px;
      }
      .login-container input[type="submit"] {
        width: 100%;
        background-color: #007bff;
        color: white;
        padding: 12px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s ease;
      }
      .login-container input[type="submit"]:hover {
        background-color: #0056b3;
      }
      .register-link {
        text-align: center;
        margin-top: 20px;
      }
      .register-link a {
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
      }
      .error-message {
        color: red;
        text-align: center;
        margin-bottom: 15px;
        padding: 10px;
        background-color: #ffebee;
        border-radius: 8px;
      }
    </style>
  </head>
  <body>
    <div class="login-container">
      <h2>Car Sales System Login</h2>

      <form action="LoginServlet" method="POST">
        <c:if test="${not empty errorMessage}">
          <div class="error-message">${errorMessage}</div>
        </c:if>

        <label for="username">Username</label>
        <input type="text" id="username" name="username" required />

        <label for="password">Password</label>
        <input type="password" id="password" name="password" required />

        <input type="submit" value="Login" />
      </form>

      <div class="register-link">
        Don't have an account? <a href="register.jsp">Register here</a>
      </div>
    </div>
  </body>
</html>
