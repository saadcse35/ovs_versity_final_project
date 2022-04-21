package common.accessControl


import common.core.Person
import common.log.AccessLog

class PersonUserType {
    Long id
    Person personId
    User userId

    String userType
    String status = "ACTIVE"

    String remarks


    Date dateCreated
    Date lastUpdated
    User createdByUserId
    User lastUpdatedByUserId
    AccessLog createdBySessionId
    AccessLog lastUpdatedBySessionId


    static constraints = {
        personId(nullable: false)
        userId(nullable: false)
        userType(blank: false, inList: ["Voter", "Candidate", "Employee"])
        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])

        remarks(nullable: true, size: 0..1000)


        dateCreated(nullable: true)
        lastUpdated(nullable: true)

        createdByUserId(nullable: true)
        lastUpdatedByUserId(nullable: true)
        createdBySessionId(nullable: true)
        lastUpdatedBySessionId(nullable: true)
    }

    static mapping = {
        version false
        table 'CMN_ACL_PERSON_USER_TYP'
        personId column: 'CORE_PERSON_ID'
        userId column: 'ACL_USER_ID'

        createdByUserId column: 'ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'ACL_USER_UP_BY_ID'
        createdBySessionId column: 'ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'ACCESS_LOG_UP_BY_SESS_ID'
        status defaultValue: "'ACTIVE'"
    }
}
