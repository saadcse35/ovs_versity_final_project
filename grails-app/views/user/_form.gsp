<%@ page import="common.accessControl.User" %>




<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'code', 'error')} required">
		<div class="form-group">
			<label for="code" class="control-label">
				<g:message code="user.code.label" default="Code" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" disabled="disabled" name="code" maxlength="30" required="" value="${userInstance?.code}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
		<div class="form-group">
			<label for="name" class="control-label">
				<g:message code="user.name.label" default="Name" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="name" maxlength="100" required="" value="${userInstance?.name}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'defaultRole', 'error')} required">
		<div class="form-group">
			<label for="defaultRole" class="control-label">
				<g:message code="user.defaultRole.label" default="Default Role" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" name="defaultRole" from="${userInstance.constraints.defaultRole.inList}" required="" value="${userInstance?.defaultRole}" valueMessagePrefix="user.defaultRole"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'emailAddress', 'error')} required">
		<div class="form-group">
			<label for="emailAddress" class="control-label">
				<g:message code="user.emailAddress.label" default="Email Address" />
				<span class="required-indicator">*</span>
			</label>
			<g:field type="email" class="form-control" name="emailAddress" maxlength="200" required="" value="${userInstance?.emailAddress}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'contactNo', 'error')} ">
		<div class="form-group">
			<label for="contactNo" class="control-label">
				<g:message code="user.contactNo.label" default="Contact No" />
				
			</label>
			<g:textField class="form-control" name="contactNo" maxlength="15" value="${userInstance?.contactNo}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
		<div class="form-group">
			<label for="password" class="control-label">
				<g:message code="user.password.label" default="Password" />
				<span class="required-indicator">*</span>
			</label>
			<g:field type="password" class="form-control" name="password" maxlength="100" required="" value="${userInstance?.password}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'confirmPassword', 'error')} required">
		<div class="form-group">
			<label for="confirmPassword" class="control-label">
				<g:message code="user.confirmPassword.label" default="Confirm Password" />
				<span class="required-indicator">*</span>
			</label>
			<g:field type="password" class="form-control" name="confirmPassword" maxlength="100" required="" value="${userInstance?.confirmPassword}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'resetCode', 'error')} ">
		<div class="form-group">
			<label for="resetCode" class="control-label">
				<g:message code="user.resetCode.label" default="Reset Code" />
				
			</label>
			<g:textField class="form-control" name="resetCode" value="${userInstance?.resetCode}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'resetToken', 'error')} ">
		<div class="form-group">
			<label for="resetToken" class="control-label">
				<g:message code="user.resetToken.label" default="Reset Token" />
				
			</label>
			<g:textField class="form-control" name="resetToken" maxlength="100" value="${userInstance?.resetToken}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'resetTokenSetDate', 'error')} ">
		<div class="form-group">
			<label for="resetTokenSetDate" class="control-label">
				<g:message code="user.resetTokenSetDate.label" default="Reset Token Set Date" />
				
			</label>
			<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="resetTokenSetDate" id="resetTokenSetDate"  value="${formatDate(format: 'dd/MM/yyyy', date: userInstance?.resetTokenSetDate)}" default="none" noSelection="['': '']" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'isTokenUsed', 'error')} ">
		<div class="form-group">
			<label for="isTokenUsed" class="control-label">
				<g:message code="user.isTokenUsed.label" default="Is Token Used" />
				
			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isTokenUsed" value="${userInstance?.isTokenUsed}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'remarks', 'error')} ">
		<div class="form-group">
			<label for="remarks" class="control-label">
				<g:message code="user.remarks.label" default="Remarks" />
				
			</label>
			<g:textArea class="form-control" name="remarks" cols="40" rows="5" maxlength="1000" value="${userInstance?.remarks}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'isActive', 'error')} ">
		<div class="form-group">
			<label for="isActive" class="control-label">
				<g:message code="user.isActive.label" default="Is Active" />
				
			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isActive" value="${userInstance?.isActive}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'activeFrom', 'error')} ">
		<div class="form-group">
			<label for="activeFrom" class="control-label">
				<g:message code="user.activeFrom.label" default="Active From" />
				
			</label>
			<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="activeFrom" id="activeFrom"  value="${formatDate(format: 'dd/MM/yyyy', date: userInstance?.activeFrom)}" default="none" noSelection="['': '']" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'activeTo', 'error')} ">
		<div class="form-group">
			<label for="activeTo" class="control-label">
				<g:message code="user.activeTo.label" default="Active To" />
				
			</label>
			<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="activeTo" id="activeTo"  value="${formatDate(format: 'dd/MM/yyyy', date: userInstance?.activeTo)}" default="none" noSelection="['': '']" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: userInstance, field: 'userTasks', 'error')} ">
		<div class="form-group">
			<label for="userTasks" class="control-label">
				<g:message code="user.userTasks.label" default="User Tasks" />
				
			</label>
			
<ul class="one-to-many">
<g:each in="${userInstance?.userTasks?}" var="u">
    <li><g:link controller="userTask" action="show" id="${u.id}">${u?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="userTask" action="create" params="['user.id': userInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'userTask.label', default: 'UserTask')])}</g:link>
</li>
</ul>

		</div>
	</div>
</div>


