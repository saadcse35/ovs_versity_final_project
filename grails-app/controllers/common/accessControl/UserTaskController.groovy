package common.accessControl




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserTaskController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = UserTask.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[userTaskInstanceCount: UserTask.countByStatus('ACTIVE')]
    }

    def show() {
        def userTaskInstance = UserTask.get(params.id)
        if (!userTaskInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userTask.label', default: 'UserTask'), params.id])
            redirect(action: "index")
            return
        }

        [userTaskInstance: userTaskInstance]
    }

    def create() {
        [userTaskInstance: new UserTask(params)]
    }

    @Transactional
    def save() {
        try {
            params.activeFrom = convertDateService.convertDate(params.activeFrom)
        }
        catch (Exception ex) {
        }

        try {
            params.activeTo = convertDateService.convertDate(params.activeTo)
        }
        catch (Exception ex) {
        }
        def userTaskInstance = new UserTask(params)
        userTaskInstance.code = codeGeneratorService.generateCode('UserTask', 'USER_TASK-')
        populateInsertUpdatedByService.populateUserId(userTaskInstance, "createdByUserId")
        if(!userTaskInstance.validate()){
            render(view: "create", model: [userTaskInstance: userTaskInstance])
            return
        }

        userTaskInstance.save(flush: true)

        logMaintainService.saveActivityLog("UserTask", 'create', userTaskInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'userTask.label', default: 'UserTask'), userTaskInstance.id])
        redirect(action: "show", id: userTaskInstance.id)
    }

    def edit() {
        def userTaskInstance = UserTask.get(params.id)
        if (!userTaskInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userTask.label', default: 'UserTask'), params.id])
            redirect(action: "index")
            return
        }
        [userTaskInstance:userTaskInstance]
    }

    @Transactional
    def update() {
        def userTaskInstance = UserTask.get(params.id)

        if (!userTaskInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userTask.label', default: 'UserTask'), params.id])
            redirect(action: "index")
            return
        }
        try {
            params.activeFrom = convertDateService.convertDate(params.activeFrom)
        }
        catch (Exception ex) {
        }

        try {
            params.activeTo = convertDateService.convertDate(params.activeTo)
        }
        catch (Exception ex) {
        }
        userTaskInstance.properties = params

        populateInsertUpdatedByService.populateUserId(userTaskInstance, "lastUpdatedByUserId")

        if(!userTaskInstance.validate()){
            render(view: "edit", model: [userTaskInstance: userTaskInstance])
            return
        }

        userTaskInstance.save flush:true

        logMaintainService.saveActivityLog("UserTask", 'edite', userTaskInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'UserTask.label', default: 'UserTask'), userTaskInstance.id])
        redirect(action: "show", id: userTaskInstance.id)
    }

    @Transactional
    def delete(UserTask userTaskInstance) {

    if (userTaskInstance == null) {
    notFound()
    return
    }

    userTaskInstance.status = 'DELETED'

    userTaskInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'UserTask.label', default: 'UserTask'), userTaskInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'userTask.label', default: 'UserTask'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM UserTask m "

    def mapx = new HashMap()
    List ffff = new ArrayList()
    String isTtl

    if (params.anyText != '' && (isTtl = params.anyText.trim()).length() != 0) {
    mapx.put("anyText", "%" + isTtl.toLowerCase() + "%")
    ffff.add("(LOWER(m.code) || LOWER(m.name)  LIKE :anyText)")
    }

    if (params.code != null && params.code != '' && (isTtl = params.code.trim()).length() != 0) {
    mapx.put("code", "%" + isTtl.toLowerCase() + "%")
    ffff.add("LOWER(m.code) like :code")
    }

    if (params.name != null && params.name != '' && (isTtl = params.name.trim()).length() != 0) {
    mapx.put("name", "%" + isTtl.toLowerCase() + "%")
    ffff.add("LOWER(m.name) like :name")
    }

    mapx.put("status", 'ACTIVE')
    ffff.add("m.status = :status")

    if (ffff.size()) {
    String ddd = ffff.toString()
    ddd = ddd.substring(1, ddd.length() - 1)
    ddd = ddd.replaceAll(",", " AND ")
    mainQu += " WHERE "
    mainQu += ddd
    }
    def lst = UserTask.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = UserTask.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [userTaskInstanceList: lst, userTaskInstanceCount:  totalCount])
    }
}
