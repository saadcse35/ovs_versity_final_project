package common.accessControl




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = User.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[userInstanceCount: User.countByStatus('ACTIVE')]
    }

    def show() {
        def userInstance = User.get(params.id)
        if (!userInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "index")
            return
        }

        [userInstance: userInstance]
    }

    def create() {
        [userInstance: new User(params)]
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
        def userInstance = new User(params)
        userInstance.code = codeGeneratorService.generateCode('User', 'USER-')
        populateInsertUpdatedByService.populateUserId(userInstance, "createdByUserId")
        if(!userInstance.validate()){
            render(view: "create", model: [userInstance: userInstance])
            return
        }

        userInstance.save(flush: true)

        logMaintainService.saveActivityLog("User", 'create', userInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def edit() {
        def userInstance = User.get(params.id)
        if (!userInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "index")
            return
        }
        [userInstance:userInstance]
    }

    @Transactional
    def update() {
        def userInstance = User.get(params.id)

        if (!userInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
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
        userInstance.properties = params

        populateInsertUpdatedByService.populateUserId(userInstance, "lastUpdatedByUserId")

        if(!userInstance.validate()){
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        userInstance.save flush:true

        logMaintainService.saveActivityLog("User", 'edite', userInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    @Transactional
    def delete(User userInstance) {

    if (userInstance == null) {
    notFound()
    return
    }

    userInstance.status = 'DELETED'

    userInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM User m "

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
    def lst = User.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = User.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [userInstanceList: lst, userInstanceCount:  totalCount])
    }
}
