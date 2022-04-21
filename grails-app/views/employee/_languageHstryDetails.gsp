<div id="renderDetails" class="table-responsive">
    <table id="showDetailsTable" class="table">
        <thead>
        <tr>
            <th>Code</th>
            <th>Language</th>
            <th>Speaking Level</th>
            <th>Writing Level</th>
            <th>Reading Level</th>
            <th>Remarks</th>


            <th>Action</th>
        </tr>
        </thead>
        <tbody id="detailRowl">
        <g:render template="details_language_skill_details" model="[languageSkill:null, i:'_sample', hidden:true]" />
        <g:each in="${personInstance?.languageSkills?.findAll{ it.status == 'ACTIVE' }}" var="languageSkill" status="i">
            <g:render template="details_language_skill_details" model="[languageSkills:languageSkill, i:i, hidden:false]" />
        </g:each>
        </tbody>
    </table>
</div>