package onlinevotingsystem




import common.CodeGeneratorService
import common.ConvertDateService
import common.FileUploadService
import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService
import org.springframework.web.multipart.commons.CommonsMultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PartyController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService
    FileUploadService fileUploadService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = Party.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[partyInstanceCount: Party.countByStatus('ACTIVE')]
    }

    def show() {
        def partyInstance = Party.get(params.id)
        if (!partyInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Party'), params.id])
            redirect(action: "index")
            return
        }

        [partyInstance: partyInstance]
    }

    def create() {
        [partyInstance: new Party(params)]
    }

    @Transactional
    def save() {
        try {
            params.regDate = convertDateService.convertDate(params.regDate)
        }
        catch (Exception ex) {
        }

        def partyInstance = new Party(params)
        partyInstance.code = codeGeneratorService.generateCode('Party', 'PARTY-')

        def featuredImage = request.getFile('imagePath1')
        partyInstance.imagePath = fileUploadService.uploadImage(featuredImage, "${partyInstance.name}.jpg", "party_image")

        populateInsertUpdatedByService.populateUserId(partyInstance, "createdByUserId")
        if(!partyInstance.validate()){
            render(view: "create", model: [partyInstance: partyInstance])
            return
        }

        partyInstance.save(flush: true)

        logMaintainService.saveActivityLog("Party", 'create', partyInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'party.label', default: 'Party'), partyInstance.id])
        redirect(action: "show", id: partyInstance.id)
    }

    def edit() {
        def partyInstance = Party.get(params.id)
        if (!partyInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Party'), params.id])
            redirect(action: "index")
            return
        }
        [partyInstance:partyInstance]
    }

    @Transactional
    def update() {
        def partyInstance = Party.get(params.id)

        if (!partyInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Party'), params.id])
            redirect(action: "index")
            return
        }

        try {
            params.regDate = convertDateService.convertDate(params.regDate)
        }
        catch (Exception ex) {
        }

        partyInstance.properties = params

        populateInsertUpdatedByService.populateUserId(partyInstance, "lastUpdatedByUserId")

        if(!partyInstance.validate()){
            render(view: "edit", model: [partyInstance: partyInstance])
            return
        }

        partyInstance.save flush:true

        logMaintainService.saveActivityLog("Party", 'edite', partyInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'Party.label', default: 'Party'), partyInstance.id])
        redirect(action: "show", id: partyInstance.id)
    }

    @Transactional
    def delete(Party partyInstance) {

    if (partyInstance == null) {
    notFound()
    return
    }

    partyInstance.status = 'DELETED'

    partyInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'Party.label', default: 'Party'), partyInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'party.label', default: 'Party'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM Party m "

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
    def lst = Party.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = Party.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [partyInstanceList: lst, partyInstanceCount:  totalCount])
    }
}
