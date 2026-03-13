/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.telco_b2c.web.rest.controller.util;

/**
 *
 * @author ronaldcheruiyot
 */
public class MiscUtil {
    
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
        }
        return null;
    }
    
     public static boolean isNullOrEmpty(String value) {
        return ((value == null) || value.isEmpty());
    }
    
}
