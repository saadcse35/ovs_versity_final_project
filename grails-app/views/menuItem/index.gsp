<%@ page import="common.accessControl.MenuItem" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main"/>
	<g:set var="entityName" value="${message(code: 'menuItem.label', default: 'Menu Item')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<div class="container-fluid">


	<div class="block-header">
		<div class="row">
			<div class="col-lg-5 col-md-8 col-sm-12">

				<ul class="nav nav-pills">
					<h4><g:message code="default.list.label" args="[entityName]" /></h4>

				</ul>
			</div>
			<div class="col-lg-7 col-md-4 col-sm-12 text-right">
				<ul class="breadcrumb justify-content-end">
					<li class="breadcrumb-item">
						<g:link controller="authorise" action="home">
							<i class="icon-home"></i>
						</g:link>
					</li>
					<li class="breadcrumb-item active">
						<g:link class="list" action="index"> ${entityName} </g:link>
					</li>
					<li class="breadcrumb-item ">
						List
					</li>
				</ul>
			</div>
		</div>
	</div>

	<g:if test="${flash.message}">
		<div class="row clearfix">
			<div class="col-md-12">
				<div class="card">
					<div class="header">
					</div>
					<div class="body">
						<div class="message" role="status"><h5 class="alert alert-warning">${flash.message}</h5></div>
					</div>
				</div>
			</div>
		</div>
	</g:if>

	<div class="row clearfix">
		<div class="col-md-12">
			<div class="card">
				<div class="header">
					<g:link class="btn btn-info create_new" action="create"><i class="fa fa-pencil"></i>&nbsp;<g:message code="default.new.label" args="[entityName]" /></g:link>
				</div>
				<div class="body">
					<div class="row">
						<g:form class="form-inline" action="search" method="post">
							<div class="col-lg-3 col-md-3">
								<label for="anyText" style="float: left">Select Any One</label>
								<g:textField  class="form-control" style="width: 100%" name="anyText" value="${params.anyText}"/>
							</div>

							<div class="col-lg-3 col-md-3">
								<label for="code" style="float: left">Code:</label>
								<g:textField name="code" class="form-control" STYLE="width: 100%" value="${params.code}" noSelection="['':'']"/>
							</div>

							<div class="col-lg-3 col-md-3">
								<label for="name" style="float: left">Name:</label>
								<g:textField name="name" class="form-control" style="width: 100%" value="${params.name}" noSelection="['':'']"/>
							</div>

							<div class="col-lg-3 col-md-3">
								<label for="menuType" style="float: left">Menu Type:</label>
								<g:select class="form-control" style="width: 100%" id="menuType" name="menuType" from="${['Module', 'Sub Module', 'Menu Item', 'Task', 'Report Group', 'Report Sub-Group', 'Report']}"
										  value="${params?.menuType}"  noSelection="['': 'Select Menu Type']"/>
							</div>

							<div class="col-lg-3 col-md-3">
								<label for="">&nbsp;</label>
								<button type="submit" style="width: 100%" class="btn btn-primary btn-block">Search</button>
							</div>
						</g:form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row clearfix">
		<div class="col-md-12">
			<div class="card">
				%{--<div class="header">

				</div>--}%
				<div class="body">
					<div class="table-responsive">
						<table class="table table-hover m-b-0 c_list">
							<thead>
								<tr>
									<g:sortableColumn property="code" title="${message(code: 'menuItem.code.label', default: 'Code')}" />
									<g:sortableColumn property="name" title="${message(code: 'menuItem.name.label', default: 'Name')}" />
									<th><g:message code="menuItem.parentId.label" default="Parent Menu" /></th>
									<g:sortableColumn property="menuType" title="${message(code: 'menuItem.menuType.label', default: 'Menu Type')}" />
									<g:sortableColumn property="remarks" title="${message(code:
											'menuItem.remarks.label', default: 'Remarks')}" />
									<g:sortableColumn property="isActive" title="${message(code:
											'menuItem.isActive.label', default: 'Is Active')}" />
									<g:sortableColumn property="sortOrder" title="${message(code: 'menuItem.sortOrder.label', default: 'Sort Order')}" />
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<g:each in="${menuItemInstanceList}" status="i" var="menuItemInstance">
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
										
										<td><g:link action="show" id="${menuItemInstance.id}">${fieldValue(bean: menuItemInstance, field: "code")}</g:link></td>
										
										<td>${fieldValue(bean: menuItemInstance, field: "name")}</td>
										
										<td>${fieldValue(bean: menuItemInstance, field: "parentId")}</td>
										
										<td>${fieldValue(bean: menuItemInstance, field: "menuType")}</td>
										
										<td>${fieldValue(bean: menuItemInstance, field: "remarks")}</td>
										
										<td><g:formatBoolean boolean="${menuItemInstance.isActive}"true="Yes"
															 false="No"  /></td>
										<td>${fieldValue(bean: menuItemInstance, field: "sortOrder")}</td>

										<td>
											<button type="button" class="btn btn-default" title="Show">
												<g:link action="show" id="${menuItemInstance.id}"><i class="fa fa-eye"></i></g:link>
											</button>
											<button type="button" class="btn btn-default" title="Edit">
												<g:link action="edit" id="${menuItemInstance.id}"><i class="fa fa-edit"></i></g:link>
											</button>

										</td>
									</tr>
								</g:each>
							</tbody>
						</table>
					</div>
					<div class="pagination">
						<g:paginate total="${menuItemInstanceCount ?: 0}" params="${[anyText: params.anyText, code: params.code, name: params.name, menuType: params.menuType]}" />
					</div>
				</div>
			</div>
		</div>
	</div>


			</div><!-- /.container-fluid -->
		</section>
		<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->
</body>
</html>
