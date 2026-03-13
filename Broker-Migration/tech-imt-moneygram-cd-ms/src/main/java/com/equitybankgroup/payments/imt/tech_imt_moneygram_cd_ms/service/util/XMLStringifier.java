package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;

public class XMLStringifier {
    public String stringify(Object o) throws JsonProcessingException {
        XmlMapper xmlMapper = new XmlMapper();
        return xmlMapper.writeValueAsString(o);
    }
}
