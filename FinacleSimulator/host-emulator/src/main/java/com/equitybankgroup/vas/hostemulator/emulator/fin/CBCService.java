/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.vas.hostemulator.emulator.fin;

import com.equitybankgroup.vas.hostemulator.emulator.util.MiscUtil;
import java.util.Map;
import javax.annotation.PostConstruct;
import org.jpos.iso.ISOMsg;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

/**
 *
 * @author ronaldcheruiyot
 */
@Service
public class CBCService {
    
    @Value("${cbc.mock.scenarios}")
    private String cbcMockScenarios;
    
    private Map<String, String> mappedResponse;
    
    @PostConstruct
    public void init()
    {
        mappedResponse = MiscUtil.generateMap(cbcMockScenarios, ";", ":");
 
    } 
    
    public ISOMsg get1200ResponseCode(ISOMsg isoMsg)
    {
        String f102 = isoMsg.getString(102) != null ? isoMsg.getString(102) : "000";
        String f127 = MiscUtil.generateRandomRRN(6);
        String f125 = "ELIPHAS GITAARI KAMUNDI/21722515/000000/SBA/ /A/KES";
        isoMsg.set(39, "000");
        isoMsg.set(102, f102);
        isoMsg.set(127, f127);
        isoMsg.set(125, f125);
        
        return isoMsg;
    }
    
    public ISOMsg get1210BalanceResponse(ISOMsg isoMsg)
    {
        String f102 = isoMsg.getString(102) != null ? isoMsg.getString(102) : "000";
        String f127 = MiscUtil.generateRandomRRN(6);
        String f48 = "+05777833858+01367553858";
        isoMsg.set(39, "000");
        isoMsg.set(102, f102);
        isoMsg.set(127, f127);
        isoMsg.set(48, f48);
        return isoMsg;
    }
    
    public ISOMsg get1210AccValidationResponse(ISOMsg isoMsg)
    {   
        // <field id="127" value="001/0010201200504/CA203/NEW MUTHOKINJU HARDWARE  LTD/54200338440/A/KES/ /"/>
        String f102 = isoMsg.getString(102) != null ? isoMsg.getString(102) : "000";
        String f125 = "54200338440 NEW MUTHOKINJU HARDWARE LTD NEW MUTHOKINJU HARDWARE  LTD  20050406CA203CAAAETS  35002001 +0000000000000000+0000000000000000";
        String f127 = "001/0010201200504/CA203/NEW MUTHOKINJU HARDWARE  LTD/54200338440/A/KES/ /";
        String f48 = "+05777833858+01367553858";
        isoMsg.set(39, "000");
        isoMsg.set(102, f102);
        isoMsg.set(125, f125);
        isoMsg.set(127, f127);
        isoMsg.set(48, f48);
        return isoMsg;
    }
    
}
