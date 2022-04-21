package onlinevotingsystem




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SeatController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = Seat.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[seatInstanceCount: Seat.countByStatus('ACTIVE')]
    }

    def show() {
        def seatInstance = Seat.get(params.id)
        if (!seatInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seat.label', default: 'Seat'), params.id])
            redirect(action: "index")
            return
        }

        [seatInstance: seatInstance]
    }

    def create() {
        [seatInstance: new Seat(params)]
    }

    @Transactional
    def save() {
        def seatInstance = new Seat(params)
        seatInstance.code = codeGeneratorService.generateCode('Seat', 'SEAT-')
        populateInsertUpdatedByService.populateUserId(seatInstance, "createdByUserId")
        if(!seatInstance.validate()){
            render(view: "create", model: [seatInstance: seatInstance])
            return
        }

        seatInstance.save(flush: true)

        logMaintainService.saveActivityLog("Seat", 'create', seatInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'seat.label', default: 'Seat'), seatInstance.id])
        redirect(action: "show", id: seatInstance.id)
    }

    def edit() {
        def seatInstance = Seat.get(params.id)
        if (!seatInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seat.label', default: 'Seat'), params.id])
            redirect(action: "index")
            return
        }
        [seatInstance:seatInstance]
    }

    @Transactional
    def update() {
        def seatInstance = Seat.get(params.id)

        if (!seatInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seat.label', default: 'Seat'), params.id])
            redirect(action: "index")
            return
        }

        seatInstance.properties = params

        populateInsertUpdatedByService.populateUserId(seatInstance, "lastUpdatedByUserId")

        if(!seatInstance.validate()){
            render(view: "edit", model: [seatInstance: seatInstance])
            return
        }

        seatInstance.save flush:true

        logMaintainService.saveActivityLog("Seat", 'edite', seatInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'Seat.label', default: 'Seat'), seatInstance.id])
        redirect(action: "show", id: seatInstance.id)
    }

    @Transactional
    def delete(Seat seatInstance) {

    if (seatInstance == null) {
    notFound()
    return
    }

    seatInstance.status = 'DELETED'

    seatInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'Seat.label', default: 'Seat'), seatInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'seat.label', default: 'Seat'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM Seat m "

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
    def lst = Seat.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = Seat.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [seatInstanceList: lst, seatInstanceCount:  totalCount])
    }
}
