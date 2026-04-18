/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CustomerWriterHook.java $
 *
 * Author:    Mathew Stephen
 *
 * $Archive:

 * $History:  CustomerWriterHook.java $
 *
 *****************************************************************************/

package com.infy.cis.custom;

import com.infosys.insulate.util.HashMap;

import com.infy.cis.adaptor.web.WebAdaptor;
import com.infy.cis.exception.WriterHookException;
import com.infy.cis.srmbo.AccountBO;
import com.infy.cis.srmbo.DemographicBO;
import com.infy.cis.srmbo.PsychographicBO;
import com.infy.cis.srmbo.TradeFinanceBO;
import com.infy.cis.srmbo.CoreInterfaceBO;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;


/**
* @semantics CustomerWriterHook - Hook file to be called in case of 'Workflow' after
*                                     creating a customer
* @author    Mathew Stephen
* @see n/a
*/

public class CustomerWriterHook {
	/**
		* @semantics 	    callFItoCore - Calls PEAS and passes CIFID & CIFTYPE *           	    to it
		* @param objParams	HashMap object
		* @param bc	        SRMBusinessContext object
		* @return 		    none
		* @throws 		    WriterHookException
		* @throws 		    Exception
		* @see			    n/a
	*/
	public static void callFItoCore(HashMap objParams, SRMBusinessContext bc) throws WriterHookException,Exception {
		try {
			AccountBO AcctBO = (AccountBO)(objParams.get("AccountBO"));
			DemographicBO DemoBO = (DemographicBO)(objParams.get("DemographicBO"));
			PsychographicBO PsychoBO = (PsychographicBO)(objParams.get("PsychographicBO"));
			TradeFinanceBO TFBO = (TradeFinanceBO)(objParams.get("TradeFinanceBO"));
			CoreInterfaceBO CoreBO = (CoreInterfaceBO)(objParams.get("CoreInterfaceBO"));

		} catch(Exception e) {
			e.printStackTrace();
			WebAdaptor.log(com.infy.cis.log.LogType.PANIC, "CustomerWriterHook : Exception"+e);
		}
	}
	//comments
}

