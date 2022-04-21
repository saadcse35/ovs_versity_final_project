package onlinevotingsystem




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ElectionController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = Election.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[electionInstanceCount: Election.countByStatus('ACTIVE')]
    }

    def show() {
        def electionInstance = Election.get(params.id)
        if (!electionInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'election.label', default: 'Election'), params.id])
            redirect(action: "index")
            return
        }

        [electionInstance: electionInstance]
    }

    def create() {
        [electionInstance: new Election(params)]
    }

    @Transactional
    def save() {
        try {
            params.startDate = convertDateService.convertDate(params.startDate)
        }
        catch (Exception ex) {
        }

        try {
            params.endDate = convertDateService.convertDate(params.endDate)
        }
        catch (Exception ex) {
        }

        def electionInstance = new Election(params)
        electionInstance.code = codeGeneratorService.generateCode('Election', 'ELECTION-')

        populateInsertUpdatedByService.populateUserId(electionInstance, "createdByUserId")
        if(!electionInstance.validate()){
            render(view: "create", model: [electionInstance: electionInstance])
            return
        }

        electionInstance.save(flush: true)

        logMaintainService.saveActivityLog("Election", 'create', electionInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'election.label', default: 'Election'), electionInstance.id])
        redirect(action: "show", id: electionInstance.id)
    }

    def edit() {
        def electionInstance = Election.get(params.id)
        if (!electionInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'election.label', default: 'Election'), params.id])
            redirect(action: "index")
            return
        }
        [electionInstance:electionInstance]
    }

    @Transactional
    def update() {
        def electionInstance = Election.get(params.id)

        if (!electionInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'election.label', default: 'Election'), params.id])
            redirect(action: "index")
            return
        }

        try {
            params.startDate = convertDateService.convertDate(params.startDate)
        }
        catch (Exception ex) {
        }

        try {
            params.endDate = convertDateService.convertDate(params.endDate)
        }
        catch (Exception ex) {
        }

        electionInstance.properties = params

        populateInsertUpdatedByService.populateUserId(electionInstance, "lastUpdatedByUserId")

        if(!electionInstance.validate()){
            render(view: "edit", model: [electionInstance: electionInstance])
            return
        }

        electionInstance.save flush:true

        logMaintainService.saveActivityLog("Election", 'edite', electionInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'Election.label', default: 'Election'), electionInstance.id])
        redirect(action: "show", id: electionInstance.id)
    }

    @Transactional
    def delete(Election electionInstance) {

    if (electionInstance == null) {
    notFound()
    return
    }

    electionInstance.status = 'DELETED'

    electionInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'Election.label', default: 'Election'), electionInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'election.label', default: 'Election'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM Election m "

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
    def lst = Election.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = Election.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [electionInstanceList: lst, electionInstanceCount:  totalCount])
    }
}
