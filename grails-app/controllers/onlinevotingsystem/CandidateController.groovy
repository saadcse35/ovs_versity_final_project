package onlinevotingsystem




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CandidateController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = Candidate.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[candidateInstanceCount: Candidate.countByStatus('ACTIVE')]
    }

    def show() {
        def candidateInstance = Candidate.get(params.id)
        if (!candidateInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])
            redirect(action: "index")
            return
        }

        [candidateInstance: candidateInstance]
    }

    def create() {
        [candidateInstance: new Candidate(params)]
    }

    @Transactional
    def save() {
        def candidateInstance = new Candidate(params)

        populateInsertUpdatedByService.populateUserId(candidateInstance, "createdByUserId")
        if(!candidateInstance.validate()){
            render(view: "create", model: [candidateInstance: candidateInstance])
            return
        }

        candidateInstance.save(flush: true)

        logMaintainService.saveActivityLog("Candidate", 'create', candidateInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'candidate.label', default: 'Candidate'), candidateInstance.id])
        redirect(action: "show", id: candidateInstance.id)
    }

    def edit() {
        def candidateInstance = Candidate.get(params.id)
        if (!candidateInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])
            redirect(action: "index")
            return
        }
        [candidateInstance:candidateInstance]
    }

    @Transactional
    def update() {
        def candidateInstance = Candidate.get(params.id)

        if (!candidateInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])
            redirect(action: "index")
            return
        }

        candidateInstance.properties = params

        populateInsertUpdatedByService.populateUserId(candidateInstance, "lastUpdatedByUserId")

        if(!candidateInstance.validate()){
            render(view: "edit", model: [candidateInstance: candidateInstance])
            return
        }

        candidateInstance.save flush:true

        logMaintainService.saveActivityLog("Candidate", 'edite', candidateInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'Candidate.label', default: 'Candidate'), candidateInstance.id])
        redirect(action: "show", id: candidateInstance.id)
    }

    @Transactional
    def delete(Candidate candidateInstance) {

    if (candidateInstance == null) {
    notFound()
    return
    }

    candidateInstance.status = 'DELETED'

    candidateInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'Candidate.label', default: 'Candidate'), candidateInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }


    def info(){

    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM Candidate m "

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
    def lst = Candidate.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = Candidate.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [candidateInstanceList: lst, candidateInstanceCount:  totalCount])
    }
}
