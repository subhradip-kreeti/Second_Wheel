$(document).ready(function () {
  var notificationCount = parseInt($("#notification-count").text());
  if (notificationCount === 0) {
    $("#readbtn").hide();
  }
  else{
    $("#readbtn").show()
  }
});
document.getElementById("readbtn").addEventListener("click", function (event) {
  event.preventDefault();
  var btnSelect = document.getElementById("readbtn");
  var selectedBtn = btnSelect.value;

  $.ajax({
    url: "/markread",
    method: "POST",
    data: {
      selected_btn: selectedBtn,
      authenticity_token: $('meta[name="csrf-token"]').attr("content"),
    },
    success: function (response) {
      var notificationCount = document.getElementById("notification-count");
      if (notificationCount) {
        notificationCount.innerText = "0";
      }
      var notificationList = document.getElementById("notification-list");
      if (notificationList) {
        notificationList.style.display = "none";
      }
    },
    error: function (xhr, status, error) {
      alert("Failed to mark as read");
    },
  });
});
