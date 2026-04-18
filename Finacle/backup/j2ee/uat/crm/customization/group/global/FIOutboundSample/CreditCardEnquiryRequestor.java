/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CreditCardEnquiryRequestor.java $
 *
 * Author: Amit_pundeer
 *
 * $Archive: /FCRM100/com/infy/cis/custom/FIOutboundSample/CreditCardEnquiryRequestor.java $
 *
 * $History: CreditCardEnquiryRequestor.java $

 ******************************************************************************/

package com.infy.cis.custom;



import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

import com.infosys.insulate.util.HashMap;
import com.infosys.insulate.util.Vector;
import com.infosys.insulate.util.ArrayList;
import com.infosys.insulate.util.HashSet;
import com.infosys.insulate.util.TreeSet;
import com.infosys.insulate.util.IdentityHashMap;
import com.infosys.insulate.util.LinkedHashMap;
import com.infosys.insulate.util.LinkedHashSet;
import com.infosys.insulate.util.LinkedList;
import com.infosys.insulate.util.Stack;
import com.infosys.insulate.util.TreeMap;
import com.infosys.insulate.util.WeakHashMap;
import com.infosys.insulate.util.PriorityQueue;
import java.lang.*;
import com.infosys.ci.fioutbound.client.*;
import com.infy.cis.custom.CreditCardRequestor.*;
import com.infy.cis.servletruntime.*;
import com.infy.cis.adaptor.web.WebAdaptor;


public class CreditCardEnquiryRequestor extends CISHttpServlet{



	public void serviceRequest(HttpServletRequest request,HttpServletResponse response)
             throws ServletException, IOException
      {

		PrintWriter out 	          = response.getWriter();
		String title 				  = "CRM REQUESTOR";

		try
		{
		 response.setContentType("text/html");
		 String CreditCardNumber 	  = request.getParameter("CreditCardNo");
		 //Getting UserId from session context
		 CISSessionContext  sc 	      = ((com.infy.cis.servletruntime.CISSessionContext) com.infy.cis.common.SRMTLVar.sc.get());

		 String userId     	   		  = sc.getAgentName();
		 //Creating Input Message
		 String inputMessage  		  = "<InputMesg>CreditCardNumber,"+CreditCardNumber+"</InputMesg>" ;

		 //calling Requestor
		 ReqOutputMesg outMsg  		  = new ReqOutputMesg();
		 CreditCardRequestor CrmRequestor 	  = new CreditCardRequestor();
		 int iReturn = CrmRequestor.SendMesg(userId,inputMessage,outMsg);
		 String outputMsg = outMsg.outputMessage;

		 if (iReturn==0)
			{
				out.println(title);
				out.println("</TITLE></HEAD><BODY>");
				out.println("<P>CREDIT CARD NUMBER ::"+CreditCardNumber+"</P>");

				String inputInfo = outputMsg.substring(outputMsg.indexOf("<InputMessage>")+14,outputMsg.indexOf("</InputMessage>"));

				StringTokenizer st = new StringTokenizer(inputInfo,"|");
				while (st.hasMoreTokens())
				{
					String token = st.nextToken();
					out.println("<P>" + token.substring(0,token.indexOf(",")) + "::" +token.substring(token.indexOf(",")+1,token.length())+"</P>");
				}

			out.println("</BODY></HTML>");
			out.close();
			}
		 else
			{
			out.println(title);
			out.println("</TITLE></HEAD><BODY>");
			out.println("<P>Credit Card Number: "+CreditCardNumber+"</P>");
			out.println("<P><H3>Error:</H3> "+outMsg.outputMessage+"</P>");
			out.println("</BODY></HTML>");
			out.close();
			}
		}

		catch(Exception e)
		{
		 out.println(title);
		 out.println("</TITLE></HEAD><BODY>");
		 out.println("<P>ERROR: "+e+" </P>");
		 out.println("</BODY></HTML>");
		 out.close();
		 WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "EXCEPTION IN CreditCardEnquiryRequestor:"+e);
		}

	}
}