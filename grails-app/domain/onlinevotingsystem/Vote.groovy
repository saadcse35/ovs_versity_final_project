package onlinevotingsystem

import common.accessControl.User
import common.core.Person
import common.log.AccessLog

class Vote {
    Long id
    String code
    Election electionId
    Voter voterId
    Candidate candidateId

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
        electionId(nullable: false)
        voterId(nullable: false)
        candidateId(nullable: false)

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
        table('VOTE')


        electionId column: 'OVS_ELECTION_ID'
        candidateId column: 'OVS_CANDIDATE_ID'

        createdByUserId column: 'ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'ACL_USER_UP_BY_ID'
        createdBySessionId column: 'ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'ACCESS_LOG_UP_BY_SESS_ID'
        status defaultValue: "'ACTIVE'"
        sort "sortOrder"
    }
    String toString(){
        return this?.voterId
    }
}
