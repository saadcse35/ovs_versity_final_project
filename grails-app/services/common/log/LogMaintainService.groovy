package common.log

import common.CodeGeneratorService
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.util.WebUtils
import utility.ClassDictionary

@Transactional
class LogMaintainService {
    CodeGeneratorService codeGeneratorService
    def saveActivityLog(def domainName, def actionName, def objectId) {
        def session = WebUtils.retrieveGrailsWebRequest().session
        def accessLogInstance = AccessLog.findById(Long.valueOf(session["accessLogId"]))
        def activityLogInstance = new ActivityLog()
        activityLogInstance.accessLogId = accessLogInstance
        activityLogInstance.sessionId = accessLogInstance.sessionId
        activityLogInstance.domainName = domainName
        activityLogInstance.actionName = actionName
        activityLogInstance.description = accessLogInstance.userId.code +" (" + session["fullName"] + ") has " + actionName + "d a " + domainName
        activityLogInstance.objectId = objectId
        activityLogInstance.save(flush: true)
    }
    def savePasswordChangeLog(def objectInstance, def userInstance, def isSuccessFull,
    def sessionId, def changeType, def previousPassword, def currentPassword, def resetCode, def  emailUsed){
        objectInstance.userId = userInstance
        objectInstance.isSuccessFull = isSuccessFull
        objectInstance.sessionId = sessionId
        objectInstance.changeType = changeType
        objectInstance.previousPassword = previousPassword
        objectInstance.currentPassword = currentPassword
        objectInstance.resetCode = resetCode
        objectInstance.emailUsed = emailUsed
        objectInstance.save(flush: true)
    }

    def saveNameChangeLog(def objectInstance, def objectCode, def domainName, def propertyName, def previousValue, def currentValue, def updatedByUserId){
        def session = WebUtils.retrieveGrailsWebRequest().session
        def accessLogInstance = AccessLog.findById(Long.valueOf(session["accessLogId"]))
        def nameChangeLongInstance = new NameChangeLog()
        nameChangeLongInstance.code = codeGeneratorService.generateCode('NameChangeLog', 'NAME-CHANGE-LOG-')
        nameChangeLongInstance.domainName = domainName
        nameChangeLongInstance.objectId = objectInstance.id
        nameChangeLongInstance.objectCode = objectCode
        nameChangeLongInstance.propertyName = ClassDictionary.Dictionary(domainName)["${propertyName}"]
        nameChangeLongInstance.previousValue = previousValue
        nameChangeLongInstance.presentValue = currentValue
        nameChangeLongInstance.updatedByUserId = updatedByUserId
        nameChangeLongInstance.sessionId = accessLogInstance.sessionId
        nameChangeLongInstance.save(flush: true)
    }
}
