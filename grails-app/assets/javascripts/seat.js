$(document).ready(function(){
    $('.location').on('change', function () {
        var dropdown = $(this);
        var id = $(this).attr('id');
        var child = '';
        if(id == 'divisionId'){
            child = $('#districtId');
        }

        var value = dropdown.val();

        if(value == ''){
            child.trigger('change');
            return false;
        }

        $.ajax({
            type:'POST',
            url:   root + '/locationList/getLocationByParent',
            data:{
                'value':value
            },
            success:function (response) {
                child.html(response);
            }
        });
    });
});