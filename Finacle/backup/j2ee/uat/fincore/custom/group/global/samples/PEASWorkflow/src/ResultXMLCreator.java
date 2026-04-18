/*
 * Created on Jan 25, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Generation - Code and Comments
 */
package com.infy.finacle.workflow.mdb.processcomplete;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Text;

//For jdk1.5 with built in xerces parser
import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;

import com.infy.finacle.workflow.mdb.common.Utility;

//For JDK 1.3 or JDK 1.4 with xerces 2.7.1
//import org.apache.xml.serialize.XMLSerializer;
//import org.apache.xml.serialize.OutputFormat;


/**
 * @author Tamilselvan.R
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */


public class ResultXMLCreator {
	public static String nodeValue;
	
	List outputValues;
	
	Document dom;
	
	public ResultXMLCreator(HashMap outputParameters) {
		System.out.println("Inside constructors: Output parameters are"
				+ outputParameters.size() + "/n contents" + outputParameters);
		outputValues = new ArrayList();
		loadData(outputParameters);
		createDocument();
	}
	
	public String procCompleteTree(String pid) {
		System.out.println("Started with Pid .. " + pid);
		createDOMTree(pid);
		String xmlMsg = printToFile();
		//		printToFile();
		System.out.println("Generated file successfully.");
		return xmlMsg;
	}
	
	/**
	 * Add a list of books to the list In a production system you might populate
	 * the list from a DB
	 */
	private void loadData(HashMap outputParameters) {
		System.out.println("Inside Load Data: Output parameters are"
				+ outputParameters.size() + "/n contents" + outputParameters);
		Set set = outputParameters.keySet();
		Iterator outputParamItr = set.iterator();
		int i = 1;
		
		while (outputParamItr.hasNext()) {
			String keys = (String) outputParamItr.next();
			System.out.println("Keys=:" + keys + ", Values=:"
					+ (String) outputParameters.get(keys));
			outputValues.add(new OutputUtility(keys, (String) outputParameters
					.get(keys)));
			i++;
		}
	}
	
	/**
	 * Using JAXP in implementation independent manner create a document object
	 * using which we create a xml tree in memory
	 */
	private void createDocument() {		
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		try {
			DocumentBuilder db = dbf.newDocumentBuilder();
			dom = db.newDocument();
			
		} catch (ParserConfigurationException pce) {
			System.out
			.println("Error while trying to instantiate DocumentBuilder "
					+ pce);
			System.exit(1);
		}
	}
	
	/**
	 * The real workhorse which creates the XML structure
	 * 
	 * @param pID
	 */
	private void createDOMTree(String pid) {
		Element resultElement = createResult();
		Element pidElement = createPeasId(pid);
		Element rootElement = dom.createElement("Output");
		dom.appendChild(rootElement);
		Iterator outputValuesItr = outputValues.iterator();
		rootElement.appendChild(resultElement);
		rootElement.appendChild(pidElement);
		boolean flag = true;
		while (outputValuesItr.hasNext()) {
			OutputUtility outputUtilityObj = (OutputUtility) outputValuesItr
			.next();
			Element outParamElement = createOutParamElement(outputUtilityObj);
			rootElement.appendChild(outParamElement);
		}
		String Stdom = dom.toString();
		System.out.println("STDOM" + dom);
	}
	
	/**
	 * Helper method which creates a XML element <Book>
	 * 
	 * @param b
	 *            The book for which we need to create an xml representation
	 * @param pID
	 * @return XML element snippet representing a book
	 */
	private Element createResult() {
		
		Element resultElement = dom.createElement("Result");
		Text resultText = dom.createTextNode("Success");
		resultElement.appendChild(resultText);
		
		return resultElement;
		
	}
	
	private Element createPeasId(String pID) {
		Element pidElement = dom.createElement("PID");
		Text pidText = dom.createTextNode(pID);
		pidElement.appendChild(pidText);
		return pidElement;
		
	}
	
	private Element createOutParamElement(OutputUtility outputUtilityObj) {
		Element outParamElement = dom.createElement("OutParam");
		Element pNameElement = dom.createElement("paramName");
		Text paramName = dom.createTextNode(outputUtilityObj.getparamName());
		pNameElement.appendChild(paramName);
		outParamElement.appendChild(pNameElement);
		Element pValueElement = dom.createElement("paramValue");
		Text paramValue = dom.createTextNode(outputUtilityObj.getparamValue());
		pValueElement.appendChild(paramValue);
		outParamElement.appendChild(pValueElement);
		
		return outParamElement;
		
	}
	
	/**
	 * This method uses Xerces specific classes prints the XML document to file.
	 */
	private String printToFile() {
		String xmlMesg = "";
		FileInputStream in = null;
		BufferedReader d = null;
		
		try {
			OutputFormat format = new OutputFormat(dom);
			format.setIndenting(true);
			File file = new File("Output_" + Utility.getDateTime() + ".xml");
			XMLSerializer serializer = new XMLSerializer(new FileOutputStream(
					file), format);
			
			serializer.serialize(dom);
			
			in = new FileInputStream(file);
			d = new BufferedReader(new InputStreamReader(in));
			
			String thisLine;
			
			while ((thisLine = d.readLine()) != null) {
				xmlMesg = xmlMesg + thisLine;
			}
			
			System.out.println("Going to return this : " + xmlMesg);
			in.close();
			d.close();
			
		} catch (IOException ie) {
			ie.printStackTrace();
		}
		return xmlMesg;
	}
	
}
