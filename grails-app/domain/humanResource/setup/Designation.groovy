package humanResource.setup

import common.accessControl.User
import common.log.AccessLog

class Designation {
    Long id
    String code
    String name
    Designation parentId

    Boolean isActive = false
    Date activeFrom
    Date activeTo
    String remarks
    String status = "ACTIVE"
    Integer sortOrder

    Date dateCreated
    Date lastUpdated
    User createdByUserId
    User lastUpdatedByUserId
    AccessLog createdBySessionId
    AccessLog lastUpdatedBySessionId

    static constraints = {
        code(blank: false, size: 2..30, unique: true)
        name(blank: false, size: 2..100, unique: true)
        parentId(nullable: true)

       /* dateOfEstablish(nullable: true)*/

        isActive(nullable: true, size: 0..1)
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
        table 'HRM_STP_DESIG'
        parentId column: 'PARENT_ID'

        createdByUserId column: 'CMN_ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'CMN_ACL_USER_UP_BY_ID'
        createdBySessionId column: 'CMN_ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'CMN_ACCESS_LOG_UP_BY_SESS_ID'
        status defaultValue: "'ACTIVE'"
        sort "sortOrder"
    }

    String toString() {
        return this?.name
    }
}
