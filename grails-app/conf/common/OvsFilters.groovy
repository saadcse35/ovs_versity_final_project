package common

import common.accessControl.AccessControlService

class OvsFilters {
    AccessControlService accessControlService

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                def byPassControllers = ['home']
                def bypassMethods = ['login', 'authenticateUser', 'home', 'changePassword', 'saveChangedPassword', 'forgotPassword', 'generateResetCode', 'resetPassword',
                                     'saveResetPassword', 'profile', 'checkUser', 'confirmUser', 'notAuthorised',
                                     'logout']

                def controller = controllerName

                def action = actionName == null ? 'index':actionName

                if (byPassControllers.indexOf(controllerName) != -1 || bypassMethods.indexOf(action) != -1) {
                    return true
                }

                def authorizationResponse = accessControlService.isAuthorised(controller, action)
                def redirectUrl = ""
                try{
                    redirectUrl = request?.request?.request?.requestDispatcherPath?.strValue
                }catch(Exception ex){}

                if (authorizationResponse == "Session Empty") {
                    redirect(controller: 'authorise', action: 'login', params: [redirectUrl: "${redirectUrl}"])
                    return false
                } else {
                    if (!authorizationResponse) {
                        flash.message = "Sorry, you are not authorized to perform this action"
                        redirect(controller: 'authorise', action: 'notAuthorised')
                        return false
                    }
                }

            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
