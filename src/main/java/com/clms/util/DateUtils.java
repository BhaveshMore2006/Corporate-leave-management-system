package com.clms.util;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class DateUtils {
    public static long calculateDaysBetween(java.sql.Date start, java.sql.Date end) {
        LocalDate startDate = start.toLocalDate();
        LocalDate endDate = end.toLocalDate();
        // Inclusive of start and end date
        return ChronoUnit.DAYS.between(startDate, endDate) + 1;
    }
}
