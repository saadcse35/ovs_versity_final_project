package common.log

class ActivityLog {
    Long id
    AccessLog accessLogId
    String sessionId
    String domainName
    String actionName
    String description
    Long objectId
    Date dateCreated

    String status = 'ACTIVE'


    static constraints = {
        sessionId(nullable: false, size: 0..50)
        domainName(nullable: false, size: 0..50)
        actionName(nullable: false, size: 0..50)
        description(nullable: false, size: 0..500)
        objectId(nullable: false)
        dateCreated(nullable: true)
        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])
    }

    static mapping = {
        version false
        table 'CMN_LOG_ACTIVITY'
        accessLogId column: 'LOG_ACCESS_ID'
        status defaultValue: "'ACTIVE'"
    }
}
