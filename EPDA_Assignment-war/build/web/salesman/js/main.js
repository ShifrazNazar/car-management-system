function showUpdateForm(id) {
  document.getElementById(id).style.display = "table-row";
}

function hideUpdateForm(id) {
  document.getElementById(id).style.display = "none";
}

// Add smooth scrolling behavior
document.querySelectorAll('.sidebar-menu a[href^="#"]').forEach((anchor) => {
  anchor.addEventListener("click", function (e) {
    e.preventDefault();
    const targetId = this.getAttribute("href");
    if (targetId === "#") return;

    const targetElement = document.querySelector(targetId);
    if (targetElement) {
      targetElement.scrollIntoView({
        behavior: "smooth",
        block: "start",
      });
    }
  });
});

// Auto-hide messages after 5 seconds
document.addEventListener("DOMContentLoaded", function () {
  const messages = document.querySelectorAll(".message");
  messages.forEach((message) => {
    setTimeout(() => {
      message.style.opacity = "0";
      setTimeout(() => message.remove(), 500);
    }, 5000);
  });
});
