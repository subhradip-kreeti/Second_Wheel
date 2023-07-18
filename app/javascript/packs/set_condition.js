$(document).ready(function() {
  $('.myModalBtn').on('click', function() {
    $('#myModal').modal('show');
  });

  var modalBtns = document.querySelectorAll('.myModalBtn');
  var verifyBtn = document.getElementById('verify-car');
  var carId;

  modalBtns.forEach(function(btn) {
    btn.addEventListener('click', function() {
      carId = btn.getAttribute('data-car-id');
      document.getElementById('myModal').classList.add('show');
      document.getElementById('myModal').style.display = 'block';

      console.log('Car ID:', carId);
    });
  });

  $('#verify-car').on('click', function() {
    var priceSelect = document.getElementById('price');
    var selectedPrice = priceSelect.value;

    var conditionSelect = document.getElementById('condition');
    var selectedOption = conditionSelect.options[conditionSelect.selectedIndex];
    var selectedCondition = selectedOption.value;

    if (!isValidPriceCondition(selectedPrice, selectedCondition)) {
      alert('Invalid price range with condition');
      return;
  }
    function isValidPriceCondition(price, condition) {
      price = price.replace(/,/g, '');
      if (condition === 'Fair' && (price < 100001 || price > 125000)) {
        return false;
      } else if (condition === 'Good' && (price < 125001 || price > 150000)) {
        return false;
      } else if (condition === 'Very_Good' && (price < 150001 || price > 175000)) {
        return false;
      } else if (condition === 'Excellent' && (price < 175001 || price > 200000)) {
        return false;
      }
      return true;
    }

    $.ajax({
      url: '/set_car_condition/verify',
      method: 'POST',
      data: {
        selected_price: selectedPrice,
        selected_condition: selectedCondition,
        car_id: carId,
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
      },
      success: function(response) {
        // Handle success response
         location.reload();
      },
      error: function(xhr, status, error) {
        // Handle error response
      }
    });
  });
});
