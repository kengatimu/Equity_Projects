/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: RescheduleLoanInCore.java $
 *
 * Author: APAC
 *
 * $Archive: /FCRM62BASE/com/infy/cis/ui/custom/RescheduleLoanInCore.java $
 *
 * $History: RescheduleLoanInCore.java $
 *****************************************************************************/


package com.infy.cis.custom;

import com.infosys.ci.ons.cistruct.*;
import com.infosys.ci.hostinterface.common.*;
import com.infosys.ci.common.CIFatalException;
import com.infosys.ci.common.CINonFatalException;
import com.infosys.ci.ons.common.CIOnsNonFatalException;
import com.infosys.bankaway.accesslayer.bwyinterface.*;
import com.infosys.ci.common.*;
//import com.infosys.ci.ons.common.AcctId;
import com.infy.cis.common.SRMFormatter;

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
import java.text.SimpleDateFormat;
import com.infy.cis.ui.common.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.security.user.*;
import com.infosys.ci.ons.common.*;


public class RescheduleLoanInCore {

	PaymentPlannerBO ppBO = null;
	//CIReschdlCommonDet circomdet = null;
	//CIReschdlParameterDet cireschdlPD = null;
	String reasonCode = "";
	String strAccountNumber = "";
	long noofDmds	= 0;
	String hldyIntFlg = "";
	String reshdlAmtFlg = "";
	double loanAmt = 0.0;
	String crcnyCode = "";
	String flowID = "";
	String calcEIorTen = "";
	int iOpportunityid = 0;
	/*** Start 110899****/
	Integer salesID = new Integer(0);
	/*** End 110899****/
	SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
    /*Enabling amount more than 8 digits.*/
    java.text.DecimalFormat decFormat = new java.text.DecimalFormat("##############.##");

	public PaymentPlannerBO fetchReschedule(SRMBusinessContext bc, int opportunityID)
		throws CIFatalException, SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException
		{

		CIUserInfo ciUserInfo = null;

		//CIReschdlCritDet ciReschdlCritDet = null;
		LoanRshdlInput loanAcctRshdlIpVO = new LoanRshdlInput();
		CILaBasicRshdlMsg loanRshdlBasicIp = loanAcctRshdlIpVO.getBasicRshdlDtl();

		//String[] inputstr = new String[0];
		ciUserInfo = new CIUserInfo();
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

		FIIncidentInfo objFIIncidentInfo = new FIIncidentInfo();
		String xx = String.valueOf(System.currentTimeMillis());
		objFIIncidentInfo.setDccReqRefNum(xx);

		String xy = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(new Date());
		objFIIncidentInfo.setDccReqOrigTime(xy);
		objFIIncidentInfo.setDccReqType("DEFAULTEJB");
		loanAcctRshdlIpVO.setFIIncidentInfo(objFIIncidentInfo);

		//ciReschdlCritDet = new CIReschdlCritDet();
		Calendar cal = Calendar.getInstance();

		CIAcctId acctID = loanRshdlBasicIp.getLaAcct();

		iOpportunityid = opportunityID;


		try {
			SRMQueryBuilder qb = new SRMQueryBuilder();

			ArrayList obj = new ArrayList();

			qb = QueryAssist.singleObjectQuery("SaleBO", SaleBO.SALESID);
			QueryAssist.addSimpleCondition(qb,"SaleBO",SaleBO.OPPORTUNITYID,IQuery.ComparisonOperation_EQ,"" + opportunityID);
			qb.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.ACCOUNTNUMBER));
			qb.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.APPLCURRENCY));
			qb.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.RESTRUCTREASONCODE ));
			qb.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.OLDACCOUNTNUMBER ));
			qb.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.SALESID));

			SRMQueryResult qr = qb.runQuery(bc, -1);
			SRMRecordSet rs = qr.getRecordSet();
			if (rs.hasNext()) {
				obj = (ArrayList) rs.getNext();
				strAccountNumber = (String) obj.get(0);
				acctID.setForacid(strAccountNumber);
				acctID.setCrncyCode((String) obj.get(1));
				reasonCode = (String) obj.get(2);
				loanRshdlBasicIp.setReason(reasonCode);
				salesID = (Integer) obj.get(4);
			}

			ciUserInfo.setChannelType("CRM");
			acctID.setForacid((String) obj.get(3));

			loanRshdlBasicIp.setLaAcct(acctID);
			loanAcctRshdlIpVO.setBasicRshdlDtl(loanRshdlBasicIp);

			LoanAccountInquiryALImplementation inter = LoanAccountInquiryALImplementation.getInstance();
			LoanRshdlDtlsOutput loanAcctRshdlOpVO = inter.fetchLoanRescheduleDetails(ciUserInfo, loanAcctRshdlIpVO);

			CILaBasicRsdlMsg loanRshdlMsgOp = loanAcctRshdlOpVO.getBasicRshdlDtl();
			AcctAdvRepaymentParamsLA acctAdvRepParam = loanAcctRshdlOpVO.getAcctAdvRepmtParamsLA();
			StructuredRepaymentLL[] structRepLL = acctAdvRepParam.getOstructuredRepmtLL();
			LaOvdueDefIntDtls laOvdueDefIntDtls = acctAdvRepParam.getOvdueDetails();
			CILaShdlCmnParams loanShdlCmnParams = loanAcctRshdlOpVO.getLoanShdlCommonParams();

			CIAcctRepaymentShdlLA acctRepaySchLA = loanRshdlMsgOp.getAcctRepaymentShdlLA();
			LaRepaymentLL[] loanRpymntLL = acctRepaySchLA.getOrepaymentLL();
			LoanEiParams  LaEiParamsOp = acctRepaySchLA.getLaEiParams();
			LaOvduDetails loanOvduDtls = loanRshdlMsgOp.getLaOvduDtls();
			CILaSchmParams laSchmParams = loanRshdlMsgOp.getLaSchmParams();

			ppBO = new PaymentPlannerBO();

			if (acctRepaySchLA.getLoanAmount() != null)
			{

				String LoanAmount = decFormat.format((Object)acctRepaySchLA.getLoanAmount().getAmountValue());

				ppBO.setReschedLoanAmt(new Double(LoanAmount));


			}
			else
				ppBO.setReschedLoanAmt(null);

			if (loanOvduDtls.getOutStandingAmt() != null)
			{

				ppBO.setReschedOSAmt(new Double((String)decFormat.format((Object)loanOvduDtls.getOutStandingAmt().getAmountValue())));

			}
			else
				ppBO.setReschedOSAmt(null);

			if (loanOvduDtls.getOverflowAmt() != null)
			{

				ppBO.setReschedOFAmt(new Double((String)decFormat.format((Object)loanOvduDtls.getOverflowAmt().getAmountValue())));

			}
			else
				ppBO.setReschedOFAmt(null);


			ppBO.setReschedEIType(laSchmParams.getEiMethod());
			//savitha changes
			ppBO.setEIFormula(laSchmParams.getEiFormulaFlg());
			ppBO.setReschedReasonCode(reasonCode);

			if (laOvdueDefIntDtls.getOvDuePrinAmt() != null)
			{
				ppBO.setReschedPrinODAmt(new Double(laOvdueDefIntDtls.getOvDuePrinAmt().getAmountValue()));

			}
			else
				ppBO.setReschedPrinODAmt(null);

			if (laOvdueDefIntDtls.getOvDueIntAmt() != null)
			{
				ppBO.setReschedIntODAmt(new Double(laOvdueDefIntDtls.getOvDueIntAmt().getAmountValue()));

			}
			else
				ppBO.setReschedIntODAmt(null);

			if (laOvdueDefIntDtls.getDefIntAmt() != null)
			{
				ppBO.setReschedDefInterestAmt(new Double(laOvdueDefIntDtls.getDefIntAmt().getAmountValue()));

			}
			else
				ppBO.setReschedDefInterestAmt(null);

			if(laOvdueDefIntDtls.getNoOfPrinOvDueInstl() !=0)
			{
				ppBO.setReschedPrinODNoOfInstall(new Integer(new Long(laOvdueDefIntDtls.getNoOfPrinOvDueInstl()).toString()));
			}else{
				ppBO.setReschedPrinODNoOfInstall(null);
			}


			if(laOvdueDefIntDtls.getNoOfIntOvDueInstl() !=0)
			{
				ppBO.setReschedIntODNoOfInstall(new Integer(new Long(laOvdueDefIntDtls.getNoOfIntOvDueInstl()).toString()));
			}else{
				ppBO.setReschedIntODNoOfInstall(null);
			}

			if(laOvdueDefIntDtls.getNoOfDefIntInstl() !=0)
			{
				ppBO.setReschedDefIntNoOfInstall(new Integer(new Long(laOvdueDefIntDtls.getNoOfDefIntInstl()).toString()));
			}else{
				ppBO.setReschedDefIntNoOfInstall(null);
			}


			if (loanRshdlMsgOp.getShdlNo() != null && !loanRshdlMsgOp.getShdlNo().equals(""))
			{
				ppBO.setReschedScheduleNo(new Integer(loanRshdlMsgOp.getShdlNo()));
			}
			else{

				ppBO.setReschedScheduleNo(null);
			}

			if (loanAcctRshdlOpVO.getRshdlDate() != null && !loanAcctRshdlOpVO.getRshdlDate().equals("")) {
				ppBO.setReschedScheduleCreationDt(loanAcctRshdlOpVO.getRshdlDate().getTime());
			} else {
				ppBO.setReschedScheduleCreationDt(null);
			}
			if (loanShdlCmnParams.getInstlmntStartDate() != null && !loanShdlCmnParams.getInstlmntStartDate().equals(""))
			{
				ppBO.setReschedInstallmentsStartDate(loanShdlCmnParams.getInstlmntStartDate().getTime());
			}
			else{
				ppBO.setReschedInstallmentsStartDate(null);
			}

			if (loanShdlCmnParams.getIntStartDate() != null && !loanShdlCmnParams.getIntStartDate().equals(""))
			{
			ppBO.setReschedInterestStartDate(loanShdlCmnParams.getIntStartDate().getTime());
			}
			else{

				ppBO.setReschedInterestStartDate(null);
			}

			ppBO.setEIFreqType(loanRpymntLL[0].getEiFrequency().getType());
			ppBO.setEIFreqWeekOfMonth(loanRpymntLL[0].getEiFrequency().getWeekNum());

			String eifreqwkday = new Long(loanRpymntLL[0].getEiFrequency().getWeekDay()).toString();
			if (eifreqwkday != null && !eifreqwkday.equals(""))
			{
				ppBO.setEIFreqDayOfWeek(eifreqwkday);
			}
			else{
				ppBO.setEIFreqDayOfWeek(null);
			}

			Integer eifreqstartdt = new Integer(new Long(loanRpymntLL[0].getEiFrequency().getStartDd()).toString());
			if (eifreqstartdt != null && !eifreqstartdt.equals(""))
			{
				ppBO.setEIFreqStartDate(eifreqstartdt);
			}
			else{
				ppBO.setEIFreqStartDate(null);
			}

			ppBO.setEIFreqHolidayCode(loanRpymntLL[0].getEiFrequency().getHldyStat());
			ppBO.setIntFreqType(loanShdlCmnParams.getIntFreq().getType());
			ppBO.setIntFreqWeekOfMonth(loanShdlCmnParams.getIntFreq().getWeekNum());

			String intfreqwkday = new Long(loanShdlCmnParams.getIntFreq().getWeekDay()).toString();

			if (intfreqwkday != null && !intfreqwkday.equals(""))
			{
				ppBO.setIntFreqDayOfWeek(intfreqwkday);
			}
			else{
				ppBO.setIntFreqDayOfWeek(null);
			}

			Integer intfreqstartdt = new Integer(new Long(loanShdlCmnParams.getIntFreq().getStartDd()).toString());
			if (intfreqstartdt != null && !intfreqstartdt.equals(""))
			{
				ppBO.setIntFreqStartDate(intfreqstartdt);
			}
			else{
				ppBO.setIntFreqStartDate(null);
			}

			ppBO.setIntFreqHolidayCode(loanShdlCmnParams.getIntFreq().getHldyStat());
			ppBO.setCarryOverDemands(loanAcctRshdlOpVO.getCarryOverDueDmds());
			ppBO.setReschedCapitalize(loanAcctRshdlOpVO.getCapitalizeIntFlag());
			ppBO.setDelinquencyReschedule(loanRshdlMsgOp.getDelinRshdlFlg());
			ppBO.setReschedIntUptoDate(loanAcctRshdlOpVO.getApplyIntUptoDate());
			ppBO.setRescheduleBy(loanAcctRshdlOpVO.getCalcNewEiOrExtendTenor());
			ppBO.setReschedRestFreq(LaEiParamsOp.getIntRestFreq());
			ppBO.setReschedRestBasis(LaEiParamsOp.getIntRestBasis());
			ppBO.setReschedGradPymt(LaEiParamsOp.getGradPmtAlwd());

			Integer noofsteps = new Integer(new Long(LaEiParamsOp.getNoOfSteps()).toString());
			if (noofsteps != null && !noofsteps.equals(""))
			{
				ppBO.setReschedNoOfSteps(noofsteps);
			}
			else{
				ppBO.setReschedNoOfSteps(new Integer(0));
			}

			if (LaEiParamsOp.getStepPcnt() != null && !LaEiParamsOp.getStepPcnt().equals(""))
			{
				ppBO.setReschedStepPcnt(new Double(LaEiParamsOp.getStepPcnt().getValue()));
			}
			else{
				ppBO.setReschedStepPcnt(null);
			}

			ppBO.setReschedStepInd(LaEiParamsOp.getStepInd());
			ppBO.setReschedAutoReschedule(LaEiParamsOp.getAutoReshdlAfterHldyPerd());
			ppBO.setReschedInstallAmtType(LaEiParamsOp.getEiType());

			noofDmds	= loanShdlCmnParams.getNoOfDmds();
			hldyIntFlg = loanAcctRshdlOpVO.getBasicRshdlDtl().getAcctRepaymentShdlLA().getLaEiParams().getHldyPerdIntFlg();
			reshdlAmtFlg = loanAcctRshdlOpVO.getRshdlAmtFlg();
			loanAmt = loanAcctRshdlOpVO.getBasicRshdlDtl().getAcctRepaymentShdlLA().getLoanAmount().getAmountValue();
			crcnyCode = loanAcctRshdlOpVO.getBasicRshdlDtl().getAcctRepaymentShdlLA().getLoanAmount().getCurrencyCode();
			flowID = loanAcctRshdlOpVO.getBasicRshdlDtl().getAcctRepaymentShdlLA().getOrepaymentLL()[0].getFlowId();
           	calcEIorTen	=	loanAcctRshdlOpVO.getCalcNewEiOrExtendTenor();
          	String eiSchmFlg = loanAcctRshdlOpVO.getBasicRshdlDtl().getAcctRepaymentShdlLA().getEiSchmFlg();
          	if(eiSchmFlg != null && !(eiSchmFlg.equals("")))
          	{
				ppBO.setStrField1(eiSchmFlg);
			}

			if(flowID != null && !(flowID.equals("")))
			{
				ppBO.setStrField9(flowID);
			}
            }
		/*** Start 110899****/
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

			e.printStackTrace();
			throw new CIFatalException(
			"Runtime errror occured during EISchedule. Please refer to server log",e);
		}
		/*** End 110899****/
		return ppBO;

	}

	public PaymentPlannerBO generateRescheduleFlow(SRMFormatter srmf, SRMBusinessContext bc,PaymentPlannerBO ppBO,String opportunityID)
		throws CIFatalException, SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException, SRMTypeConversionException
		{
		Calendar cal = Calendar.getInstance();
		iOpportunityid = Integer.parseInt(opportunityID);

		GenLaRshdlFlowInputVO genLaRshdlFlowInputVO = new GenLaRshdlFlowInputVO();
		GenLaBasicRshdlMsg genLaBasicRshdlMsg = genLaRshdlFlowInputVO.getBasicRshdlDtl();
		GenLaAcctAdvRepmtParamsLA genLaAcctAdvRepmt = genLaRshdlFlowInputVO.getAcctAdvRepmtParamsLA();
		GenLaAcctId genLaAcctId = genLaBasicRshdlMsg.getLaAcct();
		GenAcctRepaymentShdlLA genAcctRepShdlLA = genLaBasicRshdlMsg.getAcctRepaymentShdlLA();
		GenlaEiParams genlaEiParams = genAcctRepShdlLA.getLaEiParams();
		GenRepaymentLL[] genRepaymentLL = new GenRepaymentLL[1];
			StructuredRepmtLL[] genStructRepmtLL = null;
		GenLaShdlCmnParams genLaShdlCmnParams = genLaRshdlFlowInputVO.getLoanShdlCommonParams();
		Frequency intfreq = genLaShdlCmnParams.getIntFreq();
		Frequency instlmntfreq = genLaShdlCmnParams.getInstlmntFreq();
		GenRshdlLaOvdueDefIntDtls laOvdueDefIntDtls = genLaRshdlFlowInputVO.getLaOvdueDefIntDtls();
		Amount duePrinAmt = laOvdueDefIntDtls.getOvDuePrinAmt();
		Amount dueIntAmt = laOvdueDefIntDtls.getOvDueIntAmt();
		Amount defIntAmt = laOvdueDefIntDtls.getDefIntAmt();

		LaRshdlFlowOutputVO laRshdlFlowOutputVO = new LaRshdlFlowOutputVO();
		GenAcctRepaymentShdlLAOut genAcctRepShdlLAOut = null;
		GenLaBasicRshdlMsgOut genLaBasicRshdlMsgOut = null;
		GenRepaymentLLOut[] genRepLLOut = null;
		GenLaRshdlFeeOut genLaRshdlFeeOut = null;
			GenLaSchmParams genLaSchmParam = genLaBasicRshdlMsg.getLaSchmParams();


		CIUserInfo ciUserInfo = new CIUserInfo();

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
		FIIncidentInfo objFIIncidentInfo = new FIIncidentInfo();
		String xx = String.valueOf(System.currentTimeMillis());
		objFIIncidentInfo.setDccReqRefNum(xx);

		String xy = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(new Date());
		objFIIncidentInfo.setDccReqOrigTime(xy);
		objFIIncidentInfo.setDccReqType("DEFAULTEJB");
		genLaRshdlFlowInputVO.setFiIncidentInfo(objFIIncidentInfo);

			SRMQueryBuilder qb = new SRMQueryBuilder();

			ArrayList obj = new ArrayList();

			qb = QueryAssist.singleObjectQuery("SaleBO", SaleBO.SALESID);
			QueryAssist.addSimpleCondition(	qb,"SaleBO",SaleBO.OPPORTUNITYID,IQuery.ComparisonOperation_EQ,"" + opportunityID);
			qb.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.ACCOUNTNUMBER));
			qb.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.APPLCURRENCY));
			qb.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.RESTRUCTREASONCODE ));
			qb.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.OLDACCOUNTNUMBER ));
			qb.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.SALESID));
			SRMQueryResult qr = qb.runQuery(bc, -1);
			SRMRecordSet rs = qr.getRecordSet();
			if (rs.hasNext()) {
				obj = (ArrayList) rs.getNext();
				genLaAcctId.setForacid((String) obj.get(0));
				genLaAcctId.setCrncyCode((String) obj.get(1));
				genLaBasicRshdlMsg.setReason((String) obj.get(2));
				salesID = (Integer) obj.get(4);
			}

			ciUserInfo.setChannelType("CRM");
			genLaAcctId.setForacid((String) obj.get(3));

			if (ppBO.getReschedScheduleNo() != null)
			{
			genAcctRepShdlLA.setShdlNo(ppBO.getReschedScheduleNo().toString());
			}
			else{
			genAcctRepShdlLA.setShdlNo(null);
			}
			if (ppBO.getReschedScheduleCreationDt() != null)
			{
				cal.setTime(ppBO.getReschedScheduleCreationDt());
			    genLaRshdlFlowInputVO.setRshdlDate(cal);
			}
			else{
			genLaRshdlFlowInputVO.setRshdlDate(null);
			}
			if (ppBO.getReschedInstallmentsStartDate() != null)
			{
				cal.setTime(ppBO.getReschedInstallmentsStartDate());
				genLaShdlCmnParams.setInstlmntStartDate(cal);
			}else{
			genLaShdlCmnParams.setInstlmntStartDate(null);
			}
			Calendar cal1 = Calendar.getInstance();
			if (ppBO.getReschedInterestStartDate() != null)
			{
				cal1.setTime(ppBO.getReschedInterestStartDate());
				genLaShdlCmnParams.setIntStartDate(cal1);
			} else{
			genLaShdlCmnParams.setIntStartDate(null);
			}
			if (ppBO.getEIFreqType() != null)
			{
			instlmntfreq.setType(ppBO.getEIFreqType());
			}
			else{
			instlmntfreq.setType(null);
			}
			if (ppBO.getEIFreqWeekOfMonth() != null && !(ppBO.getEIFreqWeekOfMonth().equals("")) )
			{
			instlmntfreq.setWeekNum(ppBO.getEIFreqWeekOfMonth());
			}
			else{
			instlmntfreq.setWeekNum(null);
			}

			//savitha hardcoded
			if (ppBO.getEIFreqDayOfWeek() != null && !(ppBO.getEIFreqDayOfWeek().equals("")))
			{
				instlmntfreq.setWeekDay(new Integer(ppBO.getEIFreqDayOfWeek()).longValue());
			}
			else{
			    instlmntfreq.setWeekDay(0);
			}
			if (ppBO.getEIFreqStartDate() != null)
			{
			instlmntfreq.setStartDd(ppBO.getEIFreqStartDate().longValue());
			}
			else{
			instlmntfreq.setStartDd(0);
			}
			if (ppBO.getEIFreqHolidayCode() != null)
			{
			instlmntfreq.setHldyStat(ppBO.getEIFreqHolidayCode());
			}
			else{
			instlmntfreq.setHldyStat(null);
			}
			if (ppBO.getIntFreqType() != null)
			{
			intfreq.setType(ppBO.getIntFreqType());
			}
			else{
			intfreq.setType(null);
			}
			if (ppBO.getIntFreqWeekOfMonth() != null && !(ppBO.getIntFreqWeekOfMonth().equals("")))
			{
			intfreq.setWeekNum(ppBO.getIntFreqWeekOfMonth());
			}
			else{
			intfreq.setWeekNum(null);
			}

			//savitha hardcoded
			if (ppBO.getIntFreqDayOfWeek() != null && !(ppBO.getIntFreqDayOfWeek().equals("")))
			{
			intfreq.setWeekDay(new Long(ppBO.getIntFreqDayOfWeek()).longValue());
			}
			else{
				intfreq.setWeekDay(0);
			}

			if (ppBO.getIntFreqStartDate() != null && !(ppBO.getIntFreqStartDate().equals("")))
			{
			intfreq.setStartDd(ppBO.getIntFreqStartDate().longValue());
			}
			else{
			intfreq.setStartDd(0);
			}

			if (ppBO.getIntFreqHolidayCode() != null)
			{
			intfreq.setHldyStat(ppBO.getIntFreqHolidayCode());
			}
			else{
			intfreq.setHldyStat(null);
			}
			if (ppBO.getCarryOverDemands() != null)
			{
			genLaRshdlFlowInputVO.setCarryOverDueDmds(ppBO.getCarryOverDemands());
			}
			else{
			genLaRshdlFlowInputVO.setCarryOverDueDmds(null);
			}
			if (ppBO.getReschedCapitalize() != null)
			{
			genLaRshdlFlowInputVO.setCapitalizeIntFlag(ppBO.getReschedCapitalize());
			}
			else{
			genLaRshdlFlowInputVO.setCapitalizeIntFlag(null);
			}
			if (ppBO.getReschedIntUptoDate() != null)
			{
			genLaRshdlFlowInputVO.setApplyIntUptoDate(ppBO.getReschedIntUptoDate());
			}
			else{
			genLaRshdlFlowInputVO.setApplyIntUptoDate(null);
			}
			if (ppBO.getRescheduleBy() != null)
			{
				genLaRshdlFlowInputVO.setCalcNewEiOrExtendTenor(calcEIorTen);
			}
			else{
			genLaRshdlFlowInputVO.setCalcNewEiOrExtendTenor(null);
			}
			if (ppBO.getReschedAutoReschedule() != null)
			{
			genlaEiParams.setAutoReshdlAfterHldyPerd(ppBO.getReschedAutoReschedule());
			}
			else{
			genlaEiParams.setAutoReshdlAfterHldyPerd(null);
			}

			if (ppBO.getReschedEIType()!= null)
			{
				genlaEiParams.setEiType(ppBO.getReschedEIType());
			}
			/*else{
			genlaEiParams.setEiType(null);
			}*/
			if (ppBO.getDelinquencyReschedule() != null)
			{
			genLaBasicRshdlMsg.setDelinRshdlFlg(ppBO.getDelinquencyReschedule());
			}
			else{
			genLaBasicRshdlMsg.setDelinRshdlFlg(null);
			}
			if (ppBO.getReschedRestFreq() != null)
			{
			genlaEiParams.setIntRestFreq(ppBO.getReschedRestFreq());
			}
			else{
			genlaEiParams.setIntRestFreq(null);
			}
			if (ppBO.getReschedRestBasis() != null)
			{
			genlaEiParams.setIntRestBasis(ppBO.getReschedRestBasis());
			}
			else{
			genlaEiParams.setIntRestBasis(null);
			}
			if (ppBO.getReschedGradPymt() != null)
			{
			genlaEiParams.setGradPmtAlwd(ppBO.getReschedGradPymt());
			}
			else{
			genlaEiParams.setGradPmtAlwd(null);
			}
			if (ppBO.getReschedNoOfSteps() != null)
			{
			genlaEiParams.setNoOfSteps(ppBO.getReschedNoOfSteps().longValue());
			}
			else{
			genlaEiParams.setNoOfSteps(0);
			}
			Percent prct = genlaEiParams.getStepPcnt();
			if (ppBO.getReschedStepPcnt() != null)
			{
				prct.setValue(ppBO.getReschedStepPcnt().doubleValue());
			}
			else{
				prct.setValue(0);
			}

			if (ppBO.getReschedStepInd() != null)
			{
			genlaEiParams.setStepInd(ppBO.getReschedStepInd());
			}
			else{
			genlaEiParams.setStepInd(null);
			}
			if (ppBO.getReschedNoOfSteps() != null)
			{
			genlaEiParams.setNoOfSteps(ppBO.getReschedNoOfSteps().longValue());
			}
			else{
			genlaEiParams.setNoOfSteps(0);
			}
			if (ppBO.getReschedPrinODAmt() != null)
			{
			duePrinAmt.setAmountValue(ppBO.getReschedPrinODAmt().doubleValue());
			duePrinAmt.setCurrencyCode(ppBO.getCurrency());
			}
			else{
			duePrinAmt.setAmountValue(0);
			duePrinAmt.setCurrencyCode(null);
			}
			if (ppBO.getReschedIntODAmt() != null)
			{
			dueIntAmt.setAmountValue(ppBO.getReschedIntODAmt().doubleValue());
			dueIntAmt.setCurrencyCode(ppBO.getCurrency());
			}
			else{
			dueIntAmt.setAmountValue(0);
			dueIntAmt.setCurrencyCode(null);
			}
			if (ppBO.getReschedDefInterestAmt() != null)
			{
			defIntAmt.setAmountValue(ppBO.getReschedDefInterestAmt().doubleValue());
			defIntAmt.setCurrencyCode(ppBO.getCurrency());
			}
			else{
			defIntAmt.setAmountValue(0);
			defIntAmt.setCurrencyCode(null);
			}

			if (ppBO.getReschedPrinODNoOfInstall() != null)
			{
			laOvdueDefIntDtls.setNoOfPrinOvDueInstl(ppBO.getReschedPrinODNoOfInstall().longValue());
			}
			else{
			laOvdueDefIntDtls.setNoOfPrinOvDueInstl(0);
			}

			if (ppBO.getReschedIntODNoOfInstall() != null)
			{
			laOvdueDefIntDtls.setNoOfIntOvDueInstl(ppBO.getReschedIntODNoOfInstall().longValue());
			}
			else{
			laOvdueDefIntDtls.setNoOfIntOvDueInstl(0);
			}

			if (ppBO.getReschedDefIntNoOfInstall() != null)
			{
			laOvdueDefIntDtls.setNoOfDefIntInstl(ppBO.getReschedDefIntNoOfInstall().longValue());
			}
			else{
			laOvdueDefIntDtls.setNoOfDefIntInstl(0);
			}

			//Changes by savitha hardcoding
			//genLaRshdlFlowInputVO.getLoanShdlCommonParams().setNoOfDmds(genStructRepmtLL[0].getNoOfInstlmnts());
			if(ppBO.getStrField1().equals("Y"))
			{
				genLaSchmParam.setEiMethod(ppBO.getReschedEIType());
				genLaSchmParam.setEiFormulaFlg(ppBO.getEIFormula());
			}
			genLaSchmParam.setEiSchmFlg(ppBO.getStrField1());
			genLaRshdlFlowInputVO.setRescheduleMethod(ppBO.getRescheduleBy());


			/* CHANGES FOR TRACKER 89690 Start */
			genAcctRepShdlLA.setEiSchmFlg(ppBO.getStrField1());

			String loanAmount = decFormat.format((Object)ppBO.getReschedLoanAmt());


			genAcctRepShdlLA.getLoanAmount().setAmountValue(ppBO.getReschedLoanAmt().doubleValue());

			genAcctRepShdlLA.getLoanAmount().setCurrencyCode(ppBO.getCurrency());

			//ciReschdlParamDet.eiSchmFlg=getEISchemeFlag(bc, ciReschdlCritDet.getAcctNum());
//			genAcctRepShdlLA.setEiSchmFlg(getEISchemeFlag(bc, genLaAcctId.getForacid()));

			/* CHANGES FOR TRACKER 89690 End */
			//Structured Changes
			SRMCollection ppDetStruct = ppBO.getPaymentPlannerDetails();
			PaymentPlannerBO.PaymentPlannerDetails ppDetails = null;
			int iCollSize = 0;
			if ( ppDetStruct != null )
				iCollSize = ppDetStruct.size();
			if(iCollSize > 0)
			{
				genStructRepmtLL = new StructuredRepmtLL[iCollSize];
				for (int i=0; i<iCollSize; i++)
				{
					genStructRepmtLL[i] = new StructuredRepmtLL();
					ppDetails = (PaymentPlannerBO.PaymentPlannerDetails)ppDetStruct.get(i);
					if((null != ppDetails.getType())&&(ppDetails.getType().equalsIgnoreCase(Constants.STRUCTURED_REPAYMENT)))
					{
						if(null != ppDetails.getIntField1())
						{
							genStructRepmtLL[i].setNoOfInstlmnts(ppDetails.getIntField1().longValue());
						}else	genStructRepmtLL[i].setNoOfInstlmnts(0);

						//SHRUTHI
						/*Amount amt = genStructRepmtLL[i].getPrincipalAmt();
						Percent sPrct = genStructRepmtLL[i].getPrincipalPcnt();
						if(null != ppDetails.getAmountField1())
						{
							genLaAcctAdvRepmt.setTypeOfInstalment("P");
							sPrct.setValue(ppDetails.getAmountField1().doubleValue());
						}
						else{

							sPrct.setValue(0.0);
						}
						genStructRepmtLL[i].setPrincipalPcnt(sPrct);
						if(null != ppDetails.getInstallmentAmount())
						{
						if(!(ppDetails.getInstallmentAmount().equals(new Double(0.0))))
						{
							genLaAcctAdvRepmt.setTypeOfInstalment("A");
						}
							amt.setAmountValue(ppDetails.getInstallmentAmount().doubleValue());
							amt.setCurrencyCode(ppBO.getCurrency().toString());
						}
						else{
							amt.setAmountValue(0.0);
							amt.setCurrencyCode(null);
						}
						genStructRepmtLL[i].setPrincipalAmt(amt);*/
					}
				}
			}
			genRepaymentLL[0] = new GenRepaymentLL();
			MultiRecKey mKey = genRepaymentLL[0].getLlKeyElement();
			Frequency eiFreq = genRepaymentLL[0].getEiFrequency();
			Frequency intFreq = genRepaymentLL[0].getInterestFrequency();
			mKey.setSerial_num("0001");

			/*** Tracker : 122343 Start ***/
			if(null!=ppBO.getReschedNoOfInstallments()){
				genRepaymentLL[0].setNoOfDemands(ppBO.getReschedNoOfInstallments().longValue());
			}
			/*** Tracker : 122343 End ***/
            genRepaymentLL[0].setFlowStartDate(genLaShdlCmnParams.getInstlmntStartDate());
            genRepaymentLL[0].setNextIntDemandDate(genLaShdlCmnParams.getIntStartDate());
            eiFreq.setType(instlmntfreq.getType());
           	eiFreq.setWeekNum(instlmntfreq.getWeekNum());
            eiFreq.setWeekDay(instlmntfreq.getWeekDay());
            eiFreq.setStartDd(instlmntfreq.getStartDd());
            eiFreq.setHldyStat(instlmntfreq.getHldyStat());
            intFreq.setType(intfreq.getType());
            intFreq.setWeekNum(intfreq.getWeekNum());
            intFreq.setWeekDay(intfreq.getWeekDay());
            intFreq.setStartDd(intfreq.getStartDd());
            intFreq.setHldyStat(intfreq.getHldyStat());

			genRepaymentLL[0].setInterestFrequency(intFreq);
			genRepaymentLL[0].setEiFrequency(eiFreq);
			genRepaymentLL[0].setLlKeyElement(mKey);
			genlaEiParams.setHldyPerdIntFlg("N");
			genLaRshdlFlowInputVO.setRshdlAmtFlg(reshdlAmtFlg);
			genRepaymentLL[0].setFlowId(ppBO.getStrField9());
			//changes ends
			genLaAcctAdvRepmt.setOstructuredRepmtLL(genStructRepmtLL);
			genAcctRepShdlLA.setOrepaymentLL(genRepaymentLL);
			genLaBasicRshdlMsg.setLaAcct(genLaAcctId);
			genAcctRepShdlLA.setLaEiParams(genlaEiParams);
			genLaBasicRshdlMsg.setAcctRepaymentShdlLA(genAcctRepShdlLA);
			genLaShdlCmnParams.setIntFreq(intfreq);
			genLaShdlCmnParams.setInstlmntFreq(instlmntfreq);
			laOvdueDefIntDtls.setOvDuePrinAmt(duePrinAmt);
			laOvdueDefIntDtls.setOvDueIntAmt(dueIntAmt);
			laOvdueDefIntDtls.setDefIntAmt(defIntAmt);
			genLaRshdlFlowInputVO.setLaOvdueDefIntDtls(laOvdueDefIntDtls);
			genLaRshdlFlowInputVO.setLoanShdlCommonParams(genLaShdlCmnParams);
			genLaRshdlFlowInputVO.setBasicRshdlDtl(genLaBasicRshdlMsg);
			genLaRshdlFlowInputVO.setAcctAdvRepmtParamsLA(genLaAcctAdvRepmt);



		try
		{
			LoanAccountInquiryALImplementation inter = LoanAccountInquiryALImplementation.getInstance();
			laRshdlFlowOutputVO = inter.GenRshdlFlow(ciUserInfo, genLaRshdlFlowInputVO);

			genLaBasicRshdlMsgOut = laRshdlFlowOutputVO.getBasicRshdlDtl();
			genAcctRepShdlLAOut = genLaBasicRshdlMsgOut.getAcctRepaymentShdlLA();
			genRepLLOut = genAcctRepShdlLAOut.getOrepaymentLL();
			genLaRshdlFeeOut = laRshdlFlowOutputVO.getLaRshdlFeeDtl();
			//SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
				ppBO = new PaymentPlannerBO();
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
		try {
			ppBO = new PaymentPlannerBO();
			SRMCollection ppDetList = ppBO.getPaymentPlannerDetails();

			PaymentPlannerBO.PaymentPlannerDetails ppDet = null;

			for (int i = 0; i < genRepLLOut.length; i++) {

				ppDet =	(PaymentPlannerBO.PaymentPlannerDetails) ppBO.getInstance("PaymentPlannerDetails");


				ppDet.setStrField2(genRepLLOut[i].getFlowId());

				java.util.Date flowDate = genRepLLOut[i].getFlowStartDate().getTime();
				if (genRepLLOut[i].getFlowStartDate() != null && !genRepLLOut[i].getFlowStartDate().equals(""))
				{
					//ppDet.setDateField1(fDateFormat.parse(genRepLLOut[i].getFlowStartDate().toString()));
					ppDet.setDateField1(flowDate);
				}
				else {
					ppDet.setDateField1(null);
				}

				if (genRepLLOut[i].getNextIntDemandDate() != null && !genRepLLOut[i].getNextIntDemandDate().equals(""))
				{
					java.util.Date nxtDmndDate = genRepLLOut[i].getNextIntDemandDate().getTime();
					//ppDet.setDateField10(dateFormat.parse(genRepLLOut[i].getNextIntDemandDate().toString()));
					ppDet.setDateField10(nxtDmndDate);
				}
				else {
					ppDet.setDateField10(null);
				}


				if (genRepLLOut[i].getModifyAlwdFlg() != null && !genRepLLOut[i].getModifyAlwdFlg().equals("")){
					ppDet.setStrField11(genRepLLOut[i].getModifyAlwdFlg());
				}else{
					ppDet.setStrField11(null);
				}


				if (genRepLLOut[i].getDelFlg() != null && !genRepLLOut[i].getDelFlg().equals("")){
					ppDet.setStrField12(genRepLLOut[i].getDelFlg());
				}else{
					ppDet.setStrField12(null);
				}

				ppDet.setStrField3(genRepLLOut[i].getEiFrequency().getType());
				ppDet.setStrField4(genRepLLOut[i].getEiFrequency().getWeekNum());

				String eifreqwkdayll = new Long(genRepLLOut[i].getEiFrequency().getWeekDay()).toString();
				if (eifreqwkdayll != null && !eifreqwkdayll.equals(""))
				{
					ppDet.setStrField5(eifreqwkdayll);
				}
				else {
					ppDet.setStrField5(null);
				}

				Integer eifreqstartdtll =
					(new Integer((new Long(genRepLLOut[i].getEiFrequency().getStartDd()))
						.toString()));
				if (eifreqstartdtll != null && !eifreqstartdtll.equals(""))
				{
					ppDet.setIntField2(eifreqstartdtll);
				}
				else {
					ppDet.setIntField2(null);
				}
				ppDet.setStrField6(genRepLLOut[i].getEiFrequency().getHldyStat());

				Integer numinstl =
					(new Integer((new Long(genRepLLOut[i].getNoOfDemands()))
						.toString()));
				if (numinstl != null && !numinstl.equals(""))
				{
					ppDet.setIntField1(numinstl);
				}
				else {
					ppDet.setIntField1(new Integer(0));
				}

				if (genRepLLOut[i].getFlowAmt() != null && !genRepLLOut[i].getFlowAmt().equals(""))
				{
					ppDet.setAmountField2(new Double(genRepLLOut[i].getFlowAmt().getAmountValue()));
				}
				else {
					ppDet.setAmountField2(null);
				}

				if (genRepLLOut[i].getInstlmntPcnt() != null && !genRepLLOut[i].getInstlmntPcnt().equals(""))
				{
					ppDet.setAmountField3(new Double(genRepLLOut[i].getInstlmntPcnt().getValue()));
				}
				else {
					ppDet.setAmountField3(null);
				}

				ppDet.setStrField7(genRepLLOut[i].getInterestFrequency().getType());
				ppDet.setStrField8(genRepLLOut[i].getInterestFrequency().getWeekNum ());

				String intfreqwkday1 = new Long(genRepLLOut[i].getInterestFrequency().getWeekDay()).toString();
				if (intfreqwkday1 != null && !intfreqwkday1.equals("")) {
					ppDet.setStrField9(intfreqwkday1);
				}
				else {
					ppDet.setStrField9(null);
				}

				Integer intfreqstartdt1 = new Integer(new Long(genRepLLOut[i].getInterestFrequency().getStartDd()).toString());
				if (intfreqstartdt1 != null && !intfreqstartdt1.equals(""))
				{
					ppDet.setIntField3(intfreqstartdt1);
				}
				else {
					ppDet.setIntField3(null);
				}

				ppDet.setStrField10(genRepLLOut[i].getInterestFrequency().getHldyStat());
				ppDetList.add(ppDet);

			}

			if (genLaBasicRshdlMsgOut.getRshdlPrin() != null && !genLaBasicRshdlMsgOut.getRshdlPrin().equals(""))
			{
				ppBO.setReschedPrincipal(new Double(genLaBasicRshdlMsgOut.getRshdlPrin().getAmountValue()));
			}
			else {
				ppBO.setReschedPrincipal(null);
			}

			if (genLaRshdlFeeOut.getSysCalcRshdlFee() != null && !genLaRshdlFeeOut.getSysCalcRshdlFee().equals(""))
			{
				ppBO.setReschedFee(new Double(genLaRshdlFeeOut.getSysCalcRshdlFee().getAmountValue()));
			}
			else {
				ppBO.setReschedFee(null);
			}
			java.util.Date acctOpenDat = laRshdlFlowOutputVO.getLoanShdlCommonParams().getAcctOpnDate().getTime();
			if(acctOpenDat != null)
			{
				ppBO.setDateField9(acctOpenDat);
			}
			//changes by savitha for testing
			ppBO.setEIFormula(genLaSchmParam.getEiFormulaFlg());
			ppBO.setReschedNotes(laRshdlFlowOutputVO.getRshdlNotes());



		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return ppBO;
	}
	/*** Start 110899****/
	public PaymentPlannerBO generateRescheduleAmortization(SRMBusinessContext bc, PaymentPlannerBO ppBO,String accountNumber,Integer salesID)
            throws CIFatalException,SRMBOException, SRMSecurityException,
            CISInvalidArgumentException, CISConfigException,
            ClassNotFoundException, SRMBCException{



	   /*** End 110899****/
		int iCount1 =0;
		CIUserInfo ciUserInfo = new CIUserInfo();
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

		ciUserInfo.setChannelType("CRM");

		Calendar cal = Calendar.getInstance();

		int iSetNum =1;
		AmortShdlInqInputVO amortShdlInqIpVO = new AmortShdlInqInputVO();

		FIIncidentInfo objFIIncidentInfo = new FIIncidentInfo();
		String xx = String.valueOf(System.currentTimeMillis());
		objFIIncidentInfo.setDccReqRefNum(xx);

		String xy = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(new Date());
		objFIIncidentInfo.setDccReqOrigTime(xy);
		objFIIncidentInfo.setDccReqType("DEFAULTEJB");
		amortShdlInqIpVO.setFiIncidentInfo(objFIIncidentInfo);

		AmortShdlInpCriteria amortShdlInpCrit = amortShdlInqIpVO.getCriteria();
		Amount loanAmt = amortShdlInpCrit.getLoanAmount();
		Amount ovDuePrinAmt = amortShdlInpCrit.getOvDuePrinAmt();
		Amount ovDueIntAmt = amortShdlInpCrit.getOvDueIntAmt();
		Amount defIntAmt = amortShdlInpCrit.getDefIntAmt();
		CIAcctId acctId = amortShdlInpCrit.getLaAcct();

		AmortShdlInqOutputVO amortShdlInqOpVO = new AmortShdlInqOutputVO();
		AmortShdlResultLL[] resultSetLL = null;



				PaymentPlannerBO.PaymentPlannerDetails newDetails = null;
				SRMCollection ppDetailsList = ppBO.getPaymentPlannerDetails();
				 /*TrackerID 89242 Begin of Changes */
				if (ppBO.getReschedOSAmt() != null )

				{
					Double reschedOSAmt = new Double(Math.abs(ppBO.getReschedOSAmt().doubleValue()));
                    /*Enabling amount more than 8 digits.*/
                    String LoanAmount = decFormat.format((Object)reschedOSAmt);
					loanAmt.setAmountValue(new Double(LoanAmount).doubleValue());
					loanAmt.setCurrencyCode(ppBO.getCurrency());
                    /*Enabling amount more than 8 digits.*/
				}
				/*TrackerID 89242 End of Changes */
				else
				{
					loanAmt.setAmountValue(0);
					loanAmt.setCurrencyCode(null);
				}
				if (ppBO.getReschedRestFreq()!= null)
				{
					amortShdlInpCrit.setIntRestFreq(ppBO.getReschedRestFreq());
				}
				else
				{
					amortShdlInpCrit.setIntRestFreq(null);
				}
				if (ppBO.getReschedRestBasis()!= null)
				{
					amortShdlInpCrit.setIntRestBasis(ppBO.getReschedRestBasis());
				}
				else
				{
					amortShdlInpCrit.setIntRestBasis(null);
				}
				if (ppBO.getReschedPrinODAmt()!= null)
				{
					ovDuePrinAmt.setAmountValue(ppBO.getReschedPrinODAmt().doubleValue());
					ovDuePrinAmt.setCurrencyCode(ppBO.getCurrency());
				}
				else
				{
					ovDuePrinAmt.setAmountValue(0);
					ovDuePrinAmt.setCurrencyCode(null);
				}
				if (ppBO.getReschedIntODAmt()!= null)
				{
					ovDueIntAmt.setAmountValue(ppBO.getReschedIntODAmt().doubleValue());
					ovDueIntAmt.setCurrencyCode(ppBO.getCurrency());
				}else
				{
					ovDueIntAmt.setAmountValue(0);
					ovDueIntAmt.setCurrencyCode(null);
				}
				if (ppBO.getReschedDefInterestAmt()!= null)
				{
					defIntAmt.setAmountValue(ppBO.getReschedDefInterestAmt().doubleValue());
					defIntAmt.setCurrencyCode(ppBO.getCurrency());
				}else
				{
					defIntAmt.setAmountValue(0);
					defIntAmt.setCurrencyCode(null);
				}

				if (ppBO.getReschedPrinODNoOfInstall()!= null)
				{
					amortShdlInpCrit.setNoOfPrinOvDueInstl(ppBO.getReschedPrinODNoOfInstall().longValue());
				}
				else
				{
					amortShdlInpCrit.setNoOfPrinOvDueInstl(0);
				}
				if (ppBO.getReschedIntODNoOfInstall()!= null)
				{
					amortShdlInpCrit.setNoOfIntOvDueInstl(ppBO.getReschedIntODNoOfInstall().longValue());
				}
				else
				{
					amortShdlInpCrit.setNoOfIntOvDueInstl(0);
				}
				if (ppBO.getReschedDefIntNoOfInstall()!= null)
				{
					amortShdlInpCrit.setNoOfDefIntInstl(ppBO.getReschedDefIntNoOfInstall().longValue());
				}
				else
				{
					amortShdlInpCrit.setNoOfDefIntInstl(0);
				}

				if (ppBO.getReschedInstallmentsStartDate()!= null)
				{
					cal.setTime(ppBO.getReschedInstallmentsStartDate());
					amortShdlInqIpVO.setRepShdlDate(cal);
				}
                //Modified for Amort Calc generation for Schedule Balance interest Product Method.
                /*TICKET ID : 156201 Changes Begins*/
                //ciLaAmortInput.setOverrideLSBTRecFlg("Y");
                /*TICKET ID : 156201 Changes Ends*/
                amortShdlInpCrit.setOverrideLSBTRecFlg("Y");
				amortShdlInpCrit.setEiSchmFlg(ppBO.getStrField1());
				acctId.setForacid(accountNumber);

				 iCount1 = ppDetailsList.size();
			RepaymentLinkedList[] repaymentLL = new RepaymentLinkedList[iCount1];
			for (int iCount = 0; iCount < iCount1 ; iCount ++)
			{
				repaymentLL[iCount] = new RepaymentLinkedList();
				newDetails = (PaymentPlannerBO.PaymentPlannerDetails) ppDetailsList.get (iCount);
				repaymentLL[iCount].getLlKeyElement().setSerial_num(""+(iCount+1));

				if(newDetails.getStrField2() != null){
				repaymentLL[iCount].setFlowId(newDetails.getStrField2());
				}


				if(newDetails.getDateField1() != null){
                	cal.setTime(newDetails.getDateField1());
                	String dtFormat = new java.text.SimpleDateFormat("dd-MM-yyyy").format(newDetails.getDateField1());
                	repaymentLL[iCount].setFlowStartDate(dtFormat);
				}

				if((newDetails.getAmountField2() != null) ){
                    String strFlowAmount = decFormat.format(newDetails.getAmountField2());
					//ciRepaymentLL[iCount].setFlowAmt(strFlowAmount + "|" + ppBO.getCurrency());
					repaymentLL[iCount].getFlowAmt().setAmountValue(new Double(strFlowAmount).doubleValue());
					repaymentLL[iCount].getFlowAmt().setCurrencyCode(ppBO.getCurrency());
				}
				if(newDetails.getAmountField3() != null){
				repaymentLL[iCount].getInstlmntPcnt().setValue(newDetails.getAmountField3().doubleValue());
				}

				if(newDetails.getIntField1() != null){
				FINumber fin = repaymentLL[iCount].getActualNoOfFlows();
				fin.setValue(newDetails.getIntField1().doubleValue());
				repaymentLL[iCount].setActualNoOfFlows(fin);
				}

				if(ppBO.getReschedInterestStartDate() != null){
					cal.setTime(ppBO.getReschedInterestStartDate());
					repaymentLL[iCount].setNextIntDemandDate(ppBO.getReschedInterestStartDate().toString());
				}

				if(newDetails.getStrField3() != null){
				repaymentLL[iCount].getEiFrequency().setType(newDetails.getStrField3());
				}

				if(newDetails.getStrField4() != null){
				repaymentLL[iCount].getEiFrequency().setWeekNum(newDetails.getStrField4());
				}

				if(newDetails.getStrField5() != null){
				repaymentLL[iCount].getEiFrequency().setWeekDay(new Double(newDetails.getStrField5()).longValue());
				}

				if(newDetails.getIntField2() != null){
				repaymentLL[iCount].getEiFrequency().setStartDd(newDetails.getIntField2().longValue());
				}

				if(newDetails.getStrField6() != null){
				repaymentLL[iCount].getEiFrequency().setHldyStat(newDetails.getStrField6());
				}

				if(newDetails.getStrField7() != null){
				repaymentLL[iCount].getInterestFrequency().setType(newDetails.getStrField7());
				}

				if(newDetails.getStrField8() != null){
				repaymentLL[iCount].getInterestFrequency().setWeekNum(newDetails.getStrField8());
				}
				if(newDetails.getStrField9() != null && !(newDetails.getStrField9().equals(""))){
				repaymentLL[iCount].getInterestFrequency().setWeekDay(new Double(newDetails.getStrField9()).longValue());
				}
				if( null != newDetails.getIntField3() ) {
				repaymentLL[iCount].getInterestFrequency().setStartDd(newDetails.getIntField3().longValue());
				}

				if(newDetails.getStrField10() != null){
				repaymentLL[iCount].getInterestFrequency().setHldyStat(newDetails.getStrField6());
				}
				repaymentLL[iCount].setNoOfDemands(newDetails.getIntField1().longValue());
				repaymentLL[iCount].setFlowAmt(repaymentLL[iCount].getFlowAmt());
				repaymentLL[iCount].setInstlmntPcnt(repaymentLL[iCount].getInstlmntPcnt());
				repaymentLL[iCount].setEiFrequency(repaymentLL[iCount].getEiFrequency());
				repaymentLL[iCount].setInterestFrequency(repaymentLL[iCount].getInterestFrequency());

				ppDetailsList.add(newDetails);
			}
				if(ppBO.getStrField1().equals("Y"))
       			{
					amortShdlInqIpVO.getCriteria().setEiType(ppBO.getReschedEIType());
					amortShdlInqIpVO.getCriteria().setEiFormulaFlg(ppBO.getEIFormula());
				}
				amortShdlInqIpVO.getCriteria().getLoanAmount().setAmountValue(ppBO.getReschedLoanAmt().doubleValue());
				amortShdlInqIpVO.getCriteria().getLoanAmount().setCurrencyCode(ppBO.getCurrency());

			Calendar cal3 = Calendar.getInstance();
			cal3.setTime(ppBO.getDateField9());
			String dtFormat = new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(ppBO.getDateField9());
			amortShdlInqIpVO.getCriteria().setAcctOpnDate(dtFormat);

			amortShdlInpCrit.setLoanAmount(loanAmt);
			amortShdlInpCrit.setOvDuePrinAmt(ovDuePrinAmt);
			amortShdlInpCrit.setOvDueIntAmt(ovDueIntAmt);
			amortShdlInpCrit.setDefIntAmt(defIntAmt);
			amortShdlInpCrit.setLaAcct(acctId);
			amortShdlInpCrit.setOrepaymentInLL(repaymentLL);
			amortShdlInqIpVO.setCriteria(amortShdlInpCrit);
	   /*** Start 110899****/
		try {
			LoanAccountInquiryALImplementation inter = LoanAccountInquiryALImplementation.getInstance();
			amortShdlInqOpVO = inter.calculateAmortShdl(ciUserInfo, amortShdlInqIpVO);

			resultSetLL = amortShdlInqOpVO.getOoutLL();


            /*Enhancement Changes for Compatibility with Core 91*/
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

			try{
				logError(confe, salesID, bc);
			}catch(Exception ex){}
			confe.printStackTrace();
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

			e.printStackTrace();
			throw new CIFatalException(
			"Runtime errror occured during EISchedule. Please refer to server log",e);
		}
		/*** End 110899****/
		try {
			ppBO = new PaymentPlannerBO();
			SRMCollection ppDetList = ppBO.getPaymentPlannerDetails();

			PaymentPlannerBO.PaymentPlannerDetails ppDet = null;

			for (int i = 0; i < resultSetLL.length; i++) {
				ppDet = (PaymentPlannerBO.PaymentPlannerDetails) ppBO.getInstance("PaymentPlannerDetails");
				ppDet.setStrField2(resultSetLL[i].getKey().getSerial_num());

				ppDet.setStrField1(resultSetLL[i].getKey().getSerial_num());
				/*TICKET ID : 156323 BEGIN OF CHANGES*/
                /*Modified the Serial Number to Flow Desc for presenting in UI*/
                ppDet.setStrField2(resultSetLL[i].getAmortShdlDtls().getFlowDesc());
                /*TICKET ID : 156323 END OF CHANGES*/

				if (resultSetLL[i].getAmortShdlDtls().getFlowDate() != null && !resultSetLL[i].getAmortShdlDtls().getFlowDate().equals(""))
				{
					ppDet.setDateField1(
						dateFormat.parse(resultSetLL[i].getAmortShdlDtls().getFlowDate()));


				}
				else {
					ppDet.setDateField1(null);
				}


				if (resultSetLL[i].getAmortShdlDtls().getInstlAmt() != null && !resultSetLL[i].getAmortShdlDtls().getInstlAmt().equals(""))
				{
					ppDet.setAmountField1(new Double(resultSetLL[i].getAmortShdlDtls().getInstlAmt().getAmountValue()));
				}
				else {
					ppDet.setAmountField1(null);
				}

				if (resultSetLL[i].getAmortShdlDtls().getPrincAmt() != null && !resultSetLL[i].getAmortShdlDtls().getPrincAmt().equals(""))
				{
					ppDet.setAmountField2(new Double(resultSetLL[i].getAmortShdlDtls().getPrincAmt().getAmountValue()));				}
				else {
					ppDet.setAmountField2(null);
				}

				if (resultSetLL[i].getAmortShdlDtls().getIntAmt() != null && !resultSetLL[i].getAmortShdlDtls().getIntAmt().equals(""))
				{
					ppDet.setAmountField3(new Double(resultSetLL[i].getAmortShdlDtls().getIntAmt().getAmountValue()));
				}
				else {
					ppDet.setAmountField3(null);
				}

				if (resultSetLL[i].getAmortShdlDtls().getCummPrincAmt() != null && !resultSetLL[i].getAmortShdlDtls().getCummPrincAmt().equals(""))
				{
					ppDet.setAmountField4(new Double(resultSetLL[i].getAmortShdlDtls().getCummPrincAmt().getAmountValue()));
				}
				else {
					ppDet.setAmountField4(null);
				}

				if (resultSetLL[i].getAmortShdlDtls().getCummIntAmt() != null && !resultSetLL[i].getAmortShdlDtls().getCummIntAmt().equals(""))
				{
					ppDet.setAmountField5(new Double(resultSetLL[i].getAmortShdlDtls().getCummIntAmt().getAmountValue()));

				}
				else {
					ppDet.setAmountField5(null);
				}

				ppDetList.add(ppDet);

			}

		} catch (Exception ex) {
		}
		return ppBO;
	}

       private static String formatDate(String dtJdbcDate){
		String strResultDate = "";
		if( null != dtJdbcDate){
			String strJdbcDate = dtJdbcDate.toString().trim();
			String yyyy = strJdbcDate.substring(0, 4);
			String mm = strJdbcDate.substring(5, 7);
			String dd = strJdbcDate.substring(8, 10);

			strResultDate = dd + "-" + mm + "-" + yyyy;
		}
		return strResultDate;
	}

	//Function to get the DateTime format compatible with the FI call
	public static String getDateFormatforFIServReq (){
		String DateFormat= "";
		String DateFormat1= "";
		 try
			{

				//oProp = PropertyFileManager.getPropFile("WF_fldnm.properties","01");
				//DateFormat = new java.text.SimpleDateFormat("MM-dd-yyyy HH:MM:ss.ms").format(new Date());
				DateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(new Date());

				DateFormat1 = DateFormat.replace(' ','T');

	 }
		 catch(Exception e)
				{

			}

	return DateFormat1;
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
				InstanceOfSales_Status_History_Y.setBriefDesc(strErrMsg);
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
	  /*** End 110899****/
	}

	/*public String getEISchemeFlag(SRMBusinessContext bc, String accountNumber) throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException{
		String strEiFlag = "";
		String strProductsKey = "";

		SRMQueryBuilder qb = new SRMQueryBuilder();
		ArrayList obj = new ArrayList();
		qb = QueryAssist.singleObjectQuery("SaleBO", SaleBO.SALESID);
		QueryAssist.addSimpleCondition(qb,"SaleBO",SaleBO.ACCOUNTNUMBER,IQuery.ComparisonOperation_EQ,accountNumber);
		qb.addAttribScope(QueryAssist.getTransformFn("SaleBO", SaleBO.PRODUCTSKEY));
		SRMQueryResult qr = qb.runQuery(bc, -1);
		SRMRecordSet rs = qr.getRecordSet();
		if(rs.hasNext()){
			obj = (ArrayList) rs.getNext();
			strProductsKey = (String)obj.get(0);
		}

		qb = QueryAssist.singleObjectQuery("SaleBackEndBO", ProductBO.PRODUCTID);
		QueryAssist.addSimpleCondition(qb,"ProductBO",ProductBO.PRODUCTSKEY,IQuery.ComparisonOperation_EQ,"" + strProductsKey);
		qb.addAttribScope(QueryAssist.getTransformFn("ProductBO", ProductBO.PRODUCTCURRENCY_EIFLAG));
		qr = qb.runQuery(bc, -1);
		rs = qr.getRecordSet();

		if (rs.hasNext()) {
			obj = (ArrayList) rs.getNext();
			strEiFlag = (String) obj.get(0);
		}

		return strEiFlag;
	}*/
}





