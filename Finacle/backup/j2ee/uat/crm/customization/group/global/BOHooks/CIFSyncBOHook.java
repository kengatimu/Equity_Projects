/******************************************************************************
* Copyright (c) 2000-2005 Infosys Technologies Ltd.  All rights reserved.
*
* $Workfile: CifSyncDataBOHook.java $
*
* Author: vikas_sheorain
*
* $Archive:
*
* *********************************** */

package com.infy.cis.custom;

import com.infy.cis.exception.SRMPostDeleteException;
import com.infy.cis.exception.SRMPostFillException;
import com.infy.cis.exception.SRMPostWriteException;
import com.infy.cis.exception.SRMPreDeleteException;
import com.infy.cis.exception.SRMPreFillException;
import com.infy.cis.exception.SRMPreWriteException;
import com.infy.cis.exception.SRMSecurityException;
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;

public class CIFSyncBOHook implements IHooks {

	/* (non-Javadoc)
	 * @see com.infy.cis.srmbo.IHooks#postDelete(com.infy.cis.srmbo.security.user.SRMBusinessContext, java.lang.Object)
	 */
	@Override
	public void postDelete(SRMBusinessContext arg0, Object arg1)
			throws SRMPostDeleteException {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see com.infy.cis.srmbo.IHooks#postFill(com.infy.cis.srmbo.security.user.SRMBusinessContext, java.lang.Object)
	 */
	@Override
	public void postFill(SRMBusinessContext arg0, Object arg1)
			throws SRMPostFillException {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see com.infy.cis.srmbo.IHooks#postWrite(com.infy.cis.srmbo.security.user.SRMBusinessContext, java.lang.Object)
	 */
	@Override
	public void postWrite(SRMBusinessContext arg0, Object arg1)
			throws SRMPostWriteException {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see com.infy.cis.srmbo.IHooks#preDelete(com.infy.cis.srmbo.security.user.SRMBusinessContext, java.lang.Object)
	 */
	@Override
	public void preDelete(SRMBusinessContext arg0, Object arg1)
			throws SRMPreDeleteException {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see com.infy.cis.srmbo.IHooks#preFill(com.infy.cis.srmbo.security.user.SRMBusinessContext, java.lang.Object)
	 */
	@Override
	public void preFill(SRMBusinessContext arg0, Object arg1)
			throws SRMPreFillException {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see com.infy.cis.srmbo.IHooks#preWrite(com.infy.cis.srmbo.security.user.SRMBusinessContext, java.lang.Object)
	 */
	@Override
	public void preWrite(SRMBusinessContext arg0, Object arg1)
			throws SRMPreWriteException, SRMSecurityException {
		// TODO Auto-generated method stub
		
	}
	
}
