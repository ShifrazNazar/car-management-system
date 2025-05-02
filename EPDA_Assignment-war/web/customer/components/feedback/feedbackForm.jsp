<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<div class="feedback-container">
  <h2>Give Feedback</h2>

  <c:if test="${not empty errorMessage}">
    <div class="message error">
      <i class="fas fa-exclamation-circle"></i>
      ${errorMessage}
    </div>
  </c:if>

  <form action="CustomerServlet" method="POST" class="feedback-form">
    <input type="hidden" name="action" value="submitFeedback" />
    <input type="hidden" name="saleId" value="${param.saleId}" />

    <div class="form-group">
      <label>How would you rate your experience?</label>
      <div class="rating-input">
        <input type="radio" name="rating" value="5" id="rating5" required />
        <label for="rating5">★</label>
        <input type="radio" name="rating" value="4" id="rating4" required />
        <label for="rating4">★</label>
        <input type="radio" name="rating" value="3" id="rating3" required />
        <label for="rating3">★</label>
        <input type="radio" name="rating" value="2" id="rating2" required />
        <label for="rating2">★</label>
        <input type="radio" name="rating" value="1" id="rating1" required />
        <label for="rating1">★</label>
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
