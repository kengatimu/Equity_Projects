package com.equitybankgroup.vas.hostemulator.emulator.fin;

import com.equitybankgroup.vas.hostemulator.HostEmulatorApplication;
import java.io.*;
import java.text.NumberFormat;
import java.text.ParsePosition;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import org.jpos.core.Configurable;
import org.jpos.core.Configuration;
import org.jpos.core.ConfigurationException;
import org.jpos.iso.ISOException;
import org.jpos.iso.ISOMsg;
import org.jpos.iso.ISORequestListener;
import org.jpos.iso.ISOSource;


public class CBSIsoListener
        implements ISORequestListener, Configurable {
    
    private Configuration configuration;
    
    @Override
    public boolean process(ISOSource isoSource, ISOMsg isomsg) {
        try {
            if(isomsg.getMTI().equals("1210") || isomsg.getMTI().equals("0840"))
            {
                return false;
            }
        } catch (ISOException ex) {
            Logger.getLogger(CBSIsoListener.class.getName()).log(Level.SEVERE, null, ex);
        }
        ISOMsg isomsg2 = (ISOMsg) isomsg.clone();
        CBCService cbcService = HostEmulatorApplication.applicationContext.getBean(CBCService.class);
        try {
            System.out.println("****CBC Incoming Request Msg ==> ");
            if (isomsg.getMTI().equals("1200")) {
                if(isomsg2.getString(3).equals("900000") || isomsg2.getString(3).equals("440000")) {
                    System.out.println("NEW TRANSACTION!!");
                    isomsg2.setMTI("1210");
                    isomsg2 = cbcService.get1200ResponseCode(isomsg2);
                    isoSource.send(isomsg2);
                    System.out.println("Returned CBC response");
                    return true;
                }
                
                 if(isomsg2.getString(3).equals("400000") 
                         && isomsg2.getString(123).equals("TPG")
                         && isomsg2.getString(126).equals("REMITTANCE")) {
                    System.out.println("NEW TRANSACTION!!");
                    isomsg2.setMTI("1210");
                    isomsg2 = cbcService.get1200ResponseCode(isomsg2);
                    isoSource.send(isomsg2);
                    System.out.println("Returned CBC response");
                    return true;
                }
                
                
                
                //Balance request
                if(isomsg2.getString(3).equals("310000") && isomsg2.getString(123).equals("SMS") && isomsg2.getString(126).equals("CAMPAIGN")) {
                    System.out.println("NEW TRANSACTION!!");
                    isomsg2.setMTI("1210");
                    isomsg2 = cbcService.get1210BalanceResponse(isomsg2);
                    isoSource.send(isomsg2);
                    System.out.println("Returned CBC response");
                    return true;
                }
                
                //Account validation
                if(isomsg2.getString(3).equals("820000") && isomsg2.getString(123).equals("SMS") && isomsg2.getString(126).equals("CAMPAIGN")) {
//                if(isomsg2.getString(3).equals("820000") && isomsg2.getString(123).equals("TPG") && isomsg2.getString(126).equals("TERMID01")) {
                    System.out.println("NEW TRANSACTION!!");
                    isomsg2.setMTI("1210");
                    isomsg2 = cbcService.get1210AccValidationResponse(isomsg2);
                    isoSource.send(isomsg2);
                    System.out.println("Returned CBC response");
                    return true;
                }
                
                
                
            } else if(isomsg2.getMTI().equalsIgnoreCase("1804"))
            {
                isomsg2 = success0840Response(isomsg2);
                isoSource.send(isomsg2);
                System.out.println("Returned CBC response");
                return true;
            }
            if (isomsg.getMTI().equals("1420")
                    && isomsg2.getString(3).equals("440000")) {
                System.out.println("NEW TRANSACTION!!");
                isomsg2.setMTI("1430");
                isomsg2.set(39, "000");
                isoSource.send(isomsg2);
                System.out.println("Returned CBC response");
                return true;
            }
            
            if (isomsg.getMTI().equals("1200")
                    && isomsg2.getString(3).equals("310000") 
                    && isomsg2.getString(123).equals("SMS")
                    && isomsg2.getString(126).equals("CAMPAIGN")) {
                System.out.println("BALANCE CHECK!!");
                isomsg2.setMTI("1210");
                isomsg2.set(39, "000");
                isomsg2.set(48, "+00000003500+00000003505");
                isoSource.send(isomsg2);
                System.out.println("Returned CBC response");
                return true;
            }
            
            
            isomsg2.setMTI("1210");
            isomsg2.set(39, "999");
            isomsg2.set(48, "Un mapped Message");
            isoSource.send(isomsg2);
            System.out.println("Returned CBC response");
            return true;
        } catch (IOException | ISOException ex) {
            System.out.println("ISOException" + ex.getMessage());
            ex.printStackTrace(System.out);
            return false;
        } 
        
    }
    
    private ISOMsg success0840Response(ISOMsg isomsg) throws ISOException
    {
        isomsg.set(39, "000");
        isomsg.setMTI("0840");
        return isomsg;
    }
 
    public boolean isNumeric(String str) {
        NumberFormat formatter = NumberFormat.getInstance();
        ParsePosition pos = new ParsePosition(0);
        formatter.parse(str, pos);
        return (str.length() == pos.getIndex());
    }

    private String getStrFromObj(Object object, Class theclass) {
        try {
            JAXBContext jaxbContext = JAXBContext.newInstance(new Class[]{theclass});
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty("jaxb.formatted.output", Boolean.valueOf(true));
            StringWriter jaxwriter = new StringWriter();
            jaxbMarshaller.marshal(object, jaxwriter);
            StringBuffer jaxrespBfr = jaxwriter.getBuffer();
            String resp = jaxrespBfr.toString();
            System.out.println(resp);
            return resp;
        } catch (JAXBException ex) {
            Logger.getLogger(CBSIsoListener.class.getName()).log(Level.SEVERE, (String) null, ex);
            return null;
        }
    }
    
    
    
   
    
    public static boolean IsNullOrEmpty(String value)
    {
        return ((value == null) || value.isEmpty());
    }

    @Override
    public void setConfiguration(Configuration configuration) throws ConfigurationException {
        this.configuration = configuration;
    }
    
  
  

}
