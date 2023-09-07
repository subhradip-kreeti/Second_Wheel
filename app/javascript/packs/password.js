console.log("hello")
document.addEventListener("DOMContentLoaded", function () {
  // const passwordField = document.getElementById("password");
  // const confirmField = document.getElementById("confirm-password");
  // const form = document.querySelector("form");

  // form.addEventListener("btn-primary", function (event) {
    // event.preventDefault();
    // if (passwordField.value !== confirmField.value) {
    //   alert("Password and Confirm Password do not match.");
    // }
  // });

  $('.btn-primary').on('click',(event)=>{
    event.preventDefault();
    const pass=$('#password').val()
    const cpass=$('#confirm-password').val()
    console.log(pass,cpass)
    if (pass!= cpass) {
      alert("Password and Confirm Password do not match.");
    }
    else{
      if(pass.trim().length<5){
        alert("Length must be greater than 5")
        return
      }
      $.ajax({
        url: '/password_update',
        method: 'POST',
        data: {
          password: pass,
          authenticity_token: $('meta[name="csrf-token"]').attr('content')
        },
        success: function(response) {
        },
        error: function(xhr, status, error) {
        }
      });
    }
  })
});
