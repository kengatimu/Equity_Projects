 /************************************************************************************************************************
  * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
  *
  * $Workfile: SecurityAuditListOfURLsHook.java $
  *
  * $Author: Viswanathan Ramasamy $
  *
  * $Archive: /FCRM10302BASE/com/infy/cis/custom/SecurityAuditListOfURLsHook.java $
  *
  * $History: SecurityAuditListOfURLs.java $
  *
  * $Brief Description of class:
  *
  * $Functionality: 	This File is used for adding the list of URL's that has to be included in the Security Audit.
  *
  * $External Methods called:
  *
  * $Known Bugs:
  *
  * $Modification log :
 ************************************************************************************************************************/
package com.infy.cis.custom;

import com.infosys.insulate.util.ArrayList;
import com.infosys.insulate.util.HashMap;
import com.infy.cis.arch.SecureAuditHook;

//import javax.servlet.http.HttpServletRequest;

public final class SecurityAuditListOfURLsHook implements SecureAuditHook{

	private static HashMap hSecurListOfURLs= new HashMap();
	private static HashMap hCommonURLlist = new HashMap();

	/*
	*  This Function is used for setting the list of URL that has to be included in the security audit.
	*  Method Name 		: setSecurURL
	*  Return Type	 	: void
	*/

	public void setSecurURL(){

		/* This is for loading the Commn URL, in other words if same URL is used in more than one place and for
		*  identifying the Uniqu screen this configration is loaded.
		*/

		setCommonURL();
	}
	/*
	*  This Function is used for setting the Common URLs, deatils and how to identify the uniq URL details.
	*  Method Name 		: getSecurURL
	*  Paramether Tyep	: String
	*  Expected value 	: URI of the requested servlet
	*  Return Type	 	: SecurityAuditList object
	*/
	 private static void setCommonURL(){

	 	ArrayList arrRequestList=null;

	}
	/*
	*  This Function is used for getting the list of URL that has to be included in the security audit.
	*  Method Name 		: getSecureListofURLS
	*  Return Type	 	: HahsMap
	*/
	public HashMap getSecureListofURLS(){

		if(hSecurListOfURLs!=null && hSecurListOfURLs.size()<1){
			setSecurURL();
		}
		return hSecurListOfURLs;
	}

	/*
	*  This Function is used for getting the list of Common URL that has to be included in the security audit.
	*  Method Name 		: getCommonURLList
	*  Return Type	 	: HahsMap
	*/
	public HashMap getCommonURLList(){

		if(hCommonURLlist!=null && hCommonURLlist.size()<1){
			setSecurURL();
		}
		return hCommonURLlist;
	}

}