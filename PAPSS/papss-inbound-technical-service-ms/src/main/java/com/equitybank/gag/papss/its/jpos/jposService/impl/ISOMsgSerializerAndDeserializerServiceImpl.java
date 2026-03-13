package com.equitybank.gag.papss.its.jpos.jposService.impl;

import com.equitybank.gag.papss.its.jpos.jposService.ISOMsgSerializerAndDeserializerService;
import org.jpos.iso.ISOMsg;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.*;

@Service
public class ISOMsgSerializerAndDeserializerServiceImpl implements ISOMsgSerializerAndDeserializerService {
    private static final Logger log = LoggerFactory.getLogger(ISOMsgSerializerAndDeserializerServiceImpl.class);

    @Override
    public byte[] serializeISOMsg(ISOMsg isoMsg) {
        ByteArrayOutputStream baos = null;
        ObjectOutputStream oos = null;
        try {
            baos = new ByteArrayOutputStream();
            oos = new ObjectOutputStream(baos);
            oos.writeObject(isoMsg);
            return baos.toByteArray();
        } catch (IOException e) {
            log.error("Could not serialize ISOMsg: {}", e.getMessage());
            return new byte[0];
        } finally {
            if (oos != null) {
                try {
                    oos.close();
                } catch (IOException e) {
                    log.error("IOException occurred when trying to close ObjectOutputStream: {}", e.getMessage());
                }
            }
            if (baos != null) {
                try {
                    baos.close();
                } catch (IOException e) {
                    log.error("IOException occurred when trying to close ByteArrayOutputStream: {}", e.getMessage());
                }
            }
        }
    }

    @Override
    public ISOMsg deserializeISOMsg(byte[] data) {
        ByteArrayInputStream bais = null;
        ObjectInputStream ois = null;
        try {
            bais = new ByteArrayInputStream(data);
            ois = new ObjectInputStream(bais);
            return (ISOMsg) ois.readObject();
        } catch (IOException | ClassNotFoundException e) {
            log.error("Could not de-serialize ISOMsg: {}", e.getMessage());
            return new ISOMsg();
        } finally {
            if (ois != null) {
                try {
                    ois.close();
                } catch (IOException e) {
                    log.error("IOException occurred when trying to close ObjectInputStream: {}", e.getMessage());
                }
            }
            if (bais != null) {
                try {
                    bais.close();
                } catch (IOException e) {
                    log.error("IOException occurred when trying to close ByteArrayInputStream: {}", e.getMessage());
                }
            }
        }
    }

    @Override
    public String convertIsoMessageToString(ISOMsg isoMsg, String rrn) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PrintStream ps = new PrintStream(baos);
        try {
            isoMsg.dump(ps, ""); // Dumps the ISO message details into the PrintStream
            return baos.toString(); // Converts the byte array to a string
        } catch (Exception e) {
            log.error("{}: Exception occurred. Failed to convert ISO Message to string: {}", rrn, e.getMessage());
            return null;
        } finally {
            try {
                ps.close(); // Closes the PrintStream
                baos.close(); // Closes the ByteArrayOutputStream
            } catch (IOException e) {
                log.error("{}: IOException occurred. Failed to close stream: {}", rrn, e.getMessage());
            }
        }
    }
}
