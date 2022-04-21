package common.reportCenter

import common.accessControl.User
import common.log.AccessLog

class ReportParameter {
    Long id
    String code
    String name
    String parameterType
    String className
    String status = "ACTIVE"
    Integer sortOrder
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

    static hasMany = [reportParameterDeatails: ReportParameterDetail]

    static constraints = {
        code(blank: false, size: 2..30, unique: true)
        name(blank: false, size: 2..100, unique: true)
        parameterType(blank: false, size: 0..50)
        className(nullable: true, size: 0..50)
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
        table 'CMN_RC_REPORT_PARAM'
        createdByUserId column: 'ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'ACL_USER_UP_BY_ID'
        createdBySessionId column: 'ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'ACCESS_LOG_UP_BY_SESS_ID'
        status defaultValue: "'ACTIVE'"
        sort "sortOrder"
    }

    String toString() {
        return this?.name
    }
}
