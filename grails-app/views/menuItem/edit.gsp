<%@ page import="common.accessControl.MenuItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'menuItem.label', default: 'MenuItem')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
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
						<h4><g:message code="default.edit.label" args="[entityName]" /></h4>
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
							Edit
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
		<g:if test="${menuItemInstance.validate() == false}">
			<div class="row clearfix">
				<div class="col-md-12">
					<div class="card">
						<div class="header">

						</div>
						<div class="body">
							<g:hasErrors bean="${menuItemInstance}">
								<ul class="errors" role="alert">
									<g:eachError bean="${menuItemInstance}" var="error">
										<li class="alert alert-warning" <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
									</g:eachError>
								</ul>
							</g:hasErrors>
						</div>
					</div>
				</div>
			</div>
		</g:if>



		<div class="row clearfix">
			<div class="col-md-12">
				<div class="card">
					<div class="header">
						<g:link class="btn btn-secondary list" action="index"><i class="fa fa-list"></i> &nbsp; <g:message code="default.list.label" args="[entityName]" /></g:link>
						<g:link class="btn btn-info create" action="create"><i class="fa fa-pencil"></i>&nbsp;<g:message code="default.new.label" args="[entityName]" /></g:link>
					</div>
					<div class="body">
						<g:form action="update" method="POST" >
						<g:hiddenField name="id" value="${menuItemInstance?.id}" />
						<fieldset class="form">
							<g:render template="form"/>
						</fieldset>
						<fieldset class="buttons">
							<g:actionSubmit class="btn btn-primary to-disable" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
						</fieldset>
						</g:form>
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
