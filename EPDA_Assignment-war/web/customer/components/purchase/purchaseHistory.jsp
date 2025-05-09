<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@page
import="model.Sale"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<div class="purchase-history-container">
  <h2>Purchase History</h2>

  <div class="search-container">
    <form action="CustomerServlet" method="GET">
      <input type="hidden" name="action" value="searchSales" />
      <input
        type="text"
        name="searchTerm"
        placeholder="Search by car model..."
        class="search-input"
      />
      <button type="submit" class="btn btn-primary">
        <i class="fas fa-search"></i> Search
      </button>
    </form>
  </div>

  <div class="purchase-list">
    <c:choose>
      <c:when test="${not empty saleList}">
        <c:forEach var="sale" items="${saleList}">
          <div class="purchase-card">
            <div class="purchase-header">
              <h3>${sale.car.model}</h3>
              <span class="purchase-date">${sale.saleDate}</span>
            </div>

            <div class="purchase-details">
              <p><strong>Price:</strong> $${sale.amountPaid}</p>
              <p><strong>Status:</strong> ${sale.status}</p>
              <p><strong>Salesman:</strong> ${sale.salesman.username}</p>
            </div>

            <div class="purchase-actions">
              <c:if test="${!sale.reviewed}">
                <a
                  href="#feedback"
                  class="btn btn-secondary"
                  onclick="setSaleId(${sale.saleId})"
                >
                  <i class="fas fa-comment"></i> Leave Review
                </a>
              </c:if>
            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div class="no-purchases">
          <p>No purchases found.</p>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<script>
  function setSaleId(saleId) {
    document.getElementById("saleId").value = saleId;
    window.location.hash = "feedback";
  }

  function viewSaleDetails(saleId) {
    // Implement sale details view
    console.log("Viewing details for sale:", saleId);
  }
</script>
