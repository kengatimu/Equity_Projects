/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: AccountDownloadCustom.java $
 *
 * Author: Jamuna G
 *
 * $Archive: $
 *
 *
 * $History: AccountDownloadCustom.java $
 *
 */

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **BEGIN  CHANGES** */

package com.infy.intl.custom;

import com.infosys.insulate.util.Vector;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;


import com.infy.intl.custom.AcctDownloadComponentIHook;
import com.infy.intl.exception.IntlBypassException;
import com.infy.intl.util.InterfaceDBConn;

public  class AccountDownloadCustom implements AcctDownloadComponentIHook{

  /**
	 *********************************************************************************************
	 * method description
	 * @param
	 * @return		 void
	 * @exception	 IntlBypassException
	 * @since
	 ********************************************************************************************
	 */


  public void pregetSqlQueryForAppDownload(Connection connInterface,
      											Vector vctAllInterfaceData,
      											String strSalesId) throws IntlBypassException {

    //if the base interface related code needs to be bypassed , then IntlBypassException needs to be thrown
	//throw  new IntlBypassException("IntlBypassException occured.......");


 }

/**
	 *********************************************************************************************
	 * method description
	 * @param
	 * @return		 String
	 * @exception
	 * @since
	 ********************************************************************************************
	 */

  public String postgetSqlQueryForAppDownload(Connection connInterface,
      											Vector vctAllInterfaceData,
       											String strSalesId,
       											String strRetVal){

	//return the value of the baseclass method
	return strRetVal;
  }
 }

 /* CRM61SR:SRCIUHIN:TRACKER# 44232 **END OF CHANGES** */
