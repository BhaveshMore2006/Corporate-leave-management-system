// app.js
document.addEventListener('DOMContentLoaded', function() {
    // Dynamic date calculation for leave application form
    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');
    const totalDaysInput = document.getElementById('totalDays');

    function calculateDays() {
        if (startDateInput && endDateInput && totalDaysInput) {
            const start = new Date(startDateInput.value);
            const end = new Date(endDateInput.value);

            if (start && end && start <= end) {
                // Calculate difference in time
                const timeDiff = end.getTime() - start.getTime();
                // Calculate difference in days (add 1 because it's inclusive)
                const daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24)) + 1;
                totalDaysInput.value = daysDiff;
            } else {
                totalDaysInput.value = '';
            }
        }
    }

    if (startDateInput) startDateInput.addEventListener('change', calculateDays);
    if (endDateInput) endDateInput.addEventListener('change', calculateDays);

    // Highlight active sidebar link
    const currentPath = window.location.pathname;
    const navLinks = document.querySelectorAll('.sidebar-custom .nav-link');
    navLinks.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active');
        }
    });
});
