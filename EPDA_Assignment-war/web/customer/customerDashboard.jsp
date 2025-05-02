<%-- 
    Document   : customerDashboard
    Created on : 30-Apr-2025, 12:31:00
    Author     : Shifraz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Car Sales System | Customer Dashboard</title>
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

      .status-sold {
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

      .purchase-history {
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
      }

      .purchase-history h2 {
        margin-bottom: 20px;
      }

      .purchase-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px;
        border-bottom: 1px solid #eee;
      }

      .purchase-item:last-child {
        border-bottom: none;
      }

      .feedback-form {
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }

      .feedback-form h2 {
        margin-bottom: 20px;
      }

      .form-group {
        margin-bottom: 15px;
      }

      .form-group label {
        display: block;
        margin-bottom: 5px;
      }

      .form-group input,
      .form-group textarea,
      .form-group select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
      }

      .rating {
        display: flex;
        gap: 10px;
      }

      .rating input[type="radio"] {
        display: none;
      }

      .rating label {
        font-size: 24px;
        color: #ddd;
        cursor: pointer;
      }

      .rating input[type="radio"]:checked ~ label {
        color: #f1c40f;
      }
    </style>
  </head>
  <body>
    <div class="dashboard-container">
      <div class="sidebar">
        <div class="sidebar-header">
          <h2>Car Sales System</h2>
          <p>Customer Dashboard</p>
        </div>
        <ul class="sidebar-menu">
          <li><a href="#dashboard">Dashboard</a></li>
          <li><a href="#profile">My Profile</a></li>
          <li><a href="#purchases">Purchase History</a></li>
          <li><a href="#feedback">Give Feedback</a></li>
          <li><a href="login.jsp">Logout</a></li>
        </ul>
      </div>

      <div class="main-content">
        <div class="header">
          <h1>Welcome, ${sessionScope.user.username}</h1>
        </div>

        <h2>Available Cars</h2>
        <div class="car-grid">
          <div class="car-card">
            <img src="car1.jpg" alt="Car Image" class="car-image" />
            <div class="car-details">
              <span class="car-status status-available">Available</span>
              <h3>Toyota Camry 2024</h3>
              <p>Price: $25,000</p>
              <p>Mileage: 0 km</p>
              <button class="btn btn-primary">View Details</button>
              <button class="btn btn-success">Book Now</button>
            </div>
          </div>

          <div class="car-card">
            <img src="car2.jpg" alt="Car Image" class="car-image" />
            <div class="car-details">
              <span class="car-status status-available">Available</span>
              <h3>Honda Civic 2024</h3>
              <p>Price: $22,000</p>
              <p>Mileage: 0 km</p>
              <button class="btn btn-primary">View Details</button>
              <button class="btn btn-success">Book Now</button>
            </div>
          </div>
        </div>

        <div class="purchase-history">
          <h2>Purchase History</h2>
          <div class="purchase-item">
            <div>
              <h3>Ford Mustang 2024</h3>
              <p>Purchase Date: 2024-04-15</p>
              <p>Price: $35,000</p>
            </div>
            <button class="btn btn-primary">Give Feedback</button>
          </div>
          <div class="purchase-item">
            <div>
              <h3>Toyota Corolla 2023</h3>
              <p>Purchase Date: 2023-12-20</p>
              <p>Price: $20,000</p>
            </div>
            <button class="btn btn-primary">Give Feedback</button>
          </div>
        </div>

        <div class="feedback-form">
          <h2>Give Feedback</h2>
          <form action="FeedbackServlet" method="POST">
            <div class="form-group">
              <label for="car">Select Car</label>
              <select name="car" id="car" required>
                <option value="">Select a car</option>
                <option value="1">Ford Mustang 2024</option>
                <option value="2">Toyota Corolla 2023</option>
              </select>
            </div>

            <div class="form-group">
              <label>Rating</label>
              <div class="rating">
                <input type="radio" name="rating" id="star1" value="1" />
                <label for="star1">★</label>
                <input type="radio" name="rating" id="star2" value="2" />
                <label for="star2">★</label>
                <input type="radio" name="rating" id="star3" value="3" />
                <label for="star3">★</label>
                <input type="radio" name="rating" id="star4" value="4" />
                <label for="star4">★</label>
                <input type="radio" name="rating" id="star5" value="5" />
                <label for="star5">★</label>
              </div>
            </div>

            <div class="form-group">
              <label for="comment">Comment</label>
              <textarea
                name="comment"
                id="comment"
                rows="4"
                required
              ></textarea>
            </div>

            <button type="submit" class="btn btn-primary">
              Submit Feedback
            </button>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>
