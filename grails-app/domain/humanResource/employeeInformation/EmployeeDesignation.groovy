package humanResource.employeeInformation

import common.accessControl.User
import humanResource.setup.Designation
import common.log.AccessLog

class EmployeeDesignation {
    Long id
    String code
    String name
    Designation designationId
    /*Organization organizationId*/
    Employee employeeId
    Boolean isDefault = false

    Boolean isActive = false
    Date activeFrom
    Date activeTo
    String remarks
    String status = "ACTIVE"

    Date dateCreated
    Date lastUpdated
    User createdByUserId
    User lastUpdatedByUserId
    AccessLog createdBySessionId
    AccessLog lastUpdatedBySessionId


    static constraints = {
        code(blank: false, size: 2..30)
        name(blank: false, size: 2..100)
        designationId(nullable: false)
        /*organizationId(nullable: false)*/
        employeeId(nullable: false)
        isActive(nullable: true, size: 0..1)
        isDefault(nullable: true, size: 0..1)
        activeFrom(nullable: true)
        activeTo(nullable: true)
        remarks(nullable: true, size: 0..1000)
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
        table 'HRM_EI_EMP_DESIG'
        /*organizationId column: 'CMN_CORE_ORG_ID'*/
        designationId column: 'HRM_STP_DESIG_ID'
        employeeId column: 'HRM_EI_EMP_ID'
        createdByUserId column: 'CMN_ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'CMN_ACL_USER_UP_BY_ID'
        createdBySessionId column: 'CMN_ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'CMN_ACCESS_LOG_UP_BY_SESS_ID'
        status defaultValue: "'ACTIVE'"
    }

    String toString() {
        return this?.name
    }
}
