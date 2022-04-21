<%@ page import="onlinevotingsystem.Party" %>


<div class="row">

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: partyInstance, field: 'name', 'error')} required">
		<div class="form-group">
			<label for="name" class="control-label">
				<g:message code="party.name.label" default="Name" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="name" maxlength="100" required="" value="${partyInstance?.name}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: partyInstance, field: 'shortName', 'error')} required">
		<div class="form-group">
			<label for="shortName" class="control-label">
				<g:message code="party.shortName.label" default="Short Name" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="shortName" maxlength="50" required="" value="${partyInstance?.shortName}"/>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: partyInstance, field: 'regDate', 'error')} required">
		<div class="form-group">
			<label for="regDate" class="control-label">
				<g:message code="party.regDate.label" default="Registration Date" />
			</label>

			<g:textField class="form-control datemask" name="regDate" id="regDate" data-inputmask-alias="datetime"
						 data-inputmask-inputformat="dd/mm/yyyy"
						 value="${formatDate(format: 'dd/MM/yyyy', date: partyInstance?.regDate == null ? new Date() : partyInstance?.regDate)}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: seatInstance, field: 'electionId', 'error')} required">
		<div class="form-group">
			<label for="electionId" class="control-label">
				<g:message code="seat.electionId.label" default="Election" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" id="electionId" name="electionId.id" from="${onlinevotingsystem.Election.findByIsActiveAndStatus(true, 'ACTIVE')}" optionKey="id" required="" noSelection="['':'']" value="${partyInstance?.electionId?.id}" />
		</div>
	</div>
</div>



<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: partyInstance, field: 'partyDescription', 'error')} required">
		<div class="form-group">
			<label for="partyDescription" class="control-label">
				<g:message code="party.partyDescription.label" default="Party Description" />
			</label>
			<g:textArea class="form-control" name="partyDescription" cols="40" rows="5" maxlength="4000" value="${partyInstance?.partyDescription}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: partyInstance, field: 'isActive', 'error')} ">
		<div class="form-group">
			<label for="isActive" class="control-label">
				<g:message code="party.isActive.label" default="Is Active" />

			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isActive" value="${partyInstance?.isActive}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: partyInstance, field: 'sortOrder', 'error')} ">
		<div class="form-group">
			<label for="sortOrder" class="control-label">
				<g:message code="party.sortOrder.label" default="Sort Order" />
				
			</label>
			<g:field class="form-control" name="sortOrder" type="number" value="${partyInstance.sortOrder}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: partyInstance, field: 'imagePath1', 'error')} required">
		<div class="form-group">
			<label for="imagePath1" class="control-label">
				<g:message code="party.imagePath.label" default="Image Path" />
				<span class="required-indicator">*</span>
			</label>
			<input type="file" class="form-control" name="imagePath1"/>
			%{--<g:textField class="form-control" name="imagePath" required="" value="${partyInstance?.imagePath}"/>--}%
		</div>
	</div>
</div>




