package common.log

import common.accessControl.User

class NameChangeLog {
    Long id
    String code
    String domainName
    Long objectId
    String objectCode
    String propertyName
    String previousValue
    String presentValue

    Date dateCreated
    User updatedByUserId
    String sessionId

    String remarks

    String status = 'ACTIVE'

    static constraints = {
        id(size: 0..22)
        code(nullable: true,unique: false,size: 0..30)
        domainName(nullable: false, size: 0..100)
        objectId(nullable: false)
        objectCode(nullable: true, size: 0..50)
        domainName(nullable: false, size: 0..100)
        propertyName(nullable: false, size: 0..100)
        propertyName(nullable: false, size: 0..500)
        presentValue(nullable: false, size: 0..500)
        dateCreated(nullable: true)
        remarks(nullable: true,size: 0..1000)
        dateCreated(nullable: true)
        updatedByUserId(nullable: false)
        remarks(nullable: true, size: 0..500)
        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])
    }
    static mapping = {
        version false
        table 'CMN_LOG_NAME_CHANGE'
        updatedByUserId column: 'ACL_USER_UP_BY_ID'
        status defaultValue: "'ACTIVE'"
    }
}
