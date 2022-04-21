<div id="renderDetails" class="table-responsive">
    <table id="showDetailsTable" class="table">
        <thead>
        <tr>
            <th>Code</th>
            <th>Menu Type</th>
            <th>Task Name</th>
            <th>Controller</th>
            <th>Method</th>
            <th>Sort Order</th>
            <th>Is Active</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody class="detailRows" id="detailRowsMenuItem">
        <g:render template="details_menu_item_details" model="[menuItem:null, i:'_sample', hidden:true]" />
        <g:each in="${menuItemInstance?.menuItems?.findAll{ it?.status == 'ACTIVE' }?.sort{ it?.sortOrder }}" var="menuItem" status="i">
            <g:render template="details_menu_item_details" model="[menuItem:menuItem, i:i, hidden:false]" />
        </g:each>
        </tbody>
    </table>
</div>