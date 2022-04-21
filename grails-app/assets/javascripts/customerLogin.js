$(document).ready(function () {
    var href = window.location.href;
   $('.btn-login').on('click', function () {
      var formData = $(this).closest('form').serialize();
      $.ajax({
          url:root + "/userInfo/authenticateCustomer",
          method: 'post',
          data : formData,
          success:function(response){
             if(response == ""){
                 window.location.reload();
             }else{
                 alert(response)
             }
          }
      })
   });
});