jQuery(document).ready(function () {
  $(".close-button").on("click", function () {
    document.getElementById("editCityModal").classList.remove("show");
    document.getElementById("editCityModal").style.display = "none";
  });

  $("#city-list").on("click", ".delete-city-btn", function (event) {
    event.preventDefault();
    var cityId = $(this).data("city-id");
    var cityName = $(this).data("city-name");
    var stateName = $(this).data("state-name");

    if (
      confirm(
        `Are you sure you want to delete ${cityName} (${stateName}) city?`
      )
    ) {
      $.ajax({
        url: "/cities/" + cityId,
        method: "DELETE",
        data: {
          city_id: cityId,
          authenticity_token: $('meta[name="csrf-token"]').attr("content"),
        },
        success: function (response) {
          location.reload();
        },
        error: function (xhr, status, error) {},
      });
    }
  });

  $("#city-list").on("click", ".edit-city-btn", function (event) {
    event.preventDefault();
    var cityName = $(this).data("city-name");
    var stateName = $(this).data("state-name");
    var editCityId = $(this).data("city-id-2");

    $("#editCityName").val(cityName);

    var stateSelect = $("#state-input2");
    stateSelect.val(stateName);

    var listItem = $(this).closest("li");
    listItem.addClass("editing");

    document.getElementById("editCityModal").classList.add("show");
    document.getElementById("editCityModal").style.display = "block";
  });

  $("#saveEditCity").on("click", function (event) {
    event.preventDefault();
    var editCityName = $("#editCityName").val();
    var editCityState = $("#state-input2").val();
    var editCityId = $(".editing .delete-city-btn").data("city-id");

    if (editCityName.trim() == "" || editCityState.trim() == "") {
      alert("Enter values in Both fields");
      return;
    }

    if (
      isCityStatePairAlreadyPresentExclude(
        editCityName,
        editCityState,
        editCityId
      )
    ) {
      alert("City and State Pair already exists.");
      return;
    }

    $.ajax({
      url: "/cities/" + editCityId,
      method: "PATCH",
      data: {
        selected_city_id: editCityId,
        selected_city: editCityName,
        selected_state: editCityState,
        authenticity_token: $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (response) {
          location.reload();
        },
      error: function (xhr, status, error) {},
    });
  });

  function isCityStatePairAlreadyPresent(city, state) {
    var cityList = $("#city-list li");

    for (var i = 0; i < cityList.length; i++) {
      var listItemText = $(cityList[i]).text().toLowerCase();
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
  function isCityStatePairAlreadyPresentExclude(city, state, editCityId) {
    var cityList = $("#city-list li");

    for (var i = 0; i < cityList.length; i++) {
      var listItemText = $(cityList[i]).text().toLowerCase();
      var listItemCity = listItemText.split("(")[0].trim().toLowerCase();
      var listItemState = listItemText
        .split("(")[1]
        .replace(")", "")
        .trim()
        .toLowerCase();
      var listItemEditCityId = $(cityList[i])
        .find(".delete-city-btn")
        .data("city-id");

      if (
        listItemCity === city.toLowerCase() &&
        listItemState === state.toLowerCase() &&
        listItemEditCityId !== editCityId
      ) {
        return true;
      }
    }

    return false;
  }

  $("#add-city-btn").on("click", function (event) {
    event.preventDefault();
    var selectedCity = $("#city-input").val();
    var selectedState = $("#state-input").val();

    if (selectedCity.trim() == "" || selectedState.trim() == "") {
      alert("Enter values in Both fields");
      return;
    }

    if (isCityStatePairAlreadyPresent(selectedCity, selectedState)) {
      alert("City and State Pair already exists.");
      $("#city-input").val("");
      $("#state-input").val("");
      return;
    }

    $.ajax({
      url: "/cities",
      method: "POST",
      data: {
        selected_city: selectedCity,
        selected_state: selectedState,
        authenticity_token: $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (response) {
        location.reload();
      },
      error: function (xhr, status, error) {},
    });
  });
});
