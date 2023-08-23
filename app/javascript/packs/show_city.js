document.querySelectorAll(".delete-city-btn").forEach(function (button) {
  button.addEventListener("click", function (event) {
    event.preventDefault();
    var cityId = this.getAttribute("data-city-id");
    var cityName = this.getAttribute("data-city-name");
    var stateName = this.getAttribute("data-state-name");
    if (
      confirm(
        `Are you sure you want to delete ${cityName} (${stateName}) city?`
      )
    )
      $.ajax({
        url: "/delete_city/" + cityId,
        method: "DELETE",
        data: {
          city_id: cityId,
          authenticity_token: $('meta[name="csrf-token"]').attr("content"),
        },
        success: function (response) {
          console.log("reached")
          event.target.closest("li").remove();
        },
        error: function (xhr, status, error) {},
      });
  });
});

document
  .getElementById("add-city-btn")
  .addEventListener("click", function (event) {
    event.preventDefault();
    var citySelect = document.getElementById("city-input");
    var stateSelect = document.getElementById("state-input");
    var selectedCity = citySelect.value;
    var selectedState = stateSelect.value;
    console.log(selectedCity);
    console.log(selectedState);
    if (selectedCity.trim() == "" || selectedState.trim() == "") {
      alert("Enter values in Both fields");
      return;
    }
    if (isCityStatePairAlreadyPresent(selectedCity, selectedState)) {
      alert("City and State Pair already exists.");
      document.getElementById("city-input").value = "";
      document.getElementById("state-input").value = "";
      return;
    }
    if (
      confirm(
        `Are you sure you want to add ${selectedCity} (${selectedState}) city?`
      )
    )
      $.ajax({
        url: "/add_city",
        method: "POST",
        data: {
          selected_city: selectedCity,
          selected_state: selectedState,
          authenticity_token: $('meta[name="csrf-token"]').attr("content"),
        },
        success: function (response) {},
        error: function (xhr, status, error) {},
      });
  });

function isCityStatePairAlreadyPresent(city, state) {
  var cityList = document.getElementById("city-list");
  var listItems = cityList.getElementsByTagName("li");
  for (var i = 0; i < listItems.length; i++) {
    var listItemText = listItems[i].innerText.toLowerCase();
    var listItemCity = listItemText.split("(")[0].trim().toLowerCase();
    var listItemState = listItemText
      .split("(")[1]
      .replace(")", "")
      .trim()
      .toLowerCase();

    if (
      listItemCity === city.toLowerCase() &&
      listItemState === state.toLowerCase()
    ) {
      return true;
    }
  }
  return false;
}
