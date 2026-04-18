/******************************************************************************
 * Copyright (c) 2008-2009 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: ComputeLoanFee.java $
 *
 * Author: Balaji B.K
 *
 * $Archive: com/infy/cis/custom/ComputeLoanFee.java $
 *
 * $History: ComputeLoanFee.java $
 *
 *****************************************************************************/
package com.infy.cis.custom;

import com.infosys.bankaway.accesslayer.bwyinterface.LoanAccountInquiryALImplementation;
import com.infosys.ci.common.Amount;
import com.infosys.ci.common.CIFatalException;
import com.infosys.ci.common.CINonFatalException;
import com.infosys.ci.common.CIUserInfo;
import com.infosys.ci.common.FIIncidentInfo;
import com.infosys.ci.ons.cistruct.CICustId;
import com.infosys.ci.ons.cistruct.CILAGetChrgDet;
import com.infosys.ci.ons.cistruct.Charge;
import com.infosys.ci.ons.cistruct.ChargeDet;
import com.infosys.ci.ons.cistruct.ChargeLL;
import com.infosys.ci.ons.cistruct.MultiRecKey;
import com.infosys.ci.ons.cistruct.SchmCode;
import com.infosys.ci.ons.common.CIOnsNonFatalException;
import com.infy.cis.common.ARMTransHelper;
import com.infy.cis.exception.SRMTypeValidatorException;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.SaleBackEndBO;
import java.util.Date;
import java.util.List;
/**
    *Brief Description of class:
    *
    *Functionality: This file return FEES Amount by calling FI service getChrgDet
    *
    *
**/
public final class ComputeLoanFee
{
	public ComputeLoanFee()
	{
	}
	public SaleBackEndBO getFeeDetails(final SaleBackEndBO saleBackEndBO, final List params)
		throws CIFatalException,CINonFatalException,SRMTypeValidatorException,CIOnsNonFatalException
	{
		//setJVMArguments();
		CIUserInfo ciUserInfo = new CIUserInfo();

		final String sProdCode = (String)params.get(0);
		final String sCcyCode = (String)params.get(1);
		final String sCifID = (String)params.get(2);
		final Double dAmtSought = (Double)params.get(3);

		ChargeDet chargeDet = new ChargeDet();
		// Impl file instance
		LoanAccountInquiryALImplementation ciRAI = new LoanAccountInquiryALImplementation();
			SRMCollection saleFee = saleBackEndBO.getSaleFeeDetails();
			SchmCode schmCode = new SchmCode();
			schmCode.setSchmCode(sProdCode.trim());//Setting Products Key
			SaleBackEndBO.SaleFeeDetails feeDet = null;
			//ChargeLL Array
			ChargeLL[] chrgArrLL = new ChargeLL[saleFee.size()];
			//Setting Values to ChargeArrLL structure
			for (int i=0; i<saleFee.size() ;i++ )
			{
				feeDet = (SaleBackEndBO.SaleFeeDetails)saleFee.get(i);
				chrgArrLL[i] = new ChargeLL();
				Charge chg = chrgArrLL[i].getEventType();
				MultiRecKey mulKey =  chrgArrLL[i].getMultiKey();
				chg.setChargeType(feeDet.getChargeType());
				String strno=  new Long(i+1).toString();
				mulKey.setSerial_num(strno.trim());
				chrgArrLL[i].setMultiKey(mulKey);
				chrgArrLL[i].setEventId(feeDet.getChargeEventId());
				chrgArrLL[i].setEventType(chg);
			}
			CICustId custID = new CICustId();
			custID.setCifId(sCifID.trim());
			Amount amt = new Amount();
			amt.setAmountValue(dAmtSought);
			amt.setCurrencyCode(sCcyCode.trim());
			//Setting Values to ChargeDet
			chargeDet.setChargeLL(chrgArrLL);
			chargeDet.setCrncyCode(sCcyCode.trim());//Setting Product Currency
			chargeDet.setSchmCode(schmCode);
			chargeDet.setCifId(custID);
			chargeDet.setLoanAmt(amt);
			CILAGetChrgDet chrg = new CILAGetChrgDet();
			//*** FI CALL ***
			// Setting Correlator ID for forced sub-trans in core
			byte[] bCorrelatorID=ARMTransHelper.getCorrelator();
			ciUserInfo.setCorrelationId(bCorrelatorID);

			ciUserInfo.setChannelType("CRM");
			FIIncidentInfo objFIIncidentInfo = new FIIncidentInfo();
			String strxx = String.valueOf(System.currentTimeMillis());
			//Setting Values to objFIIncidentInfo
			objFIIncidentInfo.setDccReqRefNum(strxx.trim());
			//String strxy = new java.text.SimpleDateFormat("MM-dd-yyyy HH:MM:ss.ms").format(new Date());
			String strxy = new java.text.SimpleDateFormat(com.infosys.ci.common.CIConstants.DATETIMEFORMAT_REQUESTMESSAGEDATETIME).format(new Date());

			objFIIncidentInfo.setDccReqOrigTime(strxy.trim());
			objFIIncidentInfo.setDccReqType("DEFAULTEJB");
			//Setting Values to CiUserInfo
			/*Start of changes for Tracker Id:193542 */
			//ciUserInfo.setDccReqVersion("VER1");
			/*End of changes for Tracker Id:193542 */
			ciUserInfo.setAccessChannelId("CRM");
			ciUserInfo.setUserId("FIVUSR");
			chargeDet.setFiIncidentInfo(objFIIncidentInfo);
			String strbankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();
			if( strbankID != null || !strbankID.equalsIgnoreCase("")){
				ciUserInfo.setBankId(strbankID.trim());
			}
			else{
				ciUserInfo.setBankId("01");
			}
			if(chrgArrLL.length>0){
			chrg   = ciRAI.getChrgDet(ciUserInfo, chargeDet);
			//ChargeLL Array
			ChargeLL[] chrgLL = chrg.getChargeLL();
			SaleBackEndBO.SaleFeeDetails feeDetails = null;
			//Getting Values from ChargeLL structure
			for(int i=0; i<saleFee.size(); i++){
				feeDetails = (SaleBackEndBO.SaleFeeDetails) saleFee.get(i);
				for(int j=0; j<chrgLL.length; j++){
					if(feeDetails.getChargeType().equalsIgnoreCase((chrgLL[j].getEventType().getChargeType()))){
						feeDetails.setChargeAmt((chrgLL[j].getChargeAmt().getAmountValue()));
						// Setting Fee amount to SaleFeeDetails
						break;
					}
				}
			}
	      }
			return saleBackEndBO;
	}
}
