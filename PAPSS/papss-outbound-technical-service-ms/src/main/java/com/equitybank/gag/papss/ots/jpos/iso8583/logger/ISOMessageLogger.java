package com.equitybank.gag.papss.ots.jpos.iso8583.logger;

import org.jpos.iso.ISOMsg;
import org.jpos.iso.ISOUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.Instant;

public class ISOMessageLogger {
    private static final Logger logger = LoggerFactory.getLogger(ISOMessageLogger.class);

    // Define field orders for requests and responses
    private static final int[] REQUEST_FIELD_ORDER = {0, 2, 3, 4, 7, 11, 12, 17, 24, 32, 37, 41, 43, 46, 49, 102, 103, 123, 125, 126};
    private static final int[] RESPONSE_FIELD_ORDER = {0, 2, 3, 4, 7, 11, 12, 17, 32, 37, 38, 39, 41, 46, 48, 49, 102, 103, 123, 125, 126};
    private static final int[] CRITICAL_FIELDS = {0, 3, 11, 37, 39}; // Fields that MUST be logged

    /**
     * Logs outgoing requests (client → server).
     */
    public static void logRequest(ISOMsg isoMsg, String host, int port, byte[] header) {
        logISOMessage(isoMsg, "outgoing", host, port, header, null, REQUEST_FIELD_ORDER);
    }

    /**
     * Logs incoming responses (server → client).
     */
    public static void logResponse(ISOMsg isoMsg, String host, int port, byte[] header, Long lifespan) {
        logISOMessage(isoMsg, "incoming", host, port, header, lifespan, RESPONSE_FIELD_ORDER);
    }

    private static void logISOMessage(ISOMsg isoMsg, String direction, String host, int port, byte[] header, Long lifespan, int[] fieldOrder) {
        try {
            String logMessage = buildLogMessage(isoMsg, direction, host, port, header, lifespan, fieldOrder);
            logger.info(logMessage);
        } catch (Exception e) {
            logger.error("Error logging ISO message", e);
        }
    }

    private static String buildLogMessage(ISOMsg isoMsg, String direction, String host, int port, byte[] header, Long lifespan, int[] fieldOrder) throws Exception {
        StringBuilder xmlBuilder = new StringBuilder();
        String timestamp = Instant.now().toString();

        // Start log element
        xmlBuilder.append("<log realm=\"channel/")
                .append(host).append(":").append(port)
                .append("\" at=\"").append(timestamp).append("\"");

        if (lifespan != null) {
            xmlBuilder.append(" lifespan=\"").append(lifespan).append("ms\"");
        }
        xmlBuilder.append(">\n");

        // Add send/receive wrapper
        xmlBuilder.append("  <").append("outgoing".equals(direction) ? "send" : "receive").append(">\n");

        // Start isomsg
        xmlBuilder.append("    <isomsg direction=\"").append(direction).append("\">\n");
        xmlBuilder.append("      <!-- ").append(isoMsg.getPackager().getClass().getName()).append(" -->\n");

        // Add header for incoming messages
        if ("incoming".equals(direction)) {
            xmlBuilder.append("      <header>")
                    .append(ISOUtil.hexString(header))
                    .append("</header>\n");
        }

        // Log fields in specified order
        for (int fieldId : fieldOrder) {
            logField(xmlBuilder, isoMsg, fieldId);
        }

        // Ensure critical fields are logged even if missing from fieldOrder
        for (int fieldId : CRITICAL_FIELDS) {
            if (!contains(fieldOrder, fieldId) && isoMsg.hasField(fieldId)) {
                logField(xmlBuilder, isoMsg, fieldId);
            }
        }

        // Close tags
        xmlBuilder.append("    </isomsg>\n");
        xmlBuilder.append("  </").append("outgoing".equals(direction) ? "send" : "receive").append(">\n");
        xmlBuilder.append("</log>");

        return xmlBuilder.toString();
    }

    private static void logField(StringBuilder xmlBuilder, ISOMsg isoMsg, int fieldId) {
        try {
            if (isoMsg.hasField(fieldId)) {
                String value = isoMsg.getString(fieldId);
                if (fieldId == 2 && value != null && value.length() > 8) {
                    value = value.substring(0, 6) + "******" + value.substring(value.length() - 4);
                }
                xmlBuilder.append("      <field id=\"")
                        .append(fieldId)
                        .append("\" value=\"")
                        .append(value != null ? value : "")
                        .append("\"/>\n");
            }
        } catch (Exception e) {
            logger.warn("Failed to log field {}", fieldId, e);
        }
    }

    private static boolean contains(int[] array, int value) {
        for (int item : array) {
            if (item == value) return true;
        }
        return false;
    }
}