// Wait for the DOM to be fully loaded
document.addEventListener("DOMContentLoaded", function () {
  // Initialize tooltips
  const tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
  );
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });

  // Handle form submissions
  const forms = document.querySelectorAll("form");
  forms.forEach((form) => {
    form.addEventListener("submit", function (e) {
      // Add loading state to submit button
      const submitButton = form.querySelector('button[type="submit"]');
      if (submitButton) {
        submitButton.disabled = true;
        submitButton.innerHTML =
          '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Processing...';
      }
    });
  });

  // Handle car status updates
  const statusButtons = document.querySelectorAll(".status-btn");
  statusButtons.forEach((button) => {
    button.addEventListener("click", function (e) {
      e.preventDefault();
      const carId = this.dataset.carId;
      const newStatus = this.dataset.status;

      if (
        confirm(`Are you sure you want to change the status to ${newStatus}?`)
      ) {
        const form = document.createElement("form");
        form.method = "POST";
        form.action = "SalesmanServlet";

        const actionInput = document.createElement("input");
        actionInput.type = "hidden";
        actionInput.name = "action";
        actionInput.value = "updateCarStatus";
        form.appendChild(actionInput);

        const carIdInput = document.createElement("input");
        carIdInput.type = "hidden";
        carIdInput.name = "carId";
        carIdInput.value = carId;
        form.appendChild(carIdInput);

        const statusInput = document.createElement("input");
        statusInput.type = "hidden";
        statusInput.name = "status";
        statusInput.value = newStatus;
        form.appendChild(statusInput);

        document.body.appendChild(form);
        form.submit();
      }
    });
  });

  // Handle payment processing
  const paymentForms = document.querySelectorAll(".payment-form");
  paymentForms.forEach((form) => {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      const amount = form.querySelector('input[name="amount"]').value;
      const saleId = form.querySelector('input[name="saleId"]').value;

      if (confirm(`Process payment of $${amount} for this sale?`)) {
        form.submit();
      }
    });
  });

  // Handle search functionality
  const searchForm = document.querySelector("#searchForm");
  if (searchForm) {
    searchForm.addEventListener("submit", function (e) {
      e.preventDefault();
      const searchTerm = this.querySelector('input[name="searchTerm"]').value;
      window.location.href = `SalesmanServlet?action=searchCars&searchTerm=${encodeURIComponent(
        searchTerm
      )}`;
    });
  }

  // Auto-hide alerts after 5 seconds
  const alerts = document.querySelectorAll(".alert");
  alerts.forEach((alert) => {
    setTimeout(() => {
      alert.style.opacity = "0";
      setTimeout(() => {
        alert.remove();
      }, 500);
    }, 5000);
  });

  // Handle profile update form
  const profileForm = document.querySelector("#profileForm");
  if (profileForm) {
    profileForm.addEventListener("submit", function (e) {
      e.preventDefault();
      const formData = new FormData(this);

      // Validate password if changed
      const newPassword = formData.get("password");
      const confirmPassword = formData.get("confirmPassword");

      if (newPassword && newPassword !== confirmPassword) {
        alert("Passwords do not match!");
        return;
      }

      this.submit();
    });
  }
});
