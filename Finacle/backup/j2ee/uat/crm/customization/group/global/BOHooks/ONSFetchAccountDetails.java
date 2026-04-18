/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: ONSFetchAccountDetails.java $
 *
 * $Archive: /com/infy/cis/custom/BOHooks/ONSFetchAccountDetails.java
 *
 * $History: ONSFetchAccountDetails.java $
 *
 *****************************************************************************/


package com.infy.cis.custom;

import java.util.Map;
import com.infosys.insulate.util.HashMap;
import java.util.Date;
import com.infy.cis.common.ARMTransHelper;
import com.infy.cis.custom.onsutil.ONSUtil;

//ONS classes
import com.infosys.ci.common.Amount;
import com.infosys.ci.common.CIUserInfo;
import com.infosys.ci.ons.cistruct.CICrvLoanGenDetailsInputStruct;
import com.infosys.ci.ons.cistruct.CICrvLoanGenDetailsOutStruct;
import com.infosys.bankaway.accesslayer.bwyinterface.FICustomServiceALImplementation;
import com.infosys.ci.ons.cistruct.CILoanDetRec;
import com.infosys.ci.common.FIIncidentInfo;
import com.infosys.ci.ons.cistruct.CILoanDetailsRec;

public class ONSFetchAccountDetails{

public Map fetchCoreDetails(Map details) throws Exception
{
              	HashMap results= new HashMap();

				String lnActType = (String)details.get("loanType");
				if ( null == lnActType ) {
					lnActType = "";
				}
				String oldacctnumber = (String)details.get("accountNumber");

				CICrvLoanGenDetailsInputStruct cICrvLoanGenDetInpStruct=new CICrvLoanGenDetailsInputStruct();


				FIIncidentInfo objFIIncidentInfo = new FIIncidentInfo();
				String xx = String.valueOf(System.currentTimeMillis());
				objFIIncidentInfo.setDccReqRefNum(xx);
				//yyyy-MM-dd'T'HH:mm:ss.SSS
				String xy = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(new Date());
				objFIIncidentInfo.setDccReqOrigTime(xy);
				objFIIncidentInfo.setDccReqType("DEFAULTEJB");
				cICrvLoanGenDetInpStruct.setFIIncidentInfo(objFIIncidentInfo);

				//ONS API
				CIUserInfo ciUserInfo =  new CIUserInfo();
				//CICrvCustomerArg ciCrvCustomerArg =  new CICrvCustomerArg();
				//CICrvAccountArg ciCrvAccountArg =  new CICrvAccountArg();
				//String [] inputStr = new String[0];

				ciUserInfo.setChannelType( "CRM" );

				/*Start of changes for Tracker Id:193542 */
				//ciUserInfo.setDccReqVersion("VER1");
				/*End of changes for Tracker Id:193542 */

				ciUserInfo.setAccessChannelId("CRM");
				ciUserInfo.setUserId("FIVUSR");
				String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();

				if( bankID != null && !bankID.equalsIgnoreCase("")){
					ciUserInfo.setBankId(bankID);
				}
				else{
					ciUserInfo.setBankId("01");
				}

				/* CRA10MSC - ARM - Begin of changes*/
				// Setting Correlator ID for forced sub-trans in core
				byte CorrelatorID[]=ARMTransHelper.getCorrelator();
				ciUserInfo.setCorrelationId(CorrelatorID);
				/* CRA10MSC - ARM - End of changes*/


				cICrvLoanGenDetInpStruct.setAccountId(oldacctnumber);

				FICustomServiceALImplementation ciRAI = new FICustomServiceALImplementation();


				CICrvLoanGenDetailsOutStruct  cICrvLoanGenDetOutStruct  = ciRAI.getLoanGen (
																ciUserInfo,
																cICrvLoanGenDetInpStruct ) ;



				CILoanDetailsRec loanData = cICrvLoanGenDetOutStruct.getCILoanDetailsRec();
				Integer tempData = new Integer( loanData.getDaysPastDue() );


				if( tempData.intValue() > 0 ) {
					//System.ln("Final Final Yahooooo::: got ::: ACCOUNT_DELINQUENCY" );
					results.put(ONSUtil.ACCOUNT_DELINQUENCY,"Y");
				} else {
					results.put(ONSUtil.ACCOUNT_DELINQUENCY,"N");
				}

				if( ONSUtil.TYPE_LOANS.equalsIgnoreCase(lnActType) || ONSUtil.TYPE_HOME_LOANS.equalsIgnoreCase(lnActType)	 ) {
					results.put(ONSUtil.DAYSPASTDUE,new String(tempData.toString()) );
					results.put(ONSUtil.DELINQUENCYSTRING,loanData.getDelStr());
					Amount amtPrnDue =null;
					Amount amtShdlBal =null;
					Amount amtTotDue =null;
					String  PrnDue1=null;
					String  shdlBalAmt1=null;
					String  TotDueAmt1=null;
					if(loanData.getPrnDue()!=null)
					{
					  amtPrnDue = loanData.getPrnDue();
					  double prnAmt = amtPrnDue.getAmountValue();
					  PrnDue1=prnAmt+"";
					}
					if(loanData.getShdlBal()!=null)
					{
					  amtShdlBal = loanData.getShdlBal();
					  double shdlBalAmt = amtShdlBal.getAmountValue();
					  shdlBalAmt1=shdlBalAmt+"";
					}
					if(loanData.getTotDue()!=null)
					{
					  amtTotDue = loanData.getTotDue();
					  double TotDueAmt = amtTotDue.getAmountValue();
					  TotDueAmt1=TotDueAmt+"";
				  	}
					results.put(ONSUtil.PRINCIPLEAMOUNT,PrnDue1);
					results.put(ONSUtil.LOANOUTSTANDING,shdlBalAmt1);
					results.put(ONSUtil.LASTINSTALLMENTPAID,TotDueAmt1);

				}
              	return results;
        }

        //ONS call for payment restructure update
        public String updatePaymentDetails(Map details)
        {
			return("SUCCESS");
		}

		//ONS call for joint borrower details update
		public String updateJntBorrowDetails(Map details)
        {
					return("SUCCESS");
		}

        //ONS call for joint borrower details update
		public String updatePmntandBorrwDetails(Map details)
		{
					return("SUCCESS");
		}

        //ONS call for NPL Restructure update
		public String updateNPLRestrctDetails(Map details)
		{
					return("SUCCESS");
		}
		public String updateEligCalculation(Map details)
		{
					return("SUCCESS");
		}
		public Map callLoanCalculator()
		{
					//onscall to get ei data
				HashMap results = new HashMap();
				results.put("dInstalLAmt","2000.21");
				return(results);
		}
 }


