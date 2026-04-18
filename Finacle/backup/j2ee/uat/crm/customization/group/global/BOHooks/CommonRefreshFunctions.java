/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CommonRefreshFunctions.java $
 *
 * Author: Srini
 *
 * $Archive: $
 *
 * **************************************************************************/
/*This class is a common class for getting few fields for Refresh of Corporate
	functionalities.
*/

package com.infy.cis.custom;
import java.util.Date;
import java.sql.*;
import java.util.*;

import com.infosys.insulate.util.HashMap;
import com.infosys.insulate.util.Vector;
import com.infosys.insulate.util.ArrayList;
import com.infosys.insulate.util.HashSet;
import com.infosys.insulate.util.TreeSet;
import com.infosys.insulate.util.IdentityHashMap;
import com.infosys.insulate.util.LinkedHashMap;
import com.infosys.insulate.util.LinkedHashSet;
import com.infosys.insulate.util.LinkedList;
import com.infosys.insulate.util.Stack;
import com.infosys.insulate.util.TreeMap;
import com.infosys.insulate.util.WeakHashMap;
import com.infosys.insulate.util.PriorityQueue;
import com.infosys.insulate.util.ArrayList;
import java.lang.*;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.ui.common.*;
import com.infy.cis.ui.corpcif.ICommonRefreshFunctions;


public class CommonRefreshFunctions implements ICommonRefreshFunctions{


	public  ArrayList getCustomerData()  throws Exception{

		ArrayList  Custlist = new ArrayList();
		Custlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.URL_));
		Custlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.ADDRESS_COUNTRY));
		Custlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.CUST_LAST_NAME));
		// Start of Changes: Ticket 331253
		Custlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.CUST_FIRST_NAME));
		Custlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.SHORT_NAME));
		Custlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.CUST_MIDDLE_NAME));
		Custlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.CUST_LAST_NAME_ALT1));
		Custlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.CUST_FIRST_NAME_ALT1));
		Custlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.SHORT_NAME_ALT1));
		Custlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.CUST_MIDDLE_NAME_ALT1));
		// END of Changes: Ticket 331253
		return Custlist;
	}

    public  ArrayList getProspectData()  throws Exception{

		ArrayList  Prosplist = new ArrayList();
		Prosplist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.URL_));
		Prosplist.add(QueryAssist.getTransformFn(true,"SuspectBO", SuspectBO.ADDRESS_COUNTRY));
		Prosplist.add(QueryAssist.getTransformFn(true,"SuspectBO", SuspectBO.LASTNAME));
		// Start of Changes: Ticket 331253
		Prosplist.add(QueryAssist.getTransformFn(true,"SuspectBO", SuspectBO.FIRSTNAME));
		Prosplist.add(QueryAssist.getTransformFn(true,"SuspectBO", SuspectBO.SHORT_NAME));
		Prosplist.add(QueryAssist.getTransformFn(true,"SuspectBO", SuspectBO.LASTNAME_ALT1));
		Prosplist.add(QueryAssist.getTransformFn(true,"SuspectBO", SuspectBO.FIRSTNAME_ALT1));
		Prosplist.add(QueryAssist.getTransformFn(true,"SuspectBO", SuspectBO.MIDDLENAME_ALT1));
		Prosplist.add(QueryAssist.getTransformFn(true,"SuspectBO", SuspectBO.SHORT_NAME_ALT1));
		// END of Changes: Ticket 331253
		return Prosplist;
	}

    public  ArrayList getContactData()  throws Exception{

		ArrayList  Contlist = new ArrayList();
		Contlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.URL_));
		Contlist.add(QueryAssist.getTransformFn(true,"ContactBO", ContactBO.ADDRESS_COUNTRY));
		Contlist.add(QueryAssist.getTransformFn(true,"ContactBO", ContactBO.LASTNAME));
		// Start of Changes: Ticket 331253
		Contlist.add(QueryAssist.getTransformFn(true,"ContactBO", ContactBO.FIRSTNAME));
		Contlist.add(QueryAssist.getTransformFn(true,"ContactBO", ContactBO.LASTNAME_ALT1));
		Contlist.add(QueryAssist.getTransformFn(true,"ContactBO", ContactBO.FIRSTNAME_ALT1));
		Contlist.add(QueryAssist.getTransformFn(true,"ContactBO", ContactBO.MIDDLENAME_ALT1));
		// END of Changes: Ticket 331253
		return Contlist;
	}

	public  ArrayList getCorpCusData()  throws Exception{

		ArrayList  Corplist = new ArrayList();
		Corplist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.URL_));
		Corplist.add(QueryAssist.getTransformFn(true,"CorporateBO", CorporateBO.ADDRESS_COUNTRY));
		Corplist.add(QueryAssist.getTransformFn(true,"CorporateBO", CorporateBO.CORPORATE_NAME));
		// Start of Changes: Ticket 331253
		Corplist.add(QueryAssist.getTransformFn(true,"CorporateBO", CorporateBO.CORPORATE_NAME_ALT1));
		Corplist.add(QueryAssist.getTransformFn(true,"CorporateBO", CorporateBO.SHORT_NAME_ALT1));
		// END of Changes: Ticket 331253
		return Corplist;
	}

    public  ArrayList getCorpProsData()  throws Exception{

  		ArrayList Proslist = new ArrayList();
  		Proslist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.URL_));
  		Proslist.add(QueryAssist.getTransformFn(true,"CorporateBO", CorporateBO.ADDRESS_COUNTRY));
  		Proslist.add(QueryAssist.getTransformFn(true,"CorporateBO", CorporateBO.CORPORATE_NAME));
  		// Start of Changes: Ticket 331253
  		Proslist.add(QueryAssist.getTransformFn(true,"CorporateBO", CorporateBO.CORPORATE_NAME_ALT1));
  		Proslist.add(QueryAssist.getTransformFn(true,"CorporateBO", CorporateBO.SHORT_NAME_ALT1));
  		// END of Changes: Ticket 331253
  		return Proslist;
  	}

  	public  ArrayList getCustCorp()  throws Exception{

		ArrayList CorReplist = new ArrayList();
		CorReplist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_FIRST_NAME));
		CorReplist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_DOB));
		CorReplist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.GENDER));
		CorReplist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.PREFERREDNAME));
		CorReplist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.SALUTATION));
		CorReplist.add(QueryAssist.getTransformFn("PsychographicBO", PsychographicBO.COMMUNICATION_LANGUAGE));
		CorReplist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_LAST_NAME));
		/*Changes for tracker 171509 : BEGIN
		To include preferred email and preferred phone number in the corporate representaive screen. */
		/* Changes for the ticketid:360240 Starts*/
		CorReplist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.PREFERREDEMAIL));
		/* Changes for the ticketid:360240 Ends*/
		CorReplist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.PREFERREDPHONE));
		/* Changes for tracker 171509 : END */
		/*Recon for 371431 changes start*/
				CorReplist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_LAST_NAME_ALT1));
				CorReplist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_FIRST_NAME_ALT1));
				/*Recon for 371431  changes end*/


	    return CorReplist;


	}

  	/* Change for ticket 328356 : BEGIN */
  	/* Fetching details from phone/email table instead of address table */
  	public  ArrayList getConData()  throws Exception{

			ArrayList Ciflist = new ArrayList();

			//ArrayList Ciflist = new ArrayList();

			Ciflist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.PHONEEMAIL_EMAIL));
			Ciflist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.PHONEEMAIL_PHONEEMAILTYPE));
			Ciflist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.PHONEEMAIL_PHONEOREMAIL));
			Ciflist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.PHONEEMAIL_PHONENOLOCALCODE));
			Ciflist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.PHONEEMAIL_PHONENOCOUNTRYCODE));
			Ciflist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.PHONEEMAIL_PHONENOCITYCODE));
			Ciflist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.SALUTATION));
			Ciflist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.LASTNAME));
			Ciflist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.PHONEEMAIL_PREFERREDFLAG));
			//Changes for tracker id 200777 start
			Ciflist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.FIRSTNAME));
			//Changes for tracker id 200777 end
			return Ciflist;
	  	}
	 public  ArrayList getProsData()  throws Exception{

			ArrayList Ciflist = new ArrayList();

			Ciflist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.PHONEEMAIL_EMAIL));
			Ciflist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.PHONEEMAIL_PHONEEMAILTYPE));
			Ciflist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.PHONEEMAIL_PHONEOREMAIL));
			Ciflist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.PHONEEMAIL_PHONENOLOCALCODE));
			Ciflist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.PHONEEMAIL_PHONENOCOUNTRYCODE));
			Ciflist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.PHONEEMAIL_PHONENOCITYCODE));
			Ciflist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.SALUTATION));
			Ciflist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.LASTNAME));
			Ciflist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.PHONEEMAIL_PREFERREDFLAG));
			//Changes for tracker id 200777 start
			Ciflist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.FIRSTNAME));
			//Changes for tracker id 200777 end
			return Ciflist;

  	}
	/* Change for ticket 328356 : END */
   public  ArrayList getContCorp()  throws Exception{

		ArrayList ConReplist = new ArrayList();
		ConReplist.add(new TransFormFn(ContactBO.ATTR_FIRSTNAME));
		ConReplist.add(new TransFormFn(ContactBO.ATTR_DOB));
		ConReplist.add(new TransFormFn(ContactBO.ATTR_GENDER));
		ConReplist.add(new TransFormFn(ContactBO.ATTR_PREFERREDNAME));
		ConReplist.add(new TransFormFn(ContactBO.ATTR_SALUTATION));
		ConReplist.add(QueryAssist.getTransformFn("PsychographicBO", PsychographicBO.COMMUNICATION_LANGUAGE));
		ConReplist.add(new TransFormFn(ContactBO.ATTR_LASTNAME));
		/*Begin Changes Tracker ID: 182139*/
		//ConReplist.add(new TransFormFn(ContactBO.ATTR_MIDDLENAME));
		ConReplist.add(new TransFormFn(ContactBO.ATTR_PREFERREDEMAIL));
		ConReplist.add(new TransFormFn(ContactBO.ATTR_PREFERREDPHONE));
		/*End Changes Tracker ID: 182139*/
		return ConReplist;

	}

	public  ArrayList getProsCorp()  throws Exception{

		ArrayList ProsReplist = new ArrayList();
		ProsReplist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.FIRSTNAME));
		ProsReplist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.SUSPECTS_DOB));
		ProsReplist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.GENDER));
		ProsReplist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.PREFERREDNAME));
		ProsReplist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.SALUTATION));
		ProsReplist.add(QueryAssist.getTransformFn("PsychographicBO", PsychographicBO.COMMUNICATION_LANGUAGE));
		ProsReplist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.LASTNAME));
		/*Begin Changes Tracker ID: 182139*/
		ProsReplist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.PREFERREDEMAIL));
		ProsReplist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.PREFERREDPHONE));
		/*End Changes Tracker ID: 182139*/
		return ProsReplist;

	}

    public  ArrayList getCustAdd()  throws Exception{

		ArrayList Addlist = new ArrayList();

		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_ADDRESSCATEGORY));
	    Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_HOUSE_NO));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_PREMISE_NAME));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_BUILDING_LEVEL));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_STREET_NO));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_SUBURB));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_STREET_NAME));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_LOCALITY_NAME));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_TOWN));
        Addlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.ADDRESS_CITY));
		Addlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.ADDRESS_STATE));
		Addlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.ADDRESS_COUNTRY));
		/*Begin Changes Tracker ID: 182139*/
		//Addlist.add(QueryAssist.getTransformFn(true,"AccountBO", AccountBO.ADDRESS_COUNTRY_CODE));
		/*End Changes Tracker ID: 182139*/
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_ZIP));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_DOMICILE));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_ADDRESS_PROOF_DOC_ID));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_START_DATE));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_END_DATE));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_PHONENO2));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_PHONENO1));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_CELLNO));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_FAXNO));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_WORKEXTENSION));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_EMAIL));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_URL));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_MAILSTOP));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_TELEX));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_PREFERREDFORMAT));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_PREFERREDADDRESS));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_FREETEXTADDRESS));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_FREETEXTLABEL));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_HOLDMAILINITIATEDBY));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_HOLDMAILFLAG));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_HOLDMAILREASON));
		Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_BUSINESSCENTER));
		 /* Fix for Ticket ID 321374 */
		 Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_ISADDRESSPROOFRCVD));
		 Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_LASTUPDATE_DATE));
		 Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_ADDRESS_LINE1));
		 Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_ADDRESS_LINE2));
         Addlist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ADDRESS_ADDRESS_LINE3));
		 /* Fix for Ticket ID 321374 */

		return Addlist;

	}

	public  ArrayList getContAdd()  throws Exception{

		ArrayList ConAddlist = new ArrayList();

        ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_ADDRESSCATEGORY));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_HOUSE_NO));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_PREMISE_NAME));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_BUILDING_LEVEL));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_STREET_NO));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_SUBURB));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_STREET_NAME));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_LOCALITY_NAME));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_TOWN));
		ConAddlist.add(QueryAssist.getTransformFn(true,"ContactBO", ContactBO.ADDRESS_CITY));
		ConAddlist.add(QueryAssist.getTransformFn(true,"ContactBO", ContactBO.ADDRESS_STATE));
		ConAddlist.add(QueryAssist.getTransformFn(true,"ContactBO", ContactBO.ADDRESS_COUNTRY));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_ZIP));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_DOMICILE));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_ADDRESS_PROOF_DOC_ID));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_START_DATE));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_END_DATE));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_PHONENO2));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_PHONENO1));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_CELLNO));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_FAXNO));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_WORKEXTENSION));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_EMAIL));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_URL));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_MAILSTOP));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_TELEX));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_PREFERREDFORMAT));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_PREFERREDADDRESS));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_FREETEXTADDRESS));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_FREETEXTLABEL));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_HOLDMAILINITIATEDBY));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_HOLDMAILFLAG));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_HOLDMAILREASON));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_BUSINESSCENTER));
		 /* Fix for Ticket ID 321374 */
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_ISADDRESSPROOFRCVD));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_LASTUPDATE_DATE));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_ADDRESS_LINE1));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_ADDRESS_LINE2));
		ConAddlist.add(QueryAssist.getTransformFn("ContactBO", ContactBO.ADDRESS_ADDRESS_LINE3));
		 /* Fix for Ticket ID 321374 */

		return ConAddlist;

	}

    public  ArrayList getProsAdd()  throws Exception{

		ArrayList ProAddlist = new ArrayList();

		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_ADDRESSCATEGORY));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_HOUSE_NO));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_PREMISE_NAME));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_BUILDING_LEVEL));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_STREET_NO));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_SUBURB));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_STREET_NAME));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_LOCALITY_NAME));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_TOWN));
		ProAddlist.add(QueryAssist.getTransformFn(true,"SuspectBO", SuspectBO.ADDRESS_CITY));
		ProAddlist.add(QueryAssist.getTransformFn(true,"SuspectBO", SuspectBO.ADDRESS_STATE));
		ProAddlist.add(QueryAssist.getTransformFn(true,"SuspectBO", SuspectBO.ADDRESS_COUNTRY));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_ZIP));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_DOMICILE));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_ADDRESS_PROOF_DOC_ID));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_START_DATE));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_END_DATE));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_PHONENO2));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_PHONENO1));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_CELLNO));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_FAXNO));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_WORKEXTENSION));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_EMAIL));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_URL));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_MAILSTOP));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_TELEX));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_PREFERREDFORMAT));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_PREFERREDADDRESS));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_FREETEXTADDRESS));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_FREETEXTLABEL));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_HOLDMAILINITIATEDBY));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_HOLDMAILFLAG));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_HOLDMAILREASON));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_BUSINESSCENTER));
		 /* Fix for Ticket ID 321374 */
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_ISADDRESSPROOFRCVD));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_LASTUPDATE_DATE));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_ADDRESS_LINE1));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_ADDRESS_LINE2));
		ProAddlist.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.ADDRESS_ADDRESS_LINE3));
		 /* Fix for Ticket ID 321374 */
		return ProAddlist;

	 }

    public  ArrayList getCustCorpAdd()  throws Exception{

		ArrayList CorpAddlist = new ArrayList();

		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_ADDRESSCATEGORY));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_HOUSE_NO));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_PREMISE_NAME));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_BUILDING_LEVEL));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_STREET_NO));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_SUBURB));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_STREET_NAME));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_LOCALITY_NAME));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_TOWN));
		CorpAddlist.add(QueryAssist.getTransformFn(true,"CorporateBO", CorporateBO.ADDRESS_CITY));
		CorpAddlist.add(QueryAssist.getTransformFn(true,"CorporateBO", CorporateBO.ADDRESS_STATE));
		CorpAddlist.add(QueryAssist.getTransformFn(true,"CorporateBO", CorporateBO.ADDRESS_COUNTRY));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_ZIP));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_DOMICILE));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_ADDRESS_PROOF_DOC_ID));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_START_DATE));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_END_DATE));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_PHONENO2));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_PHONENO1));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_CELLNO));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_FAXNO));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_WORKEXTENSION));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_EMAIL));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_URL));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_MAILSTOP));
//		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_TELEX));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_PREFERREDFORMAT));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_PREFERREDADDRESS));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_FREETEXTADDRESS));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_FREETEXTLABEL));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_HOLDMAILINITIATEDBY));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_HOLDMAILFLAG));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_HOLDMAILREASON));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_BUSINESSCENTER));
		  /* Fix for Ticket ID 321374 */
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_ISADDRESSPROOFRCVD));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_LASTUPDATE_DATE));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_ADDRESS_LINE1));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_ADDRESS_LINE2));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.ADDRESS_ADDRESS_LINE3));
		  /* Fix for Ticket ID 321374 */
		return CorpAddlist;

	  	}

	  	//Fix for ticket 329491 starts
 		 public  ArrayList getCustCorpModAdd()  throws Exception{

		ArrayList CorpAddlist = new ArrayList();

		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_ADDRESSCATEGORY));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_HOUSE_NO));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_PREMISE_NAME));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_BUILDING_LEVEL));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_STREET_NO));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_SUBURB));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_STREET_NAME));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_LOCALITY_NAME));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_TOWN));
		CorpAddlist.add(QueryAssist.getTransformFn(true,"CorporateModBO", CorporateModBO.ADDRESS_CITY));
		CorpAddlist.add(QueryAssist.getTransformFn(true,"CorporateModBO", CorporateModBO.ADDRESS_STATE));
		CorpAddlist.add(QueryAssist.getTransformFn(true,"CorporateModBO", CorporateModBO.ADDRESS_COUNTRY));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_ZIP));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_DOMICILE));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_ADDRESS_PROOF_DOC_ID));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_START_DATE));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_END_DATE));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_PHONENO2));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_PHONENO1));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_CELLNO));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_FAXNO));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_WORKEXTENSION));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_EMAIL));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_URL));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_MAILSTOP));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_PREFERREDFORMAT));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_PREFERREDADDRESS));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_FREETEXTADDRESS));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_FREETEXTLABEL));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_HOLDMAILINITIATEDBY));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_HOLDMAILFLAG));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_HOLDMAILREASON));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_BUSINESSCENTER));
		 /* Fix for Ticket ID 321374 */
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_ISADDRESSPROOFRCVD));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_LASTUPDATE_DATE));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_ADDRESS_LINE1));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_ADDRESS_LINE2));
		CorpAddlist.add(QueryAssist.getTransformFn("CorporateModBO", CorporateModBO.ADDRESS_ADDRESS_LINE3));
		 /* Fix for Ticket ID 321374 */
		return CorpAddlist;

	  	}
	  	//Fix for ticket 329491 ends
    public  ArrayList getCifData()  throws Exception{

		ArrayList Ciflist = new ArrayList();
		 /*tracker id 169703 changes starts*/
		Ciflist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.PHONEEMAIL_EMAIL));
		Ciflist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.PHONEEMAIL_PHONEEMAILTYPE));
		Ciflist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.PHONEEMAIL_PHONEOREMAIL));
		Ciflist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.PHONEEMAIL_PHONENOLOCALCODE));
		Ciflist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.PHONEEMAIL_PHONENOCOUNTRYCODE));
		Ciflist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.PHONEEMAIL_PHONENOCITYCODE));
        /*tracker id 169703 changes ends*/

		Ciflist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.SALUTATION));
		Ciflist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_LAST_NAME));
        /*tracker id 169703 changes starts*/
		Ciflist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.PHONEEMAIL_PREFERREDFLAG));
		//Changes for tracker id 200777 start
		Ciflist.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_FIRST_NAME));
		//Changes for tracker id 200777 end
       /*tracker id 169703 changes ends*/

		return Ciflist;

  	}


   public  ArrayList getCustBeneIdent()  throws Exception{

		ArrayList CustBenIdent = new ArrayList();

		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.DOCTYPECODE));
		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.DOCTYPEDESCR));
		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.DOCCODE));
		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.DOCDESCR));
		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.DOCREMARKS));
		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.ISMANDATORY));
		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.SCANREQUIRED));
		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.REFERENCENUMBER));
		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.DOCISSUEDATE));
		CustBenIdent.add(QueryAssist.getTransformFn(true,"EntityDocumentBO", EntityDocumentBO.PLACEOFISSUE));
		CustBenIdent.add(QueryAssist.getTransformFn(true,"EntityDocumentBO", EntityDocumentBO.COUNTRYOFISSUE));
		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.IDENTIFICATIONTYPE));
		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.DOCEXPIRYDATE));
		/* Changes for ticket 328890 starts */
		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.ISDOCUMENTVERIFIED));
		CustBenIdent.add(QueryAssist.getTransformFn("EntityDocumentBO", EntityDocumentBO.IDISSUEDORGANISATION));
		/* Changes for ticket 328890 ends */

		return CustBenIdent;

	  }


   public  ArrayList getCustBene()  throws Exception{

   		ArrayList CustBen = new ArrayList();

   		CustBen.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_FIRST_NAME));
   		CustBen.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_DOB));
   		CustBen.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_MIDDLE_NAME));
   		CustBen.add(QueryAssist.getTransformFn("AccountBO", AccountBO.SALUTATION));
   		CustBen.add(QueryAssist.getTransformFn("AccountBO", AccountBO.GENDER));
   		CustBen.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_LAST_NAME));

		/*ticket id 210577 tracker id 127202 changes starts*/
		CustBen.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_FIRST_NAME_ALT1));
		CustBen.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_LAST_NAME_ALT1));
		/*ticket id 210577 tracker id 127202 changes ends*/
		CustBen.add(QueryAssist.getTransformFn("AccountBO", AccountBO.CUST_MIDDLE_NAME_ALT1));	// Start of Changes: Ticket 331253
   		return CustBen;

   	  	}


    public  ArrayList getContBene()  throws Exception{

		ArrayList ContBen = new ArrayList();

		ContBen.add(new TransFormFn(ContactBO.ATTR_FIRSTNAME));
		ContBen.add(new TransFormFn(ContactBO.ATTR_DOB));
		ContBen.add(new TransFormFn(ContactBO.ATTR_MIDDLENAME));
		ContBen.add(new TransFormFn(ContactBO.ATTR_SALUTATION));
		ContBen.add(new TransFormFn(ContactBO.ATTR_GENDER));
		ContBen.add(new TransFormFn(ContactBO.ATTR_LASTNAME));
		/*ticket id 210577 tracker id 127202 changes starts*/
		ContBen.add(new TransFormFn(ContactBO.ATTR_FIRSTNAME_ALT1));
		ContBen.add(new TransFormFn(ContactBO.ATTR_LASTNAME_ALT1));
		/*ticket id 210577 tracker id 127202 changes ends*/
		ContBen.add(new TransFormFn(ContactBO.ATTR_MIDDLENAME_ALT1));	// Start of Changes: Ticket 331253
		return ContBen;

	}


	 public  ArrayList getProsBene()  throws Exception{

		ArrayList ProsBen = new ArrayList();

		ProsBen.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.FIRSTNAME));
		ProsBen.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.SUSPECTS_DOB));
		ProsBen.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.MIDDLENAME));
		ProsBen.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.SALUTATION));
		ProsBen.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.GENDER));
		ProsBen.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.LASTNAME));

		/*ticket id 210577 tracker id 127202 changes starts*/
		ProsBen.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.FIRSTNAME_ALT1));
		ProsBen.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.LASTNAME_ALT1));
		/*ticket id 210577 tracker id 127202 changes ends*/
		/*tracker id 202606 changes starts*/
		ProsBen.add(QueryAssist.getTransformFn("SuspectBO", SuspectBO.MIDDLENAME_ALT1));
		/*tracker id 202606 changes ends*/
		return ProsBen;


	  	}

      public  ArrayList getCorpCusBene()  throws Exception{

		ArrayList CorCusBen = new ArrayList();

		CorCusBen.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.SHORT_NAME));
		/*  TrackerID 203491 changes for Lookup START  */
		CorCusBen.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.SHORT_NAME_ALT1));
		/*  TrackerID 203491 changes for Lookup END  */
		CorCusBen.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.DATE_OF_INCORPORATION));
		CorCusBen.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.CORPORATE_NAME));
		CorCusBen.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.CORPORATE_NAME_ALT1));	// Start of Changes: Ticket 331253
		return CorCusBen;


	  	  	}
      public  ArrayList getCorpProsBene()  throws Exception{

		ArrayList CorProsBen = new ArrayList();

		CorProsBen.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.SHORT_NAME));
		CorProsBen.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.CORPORATE_NAME));
		/*  TrackerID 203491 changes for Lookup START  */
		CorProsBen.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.SHORT_NAME_ALT1));
		/*  TrackerID 203491 changes for Lookup END  */
        CorProsBen.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.DATE_OF_INCORPORATION));

		return CorProsBen;

  }
/* CRM102BETA: TicketID:370930 TrackerID:227592 Begin of Change */
     public  ArrayList getCorpCustData()  throws Exception{
		ArrayList CorpCust = new ArrayList();
		CorpCust.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.PHONEEMAIL_EMAIL));
		CorpCust.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.PHONEEMAIL_PHONEEMAILTYPE));
		CorpCust.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.PHONEEMAIL_PHONEOREMAIL));
		CorpCust.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.PHONEEMAIL_PHONENOLOCALCODE));
		CorpCust.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.PHONEEMAIL_PHONENOCOUNTRYCODE));
		CorpCust.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.PHONEEMAIL_PHONENOCITYCODE));
		CorpCust.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.CORPORATE_NAME));
		CorpCust.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.SHORT_NAME));
		CorpCust.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.PHONEEMAIL_PREFERREDFLAG));
		CorpCust.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.SHORT_NAME_ALT1));
		CorpCust.add(QueryAssist.getTransformFn("CorporateBO", CorporateBO.CORPORATE_NAME_ALT1));

		return CorpCust;
	}
/* CRM102BETA: TicketID:370930 TrackerID:227592 End of Change */
}







