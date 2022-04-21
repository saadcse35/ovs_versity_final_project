<%@ page import="common.data.DataLookup" %>




<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: dataLookupInstance, field: 'code', 'error')} ">
		<div class="form-group">
			<label for="code" class="control-label">
				<g:message code="dataLookup.code.label" default="Code" />
				
			</label>
			<g:textField class="form-control" name="code" maxlength="30" value="${dataLookupInstance?.code}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: dataLookupInstance, field: 'name', 'error')} required">
		<div class="form-group">
			<label for="name" class="control-label">
				<g:message code="dataLookup.name.label" default="Name" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="name" maxlength="100" required="" value="${dataLookupInstance?.name}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: dataLookupInstance, field: 'parentId', 'error')} ">
		<div class="form-group">
			<label for="parentId" class="control-label">
				<g:message code="dataLookup.parentId.label" default="Parent Id" />
				
			</label>
			<g:select class="form-control" id="parentId" name="parentId.id" from="${common.data.DataLookup.list()}" optionKey="id" value="${dataLookupInstance?.parentId?.id}"  noSelection="['null': '']"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: dataLookupInstance, field: 'serialNumber', 'error')} ">
		<div class="form-group">
			<label for="serialNumber" class="control-label">
				<g:message code="dataLookup.serialNumber.label" default="Serial Number" />
				
			</label>
			<g:field class="form-control" name="serialNumber" type="number" value="${dataLookupInstance.serialNumber}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: dataLookupInstance, field: 'remarks', 'error')} ">
		<div class="form-group">
			<label for="remarks" class="control-label">
				<g:message code="dataLookup.remarks.label" default="Remarks" />
				
			</label>
			<g:textArea class="form-control" name="remarks" cols="40" rows="5" maxlength="1000" value="${dataLookupInstance?.remarks}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: dataLookupInstance, field: 'isActive', 'error')} ">
		<div class="form-group">
			<label for="isActive" class="control-label">
				<g:message code="dataLookup.isActive.label" default="Is Active" />
				
			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isActive" value="${dataLookupInstance?.isActive}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: dataLookupInstance, field: 'activeFrom', 'error')} ">
		<div class="form-group">
			<label for="activeFrom" class="control-label">
				<g:message code="dataLookup.activeFrom.label" default="Active From" />
				
			</label>
			<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="activeFrom" id="activeFrom"  value="${formatDate(format: 'dd/MM/yyyy', date: dataLookupInstance?.activeFrom)}" default="none" noSelection="['': '']" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: dataLookupInstance, field: 'activeTo', 'error')} ">
		<div class="form-group">
			<label for="activeTo" class="control-label">
				<g:message code="dataLookup.activeTo.label" default="Active To" />
				
			</label>
			<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="activeTo" id="activeTo"  value="${formatDate(format: 'dd/MM/yyyy', date: dataLookupInstance?.activeTo)}" default="none" noSelection="['': '']" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: dataLookupInstance, field: 'dataLookups', 'error')} ">
		<div class="form-group">
			<label for="dataLookups" class="control-label">
				<g:message code="dataLookup.dataLookups.label" default="Data Lookups" />
				
			</label>
			
<ul class="one-to-many">
<g:each in="${dataLookupInstance?.dataLookups?}" var="d">
    <li><g:link controller="dataLookup" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="dataLookup" action="create" params="['dataLookup.id': dataLookupInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'dataLookup.label', default: 'DataLookup')])}</g:link>
</li>
</ul>

		</div>
	</div>
</div>


