/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util;

/**
 *
 * @author ronaldcheruiyot
 */
import static com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util.MiscUtil.extractAllTagValues;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.google.common.base.CaseFormat;
import com.moneygram.agentconnect1512.KeyValuePair;
import com.moneygram.agentconnect1512.ProductType;
import com.moneygram.agentconnect1512.SendReversalReasonCode;
import com.moneygram.agentconnect1512.SendReversalType;
import com.moneygram.agentconnect1512.SendValidationRequest;
import jakarta.xml.bind.JAXBElement;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.namespace.QName;
import lombok.extern.slf4j.Slf4j;
import org.w3c.dom.Element;

@Slf4j
public class StringTransformer {

    public static void main(String[] args) throws Exception {
        String xmlString = "<sendValidationRequest xmlns=\"http://www.moneygram.com/AgentConnect1512\">\n"
                + "            <amount>320.00</amount>\n"
                + "            <destinationCountry>USA</destinationCountry>\n"
                + "            <destinationState>CA</destinationState>\n"
                + "            <deliveryOption>Standard</deliveryOption>\n"
                + "            <receiveCurrency>USD</receiveCurrency>\n"
                + "            <receiveAgentID>Agent002</receiveAgentID>\n"
                + "            <accountNumber>ACC12345</accountNumber>\n"
                + "            <senderFirstName>John</senderFirstName>\n"
                + "            <senderLastName>Smith</senderLastName>\n"
                + "            <senderAddress>123 Main St</senderAddress>\n"
                + "            <senderCity>Los Angeles</senderCity>\n"
                + "            <senderCountry>USA</senderCountry>\n"
                + "            <senderHomePhone>+11234567890</senderHomePhone>\n"
                + "            <receiverFirstName>Jane</receiverFirstName>\n"
                + "            <receiverLastName>Doe</receiverLastName>\n"
                + "            <receiverPhone>+11239876543</receiverPhone>\n"
                + "            <receiverPhoneCountryCode>1</receiverPhoneCountryCode>\n"
                + "            <senderPhotoIdType>Passport</senderPhotoIdType>\n"
                + "            <senderPhotoIdNumber>P123456789</senderPhotoIdNumber>\n"
                + "            <senderPhotoIdCountry>USA</senderPhotoIdCountry>\n"
                + "            <senderLegalIdType>Driver's License</senderLegalIdType>\n"
                + "            <senderLegalIdNumber>D1234567</senderLegalIdNumber>\n"
                + "            <senderDOB>1990-01-01</senderDOB>\n"
                + "            <senderOccupation>Engineer</senderOccupation>\n"
                + "            <senderBirthCountry>USA</senderBirthCountry>\n"
                + "            <sendCurrency>USD</sendCurrency>\n"
                + "            <mgiTransactionSessionID>16773711E172492497686521858318NN</mgiTransactionSessionID>\n"
                + "            <sendPurposeOfTransaction>Purpose</sendPurposeOfTransaction>\n"
                + "            <sourceOfFunds>Self</sourceOfFunds>\n"
                + "            <relationshipToReceiver>Family</relationshipToReceiver>\n"
                + "            <senderHomePhoneCountryCode>111</senderHomePhoneCountryCode>\n"
                + "            <senderIntendedUseOfMGIServices>Personal</senderIntendedUseOfMGIServices>\n"
                + "            <fieldValues>\n"
                + "                <keyValuePair>\n"
                + "                    <xmlTag>ExampleTag</xmlTag>\n"
                + "                    <fieldValue>ExampleValue</fieldValue>\n"
                + "                </keyValuePair>\n"
                + "                <keyValuePair>\n"
                + "                    <xmlTag>ExampleTag1</xmlTag>\n"
                + "                    <fieldValue>ExampleValue1</fieldValue>\n"
                + "                </keyValuePair>\n"
                + "            </fieldValues>\n"
                + "        </sendValidationRequest>";
        System.out.println(xmlString);
        List<Object> objects = transform(xmlString, SendValidationRequest.class);
        SendValidationRequest sendValidationRequest = (SendValidationRequest) (objects.get(0));
        if (objects.size() > 1) {
            Map<String, String> keyValuePairs = (Map<String, String>) (objects.get(1));
            
            Iterator<Map.Entry<String, String>> it = keyValuePairs.entrySet().iterator();
            while (it.hasNext()) {
                
                Map.Entry<String, String> entry = it.next();
                KeyValuePair keyValue = new KeyValuePair();
                keyValue.setXmlTag(entry.getKey());
                keyValue.setFieldValue(entry.getValue());
                System.out.println("KEY: " + entry.getKey() + ", VALUE: " + entry.getValue());
                sendValidationRequest.getFieldValues().getKeyValuePair().add(keyValue);
            }
        }
        String formattedResponse = XmlReaderService.wrapInSoapEnvelope(MiscUtil.convertToXml(sendValidationRequest), "SendValidationRequest");
        System.out.println(formattedResponse);
    }

    public static List<Object> transform(String xmlString, Class<?> type) throws Exception {
        List<Object> objects = new ArrayList<>();
        Map<String, Object> map = extractAllTagValues(xmlString);

        Iterator<Map.Entry<String, Object>> it = map.entrySet().iterator();

        while (it.hasNext()) {
            Map.Entry<String, Object> entry = it.next();
            System.out.println(entry.getKey() + ":" + entry.getValue());
        }

        Object object = constructObject(map, type, false);

        objects.add(object);

        Object keyValuePair = map.get("keyValuePair");

        if (keyValuePair != null) {
            objects.add(keyValuePair);
        }

        return objects;

    }

    public static String convertToXml(Object response) throws Exception {
        XmlMapper xmlMapper = new XmlMapper();
        return xmlMapper.writeValueAsString(response);
    }

    public static String getLastSegment(String input) {
        int lastSlashIndex = input.lastIndexOf('/');
        if (lastSlashIndex != -1) {
            return input.substring(lastSlashIndex + 1);
        } else {
            return input; // No "/" found, return the whole string
        }
    }

    public static XMLGregorianCalendar createXMLGregorianCalendar(String dateString) throws ParseException, DatatypeConfigurationException {
        // Define the date format of your input string
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        Date date = dateFormat.parse(dateString);

        // Convert Date to GregorianCalendar
        GregorianCalendar calendar = new GregorianCalendar();
        calendar.setTime(date);

        // Convert GregorianCalendar to XMLGregorianCalendar
        return DatatypeFactory.newInstance().newXMLGregorianCalendar(calendar);
    }

    private static Object constructObject(Map<String, Object> input, Class target, boolean format) {
        Object object = null;
        try {
            object = target.getConstructor().newInstance();
        } catch (NoSuchMethodException
                | SecurityException
                | InstantiationException
                | IllegalAccessException
                | IllegalArgumentException
                | InvocationTargetException ex) {
            log.error(ex.getMessage());
            return null;
        }

        Iterator iterator = input.entrySet().iterator();
        while (iterator.hasNext()) {
            try {
                Map.Entry entry = (Map.Entry) iterator.next();
                String key = (String) entry.getKey();
                key = getLastSegment(key);
                Object value = entry.getValue();
                if (format) {
                    key = CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_CAMEL, key);
                }
                Field field;
                try {
                    field = target.getDeclaredField(key);
                    field.setAccessible(true);
                    log.info("Field name: " + field.getName());
                    log.info("Field type: " + field.getType().toString());
                    if (value != null && !value.equals("null")) {
                        switch (field.getType().toString()) {
                            case "class java.lang.Double": {
                                log.info("Field type is java.lang.Double");
                                Double finalValue = new Double(value.toString());
                                field.set(object, finalValue);
                                break;
                            }
                            case "class java.math.BigDecimal": {
                                BigDecimal finalValue = new BigDecimal(String.valueOf(value));
                                field.set(object, finalValue);
                                break;
                            }
                            case "class javax.xml.datatype.XMLGregorianCalendar": {
                                XMLGregorianCalendar finalValue = null;
                                try {
                                    finalValue = createXMLGregorianCalendar(String.valueOf(value));
                                } catch (ParseException | DatatypeConfigurationException ex) {
                                    log.info("Error occured: " + ex.getClass() + ": " + ex.getMessage());

                                }
                                if (finalValue != null) {
                                    field.set(object, finalValue);
                                }
                                break;
                            }
                            case "class com.moneygram.agentconnect1512.SendReversalReasonCode": {
                                SendReversalReasonCode finalValue = null;
                                try {
                                    finalValue = SendReversalReasonCode.fromValue(String.valueOf(value));
                                } catch (Exception ex) {
                                    log.info("Error occured: " + ex.getClass() + ": " + ex.getMessage());

                                }
                                if (finalValue != null) {
                                    field.set(object, finalValue);
                                }
                                break;
                            }
                            case "class com.moneygram.agentconnect1512.SendReversalType": {
                                SendReversalType finalValue = null;
                                try {
                                    finalValue = SendReversalType.fromValue(String.valueOf(value));
                                } catch (Exception ex) {
                                    log.info("Error occured: " + ex.getClass() + ": " + ex.getMessage());

                                }
                                if (finalValue != null) {
                                    field.set(object, finalValue);
                                }
                                break;
                            }
                            case "class com.moneygram.agentconnect1512.SendValidationRequest$FieldValues": {
                                SendValidationRequest.FieldValues fieldValues = new SendValidationRequest.FieldValues();

                                field.set(object, fieldValues);
                                break;
                            }
                            default:
                                field.set(object, value);
                                break;
                        }
                    } else {
                        log.info("Cannot set value on field because the value is null or is equal to the string 'null'");
                    }
                    field.setAccessible(false);
                } catch (NoSuchFieldException | IllegalArgumentException | IllegalAccessException ex) {
                    log.info("Error occured: " + ex.getClass() + ": " + ex.getMessage());
                }
            } catch (SecurityException ex) {
                log.error(ex.getMessage());
            }
        }
        log.error("Final value: " + object);
        return object;
    }
}
