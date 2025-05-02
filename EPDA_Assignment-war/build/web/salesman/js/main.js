// Wait for the DOM to be fully loaded
document.addEventListener("DOMContentLoaded", function () {
  // Initialize tooltips
  const tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
  );
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });

  // Handle dashboard navigation
  const sections = document.querySelectorAll(".content-section");
  const sidebarLinks = document.querySelectorAll(".sidebar-menu a");

  // Show dashboard by default
  const dashboardSection = document.getElementById("dashboard");
  if (dashboardSection) {
    dashboardSection.style.display = "block";
  }

  sidebarLinks.forEach((link) => {
    link.addEventListener("click", function (e) {
      if (this.getAttribute("href").startsWith("#")) {
        e.preventDefault();
        const targetId = this.getAttribute("href").substring(1);

        // Hide all sections
        sections.forEach((section) => {
          section.style.display = "none";
        });

        // Show target section
        const targetSection = document.getElementById(targetId);
        if (targetSection) {
          targetSection.style.display = "block";
        }

        // Update active state
        sidebarLinks.forEach((link) => link.classList.remove("active"));
        this.classList.add("active");
      }
    });
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
  const carStatusForms = document.querySelectorAll(".car-status-form");
  carStatusForms.forEach((form) => {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      const carId = this.querySelector('input[name="carId"]').value;
      const status = this.querySelector('select[name="status"]').value;
      const comment = this.querySelector('textarea[name="comment"]').value;

      if (
        confirm(`Are you sure you want to update the car status to ${status}?`)
      ) {
        this.submit();
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
      const comment = form.querySelector('textarea[name="comment"]').value;

      if (confirm(`Process payment of $${amount} for this sale?`)) {
        this.submit();
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

      // Validate email format
      const email = formData.get("email");
      if (!isValidEmail(email)) {
        alert("Please enter a valid email address!");
        return;
      }

      // Validate phone number if provided
      const phone = formData.get("phone");
      if (phone && !isValidPhone(phone)) {
        alert("Please enter a valid phone number!");
        return;
      }

      this.submit();
    });
  }

  // Helper functions
  function isValidEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
  }

  function isValidPhone(phone) {
    const re = /^\+?[\d\s-]{10,}$/;
    return re.test(phone);
  }
});
