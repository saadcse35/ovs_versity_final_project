package common

import java.text.ParseException
import java.text.SimpleDateFormat

class ConvertDateService {
    static String [] dateFormats = ["dd/MM/yyyy hh:mm a", "dd/MM/yyyy hh:mm", "dd/MM/yyyy", "dd-MM-yyyy", "d/M/yyyy","yyyy-MM-dd hh:mm:ss.S","d/M/yy","yyyy-MM-dd hh:mm:ss","yyyy-MM-dd","dd-MMM-yy", "dd-MMM-yyyy","mm/dd/yyyy hh:mm:ss"]  ;
    def static convertDate(Object inputDate) throws Exception {
        if (inputDate == null || inputDate.toString().trim().length()==0) {
            return null
        }
        for(String dateFormat: dateFormats){
            try
            {
                return (new SimpleDateFormat(dateFormat)).parse(inputDate.toString())
            }
            catch (ParseException ec) {}
        }
        throw new Exception("Date Format doesn't match. Please give a valid format")
    }
}