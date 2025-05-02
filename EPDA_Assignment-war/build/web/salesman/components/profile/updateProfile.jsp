<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="model.Salesman"%> 
<%@taglib prefix="c"uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.SalesmanFacade"%>
<%@page import="javax.ejb.EJB"%>

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
        <label for="password">New Password</label>
        <input
          type="password"
          id="password"
          name="password"
          class="form-control"
        />
        <small class="text-muted">Leave blank to keep current password</small>
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
