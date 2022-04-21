package common.accessControl

import common.log.AccessLog

class Role {
    Long id
    String code
    String name
    String status = "ACTIVE"
    String remarks
    Boolean isActive = false
    Date activeFrom
    Date activeTo

    Date dateCreated
    Date lastUpdated
    User createdByUserId
    User lastUpdatedByUserId
    AccessLog createdBySessionId
    AccessLog lastUpdatedBySessionId

    static hasMany = [roleTasks: RoleTask]

    static constraints = {
        code(blank: false, size: 2..30, unique: true)
        name(blank: false, size: 2..100, unique: true)
        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])
        
        remarks(nullable: true, size: 0..1000)
        isActive(nullable: true, size: 0..1)
        activeFrom(nullable: true)
        activeTo(nullable: true)

        dateCreated(nullable: true)
        lastUpdated(nullable: true)

        createdByUserId(nullable: true)
        lastUpdatedByUserId(nullable: true)
        createdBySessionId(nullable: true)
        lastUpdatedBySessionId(nullable: true)

    }

    static mapping = {
        version false
        table 'CMN_ACL_ROLE'

        createdByUserId column: 'ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'ACL_USER_UP_BY_ID'
        createdBySessionId column: 'ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'ACCESS_LOG_UP_BY_SESS_ID'

        status defaultValue: "'ACTIVE'"
    }

    String toString() {
        return this?.name
    }
}
