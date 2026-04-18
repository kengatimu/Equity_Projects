/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: BOHookUtil.java $
 *
 * $Author: Administrator $
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/BOHookUtil.java $
 *
 * $History: BOHookUtil.java $
 *
 * *****************  Version 1  *****************
 * User: Mamta  Date: 7/09/06    Time: 1:52p
 * Created in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 *
 *****************************************************************************/
package  com.infy.cis.custom;

import  com.infosys.insulate.util.HashMap;
import  com.infy.cis.exception.SRMBOException;
import  com.infy.cis.exception.SRMPreWriteException;



public class  BOHookUtil  {
	public static String CIS_COPYRIGHT_="Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.";
	public static String CIS_VERSION_="1.00 $Revision: 1.1 $";

/* AdressLine changes: START */
	public static HashMap  setAddLines (HashMap aAddLines)
	throws SRMPreWriteException  {
		String addressLine = "";
		boolean ifPrevPresent = false;
		HashMap hmAddLine = new HashMap();
		try {
			if(!(aAddLines.get("HouseNo")==null)){
				addressLine = addressLine + aAddLines.get("HouseNo").toString().trim();
				ifPrevPresent = true;
			}
			if(!(aAddLines.get("BldgLevel")==null)){
				//Changes for tracker ID 451946 start
				if(!(aAddLines.get("BldgLevel").toString().equals(""))){
				if(ifPrevPresent == true){
					addressLine = addressLine + ",";
				}
				else{
					ifPrevPresent = true;
				}
				addressLine = addressLine + aAddLines.get("BldgLevel").toString().trim();
			}
			}
			if(!(aAddLines.get("PremiseNo")==null)){
				if(!(aAddLines.get("PremiseNo").toString().equals(""))){
				if(ifPrevPresent == true){
					addressLine = addressLine + ",";
				}
				addressLine = addressLine + aAddLines.get("PremiseNo").toString().trim();
				}
				//Changes for tracker ID 451946 end
			}
			hmAddLine.put("AddressLine1",addressLine);
			addressLine = "";
			ifPrevPresent = false;
			if(!(aAddLines.get("StreetNo")==null)){
				addressLine = addressLine + aAddLines.get("StreetNo").toString().trim();
				ifPrevPresent = true;
			}
			if(!(aAddLines.get("StreetName")==null)){
				if(ifPrevPresent == true){
					addressLine = addressLine + ",";
				}
				else{
					ifPrevPresent = true;
				}
				addressLine = addressLine + aAddLines.get("StreetName").toString().trim();
			}
			if(!(aAddLines.get("Locality")==null)){
				if(ifPrevPresent == true){
					addressLine = addressLine + ",";
				}
				addressLine = addressLine + aAddLines.get("Locality").toString().trim();
			}
			hmAddLine.put("AddressLine2",addressLine);
			addressLine = "";
			ifPrevPresent = false;
			if(!(aAddLines.get("Suburb")==null)){
				addressLine = addressLine + aAddLines.get("Suburb").toString().trim();
				ifPrevPresent = true;
			}
			if(!(aAddLines.get("Town")==null)){
				if(ifPrevPresent == true){
					addressLine = addressLine + ",";
				}
				addressLine = addressLine + aAddLines.get("Town").toString().trim();
			}
			hmAddLine.put("AddressLine3",addressLine);
		} catch (Exception ge) {
			throw new SRMPreWriteException (SRMBOException.ERROR_INTERNAL, ge);
		}
		return hmAddLine;
	}
/* AdressLine changes: END */

}
