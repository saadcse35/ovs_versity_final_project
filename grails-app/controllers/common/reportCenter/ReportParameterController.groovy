package common.reportCenter




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ReportParameterController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = ReportParameter.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[reportParameterInstanceCount: ReportParameter.countByStatus('ACTIVE')]
    }

    def show() {
        def reportParameterInstance = ReportParameter.get(params.id)
        if (!reportParameterInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reportParameter.label', default: 'ReportParameter'), params.id])
            redirect(action: "index")
            return
        }

        [reportParameterInstance: reportParameterInstance]
    }

    def create() {
        [reportParameterInstance: new ReportParameter(params)]
    }

    @Transactional
    def save() {
        def reportParameterInstance = new ReportParameter(params)

        populateInsertUpdatedByService.populateUserId(reportParameterInstance, "createdByUserId")
        if(!reportParameterInstance.validate()){
            render(view: "create", model: [reportParameterInstance: reportParameterInstance])
            return
        }

        reportParameterInstance.save(flush: true)

        logMaintainService.saveActivityLog("ReportParameter", 'create', reportParameterInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'reportParameter.label', default: 'ReportParameter'), reportParameterInstance.id])
        redirect(action: "show", id: reportParameterInstance.id)
    }

    def edit() {
        def reportParameterInstance = ReportParameter.get(params.id)
        if (!reportParameterInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reportParameter.label', default: 'ReportParameter'), params.id])
            redirect(action: "index")
            return
        }
        [reportParameterInstance:reportParameterInstance]
    }

    @Transactional
    def update() {
        def reportParameterInstance = ReportParameter.get(params.id)

        if (!reportParameterInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reportParameter.label', default: 'ReportParameter'), params.id])
            redirect(action: "index")
            return
        }

        reportParameterInstance.properties = params

        populateInsertUpdatedByService.populateUserId(reportParameterInstance, "lastUpdatedByUserId")

        if(!reportParameterInstance.validate()){
            render(view: "edit", model: [reportParameterInstance: reportParameterInstance])
            return
        }

        reportParameterInstance.save flush:true

        logMaintainService.saveActivityLog("ReportParameter", 'edite', reportParameterInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'ReportParameter.label', default: 'ReportParameter'), reportParameterInstance.id])
        redirect(action: "show", id: reportParameterInstance.id)
    }

    @Transactional
    def delete(ReportParameter reportParameterInstance) {

    if (reportParameterInstance == null) {
    notFound()
    return
    }

    reportParameterInstance.status = 'DELETED'

    reportParameterInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'ReportParameter.label', default: 'ReportParameter'), reportParameterInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'reportParameter.label', default: 'ReportParameter'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM ReportParameter m "

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
    def lst = ReportParameter.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = ReportParameter.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [reportParameterInstanceList: lst, reportParameterInstanceCount:  totalCount])
    }
}
