/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: SaleHLOBOHook.java $
 *
 * $Author: Raghunathrn $
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/SaleHLOBOHook.java $
 *
 * $History: SaleHLOBOHook.java $
 *
 * *****************  Version 1  *****************
 * User: Raghunathrn  Date: 5/27/03    Time: 7:56p
 * Created in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * Added for size check - tracker 52327
 *
 *****************************************************************************/
package  com.infy.cis.custom;

import  com.infosys.insulate.util.HashMap;
import  com.infy.cis.srmbo.IHooks;
import  com.infy.cis.srmbo.SaleHLOBO;
import  com.infy.cis.srmbo.security.user.SRMBusinessContext;
import  com.infy.cis.exception.*;


public class  SaleHLOBOHook
implements IHooks  {

	public void preWrite (SRMBusinessContext bc, Object bo)
	throws SRMPreWriteException {
		SaleHLOBO boHlo = (SaleHLOBO)bo;
		SizeUtil.checkApplFieldSizes (boHlo, "ProductID", boHlo.getProductID(), bc);
	}



	public void postWrite (SRMBusinessContext bc, Object bo)
	throws SRMPostWriteException {
		// customized implementation place holder
	}


	public void preDelete (SRMBusinessContext bc, Object bo)
	throws SRMPreDeleteException {
		// customized implementation place holder
	}


	public void postDelete (SRMBusinessContext bc, Object bo)
	throws SRMPostDeleteException {
		// customized implementation place holder
	}


	public void preFill (SRMBusinessContext bc, Object bo)
	throws SRMPreFillException {
		// customized implementation place holder
	}


	public void postFill (SRMBusinessContext bc, Object bo)
	throws SRMPostFillException {
		// customized implementation place holder
	}

}