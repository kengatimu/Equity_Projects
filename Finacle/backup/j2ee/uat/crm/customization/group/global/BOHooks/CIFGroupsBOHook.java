/******************************************************************************
 * Copyright (c) 2013-2014 Infosys Limited  All rights reserved.
 *
 * $Workfile: CIFGroupsBOHook.java $
 *
 * Author: Vikas_Sheorain
 *
 * $Archive: com/infy/cis/custom/CIFGroupsBOHook $
 *
 * $History: CIFGroupsBOHook.java $
 *
 *****************************************************************************/
package com.infy.cis.custom;

import java.util.Properties;

import com.infy.cis.ui.common.CIFGroupSyncData;
import com.infy.cis.common.EditorUtil;
import com.infy.cis.exception.SRMPostDeleteException;
import com.infy.cis.exception.SRMPostFillException;
import com.infy.cis.exception.SRMPostWriteException;
import com.infy.cis.exception.SRMPreDeleteException;
import com.infy.cis.exception.SRMPreFillException;
import com.infy.cis.exception.SRMPreWriteException;
import com.infy.cis.exception.SRMSecurityException;
import com.infy.cis.srmbo.CIFGroupsBO;
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;

/**
 * @author Vikas_Sheorain
 *
 */
public class CIFGroupsBOHook implements IHooks{

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
		
// changes by vikas starts for IBK
		CIFGroupsBO cifGroupBO = (CIFGroupsBO)arg1;
		
		try {
			Properties genProp = EditorUtil.getCIFGeneralInfo();
			//String syncUpFlag = genProp.getProperty(EditorUtil.CIFGROUPSYNCUP).trim();
			String syncUpFlag = genProp.getProperty(EditorUtil.GROUPSYNCUP).trim();
			if(syncUpFlag.equalsIgnoreCase("TRUE")){
				CIFGroupSyncData.syncCIFGroup(arg0, cifGroupBO);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//System.out.println("Inside CIFGroupsBOHook.CIFGroupSyncData..catch block..exception.message.."+e.getMessage());
			e.printStackTrace();
		}
		// changes by vikas ends for IBK
		
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
