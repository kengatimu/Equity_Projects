package com.papss.middleware.utils;

import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpHeaders;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import java.text.ParseException;
import java.time.ZoneOffset;
import java.util.GregorianCalendar;

import static org.junit.jupiter.api.Assertions.*;

public class UtilsTest {

    @Test
    void getHeader_returnsFirstValueOrNull() {
        HttpHeaders headers = new HttpHeaders();
        headers.add("X-Test", "v1");
        headers.add("X-Test", "v2");
        assertEquals("v1", Utils.getHeader(headers, "X-Test"));
        assertNull(Utils.getHeader(headers, "Missing"));
    }

    @Test
    void toJson_serializesPojo() {
        class Pojo { public String a = "b"; }
        String json = Utils.toJson(new Pojo());
        assertNotNull(json);
        assertTrue(json.contains("\"a\""));
        assertTrue(json.contains("\"b\""));
    }

    @Test
    void toObject_and_toJsonNode_roundTripSimpleXml() {
        String xml = "<root><name>john</name><age>30</age></root>";
        class Person { public String name; public int age; }
        Person p = Utils.toObject(xml, Person.class);
        assertNotNull(p);
        assertEquals("john", p.name);
        assertEquals(30, p.age);

        JsonNode node = Utils.toJsonNode(xml);
        assertNotNull(node);
        assertEquals("john", node.get("name").asText());
        assertEquals(30, node.get("age").asInt());
    }

    @Test
    void unmarshall_returnsNullOnEmpty() {
        assertNull(Utils.unmarshall("", Object.class));
        assertNull(Utils.unmarshall(null, Object.class));
    }

    @Test
    void generateMessageId_hasExpectedFormatParts() {
        String id = Utils.generateMessageId("P01");
        assertNotNull(id);
        assertTrue(id.length() >= 8 + 3 + 6); // yyyyMMdd + P01 + HHmmss
        assertTrue(id.contains("P01"));
    }

    @Test
    void generateZuluDateTime2_hasNoFractionalSeconds() {
        XMLGregorianCalendar xgc = Utils.generateZuluDateTime2();
        assertNotNull(xgc);
        assertNull(xgc.getFractionalSecond(), "Fractional seconds should be null");
    }

    @Test
    void generateStringFromZuluDateTime_formatsIso8601() throws DatatypeConfigurationException, ParseException {
        GregorianCalendar cal = GregorianCalendar.from(java.time.ZonedDateTime.now(ZoneOffset.UTC).withNano(0));
        String formatted = Utils.generateStringFromZuluDateTime(cal);
        assertNotNull(formatted);
        // basic shape check: ends with Z
        assertTrue(formatted.endsWith("Z"));
        assertEquals(24, formatted.length()); // yyyy-MM-dd'T'HH:mm:ss.SSS'Z' => 24 chars
    }
}
