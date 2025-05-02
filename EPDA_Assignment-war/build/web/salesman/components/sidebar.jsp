<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="../css/styles.css" />
<c:set var="currentPage" value="${param.currentPage}" scope="request" />
<div class="sidebar">
  <div class="sidebar-header">
    <h2>Car Sales System</h2>
    <p>Salesman Dashboard</p>
  </div>
  <ul class="sidebar-menu">
    <li>
      <a
        href="#dashboard"
        class="${currentPage == 'dashboard' ? 'active' : ''}"
      >
        <i class="fas fa-home"></i>
        <span>Dashboard</span>
      </a>
    </li>
    <li>
      <a href="#profile" class="${currentPage == 'profile' ? 'active' : ''}">
        <i class="fas fa-user"></i>
        <span>My Profile</span>
      </a>
    </li>
    <li>
      <a href="#sales" class="${currentPage == 'sales' ? 'active' : ''}">
        <i class="fas fa-chart-line"></i>
        <span>My Sales</span>
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
