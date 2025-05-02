<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ManagingStaff"%>
<%@page import="java.util.List"%>
<%@page import="model.ManagingStaffFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="table-container">
  <h2><i class="fas fa-users-cog"></i> Staff List</h2>
  <form action="ManagingStaffServlet" method="GET" style="margin-bottom: 20px;">
    <input type="hidden" name="action" value="searchStaff">
    <div class="form-group" style="display: flex; gap: 10px;">
      <input type="text" name="searchTerm" placeholder="Search staff by name..." style="flex: 1;">
      <button type="submit" class="btn btn-primary">
        <i class="fas fa-search"></i> Search
      </button>
    </div>
  </form>
  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${staffList}" var="staff">
      <tr>
        <td>${staff.id}</td>
        <td>${staff.username}</td>
        <td>${staff.email}</td>
        <td>
          <div class="action-buttons">
            <button type="button" class="btn btn-primary btn-sm" onclick="showUpdateForm('staff-${staff.id}')">
              <i class="fas fa-edit"></i> Update
            </button>
            <form action="ManagingStaffServlet" method="POST" style="display: inline;">
              <input type="hidden" name="action" value="deleteStaff">
              <input type="hidden" name="id" value="${staff.id}">
              <button type="submit" class="btn btn-danger btn-sm">
                <i class="fas fa-trash"></i> Delete
              </button>
            </form>
          </div>
          <div id="staff-${staff.id}" class="update-form" style="display: none;">
            <form action="ManagingStaffServlet" method="POST">
              <input type="hidden" name="action" value="updateStaff">
              <input type="hidden" name="id" value="${staff.id}">
              <div class="form-group">
                <input type="text" name="username" value="${staff.username}" required>
              </div>
              <div class="form-group">
                <input type="password" name="password" placeholder="New password">
              </div>
              <div class="form-group">
                <input type="email" name="email" value="${staff.email}" required>
              </div>
              <button type="submit" class="btn btn-success btn-sm">
                <i class="fas fa-save"></i> Save
              </button>
              <button type="button" class="btn btn-secondary btn-sm" onclick="hideUpdateForm('staff-${staff.id}')">
                <i class="fas fa-times"></i> Cancel
              </button>
            </form>
          </div>
        </td>
      </tr>
      </c:forEach>
    </tbody>
  </table>
</div> 