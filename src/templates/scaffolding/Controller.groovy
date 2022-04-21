<%=packageName ? "package ${packageName}\n\n" : ''%>


import common.CodeGeneratorService
import common.ConvertDateService

import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ${className}Controller {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    def amazonWebService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = ${className}.createCriteria()
        def result = c.list(params) {
            eq("status" ,'ACTIVE' )
        }
        respond result, model:[${propertyName}Count: ${className}.countByStatus('ACTIVE')]
    }

    def show() {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}){
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
            redirect(action: "index")
            return
        }

        [${propertyName}: ${propertyName}]
    }

    def create() {
        [${propertyName}: new ${className}(params)]
    }

    @Transactional
    def save() {
        def ${propertyName} = new ${className}(params)

        populateInsertUpdatedByService.populateUserId(${propertyName}, "createdByUserId")
        if(!${propertyName}.validate()){
            render(view: "create", model: [${propertyName}: ${propertyName}])
            return
        }

        ${propertyName}.save(flush: true)

        logMaintainService.saveActivityLog("${className}", 'create', ${propertyName}.id)

        flash.message = message(code: 'default.created.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
        redirect(action: "show", id: ${propertyName}.id)
    }

    def edit() {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}){
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
            redirect(action: "index")
            return
        }
        [${propertyName}:${propertyName}]
    }

    @Transactional
    def update() {
        def ${propertyName} = ${className}.get(params.id)

        if (!${propertyName}){
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
            redirect(action: "index")
            return
        }

        ${propertyName}.properties = params

        populateInsertUpdatedByService.populateUserId(${propertyName}, "lastUpdatedByUserId")

        if(!${propertyName}.validate()){
            render(view: "edit", model: [${propertyName}: ${propertyName}])
            return
        }

        ${propertyName}.save flush:true

        logMaintainService.saveActivityLog("${className}", 'edite', ${propertyName}.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: '${className}.label', default: '${className}'), ${propertyName}.id])
        redirect(action: "show", id: ${propertyName}.id)
    }

    @Transactional
    def delete(${className} ${propertyName}) {

    if (${propertyName} == null) {
    notFound()
    return
    }

    ${propertyName}.status = 'DELETED'

    ${propertyName}.save(flush:true)

    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.deleted.message', args: [message(code: '${className}.label', default: '${className}'), ${propertyName}.id])
    redirect action:"index", method:"GET"
    }
    '*'{ render status: NO_CONTENT }
    }
    }

    protected void notFound() {
    request.withFormat {
    form multipartForm {
    flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
    redirect action: "index", method: "GET"
    }
    '*'{ render status: NOT_FOUND }
    }
    }

    def search(){
    params.max = Math.min(params.max ? params.int('max') : 50, 100)
    String mainQu = "FROM ${className} m "

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
    def lst = ${className}.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
    def totalCount = ${className}.executeQuery(mainQu, mapx).size()
    render(view: "index", model: [${propertyName}List: lst, ${propertyName}Count:  totalCount])
    }
}
