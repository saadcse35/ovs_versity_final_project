package humanResource.employeeInformation

import common.accessControl.User
import common.log.AccessLog

class EmploymentHistory {
    Long id
    String code
    String name
    Employee employeeId
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

        employeeId(nullable: false)

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
        table 'HRM_EI_EMPLMNT_HIST'
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
