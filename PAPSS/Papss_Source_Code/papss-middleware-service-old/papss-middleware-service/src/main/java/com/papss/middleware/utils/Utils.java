package com.papss.middleware.utils;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.papss.middleware.exception.ApiException;
import com.papss.middleware.models.fxrate.PaymentFXRate;
import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBException;
import jakarta.xml.bind.Unmarshaller;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import java.io.IOException;
import java.io.StringReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.TimeZone;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
public class Utils {

    private static final ObjectMapper objectMapper = new ObjectMapper();
    private static final XmlMapper xmlMapper = new XmlMapper();

    // Cache for JAXBContext instances to improve performance
    // Limited to 100 entries with LRU eviction policy to prevent memory leaks
    private static final Map<Class<?>, JAXBContext> jaxbContextCache = 
        Collections.synchronizedMap(new LinkedHashMap<Class<?>, JAXBContext>(16, 0.75f, true) {
            @Override
            protected boolean removeEldestEntry(Map.Entry<Class<?>, JAXBContext> eldest) {
                return size() > 100; // Limit cache to 100 entries
            }
        });

    static {
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, true);
        objectMapper.enable(SerializationFeature.INDENT_OUTPUT);
    }

    /**
     * Gets a header value from HttpHeaders.
     *
     * @param headers The HttpHeaders object
     * @param headerName The name of the header to get
     * @return The header value, or null if not found
     */
    public static String getHeader(HttpHeaders headers, String headerName) {
        return headers.getFirst(headerName);
    }

    /**
     * Unmarshalls an XML string into an object of the specified class.
     * Uses a cached JAXBContext for better performance.
     *
     * @param xmlString The XML string to unmarshall
     * @param clazz The class to unmarshall into
     * @return The unmarshalled object, or null if an error occurs
     * @throws ApiException if there's an error during unmarshalling
     */
    public static <T> T unmarshall(String xmlString, Class<T> clazz) {
        if (xmlString == null || xmlString.isEmpty()) {
            log.warn("Empty XML string provided for unmarshalling to {}", clazz.getSimpleName());
            return null;
        }

        try {
            // Get or create JAXBContext from cache
            JAXBContext jaxbContext = jaxbContextCache.computeIfAbsent(clazz, k -> {
                try {
                    return JAXBContext.newInstance(k);
                } catch (JAXBException e) {
                    log.error("Failed to create JAXBContext for class {}: {}", k.getSimpleName(), e.getMessage(), e);
                    throw new ApiException(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to create JAXBContext: " + e.getMessage(), e);
                }
            });

            // Create a new Unmarshaller (not thread-safe, so we create a new one each time)
            Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();

            // Use try-with-resources to ensure StringReader is properly closed
            try (StringReader reader = new StringReader(xmlString)) {
                // Unmarshal the XML string into the specified class
                return clazz.cast(jaxbUnmarshaller.unmarshal(reader));
            }
        } catch (JAXBException e) {
            log.error("Failed to unmarshall XML to {}: {}", clazz.getSimpleName(), e.getMessage(), e);
            return null;
        }
    }

    /**
     * Converts an object to a JSON string.
     *
     * @param object The object to convert
     * @return The JSON string, or null if an error occurs
     */
    public static String toJson(Object object) {
        try {
            return objectMapper.writeValueAsString(object);
        } catch (Exception e) {
            log.error("Failed to serialize object to JSON: {}", e.getMessage(), e);
            return null;
        }
    }

    /**
     * Marshalls an object to an XML string.
     * Uses a cached JAXBContext for better performance.
     *
     * @param object The object to marshall
     * @return The XML string, or null if an error occurs
     */
    public static String marshall(Object object) {
        if (object == null) {
            log.warn("Null object provided for marshalling");
            return null;
        }

        java.io.StringWriter writer = null;
        try {
            Class<?> clazz = object.getClass();

            // Get or create JAXBContext from cache
            JAXBContext jaxbContext = jaxbContextCache.computeIfAbsent(clazz, k -> {
                try {
                    return JAXBContext.newInstance(k);
                } catch (JAXBException e) {
                    log.error("Failed to create JAXBContext for class {}: {}", k.getSimpleName(), e.getMessage(), e);
                    throw new ApiException(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to create JAXBContext: " + e.getMessage(), e);
                }
            });

            // Create a StringWriter to hold the XML
            writer = new java.io.StringWriter();

            // Create a new Marshaller (not thread-safe, so we create a new one each time)
            jakarta.xml.bind.Marshaller marshaller = jaxbContext.createMarshaller();
            marshaller.setProperty(jakarta.xml.bind.Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);

            // Marshall the object to XML
            marshaller.marshal(object, writer);

            return writer.toString();
        } catch (JAXBException e) {
            log.error("Failed to marshall object of type {}: {}", object.getClass().getSimpleName(), e.getMessage(), e);
            return null;
        } finally {
            // Ensure writer is closed in finally block
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    log.warn("Failed to close StringWriter: {}", e.getMessage());
                }
            }
        }
    }

    /**
     * Converts an XML string to an object of the specified class using XmlMapper.
     *
     * @param xml The XML string to convert
     * @param tClass The class to convert to
     * @return The converted object, or null if an error occurs
     */
    public static <T> T toObject(String xml, Class<T> tClass) {
        try {
            return xmlMapper.readValue(xml, tClass);
        } catch (Exception e) {
            log.error("Failed to deserialize XML to object of type {}: {}", tClass.getSimpleName(), e.getMessage(), e);
            return null;
        }
    }

    /**
     * Converts an XML string to a JsonNode using XmlMapper.
     *
     * @param xml The XML string to convert
     * @return The JsonNode, or null if an error occurs
     */
    public static JsonNode toJsonNode(String xml) {
        try {
            return xmlMapper.readTree(xml);
        } catch (Exception e) {
            log.error("Failed to convert XML to JsonNode: {}", e.getMessage(), e);
            return null;
        }
    }

    /**
     * Generates an XMLGregorianCalendar with the current UTC date and time.
     *
     * @return The XMLGregorianCalendar with UTC date and time
     * @throws ApiException if there's an error during generation
     */
    public static XMLGregorianCalendar generateZuluDateTime() {
        try {
            return DatatypeFactory.newInstance()
                    .newXMLGregorianCalendar(
                            (GregorianCalendar) GregorianCalendar.getInstance(TimeZone.getTimeZone(ZoneOffset.UTC)));

        } catch (Exception e) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Failed to generate Zulu DateTime", e);
        }
    }


    public static XMLGregorianCalendar generateZuluDateTime(Date date) {
        try {
            return DatatypeFactory.newInstance()
                    .newXMLGregorianCalendar((GregorianCalendar) GregorianCalendar.getInstance(TimeZone.getTimeZone(ZoneOffset.UTC)));

        } catch (Exception e) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Failed to generate Zulu DateTime", e);
        }
    }


    public static XMLGregorianCalendar generateZuluDateTime2() {
        try {
            GregorianCalendar calendar = GregorianCalendar.from(ZonedDateTime.now(ZoneOffset.UTC).withNano(0)); // removes milliseconds
            XMLGregorianCalendar xmlGregorianCalendar = DatatypeFactory.newInstance().newXMLGregorianCalendar(calendar);
            xmlGregorianCalendar.setFractionalSecond(null); // remove fractional seconds
            return xmlGregorianCalendar;
        } catch (Exception e) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Failed to generate Zulu DateTime", e);
        }
    }

    /**
     * Generates an XMLGregorianCalendar with the current date in yyyy-MM-dd format.
     *
     * @return The XMLGregorianCalendar with the current date
     * @throws ApiException if there's an error during generation
     */
    public static XMLGregorianCalendar generateSimpleDateTime(){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return DatatypeFactory.newInstance()
                    .newXMLGregorianCalendar(
                            dateFormat.format(new Date()));
        }catch (Exception e){
            throw new ApiException(HttpStatus.BAD_REQUEST, "Failed to generate Simple DateTime", e);
        }
    }

    /**
     * Unmarshalls an XML string into a montran.message.Message object.
     * Uses the generic unmarshall method with the cached JAXBContext.
     *
     * @param xmlString The XML string to unmarshall
     * @return The unmarshalled Message object, or null if an error occurs
     */
    public static montran.message.Message unmarshallMessageResponse(String xmlString) {
        return unmarshall(xmlString, montran.message.Message.class);
    }
    /**
     * Generates a message ID using the sender's PAPSS ID and the current UTC date and time.
     * Format: yyyyMMdd + senderPapssId + HHmmss
     *
     * @param senderPapssId The sender's PAPSS ID
     * @return The generated message ID
     */
    public static String generateMessageId(String senderPapssId) {
        OffsetDateTime now = OffsetDateTime.now(ZoneOffset.UTC);
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HHmmss");

        String extractedDate = now.format(dateFormatter);
        String extractedTime = now.format(timeFormatter);

        return extractedDate + senderPapssId + extractedTime;
    }

    /**
     * Converts a GregorianCalendar to a formatted string in ISO 8601 format.
     * Format: yyyy-MM-dd'T'HH:mm:ss.SSS'Z'
     *
     * @param gregorianCalendar The GregorianCalendar to convert
     * @return The formatted string
     * @throws DatatypeConfigurationException if there's an error during conversion
     * @throws ParseException if there's an error during parsing
     */
    public static String generateStringFromZuluDateTime(GregorianCalendar gregorianCalendar) throws DatatypeConfigurationException, ParseException {
        SimpleDateFormat dateStringFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        dateStringFormat.setTimeZone(TimeZone.getTimeZone(ZoneOffset.UTC));

        Date date = gregorianCalendar.getTime();

        return dateStringFormat.format(date);
    }
}
