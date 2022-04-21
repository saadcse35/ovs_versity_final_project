
<%@ page import="common.data.DataLookup" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'dataLookup.label', default: 'DataLookup')}" />
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
												<g:fieldValue bean="${dataLookupInstance}" field="code"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Name
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="name-label">
												<g:fieldValue bean="${dataLookupInstance}" field="name"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Parent Id
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="parentId-label">
												<g:link controller="dataLookup" action="show" id="${dataLookupInstance?.parentId?.id}">
													${dataLookupInstance?.parentId?.encodeAsHTML()}
												</g:link>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Serial Number
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="serialNumber-label">
												<g:fieldValue bean="${dataLookupInstance}" field="serialNumber"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Remarks
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="remarks-label">
												<g:fieldValue bean="${dataLookupInstance}" field="remarks"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Is Active
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="isActive-label">
												<g:formatBoolean boolean="${dataLookupInstance?.isActive}"
																 true="Yes" false="No" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Active From
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="activeFrom-label">
												<g:formatDate date="${dataLookupInstance?.activeFrom}" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Active To
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="activeTo-label">
												<g:formatDate date="${dataLookupInstance?.activeTo}" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Status
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="status-label">
												<g:fieldValue bean="${dataLookupInstance}" field="status"/>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Date Created
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="dateCreated-label">
												<g:formatDate date="${dataLookupInstance?.dateCreated}" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Last Updated
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="lastUpdated-label">
												<g:formatDate date="${dataLookupInstance?.lastUpdated}" />
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Created By User Id
										</th>
										<td>
											
											<span class="property-value" aria-labelledby="createdByUserId-label">
												<g:link controller="user" action="show" id="${dataLookupInstance?.createdByUserId?.id}">
													${dataLookupInstance?.createdByUserId?.encodeAsHTML()}
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
												<g:link controller="user" action="show" id="${dataLookupInstance?.lastUpdatedByUserId?.id}">
													${dataLookupInstance?.lastUpdatedByUserId?.encodeAsHTML()}
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
												<g:link controller="accessLog" action="show" id="${dataLookupInstance?.createdBySessionId?.id}">
													${dataLookupInstance?.createdBySessionId?.encodeAsHTML()}
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
												<g:link controller="accessLog" action="show" id="${dataLookupInstance?.lastUpdatedBySessionId?.id}">
													${dataLookupInstance?.lastUpdatedBySessionId?.encodeAsHTML()}
												</g:link>
											</span>
											
										</td>
									</tr>
									
									<tr>
										<th>
											Data Lookups
										</th>
										<td>
											
											<g:each in="${dataLookupInstance.dataLookups}" var="d">
												<span class="property-value" aria-labelledby="dataLookups-label">
													<g:link controller="dataLookup" action="show" id="${d.id}">
														${d?.encodeAsHTML()}
													</g:link>
												</span>
											</g:each>
											
										</td>
									</tr>
									
								</table>
							</div>
							<br/>
							<g:form url="[resource:dataLookupInstance, action:'delete']" method="DELETE">
								<fieldset class="buttons">
									<g:link class="btn btn-primary edit" action="edit" resource="${dataLookupInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
