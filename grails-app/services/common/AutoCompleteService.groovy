package common

class AutoCompleteService {
    private static def dictionary = [
            'school and colleges' : 'Institute'
    ]

    def grailsApplication
    def autocompleteAction (params) {
        def domainClass = (grailsApplication.domainClasses.find{it.clazz.simpleName == dictionary.get(params.domain)}).clazz
        def results = domainClass.createCriteria().list {
            ilike params.searchField, params.term + '%'
            maxResults(Integer.parseInt(params.max,10))
            order(params.searchField, params.order)
        }
        if (results.size()< 5){
            results = domainClass.createCriteria().list {
                ilike params.searchField, "%${params.term}%"
                maxResults(Integer.parseInt(params.max,10))
                order(params.searchField, params.order)
            }
        }
        results = results.collect {	it."${params.searchField}" }.unique()
        def htmlString = ""
        if(results.size() > 0){
            results.each {
                htmlString += "<div>${it}</div>"
            }
        }
        return htmlString
    }
}
