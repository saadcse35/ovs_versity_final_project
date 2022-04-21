<div id="renderDetails" class="table-responsive">
    <table id="showDetailsTable" class="table">
        <thead>
        <tr>
            <th>Code</th>
            <th>Professional Skill</th>
            <th>Skill Level</th>
            <th>Remarks</th>


            <th>Action</th>
        </tr>
        </thead>
        <tbody id="detailRowp">
        <g:render template="details_professional_skill_details" model="[professionalSkill:null, i:'_sample', hidden:true]" />
        <g:each in="${personInstance?.professionalSkills?.findAll{ it.status == 'ACTIVE' }}" var="professionalSkill" status="i">
            <g:render template="details_professional_skill_details" model="[professionalSkills:professionalSkill, i:i, hidden:false]" />
        </g:each>
        </tbody>
    </table>
</div>