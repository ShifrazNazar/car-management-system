<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@page
import="model.Salesman"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>My Profile</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
    />
    <link rel="stylesheet" href="css/styles.css" />
  </head>
  <body>
    <div class="dashboard-container">
      <jsp:include page="components/sidebar.jsp">
        <jsp:param name="currentPage" value="profile" />
      </jsp:include>

      <div class="main-content">
        <div class="header">
          <h1>My Profile</h1>
          <div class="user-info">
            <div class="user-avatar">
              ${sessionScope.user.username.charAt(0)}
            </div>
            <span>${sessionScope.user.username}</span>
          </div>
        </div>

        <c:if test="${not empty successMessage}">
          <div class="message success">
            <i class="fas fa-check-circle"></i>
            ${successMessage}
          </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
          <div class="message error">
            <i class="fas fa-exclamation-circle"></i>
            ${errorMessage}
          </div>
        </c:if>

        <div class="card">
          <div class="card-header">
            <h2><i class="fas fa-user-edit"></i> Edit Profile</h2>
          </div>
          <div class="card-body">
            <form
              id="profileForm"
              action="SalesmanServlet"
              method="POST"
              class="profile-form"
            >
              <input type="hidden" name="action" value="updateProfile" />

              <div class="form-group">
                <label for="username">Username</label>
                <input
                  type="text"
                  id="username"
                  name="username"
                  class="form-control"
                  value="${sessionScope.user.username}"
                  required
                />
              </div>

              <div class="form-group">
                <label for="email">Email</label>
                <input
                  type="email"
                  id="email"
                  name="email"
                  class="form-control"
                  value="${sessionScope.user.email}"
                  required
                />
              </div>

              <div class="form-group">
                <label for="phone">Phone Number</label>
                <input
                  type="tel"
                  id="phone"
                  name="phone"
                  class="form-control"
                  value="${sessionScope.user.phone}"
                />
              </div>

              <div class="form-group">
                <label for="password">New Password</label>
                <input
                  type="password"
                  id="password"
                  name="password"
                  class="form-control"
                />
                <small class="text-muted"
                  >Leave blank to keep current password</small
                >
              </div>

              <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input
                  type="password"
                  id="confirmPassword"
                  name="confirmPassword"
                  class="form-control"
                />
              </div>

              <div class="form-group">
                <label for="address">Address</label>
                <textarea
                  id="address"
                  name="address"
                  class="form-control"
                  rows="3"
                >
${sessionScope.user.address}</textarea
                >
              </div>

              <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                  <i class="fas fa-save"></i> Update Profile
                </button>
                <a href="SalesmanServlet" class="btn btn-secondary">
                  <i class="fas fa-times"></i> Cancel
                </a>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <script src="js/main.js"></script>
  </body>
</html>
