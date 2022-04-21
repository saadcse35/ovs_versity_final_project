package onlinevotingsystem




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class VoterController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = Voter.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[voterInstanceCount: Voter.countByStatus('ACTIVE')]
    }

    def show() {
        def voterInstance = Voter.get(params.id)
        if (!voterInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'voter.label', default: 'Voter'), params.id])
            redirect(action: "index")
            return
        }

        [voterInstance: voterInstance]
    }

    def create() {
        [voterInstance: new Voter(params)]
    }

    @Transactional
    def save() {
        def voterInstance = new Voter(params)

        populateInsertUpdatedByService.populateUserId(voterInstance, "createdByUserId")
        if(!voterInstance.validate()){
            render(view: "create", model: [voterInstance: voterInstance])
            return
        }

        voterInstance.save(flush: true)

        logMaintainService.saveActivityLog("Voter", 'create', voterInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'voter.label', default: 'Voter'), voterInstance.id])
        redirect(action: "show", id: voterInstance.id)
    }

    def edit() {
        def voterInstance = Voter.get(params.id)
        if (!voterInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'voter.label', default: 'Voter'), params.id])
            redirect(action: "index")
            return
        }
        [voterInstance:voterInstance]
    }

    @Transactional
    def update() {
        def voterInstance = Voter.get(params.id)

        if (!voterInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'voter.label', default: 'Voter'), params.id])
            redirect(action: "index")
            return
        }

        voterInstance.properties = params

        populateInsertUpdatedByService.populateUserId(voterInstance, "lastUpdatedByUserId")

        if(!voterInstance.validate()){
            render(view: "edit", model: [voterInstance: voterInstance])
            return
        }

        voterInstance.save flush:true

        logMaintainService.saveActivityLog("Voter", 'edite', voterInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'Voter.label', default: 'Voter'), voterInstance.id])
        redirect(action: "show", id: voterInstance.id)
    }

    @Transactional
    def delete(Voter voterInstance) {

    if (voterInstance == null) {
    notFound()
    return
    }

    voterInstance.status = 'DELETED'

    voterInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'Voter.label', default: 'Voter'), voterInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'voter.label', default: 'Voter'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM Voter m "

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
    def lst = Voter.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = Voter.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [voterInstanceList: lst, voterInstanceCount:  totalCount])
    }
}
