/* Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CustomerDownloadCustom.java $
 *
 * Author: Jamuna G
 *
 * $Archive: $
 *
 *
 * $History: CustDCompCustom.java $
 *
 */

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **BEGIN  CHANGES** */

package com.infy.intl.custom;

import com.infosys.insulate.util.Vector;
import java.sql.Connection;
import java.sql.Statement;

import com.infy.intl.custom.CustDownloadComponentIHook;
import com.infy.intl.exception.IntlBypassException;
import com.infy.intl.common.InterfaceResultSet;

public  class CustomerDownloadCustom implements CustDownloadComponentIHook{


	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			void
	 	 * @exception		IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
	public void predeleteCustRec(Connection connInterface,
								 int iCRMPersonId) throws IntlBypassException{

	 //if the base interface related code needs to be bypassed , then IntlBypassException needs to be thrown
	 //throw new IntlBypassException("IntlBypassException occured....");

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
    public void postdeleteCustRec(Connection connInterface, int iCRMPersonId){

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
    public void preinsertCustRec(Connection connInterface,
                                 InterfaceResultSet rsCRMALLData,
                                 String strTableName, String strSequenceId,
                                 String strSalesId, String strProductproctype,
                                 int iCallerId) throws IntlBypassException{

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
    public String postinsertCustRec(Connection connInterface,
                                   InterfaceResultSet rsCRMALLData,
                                   String strTableName, String strSequenceId,
                                   String strSalesId, String strProductproctype,
                                   int iCallerId , String strRetVal){

	 //return the baseclass value
	 return strRetVal;

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
    public void precustDownLoadFromCrm(Connection connInterface,String strSequenceId,
                                       String strTableName,String strSalesId,
									   String strProductproctype,
                                       String strValue, int iCallerId) throws IntlBypassException{

	//throw new IntlBypassException("IntlBypassException occured....");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			String
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public String postcustDownLoadFromCrm(Connection connInterface,String strSequenceId,
                                          String strTableName,String strSalesId,
									   	  String strProductproctype,
                                          String strValue, int iCallerId , String strRetVal){
	//return the baseclass value
	 return strRetVal;
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
    public void pregetSqlQueryForCustDownload(Connection connInterface,
                                             Vector vctAllInterfaceData) throws IntlBypassException{

	//throw new IntlBypassException("IntlBypassException occured....");
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
    public void postgetSqlQueryForCustDownload(Connection connInterface,
                                             Vector vctAllInterfaceData){

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
    public void pregetCustomerDetails(Connection connInterface, String strSequenceId,
							   		String strSalesId, String strProductproctype,
                                    String strValue) throws IntlBypassException {

	//throw new IntlBypassException("IntlBypassException occured....");
	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			String
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public String postgetCustomerDetails(Connection connInterface, String strSequenceId,
							   			String strSalesId, String strProductproctype,
                               		    String strValue , String strRetVal){

	 //return the baseclass value
	 return strRetVal;
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
    public void precustomerDownLoad(Connection connInterface,String strSequenceId, String strSalesId,
                                    String strProductproctype,String strREQUESTCATEGORY,
                                    String strREQUESTTYPE) throws IntlBypassException {

	//throw new IntlBypassException("IntlBypassException occured....");
	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			boolean
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public boolean postcustomerDownLoad(Connection connInterface,String strSequenceId, String strSalesId,
                                       String strProductproctype,String strREQUESTCATEGORY,
                                       String strREQUESTTYPE , boolean blRetVal){
	 //return the baseclass value
	 return blRetVal;
	}
}

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **END OF CHANGES** */