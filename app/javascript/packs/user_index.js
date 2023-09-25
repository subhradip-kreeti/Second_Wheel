document
  .getElementById("make-admin-btn")
  .addEventListener("click", function () {
    var userSelect = document.getElementById("user-select");
    // var userName = this.getAttribute('data-user-name');
    var selectedUser = userSelect.value;
    var selectedUserName = userSelect.options[userSelect.selectedIndex].dataset.userName;
    var selectedUserEmail = userSelect.options[userSelect.selectedIndex].dataset.userEmail;
    if (confirm(`Are you sure you want to make\n${selectedUserName} (${selectedUserEmail})\nan admin?`))
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
    var selectedUserName = userSelect.options[userSelect.selectedIndex].dataset.userName;
    var selectedUserEmail = userSelect.options[userSelect.selectedIndex].dataset.userEmail;
    if (confirm(`Are you sure you want to delete\n${selectedUserName} (${selectedUserEmail})\nfrom application as an user?`))
    $.ajax({
      url: `/users/${selectedUser}`,
      method: "DELETE",
      data: {
        selected_user_id: selectedUser,
        authenticity_token: $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (response) {},
      error: function (xhr, status, error) {},
    });
  });
