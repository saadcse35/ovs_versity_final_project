package common.log




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class NameChangeLogController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = NameChangeLog.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[nameChangeLogInstanceCount: NameChangeLog.countByStatus('ACTIVE')]
    }

    def show() {
        def nameChangeLogInstance = NameChangeLog.get(params.id)
        if (!nameChangeLogInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nameChangeLog.label', default: 'NameChangeLog'), params.id])
            redirect(action: "index")
            return
        }

        [nameChangeLogInstance: nameChangeLogInstance]
    }

    def create() {
        [nameChangeLogInstance: new NameChangeLog(params)]
    }

    @Transactional
    def save() {
        def nameChangeLogInstance = new NameChangeLog(params)

        populateInsertUpdatedByService.populateUserId(nameChangeLogInstance, "createdByUserId")
        if(!nameChangeLogInstance.validate()){
            render(view: "create", model: [nameChangeLogInstance: nameChangeLogInstance])
            return
        }

        nameChangeLogInstance.save(flush: true)

        logMaintainService.saveActivityLog("NameChangeLog", 'create', nameChangeLogInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'nameChangeLog.label', default: 'NameChangeLog'), nameChangeLogInstance.id])
        redirect(action: "show", id: nameChangeLogInstance.id)
    }

    def edit() {
        def nameChangeLogInstance = NameChangeLog.get(params.id)
        if (!nameChangeLogInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nameChangeLog.label', default: 'NameChangeLog'), params.id])
            redirect(action: "index")
            return
        }
        [nameChangeLogInstance:nameChangeLogInstance]
    }

    @Transactional
    def update() {
        def nameChangeLogInstance = NameChangeLog.get(params.id)

        if (!nameChangeLogInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nameChangeLog.label', default: 'NameChangeLog'), params.id])
            redirect(action: "index")
            return
        }

        nameChangeLogInstance.properties = params

        populateInsertUpdatedByService.populateUserId(nameChangeLogInstance, "lastUpdatedByUserId")

        if(!nameChangeLogInstance.validate()){
            render(view: "edit", model: [nameChangeLogInstance: nameChangeLogInstance])
            return
        }

        nameChangeLogInstance.save flush:true

        logMaintainService.saveActivityLog("NameChangeLog", 'edite', nameChangeLogInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'NameChangeLog.label', default: 'NameChangeLog'), nameChangeLogInstance.id])
        redirect(action: "show", id: nameChangeLogInstance.id)
    }

    @Transactional
    def delete(NameChangeLog nameChangeLogInstance) {

    if (nameChangeLogInstance == null) {
    notFound()
    return
    }

    nameChangeLogInstance.status = 'DELETED'

    nameChangeLogInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'NameChangeLog.label', default: 'NameChangeLog'), nameChangeLogInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'nameChangeLog.label', default: 'NameChangeLog'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM NameChangeLog m "

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
    def lst = NameChangeLog.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = NameChangeLog.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [nameChangeLogInstanceList: lst, nameChangeLogInstanceCount:  totalCount])
    }
}
