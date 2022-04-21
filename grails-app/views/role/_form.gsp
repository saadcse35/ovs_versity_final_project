<%@ page import="common.accessControl.Role" %>




<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: roleInstance, field: 'code', 'error')} required">
		<div class="form-group">
			<label for="code" class="control-label">
				<g:message code="role.code.label" default="Code" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" disabled="disabled" name="code" maxlength="30" required="" value="${roleInstance?.code}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: roleInstance, field: 'name', 'error')} required">
		<div class="form-group">
			<label for="name" class="control-label">
				<g:message code="role.name.label" default="Name" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="name" maxlength="100" required="" value="${roleInstance?.name}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: roleInstance, field: 'remarks', 'error')} ">
		<div class="form-group">
			<label for="remarks" class="control-label">
				<g:message code="role.remarks.label" default="Remarks" />
				
			</label>
			<g:textArea class="form-control" name="remarks" cols="40" rows="5" maxlength="1000" value="${roleInstance?.remarks}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: roleInstance, field: 'isActive', 'error')} ">
		<div class="form-group">
			<label for="isActive" class="control-label">
				<g:message code="role.isActive.label" default="Is Active" />
				
			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isActive" value="${roleInstance?.isActive}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: roleInstance, field: 'activeFrom', 'error')} ">
		<div class="form-group">
			<label for="activeFrom" class="control-label">
				<g:message code="role.activeFrom.label" default="Active From" />
				
			</label>
			<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="activeFrom" id="activeFrom"  value="${formatDate(format: 'dd/MM/yyyy', date: roleInstance?.activeFrom)}" default="none" noSelection="['': '']" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: roleInstance, field: 'activeTo', 'error')} ">
		<div class="form-group">
			<label for="activeTo" class="control-label">
				<g:message code="role.activeTo.label" default="Active To" />
				
			</label>
			<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="activeTo" id="activeTo"  value="${formatDate(format: 'dd/MM/yyyy', date: roleInstance?.activeTo)}" default="none" noSelection="['': '']" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: roleInstance, field: 'roleTasks', 'error')} ">
		<div class="form-group">
			<label for="roleTasks" class="control-label">
				<g:message code="role.roleTasks.label" default="Role Tasks" />
				
			</label>
			
<ul class="one-to-many">
<g:each in="${roleInstance?.roleTasks?}" var="r">
    <li><g:link controller="roleTask" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="roleTask" action="create" params="['role.id': roleInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'roleTask.label', default: 'RoleTask')])}</g:link>
</li>
</ul>

		</div>
	</div>
</div>


