<div id="renderDetails" class="table-responsive">
    <table class="table">
        <thead>
            <tr>
                <th>Code</th>
                <th>Name</th>
                <th>Location Type</th>
                <th>সক্রিয় কিনা</th>
                <th>Remarks</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="detailRows">
                <g:render template="details_location_details" model="[location:null, i:'_sample', hidden:true]" />
                <g:each in="${locationInstance?.locations?.findAll{ it.status == 'ACTIVE' }}" var="locationDetail" status="i">
                    <g:render template="details_location_details" model="[locationDetail: locationDetail, i:i, hidden:false]" />
                </g:each>
        </tbody>
    </table>
</div>