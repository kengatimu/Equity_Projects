/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: GcifCorporateBOHook.java $
 *
 * Author: Jojen
 *
 * *********************************** */

package com.infy.cis.custom;


import com.infosys.insulate.util.ArrayList;
import com.infosys.insulate.util.HashMap;


import com.infy.cis.common.LCIFInterface;
import com.infy.cis.exception.CISInvalidArgumentException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.exception.SRMPostDeleteException;
import com.infy.cis.exception.SRMPostFillException;
import com.infy.cis.exception.SRMPostWriteException;
import com.infy.cis.exception.SRMPreDeleteException;
import com.infy.cis.exception.SRMPreFillException;
import com.infy.cis.exception.SRMPreWriteException;
import com.infy.cis.exception.SRMSecurityException;
import com.infy.cis.srmbo.CorpLinkageBO;
import com.infy.cis.srmbo.GcifCorporateBO;
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.IQuery;
import com.infy.cis.srmbo.SRMQueryBuilder;
import com.infy.cis.srmbo.SRMQueryResult;
import com.infy.cis.srmbo.SRMRecordSet;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.ui.common.QueryAssist;
import com.infy.cis.ui.common.SRMLCIFBroker;


public class CorpLinkageBOHook implements IHooks {



	public void postWrite(final SRMBusinessContext buscntxt, final Object bo)
			throws SRMPostWriteException {

		SRMQueryResult qrGCIF = null;
		HashMap lcifMap = new HashMap();
		CorpLinkageBO boGcif = (CorpLinkageBO) bo;
		String strGcifId = boGcif.getGCIFID();
		String strlcifs = boGcif.getLCIFID();
		String strbanks = boGcif.getBank_Name();
		GcifCorporateBO gcifCorpBO = null;
		String strAppr = "";


		lcifMap.put("GCIFID", strGcifId);
		lcifMap.put("LCIFID", strlcifs);
		lcifMap.put("BANKS", strbanks);
		lcifMap.put("BOTYPE", "CORPORATE");
		try {

			//  SRMQueryBuilder qbAccounts = new SRMQueryBuilder();


			SRMQueryBuilder qbAccounts = QueryAssist.singleObjectQuery(
					"GcifCorporateBO", GcifCorporateBO.GCIFID);
			// QueryAssist.addJoin(qbAccounts,  "GcifCorporateBO", GcifCorporateBO.GCIFID, "GcifCorporateBO", GcifCorporateBO.GCIFID, IQuery.JoinType_Equi);
			ArrayList arrtempArr = new ArrayList();
			arrtempArr.add(GcifCorporateBO.RECORDSTATUS);
			QueryAssist.selectAttr(qbAccounts, "GcifCorporateBO", arrtempArr);
			QueryAssist.addSimpleCondition(qbAccounts, "GcifCorporateBO",
					GcifCorporateBO.GCIFID, IQuery.ComparisonOperation_EQ, ""
							+ strGcifId);

			qrGCIF = qbAccounts.runQuery(buscntxt, -1);
			SRMRecordSet rsAccount = qrGCIF.getRecordSet();

			/*GcifCorporateBO mainbo = (GcifCorporateBO) Utils.getBOFromID(buscntxt,
					"GcifCorporateBO",
					GcifCorporateBO.GCIFID, new Integer(
							strGcifId));*/

			if (rsAccount.hasNext()) {
				strAppr = (String) rsAccount.getNext().get(0);
					}

		//	strAppr = mainbo.getRecordStatus();

			if (strAppr.equalsIgnoreCase("A")) {

				LCIFInterface lcifIntf = SRMLCIFBroker.getLCIFIntf();
				lcifIntf.gcifIDWriter(lcifMap, buscntxt);
			}

			} catch (CISInvalidArgumentException invalidE) {
			 //System.out.println("CorpLinkageBOHook.postWrite()");

			} catch (SRMSecurityException secexce) {
				 //System.out.println("CorpLinkageBOHook.postWrite()");
			} catch (SRMBOException srmbexce) {
				 //System.out.println("CorpLinkageBOHook.postWrite()");
			}catch (ClassNotFoundException clnfe) {
				 //System.out.println("CorpLinkageBOHook.postWrite()");
			}




	}


	public void postFill(final SRMBusinessContext bc, final Object bo)
			throws SRMPostFillException {
		// customized implementation place holder
	}

	public void preDelete(final SRMBusinessContext bc, final Object bo)
			throws SRMPreDeleteException {
		// customized implementation place holder

	}

	//	sample hook - postDelete
	public void postDelete(final SRMBusinessContext bc, final Object bo)
			throws SRMPostDeleteException {
		// customized implementation place holder
	}

	//	sample hook - preFill

	public void preFill(final SRMBusinessContext bc, final Object bo)
			throws SRMPreFillException {
		// customized implementation place holder

	}

	public void preWrite(final SRMBusinessContext bc, final Object bo)
			throws SRMPreWriteException {

	}

}



