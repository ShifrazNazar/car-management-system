<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="currentPage" value="${param.currentPage}" scope="request" />
<div class="sidebar">
  <div class="sidebar-header">
    <h2>Car Sales</h2>
  </div>
  <ul class="sidebar-menu">
    <li>
      <a
        href="SalesmanServlet"
        class="${currentPage == 'dashboard' ? 'active' : ''}"
      >
        <i class="bi bi-speedometer2"></i>
        <span>Dashboard</span>
      </a>
    </li>
    <li>
      <a
        href="SalesmanServlet?action=viewProfile"
        class="${currentPage == 'profile' ? 'active' : ''}"
      >
        <i class="bi bi-person"></i>
        <span>My Profile</span>
      </a>
    </li>
    <li>
      <a
        href="SalesmanServlet?action=viewSales"
        class="${currentPage == 'sales' ? 'active' : ''}"
      >
        <i class="bi bi-cash-stack"></i>
        <span>My Sales</span>
      </a>
    </li>
    <li>
      <a href="SalesmanServlet?action=logout">
        <i class="bi bi-box-arrow-right"></i>
        <span>Logout</span>
      </a>
    </li>
  </ul>
</div>
