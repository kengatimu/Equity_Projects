/******************************************************************************
* Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
*
* $Workfile: NonCustWriter_Hook.java $
*
* Author:    Arun Kumar C.P.
*
* $Archive:

* $History:  NonCustWriter_Hook.java $
*
*****************************************************************************/
package com.infy.cis.custom;

import com.infosys.insulate.util.HashMap;

import com.infy.cis.adaptor.web.WebAdaptor;
import com.infy.cis.exception.WriterHookException;
import com.infy.cis.srmbo.NonCustomerModBO;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.ui.common.SendToPEAS;

/**
* @semantics NonCustWriter_Hook - Hook file to be called in case of 'Workflow' after
*                                     creating a Non Customer
* @author    Arun Kumar C.P.
* @see n/a
*/
public class NonCustWriter_Hook {
	/**
	* @semantics 	    callNonCustWriter_Hook - Calls PEAS and passes CIFID &
	*           	    CIFTYPE to it
	* @param HookParams	HashMap object
	* @param bc	        SRMBusinessContext object
	* @return 		    none
	* @throws 		    WriterHookException
	* @throws 		    Exception
	* @see			    n/a
	*/
	public static void callNonCustWriter_Hook(HashMap HookParams, SRMBusinessContext bc) throws WriterHookException, Exception {
		try {
			String strIntWFID 				= "";
			NonCustomerModBO NonCustModBO = (NonCustomerModBO)(HookParams.get("NonCustomerModBO"));
			HashMap hCallPEASparams = new HashMap();
			if (NonCustModBO != null) {
				strIntWFID = NonCustModBO.getIntWFID().toString();
				hCallPEASparams.put("CIFID",NonCustModBO.getOrgKey());
				hCallPEASparams.put("CIFTYPE","Non_Customers_Mod");
			}

			try {
				SendToPEAS.callSendToPEAS(hCallPEASparams, strIntWFID, bc);
			}
			catch (Exception e) {
				throw new WriterHookException("MSGEXC0206","Call to PEAS failed");
			}

			return;
		} catch(WriterHookException whe) {
			WebAdaptor.log(com.infy.cis.log.LogType.PANIC, "NonCustWriter_Hook : WriterHookException "+whe);
			throw new WriterHookException("MSGEXC0206","Error in NonCustWriter_Hook.callNonCustWriter_Hook "+whe);
		} catch(Exception e) {
			WebAdaptor.log(com.infy.cis.log.LogType.PANIC, "NonCustWriter_Hook : Exception"+e);
			throw new WriterHookException("MSGEXC0201","Error in NonCustWriter_Hook.callNonCustWriter_Hook "+e);
		}
	}
}
