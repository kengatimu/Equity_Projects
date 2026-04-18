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

public class TLCust_ScreenPop_Customer extends CISHttpServlet {

    public static String CIS_COPYRIGHT_="Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.";
    public static String CIS_VERSION_="2.00 $Revision: 1.2 $";
	static String NL = "\n";

    protected void serviceRequest(HttpServletRequest req, HttpServletResponse resp)throws Exception
	{

		PrintWriter out = resp.getWriter();
	    setContentType("text/html", resp);
	    String messageFile = context.getSessionContext(req).getClientMessageFile();
	    SRMBusinessContext bc = Utils.getBusinessContext(req,java.sql.Connection.TRANSACTION_READ_UNCOMMITTED);


	    java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();

		String strLocale = locale.toString();


        String customerId="";
        String customerKey = "";

        customerKey = req.getParameter("customerKey");
        boolean flag = false;


        if(customerKey == null || customerKey.equals("")){
			customerId = req.getParameter("customerId");
			     if(customerId == null || customerId.equals(""))
				  {

				 		 flag = true;
				 		 setError(flag,out);  //function invoked to display error message
			      }
			      else
			      {
					  custDetails(customerId,req,out,messageFile,bc);  //function invoked to display the customerdetails
				  }
	     } // ~ if end
		 else
		 {
			 customerId = convertKeyToId(customerKey,req,bc); //invokes the function for conversion of key to id
			 custDetails(customerId,req,out,messageFile,bc);  //function invoked to display the customerdetails
		 }


     } // ~ service method



/************************************************************************************************/

		  /** This function is invoked to  display the details of tabs .
		    * This function takes customerId, req , PrintWriter, messageFile
			* as input.The tab names can be any one of the following or all.
			* customer,contact, incident, opportunities, Applications,campaigns,Rewards.
			* The tab names are case-insensitive.
		    */

		  public void custDetails(String customerId,HttpServletRequest req,PrintWriter out, String messageFile, SRMBusinessContext bc)
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

					String tab7 = req.getParameter("Tab7");
					if(tab7==null || tab7.equals("")){
							 tab7 = "";
					}

					String tab8 = req.getParameter("Tab8");
					if(tab8==null || tab8.equals("")){
							 tab8 = "";
					}

					String tab9 = req.getParameter("Tab9");
					if(tab9==null || tab9.equals("")){
							 tab9 = "";
					}

					String accountNumber = req.getParameter("accountNumber");
					if(!(accountNumber == null || accountNumber.equals("")))
					{
						try{
						salesId = convertNumToSalesId(accountNumber,req,out,bc); //invokes the function for conversion of key to id

						if(salesId.equals("") || salesId == null){
							 flag = true;
						     setError(flag,out); //function invoked to display error message
					    }
					    else{
							try{

								SRMNVPair salesNV = new SRMNVPair("SalesBO.SalesID",customerId);
								ArrayList al = new ArrayList();
								al.add(salesNV);
								salesUrl =SRMURLResolver.generateURL(al,"SalesBO");
						    }
							catch(Exception ex){out.println("Error in sales :"+ex);}
					     }
						}catch(Exception ex){out.println("Error in Accounts form:"+ex);}



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
										* customer,contact, incident, opportunities, Applications,campaigns,Rewards,
										* Accounts and Accounts statistics.
										* The tab names are case-sensitive.
									   */

										setPrimaryTab(tab1,buf,out,customerId); //invokes the function to display the appropriate tab as first tab with its details
										setTab(tab1,tab1, buf,out,customerId);  //invokes the function to display the appropriate tab with its details
										setTab(tab2,tab1, buf,out,customerId);
										setTab(tab3,tab1, buf,out,customerId);
										setTab(tab4,tab1, buf,out,customerId);
										setTab(tab5,tab1, buf,out,customerId);
										setTab(tab6,tab1, buf,out,customerId);
										setTab(tab7,tab1, buf,out,customerId);
										setTab(tab8,tab1, buf,out,customerId);
										setAccountTab(tab9,tab1,buf,out,salesId,salesUrl,accountNumber);


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




/************************ This is to display the error message when customer Id is null*************/

		 /** This function is invoked to  display the error message when customer Id is null
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
			  // out.println("No valid Customer Id or Customer Key");
               out.println("showMessage(MSGJAVA_TL5);");
			   out.println("</center>");
			   out.println("</Body>");
			   out.println("</html>");

		   } // ~ if block
		 } // ~ setError

/***************************************** end *******************************************************/


/************************************function to convert key to id************************************************************/

		   /** This method takes customerkey as input,
			 * converts the key into customerId and
			 * returns the key as string
			 */

		   public String convertKeyToId(String customerKey,HttpServletRequest req,SRMBusinessContext bc)throws Exception
		   {
				ArrayList docAttrList = new ArrayList();
				docAttrList.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ACCOUNTID));
				SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("AccountBO",AccountBO.ACCOUNTID);
			    QueryAssist.addSimpleCondition(qbAccount,"AccountBO",AccountBO.ACCOUNTKEY,IQuery.ComparisonOperation_EQ,""+customerKey);
			   	qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
				SRMQueryResult qrChecklist = qbAccount.runQuery(bc, false, -1);
				SRMRecordSet rsChecklist = qrChecklist.getRecordSet();

				Integer cusId=new Integer(0);
					if(rsChecklist.hasNext() )
					{
						cusId = (Integer)(rsChecklist.getNext().get(0));
					}//end of if
				String custId = cusId.toString();
				return custId;
		   } // end of convertKeyToId

/********************************************end ****************************************************/


/************************************************************************************************/

		   /**  This function takes tabname, defaultTab, StringBuffer, Printwriter object and salesId
			 *  as input. Depending on the tabname and sales Id, it will
			 *  display the appropriate frame in the ScreenPop frame
			 */


		   public void setAccountTab(String tabName, String defaultTab,StringBuffer buf,PrintWriter out, String salesId,String salesUrl,String accountNumber)
		   {


			   if(tabName.equalsIgnoreCase("Accounts Statistics") && !(defaultTab.equalsIgnoreCase("Accounts Statistics"))){

			   			buf.append("tempFrm.frames(0).addTab(\"Account Statistics\", '../servlet/com.infy.cis.ui.sales.AccountStatistics?accountNumber="+accountNumber+"&saleURL=srmBOObj:SaleBO/SaleBO.salesID:" +salesId+ "',false)" +NL);
			  }
		   }

/************************************************************************************************/

		   /**  This function takes tabname, defaultTab, StringBuffer, Printwriter object and customerId
			 *  as input. Depending on the tabname and account Id, it will
			 *  display the appropriate frame in the ScreenPop frame
			 */


		   public void setTab(String tabName, String defaultTab,StringBuffer buf,PrintWriter out, String customerId)
		   {


			   if(tabName.equalsIgnoreCase("incidents") && !(defaultTab.equalsIgnoreCase("incidents"))){

					buf.append("tempFrm.frames(0).addTab('Incidents', '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Account_Incidents&Param1=" + customerId + "',false)" +NL);
				}
				else if(tabName.equalsIgnoreCase("opportunities") && !(defaultTab.equalsIgnoreCase("opportunities"))){
						 buf.append("tempFrm.frames(0).addTab('Opportunities', '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Account_Opportunities&Param1=" + customerId + "',false)" +NL);
				}
				else if(tabName.equalsIgnoreCase("contacts") && !(defaultTab.equalsIgnoreCase("contacts"))){
					buf.append("tempFrm.frames(0).addTab('Contacts', '../../servlet/com.infy.cis.ui.admin.RelatedContactsWizard?accountId=" + customerId + "',false)" +NL);
				}
				else if(tabName.equalsIgnoreCase("Applications") && !(defaultTab.equalsIgnoreCase("Applications"))){
					buf.append("tempFrm.frames(0).addTab('Applications', '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=ApplicationsForCustomer&Param1=" + customerId + "',false)" +NL);
				}
				else if(tabName.equalsIgnoreCase("campaigns") && !(defaultTab.equalsIgnoreCase("campaigns"))){
					buf.append("tempFrm.frames(0).addTab('Campaigns', '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=CampaignsForCustomer&Param1=" + customerId + "',false)" +NL);
				}
				else if(tabName.equalsIgnoreCase("RewardPoints") && !(defaultTab.equalsIgnoreCase("RewardPoints"))){
					buf.append("tempFrm.frames(0).addTab('Reward Points', '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=RewardPointsOfCustomer&Param1=" + customerId + "',false)" +NL);
				}
				else if(tabName.equalsIgnoreCase("Customer") && !(defaultTab.equalsIgnoreCase("Customer"))){
					buf.append("tempFrm.frames(0).addTab('Customer Info', '../../servlet/com.infy.cis.ui.common.allViews?viewname=UIAccountDetails&param2=" + customerId + "',false)" +NL);
				}

				else if(tabName.equalsIgnoreCase("Accounts") && !(defaultTab.equalsIgnoreCase("Accounts"))){
					buf.append("tempFrm.frames(0).addTab(\"Accounts Summary\", '../../servlet/com.infy.cis.ui.admin.CustomerAccountsRelationship?IsReadOnly=Y&accountId=" + customerId + "',false)" +NL);
				}


		   }// ~ setTab method

/***********************************************end*************************************************/


/******************************************function to display the first frame******************************************************/

			/**  This function takes tabname, StringBuffer, Printwriter object and customerId
			  *  as input. Depending on the tabname and account Id, it will
			  *  display the appropriate frame as First frame in the ScreenPop frame
			  */

			 public void setPrimaryTab(String tabName, StringBuffer buf,PrintWriter out, String customerId)
			 {
			   if(!(tabName.equals(""))){
				   if(tabName.equalsIgnoreCase("Customer")){
						buf.append("tempFrm.frames(0).addTab(\"Customer Info\", '../../servlet/com.infy.cis.ui.common.allViews?viewname=UIAccountDetails&param2=" + customerId + "',false)" +NL);
				   }
					else if(tabName.equalsIgnoreCase("incidents")){
						buf.append("tempFrm.frames(0).addTab(\"Incidents\", '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Account_Incidents&Param1=" + customerId + "',false)" +NL);
					}
					else if(tabName.equalsIgnoreCase("opportunities")){
						buf.append("tempFrm.frames(0).addTab(\"Opportunities\", '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Account_Opportunities&Param1=" + customerId + "',false)" +NL);
					}
					else if(tabName.equalsIgnoreCase("contacts")){
						buf.append("tempFrm.frames(0).addTab('Contacts', '../../servlet/com.infy.cis.ui.admin.RelatedContactsWizard?accountId=" + customerId + "',false)" +NL);
					}
					else if(tabName.equalsIgnoreCase("Applications")){
						buf.append("tempFrm.frames(0).addTab(\"Applications\", '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=ApplicationsForCustomer&Param1=" + customerId + "',false)" +NL);
					}
					else if(tabName.equalsIgnoreCase("campaigns")){
						buf.append("tempFrm.frames(0).addTab(\"Campaigns\", '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=CampaignsForCustomer&Param1=" + customerId + "',false)" +NL);
					}
					else if(tabName.equalsIgnoreCase("RewardPoints")){
						buf.append("tempFrm.frames(0).addTab(\"Reward Points\", '../../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=RewardPointsOfCustomer&Param1=" + customerId + "',false)" +NL);
					}

					else if(tabName.equalsIgnoreCase("Accounts")){
						buf.append("tempFrm.frames(0).addTab(\"Accounts Summary\", '../../servlet/com.infy.cis.ui.admin.CustomerAccountsRelationship?IsReadOnly=Y&accountId=" + customerId + "',false)" +NL);
					}


			   } // ~ if block
			   else if(tabName.equals(""))
			   {
					buf.append("tempFrm.frames(0).addTab(\"Customer Info\", '../../servlet/com.infy.cis.ui.common.allViews?viewname=UIAccountDetails&param2=" + customerId + "',false)" +NL);
			   }
			} //~ end of setPrimaryTab method

/***********************************************end*************************************************/



/************************************function to convert account number to sales id************************************************************/

       /** This method takes AccountNumber as input,
        *  converts the number into sales Id and
        *  returns the sales Id as string
        */

       public String convertNumToSalesId(String accountNumber,HttpServletRequest req,PrintWriter out,SRMBusinessContext bc)throws Exception
	   {

	   			ArrayList docAttrList = new ArrayList();
	   			docAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.SALESID));
                SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("SaleBO",SaleBO.SALESID);
			    QueryAssist.addSimpleCondition(qbAccount,"SaleBO",SaleBO.ACCOUNTNUMBER,IQuery.ComparisonOperation_EQ,""+accountNumber);
				qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
	   			SRMQueryResult qrChecklist = qbAccount.runQuery(bc, false, -1);
	   		    SRMRecordSet rsChecklist = qrChecklist.getRecordSet();

	   		    Integer saleId=new Integer(0);
	   			if(rsChecklist.hasNext() ) {
	   				  saleId = (Integer)(rsChecklist.getNext().get(0));

	   			}
	   			String salesId = saleId.toString();

	   			return salesId;
	   }

/********************************************end ****************************************************/


} // ~ main class
