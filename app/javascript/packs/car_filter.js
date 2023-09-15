document.addEventListener('turbolinks:load', function() {
  const form = document.querySelector("#new_form"); // Replace "new_form" with your form's ID
  const applyFilterButton = document.querySelector("#apply-filter-button");
  const selectBoxes = document.querySelectorAll(".form-select");

  // Function to check if at least one select box is selected
  function isAtLeastOneSelected() {
    for (const selectBox of selectBoxes) {
      if (selectBox.value !== "") {
        return true;
      }
    }
    return false;
  }

  // Initially, disable the Apply Filter button
  applyFilterButton.disabled = true;

  // Listen for changes in select boxes
  form.addEventListener("change", function() {
    // Enable or disable the Apply Filter button based on selection
    applyFilterButton.disabled = !isAtLeastOneSelected();
  });

  // Show a warning message when Apply Filter is clicked with no selection
  form.addEventListener("submit", function(event) {
    if (!isAtLeastOneSelected()) {
      event.preventDefault(); // Prevent form submission
      alert("Please select at least one filter criteria.");
    }
  });
});




