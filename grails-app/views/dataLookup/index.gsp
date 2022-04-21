
<%@ page import="common.data.DataLookup" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'dataLookupInstance.label', default: 'DataLookup')}" />
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
									
									<g:sortableColumn property="code" title="${message(code: 'dataLookup.code.label', default: 'Code')}" />
									
									<g:sortableColumn property="name" title="${message(code: 'dataLookup.name.label', default: 'Name')}" />
									
									<th><g:message code="dataLookup.parentId.label" default="Parent Id" /></th>
									
									<g:sortableColumn property="serialNumber" title="${message(code: 'dataLookup.serialNumber.label', default: 'Serial Number')}" />
									
									<g:sortableColumn property="remarks" title="${message(code: 'dataLookup.remarks.label', default: 'Remarks')}" />
									
									<g:sortableColumn property="isActive" title="${message(code: 'dataLookup.isActive.label', default: 'Is Active')}" />
									
									<g:sortableColumn property="activeFrom" title="${message(code: 'dataLookup.activeFrom.label', default: 'Active From')}" />
									
									<g:sortableColumn property="activeTo" title="${message(code: 'dataLookup.activeTo.label', default: 'Active To')}" />
									
									<th>Action</th>
								</tr>
								</thead>
								<tbody>
								<g:each in="${dataLookupInstanceList}" status="i" var="dataLookupInstance">
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
										
										<td><g:link action="show" id="${dataLookupInstance.id}">${fieldValue(bean: dataLookupInstance, field: "code")}</g:link></td>
										
										<td>${fieldValue(bean: dataLookupInstance, field: "name")}</td>
										
										<td>${fieldValue(bean: dataLookupInstance, field: "parentId")}</td>
										
										<td>${fieldValue(bean: dataLookupInstance, field: "serialNumber")}</td>
										
										<td>${fieldValue(bean: dataLookupInstance, field: "remarks")}</td>
										
										<td>
											<g:formatBoolean boolean="${dataLookupInstance?.isActive}" true="Yes" false="No" />
										</td>
										
										<td><g:formatDate date="${dataLookupInstance.activeFrom}" /></td>
										
										<td><g:formatDate date="${dataLookupInstance.activeTo}" /></td>
										
										<td>
											<button type="button" class="btn btn-default" title="Show">
												<g:link action="show" id="${dataLookupInstance.id}"><i class="fa fa-eye"></i></g:link>
											</button>
											<button type="button" class="btn btn-default" title="Edit">
												<g:link action="edit" id="${dataLookupInstance.id}"><i class="fa fa-edit"></i></g:link>
											</button>

										</td>
									</tr>
								</g:each>
								</tbody>
							</table>
						</div>
						<!-- /.card-body -->
						<div class="pagination">
							<g:paginate total="${dataLookupInstanceInstanceCount ?: 0}" params="${[anyText: params.anyText, code: params.code, name: params.name]}" />
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