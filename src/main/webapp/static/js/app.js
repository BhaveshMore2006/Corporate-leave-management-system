// app.js
document.addEventListener('DOMContentLoaded', function() {
    // Dynamic date calculation for leave application form
    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');
    const totalDaysInput = document.getElementById('totalDays');
    const halfDayCheckbox = document.getElementById('halfDay');

    function calculateDays() {
        if (halfDayCheckbox && halfDayCheckbox.checked) {
            if (startDateInput.value) {
                endDateInput.value = startDateInput.value;
                endDateInput.setAttribute('readonly', true);
                totalDaysInput.value = 0.5;
            } else {
                totalDaysInput.value = '';
            }
            return;
        } else if (endDateInput) {
            endDateInput.removeAttribute('readonly');
        }

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
    if (halfDayCheckbox) halfDayCheckbox.addEventListener('change', calculateDays);
});
