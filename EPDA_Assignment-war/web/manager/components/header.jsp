<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
