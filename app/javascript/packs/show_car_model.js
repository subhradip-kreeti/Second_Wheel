console.log("show-car-model js loaded")
document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('add-model-btn').addEventListener('click', function(event) {
    event.preventDefault();
    var brandSelect = document.getElementById('brand-select');
    var selectedBrand = brandSelect.value;
    console.log(selectedBrand)
    var modelSelect = document.getElementById('model-input');
    var selectedModel = modelSelect.value;
    if (selectedBrand === '' || selectedModel === '') {
      alert('Some fields are blank');
      return;
    }

    if (selectedBrand == 'Choose a brand') {
      alert('Please select a brand');
      return;
    }

    // Check if the same combination of brand and car model exists
    var modelList = document.getElementById('model-list');
    var existingModels = modelList.getElementsByTagName('li');
    for (var i = 0; i < existingModels.length; i++) {
      var modelName = existingModels[i].textContent.trim().split('(')[0].trim().toLowerCase();
      if (modelName === selectedModel.toLowerCase()) {
        alert('The car model is already available');
        // Clear the form inputs
        document.getElementById('brand-select').selectedIndex = 0;
        document.getElementById('model-input').value = '';
        return;
      }
    }

    // Send an AJAX request to add the car model
    $.ajax({
      url: '/add_car_model',
      method: 'POST',
      data: {
        selected_brand: selectedBrand,
        selected_model: selectedModel,
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
      },
      success: function(response) {
        var brandList = document.getElementById('model-list');
        var newItem = document.createElement('li');
        newItem.classList.add('list-group-item');
        newItem.textContent = selectedModel + ' ( ' + response.brand_name + ' )';
        brandList.appendChild(newItem);
        alert('Car Model added successfully');

        // Clear the form inputs
        document.getElementById('add-model-form').reset();
      },
      error: function(xhr, status, error) {
        alert('Failed to add Car Model');
      }
    });
  });
});
