package common.accessControl


import common.log.AccessLog

class User {
    Long id
    String code
    String name
    String defaultRole
    String emailAddress
    String contactNo

    String password
    String confirmPassword

    String resetCode
    String resetToken
    Date resetTokenSetDate
    Boolean isTokenUsed
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

    static mappedBy = [userTasks: 'userId']

    static hasMany = [userTasks: UserTask]


    static constraints = {
        code(blank: false, size: 2..30, unique: true)
        name(blank: false, size: 2..100)
        defaultRole(blank: false, size: 0..50, inList: ['Super Admin', 'Org Admin', 'Admin', 'User', 'Demo User'])
        emailAddress(nullable: false, unique: true, size: 0..200, email: true)
        contactNo(nullable: true, size: 0..15)

        password(blank: false, size: 6..100, password: true)

        confirmPassword(blank: false, size: 6..100, password: true,
                validator: { val, object ->
                    if (val != object.password) {
                        return "Password doesn't Match"
                    }
                    return true
                }
        )

        resetCode(nullable: true)
        resetToken(nullable: true, size: 6..100)
        resetTokenSetDate(nullable: true)
        isTokenUsed(nullable: true)
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
        table 'CMN_ACL_USER'

        createdByUserId column: 'ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'ACL_USER_UP_BY_ID'
        createdBySessionId column: 'ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'ACCESS_LOG_UP_BY_SESS_ID'

        status defaultValue: "'ACTIVE'"
    }

    String toString() {
        return this.code + ' (' + this.name + ')'
    }
}
