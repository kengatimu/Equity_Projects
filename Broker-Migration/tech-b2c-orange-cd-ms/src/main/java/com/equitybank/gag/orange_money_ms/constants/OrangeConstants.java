/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.orange_money_ms.constants;

/**
 *
 * @author ronaldcheruiyot
 */
public class OrangeConstants {
    
    public static final String ORANGE_B2C_REQUEST_EXTERNAL_REF_NO = "soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/externalRefNo";
    
    public static final String ORANGE_B2C_REQUEST_REQUEST_ID = "soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/mmHeaderInfo/requestId";
    
    public static final String ORANGE_B2C_STATUS_REQUEST_REQUEST_ID = "soap:Envelope/soap:Body/ns2:TransferStatusInquiry/TranRequestInfo/mmHeaderInfo/requestId";

    
    /*
    KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/charge; VALUE: 0
KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/amount; VALUE: 23.65
KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer; VALUE: 
        
KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/externalRefNo; VALUE: OR2403282DU9Q8
KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest; VALUE: 
            
KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/mmHeaderInfo/requestToken; VALUE: 3c505d4e8eb27b3e8a5535848bb083a991fe9e8923643ce2c317d3c326760a3dd9f5f6adc526e9b53261da23e9207c0a3ac94689fbc6860aada93095ffa34ef5
KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/mmHeaderInfo/requestId; VALUE: OR2403282DU9Q8
KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/ccy; VALUE: EUR
KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/mmHeaderInfo/requestType; VALUE: A2W
KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/mmHeaderInfo/operatorCode; VALUE: ORANGEMONEYML
KEY: soap:Envelope; VALUE: 

KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/tranDate; VALUE: 2024-03-28
KEY: soap:Envelope/soap:Body; VALUE: 
    
KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/mmHeaderInfo; VALUE: 
                
KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/accountAlias; VALUE: BANKFR0172505992643011
KEY: soap:Envelope/soap:Body/ns2:AccountToWalletTransfer/MobileTransferRequest/mmHeaderInfo/affiliateCode; VALUE: EML
    
    
    
KEY: soap:Envelope/soap:Body/ns2:TransferStatusInquiry/TranRequestInfo/mmHeaderInfo/requestType; VALUE: TRANINQ
KEY: soap:Envelope/soap:Body/ns2:TransferStatusInquiry/TranRequestInfo/externalRefNo; VALUE: OR240328B2CY8D
KEY: soap:Envelope/soap:Body/ns2:TransferStatusInquiry/TranRequestInfo; VALUE: 
            
KEY: soap:Envelope; VALUE: 

KEY: soap:Envelope/soap:Body/ns2:TransferStatusInquiry/TranRequestInfo/mmHeaderInfo/affiliateCode; VALUE: EML
KEY: soap:Envelope/soap:Body; VALUE: 
    
KEY: soap:Envelope/soap:Body/ns2:TransferStatusInquiry/TranRequestInfo/mmHeaderInfo/requestId; VALUE: OR2403283ADW1F
KEY: soap:Envelope/soap:Body/ns2:TransferStatusInquiry; VALUE: 
        
KEY: soap:Envelope/soap:Body/ns2:TransferStatusInquiry/TranRequestInfo/mmHeaderInfo/operatorCode; VALUE: ORANGEMONEYML
KEY: soap:Envelope/soap:Body/ns2:TransferStatusInquiry/TranRequestInfo/mmHeaderInfo; VALUE: 
    
    */
    
}
