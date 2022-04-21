package communication

class ContactMessage {
    Long id
    String code
    String senderName
    String senderEmail
    String senderPhone
    String remoteHost
    String ipAddress
    String actualIpAddress
    String message

    String status = 'ACTIVE'

    Date dateCreated
    static constraints = {
        code(nullable: false, size: 0..30)
        senderName(nullable: false, size: 0..200)
        senderEmail(nullable: false, size: 0..200)
        senderPhone(nullable: false, size: 0..30)
        message(nullable: false, size: 0..8000)
        remoteHost(nullable: true, size: 0..50)
        ipAddress(nullable: true, size: 0..50)
        actualIpAddress(nullable: true, size: 0..50)
        dateCreated(nullable: true)
    }

    static mapping = {
        version false
        table 'COM_CONTACT_MESSAGE'
        status defaultValue : "'ACTIVE'"
    }
}
