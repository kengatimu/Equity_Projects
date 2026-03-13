/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;
import lombok.extern.slf4j.Slf4j;

/**
 *
 * @author ronaldcheruiyot
 */
@Slf4j
public class DateUtil {
    
    private static final String DATE_FORMAT_STRING = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'";
    private static final DateFormat DATE_FORMAT = new SimpleDateFormat(DATE_FORMAT_STRING);
    private static final String DATE_FORMAT_STRING_3 = "yyyyMMddHHmmss";
    private static final DateFormat DATE_FORMAT_3 = new SimpleDateFormat(DATE_FORMAT_STRING_3);
    
    public static Date getDateStringWithoutTimeZone() {
        Calendar c = Calendar.getInstance();
        Date date = c.getTime();
        return date;
    }
    
    public static long calculateTimeDifference(Date startDate, Date endDate) {
        long diffInMillis = endDate.getTime() - startDate.getTime();
        return diffInMillis;
    }
    
    public static String getCurrentTimeStamp() {
        Calendar c = Calendar.getInstance();
        Date date = c.getTime();
        String currentTimeStamp = DATE_FORMAT.format(date);
        return currentTimeStamp;
    }

    public static String getFutureTimeStamp(Integer offset) {
        Calendar c = Calendar.getInstance();
        c.add(Calendar.MILLISECOND, offset);
        Date date = c.getTime();
        String futureTimeStamp = DATE_FORMAT.format(date);
        return futureTimeStamp;
    }

    public static boolean checkNotExpired(String expiryTimeStamp) throws ParseException {
        log.debug("Expiry timestamp: " + expiryTimeStamp);
        Calendar c = Calendar.getInstance();
        Date currentTime = c.getTime();
        log.debug("Current timestamp: " + currentTime);
        Date expiryTime = DATE_FORMAT.parse(expiryTimeStamp);
        return currentTime.after(expiryTime);
    }
    
    public static boolean checkifDateExpired(Date expiryTimeStamp) {
        log.debug("Expiry timestamp: " + expiryTimeStamp);

        // Convert the expiry timestamp to LocalDate
        LocalDate expiryDate = expiryTimeStamp.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

        // Get the current date as LocalDate
        LocalDate currentDate = LocalDate.now();

        log.debug("Expiry date: " + expiryDate);
        log.debug("Current date: " + currentDate);

        // Check if the current date is after the expiry date
        return currentDate.isAfter(expiryDate);
    }

    public static Date getCurrentTime() {
        Calendar c = Calendar.getInstance();
        Date date = c.getTime();
        return date;
    }

    public static Long getDuration(Instant start) {
        try {
            Instant end = Instant.now();
            Duration timeElapsed = Duration.between(start, end);
            timeElapsed.toMillis();
            return timeElapsed.toMillis();
        } catch (Exception e) {
            log.error("Error occured while getting duration passed");
            return null;
        }
    }
    
    public static String getDate3String() {
        Calendar c = Calendar.getInstance();
        Date date = c.getTime();
        DATE_FORMAT_3.setTimeZone(TimeZone.getTimeZone("GMT+3"));
        return DATE_FORMAT_3.format(date);
    }
    
    public static String getDate3String(Date date) {
        DATE_FORMAT_3.setTimeZone(TimeZone.getTimeZone("GMT+3"));
        return DATE_FORMAT_3.format(date);
    }
    
    public static String getDateStringWithoutTimeZone(Date date) {
        DateFormat DATE_FORMAT_INF = new SimpleDateFormat(DATE_FORMAT_STRING);
        return DATE_FORMAT_INF.format(date);
    }
    
    public static Date getDate(String dateStr) throws ParseException
    {
        return DATE_FORMAT.parse(dateStr);
    }
    
    public static Date[] getPreviousDates(int days, String timezoneStr)
    {   
        ZoneId eastAfricaTime = ZoneId.systemDefault();
        if((timezoneStr != null) && !timezoneStr.isEmpty())
        {
            eastAfricaTime = ZoneId.of(timezoneStr);
        }
        

        LocalDate yesterday = LocalDate.now().minusDays(days);
        LocalDateTime yesterdayMidnight = yesterday.atTime(LocalTime.MIDNIGHT);
        ZonedDateTime yesterdaystartEAT = ZonedDateTime.of(yesterdayMidnight, eastAfricaTime);
        Date startDate = Date.from(yesterdaystartEAT.toInstant());
        System.out.println(days + " day(s) ago date at 12:00 AM: " + startDate);

        LocalDateTime yesterdayEndOfDay = yesterday.atTime(23, 59, 59);
        ZonedDateTime yesterdayEndEAT = ZonedDateTime.of(yesterdayEndOfDay, eastAfricaTime);
        Date endDate = Date.from(yesterdayEndEAT.toInstant());
        System.out.println(days + " day(s) ago date at 11:59 PM: " + endDate);
        
        return new Date[]{startDate, endDate};
    }
    
    public static Date[] getPreviousDatesToToday(int days)
    {   
        LocalDate currentDate = LocalDate.now();
        
        // Calculate the start date (10 days ago)
        LocalDate startDate = currentDate.minusDays(days);
        
        Date startDateAsDate = java.sql.Date.valueOf(startDate);
        
        Date endDateAsDate = java.sql.Date.valueOf(currentDate);
        
        return new Date[]{startDateAsDate, endDateAsDate};
    }
    
    
}
