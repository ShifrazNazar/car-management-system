<%-- Document : register Created on : 25-Apr-2025, 18:10:17 Author : Shifraz
--%> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Car Sales System | Register</title>
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
      .register-container {
        background-color: #ffffff;
        padding: 40px;
        width: 100%;
        max-width: 450px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
      }
      .register-container h2 {
        text-align: center;
        color: #333;
        margin-bottom: 30px;
      }
      .register-container label {
        display: block;
        margin-bottom: 8px;
        color: #444;
      }
      .register-container input[type="text"],
      .register-container input[type="password"],
      .register-container input[type="email"],
      .register-container select {
        width: 100%;
        padding: 12px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 16px;
      }
      .register-container input[type="submit"] {
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
      .register-container input[type="submit"]:hover {
        background-color: #007bff;
      }
      .login-link {
        text-align: center;
        margin-top: 20px;
      }
      .login-link a {
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
      }
      .error-message {
        color: red;
        text-align: center;
        margin-bottom: 15px;
      }
    </style>
  </head>
  <body>
    <div class="register-container">
      <h2>Create an Account</h2>

      <form action="RegisterServlet" method="POST">
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="error-message">
          <%= request.getAttribute("errorMessage") %>
        </div>
        <% } %>

        <label for="username">Username</label>
        <input type="text" id="username" name="username" required />

        <label for="email">Email</label>
        <input type="email" id="email" name="email" required />

        <label for="password">Password</label>
        <input type="password" id="password" name="password" required />

        <label for="role">Role</label>
        <select name="role" id="role" required>
          <option value="">Select Role</option>
          <option value="customer">Customer</option>
          <option value="salesman">Salesman</option>
          <option value="manager">Manager</option>
        </select>

        <input type="submit" value="Register" />
      </form>

      <div class="login-link">
        Already have an account? <a href="login.jsp">Login here</a>
      </div>
    </div>
  </body>
</html>
