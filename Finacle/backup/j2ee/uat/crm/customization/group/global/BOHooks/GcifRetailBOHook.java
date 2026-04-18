/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: GcifRetailBOHook.java $
 *
 * Author: Jojen
 *
 * *********************************** */


package com.infy.cis.custom;

//import com.infy.cis.common.ARMTransHandle;
//import com.infy.cis.common.ARMTransHelper;
import com.infy.cis.exception.SRMPostDeleteException;
import com.infy.cis.exception.SRMPostFillException;
import com.infy.cis.exception.SRMPostWriteException;
import com.infy.cis.exception.SRMPreDeleteException;
import com.infy.cis.exception.SRMPreFillException;
import com.infy.cis.exception.SRMPreWriteException;
import com.infy.cis.exception.SRMSecurityException;
import com.infy.cis.srmbo.IHooks;
//import com.infy.cis.srmbo.IQuery;
//import com.infy.cis.srmbo.SRMQueryBuilder;
//import com.infy.cis.srmbo.SRMRecordSet;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;





public class GcifRetailBOHook implements IHooks {



	public GcifRetailBOHook() {

}
	public void preWrite(final SRMBusinessContext buscntxt,final Object bo)
	throws SRMPreWriteException, SRMSecurityException {

/*The preWrite Function is defined in RetailLinkageBOHook.java*/
/*

		SRMQueryResult qrGCIF = null;
		String strlcifs = "";
		String strbanks = "";
		HashMap lcifMap = new HashMap();
		GcifRetailBO boGcif = (GcifRetailBO) bo;
		ArrayList lcifList = new ArrayList();
System.err.println("1");
		String strGcifId = boGcif.getGcifId();
		String strAppr = boGcif.getRecordStatus();
System.err.println("strGcifId"+strGcifId);
System.err.println("strAppr"+strAppr);

		if (strAppr.equalsIgnoreCase("A")) {
			try {
System.err.println("2");
				SRMQueryBuilder qbAccounts = QueryAssist.singleObjectQuery(
						"RetailLinkageBO", RetailLinkageBO.GCIFID);
				QueryAssist.addSimpleCondition(qbAccounts, "RetailLinkageBO",
						RetailLinkageBO.GCIFID, IQuery.ComparisonOperation_EQ,
						"" + strGcifId);

				qrGCIF = qbAccounts.runQuery(buscntxt, true, -1);
			}

			catch (Exception e) {
				e.printStackTrace();
			}

System.err.println("3");
			SRMRecordSet rsAccount = qrGCIF.getRecordSet();
			//	RetailLinkageBO rtlLinkBO  = null;
			while (rsAccount.hasNext()) {

				lcifList = (ArrayList) rsAccount.getNext();
				for  (int ctr=0; ctr< lcifList.size();ctr++) {
					RetailLinkageBO rtlLinkBO = (RetailLinkageBO) lcifList
					.get(ctr);

					strlcifs = strlcifs + rtlLinkBO.getLCIFID() + ",";
					strbanks = rtlLinkBO.getBank_Name() + ",";
				}
			}
System.err.println("4");
			strlcifs = strlcifs + "";
			strbanks = strbanks + "";

			lcifMap.put("GCIFID",strGcifId);
			lcifMap.put("LCIFID", strlcifs);
			lcifMap.put("BANKS", strbanks);
			lcifMap.put("BOTYPE","RETAIL");
System.err.println("5");
	}


System.err.println("6");

		try{
			LCIFInterface lcifIntf = SRMLCIFBroker.getLCIFIntf();
			lcifIntf.gcifIDWriter(lcifMap,buscntxt);

}
catch(Exception e){
}
*/

		}


	public void postFill(final SRMBusinessContext bc,final Object bo)
	throws SRMPostFillException {
		// customized implementation place holder
	}

	public void preDelete(final SRMBusinessContext bc,final Object bo)
	throws SRMPreDeleteException {
		// customized implementation place holder

	}

	//	sample hook - postDelete
	public void postDelete(final SRMBusinessContext bc,final Object bo)
	throws SRMPostDeleteException {
		// customized implementation place holder
	}

	//	sample hook - preFill

	public void preFill(final SRMBusinessContext bc,final Object bo)
	throws SRMPreFillException {
		// customized implementation place holder

	}

	public void postWrite(final SRMBusinessContext bc,final Object bo)
	throws SRMPostWriteException {


	}

	/*Changes For setting Duedate*/

	/*Changes For setting Duedate*/


}
