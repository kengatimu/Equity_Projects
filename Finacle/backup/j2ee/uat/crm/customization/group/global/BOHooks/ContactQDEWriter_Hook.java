/**********************************************************************************
 * Copyright (c) 2000-2006 Infosys Ltd.  All rights reserved.
 *
 * $Workfile	: ContactQDEWriter_Hook.java
 *
 * Author		: Arun CP
 *
 * $Archive		: /CRM100/com/infy/cis/custom/ContactQDEWriter_Hook.java $
 *
 * $History		: ContactQDEWriter_Hook.java $
 *
 * Created Date	:
 *
 * Description 	: The hook file will be customizable and will be called from writer file for entities in workflow mode which in turn will make a call to SendToPEAS.
 *
 **********************************************************************************/

package com.infy.cis.custom;

import com.infosys.insulate.util.HashMap;
import com.infy.cis.adaptor.web.WebAdaptor;

import com.infy.cis.exception.WriterHookException;
import com.infy.cis.srmbo.ContactBO;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.ui.common.SendToPEAS;

public class ContactQDEWriter_Hook {
	public static void callContQDEWriter_Hook(HashMap HookParams, SRMBusinessContext bc) throws Exception {
		try {

			String strIntWFID 				= "";
			ContactBO ContBO = (ContactBO)(HookParams.get("ContactBO"));
			HashMap hCallPEASparams = new HashMap();
			if (ContBO != null) {
				strIntWFID = ContBO.getIntWFID().toString();
				hCallPEASparams.put("CIFID",ContBO.getContactsKey());
				hCallPEASparams.put("CIFTYPE","Contact");
			}

			try {
				SendToPEAS.callSendToPEAS(hCallPEASparams, strIntWFID, bc);
			}
			catch (Exception e) {
				throw new WriterHookException("MSGEXC0206","Call to PEAS failed");
			}

			return;
		} catch(WriterHookException whe) {
			WebAdaptor.log(com.infy.cis.log.LogType.PANIC, "ContactQDEWriter_Hook : WriterHookException"+whe);
			throw new WriterHookException("MSGEXC0206","WriterHookException in ContactQDEWriter_Hook.callContQDEWriter_Hook "+whe);
		} catch(Exception e) {
			throw new WriterHookException("MSGEXC0201","Error in ContactQDEWriter_Hook.callContQDEWriter_Hook "+e);
		}
	}
}
