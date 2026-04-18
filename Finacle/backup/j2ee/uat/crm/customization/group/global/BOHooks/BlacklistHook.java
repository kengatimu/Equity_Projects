/******************************************************************************
 * Copyright(c) 2000-2006 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: BlacklistHook.java $
 *
 * Author:
 *
 * Hook File for the customization team to write its query for Smart Logic
 *
 * $Archive: CRM100/com/infy/cis/custom/BlacklistHook..java $
 *
 *****************************************************************************/

package com.infy.cis.custom;

import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import java.sql.ResultSet;
import com.infy.cis.srmbo.AccountBO;
import com.infy.cis.srmbo.CorporateBO;


/**
  	 * This function will be implemented by the Customization team where they will
  	 * write the query for Smart Logic for Retail Customer which will return a
  	 * resultset
  	 * @return ResultSet having the result of the query
	 */


public class BlacklistHook  {

    public BlacklistHook() { }


    public ResultSet getBlacklistResult(AccountBO accBO)

     { ResultSet rs = null;
       return rs;
    }


    /**
	  	 * This function will be implemented by the Customization team where they will
	  	 * write the query for Smart Logic for corporate customer which will return a
	  	 * result set
	  	 * @return ResultSet having the result of the query
		 */


    public ResultSet getCorpBlacklistResult(CorporateBO accBO)
     {
		 ResultSet rs = null;
         return rs;
    }



}


