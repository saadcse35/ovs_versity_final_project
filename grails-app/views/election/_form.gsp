<%@ page import="onlinevotingsystem.Election" %>

<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: electionInstance, field: 'code', 'error')} required">
		<div class="form-group">
			<label for="code" class="control-label">
				<g:message code="election.code.label" default="Code" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" disabled="disabled" name="code" required="" value="${electionInstance?.code}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: electionInstance, field: 'name', 'error')} required">
		<div class="form-group">
			<label for="name" class="control-label">
				<g:message code="election.name.label" default="Name" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="name" required="" value="${electionInstance?.name}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: electionInstance, field: 'startDate', 'error')} required">
		<div class="form-group">
			<label for="startDate" class="control-label">
				<g:message code="election.startDate.label" default="Start Date" />
				<span class="required-indicator">*</span>
			</label>

			<g:textField class="form-control datemask" name="startDate" id="startDate" data-inputmask-alias="datetime"
						 data-inputmask-inputformat="dd/mm/yyyy"
						 value="${formatDate(format: 'dd/MM/yyyy', date: electionInstance?.startDate == null ? new Date() : electionInstance?.startDate)}" required=""/>


			%{--<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="startDate" id="startDate"  value="${formatDate(format: 'dd/MM/yyyy', date: electionInstance?.startDate)}"  />--}%
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: electionInstance, field: 'endDate', 'error')} required">
		<div class="form-group">
			<label for="endDate" class="control-label">
				<g:message code="election.endDate.label" default="End Date" />
				<span class="required-indicator">*</span>
			</label>

			<g:textField class="form-control datemask" name="endDate" id="startDate" data-inputmask-alias="datetime"
						 data-inputmask-inputformat="dd/mm/yyyy"
						 value="${formatDate(format: 'dd/MM/yyyy', date: electionInstance?.endDate == null ? new Date() : electionInstance?.endDate)}" required=""/>

			%{--<g:textField data-provide="datepicker" data-date-autoclose="true"  data-date-format="dd/mm/yyyy" class="form-control"  name="endDate" id="endDate"  value="${formatDate(format: 'dd/MM/yyyy', date: electionInstance?.endDate)}"  />--}%
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: electionInstance, field: 'isActive', 'error')} ">
		<div class="form-group">
			<label for="isActive" class="control-label">
				<g:message code="election.isActive.label" default="Is Active" />
				
			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isActive" value="${electionInstance?.isActive}" />
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: electionInstance, field: 'sortOrder', 'error')} ">
		<div class="form-group">
			<label for="sortOrder" class="control-label">
				<g:message code="election.sortOrder.label" default="Sort Order" />

			</label>
			<g:field class="form-control" name="sortOrder" type="number" value="${electionInstance.sortOrder}"/>
		</div>
	</div>
</div>



