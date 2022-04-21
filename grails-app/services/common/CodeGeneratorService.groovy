package common

import common.data.CodeGenerator
import grails.transaction.Transactional

@Transactional
class CodeGeneratorService {
    @Transactional
    def generateCode(def modelName, def prefix) {
        def codeGeneratorInstance = CodeGenerator.findByModelName(modelName)
        def nextValue = codeGeneratorInstance ? codeGeneratorInstance.nextValue : 1
        def lastDigitLength = codeGeneratorInstance ? codeGeneratorInstance.lastDigitLength : 8
        def defaultPrefix = ''
        if(prefix){
            defaultPrefix = prefix
        }
        else {
            defaultPrefix = codeGeneratorInstance ? codeGeneratorInstance.defaultPrefix : 'DATACODE-'
        }
        if(codeGeneratorInstance){
            codeGeneratorInstance.lock()
        }
        else {
            codeGeneratorInstance = new CodeGenerator()
        }
        codeGeneratorInstance.modelName = modelName
        codeGeneratorInstance.defaultPrefix = defaultPrefix
        codeGeneratorInstance.lastDigitLength = lastDigitLength
        codeGeneratorInstance.nextValue = nextValue + 1
        codeGeneratorInstance.save(flush: true)
        def code = defaultPrefix + nextValue.toString().padLeft(lastDigitLength, '0')
        return code
    }
}
