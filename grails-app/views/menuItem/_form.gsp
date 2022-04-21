<%@ page import="common.accessControl.MenuItem" %>

<script type="text/javascript">
    var menuItemsCount = ${menuItemInstance?.menuItems?.size()} + 0;
    var reportParameterDetailsCount = ${menuItemInstance?.reportParameterDetails?.size()} + 0;
    function addMenuItems(){
        var clonedRow = $('#details_menu_item_details_sample').clone() // sampleRow.clone();
        var idCmn = 'menuItems[' + menuItemsCount + '].';
        clonedRow.find('[id$=id]')
            .attr('id', idCmn + 'id' )
            .attr('name', idCmn + 'id' );
        clonedRow.find('[id$=deleted]').attr('id', idCmn +'deleted' )
            .attr('name', idCmn +'deleted' );
        clonedRow.find('[id$=new]')
            .attr('id', idCmn +'new' )
            .attr('name', idCmn +'new' );
        clonedRow.find('[id$=code]').attr('id', idCmn +'code' )
            .attr('name', idCmn +'code' ).attr('required', 'required');
        clonedRow.find('[id$=menuType]').attr('id', idCmn +'menuType' )
            .attr('name', idCmn +'menuType' ).attr('required', 'required');
        clonedRow.find('[id$=name]')
            .attr('id', idCmn +'name' )
            .attr('name', idCmn +'name' ).attr('required', 'required');
        clonedRow.find('[id$=controllerName]')
            .attr('id', idCmn +'controllerName' )
            .attr('name', idCmn +'controllerName' ).attr('required', 'required');
        clonedRow.find('[id$=actionName]')
            .attr('id', idCmn +'actionName' )
            .attr('name', idCmn +'actionName' ).attr('required', 'required');
        clonedRow.find('[id$=sortOrder]')
            .attr('id', idCmn +'sortOrder' )
            .attr('name', idCmn +'sortOrder' ).attr('required', 'required');
        clonedRow.find('[id$=isActive]')
            .attr('id', idCmn +'isActive' )
            .attr('name', idCmn +'isActive' );
        clonedRow.attr('id', 'details_menu_item_details_'+menuItemsCount);

        $('#detailRowsMenuItem').append(clonedRow);
        clonedRow.show();
        menuItemsCount++;
    }
    function addReportParameterDetails(){
        var clonedRow = $('#details_report_parameter_details_sample').clone() // sampleRow.clone();
        var idCmn = 'reportParameterDetails[' + reportParameterDetailsCount + '].';
        clonedRow.find('[id$=id]')
            .attr('id', idCmn + 'id' )
            .attr('name', idCmn + 'id' );
        clonedRow.find('[id$=deleted]').attr('id', idCmn +'deleted' )
            .attr('name', idCmn +'deleted' );
        clonedRow.find('[id$=new]')
            .attr('id', idCmn +'new' )
            .attr('name', idCmn +'new' );
        clonedRow.find('[id$=reportParameterId]').attr('id', idCmn +'reportParameterId' )
            .attr('name', idCmn +'reportParameterId' ).attr('required', 'required');
        clonedRow.find('[id$=sortOrder]')
            .attr('id', idCmn +'sortOrder' )
            .attr('name', idCmn +'sortOrder' ).attr('required', 'required');
        clonedRow.find('[id$=isActive]')
            .attr('id', idCmn +'isActive' )
            .attr('name', idCmn +'isActive' );
        clonedRow.attr('id', 'details_report_parameter_details_'+reportParameterDetailsCount);

        $('#detailRowsReportParameter').append(clonedRow);
        clonedRow.show();
        reportParameterDetailsCount++;
	}
    $(document).ready(function () {
        $('.detailRows').on('click', '.icon', function(){

            var tr = $(this).parent().parent();
            tr.find('[id$=deleted]').attr('value', 'true');
            tr.find('select').removeAttr('required');
            tr.find('input').removeAttr('required');
            tr.hide();
        });
    });
</script>

<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: menuItemInstance, field: 'code', 'error')} required">
		<div class="form-group">

			<label for="code" class="control-label">
				<g:message code="menuItem.code.label" default="Code (To be auto generated)" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="code" maxlength="30" required="" value="${menuItemInstance?.code}" disabled="disabled"/>

		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: menuItemInstance, field: 'name', 'error')} required">
		<div class="form-group">

			<label for="name" class="control-label">
				<g:message code="menuItem.departmentId.label" default="Name" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="name" maxlength="100" required="" value="${menuItemInstance?.name}"/>

		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: menuItemInstance, field: 'parentId', 'error')} ">
		<div class="form-group">

			<label for="parentId" class="control-label">
				<g:message code="menuItem.parentId.label" default="Parent Item" />
				
			</label>
			<g:select class="form-control" id="parentId" name="parentId.id" from="${common.accessControl.MenuItem.list()}" optionKey="id" value="${menuItemInstance?.parentId?.id}"  noSelection="['null': '']"/>

		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: menuItemInstance, field: 'menuType', 'error')} required">
		<div class="form-group">

			<label for="menuType" class="control-label">
				<g:message code="menuItem.menuType.label" default="Menu Type" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" name="menuType" from="${menuItemInstance.constraints.menuType.inList}" required="" value="${menuItemInstance?.menuType}" valueMessagePrefix="menuItem.menuType"/>

		</div>
	</div>
</div>

<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: menuItemInstance, field: 'controllerName', 'error')} required">
		<div class="form-group">

			<label for="menuType" class="control-label">
				<g:message code="menuItem.controllerName.label" default="Controller Name" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="controllerName"  required="" value="${menuItemInstance?.controllerName}" valueMessagePrefix="menuItem.controllerName"/>

		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: menuItemInstance, field: 'actionName', 'error')} required">
		<div class="form-group">
			<label for="menuType" class="control-label">
				<g:message code="menuItem.actionName.label" default="Action Name" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="actionName"  required="" value="${menuItemInstance?.actionName}" valueMessagePrefix="menuItem.actionName"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: menuItemInstance, field: 'sortOrder', 'error')} required">
		<div class="form-group">
			<label for="menuType" class="control-label">
				<g:message code="menuItem.sortOrder.label" default="Sort Order" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField type="number" class="form-control" name="sortOrder"  required="" value="${menuItemInstance?.sortOrder}" valueMessagePrefix="menuItem.sortOrder"/>
		</div>
	</div>
	
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: menuItemInstance, field: 'isActive', 'error')} ">
		<div class="form-group">

			<label for="isActive" class="control-label">
				<g:message code="menuItem.isActive.label" default="Is Active" />

			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isActive" value="${menuItemInstance?.isActive}" />

		</div>
	</div>
</div>
<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: menuItemInstance, field: 'activeFrom', 'error')} ">
		<div class="form-group">
			<label for="activeFrom" class="control-label">
				<g:message code="menuItem.activeFrom.label" default="Active From" />
			</label>
			<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="activeFrom" id="activeFrom"  value="${formatDate(format: 'dd/MM/yyyy', date: menuItemInstance?.activeFrom)}" default="none" noSelection="['': '']" />
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: menuItemInstance, field: 'activeTo', 'error')} ">
		<div class="form-group">
			<label for="activeTo" class="control-label">
				<g:message code="menuItem.activeTo.label" default="Active To" />
			</label>
			<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="activeTo" id="activeTo"  value="${formatDate(format: 'dd/MM/yyyy', date: menuItemInstance?.activeTo)}" default="none" noSelection="['': '']" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: menuItemInstance, field: 'remarks', 'error')} ">
		<div class="form-group">
			<label for="remarks" class="control-label">
				<g:message code="menuItem.remarks.label" default="Remarks" />
			</label>
			<g:textArea class="form-control" name="remarks" cols="40" rows="5" maxlength="1000" value="${menuItemInstance?.remarks}"/>
		</div>
	</div>

</div>





<ul class="nav nav-tabs">
	<li class="nav-item"><a class="nav-link active show" data-toggle="tab" href="#detailMenuItem"><i
			class="fa fa-home"></i>Menu Item Details</a></li>
	<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#detailReportParameter"><i
			class="fa fa-user"></i>Report Parameters</a></li>
</ul>

<div class="tab-content">
	<div class="tab-pane active show" id="detailMenuItem">
		<div class="row">
			<div class="col-lg-12 col-md-12">
				<g:render template="details"/>
				<div class="addDetailsButton" id="addDetailsButton" style="margin-bottom: 15px">
					<input type="button"  class="btn btn-success" onClick="addMenuItems();" value="Add Menu Item"/>
				</div>
			</div>
		</div>
	</div>
	<div class="tab-pane" id="detailReportParameter">
		<div class="row">
			<div class="col-lg-12 col-md-12">
				<g:render template="reportParameterDetail"/>
				<div class="addDetailsButton" id="addDetailsButton" style="margin-bottom: 15px">
					<input type="button" class="btn btn-success" onClick="addReportParameterDetails();"
						   value="Add Report Parameter"/>
				</div>
			</div>
		</div>
	</div>
</div>