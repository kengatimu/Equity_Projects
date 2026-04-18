/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: GcifRetailBOHook.java $
 *
 * Author: Rakesh
 *	Description:This is the helper file in which is used for updating the accounts table
 *
 * *********************************** */


package com.infy.cis.custom;



import com.infy.cis.common.dbmgr.IDBOps;
import com.infy.cis.common.dbmgr.SRMDBMgrDefaultProvider;
import com.infy.cis.exception.SRMPostDeleteException;
import com.infy.cis.exception.SRMPostFillException;
import com.infy.cis.exception.SRMPostWriteException;
import com.infy.cis.exception.SRMPreDeleteException;
import com.infy.cis.exception.SRMPreFillException;
import com.infy.cis.exception.SRMPreWriteException;
import com.infy.cis.srmbo.GcifRetailBO;
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.RetailLinkageBO;
import com.infy.cis.srmbo.SRMQueryResult;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import java.sql.Connection;
import com.infosys.insulate.util.HashMap;
import com.infy.cis.ui.common.Utils;

public class RetailLinkageBOHook implements IHooks {



	public RetailLinkageBOHook() {
	}

public void preWrite(final SRMBusinessContext buscntxt, final Object bo)
	throws SRMPreWriteException{

	}
/*catching the exception if any starts here*/

	public void postFill(final SRMBusinessContext bc,final Object bo)
	throws SRMPostFillException {
		// customized implementation place holder
	}
/*catching the exception if any ends here*/
/*catching the exception if any starts here*/
	public void preDelete(final SRMBusinessContext bc,final Object bo)
	throws SRMPreDeleteException {
		// customized implementation place holder
	}
	/*catching the exception if any ends here*/
/*catching the exception if any starts here*/
	//	sample hook - postDelete
	public void postDelete(final SRMBusinessContext bc,final Object bo)
	throws SRMPostDeleteException {
		// customized implementation place holder
	}
	/*catching the exception if any ends here*/
/*catching the exception if any starts here*/
	//	sample hook - preFill

	public void preFill(final SRMBusinessContext bc,final Object bo)
	throws SRMPreFillException {
		// customized implementation place holder

	}
	/*catching the exception if any ends here*/
/*catching the exception if any starts here*/
	public void postWrite(final SRMBusinessContext buscntxt,final Object bo)
			throws SRMPostWriteException {
try{
				SRMQueryResult qrGCIF = null;
/* we are taking the valus from the request and object starts here*/

				HashMap lcifMap = new HashMap();
				RetailLinkageBO boGcif = (RetailLinkageBO) bo;

			    String strGcifId = boGcif.getGCIFID();
	            String strlcifs = boGcif.getLCIFID();
				String strbanks= boGcif.getBank_Name();
/* we are taking the valus from the request and object ends here*/
				GcifRetailBO gcifCorpBO = null;
				strlcifs=strlcifs;
				strbanks=strbanks;
				String strAppr="";
/*Adding the values in the hashmap ends here*/

		            lcifMap.put("GCIFID",strGcifId);
					lcifMap.put("LCIFID", strlcifs);
					lcifMap.put("BANKS", strbanks);
				    lcifMap.put("BOTYPE","RETAIL");
/*Adding the values in the hashmap ends here*/
/*Creating a new connection object to do the transaction starts heree*/
				    	Connection DataCon1 = null;
/*Creating a new connection object to do the transaction ends heree*/

/*intailising the connection and creating an object of the same starts here*/
	 IDBOps dbops = SRMDBMgrDefaultProvider.getDBOps();
/*intailising the connection and creating an object of the same ends here*/

/*Creating an Raw query for updating of hte Accounts table with the GcifID starts here*/
	String strSql= "update Accounts set GCIFID = '"+strGcifId+"' where orgkey ='" +strlcifs+"' and Bank_id='"+strbanks+"'";
/*Creating an Raw query for updating of hte Accounts table with the GcifID ends here*/
/*Excecuting the query starts here with the object created above */
		dbops.execSQL(strSql);

	}catch (Exception e){
		e.printStackTrace();

	}


}
}






