package common.data

import common.CodeGeneratorService
import common.ConvertDateService
import common.FileUploadService
import common.PopulateInsertUpdatedByService
import common.accessControl.AccessControlService
import common.log.LogMaintainService
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class LocationController {
    AccessControlService accessControlService
    ConvertDateService convertDateService
    FileUploadService fileUploadService
    PopulateInsertUpdatedByService populateInsertUpdatedByService
    LogMaintainService logMaintainService
    CodeGeneratorService codeGeneratorService

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Location.list(params), model: [locationInstanceCount: Location.count()]
    }

    def show() {
        def locationInstance = Location.get(params.id)
        if (!locationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'location.label', default: 'Location'), locationInstance.id])
            redirect(action: "index")
            return
        }

        [locationInstance: locationInstance]
    }

    def create() {
        [locationInstance: new Location(params)]
    }

    @Transactional
    def save() {
        try {
            params.activeFrom = ConvertDateService.convertDate(params.activeFrom);
        } catch (ex) {

        }
        try {
            params.activeTo = ConvertDateService.convertDate(params.activeTo);
        } catch (ex) {

        }

        def locationInstance = new Location()

        locationInstance.code = codeGeneratorService.generateCode('Location', 'LOCATION-')

        locationInstance.properties['code','name','locationType', 'remarks', 'isActive','activeFrom', 'activeTo'] = params

        int m = 0

        while (params["locations[" + m + "].id"] != null) {
            if (params["locations[" + m + "].new"] == 'true' && params["locations[" + m + "].deleted"] == 'true') {
                m++
                continue
            }
            if (params["locations[" + m + "].new"] == 'true' && params["locations[" + m + "].deleted"] == 'false') {
                def locationDetailInstance = new Location()
                locationDetailInstance.code = params["locations[" + m + "].code"]
                locationDetailInstance.name = params["locations[" + m + "].name"]
                locationDetailInstance.locationType = params["locations[" + m + "].locationType"]
                locationDetailInstance.isActive = params["locations[" + m + "].isActive"]
                locationDetailInstance.remarks = params["locations[" + m + "].remarks"]
                locationInstance.addToLocations(locationDetailInstance)
            }
            m++
        }

        populateInsertUpdatedByService.populateUserId(locationInstance, "createdByUserId")
        if (!locationInstance.validate()) {
            render(view: "create", model: [locationInstance: locationInstance])
            return
        }

        locationInstance.save(flush: true)

        logMaintainService.saveActivityLog('Location', 'create', locationInstance.id)

        flash.message = message(code: 'default.created.message', args: [message(code: 'location.label', default: 'Location'), locationInstance.id])
        redirect(action: "show", id: locationInstance.id)
    }

    def edit() {
        def locationInstance = Location.get(params.id)
        if (!locationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'location.label', default: 'Location'), locationInstance.id])
            redirect(action: "index")
            return
        }
        [locationInstance: locationInstance]
    }

    @Transactional
    def update() {
        def locationInstance = Location.get(params.id)

        if (!locationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'location.label', default: 'Location'), locationInstance.id])
            redirect(action: "index")
            return
        }

        try {
            params.activeFrom = ConvertDateService.convertDate(params.activeFrom)
        } catch (ex) {

        }
        try {
            params.activeTo = ConvertDateService.convertDate(params.activeTo)
        } catch (ex) {

        }

        locationInstance.properties['code','name','locationType', 'remarks', 'isActive','activeFrom', 'activeTo'] = params

        int m = 0
        while (params["locations[" + m + "].id"] != null) {
            def locationDetailInstance
            if (params["locations[" + m + "].new"] == 'true' && params["locations[" + m + "].deleted"] == 'true') {
                m++
                continue
            } else if (params["locations[" + m + "].new"] == 'false' && params["locations[" + m + "].deleted"] == 'false') {
                locationDetailInstance = Location.findById(Long.valueOf(params["locations[" + m + "].id"]))
            } else if (params["locations[" + m + "].new"] == 'false' && params["locations[" + m + "].deleted"] == 'true') {
                locationDetailInstance = Location.findById(Long.valueOf(params["locations[" + m + "].id"]))
                locationDetailInstance.status = 'DELETED'
            }
            if (params["locations[" + m + "].new"] == 'true' && params["locations[" + m + "].deleted"] == 'false') {
                locationDetailInstance =  new Location()
            }
            locationDetailInstance.code = params["locations[" + m + "].code"]
            locationDetailInstance.name = params["locations[" + m + "].name"]
            locationDetailInstance.locationType = params["locations[" + m + "].locationType"]
            locationDetailInstance.isActive = params["locations[" + m + "].isActive"]
            locationDetailInstance.remarks = params["locations[" + m + "].remarks"]
            locationInstance.addToLocations(locationDetailInstance)
            m++
        }

        populateInsertUpdatedByService.populateUserId(locationInstance, "lastUpdatedByUserId")

        if (!locationInstance.validate()) {
            render(view: "edit", model: [locationInstance: locationInstance])
            return
        }

        locationInstance.save flush: true

        logMaintainService.saveActivityLog('Location', 'edit', locationInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'Location.label', default: 'Location'), locationInstance.id])
        redirect(action: "show", id: locationInstance.id)
    }

    @Transactional
    def delete(Location locationInstance) {

        if (locationInstance == null) {
            notFound()
            return
        }

        locationInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Location.label', default: 'Location'), locationInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'location.label', default: 'Location'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def search() {
        params.max = Math.min(params.max ? params.int('max') : 50, 100)
        String mainQu = "FROM Location m "

        def mapx = new HashMap()
        List ffff = new ArrayList()
        String isTtl

        if (params.anyText != '' && (isTtl = params.anyText.trim()).length() != 0) {
            mapx.put("anyText", "%" + isTtl.toLowerCase() + "%")
            ffff.add("(LOWER(m.code)|| LOWER(m.name)|| LOWER(m.parentId)|| LOWER(m.locationType) LIKE :anyText)")
        }

        if (params.code != null && params.code != '' && (isTtl = params.code.trim()).length() != 0) {
            mapx.put("code", "%" + isTtl.toLowerCase() + "%")
            ffff.add("LOWER(m.code) like :code")
        }
        if (params.name != null && params.name != '' && (isTtl = params.name.trim()).length() != 0) {
            mapx.put("name", "%" + isTtl.toLowerCase() + "%")
            ffff.add("LOWER(m.name) like :name")
        }

        if (params.locationType != '' && (isTtl = params.locationType.trim()).length() != 0) {
            mapx.put("locationType", "%" + isTtl.toLowerCase() + "%")
            ffff.add("LOWER(m.locationType) like :locationType")
        }

        if (ffff.size()) {
            String ddd = ffff.toString()
            ddd = ddd.substring(1, ddd.length() - 1)
            ddd = ddd.replaceAll(",", " AND ")
            mainQu += " WHERE "
            mainQu += ddd
        }
        def lst = Location.executeQuery(mainQu, mapx, [max: params.max, offset: params?.offset == null ? 0 : params.offset])
        def totalCount = Location.executeQuery(mainQu, mapx).size()
        render(view: "index", model: [locationInstanceList: lst, locationInstanceCount: totalCount])
    }

    def findLocationByParentId() {
        List<Location> locations = new ArrayList<Location>();
        locations = Location.findAllByParentId(7);
        System.out.print(locations);
        return locations as JSON;
    }
}
