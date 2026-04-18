 /*
  * Created on Dec 6, 2007
  *
  * TODO To change the template for this generated file go to
  * Window - Preferences - Java - Code Style - Code Templates
  */


package com.infy.finacle.workflow.mdb.processinitiate;


import java.io.BufferedOutputStream;
 import java.io.File;
 import java.io.FileOutputStream;
 import java.io.FileWriter;
import java.io.IOException;
 import java.util.Enumeration;
 import java.util.HashMap;
 import java.util.Iterator;
 import java.util.Properties;
 import java.util.Set;

 import java.io.*;
 import javax.xml.transform.Source;
 import javax.xml.transform.stream.StreamSource;
 import javax.xml.validation.*;
 import org.xml.sax.SAXException;

 import javax.jms.Destination;
 import javax.jms.JMSException;
 import javax.jms.MessageProducer;
 import javax.jms.QueueConnection;
 import javax.jms.QueueConnectionFactory;
 import javax.jms.QueueSession;
 import javax.jms.Session;
 import javax.jms.TextMessage;
 import javax.naming.Context;

 import org.apache.xerces.parsers.DOMParser;
 import org.w3c.dom.Document;
 import org.w3c.dom.NamedNodeMap;
 import org.w3c.dom.Node;
 import org.w3c.dom.NodeList;



 import peas.client.api.intf.engine.instancemgmt.PEASProcInstMgmtIF;
 import peas.client.cloader.intf.engine.interfacefactory.InstanceMgmtFactoryIF;
 import peas.init.PEASClassLoader;

 import com.infy.bbu.workflow.exception.WorkflowSysException;
 import com.infy.bbu.workflow.exception.WorkflowSysExpConstants;
import com.infy.finacle.workflow.mdb.common.PeasUtils;
import com.infy.finacle.workflow.mdb.common.Utility;
 
 /**
  * @author Rajmon_Soman
  *
  * TODO To change the template for this generated type comment go to
  * Window - Preferences - Java - Code Style - Code Templates
  */
 public class WPSRecieverBean implements javax.ejb.MessageDrivenBean, javax.jms.MessageListener {

     private javax.ejb.MessageDrivenContext fMessageDrivenCtx;
     private static final String sLogName = "PEAS";
     public static HashMap startParamMap = new HashMap();
     public static String paramName = null;
     public static String paramValue = null;
     public static String solID = null;
     public static String userID = null;
     public static String userRole = null;
     public static String processID = null;
     public static String processName = null;
    
 	/**
 	 * getMessageDrivenContext
 	 */
 	public javax.ejb.MessageDrivenContext getMessageDrivenContext() {
 		return fMessageDrivenCtx;
 	}

 	/**
 	 * setMessageDrivenContext
 	 */
 	public void setMessageDrivenContext(javax.ejb.MessageDrivenContext ctx) {
 		fMessageDrivenCtx = ctx;
 	}

 	/**
 	 * ejbCreate
 	 */
 	public void ejbCreate() {
 	}

 	/**
 	 * onMessage
 	 */
 	public void onMessage(javax.jms.Message msg) {
 		System.out.println("Inside On Message");
 		invokeProcess(msg);
 	}

 	/**
 	 * ejbRemove
 	 */
 	public void ejbRemove() {
 	}

 	/**
 	 * Invoke a PEAS process.
 	 */
 	public void invokeProcess(javax.jms.Message msg) {

 		FileWriter fw = null;
 		System.out.println("Inside InvokeProcess");
 		String PID =" ";
 		try {
 			if (msg instanceof TextMessage) {
 				System.out.println("inside IF "+ msg);
 				TextMessage message = (TextMessage) msg;
 				String xmlMsg = message.getText();
 				System.out.println("xmlMsg is :" + xmlMsg);
 				String inputFile ="requestParam_"+Utility.getDateTime()+".xml";
 				fw = new  FileWriter(inputFile);
 				
 				fw.write(xmlMsg); 				
 				fw.flush();
 				getXMLValidation(inputFile);
 				System.out.println("XML is :" + xmlMsg);

 				DOMParser parser = new DOMParser();
 				parser.parse(inputFile);
 				Document doc = parser.getDocument();
 				getValues(doc);

          		System.out.println("Values in Hash map" + startParamMap);
          		System.out.println("processName =: " + processName);
          		System.out.println("userID =: " + userID);
          		System.out.println("userRole =: " + userRole);
          		System.out.println("startParamMap =: " + startParamMap.size());


          		Iterator startParamItr = startParamMap.keySet().iterator();
          		while(startParamItr.hasNext()) {
          			String temp = (String) startParamItr.next();
          		    System.out.println( temp+ "-----" + startParamMap.get(temp));
          		}

          		System.out.println("WPSID = : " +processID);
 				PID = initiateNewProcess(processName, processID, userID, userRole, startParamMap);
 				sendInitStatus(processID, PID);
 				fw.close();
 			}
 			else {
 				System.out.println("Invalid message type" + msg.getClass());
 			}

 		}catch (Exception e) {
 			System.out.println("Exception occured 3-->" + e.getMessage());
 			try {
				fw.close();
				PID= " ";
 				sendInitStatus(processID, PID);
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}catch(JMSException ex){
 				System.out.println("Exception occured 3-->" + ex.getMessage());
 			
 			}
 		}
 	}

 	/**
 	 * Get a connection from Queue connection factory.
 	 * @param String connFact name
 	 * @return conn QueueConnection
 	 */
 	private QueueConnection getQueueConnection(String connFact)
 	{
 		QueueConnection conn = null;
 		try {
 			Context context = Utility.getInitialContext();
 			QueueConnectionFactory cf = (QueueConnectionFactory) context
 					.lookup(Utility.getConnectionFactoryName());
 			conn = cf.createQueueConnection();
 			//conn.start();
 			System.out.println("Inside getQueueConnection() Got the conn .."+conn);
 		}catch(Exception exp){
 			exp.printStackTrace();
 		}
 		return conn;
 	}

 	/**
 	 * Get the Destination queue
 	 * @param String queueName
 	 * @return dest Destination
 	 */
 	private Destination getDestinationQueue(String queueName){
 		Destination dest = null;
 		try {
 			Context context = Utility.getInitialContext();
 			dest = (Destination) context.lookup(queueName);
 			System.out.println("After Getting Queue .. " + dest);
 		}catch(Exception exp){
 			exp.printStackTrace();
 		}
 		return dest;
 	}


 	

 	/**
 	 * Initiate a new PEAS process using the process name.
 	 * @param String processName
 	 * @param String messageId
 	 * @param String userId
 	 * @param String userRole
 	 * @return initResp String
 	 */
 	private String initiateNewProcess(String processName,String messageId,String userID,String userRole, HashMap startParamMap) {
 		startParamMap.put("processName",processName);
 		startParamMap.put("WPS_MESSAGE_ID", messageId);
 		startParamMap.put("USER_ID",userID);
 		HashMap locn_param = new HashMap();

 		locn_param.put("SOLID", solID);

 		try {
 			System.out.println("\n\nAbout to Initiate PEAS");
 			PEASProcInstMgmtIF peasInst = initiatePeas();

 			if (null == peasInst) {
 				throw new WorkflowSysException(userID,
 						WorkflowSysExpConstants.ERROR_GENERAL);
 			}
 			System.out.println("\n\nProcess Started");
 			String initResp = peasInst.initiateNewProcess(processName,startParamMap,userID,userRole,locn_param);
 			System.out.println("Process Invoked with PID=" + initResp);
 			startParamMap.clear();
 			return initResp;

 		} catch (peas.client.api.intf.exception.PEASAPIException e) {
 			e.printStackTrace();
 			throw new WorkflowSysException(userID, e.getMessage(), e);
 		} catch (Exception ex) {
 			ex.printStackTrace();
 			throw new WorkflowSysException(userID,
 					WorkflowSysExpConstants.ERROR_GENERAL, ex);
 		}
 	}

 	
 	
 	
 	/**
 	 * Validating the Input XML with XSD
 	 * @param Input File
 	 * @throws Exception
 	 **/
 	public void getXMLValidation(String inputFile) throws Exception{
	
		SchemaFactory factory = SchemaFactory.newInstance("http://www.w3.org/2001/XMLSchema");
    	File schemaLocation = new File(PeasUtils.getPEASHome()
				+ File.separator + "Applications" + File.separator
				+ "defaultApp" + File.separator + "ApplicationConfig"
				+ File.separator + "requestParam.xsd");
	     Schema schema = factory.newSchema(schemaLocation);
	     Validator validator = schema.newValidator();
	     Source source = new StreamSource(inputFile);
         validator.validate(source);
         System.out.println(inputFile + " is valid.");
 	}
 	

 	/**
 	 * Send the PEAS process initiation status to response queue.
 	 * @param String WPSID
 	 * @param String PID
 	 * @throws JMSException
 	 */
 	private void sendInitStatus(String WPSID, String PID)
 			                      throws JMSException {

 	   QueueConnection conn = null;
 		QueueSession jmsSession = null;
 		MessageProducer producer = null;
 		try {
 			conn = getQueueConnection(Utility.getConnectionFactoryName());
 			Destination dest = getDestinationQueue(Utility.getResponseQueueName());
 			jmsSession = conn.createQueueSession(false,
 					Session.AUTO_ACKNOWLEDGE);
 			System.out.println("After Getting QueueSession .. " + jmsSession);
 			producer = jmsSession.createProducer(dest);
 			System.out.println("starting Connection");
 			conn.start();
 			System.out.println("going to create a XML message");
 			TextMessage message = jmsSession.createTextMessage();
 			System.out.println("Value of Text message"+message);
 			ResponseXMLCreator cXML=new ResponseXMLCreator();
 			System.out.println("Before XML call");
 			String xmlMsg = cXML.buildResponseXML( WPSID,  PID);
 			System.out.println("After XML call");
 			message.setStringProperty("TargetFunctionName","receivePEASID");
 			message.setText(xmlMsg);
 			System.out.println("MSG : "+xmlMsg);
 			producer.send(message);

 		} catch (Exception exp) {
 			exp.printStackTrace();
 		}
 		finally {
 			try {
 				if(producer != null)
 					producer.close();
 				if(jmsSession != null)
 					jmsSession.close();
 				if(conn != null)
 					conn.close();
 			}
 			catch(Exception e) {
 				e.printStackTrace();
 			}
 		}
 	}

 	
 	/**
 	 * Initiate the PEAS process Instance and return the reference.
 	 * @return PEASProcInstMgmtIF
 	 */
 	private static PEASProcInstMgmtIF initiatePeas() {
 		try {
 			InstanceMgmtFactoryIF instMgmtFactory = (InstanceMgmtFactoryIF) PEASClassLoader
 					.GetPEASClassLoader().getPEASAPIFactoryIF(
 							InstanceMgmtFactoryIF.FACTORY_NAME);
 			PEASProcInstMgmtIF receiver = instMgmtFactory
 					.getPEASProcInstMgmtIF();

 			return receiver;
 		} catch (Exception ex) {
 			throw new WorkflowSysException(sLogName, WorkflowSysExpConstants.ERROR_GENERAL, ex);
 		}
 	}


 	private static void getValues(Node node) {
 	     System.out.println(node.getNodeType());
 	     String name = node.getNodeName();

 	     switch (node.getNodeType()) {

 		     case Node.DOCUMENT_NODE:

 		     // recurse on each child
 		     NodeList nodes = node.getChildNodes();
 		     if (nodes != null) {
 		         for (int i=0; i<nodes.getLength(); i++) {
 		             getValues(nodes.item(i));
 		         }
 		     }
 		     break;

 			 case Node.ELEMENT_NODE:
 			     String name1 = node.getNodeName();
 			     NamedNodeMap attributes = node.getAttributes();
 			     for (int i=0; i<attributes.getLength(); i++) {
 			         Node current = attributes.item(i);
 			         if (node.getNodeName().equals(new String("processName"))) {
 			             processName = current.getNodeValue();
 			             System.out.println("processName: " + processName);
 			         }
 			     }

 			     // recurse on each child
 			     NodeList children = node.getChildNodes();

 			     if (children != null) {
 			         for (int i=0; i<children.getLength(); i++) {
 			             System.out.println("Printing Childern item" + children.item(i));
 			             getValues(children.item(i));
 			         }
 			     }


 			     break;

 			 case Node.TEXT_NODE:
 	//		     System.out.println("Inside Text node");
 			     if (!node.getNodeValue().trim().equals(new String(""))) {
 			         if (node.getParentNode().getLocalName().equals(new String("solID"))) {
 			              solID = (String) node.getNodeValue();
 			         } else if (node.getParentNode().getLocalName().equals(new String("userID"))) {
 			              userID = node.getNodeValue();
 			         } else if (node.getParentNode().getLocalName().equals(new String("userRole"))) {
 			              userRole = node.getNodeValue();
 			         } else if (node.getParentNode().getLocalName().equals(new String("processID"))) {
 			         	processID = node.getNodeValue();
 			         } else if (node.getParentNode().getLocalName().equals(new String("entityID"))) {
 			             String entityID = node.getNodeValue();
 			         } else if (node.getParentNode().getLocalName().equals(new String("timeZone"))) {
 			             String timeZone = node.getNodeValue();
 			             Node tmpNode = node.getNextSibling();
 			         } else if (node.getParentNode().getParentNode().getLocalName().equals(new String("startParam"))) {
 			             System.out.println("inside Start param");
 			             if (node.getParentNode().getLocalName().equals(new String("paramName"))) {
 				             paramName = node.getNodeValue();
 				             System.out.println("Indside 'strtparm' loop paramName := " + paramName);
 			             }
 			             if (node.getParentNode().getLocalName().equals(new String("paramValue"))) {
 				             paramValue = node.getNodeValue();
 				             System.out.println("Indside 'strtparm' loop paramValue := " + paramValue);
 				             startParamMap.put(processName+".StartParam."+paramName, paramValue);
 			             }

 			         }


 			             System.out.println("Get Node Value:"+node.getNodeValue());
 			     }
 			     break;
 	     }


  	}/**
      * @param string
      * @return
      */
     public static String startParamMap(String string) {
         // TODO Auto-generated method stub
         return null;
     }

 }
