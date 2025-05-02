<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="model.Car"%> 
<%@page import="model.CarFacade"%>
<%@page import="java.util.List"%> 
<%@taglib prefix="c"uri="http://java.sun.com/jsp/jstl/core"%>

<div class="card mb-4">
  <div class="card-header">
    <h2><i class="fas fa-car"></i> Available Cars</h2>
  </div>
  <div class="card-body">
    <div class="table-responsive">
      <table class="table">
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
          <c:forEach items="${cars}" var="car">
            <tr>
              <td>${car.id}</td>
              <td>${car.make}</td>
              <td>${car.model}</td>
              <td>${car.color}</td>
              <td>$${car.price}</td>
              <td>
                <span
                  class="status-badge ${car.status eq 'AVAILABLE' ? 'status-available' : car.status eq 'PENDING' ? 'status-booked' : car.status eq 'SOLD' ? 'status-sold' : 'status-cancelled'}"
                >
                  ${car.status}
                </span>
              </td>
              <td>
                <div class="btn-group">
                  <a
                    href="SalesmanServlet?action=updateCar&carId=${car.id}"
                    class="btn btn-sm btn-primary"
                  >
                    <i class="fas fa-edit"></i> Update Status
                  </a>
                  <c:if test="${car.status == 'PENDING'}">
                    <a
                      href="SalesmanServlet?action=processPayment&carId=${car.id}"
                      class="btn btn-sm btn-success"
                    >
                      <i class="fas fa-money-bill-wave"></i> Process Payment
                    </a>
                  </c:if>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>
