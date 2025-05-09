<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Salesman Dashboard</title>
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/salesman/css/index.css"
            />
    </head>
    <body>
        <div class="dashboard-container">
            <jsp:include page="components/sidebar.jsp" />

            <div class="main-content">
                <div class="header">
                    <h1>Welcome, ${sessionScope.user.username}</h1>
                    <div class="user-info">
                        <div class="user-avatar">${sessionScope.user.username.charAt(0)}</div>
                    </div>
                </div>

                <c:if test="${not empty message}">
                    <div class="message success">
                        <i class="fas fa-check-circle"></i>
                        ${message}
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="message error">
                        <i class="fas fa-exclamation-circle"></i>
                        ${error}
                    </div>
                </c:if>

                <!-- Dashboard Section -->
                <div id="dashboard">
                    <h2>Welcome to your Dashboard</h2>

                </div>

                <!-- Profile Section -->
                <div id="profile">
                    <jsp:include page="components/profile/profileManagement.jsp" />
                </div>

                <!-- Cars Section -->
                <div id="cars">
                    <jsp:include page="components/cars/carManagement.jsp" />
                </div>

                <!-- Payments Section -->
                <div id="payments">
                    <jsp:include page="components/payments/paymentManagement.jsp" />
                </div>

                <!-- Sales Section -->
                <div id="sales">
                    <jsp:include page="components/sales/salesRecords.jsp" />
                </div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/salesman/js/main.js"></script>
    </body>
</html>
