
<%@ page import="onlinevotingsystem.Election" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'election.label', default: 'Election')}" />
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
												<g:fieldValue bean="${electionInstance}" field="code"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Name
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="name-label">
												<g:fieldValue bean="${electionInstance}" field="name"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Start Date
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="startDate-label">
												<g:formatDate date="${electionInstance?.startDate}" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											End Date
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="endDate-label">
												<g:formatDate date="${electionInstance?.endDate}" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Is Active
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="isActive-label">
												<g:formatBoolean boolean="${electionInstance?.isActive}"
																 true="Yes" false="No" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Status
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="status-label">
												<g:fieldValue bean="${electionInstance}" field="status"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Sort Order
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="sortOrder-label">
												<g:fieldValue bean="${electionInstance}" field="sortOrder"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Date Created
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="dateCreated-label">
												<g:formatDate date="${electionInstance?.dateCreated}" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Last Updated
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="lastUpdated-label">
												<g:formatDate date="${electionInstance?.lastUpdated}" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Created By User Id
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="createdByUserId-label">
												<g:link controller="user" action="show" id="${electionInstance?.createdByUserId?.id}">
													${electionInstance?.createdByUserId?.encodeAsHTML()}
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
												<g:link controller="user" action="show" id="${electionInstance?.lastUpdatedByUserId?.id}">
													${electionInstance?.lastUpdatedByUserId?.encodeAsHTML()}
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
												<g:link controller="accessLog" action="show" id="${electionInstance?.createdBySessionId?.id}">
													${electionInstance?.createdBySessionId?.encodeAsHTML()}
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
												<g:link controller="accessLog" action="show" id="${electionInstance?.lastUpdatedBySessionId?.id}">
													${electionInstance?.lastUpdatedBySessionId?.encodeAsHTML()}
												</g:link>
											</span>
											
										</td>
									</tr>
									
								</table>
							</div>
							<br/>
							<g:form url="[resource:electionInstance, action:'delete']" method="DELETE">
								<fieldset class="buttons">
									<g:link class="btn btn-primary edit" action="edit" resource="${electionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
