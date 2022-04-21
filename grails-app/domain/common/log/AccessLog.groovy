package common.log

import common.accessControl.User

class AccessLog {
    Long id
    User userId
    String sessionId
    String applicationName
    String remoteHost
    String ipAddress
    String actualIpAddress
    String browserName
    String browserVersion
    String operatingSystem
    String deviceName
    String userAgentDetails
    Date dateCreated
    Date lastUpdated
    Date logoutTime
    String emailAuthenticationCode
    String smsAuthenticationCode
    Date authenticationCodeSetDate
    Boolean isTrusted = false

    String status = 'ACTIVE'

    static hasMany = [activities: ActivityLog]

    static constraints = {
        sessionId(nullable: false, unique: false)
        userId(nullable: false)
        applicationName(nullable: true, size: 0..50)
        remoteHost(nullable: true, size: 0..20)
        ipAddress(nullable: true, size: 0..20)
        actualIpAddress(nullable: true, size: 0..20)
        browserName(nullable: true, size: 0..50)
        browserVersion(nullable: true, size: 0..50)
        operatingSystem(nullable: true, size: 0..50)
        deviceName(nullable: true, size: 0..50)
        userAgentDetails(nullable: true, size: 0..200)
        dateCreated(nullable: true)
        lastUpdated(nullable: true)
        logoutTime(nullable: true)
        emailAuthenticationCode(nullable: true)
        smsAuthenticationCode(nullable: true)
        authenticationCodeSetDate(nullable: true)
        isTrusted(nullable: false)

        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])


    }


    static mapping = {
        version false
        table 'CMN_LOG_ACCESS'
        userId column: 'ACL_USER_ID'
        status defaultValue: "'ACTIVE'"
        isTrusted defaultValue: "'0'"
    }

    String toString(){
        return this.sessionId
    }
}
