<%@ page import="onlinevotingsystem.Voter" %>

<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voterInstance, field: 'code', 'error')} required">
		<div class="form-group">
			<label for="code" class="control-label">
				<g:message code="voter.code.label" default="Code" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" disabled="disabled" name="code" required="" value="${voterInstance?.code}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voterInstance, field: 'personId', 'error')} required">
		<div class="form-group">
			<label for="personId" class="control-label">
				<g:message code="voter.personId.label" default="Person Id" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" id="personId" noSelection="['':'']" name="personId.id" from="${common.core.Person.list()}" optionKey="id" required="" value="${voterInstance?.personId?.id}" />
		</div>
	</div>
</div>



<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voterInstance, field: 'contactNumber', 'error')} required">
		<div class="form-group">
			<label for="contactNumber" class="control-label">
				<g:message code="voter.contactNumber.label" default="Contact Number" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="contactNumber" maxlength="20" required="" value="${voterInstance?.contactNumber}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voterInstance, field: 'emailAddress', 'error')} ">
		<div class="form-group">
			<label for="emailAddress" class="control-label">
				<g:message code="voter.emailAddress.label" default="Email Address" />

			</label>
			<g:field type="email" class="form-control" name="emailAddress" maxlength="100" value="${voterInstance?.emailAddress}"/>
		</div>
	</div>
</div>



<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voterInstance, field: 'password', 'error')} required">
		<div class="form-group">
			<label for="password" class="control-label">
				<g:message code="voter.password.label" default="Password" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="password" required="" value="${voterInstance?.password}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voterInstance, field: 'confirmPassword', 'error')} required">
		<div class="form-group">
			<label for="confirmPassword" class="control-label">
				<g:message code="voter.confirmPassword.label" default="Confirm Password" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="confirmPassword" required="" value="${voterInstance?.confirmPassword}"/>
		</div>
	</div>
</div>



<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voterInstance, field: 'nationalIdNumber', 'error')} required">
		<div class="form-group">
			<label for="nationalIdNumber" class="control-label">
				<g:message code="voter.nationalIdNumber.label" default="National Id Number" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="nationalIdNumber" maxlength="30" required="" value="${voterInstance?.nationalIdNumber}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voterInstance, field: 'remarks', 'error')} ">
		<div class="form-group">
			<label for="remarks" class="control-label">
				<g:message code="voter.remarks.label" default="Remarks" />

			</label>
			<g:textArea class="form-control" name="remarks" cols="40" rows="5" maxlength="1000" value="${voterInstance?.remarks}"/>
		</div>
	</div>
</div>



<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voterInstance, field: 'isActive', 'error')} ">
		<div class="form-group">
			<label for="isActive" class="control-label">
				<g:message code="voter.isActive.label" default="Is Active" />

			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isActive" value="${voterInstance?.isActive}" />
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voterInstance, field: 'sortOrder', 'error')} ">
		<div class="form-group">
			<label for="sortOrder" class="control-label">
				<g:message code="voter.sortOrder.label" default="Sort Order" />

			</label>
			<g:field class="form-control" name="sortOrder" type="number" value="${voterInstance.sortOrder}"/>
		</div>
	</div>
</div>


