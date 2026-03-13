/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.vas.hostemulator.emulator.util;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;

/**
 *
 * @author ronaldcheruiyot
 */
public class MiscUtil {
    
    public static Map<String, String> generateMap(String input, String delim1, String delim2)
    {
        Map<String, String> output = new HashMap<>();
        
        String[] entries = input.split(delim1);
        
        for(String entry : entries)
        {
            String[] parts = entry.split(delim2);
            
            output.put(parts[0], parts[1]);
            
        }
        
        return output;
    }
    
    public static void main(String[] args) {
        String input = "99900988899:000;99900988900:114";
        Map<String, String> output = generateMap(input, ";", ":");
        
        Iterator<Map.Entry<String, String>> it = output.entrySet().iterator();
        
        while(it.hasNext())
        {   
            Map.Entry<String, String> entry = it.next();
            System.out.println("KEY: " + entry.getKey() + "; VALUE: " + entry.getValue());
        }
        
        System.out.println(generateRandomRRN(12));
    }
    
    public synchronized static String generateRandomRRN(int len) {
        

        String currentTimestamp = String.valueOf(generateRandomTimestamp());

        int remainingDigits = len - currentTimestamp.length();

        Random random = new Random();
        StringBuilder randomDigits = new StringBuilder();
        for (int i = 0; i < remainingDigits; i++) {
            int digit = random.nextInt(10); 
            randomDigits.append(digit);
        }

        String timestampWithRandom = (currentTimestamp + randomDigits.toString());
        if(timestampWithRandom.length() > len)
        {
            timestampWithRandom = timestampWithRandom.substring(0, len);
        }
        
        System.out.println("RRN GENERATED: " + timestampWithRandom);
        return timestampWithRandom;
    }
    
    public static Long generateRandomTimestamp() {
        
        long currentTime = System.currentTimeMillis();
        System.out.println("TIMESTAMP GENERATED: " + currentTime);
        return currentTime;
    }
    
    public static String extractTagValue(String document, String tagName) {
        try {
            String openTag = "<" + tagName + ">";
            String closeTag = "</" + tagName + ">";
            int firstPos = document.indexOf(openTag);
            if (firstPos >= 0) {
                int lastPos = document.indexOf(closeTag);
                if (lastPos >= 0) {
                    String result = document.substring(firstPos + openTag.length(), lastPos);
                    if((result != null) && result.trim().startsWith(openTag))
                    {   
                        String stringWithoutSpaces = result.replaceAll("\\s", "");
                        return stringWithoutSpaces.substring(openTag.length(), stringWithoutSpaces.length());
                    }
                    return result;
                }
            }
        } catch (Exception e) {
            System.out.println("Error occurred on snip document: " + e.getMessage());
            e.printStackTrace(System.out);
        }
        return null;
    }
    
    public static String getMessageDateTime()
    {
        Date today = new Date();
        String datetime = String.format("%tY-%tm-%tdT%tk:%tM:%tS.%ts", today, today, today, today, today, today, today);
        return datetime;
    }
    
}
