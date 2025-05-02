<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="form-container">
  <h2><i class="fas fa-user-plus"></i> Add New Salesman</h2>
  <form action="ManagingSalesmenServlet" method="POST">
    <input type="hidden" name="action" value="addSalesman" />
    <div class="form-group">
      <input type="text" name="username" placeholder="Username" required />
    </div>
    <div class="form-group">
      <input type="password" name="password" placeholder="Password" required />
    </div>
    <div class="form-group">
      <input type="email" name="email" placeholder="Email" required />
    </div>
    <div class="form-group">
      <input type="text" name="name" placeholder="Full Name" required />
    </div>
    <div class="form-group">
      <input type="text" name="phone" placeholder="Phone Number" required />
    </div>
    <button type="submit" class="btn btn-primary">
      <i class="fas fa-plus"></i> Add Salesman
    </button>
  </form>
</div>
