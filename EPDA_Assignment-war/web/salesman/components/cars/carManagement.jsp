<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Car"%>
<%@page import="model.CarFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="table-container">
    <h2>Manage Cars</h2>
    
    <!-- Search Form -->
    <form action="SalesmanServlet" method="GET" class="search-form">
        <input type="hidden" name="action" value="searchCars">
        <div class="form-group">
            <input type="text" name="searchTerm" placeholder="Search by model..." class="form-control">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search"></i> Search
            </button>
        </div>
    </form>

    <!-- Cars Table -->
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
            <c:forEach var="car" items="${carList}">
                <tr>
                    <td>${car.carId}</td>
                    <td>${car.make}</td>
                    <td>${car.model}</td>
                    <td>${car.color}</td>
                    <td>$${car.price}</td>
                    <td>
                        <span class="status-badge status-${car.status}">
                            ${car.status}
                        </span>
                    </td>
                    <td class="action-buttons">
                        <button onclick="showUpdateForm('updateCarForm${car.carId}')" class="btn btn-sm btn-primary">
                            <i class="fas fa-edit"></i> Update Status
                        </button>
                    </td>
                </tr>
                <!-- Update Form -->
                <tr id="updateCarForm${car.carId}" style="display: none;">
                    <td colspan="7">
                        <div class="update-form">
                            <form action="SalesmanServlet" method="POST">
                                <input type="hidden" name="action" value="updateCarStatus">
                                <input type="hidden" name="carId" value="${car.carId}">
                                <div class="form-group">
                                    <label>Status</label>
                                    <select name="status" class="form-control" required>
                                        <option value="available" ${car.status == 'available' ? 'selected' : ''}>Available</option>
                                        <option value="booked" ${car.status == 'booked' ? 'selected' : ''}>Booked</option>
                                        <option value="paid" ${car.status == 'paid' ? 'selected' : ''}>Paid</option>
                                        <option value="cancel" ${car.status == 'cancel' ? 'selected' : ''}>Cancel</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-save"></i> Save
                                    </button>
                                    <button type="button" onclick="hideUpdateForm('updateCarForm${car.carId}')" class="btn btn-danger">
                                        <i class="fas fa-times"></i> Cancel
                                    </button>
                                </div>
                            </form>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div> 