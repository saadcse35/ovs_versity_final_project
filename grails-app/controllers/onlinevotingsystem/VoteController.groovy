package onlinevotingsystem




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class VoteController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = Vote.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[voteInstanceCount: Vote.countByStatus('ACTIVE')]
    }

    def show() {
        def voteInstance = Vote.get(params.id)
        if (!voteInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vote.label', default: 'Vote'), params.id])
            redirect(action: "index")
            return
        }

        [voteInstance: voteInstance]
    }

    def create() {
        [voteInstance: new Vote(params)]
    }

    @Transactional
    def save() {
        def voteInstance = new Vote(params)

        populateInsertUpdatedByService.populateUserId(voteInstance, "createdByUserId")
        if(!voteInstance.validate()){
            render(view: "create", model: [voteInstance: voteInstance])
            return
        }

        voteInstance.save(flush: true)

        logMaintainService.saveActivityLog("Vote", 'create', voteInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'vote.label', default: 'Vote'), voteInstance.id])
        redirect(action: "show", id: voteInstance.id)
    }

    def edit() {
        def voteInstance = Vote.get(params.id)
        if (!voteInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vote.label', default: 'Vote'), params.id])
            redirect(action: "index")
            return
        }
        [voteInstance:voteInstance]
    }

    @Transactional
    def update() {
        def voteInstance = Vote.get(params.id)

        if (!voteInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vote.label', default: 'Vote'), params.id])
            redirect(action: "index")
            return
        }

        voteInstance.properties = params

        populateInsertUpdatedByService.populateUserId(voteInstance, "lastUpdatedByUserId")

        if(!voteInstance.validate()){
            render(view: "edit", model: [voteInstance: voteInstance])
            return
        }

        voteInstance.save flush:true

        logMaintainService.saveActivityLog("Vote", 'edite', voteInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'Vote.label', default: 'Vote'), voteInstance.id])
        redirect(action: "show", id: voteInstance.id)
    }

    @Transactional
    def delete(Vote voteInstance) {

    if (voteInstance == null) {
    notFound()
    return
    }

    voteInstance.status = 'DELETED'

    voteInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'Vote.label', default: 'Vote'), voteInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'vote.label', default: 'Vote'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM Vote m "

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
    def lst = Vote.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = Vote.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [voteInstanceList: lst, voteInstanceCount:  totalCount])
    }
}
