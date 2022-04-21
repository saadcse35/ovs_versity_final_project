package common.reportCenter

import common.accessControl.MenuItem
import common.accessControl.User
import common.log.AccessLog

class ReportParameterDetail {
    Long id
    String code
    MenuItem menuItemReportId
    ReportParameter reportParameterId
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

    static hasMany = [reportDeatails: ReportParameterDetail]

    static constraints = {
        code(blank: true, size: 2..30, unique: true)
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
        table 'CMN_RC_REPORT_PARAM_DTL'
        menuItemReportId column: 'CMN_ACL_MENU_REPORT_ID'
        reportParameterId column: 'CMN_RC_REPORT_PARAM_ID'
        createdByUserId column: 'ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'ACL_USER_UP_BY_ID'
        createdBySessionId column: 'ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'ACCESS_LOG_UP_BY_SESS_ID'
        status defaultValue: "'ACTIVE'"
        sort "sortOrder"
    }

    /*String toString() {
        return this?.name
    }*/
}
