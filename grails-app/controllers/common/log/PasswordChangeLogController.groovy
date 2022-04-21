package common.log




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PasswordChangeLogController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = PasswordChangeLog.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[passwordChangeLogInstanceCount: PasswordChangeLog.countByStatus('ACTIVE')]
    }

    def show() {
        def passwordChangeLogInstance = PasswordChangeLog.get(params.id)
        if (!passwordChangeLogInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'passwordChangeLog.label', default: 'PasswordChangeLog'), params.id])
            redirect(action: "index")
            return
        }

        [passwordChangeLogInstance: passwordChangeLogInstance]
    }

    def create() {
        [passwordChangeLogInstance: new PasswordChangeLog(params)]
    }

    @Transactional
    def save() {
        def passwordChangeLogInstance = new PasswordChangeLog(params)

        populateInsertUpdatedByService.populateUserId(passwordChangeLogInstance, "createdByUserId")
        if(!passwordChangeLogInstance.validate()){
            render(view: "create", model: [passwordChangeLogInstance: passwordChangeLogInstance])
            return
        }

        passwordChangeLogInstance.save(flush: true)

        logMaintainService.saveActivityLog("PasswordChangeLog", 'create', passwordChangeLogInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'passwordChangeLog.label', default: 'PasswordChangeLog'), passwordChangeLogInstance.id])
        redirect(action: "show", id: passwordChangeLogInstance.id)
    }

    def edit() {
        def passwordChangeLogInstance = PasswordChangeLog.get(params.id)
        if (!passwordChangeLogInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'passwordChangeLog.label', default: 'PasswordChangeLog'), params.id])
            redirect(action: "index")
            return
        }
        [passwordChangeLogInstance:passwordChangeLogInstance]
    }

    @Transactional
    def update() {
        def passwordChangeLogInstance = PasswordChangeLog.get(params.id)

        if (!passwordChangeLogInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'passwordChangeLog.label', default: 'PasswordChangeLog'), params.id])
            redirect(action: "index")
            return
        }

        passwordChangeLogInstance.properties = params

        populateInsertUpdatedByService.populateUserId(passwordChangeLogInstance, "lastUpdatedByUserId")

        if(!passwordChangeLogInstance.validate()){
            render(view: "edit", model: [passwordChangeLogInstance: passwordChangeLogInstance])
            return
        }

        passwordChangeLogInstance.save flush:true

        logMaintainService.saveActivityLog("PasswordChangeLog", 'edite', passwordChangeLogInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'PasswordChangeLog.label', default: 'PasswordChangeLog'), passwordChangeLogInstance.id])
        redirect(action: "show", id: passwordChangeLogInstance.id)
    }

    @Transactional
    def delete(PasswordChangeLog passwordChangeLogInstance) {

    if (passwordChangeLogInstance == null) {
    notFound()
    return
    }

    passwordChangeLogInstance.status = 'DELETED'

    passwordChangeLogInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'PasswordChangeLog.label', default: 'PasswordChangeLog'), passwordChangeLogInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'passwordChangeLog.label', default: 'PasswordChangeLog'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM PasswordChangeLog m "

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
    def lst = PasswordChangeLog.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = PasswordChangeLog.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [passwordChangeLogInstanceList: lst, passwordChangeLogInstanceCount:  totalCount])
    }
}
