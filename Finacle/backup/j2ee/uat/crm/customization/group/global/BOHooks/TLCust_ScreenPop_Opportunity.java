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

public class TLCust_ScreenPop_Opportunity extends CISHttpServlet {
    public static String CIS_COPYRIGHT_="Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.";
    public static String CIS_VERSION_="2.00 $Revision: 1.1 $";
	static String NL = "\n";

    protected void serviceRequest (HttpServletRequest req, HttpServletResponse resp)throws Exception
	{
			PrintWriter out = resp.getWriter();
	        setContentType("text/html", resp);

	        String messageFile = context.getSessionContext(req).getClientMessageFile();
	        SRMBusinessContext bc = Utils.getBusinessContext(req,java.sql.Connection.TRANSACTION_READ_UNCOMMITTED);

	    java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();

		String strLocale = locale.toString();
	        boolean flag = false;

 			String opportunityId = "";
 			String asscContactId = "";
			String asscCustId = "";
			String asscProspectId = "";



        	String opportunityKey = req.getParameter("opportunityKey");
        	if(opportunityKey == null || opportunityKey.equals("")){
			       opportunityId = req.getParameter("opportunityId");
						if(opportunityId == null || opportunityId.equals(""))
						{
							   flag = true;
							   setError(flag,out);  //function invoked to display error message
					    }
					    else
					    {
							// Only Keys are supported
							//oppDetails(opportunityId,req,out,messageFile,bc);  //function invoked to display the opportunitydetails
						}
		    }  // ~ if end
		    else
		    {
				List ls = getEntityID(opportunityKey,req,bc);
				if( ls != null )
				{
					Integer asscId=new Integer(0);
					try
					{
					   asscId = (Integer)(ls.get(0));
					   opportunityId = asscId.toString();
					}
					catch( Exception e )
					{
					   opportunityId = "0";
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
					opportunityId = "0";
					asscCustId = asscContactId = asscProspectId = "";
				}

				oppDetails(opportunityId,req,out,messageFile,bc,asscCustId,asscContactId,asscProspectId);  //function invoked to display the opportunitydetails
			}

	 } // ~ service method



	 /************************************************************************************************/

	 		  /** This function is invoked to  display the details of tabs .
	 		    * This function takes opportunityId, req , PrintWriter, messageFile
	 			* as input.The tab names can be any one of the following or all.
	 			* customer,contact, incident, opportunities, Applications,campaigns,Rewards.
	 			* The tab names are case-insensitive.
	 		    */

	 		  public void oppDetails(String opportunityId,HttpServletRequest req,PrintWriter out, String messageFile, SRMBusinessContext bc,String asscCustId,String asscContactId,String asscProspectId)
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

				String tab6 = req.getParameter("Tab6");
				if(tab6==null || tab6.equals("")){
					tab6 = "";
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
					   * Contacts, Incidents, Products, Customer
					   * The tab names are case-sensitive.
					   */
						setPrimaryTab(tab1,buf,out,opportunityId,req,bc,asscCustId,asscContactId,asscProspectId); //invokes the function to display the appropriate tab as first tab with its details
						setTab(tab1, tab1, buf, out,opportunityId,req,bc,asscCustId,asscContactId,asscProspectId); //invokes the function to display the appropriate tab with its details
						setTab(tab2, tab1, buf, out,opportunityId,req,bc,asscCustId,asscContactId,asscProspectId);
						setTab(tab3, tab1, buf, out,opportunityId,req,bc,asscCustId,asscContactId,asscProspectId);
						setTab(tab4, tab1, buf, out,opportunityId,req,bc,asscCustId,asscContactId,asscProspectId);
						setTab(tab5, tab1, buf, out,opportunityId,req,bc,asscCustId,asscContactId,asscProspectId);
						setTab(tab6, tab1, buf, out,opportunityId,req,bc,asscCustId,asscContactId,asscProspectId);

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

		 } // ~ oppDetails


		/************************ This is to display the error message when opportunity Id is null*************/

		 /** This function is invoked to  display the error message when opportunity Id is null
		   * This function takes boolean value and PrintWriter object as input
		   * If the boolean flag is true it will display the error message
		   */

		 public void setError(boolean flag,PrintWriter out)
		 {


	    java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();

		String strLocale = locale.toString();		   if(flag == true)
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
				      // out.println("No valid opportunity Id or opportunity Key");
                       out.println("showMessage(MSGJAVA_TL3);");
				       out.println("</center>");
				       out.println("</Body>");
				       out.println("</html>");

			  } // ~ if block
	    }  //~ setError
	 /***************************************** end *******************************************************/





		/************************************************************************************************/

			   /**  This function takes tabname, Printwriter object and opportunityId
				 *  as input. Depending on the tabname and opportunity Id, it will
				 *  display the appropriate frame in the ScreenPop frame
				 */


			   public void setTab(String tabName, String defaultTab, StringBuffer buf, PrintWriter out, String opportunityId, HttpServletRequest req, SRMBusinessContext bc,String asscCustId,String asscContactId,String asscProspectId){
					try
					{
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
						else if(tabName.equalsIgnoreCase("Incidents") && !(defaultTab.equalsIgnoreCase("Incidents"))){
							buf.append("tempFrm.frames(0).addTab(\"Related Incidents\", '../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Incidents_For_Opportunity&Param1=" + opportunityId + "',false)" +NL);
						}
						else if(tabName.equalsIgnoreCase("Products") && !(defaultTab.equalsIgnoreCase("Products"))){
							buf.append("tempFrm.frames(0).addTab(\"Products For Opportunity\", '../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=ProductsOfOpportunity&Param1=" + opportunityId + "',false)" +NL);
						}
						else if(tabName.equalsIgnoreCase("Opportunity") && !(defaultTab.equalsIgnoreCase("Opportunity"))){
							buf.append("tempFrm.frames(0).addTab(\"Opportunity Info\", '../servlet/com.infy.cis.ui.common.allViews?viewname=UIOpprDetails&param2=" + opportunityId + "',false)" +NL);
						}
						else if(tabName.equalsIgnoreCase("FieldInvestigation") && !(defaultTab.equalsIgnoreCase("FieldInvestigation"))){
							buf.append("tempFrm.frames(0).addTab(\"Field Investigations\", '../servlet/com.infy.cis.ui.loans.VerificationReportView?viewName=FieldInvestigation&yetSaved=true&opportunityID=" + opportunityId + "',false)" +NL);
						}
						else if(tabName.equalsIgnoreCase("Valuation") && !(defaultTab.equalsIgnoreCase("Valuation"))){
							buf.append("tempFrm.frames(0).addTab(\"Valuation\", '../servlet/com.infy.cis.ui.loans.VerificationReportView?viewName=Valuation&yetSaved=true&opportunityID=" + opportunityId + "',false)" +NL);
						}
					} catch(Exception e) { }

			   }
		/***********************************************end*************************************************/


		/******************************************function to display the first frame******************************************************/

				/**  This function takes tabname, Printwriter object and opportunityId
				  *  as input. Depending on the tabname and opportunityId, it will
				  *  display the appropriate frame as First frame in the ScreenPop frame
				  */

				 public void setPrimaryTab(String tabName, StringBuffer buf, PrintWriter out, String opportunityId, HttpServletRequest req,SRMBusinessContext bc,String asscCustId,String asscContactId,String asscProspectId){
				 try
					{
						if(!(tabName.equals(""))){
							if(tabName.equalsIgnoreCase("EntityInfo")){
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
							else if(tabName.equalsIgnoreCase("Incidents")){
								buf.append("tempFrm.frames(0).addTab(\"Related Incidents\", '../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Incidents_For_Opportunity&Param1=" + opportunityId + "',false)" +NL);
							}
							else if(tabName.equalsIgnoreCase("Products")){
								buf.append("tempFrm.frames(0).addTab(\"Products For Opportunity\", '../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=ProductsOfOpportunity&Param1=" + opportunityId + "',false)" +NL);
							}
							else if(tabName.equalsIgnoreCase("Opportunity")){
								buf.append("tempFrm.frames(0).addTab(\"Opportunity Info\", '../servlet/com.infy.cis.ui.common.allViews?viewname=UIOpprDetails&param2=" + opportunityId + "',false)" +NL);
							}
							else if(tabName.equalsIgnoreCase("FieldInvestigation")){
								buf.append("tempFrm.frames(0).addTab(\"Field Investigations\", '../servlet/com.infy.cis.ui.loans.VerificationReportView?viewName=FieldInvestigation&yetSaved=true&opportunityID=" + opportunityId + "',false)" +NL);
							}
							else if(tabName.equalsIgnoreCase("Valuation")){
								buf.append("tempFrm.frames(0).addTab(\"Valuation\", '../servlet/com.infy.cis.ui.loans.VerificationReportView?viewName=Valuation&yetSaved=true&opportunityID=" + opportunityId + "',false)" +NL);
							}
						}
						else
						{
							buf.append("tempFrm.frames(0).addTab(\"Opportunity Info\", '../servlet/com.infy.cis.ui.common.allViews?viewname=UIOpprDetails&param2=" + opportunityId + "',false)" +NL);
						}
					} catch(Exception e) { }
				} //~ end of setPrimaryTab method

		/***********************************************end*************************************************/



		/************************************function to convert key to id************************************************************/

			   /** This method takes opportunitykey as input,
				*  converts the key into opportunityId and
				*  returns the key as string
				*/

			   public String convertKeyToId(String opportunityKey,HttpServletRequest req, SRMBusinessContext bc)throws Exception
			   {

					ArrayList docAttrList = new ArrayList();
					docAttrList.add(QueryAssist.getTransformFn("OpportunityBO", OpportunityBO.OPPORTUNITYID));
					SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("OpportunityBO",OpportunityBO.OPPORTUNITYID);
					QueryAssist.addSimpleCondition(qbAccount,"OpportunityBO",OpportunityBO.CASEID,IQuery.ComparisonOperation_EQ,""+opportunityKey);
					qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
					SRMQueryResult qrChecklist = qbAccount.runQuery(bc, false, -1);
					SRMRecordSet rsChecklist = qrChecklist.getRecordSet();
					Integer oppId=new Integer(0);
					if(rsChecklist.hasNext() ) {
						   oppId = (Integer)(rsChecklist.getNext().get(0));
					}//end ~
					String	opportunityId = oppId.toString();
					return opportunityId;
				} // end of convertKeyToId
		/********************************************end ****************************************************/



		       /** This method takes opportunityId as input,
		         * and evaluates if the opportunity Id is created
		         * for customer, contact, prospectId and returns
		         * whichever is created against opporunityId.
		         */

			   public String getOpportunityFor(String opportunityId,HttpServletRequest req,SRMBusinessContext bc)throws Exception
			   {

				   ArrayList docAttrList = new ArrayList();
			   	   docAttrList.add(QueryAssist.getTransformFn("OpportunityBO", OpportunityBO.OPPORTUNITYFOR));
				   SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("OpportunityBO",OpportunityBO.OPPORTUNITYFOR);
				   QueryAssist.addSimpleCondition(qbAccount,"OpportunityBO",OpportunityBO.OPPORTUNITYID,IQuery.ComparisonOperation_EQ,""+opportunityId);
				   qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
				   SRMQueryResult qrChecklist = qbAccount.runQuery(bc, false, -1);
				   SRMRecordSet rsChecklist = qrChecklist.getRecordSet();
				   String opportunityFor=new String();
				   	  if(rsChecklist.hasNext() )
				   	  {
				   	   		opportunityFor = (String)(rsChecklist.getNext().get(0));
				   	   }//end of if
				 return opportunityFor;

			   } // end of opportunityFor
		/********************************************end ****************************************************/


			   /** This method takes opportunityId as input,
		         * and using it , the customer Id is retreived.
		         * The customerId is returned
		         */

			   public String getCustomerID(String opportunityId,HttpServletRequest req,SRMBusinessContext bc)throws Exception
			   {


				   ArrayList docAttrList = new ArrayList();
			   	   docAttrList.add(QueryAssist.getTransformFn("OpportunityBO", OpportunityBO.ACCOUNTID));
				   SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("OpportunityBO",OpportunityBO.ACCOUNTID);
				   QueryAssist.addSimpleCondition(qbAccount,"OpportunityBO",OpportunityBO.OPPORTUNITYID,IQuery.ComparisonOperation_EQ,""+opportunityId);
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


			   /* Function to return the opportunity ID given the key.
			    * Sets the variables to identify the entity for the opportunity.
				*/
			   public List getEntityID(String opportunityKey,HttpServletRequest req,SRMBusinessContext bc)throws Exception
			   {
				   ArrayList docAttrList = new ArrayList();
				   docAttrList.add(QueryAssist.getTransformFn("OpportunityBO", OpportunityBO.OPPORTUNITYID));
				   docAttrList.add(QueryAssist.getTransformFn("OpportunityBO", OpportunityBO.ACCOUNTID));
				   docAttrList.add(QueryAssist.getTransformFn("OpportunityBO", OpportunityBO.CONTACTID));
				   docAttrList.add(QueryAssist.getTransformFn("OpportunityBO", OpportunityBO.SUSPECTID));

				   SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("OpportunityBO",OpportunityBO.OPPORTUNITYID);
				   QueryAssist.addSimpleCondition(qbAccount,"OpportunityBO",OpportunityBO.CASEID,IQuery.ComparisonOperation_EQ,""+opportunityKey);
				   qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
				   qbAccount.addAttribScope((TransFormFn) docAttrList.get(1));
				   qbAccount.addAttribScope((TransFormFn) docAttrList.get(2));
				   qbAccount.addAttribScope((TransFormFn) docAttrList.get(3));
				   SRMQueryResult qrChecklist = qbAccount.runQuery(bc, false, -1);
				   SRMRecordSet rsChecklist = qrChecklist.getRecordSet();

				   Integer asscId=new Integer(0);
				   if(rsChecklist.hasNext() )
				   {
					   List ls = rsChecklist.getNext();
					   return ls;
				   }
				   return null;
				}

		/********************************************end ****************************************************/







}
