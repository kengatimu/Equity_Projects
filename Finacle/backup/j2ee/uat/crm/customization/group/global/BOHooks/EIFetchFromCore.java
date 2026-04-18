/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: EIFetchFromCore.java $
 *
 * Author: APAC
 *
 * $Archive: EIFetchFromCore.java $
 *
 * $History: EIFetchFromCore.java $
 *
 *****************************************************************************/


package com.infy.cis.custom;

import com.infosys.ci.ons.cistruct.*;
import com.infosys.ci.hostinterface.common.*;
import com.infosys.ci.common.CIFatalException;
import com.infosys.ci.common.CINonFatalException;
import com.infosys.ci.ons.common.CIOnsNonFatalException;
import com.infosys.bankaway.accesslayer.bwyinterface.LoanAccountInquiryALImplementation;
import com.infosys.bankaway.accesslayer.bwyinterface.LoanAccountALImplementation;
import com.infosys.bankaway.accesslayer.bwyinterface.LoanServicesALImplementation;
import com.infosys.ci.common.*;
import com.infosys.ci.ons.common.*;
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
import java.text.DateFormat.*;
import java.lang.*;
import java.text.SimpleDateFormat;
import java.text.DecimalFormat;
import com.infy.cis.servletruntime.*;
import com.infy.cis.ui.common.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.security.user.*;
import java.util.Date.*;
import java.text.DateFormat.*;

import com.infy.cis.common.ARMTransHelper;
public class EIFetchFromCore
{


		/* Input Objects for sending to core*/

/*START COMMENT*/

		CIUserInfo  ciUserInfo = new CIUserInfo();
		//savitha Changes
		//Changes For Schedule
		LoanModellingMsgInputVO loanScheduleVO = new LoanModellingMsgInputVO();
		ModIntSlabLL[] modIntSlabLL = null;//loanScheduleVO.getModIntSlabLL();
		FIAccountPrepaymentShdlLA accountPrepaymentschdl = loanScheduleVO.getAcctPrepaymentShdlLA();
		FIRepaymentLL[] repayLL = null;
		LamodAdvParams lamodAdvance = loanScheduleVO.getAdvanceParameters();
		Percent prct = null;
		AmortCriteria amCriteria = loanScheduleVO.getAmortCriteria();
		DisbShdlDtl disbSchdDtl = loanScheduleVO.getDisbShdlDtl();
		OdisbShdlLL[] disbShdl = null;
		PreEmiParam preEmi = loanScheduleVO.getPreEmiParam();
		//LamodRepayLL lamodRepayLL[] = null;
		FILamodMandParams lamodMandParam = loanScheduleVO.getMandatoryParameters();
		TableCode tblCode = lamodMandParam.getIntTblCode();
		FILamodVariables lamodSchdlVar = loanScheduleVO.getVariables();
		Amount amt = null;
		Percent pcnt = null;
		Percent percent = null;
		SchmCode schmCode = lamodMandParam.getSchmCode();
		//FIIncidentInfo FIInci = loanScheduleVO.getFIIncidentInfo();
		ModStructRepParam modStructParam = loanScheduleVO.getModStructRepParam();
		ModStructRepayParamShdl modStructLL[] = null;
		String check = "false";
		/*** Start 110899****/
		Integer salesID = new Integer(0);
		/*** End 110899****/
		//Changes For Compute
		LoanModMsgInputVO 	loanComputeVO = new LoanModMsgInputVO();
		FILamodVariables lamodvar	= loanComputeVO.getVariables();
		//Percent pcnt = lamodvar.getIntRate();
		FILamodMandParams mandParams = loanComputeVO.getMandatoryParameters();
		TableCode compTblCode = mandParams.getIntTblCode();
		SchmCode compSchmCode = mandParams.getSchmCode();
		FILamodAdvParams advParams = loanComputeVO.getAdvanceParameters();
		AmortCriteria amortCriteria = loanComputeVO.getAmortCriteria();
		Calendar cal = Calendar.getInstance();
		/********Tracker No:88539:Start*******/
		Double effectIntRate;
		Double netRate;
		/********Tracker No:88539:End*******/

/*END COMMENT  */

		/********************************************************************************************
		*
		*           Method name    : setValuesInBO
		*           parameters     : PaymentPlannerBO paymentplannerBO, Double InsAmt
		*           Return Values  : None
		*           Description    : This Method sets PaymentPlannerBO object values that are common
		*							 to CompouteEI and ScheduleEIinto Core Objects
		*
		*
		********************************************************************************************/

/*--START OF COMMENT */

		public void setValuesInBO(PaymentPlannerBO paymentplannerBO, Double InsAmt, String Flag)
		throws SRMBCException{
			// Setting Structured Repayment and Planned Prepayment Details.
			/***Tracker 178800 starts***/
			Long ltrFieldDay = null;
			String strFieldDay = "";
			/***Tracker 178800 starts***/
			SRMCollection ppDetColl = paymentplannerBO.getPaymentPlannerDetails();
			PaymentPlannerBO.PaymentPlannerDetails ppDet = null;
			int iCollSize = 0;
			if ( ppDetColl != null )
				iCollSize = ppDetColl.size();

			if(Flag == "Y")
			{
				prct = lamodAdvance.getStepPcnt();
				pcnt = lamodSchdlVar.getIntRate();
				amt =  lamodSchdlVar.getLoanAmount();
				percent =  lamodSchdlVar.getPrefRate();
			}else{
				//prct = advParams.getStepPcnt();
				pcnt = lamodvar.getIntRate();
				amt =  lamodvar.getLoanAmount();
				percent = lamodvar.getPrefRate();
			}
			//Tracker 88479..this variable will hold the no of records from Structured Repayment Tab
			int iNoOfStrPayments=0;
			if(iCollSize > 0)
			{
			modStructLL = new ModStructRepayParamShdl[iCollSize];
			repayLL = new FIRepaymentLL[iCollSize] ;


			for (int i=0; i<iCollSize; i++)
			{
				ppDet = (PaymentPlannerBO.PaymentPlannerDetails)ppDetColl.get(i);
				Amount amount = null;
				Percent fPcnt = null;
				Frequency freq = null;
				modStructLL[i] = new ModStructRepayParamShdl();
				if((null != ppDet.getType())&&(ppDet.getType().equalsIgnoreCase(Constants.STRUCTURED_REPAYMENT)))
				{
					if(Flag == "Y")
					{
						lamodAdvance.setInstlmntInd("Y");
					}else{
						//advParams.setInstlmntInd("Y");
					}
					if(null != ppDet.getIntField1())
					{
							modStructLL[i].setNoOfInst(ppDet.getIntField1().longValue());
					}
					else	modStructLL[i].setNoOfInst(0);
					amount = modStructLL[i].getFlowAmt();
					fPcnt = modStructLL[i].getFlowPcnt();
					if(null != ppDet.getAmountField1())
					{
						lamodSchdlVar.setTypeOfInstComb("P");
						fPcnt.setValue(ppDet.getAmountField1().doubleValue());
					}
					else{
						fPcnt.setValue(0.0);
					}
					modStructLL[i].setFlowPcnt(fPcnt);
					if(!(ppDet.getInstallmentAmount().equals(new Double(0.0))))
					{
						lamodSchdlVar.setTypeOfInstComb("A");
					}
					if(null != ppDet.getInstallmentAmount())
					{
						amount.setAmountValue(ppDet.getInstallmentAmount().doubleValue());
						amount.setCurrencyCode(paymentplannerBO.getCurrency().toString());
					}
					else{
						amount.setAmountValue(0.0);
							amount.setCurrencyCode(null);
					}
					modStructLL[i].setFlowAmt(amount);
				}else if((null != ppDet.getType())&&(ppDet.getType().equalsIgnoreCase(Constants.NOTIONAL_REPAYMENT)))
					{
						lamodSchdlVar.setTypeOfInstComb("N");
						amount = modStructLL[i].getInstlmntAmt();
						if(null != ppDet.getInstallmentAmount())
						{
							amount.setAmountValue(ppDet.getInstallmentAmount().doubleValue());
							amount.setCurrencyCode(paymentplannerBO.getCurrency().toString());
						}else{
							amount.setAmountValue(0.0);
							amount.setCurrencyCode(null);
						}
						modStructLL[i].setInstlmntAmt(amount);
						if(null != ppDet.getIntField2())
						{
							modStructLL[i].setNotionalTenor(ppDet.getIntField2().longValue());
						}else modStructLL[i].setNotionalTenor(0);
						if(null != ppDet.getIntField1())
						{
							modStructLL[i].setNoOfInst(ppDet.getIntField1().longValue());
						}else  modStructLL[i].setNoOfInst(0);

					}

				else if((null != ppDet.getType())&&(ppDet.getType().equalsIgnoreCase(Constants.PLANNED_PREPAYMENT)))
				{
					repayLL[i] = new FIRepaymentLL();
					freq = repayLL[i].getEiFrequency();
					check = "true";
					if(null != ppDet.getDateField1())
					{
						Date strFlowStDate = ppDet.getDateField1();
						java.util.Date newTmpDate=null;
						java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
						Calendar cal = Calendar.getInstance();
						java.util.Date tempDate = cal.getTime();
						String strDate = sdf.format(tempDate);
						//java.util.Date tmpDate = sdf.parse(strFlowStDate);
						long milliSec = strFlowStDate.getTime();
						milliSec += 12*60*60*1000;
						newTmpDate = new java.util.Date(milliSec);
						cal.setTime(newTmpDate);

						repayLL[i].setFlowStartDate(cal);
					}
					else		repayLL[i].setFlowStartDate(null);

					if(null != ppDet.getIntField1())
					{
						repayLL[i].setNoOfDemands(ppDet.getIntField1().longValue());
					}
					else	repayLL[i].setNoOfDemands(0);
					amount = repayLL[i].getFlowAmt();
					if(null != ppDet.getAmountField1())
					{
						amount.setAmountValue(ppDet.getAmountField1().doubleValue());
						amount.setCurrencyCode(paymentplannerBO.getCurrency().toString());
						repayLL[i].setFlowAmt(amount);
					}
					else{
						amount.setAmountValue(0.0);
						amount.setCurrencyCode(null);
						repayLL[i].setFlowAmt(amount);
					}
					if(null != ppDet.getStrField2())
					{
						freq.setType(ppDet.getStrField2().toString());
					}
					if(null != ppDet.getStrField3())
					{
						freq.setWeekNum(ppDet.getStrField3().toString());
					}
					else 	freq.setWeekNum("");

					if(null != ppDet.getStrField4())
					{
						/***Tracker 178800 starts***/
						strFieldDay = ppDet.getStrField4();
						ltrFieldDay = Long.parseLong(strFieldDay);
						//java.util.Date dat = new Date(ppDet.getStrField4());
						freq.setWeekDay(ltrFieldDay);
						/***Tracker 178800 ends***/
					}
					else 	freq.setWeekDay(0);

					if(null != ppDet.getIntField2())
					{
						freq.setStartDd(ppDet.getIntField2().longValue());
					}
					else 	freq.setStartDd(0);

					if(null != ppDet.getStrField1())
					{
						freq.setHldyStat(ppDet.getStrField1());
					}
					else 	freq.setHldyStat("");
					repayLL[i].setEiFrequency(freq);
					MultiRecKey key = new MultiRecKey();
					key.setSerial_num(i+1+"");
					repayLL[i].setKey(key);
				}
			}

	}


				if(Flag == "Y")
				{
				setForSchedule(paymentplannerBO,InsAmt );
				}else{
				setForCompute(paymentplannerBO,InsAmt);
			}

	}


/* END OF COMMENT */

		/********************************************************************************************

		*           Method name    : computeEI
		*           parameters     : SRMBusinessContext bc, PaymentPlannerBO paymentplannerBO,
									 Double InstallAmt
		*           Return Values  : String
		*           Description    : This Method sets PaymentPlannerBO object values into Core Objects
									 and calls CORE API's.
									 It takes output returned by CORE API's

		*********************************************************************************************/



		public String computeEI(SRMBusinessContext bc, PaymentPlannerBO paymentplannerBO, Double InstallAmt)
		throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, CIFatalException
		{
		/* CRA10MSC - ARM - Begin of changes : Starting BL Layer transaction */


		/* CRA10MSC - ARM - End of changes */

			String result   = new String();

			result = ""; //For testing. To be removed
			setValuesInBO(paymentplannerBO,InstallAmt,"N");
			String compFlag = "2";

     		ciUserInfo.setChannelType("CRM");
     		FIIncidentInfo objFIIncidentInfo = new FIIncidentInfo();
     		String xx = String.valueOf(System.currentTimeMillis());
     		xx = xx+paymentplannerBO.getSalesID();
			objFIIncidentInfo.setDccReqRefNum(xx);
			//String xy = new java.text.SimpleDateFormat("MM-dd-yyyy HH:MM:ss.ms").format(new Date());
			String xy = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(new Date());
			objFIIncidentInfo.setDccReqOrigTime(xy);
    		objFIIncidentInfo.setDccReqType("DEFAULTEJB");
			/*Start of changes for Tracker Id:193542 */
			//ciUserInfo.setDccReqVersion("VER1");
			/*End of changes for Tracker Id:193542 */
			ciUserInfo.setAccessChannelId("CRM");
			ciUserInfo.setUserId("FIVUSR");
			loanComputeVO.setAdvanceParameters(advParams);
			loanComputeVO.setMandatoryParameters(mandParams);
			loanComputeVO.setAmortCriteria(amortCriteria);
			loanComputeVO.setVariables(lamodvar);
			loanComputeVO.setFIIncidentInfo(objFIIncidentInfo);

			String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();

			if( bankID != null || !bankID.equalsIgnoreCase("")){
				ciUserInfo.setBankId(bankID);
			}
			else{
				ciUserInfo.setBankId("01");
			}


			try {

					LoanAccountInquiryALImplementation inter = LoanAccountInquiryALImplementation.getInstance();
					//inter.setFiIncidentInfo(objFIIncidentInfo);
					LoanModMsgOutputVO computStruct = inter.doCompute(ciUserInfo,loanComputeVO);

					LamodResult compResult = computStruct.getResult();
					result = compResult.getResultValue();
	        }catch (CINonFatalException Ce)
			{
				throw new SRMBCException(SRMBCException.ONS_EXCEPTION,SRMBCException.MakeReplaceableArg("CINonFatalException - " + Ce.getMessage()),null);
			}
			catch (CIFatalException CIe)
			{
				throw new SRMBCException(SRMBCException.ONS_EXCEPTION,SRMBCException.MakeReplaceableArg("CIFatalException - " + CIe.getMessage()),null);
			}
			catch (CIOnsNonFatalException confe)
			{
						String strErrMsg = "";
						for (int i = 0; i < confe.getErrorLL().length; i++)
						{
							CIOnsErr errObj = (CIOnsErr) confe.getErrorLL()[i];

							if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1)
							{
								strErrMsg = strErrMsg + "(" + (i + 1) + ") " + errObj.errDesc;
							}
							else
							{
								strErrMsg = strErrMsg + "(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;
							}
						}
						throw new SRMBCException(SRMBCException.ONS_EXCEPTION,
							SRMBCException.MakeReplaceableArg("CIOnsNonFatalException - " + strErrMsg),null);
			}catch (Throwable e)
			{
			 			throw new CIFatalException(
			 				"Runtime errror occured during EICompute. Please refer to server log",e);
			 		}

		/* CRA10MSC - ARM - Begin of changes : Stopping BL Layer transaction */

		/* CRA10MSC - ARM - End of changes */
		 		return result;
	  		}




		/********************************************************************************************
        *
		*           Method name    : scheduleEI
	    *
		*           parameters     : SRMBusinessContext bc, PaymentPlannerBO paymentplannerBO,
		*							 ArrayList disb
		*
		*           Return Values  : PaymentPlannerBO object
		*
		*           Description    : This Method sets PaymentPlanner object values into Core Objects
		*							 and calls CORE API's.
		*							 It takes output object returned by CORE API's and sets into
		*							 PaymentPlannerBO object.
		*
		*********************************************************************************************/


	  public PaymentPlannerBO scheduleEI(SRMBusinessContext bc, PaymentPlannerBO paymentplannerBO, ArrayList disb)
	  throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, SRMTypeValidatorException, CIFatalException
	  {

		/* CRA10MSC - ARM - Begin of changes : Starting BL Layer transaction */


		/* CRA10MSC - ARM - End of changes */

		CILoanModScheduleOutStruct lamodSchedule = null;
		int disbCount = 0;
		/*** Start 110899****/
		salesID = paymentplannerBO.getSalesID();
		/*** End 110899****/


		if(paymentplannerBO.getMoratoriumPeriod()!=null)
		{
			preEmi.setHldyPerd(paymentplannerBO.getMoratoriumPeriod().longValue());
		}
		else
		{
			preEmi.setHldyPerd(0);
		}
		if(null != paymentplannerBO.getMoratoriumCapitalize() && paymentplannerBO.getMoratoriumCapitalize().equals("Y"))
		{
			preEmi.setCapitalizeIntFlg("C");
		}else{
		preEmi.setCapitalizeIntFlg(paymentplannerBO.getMoratoriumCapitalize());
		}
		if(null != paymentplannerBO.getInstallmentStartDate())
			{
				Calendar cal1 = Calendar.getInstance();
				cal1.setTime(paymentplannerBO.getInstallmentStartDate());
				amCriteria.setInstlStartDate(cal1);
			}
		setValuesInBO(paymentplannerBO,null,"Y");

		if (disb != null)
		{
			disbCount = disb.size();
		}

		try
		{
		if ( disbCount > 0 )
		{
			StringTokenizer tokensType = null ;
			String disbRow = null;
			disbShdl = new OdisbShdlLL[disbCount];
			for (int iCount = 0; iCount < disbCount ; iCount++ )
			{
				disbShdl[iCount] = new OdisbShdlLL();
				Amount amnt = disbShdl[iCount].getDisburseAmt();
				disbRow = (String) disb.get(iCount);
				if(disbRow != null)
				{
					SimpleDateFormat disbFormat = new SimpleDateFormat("yyyy-MM-dd");
					tokensType = new StringTokenizer(disbRow, "|");
					if ( tokensType.hasMoreTokens() )
					{
						String strDisbDate = (String)tokensType.nextElement();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date dtDisbDate = sdf.parse(strDisbDate);
						Calendar cal1 = Calendar.getInstance();
						//cal1.setTime(paymentplannerBO.getOriginationDate());
						cal1.setTime(dtDisbDate);
						disbShdl[iCount].setDisburseDate(cal1);
						String strAmount = (String)tokensType.nextElement();
						amnt.setAmountValue((new Double(strAmount)).doubleValue());
						amnt.setCurrencyCode(paymentplannerBO.getCurrency());
					disbShdl[iCount].setDisburseAmt(amnt);
					disbShdl[iCount].setRemarks((String)tokensType.nextElement());
				}
				}
			}

				}
			}
		catch (Exception ex)
		{
		}

		disbSchdDtl.setOdisbShdlLL(disbShdl);


   		//advancedDtls.setMortDtls(MortDtls);


		ciUserInfo.setChannelType("CRM");

		FIIncidentInfo objFIIncidentInfo = new FIIncidentInfo();
   		String xx = String.valueOf(System.currentTimeMillis());
   		xx = xx + paymentplannerBO.getSalesID();
		objFIIncidentInfo.setDccReqRefNum(xx);
		//String xy = new java.text.SimpleDateFormat("MM-dd-yyyy HH:MM:ss.ms").format(new Date());
		String xy = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(new Date());
		objFIIncidentInfo.setDccReqOrigTime(xy);
   		objFIIncidentInfo.setDccReqType("DEFAULTEJB");

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

		if(check == "true")
		{
		accountPrepaymentschdl.setOprepaymentLL(repayLL);
		loanScheduleVO.setAcctPrepaymentShdlLA(accountPrepaymentschdl);
		}
		loanScheduleVO.setAdvanceParameters(lamodAdvance);
		loanScheduleVO.setAmortCriteria(amCriteria);
		loanScheduleVO.setDisbShdlDtl(disbSchdDtl);
		loanScheduleVO.setPreEmiParam(preEmi);
		modStructParam.setOstructRepShdlLL(modStructLL);
		loanScheduleVO.setModStructRepParam(modStructParam);
		loanScheduleVO.setMandatoryParameters(lamodMandParam);
		loanScheduleVO.setVariables(lamodSchdlVar);
		loanScheduleVO.setFIIncidentInfo(objFIIncidentInfo);

		try
		{
			LoanServicesALImplementation inter = LoanServicesALImplementation.getInstance();
			LoanModellingSchOutputVO scheduleStruct	= inter.doSchedule(ciUserInfo, loanScheduleVO);


			LamodRepaymentLL arrayciRepayLL[] = scheduleStruct.getLamodRepaymentLL();
			FIAmortLL arrayciAmortizeLL[] = scheduleStruct.getOamortLL();


			SRMCollection ppDetailsList = paymentplannerBO.getPaymentPlannerDetails();
			/********Tracker No:88539:Start*******/
			paymentplannerBO.setOfferRate(netRate);
			/********Tracker No:88539:Start*******/
			PaymentPlannerBO.PaymentPlannerDetails ppDetails = null;//(PaymentPlannerBO.PaymentPlannerDetails) paymentplannerBO.getInstance("PaymentPlannerDetails");

			String instType = "INSTALLMENT_TYPE";
			Amount amot = null;

			for(int i=0; i<arrayciRepayLL.length; i++)
			{
				ppDetails = (PaymentPlannerBO.PaymentPlannerDetails) paymentplannerBO.getInstance("PaymentPlannerDetails");

				ppDetails.setType(Constants.PAYMENTSCHEDULE);
				MultiRecKey mKey = arrayciRepayLL[i].getKey();
				ppDetails.setStrField4(mKey.getSerial_num());
				ppDetails.setStrField2(arrayciRepayLL[i].getFlowDesc());
				ppDetails.setStrField3(arrayciRepayLL[i].getFreq());

				SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
				if(arrayciRepayLL[i].getFlowStartDate()!=null)
				{
					java.util.Date dat = arrayciRepayLL[i].getFlowStartDate().getTime();
					ppDetails.setDateField1(dat);
				}
				else
				{
					ppDetails.setDateField1(null);
				}
				//ppDetails.setStrField9(arrayciRepayLL[i].getFlowId());

				if(arrayciRepayLL[i].getFlowAmt()!=null)
				{
					amot = arrayciRepayLL[i].getFlowAmt();
					ppDetails.setAmountField1(new Double(amot.getAmountValue()));
				}
				else
				{
					ppDetails.setAmountField1(new Double(0.0));
				}

				if(arrayciRepayLL[i].getNoOfInstalments()!=0)
				{
					String lNoofInstal = new Long(arrayciRepayLL[i].getNoOfInstalments()).toString();
					ppDetails.setIntField1(new Integer(lNoofInstal));
				}
				else
				{
					ppDetails.setIntField1(new Integer(0));
				}

				ppDetailsList.add(ppDetails);
			}


			for(int i=0; i<arrayciAmortizeLL.length; i++)
			{

				ppDetails = (PaymentPlannerBO.PaymentPlannerDetails) paymentplannerBO.getInstance("PaymentPlannerDetails");
				FIAmortShdlDtls amortSchdl = arrayciAmortizeLL[i].getAmortStruct();
				ppDetails.setType(Constants.AMORTIZATIONSCHEDULE);
				MultiRecKey mKeyamort = arrayciAmortizeLL[i].getKey();
				ppDetails.setStrField4(mKeyamort.getSerial_num());

				SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
				if(amortSchdl.getFlowDate()!=null)
				{
				 try{
				 java.util.Date dat = amortSchdl.getFlowDate().getTime();
				 ppDetails.setDateField2(dat);
			 	}catch(Exception e){ e.printStackTrace();}
				}
				else
				ppDetails.setDateField2(null);

				if(amortSchdl.getInstlAmt()!=null)
				{
				try{
				amot = amortSchdl.getInstlAmt();
				ppDetails.setAmountField3(new Double(amot.getAmountValue()));
				}catch(Exception e){ }
				}
				else
				ppDetails.setAmountField3(null);

				if(amortSchdl.getPrincAmt()!=null)
				{
					amot = amortSchdl.getPrincAmt();
					ppDetails.setAmountField4(new Double(amot.getAmountValue()));
				}
				else
				ppDetails.setAmountField4(null);

				if(amortSchdl.getIntAmt()!=null)
				{
					amot = amortSchdl.getIntAmt();
					ppDetails.setAmountField5(new Double(amot.getAmountValue()));

				}
				else
				ppDetails.setAmountField5(null);

				if(amortSchdl.getCummPrincAmt()!=null)
				{
					amot = amortSchdl.getCummPrincAmt();
					ppDetails.setAmountField6(new Double(amot.getAmountValue()));

				}
				else
				ppDetails.setAmountField6(null);

				if(amortSchdl.getCummIntAmt()!=null)
				{
					amot = amortSchdl.getCummIntAmt();
					ppDetails.setAmountField7(new Double(amot.getAmountValue()));
				}
				else
				ppDetails.setAmountField7(null);

				ppDetailsList.add(ppDetails);
			}
		  /*** Start 110899****/
		}
		catch (CINonFatalException e)
		{
			try{
				logError("An Internal error occured.Check the interface logs", salesID, bc);
			}catch(Exception ex){}
			throw new SRMBCException(SRMBCException.ONS_EXCEPTION,SRMBCException.MakeReplaceableArg("CINonFatalException - " + e.getMessage()),null);
		}
		catch (CIFatalException e)
		{
			try{
				logError("An Internal error occured.Check the interface logs", salesID, bc);
			}catch(Exception ex){}
			throw new SRMBCException(SRMBCException.ONS_EXCEPTION,SRMBCException.MakeReplaceableArg("CIFatalException - " + e.getMessage()),null);
		}
		catch (CIOnsNonFatalException confe){
				confe.printStackTrace();
		try{
			logError(confe, salesID, bc);
		}catch(Exception ex){}


		String strErrMsg = "";
		for (int i = 0; i < confe.getErrorLL().length; i++)
		{
			CIOnsErr errObj = (CIOnsErr) confe.getErrorLL()[i];

			if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1)
			{
				strErrMsg = strErrMsg + "(" + (i + 1) + ") " + errObj.errDesc;
			}
			else
			{
				strErrMsg = strErrMsg + "(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;
			}
		}
		throw new SRMBCException(SRMBCException.ONS_EXCEPTION,
			SRMBCException.MakeReplaceableArg("CIOnsNonFatalException - " + strErrMsg),null);
		}
		catch (Throwable e)
		{
			throw new CIFatalException(
			"Runtime errror occured during EISchedule. Please refer to server log",e);
		}
	   /*** End 110899****/
 /* END OF COMMENTS*/
		/* CRA10MSC - ARM - Begin of changes : Stopping BL Layer transaction */

		/* CRA10MSC - ARM - End of changes */
		return paymentplannerBO;

	}
		public void setForSchedule(PaymentPlannerBO paymentplannerBO,Double InsAmt)
					throws SRMBCException{

				if(paymentplannerBO.getOriginationDate()!=null)
				{
					Calendar cal2 = Calendar.getInstance();
					cal2.setTime(paymentplannerBO.getOriginationDate());
					lamodMandParam.setOriginationDate(cal2);
				}else	lamodMandParam.setOriginationDate(null);
				if(paymentplannerBO.getTenorMonths()!=null)
				{
					lamodMandParam.setLoanPerdMths(paymentplannerBO.getTenorMonths().longValue());
				}else	lamodMandParam.setLoanPerdMths(0);
				if(paymentplannerBO.getTenorDays()!=null)
				{
					lamodMandParam.setLoanPerdDays(paymentplannerBO.getTenorDays().longValue());
				}else	lamodMandParam.setLoanPerdDays(0);
				if(paymentplannerBO.getNoOfInstallments()!=null)
				{
					lamodSchdlVar.setNoOfInstalmnts((paymentplannerBO.getNoOfInstallments()).longValue());
				}else	lamodSchdlVar.setNoOfInstalmnts(0);
				Double cDiscount;
				/* Changes for tracker id 352709 Start to set correct value for discount*/
				if(paymentplannerBO.getAcPreferentialDr()!=null){
					//System.out.println("EMIFetechFromCore");
					cDiscount =	(Double)(paymentplannerBO.getAcPreferentialDr());
					//System.out.println("EMIFetechFromCore cDiscount"+cDiscount);
				}/* Changes for tracker id 352709 End */
				else{
					cDiscount=new Double(0.0);
				}
				if(paymentplannerBO.getCardedInterestRate()!=null){
					effectIntRate=(Double)(paymentplannerBO.getCardedInterestRate());
					//System.out.println("EMIFetechFromCore effectIntRate"+effectIntRate);
				}else{
					effectIntRate=new Double(0.0);
				}
// changes for 319940
			//	netRate=new Double(effectIntRate.doubleValue()+cDiscount.doubleValue());
				netRate=new Double(effectIntRate.doubleValue());
				if ( netRate.doubleValue() >0.0 ){
					pcnt.setValue(netRate.doubleValue());
					lamodSchdlVar.setIntRate(pcnt);
				}else{
					pcnt.setValue(0.0);
					lamodSchdlVar.setIntRate(pcnt);
				}
				  SRMCollection intSlabDet = paymentplannerBO.getSaleIntSlabDetails();
				                                   int iIntSlabDetails = intSlabDet.size();

				   if ( iIntSlabDetails == 0 ) {

					tblCode.setTableCode(paymentplannerBO.getInterestCode());
					lamodMandParam.setIntTblCode(tblCode);
					  } else {
							/*This code checks for validation>>[[Start date of 1st slab must be origination date.]]
							if the origination date is before Start Date,then Start Date==Origination Date
							Also,if origination date is between start date n end date,then also,Start Date=Origination Date
							The Count of the slab which satisfies the given criteria is recorded in variable iCnt
							*/
								int iCnt=0;

								Date dtOrg = paymentplannerBO.getOriginationDate();
								for ( int j =0 ; j<iIntSlabDetails; j++){
									PaymentPlannerBO.SaleIntSlabDetails intSlDet=
													(PaymentPlannerBO.SaleIntSlabDetails) intSlabDet.get(j);
									Date dtEndDate = intSlDet.getEndDate();
									Date dtStartDate = intSlDet.getStartDate();

									if(dtOrg.before(dtStartDate)){
										iCnt=j;
										break;
									}else if (dtStartDate.before(dtOrg) && dtEndDate.after(dtOrg)){
										iCnt=j;
										break;
									}

								}

								modIntSlabLL = new ModIntSlabLL[iIntSlabDetails-iCnt];
								/*
								var k,represents the index for the array modIntSlabLL
								*/
								int k=0;
								for ( int i =iCnt ; i<iIntSlabDetails; i++){
								modIntSlabLL[k]=new ModIntSlabLL();
								   PaymentPlannerBO.SaleIntSlabDetails intSlabDetails =
																   (PaymentPlannerBO.SaleIntSlabDetails) intSlabDet.get(i);
								   Date dtEndDate = intSlabDetails.getEndDate();
														   //System.out.println("dtEndDate>>>>>"+dtEndDate);
								   if (dtEndDate != null ){
										   Calendar cal3 = Calendar.getInstance();
										   cal3.setTime(dtEndDate);
										   modIntSlabLL[k].setEndDate(cal3);
								   } else {
										   modIntSlabLL[k].setEndDate(null);
								   }

								   Date dtStartDate = intSlabDetails.getStartDate();
														   //System.out.println("dtStartDate>>>>>>>"+dtStartDate);
								   if (dtStartDate != null ){
										   Calendar cal3 = Calendar.getInstance();
										   if(k==0){
												cal3.setTime(paymentplannerBO.getOriginationDate());
												modIntSlabLL[k].setStartDate(cal3);
											}else{
												cal3.setTime(dtStartDate);
												modIntSlabLL[k].setStartDate(cal3);
											}
								   } else {
										   modIntSlabLL[k].setStartDate(null);
								   }

								   String strIntTblCode = intSlabDetails.getInterestTableCode();
														   //System.out.println("strIntTblCode>>>>>>>>"+strIntTblCode);
								   if ( strIntTblCode != null ) {
										   modIntSlabLL[k].setIntTblCode(strIntTblCode);
								   } else {
										   modIntSlabLL[k].setIntTblCode(null);
								   }
								   MultiRecKey key = new MultiRecKey();
								   key.setSerial_num(k+1+"");
								   modIntSlabLL[k].setKey(key);
								    k++;
						   }
						   loanScheduleVO.setModIntSlabLL(modIntSlabLL);
				   }
				/* Changes for tracker id 352709 Start */
				if(paymentplannerBO.getAcPreferentialDr()!=null)
				{
					percent.setValue(paymentplannerBO.getAcPreferentialDr().doubleValue());
					lamodSchdlVar.setPrefRate(percent);
				}
				/* Changes for tracker id 352709 End */
				    schmCode.setSchmCode(paymentplannerBO.getProductsKey().toString());
				    lamodMandParam.setSchmCode(schmCode);
					 lamodMandParam.setCrncyCode(paymentplannerBO.getCurrency());
				if(InsAmt!=null)
				{
					amt.setAmountValue(InsAmt.doubleValue());
					amt.setCurrencyCode(paymentplannerBO.getCurrency().toString());
					lamodSchdlVar.setLoanAmount(amt);
				}
				else
				{
					if(paymentplannerBO.getLoanAmount()!=null)
					{
						Double dLoanAmt = paymentplannerBO.getLoanAmount();
						amt.setAmountValue(dLoanAmt.doubleValue());
						amt.setCurrencyCode(paymentplannerBO.getCurrency().toString());
						lamodSchdlVar.setLoanAmount(amt);
					}else{
						amt.setAmountValue(0.0);
						amt.setCurrencyCode(null);
						lamodSchdlVar.setLoanAmount(amt);

					}

				}
				lamodAdvance.setCaptInt(paymentplannerBO.getCompoundIntOnCapitalize());
				lamodAdvance.setEIMethod(paymentplannerBO.getEIType());
				lamodAdvance.setEIFreq(paymentplannerBO.getEIFrequency());
				lamodAdvance.setIntCalcFreq(paymentplannerBO.getCompoundingFreq());
				lamodAdvance.setEIFormula(paymentplannerBO.getEIFormula());
				lamodAdvance.setIntBaseMthd(paymentplannerBO.getIntBaseMethod());
				amCriteria.setFullPerdInterest(paymentplannerBO.getApplyIntForFull());

				if(paymentplannerBO.getNoOfDaysInYear()!=null)
				{
					lamodAdvance.setNoOfDaysInaYr(paymentplannerBO.getNoOfDaysInYear().longValue());
				}else	lamodAdvance.setNoOfDaysInaYr(365);



				lamodAdvance.setIntRestFreq(paymentplannerBO.getRestFreq());
				amCriteria.setIntRestBasis(paymentplannerBO.getRestBasis());
				if(null != paymentplannerBO.getAllowGradPayment()){
				lamodAdvance.setStepsAllow(paymentplannerBO.getAllowGradPayment().toString());
				}
				lamodAdvance.setStepIndicator(paymentplannerBO.getStepIndicator());

				if(null != paymentplannerBO.getNoOfSteps())
				{
					lamodAdvance.setNoOfSteps(paymentplannerBO.getNoOfSteps());
				}else 	lamodAdvance.setNoOfSteps(0);

				if(null != paymentplannerBO.getStepPercentage())
				{
					prct.setValue(paymentplannerBO.getStepPercentage().doubleValue());
					lamodAdvance.setStepPcnt(prct);
				}else{
						prct.setValue(0.0);
						lamodAdvance.setStepPcnt(prct);
				}
			}

		public void setForCompute(PaymentPlannerBO paymentplannerBO,  Double InsAmt)
				throws SRMBCException{

						if(paymentplannerBO.getOriginationDate()!=null)
						{
							cal.setTime(paymentplannerBO.getOriginationDate());
							mandParams.setOriginationDate(cal);
						}else 	mandParams.setOriginationDate(null);

						if(paymentplannerBO.getTenorMonths()!=null)
								mandParams.setLoanPerdMths(paymentplannerBO.getTenorMonths().longValue());
						else	mandParams.setLoanPerdMths(0);

						if(paymentplannerBO.getTenorDays()!=null)
								mandParams.setLoanPerdDays(paymentplannerBO.getTenorDays().longValue());
						else 	mandParams.setLoanPerdDays(0);

						if(paymentplannerBO.getNoOfInstallments()!=null)
						{
							lamodvar.setNoOfInstalmnts((paymentplannerBO.getNoOfInstallments()).longValue());
						}else	lamodvar.setNoOfInstalmnts(0);
										Double cDiscount;
						if(paymentplannerBO.getOfferRate()!=null){
							cDiscount =	(Double)(paymentplannerBO.getOfferRate());
						}else{
							cDiscount=new Double(0.0);
						}
						if(paymentplannerBO.getCardedInterestRate()!=null){
							effectIntRate=(Double)(paymentplannerBO.getCardedInterestRate());
						}else{
							effectIntRate=new Double(0.0);
						}
						netRate=new Double(effectIntRate.doubleValue()+cDiscount.doubleValue());
						if( netRate.doubleValue() >0.0 ){
								pcnt.setValue(netRate.doubleValue());
								lamodvar.setIntRate(pcnt);
						}else{
								pcnt.setValue(0.0);
								lamodvar.setIntRate(pcnt);
						}
						SRMCollection intSlabDet = paymentplannerBO.getSaleIntSlabDetails();
						int iIntSlabDetails = intSlabDet.size();

						 if ( iIntSlabDetails == 0 ) {
						compTblCode.setTableCode(paymentplannerBO.getInterestCode());
						mandParams.setIntTblCode(compTblCode);
					   } else {
							   /*PaymentPlannerBO.SaleIntSlabDetails intSlabDetails =
																	   (PaymentPlannerBO.SaleIntSlabDetails)
																									   paymentplannerBO.getInstance("SaleIntSlabDetails");*/

							   modIntSlabLL = new ModIntSlabLL[iIntSlabDetails];
							   for ( int i =0 ; i<iIntSlabDetails; i++){
									   PaymentPlannerBO.SaleIntSlabDetails intSlabDetails =
																	   (PaymentPlannerBO.SaleIntSlabDetails) intSlabDet.get(i);
									   Date dtEndDate = intSlabDetails.getEndDate();
									   if (dtEndDate != null ){
											   Calendar cal3 = Calendar.getInstance();
											   cal3.setTime(dtEndDate);
											   modIntSlabLL[i].setEndDate(cal3);
									   } else {
											   modIntSlabLL[i].setEndDate(null);
									   }

									   Date dtStartDate = intSlabDetails.getStartDate();
									   if (dtStartDate != null ){
											   Calendar cal3 = Calendar.getInstance();
											   cal3.setTime(dtStartDate);
											   modIntSlabLL[i].setStartDate(cal3);
									   } else {
											   modIntSlabLL[i].setStartDate(null);
									   }

									   String strIntTblCode = intSlabDetails.getInterestTableCode();
									   if ( strIntTblCode != null ) {
											   modIntSlabLL[i].setIntTblCode(strIntTblCode);
									   } else {
											   modIntSlabLL[i].setIntTblCode(null);
									   }
									   MultiRecKey key = new MultiRecKey();
									   key.setSerial_num(i+1+"");
									   modIntSlabLL[i].setKey(key);
							   }
							   loanComputeVO.setModIntSlabLL(modIntSlabLL);
					   }

						if(paymentplannerBO.getOfferRate()!=null)
						{
								percent.setValue(paymentplannerBO.getOfferRate().doubleValue());
								lamodvar.setPrefRate(percent);
						}
						compSchmCode.setSchmCode(paymentplannerBO.getProductsKey().toString());
		           		mandParams.setSchmCode(compSchmCode);
						mandParams.setCrncyCode(paymentplannerBO.getCurrency());
						if(InsAmt!=null)
						{
								amt.setAmountValue(InsAmt.doubleValue());
								amt.setCurrencyCode(paymentplannerBO.getCurrency().toString());
								lamodvar.setLoanAmount(amt);
						}
						else
						{
							if(paymentplannerBO.getLoanAmount()!=null)
							{
								Double dLoanAmt = paymentplannerBO.getLoanAmount();
									amt.setAmountValue(dLoanAmt.doubleValue());
									amt.setCurrencyCode(paymentplannerBO.getCurrency().toString());
									lamodvar.setLoanAmount(amt);
							}else
							{
									amt.setAmountValue(0.0);
									amt.setCurrencyCode(null);
									lamodvar.setLoanAmount(amt);
							}
						}

							//advParams.setCaptInt(paymentplannerBO.getCompoundIntOnCapitalize());
							advParams.setEIMethod(paymentplannerBO.getEIType());
							advParams.setIntCalcFreq(paymentplannerBO.getCompoundingFreq());
							advParams.setEIFreq(paymentplannerBO.getEIFrequency());
							advParams.setEIFormula(paymentplannerBO.getEIFormula());
							advParams.setIntBaseMthd(paymentplannerBO.getIntBaseMethod());
							amortCriteria.setFullPerdInterest(paymentplannerBO.getApplyIntForFull());
						/*if(paymentplannerBO.getNoOfDaysInYear()!=null)
						{
								advParams.setNoOfDaysInaYr(paymentplannerBO.getNoOfDaysInYear().longValue());
						}else	advParams.setNoOfDaysInaYr(0);*/

						if(null != paymentplannerBO.getInstallmentStartDate())
						{
							cal.setTime(paymentplannerBO.getInstallmentStartDate());
							amortCriteria.setInstlStartDate(cal);
						}else	amortCriteria.setInstlStartDate(null);

							//advParams.setIntRestFreq(paymentplannerBO.getRestFreq());
							amortCriteria.setIntRestBasis(paymentplannerBO.getRestBasis());
							//advParams.setStepsAllow(paymentplannerBO.getAllowGradPayment());
							//advParams.setStepIndicator(paymentplannerBO.getStepIndicator());

						/*if(paymentplannerBO.getNoOfSteps()!=null)
						{
								advParams.setNoOfSteps(new Long(paymentplannerBO.getNoOfSteps().toString()).longValue());
						}else	advParams.setNoOfSteps(0);*/

						/*if(paymentplannerBO.getStepPercentage()!=null)
						{
								prct.setValue(paymentplannerBO.getStepPercentage().doubleValue());
								advParams.setStepPcnt(prct);
						}else{
								prct.setValue(0.0);
								advParams.setStepPcnt(prct);
						}*/
				}
	  /*** Start 110899****/
		public void logError(CIOnsNonFatalException confe,Integer iSalesID, SRMBusinessContext bc)
				throws SRMBOException, SRMTypeValidatorException, SRMSecurityException{

		try{

		Calendar cal = Calendar.getInstance();
		java.util.Date sysDate = cal.getTime();

		ErrorReportBO errRptBO = null;
		SRMQueryBuilder qb =  QueryAssist.singleObjectQuery("ErrorReportBO",ErrorReportBO.SALES_STATUS_ID);
		QueryAssist.addSimpleCondition(qb,"ErrorReportBO",ErrorReportBO.SALESID,IQuery.ComparisonOperation_EQ,""+iSalesID);
		SRMQueryResult qr = qb.runQuery(bc,true,-1);
		SRMRecordSet rs = qr.getRecordSet();
		if(rs.hasNext())
		{
			errRptBO = (ErrorReportBO)rs.getNext().get(0);

		}
		if ( errRptBO == null ) {

			errRptBO = new ErrorReportBO();
			errRptBO.setSalesId(iSalesID);
		}
		SRMCollection errStatHisList = errRptBO.getSales_Status_History();



           for (int i = 0; i < confe.getErrorLL().length; i++) {
               String strErrMsg = "";
               CIOnsErr errObj =  confe.getErrorLL()[i];

               if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1) {

                   strErrMsg = "(" + (i + 1) + ") " + errObj.errDesc;
               } else {

                   strErrMsg = "(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;
               }

				ErrorReportBO.Sales_Status_History  InstanceOfSales_Status_History_Y = null;
				InstanceOfSales_Status_History_Y = (ErrorReportBO.Sales_Status_History)errRptBO.getInstance("Sales_Status_History");
				InstanceOfSales_Status_History_Y.setBriefDesc("CIOnsNonFatalException");
				InstanceOfSales_Status_History_Y.setStatus_Desc(strErrMsg);
				InstanceOfSales_Status_History_Y.setDateOfError(sysDate);

				errStatHisList.add(InstanceOfSales_Status_History_Y);
           }

		Core.SaveErrorReport(bc,errRptBO);
	}
	catch(Exception ee)
	{
		ee.printStackTrace();
	}
	}


	public void logError(String errMsg, Integer iSalesID, SRMBusinessContext bc)
				throws SRMBOException, SRMTypeValidatorException, SRMSecurityException{

		Calendar cal = Calendar.getInstance();
		java.util.Date sysDate = cal.getTime();
		try{

		ErrorReportBO errRptBO = null;
		SRMQueryBuilder qb =  QueryAssist.singleObjectQuery("ErrorReportBO",ErrorReportBO.SALES_STATUS_ID);
		QueryAssist.addSimpleCondition(qb,"ErrorReportBO",ErrorReportBO.SALESID,IQuery.ComparisonOperation_EQ,""+iSalesID);
		SRMQueryResult qr = qb.runQuery(bc,true,-1);
		SRMRecordSet rs = qr.getRecordSet();
		if(rs.hasNext())
		{
			errRptBO = (ErrorReportBO)rs.getNext().get(0);

		}
		if ( errRptBO == null ) {

			errRptBO = new ErrorReportBO();
			errRptBO.setSalesId(iSalesID);
		}
		SRMCollection errStatHisList = errRptBO.getSales_Status_History();
		ErrorReportBO.Sales_Status_History  InstanceOfSales_Status_History_Y = null;
		InstanceOfSales_Status_History_Y = (ErrorReportBO.Sales_Status_History)errRptBO.getInstance("Sales_Status_History");
		InstanceOfSales_Status_History_Y.setBriefDesc("Fatal Error.");
		InstanceOfSales_Status_History_Y.setStatus_Desc(errMsg);
		InstanceOfSales_Status_History_Y.setDateOfError(sysDate);
		errStatHisList.add(InstanceOfSales_Status_History_Y);

		Core.SaveErrorReport(bc,errRptBO);

		}catch(Exception ee){
			ee.printStackTrace();
		}
	}
	/*** End 110899****/

public Double getAPR(PaymentPlannerBO paymentplannerBO, ArrayList disb, ArrayList chgAmt) throws Exception
	  //throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, SRMTypeValidatorException, CIFatalException
	  {

		CIUserInfo ciUserInfo = new CIUserInfo();
		EirCalcMsg eirCalcMsg = new EirCalcMsg();
		Frequency frq = new Frequency();
		CILAComputeEIRRateFCRM chrg = new CILAComputeEIRRateFCRM();


		LoanAccountALImplementation ciRAI = new LoanAccountALImplementation() ;
		SRMCollection ppDet = paymentplannerBO.getPaymentPlannerDetails();
		int iRepaySize = 0;
		for (int i =0 ; i<ppDet.size();i++ )
		{
			PaymentPlannerBO.PaymentPlannerDetails ppDetails = (PaymentPlannerBO.PaymentPlannerDetails) ppDet.get(i);
			if (ppDetails.getType() != null && ppDetails.getType().equals (Constants.AMORTIZATIONSCHEDULE))
			{
				iRepaySize++;
			}
		}
		int disbCount = 0;
		if (disb != null){
			disbCount = disb.size();
		}
		int iSize = disbCount+iRepaySize+chgAmt.size();

		IrrLL[] irrLL = new IrrLL[iSize];
		int irrSize = 0;

		/*Amortization details Starts*/

		/*Amortization details Ends*/
		String strDisbDate = null;
		int iCount = 1;
		/*Disbursment details Starts*/
		if ( disbCount > 0 )
		{
			StringTokenizer tokensType = null ;
			String disbRow = null;
			//mulKey.setSerial_num("D");

			for (iCount = 0; iCount < disbCount ; iCount++ )
			{
				irrLL[irrSize] = new IrrLL();
				Amount amnt = irrLL[irrSize].getFlowAmt();
				disbRow = (String) disb.get(iCount);
				if(disbRow != null)
				{
					tokensType = new StringTokenizer(disbRow, "|");
					if ( tokensType.hasMoreTokens() )
					{
						strDisbDate = (String)tokensType.nextElement();
						Calendar cal1 = Calendar.getInstance();
						//Date todaysDate1 = new Date();
						//cal1.setTime(todaysDate1);
						//cal1.setTime(paymentplannerBO.getOriginationDate());// to be verified ***
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
						Date date = dateFormat.parse (strDisbDate);
						cal1.setTime(date);
						irrLL[irrSize] = new IrrLL();
						irrLL[irrSize].setFlowDate(cal1);
						String strAmount = (String)tokensType.nextElement();
						Amount amnt1 = new Amount();
						amnt1.setAmountValue(-(new Double(strAmount)).doubleValue());
						amnt1.setCurrencyCode(paymentplannerBO.getCurrency());// to be verified ***
					irrLL[irrSize].setFlowAmt(amnt1);
					MultiRecKey mulKey1 = new MultiRecKey();
					mulKey1.setSerial_num(irrSize+1+"");
					irrLL[irrSize].setLlKey(mulKey1);
					irrSize++;
					}
				}
			}
		}
		/*Disbursment details Ends*/
		/*Fees details start*/
		for(int i=0; i<chgAmt.size(); i++){
			Calendar cal1 = Calendar.getInstance();
			if ( strDisbDate != null ){
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date date = dateFormat.parse (strDisbDate);
				cal1.setTime(date);
			} else {
				Date todaysDate = new Date();
				cal1.setTime(todaysDate);
			}
			irrLL[irrSize] = new IrrLL();
			Amount amnt = irrLL[irrSize].getFlowAmt();
			irrLL[irrSize].setFlowDate(cal1);				// Date Fld should be verified
			Double dAmount = (Double)chgAmt.get(i);
			amnt.setAmountValue(dAmount.doubleValue());
			amnt.setCurrencyCode(paymentplannerBO.getCurrency());
			irrLL[irrSize].setFlowAmt(amnt);
			MultiRecKey mulKey = new MultiRecKey();
			mulKey.setSerial_num(irrSize+1+"");
			irrLL[irrSize].setLlKey(mulKey);
			irrSize++;
		}
		/*Fees details Ends*/

		/* Amortization Details */
			for(int i=0; i<ppDet.size(); i++){
				Calendar cal1 = Calendar.getInstance();
				PaymentPlannerBO.PaymentPlannerDetails ppDetails = null;
				ppDetails = (PaymentPlannerBO.PaymentPlannerDetails) ppDet.get(i);
				Double strAmount = null;
				if ( ppDetails.getType() != null && ppDetails.getType().equals (Constants.PAYMENTSCHEDULE))
				{
					continue;
					//cal1.setTime(ppDetails.getDateField1());
					//strAmount = ppDetails.getAmountField1();
				} else if (ppDetails.getType() != null && ppDetails.getType().equals (Constants.AMORTIZATIONSCHEDULE))
				{
					cal1.setTime(ppDetails.getDateField2());
					strAmount = ppDetails.getAmountField3();
				}
				irrLL[irrSize] = new IrrLL();
				Amount amnt = new Amount();
				irrLL[irrSize].setFlowDate(cal1);
				amnt.setAmountValue(strAmount);
				amnt.setCurrencyCode(paymentplannerBO.getCurrency());
				irrLL[irrSize].setFlowAmt(amnt);
				MultiRecKey mulKey = new MultiRecKey();
				mulKey.setSerial_num(irrSize+1+"");
				irrLL[irrSize].setLlKey(mulKey);
				irrSize++;
			}
		/*Amortization details end*/

		eirCalcMsg.setIrrLL(irrLL);

		// Setting Correlator ID for forced sub-trans in core
			byte CorrelatorID[]=ARMTransHelper.getCorrelator();
			ciUserInfo.setCorrelationId(CorrelatorID);
			/* CRA10MSC - ARM - End of changes*/
			ciUserInfo.setChannelType("CRM");
			FIIncidentInfo objFIIncidentInfo = new FIIncidentInfo();
			String xx = String.valueOf(System.currentTimeMillis());
			xx = xx + paymentplannerBO.getSalesID();
			objFIIncidentInfo.setDccReqRefNum(xx);
			//String xy = new java.text.SimpleDateFormat("MM-dd-yyyy HH:MM:ss.ms").format(new Date());
			String xy = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(new Date());
			objFIIncidentInfo.setDccReqOrigTime(xy);
			objFIIncidentInfo.setDccReqType("DEFAULTEJB");
			/*Start of changes for Tracker Id:193542 */
			//ciUserInfo.setDccReqVersion("VER1");
			/*End of changes for Tracker Id:193542 */
			ciUserInfo.setAccessChannelId("CRM");
			ciUserInfo.setUserId("FIVUSR");
			eirCalcMsg.setFiIncidentInfo(objFIIncidentInfo);
			Calendar cal1 = Calendar.getInstance();
			Date todaysDate = new Date();
			cal1.setTime(todaysDate);
			eirCalcMsg.setRefDate(cal1);
			eirCalcMsg.setGuessRate(new Double(2));
			frq = eirCalcMsg.getLrFreq();
			frq.setType("M");
			frq.setStartDd(10);
			frq.setHldyStat("P");
			eirCalcMsg.setLrFreq(frq);
			String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();

			if( bankID != null && !bankID.equalsIgnoreCase("")){
				ciUserInfo.setBankId(bankID);
			}
			else{
				ciUserInfo.setBankId("01");
			}
			chrg   = ciRAI.doComputeEIRRate(ciUserInfo, eirCalcMsg);
			Double eirRate = chrg.getEirRate();
			return eirRate;
	  }
}




