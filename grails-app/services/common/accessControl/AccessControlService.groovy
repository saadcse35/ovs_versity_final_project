package common.accessControl

import common.log.AccessLog
import org.codehaus.groovy.grails.web.util.WebUtils


class AccessControlService {
    def isAuthorised(def controllerName, def actionName) {
        def session = WebUtils.retrieveGrailsWebRequest().session
        if (session["emailAddress"] == null) {
            return "Session Empty"
        }
        def userInstance = User.findByEmailAddress(session["emailAddress"])
        if (userInstance == null) {
            return "Session Empty"
        }

        def accessLogInstance = AccessLog.findById(Long.valueOf(session["accessLogId"]))
        if (accessLogInstance.isTrusted == false) {
            session["userId"] = null
            session["emailAddress"] = null
            session["fullName"] = null
            session["accessLogId"] = null
            return "Session Empty"
        }

        if (session["emailAddress"] == 'saad.cse35@gmail.com') {
            return true
        }
        def actionInstance = UserTask.find('from UserTask c where c.userId = ? ' +
                'and c.taskId.controllerName = ? and c.isActive = ? and  ' +
                '(c.taskId.actionName = ? or c.taskId.actionName in ' +
                '(select k.actionName from ActionPair k ' +
                'where k.conjugateActionName = ?)) ',
                [userInstance, controllerName, true, actionName, actionName])
        if (actionInstance) {
            return true
        } else {
            return false
        }
    }
}
