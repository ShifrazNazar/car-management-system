<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Salesman Dashboard</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .section {
                margin-bottom: 30px;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
            }
            input[type="text"],
            input[type="password"],
            input[type="email"],
            input[type="number"],
            textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            button {
                background-color: #4CAF50;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            button:hover {
                background-color: #45a049;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #f2f2f2;
            }
            .message {
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 4px;
            }
            .success {
                background-color: #dff0d8;
                color: #3c763d;
            }
            .error {
                background-color: #f2dede;
                color: #a94442;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Salesman Dashboard</h1>
            
            <c:if test="${not empty message}">
                <div class="message success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>

            <!-- Profile Management Section -->
            <div class="section">
                <h2>Profile Management</h2>
                <form action="SalesmanServlet" method="POST">
                    <input type="hidden" name="action" value="updateProfile">
                    <div class="form-group">
                        <label>Username:</label>
                        <input type="text" name="username" value="${sessionScope.user.username}">
                    </div>
                    <div class="form-group">
                        <label>Password:</label>
                        <input type="password" name="password" placeholder="Enter new password">
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="email" value="${sessionScope.user.email}">
                    </div>
                    <button type="submit">Update Profile</button>
                </form>
            </div>

            <!-- Car Management Section -->
            <div class="section">
                <h2>Car Management</h2>
                <form action="SalesmanServlet" method="GET">
                    <input type="hidden" name="action" value="searchCars">
                    <div class="form-group">
                        <label>Search Cars:</label>
                        <input type="text" name="searchTerm" placeholder="Enter car model">
                    </div>
                    <button type="submit">Search</button>
                </form>

                <table>
                    <tr>
                        <th>Make</th>
                        <th>Model</th>
                        <th>Color</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    <c:forEach items="${carList}" var="car">
                        <tr>
                            <td>${car.make}</td>
                            <td>${car.model}</td>
                            <td>${car.color}</td>
                            <td>$${car.price}</td>
                            <td>${car.status}</td>
                            <td>
                                <form action="SalesmanServlet" method="POST" style="display: inline;">
                                    <input type="hidden" name="action" value="updateCarStatus">
                                    <input type="hidden" name="carId" value="${car.carId}">
                                    <select name="status">
                                        <option value="available">Available</option>
                                        <option value="booked">Booked</option>
                                        <option value="paid">Paid</option>
                                        <option value="cancel">Cancel</option>
                                    </select>
                                    <button type="submit">Update</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <!-- Sales Management Section -->
            <div class="section">
                <h2>Sales Management</h2>
                <table>
                    <tr>
                        <th>Car</th>
                        <th>Customer</th>
                        <th>Amount Paid</th>
                        <th>Status</th>
                        <th>Comments</th>
                        <th>Action</th>
                    </tr>
                    <c:forEach items="${saleList}" var="sale">
                        <tr>
                            <td>${sale.car.make} ${sale.car.model}</td>
                            <td>${sale.customer.username}</td>
                            <td>$${sale.amountPaid}</td>
                            <td>${sale.status}</td>
                            <td>${sale.comment}</td>
                            <td>
                                <c:if test="${sale.status eq 'booked'}">
                                    <form action="SalesmanServlet" method="POST">
                                        <input type="hidden" name="action" value="processPayment">
                                        <input type="hidden" name="saleId" value="${sale.saleId}">
                                        <div class="form-group">
                                            <input type="number" name="amountPaid" placeholder="Amount" step="0.01" required>
                                        </div>
                                        <div class="form-group">
                                            <textarea name="comment" placeholder="Comments"></textarea>
                                        </div>
                                        <button type="submit">Process Payment</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </body>
</html>
