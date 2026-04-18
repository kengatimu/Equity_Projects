/******************************************************************************
* Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
*
* $Workfile: QDEProspectWriter_Hook.java $
*
* Author:    Arun Kumar C.P.
*
* $Archive:

* $History:  QDEProspectWriter_Hook.java $
*
*****************************************************************************/

package com.infy.cis.custom;

import com.infosys.insulate.util.HashMap;

import com.infy.cis.adaptor.web.WebAdaptor;
import com.infy.cis.exception.WriterHookException;
import com.infy.cis.srmbo.SuspectBO;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.ui.common.SendToPEAS;

/**
* @semantics QDEProspectWriter_Hook - Hook file to be called in case of 'Workflow' after
*                                     creating a Prospect
* @author    Arun Kumar C.P.
* @see n/a
*/

public class QDEProspectWriter_Hook {
	/**
		* @semantics 	    callQDEProspWriter_Hook - Calls PEAS and passes CIFID &
		*           	    CIFTYPE to it
		* @param HookParams	HashMap object
		* @param bc	        SRMBusinessContext object
		* @return 		    none
		* @throws 		    WriterHookException
		* @throws 		    Exception
		* @see			    n/a
	*/
	public static void callQDEProspWriter_Hook(HashMap HookParams, SRMBusinessContext bc) throws WriterHookException,Exception {
		try {
			String strIntWFID 				= "";
			SuspectBO SuspBO = (SuspectBO)(HookParams.get("SuspectBO"));
			HashMap hCallPEASparams = new HashMap();
			if (SuspBO != null) {
				strIntWFID = SuspBO.getIntWFID().toString();
				hCallPEASparams.put("CIFID",SuspBO.getSuspectsKey());
				hCallPEASparams.put("CIFTYPE","Suspect");
			}

			try {
				SendToPEAS.callSendToPEAS(hCallPEASparams, strIntWFID, bc);
			}
			catch (Exception e) {
				throw new WriterHookException("MSGEXC0206","Call to PEAS failed");
			}


			return;
		}  catch(WriterHookException whe) {
			WebAdaptor.log(com.infy.cis.log.LogType.PANIC, "QDEProspectWriter_Hook : Exception"+whe);
			throw new WriterHookException("MSGEXC0206","Error in QDEProspectWriter_Hook.callQDEProspWriter_Hook "+whe);
		} catch(Exception e) {
			WebAdaptor.log(com.infy.cis.log.LogType.PANIC, "QDEProspectWriter_Hook : Exception"+e);
		}
	}
}
