package common.log

import common.accessControl.User

class PasswordChangeLog {
    Long id
    User userId
    String changeType
    String applicationName
    Boolean isSuccessFull = false
    String sessionId

    String remoteHost
    String ipAddress
    String actualIpAddress
    String browserName
    String browserVersion
    String operatingSystem
    String deviceName
    String userAgentDetails

    String previousPassword
    String currentPassword
    String resetCode
    String emailUsed

    Date dateCreated

    String status = 'ACTIVE'

    static constraints = {
        userId(nullable: true)
        changeType(nullable: false, size : 0..100)
        applicationName(nullable: false, size : 0..100, inList: ['Student Portal', 'ERP', 'Online Application Form'])
        isSuccessFull(nullable: false, size : 0..1)
        sessionId(nullable: true, size : 0..100)

        remoteHost(nullable: true, size:0..100)
        ipAddress(nullable: true, size:0..100)
        actualIpAddress(nullable: true, size: 0..100)
        browserName(nullable: true, size:0..100)
        browserVersion(nullable: true, size:0..100)
        operatingSystem(nullable: true, size:0..100)
        deviceName(nullable: true, size:0..100)
        userAgentDetails(nullable: true, size: 0..200)
        previousPassword(nullable: true, size:0..100)
        currentPassword(nullable: true, size:0..100)
        resetCode(nullable: true, size:0..100)
        emailUsed(nullable: true, size:0..200)
        dateCreated(nullable: true, size:0..100)

        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])
    }
    static mapping = {
        version false
        table 'CMN_LOG_PASSWORD_CHANGE'
        userId column: 'ACL_USER_ID'
        status defaultValue: "'ACTIVE'"
    }
}