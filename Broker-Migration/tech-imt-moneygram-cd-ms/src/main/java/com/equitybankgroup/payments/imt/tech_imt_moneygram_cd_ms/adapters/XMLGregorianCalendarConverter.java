///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.adapters;
//
//import com.thoughtworks.xstream.converters.Converter;
//import com.thoughtworks.xstream.converters.MarshallingContext;
//import com.thoughtworks.xstream.converters.UnmarshallingContext;
//import com.thoughtworks.xstream.io.HierarchicalStreamReader;
//import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
//
//import javax.xml.datatype.DatatypeFactory;
//import javax.xml.datatype.XMLGregorianCalendar;
//
//public class XMLGregorianCalendarConverter implements Converter {
//    
//
//    @Override
//    public void marshal(Object source, HierarchicalStreamWriter writer, MarshallingContext context) {
//        XMLGregorianCalendar calendar = (XMLGregorianCalendar) source;
//        writer.setValue(calendar.toXMLFormat());
//    }
//
//    @Override
//    public Object unmarshal(HierarchicalStreamReader reader, UnmarshallingContext context) {
//        try {
//            return DatatypeFactory.newInstance().newXMLGregorianCalendar(reader.getValue());
//        } catch (Exception e) {
//            throw new RuntimeException("Failed to parse XMLGregorianCalendar", e);
//        }
//    }
//
//    @Override
//    public boolean canConvert(Class type) {
//        return XMLGregorianCalendar.class.isAssignableFrom(type);
//    }
//}
//
