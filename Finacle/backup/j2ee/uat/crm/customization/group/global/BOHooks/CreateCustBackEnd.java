/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CreateCustBackEnd.java $
 *
 * Author: $
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/CreateCustBackEnd.java $
 *
 * $History: CreateCustBackEnd.java $
 *
 * *****************  Version 1  *****************
 * User: Nixon        Date: 2/26/04    Time: 11:10a
 * Created in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * Tracker Id: 60682
 * Added by :Jayanthi
 * Reviewed by : Nixon
 *
 * *****************  Version 2  *****************
 * User: Sumedh_samant Date: 1/22/04    Time: 7:48p
 * Updated in $/FCRM62BASE/com/infy/cis/ui/sales
 * Tracker number: 61030/61031
 * Changes. Related to ML.
 * Modified by:
 * Sumedh and Raghv
 * Reviewed by:
 * Shiva(201005) & Manoj
 *
 * *****************  Version 1  *****************
 * User: Raghavendren_b Date: 12/23/03   Time: 9:54a
 * Created in $/FCRM62BASE/com/infy/cis/ui/sales
 * TrackerID: 60106
 * Added a new file for Create Customer at Backend Process step.
 *
 * Added By:
 * Raghavendren
 *
 * Reviewed By:
 * Nixon.
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
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.srmbo.XML;
import com.infy.cis.viewcfg.*;

   /*
	*Brief Description of class:
	*
	*Functionality:	This Servlet shows a list of related parties who are customers and
	*				specified in the role category.
	*
	*External Methods called:
	*
	*Start Date: 12/19/03
	*
	*Modification log :
    */

public class CreateCustBackEnd extends CISHttpServlet
{
    public static String CIS_COPYRIGHT_ = "Copyright (c) 2000-2005 Infosys Tech. Ltd.  All rights reserved.";
    public static String CIS_VERSION_ = "2.00 $Revision: 1.1 $";

/* $NoKeywords: $ */

    protected void serviceRequest(HttpServletRequest req, HttpServletResponse resp)
    throws Exception
    {
		setContentType("text/html", resp);
		PrintWriter out = resp.getWriter();
		out.println("<SCRIPT LANGUAGE='javascript' src=\"../common/js/SSOParameter.js \"></SCRIPT>");
		out.println("<script>parent.parent.parent.parent.frames(3).saveBut.value = 'Create Customer';</script>");

		SRMBusinessContext bc = Utils.getBusinessContext(req);

		CISSessionContext sc = context.getSessionContext(req);

		Views view = ConfigManager.getInstance().
				findView("CreateCustBackEnd", bc);

		String custRowIdentifier 	= view.getRowIdentifier();
		String custRequiredColumns 	= Utils.getOrderedRequiredColumnList(view.getRequiredItems());
		String custIdAttributeColumns = Utils.getIdAttributeColumns(view);

		String xslFile 			= view.getXslFileName();
		String xslFileName 		= Utils.getXslFileName(xslFile);
		String xslFilePath 		= Utils.getXslFilePath(xslFile);
		String objectId 		= req.getParameter("objectId");
		String salesId			= req.getParameter("SaleBO.salesID");
		String prodID			= req.getParameter("SaleBO.productID");

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
		if( salesId != null && !salesId.trim().equals("")) {

			ArrayList applIDNVList 			= new ArrayList();
			SRMNVPair nv 					= new SRMNVPair(SaleBO.SALESID, new Integer(salesId));
			applIDNVList.add(nv);
			String saleURL 					= SRMURLResolver.generateURL(applIDNVList,"SaleBO");


			ArrayList prodIDNVList 			= new ArrayList();
			SRMNVPair nv1 					= new SRMNVPair(ProductBO.PRODUCTID, prodID);
			prodIDNVList.add(nv1);
			String prodURL 					= SRMURLResolver.generateURL(prodIDNVList,"ProductBO");
			ProductBO product 				= (ProductBO)SRMURLResolver.getPartialObject ( bc, prodURL);

			String sCrCustOnLine			= product.getCreateCustomerOnLine();

			cData.add(new NameValue("saleURL", saleURL));
			cData.add(new NameValue("objectID", objectId));

			if(sCrCustOnLine == null)
				sCrCustOnLine = "N";
			cData.add(new NameValue("CrCustOnLine", sCrCustOnLine));


			SRMQueryResult qrCustomer = getResultDet(bc, view, custRowIdentifier, saleURL);

			Xmlassist.setFormData(qrCustomer, null, true, "Customer" , "CustomerRecordSet");

		}

		Xmlassist.addTablePresentation("CustomerRecordSet", "", "ascending",
												"", custRequiredColumns,
												custRequiredColumns, "",
												custIdAttributeColumns, custRowIdentifier);

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

    public SRMQueryResult getResultDet(SRMBusinessContext bc, Views view,
    								String custRowIdentifier, String saleURL)
    	throws CISInvalidArgumentException, SRMSecurityException, SRMBOException, CISConfigException,ClassNotFoundException,
    		SRMViewsException, Exception
    {
		SRMQueryBuilder qb = new SRMQueryBuilder();
		RunQuery.buildJoins(qb, view);
		String selectClause = view.getSelectClause(bc);

		if(selectClause != null && ! selectClause.trim().equals("")){
			if(custRowIdentifier != null && custRowIdentifier.length() > 1)
			{
				char[] COMMA = {','};
				selectClause += "," + Escaper.escape(custRowIdentifier,'\\',COMMA);
			}
			RunQuery.tokenizeQueryClause(qb, selectClause, view, 1);
		}
		ArrayList ltRole = new ArrayList();

		SRMQueryResult qrRole = CommonQueries.getRelationCategories(bc,
							com.infy.cis.ui.common.Constants.ROLECAT);
		SRMRecordSet rsRole	  = qrRole.getRecordSet();

		while(rsRole.hasNext()) {
			ArrayList altemp = (ArrayList)rsRole.getNext();
			ltRole.add((String)altemp.get(0));
		}

		QueryAssist.addSimpleCondition(qb, "SaleBO", SaleBO.URL_,
									IQuery.ComparisonOperation_EQ, ""+saleURL);
		QueryAssist.addSimpleCondition(qb, "SaleBO", SaleBO.SALECUSTOMER_ORGID,
									IQuery.ComparisonOperation_ISNOTNULL, "");
		QueryAssist.addSimpleCondition(qb, "SaleBO", SaleBO.SALECUSTOMER_ROLE,
									IQuery.ComparisonOperation_IN, ltRole);

		SRMQueryResult qr = qb.runQuery(bc, -1);
		return qr;
	}
}
