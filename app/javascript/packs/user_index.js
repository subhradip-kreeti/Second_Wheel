document
  .getElementById("make-admin-btn")
  .addEventListener("click", function () {
    var userSelect = document.getElementById("user-select");
    var selectedUser = userSelect.value;
    $.ajax({
      url: "/make_admin",
      method: "PATCH",
      data: {
        selected_user_id: selectedUser,
        authenticity_token: $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (response) {},
      error: function (xhr, status, error) {},
    });
  });

document
  .getElementById("delete-user-btn")
  .addEventListener("click", function () {
    var userSelect = document.getElementById("user-select-for-delete");
    var selectedUser = userSelect.value;
    $.ajax({
      url: "/delete_user",
      method: "DELETE",
      data: {
        selected_user_id: selectedUser,
        authenticity_token: $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (response) {},
      error: function (xhr, status, error) {},
    });
  });
