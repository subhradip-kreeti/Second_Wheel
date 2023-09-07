document.addEventListener("DOMContentLoaded", function () {
  var edit_CityId
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
            console.log("reached");
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

  document.querySelectorAll(".edit-city-btn").forEach(function (button) {
    button.addEventListener("click", function (event) {
      event.preventDefault();
      var cityName = this.getAttribute("data-city-name");
      var stateName = this.getAttribute("data-state-name");
      edit_CityId = this.getAttribute("data-city-id-2");
      document.getElementById("editCityName").value = cityName;
      console.log(stateName);
      var stateSelect = document.getElementById("state-input2");
      var stateOptions = stateSelect.options;
      for (var i = 0; i < stateOptions.length; i++) {
        if (stateOptions[i].text === stateName) {
          stateOptions[i].selected = true;
          break;
        }
      }
      var listItem = this.closest("li");
      listItem.classList.add("editing");

      $("#editCityModal").modal("show");
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

  function isCityStatePairAlreadyPresentExclude(city, state) {
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
        listItemState === state.toLowerCase() &&
        !listItems[i].classList.contains("editing")
      ) {
        return true;
      }
    }
    return false;
  }

  document
    .getElementById("saveEditCity")
    .addEventListener("click", function (event) {
      var editCityName = document.getElementById("editCityName").value;
      var editCityState = document.getElementById("state-input2").value;
      if (editCityName.trim() == "" || editCityState.trim() == "") {
        alert("Enter values in Both fields");
        return;
      }
      if (isCityStatePairAlreadyPresentExclude(editCityName, editCityState)) {
        alert("City and State Pair already exists.");
        return;
      }

      if (
        confirm(
          `Are you sure you want to add ${editCityName} (${editCityState}) city?`
        )
      ) {
        $.ajax({
          url: "/update_city/" + edit_CityId,
          method: "POST",
          data: {
            selected_city_id: edit_CityId,
            selected_city: editCityName,
            selected_state: editCityState,
            authenticity_token: $('meta[name="csrf-token"]').attr("content"),
          },
          success: function (response) {
            // $("#editCityModal").modal("hide");
            location.reload();
          },
          error: function (xhr, status, error) {
            // $("#editCityModal").modal("hide");
            location.reload();
          },
        });
      }
    });
});
