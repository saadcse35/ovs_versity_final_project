<%@ page import="onlinevotingsystem.Vote" %>




<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voteInstance, field: 'code', 'error')} required">
		<div class="form-group">
			<label for="code" class="control-label">
				<g:message code="vote.code.label" default="Code" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="code" required="" value="${voteInstance?.code}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voteInstance, field: 'electionId', 'error')} required">
		<div class="form-group">
			<label for="electionId" class="control-label">
				<g:message code="vote.electionId.label" default="Election Id" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" id="electionId" name="electionId.id" from="${onlinevotingsystem.Election.list()}" optionKey="id" required="" value="${voteInstance?.electionId?.id}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voteInstance, field: 'voterId', 'error')} required">
		<div class="form-group">
			<label for="voterId" class="control-label">
				<g:message code="vote.voterId.label" default="Voter Id" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" id="voterId" name="voterId.id" from="${onlinevotingsystem.Voter.list()}" optionKey="id" required="" value="${voteInstance?.voterId?.id}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voteInstance, field: 'candidateId', 'error')} required">
		<div class="form-group">
			<label for="candidateId" class="control-label">
				<g:message code="vote.candidateId.label" default="Candidate Id" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" id="candidateId" name="candidateId.id" from="${onlinevotingsystem.Candidate.list()}" optionKey="id" required="" value="${voteInstance?.candidateId?.id}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voteInstance, field: 'isActive', 'error')} ">
		<div class="form-group">
			<label for="isActive" class="control-label">
				<g:message code="vote.isActive.label" default="Is Active" />
				
			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isActive" value="${voteInstance?.isActive}" />
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: voteInstance, field: 'sortOrder', 'error')} ">
		<div class="form-group">
			<label for="sortOrder" class="control-label">
				<g:message code="vote.sortOrder.label" default="Sort Order" />
				
			</label>
			<g:field class="form-control" name="sortOrder" type="number" value="${voteInstance.sortOrder}"/>
		</div>
	</div>
</div>


