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

public class TLCust_ScreenPop_Contacts extends CISHttpServlet {

    public static String CIS_COPYRIGHT_="Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.";
    public static String CIS_VERSION_="2.00 $Revision: 1.2 $";
	static String NL = "\n";
     protected void serviceRequest (HttpServletRequest req, HttpServletResponse resp) throws Exception
	 {


			PrintWriter out = resp.getWriter();
	        setContentType("text/html", resp);

	    java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();

		String strLocale = locale.toString();

	        boolean flag = false;

	        String messageFile = context.getSessionContext(req).getClientMessageFile();
	        String contactId = "";

	        String contactKey = req.getParameter("contactKey");

			if(contactKey == null || contactKey.equals("")){
				contactId = req.getParameter("contactId");
			       	if(contactId == null || contactId.equals(""))
					{
					 	 flag = true;
					 	 setError(flag,out);  //function invoked to display error message
		        	}
		        	else
					{
						  contDetails(contactId,req,out,messageFile);  //function invoked to display the customerdetails
					}
			} // ~ if end
			else
		    {
				contactId = convertKeyToId(contactKey,req); //invokes the function for conversion of key to id
				contDetails(contactId,req,out,messageFile);  //function invoked to display the customerdetails
		    }

       }// ~ service method

/************************************************************************************************/

		  /** This function is invoked to  display the details of tabs .
		    * This function takes customerId, req , PrintWriter, messageFile
			* as input.The tab names can be any one of the following or all.
			* customer,contact, incident, opportunities, Applications,campaigns,Rewards.
			* The tab names are case-insensitive.
		    */

		  public void contDetails(String contactId,HttpServletRequest req,PrintWriter out, String messageFile)
		  {

        java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();

	    String strLocale = locale.toString();

			/****************** This block retrieves the different tab names as parameter*****************/

			   StringBuffer buf = new StringBuffer();
			   String tab1 = req.getParameter("Tab1");
			   if(tab1==null || tab1.equals("")){
					tab1 = "";
			   }

			   String tab2 = req.getParameter("Tab2");
			   if(tab2==null || tab2.equals("")){
					tab2 = "";
			   }

			   String tab3 = req.getParameter("Tab3");
			   if(tab3==null || tab3.equals("")){
					tab3 = "";
			   }

			   String tab4 = req.getParameter("Tab4");
			   if(tab4==null || tab4.equals("")){
					tab4 = "";
			   }

			   String tab5 = req.getParameter("Tab5");
				   if(tab5==null || tab5.equals("")){
						tab5 = "";
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
				   * Opportunities, Contacts, Incidents, Banks
				   * The tab names are case-sensitive.
	               */

	                setPrimaryTab(tab1,buf,out,contactId); //invokes the function to display the appropriate tab as first tab with its details
				 	setTab(tab1,tab1,buf,out,contactId);  //invokes the function to display the appropriate tab with its details
				 	setTab(tab2,tab1,buf,out,contactId);
				 	setTab(tab3,tab1,buf,out,contactId);
				 	setTab(tab4,tab1,buf,out,contactId);
				 	setTab(tab5,tab1,buf,out,contactId);
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
	    } //


/************************ This is to display the error message when contact Id is null*************/

		 /** This function is invoked to  display the error message when contact Id is null
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
				      //out.println("No valid Contact Id or Contact Key");
                       out.println("showMessage(MSGJAVA_TL6);");
				       out.println("</center>");
				       out.println("</Body>");
				       out.println("</html>");

		   } // ~ if block
	     } // ~ setError
/***************************************** end *******************************************************/





/************************************************************************************************/

       /**  This function takes tabname, StringBuffer, Printwriter object and contactId
         *  as input. Depending on the tabname and contacts Id, it will
         *   display the appropriate frame in the ScreenPop frame
         */


	   public void setTab(String tabName, String defaultTab,StringBuffer buf,PrintWriter out, String contactId)
	   {
		    if(tabName.equalsIgnoreCase("opportunities") && !(defaultTab.equalsIgnoreCase("opportunities"))){
					 buf.append("tempFrm.frames(0).addTab(\"Opportunities\", '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Opportunities_For_Contact&Param1=" + contactId + "',false)" +NL);
		 	}

		 	else if(tabName.equalsIgnoreCase("incidents") && !(defaultTab.equalsIgnoreCase("incidents"))){
					 buf.append("tempFrm.frames(0).addTab(\"Incidents\", '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Incidents_For_Contact&Param1=" + contactId + "',false)" +NL);
		 	}

		 	else if(tabName.equalsIgnoreCase("Banks") && !(defaultTab.equalsIgnoreCase("Banks"))){
					 buf.append("tempFrm.frames(0).addTab(\"Other Banks/FI's\", '../../servlet/com.infy.cis.ui.admin.RelBanksList?ViewName=RelBanksForContact&Param1=" + contactId + "',false)" +NL);
			}
			else if(tabName.equalsIgnoreCase("contacts") && !(defaultTab.equalsIgnoreCase("contacts"))){
					 buf.append("tempFrm.frames(0).addTab(\"Contact Info\", '../../servlet/com.infy.cis.ui.common.allViews?viewname=UIContactDetails&param2=" + contactId + "',false)" +NL);
			}
			else if(tabName.equalsIgnoreCase("RelationshipSummary") && !(defaultTab.equalsIgnoreCase("RelationshipSummary"))){
					 buf.append("tempFrm.frames(0).addTab(\"Accounts Summary\", '../../servlet/com.infy.cis.ui.admin.ContactAcctRelationshipWizard?contactId=" + contactId + "',false)" +NL);
			}

	   } // ~ setTab

/***********************************************end**********************************************/


/******************************************function to display the first frame******************************************************/

        /**  This function takes tabname, StringBuffer, Printwriter object and customerId
          *  as input. Depending on the tabname and account Id, it will
          *  display the appropriate frame as First frame in the ScreenPop frame
          */

		 public void setPrimaryTab(String tabName, StringBuffer buf,PrintWriter out, String contactId)
		 {
		   if(!(tabName.equals(""))){
			   if(tabName.equalsIgnoreCase("Contacts")){
			   		 buf.append("tempFrm.frames(0).addTab(\"Contact Info\", '../../servlet/com.infy.cis.ui.common.allViews?viewname=UIContactDetails&param2=" + contactId + "',false)" +NL);
		       }
			   else if(tabName.equalsIgnoreCase("Opportunities")){
			   		 buf.append("tempFrm.frames(0).addTab(\"Opportunities\", '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Opportunities_For_Contact&Param1=" + contactId + "',false)" +NL);
		       }
			   else if(tabName.equalsIgnoreCase("Incidents")){
			   	     buf.append("tempFrm.frames(0).addTab(\"Incidents\", '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Incidents_For_Contact&Param1=" + contactId + "',false)" +NL);
			   }
			   else if(tabName.equalsIgnoreCase("Banks")){
			   		 buf.append("tempFrm.frames(0).addTab(\"Other Banks/FI's\", '../../servlet/com.infy.cis.ui.admin.RelBanksList?ViewName=RelBanksForContact&Param1=" + contactId + "',false)" +NL);
			   }
			   else if(tabName.equalsIgnoreCase("RelationshipSummary")){
				   buf.append("tempFrm.frames(0).addTab(\"Accounts Summary\", '../../servlet/com.infy.cis.ui.admin.ContactAcctRelationshipWizard?contactId=" + contactId + "',false)" +NL);
			   }
	       } // ~ if block
	       else
	       {
			  	buf.append("tempFrm.frames(0).addTab(\"Contact Info\", '../servlet/com.infy.cis.ui.common.allViews?viewname=UIContactDetails&param2=" + contactId + "',false)" +NL);
		   }
         } //~ end of setPrimaryTab method

/***********************************************end*************************************************/


/************************************function to convert key to id************************************************************/

       /** This method takes contactskey as input,
         * converts the key into contactsId and
         * returns the key as string
         */

	   public String convertKeyToId(String contactKey,HttpServletRequest req)throws Exception
	   {
				ArrayList docAttrList = new ArrayList();
				docAttrList.add(QueryAssist.getTransformFn("ContactBO", ContactBO.CONTACTID));
				SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("ContactBO",ContactBO.CONTACTID);
				QueryAssist.addSimpleCondition(qbAccount,"ContactBO",ContactBO.CONTACTSKEY,IQuery.ComparisonOperation_EQ,""+contactKey);
			  	qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
				SRMBusinessContext bc = Utils.getBusinessContext(req,java.sql.Connection.TRANSACTION_READ_UNCOMMITTED);
				SRMQueryResult qrChecklist = qbAccount.runQuery(bc, false, -1);
				SRMRecordSet rsChecklist = qrChecklist.getRecordSet();

				Integer accId=new Integer(0);
				  if(rsChecklist.hasNext() )
				  {
				   		accId = (Integer)(rsChecklist.getNext().get(0));
				  }//end of if
		       String contactId = accId.toString();
		       return contactId;
	 }
/***********************************************end**********************************************/
}
