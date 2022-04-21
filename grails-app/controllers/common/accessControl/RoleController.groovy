package common.accessControl




import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RoleController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = Role.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[roleInstanceCount: Role.countByStatus('ACTIVE')]
    }

    def show() {
        def roleInstance = Role.get(params.id)
        if (!roleInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), params.id])
            redirect(action: "index")
            return
        }

        [roleInstance: roleInstance]
    }

    def create() {
        [roleInstance: new Role(params)]
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
        def roleInstance = new Role(params)
        roleInstance.code = codeGeneratorService.generateCode('Role', 'ROLE-')
        populateInsertUpdatedByService.populateUserId(roleInstance, "createdByUserId")
        if(!roleInstance.validate()){
            render(view: "create", model: [roleInstance: roleInstance])
            return
        }

        roleInstance.save(flush: true)

        logMaintainService.saveActivityLog("Role", 'create', roleInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'role.label', default: 'Role'), roleInstance.id])
        redirect(action: "show", id: roleInstance.id)
    }

    def edit() {
        def roleInstance = Role.get(params.id)
        if (!roleInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), params.id])
            redirect(action: "index")
            return
        }
        [roleInstance:roleInstance]
    }

    @Transactional
    def update() {
        def roleInstance = Role.get(params.id)

        if (!roleInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), params.id])
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
        roleInstance.properties = params

        populateInsertUpdatedByService.populateUserId(roleInstance, "lastUpdatedByUserId")

        if(!roleInstance.validate()){
            render(view: "edit", model: [roleInstance: roleInstance])
            return
        }

        roleInstance.save flush:true

        logMaintainService.saveActivityLog("Role", 'edite', roleInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'Role.label', default: 'Role'), roleInstance.id])
        redirect(action: "show", id: roleInstance.id)
    }

    @Transactional
    def delete(Role roleInstance) {

    if (roleInstance == null) {
    notFound()
    return
    }

    roleInstance.status = 'DELETED'

    roleInstance.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: 'Role.label', default: 'Role'), roleInstance.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM Role m "

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
    def lst = Role.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = Role.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [roleInstanceList: lst, roleInstanceCount:  totalCount])
    }
}
