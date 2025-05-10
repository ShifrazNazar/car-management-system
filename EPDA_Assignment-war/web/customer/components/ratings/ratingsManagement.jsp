<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="model.Feedback"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="ratings-container">
  <h2>My Ratings</h2>

  <div class="ratings-summary">
    <div class="summary-card">
      <h3>Average Rating</h3>
      <div class="rating-display">
        <span class="rating-value">${averageRating}</span>
        <div class="stars">
          <c:forEach begin="1" end="5" var="i">
            <i class="fas fa-star ${i <= averageRating ? 'active' : ''}"></i>
          </c:forEach>
        </div>
      </div>
    </div>

    <div class="summary-card">
      <h3>Total Reviews</h3>
      <p>${feedbackList.size()}</p>
    </div>
  </div>

  <div class="reviews-list">
    <c:choose>
      <c:when test="${not empty feedbackList}">
        <c:forEach var="feedback" items="${feedbackList}">
          <div class="review-card">
            <div class="review-header">
              <h3>${feedback.car.model}</h3>
              <div class="review-rating">
               <c:forEach begin="1" end="5" var="i">
                  <i
                    class="fas fa-star ${i <= feedback.rating ? 'active' : ''}"
                  ></i>
                </c:forEach>
              </div>
            </div>

            <div class="review-content">
              <p>${feedback.comment}</p>
            </div>

            <div class="review-footer">
              <div class="review-actions">
                <button
                  class="btn btn-danger"
                  onclick="deleteFeedback(${feedback.feedbackId})"
                >
                  <i class="fas fa-trash"></i> Delete
                </button>
              </div>
            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div class="no-reviews">
          <p>No reviews found.</p>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<script>
  function deleteFeedback(feedbackId) {
    if (confirm("Are you sure you want to delete this review?")) {
      fetch("CustomerServlet", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: `action=deleteFeedback&feedbackId=${feedbackId}`,
      }).then((response) => {
        if (response.ok) {
          window.location.reload();
        }
      });
    }
  }
</script>
