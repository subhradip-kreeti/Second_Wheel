document.addEventListener('turbolinks:load', function() {
  const form = document.querySelector("#filter-sort-form");
  const applyFilterButton = document.querySelector("#apply-filter-button-g");
  const selectBoxes = document.querySelectorAll(".form-select");

  function isAtLeastOneSelected() {
    for (const selectBox of selectBoxes) {
      if (selectBox.value !== "") {
        return true;
      }
    }
    return false;
  }
  applyFilterButton.disabled = true;
  form.addEventListener("change", function() {
    applyFilterButton.disabled = !isAtLeastOneSelected();
  });

  form.addEventListener("submit", function(event) {
    if (!isAtLeastOneSelected()) {
      event.preventDefault();
      alert("Please select at least one filter criteria.");
    }
  });
});




