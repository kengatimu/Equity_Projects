/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CommonQueryFunctions.java $
 *
 * Author: Paritosh
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/CommonQueryFunctions.java $
 *
 * **************************************************************************/
/*This class is a common class for getting few fields from Incidents, Sales and ProdCat table from
	the databse.
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

import java.lang.*;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.ui.common.*;


import com.infosys.bankaway.accesslayer.user.*;
//import com.infy.intl.common.InterfaceDBAccess;
//import com.infy.intl.common.InterfaceResultSet;
/*Tracker 103058 : FI Call Change :Start
import com.infosys.bankaway.accesslayer.accounts.*;
import com.infy.intl.common.*;
Tracker 103058 : FI Call Change :End*/
public class CommonQueryFunctions{

	/*
	 * The method chops the primary key /id out of the bo.
	 *
	 * @param url - BO url
	 * @return Integer - The return will be primary key of the bo
	 * @exception Exception
	 */
	public static Integer getIDFromURL(String url) throws Exception{

		String strColon = ":";
		Integer  iID = null;
		int index = url.lastIndexOf(strColon) + 1;
		String  strID = url.substring(index);
		if( strID !=null){
			if(!strID.trim().equals("")){
				iID=  new Integer(strID);
			}
		}
		return iID;
	}

	/*
	 * The method fetches data from Sales table on the basis of Account Number.
	 *
	 * @param AccountNumber - Finacle Account number
	 * @param bc - SRMBusiness Context
	 * @return List - This list contains the values fetched from Sales table
	 * @exception Exception
	 */
	public static List getSalesData (String  AccountNumber , SRMBusinessContext bc)  throws Exception{

		ArrayList  saleAttrList = new ArrayList();
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.SALESID));
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.PRODUCTSKEY));
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.APPLCURRENCY));
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.ACCBRANCHCODE));
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.PRODCATID));
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.SALECUSTOMER_ORGID));

		//changes for 417147 to fetch ProductType --- start
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.PRODUCTTYPE));
		//changes for 417147 to fetch ProductType --- end
		SRMQueryBuilder qbSales = new SRMQueryBuilder();
		QueryAssist.addJoin(qbSales,"SaleBO", SaleBO.ACCOUNTNUMBER,
		"SaleBO", SaleBO.ACCOUNTNUMBER, IQuery.JoinType_Inner);

		QueryAssist.addSimpleCondition(qbSales, "SaleBO", SaleBO.ACCOUNTNUMBER,
		IQuery.ComparisonOperation_EQ,"" + AccountNumber);
		int noOfAttrs = saleAttrList.size();

		for (int j=0; j<noOfAttrs; j++){
			qbSales.addAttribScope((TransFormFn) saleAttrList.get(j));
		}
		//running the query
		SRMQueryResult qrSales = qbSales.runQuery( bc, false,-1);
		//getting the SRM recordset
		SRMRecordSet rsSales = qrSales.getRecordSet();
		List salelist = null;
		if(rsSales.hasNext()) {
			salelist =   rsSales.getNext();
		}
		rsSales.resetIndex();
		return	salelist;
	}


	public static List getSalesData (Integer  SalesID , SRMBusinessContext bc )  throws Exception{
		ArrayList  saleAttrList = new ArrayList();
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.SALESID));
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.PRODUCTSKEY));
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.APPLCURRENCY));
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.ACCBRANCHCODE));
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.PRODCATID));
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.SALECUSTOMER_ORGID));
		saleAttrList.add(QueryAssist.getTransformFn("SaleBO", SaleBO.ACCOUNTNUMBER));


		SRMQueryBuilder qbSales = new SRMQueryBuilder();
		QueryAssist.addJoin(qbSales,"SaleBO", SaleBO.SALESID,
		"SaleBO", SaleBO.SALESID, IQuery.JoinType_Inner);

		QueryAssist.addSimpleCondition(qbSales, "SaleBO", SaleBO.SALESID,
		IQuery.ComparisonOperation_EQ,"" + SalesID);

		int noOfAttrs = saleAttrList.size();

		for (int j=0; j<noOfAttrs; j++){
			qbSales.addAttribScope((TransFormFn) saleAttrList.get(j));
		}
		//running the query
		SRMQueryResult qrSales = qbSales.runQuery( bc, false,-1);
		//getting the SRM recordset
		SRMRecordSet rsSales = qrSales.getRecordSet();
		List salelist = null;
		if(rsSales.hasNext()) {
			salelist =   rsSales.getNext();
		}
		rsSales.resetIndex();
		return	salelist;
	}

	public static List getSaleBackEndData (Integer iSalesID , SRMBusinessContext bc )  throws Exception{

		ArrayList  saleBackEndAttrList = new ArrayList();
		saleBackEndAttrList.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.BACKENDID));
		saleBackEndAttrList.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.ACCOUNTCURRENCY));
		saleBackEndAttrList.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.ACCOUNTOPENINGDATE));
		// Tracker ID : 127280 - Begin of Changes
		/* Tracker ID : 149452 - Start of Changes */
		/* Uncommented the below line */
		saleBackEndAttrList.add(QueryAssist.getTransformFn("SaleBackEndBO", SaleBackEndBO.APPLLIMITEXPIRYDATE));
		/* Tracker ID : 149452 - End of Changes */
		// Tracker ID : 127280 - Begin of Changes
		SRMQueryBuilder qbSaleBackEnd = new SRMQueryBuilder();
		QueryAssist.addJoin(qbSaleBackEnd,"SaleBackEndBO", SaleBackEndBO.SALESID,
		"SaleBackEndBO", SaleBackEndBO.SALESID, IQuery.JoinType_Inner);

		QueryAssist.addSimpleCondition(qbSaleBackEnd, "SaleBackEndBO", SaleBackEndBO.SALESID,
		IQuery.ComparisonOperation_EQ,"" + iSalesID);

		int noOfAttrs = saleBackEndAttrList.size();

		for (int j=0; j<noOfAttrs; j++){
			qbSaleBackEnd.addAttribScope((TransFormFn) saleBackEndAttrList.get(j));
		}
		//running the query
		SRMQueryResult qrSaleBackEnd = qbSaleBackEnd.runQuery( bc, false,-1);
		//getting the SRM recordset
		SRMRecordSet rsSaleBackEnd = qrSaleBackEnd.getRecordSet();
		List saleBackEndList = null;
		if(rsSaleBackEnd.hasNext()) {
			saleBackEndList =   rsSaleBackEnd.getNext();
		}
		rsSaleBackEnd.resetIndex();
		return	saleBackEndList;
	}




	/*
	 * The method fetches data from RefCodeMapper table on the basis of CRM Category Type and
	 *	CRM Category Value.
	 *
	 * @param CRMCategoryType - CRM data Category Type
	 * @param CRMCategoryValue - CRM data Category Value
	 * @param CRMValueDesc - CRM data Category Description
	 * @return String - Finacle equivalent of the CRM value
	 * @exception Exception
	 */
	/*Get data from RefCodeMapper-Start*/
	public static String getDataFromRefCodeMapper(  String CRMCategoryType
																				, String CRMCategoryValue
																				, String	CRMValueDesc )
																				throws Exception{

		String query = null;
		Vector vctParams = new Vector();
		if ( CRMValueDesc != null){
				query = "select Back_End_RefCode FROM CMap WHERE Ref_Code_Type = ? and Back_End_RefDesc = ?";
				vctParams.add(CRMCategoryType.trim());
				vctParams.add(CRMValueDesc.trim());
		}else{
				query = "select Back_End_RefCode FROM CMap WHERE Ref_Code_Type = ? and Front_End_RefDesc = ?";
				vctParams.add(CRMCategoryType.trim());
				vctParams.add(CRMCategoryValue.trim());
		}
		String prodRefCode = null;
		/*Tracker 103058 : FI Call Change :Start
		InterfaceResultSet rs= InterfaceDBAccess.getResultSetFromInterface(query,vctParams,false);
		if(rs.next()){
			prodRefCode = rs.getString("Back_End_RefCode");
		}
		rs.close();
		Tracker 103058 : FI Call Change :End*/
		return prodRefCode;
  	}

	/*Get data from RefCodeMapper-End*/


	/*
	 * The method fetches data from Incident table on the basis of Incident id .
	 *
	 * @param IncidentID - Incident ID
	 * @param bc - SRMBusiness Context
	 * @return List - This list contains the values fetched from Incident table
	 * @exception Exception
	 */
	/*Getting data from Incident table-Start*/
	public static List getInciData (Integer  IncidentID , SRMBusinessContext bc)  throws Exception{
		ArrayList inciAttrList = new ArrayList();

		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.INCIDENTID));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.PROCESSID));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.CURRENTSTEP));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.ACCOUNTNUMBER));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.STATUS));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.SALESID));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.SERVICEREQUESTTYPE));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.FRONTENDPROCESSOR));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.PRODUCTPROCESSOR));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.STARTDATE));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.ACCBRANCHCODE));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.ACCCURRENCYCODE));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.ACCPRODUCTSKEY));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.ACCOUNTID));
		//**CRM62ENH-ONS** Tracker- 58813 change started
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.LINK));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.REQUESTCLASSIFICATION));
		//**CRM62ENH-ONS** Tracker- 58813 change ended

		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.CRMCUSTID));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.FUTUREFLAG));
		inciAttrList.add(QueryAssist.getTransformFn("IncidentBO", IncidentBO.CASEID));


		SRMQueryBuilder qbIncident = new SRMQueryBuilder();
		//forming the query
		QueryAssist.addJoin(qbIncident,"IncidentBO", IncidentBO.INCIDENTID,
		"IncidentBO", IncidentBO.INCIDENTID, IQuery.JoinType_Inner);

		QueryAssist.addSimpleCondition(qbIncident, "IncidentBO", IncidentBO.INCIDENTID,
		IQuery.ComparisonOperation_EQ,"" + IncidentID);


		int noOfAttrs = inciAttrList.size();
		for (int i=0; i<noOfAttrs; i++){
			qbIncident.addAttribScope((TransFormFn) inciAttrList.get(i));
		}
		//running the query
		SRMQueryResult qrIncident = qbIncident.runQuery( bc, false,-1);
		//getting the SRM recordset
		SRMRecordSet rsIncident = qrIncident.getRecordSet();
		List incilist =   null;
		//getting processid and currentstepid for the incident
		if(rsIncident.hasNext()) {
			incilist =   rsIncident.getNext();
		}
		rsIncident.resetIndex();
		return incilist;
	}

	/*Getting data from Incident table-End*/

	/*Method for removing space in between in a String*/
	public static String getStrWithoutSpace(String str) throws Exception{
		StringBuffer sbf = new StringBuffer(str);
		StringBuffer sbfacc = new StringBuffer();
			for (int i=0;i< sbf.length() ;i++ )
			{
			char ch = 	 sbf.charAt(i);
			if (ch!=' ')
			{
			sbfacc.append(ch);
			}
			}
			return sbfacc.toString();
	}

	/*
	 * The method fetches Product category value  from ProdCat table on the basis of ProdCatID.
	 *
	 * @param ProdCatID - Product category ID
	 * @param bc - SRMBusiness Context
	 * @return List - This String  contains the Product category value  fetched from ProdCat table
	 * @exception Exception
	 */
	/*getting Account type description from Prodcat table on the basis of ProdCatId-start*/
	public static String getAccountType( Integer prodCatID , SRMBusinessContext bc)  throws Exception {
		ArrayList prodcatAttrList = new ArrayList();
		prodcatAttrList .add(QueryAssist.getTransformFn("ProductCategoryBO", ProductCategoryBO.PRODCATID));
		prodcatAttrList .add(QueryAssist.getTransformFn("ProductCategoryBO", ProductCategoryBO.CATEGORYNAME));

		SRMQueryBuilder qbProdCat = new SRMQueryBuilder();
		QueryAssist.addJoin(qbProdCat,"ProductCategoryBO", ProductCategoryBO.PRODCATID,
		"ProductCategoryBO", ProductCategoryBO.PRODCATID, IQuery.JoinType_Inner);

		QueryAssist.addSimpleCondition(qbProdCat, "ProductCategoryBO", ProductCategoryBO.PRODCATID,
		IQuery.ComparisonOperation_EQ,"" + prodCatID);

		int noOfAttrs = prodcatAttrList .size();
		for (int j=0; j<noOfAttrs; j++){
			qbProdCat.addAttribScope((TransFormFn) prodcatAttrList.get(j));
		}
		//running the query
		SRMQueryResult qrProdCat = qbProdCat.runQuery( bc, false,-1);
		//getting the SRM recordset
		SRMRecordSet rsProdCat = qrProdCat.getRecordSet();

		String  accountType=null;

		if(rsProdCat.hasNext()) {
			List prodcatlist =   rsProdCat.getNext();
			if( prodcatlist.get(1) != null){
				accountType = (String)prodcatlist.get(1);
			}
		}
		rsProdCat.resetIndex();
		return accountType;
	}
	/*getting Account type description from Prodcat table on the basis of ProdCatId-end*/

	/// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
	public static String  getOrgKey (Integer orgID, SRMBusinessContext bc)
	throws Exception	{
		SRMQueryBuilder qb = new SRMQueryBuilder();
		qb.addJoinScope (
			IQuery.LogicalOperation_AND,
			AccountBO.ATTR_URL_,
			IQuery.JoinType_Equi,
			AccountBO.ATTR_URL_	);
		qb.addAttribScope (new TransFormFn (AccountBO.ATTR_ACCOUNTKEY));
		qb.addCondition (
			IQuery.LogicalOperation_AND,
			new SRMQueryExpr (new SRMAttributeInfo (AccountBO.class, AccountBO.ACCOUNTID)),
			IQuery.ComparisonOperation_EQ,
			new SRMQueryExpr (orgID)	);

		SRMRecordSet rs = qb.runQuery (bc, false, 1).getRecordSet();
		return rs.hasNext() ? (String)rs.getNext().get(0) : null;
	}
	/// NCB_226, TRACKER# 51444, END OF CHANGES


	/* TRACKER 60196 - BEGIN CHANGES ***/
	public static RequestBO getRequestData (SRMBusinessContext bc,
													Integer incidentID,
					 								boolean complete)
					throws Exception {
			RequestBO reqBO = null;
			SRMQueryBuilder qb = new SRMQueryBuilder();
			QueryAssist.addJoin(qb,"RequestBO", RequestBO.REQUESTID,
			"RequestBO", RequestBO.REQUESTID, IQuery.JoinType_Inner);

			QueryAssist.addSimpleCondition(qb, "RequestBO", RequestBO.INCIDENTID,
			IQuery.ComparisonOperation_EQ, incidentID);
			//running the query
			SRMQueryResult qr = qb.runQuery( bc, complete,-1);
			SRMRecordSet rs = qr.getRecordSet();
			List list =   null;

			if(rs.hasNext()) {
				list =   rs.getNext();
				reqBO = (RequestBO)list.get(0);
			}
			return reqBO;

	}
	/* TRACKER 60196 - END CHANGES ***/

}//End of Class


