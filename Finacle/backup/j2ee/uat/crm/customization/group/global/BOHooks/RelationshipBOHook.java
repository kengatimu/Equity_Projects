/******************************************************************************
* Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
*
* $Workfile: NonCustomerBOHook.java $
*
* Author:
*
* $Archive:
*
* *********************************** */


package com.infy.cis.custom;



import com.infy.cis.exception.SRMPostDeleteException;
import com.infy.cis.exception.SRMPostFillException;
import com.infy.cis.exception.SRMPostWriteException;
import com.infy.cis.exception.SRMPreDeleteException;
import com.infy.cis.exception.SRMPreFillException;
import com.infy.cis.exception.SRMPreWriteException;

import com.infy.cis.exception.SRMSecurityException;
import com.infy.cis.srmbo.AttrAccValidator;
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;

import com.infy.finacle.crypt.MsgDigest;
import java.util.Date;
import java.util.Properties;
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
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.cis.srmbo.RelationshipBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.SRMDataObject;
import com.infy.cis.exception.SRMTypeValidatorException;
import com.infy.cis.exception.CISContextException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.common.EditorUtil;
import com.infy.cis.srmbo.SRMQueryBuilder;
import com.infy.cis.srmbo.SRMQueryResult;
import com.infy.cis.srmbo.SRMRecordSet;
import com.infy.cis.ui.common.QueryAssist;
import com.infy.cis.srmbo.IQuery;
import  com.infy.cis.srmbo.RelationshipBO;
import  com.infy.cis.srmbo.AccountBO;
import  com.infy.cis.srmbo.ContactBO;
import  com.infy.cis.srmbo.SuspectBO;

public class RelationshipBOHook implements IHooks {

    public RelationshipBOHook() { }

    final public void preWrite(final SRMBusinessContext
    aBusiContxt, final Object aBoObj)
    throws SRMPreWriteException, SRMSecurityException {
        try {
            AttrAccValidator.validatecreate((SRMBase) aBoObj);
        } catch (SRMSecurityException e) {
            throw new SRMSecurityException(
                SRMSecurityException.ERROR_ATTR_MASK, null);
        }
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

	 final RelationshipBO aBoNew = (RelationshipBO) aBoObj;
	 String primeIntro = aBoNew.getPrimaryIntroducer();
	 if (primeIntro == null) {
		 primeIntro = "";
		 }

	 if (primeIntro.equalsIgnoreCase("Y")) {

	 String[] aString = new String[2];
	 final String parentEntity = aBoNew.getParentEntity();
	 final Integer prtEntityId = aBoNew.getParentEntityID();
	 aString[0] = aBoNew.getChildEntity();
	 if (aBoNew.getChildEntityID() != null) {
	 aString[1] = aBoNew.getChildEntityID().toString();}
	 else { aString[1] = "";}
	 for(int i=0; i<=1 ; i++){
		if(aString[i] == null){
			aString[i] = "";
		}
      }
	 /*** Account, Contact nd Suspect  using same fields
	       of RelationshipBO  for calculating CheckSum ***/

	 StringBuffer chkSumER = new StringBuffer(256);
	 for(int iAppend = 0; iAppend <= 1 ; iAppend++)
	 {
	    chkSumER.append(aString[iAppend]);
		chkSumER.append("|");
	 }
	  String chkSumCalc1 = MsgDigest.getDigestToken(chkSumER.toString());
	   aBoNew.setCheckSum(chkSumCalc1);
   }

   String parentEntity = aBoNew.getParentEntity();
   String childEntity = aBoNew.getChildEntity();
   Integer parentEntityID = aBoNew.getParentEntityID();
   Integer childEntityID = aBoNew.getChildEntityID();
   String CIFID = "";
   CIFID = getCIFID(parentEntity, parentEntityID, aBusiContxt);
   aBoNew.setParentCIFID(CIFID);
   CIFID = getCIFID(childEntity, childEntityID, aBusiContxt);
   aBoNew.setChildCIFID(CIFID);


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

    public void postWrite(final SRMBusinessContext aBusiContxt,
    final Object aBoObj)
    throws SRMPostWriteException {
    }

    public void preDelete(final SRMBusinessContext aBusiContxt,
    final Object aBoObj)
    throws SRMPreDeleteException {
    }

    public void postDelete(final SRMBusinessContext aBusiContxt,
    final Object aBoObj)
    throws SRMPostDeleteException {
    }

    public void preFill(final SRMBusinessContext aBusiContxt,
    final Object aBoObj)
    throws SRMPreFillException {
    }

    public void postFill(final SRMBusinessContext aBusiContxt,
    final Object aBoObj)
    throws SRMPostFillException {
    }



private String getCIFID (String entity, Integer entityID, SRMBusinessContext bc) throws Exception{

		List attr=new ArrayList();
		String CIFID = "";
try{
	if(entity == null){
		entity = "Customer";
	}
		if(entity.equalsIgnoreCase("Customer")){
			attr.add(AccountBO.ACCOUNTKEY);
			SRMQueryBuilder qb = new SRMQueryBuilder();

			qb	= QueryAssist.singleObjectQuery("AccountBO", AccountBO.ACCOUNTID);
			QueryAssist.addSimpleCondition(qb  ,"AccountBO",AccountBO.ACCOUNTID,
										IQuery.ComparisonOperation_EQ,
										entityID);

			QueryAssist.selectAttr( qb, "AccountBO", attr);
			SRMQueryResult qr = qb.runQuery(bc, false, -1);
			SRMRecordSet rs = qr.getRecordSet();

			while(rs.hasNext()){
				ArrayList rowObj = (ArrayList)rs.getNext();
				if(rowObj.get(0)!=null){
					CIFID= rowObj.get(0).toString();
				}
			}
		}else if(entity.equalsIgnoreCase("Contact")){
			attr.add(ContactBO.CONTACTSKEY);
			String accountKey = "";
			SRMQueryBuilder qb = new SRMQueryBuilder();

			qb	= QueryAssist.singleObjectQuery("ContactBO", ContactBO.CONTACTID);
			QueryAssist.addSimpleCondition(qb  ,"ContactBO",ContactBO.CONTACTID,
										IQuery.ComparisonOperation_EQ,
										entityID);

			QueryAssist.selectAttr( qb, "ContactBO", attr);
			SRMQueryResult qr = qb.runQuery(bc, false, -1);
			SRMRecordSet rs = qr.getRecordSet();

			while(rs.hasNext()){
				ArrayList rowObj = (ArrayList)rs.getNext();
				if(rowObj.get(0)!=null){
					CIFID= rowObj.get(0).toString();
				}
			}
		}else if(entity.equalsIgnoreCase("Prospect")){
			attr.add(SuspectBO.SUSPECTSKEY);
			String accountKey = "";
			SRMQueryBuilder qb = new SRMQueryBuilder();

			qb	= QueryAssist.singleObjectQuery("SuspectBO", SuspectBO.SUSPECTID);
			QueryAssist.addSimpleCondition(qb  ,"SuspectBO",SuspectBO.SUSPECTID,
										IQuery.ComparisonOperation_EQ,
										entityID);

			QueryAssist.selectAttr( qb, "SuspectBO", attr);
			SRMQueryResult qr = qb.runQuery(bc, false, -1);
			SRMRecordSet rs = qr.getRecordSet();

			while(rs.hasNext()){
				ArrayList rowObj = (ArrayList)rs.getNext();
				if(rowObj.get(0)!=null){
					CIFID= rowObj.get(0).toString();
				}
			}
		}

	}catch(Exception e){
		//System.out.println("in catch");
		e.printStackTrace();
	}
		return CIFID;
	}
}

