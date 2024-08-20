package com.svalero.ardiyas.util;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import static com.svalero.ardiyas.util.Constants.DATE_PATTERN;

public class DateUtils {

    public static String format(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_PATTERN);
        return dateFormat.format(date);
    }

    public static Date parse(String date) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_PATTERN);
        return new Date(dateFormat.parse(date).getTime());
    }

    public static boolean validate(String date) throws ParseException {
        try {
            DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern(DATE_PATTERN);
            LocalDate.parse(date, dateFormat);
        } catch (DateTimeParseException e) {
            return false;
        }
        return true;
    }
}
