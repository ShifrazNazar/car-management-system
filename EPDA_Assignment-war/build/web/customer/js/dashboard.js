function showUpdateForm(id) {
  document.getElementById(id).style.display = "block";
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
