package common.accessControl

import common.CodeGeneratorService
import common.ConvertDateService
import common.FileUploadService
import common.PopulateInsertUpdatedByService
import common.log.LogMaintainService
import common.reportCenter.ReportParameter
import common.reportCenter.ReportParameterDetail
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.NO_CONTENT

@Transactional(readOnly = true)
class MenuItemController {
    AccessControlService accessControlService
    CodeGeneratorService codeGeneratorService
    ConvertDateService convertDateService
    FileUploadService fileUploadService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService


    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def c = MenuItem.createCriteria()
        def result = c.list(params) {
            eq("status", 'ACTIVE')
        }
        respond result, model: [menuItemInstanceCount: MenuItem.findAllByStatus('ACTIVE').size()]
    }

    def show() {
        def menuItemInstance = MenuItem.get(params.id)
        if (!menuItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), params.id])
            redirect(action: "index")
            return
        }

        [menuItemInstance: menuItemInstance]
    }

    def create() {
        [menuItemInstance: new MenuItem(params)]
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

        def menuItemInstance = new MenuItem()
        menuItemInstance.properties['code', 'name', 'menuType', 'parentId', 'controllerName', 'actionName', 'isActive',
                'remarks', 'activeFrom', 'activeTo', 'sortOrder'] = params
        menuItemInstance.code = codeGeneratorService.generateCode('MenuItem', 'MENU')
        menuItemInstance.controllerName == null ? menuItemInstance.controllerName = '#': menuItemInstance.controllerName
        menuItemInstance.actionName == null ? menuItemInstance.actionName = '#': menuItemInstance.actionName


        int m = 0
        while (params["menuItems[" + m + "].id"] != null) {
            if (params["menuItems[" + m + "].new"] == 'true' && params["menuItems[" + m + "].deleted"] == 'true') {
                m++
                continue
            }
            if (params["menuItems[" + m + "].new"] == 'true' && params["menuItems[" + m + "].deleted"] == 'false') {
                def menuItemChildInstance = new MenuItem()
                menuItemChildInstance.code = codeGeneratorService.generateCode('MenuItem', 'MENU')
                menuItemChildInstance.name = params["menuItems[" + m + "].name"]
                menuItemChildInstance.controllerName = params["menuItems[" + m + "].controllerName"]
                menuItemChildInstance.actionName = params["menuItems[" + m + "].actionName"]
                menuItemChildInstance.menuType = params["menuItems[" + m + "].menuType"]

                try {
                    menuItemChildInstance.sortOrder = Integer.valueOf(params["menuItems[" + m + "].sortOrder"])
                }
                catch (Exception ex){}

                menuItemChildInstance.isActive = params["menuItems[" + m + "].isActive"]

                if (menuItemChildInstance.menuType == 'Menu Item' && menuItemChildInstance.actionName == 'index') {
                    addMenuItem(menuItemChildInstance, menuItemChildInstance.controllerName)
                }
                menuItemInstance.addToMenuItems(menuItemChildInstance)
            }
            m++
        }

        int n = 0
        while (params["reportParameterDetails[" + n + "].id"] != null) {
            if (params["reportParameterDetails[" + n + "].new"] == 'true' && params["reportParameterDetails[" + n + "].deleted"] == 'true') {
                n++
                continue
            }
            if (params["reportParameterDetails[" + n + "].new"] == 'true' && params["reportParameterDetails[" + n + "].deleted"] == 'false') {
                def reportParameterDetailInstance = new ReportParameterDetail()
                reportParameterDetailInstance.code = codeGeneratorService.generateCode('ReportParameterDetail', 'REPORT-PARAM-DETAIL-')
                try{
                    reportParameterDetailInstance.reportParameterId = ReportParameter.findById(Long.valueOf(params["reportParameterDetails[" + n + "].reportParameterId"]))
                }
                catch (Exception ex){}

                try {
                    reportParameterDetailInstance.sortOrder = Integer.valueOf(params["reportParameterDetails[" + n + "].sortOrder"])
                }
                catch (Exception ex){}

                reportParameterDetailInstance.isActive = params["reportParameterDetails[" + n + "].isActive"]

                menuItemInstance.addToReportParameterDetails(reportParameterDetailInstance)
            }
            n++
        }




        populateInsertUpdatedByService.populateUserId(menuItemInstance, "createdByUserId")
        if (!menuItemInstance.validate()) {
            render(view: "create", model: [menuItemInstance: menuItemInstance])
            return
        }

        menuItemInstance.save(flush: true)

        logMaintainService.saveActivityLog('MenuItem', 'create', menuItemInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), menuItemInstance.id])
        redirect(action: "show", id: menuItemInstance.id)
    }

    def edit() {
        def menuItemInstance = MenuItem.get(params.id)
        if (!menuItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), menuItemInstance.id])
            redirect(action: "index")
            return
        }
        [menuItemInstance: menuItemInstance]
    }

    @Transactional
    def update() {
        def menuItemInstance = MenuItem.get(params.id)

        if (!menuItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), menuItemInstance.id])
            redirect(action: "index")
            return
        }

        menuItemInstance.properties['code', 'name', 'menuType', 'parentId', 'controllerName', 'actionName', 'isActive',
                'remarks', 'activeFrom', 'activeTo', 'sortOrder'] = params


        int m = 0

        while (params["menuItems[" + m + "].id"] != null) {
            def menuItemChildInstance
            if (params["menuItems[" + m + "].new"] == 'true' && params["menuItems[" + m + "].deleted"] == 'true') {
                m++
                continue
            } else if (params["menuItems[" + m + "].new"] == 'false' && params["menuItems[" + m + "].deleted"] == 'false') {
                menuItemChildInstance = MenuItem.findById(Long.valueOf(params["menuItems[" + m + "].id"]))
            } else if (params["menuItems[" + m + "].new"] == 'false' && params["menuItems[" + m + "].deleted"] == 'true') {
                menuItemChildInstance = MenuItem.findById(Long.valueOf(params["menuItems[" + m + "].id"]))
                menuItemChildInstance.status = 'DELETED'
            }
            if (params["menuItems[" + m + "].new"] == 'true' && params["menuItems[" + m + "].deleted"] == 'false') {
                menuItemChildInstance = new MenuItem()
                menuItemChildInstance.code = codeGeneratorService.generateCode('MenuItem', 'MENU')
            }

            menuItemChildInstance.name = params["menuItems[" + m + "].name"]
            menuItemChildInstance.controllerName = params["menuItems[" + m + "].controllerName"]
            menuItemChildInstance.actionName = params["menuItems[" + m + "].actionName"]

            try {
                menuItemChildInstance.sortOrder = Integer.valueOf(params["menuItems[" + m + "].sortOrder"])
            }
            catch (Exception ex){}

            menuItemChildInstance.menuType = params["menuItems[" + m + "].menuType"]
            if (menuItemChildInstance.menuType == 'Menu Item' && menuItemChildInstance.actionName == 'index') {
                addMenuItem(menuItemChildInstance, menuItemChildInstance.controllerName)
            }
            menuItemChildInstance.isActive = params["menuItems[" + m + "].isActive"]
            menuItemInstance.addToMenuItems(menuItemChildInstance)

            m++
        }

        int n = 0

        while (params["reportParameterDetails[" + n + "].id"] != null) {
            def reportParameterDetailInstance
            if (params["reportParameterDetails[" + n + "].new"] == 'true' && params["reportParameterDetails[" + n + "].deleted"] == 'true') {
                n++
                continue
            } else if (params["reportParameterDetails[" + n + "].new"] == 'false' && params["reportParameterDetails[" + n + "].deleted"] == 'false') {
                reportParameterDetailInstance = ReportParameterDetail.findById(Long.valueOf(params["reportParameterDetails[" + n + "].id"]))
            } else if (params["reportParameterDetails[" + n + "].new"] == 'false' && params["reportParameterDetails[" + n + "].deleted"] == 'true') {
                reportParameterDetailInstance = ReportParameterDetail.findById(Long.valueOf(params["reportParameterDetails[" + n + "].id"]))
                reportParameterDetailInstance.status = 'DELETED'
            }
            if (params["reportParameterDetails[" + n + "].new"] == 'true' && params["reportParameterDetails[" + n + "].deleted"] == 'false') {
                reportParameterDetailInstance = new ReportParameterDetail()
                reportParameterDetailInstance.code = codeGeneratorService.generateCode('ReportParameterDetail', 'REPORT-PARAM-DETAIL-')
            }
            try{
                reportParameterDetailInstance.reportParameterId = ReportParameter.findById(Long.valueOf(params["reportParameterDetails[" + n + "].reportParameterId"]))
            }
            catch (Exception ex){}
            try {
                reportParameterDetailInstance.sortOrder = Integer.valueOf(params["reportParameterDetails[" + n + "].sortOrder"])
            }
            catch (Exception ex){}

            reportParameterDetailInstance.isActive = params["reportParameterDetails[" + n + "].isActive"]
            menuItemInstance.addToReportParameterDetails(reportParameterDetailInstance)
            n++
        }


        populateInsertUpdatedByService.populateUserId(menuItemInstance, "lastUpdatedByUserId")

        if (!menuItemInstance.validate()) {
            render(view: "edit", model: [menuItemInstance: menuItemInstance])
            return
        }

        menuItemInstance.save flush: true

        logMaintainService.saveActivityLog('MenuItem', 'edite', menuItemInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'MenuItem.label', default: 'MenuItem'), menuItemInstance.id])
        redirect(action: "show", id: menuItemInstance.id)
    }

    @Transactional
    def delete(MenuItem menuItemInstance) {

        if (menuItemInstance == null) {
            notFound()
            return
        }

        menuItemInstance.status = 'DELETED'

        menuItemInstance.save(flush: true)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'MenuItem.label', default: 'MenuItem'), menuItemInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuItem.label', default: 'MenuItem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def search() {
        params.max = Math.min(params.max ? params.int('max') : 50, 100)
        String mainQu = "FROM MenuItem m "

        def mapx = new HashMap()
        List ffff = new ArrayList()
        String isTtl

        if (params.anyText != '' && (isTtl = params.anyText.trim()).length() != 0) {
            mapx.put("anyText", "%" + isTtl.toLowerCase() + "%")
            ffff.add("(LOWER(m.code) || LOWER(m.name) || LOWER(m.menuType) LIKE :anyText)")
        }

        if (params.code != null && params.code != '' && (isTtl = params.code.trim()).length() != 0) {
            mapx.put("code", "%" + isTtl.toLowerCase() + "%")
            ffff.add("LOWER(m.code) like :code")
        }

        if (params.name != null && params.name != '' && (isTtl = params.name.trim()).length() != 0) {
            mapx.put("name", "%" + isTtl.toLowerCase() + "%")
            ffff.add("LOWER(m.name) like :name")
        }

        if (params.menuType != '' && (isTtl = params.menuType.trim()).length() != 0) {
            mapx.put("menuType", isTtl.toLowerCase())
            ffff.add("LOWER(m.menuType) = :menuType")
        }

        if (ffff.size()) {
            String ddd = ffff.toString()
            ddd = ddd.substring(1, ddd.length() - 1)
            ddd = ddd.replaceAll(",", " AND ")
            mainQu += " WHERE "
            mainQu += ddd
        }
        def lst = MenuItem.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
        def totalCount = MenuItem.executeQuery(mainQu, mapx).size()
        render(view: "index", model: [menuItemInstanceList: lst, menuItemInstanceCount: totalCount])
    }

    def private addMenuItem(def parentMenuItemInstance, def controllerName ){
        def taskType = ['create', 'show', 'edit', 'delete']
        def taskName = ['Create New', 'Show', 'Edit', 'Delete']
        def menuItemSecondChildReadInstance
        for(def i = 0; i < taskType.size(); i++){
            if(parentMenuItemInstance.id == null || !MenuItem.findByControllerNameAndActionNameAndParentId(parentMenuItemInstance.controllerName, taskType[i], parentMenuItemInstance)){
                menuItemSecondChildReadInstance = new MenuItem()
                menuItemSecondChildReadInstance.code = codeGeneratorService.generateCode('MenuItem', 'MENU')
                menuItemSecondChildReadInstance.name = taskName[i]
                menuItemSecondChildReadInstance.controllerName = controllerName
                menuItemSecondChildReadInstance.actionName = taskType[i]
                menuItemSecondChildReadInstance.menuType = 'Task'
                menuItemSecondChildReadInstance.sortOrder = i + 1
                menuItemSecondChildReadInstance.isActive = true
                parentMenuItemInstance.addToMenuItems(menuItemSecondChildReadInstance)
            }
        }
    }
}
