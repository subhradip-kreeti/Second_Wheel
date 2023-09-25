document.addEventListener("turbolinks:load", function () {
  console.log("custom js file loaded for show brand");
  $(".close-button").on("click", function () {
    // Close the modal using vanilla JavaScript
    document.getElementById("editBrandModal").classList.remove("show");
    document.getElementById("editBrandModal").style.display = "none";
  });
  document.querySelectorAll(".delete-brand-btn").forEach(function (button) {
    button.addEventListener("click", function (event) {
      event.preventDefault();
      var brandId = this.getAttribute("data-brand-id");
      var brandName = this.getAttribute("data-brand-name");
      if (confirm(`Are you sure you want to delete ${brandName} brand?`))
        $.ajax({
          url: "/brands/" + brandId,
          method: "DELETE",
          data: {
            brand_id: brandId,
            authenticity_token: $('meta[name="csrf-token"]').attr("content"),
          },
          success: function (response) {
            event.target.closest("li").remove();
          },
          error: function (xhr, status, error) {},
        });
    });
  });

  document
    .getElementById("add-brand-btn")
    .addEventListener("click", function (event) {
      event.preventDefault();
      var brandSelect = document.getElementById("brand-input");
      var selectedBrand = brandSelect.value;

      if (selectedBrand.trim() == "") {
        alert("Enter some value in input");
        return;
      }

      if (isBrandAlreadyPresent(selectedBrand)) {
        document.getElementById("brand-input").value = "";
        alert(`${selectedBrand} is already present`);
        return;
      }
      if (confirm(`Are you sure you want to add ${selectedBrand} brand?`))
        $.ajax({
          url: "/brands",
          method: "POST",
          data: {
            selected_brand: selectedBrand,
            authenticity_token: $('meta[name="csrf-token"]').attr("content"),
          },
          success: function (response) {
            document.getElementById("brand-input").value = "";
            var brandList = document.getElementById("brand-list");
            var listItem = document.createElement("li");
            listItem.className = "list-group-item";
            listItem.innerText = selectedBrand;
            brandList.appendChild(listItem);
            setTimeout(function () {
              location.reload();
            }, 3000);
          },
          error: function (xhr, status, error) {
            alert("Error occured");
          },
        });
    });

  function isBrandAlreadyPresent(brand) {
    var brandList = document.getElementById("brand-list");
    var listItems = brandList.getElementsByTagName("li");
    for (var i = 0; i < listItems.length; i++) {
      var listItemText = listItems[i].innerText.toLowerCase();
      if (listItemText.includes(brand.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  // Function to handle the click event for editing a brand
  function handleEditBrandButtonClick(event) {
    event.preventDefault();
    var brandName = this.getAttribute("data-brand-name");
    edit_BrandId = this.getAttribute("data-brand-id");
    document.getElementById("editBrandName").value = brandName;

    document.getElementById("editBrandModal").classList.add("show");
    document.getElementById("editBrandModal").style.display = "block";
  }

  // Event listener for the "Save Edit Brand" button
  document
    .getElementById("saveEditBrand")
    .addEventListener("click", function (event) {
      event.preventDefault();
      var editBrandName = document.getElementById("editBrandName").value;

      if (editBrandName.trim() == "") {
        alert("Enter a brand name");
        return;
      }

      if (isBrandAlreadyPresent(editBrandName)) {
        alert("Brand already exists.");
        return;
      }

      if (confirm(`Are you sure you want to edit ${editBrandName} brand?`)) {
        $.ajax({
          url: "/brands/" + edit_BrandId,
          method: "PATCH",
          data: {
            selected_brand_id: edit_BrandId,
            selected_brand: editBrandName,
            authenticity_token: $('meta[name="csrf-token"]').attr("content"),
          },
          success: function (response) {
            setTimeout(function () {
              location.reload();
            }, 3000);
          },
          error: function (xhr, status, error) {
            alert("Error occured");
          },
        });
      }
    });
  document.querySelectorAll(".edit-brand-btn").forEach(function (button) {
    button.addEventListener("click", handleEditBrandButtonClick);
  });
});
