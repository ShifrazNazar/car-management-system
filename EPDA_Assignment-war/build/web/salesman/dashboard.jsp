<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="model.Car"%> 
<%@page import="model.Sale"%> 
<%@page import="model.Customer"%> 
<%@page import="model.Salesman"%> 
<%@page import="java.util.List"%> 
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
            href="${pageContext.request.contextPath}/salesman/css/styles.css"
            />
    </head>
    <body>
        <div class="dashboard-container">
            <jsp:include page="components/sidebar.jsp" />

            <div class="main-content">
                <div class="header">
                    <h1>${param.title}</h1>
                    <div class="user-info">
                        <div class="user-avatar">
                            ${sessionScope.user.username.charAt(0)}
                        </div>
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

                <!-- Dashboard Section -->
                <div id="dashboard" class="content-section">
                    <h2>Welcome to your Dashboard</h2>
                    <!-- Add dashboard content here -->
                </div>

                <!-- Profile Section -->
                <div id="profile" class="content-section">
                    <jsp:include page="components/profile/updateProfile.jsp" />
                </div>

                <!-- Cars Section -->
                <div id="cars" class="content-section">
                    <jsp:include page="components/cars/updateCars.jsp" />
                    <jsp:include page="components/cars/viewCars.jsp" />
                </div>

                <!-- Sales Section -->

            </div>
        </div>
        <script src="js/main.js"></script>
    </body>
</html>
