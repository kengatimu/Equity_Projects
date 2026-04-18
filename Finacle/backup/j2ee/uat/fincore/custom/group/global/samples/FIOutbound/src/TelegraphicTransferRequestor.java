/**
 * TelegraphicTransferRequestor.java
 *
 * COPYRIGHT NOTICE:
 * Copyright (c) 2004 Infosys Technologies Limited, Electronic City,
 * Hosur Road, Bangalore - 560 100, India.
 * All Rights Reserved.
 *
 * This software is the confidential and proprietary information of
 * Infosys Technologies Ltd. ("Confidential Information"). You shall
 * not disclose such Confidential Information and shall use it only
 * in accordance with the terms of the license agreement you entered
 * into with Infosys.
 */

/**
* This class contains code for Finacle Core Requestor Class
*
* @since FCORE 10.0
* @author Meenakshi Naik
**/

package com.infosys.ci.ons.fijlimo.custom;

import java.util.*;
import java.io.ByteArrayInputStream;
import java.io.IOException;

import com.infy.COTP.LinkList;
import com.infosys.ci.ons.fijlimo.client.AbstractFIRequestor;
import com.infosys.ci.fijlimo.common.FIReqOutputMesg;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;
import org.w3c.dom.NodeList;
import org.w3c.dom.Document;
import fabclasses.CommonFunctions;

public class TelegraphicTransferRequestor extends AbstractFIRequestor
{
	static 	String accntNum ="";
	static String actionCode="";

	/**
	 * Formats the input for the telegraphic request
	 * @param inputVal Map
	 * @return String formatted request string
	 */
	public String formatInput(Map inputVal)
	{
		Set vals = inputVal.keySet();
		Iterator itr = vals.iterator();
		String paramName = "";

		//formatting the input Message
		String reqType = (String)this.getRequestParameters(null).get("SERVICEREQUESTID");
		StringBuffer inputMessage=new StringBuffer("<BODY>");
		inputMessage.append("<"+reqType+">");
		String qualifier = "cc:";
		int n=0;
		while(itr.hasNext()){
			paramName= (String)itr.next();
			if(paramName.equals("SuccessOrFailure") || paramName.equals("pagename") ||
			        paramName.equals("actionCode") || paramName.equals("tlgxfer.funcCode")|| paramName.equals("tabName"))
			{
				if(paramName.equals("actionCode"))
				{
					/*return if the this class is called from the criteria page*/
					if(inputVal.get(paramName).toString().equalsIgnoreCase(("Accept")))
					{
						/* saving data from the criteria page */
						this.actionCode =(String)inputVal.get("tlgxfer.funcCode");

						/* saving data from the criteria page */
						accntNum = (String)inputVal.get("acctNum");
						inputVal.clear();
						if(accntNum == null || accntNum.trim().length()<1)
							inputVal.put("SuccessOrFailure","N");
						else
							inputVal.put("SuccessOrFailure","Y");
						return null;
					}
				}
				continue;
			}
			if(n>0)
				inputMessage.append("<"+qualifier+paramName+">"+inputVal.get(paramName)+"</"+qualifier+paramName+">");
			n++;
		}
		inputMessage.append("</"+reqType+">");
		inputMessage.append("</BODY>");

		if(inputMessage == null)
		{
			inputVal.put("SuccessOrFailure","N");
			return null;
		}
		else
			return  inputMessage.toString();
	}

	/**
	 * Formatting the response obtained
	 * @param dataHm Map
	 * @param outputMsgLL LinkList
	 * @param errLL LinkList
	 */
	public void formatOutput(Map dataHm, LinkList outputMsgLL,LinkList errLL)
	{
		Document document = null;
		try
		{
			FIReqOutputMesg responseMsg =  (FIReqOutputMesg)outputMsgLL.get(0);
			String[] tagToGet = new String[2];

			String responseXMLStr = responseMsg.outputMessage;
			ByteArrayInputStream responseXMLMsg = new ByteArrayInputStream(responseXMLStr.getBytes());
			DocumentBuilderFactory factory =  DocumentBuilderFactory.newInstance();
			factory.setValidating(false);
			DocumentBuilder parser = factory.newDocumentBuilder();

			/* Setting the error handler */
			//ErrorHandler errorHandler = new ParserErrorHandler();
			//parser.setErrorHandler(errorHandler);

			/* Parsing the xml string */
			document = parser.parse(responseXMLMsg);
			NodeList statusList = null;
			NodeList tranList = null;
			String tranId = null;
			statusList = document.getElementsByTagName("STATUS");
			String status = statusList.item(0).getChildNodes().item(0).getNodeValue();

			/* Determining the status of the request */
			if(status != null && status.equalsIgnoreCase("0"))
			{
				dataHm.put("SuccessOrFailure","Y");
				tagToGet[0] = "TRANID";
				tranList = document.getElementsByTagName(tagToGet[0]);
				tranId = tranList.item(0).getChildNodes().item(0).getNodeValue();
				dataHm.put("tranNum",tranId);
				String action = null;

				if(actionCode.equalsIgnoreCase("A"))
					action = "added";
				else if(actionCode.equalsIgnoreCase("M"))
					action = "modified";
				else if(actionCode.equalsIgnoreCase("D"))
					action = "deleted";
				else if(actionCode.equalsIgnoreCase("V"))
					action = "verified";
				else
					action = "executed";
				String message = "Telegraphic Transfer Instruction successfully "+action+" for A/c ID: "+accntNum;
				dataHm.put("RESULT_MSG",message);

			}
			else
			{
				dataHm.put("SuccessOrFailure","N");
				tagToGet[0] = "ERRORCODE";
				tagToGet[1] = "ERRORDESC";
				String errMsg = "";
				for(int ind = 0; ind < tagToGet.length; ind++)
				{
					statusList = document.getElementsByTagName(tagToGet[ind]);
					errMsg = errMsg+"\n"+statusList.item(0).getChildNodes().item(0).getNodeValue();
				}
				CommonFunctions.populateErrorLL(errLL,"FTL0000081","Telegraphic Transfer Instruction failed for A/c ID: "+accntNum+"\n"+errMsg,null);
			}
		}
		catch(SAXException saxe)
		{
			CommonFunctions.populateErrorLL(errLL,"FTL0000081","SAXException while parsing the response\n"+saxe.toString(),null);
		}
		catch(IOException ioe)
		{
			CommonFunctions.populateErrorLL(errLL,"FTL0000081","IOException while parsing the response\n"+ioe.toString(),null);
		}
		catch(ParserConfigurationException pcfge)
		{
			CommonFunctions.populateErrorLL(errLL,"FTL0000081","ParserConfigurationException while parsing the response\n"+pcfge.toString(),null);
		}
		catch(Throwable te)
		{
			CommonFunctions.populateErrorLL(errLL,"FTL0000081","General exception while parsing the response\n"+te.toString(),null);
		}
	}

	/**
	 * Setting request parameters
	 * @param inputData Map
	 * @return Map
	 */
	public Map getRequestParameters(Map inputData)
	{
		Map mapReqDet = new HashMap();
        mapReqDet.put("SERVICEREQUESTID","TELEGRAPHIC_TRANSFER");
		mapReqDet.put("SERVICEREQUESTVERSION","11.0");
		mapReqDet.put("MESSAGEDATETIME",this.getCurrentTime());
		mapReqDet.put("BANK_ID","01");
		return mapReqDet;
	}

	/**
	 * Preprocessing data
	 * @param inputData Map
	 */
	public void preprocess(Map inputData) {
	}
}
