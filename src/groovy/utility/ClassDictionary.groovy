package utility

class ClassDictionary {
    static def Dictionary(String className) {
        def Dictionary = [:]
        if (className == 'Course') {
            Dictionary = [code                 : 'Course Code', name: 'Course Name', programId: 'Program', departmentId: 'Department'
                          , creditHour         : 'Credit Hour', dataLookupCourseTypeId: 'Course Type', status: 'Status', remarks: 'Remarks'
                          , isActive           : 'Is Active', activeFrom: 'Active From', activeTo: 'Active To', lastUpdated: 'Last Updated'
                          , lastUpdatedByUserId: 'Last Updated By', createdBySessionId: 'Created By Session', lastUpdatedBySessionId: 'Last Updated By Session']
        }
        else if (className == 'Student') {
            Dictionary = [firstName                      : 'Full Name'
                          , imagePath                    : 'Image Path'
                          , fathersName                  : 'Father\'s Name'
                          , mothersName                  : 'Mother\'s Name'
                          , spouseName                   : 'spouse Name'
                          , gender                       : 'Gender'
                          , bloodGroup                   : 'Blood Group'
                          , dateOfBirth                  : 'Date of Birth'
                          , contactNumber                : 'Contact Number'
                          , emailAddress                 : 'Email Address'
                          , permanentAddress             : 'Permanent Address'
                          , permanentCountryId           : 'Permanent Country'
                          , permanentDivisionId          : 'Permanent Division'
                          , permanentDistrictId          : 'Permanent District'
                          , permanentThanaId             : 'Permanent Thana'
                          , presentAddress               : 'Present Address'
                          , presentCountryId             : 'Present Country'
                          , presentDivisionId            : 'Present Division'
                          , presentDistrictId            : 'Present District'
                          , presentThanaId               : 'Present Thana'
                          , dataLookupReligionId         : 'Religion'
                          , dataLookupFathersProfessionId: 'Fathers Profession'
                          , dataLookupFathersProfessionId: 'Mothers Profession'
                          , alternateContactNo           : 'Alternate Contact No'
                          , alternateEmail               : 'Alternate Email'
                          , guardianName                 : 'Guardian Name'
                          , guardianContactNo            : 'Guardian Contact No'
                          , annualIncomeOfGuardian       : 'Annual Income Of Guardian'
                          , annualIncomeCurrencyId       : 'Annual Income Currency'
                          , emergencyContactName         : 'Emergency Contact Name'
                          , emergencyContactNo           : 'Emergency Contact No'
                          , emergencyContactAddress      : 'Emergency Contact Address'
                          , nationalIdNumber             : 'National Id Number'
                          , drivingLicenceNo             : 'Driving Licence No'
                          , passportNo                   : 'Passport No'
                          , personId                     : 'Person'
                          , studentId                    : 'Student Id'
                          , admissionSemesterId          : 'Admission Semester'
                          , completionSemesterId         : 'Completion Semester'
                          , dataLookupProgramTypeId      : 'Program Type'
                          , programId                    : 'Program'
                          , campusId                     : 'Campus'
                          , courseGroupId                : 'Course Group'
                          , gradingSystemId              : 'Grading System'
                          , exemptedCourseGroupId        : 'Exempted Course Group'
                          , majorGroups                  : 'Major Groups'
                          , status                       : 'Status'
                          , convocationId                : 'Convocation'
                          , isRegisteredForConvocation   : 'Is Registered For Convocation'
                          , cbeMeetingMasterId           : 'Cbe Meeting No'
                          , remarks                      : 'Remarks'
                          , isCreditTransferredStudent   : 'Is Credit Transferred Student'
                          , isActive                     : 'Is Active'
                          , dateOfApplication            : 'Date Of Application'
                          , dateOfAdmission              : 'Date Of Admission'
                          , lastUpdated                  : 'Last Updated'
                          , lastUpdatedByUserId          : 'Last Updated By'
                          , lastUpdatedBySessionId       : 'Last Updated By Session']
        }
        else if (className == 'Semester') {
            Dictionary = [code                                : 'Semester Code'
                          , name                              : 'Semester Name'
                          , semesterLookup                    : 'Semester Lookup'
                          , year                              : 'Year'
                          , admissionStartDate                : 'Admission Start Date'
                          , admissionEndDate                  : 'Admission End Date'
                          , registrationStartDate             : 'Registration Start Date'
                          , registrationEndDate               : 'Registration End Date'
                          , firstSemesterRegistrationStartDate: 'First Semester Registration Start Date'
                          , firstSemesterRegistrationEndDate  : 'First Semester Registration End Date'
                          , classStartDate                    : 'Class Start Date'
                          , classEndDate                      : 'Class End Date'
                          , midTermStartDate                  : 'Mid Term Start Date'
                          , midTermStartDate                  : 'Mid Term Start Date'
                          , midTermEndDate                    : 'Mid Term End Date'
                          , finalExamStartDate                : 'Final Exam Start Date'
                          , finalExamEndDate                  : 'Final Exam End Date'
                          , terFillUpStartDate                : 'TER Fill Up Start Date'
                          , semesterStatus                    : 'Semester Status'
                          , startDate                         : 'Start Date'
                          , endDate                           : 'End Date'
                          , remarks                           : 'Remarks'
                          , isActive                          : 'Is Active'
                          , activeFrom                        : 'Active From'
                          , activeTo                          : 'Active To'
                          , lastUpdated                       : 'Last Updated At'
                          , lastUpdatedByUserId               : 'Last Updated By'
                          , lastUpdatedBySessionId            : 'Last Updated By SessionId']
        }
        else if (className == "CourseGroup") {
            Dictionary = [parentId                : "Parent Group"
                          , code                  : "Group Code"
                          , name                  : "Group Name"
                          , programId             : "Program"
                          , numberOfChildGroups   : "Number Of Child Groups"
                          , numberOfIncludedCours : "Number Of Included Course"
                          , numberOfRequiredGroup : "Number Of Required Group"
                          , numberOfRequiredCours : "Number Of Required Course"
                          , requiredCredit        : "Required Credit"
                          , retakeGpaLimit        : "Retake Gpa Limit"
                          , isMajor               : "Is Major"
                          , remarks               : "Remarks"
                          , status                : "Status"
                          , isActive              : "Is Active"
                          , activeFrom            : "Active From"
                          , activeTo              : "Active To"
                          , dateCreated           : "Date Created"
                          , lastUpdated           : "Last Updated"
                          , createdByUserId       : "Created By UserId"
                          , lastUpdatedByUserId   : "Last Updated By"
                          , createdBySessionId    : "Created By Session"
                          , lastUpdatedBySessionId: "Last Updated By Session"]
        }
        else if (className == "Employee") {
            Dictionary = [firstName                      : 'Full Name'
                          , imagePath                    : 'Image Path'
                          , fathersName                  : 'Father\'s Name'
                          , mothersName                  : 'Mother\'s Name'
                          , spouseName                   : 'spouse Name'
                          , gender                       : 'Gender'
                          , bloodGroup                   : 'Blood Group'
                          , dateOfBirth                  : 'Date of Birth'
                          , contactNumber                : 'Contact Number'
                          , emailAddress                 : 'Email Address'
                          , permanentAddress             : 'Permanent Address'
                          , permanentCountryId           : 'Permanent Country'
                          , permanentDivisionId          : 'Permanent Division'
                          , permanentDistrictId          : 'Permanent District'
                          , permanentThanaId             : 'Permanent Thana'
                          , presentAddress               : 'Present Address'
                          , presentCountryId             : 'Present Country'
                          , presentDivisionId            : 'Present Division'
                          , presentDistrictId            : 'Present District'
                          , presentThanaId               : 'Present Thana'
                          , dataLookupReligionId         : 'Religion'
                          , dataLookupFathersProfessionId: 'Fathers Profession'
                          , dataLookupFathersProfessionId: 'Mothers Profession'
                          , alternateContactNo           : 'Alternate Contact No'
                          , alternateEmail               : 'Alternate Email'
                          , guardianName                 : 'Guardian Name'
                          , guardianContactNo            : 'Guardian Contact No'
                          , annualIncomeOfGuardian       : 'Annual Income Of Guardian'
                          , annualIncomeCurrencyId       : 'Annual Income Currency'
                          , emergencyContactName         : 'Emergency Contact Name'
                          , emergencyContactNo           : 'Emergency Contact No'
                          , emergencyContactAddress      : 'Emergency Contact Address'
                          , nationalIdNumber             : 'National Id Number'
                          , drivingLicenceNo             : 'Driving Licence No'
                          , passportNo                   : 'Passport No'
                          , personId                     : 'Person'
                          , employeeId                   : 'Employee Id'
                          , dateOfJoining                : 'Date Of Joining'
                          , employeeType                 : 'Employee Type'
                          , employeeStatus               : 'Employee Status'
                          , dateOfTermination            : 'Date Of Termination'
                          , salaryScaleType              : 'Salary Scale Type'
                          , salaryAmount                 : 'Salary Amount']
        }
        return Dictionary
    }

    static
    def allowedBrowsers = ['Chrome', 'Firefox', 'Internet Explorer', 'Microsoft Edge', 'Opera', 'Safari', 'Vivaldi']

    /*static def allowedBrowsers = ['Chrome','Firefox','Internet Explorer','Microsoft Edge','Safari','Vivaldi']*/

    static def allowedOss = ['Windows', 'Android', 'Linux', 'Mac OS X', 'Symbian OS', 'Tizen', 'Ubuntu', 'iOS']

    /*static def allowedOss = ['Android', 'Linux', 'Mac OS X', 'Symbian OS', 'Tizen', 'Ubuntu',  'iOS']*/

}
