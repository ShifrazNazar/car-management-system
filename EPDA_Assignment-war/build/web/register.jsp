<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Car Sales System | Register</title>
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

      .register-container {
        background-color: #ffffff;
        padding: 1.5rem;
        width: 100%;
        max-width: 400px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
      }

      .register-container h2 {
        text-align: center;
        color: #4361ee;
        margin-bottom: 1.2rem;
        font-size: 1.5rem;
        font-weight: 600;
      }

      .form-group {
        margin-bottom: 1rem;
      }

      .form-group label {
        display: block;
        margin-bottom: 0.3rem;
        color: #2c3e50;
        font-weight: 500;
        font-size: 0.9rem;
      }

      .form-group input,
      .form-group select {
        width: 100%;
        padding: 0.6rem;
        border: 1px solid #ddd;
        border-radius: 8px;
        transition: all 0.3s ease;
        font-size: 0.9rem;
      }

      .form-group input:focus,
      .form-group select:focus {
        outline: none;
        border-color: #4361ee;
        box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
      }

      .btn {
        width: 100%;
        padding: 0.6rem;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 500;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        font-size: 0.9rem;
      }

      .btn-primary {
        background-color: #4361ee;
        color: white;
      }

      .btn-primary:hover {
        background-color: #3f37c9;
        transform: translateY(-2px);
      }

      .login-link {
        text-align: center;
        margin-top: 1rem;
        font-size: 0.9rem;
      }

      .login-link a {
        color: #4361ee;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s ease;
      }

      .login-link a:hover {
        color: #3f37c9;
      }

      .error-message {
        background-color: #f8d7da;
        color: #721c24;
        padding: 0.8rem;
        border-radius: 8px;
        margin-bottom: 1rem;
        border: 1px solid #f5c6cb;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 0.9rem;
      }

      .error-message i {
        font-size: 1rem;
      }
    </style>
  </head>
  <body>
    <div class="register-container">
      <h2>Create an Account</h2>

      <form action="RegisterServlet" method="POST">
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
          <label for="email">Email</label>
          <input type="email" id="email" name="email" required />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" required />
        </div>

        <div class="form-group">
          <label for="role">Role</label>
          <select name="role" id="role" required>
            <option value="">Select Role</option>
            <option value="customer">Customer</option>
            <option value="salesman">Salesman</option>
            <option value="manager">Manager</option>
          </select>
        </div>

        <button type="submit" class="btn btn-primary">
          <i class="fas fa-user-plus"></i> Register
        </button>
      </form>

      <div class="login-link">
        Already have an account? <a href="login.jsp">Login here</a>
      </div>
    </div>
  </body>
</html>
