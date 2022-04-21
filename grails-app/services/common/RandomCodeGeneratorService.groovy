package common

import grails.transaction.Transactional
import org.apache.commons.lang.RandomStringUtils

@Transactional
class RandomCodeGeneratorService {

    def generateRandomCode(def codeType, def length) {
        String charset
        Integer codeLength
        if(codeType == 'code'){
            charset = (('A'..'Z') + ('0'..'9')).join()
        }
        else{
            charset = (('A'..'Z') + ('a'..'z') + ('0'..'9')).join()
        }
        length == null ? (codeLength = 6) : (codeLength = length)
        String randomString = RandomStringUtils.random(codeLength, charset.toCharArray())
        return randomString
    }
}
