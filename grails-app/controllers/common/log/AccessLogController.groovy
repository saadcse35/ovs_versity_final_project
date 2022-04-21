package common.log




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AccessLogController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = AccessLog.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[accessLogInstanceCount: AccessLog.countByStatus('ACTIVE')]
    }

    def show() {
        def accessLogInstance = AccessLog.get(params.id)
        if (!accessLogInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'accessLog.label', default: 'AccessLog'), params.id])
            redirect(action: "index")
            return
        }

        [accessLogInstance: accessLogInstance]
    }

    def create() {
        [accessLogInstance: new AccessLog(params)]
    }

    @Transactional
    def save() {
        def accessLogInstance = new AccessLog(params)

        populateInsertUpdatedByService.populateUserId(accessLogInstance, "createdByUserId")
        if(!accessLogInstance.validate()){
            render(view: "create", model: [accessLogInstance: accessLogInstance])
            return
        }

        accessLogInstance.save(flush: true)

        logMaintainService.saveActivityLog("AccessLog", 'create', accessLogInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'accessLog.label', default: 'AccessLog'), accessLogInstance.id])
        redirect(action: "show", id: accessLogInstance.id)
    }

    def edit() {
        def accessLogInstance = AccessLog.get(params.id)
        if (!accessLogInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'accessLog.label', default: 'AccessLog'), params.id])
            redirect(action: "index")
            return
        }
        [accessLogInstance:accessLogInstance]
    }

    @Transactional
    def update() {
        def accessLogInstance = AccessLog.get(params.id)

        if (!accessLogInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'accessLog.label', default: 'AccessLog'), params.id])
            redirect(action: "index")
            return
        }

        accessLogInstance.properties = params

        populateInsertUpdatedByService.populateUserId(accessLogInstance, "lastUpdatedByUserId")

        if(!accessLogInstance.validate()){
            render(view: "edit", model: [accessLogInstance: accessLogInstance])
            return
        }

        accessLogInstance.save flush:true

        logMaintainService.saveActivityLog("AccessLog", 'edite', accessLogInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'AccessLog.label', default: 'AccessLog'), accessLogInstance.id])
        redirect(action: "show", id: accessLogInstance.id)
    }

    @Transactional
    def delete(AccessLog accessLogInstance) {

    if (accessLogInstance == null) {
    notFound()
    return
    }

    accessLogInstance.status = 'DELETED'

    accessLogInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'AccessLog.label', default: 'AccessLog'), accessLogInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'accessLog.label', default: 'AccessLog'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM AccessLog m "

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
    def lst = AccessLog.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = AccessLog.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [accessLogInstanceList: lst, accessLogInstanceCount:  totalCount])
    }
}
