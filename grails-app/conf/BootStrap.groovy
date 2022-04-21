import common.accessControl.PersonUserType
import common.accessControl.User
import common.core.Person
import humanResource.employeeInformation.Employee

import java.text.SimpleDateFormat

class BootStrap {

    def init = { servletContext ->
        if (User.count() == 0) {

            def userInstance = new User()
            userInstance.code = 'USER-0001'
            userInstance.name = "Saad Ahmad"
            userInstance.emailAddress = "saad.cse35@gmail.com"
            userInstance.contactNo = "+8801755969477"
            userInstance.password = "123456".encodeAsMD5()
            userInstance.confirmPassword = "123456".encodeAsMD5()
            userInstance.defaultRole = 'Super Admin'
            userInstance.remarks = "Initial User"
            userInstance.isActive = true
            userInstance.activeFrom = new Date()
            println(userInstance.validate())
            println(userInstance.errors)
            userInstance.save(flush: true)

            def personInstance = new Person()
            personInstance.name = "Saad Ahmad"
            personInstance.gender = "Male"
            personInstance.bloodGroup = "O+"
            try {
                personInstance.dateOfBirth = (new SimpleDateFormat("dd/MM/yyyy")).parse('04/02/1993')
            } catch (Exception ex) {
            }
            personInstance.contactNumber = userInstance.contactNo
            personInstance.emailAddress = userInstance.emailAddress
            if (!personInstance.validate()) {
                personInstance.errors.each {
                    println(it)
                }
            }
            personInstance.save(flush: true)

            def personUserTypeInstance = new PersonUserType()
            personUserTypeInstance.personId = personInstance
            personUserTypeInstance.userId = userInstance
            personUserTypeInstance.userType = 'Employee'
            personUserTypeInstance.save(flush: true)

            def employeeInstance = new Employee()
            employeeInstance.personId = personInstance
            employeeInstance.employeeId = '000000'
            employeeInstance.dateOfJoining = new Date()
            employeeInstance.employeeType = 'Full Time Employee'
            employeeInstance.employeeStatus = 'Running'
            employeeInstance.salaryScaleType = 'Fixed'
            employeeInstance.save(flush: true)

        }
    }
    def destroy = {
    }
}
