<%@ page import="humanResource.employeeInformation.Employee" %>
<%@ page import="common.core.Person" %>
<asset:javascript src="location.js"/>
<asset:javascript src="humanResource/employee-entry.js"/>
<script type="text/javascript">
    var employeeDesignationsCount = ${employeeInstance?.employeeDesignations?.findAll{it?.status == 'ACTIVE'}?.size()} + 0;
    function addEmployeeDesignationDetails() {
        var clonedRow = $('#details_employee_designation_details_sample').clone()
        var idCmn = 'employeeDesignations[' + employeeDesignationsCount + '].';

        clonedRow.find('[id$=id]').attr('id', idCmn + 'id')
            .attr('name', idCmn + 'id');
        clonedRow.find('[id$=deleted]').attr('id', idCmn + 'deleted')
            .attr('name', idCmn + 'deleted');
        clonedRow.find('[id$=new]')
            .attr('id', idCmn + 'new')
            .attr('name', idCmn + 'new');

        clonedRow.find('[id*=code]')
            .attr('id', idCmn + 'code')
            .attr('name', idCmn + 'code');

        clonedRow.find('[id$=designationId]')
            .attr('id', idCmn + 'designationId')
            .attr('name', idCmn + 'designationId').attr('required', 'required');

        clonedRow.find('[id$=organizationId]')
            .attr('id', idCmn + 'organizationId')
            .attr('name', idCmn + 'organizationId').attr('required', 'required');

        clonedRow.find('[id*=isDefault]')
            .attr('id', idCmn + 'isDefault')
            .attr('name', idCmn + 'isDefault');

        clonedRow.find('[id*=isActive]')
            .attr('id', idCmn + 'isActive')
            .attr('name', idCmn + 'isActive');

        clonedRow.find('[id*=activeFrom]')
            .attr('id', idCmn + 'activeFrom')
            .attr('name', idCmn + 'activeFrom').attr('required', 'required');

        clonedRow.find('[id*=activeTo]')
            .attr('id', idCmn + 'activeTo')
            .attr('name', idCmn + 'activeTo');

        clonedRow.find('[id*=remarks]')
            .attr('id', idCmn + 'remarks')
            .attr('name', idCmn + 'remarks');

        clonedRow.attr('id', 'details_employee_designation_details_' + employeeDesignationsCount);

        $('#detailRowDesg').append(clonedRow);
        clonedRow.show();
        employeeDesignationsCount++;
    }

    $(document).ready(function () {
        $('#detailRow').on('click', '.icon', function () {
            var tr = $(this).parent().parent();
            tr.find('[id$=deleted]').attr('value', 'true');
            tr.find('select').removeAttr('required');
            tr.find('input').removeAttr('required');
            tr.hide();
        });
        $('#detailRows').on('click', '.icon', function () {
            var tr = $(this).parent().parent();
            tr.find('[id$=deleted]').attr('value', 'true');
            tr.find('select').removeAttr('required');
            tr.find('input').removeAttr('required');
            tr.hide();
        });

        $('#detailRowt').on('click', '.icon', function () {
            var tr = $(this).parent().parent();
            tr.find('[id$=deleted]').attr('value', 'true');
            tr.find('select').removeAttr('required');
            tr.find('input').removeAttr('required');
            tr.hide();
        });

        $('#detailRowl').on('click', '.icon', function () {
            var tr = $(this).parent().parent();
            tr.find('[id$=deleted]').attr('value', 'true');
            tr.find('select').removeAttr('required');
            tr.find('input').removeAttr('required');
            tr.hide();
        });

        $('#detailRowp').on('click', '.icon', function () {
            var tr = $(this).parent().parent();
            tr.find('[id$=deleted]').attr('value', 'true');
            tr.find('select').removeAttr('required');
            tr.find('input').removeAttr('required');
            tr.hide();
        });

        $('#detailRowDesg').on('click', '.icon', function () {
            var tr = $(this).parent().parent();
            tr.find('[id$=deleted]').attr('value', 'true');
            tr.find('select').removeAttr('required');
            tr.find('input').removeAttr('required');
            tr.hide();
        });

        $('#detailRowSalaryScale').on('click', '.icon', function () {
            var tr = $(this).parent().parent();
            tr.find('[id$=deleted]').attr('value', 'true');
            tr.find('select').removeAttr('required');
            tr.find('input').removeAttr('required');
            tr.hide();
        });

        $('#salaryScaleType').on('change', function () {
            var value = $(this).val();
            if (value == '' || value == 'Salary Scale') {
                $('#salaryAmount').val('');
                $('.salaryAmount').hide();
            }
            else {
                $('.salaryAmount').show();
            }
        });

        $('#detailRowBankAccount').on('click', '.icon', function () {
            var tr = $(this).parent().parent();
            tr.find('[id$=deleted]').attr('value', 'true');
            tr.find('select').removeAttr('required');
            tr.find('input').removeAttr('required');
            tr.hide();
        });
        $('#detailRowReportingBoss').on('click', '.icon', function () {
            var tr = $(this).parent().parent();
            tr.find('[id$=deleted]').attr('value', 'true');
            tr.find('select').removeAttr('required');
            tr.find('input').removeAttr('required');
            tr.hide();
        });
    });
</script>

<ul class="nav nav-tabs">
    <li class="nav-item"><a class="nav-link active show" data-toggle="tab" href="#personalInfo"><i
            class="fa fa-home"></i>Personal &amp; Job Info</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#familyAndContact"><i
            class="fa fa-user"></i>Family &amp; Contact Info</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#prmntAddress"><i
            class="fa fa-user"></i>Permanent Address</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#prsntAddress"><i
            class="fa fa-vcard"></i>Present Address</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#othersInfo"><i class="fa fa-vcard"></i>Others Info
    </a></li>
</ul>

<div class="tab-content">
    <div class="tab-pane active show" id="personalInfo">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: employeeInstance, field: 'employeeId', 'error')} required">
                <div class="form-group">
                    <label for="employeeId" class="control-label">
                        <g:message code="employee.employeeId.label" default="Employee Id/Employee No."/>
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField class="form-control" name="employeeId" required=""
                                 value="${employeeInstance?.employeeId}"/>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'name', 'error')} required">
                <div class="form-group">
                    <label for="name" class="control-label">
                        <g:message code="person.name.label" default="Employee Name"/>
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField class="form-control" name="name" maxlength="50" required=""
                                 value="${personInstance?.name}"/>

                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: employeeInstance, field: 'dateOfJoining', 'error')} required">
                <div class="form-group demo-masked-input">
                    <label for="dateOfJoining" class="control-label">
                        <g:message code="employee.dateOfJoining.label" default="Date Of Joining"/>
                        <span class="required-indicator">*</span>
                    </label>
                    %{--<g:textField class="form-control  datemask" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy"
                                 name="dateOfJoining" id="dateOfJoining"
                                 value="${formatDate(format: 'dd/MM/yyyy', date: employeeInstance?.dateOfJoining)}"/>--}%

                    <g:textField class="form-control datemask"  name="dateOfJoining" id="dateOfJoining"  data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy"
                                 value="${formatDate(format: 'dd/MM/yyyy', date: employeeInstance?.dateOfJoining == null ? new Date() : employeeInstance?.dateOfJoining)}" required="" />
                </div>
            </div>


            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'emailAddress', 'error')} ">
                <div class="form-group">
                    <label for="emailAddress" class="control-label">
                        <g:message code="person.emailAddress.label" default="Email Address"/>
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField class="form-control" name="emailAddress" maxlength="100" required=""
                                 value="${personInstance?.emailAddress}"/>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'contactNumber', 'error')} required">
                <div class="form-group">
                    <label for="contactNumber" class="control-label">
                        <g:message code="person.contactNumber.label" default="Contact Number"/>
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField class="form-control" name="contactNumber" maxlength="20" required=""
                                 value="${personInstance?.contactNumber}"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'imagePath', 'error')} ">
                <div class="form-group">
                    <label for="imagePath" class="control-label">
                        <g:message code="person.imagePath.label" default="Employee Image"/>
                    </label>
                    <input type="file" class="form-control" name="imagePath1"/>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'dateOfBirth', 'error')} required">
                <div class="form-group demo-masked-input">
                    <label for="dateOfBirth" class="control-label">
                        <g:message code="person.dateOfBirth.label" default="Date of Birth"/>
                        <span class="required-indicator">*</span>
                    </label>
                    %{--<g:textField class="form-control datemask" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy"
                                 name="dateOfBirth" id="dateOfBirth" required=""
                                 value="${formatDate(format: 'dd/MM/yyyy', date: personInstance?.dateOfBirth)}"/>--}%


                    <g:textField class="form-control datemask"  name="dateOfBirth" id="dateOfBirth"  data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy"
                                 value="${formatDate(format: 'dd/MM/yyyy', date: personInstance?.dateOfBirth == null ? new Date() : personInstance?.dateOfBirth)}" required="" />
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'gender', 'error')} required">
                <div class="form-group">
                    <label for="gender" class="control-label">
                        <g:message code="person.gender.label" default="Gender"/>
                        <span class="required-indicator">*</span>
                    </label>
                    <g:select class="form-control" name="gender" from="${personInstance.constraints.gender.inList}"
                              required="" value="${personInstance?.gender}" valueMessagePrefix="person.gender"
                              noSelection="['': '']"/>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: employeeInstance, field: 'employeeType', 'error')} required">
                <div class="form-group">
                    <label for="employeeType" class="control-label">
                        <g:message code="employee.employeeType.label" default="Employee Type"/>
                        <span class="required-indicator">*</span>
                    </label>
                    <g:select class="form-control" name="employeeType"
                              from="${employeeInstance.constraints.employeeType.inList}" required=""
                              value="${employeeInstance?.employeeType}" valueMessagePrefix="employee.employeeType"
                              noSelection="['': '']"/>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-pane" id="familyAndContact">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'fathersName', 'error')} ">
                <div class="form-group">
                    <label for="fathersName" class="control-label">
                        <g:message code="person.fathersName.label" default="Father's Name"/>
                    </label>
                    <g:textField class="form-control" name="fathersName" value="${personInstance?.fathersName}"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'mothersName', 'error')} ">
                <div class="form-group">
                    <label for="mothersName" class="control-label">
                        <g:message code="person.mothersName.label" default="Mother's Name"/>
                    </label>
                    <g:textField class="form-control" name="mothersName" value="${personInstance?.mothersName}"/>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'spouseName', 'error')} ">
                <div class="form-group">
                    <label for="spouseName" class="control-label">
                        <g:message code="person.spouseName.label" default="Spouse Name"/>
                    </label>
                    <g:textField class="form-control" name="spouseName" value="${personInstance?.spouseName}"/>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-pane" id="prmntAddress">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'permanentCountryId', 'error')} required">
                <div class="form-group">
                    <label for="permanentCountryId" class="control-label">
                        <g:message code="person.permanentCountryId.label" default="Permanent Country"/>
                        <span class="required-indicator"></span>
                    </label>
                    <g:select class="form-control location" id="permanentCountryId" name="permanentCountryId.id"
                              from="${common.data.Location.executeQuery('from Location c where c.locationType = ?', ['Country'])}"
                              optionKey="id" value="${personInstance?.permanentCountryId?.id}" noSelection="['': '']"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'permanentDivisionId', 'error')} ">
                <div class="form-group">
                    <label for="permanentDivisionId" class="control-label">
                        <g:message code="person.permanentDivisionId.label" default="Permanent Division"/>
                    </label>
                    <g:select class="form-control location" id="permanentDivisionId" name="permanentDivisionId.id"
                              from="${common.data.Location.findAllByLocationType('State/Division')}" optionKey="id"
                              value="${personInstance?.permanentDivisionId?.id}" noSelection="['null': '']"/>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'permanentDistrictId', 'error')} ">
                <div class="form-group">
                    <label for="permanentDistrictId" class="control-label">
                        <g:message code="person.permanentDistrictId.label" default="Permanent District"/>
                    </label>
                    <g:select class="form-control location" id="permanentDistrictId" name="permanentDistrictId.id"
                              from="${common.data.Location.findAllByLocationType('District')}" optionKey="id"
                              value="${personInstance?.permanentDistrictId?.id}"
                              noSelection="['null': '']"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'permanentThanaId', 'error')} ">
                <div class="form-group">
                    <label for="permanentThanaId" class="control-label">
                        <g:message code="person.permanentThanaId.label" default="Permanent Thana"/>
                    </label>
                    <g:select class="form-control" id="permanentThanaId" name="permanentThanaId.id"
                              from="${common.data.Location.findAllByLocationType('Thana')}" optionKey="id"
                              value="${personInstance?.permanentThanaId?.id}"
                              noSelection="['null': '']"/>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'permanentAddress', 'error')} ">
                <div class="form-group">
                    <label for="permanentAddress" class="control-label">
                        <g:message code="person.permanentAddress.label" default="Permanent Address"/>
                    </label>
                    <g:textArea class="form-control" name="permanentAddress" cols="40" rows="5" maxlength="1000"
                                value="${personInstance?.permanentAddress}"/>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-pane" id="prsntAddress">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'presentCountryId', 'error')} ">
                <div class="form-group">
                    <label for="presentCountryId" class="control-label">
                        <g:message code="person.presentCountryId.label" default="Present Country"/>
                    </label>
                    <g:select class="form-control location" id="presentCountryId" name="presentCountryId.id"
                              from="${common.data.Location.findAllByLocationType('Country')}" optionKey="id"
                              value="${personInstance?.presentCountryId?.id}" noSelection="['null': '']"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'presentDivisionId', 'error')} ">
                <div class="form-group">
                    <label for="presentDivisionId" class="control-label">
                        <g:message code="person.presentDivisionId.label" default="Present Division"/>
                    </label>
                    <g:select class="form-control location" id="presentDivisionId" name="presentDivisionId.id"
                              from="${common.data.Location.findAllByLocationType('Division')}" optionKey="id"
                              value="${personInstance?.presentDivisionId?.id}"
                              noSelection="['null': '']"/>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'presentDistrictId', 'error')} ">
                <div class="form-group">
                    <label for="presentDistrictId" class="control-label">
                        <g:message code="person.presentDistrictId.label" default="Present District"/>
                    </label>
                    <g:select class="form-control location" id="presentDistrictId" name="presentDistrictId.id"
                              from="${common.data.Location.findAllByLocationType('District')}" optionKey="id"
                              value="${personInstance?.presentDistrictId?.id}"
                              noSelection="['null': '']"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'presentThanaId', 'error')} ">
                <div class="form-group">
                    <label for="presentThanaId" class="control-label">
                        <g:message code="person.presentThanaId.label" default="Present Thana"/>
                    </label>
                    <g:select class="form-control" id="presentThanaId" name="presentThanaId.id"
                              from="${common.data.Location.findAllByLocationType('Thana')}" optionKey="id"
                              value="${personInstance?.presentThanaId?.id}"
                              noSelection="['null': '']"/>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'presentAddress', 'error')} ">
                <div class="form-group">
                    <label for="presentAddress" class="control-label">
                        <g:message code="person.presentAddress.label" default="Present Address"/>
                    </label>
                    <g:textArea class="form-control" name="presentAddress" cols="40" rows="5" maxlength="1000"
                                value="${personInstance?.presentAddress}"/>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-pane" id="othersInfo">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'taxIdentificationNo', 'error')} ">
                <div class="form-group">
                    <label for="taxIdentificationNo" class="control-label">
                        <g:message code="person.taxIdentificationNo.label" default="Tax Identification No (TIN)"/>
                    </label>
                    <g:textField class="form-control" name="taxIdentificationNo" maxlength="20" value="${personInstance?.taxIdentificationNo}"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'nationalIdNumber', 'error')} ">
                <div class="form-group">
                    <label for="nationalIdNumber" class="control-label">
                        <g:message code="person.nationalIdNumber.label" default="National Id Number"/>
                    </label>
                    <g:textField class="form-control" name="nationalIdNumber" maxlength="20" value="${personInstance?.nationalIdNumber}"/>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'drivingLicenceNo', 'error')} ">
                <div class="form-group">
                    <label for="drivingLicenceNo" class="control-label">
                        <g:message code="person.drivingLicenceNo.label" default="Driving Licence No"/>
                    </label>
                    <g:textField class="form-control" name="drivingLicenceNo" maxlength="20"
                                 value="${personInstance?.drivingLicenceNo}"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'passportNo', 'error')} ">
                <div class="form-group">
                    <label for="passportNo" class="control-label">
                        <g:message code="person.passportNo.label" default="Passport No"/>
                    </label>
                    <g:textField class="form-control" name="passportNo" maxlength="20"  value="${personInstance?.passportNo}"/>
                </div>
            </div>
        </div>
        
       %{-- <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'isHandicapped', 'error')} ">
                <div class="form-group">
                    <label for="isHandicaped" class="control-label">
                        <g:message code="person.isHandicapped.label" default="Is Handicapped"/>
                    </label>
                    <g:checkBox class="form-control" style="height: 40px;" name="isHandicapped"
                                value="${personInstance?.isHandicapped}"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'isGazettedWoundFreedomFighter', 'error')} ">
                <div class="form-group">
                    <label for="isGazettedWoundFreedomFighter" class="control-label">
                        <g:message code="person.isGazettedWoundFreedomFighter.label" default="Is Gazetted Wound Freedom Fighter"/>
                    </label>
                    <g:checkBox class="form-control" style="height: 40px;" name="isGazettedWoundFreedomFighter"
                                value="${personInstance?.isGazettedWoundFreedomFighter}"/>
                </div>
            </div>
        </div>--}%



        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: employeeInstance, field: 'employeeStatus', 'error')} required">
                <div class="form-group">
                    <label for="employeeStatus" class="control-label">
                        <g:message code="employee.employeeStatus.label" default="Employee Status"/>
                        <span class="required-indicator">*</span>
                    </label>
                    <g:select class="form-control" name="employeeStatus"
                              from="${employeeInstance.constraints.employeeStatus.inList}" required=""
                              value="${employeeInstance?.employeeStatus}" valueMessagePrefix="employee.employeeStatus"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: employeeInstance, field: 'dateOfTermination', 'error')} ">
                <div class="form-group demo-masked-input">
                    <label for="dateOfTermination" class="control-label">
                        <g:message code="employee.dateOfTermination.label" default="Date Of Termination"/>
                    </label>
                    <g:textField data-provide="datepicker" data-date-autoclose="true" data-date-format="dd/mm/yyyy"
                                 class="form-control date" name="dateOfTermination" id="dateOfTermination"
                                 value="${formatDate(format: 'dd/MM/yyyy', date: employeeInstance?.dateOfTermination)}"
                                 default="none" noSelection="['': '']"/>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'bloodGroup', 'error')} ">
                <div class="form-group">
                    <label for="bloodGroup" class="control-label">
                        <g:message code="person.bloodGroup.label" default="Blood Group"/>
                    </label>
                    <g:select class="form-control" id="bloodGroup" name="bloodGroup"
                              from="${["A+", "A-", "AB+", "AB-", 'B+', 'B-', 'O+', 'O-']}"
                              value="${personInstance?.bloodGroup}"
                              noSelection="['': '']"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: employeeInstance, field: 'isActive', 'error')} ">
                <div class="form-group">
                    <label for="isActive" class="control-label">
                        <g:message code="employee.isActive.label" default="Is Active?"/>
                    </label>
                    <g:checkBox class="form-control" style="height: 40px;" name="isActive"
                                value="${employeeInstance?.isActive}"/>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: employeeInstance, field: 'activeFrom', 'error')} ">
                <div class="form-group demo-masked-input">
                    <label for="activeFrom" class="control-label">
                        <g:message code="employee.activeFrom.label" default="Acrive From"/>
                    </label>
                    <g:textField data-provide="datepicker" data-date-autoclose="true" data-date-format="dd/mm/yyyy"
                                 class="form-control date" name="activeFrom" id="activeFrom"
                                 value="${formatDate(format: 'dd/MM/yyyy', date: employeeInstance?.activeFrom)}"
                                 default="none" noSelection="['': '']"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: employeeInstance, field: 'activeTo', 'error')} ">
                <div class="form-group demo-masked-input">
                    <label for="activeTo" class="control-label">
                        <g:message code="employee.activeTo.label" default="Active To"/>
                    </label>
                    <g:textField data-provide="datepicker" data-date-autoclose="true" data-date-format="dd/mm/yyyy"
                                 class="form-control date" name="activeTo" id="activeTo"
                                 value="${formatDate(format: 'dd/MM/yyyy', date: employeeInstance?.activeTo)}"
                                 default="none" noSelection="['': '']"/>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: personInstance, field: 'religion', 'error')} ">
                <div class="form-group">

                    <label for="religion" class="control-label">
                        <g:message code="person.religion.label" default="Religion"/>

                    </label>
                    <g:select class="form-control" id="religion" name="religion"
                              from="${common.core.Person.constraints.religion.inList}"
                              value="${personInstance?.religion}"
                              noSelection="['null': '']"/>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: employeeInstance, field: 'remarks', 'error')} ">
                <div class="form-group">
                    <label for="remarks" class="control-label">
                        <g:message code="employee.remarks.label" default="Remarks"/>
                    </label>
                    <g:textArea class="form-control" name="remarks" cols="40" rows="5" maxlength="1000"
                                value="${employeeInstance?.remarks}"/>
                </div>
            </div>
        </div>
    </div>

</div>%{--
<ul class="nav nav-tabs">
    <li class="nav-item"><a class="nav-link active show" data-toggle="tab" href="#academicHistory"><i
            class="fa fa-home"></i>AcademicHistory</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#careerHistory"><i
            class="fa fa-user"></i>Career History</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#trainingHistory"><i
            class="fa fa-user"></i>Training History</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#languageSkill"><i
            class="fa fa-vcard"></i>LanguageSkill</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#professionalSkill"><i
            class="fa fa-vcard"></i>Professional Skill</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#employeeDesignation"><i
            class="fa fa-vcard"></i>Designation</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#employeeSalaryScale"><i
            class="fa fa-vcard"></i>Salary Scale</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#employeeBankAccount"><i
            class="fa fa-vcard"></i>Bank Account</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#reportingBoss"><i
            class="fa fa-vcard"></i>Reporting Boss</a></li>
</ul>--}%
%{--

<div class="tab-content">
    <div class="tab-pane active show" id="academicHistory">
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <h3><strong>Academic History Details</strong></h3><hr class="hrtag"/>
                <g:render template="acadHstryDetails"/>
                <div class="addDetailsButton" id="addDetailsButton" style="margin-bottom: 15px">
                    <input type="button" class="btn btn-success" onClick="addAcademicHistoryDetails();"
                           value="Add Details"/>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-pane" id="careerHistory">
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <h3><strong>Career History Details</strong></h3><hr class="hrtag"/>
                <g:render template="careerHstryDetail"/>
                <div class="addDetailsButton" id="addDetailsButton" style="margin-bottom: 15px">
                    <input type="button" class="btn btn-success" onClick="addCarerHistoryDetails();"
                           value="Add Details"/>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-pane" id="trainingHistory">
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <h3><strong>Training History Details</strong></h3><hr class="hrtag"/>
                <g:render template="trainingHstryDetails"/>
                <div class="addDetailsButton" id="addDetailsButton" style="margin-bottom: 15px">
                    <input type="button" class="btn btn-success" onClick="addTrainingHistoryDetails();"
                           value="Add Details"/>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-pane" id="languageSkill">
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <h3><strong>Language Skills</strong></h3><hr class="hrtag"/>
                <g:render template="languageHstryDetails"/>
                <div class="addDetailsButton" id="addDetailsButton" style="margin-bottom: 15px">
                    <input type="button" class="btn btn-success" onClick="addLanguageSkillDetails();"
                           value="Add Details"/>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-pane" id="professionalSkill">
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <h3><strong>Professional Skills</strong></h3><hr class="hrtag"/>
                <g:render template="profSkilDetails"/>
                <div class="addDetailsButton" id="addDetailsButton" style="margin-bottom: 15px">
                    <input type="button" class="btn btn-success" onClick="addProfessionalSkillDetails();"
                           value="Add Details"/>
                </div>
            </div>
        </div>

    </div>

    <div class="tab-pane" id="employeeDesignation">
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <h3><strong>Designation History Details</strong></h3><hr class="hrtag"/>
                <g:render template="empDesignationDetails"/>
                <div class="addDetailsButton" id="addDetailsButton" style="margin-bottom: 15px">
                    <input type="button" class="btn btn-success" onClick="addEmployeeDesignationDetails();"
                           value="Add Details"/>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-pane" id="employeeSalaryScale">
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <h3><strong>Salary Scales</strong></h3><hr class="hrtag"/>
                <g:render template="empSalaryScales"/>
                <div class="addDetailsButton" id="addDetailsButton" style="margin-bottom: 15px">
                    <input type="button" class="btn btn-success" onClick="addEmployeeSalaryScales();"
                           value="Add Details"/>
                </div>
            </div>
        </div>
    </div>
    <div class="tab-pane" id="employeeBankAccount">
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <h3><strong>Bank Account</strong></h3><hr class="hrtag"/>
                <g:render template="empBankAccounts"/>
                <div class="addDetailsButton" id="addDetailsButton" style="margin-bottom: 15px">
                    <input type="button" class="btn btn-success" onClick="addEmployeeBankAccounts();"
                           value="Add Details"/>
                </div>
            </div>
        </div>
    </div>
    <div class="tab-pane" id="reportingBoss">
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <h3><strong>Reporting Boss</strong></h3><hr class="hrtag"/>
                <g:render template="empReportingBosses"/>
                <div class="addDetailsButton" id="addDetailsButton" style="margin-bottom: 15px">
                    <input type="button" class="btn btn-success" onClick="addEmployeeReportingBosses();"
                           value="Add Details"/>
                </div>
            </div>
        </div>
    </div>
</div>
--}%






