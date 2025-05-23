<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="../css/styles.css" />
<c:set var="currentPage" value="${param.currentPage}" scope="request" />
<div class="sidebar">
  <div class="sidebar-header">
    <h2>Car Sales System</h2>
    <p>Customer Dashboard</p>
  </div>
  <ul class="sidebar-menu">
    <li>
      <a href="#dashboard">
        <i class="fas fa-home"></i>
        <span>Dashboard</span>
      </a>
    </li>
    <li>
      <a href="#profile">
        <i class="fas fa-user"></i>
        <span>My Profile</span>
      </a>
    </li>
        <li>
      <a href="#purchase">
        <i class="fas fa-car"></i>
        <span>Buy Car</span>
      </a>
    </li>
    <li>
      <a href="#purchaseHistory">
        <i class="fas fa-history"></i>
        <span>Purchase History</span>
      </a>
    </li>
    <li>
      <a href="#feedback">
        <i class="fas fa-comment-alt"></i>
        <span>Give Feedback</span>
      </a>
    </li>
    <li>
      <a href="#ratings">
        <i class="fas fa-star"></i>
        <span>My Ratings</span>
      </a>
    </li>
    <li>
      <a href="login.jsp">
        <i class="fas fa-sign-out-alt"></i>
        <span>Logout</span>
      </a>
    </li>
  </ul>
</div>
