<%@ page import="humanResource.setup.Designation" %>




<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: designationInstance, field: 'code', 'error')} required">
		<div class="form-group">
			<label for="code" class="control-label">
				<g:message code="designation.code.label" default="Code" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" disabled="disabled" name="code" maxlength="30" required="" value="${designationInstance?.code}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: designationInstance, field: 'name', 'error')} required">
		<div class="form-group">
			<label for="name" class="control-label">
				<g:message code="designation.name.label" default="Name" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="name" maxlength="100" required="" value="${designationInstance?.name}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: designationInstance, field: 'parentId', 'error')} ">
		<div class="form-group">
			<label for="parentId" class="control-label">
				<g:message code="designation.parentId.label" default="Parent Id" />
				
			</label>
			<g:select class="form-control" id="parentId" name="parentId.id" from="${humanResource.setup.Designation.list()}" optionKey="id" value="${designationInstance?.parentId?.id}"  noSelection="['null': '']"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: designationInstance, field: 'isActive', 'error')} ">
		<div class="form-group">
			<label for="isActive" class="control-label">
				<g:message code="designation.isActive.label" default="Is Active" />
				
			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isActive" value="${designationInstance?.isActive}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: designationInstance, field: 'activeFrom', 'error')} ">
		<div class="form-group">
			<label for="activeFrom" class="control-label">
				<g:message code="designation.activeFrom.label" default="Active From" />
				
			</label>
			<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="activeFrom" id="activeFrom"  value="${formatDate(format: 'dd/MM/yyyy', date: designationInstance?.activeFrom)}" default="none" noSelection="['': '']" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: designationInstance, field: 'activeTo', 'error')} ">
		<div class="form-group">
			<label for="activeTo" class="control-label">
				<g:message code="designation.activeTo.label" default="Active To" />
				
			</label>
			<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="activeTo" id="activeTo"  value="${formatDate(format: 'dd/MM/yyyy', date: designationInstance?.activeTo)}" default="none" noSelection="['': '']" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: designationInstance, field: 'remarks', 'error')} ">
		<div class="form-group">
			<label for="remarks" class="control-label">
				<g:message code="designation.remarks.label" default="Remarks" />
				
			</label>
			<g:textArea class="form-control" name="remarks" cols="40" rows="5" maxlength="1000" value="${designationInstance?.remarks}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: designationInstance, field: 'sortOrder', 'error')} required">
		<div class="form-group">
			<label for="sortOrder" class="control-label">
				<g:message code="designation.sortOrder.label" default="Sort Order" />
				<span class="required-indicator">*</span>
			</label>
			<g:field class="form-control" name="sortOrder" type="number" value="${designationInstance.sortOrder}" required=""/>
		</div>
	</div>
</div>


