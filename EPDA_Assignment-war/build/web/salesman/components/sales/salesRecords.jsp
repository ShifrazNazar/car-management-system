<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="model.Sale"%> 
<%@page import="model.SaleFacade"%> 
<%@page import="model.Car"%> 
<%@page import="model.Customer"%> 
<%@page import="javax.ejb.EJB"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="table-container">
    <h2>My Sales Records</h2>

    <!-- Sales Summary -->
    <div class="stats-container">
        <div class="stat-card">
            <h3>Total Sales</h3>
            <p>${saleList.size()}</p>
            <i class="fas fa-chart-line"></i>
        </div>

        <div class="stat-card">
      <h3>Total Revenue</h3>
      <c:set var="totalRevenue" value="0" />
      <c:forEach items="${saleList}" var="sale">
        <c:set var="totalRevenue" value="${totalRevenue + sale.amountPaid}" />
      </c:forEach>
      <p>$${totalRevenue}</p>
      <i class="fas fa-dollar-sign"></i>
    </div>

        <div class="stat-card">
            <h3>Completed Sales</h3>
            <p>${saleList.stream().filter(s -> s.status == 'paid').count()}</p>
            <i class="fas fa-check-circle"></i>
        </div>

        <div class="stat-card">
            <h3>Pending Sales</h3>
            <p>${saleList.stream().filter(s -> s.status != 'paid').count()}</p>
            <i class="fas fa-clock"></i>
        </div>
    </div>

    <!-- Sales Table -->
    <table>
        <thead>
            <tr>
                <th>Sale ID</th>
                <th>Car Details</th>
                <th>Customer</th>
                <th>Sale Date</th>
                <th>Amount Paid</th>
                <th>Status</th>
                <th>Comments</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="sale" items="${saleList}">
                <tr>
                    <td>${sale.saleId}</td>
                    <td>${sale.car.make} ${sale.car.model}</td>
                    <td>${sale.customer.username}</td>
                    <td>${sale.saleDate}</td>

                    <td>$${sale.amountPaid}</td>
                    <td>
                        <span class="status-badge status-${sale.status}">
                            ${sale.status}
                        </span>
                    </td>
                    <td>${sale.comment}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
