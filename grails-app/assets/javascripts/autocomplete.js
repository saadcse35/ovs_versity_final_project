$(document).ready(function () {
   /* $(document).on('focus','.in-autocomplete', function () {
       $(this).parent().parent().removeClass('col-lg-3 col-md-3').addClass('col-lg-6 col-md-6');
    });
    $(document).on('focusout', '.in-autocomplete', function () {
        var autoDiv = $('.autocomplete-items');
        console.common.log(autoDiv);
        if(autoDiv.length == 0){
            $(this).parent().parent().removeClass('col-lg-6 col-md-6').addClass('col-lg-3 col-md-3');
        }

    });*/
    $(document).on('keyup', '.in-autocomplete', function (event) {
        $('.autocomplete-items').remove();
        var txtBox = $(this);
        var searchTerm = $(this).val();
        if(searchTerm != ''){
            /*var attribute = $(this).attr('id');
            if(searchField == "" || domain == ""){
                return false;
            }*/
            $.ajax({
                url: root + "/AutoCompleteSearch/searchAction",
                method:"POST",
                data:{
                    searchTerm:searchTerm
                },
                success:function(response){
                    $("<div/>", {
                        html: response,
                        class:'autocomplete-items'
                    }).insertAfter(txtBox);
                }
            })
        }
    });
    /*$(document).on('click', '.autocomplete-items div', function () {
        var txt = $(this).text();
        var textBox = $(this).parent()[0].previousSibling;
        $(textBox).val(txt).focus();
        $('.autocomplete-items').remove();
    });*/
});