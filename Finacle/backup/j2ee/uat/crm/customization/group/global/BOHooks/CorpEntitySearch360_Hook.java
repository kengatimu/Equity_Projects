/******************************************************************************
* Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
*
* $Workfile: CorpEntitySearch360_Hook.java $
*
* Author:    Arun Kumar C.P.
*
* $Archive:

* $History:  CorpEntitySearch360_Hook.java $
*
*****************************************************************************/
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

/**
* @semantics CorpEntitySearch360_Hook - Hook file to be called in case of 'Workflow' after
*                                       retrieving a corporate  entity in 'Corp Entity
*                                       Search' in '360 Degrees View'.
* @author    Arun Kumar C.P.
* @see       n/a
*/
public class CorpEntitySearch360_Hook {

	/**
	* @semantics 	    call360CorpEntitySearch_Hook - Calls PEAS and passes CIFID &
	*           	    CIFTYPE to it
	* @param HookParams	HashMap object
	* @param bc	        SRMBusinessContext object
	* @return 		    none
	* @throws 		    WriterHookException
	* @throws 		    Exception
	* @see			    n/a
	*/

	public static void call360CorpEntitySearch_Hook(HashMap HookParams, SRMBusinessContext bc) throws WriterHookException, Exception {
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
			if (sBOName.equals("CorporateBO")) {
				hCallPEASparams.put("CIFID",wflBO.getEntityID());
				hCallPEASparams.put("CIFTYPE","Corp_Customer");
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
		} catch(WriterHookException whe) {
			WebAdaptor.log(com.infy.cis.log.LogType.PANIC, "CorpEntitySearch360_Hook : Exception"+whe);
			throw new WriterHookException("MSGEXC0206","Error in CorpEntitySearch360_Hook.call360CorpEntitySearch_Hook "+whe);
		} catch (Exception e) {
			WebAdaptor.log(com.infy.cis.log.LogType.PANIC, "CorpEntitySearch360_Hook : Exception"+e);
		}
	}

}
