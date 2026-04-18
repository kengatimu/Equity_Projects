/******************************************************************************
 * Copyright (c) 2000-2006 Infosys Ltd.  All rights reserved.
 *
 * $Workfile  : CheckSumHelper.java $
 *
 * Author     : Greety Varghese
 *
 * $Archive   :
 *
 * $History   : CheckSumHelper.java $
 *
 *****************************************************************************/

// Package declaration
package com.infy.cis.custom;
// Import classes

import com.infy.cis.exception.CISInvalidArgumentException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.exception.SRMSecurityException;
import com.infy.cis.exception.SRMTypeValidatorException;
import com.infy.cis.srmbo.CheckSumErrorBO;
import com.infy.cis.srmbo.Core;
import com.infy.cis.srmbo.IQuery;
import com.infy.cis.srmbo.SRMAttributeInfo;
import com.infy.cis.srmbo.SRMQueryBuilder;
import com.infy.cis.srmbo.SRMQueryExpr;
import com.infy.cis.srmbo.SRMQueryResult;
import com.infy.cis.srmbo.SRMRecordSet;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.ui.common.QueryAssist;

/**
* File with functions for writing into CheckSumErrorBO
* and for getting BO from attribute
* @author Vijay
*/


public final class CheckSumHelper
{
	// Constructor

	private CheckSumHelper()
	{
		// No Implementation
	}

	/**
	* Function			writeCheckSumError
	* Description		writes into the CheckSumErrorBO
	* @param 			aBusiCntxt	Business Context
	* @param      		aEntityType  Type of entity
	* @param 			aEntityID	ID of entity
	*/

	public static void writeCheckSumError(SRMBusinessContext aBusiCntxt,
										  String aEntityType,
										  int aEntityID
										  ,String sOrgkey)
	{


		final Integer entID = new Integer(aEntityID);

		CheckSumErrorBO boErrChkSum = null;

		//	Query builder object to query on the CheckSumErrorBO
		/*	To find out if an entry exists for the particular EntityID
			and EntityType*/
	try
	{
		final SRMQueryBuilder qryBldr = QueryAssist.singleObjectQuery(
												"CheckSumErrorBO",
												CheckSumErrorBO.CHECKSUMID);

		QueryAssist.addSimpleCondition(qryBldr,"CheckSumErrorBO",
									   CheckSumErrorBO.ENTITYID,
									   IQuery.ComparisonOperation_EQ, entID);

		QueryAssist.addSimpleCondition(qryBldr,"CheckSumErrorBO",
									   CheckSumErrorBO.ENTITYNAME,
									   IQuery.ComparisonOperation_EQ,
									   aEntityType);


		//	Execute the query and return the resultset
		final SRMQueryResult qryResult = qryBldr.runQuery(aBusiCntxt, true, -1);
		final SRMRecordSet resultSet = qryResult.getRecordSet();

		if (resultSet.hasNext())
		{
			boErrChkSum = (CheckSumErrorBO)(resultSet.getNext()).get(0);

		}

		/*
			Check if a record for the entity exists. If no, set the fields
			and save the busiObj.If record exists, check if IsReset is "Y".
			If so, then also set the fields and	save the busiObj
		*/
			if(boErrChkSum==null || boErrChkSum.getIsReset().equalsIgnoreCase("Y")
								 || ("Y").equalsIgnoreCase(boErrChkSum.getSentForApproval()))
			{
				//	Instantiate the busiObj and set the fields
				boErrChkSum=new CheckSumErrorBO();
				boErrChkSum.setEntityName(aEntityType);
				boErrChkSum.setEntityID(new Integer(aEntityID));
				final java.util.Date loggedDate = new java.util.Date();
				boErrChkSum.setLoggedDate(loggedDate);
				boErrChkSum.setIsReset("N");
				boErrChkSum.setStrField1(sOrgkey);
				Core.saveCheckSumErrorBO(aBusiCntxt,boErrChkSum);
			}

	}
		 catch(CISInvalidArgumentException cisEx)
		{
			cisEx.printStackTrace();
		}
		catch(SRMBOException boEx)
		{
			boEx.printStackTrace();
		}
		catch(SRMTypeValidatorException srmTypeEx)
		{
			srmTypeEx.printStackTrace();
		}
		catch(SRMSecurityException secEx)
		{
			secEx.printStackTrace();
		}
		catch(ClassNotFoundException clsEx)
		{
			clsEx.printStackTrace();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}

	}


	/**
	* Function		getBOForAttr
	* Description	get BO for the particular BO and attribute
	* @param		aBusiCntxt			Business Context
	* @param		aBOName				Name of BO
	* @param		aBOPrimAttr	Primary Attribute of BO
	* @param		aValue				Value of the attribute
	* @return 		busiObj 	Object
	*/

	  public static Object getBOForAttr(SRMBusinessContext aBusiCntxt,
										String aBOName,
										String aBOPrimAttr,
	  									Object aValue)

	    {
			Object busiObj = null;
			try
			{
				Class boClass;
        		boClass = Class.forName("com.infy.cis.srmbo." + aBOName);

        		// New QB object for fetching the BO
        		final SRMQueryBuilder qryBldr = new SRMQueryBuilder();
				final SRMAttributeInfo joinAttr = new SRMAttributeInfo(boClass,
														   aBOPrimAttr);

	        	// Add join scope
	        	qryBldr.addJoinScope (qryBldr.LogicalOperation_AND, joinAttr,
	        					 qryBldr.JoinType_Equi, joinAttr);

				// Add condition for querying that particular record
	        	qryBldr.addCondition (qryBldr.LogicalOperation_AND,
	        					new SRMQueryExpr(joinAttr),
	        					qryBldr.ComparisonOperation_EQ,
	        					new SRMQueryExpr(aValue));

				// Exceute the query and return result set
	        	final SRMRecordSet resultSet =
	        				qryBldr.runQuery(aBusiCntxt,true,1).getRecordSet();

				// Check for the BO and return it
	        	if (resultSet.hasNext()){
					busiObj = resultSet.getNext().get(0);
					if(busiObj !=null){
						return busiObj;
					}
				}
			}


			catch(CISInvalidArgumentException cisEx)
			{
				cisEx.printStackTrace();
			}

			catch(SRMBOException boEx)
			{
				boEx.printStackTrace();
			}

			catch(SRMSecurityException secEx)
			{
				secEx.printStackTrace();
			}

			catch(ClassNotFoundException clsEx)
			{
				clsEx.printStackTrace();
			}

			return null;
    	}
 }


