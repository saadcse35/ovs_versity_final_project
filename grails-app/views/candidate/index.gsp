
<%@ page import="onlinevotingsystem.Candidate" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'candidateInstance.label', default: 'Candidate')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1>${entityName}</h1>
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
							List
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
								<h3 class="alert alert-info">${flash.message}</h3>
							</div>
						</div>
					</div>
				</div>
			</g:if>

			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-header">
							<g:link class="btn btn-info create_new" action="create"><i class="fa fa-pencil"></i>&nbsp;<g:message code="default.new.label" args="[entityName]" /></g:link>
						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<g:form class="form-inline" action="search" method="post">
								<div class="col-lg-3 col-md-3">
									<label for="anyText" style="float: left">Select Anything: </label>
									<g:textField  class="form-control" style="width: 100%" name="anyText" value="${params.anyText}"/>
								</div>

								<div class="col-lg-3 col-md-3">
									<label for="code" style="float: left">Code:</label>
									<g:textField name="code" class="form-control" style="width: 100%" value="${params.code}" noSelection="['':'']"/>
								</div>

								<div class="col-lg-3 col-md-3">
									<label for="name" style="float: left">Name:</label>
									<g:textField name="name" class="form-control" style="width: 100%" value="${params.name}" noSelection="['':'']"/>
								</div>
								<div class="col-lg-3 col-md-3">
									<label for="">&nbsp;</label>
									<button type="submit" class="btn btn-primary btn-block">Search</button>
								</div>
							</g:form>
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->
				</div>
			</div>

			<div class="row">
				<div class="col-12">
					<div class="card">
						<!-- /.card-header -->
						<div class="card-body table-responsive p-0">
							<table class="table table-hover text-nowrap">
								<thead>
								<tr>
									
									<g:sortableColumn property="code" title="${message(code: 'candidate.code.label', default: 'Code')}" />
									
									<th><g:message code="candidate.personId.label" default="Person Id" /></th>
									
									<g:sortableColumn property="imagePath" title="${message(code: 'candidate.imagePath.label', default: 'Image Path')}" />
									
									<th><g:message code="candidate.voterId.label" default="Voter Id" /></th>
									
									<th><g:message code="candidate.partyId.label" default="Party Id" /></th>
									
									<th><g:message code="candidate.electionId.label" default="Election Id" /></th>
									
									<th><g:message code="candidate.seatId.label" default="Seat Id" /></th>
									
									<g:sortableColumn property="contactNumber" title="${message(code: 'candidate.contactNumber.label', default: 'Contact Number')}" />
									
									<th>Action</th>
								</tr>
								</thead>
								<tbody>
								<g:each in="${candidateInstanceList}" status="i" var="candidateInstance">
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
										
										<td><g:link action="show" id="${candidateInstance.id}">${fieldValue(bean: candidateInstance, field: "code")}</g:link></td>
										
										<td>${fieldValue(bean: candidateInstance, field: "personId")}</td>
										
										<td>${fieldValue(bean: candidateInstance, field: "imagePath")}</td>
										
										<td>${fieldValue(bean: candidateInstance, field: "voterId")}</td>
										
										<td>${fieldValue(bean: candidateInstance, field: "partyId")}</td>
										
										<td>${fieldValue(bean: candidateInstance, field: "electionId")}</td>
										
										<td>${fieldValue(bean: candidateInstance, field: "seatId")}</td>
										
										<td>${fieldValue(bean: candidateInstance, field: "contactNumber")}</td>
										
										<td>
											<button type="button" class="btn btn-default" title="Show">
												<g:link action="show" id="${candidateInstance.id}"><i class="fa fa-eye"></i></g:link>
											</button>
											<button type="button" class="btn btn-default" title="Edit">
												<g:link action="edit" id="${candidateInstance.id}"><i class="fa fa-edit"></i></g:link>
											</button>

										</td>
									</tr>
								</g:each>
								</tbody>
							</table>
						</div>
						<!-- /.card-body -->
						<div class="pagination">
							<g:paginate total="${candidateInstanceInstanceCount ?: 0}" params="${[anyText: params.anyText, code: params.code, name: params.name]}" />
						</div>
					</div>
					<!-- /.card -->
				</div>
			</div>
		</div><!-- /.container-fluid -->
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->
</body>
</html>