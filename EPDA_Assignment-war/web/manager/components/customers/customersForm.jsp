<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="form-container">
  <h2><i class="fas fa-user-plus"></i> Add New Customer</h2>
  <form action="ManagingCustomersServlet" method="POST">
    <input type="hidden" name="action" value="addCustomer" />
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
    <div class="form-group">
      <input type="text" name="address" placeholder="Address" required />
    </div>
    <button type="submit" class="btn btn-primary">
      <i class="fas fa-plus"></i> Add Customer
    </button>
  </form>
</div>
