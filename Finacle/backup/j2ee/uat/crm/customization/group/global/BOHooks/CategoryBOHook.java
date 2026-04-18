/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CategoryBOHook.java $
 *
 * Author:
 *
 * $Archive:
 *
 * *********************************** */

package com.infy.cis.custom;

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

import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.*;
import com.infy.cis.srmbo.ApplRelPartyXML;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
import com.infy.cis.common.dbmgr.*;
import com.infy.cis.ui.common.Category;
import com.infy.cis.ui.common.QueryAssist;



public class CategoryBOHook implements IHooks {

	public static String STRSEPERATOR = "_";
	public static boolean flag = false;
   public CategoryBOHook(){}

// sample hook - postWrite

	public void preWrite (SRMBusinessContext bc, Object bo)
	 throws SRMPreWriteException {
	   // customized implementation place holder
	   	getCategory(bc,bo);
	 }


// sample hook - postWrite

  public void postWrite (SRMBusinessContext bc, Object bo)
    throws SRMPostWriteException {
   }

// sample hook - preDelete
  public void preDelete (SRMBusinessContext bc, Object bo)
    throws SRMPreDeleteException {
           // customized implementation place holder

   }

// sample hook - postDelete
  public void postDelete (SRMBusinessContext bc, Object bo)
    throws SRMPostDeleteException {
           // customized implementation place holder
         }
// sample hook - preFill

  public void preFill (SRMBusinessContext bc, Object bo)
    throws SRMPreFillException {
    	   // customized implementation place holder

   }

// sample hook - postFill
  public void postFill (SRMBusinessContext bc, Object bo)
    throws SRMPostFillException {
 	   // customized implementation place holder
       }

	private static void getCategory(SRMBusinessContext bc, Object BO) throws SRMPreWriteException{

	try{
		CategoryBO boCat = (CategoryBO)BO;
		String strCatType = boCat.getCategoryType();

		SRMCollection catLangList = boCat.getCategory_lang();
		CategoryBO.category_lang catLang = (CategoryBO.category_lang)catLangList.get(0);

		if( strCatType.equalsIgnoreCase("INCIDENTCREATIONSKILLS") || strCatType.equalsIgnoreCase("SERVICEREQ_TYPE")){
			int i=0;
			String strInciCreationValue = "";
			String strType1 = "TYPE1";
			String strType2 = "TYPE2";
			String strType3 = "TYPE3";
			String strType1Value = "";
			String strType2Value = "";
			String strType3Value = "";
			String strType1Code = "";
			String strType2Code = "";
			String strType3Code = "";

			String strInciCatLangVal = catLang.getCat_val();
			String strLangCode = catLang.getLang_code();
			String[] getStr = strInciCatLangVal.split(STRSEPERATOR);
			String key = "";
			SRMQueryResult qr = null;
			SRMRecordSet rs = null;

			for(i=0; i<getStr.length; i++){
				key = getStr[i];
				if(i==0){
					qr = findCategory(strType1, key, bc, strLangCode);
					rs = qr.getRecordSet();
					while(rs.hasNext()){
						ArrayList rowObj = (ArrayList)rs.getNext();
						if(rowObj.get(0)!=null){
							strType1Value = rowObj.get(0).toString();
						}
						if(rowObj.get(1)!=null){
							strType1Code = rowObj.get(1).toString();
						}

						if(key.equalsIgnoreCase(strType1Value)){
							strInciCreationValue = strInciCreationValue + strType1Code;
						}
					}
				}else if(i==1){
					qr = findCategory(strType2, key, bc, strLangCode);
					rs = qr.getRecordSet();
					while(rs.hasNext()){
						ArrayList rowObj = (ArrayList)rs.getNext();
						if(rowObj.get(0)!=null){
							strType2Value = rowObj.get(0).toString();
						}
						if(rowObj.get(1)!=null){
							strType2Code = rowObj.get(1).toString();
						}
						if(key.equalsIgnoreCase(strType2Value)){
							strInciCreationValue = strInciCreationValue + STRSEPERATOR + strType2Code;
						}
					}
				}else if(i==2){
					qr = findCategory(strType3, key, bc, strLangCode);
					rs = qr.getRecordSet();
					while(rs.hasNext()){
						ArrayList rowObj = (ArrayList)rs.getNext();
						if(rowObj.get(0)!=null){
							strType3Value = rowObj.get(0).toString();
						}
						if(rowObj.get(1)!=null){
							strType3Code = rowObj.get(1).toString();
						}
						if(key.equalsIgnoreCase(strType3Value)){
							strInciCreationValue = strInciCreationValue + STRSEPERATOR + strType3Code;
						}
					}
				}
			}
			if(!strInciCreationValue.equalsIgnoreCase(""))
			{
				boCat.setValue(strInciCreationValue);
			}
		}
	}catch(Exception e){
	}
}
private static SRMQueryResult findCategory(String strType, String key, SRMBusinessContext bc, String strLocale){
	SRMQueryResult qr = null;
	List attr=new ArrayList();
	attr.add(CategoryBO.CATEGORY_LANG_CAT_VAL);
	attr.add(CategoryBO.VALUE);
	attr.add(CategoryBO.RATING);

	try{
		SRMQueryBuilder qbCat = new SRMQueryBuilder();

		qbCat 	= QueryAssist.singleObjectQuery("CategoryBO", CategoryBO.CATEGORYID);
		QueryAssist.addSimpleCondition(qbCat,"CategoryBO",CategoryBO.CATEGORYTYPE,
										IQuery.ComparisonOperation_EQ,
										strType);
		QueryAssist.addSimpleCondition(qbCat,"CategoryBO",CategoryBO.CATEGORY_LANG_LANG_CODE,
										IQuery.ComparisonOperation_EQ,
										strLocale);

		QueryAssist.selectAttr( qbCat, "CategoryBO", attr);
		qr = qbCat.runQuery(bc, true, -1);

	}catch(Exception e){

	}
	return qr;
}

}
