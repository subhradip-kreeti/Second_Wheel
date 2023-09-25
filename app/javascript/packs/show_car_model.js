// document.addEventListener("DOMContentLoaded", function () {
  console.log("show-car-model js loaded");
  var carModelIdforedit;

  document.querySelectorAll(".delete-car-model-btn").forEach(function (button) {
    button.addEventListener("click", function (event) {
      event.preventDefault();
      var carModelId = this.getAttribute("data-car-model-id");
      $.ajax({
        url: "/car_models/" + carModelId,
        method: "DELETE",
        data: {
          carModelId: carModelId,
          authenticity_token: $('meta[name="csrf-token"]').attr("content"),
        },
        success: function (response) {
          event.target.closest("li").remove();
          setTimeout(function () {
            location.reload();
          }, 3000);
        },
        error: function (xhr, status, error) {
          alert("Error Occurred");
        },
      });
    });
  });

  document.addEventListener("DOMContentLoaded", function () {
    // Add an event listener to open the edit modal
    document.querySelectorAll(".edit-car-model-btn").forEach(function (button) {
      button.addEventListener("click", function (event) {
        event.preventDefault();
        carModelIdforedit = this.getAttribute("data-car-model-id");
        var carModelName = this.getAttribute("data-car-model-name");
        var carModelBrandName = this.getAttribute("data-car-model-brand-name");
        var carModelBrandId = this.getAttribute("data-car-model-brand-id");

        // Set the values in the edit form fields
        document.getElementById("editCarModelName").value = carModelName;

        // Select the corresponding option in the brand select dropdown
        var editCarModelBrandSelect =
          document.getElementById("editCarModelBrand");
        for (var i = 0; i < editCarModelBrandSelect.options.length; i++) {
          if (editCarModelBrandSelect.options[i].text === carModelBrandName) {
            editCarModelBrandSelect.options[i].selected = true;
            break;
          }
        }

        // Open the modal
        $("#editCarModelModal").modal("show");
      });
    });

    // Add an event listener to save changes in the edit modal
    document
      .getElementById("saveEditCarModel")
      .addEventListener("click", function (event) {
        event.preventDefault();

        var editedCarModelName =
          document.getElementById("editCarModelName").value;
        var editedCarModelBrandId =
          document.getElementById("editCarModelBrand").value;

        $.ajax({
          url: "/car_models/" + carModelIdforedit,
          method: "PATCH",
          data: {
            carModelId: carModelIdforedit,
            editedCarModelName: editedCarModelName,
            editedCarModelBrandId: editedCarModelBrandId,
            authenticity_token: $('meta[name="csrf-token"]').attr("content"),
          },
          success: function (response) {
            setTimeout(function () {
              location.reload();
            }, 3000);
          },
          error: function (xhr, status, error) {
            alert("Error Occurred");
          },
        });
      });

    // Add an event listener to the add model button
    document
      .getElementById("add-model-btn")
      .addEventListener("click", function (event) {
        event.preventDefault();
        var brandSelect = document.getElementById("brand-select");
        var selectedBrand = brandSelect.value;
        var modelSelect = document.getElementById("model-input");
        var selectedModel = modelSelect.value;

        if (selectedBrand.trim() === "" || selectedModel.trim() === "") {
          alert("Some fields are blank");
          return;
        }

        if (selectedBrand == "Choose a brand") {
          alert("Please select a brand");
          return;
        }

        // Check if the same combination of brand and car model exists
        var modelList = document.getElementById("model-list");
        var existingModels = modelList.getElementsByTagName("li");
        for (var i = 0; i < existingModels.length; i++) {
          var modelName = existingModels[i].textContent
            .trim()
            .split("(")[0]
            .trim()
            .toLowerCase();
          var existingBrandName = existingModels[i].textContent
            .trim()
            .split("(")[1]
            .split(")")[0]
            .trim()
            .toLowerCase(); // Extract existing brand name

          if (
            modelName == selectedModel.toLowerCase() &&
            existingBrandName == selectedBrand.trim().toLowerCase()
          ) {
            alert("The car model is already available for the selected brand");
            brandSelect.selectedIndex = 0;
            modelSelect.value = "";
            return;
          }
        }

        // Send an AJAX request to add the car model
        $.ajax({
          url: "/car_models",
          method: "POST",
          data: {
            selected_brand: selectedBrand,
            selected_model: selectedModel,
            authenticity_token: $('meta[name="csrf-token"]').attr("content"),
          },
          success: function (response) {
            setTimeout(function () {
              location.reload();
            }, 3000);
          },
          error: function (xhr, status, error) {
            alert("Failed to add Car Model");
          },
        });
      });
  });
