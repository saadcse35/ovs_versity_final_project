package common.accessControl




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RoleTaskController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = RoleTask.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[roleTaskInstanceCount: RoleTask.countByStatus('ACTIVE')]
    }

    def show() {
        def roleTaskInstance = RoleTask.get(params.id)
        if (!roleTaskInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'roleTask.label', default: 'RoleTask'), params.id])
            redirect(action: "index")
            return
        }

        [roleTaskInstance: roleTaskInstance]
    }

    def create() {
        [roleTaskInstance: new RoleTask(params)]
    }

    @Transactional
    def save() {
        try {
            params.activeFrom = convertDateService.convertDate(params.activeFrom)
        }
        catch (Exception ex) {
        }

        try {
            params.activeTo = convertDateService.convertDate(params.activeTo)
        }
        catch (Exception ex) {
        }
        def roleTaskInstance = new RoleTask(params)
        roleTaskInstance.code = codeGeneratorService.generateCode('RoleTask', 'ROLE-')
        populateInsertUpdatedByService.populateUserId(roleTaskInstance, "createdByUserId")
        if(!roleTaskInstance.validate()){
            render(view: "create", model: [roleTaskInstance: roleTaskInstance])
            return
        }

        roleTaskInstance.save(flush: true)

        logMaintainService.saveActivityLog("RoleTask", 'create', roleTaskInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'roleTask.label', default: 'RoleTask'), roleTaskInstance.id])
        redirect(action: "show", id: roleTaskInstance.id)
    }

    def edit() {
        def roleTaskInstance = RoleTask.get(params.id)
        if (!roleTaskInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'roleTask.label', default: 'RoleTask'), params.id])
            redirect(action: "index")
            return
        }
        [roleTaskInstance:roleTaskInstance]
    }

    @Transactional
    def update() {
        def roleTaskInstance = RoleTask.get(params.id)

        if (!roleTaskInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'roleTask.label', default: 'RoleTask'), params.id])
            redirect(action: "index")
            return
        }
        try {
            params.activeFrom = convertDateService.convertDate(params.activeFrom)
        }
        catch (Exception ex) {
        }

        try {
            params.activeTo = convertDateService.convertDate(params.activeTo)
        }
        catch (Exception ex) {
        }
        roleTaskInstance.properties = params

        populateInsertUpdatedByService.populateUserId(roleTaskInstance, "lastUpdatedByUserId")

        if(!roleTaskInstance.validate()){
            render(view: "edit", model: [roleTaskInstance: roleTaskInstance])
            return
        }

        roleTaskInstance.save flush:true

        logMaintainService.saveActivityLog("RoleTask", 'edite', roleTaskInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'RoleTask.label', default: 'RoleTask'), roleTaskInstance.id])
        redirect(action: "show", id: roleTaskInstance.id)
    }

    @Transactional
    def delete(RoleTask roleTaskInstance) {

    if (roleTaskInstance == null) {
    notFound()
    return
    }

    roleTaskInstance.status = 'DELETED'

    roleTaskInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'RoleTask.label', default: 'RoleTask'), roleTaskInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'roleTask.label', default: 'RoleTask'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM RoleTask m "

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
    def lst = RoleTask.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = RoleTask.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [roleTaskInstanceList: lst, roleTaskInstanceCount:  totalCount])
    }
}
