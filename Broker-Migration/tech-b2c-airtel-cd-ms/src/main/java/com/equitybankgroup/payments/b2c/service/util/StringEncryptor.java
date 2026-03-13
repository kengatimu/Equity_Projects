/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.util;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import org.jasypt.util.text.BasicTextEncryptor;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;

/**
 *
 * @author ronaldcheruiyot
 */
public class StringEncryptor {
    
    public static String jasyptDecrypt(ApplicationContext applicationContext, String encryptedValue)
    {
        Environment env = applicationContext.getEnvironment();
        
        BasicTextEncryptor textEncryptor = new BasicTextEncryptor();
        textEncryptor.setPassword(env.getProperty("JASYPT_ENCRYPTOR_PASSWORD"));

        String decryptedValue = textEncryptor.decrypt(encryptedValue);
        
        System.out.println("Encrypted Value: " + encryptedValue);
        
        return decryptedValue;
    }
    
    public static String encrypt(String input, String key) throws UnsupportedEncodingException, Exception
    {
        return bytesToBase64(encryptAESGCM(base64ToBytes(key), input.getBytes("UTF-8")));
    }
    
    public static String decrypt(String input, String key) throws UnsupportedEncodingException, Exception
    {
        return new String(decryptAESGCM(base64ToBytes(key), base64ToBytes(input)));
    }

    public static String bytesToBase64(byte[] input) {
        return java.util.Base64.getEncoder().encodeToString(input);
    }

    public static byte[] base64ToBytes(String input) {
        return java.util.Base64.getDecoder().decode(input);
    }

    public static byte[] generateAESKey() throws NoSuchAlgorithmException {
        KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");

        keyGenerator.init(256);

        SecretKey secretKey = keyGenerator.generateKey();

        byte[] keyBytes = secretKey.getEncoded();

        System.out.println("Generated AES Key (Base64 Encoded): " + java.util.Base64.getEncoder().encodeToString(keyBytes));

        return keyBytes;

    }

    public static byte[] encryptAESGCM(byte[] key, byte[] plaintext) throws Exception {
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        SecretKey secretKey = new SecretKeySpec(key, "AES");
        GCMParameterSpec gcmParameterSpec = new GCMParameterSpec(128, new byte[16]);
        cipher.init(Cipher.ENCRYPT_MODE, secretKey, gcmParameterSpec);
        cipher.updateAAD(new byte[0]);
        byte[] ciphertext = cipher.doFinal(plaintext);
        return ciphertext;
    }

    public static byte[] decryptAESGCM(byte[] key, byte[] ciphertext) throws Exception {
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        SecretKey secretKey = new SecretKeySpec(key, "AES");
        GCMParameterSpec gcmParameterSpec = new GCMParameterSpec(128, new byte[16]);
        cipher.init(Cipher.DECRYPT_MODE, secretKey, gcmParameterSpec);
        cipher.updateAAD(new byte[0]);
        byte[] plaintext = cipher.doFinal(ciphertext);
        return plaintext;
    }

}
