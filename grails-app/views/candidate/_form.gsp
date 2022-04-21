<%@ page import="onlinevotingsystem.Candidate" %>




<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'code', 'error')} required">
		<div class="form-group">
			<label for="code" class="control-label">
				<g:message code="candidate.code.label" default="Code" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="code" disabled="disabled" required="" value="${candidateInstance?.code}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'personId', 'error')} required">
		<div class="form-group">
			<label for="personId" class="control-label">
				<g:message code="candidate.personId.label" default="Person Id" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" id="personId"  noSelection="['':'']" name="personId.id" from="${common.core.Person.list()}" optionKey="id" required="" value="${candidateInstance?.personId?.id}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'imagePath1', 'error')} ">
		<div class="form-group">
			<label for="imagePath1" class="control-label">
				<g:message code="candidate.imagePath.label" default="Image Path" />
				
			</label>
			%{--<g:textField class="form-control" name="imagePath" value="${candidateInstance?.imagePath}"/>--}%
			<input type="file" class="form-control" name="imagePath1"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'voterId', 'error')} required">
		<div class="form-group">
			<label for="voterId" class="control-label">
				<g:message code="candidate.voterId.label" default="Voter Id" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" id="voterId"  noSelection="['':'']" name="voterId.id" from="${onlinevotingsystem.Voter.list()}" optionKey="id" required="" value="${candidateInstance?.voterId?.id}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'partyId', 'error')} required">
		<div class="form-group">
			<label for="partyId" class="control-label">
				<g:message code="candidate.partyId.label" default="Party Id" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" id="partyId"  noSelection="['':'']" name="partyId.id" from="${onlinevotingsystem.Party.list()}" optionKey="id" required="" value="${candidateInstance?.partyId?.id}" />
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'electionId', 'error')} required">
		<div class="form-group">
			<label for="electionId" class="control-label">
				<g:message code="candidate.electionId.label" default="Election Id" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" id="electionId"  noSelection="['':'']" name="electionId.id" from="${onlinevotingsystem.Election.list()}" optionKey="id" required="" value="${candidateInstance?.electionId?.id}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'seatId', 'error')} required">
		<div class="form-group">
			<label for="seatId" class="control-label">
				<g:message code="candidate.seatId.label" default="Seat Id" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" id="seatId"  noSelection="['':'']" name="seatId.id" from="${onlinevotingsystem.Seat.list()}" optionKey="id" required="" value="${candidateInstance?.seatId?.id}" />
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'contactNumber', 'error')} required">
		<div class="form-group">
			<label for="contactNumber" class="control-label">
				<g:message code="candidate.contactNumber.label" default="Contact Number" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="contactNumber" maxlength="20" required="" value="${candidateInstance?.contactNumber}"/>
		</div>
	</div>
</div>




<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'emailAddress', 'error')} ">
		<div class="form-group">
			<label for="emailAddress" class="control-label">
				<g:message code="candidate.emailAddress.label" default="Email Address" />
				
			</label>
			<g:field type="email" class="form-control" name="emailAddress" maxlength="100" value="${candidateInstance?.emailAddress}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'nationalIdNumber', 'error')} required">
		<div class="form-group">
			<label for="nationalIdNumber" class="control-label">
				<g:message code="candidate.nationalIdNumber.label" default="National Id Number" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="nationalIdNumber" maxlength="30" required="" value="${candidateInstance?.nationalIdNumber}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'fileUploadPath1', 'error')} ">
		<div class="form-group">
			<label for="fileUploadPath1" class="control-label">
				<g:message code="candidate.fileUploadPath.label" default="Upload Your File" />

			</label>
			%{--<g:textField class="form-control" name="imagePath" value="${candidateInstance?.imagePath}"/>--}%
			<input type="file" class="form-control" name="fileUploadPath1"/>
		</div>
	</div>
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'sortOrder', 'error')} ">
		<div class="form-group">
			<label for="sortOrder" class="control-label">
				<g:message code="candidate.sortOrder.label" default="Sort Order" />
				
			</label>
			<g:field class="form-control" name="sortOrder" type="number" value="${candidateInstance.sortOrder}"/>
		</div>
	</div>
</div>



<div class="row">

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'remarks', 'error')} ">
		<div class="form-group">
			<label for="remarks" class="control-label">
				<g:message code="candidate.remarks.label" default="Remarks" />

			</label>
			<g:textArea class="form-control" name="remarks" cols="40" rows="5" maxlength="1000" value="${candidateInstance?.remarks}"/>
		</div>
	</div>
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: candidateInstance, field: 'isActive', 'error')} ">
		<div class="form-group">
			<label for="isActive" class="control-label">
				<g:message code="candidate.isActive.label" default="Is Active" />
				
			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isActive" value="${candidateInstance?.isActive}" />
		</div>
	</div>
</div>


