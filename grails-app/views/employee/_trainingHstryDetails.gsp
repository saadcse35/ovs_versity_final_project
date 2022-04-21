<div id="renderDetails" class="table-responsive">
    <table id="showDetailsTable" class="table">
        <thead>
        <tr>
            <th>Training Topic</th>
            <th>Training Organization</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Month Of Duration</th>
            <th>Is Certified</th>
            <th>Remarks</th>


            <th>Action</th>
        </tr>
        </thead>
        <tbody id="detailRowt">
        <g:render template="details_training_history_details" model="[trainingHistory:null, i:'_sample', hidden:true]" />
        <g:each in="${personInstance?.trainingHistories?.findAll{ it.status == 'ACTIVE' }}" var="careerHistory" status="i">
            <g:render template="details_training_history_details" model="[trainingHistories:trainingHistory, i:i, hidden:false]" />
        </g:each>
        </tbody>
    </table>
</div>