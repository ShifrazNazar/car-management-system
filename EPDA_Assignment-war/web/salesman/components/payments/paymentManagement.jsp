<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Sale"%>
<%@page import="model.SaleFacade"%>
<%@page import="model.Car"%>
<%@page import="model.Customer"%>
<%@page import="javax.ejb.EJB"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="table-container">
    <h2>Payments & Comments</h2>

    <!-- Pending Payments Table -->
    <table>
        <thead>
            <tr>
                <th>Sale ID</th>
                <th>Car Details</th>
                <th>Car Price</th>
                <th>Customer</th>
                <th>Amount Paid</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="sale" items="${saleList}">
                <c:if test="${!'paid'.equals(sale.status)}">
                    <tr>
                        <td>${sale.saleId}</td>
                        <td>${sale.car.make} ${sale.car.model}</td>
                        <td>$${sale.car.price}</td>
                        <td>${sale.customer.username}</td>
                        <td>$${sale.amountPaid}</td>
                        <td>
                            <span class="status-badge status-${sale.status}">
                                ${sale.status}
                            </span>
                        </td>
                        <td class="action-buttons">
                            <button onclick="showUpdateForm('paymentForm${sale.saleId}')" class="btn btn-sm btn-success">
                                <i class="fas fa-money-bill-wave"></i> Process Payment
                            </button>
                        </td>
                    </tr>
                    <!-- Payment Form -->
                    <tr id="paymentForm${sale.saleId}" style="display: none;">
                        <td colspan="7">
                            <div class="update-form">
                                <form action="SalesmanServlet" method="POST">
                                    <input type="hidden" name="action" value="processPayment">
                                    <input type="hidden" name="saleId" value="${sale.saleId}">
                                    <div class="form-group">
                                        <label>Amount Paid</label>
                                        <input type="number" name="amountPaid" class="form-control" 
                                               min="0" step="0.01" value="${sale.car.price}" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Comments</label>
                                        <textarea name="comment" class="form-control" rows="3"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-save"></i> Save Payment
                                        </button>
                                        <button type="button" onclick="hideUpdateForm('paymentForm${sale.saleId}')" class="btn btn-danger">
                                            <i class="fas fa-times"></i> Cancel
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </tbody>
    </table>
</div> 