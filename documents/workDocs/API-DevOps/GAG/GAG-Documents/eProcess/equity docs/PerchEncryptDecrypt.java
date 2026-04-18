package com.ecobank;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Date;

/**
 * @author gaffar
 * created on 15/09/2021 inside the package - com.ecobank
 */
public class PerchEncryptDecrypt {

    private static final String ENCRYPT_ALGO = "AES/GCM/NoPadding";
    private CryptoUtils cryptoUtils = new CryptoUtils();
    private static final int TAG_LENGTH_BIT = 128;
    private static final int IV_LENGTH_BYTE = 12;
    private static final int SALT_LENGTH_BYTE = 16;
    private static final Charset UTF_8 = StandardCharsets.UTF_8;


    private String password = "eRcNrtt=nR*42xxv$uNh?GfSyM5AvK?kcKZDa@h^8ZcWp8jLF-MkHcF_uuutH?45YE&cqk&G&QGBRbGFzZbR?dFKC6sJn2ACN&Aj&?L#f3@6fprRn-=YHBPyrPa9HH+2ZjBySRpBhEV?AR9dZ+#%aPD4W#LP!-JC?RQP%4whnbPn@gj%5_CtYp$vtBcdyP8g+sq?H5Q=nvAZUh+$qQ6Y2HN-#7fu*@%t^bbwu9F6xRUSB85zkKbqeUWm2WS8VmXD";


    public String encrypt(String text) throws Exception {
        byte[] pText = text.getBytes(UTF_8);
        byte[] salt = cryptoUtils.getSaltRandomByte(SALT_LENGTH_BYTE);
        byte[] iv = cryptoUtils.getSaltRandomByte(IV_LENGTH_BYTE);
        SecretKey aesKeyFromPassword = cryptoUtils.getAESKeyFromPassword(password.toCharArray(), salt);
        Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
        cipher.init(Cipher.ENCRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));
        byte[] cipherText = cipher.doFinal(pText);
        byte[] cipherTextWithIvSalt = ByteBuffer.allocate(iv.length + salt.length + cipherText.length)
                .put(iv)
                .put(salt)
                .put(cipherText)
                .array();
        return Base64.getEncoder().encodeToString(cipherTextWithIvSalt);
    }

    public String decrypt(String cText) throws Exception {
        byte[] decode = Base64.getDecoder().decode(cText.getBytes(UTF_8));
        ByteBuffer bb = ByteBuffer.wrap(decode);
        byte[] iv = new byte[IV_LENGTH_BYTE];
        bb.get(iv);
        byte[] salt = new byte[SALT_LENGTH_BYTE];
        bb.get(salt);
        byte[] cipherText = new byte[bb.remaining()];
        bb.get(cipherText);
        SecretKey aesKeyFromPassword = cryptoUtils.getAESKeyFromPassword(password.toCharArray(), salt);
        Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
        cipher.init(Cipher.DECRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));
        byte[] plainText = cipher.doFinal(cipherText);
        return new String(plainText, UTF_8);
    }

    public static void main(String[] args) throws Exception {
        PerchEncryptDecrypt p = new PerchEncryptDecrypt();
        System.out.println(p.encrypt("\n" +
                "{\n" +
                " \"sendCountry\": \"GH\",\n" +
                " \"deliveryMethod\": \"ACCOUNT\",\n" +
                " \"sendCcy\": \"GHS\",\n" +
                " \"destinationCountry\": \"KE\",\n" +
                " \"destinationCcy\": \"KES\",\n" +
                " \"amount\": \"800\",\n" +
                " \"amountType\": \"SENDAMT\"\n" +
                "}\n"));

        System.out.println(p.decrypt("GytWKWApXjpCNl85C0tRBDVXOSQWHUseXmJWQksF98hxR6Z7jGaE6Bm0D8h1V70y4AhC1HvEft55owU2o4DtlOtd16bo+nYaTJLI39jVeFh49SAo/63sUtx4PFvd5pzImerKhbk9lW2LCS8Cws9vJhlmyarw/QWIBRmkxJ9B+u7cNQ=="));
    }
}
