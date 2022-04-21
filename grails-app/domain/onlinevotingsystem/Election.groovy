package onlinevotingsystem

import common.accessControl.User
import common.log.AccessLog

class Election {
    Long id
    String code
    String name
    Date startDate
    Date endDate

    Boolean isActive = true
    String status = "ACTIVE"
    Integer sortOrder

    Date dateCreated
    Date lastUpdated
    User createdByUserId
    User lastUpdatedByUserId
    AccessLog createdBySessionId
    AccessLog lastUpdatedBySessionId

    static constraints = {
        code(blank: false, unique: true)
        name(nullable: false, unique: true)
        startDate(nullable: false)
        endDate(nullable: false)

        isActive(nullable: false)
        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])
        sortOrder(nullable: true)

        dateCreated(nullable: true)
        lastUpdated(nullable: true)
        createdByUserId(nullable: true)
        lastUpdatedByUserId(nullable: true)
        createdBySessionId(nullable: true)
        lastUpdatedBySessionId(nullable: true)

    }

    static mapping = {
        version(false)
        table('ELECTION')

        createdByUserId column: 'ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'ACL_USER_UP_BY_ID'
        createdBySessionId column: 'ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'ACCESS_LOG_UP_BY_SESS_ID'

        status defaultValue: "'ACTIVE'"
        sort "sortOrder"
    }

    String toString(){
        return this?.name
    }
}
