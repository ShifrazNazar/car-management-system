<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Car Sales System | Salesman Dashboard</title>
    <style>
      * {
        box-sizing: border-box;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
      }

      body {
        background-color: #f5f5f5;
      }

      .dashboard-container {
        display: flex;
        min-height: 100vh;
      }

      .sidebar {
        width: 250px;
        background: #2c3e50;
        color: white;
        padding: 20px;
        position: fixed;
        height: 100vh;
      }

      .sidebar-header {
        padding: 20px 0;
        border-bottom: 1px solid #34495e;
        margin-bottom: 20px;
      }

      .sidebar-menu {
        list-style: none;
      }

      .sidebar-menu li {
        margin-bottom: 10px;
      }

      .sidebar-menu a {
        color: white;
        text-decoration: none;
        display: block;
        padding: 10px;
        border-radius: 5px;
        transition: background-color 0.3s;
      }

      .sidebar-menu a:hover {
        background-color: #34495e;
      }

      .main-content {
        margin-left: 250px;
        padding: 20px;
        flex: 1;
      }

      .header {
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
      }

      .stats-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
      }

      .stat-card {
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }

      .stat-card h3 {
        color: #2c3e50;
        margin-bottom: 10px;
      }

      .stat-card p {
        font-size: 24px;
        font-weight: bold;
        color: #3498db;
      }

      .car-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
      }

      .car-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        overflow: hidden;
      }

      .car-image {
        width: 100%;
        height: 200px;
        object-fit: cover;
      }

      .car-details {
        padding: 20px;
      }

      .car-status {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 15px;
        font-size: 12px;
        font-weight: bold;
        margin-bottom: 10px;
      }

      .status-available {
        background-color: #2ecc71;
        color: white;
      }

      .status-booked {
        background-color: #f1c40f;
        color: white;
      }

      .status-paid {
        background-color: #3498db;
        color: white;
      }

      .status-cancelled {
        background-color: #e74c3c;
        color: white;
      }

      .btn {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
        transition: background-color 0.3s;
        width: 100%;
        margin-top: 10px;
      }

      .btn-primary {
        background-color: #3498db;
        color: white;
      }

      .btn-primary:hover {
        background-color: #2980b9;
      }

      .btn-success {
        background-color: #2ecc71;
        color: white;
      }

      .btn-success:hover {
        background-color: #27ae60;
      }

      .btn-warning {
        background-color: #f1c40f;
        color: white;
      }

      .btn-warning:hover {
        background-color: #f39c12;
      }
    </style>
  </head>
  <body>
    <div class="dashboard-container">
      <div class="sidebar">
        <div class="sidebar-header">
          <h2>Car Sales System</h2>
          <p>Salesman Dashboard</p>
        </div>
        <ul class="sidebar-menu">
          <li><a href="#dashboard">Dashboard</a></li>
          <li><a href="#profile">My Profile</a></li>
          <li><a href="#cars">Manage Cars</a></li>
          <li><a href="#sales">Sales Records</a></li>
          <li><a href="#payments">Payment Collection</a></li>
          <li><a href="login.jsp">Logout</a></li>
        </ul>
      </div>

      <div class="main-content">
        <div class="header">
          <h1>Welcome, ${sessionScope.user.username}</h1>
        </div>

        <div class="stats-container">
          <div class="stat-card">
            <h3>Total Sales</h3>
            <p>${totalSales}</p>
          </div>
          <div class="stat-card">
            <h3>Available Cars</h3>
            <p>${availableCars}</p>
          </div>
          <div class="stat-card">
            <h3>Pending Payments</h3>
            <p>${pendingPayments}</p>
          </div>
          <div class="stat-card">
            <h3>Customer Rating</h3>
            <p>${customerRating}/5</p>
          </div>
        </div>

        <h2>My Cars</h2>
        <div class="car-grid">
          <div class="car-card">
            <img src="car1.jpg" alt="Car Image" class="car-image" />
            <div class="car-details">
              <span class="car-status status-available">Available</span>
              <h3>Toyota Camry 2024</h3>
              <p>Price: $25,000</p>
              <p>Mileage: 0 km</p>
              <button class="btn btn-primary">Update Status</button>
              <button class="btn btn-success">Collect Payment</button>
            </div>
          </div>

          <div class="car-card">
            <img src="car2.jpg" alt="Car Image" class="car-image" />
            <div class="car-details">
              <span class="car-status status-booked">Booked</span>
              <h3>Honda Civic 2024</h3>
              <p>Price: $22,000</p>
              <p>Mileage: 0 km</p>
              <button class="btn btn-primary">Update Status</button>
              <button class="btn btn-warning">View Booking Details</button>
            </div>
          </div>

          <div class="car-card">
            <img src="car3.jpg" alt="Car Image" class="car-image" />
            <div class="car-details">
              <span class="car-status status-paid">Paid</span>
              <h3>Ford Mustang 2024</h3>
              <p>Price: $35,000</p>
              <p>Mileage: 0 km</p>
              <button class="btn btn-primary">Update Status</button>
              <button class="btn btn-success">View Sale Details</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
