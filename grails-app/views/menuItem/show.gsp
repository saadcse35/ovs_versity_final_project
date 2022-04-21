<%@ page import="common.accessControl.MenuItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'menuItem.label', default: 'Menu Item')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
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
                <h4><g:message code="default.show.label" args="[entityName]"/></h4>
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
                    <g:link class="list" action="index">${entityName}</g:link>
                </li>
                <li class="breadcrumb-item ">
                    Show
                </li>
            </ul>
        </div>
    </div>
</div>
<g:if test="${flash.message}">
    <div class="row clearfix">
        <div class="col-md-12">
            <div class="card">
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
                <g:link class="btn btn-secondary list" action="index"><i class="fa fa-list"></i>&nbsp;<g:message
                        code="default.list.label" args="[entityName]"/></g:link>
                <g:link class="btn btn-info create" action="create"><i class="fa fa-pencil"></i>&nbsp;<g:message
                        code="default.new.label" args="[entityName]"/></g:link>
            </div>

            <div class="body">
                <div class="table-responsive">
                    <table class="table table-hover m-b-0 c_list">
                        <tr>
                            <th>
                                Code
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="code-label"><g:fieldValue
                                        bean="${menuItemInstance}" field="code"/></span>
                            </td>

                            <th>
                                Name
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="name-label"><g:fieldValue
                                        bean="${menuItemInstance}" field="name"/></span>
                            </td>
                        </tr>

                        <tr>
                            <th>
                                Parent
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="parentId-label"><g:link
                                        controller="menuItem" action="show"
                                        id="${menuItemInstance?.parentId?.id}">${menuItemInstance?.parentId?.encodeAsHTML()}</g:link></span>
                            </td>

                            <th>
                                Menu Type
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="menuType-label"><g:fieldValue
                                        bean="${menuItemInstance}" field="menuType"/></span>
                            </td>
                        </tr>

                        <tr>
                            <th>
                                Controller Name
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="parentId-label">
                                    ${menuItemInstance?.controllerName}

                                </span>
                            </td>

                            <th>
                                Action Name
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="parentId-label">
                                    ${menuItemInstance?.actionName}
                                </span>
                            </td>
                        </tr>

                        <tr>
                            <th>
                                Remarks
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="remarks-label"><g:fieldValue
                                        bean="${menuItemInstance}" field="remarks"/></span>
                            </td>

                            <th>
                                Is Active
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                        boolean="${menuItemInstance?.isActive}"true="Yes" false="No"/></span>
                            </td>
                        </tr>

                        <tr>
                            <th>
                                Active From
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="activeFrom-label"><g:formatDate
                                        date="${menuItemInstance?.activeFrom}"/></span>
                            </td>

                            <th>
                                Active To
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="activeTo-label"><g:formatDate
                                        date="${menuItemInstance?.activeTo}"/></span>
                            </td>
                        </tr>

                        <tr>
                            <th>
                                Date Created
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                        date="${menuItemInstance?.dateCreated}"/></span>
                            </td>

                            <th>
                                Last Update
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                        date="${menuItemInstance?.lastUpdated}"/></span>
                            </td>
                        </tr>

                        <tr>
                            <th>
                                Created By
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="createdByUserId-label"><g:link
                                        controller="user" action="show"
                                        id="${menuItemInstance?.createdByUserId?.id}">${menuItemInstance?.createdByUserId?.encodeAsHTML()}</g:link></span>
                            </td>

                            <th>
                                Last Updated Time
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="lastUpdatedByUserId-label"><g:link
                                        controller="user" action="show"
                                        id="${menuItemInstance?.lastUpdatedByUserId?.id}">${menuItemInstance?.lastUpdatedByUserId?.encodeAsHTML()}</g:link></span>
                            </td>
                        </tr>
                       %{-- <tr>
                            <th>
                                যে সেশনে এন্ট্রি হয়েছে
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="createdBySessionId-label">
                                    <g:if test="${menuItemInstance?.createdBySessionId}">
                                        <g:link controller="accessLog" action="show"
                                                id="${menuItemInstance?.createdBySessionId}">
                                            ${common.log.AccessLog.findById(Long.valueOf(menuItemInstance?.createdBySessionId))?.sessionId}
                                        </g:link>
                                    </g:if>
                                </span>
                            </td>

                            <th>
                                সর্বশেষ আপডেটের তারিখ ও সময়
                            </th>
                            <td>
                                <span class="property-value" aria-labelledby="lastUpdatedBySessionId-label">
                                    <g:if test="${menuItemInstance?.lastUpdatedBySessionId}">
                                        <g:link controller="accessLog" action="show"
                                                id="${menuItemInstance?.lastUpdatedBySessionId}">
                                            ${common.log.AccessLog.findById(Long.valueOf(menuItemInstance?.lastUpdatedBySessionId))?.sessionId}
                                        </g:link>
                                    </g:if>
                                </span>
                            </td>
                        </tr>--}%
                    </table>

                    <g:if test="${menuItemInstance.menuItems.size() > 0}">
                        <hr/>
                        <div class="table-responsive">
                            <h3>Menu Items</h3>
                            <table class="table">
                                <tr>
                                    <th>Code</th>
                                    <th>Menu Type</th>
                                    <th>Task Name</th>
                                    <th>Controller</th>
                                    <th>Method</th>
                                    <th>Sort Order</th>
                                    <th>Is Active</th>
                                </tr>
                                <g:each in="${menuItemInstance.menuItems.findAll { it.status == 'ACTIVE' }.sort {
                                    it.sortOrder
                                }}" var="menuItem"
                                        status="i">
                                    <tr>
                                        <td><g:link controller="menuItem" action="show"
                                                    id="${menuItem.id}">${menuItem.code}</g:link></td>
                                        <td>${menuItem.menuType}</td>
                                        <td>${menuItem.name}</td>
                                        <td>${menuItem.controllerName}</td>
                                        <td>${menuItem.actionName}</td>
                                        <td>${menuItem.sortOrder}</td>
                                        <td><g:formatBoolean boolean="${menuItem.isActive}" false="No"
                                                             true="Yes"/></td>
                                    </tr>
                                </g:each>
                            </table>
                        </div>
                    </g:if>


                    <g:if test="${menuItemInstance.reportParameterDetails.size() > 0}">
                        <hr/>
                        <div class="table-responsive">
                            <h3>Report Parameters</h3>
                            <table class="table">
                                <tr>
                                    <th>Code</th>
                                    <th>Parameter</th>
                                    <th>Is Active</th>
                                    <th>Sort Order</th>
                                </tr>
                                <g:each in="${menuItemInstance.reportParameterDetails.findAll {
                                    it.status == 'ACTIVE'
                                }.sort {
                                    it.sortOrder
                                }}" var="reportParameter"
                                        status="i">
                                    <tr>
                                        <td><g:link controller="reportParameter" action="show"
                                                    id="${reportParameter.id}">${reportParameter.code}</g:link></td>
                                        <td>${reportParameter.reportParameterId.name}</td>
                                        <td><g:formatBoolean boolean="${reportParameter.isActive}" false="No"
                                                             true="Yes"/></td>
                                        <td>${reportParameter.sortOrder}</td>
                                    </tr>
                                </g:each>
                            </table>
                        </div>
                    </g:if>

                    <g:form url="[resource: menuItemInstance, action: 'delete']" method="DELETE">
                        <fieldset class="buttons">
                            <g:link class="btn btn-success edit" action="edit" resource="${menuItemInstance}"><g:message
                                    code="default.button.edit.label" default="Edit"/></g:link>
                            <g:actionSubmit class="btn btn-danger delete" action="delete"
                                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                        </fieldset>
                    </g:form>
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