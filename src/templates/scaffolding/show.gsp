<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
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
							<g:link class="list" action="index"> \${entityName} </g:link>
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
			<g:if test="\${flash.message}">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h3 class="alert alert-secondary">\${flash.message}</h3>
							</div>
						</div>
					</div>
				</div>
			</g:if>

			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-header">
							<g:link class="btn btn-info" action="index"><i class="fa fa-list"></i>&nbsp; \${entityName} List </g:link>
							<g:link class="btn btn-info create_new" action="create"><i class="fa fa-pencil"></i>&nbsp;<g:message code="default.new.label" args="[entityName]" /></g:link>
						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<div class="card-body table-responsive p-0">
								<table class="table table-hover text-nowrap">
									<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
									allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
									props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }
									Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
									props.each { p -> %>
									<tr>
										<th>
											${p.naturalName}
										</th>
										<td>
											<%  if (p.isEnum()) { %>
											<span class="property-value" aria-labelledby="${p.name}-label">
												<g:fieldValue bean="\${${propertyName}}" field="${p.name}"/>
											</span>
											<%  } else if (p.oneToMany || p.manyToMany) { %>
											<g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
												<span class="property-value" aria-labelledby="${p.name}-label">
													<g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">
														\${${p.name[0]}?.encodeAsHTML()}
													</g:link>
												</span>
											</g:each>
											<%  } else if (p.manyToOne || p.oneToOne) { %>
											<span class="property-value" aria-labelledby="${p.name}-label">
												<g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">
													\${${propertyName}?.${p.name}?.encodeAsHTML()}
												</g:link>
											</span>
											<%  } else if (p.type == Boolean || p.type == boolean) { %>
											<span class="property-value" aria-labelledby="${p.name}-label">
												<g:formatBoolean boolean="\${${propertyName}?.${p.name}}"
																 true="Yes" false="No" />
											</span>
											<%  } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
											<span class="property-value" aria-labelledby="${p.name}-label">
												<g:formatDate date="\${${propertyName}?.${p.name}}" />
											</span>
											<%  } else if (!p.type.isArray()) { %>
											<span class="property-value" aria-labelledby="${p.name}-label">
												<g:fieldValue bean="\${${propertyName}}" field="${p.name}"/>
											</span>
											<%  } %>
										</td>
									</tr>
									<%  } %>
								</table>
							</div>
							<br/>
							<g:form url="[resource:${propertyName}, action:'delete']" method="DELETE">
								<fieldset class="buttons">
									<g:link class="btn btn-primary edit" action="edit" resource="\${${propertyName}}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
									<g:actionSubmit class="btn btn-danger delete" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
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
