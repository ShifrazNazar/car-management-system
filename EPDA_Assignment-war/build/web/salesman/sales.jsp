<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Sale"%>
<%@page import="model.Car"%>
<%@page import="model.Customer"%>
<%@page import="model.Salesman"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Sales</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="css/styles.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/main.js"></script>
    </head>
    <body>
        <div class="dashboard-container">
            <jsp:include page="components/sidebar.jsp">
                <jsp:param name="currentPage" value="sales"/>
            </jsp:include>

            <div class="main-content">
                <div class="header">
                    <h1>My Sales</h1>
                    <div class="user-info">
                        <div class="user-avatar">${sessionScope.user.username.charAt(0)}</div>
                        <span>${sessionScope.user.username}</span>
                    </div>
                </div>

                <c:if test="${not empty successMessage}">
                    <div class="message success">
                        <i class="fas fa-check-circle"></i>
                        ${successMessage}
                    </div>
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <div class="message error">
                        <i class="fas fa-exclamation-circle"></i>
                        ${errorMessage}
                    </div>
                </c:if>

                <!-- Sales Summary -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h2><i class="fas fa-chart-pie"></i> Sales Summary</h2>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="card bg-primary text-white">
                                    <div class="card-body">
                                        <h5 class="card-title">Total Sales</h5>
                                        <p class="card-text h3">${totalSales}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card bg-success text-white">
                                    <div class="card-body">
                                        <h5 class="card-title">Completed Sales</h5>
                                        <p class="card-text h3">${completedSales}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card bg-warning text-white">
                                    <div class="card-body">
                                        <h5 class="card-title">Pending Sales</h5>
                                        <p class="card-text h3">${pendingSales}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card bg-info text-white">
                                    <div class="card-body">
                                        <h5 class="card-title">Total Revenue</h5>
                                        <p class="card-text h3">$${totalRevenue}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sales List -->
                <div class="card">
                    <div class="card-header">
                        <h2><i class="fas fa-list"></i> Sales Records</h2>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Sale ID</th>
                                        <th>Date</th>
                                        <th>Customer</th>
                                        <th>Car</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                        <th>Comments</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${sales}" var="sale">
                                        <tr>
                                            <td>${sale.id}</td>
                                            <td>${sale.saleDate}</td>
                                            <td>${sale.customer.username}</td>
                                            <td>${sale.car.make} ${sale.car.model} (${sale.car.vin})</td>
                                            <td>$${sale.amount}</td>
                                            <td>
                                                <span class="status-badge ${sale.status eq 'COMPLETED' ? 'status-available' : 
                                                                      sale.status eq 'PENDING' ? 'status-booked' : 'status-sold'}">
                                                    ${sale.status}
                                                </span>
                                            </td>
                                            <td>${sale.comment}</td>
                                            <td>
                                                <c:if test="${sale.status == 'PENDING'}">
                                                    <form class="payment-form" action="SalesmanServlet" method="POST">
                                                        <input type="hidden" name="action" value="processPayment">
                                                        <input type="hidden" name="saleId" value="${sale.id}">
                                                        <div class="input-group">
                                                            <input type="number" name="amount" value="${sale.amount}" 
                                                                   step="0.01" class="form-control form-control-sm">
                                                            <button type="submit" class="btn btn-sm btn-success">
                                                                <i class="fas fa-money-bill-wave"></i> Process Payment
                                                            </button>
                                                        </div>
                                                    </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="js/main.js"></script>
    </body>
</html> 