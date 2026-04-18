package com.infy.cis.custom;


import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
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
import com.infy.cis.ui.common.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.servletruntime.*;


public class TLCust_ScreenPop_Prospect extends CISHttpServlet {

    public static String CIS_COPYRIGHT_="Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.";
    public static String CIS_VERSION_="2.00 $Revision: 1.1 $";
	static String NL = "\n";

    protected void serviceRequest(HttpServletRequest req, HttpServletResponse resp)throws Exception
	{

		PrintWriter out = resp.getWriter();
	    setContentType("text/html", resp);
	    String messageFile = context.getSessionContext(req).getClientMessageFile();

	    java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();

		String strLocale = locale.toString();

        String prospectId="";
        String prospectKey = "";

        prospectKey = req.getParameter("prospectKey");
        boolean flag = false;


        if(prospectKey == null || prospectKey.equals("")){
			prospectId = req.getParameter("prospectId");
			     if(prospectId == null || prospectId.equals(""))
				  {

				 		 flag = true;
				 		 setError(flag,out);  //function invoked to display error message
			      }
			      else
			      {
					  prospectDetails(prospectId,req,out,messageFile);  //function invoked to display the prospectdetails
				  }
	     } // ~ if end
		 else
		 {
			 prospectId = convertKeyToId(prospectKey,req); //invokes the function for conversion of key to id
			 prospectDetails(prospectId,req,out,messageFile);  //function invoked to display the prospectdetails
		 }


     } // ~ service method



/************************************************************************************************/

		  /** This function is invoked to  display the details of tabs .
		    * This function takes prospectId, req , PrintWriter, messageFile
			* as input.The tab names can be any one of the following or all.
			* prospects,events.The tab names are case-insensitive.
			*/

		  public void prospectDetails(String prospectId,HttpServletRequest req,PrintWriter out, String messageFile)
		  {

        java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();

	    String strLocale = locale.toString();
				boolean flag = false;
				String salesId = "";
				String salesUrl = "";
				StringBuffer buf = new StringBuffer();
	   	  /****************** This block retrieves the different tab names as parameter*****************/


			        String tab1 = req.getParameter("Tab1");
					if(tab1==null || tab1.equals("")){
							tab1 = "";
					}

				    String tab2 = req.getParameter("Tab2");
				    if(tab2==null || tab2.equals("")){
					   	    tab2 = "";
					}

		 /************************************** end ***********************************************/



				        buf.append(
			              " <HTML>" +NL+
			              " <HEAD>" +NL+
			              " <TITLE>" +NL+
			              	this.getSystemString("Default", "Title") +NL+
			              " </TITLE>" +NL+
			              " <SCRIPT type=\"text/javascript\" src=\""+ messageFile+"\" language=\"javascript\"></SCRIPT>"+NL+
						  "<SCRIPT>var finaclecrmlocale='"+strLocale+"'</SCRIPT>"+NL+
						  " <SCRIPT SRC='../common/js/SRMDynamicTabsView.js'></SCRIPT>"+NL+
			              " <SCRIPT>" +NL+

			              "  defTabs = new Array();" +NL+
			              "  defTabsURL = new Array();" +NL+
              			  "  function init() {" +NL);

		  /************************************************************************************************/

									  /** This function is invoked to  display the appropriate tab with its details
										* The tab names can be any one of the following or all.
										* prospects,events.The tab names are case-sensitive.
										*/

										setPrimaryTab(tab1,buf,out,prospectId); //invokes the function to display the appropriate tab as first tab with its details
										setTab(tab1,tab1, buf,out,prospectId);  //invokes the function to display the appropriate tab with its details
										setTab(tab2,tab1, buf,out,prospectId);




		 /***************************************** end *******************************************************/



              			  buf.append(

						  "  tempFrm.selectTab(\"" +tab1+"\");" +NL+
		                  "  }" +NL+
						  "  </SCRIPT>" +NL+
						  "  </HEAD>" +NL+
						  "  <FRAMESET onload=init() frameborder='no' BORDER=0 FRAMESPACING=0 name='LookupPopup'>" + NL );
						  buf.append("  <FRAME frameborder='no' name='tempFrm' id='tempFrm' src= '../wizards/html/ScreenPopDynamicWizard.html'>" +NL+
		                  "  </FRAMESET>" + NL +
						  "  </HTML>" );
						  out.println (buf.toString());
						  out.close();
	       }




/************************ This is to display the error message when prospect Id is null*************/

		 /** This function is invoked to  display the error message when prospect Id is null
		   * This function takes boolean value and PrintWriter object as input
		   * If the boolean flag is true it will display the error message
		   */

		 public void setError(boolean flag,PrintWriter out)
		 {

	    java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();

		String strLocale = locale.toString();
		   if(flag == true)
		   {
			   out.println("<HTML>");
			   out.println("<TITLE>");
			   out.println(this.getSystemString("Default", "Title"));
			   out.println("</TITLE>");
			   out.println("<HEAD>");
			   out.println("<Body>");
			   out.println("<BR><BR><BR><BR>");
			   out.println("<center>");
    		   out.println("<SCRIPT LANGUAGE='javascript' src=\"../cis/custom/js/Message_custom_"+strLocale+".js \"></SCRIPT>" );
			  // out.println("Error...");
			   out.println("showMessage(MSGJAVA_TL2);");
			  //out.println("No valid Prospect Id or Prospect Key");
			   out.println("showMessage(MSGJAVA_TL1);");
			   out.println("</center>");
			   out.println("</Body>");
			   out.println("</html>");

		   } // ~ if block
		 } // ~ setError

/***************************************** end *******************************************************/


/************************************function to convert key to id************************************************************/

		   /** This method takes prospectkey as input,
			 * converts the key into prospectId and
			 * returns the key as string
			 */

		   public String convertKeyToId(String prospectKey,HttpServletRequest req)throws Exception
		   {
				ArrayList docAttrList = new ArrayList();
				docAttrList.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.SUSPECTID));
				SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("SuspectBO",SuspectBO.SUSPECTID);
				QueryAssist.addSimpleCondition(qbAccount,"SuspectBO",SuspectBO.SUSPECTSKEY,IQuery.ComparisonOperation_EQ,""+prospectKey);
			   	qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
				SRMBusinessContext bc = Utils.getBusinessContext(req,java.sql.Connection.TRANSACTION_READ_UNCOMMITTED);
				SRMQueryResult qrChecklist = qbAccount.runQuery(bc, false, -1);
				SRMRecordSet rsChecklist = qrChecklist.getRecordSet();

				Integer prosptId=new Integer(0);
					if(rsChecklist.hasNext() )
					{
						prosptId = (Integer)(rsChecklist.getNext().get(0));
					}//end of if
				String prospectId = prosptId.toString();
				return prospectId;
		   } // end of convertKeyToId

/********************************************end ****************************************************/



		   /**  This function takes tabname, defaultTab, StringBuffer, Printwriter object and prospectId
			 *  as input. Depending on the tabname and prospect Id, it will
			 *  display the appropriate frame in the ScreenPop frame
			 */


		   public void setTab(String tabName, String defaultTab,StringBuffer buf,PrintWriter out, String prospectId)
		   {


			   if(tabName.equalsIgnoreCase("prospects") && !(defaultTab.equalsIgnoreCase("prospects"))){

						/* Changes for Tracker #98450 - Begin */
						buf.append("tempFrm.frames(0).addTab('Prospect Info', '../../servlet/com.infy.cis.ui.common.allViews?viewname=UISuspectDetails&param2=" + prospectId + "',false)" +NL);
						/* Changes for Tracker #98450 - End */
				}
				else if(tabName.equalsIgnoreCase("events") && !(defaultTab.equalsIgnoreCase("events"))){
						 buf.append("tempFrm.frames(0).addTab('Events', '../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=ViewEvents&Param3=" + prospectId + "',false)" +NL);
				}



		   }// ~ setTab method

/***********************************************end*************************************************/


/******************************************function to display the first frame******************************************************/

			/**  This function takes tabname, StringBuffer, Printwriter object and prospectId
			  *  as input. Depending on the tabname and prospect Id, it will
			  *  display the appropriate frame as First frame in the ScreenPop frame
			  */

			 public void setPrimaryTab(String tabName, StringBuffer buf,PrintWriter out, String prospectId)
			 {
			   if(!(tabName.equals(""))){
				   if(tabName.equalsIgnoreCase("Prospects")){
						/* Changes for Tracker #98450 - Begin */
						buf.append("tempFrm.frames(0).addTab(\"Prospect Info\", '../../servlet/com.infy.cis.ui.common.allViews?viewname=UISuspectDetails&param2=" + prospectId + "',false)" +NL);
						/* Changes for Tracker #98450 - End */
				   }
					else if(tabName.equalsIgnoreCase("Events")){
						buf.append("tempFrm.frames(0).addTab(\"Events\", '../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=ViewEvents&Param3=" + prospectId + "',false)" +NL);
					}

			   } // ~ if block
			   else if(tabName.equals(""))
			   {

					buf.append("tempFrm.frames(0).addTab(\"Prospect Info\", '../servlet/com.infy.cis.ui.common.allViews?viewname=UISuspectDetails&param2=" + prospectId + "',false)" +NL);
			   }
			} //~ end of setPrimaryTab method

/***********************************************end*************************************************/


} // ~ main class
