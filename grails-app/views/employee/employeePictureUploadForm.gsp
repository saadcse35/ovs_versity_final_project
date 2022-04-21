<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'employeesDocumentPrinting.label', default: 'Employees Photo Upload')}"/>
    <title>${entityName}</title>

</head>

<body>
<div class="block-header">
    <div class="row">
        <div class="col-lg-5 col-md-8 col-sm-12">
            <ul class="nav nav-pills">
                <li>
                    <h4>${entityName}</h4>
                </li>
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
                    <g:link class="list" action="index">Employee</g:link>
                </li>
                <li class="breadcrumb-item ">
                    ${entityName}
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
            <div class="body">
                <g:form action="uploadPhoto" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="employeeIdSuErpX" class="control-label">
                                    Employee ID
                                </label>
                                <g:textField class="form-control" name="employeeIdSuErpX" type="text"
                                             required=""/>
                                <label class="SuErpXName"></label>
                                <g:hiddenField name="employeeId.id" id="employeeId"/>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="pictureFile" class="control-label">
                                    Employee Image
                                </label>
                                <input type="file" name="pictureFile" id="pictureFile" class="form-control"
                                       required=""/>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="loadVerificationInfo">&nbsp;</label>
                                <button type="submit" id="loadVerificationInfo"
                                        class="btn btn-info btn-block" name="uploadPhoto">Upload Photo</button>
                            </div>
                        </div>

                    </div>
                </g:form>

            </div>
        </div>
    </div>
</div>


</body>
</html>
