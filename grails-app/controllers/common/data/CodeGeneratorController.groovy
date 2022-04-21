package common.data




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CodeGeneratorController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = CodeGenerator.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[codeGeneratorInstanceCount: CodeGenerator.countByStatus('ACTIVE')]
    }

    def show() {
        def codeGeneratorInstance = CodeGenerator.get(params.id)
        if (!codeGeneratorInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'codeGenerator.label', default: 'CodeGenerator'), params.id])
            redirect(action: "index")
            return
        }

        [codeGeneratorInstance: codeGeneratorInstance]
    }

    def create() {
        [codeGeneratorInstance: new CodeGenerator(params)]
    }

    @Transactional
    def save() {
        def codeGeneratorInstance = new CodeGenerator(params)

        populateInsertUpdatedByService.populateUserId(codeGeneratorInstance, "createdByUserId")
        if(!codeGeneratorInstance.validate()){
            render(view: "create", model: [codeGeneratorInstance: codeGeneratorInstance])
            return
        }

        codeGeneratorInstance.save(flush: true)

        logMaintainService.saveActivityLog("CodeGenerator", 'create', codeGeneratorInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'codeGenerator.label', default: 'CodeGenerator'), codeGeneratorInstance.id])
        redirect(action: "show", id: codeGeneratorInstance.id)
    }

    def edit() {
        def codeGeneratorInstance = CodeGenerator.get(params.id)
        if (!codeGeneratorInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'codeGenerator.label', default: 'CodeGenerator'), params.id])
            redirect(action: "index")
            return
        }
        [codeGeneratorInstance:codeGeneratorInstance]
    }

    @Transactional
    def update() {
        def codeGeneratorInstance = CodeGenerator.get(params.id)

        if (!codeGeneratorInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'codeGenerator.label', default: 'CodeGenerator'), params.id])
            redirect(action: "index")
            return
        }

        codeGeneratorInstance.properties = params

        populateInsertUpdatedByService.populateUserId(codeGeneratorInstance, "lastUpdatedByUserId")

        if(!codeGeneratorInstance.validate()){
            render(view: "edit", model: [codeGeneratorInstance: codeGeneratorInstance])
            return
        }

        codeGeneratorInstance.save flush:true

        logMaintainService.saveActivityLog("CodeGenerator", 'edite', codeGeneratorInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'CodeGenerator.label', default: 'CodeGenerator'), codeGeneratorInstance.id])
        redirect(action: "show", id: codeGeneratorInstance.id)
    }

    @Transactional
    def delete(CodeGenerator codeGeneratorInstance) {

    if (codeGeneratorInstance == null) {
    notFound()
    return
    }

    codeGeneratorInstance.status = 'DELETED'

    codeGeneratorInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'CodeGenerator.label', default: 'CodeGenerator'), codeGeneratorInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'codeGenerator.label', default: 'CodeGenerator'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM CodeGenerator m "

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
    def lst = CodeGenerator.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = CodeGenerator.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [codeGeneratorInstanceList: lst, codeGeneratorInstanceCount:  totalCount])
    }
}
