/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CustCreationForm.java $
 *
 * Author: $
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/CustCreationForm.java $
 *
 * $History: CustCreationForm.java $
 *
 * *****************  Version 2  *****************
 * User: Sumedh_samant Date: 1/22/04    Time: 7:45p
 * Updated in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * Tracker number: 61030/61031
 * Changes. Related to ML.
 * Modified by:
 * Sumedh and Raghv
 * Reviewed by:
 * Shiva(201005) & Manoj
 *
 * *****************  Version 1  *****************
 * User: Raghavendren_b Date: 12/23/03   Time: 10:25a
 * Created in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * TrackerID: 60105
 * Changes:
 * Added a new file CustCreationForm for a process steps.
 *
 * Added By:
 * Raghavendren
 *
 * Reviewed By:
 * Nixon.
 *
 *
 * *****************  Version 1  *****************
 * User: Raghavendren_b Date: 12/18/03   Time: 11:29a
 * Created in $/FCRM62BASE/com/infy/cis/ui/sales
 * TrackerID: 60105
 *
 *****************************************************************************/
package com.infy.cis.custom;

import javax.servlet.http.*;
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
import java.io.*;

import com.infy.cis.servletruntime.*;
import com.infy.cis.common.*;
import com.infy.cis.ui.common.*;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.srmbo.*;
//import org.apache.ecs.*;
import com.infy.cis.srmbo.XML;
import com.infy.cis.viewcfg.*;
import com.infy.cis.ui.sales.SaleQueries;

   /*
	*Brief Description of class:
	*
	*Functionality:	This Servlet forms a list of groups and agents and loads it
	* in the view using the display logic.
	*
	*External Methods called:
	*
	*Start Date: 07/24/03
	*
	*Modification log :
    */

public class CustCreationForm extends CISHttpServlet
{
    public static String CIS_COPYRIGHT_ = "Copyright (c) 2000-2005 Infosys Tech. Ltd.  All rights reserved.";
    public static String CIS_VERSION_ = "2.00 $Revision: 1.2 $";

/* $NoKeywords: $ */

    protected void serviceRequest(HttpServletRequest req, HttpServletResponse resp)
    throws Exception
    {
		setContentType("text/html", resp);
		PrintWriter out = resp.getWriter();
		out.println("<SCRIPT LANGUAGE='javascript' src=\"../common/js/SSOParameter.js \"></SCRIPT>");
		out.println("<script>parent.parent.parent.parent.frames(3).saveBut.value = 'Convert To Customer';</script>");

		// List of Column for customer entity.

		final String custDefaultColumnOrder = AccountBO.CUST_LAST_NAME + "," +
											  AccountBO.CUST_FIRST_NAME + "," +
										   	  AccountBO.ACCOUNTKEY + "," +
										      SaleBO.SALECUSTOMER_ROLE;
		final String custMandatoryColumns = custDefaultColumnOrder;
		final String custRowIdentifier = AccountBO.URL_;

		final String custIdAttributeColumns = AccountBO.URL_ + "," + AccountBO.ACCOUNTKEY;

		// List of Column for contact entity.

		final String contDefaultColumnOrder = ContactBO.LASTNAME + "," +
											  ContactBO.FIRSTNAME + "," +
											  ContactBO.CONTACTSKEY + "," +
											  SaleBO.SALECONTACT_ROLE;
		final String contMandatoryColumns = custDefaultColumnOrder;
		final String contRowIdentifier = ContactBO.URL_;

		final String contIdAttributeColumns = ContactBO.URL_ + "," + ContactBO.CONTACTSKEY;


		// List of Column for prospect entity.

		final String prosDefaultColumnOrder = SuspectBO.LASTNAME + "," +
											  SuspectBO.FIRSTNAME + "," +
										   	  SuspectBO.SUSPECTSKEY + "," +
										      SaleBO.SALEPROSPECT_ROLE;
		final String prosMandatoryColumns = custDefaultColumnOrder;
		final String prosRowIdentifier = SuspectBO.URL_;

		final String prosIdAttributeColumns = SuspectBO.URL_ + "," + SuspectBO.SUSPECTSKEY;


		SRMBusinessContext bc = Utils.getBusinessContext(req);

		CISSessionContext sc = context.getSessionContext(req);
		Views view = ConfigManager.getInstance().
				findView("CustomerCreation", bc);

		String xslFile 			= view.getXslFileName();
		String xslFileName 		= Utils.getXslFileName(xslFile);
		String xslFilePath 		= Utils.getXslFilePath(xslFile);
		String objectId 		= req.getParameter("objectId");
		String salesId			= req.getParameter("SaleBO.salesID");

		// param for activity creation
		String startTime 		= req.getParameter("starttm");
		String processId 		= req.getParameter("processId");
		String stepId 			= req.getParameter("processStep");
		String nextStepId 		= req.getParameter("nextStep");
		String strictProcess 	= req.getParameter("strictProc");
		String isConditional 	= req.getParameter("isConditional");
		String startDate 		= req.getParameter("startdt");
		String dueDate 			= req.getParameter("dueDate");

		ArrayList cData = new ArrayList();

		XMLFormAssist Xmlassist=new XMLFormAssist(sc);
		/* Tracker 73898 Begin of Changes */
		if( salesId != null && !salesId.trim().equals("") && !salesId.trim().equalsIgnoreCase("null")) {
		/* Tracker 73898 End of Changes */

			ArrayList applIDNVList 			= new ArrayList();
			SRMNVPair nv 					= new SRMNVPair(SaleBO.SALESID, new Integer(salesId));
			applIDNVList.add(nv);
			String saleURL 					= SRMURLResolver.generateURL(applIDNVList,"SaleBO");
			cData.add(new NameValue("saleURL", saleURL));
			cData.add(new NameValue("objectID", objectId));

			ArrayList ltRole = new ArrayList();

			SRMQueryResult qrRole = CommonQueries.getRelationCategories(bc,
								com.infy.cis.ui.common.Constants.ROLECAT);
			SRMRecordSet rsRole	  = qrRole.getRecordSet();

			while(rsRole.hasNext()) {
				ArrayList altemp = (ArrayList)rsRole.getNext();
				ltRole.add((String)altemp.get(0));
			}
			//Added for Call Id: 200419
			rsRole.resetIndex();

			// for Customer
			ArrayList custAttrList = new ArrayList();
			custAttrList.add(QueryAssist.getTransformFn("AccountBO",AccountBO.CUST_LAST_NAME ));
			custAttrList.add(QueryAssist.getTransformFn("AccountBO",AccountBO.CUST_FIRST_NAME ));
			custAttrList.add(QueryAssist.getTransformFn("AccountBO",AccountBO.ACCOUNTKEY ));
			custAttrList.add(QueryAssist.getTransformFn("AccountBO",AccountBO.URL_));
			custAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.SALECUSTOMER_ROLE));

			SRMQueryResult qrCustomer = SaleQueries.getCustomersForSale(bc, saleURL, custAttrList, ltRole);

			Xmlassist.setFormData(qrCustomer, null, true, "Customer" , "CustomerRecordSet");


			// for Contact
			ArrayList contAttrList = new ArrayList();
			contAttrList.add(QueryAssist.getTransformFn("ContactBO",ContactBO.LASTNAME ));
			contAttrList.add(QueryAssist.getTransformFn("ContactBO",ContactBO.FIRSTNAME ));
			contAttrList.add(QueryAssist.getTransformFn("ContactBO",ContactBO.CONTACTSKEY ));
			contAttrList.add(QueryAssist.getTransformFn("ContactBO",ContactBO.URL_));
			contAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.SALECONTACT_ROLE));

			SRMQueryResult qrContact = SaleQueries.getContactsForSale(bc, saleURL, contAttrList, ltRole);

			Xmlassist.setFormData(qrContact, null, true, "Contact" , "ContactRecordSet");

			// for Prospect
			ArrayList prosAttrList = new ArrayList();
			prosAttrList.add(QueryAssist.getTransformFn("SuspectBO",SuspectBO.LASTNAME ));
			prosAttrList.add(QueryAssist.getTransformFn("SuspectBO",SuspectBO.FIRSTNAME ));
			prosAttrList.add(QueryAssist.getTransformFn("SuspectBO",SuspectBO.SUSPECTSKEY ));
			prosAttrList.add(QueryAssist.getTransformFn("SuspectBO",SuspectBO.URL_));
			prosAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.SALEPROSPECT_ROLE));

			SRMQueryResult qrProspect = SaleQueries.getProspectsForSale(bc, saleURL, prosAttrList, ltRole);

			Xmlassist.setFormData(qrProspect, null, true, "Prospect" , "ProspectRecordSet");

		}

		Xmlassist.addTablePresentation("CustomerRecordSet", "", "ascending",
												"", custDefaultColumnOrder,
												custMandatoryColumns, "",
												custIdAttributeColumns, custRowIdentifier);

		Xmlassist.addTablePresentation("ContactRecordSet", "", "ascending",
												"", contDefaultColumnOrder,
												contMandatoryColumns, "",
										contIdAttributeColumns, contRowIdentifier);

		Xmlassist.addTablePresentation("ProspectRecordSet", "", "ascending",
												"", prosDefaultColumnOrder,
												prosMandatoryColumns, "",
												prosIdAttributeColumns, prosRowIdentifier);

		cData.add(new NameValue("starttm", startTime));
		cData.add(new NameValue("processId", processId));
		cData.add(new NameValue("processStep", stepId));
		cData.add(new NameValue("nextStep", nextStepId));
		cData.add(new NameValue("strictProc", strictProcess));
		cData.add(new NameValue("isConditional", isConditional));
		cData.add(new NameValue("startdt", startDate));
		cData.add(new NameValue("dueDate", dueDate));

		Xmlassist.setUserData ("CustomData", cData);

		XML xmlFile =   Xmlassist.getXmlDocument();
		XSLAssist.translate (sc.getSessionLocale(),
					xmlFile,xslFileName,xslFilePath, null, out);

    }
}
