$(document).ready(function() {
  $('.myModalBtn').on('click', function() {
    $('#myModal').modal('show');
  });

  var modalBtns = document.querySelectorAll('.myModalBtn');
  var verifyBtn = document.getElementById('form-submit-btn');
  var carId;

  modalBtns.forEach(function(btn) {
    btn.addEventListener('click', function() {
      carId = btn.getAttribute('data-car-id');
      document.getElementById('myModal').classList.add('show');
      document.getElementById('myModal').style.display = 'block';

      console.log('Car ID:', carId);
    });
  });

  $('#form-submit-btn').on('click', function() {
    var dateSelect = document.getElementById('appointment-date');
    var appointmentDate = dateSelect.value;

    $.ajax({
      url: '/buyer_dashboard/inspection_request',
      method: 'POST',
      data: {
        appointmentDate: appointmentDate,
        car_id: carId,
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
      },
      success: function(response) {
         location.reload();
      },
      error: function(xhr, status, error) {

      }
    });
  });
});
