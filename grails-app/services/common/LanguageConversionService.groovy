package common


class LanguageConversionService {
    def convertToBengali(Object number) {
        def numberString = number.toString()
        def convertedString = ''
        for (int i = 0; i < numberString.length(); i++) {
            if (numberString[i] == '0') {
                convertedString += '০'
            } else if (numberString[i] == '1') {
                convertedString += '১'
            } else if (numberString[i] == '2') {
                convertedString += '২'
            } else if (numberString[i] == '3') {
                convertedString += '৩'
            } else if (numberString[i] == '4') {
                convertedString += '৪'
            } else if (numberString[i] == '5') {
                convertedString += '৫'
            } else if (numberString[i] == '6') {
                convertedString += '৬'
            } else if (numberString[i] == '7') {
                convertedString += '৭'
            } else if (numberString[i] == '8') {
                convertedString += '৮'
            } else if (numberString[i] == '9') {
                convertedString += '৯'
            } else {
                convertedString += numberString[i]
            }
        }
        return convertedString
    }
}
