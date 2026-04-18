/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: QDECustomerWriter_Hook.java $
 *
 * Author:    Arun Kumar C.P.
 *
 * $Archive:

 * $History:  QDECustomerWriter_Hook.java $
 *
 *****************************************************************************/

package com.infy.cis.custom;

import com.infosys.insulate.util.HashMap;

import com.infy.cis.adaptor.web.WebAdaptor;
import com.infy.cis.exception.WriterHookException;
import com.infy.cis.srmbo.AccountBO;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.ui.common.SendToPEAS;


/**
* @semantics QDECustomerWriter_Hook - Hook file to be called in case of 'Workflow' after
*                                     creating a customer
* @author    Arun Kumar C.P.
* @see n/a
*/

public class QDECustomerWriter_Hook {
	/**
		* @semantics 	    callQDECustWriter_Hook - Calls PEAS and passes CIFID & CIFTYPE *           	    to it
		* @param HookParams	HashMap object
		* @param bc	        SRMBusinessContext object
		* @return 		    none
		* @throws 		    WriterHookException
		* @throws 		    Exception
		* @see			    n/a
	*/
	public static void callQDECustWriter_Hook(HashMap HookParams, SRMBusinessContext bc) throws WriterHookException,Exception {
		try {
			String strIntWFID 				= "";
			AccountBO AcctBO = (AccountBO)(HookParams.get("AccountBO"));
			HashMap hCallPEASparams = new HashMap();
			if (AcctBO != null) {
				strIntWFID = AcctBO.getIntWFID().toString();
				hCallPEASparams.put("CIFID",AcctBO.getAccountKey());
				hCallPEASparams.put("CIFTYPE","Customer");
			}
			try {
				SendToPEAS.callSendToPEAS(hCallPEASparams, strIntWFID, bc);
			}
			catch (Exception e) {
				throw new WriterHookException("MSGEXC0206","Call to PEAS failed");
			}

			return;
		} catch(WriterHookException whe) {
			WebAdaptor.log(com.infy.cis.log.LogType.PANIC, "QDECustomerWriter_Hook : Exception"+whe);
			throw new WriterHookException("MSGEXC0206","Error in QDECustomerWriter_Hook.callQDECustWriter_Hook "+whe);
		} catch(Exception e) {
			WebAdaptor.log(com.infy.cis.log.LogType.PANIC, "QDECustomerWriter_Hook : Exception"+e);
		}
	}
}
