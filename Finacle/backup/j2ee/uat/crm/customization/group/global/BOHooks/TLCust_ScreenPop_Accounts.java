/***** changes for tracker 46162  *******/
package com.infy.cis.custom;

import java.io.PrintWriter;
import com.infosys.insulate.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.infy.cis.servletruntime.CISHttpServlet;
import com.infy.cis.srmbo.IQuery;
import com.infy.cis.srmbo.SRMNVPair;
import com.infy.cis.srmbo.SRMQueryBuilder;
import com.infy.cis.srmbo.SRMQueryResult;
import com.infy.cis.srmbo.SRMRecordSet;
import com.infy.cis.srmbo.SaleBO;
import com.infy.cis.srmbo.TransFormFn;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.ui.common.QueryAssist;
import com.infy.cis.ui.common.Utils;

public class TLCust_ScreenPop_Accounts extends CISHttpServlet {

    public static String CIS_COPYRIGHT_="Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.";
    public static String CIS_VERSION_="2.00 $Revision: 1.3.228.1.72.1 $";
	static String NL = "\n";

	//Integer prodCatId=new Integer(0);
	//String strAccKey = "";
	//String viewName="";
	//String customerId = "";


    protected void serviceRequest (HttpServletRequest req, HttpServletResponse resp)throws Exception
	{


		////System.out.println("Using the Customization file");

			PrintWriter out = resp.getWriter();
	        setContentType("text/html", resp);

	    java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();

		String strLocale = locale.toString();


	        boolean flag = false;
			String strAccKey = "";
			//String viewName="";
			String customerId = "";

	        SRMBusinessContext bc = Utils.getBusinessContext(req,java.sql.Connection.TRANSACTION_READ_UNCOMMITTED);
			String messageFile = context.getSessionContext(req).getClientMessageFile();
			StringBuffer buf = new StringBuffer();
			String salesUrl = "";



	        String accountNumber = req.getParameter("accountNumber");
	        if(accountNumber == null || accountNumber.equals("")){
				 flag = true;
				 //setError(flag,out); //function invoked to display error message
			}

		    strAccKey = accountNumber;
			int prodCatId=0;
			String accountId="";
			List ls = convertNumToSalesId(accountNumber,req,bc); //invokes the function for conversion of key to id

			if( ls != null )
			{
				Integer asscId=new Integer(0);
				try
				{
				   asscId = (Integer)(ls.get(0));
				   accountId = asscId.toString();
				}
				catch(Exception e)
				{
					accountId = "";
				}
				try
				{
				   asscId = (Integer)(ls.get(1));
				   prodCatId = asscId.intValue();
				}
				catch(Exception e)
				{
					prodCatId = 0;
				}
			}
			else
			{
				accountId = "";
				prodCatId = 0;

			}

			if(accountId.equals("") || accountId == null){
				 flag = true;
				 //setError(flag,out); //function invoked to display error message
			}


			if(!accountId.equals("")){
				customerId = convertNumToCustId(accountNumber,req,bc); //invokes the function for conversion of key to Number
			}
			else{
				customerId ="0";
				strAccKey = "";
			}

            /* This block retreives the salesUrl*/

			try{

				SRMNVPair salesNV = new SRMNVPair("SalesBO.SalesID",accountId);
				ArrayList al = new ArrayList();
				al.add(salesNV);
				//salesUrl =SRMURLResolver.generateURL(al,"SalesBO");
				salesUrl="srmBOObj:SaleBO/SaleBO.salesID:"+accountId;
			}
			catch(Exception ex){out.println("Error in sales :"+ex);}

  	      /*********************************end*********************************/

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


/************************************** end ***********************************************/


//if(!(accountId.equals(""))){
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
            //if(!(customerId.equals(""))) {

/************************************************************************************************/

				/** This function is invoked to  display the appropriate tab with its details
				  * The valid tab name as of now is Customer
		          */

				setPrimaryTab(tab1,buf,out,accountId,customerId,salesUrl,prodCatId,strAccKey); //invokes the function to display the appropriate tab as first tab with its details
				setTab(tab1, tab1,buf,out,accountId,customerId,salesUrl,prodCatId,strAccKey);  //invokes the function to display the appropriate tab with its details
				setTab(tab2, tab1,buf,out,accountId,customerId,salesUrl,prodCatId,strAccKey);
				setTab(tab3, tab1,buf,out,accountId,customerId,salesUrl,prodCatId,strAccKey);
				setTab(tab4, tab1,buf,out,accountId,customerId,salesUrl,prodCatId,strAccKey);
				setTab(tab5, tab1,buf,out,accountId,customerId,salesUrl,prodCatId,strAccKey);
				setTab(tab6, tab1,buf,out,accountId,customerId,salesUrl,prodCatId,strAccKey);

/***************************************** end *******************************************************/

		    //} ~ if customerid is not null
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
		//} ~ if account id is not null
		//else{
		//	setError(true,out);
		//}


	   }// ~ service method


	/************************************function to convert account number to sales id************************************************************/

       /** This method takes AccountNumber as input,
        *  converts the number into sales Id and
        *  returns the sales Id as string
        */

       public List convertNumToSalesId(String accountNumber,HttpServletRequest req,SRMBusinessContext bc)throws Exception
	   {

	   			ArrayList docAttrList = new ArrayList();
	   			docAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.SALESID));
	   			docAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.PRODCATID));

	   			SRMQueryBuilder qbAccount = new SRMQueryBuilder();
	   			QueryAssist.addJoin(qbAccount,"SaleBO", SaleBO.SALESID,"SaleBO", SaleBO.SALESID, IQuery.JoinType_Left_Outer);
	   			QueryAssist.addSimpleCondition(qbAccount, "SaleBO", SaleBO.ACCOUNTNUMBER,IQuery.ComparisonOperation_EQ,accountNumber);
	   			qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
	   			qbAccount.addAttribScope((TransFormFn) docAttrList.get(1));
	   			SRMQueryResult qrChecklist = qbAccount.runQuery(bc, true, -1);
	   		    SRMRecordSet rsChecklist = qrChecklist.getRecordSet();

	   		    Integer saleId=new Integer(0);
	   		    Integer prodCatId = new Integer(0);
	   			if(rsChecklist.hasNext() ) {
					  List ls = rsChecklist.getNext();
					  return ls;
				}
				return null;
	   }

/********************************************end ****************************************************/


/************************************function to convert account number to customer id************************************************************/

       /** This method takes AccountNumber as input,
        *  converts the account number into CustomerId and
        *  returns the customer Id as string
        */

		public String convertNumToCustId(String accountNumber,HttpServletRequest req,SRMBusinessContext bc)throws Exception
	    {

		   SRMQueryBuilder qb = QueryAssist.singleObjectQuery("SaleBO", SaleBO.SALESID);
		   QueryAssist.addSimpleCondition(qb, "SaleBO", SaleBO.ACCOUNTNUMBER,IQuery.ComparisonOperation_EQ, accountNumber);
		   QueryAssist.addSimpleCondition(qb, "SaleBO", SaleBO.SALECUSTOMER_ROLE,IQuery.ComparisonOperation_EQ, "Main Account Holder");
			//Tracker:109227:95 SPE Changes:Start
			qb.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.SALECUSTOMER_ORGID));
			SRMQueryResult qr 		= qb.runQuery(bc, false, -1);
		   SRMRecordSet rs 		= qr.getRecordSet();
			if(rs.hasNext()){
				return rs.getNext().get(0).toString();
			}
			return "0";
			//Tracker:109227:95 SPE Changes:Start

	   }
/********************************************end ****************************************************/

/************************************************************************************************/

	public String getAccViewName( int nProdCatId )
	{
		String viewName = "";
		switch (nProdCatId)
		{
			case 1:
				viewName="SavingsAccountDetails";
				break;
			case 2:
				viewName="DepositAccountDetails";
				break;
			case 3:
				viewName="CurrentAccountDetails";
				break;
			case 4:
				viewName="CreditcardDetails";
				break;
			case 5:
				viewName="HomeloanDetails";
				break;
			case 6:
				viewName="LoanDetails";
				break;
			case 7:
				viewName="MutualfundDetails";
				break;
			case 8:
				viewName="OtherInvestProductDetails";
				break;
			case 9:
				viewName="InsuranceDetails";
				break;
			case 10:
				viewName="DematAccountDetails";
				break;
		}

		return viewName;
	}

       /**  This function takes tabname, StringBuffer, Printwriter object and customerId
         *  as input. Depending on the tabname and customer Id, it will
         *  display the appropriate frame in the ScreenPop frame
         */


	   public void setTab(String tabName, String defaultTab, StringBuffer buf,PrintWriter out, String accountId,String customerId, String salesUrl,int nProdCatId,String strAccKey){
		   String viewName = getAccViewName(nProdCatId);
		   if(tabName.equalsIgnoreCase("Customer") && !(defaultTab.equalsIgnoreCase("Customer"))){
		   		buf.append("tempFrm.frames(0).addTab(\"Customer Info\", '../servlet/com.infy.cis.ui.common.allViews?viewname=UIAccountDetails&param2=" + customerId + "',false)" +NL);
		 	}
		 	else if(tabName.equalsIgnoreCase("Accounts") && !(defaultTab.equalsIgnoreCase("Accounts"))){
				buf.append("tempFrm.frames(0).addTab(\"Accounts Relationship Summary\", '../servlet/com.infy.cis.ui.admin.CustomerAccountsRelationship?IsReadOnly=Y&accountId=" +customerId+ "',false)" +NL);
		    }
		    else if(tabName.equalsIgnoreCase("Account Details") && !(defaultTab.equalsIgnoreCase("Account Details"))){

				if(!viewName.equals("")){
					buf.append("tempFrm.frames(0).addTab(\"Account Details\", '../servlet/com.infy.cis.ui.admin.CommonAccountDetails?viewname="+ viewName +"&salesId="+accountId+"',false)" +NL);
				}
		    }
		    else if(tabName.equalsIgnoreCase("Incidents") && !(defaultTab.equalsIgnoreCase("Incidents"))){
				buf.append("tempFrm.frames(0).addTab(\"Incidents\", '../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Account_Incidents&Param1="+customerId+ "',false)" +NL);
		    }
		    else if(tabName.equalsIgnoreCase("LastTenTxns") && !(defaultTab.equalsIgnoreCase("LastTenTxns"))){
				buf.append("tempFrm.frames(0).addTab(\"Last Ten Transactions\", '../servlet/com.infy.cis.custom.OnlineTransactionEnquiry?accountNumber=" +strAccKey+ "&srmUrl=srmBOObj:SaleBO/SaleBO.salesID:" +accountId+"',false)" +NL);
		    }
		    else if(tabName.equalsIgnoreCase("OnlineBalance") && !(defaultTab.equalsIgnoreCase("OnlineBalance"))){
				buf.append("tempFrm.frames(0).addTab(\"Online Balance\", '../servlet/com.infy.cis.custom.OnlineBalanceEnquiry?accountNumber=" +strAccKey+ "&srmUrl=srmBOObj:SaleBO/SaleBO.salesID:" +accountId+"',false)" +NL);
		    }
	   }

/***********************************************end*************************************************/



/******************************************function to display the first frame******************************************************/

        /**  This function takes tabname, StringBuffer, Printwriter object and customerId
          *  as input. Depending on the tabname and account Id, it will
          *  display the appropriate frame as First frame in the ScreenPop frame
          */

		 public void setPrimaryTab(String tabName, StringBuffer buf, PrintWriter out, String accountId, String customerId,String salesUrl,int nProdCatId,String strAccKey){
		    String viewName = getAccViewName(nProdCatId);
		   if(!(tabName.equals(""))){
			   if(tabName.equalsIgnoreCase("Customer")){
		   			buf.append("tempFrm.frames(0).addTab(\"Customer Info\", '../servlet/com.infy.cis.ui.common.allViews?viewname=UIAccountDetails&param2=" + customerId + "',false)" +NL);
		       }
		   		else if(tabName.equalsIgnoreCase("Accounts")){
		   			buf.append("tempFrm.frames(0).addTab(\"Account Statistics\", '../servlet/com.infy.cis.ui.sales.AccountStatistics?accountNumber=" +accountId + "&saleURL=" +salesUrl+ "',false)" +NL);
		 		}
		 		else if(tabName.equalsIgnoreCase("Account Details")){
					if(!viewName.equals("")){
						buf.append("tempFrm.frames(0).addTab(\"Account Details\", '../servlet/com.infy.cis.ui.admin.CommonAccountDetails?viewname="+ viewName +"&salesId="+accountId+"',false)" +NL);
					}
		 		}
		 		else if(tabName.equalsIgnoreCase("Incidents")){
					buf.append("tempFrm.frames(0).addTab(\"Incidents\", '../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Account_Incidents&Param1="+customerId+ "',false)" +NL);
		 		}
		 		else if(tabName.equalsIgnoreCase("LastTenTxns")){
					buf.append("tempFrm.frames(0).addTab(\"Last Ten Transactions\", '../servlet/com.infy.cis.custom.OnlineTransactionEnquiry?accountNumber=" +strAccKey+ "&srmUrl=srmBOObj:SaleBO/SaleBO.salesID:" +accountId+"',false)" +NL);
		 		}
		 		else if(tabName.equalsIgnoreCase("OnlineBalance")){
					buf.append("tempFrm.frames(0).addTab(\"Online Balance\", '../servlet/com.infy.cis.custom.OnlineBalanceEnquiry?accountNumber=" +strAccKey+ "&srmUrl=srmBOObj:SaleBO/SaleBO.salesID:" +accountId+"',false)" +NL);
		 		}

	       } // ~ if block
	       else
	       {
			  	buf.append("tempFrm.frames(0).addTab(\"Account Statistics\", '../servlet/com.infy.cis.ui.sales.AccountStatistics?accountNumber=" +accountId + "&saleURL=" +salesUrl+ "',false)" +NL);
		   }
        } //~ end of setPrimaryTab method

/***********************************************end*************************************************/


/************************ This is to display the error message when account Id is null*************/

            public void setError(boolean flag,PrintWriter out){

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
			      //out.println("Error...");
      			   out.println("showMessage(MSGJAVA_TL2);");
			      // out.println("Invalid Account Number ");
			       out.println("showMessage(MSGJAVA_TL7);");
			       out.println("</center>");
			       out.println("</Body>");
			       out.println("</html>");

			   } // ~ if block
		   	}

/***************************************** end *******************************************************/

}


/***** End of changes for tracker 46162  *******/

