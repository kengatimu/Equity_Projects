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

public class TLCust_ScreenPop_Incident extends CISHttpServlet {
    public static String CIS_COPYRIGHT_="Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.";

    public static String CIS_VERSION_="2.00 $Revision: 1.1 $";
	static String NL = "\n";

       protected void serviceRequest (HttpServletRequest req, HttpServletResponse resp)
	        throws Exception
	    {
			PrintWriter out = resp.getWriter();
	        setContentType("text/html", resp);

	        String messageFile = context.getSessionContext(req).getClientMessageFile();
	         SRMBusinessContext bc = Utils.getBusinessContext(req,java.sql.Connection.TRANSACTION_READ_UNCOMMITTED);

	        java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();

		    String strLocale = locale.toString();

			boolean flag = false;
			String asscContactId = "";
			String asscCustId = "";
			String asscProspectId = "";

	        String incidentId = "";
	        String incidentKey = req.getParameter("incidentKey");


			 if(incidentKey == null || incidentKey.equals("")){
			      incidentId = req.getParameter("incidentId");
				           if(incidentId == null || incidentId.equals(""))
				  		   {
				  					 flag = true;
				  					 setError(flag,out);  //function invoked to display error message
					       }
					       else
					       {
							   // only KEYS are supported
							   //inciDetails(incidentId,req,out,messageFile,bc);  //function invoked to display the incidentdetails
						   }
		     } // ~ if end
		     else
		     {

				List ls = getIncidentForID(incidentKey,req,bc);
				if( ls != null )
				{
					Integer asscId=new Integer(0);
					try
					{
					   asscId = (Integer)(ls.get(0));
					   incidentId = asscId.toString();
					}
					catch( Exception e )
					{
					   incidentId = "0";
					}
					try
					{
					   asscId = (Integer)(ls.get(1));
					   asscCustId = asscId.toString();
					}
					catch( Exception e )
					{
					   asscCustId = "";
					}

					try
					{
					   asscId = (Integer)(ls.get(2));
					   asscContactId = asscId.toString();
					}
					catch( Exception e )
					{
						asscContactId = "";
					}

					try
					{
						asscId = (Integer)(ls.get(3));
						asscProspectId = asscId.toString();
					}
					catch( Exception e )
					{
						asscProspectId = "";
					}
				}
				else
				{
					incidentId = "0";
					asscCustId = asscContactId = asscProspectId = "";
				}

				inciDetails(incidentId,req,out,messageFile,bc,asscCustId,asscContactId,asscProspectId);  //function invoked to display the incidentdetails

			 }

          }//~ service



	/************************************************************************************************/

		  /** This function is invoked to  display the details of tabs .
		    * This function takes customerId, req , PrintWriter, messageFile
			* as input.The tab names can be any one of the following or all.
			* customer,contact, incident, opportunities, Applications,campaigns,Rewards.
			* The tab names are case-insensitive.
		    */

		  public void inciDetails(String incidentId,HttpServletRequest req,PrintWriter out, String messageFile,SRMBusinessContext bc,String asscCustId,String asscContactId,String asscProspectId)
		  {

        java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();

	    String strLocale = locale.toString();				/****************** This block retrieves the different tab names as parameter*****************/
				StringBuffer buf = new StringBuffer();

				String tab1 = req.getParameter("Tab1");
				if(tab1==null || tab1.equals("")){
					tab1 = "Incident";
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
				  * Customer,Contacts, Opportunities, KBEntries, Products,Incidents
				  * The tab names are case-sensitive.
				  */
						setPrimaryTab(tab1,buf,out,incidentId,req,bc,asscCustId,asscContactId,asscProspectId); //invokes the function to display the appropriate tab as first tab with its details
						setTab(tab1,tab1,buf, out,incidentId,req,bc,asscCustId,asscContactId,asscProspectId); //invokes the function to display the appropriate tab with its details
						setTab(tab2, tab1,buf,out,incidentId,req,bc,asscCustId,asscContactId,asscProspectId);
						setTab(tab3, tab1,buf,out,incidentId,req,bc,asscCustId,asscContactId,asscProspectId);
						setTab(tab4, tab1,buf,out,incidentId,req,bc,asscCustId,asscContactId,asscProspectId);


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

	/************************ This is to display the error message when incident Id is null*************/

		 /** This function is invoked to  display the error message when incident Id is null
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
				      //out.println("No valid incident Id or incident Key");
                       out.println("showMessage(MSGJAVA_TL4);");
				       out.println("</center>");
				       out.println("</Body>");
				       out.println("</html>");

				   } // ~ if block

	  } // ~ setError
	/***************************************** end *******************************************************/




	/************************************************************************************************/

       /**  This function takes tabname, StringBuffer,Printwriter object and incidentId
         *  as input. Depending on the tabname and incident Id, it will
         *   display the appropriate tab  in the ScreenPop frame
         */

	   public void setTab(String tabName, String defaultTab, StringBuffer buf,PrintWriter out, String incidentId, HttpServletRequest req,SRMBusinessContext bc, String asscCustId, String asscContactId, String asscProspectId){
		   try{
				if(tabName.equalsIgnoreCase("EntityInfo") && !(defaultTab.equalsIgnoreCase("EntityInfo"))){
						if( !asscCustId.equals("") )
						{
							buf.append("tempFrm.frames(0).addTab(\"Entity Info\", '../servlet/com.infy.cis.ui.common.allViews?ViewName=UIAccountDetails&param2=" + asscCustId + "',false)" +NL);
						}
						else if( !asscContactId.equals("") )
						{
							buf.append("tempFrm.frames(0).addTab(\"Entity Info\", '../servlet/com.infy.cis.ui.common.allViews?ViewName=UIContactDetails&param2=" + asscContactId + "',false)" +NL);
						}
						else if( !asscProspectId.equals("") )
						{
							buf.append("tempFrm.frames(0).addTab(\"Entity Info\", '../servlet/com.infy.cis.ui.common.allViews?ViewName=UISuspectDetails&param2=" + asscProspectId + "',false)" +NL);
						}

				}
				else if(tabName.equalsIgnoreCase("Opportunities") && !(defaultTab.equalsIgnoreCase("Opportunities"))){
						buf.append("tempFrm.frames(0).addTab(\"Related Opportunities\", '../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Opportunities_For_Incident&Param1=" + incidentId + "',false)" +NL);
				}

				else if(tabName.equalsIgnoreCase("KBEntries") && !(defaultTab.equalsIgnoreCase("KBEntries"))){
						 buf.append("tempFrm.frames(0).addTab(\"Related KB Entries\", '../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=KB_Related_To_Incident&Param1=" + incidentId + "',false)" +NL);
				}
				else if(tabName.equalsIgnoreCase("Incidents") && !(defaultTab.equalsIgnoreCase("Incidents"))){
						buf.append("tempFrm.frames(0).addTab(\"Incident Info\", '../servlet/com.infy.cis.ui.common.allViews?viewname=UIIncidentDetails&param2=" + incidentId + "',false)" +NL);
				}
			}
			catch(Exception e){}
	    }
	/***********************************************end*************************************************/


	/******************************************function to display the first frame******************************************************/

        /**  This function takes tabname, Stringbuffer, Printwriter object and incidentId
          *  as input. Depending on the tabname and incident Id, it will
          *  display the appropriate tab as First tab with its details in the ScreenPop frame
          */

		 public void setPrimaryTab(String tabName, StringBuffer buf,PrintWriter out, String incidentId, HttpServletRequest req,SRMBusinessContext bc, String asscCustId, String asscContactId, String asscProspectId){
		   if(!(tabName.equals(""))){
			   if(tabName.equalsIgnoreCase("Incidents")){
		   			buf.append("tempFrm.frames(0).addTab(\"Incident Info\", '../servlet/com.infy.cis.ui.common.allViews?viewname=UIIncidentDetails&param2=" + incidentId + "',false)" +NL);
		       }
		   	   else if(tabName.equalsIgnoreCase("EntityInfo")){
						if( !asscCustId.equals("") )
						{
							buf.append("tempFrm.frames(0).addTab(\"Entity Info\", '../servlet/com.infy.cis.ui.common.allViews?ViewName=UIAccountDetails&param2=" + asscCustId + "',false)" +NL);
						}
						else if( !asscContactId.equals("") )
						{
							buf.append("tempFrm.frames(0).addTab(\"Entity Info\", '../servlet/com.infy.cis.ui.common.allViews?ViewName=UIContactDetails&param2=" + asscContactId + "',false)" +NL);
						}
						else if( !asscProspectId.equals("") )
						{
							buf.append("tempFrm.frames(0).addTab(\"Entity Info\", '../servlet/com.infy.cis.ui.common.allViews?ViewName=UISuspectDetails&param2=" + asscProspectId + "',false)" +NL);
						}
		 	   }
		 	   else if(tabName.equalsIgnoreCase("Opportunities")){
					 buf.append("tempFrm.frames(0).addTab(\"Related Opportunities\", '../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Opportunities_For_Incident&Param1=" + incidentId + "',false)" +NL);
		 	   }

		 	   else if(tabName.equalsIgnoreCase("KBEntries")){
					 buf.append("tempFrm.frames(0).addTab(\"Related KB Entries\", '../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=KB_Related_To_Incident&Param1=" + incidentId + "',false)" +NL);
		 	   }
		   } // ~ if block
	       else
	       {
			  	buf.append("tempFrm.frames(0).addTab(\"Incident Info\", '../servlet/com.infy.cis.ui.common.allViews?viewname=UIIncidentDetails&param2=" + incidentId + "',false)" +NL);
		   }
        } //~ end of setPrimaryTab method

	/***********************************************end*************************************************/



	/************************************function to convert key to id************************************************************/

	       /** This method takes incidentkey as input,
	         * converts the key into incidentId and
	         * returns the key as string
	         */

		   public String convertKeyToId(String incidentKey,HttpServletRequest req,SRMBusinessContext bc)throws Exception
		   {


			   ArrayList docAttrList = new ArrayList();
		   	   docAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.INCIDENTID));
			   SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("IncidentBO",IncidentBO.INCIDENTID);
			   QueryAssist.addSimpleCondition(qbAccount,"IncidentBO",IncidentBO.CASEID,IQuery.ComparisonOperation_EQ,""+incidentKey);
			   qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
			   SRMQueryResult qrChecklist = qbAccount.runQuery(bc, false, -1);
			   SRMRecordSet rsChecklist = qrChecklist.getRecordSet();

			   Integer accId=new Integer(0);
			   	  if(rsChecklist.hasNext() )
			   	  {
			   	   		accId = (Integer)(rsChecklist.getNext().get(0));
			   	   }//end of if
			   String acctId = accId.toString();
			   return acctId;

		   } // end of convertKeyToId
	/********************************************end ****************************************************/




		       /** This method takes incidentId as input,
				 * and evaluates if the incident Id is created
				 * for customer, contact, prospectId and returns
				 * whichever is created against incidentId.
		         */

			   public String getIncidentFor(String incidentId,HttpServletRequest req,SRMBusinessContext bc)throws Exception
			   {


				   ArrayList docAttrList = new ArrayList();
			   	   docAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.INCIDENTFOR));
				   SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("IncidentBO",IncidentBO.INCIDENTFOR);
				   QueryAssist.addSimpleCondition(qbAccount,"IncidentBO",IncidentBO.INCIDENTID,IQuery.ComparisonOperation_EQ,""+incidentId);
				   qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
				   SRMQueryResult qrChecklist = qbAccount.runQuery(bc, false, -1);
				   SRMRecordSet rsChecklist = qrChecklist.getRecordSet();

				   String incidentFor=new String();
				   	  if(rsChecklist.hasNext() )
				   	  {
				   	   		incidentFor = (String)(rsChecklist.getNext().get(0));
				   	   }//end of if
				 return incidentFor;

			   } // end of getIncidentFor
		/********************************************end ****************************************************/

			   /** This method takes incidentId as input,
		         * and using it , the customer Id is retreived.
		         * The customerId is returned
		         */


			   public String getCustomerID(String incidentId,HttpServletRequest req,SRMBusinessContext bc)throws Exception
			   {
				   ArrayList docAttrList = new ArrayList();
			   	   docAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.ACCOUNTID));
				   SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("IncidentBO",IncidentBO.ACCOUNTID);
				   QueryAssist.addSimpleCondition(qbAccount,"IncidentBO",IncidentBO.INCIDENTID,IQuery.ComparisonOperation_EQ,""+incidentId);
				   qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
				   SRMQueryResult qrChecklist = qbAccount.runQuery(bc, false, -1);
				   SRMRecordSet rsChecklist = qrChecklist.getRecordSet();

				   Integer accId=new Integer(0);
					  if(rsChecklist.hasNext() )
					  {
							accId = (Integer)(rsChecklist.getNext().get(0));
					   }//end of if
				  	 String acctId = accId.toString();
			  	    return acctId;

			   } // end of getCustomerID

			   public List getIncidentForID(String incidentKey,HttpServletRequest req,SRMBusinessContext bc)throws Exception
			   {
				   String strIncidentID = "0";
				   String asscCustId = "";
				   String asscContactId = "";
				   String asscProspectId = "";
				   ArrayList docAttrList = new ArrayList();
				   docAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.INCIDENTID));
				   docAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.ACCOUNTID));
				   docAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.CONTACTID));
				   docAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.SUSPECTID));

				   SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("IncidentBO",IncidentBO.INCIDENTID);
				   QueryAssist.addSimpleCondition(qbAccount,"IncidentBO",IncidentBO.CASEID,IQuery.ComparisonOperation_EQ,""+incidentKey);
				   qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
				   qbAccount.addAttribScope((TransFormFn) docAttrList.get(1));
				   qbAccount.addAttribScope((TransFormFn) docAttrList.get(2));
				   qbAccount.addAttribScope((TransFormFn) docAttrList.get(3));
				   SRMQueryResult qrChecklist = qbAccount.runQuery(bc, false, -1);
				   SRMRecordSet rsChecklist = qrChecklist.getRecordSet();

				   if(rsChecklist.hasNext() )
				   {
					   List ls = rsChecklist.getNext();
					   return ls;
				   }
					return null;
				   //return strIncidentID.concat("|").concat(asscCustId).concat("|").concat(asscContactId).concat("|").concat(asscProspectId);
			   }
		/********************************************end ****************************************************/



}
