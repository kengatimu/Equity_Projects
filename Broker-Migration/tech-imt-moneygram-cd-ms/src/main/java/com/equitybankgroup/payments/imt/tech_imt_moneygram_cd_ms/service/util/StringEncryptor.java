/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;


public class StringEncryptor {

    public static void main(String[] args) throws Exception {
        
        //Sample values
        String consumerKey = "3e4fd89e-39cf-454a-bc61-07317436da56";
        String consumerSecret = "d8f6ea4c-638f-454e-8d97-44e0fcb9c6ec";
        String pin = "2140";
        
//        String secretKey = java.util.Base64.getEncoder().encodeToString(generateAESKey());
        
        String secretKey = "9UUuCy/8DpqLetlfbeM7Jg==";
        
        String encConsumerKey = encrypt(consumerKey, secretKey);
        String encConsumerSecret = encrypt(consumerSecret, secretKey);
        String encPin = encrypt(pin, secretKey);
        
        System.out.println("encConsumerKey: " + encConsumerKey);
        System.out.println("encConsumerSecret: " + encConsumerSecret);
        System.out.println("encPin: " + encPin);

        String decConsumerKey = decrypt(encConsumerKey, secretKey);
        String decConsumerSecret = decrypt(encConsumerSecret, secretKey);
        String decPin = decrypt(encPin, secretKey);
        
        System.out.println("decConsumerKey: " + decConsumerKey);
        System.out.println("decConsumerSecret: " + decConsumerSecret);
        System.out.println("decPin: " + decPin);
        
        String publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkq3XbDI1s8Lu7SpUBP+bqOs/MC6PKWz6n/0UkqTiOZqKqaoZClI3BUDTrSIJsrN1Qx7ivBzsaAYfsB0CygSSWay4iyUcnMVEDrNVOJwtWvHxpyWJC5RfKBrweW9b8klFa/CfKRtkK730apy0Kxjg+7fF0tB4O3Ic9Gxuv4pFkbQIDAQAB";

    }
    
    public static byte[] generateAESKey() throws NoSuchAlgorithmException
    {
        KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");

        keyGenerator.init(128); 

        SecretKey secretKey = keyGenerator.generateKey();

        byte[] keyBytes = secretKey.getEncoded();
                
        System.out.println("Generated AES Key (Base64 Encoded): " + Base64.getEncoder().encodeToString(keyBytes));
        
        return keyBytes;

    }
    
    public static byte[] stringToBytes(String input)
    {
        return Base64.getDecoder().decode(input);
    }
    
    public static String encrypt(String input, String secretKey) throws Exception
    {
        return encrypt(input, stringToBytes(secretKey));
    }
    
    public static String decrypt(String input, String secretKey) throws Exception
    {
        return decrypt(Base64.getDecoder().decode(input), stringToBytes(secretKey));
    }

    public static String encrypt(String plainText, byte[] secretKey) throws Exception {
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey, "AES");
        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, new IvParameterSpec(new byte[16])); // Use zero IV for simplicity
        byte[] encryptedBytes = cipher.doFinal(plainText.getBytes());
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }
    public static String decrypt(byte[] cipherText, byte[] secretKey) throws Exception {
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey, "AES");
        cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, new IvParameterSpec(new byte[16])); // Use zero IV for simplicity
        return new String(cipher.doFinal(cipherText));
    }
}
