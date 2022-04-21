
<%@ page import="onlinevotingsystem.Candidate" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'candidate.label', default: 'Candidate')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1><g:message code="default.show.label" args="[entityName]" /></h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item active">
							<g:link controller="authorise" action="home">
								Home
							</g:link>
						</li>
						<li class="breadcrumb-item ">
							<g:link class="list" action="index"> ${entityName} </g:link>
						</li>
						<li class="breadcrumb-item ">
							Show
						</li>
					</ol>
				</div>
			</div>
		</div><!-- /.container-fluid -->
	</section>

	<!-- Main content -->
	<section class="content">
		<div class="container-fluid">
			<g:if test="${flash.message}">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h3 class="alert alert-secondary">${flash.message}</h3>
							</div>
						</div>
					</div>
				</div>
			</g:if>

			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-header">
							<g:link class="btn btn-info" action="index"><i class="fa fa-list"></i>&nbsp; ${entityName} List </g:link>
							<g:link class="btn btn-info create_new" action="create"><i class="fa fa-pencil"></i>&nbsp;<g:message code="default.new.label" args="[entityName]" /></g:link>
						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<div class="card-body table-responsive p-0">
								<table class="table table-hover text-nowrap">
									
									<tr>
										<th>
											Code
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="code-label">
												<g:fieldValue bean="${candidateInstance}" field="code"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Person Id
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="personId-label">
												<g:link controller="person" action="show" id="${candidateInstance?.personId?.id}">
													${candidateInstance?.personId?.encodeAsHTML()}
												</g:link>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Image Path
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="imagePath-label">
												<g:fieldValue bean="${candidateInstance}" field="imagePath"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Voter Id
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="voterId-label">
												<g:link controller="voter" action="show" id="${candidateInstance?.voterId?.id}">
													${candidateInstance?.voterId?.encodeAsHTML()}
												</g:link>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Party Id
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="partyId-label">
												<g:link controller="party" action="show" id="${candidateInstance?.partyId?.id}">
													${candidateInstance?.partyId?.encodeAsHTML()}
												</g:link>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Election Id
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="electionId-label">
												<g:link controller="election" action="show" id="${candidateInstance?.electionId?.id}">
													${candidateInstance?.electionId?.encodeAsHTML()}
												</g:link>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Seat Id
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="seatId-label">
												<g:link controller="seat" action="show" id="${candidateInstance?.seatId?.id}">
													${candidateInstance?.seatId?.encodeAsHTML()}
												</g:link>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Contact Number
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="contactNumber-label">
												<g:fieldValue bean="${candidateInstance}" field="contactNumber"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Email Address
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="emailAddress-label">
												<g:fieldValue bean="${candidateInstance}" field="emailAddress"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											National Id Number
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="nationalIdNumber-label">
												<g:fieldValue bean="${candidateInstance}" field="nationalIdNumber"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Sort Order
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="sortOrder-label">
												<g:fieldValue bean="${candidateInstance}" field="sortOrder"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Remarks
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="remarks-label">
												<g:fieldValue bean="${candidateInstance}" field="remarks"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Status
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="status-label">
												<g:fieldValue bean="${candidateInstance}" field="status"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Is Active
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="isActive-label">
												<g:formatBoolean boolean="${candidateInstance?.isActive}"
																 true="Yes" false="No" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Date Created
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="dateCreated-label">
												<g:formatDate date="${candidateInstance?.dateCreated}" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Last Updated
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="lastUpdated-label">
												<g:formatDate date="${candidateInstance?.lastUpdated}" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Created By User Id
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="createdByUserId-label">
												<g:link controller="user" action="show" id="${candidateInstance?.createdByUserId?.id}">
													${candidateInstance?.createdByUserId?.encodeAsHTML()}
												</g:link>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Last Updated By User Id
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="lastUpdatedByUserId-label">
												<g:link controller="user" action="show" id="${candidateInstance?.lastUpdatedByUserId?.id}">
													${candidateInstance?.lastUpdatedByUserId?.encodeAsHTML()}
												</g:link>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Created By Session Id
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="createdBySessionId-label">
												<g:link controller="accessLog" action="show" id="${candidateInstance?.createdBySessionId?.id}">
													${candidateInstance?.createdBySessionId?.encodeAsHTML()}
												</g:link>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Last Updated By Session Id
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="lastUpdatedBySessionId-label">
												<g:link controller="accessLog" action="show" id="${candidateInstance?.lastUpdatedBySessionId?.id}">
													${candidateInstance?.lastUpdatedBySessionId?.encodeAsHTML()}
												</g:link>
											</span>
											
										</td>
									</tr>
									
								</table>
							</div>
							<br/>
							<g:form url="[resource:candidateInstance, action:'delete']" method="DELETE">
								<fieldset class="buttons">
									<g:link class="btn btn-primary edit" action="edit" resource="${candidateInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
									<g:actionSubmit class="btn btn-danger delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
								</fieldset>
							</g:form>
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->
				</div>
			</div>
		</div>
	</section>
</div>
<!-- /.content-wrapper -->
</body>
</html>
