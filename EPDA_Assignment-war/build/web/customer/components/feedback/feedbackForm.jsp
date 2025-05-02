<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<div class="feedback-container">
  <h2>Give Feedback</h2>

  <form action="CustomerServlet" method="POST" class="feedback-form">
    <input type="hidden" name="action" value="submitFeedback" />
    <input type="hidden" name="purchaseId" id="purchaseId" />

    <div class="form-group">
      <label>Car Model</label>
      <input type="text" name="carModel" class="form-control" readonly />
    </div>

    <div class="form-group">
      <label>Rating</label>
      <div class="rating-input">
        <input type="radio" name="rating" value="5" id="rating5" />
        <label for="rating5">★</label>
        <input type="radio" name="rating" value="4" id="rating4" />
        <label for="rating4">★</label>
        <input type="radio" name="rating" value="3" id="rating3" />
        <label for="rating3">★</label>
        <input type="radio" name="rating" value="2" id="rating2" />
        <label for="rating2">★</label>
        <input type="radio" name="rating" value="1" id="rating1" />
        <label for="rating1">★</label>
      </div>
    </div>

    <div class="form-group">
      <label>Review Title</label>
      <input type="text" name="reviewTitle" class="form-control" required />
    </div>

    <div class="form-group">
      <label>Review Content</label>
      <textarea
        name="reviewContent"
        class="form-control"
        rows="5"
        required
      ></textarea>
    </div>

    <div class="form-group">
      <button type="submit" class="btn btn-primary">
        <i class="fas fa-paper-plane"></i> Submit Review
      </button>
    </div>
  </form>
</div>

<script>
  // Initialize the form when a purchase is selected
  document.addEventListener("DOMContentLoaded", function () {
    const purchaseId = document.getElementById("purchaseId").value;
    if (purchaseId) {
      // Fetch purchase details and populate the form
      fetch(
        `CustomerServlet?action=getPurchaseDetails&purchaseId=${purchaseId}`
      )
        .then((response) => response.json())
        .then((data) => {
          document.querySelector('input[name="carModel"]').value =
            data.carModel;
        });
    }
  });
</script>
