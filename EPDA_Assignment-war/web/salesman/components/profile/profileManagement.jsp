<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="model.Salesman"%> 
<%@page import="model.SalesmanFacade"%> 
<%@page import="model.Sale"%> 
<%@page import="model.Car"%> 
<%@page import="javax.ejb.EJB"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="form-container">
  <h2>My Profile</h2>
  <form action="SalesmanServlet" method="POST">
    <input type="hidden" name="action" value="updateProfile" />

    <div class="form-group">
      <label>Username</label>
      <input
        type="text"
        name="username"
        value="${user.username}"
        class="form-control"
        required
      />
    </div>

    <div class="form-group">
      <label>Email</label>
      <input
        type="email"
        name="email"
        value="${user.email}"
        class="form-control"
        required
      />
    </div>

    <div class="form-group">
      <label>Password</label>
      <input
        type="password"
        name="password"
        placeholder="Leave blank to keep current password"
        class="form-control"
      />
    </div>

    <div class="form-group">
      <button type="submit" class="btn btn-primary">
        <i class="fas fa-save"></i> Update Profile
      </button>
    </div>
  </form>
</div>

<!-- Profile Statistics -->
<div class="stats-container">
  <div class="stat-card">
    <h3>Total Sales</h3>
    <p>${saleList.size()}</p>
    <i class="fas fa-chart-line"></i>
  </div>

  <div class="stat-card">
    <h3>Cars Managed</h3>
    <p>${carList.size()}</p>
    <i class="fas fa-car"></i>
  </div>

  <div class="stat-card">
    <h3>Pending Payments</h3>
    <p>${saleList.stream().filter(s -> s.status != 'paid').count()}</p>
    <i class="fas fa-money-bill-wave"></i>
  </div>
</div>
