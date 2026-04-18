/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile	: EntityDocumentModBOHook.java $
 *
 * $Author		: Greety $
 *
 * $Archive		: /FCRM62BASE/com/infy/cis/custom/BOHooks/EntityDocumentModBOHook.java $
 *
 * $History		: EntityDocumentModBOHook.java $
 *
 *****************************************************************************/
package  com.infy.cis.custom;

import  com.infy.cis.srmbo.IHooks;
import  com.infy.cis.srmbo.EntityDocumentModBO;
import  com.infy.cis.srmbo.security.user.SRMBusinessContext;
import  com.infy.cis.exception.*;
import com.infy.cis.common.EditorUtil;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.finacle.crypt.MsgDigest;
import java.util.Properties;


public class  EntityDocumentModBOHook
implements IHooks  {

	public void preWrite (SRMBusinessContext bc, Object bo)
	throws SRMPreWriteException,SRMSecurityException{
		 // Changes for CheckSum : Start
		try
		{
			//Check for Checksum enable flag
			final Properties keyProp = EditorUtil.getCIFGeneralInfo();
			String chkEnFlag1 = keyProp.getProperty(EditorUtil.CHECKSUM_ENABLE);
			String chkEnFlag = "false";
			if (chkEnFlag1 != null) {
			chkEnFlag = chkEnFlag1.trim();
			}
			if (chkEnFlag.equalsIgnoreCase("True")) {

			EntityDocumentModBO boEntDoc = (EntityDocumentModBO)bo;

			String IdentType = boEntDoc.getIdentificationType();

			final String drivLic = "Driving Licence";
			final String passNum = "Passport Number";

			/* 10.1 RECON Changes by mukundhan_santhanam (79625)*/
			if ((IdentType!=null) && (IdentType.equalsIgnoreCase(passNum) || IdentType.equalsIgnoreCase(drivLic))){
			// End of 10.1 RECON Changes
			String RefNo = boEntDoc.getReferenceNumber();
			final String chkSumCalc = MsgDigest.getDigestToken(RefNo);
				if(null == RefNo){
					RefNo = "";
				}
			boEntDoc.setCheckSum(chkSumCalc);

				}


			}
			}
			 catch (SRMBOException e)
			 { ExceptThrow.Throw(
				new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e));
			 }
			 catch (SRMSecurityException e)
			 { ExceptThrow.Throw(
				 new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e));
			 }
			 catch (SRMTypeValidatorException e)
			 { ExceptThrow.Throw(
				 new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e));
			 }
			catch (CISContextException e)
			{ExceptThrow.Throw(
				 new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e));
				}
			catch (Exception e)
			 { ExceptThrow.Throw(
				 new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e));
			 }
			// Changes for CheckSum : End
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

