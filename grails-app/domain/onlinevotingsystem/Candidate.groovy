package onlinevotingsystem

import common.accessControl.User
import common.log.AccessLog
import common.core.Person

class Candidate {
    Long id
    String code
    Person personId
    String imagePath
    Voter voterId
    Party partyId
    Election electionId
    Seat seatId

    String contactNumber
    String emailAddress

    String nationalIdNumber
    String fileUploadPath


    Integer sortOrder

    String remarks
    Boolean isActive =true
    String status = 'ACTIVE'

    Date dateCreated
    Date lastUpdated
    User createdByUserId
    User lastUpdatedByUserId
    AccessLog createdBySessionId
    AccessLog lastUpdatedBySessionId

    static constraints = {
        code(blank: false, unique: true)
        personId(nullable: false)
        imagePath(nullable: true)
        voterId(nullable: false)
        partyId(nullable: false)
        electionId(nullable: false)
        seatId(nullable: false)

        contactNumber(unique: true, nullable:false, size: 0..20)
        emailAddress(nullable: true, unique: true, size: 0..100, email: true)

        nationalIdNumber(unique: true, nullable: false, size: 0..30)


        sortOrder(nullable: true)

        remarks(nullable: true, size: 0..1000)
        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])
        isActive(nullable: true, size: 0..1)

        dateCreated(nullable: true)
        lastUpdated(nullable: true)
        createdByUserId(nullable: true)
        lastUpdatedByUserId(nullable: true)
        createdBySessionId(nullable: true)
        lastUpdatedBySessionId(nullable: true)


    }
    static mapping = {
        version(false)
        table('CANDIDATE')

        electionId column: 'OVS_ELECTION_ID'
        createdByUserId column: 'ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'ACL_USER_UP_BY_ID'
        createdBySessionId column: 'ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'ACCESS_LOG_UP_BY_SESS_ID'

        status defaultValue: "'ACTIVE'"
        sort "sortOrder"
    }
    String toString(){
        return this?.personId?.name
    }
}
