package common.data




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class DataLookupController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = DataLookup.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[dataLookupInstanceCount: DataLookup.countByStatus('ACTIVE')]
    }

    def show() {
        def dataLookupInstance = DataLookup.get(params.id)
        if (!dataLookupInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataLookup.label', default: 'DataLookup'), params.id])
            redirect(action: "index")
            return
        }

        [dataLookupInstance: dataLookupInstance]
    }

    def create() {
        [dataLookupInstance: new DataLookup(params)]
    }

    @Transactional
    def save() {
        def dataLookupInstance = new DataLookup(params)

        populateInsertUpdatedByService.populateUserId(dataLookupInstance, "createdByUserId")
        if(!dataLookupInstance.validate()){
            render(view: "create", model: [dataLookupInstance: dataLookupInstance])
            return
        }

        dataLookupInstance.save(flush: true)

        logMaintainService.saveActivityLog("DataLookup", 'create', dataLookupInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'dataLookup.label', default: 'DataLookup'), dataLookupInstance.id])
        redirect(action: "show", id: dataLookupInstance.id)
    }

    def edit() {
        def dataLookupInstance = DataLookup.get(params.id)
        if (!dataLookupInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataLookup.label', default: 'DataLookup'), params.id])
            redirect(action: "index")
            return
        }
        [dataLookupInstance:dataLookupInstance]
    }

    @Transactional
    def update() {
        def dataLookupInstance = DataLookup.get(params.id)

        if (!dataLookupInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataLookup.label', default: 'DataLookup'), params.id])
            redirect(action: "index")
            return
        }

        dataLookupInstance.properties = params

        populateInsertUpdatedByService.populateUserId(dataLookupInstance, "lastUpdatedByUserId")

        if(!dataLookupInstance.validate()){
            render(view: "edit", model: [dataLookupInstance: dataLookupInstance])
            return
        }

        dataLookupInstance.save flush:true

        logMaintainService.saveActivityLog("DataLookup", 'edite', dataLookupInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'DataLookup.label', default: 'DataLookup'), dataLookupInstance.id])
        redirect(action: "show", id: dataLookupInstance.id)
    }

    @Transactional
    def delete(DataLookup dataLookupInstance) {

    if (dataLookupInstance == null) {
    notFound()
    return
    }

    dataLookupInstance.status = 'DELETED'

    dataLookupInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'DataLookup.label', default: 'DataLookup'), dataLookupInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataLookup.label', default: 'DataLookup'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM DataLookup m "

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
    def lst = DataLookup.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = DataLookup.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [dataLookupInstanceList: lst, dataLookupInstanceCount:  totalCount])
    }
}
