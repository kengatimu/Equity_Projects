/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CurrencyBOHook.java $
 *
 * Author: Pavithra R
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/CurrencyBOHook.java $
 *
 *******************************************************************************/
package com.infy.cis.custom;

import javax.servlet.*;
import javax.servlet.http.*;

import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.CurrencyBO;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.ui.common.*;
import com.infy.cis.exception.*;
import com.infy.cis.ui.sales.*;

public class CurrencyBOHook implements IHooks {

	public CurrencyBOHook(){}

	public void preWrite (SRMBusinessContext bc, Object bo)
	throws SRMPreWriteException{

	}

	public void postWrite (SRMBusinessContext bc, Object bo)
	throws SRMPostWriteException {
		CurrencyAndRateCache.ClearCurrFromCache();
	}

	public void preDelete (SRMBusinessContext bc, Object bo)
	throws SRMPreDeleteException {

	}

	public void postDelete (SRMBusinessContext bc, Object bo)
	throws SRMPostDeleteException {

	}

	public void preFill (SRMBusinessContext bc, Object bo)
	throws SRMPreFillException {

	}

	public void postFill (SRMBusinessContext bc, Object bo)
	throws SRMPostFillException {

	}
}
