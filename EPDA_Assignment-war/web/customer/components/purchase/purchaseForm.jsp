<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Car"%>
<%@page import="model.CarFacade"%>
<%@page import="model.Salesman"%>
<%@page import="model.SalesmanFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="purchase-container">
    <h2><i class="fas fa-car"></i> Available Cars</h2>
    
    <c:if test="${not empty errorMessage}">
        <div class="message error">
            <i class="fas fa-exclamation-circle"></i>
            ${errorMessage}
        </div>
    </c:if>

    <div class="car-grid">
        <c:forEach items="${availableCars}" var="car">
            <div class="car-card">
                <div class="car-details">
                    <h3>${car.make} ${car.model}</h3>
                    <p class="car-price">$${car.price}</p>
                    <p class="car-color">Color: ${car.color}</p>
                    <p class="car-status">Status: ${car.status}</p>
                </div>
                <form action="CustomerServlet" method="POST" class="purchase-form">
                    
                    <input type="hidden" name="action" value="submitPurchase">
                    <input type="hidden" name="carId" value="${car.carId}">
                    <div class="form-group">
                        <label for="salesmanId_${car.carId}">Select Salesman:</label>
                        <select name="salesmanId" id="salesmanId_${car.carId}" class="form-control" required>
                            <option value="">Choose a salesman...</option>
                            <c:forEach items="${salesmen}" var="salesman">
                                <option value="${salesman.salesmanId}">${salesman.username}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary" ${car.status ne 'available' ? 'disabled' : ''}>
                        <i class="fas fa-shopping-cart"></i> Purchase
                    </button>
                </form>
            </div>
        </c:forEach>
    </div>
</div>
