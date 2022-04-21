$(document).ready(function () {
    $('#reportGroup').on('change', function () {
        var parentId = $('#reportGroup').val();
        if(parentId == ''){
            $('#reportSubGroup').html('');
            $('#reportId').html('');
            return false;
        }
        $.ajax({
            url: root + '/reportGroup/getChild',
            method: 'POST',
            data: {
                'parentId': parentId
            },
            success: function (response) {
                $('#reportSubGroup').html(response);
            },
            error: function () {
                alert('Something Went Wrong');
            }
        }); 
    });
    $('#reportSubGroup').on('change', function () {
        var parentId = $('#reportSubGroup').val();
        if(parentId == ''){
            $('#reportId').html('');
            return false;
        }
        $.ajax({
            url: root + '/reportGroup/getChild',
            method: 'POST',
            data: {
                'parentId': parentId
            },
            success: function (response) {
                $('#reportId').html(response);
            },
            error: function () {
                alert('Something Went Wrong');
            }
        });
    });

    $('#reportId').on('change', function () {
        var reportId = $('#reportId').val();
        if(reportId == ''){
            return false
        }
        $.ajax({
            url: '../ReportCenter/loadParams',
            method: 'post',
            data: {reportId : reportId},
            success:function (response) {
                $('#paramDetails').html(response);
            }
        });
    });
});