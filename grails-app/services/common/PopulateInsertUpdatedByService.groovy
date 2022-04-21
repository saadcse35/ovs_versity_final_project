package common

import common.accessControl.User
import common.log.AccessLog
import org.codehaus.groovy.grails.web.util.WebUtils


class PopulateInsertUpdatedByService {
    def populateUserId(def objectInstance, def propertyInstance) {
        def session = WebUtils.retrieveGrailsWebRequest().session

        def userIdInstance = User.findByEmailAddress(session["emailAddress"])

        def accessLogId  = AccessLog.findById(Long.valueOf(session["accessLogId"]))


        if(propertyInstance == "createdByUserId"){
            objectInstance.createdByUserId = userIdInstance
            objectInstance.createdBySessionId = accessLogId
        }
        else if(propertyInstance == "lastUpdatedByUserId"){
            objectInstance.lastUpdatedByUserId = userIdInstance
            objectInstance.lastUpdatedBySessionId = accessLogId
        }
    }
}