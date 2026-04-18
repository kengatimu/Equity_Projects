/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: AccountUploadCustom.java $
 *
 * Author: Jamuna G
 *
 * $Archive: $
 *
 *
 * $History: AccountUploadCustom.java $
 *
 */

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **BEGIN  CHANGES** */

package com.infy.intl.custom;

import com.infosys.insulate.util.Vector;
import java.util.Hashtable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;


import com.infy.intl.common.InterfaceDBAccess;
import com.infy.intl.common.InterfaceResultSet;
import com.infy.intl.exception.IntlBypassException;
import com.infy.intl.custom.AcctUploadComponentIHook;
import com.infy.intl.util.InterfaceDBConn;

public class AccountUploadCustom implements AcctUploadComponentIHook {

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return		void
	 	 * @exception   IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */

    public void pregetSalesId(Hashtable htbSales, Vector vctProdId,
    							Connection connCRM) throws IntlBypassException{


	//if the base interface related code needs to be bypassed , then IntlBypassException needs to be thrown
	//throw  new IntlBypassException("IntlBypassException occured.......");

	}


	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return		void
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */


    public void postgetSalesId(Hashtable htbSales, Vector vctProdId,
    							Connection connCRM){


	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			void
	 	 * @exception		IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */

    public void predoInsertUpdateSales(String strSalesUpdateId, int irecCount,
    										Hashtable htbSales,Vector vctProdId,
    										Connection connCRM) throws IntlBypassException{

	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			void
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */


    public void postdoInsertUpdateSales(String strSalesUpdateId, int irecCount,
    										Hashtable htbSales,Vector vctProdId,
    										Connection connCRM){

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			void
	 	 * @exception		IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */

    public void predoCustomerUpload(String strSalesID,
    									Connection connCRM) throws IntlBypassException{

	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void postdoCustomerUpload(String strSalesID,Connection connCRM){


	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void predoSaleCustUpload(Connection connCRM,String strSalesID,
    									String strOrgID, String strRole,
    									String strProdProc, String strProdCustID,
    									String strPersonTypeTable) throws IntlBypassException{

	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void postdoSaleCustUpload(Connection connCRM,String strSalesID,
    									String strOrgID, String strRole,
    									String strProdProc, String strProdCustID,
    									String strPersonTypeTable){

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void presalesCustInsertUpdate(Hashtable htbSales,
									   Connection connCRM,
									   String strCRMTable) throws IntlBypassException{

	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				Vector
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public Vector postsalesCustInsertUpdate(Hashtable htbSales,
									   Connection connCRM,
									   String strCRMTable,
									   Vector vctPostData){

	return vctPostData;
	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void preinsertSalesCustomer(Connection connCRM, String strSalesID,
									String strOrgID, String strRole,
									Vector vctParams, String strPersonTypeTable) throws IntlBypassException{

	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void postinsertSalesCustomer(Connection connCRM, String strSalesID,
									String strOrgID, String strRole,
									Vector vctParams, String strPersonTypeTable){
	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void preAccountExtension(Connection ConnCRM,
								   String strSeqIdFromAccount,
								   String strProductType,
								   String strSalesID,
								   String strRequestID) throws IntlBypassException{


	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				Vector
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public Vector postAccountExtension(Connection ConnCRM,
								   String strSeqIdFromAccount,
								   String strProductType,
								   String strSalesID,
								   String strRequestID,
								   Vector vctPostData){

	//return the base code value
	return vctPostData;
	}


	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void predeleteAccountsExtnDetails(String strSalesID,Connection ConnCRM,
    											 InterfaceResultSet rsExtn) throws IntlBypassException{


	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void postdeleteAccountsExtnDetails(String strSalesID,Connection ConnCRM,
    											  InterfaceResultSet rsExtn){


	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void presaleCustUploadProcess(Hashtable htbCustData, String strSalesID,
									   Connection connCRM ) throws IntlBypassException{


	//throw  new IntlBypassException("IntlBypassException occured.......");


	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void postsaleCustUploadProcess(Hashtable htbCustData, String strSalesID,
									   Connection connCRM ){


	}
}

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **END OF CHANGES** */