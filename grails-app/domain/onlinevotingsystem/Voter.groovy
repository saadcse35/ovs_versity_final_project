package onlinevotingsystem

import common.accessControl.User
import common.core.Person
import common.log.AccessLog


class Voter {
    Long id
    String code
    String contactNumber
    String emailAddress
    String password
    String confirmPassword

    String nationalIdNumber

    String remarks
    Boolean isActive =true
    String status = 'ACTIVE'
    Integer sortOrder

    Date dateCreated
    Date lastUpdated
    User createdByUserId
    User lastUpdatedByUserId
    AccessLog createdBySessionId
    AccessLog lastUpdatedBySessionId


    static constraints = {

        code(nullable: false, unique: true)

        contactNumber(unique: true, nullable:false, size: 0..20)
        emailAddress(nullable: true, unique: true, size: 0..100, email: true)
        password(nullable: false)
        confirmPassword(nullable: false)

        nationalIdNumber(unique: true, nullable: false, size: 0..30)

        remarks(nullable: true, size: 0..1000)
        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])
        isActive(nullable: true, size: 0..1)
        sortOrder(nullable: true)

        dateCreated(nullable: true)
        lastUpdated(nullable: true)

        createdByUserId(nullable: true)
        lastUpdatedByUserId(nullable: true)
        createdBySessionId(nullable: true)
        lastUpdatedBySessionId(nullable: true)
    }

    static mapping = {
        version false
        table 'VOTER'

        createdByUserId column: 'CMN_ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'CMN_ACL_USER_UP_BY_ID'
        createdBySessionId column: 'CMN_ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'CMN_ACCESS_LOG_UP_BY_SESS_ID'
        status defaultValue: "'ACTIVE'"
    }

    String toString(){
        return this?.personId?.name
    }
}
