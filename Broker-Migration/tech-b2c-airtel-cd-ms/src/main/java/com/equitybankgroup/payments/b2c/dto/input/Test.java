 package com.equitybankgroup.payments.b2c.dto.input;
 
 import java.io.StringReader;
 import java.io.StringWriter;
 import java.math.BigDecimal;
 import java.math.RoundingMode;
 import java.util.List;
 import java.util.logging.Level;
 import java.util.logging.Logger;
 import jakarta.xml.bind.JAXBContext;
 import jakarta.xml.bind.JAXBElement;
 import jakarta.xml.bind.JAXBException;
 import jakarta.xml.bind.Marshaller;
 import jakarta.xml.bind.Unmarshaller;
 import javax.xml.transform.stream.StreamSource;
 
 
 
 
 
 
 
 
 
 
 
 public class Test
 {
   public static void main(String[] args) {
     BigDecimal amt = new BigDecimal("100");
     System.out.println(amt.setScale(0, RoundingMode.CEILING).toString());
     
     strToObj();
   }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
   
   public static void objectToStr(MidletRq rq) {
     try {
       JAXBContext jaxbContext = JAXBContext.newInstance(new Class[] { MidletRq.class });
       Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
 
       
       jaxbMarshaller.setProperty("jaxb.formatted.output", Boolean.valueOf(true));
 
 
       
       StringWriter jaxwriter = new StringWriter();
       jaxbMarshaller.marshal(rq, jaxwriter);
       StringBuffer jaxrespBfr = jaxwriter.getBuffer();
       System.out.println(jaxrespBfr.toString());
     } catch (JAXBException ex) {
       Logger.getLogger(Test.class.getName()).log(Level.SEVERE, (String)null, ex);
     } 
   }
   
   public static MidletRq strToObj() {
     try {
       String body = "<MidletRs version='1.0' Mode='USSD'>\n  <Set>\n    <String Name='RC'>OK</String>\n    <String Name='DATARS'>0170190906608,CRD</String>\n    <String Name='ROLE'>CUSTOMER</String>\n    <String Name='FIRSTNAME'>ROY</String>\n    <String Name='PACC'>0170190906608</String>\n  </Set>\n</MidletRs>";
 
 
 
 
 
 
 
       
       StringReader strWay4Reader = new StringReader(body.trim());
       JAXBContext jaxbContextUmWay4 = JAXBContext.newInstance(new Class[] { MidletRq.class });
       Unmarshaller unmarshallerWay4 = jaxbContextUmWay4.createUnmarshaller();
       JAXBElement<MidletRq> rootWay4 = unmarshallerWay4.unmarshal(new StreamSource(strWay4Reader), MidletRq.class);
       MidletRq inqRequest = rootWay4.getValue();
       System.out.println(inqRequest.getMode());
       List<MidletStr> setLi = inqRequest.getMidletSet().getSet();
       for (MidletStr midletStr : setLi) {
         System.out.println("midletStr" + midletStr.getName() + midletStr.getDescription());
         if (midletStr.getName().equals("RRN")) {
           System.out.println("RRN= " + midletStr.getDescription());
         }
       } 
       return inqRequest;
     } catch (JAXBException ex) {
       Logger.getLogger(Test.class.getName()).log(Level.SEVERE, (String)null, ex);
       return null;
     } 
   }
 }


/* Location:              C:\Users\geoffrey.kamau\Desktop\111\sub-b2c\b2c-sub-0.0.1-SNAPSHOT.jar!\com\way4\Test.class
 * Java compiler version: 6 (50.0)
 * JD-Core Version:       1.1.3
 */