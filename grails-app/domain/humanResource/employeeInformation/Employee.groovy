package humanResource.employeeInformation

import common.accessControl.User
import common.core.Person
import common.log.AccessLog

class Employee {
    Long id
    Person personId
    String employeeId

    Date dateOfJoining

    String employeeType

    String employeeStatus

    Date dateOfTermination

    String salaryScaleType = "Fixed"
    Float salaryAmount

    String incomeTaxDeductionMethod

    Boolean isAttendanceRequired = true

    String remarks
    Boolean isActive =true
    Date activeFrom
    Date activeTo
    String status = 'ACTIVE'

    Date dateCreated
    Date lastUpdated
    User createdByUserId
    User lastUpdatedByUserId
    AccessLog createdBySessionId
    AccessLog lastUpdatedBySessionId


    static hasMany = [employeeDesignations:EmployeeDesignation, employmentHistories: EmploymentHistory]

    static constraints = {
        personId(nullable: false)
        employeeId(nullable: false, unique: true)
        employeeType(blank: false, size: 0..30, inList: ["Full Time Employee", "Contract Employee"])
        dateOfJoining(nullable: false)
        employeeStatus(blank: false, size: 0..30, inList: ["Running", "Retired", "Sacked", "Resigned", "On Leave"])
        salaryScaleType(nullable: true, size: 0..30, inList: ["Fixed", "Salary Scale"])
        dateOfTermination(nullable: true)
        salaryAmount(nullable: true)

        incomeTaxDeductionMethod(nullable: true, size: 0..30, inList: ["Standard Rule(NBR)", "Fixed Amount", "Fixed Percent"])

        remarks(nullable: true, size: 0..1000)

        isActive(nullable: true, size: 0..1)
        isAttendanceRequired(nullable: true, size: 0..1)

        activeFrom(nullable: true)
        activeTo(nullable: true)

        dateCreated(nullable: true)
        lastUpdated(nullable: true)

        createdByUserId(nullable: true)
        lastUpdatedByUserId(nullable: true)
        createdBySessionId(nullable: true)
        lastUpdatedBySessionId(nullable: true)
        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])
    }

    static mapping = {
        version false
        table 'HRM_EI_EMP'
        personId column: 'CMN_CORE_PERSON_ID'


        createdByUserId column: 'CMN_ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'CMN_ACL_USER_UP_BY_ID'
        createdBySessionId column: 'CMN_ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'CMN_ACCESS_LOG_UP_BY_SESS_ID'
        status defaultValue: "'ACTIVE'"

    }

    String toString(){
        return this.employeeId +" - " + this?.personId?.name
    }
}