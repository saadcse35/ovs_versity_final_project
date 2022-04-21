package common.data

import common.accessControl.User
import common.log.AccessLog

class DataLookup {
    Long id
    DataLookup parentId
    String code
    String name

    Integer serialNumber
    String remarks
    Boolean isActive = false
    Date activeFrom
    Date activeTo

    String status = "ACTIVE"

    Date dateCreated
    Date lastUpdated
    User createdByUserId
    User lastUpdatedByUserId
    AccessLog createdBySessionId
    AccessLog lastUpdatedBySessionId

    static hasMany = [dataLookups: DataLookup]


    static constraints = {
        code(nullable: true, size: 0..30)
        name(blank: false, size: 0..100)
        parentId(nullable: true)

        serialNumber(nullable: true)
        remarks(nullable: true, size: 0..1000)
        isActive(nullable: true, size: 0..1)
        activeFrom(nullable: true)
        activeTo(nullable: true)
        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])
        
        dateCreated(nullable: true)
        lastUpdated(nullable: true)

        createdByUserId(nullable: true)
        lastUpdatedByUserId(nullable: true)
        createdBySessionId(nullable: true)
        lastUpdatedBySessionId(nullable: true)


    }

    static mapping = {
        version false
        table 'CMN_DT_DLU'
        parentId column: 'PARENT_ID'

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