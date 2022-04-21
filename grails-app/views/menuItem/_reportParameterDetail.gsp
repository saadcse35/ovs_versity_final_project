<div class="renderDetails table-responsive">
    <table class="showDetailsTable table">
        <thead>
        <tr>
            <th>Parameter</th>
            <th>Is Active</th>
            <th>Sort Order</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody id="detailRowsReportParameter" class="detailRows">
        <g:render template="details_report_parameter_details" model="[reportParameterDetail:null, i:'_sample', hidden:true]" />
        <g:each in="${menuItemInstance.reportParameterDetails.findAll{ it.status == 'ACTIVE' }.sort{ it.sortOrder }}" var="reportParameterDetail" status="i">
            <g:render template="details_report_parameter_details" model="[reportParameterDetail:reportParameterDetail, i:i, hidden:false]" />
        </g:each>
        </tbody>
    </table>
</div>