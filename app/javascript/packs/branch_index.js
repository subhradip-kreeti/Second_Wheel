console.log("branch index js loaded")
document.getElementById('add-branch-btn').addEventListener('click', function(event) {
  event.preventDefault();
  var citySelect = document.getElementById('city-select');
  var selectedOption = citySelect.options[citySelect.selectedIndex];
  var selectedCity = selectedOption.value;

  var branchSelect = document.getElementById('branch-input');
  var selectedBranch = branchSelect.value;

  var addressSelect = document.getElementById('address-input');
  var selectedAddress = addressSelect.value;

  var mapSelect = document.getElementById('maplink-input');
  var selectedMap = mapSelect.value;

  var longSelect = document.getElementById('long-input');
  var selectedLong = parseFloat(longSelect.value);

  var latSelect = document.getElementById('lat-input');
  var selectedLat = parseFloat(latSelect.value);

  if(selectedCity && selectedBranch && selectedAddress && selectedMap && selectedLong && selectedLat && !isNaN(selectedLong) && !isNaN(selectedLat))
  {
    if (!((!isNaN(parseFloat(selectedLong))) && (!isNaN(parseFloat(selectedLat)))))
    {
      alert("Enter Latitude and Longitude in float ");
      return;
    }
    $.ajax({
      url: '/add_new_branch',
      method: 'POST',
      data: {
        selected_city: selectedCity,
        selected_branch: selectedBranch,
        selected_address: selectedAddress,
        selected_map: selectedMap,
        selected_long: selectedLong,
        selected_lat: selectedLat,
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
      },
      success: function(response) {
        var branchList = document.getElementById('model-list');
        var newItem = document.createElement('li');
        newItem.classList.add('list-group-item');
        newItem.textContent = selectedBranch + ' ( ' + response.city_name + ' )';
        branchList.appendChild(newItem);
        alert("Branch added successfully");
        citySelect.selectedIndex = 0;
        branchSelect.value = '';
        addressSelect.value = '';
        mapSelect.value = '';
        longSelect.value = '';
        latSelect.value = '';
      },
      error: function(xhr, status, error) {
        alert("Failed to add Branch");
      }
    });
  }
  else
  {
    alert("Some fields are missing or Latitude/Longitude is not a valid number");
  }
});
