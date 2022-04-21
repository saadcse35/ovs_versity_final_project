<%@ page import="humanResource.employeeInformation.Employee" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
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
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <g:link class="btn btn-info create_new" action="create"><i class="fa fa-pencil"></i>&nbsp;<g:message code="default.new.label" args="[entityName]" /></g:link>
                            </div>
                            <div class="card-body">
                                <g:form class="form-inline" action="search" method="post">
                                    <g:form class="form-inline" action="search" method="post">
                                        <div class="col-lg-3 col-md-3">
                                            <label for="anyText">Select Anything:</label>
                                            <g:textField  style="width:100%;" class="form-control" name="anyText" value="${params.anyText}"/>
                                        </div>

                                        <div class="col-lg-3 col-md-3">
                                            <label for="code">Employee ID:</label>
                                            <g:textField  style="width:100%;" name="code" class="form-control" value="${params.code}"
                                                         noSelection="['': '']"/>
                                        </div>

                                        <div class="col-lg-3 col-md-3">
                                            <label for="name">Employee Name:</label>
                                            <g:textField  style="width:100%;" name="name" class="form-control" value="${params.name}"
                                                         noSelection="['': '']"/>
                                        </div>

                                        <div class="col-lg-3 col-md-3">
                                            <label for="employeeType">Employee Type:</label>
                                            <g:select  style="width:100%;"
                                                    from="${["Full Time Employee", "Contract Employee", "Full Time Teacher", "Part Time Teacher", "Trainer"]}"
                                                    name="employeeType" class="form-control" value="${params.employeeType}"
                                                    noSelection="['': '']"/>
                                        </div>
                                        <div class="col-lg-3 col-md-3">
                                            <label for="employeeStatus">Employee Status:</label>
                                            <g:select style="width:100%;"
                                                    from="${["Running", "Retired", "Sacked",  "Resigned", "On Leave"]}"
                                                    name="employeeStatus" class="form-control" value="${params.employeeStatus}"
                                                    noSelection="['': '']"/>
                                        </div>

                                        <div class="col-lg-3 col-md-3">
                                            <label for="">&nbsp;</label>
                                            <button type="submit" class="btn btn-primary btn-block">Search</button>
                                        </div>
                                    </g:form>
                                </g:form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover m-b-0 c_list">
                                        <thead>
                                        <tr>
                                            <g:sortableColumn property="employeeId"
                                                              title="${message(code: 'employee.employeeId.label', default: 'Employee Id')}"/>
                                            <th><g:message code="employee.personId.label" default="Employee Name"/></th>
                                            <g:sortableColumn property="employeeType"
                                                              title="${message(code: 'employee.employeeType.label', default: 'Employee Type')}"/>
                                            <g:sortableColumn property="dateOfJoining"
                                                              title="${message(code: 'employee.dateOfJoining.label', default: 'Date Of Joining')}"/>
                                            <g:sortableColumn property="employeeStatus"
                                                              title="${message(code: 'employee.employeeStatus.label', default: 'Employee Status')}"/>
                                            <g:sortableColumn property="dateOfTermination"
                                                              title="${message(code: 'employee.dateOfTermination.label', default: 'Date Of Termination')}"/>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${employeeInstanceList}" status="i" var="employeeInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td>
                                                    <g:link action="show" id="${employeeInstance.id}">
                                                        ${fieldValue(bean: employeeInstance, field: "employeeId")}
                                                    </g:link>
                                                </td>
                                                <td>${fieldValue(bean: employeeInstance, field: "personId")}</td>
                                                <td>${fieldValue(bean: employeeInstance, field: "employeeType")}</td>
                                                <td><g:formatDate date="${employeeInstance.dateOfJoining}" format="dd/MM/yyyy"/></td>
                                                <td>${fieldValue(bean: employeeInstance, field: "employeeStatus")}</td>
                                                <td><g:formatDate date="${employeeInstance.dateOfTermination}" format="dd/MM/yyyy"/></td>

                                                <td>
                                                    <button type="button" class="btn btn-default" title="Show">
                                                        <g:link action="show" id="${employeeInstance.id}"><i
                                                                class="fa fa-eye"></i></g:link>
                                                    </button>
                                                    <button type="button" class="btn btn-default" title="Edit">
                                                        <g:link action="edit" id="${employeeInstance.id}"><i
                                                                class="fa fa-edit"></i></g:link>
                                                    </button>

                                                </td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="pagination">
                                    <g:paginate total="${employeeInstanceCount ?: 0}" params="${[anyText: params.anyText, code: params.code, name: params.name]}" />
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
