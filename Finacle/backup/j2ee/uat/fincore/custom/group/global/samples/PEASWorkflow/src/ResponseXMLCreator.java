
/*
 * Created on Jan 12, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

package com.infy.finacle.workflow.mdb.processinitiate;
 


import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

//import java.util.ArrayList;
//import java.util.Iterator;
//import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
//import org.w3c.dom.Text;

//For jdk1.5 with built in xerces parser
import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;

import com.infy.finacle.workflow.mdb.common.Utility;

//For JDK 1.3 or JDK 1.4  with xerces 2.7.1
//import org.apache.xml.serialize.XMLSerializer;
//import org.apache.xml.serialize.OutputFormat;



/**
 * @author Tamilselvan.R
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */


public class ResponseXMLCreator{
    public String buildResponseXML(String WPSID, String PID){
         String root = "Response";
	    DocumentBuilderFactory documentBuilderFactory =
	                                   DocumentBuilderFactory.newInstance();
	        DocumentBuilder documentBuilder = null;
            try {
                documentBuilder = documentBuilderFactory.newDocumentBuilder();
            } catch (ParserConfigurationException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            Document document = documentBuilder.newDocument();
	        Element rootElement = document.createElement(root);
	        document.appendChild(rootElement);
	        //create ProcessID node
	        String processID = "processID";
	        Element processIDEm = document.createElement(processID);
	        processIDEm.appendChild(document.createTextNode(WPSID));
	        rootElement.appendChild(processIDEm);

//	      create PeasID node
	        String peasID = "peasID";
	        Element peasIDEm = document.createElement(peasID);
	        peasIDEm.appendChild(document.createTextNode(PID));
	        rootElement.appendChild(peasIDEm);
	        String outPut = printToFile(document);
	        System.out.println("Going to return this from buildResponseXML: " + outPut);
	        return outPut;
    }

		private String printToFile(Document dom){
		    String outPut="";
		    FileInputStream fileInput=null;
		    BufferedReader bufferedReader=null;
		try
		{
			//print
			OutputFormat format = new OutputFormat(dom);
			format.setIndenting(false);

			//to generate output to console use this serializer
			//XMLSerializer serializer = new XMLSerializer(System.out, format);

			File fileName=new File("Response_"+Utility.getDateTime()+".xml");
			//to generate a file output use fileoutputstream instead of system.out
			XMLSerializer serializer = new XMLSerializer(
			new FileOutputStream(fileName), format);

			serializer.serialize(dom);
			fileInput = new FileInputStream(fileName);
			bufferedReader= new BufferedReader(new InputStreamReader(fileInput));

			String thisLine;
			
			while ((thisLine = bufferedReader.readLine()) != null) {
				outPut = outPut + thisLine;
			}

			System.out.println("Going to return this : " + outPut);
			bufferedReader.close();
			fileInput.close();
			 return outPut; 

		} catch(IOException ie) {
		    ie.printStackTrace();
		}catch (RuntimeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return outPut;
	}

}
