<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Manager Dashboard</title>
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/manager/css/index.css"
            />
    </head>
    <body>
        <div class="dashboard-container">
            <jsp:include page="components/sidebar.jsp" />

            <div class="main-content">
                <div class="header">
                    <h1>Welcome, Shifraz</h1>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
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

                <jsp:include page="components/stats.jsp" />

                <div id="staff">
                    <jsp:include page="components/staff/staffForm.jsp" />
                    <jsp:include page="components/staff/staffList.jsp" />
                </div>

                <div id="salesmen">
                    <jsp:include page="components/salesmen/salesmenList.jsp" />
                </div>

                <div id="customers">
                    <jsp:include page="components/customers/customersList.jsp" />
                </div>

                <div id="cars">
                    <jsp:include page="components/cars/carsForm.jsp" />
                    <jsp:include page="components/cars/carsList.jsp" />
                </div>

                <div id="payments">
                    <jsp:include page="components/payments/paymentsAnalysis.jsp" />
                </div>

                <div id="feedback">
                    <jsp:include page="components/feedback/feedbackAnalysis.jsp" />
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/manager/js/dashboard.js"></script>
    </body>
</html>
