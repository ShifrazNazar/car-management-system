<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Car"%>
<%@page import="model.CarFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="card">
    <div class="card-header">
        <h2><i class="fas fa-car"></i> Update Car Status</h2>
    </div>
    <div class="card-body">
        <form action="SalesmanServlet" method="POST" class="car-status-form">
            <input type="hidden" name="action" value="updateCarStatus">
            <input type="hidden" name="carId" value="${param.carId}">
            
            <div class="form-group">
                <label for="status">Status</label>
                <select name="status" id="status" class="form-control" required>
                    <option value="AVAILABLE" ${param.currentStatus == 'AVAILABLE' ? 'selected' : ''}>Available</option>
                    <option value="PENDING" ${param.currentStatus == 'PENDING' ? 'selected' : ''}>Booked</option>
                    <option value="SOLD" ${param.currentStatus == 'SOLD' ? 'selected' : ''}>Paid</option>
                    <option value="CANCELLED" ${param.currentStatus == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                </select>
            </div>

            <div class="form-group">
                <label for="comment">Comments</label>
                <textarea id="comment" name="comment" class="form-control" rows="3">${param.comment}</textarea>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Update Status
                </button>
                <a href="SalesmanServlet" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</div>
