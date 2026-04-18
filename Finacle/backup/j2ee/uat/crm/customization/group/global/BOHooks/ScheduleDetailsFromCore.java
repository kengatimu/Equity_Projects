package com.infy.cis.custom;
import com.infosys.ci.ons.cistruct.*;
import com.infosys.ci.hostinterface.common.*;
import com.infosys.ci.common.Amount;
import com.infosys.ci.common.CIFatalException;
import com.infosys.ci.common.CINonFatalException;
import com.infosys.ci.common.CIUserInfo;
import com.infosys.ci.common.FIIncidentInfo;
import com.infosys.ci.common.Percent;
import com.infosys.ci.ons.common.CIOnsErr;
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
import com.infy.cis.srmbo.Products;
import java.util.Date.*;
import java.text.DateFormat.*;
import com.infy.cis.common.ARMTransHelper;
import com.infy.cis.srmbo.PsychographicBO;//changes for callid:409425

public class ScheduleDetailsFromCore {
	/* Input Objects for sending to core*/
	CIUserInfo  ciUserInfo = new CIUserInfo();
	CILAAmortShdlInputFCRM inputVO = new CILAAmortShdlInputFCRM();
	CILAAmortOvarTenorSlabLLFCRM[] amortOvarTenorSlabLLFCRM = inputVO.getAmortOvarTenorSlabLAOpenFCRM();

	CILAAmortShdlBasicFCRM amortBasicInfo = inputVO.getAmortCommonInfoLAOpenFCRM().getAmortGeneralInfoLAOpenFCRM().getAmortBasicLAOpenFCRM();
	CILAAmortLaEiParamsFCRM amortEIParams = inputVO.getAmortRepaymentShdlLAOpenFCRM().getLaEiParamsOpenFCRM();

	CILAAmortLaShdlCmnFCRM amortNonEIParams = inputVO.getLaShdlCmn();
	CILAAmortRepaymentLLFCRM repayLL[] =null;
	CILAAmortShdlRepaymentShdlFCRM repayDtl = inputVO.getAmortRepaymentShdlLAOpenFCRM();

	CILAAmortDisburseScheduleLLFCRM disbScheduleLL[] =null;
	CILAAmortShdlDisburseShdlLAFCRM disbSchdDtl = inputVO.getAmortDisburseShdlLAOpenFCRM();

	String check = "false";
	Amount amt = new Amount();

	CILAAmortChargeFreqLLFCRM freqChrgLL[] =null;
	CILAAmortShdlChargeFreqFCRM freqChrgDtl = inputVO.getAmortChargeFreqLAFCRM();

	CILAAmortSubsidyLLFCRM subsidyLL[] =null;
	CILAAmortShdlSubsidyFCRM subsidyDtl = inputVO.getAmortSubsidyLAOpenFCRM();

	Percent prct = new Percent();
	CILAAmortStructuredRepmtLLFCRM  structRepayLL[] = null;
	CILAAmortLaShdlCmnFCRM commonField = inputVO.getLaShdlCmn();

	Integer salesID = new Integer(0);
	String strAPPLBRANCH = "";
	String strACCOUNTCURRENCY =  "";
	String strEIFLAG=  "";
	String strEIMODE=  "";
	String strUPFRONTINSTAMOUNT=  "";
	Integer strNUMBEROFUPFRONTINSTALLMENTS= new Integer(0);
	Integer strDEFERMENTSTARTMONTH=  new Integer(0);
	Integer strMAXDEFERMENTMONTH=  new Integer(0);
	String strCAPOVEREMI=  "";
	String strEIFormula=  "";
//changes for callid:409425
	Double strActPrfIntDr=new Double(0);
	Double strChnPrfIntDr=new Double(0);
	Double strNegPrfIntDr=new Double(0);
	boolean slabFlag=false;
//changes for callid:409425 ends
	private static final String EIFetchFromCore_SALEBACKENDDETAILS = "com.infy.cis.custom.BOHooks.ScheduleDetailsFromCore_SaleBackEndBO_getEligAmt";
	public PaymentPlannerBO calculatePaymentSchedule(SRMBusinessContext bc, PaymentPlannerBO paymentplannerBO, ArrayList disb)
	throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, SRMTypeValidatorException, CIFatalException
	{

		salesID = paymentplannerBO.getSalesID();
		/*Condition to check whether eI amort calculation needs to be called or Non ei amort calc*/

		if(paymentplannerBO.getEIType() !=null && 	"Y".equalsIgnoreCase(paymentplannerBO.getEIType()))

		{
			paymentplannerBO=scheduleEI(bc, paymentplannerBO, disb);
		}
		else if((paymentplannerBO.getEIType() !=null )&& ("N".equalsIgnoreCase(paymentplannerBO.getEIType()))){
			paymentplannerBO=scheduleNonEI(bc, paymentplannerBO, disb);
		}

		return paymentplannerBO;
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
		CILAAmortShdlDtlsOutLLFCRM outputVo =null;
		CILoanModScheduleOutStruct lamodSchedule = null;
		int disbCount = 0;
		/*** Start 110899****/
		salesID = paymentplannerBO.getSalesID();
		/*** End 110899****/

		ArrayList arrSalebackendDetails  = getSaleBackendDetails(bc);
		strAPPLBRANCH = (String)arrSalebackendDetails.get(0);
		strACCOUNTCURRENCY =  (String)arrSalebackendDetails.get(1);
		strEIFLAG=  (String)arrSalebackendDetails.get(2);
		strEIMODE=  (String)arrSalebackendDetails.get(3);
		strUPFRONTINSTAMOUNT= (String)arrSalebackendDetails.get(4);
		strNUMBEROFUPFRONTINSTALLMENTS= (Integer)arrSalebackendDetails.get(5);
		strDEFERMENTSTARTMONTH=  (Integer)arrSalebackendDetails.get(6);
		strMAXDEFERMENTMONTH=  (Integer)arrSalebackendDetails.get(7);
		strCAPOVEREMI= (String)arrSalebackendDetails.get(8);
		strEIFormula = (String)arrSalebackendDetails.get(9);
		//change for callid 409425 begins
        strActPrfIntDr=(Double)arrSalebackendDetails.get(10);
        strChnPrfIntDr=(Double)arrSalebackendDetails.get(11);
        strNegPrfIntDr=(Double)arrSalebackendDetails.get(12);
        //change for callid 409425 ends
		try
		{
			setAmortBasicInfo(bc,paymentplannerBO);
		}
		catch (Exception e2){

			e2.printStackTrace();
		}
		setAmortEIParams(paymentplannerBO);
		setRepaypaymentLLDetails(paymentplannerBO);
		setFrequencyChargeDetails(bc);

		if (disb != null)
		{
			setDisbursementDetails(disb, paymentplannerBO);
		}
		setTenorSlabDetails(bc, paymentplannerBO);
		try{
		setAdvancePaymentDetails(paymentplannerBO);

		setSubsidyDetails(bc, paymentplannerBO);
		//call core
		paymentplannerBO = getCoreAmortSchedule(bc, paymentplannerBO);
		}
		catch (Exception e){

			e.printStackTrace();
		}


		return paymentplannerBO;

	}
	public PaymentPlannerBO scheduleNonEI(SRMBusinessContext bc, PaymentPlannerBO paymentplannerBO, ArrayList disb)
	throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, SRMTypeValidatorException, CIFatalException
	{

		/* CRA10MSC - ARM - Begin of changes : Starting BL Layer transaction */


		/* CRA10MSC - ARM - End of changes */

		CILAAmortShdlDtlsOutLLFCRM outputVo =null;
		CILoanModScheduleOutStruct lamodSchedule = null;
		int disbCount = 0;
		/*** Start 110899****/
		salesID = paymentplannerBO.getSalesID();
		/*** End 110899****/
		ArrayList arrSalebackendDetails  = getSaleBackendDetails(bc);
		strAPPLBRANCH = (String)arrSalebackendDetails.get(0);
		strACCOUNTCURRENCY =  (String)arrSalebackendDetails.get(1);
		strEIFLAG=  (String)arrSalebackendDetails.get(2);
		//change for callid 409425 begins
		        strActPrfIntDr=(Double)arrSalebackendDetails.get(10);
		        strChnPrfIntDr=(Double)arrSalebackendDetails.get(11);
		        strNegPrfIntDr=(Double)arrSalebackendDetails.get(12);
        //change for callid 409425 ends
		//strEIMODE=  (String)arrSalebackendDetails.get(3);
		//strUPFRONTINSTAMOUNT= (String)arrSalebackendDetails.get(4);
		//strNUMBEROFUPFRONTINSTALLMENTS= (Integer)arrSalebackendDetails.get(5);
		//strDEFERMENTSTARTMONTH=  (Integer)arrSalebackendDetails.get(6);
		//strMAXDEFERMENTMONTH=  (Integer)arrSalebackendDetails.get(7);
		//strCAPOVEREMI= (String)arrSalebackendDetails.get(8);
		//strEIFormula = (String)arrSalebackendDetails.get(9);
		//System.out.println("calling  strAPPLBRANCH---------------->"+strAPPLBRANCH);
		//System.out.println("calling  strACCOUNTCURRENCY---------------->"+strACCOUNTCURRENCY);
		//System.out.println("calling  strEIFLAG---------------->"+strEIFLAG);

		setAmortBasicInfo(bc, paymentplannerBO);
		setNonEIParams(bc, paymentplannerBO);
		setRepaymentLLDetailsNonEI(paymentplannerBO);
		//setFrequencyChargeDetails(bc);


		if (disb != null)
		{
			setDisbursementDetails(disb, paymentplannerBO);
		}

		//call core
		paymentplannerBO = getCoreAmortSchedule(bc, paymentplannerBO);
		return paymentplannerBO;

	}
	private void setRepaymentLLDetailsNonEI(PaymentPlannerBO paymentplannerBO)
		throws SRMBCException{
			try{
				// Setting Structured Repayment and Planned Prepayment Details.
				/***Tracker 178800 starts***/
				Long ltrFieldDay = null;
				String strFieldDay = "";
				/***Tracker 178800 starts***/
				SRMCollection ppDetColl = paymentplannerBO.getPaymentPlannerDetails();
				PaymentPlannerBO.PaymentPlannerDetails ppDet = null;
				int iCollSize = 0;
				//System.out.println("ppDetColl--------->"+ppDetColl);
				if ( ppDetColl != null )
					iCollSize = ppDetColl.size();
				//System.out.println("iCollSize--------->"+iCollSize);

				//Tracker 88479..this variable will hold the no of records from Structured Repayment Tab
				int iNoOfStrPayments=0;
				//if(iCollSize > 0)		{
					//structRepayLL = new CILAAmortStructuredRepmtLLFCRM[iCollSize];
					repayLL = new CILAAmortRepaymentLLFCRM[iCollSize] ;


					for (int i=0; i<iCollSize; i++){
						ppDet = (PaymentPlannerBO.PaymentPlannerDetails)ppDetColl.get(i);
						//Amount amount = null;
						//Percent fPcnt = null;
						//Frequency freq = null;
						//AmortCalFreq amortFreq = null;
						//AmortCalFreq amortIntFreq = null;
						AmortCalFreq amortNonEIInstmtFreq  = amortNonEIParams.getInstlmntFreq();
						//structRepayLL[i] = new CILAAmortStructuredRepmtLLFCRM();
						////System.out.println("setting repay ll---------------------------");
						repayLL[i]= new CILAAmortRepaymentLLFCRM();
//						if((null != ppDet.getType())&&(ppDet.getType().equalsIgnoreCase(Constants.PLANNED_PREPAYMENT)))				{
						//repayLL[i] = new CILAAmortRepaymentLLFCRM();
						//amortFreq = repayLL[i].getEiFrequency();
						amortNonEIInstmtFreq = repayLL[i].getInterestFrequency();
						check = "true";
						//if(null != ppDet.getDateField1())
						if(null != ppDet.getDateField1())
						{
							//Date strFlowStDate = ppDet.getDateField1();
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

							//flow start date => origination date in PP or PP paymentplannerBO.getOriginationDate()

						}
						else		repayLL[i].setFlowStartDate(null);
						//System.out.println("repayLL[i].setFlowStartDate--->"+repayLL[i].getFlowStartDate());
						Amount temp = new Amount();

						if(null != ppDet.getAmountField1())
						{
							temp.setAmountValue(ppDet.getAmountField1());
							temp.setCurrencyCode(paymentplannerBO.getCurrency().toString());
							repayLL[i].setFlowAmt(temp);
						}

						//if(null != ppDet.getIntField1())
						if(null != ppDet.getIntField1())
						{
							repayLL[i].setNoOfDemands(ppDet.getIntField1().longValue());
						}
						else	{
							repayLL[i].setNoOfDemands(0);
						}
						//System.out.println("paymentplannerBO.getIntFreqType--->"+paymentplannerBO.getIntFreqType());

						repayLL[i].getEiFrequency().setType(ppDet.getUserField1());

						if(null != ppDet.getUserField4())
						repayLL[i].getEiFrequency().setWeekDay(Long.parseLong(ppDet.getUserField4()));

						if(null != ppDet.getUserField3())
						repayLL[i].getEiFrequency().setWeekNum(ppDet.getUserField3());

						if(null != ppDet.getUserField5())
						repayLL[i].getEiFrequency().setStartDt(Long.parseLong(ppDet.getUserField5()));

						if(null != ppDet.getUserField6())
						repayLL[i].getEiFrequency().setHolStat(ppDet.getUserField6());
						////System.out.println("repayLL[i].getInterestFrequency().getType()--->"+repayLL[i].getInterestFrequency().getType());
						//System.out.println("setting serial num");
						repayLL[i].setSerial_num((i+1)+"");


					//}
					//System.out.println("setting repay ll------------>"+repayLL);
					}
			}
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}

	}
	private void setNonEIParams(SRMBusinessContext bc,PaymentPlannerBO paymentplannerBO) throws SRMBCException{

		try{

			/*Interest Freq*/
			//AmortCalFreq	amortNonEIInstmtFreq  = amortNonEIParams.getInstlmntFreq();
			AmortCalFreq	amortNonEIIntFreq = amortNonEIParams.getIntFreq();
			Long ltrNonEIFieldDay = null;
			String strNonEIFieldDay = "";


			//amortNonEIParams.setNoOfDmds(0);
			amortNonEIParams.setNoOfDmds(paymentplannerBO.getNoOfInstallments());

			if(null != paymentplannerBO.getIntFreqType()){
				amortNonEIIntFreq.setType(paymentplannerBO.getIntFreqType().toString());
			}

			if(null != paymentplannerBO.getIntFreqWeekOfMonth()){
				amortNonEIIntFreq.setWeekNum(paymentplannerBO.getIntFreqWeekOfMonth().toString());
			}else 	{
				amortNonEIIntFreq.setWeekNum("");
			}

			//System.out.println("paymentplannerBO.getIntFreqDayOfWeek--->"+paymentplannerBO.getIntFreqDayOfWeek());

			if(null != paymentplannerBO.getIntFreqDayOfWeek()){

				strNonEIFieldDay = paymentplannerBO.getIntFreqDayOfWeek();
				if(strNonEIFieldDay.trim().length() > 0){
					ltrNonEIFieldDay = Long.parseLong(strNonEIFieldDay);
					amortNonEIIntFreq.setWeekDay(ltrNonEIFieldDay);
				}

			}else {
				amortNonEIIntFreq.setWeekDay(0);
			}

			//System.out.println("paymentplannerBO.getIntFreqStartDate--->"+paymentplannerBO.getIntFreqStartDate());

			if(null != paymentplannerBO.getIntFreqStartDate()){
				amortNonEIIntFreq.setStartDt(paymentplannerBO.getIntFreqStartDate().longValue());
			}else {
				amortNonEIIntFreq.setStartDt(0);
			}

			//System.out.println("paymentplannerBO.getIntFreqHolidayCode--->"+paymentplannerBO.getIntFreqHolidayCode());

			if(null != paymentplannerBO.getIntFreqHolidayCode())
			{
				amortNonEIIntFreq.setHolStat(paymentplannerBO.getIntFreqHolidayCode());
			}
			else {
				amortNonEIIntFreq.setHolStat("");
			}

			/*Installment Freq AND iNT REQ ARE SAME*/
			amortNonEIParams.setInstlmntFreq(amortNonEIIntFreq);
			amortNonEIParams.setIntFreq(amortNonEIIntFreq);

			if(paymentplannerBO.getDateField6()!=null)
			{
				Calendar cal3 = Calendar.getInstance();
				cal3.setTime(paymentplannerBO.getDateField6());
				amortNonEIParams.setInstlmntStartDate(cal3);
				amortNonEIParams.setIntStartDate(cal3);
			}else {
				amortNonEIParams.setInstlmntStartDate(null);
				amortNonEIParams.setIntStartDate(null);
			}
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();

		}

		// TODO Auto-generated method stub

	}
	public void setAmortBasicInfo(SRMBusinessContext bc,PaymentPlannerBO paymentplannerBO)
	throws SRMBCException{
		try{
			String strCIFID = getCIFID(bc);
			amortBasicInfo.setCifId(strCIFID);
			//change for callid 409425 begins
			String prodCur=paymentplannerBO.getCurrency().toString();
            Double strCustPrfInt= getCustPrefInt(bc,strCIFID,prodCur);
            //change for callid 409425 ends
			// Sol Id is equalent "Application" branch in sale back end table
			//System.out.println("strAPPLBRANCH--------->"+strAPPLBRANCH);
			amortBasicInfo.setSolId(strAPPLBRANCH);

		//	amortBasicInfo.
			//amortBasicInfo.getGlSubHeadCodeSolID();
			//amortBasicInfo.setSolId("102");
			//amortBasicInfo.setAcctCrncyCode("INR");
			//amortBasicInfo.setAcctCrncyCode(strACCOUNTCURRENCY);
			amortBasicInfo.setAcctCrncyCode(paymentplannerBO.getCurrency().toString());
			if(paymentplannerBO.getOriginationDate()!=null)
			{
				Calendar cal2 = Calendar.getInstance();
				cal2.setTime(paymentplannerBO.getOriginationDate());
				amortBasicInfo.setAcctOpnDate(cal2);
			}else	amortBasicInfo.setAcctOpnDate(null);
			//amortBasicInfo.setAcctCrncyCode();
			if(paymentplannerBO.getTenorMonths()!=null)
			{
				amortBasicInfo.setLoanTenorMths(paymentplannerBO.getTenorMonths().longValue());
			}else	amortBasicInfo.setLoanTenorMths(0);
			if(paymentplannerBO.getTenorDays()!=null)
			{
				amortBasicInfo.setLoanTenorDays(paymentplannerBO.getTenorDays().longValue());
			}else	amortBasicInfo.setLoanTenorDays(0);
			/*		if(paymentplannerBO.getNoOfInstallments()!=null)
		{
			amortBasicInfo.setNoOfInstalmnts((paymentplannerBO.getNoOfInstallments()).longValue());
		}else	lamodSchdlVar.setNoOfInstalmnts(0);
			 */
			if(paymentplannerBO.getLoanAmount()!=null)
			{
				Double dLoanAmt = paymentplannerBO.getLoanAmount();
				amt.setAmountValue(dLoanAmt.doubleValue());
				amt.setCurrencyCode(paymentplannerBO.getCurrency().toString());
				amortBasicInfo.setLoanAmt(amt);
			}else{
				amt.setAmountValue(0.0);
				amt.setCurrencyCode(null);
				amortBasicInfo.setLoanAmt(amt);

			}
			//Hard coding to N (all Account)
			amortBasicInfo.setTypeOfAcct("N");
			//Hardcoding for Autogenaration of account N
			//amortBasicInfo.setPermAcct("LOS");

			amortBasicInfo.setSchmCode(paymentplannerBO.getProductsKey().toString());
			//amortBasicInfo.setSchmCode("ASHL1");
			//If prodcatid =5 or 6 query product bo
			//ProductBO prBO = Products.findProductBO(strProductID,bc);
			amortBasicInfo.setSchmType("LAA");
			//change for callid 409425 begins
             if(strActPrfIntDr!=null){
			    Percent prct5 = new Percent();
			    prct5.setValue(strActPrfIntDr);

			    amortBasicInfo.setAcctPrefIntDr(prct5);
			   }
			   if(strCustPrfInt!=null){
			   Percent prct7 = new Percent();
			   prct7.setValue(strCustPrfInt);
			   amortBasicInfo.setCustPrefIntDr(prct7);
			   }
			 if(strChnPrfIntDr!=null){

				amortOvarTenorSlabLLFCRM[0] = new CILAAmortOvarTenorSlabLLFCRM();

			 	Percent prct6 = new Percent();
			 	prct6.setValue(strChnPrfIntDr.doubleValue());
				amortOvarTenorSlabLLFCRM[0].setChnlPrefInt(prct6);

		  }
		  if(strNegPrfIntDr!=null){
                Percent prct7 = new Percent();
				prct7.setValue(strNegPrfIntDr.doubleValue());
				amortOvarTenorSlabLLFCRM[0].setNegotiatedRate(prct7);

			 	inputVO.setAmortOvarTenorSlabLAOpenFCRM(amortOvarTenorSlabLLFCRM);
			 	slabFlag=true;

             }

			//change for callid 409425 ends
			if(paymentplannerBO.getInterestCode()!= null){
				amortBasicInfo.setIntTableCode(paymentplannerBO.getInterestCode().toString());
			}
			/* Changes for callid 374707 and recon of call id 367720 to set correct value for discount beings*/
             //callid 409425 begins-reverting the changes of callid 367720
			/* Changes for callid 367720 to set correct value for discount beings*/
					/*Double cDiscount;

				if(paymentplannerBO.getAcPreferentialDr()!=null){
				cDiscount =	(Double)(paymentplannerBO.getAcPreferentialDr());
				Percent prct5 = new Percent();
			    prct5.setValue(cDiscount);
				amortBasicInfo.setAcctPrefIntDr(prct5);
                  }*/

			/* Changes for callid 367720 to set correct value for discount ends */
            //callid 409425 ends-reverting the changes of callid 367720
			if ("B".equals(paymentplannerBO.getPaymentPlannerOn()))
			{
			Percent prct5 = new Percent();
			prct5.setValue(paymentplannerBO.getBankSellingRate().doubleValue());
			amortBasicInfo.setEffIntRate(prct5);
			}


			// Islamic Changes SP starts

			Integer iProdCatID  = null;
			SRMQueryBuilder qbSaleBO = QueryAssist.singleObjectQuery("SaleBO", SaleBO.SALESID);
			QueryAssist.addSimpleCondition(qbSaleBO, "SaleBO", SaleBO.SALESID, IQuery.ComparisonOperation_EQ,""+salesID);
			qbSaleBO.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.PRODCATID));
			SRMQueryResult qrSaleBO = qbSaleBO.runQuery(bc,-1);
			SRMRecordSet rsSaleBO = qrSaleBO.getRecordSet();
			while ( rsSaleBO.hasNext() ) {
				List alSaleBO = (ArrayList)rsSaleBO.getNext();
				iProdCatID = (Integer)alSaleBO.get(0);
			}
			//SRMQueryBuilder qbSubsidy =null;

			Double	dAssetvalueIB =null;
			Double	dResidvalueIB =null;

			//  changes for  dSecurityDepositIB & dCustMarginIB

			Double	dSecurityDepositIB =null;
			Double	dCustMarginIB =null;
			if(iProdCatID.intValue() == 5){






			//if(paymentplannerBO.get)
			ArrayList arrTemp1 = null;
			SRMQueryBuilder qb1 = new SRMQueryBuilder();
			qb1 = QueryAssist.singleObjectQuery("SaleHLOBO",SaleHLOBO.SALESID);
			//qb1 = QueryAssist.singleObjectQuery("SaleHLOBO",SaleHLOBO.RESIDUALVALUE);
			QueryAssist.addSimpleCondition(qb1,"SaleHLOBO",SaleHLOBO.SALESID,IQuery.ComparisonOperation_EQ,paymentplannerBO.getSalesID());
			qb1.addAttribScope(QueryAssist.getTransformFn("SaleHLOBO",SaleHLOBO.IBASSETVALUE));
			qb1.addAttribScope(QueryAssist.getTransformFn("SaleHLOBO",SaleHLOBO.RESIDUALVALUE));
			qb1.addAttribScope(QueryAssist.getTransformFn("SaleHLOBO",SaleHLOBO.SECURITYDEPOSITAMT));
			qb1.addAttribScope(QueryAssist.getTransformFn("SaleHLOBO",SaleHLOBO.CUSTMARGIN));
			SRMQueryResult qr1	= qb1.runQuery(bc,-1);
			SRMRecordSet rs1		= qr1.getRecordSet();
			while(rs1.hasNext()){
				arrTemp1 = (ArrayList)rs1.getNext();
			}
			dAssetvalueIB = (Double)arrTemp1.get(0);
			dResidvalueIB = (Double)arrTemp1.get(1);
			dSecurityDepositIB = (Double)arrTemp1.get(2);
			dCustMarginIB = (Double)arrTemp1.get(3);
			}if(iProdCatID.intValue() == 6){

				ArrayList arrTemp1 = null;
				SRMQueryBuilder qb1 = new SRMQueryBuilder();
				qb1 = QueryAssist.singleObjectQuery("SaleLOBO",SaleLOBO.SALESID);

				//qb1 = QueryAssist.singleObjectQuery("SaleLOBO",SaleLOBO.RESIDUALVALUE);
				QueryAssist.addSimpleCondition(qb1,"SaleLOBO",SaleLOBO.SALESID,IQuery.ComparisonOperation_EQ,paymentplannerBO.getSalesID());
				qb1.addAttribScope(QueryAssist.getTransformFn("SaleLOBO",SaleLOBO.IBASSETVALUE));
				qb1.addAttribScope(QueryAssist.getTransformFn("SaleLOBO",SaleLOBO.RESIDUALVALUE));
				qb1.addAttribScope(QueryAssist.getTransformFn("SaleLOBO",SaleLOBO.SECURITYDEPOSITAMT));
				qb1.addAttribScope(QueryAssist.getTransformFn("SaleLOBO",SaleLOBO.CUSTMARGIN));

			SRMQueryResult qr1	= qb1.runQuery(bc,-1);
			SRMRecordSet rs1		= qr1.getRecordSet();
			while(rs1.hasNext()){
				arrTemp1 = (ArrayList)rs1.getNext();
			}
			dAssetvalueIB = (Double)arrTemp1.get(0);
			dResidvalueIB = (Double)arrTemp1.get(1);
				dSecurityDepositIB = (Double)arrTemp1.get(2);
				dCustMarginIB = (Double)arrTemp1.get(3);




			}
			//TODO: Add the dAssetvalueIB into the corresponding structure

			IslamicProductDataBO objIslamicProductDataBO = new IslamicProductDataBO();
            SRMQueryBuilder qb = QueryAssist.singleObjectQuery("IslamicProductDataBO",
                    IslamicProductDataBO.SALESID,"strQueryIslamicBO"
                  );
				QueryAssist.addSimpleCondition(qb,
				    "IslamicProductDataBO",
				    IslamicProductDataBO.SALESID,
				    IQuery.ComparisonOperation_EQ,
				    ""+salesID
				   );

				SRMQueryResult qr = qb.runQuery(bc, true, -1);
				SRMRecordSet rs = qr.getRecordSet();
				if(rs.hasNext()) {
					objIslamicProductDataBO= (IslamicProductDataBO)rs.getNext().get(0);


				}

				//objIslamicProductDataBO.getPurchasePricePerUnit();
				//TODO: Add this to the corresponding structure

			//TODO: purchasePricePU had to be added speak to mohd
				Amount aPurchase = new Amount();
				aPurchase.setCurrencyCode(paymentplannerBO.getCurrency().toString());

		if (null != objIslamicProductDataBO.getPurchasePricePerUnit()){
		aPurchase.setAmountValue(objIslamicProductDataBO.getPurchasePricePerUnit());
		amortBasicInfo.setPurchasePricePU(aPurchase);

		}

		if (null != dResidvalueIB){
			Amount PResidvalueIB = new Amount();
			PResidvalueIB.setAmountValue(dResidvalueIB);
			PResidvalueIB.setCurrencyCode(paymentplannerBO.getCurrency().toString());
			amortBasicInfo.setResidualValue(PResidvalueIB);

			}
		if (null != dAssetvalueIB){
			Amount PAssetvalue = new Amount();
			PAssetvalue.setCurrencyCode(paymentplannerBO.getCurrency().toString());
			PAssetvalue.setAmountValue(dAssetvalueIB);
			amortBasicInfo.setAssetValue(PAssetvalue);

			}

		// changes for  dSecurityDepositIB & dCustMarginIB
		if (null != dSecurityDepositIB){
			Amount PSecurityDeposit = new Amount();
			PSecurityDeposit.setCurrencyCode(paymentplannerBO.getCurrency().toString());
			PSecurityDeposit.setAmountValue(dSecurityDepositIB);
			amortBasicInfo.setSecurityDepositAmt(PSecurityDeposit);
			}

		if (null != dCustMarginIB){
			Amount PCustMargin = new Amount();
			PCustMargin.setCurrencyCode(paymentplannerBO.getCurrency().toString());
			PCustMargin.setAmountValue(dCustMarginIB);
			amortBasicInfo.setMarginMoneyAmt(PCustMargin);
			}
			// Islamic Changes SP Ends

		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void setAmortEIParams(PaymentPlannerBO paymentplannerBO)
	throws SRMBCException{

		//kunal changes holiday period islamic

//		if(paymentplannerBO.getMoratoriumPeriod()!=null)
//		{
//			//in los we are getting only months
//			amortEIParams.setHldyPerdMths(paymentplannerBO.getMoratoriumPeriod().longValue());
//			amortEIParams.setHldyPerdDays(0);
//		}
//		else
//		{
//			amortEIParams.setHldyPerdMths(0);
//			amortEIParams.setHldyPerdDays(0);
//
//		}

		//kunal changes holiday period islamic
		if(null != paymentplannerBO.getHPNormalHolidayPeriod())
		amortEIParams.setHldyPerdMths(paymentplannerBO.getHPNormalHolidayPeriod());

		if(null != paymentplannerBO.getProfitDuringHolidayPeriod())
		{
			amortEIParams.setHldyPerdIntFlg(paymentplannerBO.getProfitDuringHolidayPeriod());
			if(null != paymentplannerBO.getHPNumberOfInstallments() && "I".equalsIgnoreCase(paymentplannerBO.getProfitDuringHolidayPeriod()))
				amortEIParams.setHldyPerdIntInstlMths(paymentplannerBO.getHPNumberOfInstallments());
		}



//		if(null != paymentplannerBO.getMoratoriumCapitalize() && paymentplannerBO.getMoratoriumCapitalize().equals("Y"))
//		{
//			amortEIParams.setHldyPerdIntFlg("C");
//		}else{
//			amortEIParams.setHldyPerdIntFlg(paymentplannerBO.getMoratoriumCapitalize());
//		}


		if(null != paymentplannerBO.getPFDHPFreqType())
		{
			AmortCalFreq amortHFreq = amortEIParams.getHldyFrequency();
			amortHFreq.setType(paymentplannerBO.getPFDHPFreqType());

			if(null != paymentplannerBO.getPFDHPFreqHolidayCode())
				amortHFreq.setHolStat(paymentplannerBO.getPFDHPFreqHolidayCode());

			if(null != paymentplannerBO.getPFDHPFreqStartDate())
				amortHFreq.setStartDt(paymentplannerBO.getPFDHPFreqStartDate());

			if(null != paymentplannerBO.getPFDHPFreqDayOfWeek())
			{
			String strHFreqDayOfWeek = paymentplannerBO.getPFDHPFreqDayOfWeek();
			Long LngEIFreqDayOfWeek=Long.valueOf(strHFreqDayOfWeek);
			amortHFreq.setWeekDay(LngEIFreqDayOfWeek);
			}

			if(null != paymentplannerBO.getPFDHPFreqWeekOfMonth())
				amortHFreq.setWeekNum(paymentplannerBO.getPFDHPFreqWeekOfMonth());

		amortEIParams.setHldyFrequency(amortHFreq);
		}

		//amortEIParams.setEiType(paymentplannerBO.getEIType());
		amortEIParams.setEiType(strEIMODE);
		// EI Type is equalent to  EI Method from Sale Back End Table.
		amortEIParams.setCollectUpFrontFlg(strUPFRONTINSTAMOUNT);
		if(strNUMBEROFUPFRONTINSTALLMENTS!= null)
			amortEIParams.setNumOfAdvInst(strNUMBEROFUPFRONTINSTALLMENTS);
		if(strDEFERMENTSTARTMONTH!= null)
			amortEIParams.setDefStartMonth(strDEFERMENTSTARTMONTH);
		if(strMAXDEFERMENTMONTH!= null)
			amortEIParams.setNumOfMnthsDefer(strMAXDEFERMENTMONTH);
		amortEIParams.setCapEMIFlg(strCAPOVEREMI);


//		populate salebackend as default population not hapening in payment planner BO

		//amortEIParams.setEiFormulaFlg(paymentplannerBO.getEIFormula());
		amortEIParams.setEiFormulaFlg(strEIFormula);
		amortEIParams.setIntRestFreq(paymentplannerBO.getRestFreq());
		amortEIParams.setIntRestBasis(paymentplannerBO.getRestBasis());

		if(null != paymentplannerBO.getAllowGradPayment()){
			amortEIParams.setGradPmtAlwd(paymentplannerBO.getAllowGradPayment().toString());
		}
		amortEIParams.setStepInd(paymentplannerBO.getStepIndicator());

		if(null != paymentplannerBO.getNoOfSteps())
		{
			amortEIParams.setNoOfSteps(paymentplannerBO.getNoOfSteps());
		}else 	amortEIParams.setNoOfSteps(0);

		Percent prct6 = new Percent();
		if(null != paymentplannerBO.getStepPercentage())
		{
			prct6.setValue(paymentplannerBO.getStepPercentage().doubleValue());
			amortEIParams.setStepPcnt(prct6);
		}else{
			prct6.setValue(0.0);
			amortEIParams.setStepPcnt(prct6);
		}



	}
	public void setRepaypaymentLLDetails(PaymentPlannerBO paymentplannerBO)
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

		//Tracker 88479..this variable will hold the no of records from Structured Repayment Tab
		int iNoOfStrPayments=0;
		//if(iCollSize > 0)		{
			//structRepayLL = new CILAAmortStructuredRepmtLLFCRM[iCollSize];
			repayLL = new CILAAmortRepaymentLLFCRM[1] ;

int i=0;
		//	for (int i=0; i<iCollSize; i++){
			//	ppDet = (PaymentPlannerBO.PaymentPlannerDetails)ppDetColl.get(i);
				Amount amount = null;
				Percent fPcnt = null;
				Frequency freq = null;
				AmortCalFreq amortFreq = null;
				AmortCalFreq amortIntFreq = null;
				//structRepayLL[i] = new CILAAmortStructuredRepmtLLFCRM();
				repayLL[i]= new CILAAmortRepaymentLLFCRM();
//				if((null != ppDet.getType())&&(ppDet.getType().equalsIgnoreCase(Constants.PLANNED_PREPAYMENT)))				{
				repayLL[i] = new CILAAmortRepaymentLLFCRM();
				amortFreq = repayLL[i].getEiFrequency();
				amortIntFreq = repayLL[i].getInterestFrequency();
				check = "true";
				//if(null != ppDet.getDateField1())
				try{
					if(null == paymentplannerBO.getInstallmentStartDate())
						{
						paymentplannerBO.setInstallmentStartDate(paymentplannerBO.getOriginationDate());
						}
					}catch(Exception e)	{}
				if(null != paymentplannerBO.getInstallmentStartDate())
				{
					//Date strFlowStDate = ppDet.getDateField1();
					Date strFlowStDate = paymentplannerBO.getInstallmentStartDate();
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

					//flow start date => origination date in PP or PP paymentplannerBO.getOriginationDate()

				}
				else		repayLL[i].setFlowStartDate(null);

				//if(null != paymentplannerBO.getInstallmentStartDate())
					if(null != paymentplannerBO.getInstallmentStartDate())
				{
					Calendar cal1 = Calendar.getInstance();

					//cal1.setTime(paymentplannerBO.getInstallmentStartDate());
					cal1.setTime(paymentplannerBO.getInstallmentStartDate());
					repayLL[i].setNextDemandDate(cal1);
					repayLL[i].setNextIntDemandDate(cal1);
					//setNextDemandDate,NextIntDemandDate => origination date in PP or PP paymentplannerBO.getOriginationDate()
				}
				else{
					repayLL[i].setNextDemandDate(null);
					repayLL[i].setNextIntDemandDate(null);
				}
				//}
				//if(null != ppDet.getIntField1())
					if(null != paymentplannerBO.getNoOfInstallments())
				{
					repayLL[i].setNoOfDemands(paymentplannerBO.getNoOfInstallments().longValue());
				}
				else	repayLL[i].setNoOfDemands(0);
				//paymentplannerBO.getNoOfInstallments()
				//amount = repayLL[i].getFlowAmt();
				/*if(null != ppDet.getAmountField1())
				{
					amount.setAmountValue(ppDet.getAmountField1().doubleValue());
					amount.setCurrencyCode(paymentplannerBO.getCurrency().toString());
					repayLL[i].setFlowAmt(amount);

				}
				else{
					amount.setAmountValue(0.0);
					amount.setCurrencyCode(null);
					repayLL[i].setFlowAmt(amount);
				}*/
				/*//System.out.println("ppDet.getStrField2--->"+ppDet.getStrField2());
				if(null != ppDet.getStrField2())
				{
					amortFreq.setType(ppDet.getStrField2().toString());
				}
				//System.out.println("ppDet.getStrField3--->"+ppDet.getStrField3());
				if(null != ppDet.getStrField3())
				{
					amortFreq.setWeekNum(ppDet.getStrField3().toString());
				}
				else 	amortFreq.setWeekNum("");
				//System.out.println("ppDet.getStrField4--->"+ppDet.getStrField4());
				if(null != ppDet.getStrField4())
				{

					strFieldDay = ppDet.getStrField4();
					ltrFieldDay = Long.parseLong(strFieldDay);
					//java.util.Date dat = new Date(ppDet.getStrField4());
					amortFreq.setWeekDay(ltrFieldDay);

				}
				else 	amortFreq.setWeekDay(0);
				//System.out.println("ppDet.getIntField2--->"+ppDet.getIntField2());
				if(null != ppDet.getIntField2())
				{
					amortFreq.setStartDt(ppDet.getIntField2().longValue());
				}
				else 	amortFreq.setStartDt(0);
				//System.out.println("ppDet.getStrField1--->"+ppDet.getStrField1());
				if(null != ppDet.getStrField1())
				{
					amortFreq.setHolStat(ppDet.getStrField1());
				}
				else 	amortFreq.setHolStat("");
				*/
				//System.out.println("paymentplannerBO.getIntFreqType--->"+paymentplannerBO.getIntFreqType());
				if(null != paymentplannerBO.getIntFreqType())
				{
					amortIntFreq.setType(paymentplannerBO.getIntFreqType().toString());
				}
				if(null != paymentplannerBO.getIntFreqWeekOfMonth())
				{
					amortIntFreq.setWeekNum(paymentplannerBO.getIntFreqWeekOfMonth().toString());
				}
				else 	amortIntFreq.setWeekNum("");
				//System.out.println("paymentplannerBO.getIntFreqDayOfWeek--->"+paymentplannerBO.getIntFreqDayOfWeek());
				if(null != paymentplannerBO.getIntFreqDayOfWeek())
				{
					/***Tracker 178800 starts***/
					strFieldDay = paymentplannerBO.getIntFreqDayOfWeek();
					ltrFieldDay = Long.parseLong(strFieldDay);
					//java.util.Date dat = new Date(ppDet.getStrField4());
					amortIntFreq.setWeekDay(ltrFieldDay);
					/***Tracker 178800 ends***/
				}
				else 	amortIntFreq.setWeekDay(0);
				//System.out.println("paymentplannerBO.getIntFreqStartDate--->"+paymentplannerBO.getIntFreqStartDate());
				if(null != paymentplannerBO.getIntFreqStartDate())
				{
					amortIntFreq.setStartDt(paymentplannerBO.getIntFreqStartDate().longValue());
				}
				else 	amortIntFreq.setStartDt(0);
				if(null != paymentplannerBO.getIntFreqHolidayCode())
				{
					amortIntFreq.setHolStat(paymentplannerBO.getIntFreqHolidayCode());
				}
				else 	amortIntFreq.setHolStat("");


				if(null != paymentplannerBO.getEIFrequency())
				amortFreq.setType(paymentplannerBO.getEIFrequency());
				if(null != paymentplannerBO.getEIFreqHolidayCode())
				amortFreq.setHolStat(paymentplannerBO.getEIFreqHolidayCode());
				if(null != paymentplannerBO.getEIFreqStartDate())
				amortFreq.setStartDt(paymentplannerBO.getEIFreqStartDate());
				if(null != paymentplannerBO.getEIFreqDayOfWeek())
				{
				String EIFreqDayOfWeek = paymentplannerBO.getEIFreqDayOfWeek();
				Long LngEIFreqDayOfWeek=Long.valueOf(EIFreqDayOfWeek);
				amortFreq.setWeekDay(LngEIFreqDayOfWeek);
				}
				if(null != paymentplannerBO.getEIFreqWeekOfMonth())
				amortFreq.setWeekNum(paymentplannerBO.getEIFreqWeekOfMonth());
				repayLL[i].setEiFrequency(amortFreq);

				//repayLL[i].getEiFrequency().setType(paymentplannerBO.getEIFrequency());
				//repayLL[i].getEiFrequency().setStartDt(30);
				//repayLL[i].getEiFrequency().setHolStat("N");
				//as of now it not required to be passed
				//amortFreq.setType(paymentplannerBO.getIntFreqType());
				//repayLL[i].setInstlmntInd (null);
				//as of now it not required to be passed

				//repayLL[i].setInstlmntPcnt (0);


				repayLL[i].setInterestFrequency (amortIntFreq);
				//repayLL[i].getInterestFrequency().setType(paymentplannerBO.getIntFreqType());
				//repayLL[i].getInterestFrequency().setStartDt(30);
				//repayLL[i].getInterestFrequency().setHolStat("N");
				repayLL[i].setSerial_num((i+1)+"");


			//}
		//}
	}
	public void setAdvancePaymentDetails(PaymentPlannerBO paymentplannerBO)
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


		//Tracker 88479..this variable will hold the no of records from Structured Repayment Tab
		int iNoOfStrPayments=0;
		if(iCollSize > 0)
		{
			structRepayLL = new CILAAmortStructuredRepmtLLFCRM[iCollSize];
			repayLL = new CILAAmortRepaymentLLFCRM[iCollSize] ;


			for (int i=0; i<iCollSize; i++)
			{
				ppDet = (PaymentPlannerBO.PaymentPlannerDetails)ppDetColl.get(i);
				Amount amount = null;
				Percent fPcnt = null;
				Frequency freq = null;
				AmortCalFreq amortFreq = null;
				AmortCalFreq amortIntFreq = null;
				structRepayLL[i] = new CILAAmortStructuredRepmtLLFCRM();
				repayLL[i]= new CILAAmortRepaymentLLFCRM();
				amortFreq = repayLL[i].getEiFrequency();
				if((null != ppDet.getType())&&(ppDet.getType().equalsIgnoreCase(Constants.STRUCTURED_REPAYMENT)))
				{
					/*if(Flag == "Y")
				{
					lamodAdvance.setInstlmntInd("Y");
				}else{
					//advParams.setInstlmntInd("Y");
				}*/
					/*
									  instlmntAmt
					long noOfInstlmnts
					long notionalTenor
					serial_num
					principalAmt
					principalPcnt


					 */
					if(null != ppDet.getIntField1())
					{
						structRepayLL[i].setNoOfInstlmnts(ppDet.getIntField1().longValue());
					}
					else	structRepayLL[i].setNoOfInstlmnts(0);
					amount = structRepayLL[i].getPrincipalAmt();
					fPcnt = structRepayLL[i].getPrincipalPcnt();
					if(null != ppDet.getAmountField1())
					{
						//TypeOfInstallment or instType Mohmad will check in core
						//lamodSchdlVar.setTypeOfInstComb("P");
						fPcnt.setValue(ppDet.getAmountField1().doubleValue());
					}
					else{
						fPcnt.setValue(0.0);
					}
					structRepayLL[i].setPrincipalPcnt(fPcnt);
					if(!(ppDet.getInstallmentAmount().equals(new Double(0.0))))
					{
						//TypeOfInstallment or instType Mohmad will check in core
						//lamodSchdlVar.setTypeOfInstComb("A");
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
					structRepayLL[i].setPrincipalAmt(amount);
				}else if((null != ppDet.getType())&&(ppDet.getType().equalsIgnoreCase(Constants.NOTIONAL_REPAYMENT)))
				{
					//TypeOfInstallment or instType Mohmad will check in core
					//lamodSchdlVar.setTypeOfInstComb("N");
					//structRepayLL[i].setTypeOfStructPmnt(amount);...need to added
					amount = structRepayLL[i].getInstlmntAmt();
					if(null != ppDet.getInstallmentAmount())
					{
						amount.setAmountValue(ppDet.getInstallmentAmount().doubleValue());
						amount.setCurrencyCode(paymentplannerBO.getCurrency().toString());
					}else{
						amount.setAmountValue(0.0);
						amount.setCurrencyCode(null);
					}
					structRepayLL[i].setInstlmntAmt(amount);
					if(null != ppDet.getIntField2())
					{
						structRepayLL[i].setNotionalTenor(ppDet.getIntField2().longValue());
					}else structRepayLL[i].setNotionalTenor(0);
					if(null != ppDet.getIntField1())
					{
						structRepayLL[i].setNoOfInstlmnts(ppDet.getIntField1().longValue());
					}else  structRepayLL[i].setNoOfInstlmnts(0);


				}

				else if((null != ppDet.getType())&&(ppDet.getType().equalsIgnoreCase(Constants.PLANNED_PREPAYMENT)))
				{
					repayLL[i] = new CILAAmortRepaymentLLFCRM();
					amortFreq = repayLL[i].getEiFrequency();
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
					if(null != paymentplannerBO.getInstallmentStartDate())
					{
						Calendar cal1 = Calendar.getInstance();

						cal1.setTime(paymentplannerBO.getInstallmentStartDate());
						repayLL[i].setNextDemandDate(cal1);
						repayLL[i].setNextIntDemandDate(cal1);
					}
					else
						repayLL[i].setNextDemandDate(null);
					repayLL[i].setNextIntDemandDate(null);
				}

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
					amortFreq.setType(ppDet.getStrField2().toString());

				}
				if(null != ppDet.getStrField3())
				{
					amortFreq.setWeekNum(ppDet.getStrField3().toString());
				}
				else 	amortFreq.setWeekNum("");

				if(null != ppDet.getStrField4())
				{
					/***Tracker 178800 starts***/
					strFieldDay = ppDet.getStrField4();
					ltrFieldDay = Long.parseLong(strFieldDay);
					//java.util.Date dat = new Date(ppDet.getStrField4());
					amortFreq.setWeekDay(ltrFieldDay);
					/***Tracker 178800 ends***/
				}
				else 	amortFreq.setWeekDay(0);

				if(null != ppDet.getIntField2())
				{
					Long lintField = Long.parseLong(String.valueOf(ppDet.getIntField2()));
                      amortFreq.setStartDt(lintField);
				}
				else 	amortFreq.setStartDt(0);

				if(null != ppDet.getStrField1())
				{
					amortFreq.setHolStat(ppDet.getStrField1());
				}
				else 	amortFreq.setHolStat("");
				/**/
				amortIntFreq = repayLL[i].getInterestFrequency();
				if(null != paymentplannerBO.getIntFreqType())
				{
					amortIntFreq.setType(paymentplannerBO.getIntFreqType().toString());
				}
				if(null != paymentplannerBO.getIntFreqWeekOfMonth())
				{
					amortIntFreq.setWeekNum(paymentplannerBO.getIntFreqWeekOfMonth().toString());
				}
				else 	amortIntFreq.setWeekNum("");

				if(null != paymentplannerBO.getIntFreqDayOfWeek())
				{
					/***Tracker 178800 starts***/
					strFieldDay = paymentplannerBO.getIntFreqDayOfWeek();
					ltrFieldDay = Long.parseLong(strFieldDay);
					//java.util.Date dat = new Date(ppDet.getStrField4());
					amortIntFreq.setWeekDay(ltrFieldDay);
					/***Tracker 178800 ends***/
				}
				else 	amortIntFreq.setWeekDay(0);

				if(null != paymentplannerBO.getIntFreqStartDate())
				{
					amortIntFreq.setStartDt(paymentplannerBO.getIntFreqStartDate().longValue());
				}
				else 	amortIntFreq.setStartDt(0);

				if(null != paymentplannerBO.getIntFreqHolidayCode())
				{
					amortIntFreq.setHolStat(paymentplannerBO.getIntFreqHolidayCode());
				}
				else 	amortIntFreq.setHolStat("");
				/**/

				//repayLL[i].setEiFrequency(amortFreq);
				//as of now it not required to be passed
				//repayLL[i].setInstlmntInd (null);
				//as of now it not required to be passed

				//repayLL[i].setInstlmntPcnt (0);


				repayLL[i].setInterestFrequency (amortIntFreq);
				//change for 356298 beings
							if(null != paymentplannerBO.getOriginationDate())
											{
												//Date strFlowStDate = ppDet.getDateField1();
												Date strFlowStDate = paymentplannerBO.getOriginationDate();
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

												//flow start date => origination date in PP or PP paymentplannerBO.getOriginationDate()

											}
				else		repayLL[i].setFlowStartDate(null);

								repayLL[i].getEiFrequency().setType(paymentplannerBO.getEIFrequency());
								repayLL[i].getEiFrequency().setStartDt(30);
								repayLL[i].getEiFrequency().setHolStat("N");
								//as of now it not required to be passed
								//amortFreq.setType(paymentplannerBO.getIntFreqType());
								//repayLL[i].setInstlmntInd (null);
								//as of now it not required to be passed

								//repayLL[i].setInstlmntPcnt (0);


								//repayLL[i].setInterestFrequency (amortIntFreq);
								repayLL[i].getInterestFrequency().setType(paymentplannerBO.getEIFrequency());
								repayLL[i].getInterestFrequency().setStartDt(30);
				repayLL[i].getInterestFrequency().setHolStat("N");
				MultiRecKey key = new MultiRecKey();
				key.setSerial_num(i+1+"");
				//repayLL[i].setKey(key);

				repayLL[i].setSerial_num((i+1)+"");


			}
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
	public void setFrequencyChargeDetails(SRMBusinessContext bc)throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, SRMTypeValidatorException, CIFatalException{
		/*Adding Frequency based charge*/
//		need to cross check whether any other type is supported in LOS
		String strAssessDmdFlg="C";
		String strApplyFlag="Y";
		SRMQueryResult qrAssesmentFee = null;
		ArrayList arrAssesmentFee = new ArrayList();
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_CHARGETYPE));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_CHARGEEVENTID));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_CRNCYCODE));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_DEDUCTIBLEFLG));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_APPLYFLG));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_ASSESSDEMANDFLG));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_AMORTIZEFLG));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_AMORTIZETENOR));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_MAXNUMBERASSESS));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_NEXTASSESSDATE));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_ASSESSFREQTYPE));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_ASSESSFREQSTARTDATE));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_ASSESSFREQHOLCODE));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_ASSESSFREQWEEKDAY));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_ASSESSFREQWEEKNUM));
		arrAssesmentFee.add(QueryAssist.getTransformFn(true,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_MULTIPLEASSESSFLG));

		SRMQueryBuilder qbAssesmentFee = new SRMQueryBuilder () ;
		QueryAssist.addJoin(qbAssesmentFee, "SaleBackEndBO", SaleBackEndBO.SALESID, "SaleBackEndBO", SaleBackEndBO.SALESID, IQuery.JoinType_Equi);
		QueryAssist.addSimpleCondition(qbAssesmentFee, "SaleBackEndBO", SaleBackEndBO.SALESID, IQuery.ComparisonOperation_EQ, ""+salesID);

		QueryAssist.addSimpleCondition(qbAssesmentFee,"SaleBackEndBO",SaleBackEndBO.SALEFEEDETAILS_APPLYFLG,IQuery.ComparisonOperation_EQ, ""+strApplyFlag);


		SRMCompositeExpr ce1 = new SRMCompositeExpr();
		SRMCompositeExpr ce2 = new SRMCompositeExpr();


		qbAssesmentFee.buildCompositeCondition(IQuery.LogicalOperation_OR,
				new SRMQueryExpr(
						new SRMAttributeInfo(Class.forName("com.infy.cis.srmbo.SaleBackEndBO"),
								SaleBackEndBO.SALEFEEDETAILS_ASSESSDEMANDFLG)),
								IQuery.ComparisonOperation_NOTEQ,new SRMQueryExpr(strAssessDmdFlg),ce1);

		qbAssesmentFee.buildCompositeCondition(IQuery.LogicalOperation_OR,
				new SRMQueryExpr(
						new SRMAttributeInfo(Class.forName("com.infy.cis.srmbo.SaleBackEndBO"),
								SaleBackEndBO.SALEFEEDETAILS_ASSESSDEMANDFLG)),
								IQuery.ComparisonOperation_ISNULL,new SRMQueryExpr(""),	ce2);


		qbAssesmentFee.addCompositeCondition(IQuery.LogicalOperation_AND,new SRMQueryExpr(ce1),
				IQuery.LogicalOperation_OR,new SRMQueryExpr(ce2));

		int assesmentFeeNoOfAttrs = arrAssesmentFee.size();
		for (int i=0; i<assesmentFeeNoOfAttrs; i++) {
			qbAssesmentFee.addAttribScope((TransFormFn) arrAssesmentFee.get(i));
		}
		qrAssesmentFee = qbAssesmentFee.runQuery(bc,-1);
		SRMRecordSet assesmentFeeRecordSet = qrAssesmentFee.getRecordSet();

		int iFreqChrg = assesmentFeeRecordSet.size();
		freqChrgLL = new CILAAmortChargeFreqLLFCRM[iFreqChrg];
		iFreqChrg = 0;

		while ( assesmentFeeRecordSet.hasNext() ) {

			List alFreqChrg = (ArrayList)assesmentFeeRecordSet.getNext();

			String strChargeType			=(String)alFreqChrg.get(0);
			String strChargeEventid			=(String)alFreqChrg.get(1);
			String strCrncyCode				=(String)alFreqChrg.get(2);
			String strDeductibleFlg			=(String)alFreqChrg.get(3);
			String strApplyFlg				=(String)alFreqChrg.get(4);
			String strAssessdemandFlg		=(String)alFreqChrg.get(5);
			String strAmortizeFlg			=(String)alFreqChrg.get(6);

			Integer lAmortizeTenor			=(Integer)alFreqChrg.get(7);

			Integer lMaxNumberAssess		=(Integer)alFreqChrg.get(8);

			Date dtNextAssessDate			=(Date)alFreqChrg.get(9);
			String strAssessFreqType		=(String)alFreqChrg.get(10);

			Integer lAssessFreqStartDate	=(Integer)alFreqChrg.get(11);

			String strAssessFreqHolcode		=(String)alFreqChrg.get(12);

			//Start - Virochan Dev Tracker ID : 182560. ClassCastException while opening and Account.Wrongly type casted from String to Long.
			//Long lAssessFreqWeekDay			=(Long)alFreqChrg.get(13);
			Long lAssessFreqWeekDay			=(Long.getLong((String)alFreqChrg.get(13)));
			//End - Virochan Dev

			String strAssessFreqWeekNum		=(String)alFreqChrg.get(14);
			String strMultipleAssessFlg		=(String)alFreqChrg.get(15);

			freqChrgLL[iFreqChrg] = new CILAAmortChargeFreqLLFCRM();

			if ( null != strChargeType ) {
				freqChrgLL[iFreqChrg].setEventID(strChargeType);
			}

			if ( null != strChargeEventid ) {
				freqChrgLL[iFreqChrg].setPttmEventId(strChargeEventid);
			}

			if ( null != strCrncyCode ) {
				freqChrgLL[iFreqChrg].setCrncy(strCrncyCode);
			}
			if ( null != strDeductibleFlg ) {
				freqChrgLL[iFreqChrg].setDeductibleFlg(strDeductibleFlg);
			}
			/*
			if ( null != strApplyFlg ) {
				freqChrgLL[iFreqChrg].setDelFlg("N");
			}*/
			if ( null != strAssessdemandFlg ) {
				freqChrgLL[iFreqChrg].setAssessDmdFlg(strAssessdemandFlg);
			}
			if ( null != lAmortizeTenor ) {
				freqChrgLL[iFreqChrg].setFeeTenorMnths(lAmortizeTenor);
			}
			if ( null != lMaxNumberAssess ) {
				freqChrgLL[iFreqChrg].setMaxNoOfAssessmnts(lMaxNumberAssess);
			}
			if ( null != dtNextAssessDate ) {

				Calendar cal1 = Calendar.getInstance();
				cal1.setTime(dtNextAssessDate);
				freqChrgLL[iFreqChrg].setNextAssessDate(cal1);
			}
			if ( null != strAssessFreqType ) {
				freqChrgLL[iFreqChrg].getAssessFreq().setType(strAssessFreqType);
			}
			if ( null != lAssessFreqStartDate ) {
				freqChrgLL[iFreqChrg].getAssessFreq().setStartDt(lAssessFreqStartDate);
			}
			if ( null != strAssessFreqHolcode ) {
				freqChrgLL[iFreqChrg].getAssessFreq().setHolStat(strAssessFreqHolcode);
			}
			if ( null != lAssessFreqWeekDay ) {
				freqChrgLL[iFreqChrg].getAssessFreq().setWeekDay(lAssessFreqWeekDay);
			}
			if ( null != strAssessFreqWeekNum ) {
				freqChrgLL[iFreqChrg].getAssessFreq().setWeekNum(strAssessFreqWeekNum);
			}

			freqChrgLL[iFreqChrg].setSerial_num(iFreqChrg+1+"");
			iFreqChrg++;
		}
		//acctChargeFreq.setOchargeFreqLLFCRM(freqChrgLL);
		freqChrgDtl.setOchargeFreqLLFCRM(freqChrgLL);

		/*not required
		if(iFreqChrg != 0){
			freqChrgDtl.setIsDetailsEntered(1);
		}
		 */
		inputVO.setAmortChargeFreqLAFCRM(freqChrgDtl);

		/*Adding Frequency based charge - Ends*/
	}
	public void setTenorSlabDetails(SRMBusinessContext bc,PaymentPlannerBO paymentplannerBO)throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, SRMTypeValidatorException, CIFatalException{
		//if(paymentplannerBO.getInterestCode()== null){
		if(paymentplannerBO.getInterestCode()==null || (paymentplannerBO.getInterestCode()!=null && paymentplannerBO.getInterestCode().trim().isEmpty())){

			//Setting interest Slab Details to linttmAcctMsg
			SRMQueryBuilder qbBackEnd = QueryAssist.singleObjectQuery("SaleBackEndBO", SaleBackEndBO.BACKENDID);
			QueryAssist.addSimpleCondition(qbBackEnd, "SaleBackEndBO", SaleBackEndBO.SALESID, IQuery.ComparisonOperation_EQ,""+salesID);
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_ACCTPREFINTPERCNT));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_CHANNELPREFINTPERCNT));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_CUSTPREFINTPERCNT));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_ENDDATE));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_INTERESTTABLECODE));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_NEGINTPERCNT));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_PEGREVIEWDATE));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_REVIEWONSLABSTARTDATE));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_STARTDATE));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_VERSIONNO));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_PEGFREQINDAYS));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_PEGFREQINMONTHS));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_MAXINTPERCNT));
			qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.SALEINTSLABDETAILS_MININTPERCNT));

			//qbBackEnd.addAttribScope(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.INTERESTTYPE));
			SRMQueryResult qrBackEnd = qbBackEnd.runQuery(bc,-1);
			SRMRecordSet rsBackEnd = qrBackEnd.getRecordSet();

			int iIntSlabCnt = rsBackEnd.size();
			amortOvarTenorSlabLLFCRM = new CILAAmortOvarTenorSlabLLFCRM[iIntSlabCnt];
			iIntSlabCnt = 0;
			while ( rsBackEnd.hasNext() ) {
				List alIntSlab = (ArrayList)rsBackEnd.getNext();
				Double dAcctPrefInt = (Double)alIntSlab.get(0);
				Double dChnlPrefInt = (Double)alIntSlab.get(1);
				Double dCustPrefInt = (Double)alIntSlab.get(2);
				Date dtEndDate 		= (Date)alIntSlab.get(3);
				String strIntTblCde = (String)alIntSlab.get(4);
				Double dNegIntPcnt  = (Double)alIntSlab.get(5);
				Date dtPegRevDate   = (Date)alIntSlab.get(6);
				String sRevOnSlbStDt= (String)alIntSlab.get(7);
				Date dtStartDate 	= (Date)alIntSlab.get(8);
				String strVersionNo = (String)alIntSlab.get(9);
				Integer iSlabPegFreqDays= (Integer)alIntSlab.get(10);
				Integer iSlabPegFreqMon = (Integer)alIntSlab.get(11);
				Double dMaxPercent 	= (Double)alIntSlab.get(12);
				Double dMinPercent 	= (Double)alIntSlab.get(13);


				amortOvarTenorSlabLLFCRM[iIntSlabCnt] = new CILAAmortOvarTenorSlabLLFCRM();
				Percent pcnt = null;
				if ( null != dtEndDate ) {
					Calendar cal = Calendar.getInstance();
					cal.setTime(dtEndDate);
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setEndDate(cal);
				}

				if ( null != dtStartDate ) {
					Calendar cal = Calendar.getInstance();
					cal.setTime(dtStartDate);
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setStartDate(cal);
				}

				if ( null != dtPegRevDate ) {
					Calendar cal = Calendar.getInstance();
					cal.setTime(dtPegRevDate);
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setPegReviewDate(cal);
				}

				amortOvarTenorSlabLLFCRM[iIntSlabCnt].setPeggedFlg("Y");
				if ( iSlabPegFreqDays != null ) {
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setPeggedFreqInDays(iSlabPegFreqDays);
				} else {
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setPeggedFreqInDays(0);
				}

				if (iSlabPegFreqMon != null ) {
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setPeggedFreqInMnths(iSlabPegFreqMon);
				} else {
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setPeggedFreqInMnths(0);
				}
				amortOvarTenorSlabLLFCRM[iIntSlabCnt].setReviewReqdOnStartDate(sRevOnSlbStDt);

				pcnt = amortOvarTenorSlabLLFCRM[iIntSlabCnt].getCustPrefInt();
				if (dCustPrefInt != null ) {
					pcnt.setValue(dCustPrefInt.doubleValue());
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setCustPrefInt(pcnt);
				}

				pcnt = amortOvarTenorSlabLLFCRM[iIntSlabCnt].getAcctPrefInt();
				if (dAcctPrefInt != null ) {
					pcnt.setValue(dAcctPrefInt.doubleValue());
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setAcctPrefInt(pcnt);
				}

				pcnt = amortOvarTenorSlabLLFCRM[iIntSlabCnt].getNegotiatedRate();
				if (dNegIntPcnt != null ) {
					pcnt.setValue(dNegIntPcnt.doubleValue());
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setNegotiatedRate(pcnt);
				}

				pcnt = amortOvarTenorSlabLLFCRM[iIntSlabCnt].getChnlPrefInt();
				if (dChnlPrefInt != null ) {
					pcnt.setValue(dChnlPrefInt.doubleValue());
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setChnlPrefInt(pcnt);
				}
				pcnt = amortOvarTenorSlabLLFCRM[iIntSlabCnt].getMaxIntPercent();
				if (dAcctPrefInt != null ) {
					pcnt.setValue(dMaxPercent.doubleValue());
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setMaxIntPercent(pcnt);
				}
				pcnt = amortOvarTenorSlabLLFCRM[iIntSlabCnt].getMinIntPercent();
				if (dAcctPrefInt != null ) {
					pcnt.setValue(dMinPercent.doubleValue());
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setMinIntPercent(pcnt);
				}
				amortOvarTenorSlabLLFCRM[iIntSlabCnt].setIntTblVerNum(strVersionNo);
				amortOvarTenorSlabLLFCRM[iIntSlabCnt].setSerial_num(iIntSlabCnt+1+"");
				if(strIntTblCde != null){
					amortOvarTenorSlabLLFCRM[iIntSlabCnt].setInterestTableCode(strIntTblCde);
				}
				iIntSlabCnt++;
			}


			inputVO.setAmortOvarTenorSlabLAOpenFCRM(amortOvarTenorSlabLLFCRM);
		}
		/*		else if (strInterestRateCode != null ) {
			basicInt.setIntTblCode(strInterestRateCode.toUpperCase());
			basicInt.setIntTblVernum(strIntTblVerNum);
		}
//		pcnt = basicInt.getChanDrPrefPcnt();
		if (dChannelPrefInt != null) {
			pcnt.setValue(dChannelPrefInt.doubleValue());
//			basicInt.setChanDrPrefPcnt(pcnt);
		}

		if( null != dtVariableRateReviewDate ) {
			//cal = Calendar.getInstance();
			//cal.setTime(dtVariableRateReviewDate);
			cal = coreDateFormat(dtVariableRateReviewDate);
			basicInt.setPegReviewDate(cal);
			//CILAParams.IntTaxDet.pegRevDate = formatDate(dtVariableRateReviewDate.toString());
		}

		if(null != strPegFlag && strPegFlag.trim().length()>0){
			basicInt.setPeggedFlg(strPegFlag.toUpperCase());
			//CILAParams.IntTaxDet.acctPegged = strPegFlag.toUpperCase();
		}

		if(null != strApplWithHldgTaxFlg && strApplWithHldgTaxFlg.trim().length()>0){
			acctIntTax.setWtaxFlg(strApplWithHldgTaxFlg.toUpperCase());
			//CILAParams.IntTaxDet.wtaxFlg = strApplWithHldgTaxFlg.toUpperCase();
		}

		if(acPreferentialDr > 0.0)
		{
			pcnt = basicInt.getAcctCrPrefPcnt();
			pcnt.setValue(acPreferentialDr);
			basicInt.setAcctCrPrefPcnt(pcnt);
		}else if(acPreferentialDr < 0.0)
		{
			pcnt = basicInt.getAcctDrPrefPcnt();
			pcnt.setValue(acPreferentialDr);
			basicInt.setAcctDrPrefPcnt(pcnt);
			//
			//IntCollFlg has to be set as Y when AcctDrPrefPcnt is set
			 //otherwise CORE will throw a warning as follows
			 //Warning: ASD -> Debit preferentials will not be used as collect interest is 'N'
			 //
			acctIntTax.setIntCollFlg("Y");
		}
		 */
	}
	public void setSubsidyDetails(SRMBusinessContext bc,PaymentPlannerBO paymentplannerBO)throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, SRMTypeValidatorException, CIFatalException{


		Integer iProdCatID  = null;
		SRMQueryBuilder qbSaleBO = QueryAssist.singleObjectQuery("SaleBO", SaleBO.SALESID);
		QueryAssist.addSimpleCondition(qbSaleBO, "SaleBO", SaleBO.SALESID, IQuery.ComparisonOperation_EQ,""+salesID);
		qbSaleBO.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.PRODCATID));
		SRMQueryResult qrSaleBO = qbSaleBO.runQuery(bc,-1);
		SRMRecordSet rsSaleBO = qrSaleBO.getRecordSet();
		while ( rsSaleBO.hasNext() ) {
			List alSaleBO = (ArrayList)rsSaleBO.getNext();
			iProdCatID = (Integer)alSaleBO.get(0);
		}
		SRMQueryBuilder qbSubsidy =null;
		if(iProdCatID.intValue() == 5){
			//HLO
			/*serial_num
					subCode
					subEndDate
					subStartDate
					subSuspendFlg
					subAgencyCode

			 *
			 *
			 */
			qbSubsidy = QueryAssist.singleObjectQuery("SaleHLOBO", SaleHLOBO.SALESID);
			QueryAssist.addSimpleCondition(qbSubsidy, "SaleHLOBO", SaleHLOBO.SALESID, IQuery.ComparisonOperation_EQ,""+salesID);
			qbSubsidy.addAttribScope(QueryAssist.getTransformFn("SaleHLOBO", SaleHLOBO.SUBSIDYDETAILS_SUBSIDYCODE));
			qbSubsidy.addAttribScope(QueryAssist.getTransformFn("SaleHLOBO", SaleHLOBO.SUBSIDYDETAILS_SUBSIDYENDDATE));
			qbSubsidy.addAttribScope(QueryAssist.getTransformFn("SaleHLOBO", SaleHLOBO.SUBSIDYDETAILS_SUBSIDYSTDATE));
			qbSubsidy.addAttribScope(QueryAssist.getTransformFn("SaleHLOBO", SaleHLOBO.SUBSIDYDETAILS_SUBSIDYAGENCY));


		}else if(iProdCatID.intValue() == 6){
			qbSubsidy = QueryAssist.singleObjectQuery("SaleLOBO", SaleLOBO.SALESID);
			QueryAssist.addSimpleCondition(qbSubsidy, "SaleLOBO", SaleLOBO.SALESID, IQuery.ComparisonOperation_EQ,""+salesID);
			qbSubsidy.addAttribScope(QueryAssist.getTransformFn("SaleLOBO", SaleLOBO.SUBSIDYDETAILS_SUBSIDYCODE));
			qbSubsidy.addAttribScope(QueryAssist.getTransformFn("SaleLOBO", SaleLOBO.SUBSIDYDETAILS_SUBSIDYENDDATE));
			qbSubsidy.addAttribScope(QueryAssist.getTransformFn("SaleLOBO", SaleLOBO.SUBSIDYDETAILS_SUBSIDYSTDATE));
			qbSubsidy.addAttribScope(QueryAssist.getTransformFn("SaleLOBO", SaleLOBO.SUBSIDYDETAILS_SUBSIDYAGENCY));
		}
		SRMQueryResult qrSubsidy = qbSubsidy.runQuery(bc,-1);
		SRMRecordSet rsSubsidy = qrSubsidy.getRecordSet();
		int iSubsidyCnt = rsSubsidy.size();
		subsidyLL = new CILAAmortSubsidyLLFCRM[iSubsidyCnt];
		iSubsidyCnt = 0;
		while ( rsSubsidy.hasNext() ) {
			List alSubsidy = (ArrayList)rsSubsidy.getNext();
			String strSubCode = (String)alSubsidy.get(0);
			Date dtSubEndDate 		= (Date)alSubsidy.get(1);
			Date dtSubStartDate 		= (Date)alSubsidy.get(2);
			String strSubAgencyCode = (String)alSubsidy.get(3);
			subsidyLL[iSubsidyCnt] = new CILAAmortSubsidyLLFCRM();
			if(strSubCode != null){
				subsidyLL[iSubsidyCnt].setSubCode(strSubCode);
			}
			if ( null != dtSubEndDate ) {
				Calendar cal = Calendar.getInstance();
				cal.setTime(dtSubEndDate);
				subsidyLL[iSubsidyCnt].setSubEndDate(cal);
			}
			if ( null != dtSubStartDate ) {
				Calendar cal = Calendar.getInstance();
				cal.setTime(dtSubStartDate);
				subsidyLL[iSubsidyCnt].setSubStartDate(cal);
			}
			if(strSubAgencyCode != null){
				subsidyLL[iSubsidyCnt].setSubAgencyCode(strSubAgencyCode);
			}
			subsidyLL[iSubsidyCnt].setSerial_num(iSubsidyCnt+1+"");
			iSubsidyCnt++;
		}
		subsidyDtl.setOsubsidyLLOpenFCRM(subsidyLL);
		inputVO.setAmortSubsidyLAOpenFCRM(subsidyDtl);
	}
	public void setCommonFields(PaymentPlannerBO paymentplannerBO){
		if(null != paymentplannerBO.getInstallmentStartDate())
		{
			Calendar cal1 = Calendar.getInstance();

			cal1.setTime(paymentplannerBO.getInstallmentStartDate());
			commonField.setRepShdlDate(cal1);

		}
		else{
			commonField.setRepShdlDate(null);

		}
		/*
		 * noOfDmds-->noofinstalments
instlmntStartDate-->
intStartDate
repShdlDate
repmtMthd
instlmntFreq
intFreq

		 *
		 */
		/*
		commonField.setInstlmntFreq(instlmntFreq);
		commonField.setInstlmntStartDate(instlmntStartDate);
		commonField.setNoOfDmds(noOfDmds);
		commonField.setRepmtMthd(repmtMthd);
		commonField.setIntFreq(intFreq);
		 */
		inputVO.setLaShdlCmn(commonField);
	}
	public void setDisbursementDetails(ArrayList disb,PaymentPlannerBO paymentplannerBO)throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, SRMTypeValidatorException, CIFatalException{
		int disbCount = 0;
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
				disbScheduleLL = new CILAAmortDisburseScheduleLLFCRM[disbCount];
				for (int iCount = 0; iCount < disbCount ; iCount++ )
				{
					disbScheduleLL[iCount] = new CILAAmortDisburseScheduleLLFCRM();
					Amount amnt = disbScheduleLL[iCount].getDisburseAmt();
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
							disbScheduleLL[iCount].setDisburseDate(cal1);
							String strAmount = (String)tokensType.nextElement();
							amnt.setAmountValue((new Double(strAmount)).doubleValue());
							amnt.setCurrencyCode(paymentplannerBO.getCurrency());
							disbScheduleLL[iCount].setDisburseAmt(amnt);
							//not required
							//disbScheduleLL[iCount].setRemarks((String)tokensType.nextElement());
							disbScheduleLL[iCount].setSerial_num((iCount + 1)+"");
						}
					}
				}
				disbSchdDtl.setOdisburseScheduleLLOpenFCRM(disbScheduleLL);
				inputVO.setAmortDisburseShdlLAOpenFCRM(disbSchdDtl);
			}
		}
		catch (Exception ex)
		{
		}

	}
	public PaymentPlannerBO getCoreAmortSchedule(SRMBusinessContext bc,PaymentPlannerBO paymentplannerBO)throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, SRMTypeValidatorException, CIFatalException{
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
		inputVO.setFiIncidentInfo(objFIIncidentInfo);
		//setting all values in input vo
		disbSchdDtl.setOdisburseScheduleLLOpenFCRM(disbScheduleLL);
		inputVO.setAmortDisburseShdlLAOpenFCRM(disbSchdDtl);
		repayDtl.setOrepaymentLL(repayLL);
		repayDtl.setLaEiParamsOpenFCRM(amortEIParams);
		repayDtl.setEiSchmFlg(strEIFLAG);

		//repayDtl
		inputVO.setAmortRepaymentShdlLAOpenFCRM(repayDtl);
		inputVO.getAmortCommonInfoLAOpenFCRM().getAmortGeneralInfoLAOpenFCRM().setAmortBasicLAOpenFCRM(amortBasicInfo);
		inputVO.getAmortRepmtParamsLAFCRM().setOstructuredRepmtLLFCRM(structRepayLL);

		//setFrequencyChargeDetails(bc);
		//setTenorSlabDetails(bc,paymentplannerBO);
		//setSubsidyDetails(bc,paymentplannerBO);
		try
		{
			LoanAccountALImplementation inter = LoanAccountALImplementation.getInstance();
			CILAAmortShdlOutputFCRM outputvo = inter.doAmortScheduleFCRM(ciUserInfo, inputVO);
			CILAAmortOutLLFCRM outAmortLL[]= outputvo.getOamortLLOUT();
			CILAAmortAddInfoValFCRM outAdition = outputvo.getAmortAdditionalInfoVal();
			CILAAmortRepaymentLLFCRM[] arrayciRepayLL= outputvo.getOrepaymentLLOut();




		Percent	percent1 = outAdition.getEffIntRate();

		Amount intAmnt = outAdition.getTotIntAmt();
		Amount repAmnt = outAdition.getTotRepayAmt();
		Amount UnEarnedIncForConstPeriod = outAdition.getUnearndIncForCnstrperiod();
		Amount UnEarnedIncForStlmntPeriod = outAdition.getUnearnedIncForStlmntPeriod();

		//if (null == percent.getValue())

			paymentplannerBO.setEffIntRate(percent1.getValue())	;
			paymentplannerBO.setTotalProfit(intAmnt.getAmountValue());
			paymentplannerBO.setBankSP(repAmnt.getAmountValue());

//System.out.println("UnEarnedIncForConstPeriod.getAmountValue()----------->"+UnEarnedIncForConstPeriod.getAmountValue());
//System.out.println("UnEarnedIncForStlmntPeriod.getAmountValue()------->"+UnEarnedIncForStlmntPeriod.getAmountValue());
			if(UnEarnedIncForConstPeriod !=null){
			paymentplannerBO.setUnearnedIncConstPeriod(UnEarnedIncForConstPeriod.getAmountValue());
			}
			if(UnEarnedIncForStlmntPeriod !=null){
			paymentplannerBO.setUnearnedIncSetlmntPeriod(UnEarnedIncForStlmntPeriod.getAmountValue());
			}
			//outAdition.getTotIntAmt();
			//outAdition.getTotRepayAmt();


			//LamodRepaymentLL arrayciRepayLL[] = scheduleStruct.getLamodRepaymentLL();
			//FIAmortLL arrayciAmortizeLL[] = scheduleStruct.getOamortLL();

			SRMCollection ppDetailsList = paymentplannerBO.getPaymentPlannerDetails();
			/********Tracker No:88539:Start*******/
			//paymentplannerBO.setOfferRate(netRate);
			/********Tracker No:88539:Start*******/
			PaymentPlannerBO.PaymentPlannerDetails ppDetails = null;//(PaymentPlannerBO.PaymentPlannerDetails) paymentplannerBO.getInstance("PaymentPlannerDetails");

			String instType = "INSTALLMENT_TYPE";
			Amount amot = null;
			Percent percent = null;
			for(int i=0; i<arrayciRepayLL.length; i++)
			{
				ppDetails = (PaymentPlannerBO.PaymentPlannerDetails) paymentplannerBO.getInstance("PaymentPlannerDetails");

				ppDetails.setType(Constants.PAYMENTSCHEDULE);
				String strKey = arrayciRepayLL[i].getSerial_num();
				ppDetails.setStrField4(strKey);
				ppDetails.setStrField2(arrayciRepayLL[i].getFlowId());
				ppDetails.setStrField3(arrayciRepayLL[i].getEiFrequency().getType());

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
				if(arrayciRepayLL[i].getFlowId() != null)
				{
					ppDetails.setStrField9(arrayciRepayLL[i].getFlowId());
				}
				else{
					ppDetails.setStrField9(null);
				}
				if(arrayciRepayLL[i].getFlowAmt()!=null)
				{
					amot = arrayciRepayLL[i].getFlowAmt();
					ppDetails.setAmountField1(new Double(amot.getAmountValue()));
				}
				else
				{
					ppDetails.setAmountField1(new Double(0.0));
				}
				if(arrayciRepayLL[i].getNoOfDemands()!=0)
				{
					String lNoofInstal = new Long(arrayciRepayLL[i].getNoOfDemands()).toString();
					ppDetails.setIntField1(new Integer(lNoofInstal));
				}
				else
				{
					ppDetails.setIntField1(new Integer(0));
				}

				/**new fields**/
				/*
				if(arrayciRepayLL[i].getActualNoOfFlows() !=null)
				{

					ppDetails.setActualNoOfFlows(new Double(arrayciRepayLL[i].getActualNoOfFlows().value));
				else
				{
					ppDetails.setActualNoOfFlows(new Double(0));
				}
				if(arrayciRepayLL[i].getInstlmntPcnt()!=null)
				{
					percent = arrayciRepayLL[i].getInstlmntPcnt();
					ppDetails.setInstlmntPcnt(percent.getValue());
				}
				else
				{
					ppDetails.setInstlmntPcnt(null);
				}
				if(arrayciRepayLL[i].getNextIntDemandDate()!=null)
				{
					try{
						java.util.Date dat = arrayciRepayLL[i].getNextIntDemandDate().getTime();
						ppDetails.setNextIntDemandDate(dat);
					}catch(Exception e){ e.printStackTrace();}
				}
				else{
					ppDetails.setNextIntDemandDate(null);
				}
				if(arrayciRepayLL[i].getNextDemandDate()!=null)
				{
					java.util.Date dat = arrayciRepayLL[i].getNextDemandDate().getTime();
					ppDetails.setNextDemandDate(dat);
				}
				else
				{
					ppDetails.setNextDemandDate(null);
				}
				if(arrayciRepayLL[i].getInstlmntInd()!=null)
				{

					ppDetails.setInstlmntInd(arrayciRepayLL[i].getInstlmntInd());
				}
				else
				{
					ppDetails.setInstlmntInd(null);
				}
				//need to set interestFrequency
				 // ppDetails.setInterestFrequency(arrayciRepayLL[i].getInterestFrequency().getType());
				 */

				ppDetailsList.add(ppDetails);
			}

			for(int i=0; i<outAmortLL.length; i++)
			{

				ppDetails = (PaymentPlannerBO.PaymentPlannerDetails) paymentplannerBO.getInstance("PaymentPlannerDetails");
				//FIAmortShdlDtls amortSchdl = arrayciAmortizeLL[i].getAmortStruct();
				CILAAmortShdlDtlsOutLLFCRM amortSchdl = outAmortLL[i].getOamortShdlDtlsLLOut();
				ppDetails.setType(Constants.AMORTIZATIONSCHEDULE);
				/*MultiRecKey mKeyamort = arrayciAmortizeLL[i].getKey();
				ppDetails.setStrField4(mKeyamort.getSerial_num());*/
				String strSerialNum = outAmortLL[i].getSerial_num();
				ppDetails.setStrField4(strSerialNum);
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
					ppDetails.setAmountField3(0.0);
				if(amortSchdl.getPrincAmt()!=null)
				{
					amot = amortSchdl.getPrincAmt();
					ppDetails.setAmountField4(new Double(amot.getAmountValue()));
				}
				else
					ppDetails.setAmountField4(0.0);
				if(amortSchdl.getIntAmt()!=null)
				{
					amot = amortSchdl.getIntAmt();
					ppDetails.setAmountField5(new Double(amot.getAmountValue()));

				}
				else
					ppDetails.setAmountField5(0.0);
				if(amortSchdl.getCummPrincAmt()!=null)
				{
					amot = amortSchdl.getCummPrincAmt();
					ppDetails.setAmountField6(new Double(amot.getAmountValue()));

				}
				else
					ppDetails.setAmountField6(0.0);
				if(amortSchdl.getCummIntAmt()!=null)
				{
					amot = amortSchdl.getCummIntAmt();
					ppDetails.setAmountField7(new Double(amot.getAmountValue()));
				}
				else
					ppDetails.setAmountField7(0.0);
				//need to check with mohmad

				if(amortSchdl.getBankSharePcnt()!=null)
				{
					percent = amortSchdl.getBankSharePcnt();
					ppDetails.setBankSharePerc(new Double(percent.getValue()));
				}
				else
					ppDetails.setBankSharePerc(0.0);

				if(amortSchdl.getCustSharePcnt()!=null)
				{
					percent = amortSchdl.getCustSharePcnt();
					ppDetails.setCustSharePerc(new Double(percent.getValue()));
				}
				else
					ppDetails.setCustSharePerc(0.0);

				//getSellPriceAmt new field changes

					if(amortSchdl.getSellPriceAmt()!=null)
					{
						amot = amortSchdl.getSellPriceAmt();
						ppDetails.setOutStandingSP(new Double(amot.getAmountValue()));
					}
					else
						ppDetails.setOutStandingSP(0.0);
				if(amortSchdl.getPrincOutStanding()!=null)
				{
					amot = amortSchdl.getPrincOutStanding();
					ppDetails.setPrincOutStanding(new Double(amot.getAmountValue()));
				}
				else
					ppDetails.setPrincOutStanding(0.0);
				if(amortSchdl.getQntyOfAssetDlvd()!=null)
				{
					amot = amortSchdl.getQntyOfAssetDlvd();
					ppDetails.setAssetQntyDlvrd(new Double(amot.getAmountValue()));
				}
				else
					ppDetails.setAssetQntyDlvrd(0.0);

				/*if(amortSchdl.getVariableChrgDmd()!=null)
				{

					ppDetails.setVariableChrgDmd(amortSchdl.getVariableChrgDmd());

				}
				else
					ppDetails.setVariableChrgDmd(null);*/
				if(amortSchdl.getFixedChargeAmt ()!=null)
				{
					amot = amortSchdl.getFixedChargeAmt();
					ppDetails.setFixedChargeAmt (new Double(amot.getAmountValue()));

				}
				else
					ppDetails.setFixedChargeAmt (0.0);
				/*if(amortSchdl.getCummFixedChargeAmt ()!=null)
				{
					amot = amortSchdl.getCummFixedChargeAmt();
					ppDetails.setCummFixedChargeAmt (new Double(amot.getAmountValue()));

				}
				else
					ppDetails.setCummFixedChargeAmt (null);
				if(amortSchdl.getTotalSbsdyAmt()!=null)
				{
					amot = amortSchdl.getTotalSbsdyAmt();
					ppDetails.setTotalSbsdyAmt(new Double(amot.getAmountValue()));

				}
				else
					ppDetails.setTotalSbsdyAmt (null);
				 */
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
				//logError(confe, salesID, bc);
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
		catch (Exception e)
		{
			e.printStackTrace();
		}
		catch (Throwable e)
		{
			throw new CIFatalException(
					"Runtime errror occured during EISchedule. Please refer to server log",e);
		}
		return paymentplannerBO;
	}
	public ArrayList getSaleBackendDetails(SRMBusinessContext bc)
	{
		/* CRA10MSC - ARM - Begin of changes : Starting BL Layer transaction */


		/* CRA10MSC - ARM - End of changes */
		ArrayList arrSaleBackDetails = new ArrayList();
		Double dEligibleAmount=null;
		try{
			/* START - CHANGES DONE FOR CRM70TNG TRACKER#--> 82238 */
			List attr = new ArrayList();

			attr.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.APPLBRANCH));
			attr.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.ACCOUNTCURRENCY));
			attr.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.EIFLAG));
			attr.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.EIMODE));
			attr.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.UPFRONTINSTAMOUNT));
			attr.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.NUMBEROFUPFRONTINSTALLMENTS));
			attr.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.DEFERMENTSTARTMONTH));
			attr.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.MAXDEFERMENTMONTH));
			attr.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.CAPOVEREMI));
			attr.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.EIFORMULA));
			/*
			amortEIParams.setCollectUpFrontFlg();
			amortEIParams.setNumOfAdvInst(numOfAdvInst);
			amortEIParams.setDefStartMonth(defStartMonth)
			amortEIParams.setNumOfMnthsDefer(numOfMnthsDefer)
			amortEIParams.setCapEMIFlg(capEMIFlg)*/
			SRMQueryBuilder qbs = QueryAssist.singleObjectQuery("SaleBackEndBO",SaleBackEndBO.BACKENDID,EIFetchFromCore_SALEBACKENDDETAILS);
			QueryAssist.addSimpleCondition(qbs,"SaleBackEndBO", SaleBackEndBO.SALESID,IQuery.ComparisonOperation_EQ,""+salesID);

			int noOfAttrs = attr.size();
			for (int i=0; i<noOfAttrs; i++) {
				qbs.addAttribScope((TransFormFn) attr.get(i));
			}
			SRMQueryResult qrs = qbs.runQuery(bc, false, -1);

			//ArrayList boSaleBackEndBO = null;
			SRMRecordSet rs = qrs.getRecordSet();
			if(rs.hasNext()) {
				//SaleBackEndBO boSaleBackEndBO = (SaleBackEndBO)rs.getNext().get(0);
				arrSaleBackDetails= (ArrayList)rs.getNext();


			}
			rs.resetIndex();
			/* END - CHANGES DONE FOR CRM70TNG TRACKER#--> 82238 */
		}catch(Exception e){
		}

		/* CRA10MSC - ARM - Begin of changes : Stopping BL Layer transaction */

		/* CRA10MSC - ARM - End of changes */
		return arrSaleBackDetails;
	}
	public String getCIFID (SRMBusinessContext bc)throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, SRMTypeValidatorException, CIFatalException{
		String strCIFID = "";
		String strCustId = "";
//		getttng opportunityid
		Integer iOpportunityId  = null;
		SRMQueryBuilder qbSaleBO = QueryAssist.singleObjectQuery("SaleBO", SaleBO.SALESID);
		QueryAssist.addSimpleCondition(qbSaleBO, "SaleBO", SaleBO.SALESID, IQuery.ComparisonOperation_EQ,""+salesID);
		qbSaleBO.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.OPPORTUNITYID));
		SRMQueryResult qrSaleBO = qbSaleBO.runQuery(bc,-1);
		SRMRecordSet rsSaleBO = qrSaleBO.getRecordSet();
		while ( rsSaleBO.hasNext() ) {
			List alSaleBO = (ArrayList)rsSaleBO.getNext();
			iOpportunityId = (Integer)alSaleBO.get(0);
		}
		//Getting the CIF ID
		SRMQueryBuilder qbCIFID = new SRMQueryBuilder();

		QueryAssist.addJoin (qbCIFID, "AccountBO", AccountBO.ACCOUNTID,"OpportunityBO", OpportunityBO.ACCOUNTID,IQuery.JoinType_Equi);
		qbCIFID.addAttribScope(QueryAssist.getTransformFn("AccountBO", AccountBO.ACCOUNTKEY));
		qbCIFID.addAttribScope(QueryAssist.getTransformFn("AccountBO", AccountBO.ACCOUNTID));
		QueryAssist.addSimpleCondition(qbCIFID,"OpportunityBO",OpportunityBO.OPPORTUNITYID,IQuery.ComparisonOperation_EQ, iOpportunityId);
		SRMQueryResult qrCIFID = qbCIFID.runQuery(bc,-1);
		SRMRecordSet rsCIFID = qrCIFID.getRecordSet();
		if ( rsCIFID.hasNext() ) {
			ArrayList arCIFID = (ArrayList)rsCIFID.getNext();
			if (arCIFID.get(0) != null ) {
				strCIFID = (String)arCIFID.get(0);
				strCustId = ((Integer)arCIFID.get(1)).toString();
			}
		}
		return strCIFID;
	}
	//change for callid 409425 begins
	public Double getCustPrefInt(SRMBusinessContext bc , String strCIFID,String prodCur) throws SRMBOException,SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, SRMTypeValidatorException, CIFatalException{
		PsychographicBO PsychoBO = null;
		PsychoBO = (PsychographicBO)Utils.getBOFromID(bc,"PsychographicBO",PsychographicBO.ORGKEY,strCIFID);
		SRMCollection  cAsset = PsychoBO.getMiscellaneousInfo();
		PsychographicBO.MiscellaneousInfo misc = null;
		int noOfmisc = cAsset.size();
		Double custPrefInt=0.0;
		for(int i = 0;i < noOfmisc ; i++) {
		misc =(PsychographicBO.MiscellaneousInfo)cAsset.get(i);
		String str =misc.getType();
		String custCur =misc.getStrText10();
		if(str.equals("CURRENCY") && custCur.equalsIgnoreCase(prodCur)){
			custPrefInt=misc.getDbFloat2();
		}
	   }
		return custPrefInt;
	}
	//change for callid 409425 ends
}


