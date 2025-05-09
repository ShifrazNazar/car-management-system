<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="model.Feedback"%> 
<%@page import="model.FeedbackFacade"%> 
<%@page import="model.Sale"%> 
<%@page import="model.SaleFacade"%> 
<%@page import="model.Car"%> 
<%@page import="javax.ejb.EJB"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="feedback-container">
  <h2>Give Feedback</h2>

  <c:if test="${not empty errorMessage}">
    <div class="message error">
      <i class="fas fa-exclamation-circle"></i>
      ${errorMessage}
    </div>
  </c:if>

  <c:if test="${not empty saleList}">
    <div class="purchases-to-review">
      <h3>Your Purchases</h3>
      <div class="feedback-grid">
        <c:forEach items="${saleList}" var="sale">
          <c:if test="${!sale.reviewed && 'paid'.equals(sale.status)}">
            <div class="feedback-card">
              <div class="car-info">
                <div class="car-header">
                  <h4>${sale.car.make} ${sale.car.model}</h4>
                  <span class="purchase-date"
                    >Purchased on: ${sale.saleDate}</span
                  >
                </div>
                <div class="car-details">
                  <p><i class="fas fa-tag"></i> Price: $${sale.car.price}</p>
                  <p><i class="fas fa-palette"></i> Color: ${sale.car.color}</p>
                </div>
              </div>
              <form
                action="CustomerServlet"
                method="POST"
                class="feedback-form"
              >
                <input type="hidden" name="action" value="submitFeedback" />
                <input type="hidden" name="saleId" value="${sale.saleId}" />

                <div class="form-group">
                  <label>How would you rate your experience?</label>
                  <div class="rating-input">
                    <input
                      type="radio"
                      name="rating"
                      value="5"
                      id="rating5_${sale.saleId}"
                      required
                    />
                    <label for="rating5_${sale.saleId}">★</label>
                    <input
                      type="radio"
                      name="rating"
                      value="4"
                      id="rating4_${sale.saleId}"
                      required
                    />
                    <label for="rating4_${sale.saleId}">★</label>
                    <input
                      type="radio"
                      name="rating"
                      value="3"
                      id="rating3_${sale.saleId}"
                      required
                    />
                    <label for="rating3_${sale.saleId}">★</label>
                    <input
                      type="radio"
                      name="rating"
                      value="2"
                      id="rating2_${sale.saleId}"
                      required
                    />
                    <label for="rating2_${sale.saleId}">★</label>
                    <input
                      type="radio"
                      name="rating"
                      value="1"
                      id="rating1_${sale.saleId}"
                      required
                    />
                    <label for="rating1_${sale.saleId}">★</label>
                  </div>
                </div>

                <div class="form-group">
                  <label>Your Review</label>
                  <textarea
                    name="reviewContent"
                    class="form-control"
                    rows="4"
                    required
                    placeholder="Share your thoughts about the car..."
                  ></textarea>
                </div>

                <div class="form-group">
                  <button type="submit" class="btn btn-primary">
                    <i class="fas fa-paper-plane"></i> Submit Review
                  </button>
                </div>
              </form>
            </div>
          </c:if>
        </c:forEach>
      </div>
    </div>
  </c:if>

  <c:if
    test="${empty saleList || !saleList.stream().anyMatch(s -> !s.reviewed && 'paid'.equals(s.status))}"
  >
    <div class="no-purchases">
      <i class="fas fa-info-circle"></i>
      <p>You don't have any purchases that need feedback at the moment.</p>
    </div>
  </c:if>
</div>
