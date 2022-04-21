
<%@ page import="onlinevotingsystem.Election" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'electionInstance.label', default: 'Election')}" />
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
									
									<g:sortableColumn property="code" title="${message(code: 'election.code.label', default: 'Code')}" />
									
									<g:sortableColumn property="name" title="${message(code: 'election.name.label', default: 'Name')}" />
									
									<g:sortableColumn property="startDate" title="${message(code: 'election.startDate.label', default: 'Start Date')}" />
									
									<g:sortableColumn property="endDate" title="${message(code: 'election.endDate.label', default: 'End Date')}" />
									
									<g:sortableColumn property="isActive" title="${message(code: 'election.isActive.label', default: 'Is Active')}" />
									
									%{--<g:sortableColumn property="sortOrder" title="${message(code: 'election.sortOrder.label', default: 'Sort Order')}" />--}%
									
									%{--<g:sortableColumn property="dateCreated" title="${message(code: 'election.dateCreated.label', default: 'Date Created')}" />
									
									<g:sortableColumn property="lastUpdated" title="${message(code: 'election.lastUpdated.label', default: 'Last Updated')}" />--}%
									
									<th>Action</th>
								</tr>
								</thead>
								<tbody>
								<g:each in="${electionInstanceList}" status="i" var="electionInstance">
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
										
										<td><g:link action="show" id="${electionInstance.id}">${fieldValue(bean: electionInstance, field: "code")}</g:link></td>
										
										<td>${fieldValue(bean: electionInstance, field: "name")}</td>
										
										<td><g:formatDate date="${electionInstance.startDate}" /></td>
										
										<td><g:formatDate date="${electionInstance.endDate}" /></td>
										
										<td>
											<g:formatBoolean boolean="${electionInstance?.isActive}" true="Yes" false="No" />
										</td>
										
										%{--<td>${fieldValue(bean: electionInstance, field: "sortOrder")}</td>--}%
										
										%{--<td><g:formatDate date="${electionInstance.dateCreated}" /></td>
										
										<td><g:formatDate date="${electionInstance.lastUpdated}" /></td>--}%
										
										<td>
											<button type="button" class="btn btn-default" title="Show">
												<g:link action="show" id="${electionInstance.id}"><i class="fa fa-eye"></i></g:link>
											</button>
											<button type="button" class="btn btn-default" title="Edit">
												<g:link action="edit" id="${electionInstance.id}"><i class="fa fa-edit"></i></g:link>
											</button>

										</td>
									</tr>
								</g:each>
								</tbody>
							</table>
						</div>
						<!-- /.card-body -->
						<div class="pagination">
							<g:paginate total="${electionInstanceInstanceCount ?: 0}" params="${[anyText: params.anyText, code: params.code, name: params.name]}" />
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