<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ManagingStaff"%>
<%@page import="java.util.List"%>
<%@page import="model.ManagingStaffFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="form-container" id="staff">
  <h2><i class="fas fa-user-plus"></i> Add New Staff</h2>
  <form action="ManagingStaffServlet" method="POST">
    <input type="hidden" name="action" value="addStaff" />
    <div class="form-group">
      <label for="username">Username</label>
      <input type="text" id="username" name="username" required />
    </div>
    <div class="form-group">
      <label for="password">Password</label>
      <input type="password" id="password" name="password" required />
    </div>
    <div class="form-group">
      <label for="email">Email</label>
      <input type="email" id="email" name="email" required />
    </div>
    <button type="submit" class="btn btn-primary">
      <i class="fas fa-plus"></i> Add Staff
    </button>
  </form>
</div>
