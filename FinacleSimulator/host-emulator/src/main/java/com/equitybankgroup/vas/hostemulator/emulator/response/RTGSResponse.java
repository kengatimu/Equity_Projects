/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.vas.hostemulator.emulator.response;

import com.equitybankgroup.vas.hostemulator.emulator.util.MiscUtil;

/**
 *
 * @author ronaldcheruiyot
 */
public class RTGSResponse {
    
    public static String getRTGSSuccessMessage(String RequestUUID, String MessageDateTime, String BankId)
    {
        String response = "<FIXML xsi:schemaLocation=\"http://www.finacle.com/fixml executeFinacleScript.xsd\" xmlns=\"http://www.finacle.com/fixml\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
"    <Header>\n" +
"        <ResponseHeader>\n" +
"            <RequestMessageKey>\n" +
"                <RequestUUID>" + RequestUUID + "</RequestUUID>\n" +
"                <ServiceRequestId>executeFinacleScript</ServiceRequestId>\n" +
"                <ServiceRequestVersion>10.2</ServiceRequestVersion>\n" +
"                <ChannelId>POL</ChannelId>\n" +
"            </RequestMessageKey>\n" +
"            <ResponseMessageInfo>\n" +
"                <BankId>" + BankId + "</BankId>\n" +
"                <TimeZone>GMT+05:30</TimeZone>\n" +
"                <MessageDateTime>" + MessageDateTime + "</MessageDateTime>\n" +
"            </ResponseMessageInfo>\n" +
"            <UBUSTransaction>\n" +
"                <Id/>\n" +
"                <Status/>\n" +
"            </UBUSTransaction>\n" +
"            <HostTransaction>\n" +
"                <Id/>\n" +
"                <Status>SUCCESS</Status>\n" +
"            </HostTransaction>\n" +
"            <HostParentTransaction>\n" +
"                <Id/>\n" +
"                <Status/>\n" +
"            </HostParentTransaction>\n" +
"            <CustomInfo/>\n" +
"        </ResponseHeader>\n" +
"    </Header>\n" +
"    <Body>\n" +
"        <executeFinacleScriptResponse>\n" +
"            <ExecuteFinacleScriptOutputVO>\n" +
" </ExecuteFinacleScriptOutputVO>\n" +
"            <executeFinacleScript_CustomData>\n" +
"                <SWIFTLISTStruct>\n" +
"                    <PymtRefNum>" + MiscUtil.generateRandomRRN(12) + "</PymtRefNum>\n" +
"                </SWIFTLISTStruct>\n" +
"            </executeFinacleScript_CustomData>\n" +
"        </executeFinacleScriptResponse>\n" +
"    </Body>\n" +
"</FIXML>";
        
        return response;
    }
    
}
