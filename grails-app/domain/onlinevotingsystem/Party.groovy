package onlinevotingsystem

import common.accessControl.User
import common.log.AccessLog

class Party {
    Long id
    String code
    String name
    Election electionId
    String imagePath
    String shortName
    Date regDate
    String partyDescription

    Boolean isActive=true
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
        name (nullable: false, unique: true, size: 2..100)
        shortName(nullable: true, size: 0..50)
        electionId(nullable: false)
        regDate(nullable: true)
        partyDescription(nullable: true, size: 0..4000)
        imagePath(nullable: true)

        isActive(nullable: true)
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
        table('PARTY')

        electionId column: 'ELECTION_ID'
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
