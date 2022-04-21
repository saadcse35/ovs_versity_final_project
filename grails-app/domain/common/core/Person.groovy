package common.core

import common.accessControl.User
import common.data.DataLookup
import common.data.Location
import common.log.AccessLog

class Person {
    Long id

    String name

    String imagePath

    String fathersName
    String mothersName
    String spouseName

    String gender
    String bloodGroup
    Date dateOfBirth

    String contactNumber
    String educationalQualification

    String emailAddress
    String permanentAddress
    String permanentPostOffice
    Location permanentCountryId
    Location permanentDivisionId
    Location permanentDistrictId
    Location permanentThanaId
    String presentAddress

    Location presentCountryId
    Location presentDivisionId
    Location presentDistrictId
    Location presentThanaId

    String  religion
    String profession
    String fathersProfession
    String mothersProfession

    String alternateContactNo
    String alternateEmail


    String guardianName
    String guardianContactNo
    String relationWithGuardian
    String guardianAddress
    Float annualIncomeOfGuardian
    Currency annualIncomeCurrencyId

    String emergencyContactName
    String emergencyContactNo
    String emergencyContactAddress


    String nationalIdNumber
    String drivingLicenceNo
    String passportNo
    String taxIdentificationNo

    Boolean isHandicapped
    Boolean isOrphan
    Boolean isGazettedWoundFreedomFighter


    String remarks
    String status = "ACTIVE"
    Boolean isActive = false
    Date activeFrom
    Date activeTo

    Date dateCreated
    Date lastUpdated
    User createdByUserId
    User lastUpdatedByUserId
    AccessLog createdBySessionId
    AccessLog lastUpdatedBySessionId

    static constraints = {
        name(unique: false, blank: false, size: 0..50)

        imagePath(nullable: true, size: 0..200)

        fathersName(nullable: true)
        fathersProfession(nullable: true, size: 0..100)
        mothersName(nullable: true)
        spouseName(nullable: true)

        dateOfBirth(blank: false)
        educationalQualification(blank: true, nullable: true)

        gender(nullable: false, inList: ["Male", "Female", "Other"])
        bloodGroup(nullable: true, size: 0..4, inList: ["A+", "A-", "AB+", "AB-", 'B+', 'B-', 'O+', 'O-'])

        contactNumber(unique: false, nullable:true, size: 0..20)
        emailAddress(blank: true, nullable: true, size: 0..100, email: true)

        permanentAddress(blank: true, nullable: true, size: 0..1000)
        permanentPostOffice(blank: true, nullable: true, size: 0..100)
        permanentCountryId(nullable: true)
        permanentDivisionId(nullable: true)
        permanentDistrictId(nullable: true)
        permanentThanaId(nullable: true)

        presentAddress(blank: true, nullable: true, size: 0..1000)

        presentCountryId(nullable: true)
        presentDivisionId(nullable: true)
        presentDistrictId(nullable: true)
        presentThanaId(nullable: true)

        religion(nullable: true, inList: ["Islam", "Hinduism","Christian","Buddhist","Others"])
        profession(nullable: true, inList: ["Farmer", "Housewife", "Business","Doctor","Engineer","Teacher","Lawyer","Govt. Employee", "Non Gov. Employee",])
        fathersProfession(nullable: true, inList: ["Farmer", "Business","Doctor","Engineer","Teacher","Lawyer","Govt. Employee", "Non Gov. Employee",])
        mothersProfession(nullable: true, inList: ["Housewife", "Business","Doctor","Engineer","Teacher","Lawyer","Govt. Employee", "Non Gov. Employee",])

        nationalIdNumber(unique: true, blank: true, nullable: true, size: 0..20)
        drivingLicenceNo(unique: true, blank: true, nullable: true, size: 0..20)
        passportNo(unique: true, blank: true, nullable: true, size: 0..20)
        taxIdentificationNo(unique: true, blank: true, nullable: true, size: 0..20)
        isOrphan(nullable: true)
        isHandicapped(nullable: true, size: 0..1)
        isGazettedWoundFreedomFighter(nullable: true, size: 0..1)

        alternateContactNo(nullable: true, size: 0..15)
        alternateEmail(nullable: true, size: 0..100)
        guardianName(nullable: true, size: 0..100)
        guardianContactNo(nullable: true, size: 0..15)
        relationWithGuardian(nullable: true, size:0..50)
        guardianAddress(nullable: true, size:0..500)
        annualIncomeOfGuardian(nullable: true)
        annualIncomeCurrencyId(nullable: true)
        emergencyContactName(nullable: true, size: 0..100)
        emergencyContactNo(nullable: true, size: 0..15)
        emergencyContactAddress(nullable: true, size: 0..1000)


        remarks(nullable: true, size: 0..1000)
        status(nullable: false, size: 0..30, inList: ["ACTIVE", "DELETED"])
        isActive(nullable: true, size: 0..1)
        activeFrom(nullable: true)
        activeTo(nullable: true)

        dateCreated(nullable: true)
        lastUpdated(nullable: true)

        createdByUserId(nullable: true)
        lastUpdatedByUserId(nullable: true)
        createdBySessionId(nullable: true)
        lastUpdatedBySessionId(nullable: true)

    }

    static mapping = {
        version false
        table 'CMN_CORE_PERSON'
        permanentCountryId column: 'DT_LOC_PRMNT_CNTRY_ID'
        permanentDivisionId column: 'DT_LOC_PRMNT_DIS_ID'
        permanentDistrictId column: 'DT_LOC_PRMNT_DIV_ID'
        permanentThanaId column: 'DT_LOC_PRMNT_THANA_ID'
        presentCountryId column: 'DT_LOC_PRSNT_CNTRY_ID'
        presentDivisionId column: 'DT_LOC_PRSNT_DIST_ID'
        presentDistrictId column: 'DT_LOC_PRSNT_DIV_ID'
        presentThanaId column: 'DT_LOC_PRSNT_THANA_ID'
        annualIncomeCurrencyId column: 'DT_ANNL_INCM_CURRENCY_ID'

        createdByUserId column: 'ACL_USER_CR_BY_ID'
        lastUpdatedByUserId column: 'ACL_USER_UP_BY_ID'
        createdBySessionId column: 'ACCESS_LOG_CR_BY_SESS_ID'
        lastUpdatedBySessionId column: 'ACCESS_LOG_UP_BY_SESS_ID'

        status defaultValue: "'ACTIVE'"

        isGazettedWoundFreedomFighter column: 'IS_GAZ_WOUND_FREEDOM_FIGHTER'
    }

    String toString() {
        return this?.name
    }

}










