/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: FIHook.java $
 *
 * Author:
 *
 * $Archive: CRM100/com/infy/cis/custom/BOHooks/FIHook.java
 *
 ******************************************************************************
 ****************** Dedup/BL/NL Enquiry ***************************************
 * User: 71691       Date: 07/20/07
 * Updated in $/CRM100/com/infy/cis/custom/BOHooks
 * Changes: Added new method to implement the Custom complex logic. Sql raw
 * 			queries are returned based onthe viewname and isUnified flag passed
 * TRACKER ID: 113279
 * Modified by : Bharat Shingari
 *
 *****************************************************************************/


package com.infy.cis.custom;

import com.infosys.insulate.util.HashMap;

import com.infy.cis.exception.CRMBusinessException;
import com.infy.cis.exception.CRMSystemException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.exception.SRMSecurityException;
import com.infy.cis.exception.CISInvalidArgumentException;
import com.infy.cis.exception.SRMPreDeleteException;
import com.infy.cis.exception.SRMPostDeleteException;
import com.infy.cis.exception.SRMPreFillException;
import com.infy.cis.exception.SRMPostFillException;
import com.infy.cis.exception.SRMPostWriteException;
import com.infy.cis.exception.SRMPreWriteException;
import com.infy.cis.srmbo.*;
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.SRMBOBase;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.log.LogType;



/* 113279 - Begin of changes : To Implement Customization Complex logic */
import com.infy.cis.common.CRMEJBUtil;
import com.infy.cis.srmbo.SRMQueryResult;
/* 113279 - End of changes */

/******************************************************************************
* This File is provided for customization of the EJB services especially
* create update and search services. .
*
*/

public class FIHook implements IHooks {



    // Hook for CRMEJB create
    public static String create(HashMap inputHash, SRMBusinessContext busCntxt, String serviceName, String ResponseXml)
                               throws SRMBOException, SRMSecurityException,
                               CISInvalidArgumentException, Exception {

		return ResponseXml;
    }

    // Hook for CRMEJB update
   public static String update(HashMap inputHash, SRMBusinessContext busCntxt, String serviceName, String ResponseXml)
   	throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, Exception {

		return ResponseXml;

    }

/* 113279 - Begin of changes : To Implement Customization Complex logic */

/**
 * This function acts as a hook to provide the freedom to customization team
 * with which they can provide the raw sql queries to perform the Dedup/BL/NL
 * enquiry. This function provide sql queries for simple searches and also
 * for unified searches.
 * @param viewName XML String containing View Name
 * @param isUnified  boolean value that tells unification to perform or not
	 * @param paramList  HashMap paramList passed by FI
 * @return strSql containing the sql Query.
 */

	/* 10.1 RECON Changes by mukundhan_santhanam (79625)*/
	public static String search(String viewName, boolean isUnified, HashMap paramList, SRMBusinessContext busCntxt) throws Exception {

		String strSql = null;

		strSql = search(viewName, isUnified, paramList); //This method is invoked for unified and simple search on the basis of isUnified flag and view name, if this is commented out during customization, then the invoked method body should be defined here.

		return strSql;

	}
	// End of 10.1 RECON Changes

	public static String search(String viewName, boolean isUnified, HashMap paramList) throws Exception {
	String strSql = null;
	String strSqlRetail = null;
	String strSqlCorporate = null;

	// Section to provide query for unified search on the basis of isUnified flag and view name
	if(isUnified) {
		// Block for Blacklist Unified search
		if((viewName.equals(CRMEJBUtil.CIFRETAILBLACKLISTENQUIRY) || viewName.equals(CRMEJBUtil.CIFCORPBLACKLISTENQUIRY))) {
			// Sql raw query for retail blacklist enquiry
			strSqlRetail = null;
			// Sql raw query for corporate blacklist enquiry
			strSqlCorporate = null;

			// Concatinating two queries for Unification
			strSql = strSqlRetail+"UNION"+strSqlCorporate;
		}
		// Block for Negativelist Unified search
		else if((viewName.equals(CRMEJBUtil.CIFRETAILNEGATIVEENQUIRY) || viewName.equals(CRMEJBUtil.CIFCORPNEGATIVEENQUIRY))) {
			// Sql raw query for retail Negativelist enquiry
			strSqlRetail = null;
			// Sql raw query for corporate Negativelist enquiry
			strSqlCorporate = null;

			// Concatinating two queries for Unification
			strSql = strSqlRetail+"UNION"+strSqlCorporate;
		}
		// Block for Dedup Unified search
		else if((viewName.equals(CRMEJBUtil.CIFRETAILDEDUPENQUIRY) || viewName.equals(CRMEJBUtil.CIFCORPDEDUPENQUIRY))) {
			// Sql raw query for retail Dedup enquiry
			strSqlRetail = null;
			// Sql raw query for corporate Dedup enquiry
			strSqlCorporate = null;

			// Concatinating two queries for Unification
			strSql = strSqlRetail+"UNION"+strSqlCorporate;
		}

		/* 10.1 RECON Changes by mukundhan_santhanam (79625)*/
		else if((viewName.equals(CRMEJBUtil.CIFRETAILWILDINQUIRY)) || (viewName.equals(CRMEJBUtil.CIFCORPWILDINQUIRY))) {
			// Sql raw query for retail CIF WildCard enquiry
			strSqlRetail = null;
			// Sql raw query for corporate CIF WildCard enquiry
			strSqlCorporate = null;

			// Concatinating two queries for Unification
			strSql = strSqlRetail+"UNION"+strSqlCorporate;
		}
		// End of 10.1 RECON Changes
	}
	// Section to provide query for simple search on the basis of view name
	else {
		// Sql raw query for retail blacklist enquiry
		if(viewName.equals(CRMEJBUtil.CIFRETAILBLACKLISTENQUIRY)) {
			strSql = null;
		}
		// Sql raw query for retail Negativelist enquiry
		else if(viewName.equals(CRMEJBUtil.CIFRETAILNEGATIVEENQUIRY)) {
			strSql = null;
		}
		// Sql raw query for retail Dedup enquiry
		else if(viewName.equals(CRMEJBUtil.CIFRETAILDEDUPENQUIRY)) {
			strSql = null;
		}
		// Sql raw query for corporate blacklist enquiry
		else if(viewName.equals(CRMEJBUtil.CIFCORPBLACKLISTENQUIRY)) {
			strSql = null;
		}
		// Sql raw query for corporate Negativelist enquiry
		else if(viewName.equals(CRMEJBUtil.CIFCORPNEGATIVEENQUIRY)) {
			strSql = null;
		}
		// Sql raw query for corporate Dedup enquiry
		else if(viewName.equals(CRMEJBUtil.CIFCORPDEDUPENQUIRY)) {
			strSql = null;
		}
		/* 10.1 RECON Changes by mukundhan_santhanam (79625)*/
		/* 130219 - Begin of changes : Block for retail CIF WildCard search */
		// Sql raw query for retail CIF WildCard enquiry
		else if(viewName.equals(CRMEJBUtil.CIFRETAILWILDINQUIRY)) {
			strSql = null;
		}
		// Sql raw query for corporate CIF WildCard enquiry
		else if(viewName.equals(CRMEJBUtil.CIFCORPWILDINQUIRY)) {
			strSql = null;
		}
		/* 130219 - End of changes */
	}

	// Sql Query is passed as the output of this method
	return strSql;
}

	/**
	 * This function acts as a hook to provide the freedom to customization team
	 * with which they can change or filter the query result and return the modified
	 * one to the calling function.
	 * @param queryResult SRMQueryResult containing Query Result
	 * @return queryResult containing the updated queryResult.
	 */

	public static SRMQueryResult search(SRMQueryResult queryResult) {

		/* Customization team has to modify the SRMQueryResult generated for
		   Hook approach */

		// Return the modified query Result
		return queryResult;
	}

	/**
	 * This function acts as a hook to provide the freedom to customization team
	 * with which they can change the view name.
	 * @param queryResult SRMQueryResult containing Query Result
	 * @return queryResult containing the updated queryResult.
	 */

	public static StringBuffer search(StringBuffer strBuffViewName) {

		// Customization team has to change the viewName in the String Buffer

		// Return the modified query Result
		return strBuffViewName;
	}

/* 113279 - End of changes */


	public static boolean search(HashMap paramList, String viewName,SRMBusinessContext busCntxt, boolean singleView){

		boolean isCustomized = true;

		return isCustomized; // along with this modfied paramList and viewName are passed by reference

	}
    // sample hook - preDelete
    public void preDelete(final SRMBusinessContext busCntxt, final Object boObj)
        throws SRMPreDeleteException {
        // customized implementation place holder
    }

    // sample hook - postDelete
    public void postDelete(final SRMBusinessContext busCntxt,  final Object boObj)
        throws SRMPostDeleteException {
        // customized implementation place holder
    }

    // sample hook - preFill
    public void preFill(final SRMBusinessContext busCntxt,  final Object boObj)
        throws SRMPreFillException {
       // customized implementation place holder
    }

    // sample hook - postFill
    public void postFill(final SRMBusinessContext busCntxt,  final Object boObj)
        throws SRMPostFillException {
        // customized implementation place holder
    }

    public void postWrite(final SRMBusinessContext busCntxt,  final Object boObj)
        throws SRMPostWriteException {
    }
    public void preWrite(final SRMBusinessContext busCntxt,  final Object boObj)
        throws SRMPreWriteException {
    }
}


