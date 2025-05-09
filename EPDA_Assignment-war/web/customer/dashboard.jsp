<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Customer Dashboard</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/customer/css/index.css"
    />
  </head>
  <body>
    <div class="dashboard-container">
      <jsp:include page="components/sidebar.jsp" />

      <div class="main-content">
        <div class="header">
          <h1>Welcome, ${sessionScope.user.username}</h1>
          <div class="user-info">
            <div class="user-avatar">
              ${sessionScope.user.username.charAt(0)}
            </div>
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
          <div class="dashboard-content">
            <p>
              Here you can manage your profile, view purchase history, give
              feedback, and manage your ratings.
            </p>
          </div>
        </div>

        <!-- Profile Section -->
        <div id="profile">
          <jsp:include page="components/profile/profileManagement.jsp" />
        </div>
        
         <!-- Purchase Section -->
        <div id="purchase">
          <jsp:include page="components/purchase/purchaseForm.jsp" />
        </div>

        <!-- Purchase History Section -->
        <div id="purchaseHistory">
          <jsp:include page="components/purchase/purchaseHistory.jsp" />
        </div>

        <!-- Feedback Section -->
        <div id="feedback">
          <jsp:include page="components/feedback/feedbackForm.jsp" />
        </div>

        <!-- Ratings Section -->
        <div id="ratings">
          <jsp:include page="components/ratings/ratingsManagement.jsp" />
        </div>
      </div>
    </div>
    <script src="${pageContext.request.contextPath}/customer/js/main.js"></script>
  </body>
</html>
