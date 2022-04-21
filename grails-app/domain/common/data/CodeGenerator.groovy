package common.data

import common.accessControl.User
import common.log.AccessLog

class CodeGenerator {
    Long id
    String modelName
    String defaultPrefix
    Integer lastDigitLength
    Integer nextValue


    String status = 'ACTIVE'
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

    static constraints = {
        modelName(nullable: false, unique: true, size: 0..50)
        defaultPrefix(nullable: true, size: 0..30)
        lastDigitLength(nullable: false)
        nextValue(nullable: false)
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
        table 'CMN_DT_CODE_GENERATOR'

        createdByUserId column: 'ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'ACL_USER_UP_BY_ID'
        createdBySessionId column: 'ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'ACCESS_LOG_UP_BY_SESS_ID'
        status defaultValue: "'ACTIVE'"
    }
}
