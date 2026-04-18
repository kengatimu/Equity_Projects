/******************************************************************************
* Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
*
* $Workfile: QDECorpEntityWriter_Hook.java $
*
* Author:    Arun Kumar C.P.
*
* $Archive:

* $History:  QDECorpEntityWriter_Hook.java $
*
*****************************************************************************/
package com.infy.cis.custom;

import com.infosys.insulate.util.HashMap;

import com.infy.cis.adaptor.web.WebAdaptor;
import com.infy.cis.exception.WriterHookException;
import com.infy.cis.srmbo.CorporateBO;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.ui.common.SendToPEAS;

/**
* @semantics QDECorpEntityWriter_Hook - Hook file to be called in case of 'Workflow' after
*                                     creating a Corporate Entity
* @author    Arun Kumar C.P.
* @see n/a
*/
public class QDECorpEntityWriter_Hook {
	/**
	* @semantics 	    callQDECorpWriter_Hook - Calls PEAS and passes CIFID &
	*           	    CIFTYPE to it
	* @param HookParams	HashMap object
	* @param bc	        SRMBusinessContext object
	* @return 		    none
	* @throws 		    WriterHookException
	* @throws 		    Exception
	* @see			    n/a
	*/
	public static void callQDECorpWriter_Hook(HashMap HookParams, SRMBusinessContext bc) throws WriterHookException,Exception {
		try {
			String strIntWFID = "";
			CorporateBO CorpBO = (CorporateBO)(HookParams.get("CorporateBO"));
			HashMap hCallPEASparams = new HashMap();
			if (CorpBO != null) {
				strIntWFID = CorpBO.getIntWFID().toString();
				hCallPEASparams.put("CIFID",CorpBO.getCorp_Key());
				if (CorpBO.getEntity_Type().equals("Customer")) {
					hCallPEASparams.put("CIFTYPE","Corp_Customer");
				}else if (CorpBO.getEntity_Type().equals("Prospect")) {
					hCallPEASparams.put("CIFTYPE","Corp_Prospect");
				}else if (CorpBO.getEntity_Type().equals("NonCustomer")) {
					hCallPEASparams.put("CIFTYPE","Corp_Non_Customer");
				}
			}

			try {
				SendToPEAS.callSendToPEAS(hCallPEASparams, strIntWFID, bc);
			}
			catch (Exception e) {
				throw new WriterHookException("MSGEXC0206","Call to PEAS failed");
			}

			return;
		} catch(WriterHookException whe) {
			WebAdaptor.log(com.infy.cis.log.LogType.PANIC, "QDECorpEntityWriter_Hook : Exception"+whe);
			throw new WriterHookException("MSGEXC0206","Error in QDECorpEntityWriter_Hook.callQDECorpWriter_Hook "+whe);
		} catch(Exception e) {
			WebAdaptor.log(com.infy.cis.log.LogType.PANIC, "QDECorpEntityWriter_Hook : Exception"+e);
		}
	}
}
