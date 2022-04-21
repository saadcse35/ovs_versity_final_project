package common.log




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ActivityLogController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = ActivityLog.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[activityLogInstanceCount: ActivityLog.countByStatus('ACTIVE')]
    }

    def show() {
        def activityLogInstance = ActivityLog.get(params.id)
        if (!activityLogInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'activityLog.label', default: 'ActivityLog'), params.id])
            redirect(action: "index")
            return
        }

        [activityLogInstance: activityLogInstance]
    }

    def create() {
        [activityLogInstance: new ActivityLog(params)]
    }

    @Transactional
    def save() {
        def activityLogInstance = new ActivityLog(params)

        populateInsertUpdatedByService.populateUserId(activityLogInstance, "createdByUserId")
        if(!activityLogInstance.validate()){
            render(view: "create", model: [activityLogInstance: activityLogInstance])
            return
        }

        activityLogInstance.save(flush: true)

        logMaintainService.saveActivityLog("ActivityLog", 'create', activityLogInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'activityLog.label', default: 'ActivityLog'), activityLogInstance.id])
        redirect(action: "show", id: activityLogInstance.id)
    }

    def edit() {
        def activityLogInstance = ActivityLog.get(params.id)
        if (!activityLogInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'activityLog.label', default: 'ActivityLog'), params.id])
            redirect(action: "index")
            return
        }
        [activityLogInstance:activityLogInstance]
    }

    @Transactional
    def update() {
        def activityLogInstance = ActivityLog.get(params.id)

        if (!activityLogInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'activityLog.label', default: 'ActivityLog'), params.id])
            redirect(action: "index")
            return
        }

        activityLogInstance.properties = params

        populateInsertUpdatedByService.populateUserId(activityLogInstance, "lastUpdatedByUserId")

        if(!activityLogInstance.validate()){
            render(view: "edit", model: [activityLogInstance: activityLogInstance])
            return
        }

        activityLogInstance.save flush:true

        logMaintainService.saveActivityLog("ActivityLog", 'edite', activityLogInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'ActivityLog.label', default: 'ActivityLog'), activityLogInstance.id])
        redirect(action: "show", id: activityLogInstance.id)
    }

    @Transactional
    def delete(ActivityLog activityLogInstance) {

    if (activityLogInstance == null) {
    notFound()
    return
    }

    activityLogInstance.status = 'DELETED'

    activityLogInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'ActivityLog.label', default: 'ActivityLog'), activityLogInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'activityLog.label', default: 'ActivityLog'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM ActivityLog m "

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
    def lst = ActivityLog.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = ActivityLog.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [activityLogInstanceList: lst, activityLogInstanceCount:  totalCount])
    }
}
