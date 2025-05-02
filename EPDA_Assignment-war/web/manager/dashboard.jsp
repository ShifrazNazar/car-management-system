<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ManagingStaff, model.Salesman, model.Customer, model.Car, model.Sale, model.Feedback"%>
<%@page import="java.util.List"%>
<%@page import="model.ManagingStaffFacade, model.SalesmanFacade, model.CustomerFacade, model.CarFacade, model.SaleFacade, model.FeedbackFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Car Sales System | Manager Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    
    <style>
      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: 'Poppins', sans-serif;
      }

      body {
        background-color: #f8f9fa;
        color: #2c3e50;
        line-height: 1.6;
      }

      .dashboard-container {
        display: flex;
        min-height: 100vh;
      }

      .sidebar {
        width: 280px;
        background: linear-gradient(135deg, #4361ee, #3f37c9);
        color: white;
        padding: 2rem;
        position: fixed;
        height: 100vh;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }

      .sidebar-header {
        padding: 1.5rem 0;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        margin-bottom: 2rem;
        text-align: center;
      }

      .sidebar-header h2 {
        font-size: 1.5rem;
        margin-bottom: 0.5rem;
        font-weight: 600;
      }

      .sidebar-header p {
        font-size: 0.9rem;
        opacity: 0.8;
      }

      .sidebar-menu {
        list-style: none;
      }

      .sidebar-menu li {
        margin-bottom: 0.5rem;
      }

      .sidebar-menu a {
        color: white;
        text-decoration: none;
        display: flex;
        align-items: center;
        padding: 1rem;
        border-radius: 10px;
        transition: all 0.3s ease;
      }

      .sidebar-menu a i {
        margin-right: 1rem;
        font-size: 1.2rem;
      }

      .sidebar-menu a:hover {
        background-color: rgba(255, 255, 255, 0.1);
        transform: translateX(5px);
      }

      .main-content {
        margin-left: 280px;
        padding: 2rem;
        flex: 1;
      }

      .header {
        background: white;
        padding: 1.5rem;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin-bottom: 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .header h1 {
        font-size: 1.8rem;
        color: #4361ee;
        font-weight: 600;
      }

      .user-info {
        display: flex;
        align-items: center;
        gap: 1rem;
      }

      .user-avatar {
        width: 40px;
        height: 40px;
        background-color: #4361ee;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
      }

      .stats-container {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 1.5rem;
        margin-bottom: 2rem;
      }

      .stat-card {
        background: white;
        padding: 1.5rem;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
      }

      .stat-card:hover {
        transform: translateY(-5px);
      }

      .stat-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 5px;
        background: #4361ee;
      }

      .stat-card h3 {
        color: #6c757d;
        font-size: 1rem;
        margin-bottom: 0.5rem;
        font-weight: 500;
      }

      .stat-card p {
        font-size: 2rem;
        font-weight: 600;
        color: #4361ee;
        margin: 0;
      }

      .stat-card i {
        position: absolute;
        right: 1.5rem;
        top: 1.5rem;
        font-size: 2rem;
        opacity: 0.1;
      }

      .form-container, .table-container {
        background: white;
        padding: 2rem;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin-bottom: 2rem;
      }

      .form-container h2, .table-container h2 {
        color: #4361ee;
        margin-bottom: 1.5rem;
        font-size: 1.5rem;
        font-weight: 600;
      }

      .form-group {
        margin-bottom: 1.5rem;
      }

      .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        color: #2c3e50;
        font-weight: 500;
      }

      .form-group input,
      .form-group select {
        width: 100%;
        padding: 0.8rem;
        border: 1px solid #ddd;
        border-radius: 10px;
        transition: all 0.3s ease;
      }

      .form-group input:focus,
      .form-group select:focus {
        outline: none;
        border-color: #4361ee;
        box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 1rem;
      }

      th, td {
        padding: 1rem;
        text-align: left;
        border-bottom: 1px solid #eee;
      }

      th {
        background-color: #f8f9fa;
        font-weight: 600;
        color: #6c757d;
      }

      tr:hover {
        background-color: #f8f9fa;
      }

      .btn {
        padding: 0.8rem 1.5rem;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        font-weight: 500;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
      }

      .btn i {
        font-size: 1rem;
      }

      .btn-primary {
        background-color: #4361ee;
        color: white;
      }

      .btn-primary:hover {
        background-color: #3f37c9;
        transform: translateY(-2px);
      }

      .btn-success {
        background-color: #4cc9f0;
        color: white;
      }

      .btn-success:hover {
        background-color: #3aa8d8;
        transform: translateY(-2px);
      }

      .btn-danger {
        background-color: #f72585;
        color: white;
      }

      .btn-danger:hover {
        background-color: #d61a6f;
        transform: translateY(-2px);
      }

      .message {
        padding: 1rem;
        margin-bottom: 1.5rem;
        border-radius: 10px;
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }

      .success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
      }

      .error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
      }

      .status-badge {
        padding: 0.3rem 0.8rem;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 500;
      }

      .status-available {
        background-color: #d4edda;
        color: #155724;
      }

      .status-booked {
        background-color: #fff3cd;
        color: #856404;
      }

      .status-sold {
        background-color: #f8d7da;
        color: #721c24;
      }

      .rating {
        display: flex;
        gap: 0.2rem;
      }

      .rating i {
        color: #f9c74f;
      }

      .action-buttons {
        display: flex;
        gap: 5px;
        flex-wrap: wrap;
      }

      .btn-sm {
        padding: 0.4rem 0.8rem;
        font-size: 0.875rem;
      }

      .update-form {
        margin-top: 10px;
        padding: 15px;
        background-color: #f8f9fa;
        border-radius: 5px;
        border: 1px solid #dee2e6;
      }

      .update-form .form-group {
        margin-bottom: 10px;
      }

      .update-form .form-group input,
      .update-form .form-group select {
        width: 100%;
        padding: 0.375rem 0.75rem;
        font-size: 0.875rem;
        border: 1px solid #ced4da;
        border-radius: 0.25rem;
      }

      .update-form .btn {
        margin-right: 5px;
      }
    </style>
  </head>
  <body>
    <div class="dashboard-container">
      <div class="sidebar">
        <div class="sidebar-header">
          <h2>Car Sales System</h2>
          <p>Manager Dashboard</p>
        </div>
        <ul class="sidebar-menu">
          <li><a href="#dashboard"><i class="fas fa-home"></i><span>Dashboard</span></a></li>
          <li><a href="#staff"><i class="fas fa-users-cog"></i><span>Manage Staff</span></a></li>
          <li><a href="#salesmen"><i class="fas fa-user-tie"></i><span>Manage Salesmen</span></a></li>
          <li><a href="#customers"><i class="fas fa-users"></i><span>Manage Customers</span></a></li>
          <li><a href="#cars"><i class="fas fa-car"></i><span>Manage Cars</span></a></li>
          <li><a href="#payments"><i class="fas fa-money-bill-wave"></i><span>Payment Analysis</span></a></li>
          <li><a href="#feedback"><i class="fas fa-comment-alt"></i><span>Feedback Analysis</span></a></li>
          <li><a href="login.jsp"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a></li>
        </ul>
      </div>

      <div class="main-content">
        <div class="header">
          <h1>Welcome, Shifraz</h1>
          <div class="user-info">
            <div class="user-avatar">
              S
            </div>
          </div>
        </div>

        <c:if test="${not empty message}">
          <div class="message success">
            <i class="fas fa-check-circle"></i>
            ${message}
          </div>
        </c:if>

        <c:if test="${not empty error}">
          <div class="message error">
            <i class="fas fa-exclamation-circle"></i>
            ${error}
          </div>
        </c:if>

        <div class="stats-container">
          <div class="stat-card">
            <i class="fas fa-users-cog"></i>
            <h3>Total Staff</h3>
            <p>${managingStaffFacade.count()}</p>
          </div>
          <div class="stat-card">
            <i class="fas fa-user-tie"></i>
            <h3>Total Salesmen</h3>
            <p>${salesmanFacade.count()}</p>
          </div>
          <div class="stat-card">
            <i class="fas fa-users"></i>
            <h3>Total Customers</h3>
            <p>${customerFacade.count()}</p>
          </div>
          <div class="stat-card">
            <i class="fas fa-car"></i>
            <h3>Total Cars</h3>
            <p>${carFacade.count()}</p>
          </div>
        </div>

        <!-- Staff Management Form -->
        <div class="form-container">
          <h2><i class="fas fa-user-plus"></i> Add New Staff</h2>
          <form action="ManagingStaffServlet" method="POST">
            <input type="hidden" name="action" value="addStaff">
            <div class="form-group">
              <label for="username">Username</label>
              <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
              <label for="password">Password</label>
              <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
              <label for="email">Email</label>
              <input type="email" id="email" name="email" required>
            </div>
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-plus"></i> Add Staff
            </button>
          </form>
        </div>

        <!-- Staff List -->
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

        <!-- Salesmen List -->
        <div class="table-container">
          <h2><i class="fas fa-user-tie"></i> Salesmen List</h2>
          <form action="ManagingStaffServlet" method="GET" style="margin-bottom: 20px;">
            <input type="hidden" name="action" value="searchSalesman">
            <div class="form-group" style="display: flex; gap: 10px;">
              <input type="text" name="searchTerm" placeholder="Search salesmen by name..." style="flex: 1;">
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
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${salesmanList}" var="salesman">
              <tr>
                <td>${salesman.salesmanId}</td>
                <td>${salesman.username}</td>
                <td>${salesman.email}</td>
                <td>
                  <span class="status-badge ${salesman.role eq 'approved' ? 'status-available' : 'status-booked'}">
                    ${salesman.role}
                  </span>
                </td>
                <td>
                  <div class="action-buttons">
                    <form action="ManagingStaffServlet" method="POST" style="display: inline;">
                      <input type="hidden" name="action" value="approveSalesman">
                      <input type="hidden" name="id" value="${salesman.salesmanId}">
                      <button type="submit" class="btn btn-success btn-sm">
                        <i class="fas fa-check"></i> Approve
                      </button>
                    </form>
                    <button type="button" class="btn btn-primary btn-sm" onclick="showUpdateForm('salesman-${salesman.salesmanId}')">
                      <i class="fas fa-edit"></i> Update
                    </button>
                    <form action="ManagingStaffServlet" method="POST" style="display: inline;">
                      <input type="hidden" name="action" value="deleteSalesman">
                      <input type="hidden" name="id" value="${salesman.salesmanId}">
                      <button type="submit" class="btn btn-danger btn-sm">
                        <i class="fas fa-trash"></i> Delete
                      </button>
                    </form>
                  </div>
                  <div id="salesman-${salesman.salesmanId}" class="update-form" style="display: none;">
                    <form action="ManagingStaffServlet" method="POST">
                      <input type="hidden" name="action" value="updateSalesman">
                      <input type="hidden" name="id" value="${salesman.salesmanId}">
                      <div class="form-group">
                        <input type="text" name="username" value="${salesman.username}" required>
                      </div>
                      <div class="form-group">
                        <input type="password" name="password" placeholder="New password">
                      </div>
                      <div class="form-group">
                        <input type="email" name="email" value="${salesman.email}" required>
                      </div>
                      <button type="submit" class="btn btn-success btn-sm">
                        <i class="fas fa-save"></i> Save
                      </button>
                      <button type="button" class="btn btn-secondary btn-sm" onclick="hideUpdateForm('salesman-${salesman.salesmanId}')">
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

        <!-- Customer List -->
        <div class="table-container">
          <h2><i class="fas fa-users"></i> Customer List</h2>
          <form action="ManagingStaffServlet" method="GET" style="margin-bottom: 20px;">
            <input type="hidden" name="action" value="searchCustomer">
            <div class="form-group" style="display: flex; gap: 10px;">
              <input type="text" name="searchTerm" placeholder="Search customers by name..." style="flex: 1;">
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
              <c:forEach items="${customerList}" var="customer">
              <tr>
                <td>${customer.customerId}</td>
                <td>${customer.username}</td>
                <td>${customer.email}</td>
                <td>
                  <div class="action-buttons">
                    <button type="button" class="btn btn-primary btn-sm" onclick="showUpdateForm('customer-${customer.customerId}')">
                      <i class="fas fa-edit"></i> Update
                    </button>
                    <form action="ManagingStaffServlet" method="POST" style="display: inline;">
                      <input type="hidden" name="action" value="deleteCustomer">
                      <input type="hidden" name="id" value="${customer.customerId}">
                      <button type="submit" class="btn btn-danger btn-sm">
                        <i class="fas fa-trash"></i> Delete
                      </button>
                    </form>
                  </div>
                  <div id="customer-${customer.customerId}" class="update-form" style="display: none;">
                    <form action="ManagingStaffServlet" method="POST">
                      <input type="hidden" name="action" value="updateCustomer">
                      <input type="hidden" name="id" value="${customer.customerId}">
                      <div class="form-group">
                        <input type="text" name="username" value="${customer.username}" required>
                      </div>
                      <div class="form-group">
                        <input type="password" name="password" placeholder="New password">
                      </div>
                      <div class="form-group">
                        <input type="email" name="email" value="${customer.email}" required>
                      </div>
                      <button type="submit" class="btn btn-success btn-sm">
                        <i class="fas fa-save"></i> Save
                      </button>
                      <button type="button" class="btn btn-secondary btn-sm" onclick="hideUpdateForm('customer-${customer.customerId}')">
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

        <!-- Car Management Form -->
        <div class="form-container">
          <h2><i class="fas fa-car"></i> Add New Car</h2>
          <form action="ManagingStaffServlet" method="POST">
            <input type="hidden" name="action" value="addCar">
            <div class="form-group">
              <label for="make">Make</label>
              <input type="text" id="make" name="make" required>
            </div>
            <div class="form-group">
              <label for="model">Model</label>
              <input type="text" id="model" name="model" required>
            </div>
            <div class="form-group">
              <label for="color">Color</label>
              <input type="text" id="color" name="color" required>
            </div>
            <div class="form-group">
              <label for="price">Price</label>
              <input type="number" id="price" name="price" step="0.01" required>
            </div>
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-plus"></i> Add Car
            </button>
          </form>
        </div>

        <!-- Car List -->
        <div class="table-container">
          <h2><i class="fas fa-car"></i> Car List</h2>
          <form action="ManagingStaffServlet" method="GET" style="margin-bottom: 20px;">
            <input type="hidden" name="action" value="searchCar">
            <div class="form-group" style="display: flex; gap: 10px;">
              <input type="text" name="searchTerm" placeholder="Search cars by model..." style="flex: 1;">
              <button type="submit" class="btn btn-primary">
                <i class="fas fa-search"></i> Search
              </button>
            </div>
          </form>
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Make</th>
                <th>Model</th>
                <th>Color</th>
                <th>Price</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${carList}" var="car">
              <tr>
                <td>${car.carId}</td>
                <td>${car.make}</td>
                <td>${car.model}</td>
                <td>${car.color}</td>
                <td>$${car.price}</td>
                <td>
                  <span class="status-badge ${car.status eq 'available' ? 'status-available' : 
                    (car.status eq 'booked' ? 'status-booked' : 'status-sold')}">
                    ${car.status}
                  </span>
                </td>
                <td>
                  <div class="action-buttons">
                    <button type="button" class="btn btn-primary btn-sm" onclick="showUpdateForm('car-${car.carId}')">
                      <i class="fas fa-edit"></i> Update
                    </button>
                    <form action="ManagingStaffServlet" method="POST" style="display: inline;">
                      <input type="hidden" name="action" value="deleteCar">
                      <input type="hidden" name="id" value="${car.carId}">
                      <button type="submit" class="btn btn-danger btn-sm">
                        <i class="fas fa-trash"></i> Delete
                      </button>
                    </form>
                  </div>
                  <div id="car-${car.carId}" class="update-form" style="display: none;">
                    <form action="ManagingStaffServlet" method="POST">
                      <input type="hidden" name="action" value="updateCar">
                      <input type="hidden" name="id" value="${car.carId}">
                      <div class="form-group">
                        <input type="text" name="make" value="${car.make}" required>
                      </div>
                      <div class="form-group">
                        <input type="text" name="model" value="${car.model}" required>
                      </div>
                      <div class="form-group">
                        <input type="text" name="color" value="${car.color}" required>
                      </div>
                      <div class="form-group">
                        <input type="number" name="price" value="${car.price}" step="0.01" required>
                      </div>
                      <div class="form-group">
                        <select name="status" required>
                          <option value="available" ${car.status eq 'available' ? 'selected' : ''}>Available</option>
                          <option value="booked" ${car.status eq 'booked' ? 'selected' : ''}>Booked</option>
                          <option value="sold" ${car.status eq 'sold' ? 'selected' : ''}>Sold</option>
                        </select>
                      </div>
                      <button type="submit" class="btn btn-success btn-sm">
                        <i class="fas fa-save"></i> Save
                      </button>
                      <button type="button" class="btn btn-secondary btn-sm" onclick="hideUpdateForm('car-${car.carId}')">
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

        <!-- Payment Analysis -->
        <div class="table-container">
          <h2><i class="fas fa-money-bill-wave"></i> Payment Analysis</h2>
          <form action="ManagingStaffServlet" method="GET">
            <input type="hidden" name="action" value="viewPayments">
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-eye"></i> View Payments
            </button>
          </form>
          <table>
            <thead>
              <tr>
                <th>Sale ID</th>
                <th>Car</th>
                <th>Customer</th>
                <th>Salesman</th>
                <th>Amount</th>
                <th>Date</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${saleList}" var="sale">
              <tr>
                <td>${sale.saleId}</td>
                <td>${sale.car.make} ${sale.car.model}</td>
                <td>${sale.customer.username}</td>
                <td>${sale.salesman.username}</td>
                <td>$${sale.amountPaid}</td>
                <td>${sale.saleDate}</td>
                <td>
                  <span class="status-badge ${sale.status eq 'completed' ? 'status-available' : 'status-booked'}">
                    ${sale.status}
                  </span>
                </td>
              </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <!-- Feedback Analysis -->
        <div class="table-container">
          <h2><i class="fas fa-comment-alt"></i> Feedback Analysis</h2>
          <form action="ManagingStaffServlet" method="GET">
            <input type="hidden" name="action" value="viewFeedback">
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-eye"></i> View Feedback
            </button>
          </form>
          <table>
            <thead>
              <tr>
                <th>Feedback ID</th>
                <th>Car</th>
                <th>Customer</th>
                <th>Rating</th>
                <th>Comment</th>
                <th>Date</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${feedbackList}" var="feedback">
              <tr>
                <td>${feedback.feedbackId}</td>
                <td>${feedback.car.make} ${feedback.car.model}</td>
                <td>${feedback.customer.username}</td>
                <td>
                  <div class="rating">
                    <c:forEach begin="1" end="${feedback.rating}">
                      <i class="fas fa-star"></i>
                    </c:forEach>
                  </div>
                </td>
                <td>${feedback.comment}</td>
                <td>${feedback.submittedAt}</td>
              </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <script>
      function showUpdateForm(id) {
        document.getElementById(id).style.display = 'block';
      }

      function hideUpdateForm(id) {
        document.getElementById(id).style.display = 'none';
      }
    </script>
  </body>
</html>
