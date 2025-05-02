<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Car"%>
<%@page import="model.CarFacade"%>
<%@page import="javax.ejb.EJB"%>

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
