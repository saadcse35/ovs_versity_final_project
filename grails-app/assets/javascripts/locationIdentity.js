$(document).ready(function(){
    $('#name').on('keyup', function(){
        var name = $(this).val().replace(/ /g, "-");
        name = name.replace(/,/g, '');
        name = name.replace(/:/g, '');
        name = name.replace(/\./g, '');
        name = name.replace(/\?/g, '');
        name = name.replace(/\//g, '');
        name = name.replace(/;/g, '');
        name = name.replace(/!/g, '');
        name = name.replace(/'/g, '');
        name = name.replace(/’/g, '');
        name = name.replace(/‘/g, '');

        var url =$('#locationType').val() + ' - ' + name;
        $('#locationWithIdentity').val(url.toUpperCase());

    });

});