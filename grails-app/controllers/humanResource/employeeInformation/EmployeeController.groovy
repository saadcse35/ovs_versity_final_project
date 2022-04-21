package humanResource.employeeInformation

import com.amazonaws.services.s3.model.ObjectMetadata
import com.amazonaws.services.s3.model.PutObjectRequest
import com.amazonaws.services.s3.model.CannedAccessControlList
import common.CodeGeneratorService
import common.ConvertDateService
import common.FileUploadService
import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.accessControl.PersonUserType
import common.accessControl.User
import common.core.*
import common.data.DataLookup
import common.log.LogMaintainService
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.NO_CONTENT

@Transactional(readOnly = true)
class EmployeeController {
    def amazonWebService
    AccessControlService accessControlService
    ConvertDateService convertDateService
    FileUploadService fileUploadService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService
    CodeGeneratorService codeGeneratorService



    static allowedMethods = [save: "POST", update: "POST", uploadPhoto: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = Employee.createCriteria()
        def result = c.list(params) {
            eq("status", 'ACTIVE')
        }
        respond result, model: [employeeInstanceCount: Employee.findAllByStatus('ACTIVE').size()]
    }

    def show() {
        def employeeInstance = Employee.get(params.id)
        if (!employeeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), employeeInstance.id])
            redirect(action: "index")
            return
        }
        def personInstance = employeeInstance.personId

        [employeeInstance: employeeInstance, personInstance: personInstance]
    }

    def create() {
        [employeeInstance: new Employee(params), personInstance: new Person(params)]
    }

    @Transactional
    def save() {
        try {
            params.dateOfJoining = convertDateService.convertDate(params.dateOfJoining)
        }
        catch (Exception ex) {
        }
        try {
            params.dateOfTermination = convertDateService.convertDate(params.dateOfTermination)
        }
        catch (Exception ex) {

        }
        try {
            params.activeFrom = convertDateService.convertDate(params.activeFrom)
        }
        catch (Exception ex) {
        }
        try {
            params.activeTo = convertDateService.convertDate(params.activeTo)
        }
        catch (Exception ex) {

        }
        try {
            params.dateOfBirth = convertDateService.convertDate(params.dateOfBirth)
        }
        catch (Exception ex) {
        }

        def personInstance = new Person()
        personInstance.properties['firstName', 'middleName', 'lastName', 'imagePath', 'fathersName', 'mothersName', 'spouseName', 'gender', 'dateOfBirth', 'contactNumber', 'emailAddress', 'permanentAddress', 'permanentCountryId', 'permanentDivisionId', 'permanentDistrictId', 'permanentThanaId', 'presentAddress', 'presentCountryId', 'presentDivisionId', 'presentDistrictId', 'presentThanaId', 'dataLookupReligionId', 'nationalIdNumber', 'isHandicaped', 'isGazettedWoundFreedomFighter', 'drivingLicenceNo', 'passportNo', 'bloodGroup', 'taxIdentificationNo'] = params

        def employeeInstance = new Employee()
        employeeInstance.properties['employeeId', 'dateOfJoining', 'employeeType', 'salaryScaleType', 'salaryAmount', 'employeeStatus', 'dateOfTermination', 'remarks', 'isActive', 'activeFrom', 'activeTo', 'isAttendanceRequired'] = params
        employeeInstance.personId = personInstance

        if (employeeInstance.employeeId.size() < 4) {
            employeeInstance.employeeId = employeeInstance.employeeId.padLeft(4, '০')
        }


        def employeeImage = request.getFile('imagePath1')
        personInstance.imagePath = fileUploadService.uploadImage(employeeImage, "${personInstance.name}.jpg", "employee-image")


        populateInsertUpdatedByService.populateUserId(personInstance, "createdByUserId")
        populateInsertUpdatedByService.populateUserId(employeeInstance, "createdByUserId")
        if (!employeeInstance.validate() || !personInstance.validate()) {
            render(view: "create", model: [employeeInstance: employeeInstance, personInstance: personInstance])
            return
        }

        personInstance.save(flush: true)
        employeeInstance.save(flush: true)

        logMaintainService.saveActivityLog('Employee', 'create', employeeInstance.id)
        logMaintainService.saveActivityLog('Person', 'create', personInstance.id)


        try {
            def userInstance = User.findByEmailAddress(employeeInstance.personId.emailAddress)

            if(userInstance){
                output = ""
            }

            if (!userInstance) {
                userInstance = new User()
                userInstance.code = params.employeeId
                userInstance.name = employeeInstance.personId.name
                userInstance.emailAddress = personInstance.emailAddress
                userInstance.contactNo = personInstance.contactNumber
                def dateOfBirth = personInstance.dateOfBirth
                def password = (dateOfBirth.calendarDate.year.toString() + dateOfBirth.calendarDate.month.toString().padLeft(2, '0') + dateOfBirth.date.toString().padLeft(2, '0')).encodeAsMD5()
                userInstance.password = password
                userInstance.confirmPassword = password
                userInstance.remarks = 'Automatic entry during employee entry.'
                userInstance.isActive = true
                userInstance.activeFrom = new Date()
                userInstance.defaultRole  = 'User'
                populateInsertUpdatedByService.populateUserId(userInstance, "createdByUserId")
                userInstance.save(flush: true)
                logMaintainService.saveActivityLog('User', 'create', userInstance.id)
            }

            def personUserTypeInstance = PersonUserType.findByPersonIdAndUserIdAndUserType(employeeInstance.personId, userInstance, 'Employee')
            if (!personUserTypeInstance) {
                personUserTypeInstance = new PersonUserType()
                personUserTypeInstance.personId = personInstance
                personUserTypeInstance.userId = userInstance
                personUserTypeInstance.userType = 'Employee'
                personUserTypeInstance.remarks = 'Automatic entry during employee entry.'
                populateInsertUpdatedByService.populateUserId(userInstance, "createdByUserId")
                personUserTypeInstance.save(flush: true)
                logMaintainService.saveActivityLog('PersonUserType', 'create', personUserTypeInstance.id)
            }
        }
        catch (Exception ex) {}

        flash.message = message(code: 'default.created.message', args: [message(code: 'employee.label', default: 'Employee'), employeeInstance.id])
        redirect(action: "show", id: employeeInstance.id)
    }

    def edit() {
        def employeeInstance = Employee.get(params.id)
        if (!employeeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), employeeInstance.id])
            redirect(action: "index")
            return
        }
        def personInstance = employeeInstance.personId
        [employeeInstance: employeeInstance, personInstance: personInstance]
    }

    @Transactional
    def update() {
        def employeeInstance = Employee.get(params.id)
        if (!employeeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), employeeInstance.id])
            redirect(action: "index")
            return
        }

        try {
            params.dateOfJoining = convertDateService.convertDate(params.dateOfJoining)
        }
        catch (Exception ex) {
        }
        try {
            params.dateOfTermination = convertDateService.convertDate(params.dateOfTermination)
        }
        catch (Exception ex) {

        }
        try {
            params.activeFrom = convertDateService.convertDate(params.activeFrom)
        }
        catch (Exception ex) {
        }
        try {
            params.activeTo = convertDateService.convertDate(params.activeTo)
        }
        catch (Exception ex) {

        }
        try {
            params.dateOfBirth = convertDateService.convertDate(params.dateOfBirth)
        }
        catch (Exception ex) {
        }

        def personInstance = employeeInstance.personId

        personInstance.properties['firstName', 'middleName', 'lastName', 'imagePath', 'fathersName', 'mothersName', 'spouseName', 'gender',
                'dateOfBirth', 'contactNumber', 'emailAddress', 'permanentAddress', 'permanentCountryId',
                'permanentDivisionId', 'permanentDistrictId', 'permanentThanaId', 'presentAddress', 'presentCountryId', 'presentDivisionId',
                'presentDistrictId', 'presentThanaId', 'dataLookupReligionId', 'nationalIdNumber', 'isHandicaped', 'isGazettedWoundFreedomFighter',
                'drivingLicenceNo', 'passportNo', 'bloodGroup', 'taxIdentificationNo'] = params
        employeeInstance.properties['employeeId', 'dateOfJoining', 'employeeType', 'salaryScaleType', 'salaryAmount', 'employeeStatus', 'dateOfTermination', 'remarks', 'isActive', 'activeFrom', 'activeTo', 'isAttendanceRequired'] = params



        /*int s = 0
        while (params["employeeDesignations[" + s + "].id"] != null) {
            def employeeDesignationInstance
            if (params["employeeDesignations[" + s + "].new"] == 'true' && params["employeeDesignations[" + s + "].deleted"] == 'true') {
                s++
                continue
            } else if (params["employeeDesignations[" + s + "].new"] == 'false' && params["employeeDesignations[" + s + "].deleted"] == 'false') {
                employeeDesignationInstance = EmployeeDesignation.findById(Long.valueOf(params["employeeDesignations[" + s + "].id"]))
            } else if (params["employeeDesignations[" + s + "].new"] == 'false' && params["employeeDesignations[" + s + "].deleted"] == 'true') {
                employeeDesignationInstance = EmployeeDesignation.findById(Long.valueOf(params["employeeDesignations[" + s + "].id"]))
                employeeDesignationInstance.status = 'DELETED'
                personInstance.addToAcademicHistories(employeeDesignationInstance)
                s++
                continue
            }
            if (params["employeeDesignations[" + s + "].new"] == 'true' && params["employeeDesignations[" + s + "].deleted"] == 'false') {
                employeeDesignationInstance = new EmployeeDesignation()
                employeeDesignationInstance.code = codeGeneratorService.generateCode("EmployeeDesignation", 'EMPLOYEE-DESIGNATION-')
            }
            try {
                def designationIdInstance = Designation.findById(Long.valueOf(params["employeeDesignations[" + s + "].designationId"]))
                employeeDesignationInstance.designationId = designationIdInstance
                employeeDesignationInstance.name = designationIdInstance.name
            }
            catch (Exception ex) {
            }

            try {
                def organizationIdInstance = Organization.findById(Long.valueOf(params["employeeDesignations[" + s + "].organizationId"]))
                employeeDesignationInstance.organizationId = organizationIdInstance
            }
            catch (Exception ex) {
            }
            employeeDesignationInstance.isDefault = params["employeeDesignations[" + s + "].isDefault"]
            employeeDesignationInstance.isActive = params["employeeDesignations[" + s + "].isActive"]
            employeeDesignationInstance.activeFrom = ConvertDateService.convertDate(params["employeeDesignations[" + s + "].activeFrom"])
            employeeDesignationInstance.activeTo = ConvertDateService.convertDate(params["employeeDesignations[" + s + "].activeTo"])
            employeeDesignationInstance.remarks = params["employeeDesignations[" + s + "].remarks"]
            employeeInstance.addToEmployeeDesignations(employeeDesignationInstance)
            s++
        }
        int t = 0
        while (params["employeeSalaryScales[" + t + "].id"] != null) {
            def employeeSalaryScaleInstance
            if (params["employeeSalaryScales[" + t + "].new"] == 'true' && params["employeeSalaryScales[" + t + "].deleted"] == 'true') {
                t++
                continue
            } else if (params["employeeSalaryScales[" + t + "].new"] == 'false' && params["employeeSalaryScales[" + t + "].deleted"] == 'false') {
                employeeSalaryScaleInstance = EmployeeSalaryScale.findById(Long.valueOf(params["employeeSalaryScales[" + t + "].id"]))
            } else if (params["employeeSalaryScales[" + t + "].new"] == 'false' && params["employeeSalaryScales[" + t + "].deleted"] == 'true') {
                employeeSalaryScaleInstance = EmployeeSalaryScale.findById(Long.valueOf(params["employeeSalaryScales[" + t + "].id"]))
                employeeSalaryScaleInstance.status = 'DELETED'
                employeeInstance.addToEmployeeSalaryScales(employeeSalaryScaleInstance)
                t++
                continue
            }
            if (params["employeeSalaryScales[" + t + "].new"] == 'true' && params["employeeSalaryScales[" + t + "].deleted"] == 'false') {
                employeeSalaryScaleInstance = new EmployeeSalaryScale()
                employeeSalaryScaleInstance.code = codeGeneratorService.generateCode("EmployeeSalaryScale", 'EMP-SALARY-SCALE-')
            }

            try {
                def salaryScaleInstance = SalaryScale.findById(Long.valueOf(params["employeeSalaryScales[" + t + "].salaryScaleId"]))
                employeeSalaryScaleInstance.salaryScaleId = salaryScaleInstance
                employeeSalaryScaleInstance.name = employeeInstance.employeeId + '-' + salaryScaleInstance.name
            } catch (Exception ex) {
            }

            employeeSalaryScaleInstance.isActive = params["employeeSalaryScales[" + t + "].isActive"]
            employeeSalaryScaleInstance.activeFrom = ConvertDateService.convertDate(params["employeeSalaryScales[" + t + "].activeFrom"])
            employeeSalaryScaleInstance.activeTo = ConvertDateService.convertDate(params["employeeSalaryScales[" + t + "].activeTo"])
            employeeSalaryScaleInstance.remarks = params["employeeSalaryScales[" + t + "].remarks"]
            employeeInstance.addToEmployeeSalaryScales(employeeSalaryScaleInstance)
            t++
        }*/


        /* int u = 0
         while (params["employeeBankAccounts[" + u + "].id"] != null) {
             def employeeBankAccountInstance
             if (params["employeeBankAccounts[" + u + "].new"] == 'true' && params["employeeBankAccounts[" + u + "].deleted"] == 'true') {
                 u++
                 continue
             } else if (params["employeeBankAccounts[" + u + "].new"] == 'false' && params["employeeBankAccounts[" + u + "].deleted"] == 'false') {
                 employeeBankAccountInstance = EmployeeBankAccount.findById(Long.valueOf(params["employeeBankAccounts[" + u + "].id"]))
             } else if (params["employeeBankAccounts[" + u + "].new"] == 'false' && params["employeeBankAccounts[" + u + "].deleted"] == 'true') {
                 employeeBankAccountInstance = EmployeeBankAccount.findById(Long.valueOf(params["employeeBankAccounts[" + u + "].id"]))
                 employeeBankAccountInstance.status = 'DELETED'
                 employeeInstance.addToEmployeeBankAccounts(employeeBankAccountInstance)
                 u++
                 continue
             }
             if (params["employeeBankAccounts[" + u + "].new"] == 'true' && params["employeeBankAccounts[" + u + "].deleted"] == 'false') {
                 employeeBankAccountInstance = new EmployeeBankAccount()
                 employeeBankAccountInstance.code = codeGeneratorService.generateCode("EmployeeBankAccount", 'EMP-BANK-ACCOUNT-')
             }
             try {
                 def bankInstance = Bank.findById(Long.valueOf(params["employeeBankAccounts[" + u + "].bankId"]))
                 employeeBankAccountInstance.bankId = bankInstance
             } catch (Exception ex) {
             }
             try {
                 def bankBranchInstance = BankBranch.findById(Long.valueOf(params["employeeBankAccounts[" + u + "].bankBranchId"]))
                 employeeBankAccountInstance.bankBranchId = bankBranchInstance
             } catch (Exception ex) {
             }

             employeeBankAccountInstance.accountNumber = params["employeeBankAccounts[" + u + "].accountNumber"]
             employeeBankAccountInstance.accountType = params["employeeBankAccounts[" + u + "].accountType"]
             employeeBankAccountInstance.name = employeeInstance.employeeId + '-' + employeeBankAccountInstance.accountNumber

             employeeBankAccountInstance.isActive = params["employeeBankAccounts[" + u + "].isActive"]
             try {
                 employeeBankAccountInstance.activeFrom = ConvertDateService.convertDate(params["employeeBankAccounts[" + u + "].activeFrom"])
             }
             catch (Exception ex) {
             }
             try {
                 employeeBankAccountInstance.activeTo = ConvertDateService.convertDate(params["employeeBankAccounts[" + u + "].activeTo"])
             }
             catch (Exception ex) {
             }
             try {
                 employeeBankAccountInstance.openingDate = ConvertDateService.convertDate(params["employeeBankAccounts[" + u + "].openingDate"])
             }
             catch (Exception ex) {
             }
             employeeBankAccountInstance.remarks = params["employeeBankAccounts[" + u + "].remarks"]
             employeeInstance.addToEmployeeBankAccounts(employeeBankAccountInstance)
             u++
         }*/

        /* int v = 0
         while (params["employeeReportingBosses[" + v + "].id"] != null) {
             def employeeReportingBossInstance
             if (params["employeeReportingBosses[" + v + "].new"] == 'true' && params["employeeReportingBosses[" + v + "].deleted"] == 'true') {
                 v++
                 continue
             } else if (params["employeeReportingBosses[" + v + "].new"] == 'false' && params["employeeReportingBosses[" + v + "].deleted"] == 'false') {
                 employeeReportingBossInstance = EmployeeReportingBoss.findById(Long.valueOf(params["employeeReportingBosses[" + v + "].id"]))
             } else if (params["employeeReportingBosses[" + v + "].new"] == 'false' && params["employeeReportingBosses[" + v + "].deleted"] == 'true') {
                 employeeReportingBossInstance = EmployeeReportingBoss.findById(Long.valueOf(params["employeeReportingBosses[" + v + "].id"]))
                 employeeReportingBossInstance.status = 'DELETED'
                 employeeInstance.addToEmployeeReportingBosses(employeeReportingBossInstance)
                 v++
                 continue
             }
             if (params["employeeReportingBosses[" + v + "].new"] == 'true' && params["employeeReportingBosses[" + v + "].deleted"] == 'false') {
                 employeeReportingBossInstance = new EmployeeReportingBoss()
                 employeeReportingBossInstance.code = codeGeneratorService.generateCode("EmployeeReportingBoss", 'EMP-REPORTING-BOSS-')
             }
             try {
                 def employeeBossInstance = Employee.findById(Long.valueOf(params["employeeReportingBosses[" + v + "].employeeId"]))
                 employeeReportingBossInstance.employeeId = employeeBossInstance
             } catch (Exception ex) {
             }

             employeeReportingBossInstance.name = employeeInstance.employeeId + '-' + employeeReportingBossInstance.employeeId.employeeId

             employeeReportingBossInstance.isActive = params["employeeReportingBosses[" + v + "].isActive"]
             try {
                 employeeReportingBossInstance.activeFrom = ConvertDateService.convertDate(params["employeeReportingBosses[" + v + "].activeFrom"])
             }
             catch (Exception ex) {
             }
             try {
                 employeeReportingBossInstance.activeTo = ConvertDateService.convertDate(params["employeeReportingBosses[" + v + "].activeTo"])
             }
             catch (Exception ex) {
             }

             employeeReportingBossInstance.remarks = params["employeeReportingBosses[" + v + "].remarks"]
             employeeInstance.addToEmployeeReportingBosses(employeeReportingBossInstance)
             v++
         }*/
        def employeeImage = request.getFile('imagePath1')

        fileUploadService.uploadFileToS3(employeeImage, 'employee-images', personInstance, 'imagePath')

        populateInsertUpdatedByService.populateUserId(employeeInstance, "lastUpdatedByUserId")
        populateInsertUpdatedByService.populateUserId(personInstance, "lastUpdatedByUserId")

        if (!personInstance.validate() || !employeeInstance.validate()) {
            render(view: "edit", model: [employeeInstance: employeeInstance, personInstance: personInstance])
            return
        }

        def propertyNameList = new ArrayList()
        def originalValueList = new ArrayList()
        def currentValueList = new ArrayList()

        def names = personInstance.dirtyPropertyNames
        for (name in names) {
            def originalValue = personInstance.getPersistentValue(name)
            def currentValue = personInstance["${name}"]
            propertyNameList.add(name)
            originalValueList.add(originalValue)
            currentValueList.add(currentValue)
        }

        def namesEmployee = employeeInstance.dirtyPropertyNames
        for (nameEmployee in namesEmployee) {
            def originalValue = employeeInstance.getPersistentValue(nameEmployee)
            def currentValue = employeeInstance["${nameEmployee}"]
            propertyNameList.add(nameEmployee)
            originalValueList.add(originalValue)
            currentValueList.add(currentValue)
        }


        personInstance.save(flush: true)
        employeeInstance.save flush: true

        if (propertyNameList.size() > 0) {
            for (def i = 0; i < propertyNameList.size(); i++) {
                logMaintainService.saveNameChangeLog(personInstance, employeeInstance.employeeId, 'Employee', propertyNameList[i], originalValueList[i], currentValueList[i], personInstance.lastUpdatedByUserId)
            }
        }

        logMaintainService.saveActivityLog('Employee', 'edit', employeeInstance.id)
        logMaintainService.saveActivityLog('Person', 'edit', personInstance.id)

        try {
            def userInstance = User.find('from User c where c.id in (select a.userId.id from PersonUserType a where a.personId = ?)', [personInstance])
            if (userInstance) {
                userInstance.emailAddress = personInstance.emailAddress
                userInstance.contactNo = personInstance.contactNumber
                userInstance.name = personInstance.firstName
                userInstance.save(flush: true)
            }
        }
        catch (Exception ex) {
        }


        try {
            def userInstance = User.findByEmailAddress(employeeInstance.personId.emailAddress)
            if (!userInstance) {
                userInstance = new User()
                userInstance.code = employeeInstance.employeeId
                userInstance.name = employeeInstance.personId.firstName
                userInstance.emailAddress = personInstance.emailAddress
                userInstance.contactNo = personInstance.contactNumber
                def dateOfBirth = personInstance.dateOfBirth
                def password = (dateOfBirth.calendarDate.year.toString() + dateOfBirth.calendarDate.month.toString().padLeft(2, '0') + dateOfBirth.date.toString().padLeft(2, '0')).encodeAsMD5()
                userInstance.password = password
                userInstance.confirmPassword = password
                userInstance.remarks = 'Automatic entry during employee entry.'
                userInstance.isActive = true
                userInstance.activeFrom = new Date()
                userInstance.defaultRole = 'User'
                populateInsertUpdatedByService.populateUserId(userInstance, "createdByUserId")
                userInstance.save(flush: true)
                logMaintainService.saveActivityLog('User', 'create', userInstance.id)
            }

            def personUserTypeInstance = PersonUserType.findByPersonIdAndUserIdAndUserType(employeeInstance.personId, userInstance, 'Employee')
            if (!personUserTypeInstance) {
                personUserTypeInstance = new PersonUserType()
                personUserTypeInstance.personId = personInstance
                personUserTypeInstance.userId = userInstance
                personUserTypeInstance.userType = 'Employee'
                personUserTypeInstance.remarks = 'Automatic entry during employee entry.'
                populateInsertUpdatedByService.populateUserId(userInstance, "createdByUserId")
                personUserTypeInstance.save(flush: true)
                logMaintainService.saveActivityLog('PersonUserType', 'create', personUserTypeInstance.id)
            }
        }
        catch (Exception ex) {}

/*
        def image = request.getFile("imagePath1")
        if (!image.isEmpty()) {
            def fileName = employeeInstance.employeeId + new Date().getTime()
            if (image.contentType == "image/jpeg") {
                fileName += '.jpg'
                personInstance.imagePath = fileUploadService.uploadImage(image, "${fileName}", 'employee_image')
            } else if (image.contentType == "image/png") {
                fileName += '.png'
                personInstance.imagePath = fileUploadService.uploadImage(image, "${fileName}", 'employee_image')
            }
            personInstance.save(flush: true)
        }*/

        flash.message = message(code: 'default.updated.message', args: [message(code: 'Employee.label', default: 'Employee'), employeeInstance.id])
        redirect(action: "show", id: employeeInstance.id)
    }

    @Transactional
    def delete(Employee employeeInstance) {
        if (employeeInstance == null) {
            notFound()
            return
        }
        employeeInstance.status = 'DELETED'
        employeeInstance.save(flush: true)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Employee.label', default: 'Employee'), employeeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def search() {
        params.max = Math.min(params.max ? params.int('max') : 50, 100)
        String mainQu = "FROM Employee m "

        def mapx = new HashMap()
        List ffff = new ArrayList()
        String isTtl

        if (params.anyText != '' && (isTtl = params.anyText.trim()).length() != 0) {
            mapx.put("anyText", "%" + isTtl.toLowerCase() + "%")
            ffff.add("(LOWER(m.employeeId) || LOWER(m.personId.firstName) || LOWER(m.employeeStatus)  LIKE :anyText)")
        }

        if (params.code != null && params.code != '' && (isTtl = params.code.trim()).length() != 0) {
            mapx.put("code", "%" + isTtl.toLowerCase() + "%")
            ffff.add("LOWER(m.employeeId) like :code")
        }
        if (params.name != null && params.name != '' && (isTtl = params.name.trim()).length() != 0) {
            mapx.put("name", "%" + isTtl.toLowerCase() + "%")
            ffff.add("LOWER(m.personId.firstName) like :name")
        }

        if (params.employeeType != null && params.employeeType != '' && (isTtl = params.employeeType.trim()).length() != 0) {
            mapx.put("employeeType",  isTtl.toLowerCase())
            ffff.add("LOWER(m.employeeType) = :employeeType")
        }

        if (params.employeeStatus != null && params.employeeStatus != '' && (isTtl = params.employeeStatus.trim()).length() != 0) {
            mapx.put("employeeStatus",  isTtl.toLowerCase())
            ffff.add("LOWER(m.employeeStatus) = :employeeStatus")
        }

        if (ffff.size()) {
            String ddd = ffff.toString()
            ddd = ddd.substring(1, ddd.length() - 1)
            ddd = ddd.replaceAll(",", " AND ")
            mainQu += " WHERE "
            mainQu += ddd
        }
        def lst = Employee.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
        def totalCount = Employee.executeQuery(mainQu, mapx).size()
        render(view: "index", model: [employeeInstanceList: lst, employeeInstanceCount: totalCount])
    }

    def employeePictureUploadForm() {}

    def uploadPhoto() {
        def employeeInstance = Employee.findById(Long.valueOf(params["employeeId.id"]))
        if (employeeInstance == null) {
            flash.message = "Please enter a valid Employee Id."
            redirect(action: 'employeesPictureUploadForm')
            return
        }
        def image = request.getFile("pictureFile")
        if (!image.isEmpty()) {
            def personInstance = employeeInstance.personId
            def fileName = employeeInstance.employeeId + new Date().getTime()
            if (image.size > 1048576) {
                flash.message = "Image size is bigger than expected. Please upload an image of size less than 1 MB."
                redirect(action: 'employeePictureUploadForm')
                return
            }
            if (image.contentType == "image/jpeg") {
                fileName += '.jpg'
                personInstance.imagePath = fileUploadService.uploadImage(image, "${fileName}", 'employee_image')
            } else if (image.contentType == "image/png") {
                fileName += '.png'
                personInstance.imagePath = fileUploadService.uploadImage(image, "${fileName}", 'employee_image')
            } else {
                flash.message = "Invalid Image Type."
                redirect(action: 'employeePictureUploadForm')
                return
            }
            personInstance.save(flush: true)
            flash.message = "Employees Picture Uploaded Successfully."
            redirect(action: 'employeePictureUploadForm')
        }
    }
}
