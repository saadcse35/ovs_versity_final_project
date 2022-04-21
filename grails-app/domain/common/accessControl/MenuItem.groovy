package common.accessControl

import common.log.AccessLog
import common.reportCenter.ReportParameterDetail

class MenuItem {
    Long id
    String code
    String name
    String controllerName
    String actionName

    String menuType
    MenuItem parentId

    Integer sortOrder

    String status = "ACTIVE"
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

    static hasMany = [menuItems: MenuItem, roleTasks: RoleTask, reportParameterDetails: ReportParameterDetail]

    static constraints = {
        code(blank: false, size: 2..30, unique: true)
        name(blank: false, size: 2..100, unique: false)
        controllerName(blank: false, size: 0..100)
        actionName(blank: false, size: 0..100)
        parentId(nullable: true)
        menuType(blank: false, size: 0..50, inList: ['Module', 'Sub Module', 'Menu Item', 'Task', 'Report Group', 'Report Sub-Group', 'Report', 'Child Report'])

        sortOrder(nullable: true)

        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])

        isActive(nullable: true, size: 0..1)
        activeFrom(nullable: true)
        activeTo(nullable: true)
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
        table 'CMN_ACL_MENU'
        parentId column: 'PARENT_ID'

        createdByUserId column: 'ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'ACL_USER_UP_BY_ID'
        createdBySessionId column: 'ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'ACCESS_LOG_UP_BY_SESS_ID'



        status defaultValue: "'ACTIVE'"
        sort: 'sortOrder'
    }

    String toString() {
        return this?.name
    }
}
