package com.equitybank.gag.papss.ots.jpos.jposService;

import org.jpos.iso.ISOMsg;

public interface ISOMsgSerializerAndDeserializerService {
    byte[] serializeISOMsg(ISOMsg isoMsg);

    ISOMsg deserializeISOMsg(byte[] data);

    String convertIsoMessageToString(ISOMsg isoMsg, String rrn);
}
