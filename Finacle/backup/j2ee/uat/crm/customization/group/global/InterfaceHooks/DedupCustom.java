/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: DedupCustom.java $
 *
 * Author: Jamuna G
 *
 * $Archive: $
 *
 *
 * $History: DedupCustom.java $
 *
 */

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **BEGIN  CHANGES** */

package com.infy.intl.custom;

import com.infy.intl.custom.DedupInterfaceHook;
import com.infy.intl.exception.IntlBypassException;

public  class DedupCustom implements DedupInterfaceHook {

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
 public void precheckCID(String strCIDType, String strCIDValue)  throws IntlBypassException {


	//if the base interface related code needs to be bypassed , then IntlBypassException needs to be thrown
	//throw  new IntlBypassException("IntlBypassException occured.......");

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
 public String[] postcheckCID (String strCIDType, String strCIDValue, String[] strRetVal) {



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
  public void precheckCIDAcc(String  strCIDType, String strCIDValue) throws IntlBypassException {


	//throw  new IntlBypassException("IntlBypassException occured........");

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
  public String[] postcheckCIDAcc(String strCIDType, String strCIDValue, String[] strRetVal) {



	//return the baseclass value
	return  strRetVal;
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
  public void precheckCIDSus(String strCIDType, String strCIDValue) throws IntlBypassException {


	//throw  new IntlBypassException("IntlBypassException occured..........");
  }


	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				String[]
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
 public String[] postcheckCIDSus(String strCIDType, String strCIDValue, String[] strRetVal ) {



	//return the baseclass value
	return  strRetVal;
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
 public void precheckCIDCon(String strCIDType, String strCIDValue) throws IntlBypassException {


	//throw  new IntlBypassException("IntlBypassException occured...........");

 }

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				String[]
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
 public String[] postcheckCIDCon(String strCIDType, String strCIDValue, String[] strRetVal) {


	//return the baseclass value
	return  strRetVal;
 }
}

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **END OF CHANGES** */
