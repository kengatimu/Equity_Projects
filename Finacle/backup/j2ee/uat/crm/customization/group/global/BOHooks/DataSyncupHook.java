/******************************************************************************
* Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
*
* $Workfile: DataSyncup.java $
*
* Author:
*
* $Archive:
*
* *****************************************************************************/


package com.infy.cis.custom;

import com.infy.cis.exception.SRMPostDeleteException;
import com.infy.cis.exception.SRMPostFillException;
import com.infy.cis.exception.SRMPostWriteException;
import com.infy.cis.exception.SRMPreDeleteException;
import com.infy.cis.exception.SRMPreFillException;
import com.infy.cis.exception.SRMPreWriteException;
import com.infy.cis.exception.SRMSecurityException;
//Changes for call id 393414-recon of call id 391323 starts
//Changes for call id 410416-recon of call id 404216 starts
import com.infy.cis.srmbo.CorporateBO;
import com.infy.cis.srmbo.SRMBOBase;
//Changes for call id 410416-recon of call id 404216 ends
//Changes for call id 393414-recon of call id 391323 ends
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;

public class DataSyncupHook implements IHooks {

    public DataSyncupHook() { }
//Changes for call id 393414-recon of call id 391323 starts
//Changes for call id 410416-recon of call id 404216 starts
 public static String corpUpdateCustomFields(String cuFlag, CorporateBO newCorporateBO){
   		String tempString = "";
   		if(cuFlag.equalsIgnoreCase("C")){
   		}
   		else if(cuFlag.equalsIgnoreCase("E")){
   		}
   		return tempString;
	}
	//Changes for call id 410416-recon of call id 404216 ends
	//Changes for call id 393414-recon of call id 391323 ends
    public void preWrite (SRMBusinessContext bc, Object sourceBO, Object targetBO)
	 throws SRMPreWriteException,SRMSecurityException {


	 }

	public void postWrite (SRMBusinessContext bc, Object sourceBO, Object targetBO)
		 throws SRMPreWriteException,SRMSecurityException {


		 }



	public void postDelete(SRMBusinessContext bc, Object bo)
			throws SRMPostDeleteException {


	}



	public void postFill(SRMBusinessContext bc, Object bo)
			throws SRMPostFillException {


	}



	public void postWrite(SRMBusinessContext bc, Object bo)
			throws SRMPostWriteException {


	}



	public void preDelete(SRMBusinessContext bc, Object bo)
			throws SRMPreDeleteException {


	}



	public void preFill(SRMBusinessContext bc, Object bo)
			throws SRMPreFillException {


	}



	public void preWrite(SRMBusinessContext bc, Object bo)
			throws SRMPreWriteException, SRMSecurityException {


	}

//changes for 556684
	 public static void updateRetailNegativeCustomFields(SRMBusinessContext bc,SRMBOBase bo,SRMBOBase objBO){
		 	 
	 }
	 public static void updateRetailBlacklistCustomFields(SRMBusinessContext bc,SRMBOBase bo,SRMBOBase objBO){
		 	 
	 }
	 public static void updateRetailDedupCustomFields(SRMBusinessContext bc,SRMBOBase bo,SRMBOBase objBO){
		 	
	 }
	 public static void updateCorporateNegativeCustomFields(SRMBusinessContext bc,SRMBOBase bo,SRMBOBase objBO){
		 
	 }
	 public static void updateCorporateBlacklistCustomFields(SRMBusinessContext bc,SRMBOBase bo,SRMBOBase objBO){
		 
	 }
	 public static void updateCorporateDedupCustomFields(SRMBusinessContext bc,SRMBOBase bo,SRMBOBase objBO){
	 
	 }
//changes for 556684
}
