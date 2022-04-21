$(document).ready(function(){
    $('.location').on('change', function () {
        var dropdown = $(this);
        var id = $(this).attr('id');
        var child = '';
        if(id == 'presentCountryId'){
            child = $('#presentDivisionId');
        }else if(id == 'presentDivisionId'){
            child = $('#presentDistrictId');
        }else if(id == 'presentDistrictId'){
            child = $('#presentThanaId');
        }else if(id == 'permanentCountryId'){
            child = $('#permanentDivisionId');
        }else if(id == 'permanentDivisionId'){
            child = $('#permanentDistrictId');
        }else if(id == 'permanentDistrictId') {
            child = $('#permanentThanaId');
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
})