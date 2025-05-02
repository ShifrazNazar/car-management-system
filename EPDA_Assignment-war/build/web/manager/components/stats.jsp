<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="stats-container" id="dashboard">
  <div class="stat-card">
    <i class="fas fa-users-cog"></i>
    <h3>Total Staff</h3>
    <p>${managingStaffFacade.count()}</p>
  </div>
  <div class="stat-card">
    <i class="fas fa-user-tie"></i>
    <h3>Total Salesmen</h3>
    <p>${salesmanFacade.count()}</p>
  </div>
  <div class="stat-card">
    <i class="fas fa-users"></i>
    <h3>Total Customers</h3>
    <p>${customerFacade.count()}</p>
  </div>
  <div class="stat-card">
    <i class="fas fa-car"></i>
    <h3>Total Cars</h3>
    <p>${carFacade.count()}</p>
  </div>
</div>
