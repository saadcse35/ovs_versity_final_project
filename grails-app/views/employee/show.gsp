<%@ page import="humanResource.employeeInformation.Employee" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
                </div>

                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">
                            <g:link controller="authorise" action="home">
                                Home
                            </g:link>
                        </li>
                        <li class="breadcrumb-item ">
                            <g:link class="list" action="index">${entityName}</g:link>
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
                            <g:link class="btn btn-info" action="index"><i
                                    class="fa fa-list"></i>&nbsp; ${entityName} List</g:link>
                            <g:link class="btn btn-info create_new" action="create"><i
                                    class="fa fa-pencil"></i>&nbsp;<g:message code="default.new.label"
                                                                              args="[entityName]"/></g:link>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="card-body table-responsive p-0">
                                <table class="table table-hover text-nowrap">
                                    <tr>
                                        <td colspan="4">
                                            <img width="150" height="150"
                                                 src="${employeeInstance?.personId?.imagePath}"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Employee Id
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="firstName-label">
                                                <g:fieldValue bean="${employeeInstance}" field="employeeId"/>
                                            </span>
                                        </td>

                                        <th>
                                            Employee Type
                                        </th>
                                        <td>
                                            <span class="property-value"
                                                  aria-labelledby="employeeType-label"><g:fieldValue
                                                    bean="${employeeInstance}" field="employeeType"/></span>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>
                                            Full Name
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label">
                                                <g:fieldValue bean="${personInstance}" field="name"/>
                                            </span>
                                        </td>
                                        <th>
                                            Father's Name
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="fathersName"/></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Mother's Name
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="mothersName"/></span>
                                        </td>

                                        <th>
                                            Husband / Wife's Name
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="spouseName"/></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Gender
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="gender"/></span>
                                        </td>

                                        <th>
                                            Date of Birth
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label">
                                                <g:fieldValue bean="${personInstance}" field="dateOfBirth"/>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Contact Number
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="contactNumber"/></span>
                                        </td>

                                        <th>
                                            Email
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="emailAddress"/></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Permanent Country
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="permanentCountryId"/></span>
                                        </td>

                                        <th>
                                            Permanent Division
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="permanentDivisionId"/></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Permanent District
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="permanentDistrictId"/></span>
                                        </td>

                                        <th>
                                            Permanent Thana
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="permanentThanaId"/></span>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>
                                            Permanent Address
                                        </th>
                                        <td colspan="3">
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="permanentAddress"/></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Present Country
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="presentCountryId"/></span>
                                        </td>

                                        <th>
                                            Present Division
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="presentDivisionId"/></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Present District
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="presentDistrictId"/></span>
                                        </td>

                                        <th>
                                            Present Thana
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="presentThanaId"/></span>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>
                                            Present Address
                                        </th>
                                        <td colspan="3">
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="presentAddress"/></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Religion
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="religion"/></span>
                                        </td>
                                        <th>
                                            Blood Group
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="bloodGroup-label">
                                                <g:fieldValue bean="${personInstance}" field="bloodGroup"/>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Driving Licence No
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="drivingLicenceNo"/></span>
                                        </td>
                                        <th>
                                            Passport No
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="personId-label"><g:fieldValue
                                                    bean="${personInstance}" field="passportNo"/></span>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>
                                            Date of Joining
                                        </th>
                                        <td>
                                            <span class="property-value"
                                                  aria-labelledby="dateOfJoining-label"><g:formatDate
                                                    date="${employeeInstance?.dateOfJoining}"/></span>
                                        </td>
                                        <th>
                                            Employee Status
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="employeeStatus-label">
                                                <g:fieldValue bean="${employeeInstance}" field="employeeStatus"/>
                                            </span>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>
                                            Date of Termination
                                        </th>
                                        <td>
                                            <span class="property-value"
                                                  aria-labelledby="dateOfTermination-label"><g:formatDate
                                                    date="${employeeInstance?.dateOfTermination}"/></span>
                                        </td>

                                        <th>
                                            Tax Identification No
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="taxIdentificationNo-label">
                                                <g:fieldValue bean="${personInstance}" field="taxIdentificationNo"/>
                                            </span>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>
                                            National ID Number
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="nationalIdNumber-label">
                                                <g:fieldValue bean="${personInstance}" field="nationalIdNumber"/>
                                            </span>
                                        </td>

                                        <th>
                                            Passport No
                                        </th>

                                        <th>
                                            Remarks
                                        </th>
                                        <td colspan="3">
                                            <span class="property-value" aria-labelledby="remarks-label"><g:fieldValue
                                                    bean="${employeeInstance}" field="remarks"/></span>
                                        </td>

                                    </tr>

                                    <tr>
                                        <th>
                                            Is Handicapped?
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="isHandicapped-label">
                                                <g:formatBoolean boolean="${personInstance?.isHandicapped}"
                                                                 true="Yes" false="No"/>
                                            </span>
                                        </td>

                                        <th>
                                            Is Gazetted Wound Freedom Fighter?
                                        </th>
                                        <td>
                                            <span class="property-value"
                                                  aria-labelledby="isGazettedWoundFreedomFighter-label">
                                                <g:formatBoolean
                                                        boolean="${personInstance?.isGazettedWoundFreedomFighter}"
                                                        true="Yes" false="No"/>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Is Attendence Required?
                                        </th>
                                        <td>
                                            <span class="property-value"
                                                  aria-labelledby="isAttendanceRequired-label"><g:formatBoolean
                                                    boolean="${employeeInstance?.isAttendanceRequired}" true="Yes"
                                                    false="No"/></span>
                                        </td>

                                        <th>
                                            Salary Scale Type
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="salaryScaleType-label">
                                                <g:fieldValue bean="${employeeInstance}" field="salaryScaleType"/>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Salary Amount
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="salaryScaleType-label">
                                                <g:fieldValue bean="${employeeInstance}" field="salaryAmount"/>
                                            </span>
                                        </td>
                                        <th>
                                            Is Active?
                                        </th>
                                        <td>
                                            <span class="property-value"
                                                  aria-labelledby="isActive-label"><g:formatBoolean
                                                    boolean="${employeeInstance?.isActive}" true="হ্যাঁ"
                                                    false="না"/></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Active From
                                        </th>
                                        <td>
                                            <span class="property-value"
                                                  aria-labelledby="activeFrom-label"><g:formatDate
                                                    date="${employeeInstance?.activeFrom}"/></span>
                                        </td>

                                        <th>
                                            Active To
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="activeTo-label">
                                                <g:formatDate date="${employeeInstance?.activeTo}"/>
                                            </span>
                                        </td>
                                    </tr>


                                    <tr>
                                        <th>
                                            Date of Entry
                                        </th>
                                        <td>
                                            <span class="property-value"
                                                  aria-labelledby="dateCreated-label"><g:formatDate
                                                    date="${employeeInstance?.dateCreated}"/></span>
                                        </td>

                                        <th>
                                            Date of Last Updated
                                        </th>
                                        <td>
                                            <span class="property-value"
                                                  aria-labelledby="lastUpdated-label"><g:formatDate
                                                    date="${employeeInstance?.lastUpdated}"/></span>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>
                                            Crated By User Id
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="createdByUserId-label">
                                                <g:link controller="user" action="show"
                                                        id="${employeeInstance?.createdByUserId?.id}">
                                                    ${employeeInstance?.createdByUserId?.encodeAsHTML()}
                                                </g:link>
                                            </span>
                                        </td>

                                        <th>
                                            Last Updated By User Id
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="lastUpdatedByUserId-label">
                                                <g:link controller="user" action="show"
                                                        id="${employeeInstance?.lastUpdatedByUserId?.id}">
                                                    ${employeeInstance?.lastUpdatedByUserId?.encodeAsHTML()}
                                                </g:link>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Created Session Id
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="createdBySessionId-label">
                                                <g:link controller="accessLog" action="show"
                                                        id="${employeeInstance?.createdBySessionId?.id}">
                                                    ${employeeInstance?.createdBySessionId?.encodeAsHTML()}
                                                </g:link>
                                            </span>
                                        </td>

                                        <th>
                                            Last Updated Session Id
                                        </th>
                                        <td>
                                            <span class="property-value" aria-labelledby="lastUpdatedBySessionId-label">
                                                <g:link controller="accessLog" action="show"
                                                        id="${employeeInstance?.lastUpdatedBySessionId?.id}">
                                                    ${employeeInstance?.lastUpdatedBySessionId?.encodeAsHTML()}
                                                </g:link>
                                            </span>
                                        </td>
                                    </tr>

                                </table>
                            </div>
                            <br/>



                            <g:form url="[resource: employeeInstance, action: 'delete']" method="DELETE">
                                <fieldset class="buttons">
                                    <g:link class="btn btn-success edit" action="edit"
                                            resource="${employeeInstance}"><g:message
                                            code="default.button.edit.label" default="Edit"/></g:link>
                                    <g:actionSubmit class="btn btn-danger delete" action="delete"
                                                    value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
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
