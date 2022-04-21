<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'roleInstance.label', default: 'Role')}" />
	<title><g:message code="default.create.label" args="[entityName]" /></title>
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
							Create
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

			<g:hasErrors bean="${roleInstance}">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<ul class="errors" role="alert">
									<g:eachError bean="${roleInstanceInstance}" var="error">
										<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
									</g:eachError>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</g:hasErrors>


			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-header">
							<g:link class="btn btn-info" action="index"><i class="fa fa-list"></i>&nbsp; ${entityName} List </g:link>
						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<g:form action="save" method="POST" enctype="multipart/form-data">
								<fieldset class="form">
									<g:render template="form"/>
								</fieldset>
								<fieldset class="buttons">
									<g:submitButton name="create" class="btn btn-primary save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
								</fieldset>
							</g:form>
						</div>
					</div>
					<!-- /.card -->
				</div>
			</div>
		</div><!-- /.container-fluid -->
	</section>
	<!-- /.content -->
</div>
</body>
</html>