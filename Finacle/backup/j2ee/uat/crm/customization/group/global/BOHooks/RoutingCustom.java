/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: $
 *
 * Author: Sonia Kar
 *
 * $Archive:  $
 *
 * $History:  $
 *
 *****************************************************************************/
 package com.infy.cis.custom;

 import com.infy.cis.srmbo.*;
 import com.infy.cis.ui.common.QueryAssist;
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
 import com.infy.cis.srmbo.security.user.SRMBusinessContext;
 /*Recon of ticket 346250*/
 import com.infy.cis.exception.SRMBOException;
 import com.infy.cis.exception.SRMSecurityException;
 import com.infy.cis.exception.CISInvalidArgumentException;
 import com.infy.cis.adaptor.web.WebAdaptor;

public class RoutingCustom {
	 /***************************************************************************
	  * Function	:	setRoutingAlgo()
	  *	Parameter	:	no parameters
	  *	Return		:	String
	  ***************************************************************************/

	  public String setRoutingAlgo() {
		String strUserID = "";
		try{

		}catch(Exception e){
			e.printStackTrace();
		}
		return strUserID;
	  }


	  /***************************************************************************
	   * Function	:	setBestUser()
	   * Parameter	:	no parameters
	   * Return		:	String
	   ***************************************************************************/

	   public String setBestUser(String strEntityFor,SRMBusinessContext bc,String strTypeID) {
		String strAsgnGrpID = "";
		try{
			/*
			 * here customization logic will come.
			 */
			/*Recon of ticket 346250*/
			WebAdaptor.logTrace(com.infy.cis.log.LogType.DEBUG,"In set Best User");
			Integer relManagerID = new Integer(0);
			List list = new ArrayList();
			//SRMQueryBuilder qb = new SRMQueryBuilder();
			//SRMQueryResult qrRes = null;
			//SRMRecordSet rs = null;
			String strRelManID = "";
			//if(strEntityFor.trim().equalsIgnoreCase("Customer")){
			strEntityFor=strEntityFor.trim();
			if(strEntityFor.equalsIgnoreCase("RetailCustomer")){
				strAsgnGrpID=getBestUser( bc, strTypeID,"AccountModBO",AccountModBO.ACCOUNTID,AccountModBO.ATTR_ACCESSOWNERAGENT);
				if( (strAsgnGrpID != null && strAsgnGrpID.equals("")) || strAsgnGrpID == null){
				      strAsgnGrpID=getBestUser( bc, strTypeID,"AccountBO",AccountBO.ACCOUNTID,AccountBO.ATTR_ACCESSOWNERAGENT);
				}
				/*qb = QueryAssist.singleObjectQuery("AccountBO",AccountBO.ACCOUNTID);
				qb.addAttribScope(AccountBO.ATTR_RELATIONSHIPMGRID);
				QueryAssist.addSimpleCondition(qb, "AccountBO", AccountBO.ACCOUNTID, IQuery.ComparisonOperation_EQ,new Integer(strTypeID));
				qrRes = qb.runQuery(bc, false,-1);
				rs = qrRes.getRecordSet();
				while(rs.hasNext()) {
					list = (ArrayList)rs.getNext();
					if(list.size() >0 ) {
						relManagerID = (Integer)list.get(0);
						break;
					}
				}
				strRelManID = "" + relManagerID;
				if((strRelManID != null) && !(strRelManID.trim().equals("")) && !(strRelManID.trim().equals("0"))){
					strAsgnGrpID = strRelManID;
					//hasUserChosen = "true";
				}*/
			}else if( strEntityFor.equalsIgnoreCase("CorporateCustomer")){
				strAsgnGrpID=getBestUser( bc, strTypeID,"CorporateModBO",CorporateModBO.CORP_MOD_ID,CorporateModBO.ATTR_ACCESSOWNERAGENT);
				if( (strAsgnGrpID != null && strAsgnGrpID.equals("")) || strAsgnGrpID == null){
					strAsgnGrpID=getBestUser( bc, strTypeID,"CorporateBO",CorporateBO.CORP_ID,CorporateBO.ATTR_ACCESSOWNERAGENT);
					}
			}else if(strEntityFor.trim().equalsIgnoreCase("Contact")){
				strAsgnGrpID=getBestUser( bc, strTypeID,"ContactBO",ContactBO.CONTACTID,ContactBO.ATTR_RELATIONSHIPMGRID);
				/*qb = QueryAssist.singleObjectQuery("ContactBO",ContactBO.CONTACTID);
				qb.addAttribScope(ContactBO.ATTR_RELATIONSHIPMGRID);
				QueryAssist.addSimpleCondition(qb, "ContactBO", ContactBO.CONTACTID, IQuery.ComparisonOperation_EQ,new Integer(strTypeID));
				qrRes = qb.runQuery(bc, false,-1);
				rs = qrRes.getRecordSet();
				while(rs.hasNext()) {
					list = (ArrayList)rs.getNext();
					if(list.size() >0 ) {
						relManagerID = (Integer)list.get(0);
						break;
					}
				}
				strRelManID = "" + relManagerID;
				if((strRelManID != null) && !(strRelManID.trim().equals("")) && !(strRelManID.trim().equals("0"))){
					strAsgnGrpID = strRelManID;
					//hasUserChosen = "true";
				}*/
			}else{
				strAsgnGrpID=getBestUser( bc, strTypeID,"SuspectBO",SuspectBO.SUSPECTID,SuspectBO.ATTR_RELATIONSHIPMGRID);
				/*qb = QueryAssist.singleObjectQuery("SuspectBO",SuspectBO.SUSPECTID);
				qb.addAttribScope(SuspectBO.ATTR_RELATIONSHIPMGRID);
				QueryAssist.addSimpleCondition(qb, "SuspectBO", SuspectBO.SUSPECTID, IQuery.ComparisonOperation_EQ,new Integer(strTypeID));
				qrRes = qb.runQuery(bc, false,-1);
				rs = qrRes.getRecordSet();
				while(rs.hasNext()) {
					list = (ArrayList)rs.getNext();
					if(list.size() >0 ) {
						relManagerID = (Integer)list.get(0);
						break;
					}
				}
				strRelManID = "" + relManagerID;
				if((strRelManID != null) && !(strRelManID.trim().equals("")) && !(strRelManID.trim().equals("0"))){
					strAsgnGrpID = strRelManID;
					//hasUserChosen = "true";
				}*/
			}

		}catch(Exception e){
			e.printStackTrace();
		}
		return strAsgnGrpID;
	   }
		/**
		   *  Function for finding the Best user for Corporate
		   * @param bc
		   * @param strTypeID
		   * @param boName
		   * @param boId
		   * @param attribute
		   * @return
		   * @throws SRMBOException
		   * @throws SRMSecurityException
		   * @throws CISInvalidArgumentException
		   * @throws ClassNotFoundException
	       */
	           private String getBestUser(SRMBusinessContext bc, String strTypeID,String boName,String boId,SRMStdAttributeInfo attribute)
	                           throws SRMBOException, SRMSecurityException,
	                           CISInvalidArgumentException, ClassNotFoundException {
	                   SRMQueryBuilder qb = new SRMQueryBuilder();
	                   SRMQueryResult qrRes = null;
	                   SRMRecordSet rs = null;
	                   /*qb = QueryAssist.singleObjectQuery("CorporateModBO",
	                                   CorporateModBO.CORP_MOD_ID);
	                   qb.addAttribScope(CorporateModBO.ATTR_ACCESSOWNERAGENT);
	                   QueryAssist.addSimpleCondition(qb, "CorporateModBO",
	                                   CorporateModBO.CORP_MOD_ID, IQuery.ComparisonOperation_EQ,
	                                   new Integer(strTypeID));*/
	                   qb=QueryAssist.singleObjectQuery(boName, boId);
	                   qb.addAttribScope(attribute);
	                   QueryAssist.addSimpleCondition(qb,boName,boId,IQuery.ComparisonOperation_EQ,new Integer(strTypeID));
	                   qrRes = qb.runQuery(bc, false, -1);
	                   rs = qrRes.getRecordSet();
	                   ArrayList list = null;
	                   Integer bestUser = null;
	                   while (rs.hasNext()) {
	                           WebAdaptor.logTrace(com.infy.cis.log.LogType.DEBUG,
	                                           "setBestUser:User found");
	                           list = (ArrayList) rs.getNext();
	                           if (list.size() > 0) {
	                                   bestUser = (Integer) list.get(0);
	                                   break;
	                           }
	                   }

	                   if ((bestUser != null)) {
	                           return bestUser.toString();

	                   } else
	                           return "";

	           }

	   /******************************************************************************************
	    *	Function	:	setBetterLocation()
	    					Customised file for Better Location Routing.
	    ******************************************************************************************/

	    public ArrayList setBetterLocation() {
			ArrayList arrRet = new ArrayList();
			/*try{

			}catch(Exception e){
				e.printStackTrace();
			}*/
			return arrRet;
		}
   }//end of class