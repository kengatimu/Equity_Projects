/**********************************************************************************
 * Copyright (c) 2000-2006 Infosys Ltd.  All rights reserved.
 *
 * $Workfile	: EntitySearch360_Hook.java
 *
 * Author		: Arun CP
 *
 * $Archive		: /CRM100/com/infy/cis/custom/EntitySearch360_Hook.java $
 *
 * $History		: EntitySearch360_Hook.java $
 *
 * Created Date	:
 *
 * Description 	: The hook file will be customizable and will be called from genric results file for entities in workflow mode which in turn will make a call to SendToPEAS.
 *
 **********************************************************************************/


package com.infy.cis.custom;

import com.infosys.insulate.util.ArrayList;
import com.infosys.insulate.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;


import com.infy.cis.adaptor.web.WebAdaptor;
import com.infy.cis.exception.WriterHookException;
import com.infy.cis.srmbo.IQuery;
import com.infy.cis.srmbo.WFlowBO;
import com.infy.cis.ui.common.SendToPEAS;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.srmbo.SRMURLResolver;
import com.infy.cis.srmbo.SRMQueryBuilder;
import com.infy.cis.srmbo.SRMQueryResult;
import com.infy.cis.srmbo.SRMRecordSet;
import com.infy.cis.ui.common.QueryAssist;
import com.infy.cis.ui.common.Utils;

public class EntitySearch360_Hook {

	public static void call360EntitySearch_Hook(HashMap HookParams, SRMBusinessContext bc) throws Exception {
		try {
			WFlowBO wflBO = null;
			String sBOName = HookParams.get("BOName").toString();

			String strIntWFID = HookParams.get("IntWFID").toString();
			List attr = new ArrayList();
			SRMQueryBuilder qrybld = QueryAssist.singleObjectQuery("WFlowBO", WFlowBO.INTWFLOWID);
			QueryAssist.addSimpleCondition(qrybld, "WFlowBO", WFlowBO.INTWFLOWID, IQuery.ComparisonOperation_EQ, strIntWFID);
			SRMQueryResult qryres = qrybld.runQuery(bc, -1);
			SRMRecordSet   resset = qryres.getRecordSet();
			if (resset.hasNext()) {
				wflBO = (WFlowBO)resset.getNext().get(0);
			}

			HashMap hCallPEASparams = new HashMap();
			if (sBOName.equals("AccountBO")) {
				hCallPEASparams.put("CIFID",wflBO.getEntityID());
				hCallPEASparams.put("CIFTYPE","Customer");

			}
			else if (sBOName.equals("ContactBO")) {
				hCallPEASparams.put("CIFID",wflBO.getEntityID());
				hCallPEASparams.put("CIFTYPE","Contact");
			}
			else if (sBOName.equals("SuspectBO")) {
				hCallPEASparams.put("CIFID",wflBO.getEntityID());
				hCallPEASparams.put("CIFTYPE","Prospect");
			}
			else if (sBOName.equals("NonCustomerBO")) {
				hCallPEASparams.put("CIFID",wflBO.getEntityID());
				hCallPEASparams.put("CIFTYPE","Non_Customer");
			}

			if ((!strIntWFID.equals("null"))&&(!strIntWFID.equals(""))) {
				try {
					SendToPEAS.callSendToPEAS(hCallPEASparams, strIntWFID, bc);
				}
				catch (Exception e) {
					throw new WriterHookException("MSGEXC0206","Call to PEAS failed");
				}
			}

			return;
		} catch (Exception e) {
			throw new WriterHookException("MSGEXC0206","Error in EntitySearch360_Hook.call360EntitySearch_Hook "+e);
		}
	}

}
