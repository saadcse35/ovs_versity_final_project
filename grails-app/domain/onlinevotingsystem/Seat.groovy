package onlinevotingsystem

import common.accessControl.User
import common.data.Location
import common.log.AccessLog

class Seat {
    Long id
    String code
    String name
    Integer parliamentSeatNo
    String boundary
    Location divisionId
    Location districtId

    Boolean isActive = true
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
        name(nullable: false, size: 0..100, unique: true)
        parliamentSeatNo(nullable: false)
        boundary(nullable: false)
        divisionId (nullable: false)
        districtId(nullable: false)

        isActive(nullable: false)
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
        table('SEAT')

        divisionId column: 'DT_LOC_DIVISION_ID'
        districtId column: 'DT_LOC_DISTRICT_ID'
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
