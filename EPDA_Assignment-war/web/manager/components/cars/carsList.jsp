<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Car"%>
<%@page import="java.util.List"%>
<%@page import="model.CarFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
                                                    (car.status eq 'booked' ? 'status-booked' : 
                                                    (car.status eq 'paid' ? 'status-paid' : 
                                                    (car.status eq 'cancel' ? 'status-cancel' : 'status-sold')))}">
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
