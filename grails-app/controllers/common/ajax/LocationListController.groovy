package common.ajax

import common.data.Location

class LocationListController {
    def getLocationByParent() {
        def locationInstance = Location.findById(Long.valueOf(params.value))
        def locationInstanceList = Location.executeQuery('from Location c where c.parentId = ? and c.isActive = ? order by c.name', [locationInstance, true])
        def output = ''
        if(locationInstanceList.size() > 0){
            def optionEmpty = true
            locationInstanceList.each { e ->
                if(optionEmpty){
                    optionEmpty = false
                    output += "<option value=''></option>"
                    output += "<option value='${e.id}'>${e.name}</option>"
                }
                else {
                    output += "<option value='${e.id}'>${e.name}</option>"
                }
            }
        }
        render output
    }
}
