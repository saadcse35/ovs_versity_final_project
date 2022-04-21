package common.data

import common.accessControl.User
import common.log.AccessLog

class Location {
    Long id
    String code
    String name
    String locationType
    Location parentId

    String remarks
    Boolean isActive = true
    Date activeFrom
    Date activeTo
    String status = "ACTIVE"
    Date dateCreated
    Date lastUpdated
    User createdByUserId
    User lastUpdatedByUserId
    AccessLog createdBySessionId
    AccessLog lastUpdatedBySessionId

    static hasMany = [locations: Location]

    static constraints = {
        code(blank: false, size: 2..30, unique: true)
        name(blank: false, size: 2..100)

        parentId(nullable: true)

        locationType(blank: false, inList: ["Country", "State/Division", "District", "Thana"])

        remarks(nullable: true, size: 0..1000)
        isActive(nullable: true, size: 0..1)
        activeFrom(nullable:true)
        activeTo(nullable:true)

        dateCreated(nullable:true)
        lastUpdated(nullable:true)

        createdByUserId(nullable:true)
        lastUpdatedByUserId(nullable:true)
        createdBySessionId(nullable: true)
        lastUpdatedBySessionId(nullable: true)
    }

    static mapping = {
        version false
        table 'CMN_DT_LOC'
        parentId column: 'PARENT_ID'

        createdByUserId column: 'CMN_ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'CMN_ACL_USER_UP_BY_ID'
        createdBySessionId column: 'CMN_ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'CMN_ACCESS_LOG_UP_BY_SESS_ID'
        status defaultValue: "'ACTIVE'"
    }

    String toString(){
        this?.name
    }
}
