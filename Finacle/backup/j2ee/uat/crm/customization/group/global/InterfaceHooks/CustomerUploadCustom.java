/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CustomerUploadCustom.java $
 *
 * Author: Jamuna G
 *
 * $Archive: $
 *
 *
 * $History: CustomerUploadCustom.java $
 *
 */

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **BEGIN  CHANGES** */

package com.infy.intl.custom;

import com.infosys.insulate.util.Vector;
import java.util.Hashtable;
import java.sql.Connection;

import com.infy.intl.custom.CustUploadComponentIHook;
import com.infy.intl.exception.IntlBypassException;


public  class CustomerUploadCustom implements CustUploadComponentIHook{

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
	public void prestartCustomerUpload(String strSalesID,
		                                     Connection connCRM , int iSeqId,
		                                     boolean isStandalone,String strProdProcType,
                           					 String strProdCustID) throws IntlBypassException{

     //if the base interface related code needs to be bypassed , then IntlBypassException needs to be thrown
	//throw new IntlBypassException("IntlBypassException occured....");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			Vector
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public Vector poststartCustomerUpload(String strSalesID,
		                                     Connection connCRM , int iSeqId,
		                                     boolean isStandalone,String strProdProcType,
											 String strProdCustID , Vector vctData){

	//return the baseclass value
	return vctData;


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
	public void prevctAddExtData(Connection ConnIn , int iSeqId, String strProdType,
	                                   String strProdKeyVal) throws IntlBypassException{

	//throw new IntlBypassException("IntlBypassException occured....");
	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			Vector
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
	public Vector postvctAddExtData(Connection ConnIn , int iSeqId, String strProdType,
	                                    String strProdKeyVal , Vector vctData){


	//return the baseclass value
	return vctData;
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
	public void preprocessRec(Connection ConnInterface, Connection ConnCRM,
	                            String strProdType, String strSalesID,String strProdKeyVal,
	                            Hashtable htbCustData, Vector vctExtraData,
	                            boolean isStandAlone) throws IntlBypassException{

	//throw new IntlBypassException("IntlBypassException occured....");
	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			String[]
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
	public String[] postprocessRec(Connection ConnInterface, Connection ConnCRM,
	                            String strProdType, String strSalesID,String strProdKeyVal,
	                            Hashtable htbCustData, Vector vctExtraData,
	                            boolean isStandAlone , String[] strAry){

		//return the baseclass value if processing is not done
	    return strAry;
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
	public void preupdateStatusFlag(Connection connInt,int iSeqId,String strProdType,
								String strProdValue) throws IntlBypassException{

    //throw new IntlBypassException("IntlBypassException occured....");
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
	public void postupdateStatusFlag(Connection connInt,int iSeqId,
														String strProdType,String strProdValue){


	}
}

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **END OF CHANGES** */