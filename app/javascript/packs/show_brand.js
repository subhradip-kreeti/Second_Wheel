console.log("custom js file loaded for show brand")

document.querySelectorAll('.delete-brand-btn').forEach(function(button) {
  button.addEventListener('click', function(event) {
    event.preventDefault();
    var brandId = this.getAttribute('data-brand-id');
    $.ajax({
      url: '/delete_brand/' + brandId,
      method: 'DELETE',
      data: {
        brand_id: brandId,
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
      },
      success: function(response) {
        event.target.closest('li').remove();
        alert('Brand deleted successfully');
      },
      error: function(xhr, status, error) {
        alert('Failed to delete Brand');
      }
    });
  });
});

document.getElementById('add-brand-btn').addEventListener('click', function(event) {
  // event.preventDefault();
  var brandSelect = document.getElementById('brand-input');
  var selectedBrand = brandSelect.value;

  if(selectedBrand == '')
  {
    alert("Enter some value in input");
    return;
  }

  if (isBrandAlreadyPresent(selectedBrand)) {
    alert("Brand already exists.");
    document.getElementById('brand-input').value = '';
    return;
  }

  $.ajax({
    url: '/add_brand',
    method: 'POST',
    data: {
      selected_brand: selectedBrand,
      authenticity_token: $('meta[name="csrf-token"]').attr('content')
    },
    success: function(response) {
      alert("Brand added successfully");
      document.getElementById('brand-input').value = '';
      var brandList = document.getElementById('brand-list');
      var listItem = document.createElement('li');
      listItem.className = 'list-group-item';
      listItem.innerText = selectedBrand;
      brandList.appendChild(listItem);
    },
    error: function(xhr, status, error) {
      alert("Failed to add Brand");
    }
  });
});

function isBrandAlreadyPresent(brand) {
  var brandList = document.getElementById('brand-list');
  var listItems = brandList.getElementsByTagName('li');
  for (var i = 0; i < listItems.length; i++) {
    var listItemText = listItems[i].innerText.toLowerCase();
    if (listItemText.includes(brand.toLowerCase())) {
      return true;
    }
  }
  return false;
}
