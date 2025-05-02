<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@page
import="model.Sale"%> <%@page import="java.util.List"%> <%@page
import="model.SaleFacade"%> <%@page import="javax.ejb.EJB"%> <%@taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Payment Analysis -->
<div class="table-container">
  <h2><i class="fas fa-money-bill-wave"></i> Payment Analysis</h2>
  <form action="ManagingStaffServlet" method="GET"></form>
  <table>
    <thead>
      <tr>
        <th>Sale ID</th>
        <th>Car</th>
        <th>Customer</th>
        <th>Salesman</th>
        <th>Amount</th>
        <th>Date</th>
        <th>Status</th>
        <th>Comment</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${saleList}" var="sale">
        <tr>
          <td>${sale.saleId}</td>
          <td>${sale.car.make} ${sale.car.model}</td>
          <td>${sale.customer.username}</td>
          <td>${sale.salesman.username}</td>
          <td>$${sale.amountPaid}</td>
          <td>${sale.saleDate}</td>
          <td>
            <span
              class="status-badge ${sale.status eq 'paid' ? 'status-available' : (sale.status eq 'booked' ? 'status-booked' : (sale.status eq 'cancel' ? 'status-cancel' : 'status-available'))}"
            >
              ${sale.status}
            </span>
          </td>
          <td>${sale.comment}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
