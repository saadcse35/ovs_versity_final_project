package common.log



import grails.test.mixin.*
import spock.lang.*

@TestFor(PasswordChangeLogController)
@Mock(PasswordChangeLog)
class PasswordChangeLogControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
        controller.index()

        then:"The model is correct"
        !model.passwordChangeLogInstanceList
        model.passwordChangeLogInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
        controller.create()

        then:"The model is correctly created"
        model.passwordChangeLogInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def passwordChangeLog = new PasswordChangeLog()
        passwordChangeLog.validate()
        controller.save(passwordChangeLog)

        then:"The create view is rendered again with the correct model"
        model.passwordChangeLogInstance!= null
        view == 'create'

        when:"The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        passwordChangeLog = new PasswordChangeLog(params)

        controller.save(passwordChangeLog)

        then:"A redirect is issued to the show action"
        response.redirectedUrl == '/passwordChangeLog/show/1'
        controller.flash.message != null
        PasswordChangeLog.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
        controller.show(null)

        then:"A 404 error is returned"
        response.status == 404

        when:"A domain instance is passed to the show action"
        populateValidParams(params)
        def passwordChangeLog = new PasswordChangeLog(params)
        controller.show(passwordChangeLog)

        then:"A model is populated containing the domain instance"
        model.passwordChangeLogInstance == passwordChangeLog
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
        controller.edit(null)

        then:"A 404 error is returned"
        response.status == 404

        when:"A domain instance is passed to the edit action"
        populateValidParams(params)
        def passwordChangeLog = new PasswordChangeLog(params)
        controller.edit(passwordChangeLog)

        then:"A model is populated containing the domain instance"
        model.passwordChangeLogInstance == passwordChangeLog
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        controller.update(null)

        then:"A 404 error is returned"
        response.redirectedUrl == '/passwordChangeLog/index'
        flash.message != null


        when:"An invalid domain instance is passed to the update action"
        response.reset()
        def passwordChangeLog = new PasswordChangeLog()
        passwordChangeLog.validate()
        controller.update(passwordChangeLog)

        then:"The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.passwordChangeLogInstance == passwordChangeLog

        when:"A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        passwordChangeLog = new PasswordChangeLog(params).save(flush: true)
        controller.update(passwordChangeLog)

        then:"A redirect is issues to the show action"
        response.redirectedUrl == "/passwordChangeLog/show/$passwordChangeLog.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(null)

        then:"A 404 is returned"
        response.redirectedUrl == '/passwordChangeLog/index'
        flash.message != null

        when:"A domain instance is created"
        response.reset()
        populateValidParams(params)
        def passwordChangeLog = new PasswordChangeLog(params).save(flush: true)

        then:"It exists"
        PasswordChangeLog.count() == 1

        when:"The domain instance is passed to the delete action"
        controller.delete(passwordChangeLog)

        then:"The instance is deleted"
        PasswordChangeLog.count() == 0
        response.redirectedUrl == '/passwordChangeLog/index'
        flash.message != null
    }
}
