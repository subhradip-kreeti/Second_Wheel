console.log("custom js file loaded for show brand")

document.querySelectorAll('.delete-brand-btn').forEach(function(button) {
  button.addEventListener('click', function(event) {
    event.preventDefault();
    var brandId = this.getAttribute('data-brand-id');
    var brandName = this.getAttribute('data-brand-name');
    if (confirm(`Are you sure you want to delete ${brandName} brand?`))
    $.ajax({
      url: '/delete_brand/' + brandId,
      method: 'DELETE',
      data: {
        brand_id: brandId,
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
      },
      success: function(response) {
        event.target.closest('li').remove();

      },
      error: function(xhr, status, error) {

      }
    });
  });
});

document.getElementById('add-brand-btn').addEventListener('click', function(event) {
  event.preventDefault();
  var brandSelect = document.getElementById('brand-input');
  var selectedBrand = brandSelect.value;

  if(selectedBrand.trim() == '')
  {
    alert("Enter some value in input");
    return;
  }

  if (isBrandAlreadyPresent(selectedBrand)) {
    document.getElementById('brand-input').value = '';
    return;
  }
  if (confirm(`Are you sure you want to add ${selectedBrand} brand?`))
  $.ajax({
    url: '/add_brand',
    method: 'POST',
    data: {
      selected_brand: selectedBrand,
      authenticity_token: $('meta[name="csrf-token"]').attr('content')
    },
    success: function(response) {
      document.getElementById('brand-input').value = '';
      var brandList = document.getElementById('brand-list');
      var listItem = document.createElement('li');
      listItem.className = 'list-group-item';
      listItem.innerText = selectedBrand;
      brandList.appendChild(listItem);
    },
    error: function(xhr, status, error) {
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
