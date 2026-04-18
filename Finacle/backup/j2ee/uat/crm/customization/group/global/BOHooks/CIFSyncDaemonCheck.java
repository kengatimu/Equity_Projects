/******************************************************************************
 * Copyright (c) 2013-2014 Infosys Limited  All rights reserved.
 *
 * $Workfile: CIFSyncDaemonCheck.java $
 *
 * Author: Vikas_Sheorain
 *
 * $Archive: com/infy/cis/custom/CIFSyncDaemonCheck $
 *
 * $History: CIFSyncDaemonCheck.java $
 *
 *****************************************************************************/

package com.infy.cis.custom;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.infy.cis.servletruntime.CISHttpServlet;
import com.infy.cis.ui.common.CIFSynchUpDaemon;

public class CIFSyncDaemonCheck extends CISHttpServlet{
	
	protected void serviceRequest(HttpServletRequest req, HttpServletResponse res){
		//Calling CIFSynchUpDaemon.dataSynchUp
		CIFSynchUpDaemon cifSyncDaemon = new CIFSynchUpDaemon();
		cifSyncDaemon.dataSynchUp("11:00", "11:00", "01");		
	}
	
}