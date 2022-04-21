package common.accessControl

import common.RandomCodeGeneratorService
//import common.core.AppSettings
import common.core.Person
import common.log.AccessLog
import common.log.LogMaintainService
import common.log.PasswordChangeLog
import humanResource.employeeInformation.Employee
import utility.ClassDictionary

class AuthoriseController {
    AccessControlService accessControlService
    def mailService
    RandomCodeGeneratorService randomCodeGeneratorService
    IpAddressLocateService ipAddressLocateService
    def userAgentIdentService
    LogMaintainService logMaintainService

    static allowedMethods = [authenticateUser: "POST", saveChangedPassword: "POST", generateResetCode: 'POST', saveResetPassword: "POST", confirmUser: "POST"]

    def login() {
        if (session["emailAddress"] != null && session["userType"] == "Website Admin") {
            redirect(action: 'home')
        }
        def redirectUrl = null
        if (params.redirectUrl) {
            redirectUrl = params.redirectUrl
        }
        [redirectUrl: redirectUrl]
    }

    def authenticateUser() {
        def userName = params.username
        def passWord = params.password

        def remoteHost = request.getRemoteAddr()
        def actualIpAddress = ipAddressLocateService.getClientIpAddress(request)
        def ipAddress = request.getRemoteHost()
        def operatingSystem = userAgentIdentService.operatingSystem
        def browserName = userAgentIdentService.browser
        def browserVersion = userAgentIdentService.browserVersion
        def userAgentDetails = userAgentIdentService.getUserAgentString()
        def isTrustedClient = false
        def isTrustedOs = false

        for (def browser : ClassDictionary.allowedBrowsers) {
            if (browserName.indexOf(browser) != -1) {
                isTrustedClient = true
                break
            }
        }
        for (def os : ClassDictionary.allowedOss) {
            if (operatingSystem.indexOf(os) != -1) {
                isTrustedOs = true
                break
            }
        }

        if (isTrustedClient == false || isTrustedOs == false) {
            flash.error = "Sorry, you are bounced back! Please try to login from a trusted client"
            redirect(action: "login")
            return
        }


        if (userName.indexOf(' ') != -1 ||  passWord.indexOf(' ') != -1) {
            flash.error = "Please enter valid username and password."
            redirect(action: "login")
            return
        }
        def password = (params.password).encodeAsMD5()
        def personInstance = Person.findByEmailAddress(userName)

        // = Employee.find("from Employee c where c.employeeId = ? and (c.personId.contactNumber = ? or c.personId.emailAddress = ?) and c.employeeStatus = ?", [userName,  'Running'])
        if (personInstance == null) {
            flash.error = "Wrong username or password! Please enter correct information."
            redirect(action: "login")
            return
        } else {
            def userPersonInstance = PersonUserType.findByPersonId(personInstance)
            if (userPersonInstance) {
                def userInstance = User.find('from User u where u.password = ? and u.id = ? and u.isActive = ?', [password, userPersonInstance.userId.id, true])
                if (userInstance == null) {
                    flash.error = "Wrong username or password! Please enter correct information."
                    redirect(action: 'login')
                    return
                } else {
                    if (!userInstance.validate(['emailAddress'])) {
                        flash.error = "Your email address (${userInstance.emailAddress}) is not a valid one. Please request authority to input your valid email address."
                        redirect(action: 'login')
                        return
                    }
                    session["emailAddress"] = userInstance.emailAddress
                    session["fullName"] = userInstance.name
                    //session["organizationId"] = userPersonInstance.organizationId
                    session["userType"] = "Website Admin"
                    def accessLogInstance = new AccessLog()
                    accessLogInstance.sessionId = session.adaptee.session.id
                    accessLogInstance.userId = userInstance
                    loadAccessDetails(accessLogInstance, "OVS", remoteHost, ipAddress, actualIpAddress, browserName, operatingSystem, browserVersion, userAgentDetails)
                    session["accessLogId"] = accessLogInstance.id



                    def trustedAccessLogInstance = AccessLog.findByUserIdAndApplicationNameAndActualIpAddressAndBrowserNameAndBrowserVersionAndOperatingSystemAndIpAddressAndUserAgentDetails(
                            userInstance,
                            accessLogInstance.applicationName,
                            accessLogInstance.actualIpAddress,
                            accessLogInstance.browserName,
                            accessLogInstance.browserVersion,
                            accessLogInstance.operatingSystem,
                            accessLogInstance.ipAddress,
                            accessLogInstance.userAgentDetails

                    )

                    if (trustedAccessLogInstance) {
                        accessLogInstance.isTrusted = true
                        accessLogInstance.save(flush: true)
                        session["accessLogId"] = accessLogInstance.id
                        if (params.redirectUrl) {
                            redirect(url: "${params.redirectUrl}")
                        } else {
                            redirect(action: 'home')
                        }
                        return
                    } else {
                        accessLogInstance.isTrusted = false
                        def emailAuthenticationCode = randomCodeGeneratorService.generateRandomCode(null, 8)
                        //def emailAuthenticationCode = 'aBcD123x'
                        accessLogInstance.emailAuthenticationCode = emailAuthenticationCode.encodeAsMD5()
                        accessLogInstance.authenticationCodeSetDate = new Date()
                        accessLogInstance.save(flush: true)
                        mailService.sendMail {
                            to "${userInstance.emailAddress}"
                            subject "Online Voting System | Access Confirmation"
                            body "Please enter the follwoing code within 5 minutes for authentication: ${emailAuthenticationCode}"
                        }
                        session["accessLogId"] = accessLogInstance.id

                        flash.error = "You are trying to login from a new device! Please check your email right now and enter the authentication code here."
                        redirect(action: 'checkUser', params: [redirectUrl: params.redirectUrl])
                        return
                    }
                }
            } else {
                flash.error = "Sorry, you are not permitted to access this portal"
                redirect(action: "login")
                return
            }
        }
    }

    def home() {
        if (session["emailAddress"] == null) {
            flash.message = "You must login to view this."
            redirect(action: 'login')
        }
    }

    def logout() {
        if (session["emailAddress"] == null) {
            flash.error = "Your session is already expired. Please login to continue."
            redirect(action: 'login')
            return
        }
        def accessLogInstance = AccessLog.findById(Long.valueOf(session["accessLogId"]))
        accessLogInstance.logoutTime = new Date()
        accessLogInstance.save(flush: true)
        session["userId"] = null
        session["emailAddress"] = null
        session["fullName"] = null
        session["accessLogId"] = null
        session.invalidate()
        redirect(action: 'login')
    }

    def changePassword() {}

    def saveChangedPassword() {
        if (params.currentPassword == '' || (params.currentPassword).length() < 6) {
            flash.error = "Wrong current password"
            redirect(action: "changePassword")
            return
        }

        if (params.password == '' || (params.password).length() < 6) {
            flash.error = "New password must be at least 6 character."
            redirect(action: "changePassword")
            return
        }
        if (params.confirmPassword == '' || (params.confirmPassword).length() < 6) {
            flash.error = "Confirm password must be at least 6 character."
            redirect(action: "changePassword")
            return
        }
        if (params.password != params.confirmPassword) {
            flash.error = "Password mismatched"
            redirect(action: "changePassword")
            return
        }
        def userInstance = User.findByEmailAddress(session["emailAddress"])
        def currentPassword = userInstance.password
        if ((params.currentPassword.encodeAsMD5() != userInstance.password)) {
            flash.error = "Current password is not correct! Please try again or reset your password."
            redirect(action: "changePassword")
            return
        }
        if ((params.password.encodeAsMD5() == userInstance.password)) {
            flash.error = "You can not use same password. Please try with another."
            redirect(action: "changePassword")
            return
        }
        userInstance.password = (params.password).encodeAsMD5()
        userInstance.confirmPassword = (params.password).encodeAsMD5()
        userInstance.save(flush: true)

        logMaintainService.saveActivityLog('User', 'changePassword', userInstance.id)

        def passwordChangeLogInstance = new PasswordChangeLog()
        def remoteHost = request.getRemoteAddr()
        def actualIpAddress = ipAddressLocateService.getClientIpAddress(request)
        def ipAddress = request.getRemoteHost()
        def operatingSystem = userAgentIdentService.operatingSystem
        def browserName = userAgentIdentService.browser
        def browserVersion = userAgentIdentService.browserVersion
        def userAgentDetails = userAgentIdentService.getUserAgentString()
        def accessLogInstance = AccessLog.findById(Long.valueOf(session["accessLogId"]))
        def sessionId = accessLogInstance.sessionId
        loadAccessDetails(passwordChangeLogInstance, "ERP", remoteHost, ipAddress, actualIpAddress, browserName, operatingSystem, browserVersion, userAgentDetails)
        logMaintainService.savePasswordChangeLog(passwordChangeLogInstance, userInstance, true,
                sessionId, 'Password Change', currentPassword, userInstance.password, null, null)
        flash.message = "Password changed successfully"
        redirect(action: 'home')
    }

    def forgotPassword() {}

    def generateResetCode() {
        def passwordChangeLogInstance = new PasswordChangeLog()
        def remoteHost = request.getRemoteAddr()
        def actualIpAddress = ipAddressLocateService.getClientIpAddress(request)
        def ipAddress = request.getRemoteHost()
        def operatingSystem = userAgentIdentService.operatingSystem
        def browserName = userAgentIdentService.browser
        def browserVersion = userAgentIdentService.browserVersion
        def userAgentDetails = userAgentIdentService.getUserAgentString()

        def isTrustedClient = false
        def isTrustedOs = false

        for (def browser : ClassDictionary.allowedBrowsers) {
            if (browserName.indexOf(browser) != -1) {
                isTrustedClient = true
                break
            }
        }
        for (def os : ClassDictionary.allowedOss) {
            if (operatingSystem.indexOf(os) != -1) {
                isTrustedOs = true
                break
            }
        }

        if (isTrustedClient == false || isTrustedOs == false) {
            flash.error = "Sorry, you are bounced back! Please try to login from a trusted client"
            redirect(action: "login")
            return
        }

        def emailAddress = params.emailAddress
        def userInstance = User.find('from User u where (u.emailAddress = ?) and u.isActive = ?', [emailAddress, true])
        if (userInstance == null) {
            flash.error = "User doesn't not exist!"
            redirect(action: 'forgotPassword')
        } else {
            def resetToken = randomCodeGeneratorService.generateRandomCode('', 15).encodeAsMD5()
            def resetCode = randomCodeGeneratorService.generateRandomCode('code', 6)
            //def resetCode = 'aBcD123x'
            userInstance.resetToken = resetToken
            userInstance.resetCode = resetCode.encodeAsMD5()
            userInstance.isTokenUsed = false
            userInstance.resetTokenSetDate = new Date()
            userInstance.save(flush: true)
            def appSettingsInstance = AppSettings.findByNameAndIsActive('Application URL', true)
            def resetLink = appSettingsInstance.remarks + request.contextPath + "/authorise/resetPassword?key=" + resetToken
            mailService.sendMail {
                to "${userInstance.emailAddress}"
                subject "Password reset"
                body "Please click the following link to set password: ${resetLink}\n" +
                        "Enter the reset code: ${resetCode}"
            }

            loadAccessDetails(passwordChangeLogInstance, "ERP", remoteHost, ipAddress, actualIpAddress, browserName, operatingSystem, browserVersion, userAgentDetails)
            logMaintainService.savePasswordChangeLog(passwordChangeLogInstance, userInstance, false,
                    null, 'Password Forgot Request', userInstance.password, userInstance.password, userInstance.resetCode, userInstance.emailAddress)

            flash.success = "An email containing the reset instruction has been sent to your email. Please check your inbox and complete the reset process within 30 minute."
            redirect(action: 'forgotPassword')
        }
    }

    def resetPassword() {
        def resetKey = params.key
        if (resetKey) {
            def userInstance = User.findByResetToken(resetKey)
            if (userInstance.isTokenUsed) {
                flash.error = "Sorry, this token is already used."
                redirect(action: 'forgotPassword')
            } else if ((new Date().getTime() - userInstance.resetTokenSetDate.getTime()) / 1000 / 60 >= 30) {
                flash.error = "Sorry, this link is already expired."
                redirect(action: 'forgotPassword')
            }
        }
        [resetToken: resetKey]
    }

    def saveResetPassword() {
        if (params.password == '' || (params.password).length() < 6) {
            flash.error = "New password must be at least 6 character."
            redirect(action: "resetPassword")
            return
        }
        if (params.confirmPassword == '' || (params.confirmPassword).length() < 6) {
            flash.error = "Confirm password must be at least 6 character."
            redirect(action: "resetPassword")
            return
        }
        if (params.password != params.confirmPassword) {
            flash.error = "Password mismatched"
            redirect(action: "resetPassword")
            return
        }

        def userInstance = User.findByResetTokenAndResetCodeAndIsTokenUsed(params.resetToken, (params.resetCode).encodeAsMD5(), false)
        def currentPassword = userInstance.password
        if (userInstance) {
            userInstance.password = (params.password).encodeAsMD5()
            userInstance.confirmPassword = (params.password).encodeAsMD5()
            userInstance.isTokenUsed = true
            userInstance.save(flush: true)

            def passwordChangeLogInstance = new PasswordChangeLog()
            def remoteHost = request.getRemoteAddr()
            def actualIpAddress = ipAddressLocateService.getClientIpAddress(request)
            def ipAddress = request.getRemoteHost()
            def operatingSystem = userAgentIdentService.operatingSystem
            def browserName = userAgentIdentService.browser
            def browserVersion = userAgentIdentService.browserVersion
            def userAgentDetails = userAgentIdentService.getUserAgentString()

            //def sessionId = session.adaptee.session.id
            loadAccessDetails(passwordChangeLogInstance, "ERP", remoteHost, ipAddress, actualIpAddress, browserName, operatingSystem, browserVersion, userAgentDetails)
            logMaintainService.savePasswordChangeLog(passwordChangeLogInstance, userInstance, true,
                    null, 'Forgot Password Reset', currentPassword, userInstance.password, userInstance.resetCode, userInstance.emailAddress)

            flash.success = "Password changed successfully"
            redirect(action: 'login')
        }
    }

    def notAuthorised() {}

    def checkUser() {
        def accessLogInstance = AccessLog.findById(Long.valueOf(session["accessLogId"]))
        if (accessLogInstance.isTrusted) {
            flash.message = "You are already authenticated."
            redirect(action: 'home')
        }
        def redirectUrl = null
        if (params.redirectUrl) {
            redirectUrl = params.redirectUrl
        }
        [redirectUrl: redirectUrl]
    }

    def confirmUser() {
        def accessLogInstance = AccessLog.findById(Long.valueOf(session["accessLogId"]))
        if (accessLogInstance.isTrusted) {
            flash.message = "You are already authenticated."
            redirect(action: 'home')
        }
        def resetCode = params.authCode
        if (resetCode.size() != 8) {
            flash.error = "Please enter a correct authentication code."
            redirect(action: 'checkUser')
            return
        }

        if ((new Date().getTime() - accessLogInstance.authenticationCodeSetDate.getTime()) / 1000 / 60 >= 5) {
            accessLogInstance.isTrusted = false
            accessLogInstance.save(flush: true)
            session["userId"] = null
            session["emailAddress"] = null
            session["fullName"] = null
            session["accessLogId"] = null
            flash.error = "Sorry, authentication time has already expired"
            redirect(action: 'login')
            return
        }
        def authCode = resetCode.encodeAsMD5()
        if (accessLogInstance.emailAuthenticationCode == authCode) {
            accessLogInstance.isTrusted = true
            accessLogInstance.save(flush: true)
            if (params.redirectUrl) {
                redirect(url: "${params.redirectUrl}")
            } else {
                redirect(action: 'home')
            }
            return
        } else {
            accessLogInstance.isTrusted = false
            accessLogInstance.save(flush: true)
            session["userId"] = null
            session["emailAddress"] = null
            session["fullName"] = null
            session["accessLogId"] = null
            flash.error = "Sorry, wrong authentication code! Please login again."
            redirect(action: 'login')
            return
        }
    }

    def profile() {
        if (session["emailAddress"] == null) {
            redirect(action: 'login')
            return
        }
        def personInstance = Person.findByEmailAddress(session["emailAddress"])
        def employeeInstance = Employee.findByPersonId(personInstance)
        [employeeInstance: employeeInstance, personInstance: personInstance]
    }

    private def loadAccessDetails(
            def objectInstance,
            def applicationName,
            def remoteHost,
            def ipAddress,
            def actualIpAddress, def browserName, def operatingSystem, def browserVersion, def userAgentDetails) {
        objectInstance.applicationName = applicationName
        objectInstance.remoteHost = remoteHost
        objectInstance.ipAddress = ipAddress
        objectInstance.actualIpAddress = actualIpAddress
        objectInstance.browserName = browserName
        objectInstance.operatingSystem = operatingSystem
        objectInstance.browserVersion = browserVersion
        objectInstance.userAgentDetails = userAgentDetails
    }
}