/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: SizeUtil.java $
 *
 * $Author: Administrator $
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/SizeUtil.java $
 *
 * $History: SizeUtil.java $
 *
 * *****************  Version 1  *****************
 * User: Raghunathrn  Date: 5/27/03    Time: 8:10p
 * Created in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * tracker 52327
 *
 *****************************************************************************/
package  com.infy.cis.custom;

import  java.util.List;
import  com.infosys.insulate.util.HashMap;
import  com.infosys.insulate.util.ArrayList;
import  java.io.FileReader;
import  java.io.BufferedReader;

import  com.infy.cis.common.CacheService;
import  com.infy.cis.srmbo.SaleBO;
import  com.infy.cis.srmbo.AccountBO;
import  com.infy.cis.srmbo.ContactBO;
import  com.infy.cis.srmbo.SuspectBO;
import  com.infy.cis.srmbo.ProductBO;
import  com.infy.cis.srmbo.DemographicBO;
import  com.infy.cis.srmbo.PsychographicBO;
import  com.infy.cis.srmbo.ProductCategoryBO;
import  com.infy.cis.srmbo.IQuery;
import  com.infy.cis.srmbo.SRMBase;
import  com.infy.cis.srmbo.SRMBOBase;
import  com.infy.cis.srmbo.SRMNVPair;
import  com.infy.cis.srmbo.TransFormFn;
import  com.infy.cis.srmbo.SRMBOHelper;
import  com.infy.cis.srmbo.SRMRecordSet;
import  com.infy.cis.srmbo.SRMQueryExpr;
import  com.infy.cis.srmbo.SRMCollection;
import  com.infy.cis.srmbo.SRMQueryBuilder;
import  com.infy.cis.srmbo.SRMAttributeInfo;
import  com.infy.cis.srmbo.security.user.SRMBusinessContext;
import  com.infy.cis.exception.SRMBOException;
import  com.infy.cis.exception.SRMBCException;
import  com.infy.cis.exception.SRMBaseException;
import  com.infy.cis.exception.SRMPreWriteException;



public class  SizeUtil  {
	public static String CIS_COPYRIGHT_="Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.";
	public static String CIS_VERSION_="1.00 $Revision: 1.1 $";
	/* $NoKeywords: $ */

	public static final String  CUSTCONFIG = "CUSTOMER_FIELDSIZES";
	public static final String  APPLCONFIG = "APPLFORM_FIELDSIZES";
	public static final char    CONNECT = '|';
	public static final char    COMMENT = '#';
	public static final char    OPENB   = '[';
	public static final char    CLOSEB  = ']';

	private static final String  CRMROOT = System.getProperty ("SIMPLERM_ROOT");

	//Begin Modify, APAC, Unix Porting, <16-Jan-2006>
	/*private static final String  SEP = System.getProperty ("file.separator");*/
	private static final String  SEP = "/";
	//End Modify, APAC, Unix Porting, <16-Jan-2006>

	private static final String  APPLCFGPATH = CRMROOT + SEP + "admin" + SEP + "properties" + SEP + "ApplFields.cfg";
	private static final String  CUSTCFGPATH = CRMROOT + SEP + "admin" + SEP + "properties" + SEP + "CustFields.cfg";



	private static void  loadcfg (String cfgfilename, String cachespace) {
		String subspace, fldname, fldsize, fldlabel;
		HashMap  sizemap = null;
		HashMap  fields = new HashMap();
		int m, n;

		try {
			BufferedReader cfgfile = new BufferedReader (new FileReader(cfgfilename));
			String line = cfgfile.readLine();
			while (line != null)	{
				line = line.trim();
				if ((n = line.length()) < 3 || line.charAt(0) != OPENB || line.charAt(n-1) != CLOSEB) {
					line = cfgfile.readLine();
					continue;
				}

				subspace = line.substring(1, n-1);
				sizemap = new HashMap();
				while ((line = cfgfile.readLine()) != null)  {
					if ((line = line.trim()).length() == 0 || line.charAt(0) == COMMENT) continue;
					if (line.charAt(0) == OPENB) break;
					try {
						fldname = line.substring (0, n=line.indexOf(CONNECT)).trim();
						fldsize = line.substring (n+1, m=line.indexOf (CONNECT, n+1)).trim();
						fldlabel = line.substring (m+1).trim();
						sizemap.put (fldname, new SizeStruct (fldsize, fldlabel));
					} catch (Exception ge) { /* Ignore it... */ }
				}

				fields.put (subspace, sizemap);
			}
			cfgfile.close();
		} catch (Exception ge) { /* ignore it... */ }

		CacheService.getHandle().put (cachespace, fields);
	}


	public static HashMap  getCustConfig (String persontype) {
		HashMap cfgmap = (HashMap)CacheService.getHandle().get(CUSTCONFIG);
		if (cfgmap == null)  {
			loadcfg (CUSTCFGPATH, CUSTCONFIG);
			cfgmap = (HashMap)CacheService.getHandle().get(CUSTCONFIG);
		}
		return (HashMap)cfgmap.get (persontype);
	}


	public static HashMap  getApplConfig (String backend, String prodcat) {
		HashMap cfgmap = (HashMap)CacheService.getHandle().get(APPLCONFIG);
		if (cfgmap == null) {
			loadcfg (APPLCFGPATH, APPLCONFIG);
			cfgmap = (HashMap)CacheService.getHandle().get(APPLCONFIG);
		}
		return (HashMap)cfgmap.get (backend + CONNECT + prodcat);
	}


	public static HashMap  getApplConfig (SRMBusinessContext bc, String type, Object uid) {
		boolean saleflg = "SalesID".equalsIgnoreCase (type);
		String backend = null;
		String prodcat = null;

		try {
			SRMAttributeInfo attr_prodId = new SRMAttributeInfo (ProductBO.class, ProductBO.PRODUCTID);
			SRMQueryBuilder qb = new SRMQueryBuilder();

			if (saleflg) {
				qb.addJoinScope (
					IQuery.LogicalOperation_AND,
					new SRMAttributeInfo (SaleBO.class, SaleBO.PRODUCTID),
					IQuery.JoinType_Equi,
					attr_prodId	);
			}

			qb.addJoinScope (
				IQuery.LogicalOperation_AND,
				new SRMAttributeInfo (ProductBO.class, ProductBO.PRODCATID),
				IQuery.JoinType_Equi,
				new SRMAttributeInfo (ProductCategoryBO.class, ProductCategoryBO.PRODCATID)	);

			qb.addAttribScope (new TransFormFn (ProductBO.ATTR_PRODUCTFEATURE2));
			qb.addAttribScope (new TransFormFn (ProductCategoryBO.ATTR_CATEGORYNAME));

			qb.addCondition (
				IQuery.LogicalOperation_AND,
				new SRMQueryExpr (saleflg ? new SRMAttributeInfo (SaleBO.class, SaleBO.SALESID) : attr_prodId),
				IQuery.ComparisonOperation_EQ,
				new SRMQueryExpr (uid)	);

			SRMRecordSet rs = qb.runQuery (bc, false, 1).getRecordSet();
			if (! rs.hasNext()) return null; // this condition will not come....
			List rowObj = rs.getNext();
			backend = rowObj.get(0).toString();
			prodcat = rowObj.get(1).toString();

		} catch (Exception ge) {
			return null;
		}

		return  getApplConfig (backend, prodcat);
	}



	public static void  checkFieldSizes (SRMBOBase bo, HashMap cfgmap)
	throws SRMBOException  {
		ArrayList nvlist = new ArrayList(128);
		SRMNVPair nv = null;
		SizeStruct struct = null;
		SRMBOException error = null;

		SRMBOHelper.saveToNVSet (bo, nvlist);
		int size = nvlist.size();

		for (int i = 0; i < size; ++i)  {
			nv = (SRMNVPair)nvlist.get(i);
			if (nv.getValue() != null &&
			    (struct = (SizeStruct)cfgmap.get(nv.getName())) != null &&
			    nv.getValue().toString().length() > struct.fldsize	) {
				String[] args = new String[] { struct.fldlabel, Integer.toString(struct.fldsize) };
				error = new SRMBOException (SRMBOException.ERROR_SIZEVALIDATION, args, error);
			}
		}

		if (error != null) {
			throw error;
		}
	}


	public static void  checkFieldSizes (SRMBase inner, String parent, String type, HashMap cfgmap)
	throws SRMBOException  {
		ArrayList nvlist = new ArrayList(128);
		SRMNVPair nv = null;
		SizeStruct struct = null;
		SRMBOException error = null;

		SRMBOHelper.saveToNVSet (inner, nvlist);
		int size = nvlist.size();

		if (type != null && type.length() != 0)  {
			type = "." + type;
		} else  type = "";

		if (parent != null && parent.length() != 0) {
			parent = parent + ".";
		} else parent = "";

		for (int i = 0; i < size; ++i)  {
			nv = (SRMNVPair)nvlist.get(i);
			if (nv.getValue() != null &&
			    (struct = (SizeStruct)cfgmap.get(parent+nv.getName()+type)) != null &&
			    nv.getValue().toString().length() > struct.fldsize	) {
				String[] args = new String[] { struct.fldlabel, Integer.toString(struct.fldsize) };
				error = new SRMBOException (SRMBOException.ERROR_SIZEVALIDATION, args, error);
			}
		}

		if (error != null) {
			throw error;
		}
	}


	public static void  checkFieldSizes (SRMCollection innerCls, String parent, HashMap cfgmap)
	throws SRMBOException {
		if (innerCls == null) return;
		for (int i = 0; i < innerCls.size(); ++i) {
			checkFieldSizes ((SRMBase)innerCls.get(i), parent, null, cfgmap);
		}
	}


	public static SRMBOException  checkFieldSizes (SRMBOBase bo, HashMap cfgmap, SRMBOException boe) {
		ArrayList nvlist = new ArrayList(128);
		SRMNVPair nv = null;
		SizeStruct struct = null;

		SRMBOHelper.saveToNVSet (bo, nvlist);
		int size = nvlist.size();

		for (int i = 0; i < size; ++i)  {
			nv = (SRMNVPair)nvlist.get(i);
			if (nv.getValue() != null &&
			    (struct = (SizeStruct)cfgmap.get(nv.getName())) != null &&
			    nv.getValue().toString().length() > struct.fldsize	) {
				String[] args = new String[] { struct.fldlabel, Integer.toString(struct.fldsize) };
				boe = new SRMBOException (SRMBOException.ERROR_SIZEVALIDATION, args, boe);
			}
		}

		return boe;
	}


	public static SRMBOException  checkFieldSizes (SRMBase inner, String parent, String type, HashMap cfgmap, SRMBOException boe) {
		ArrayList nvlist = new ArrayList(128);
		SRMNVPair nv = null;
		SizeStruct struct = null;

		SRMBOHelper.saveToNVSet (inner, nvlist);
		int size = nvlist.size();

		if (type != null && type.length() != 0)  {
			type = "." + type;
		} else  type = "";

		if (parent != null && parent.length() != 0) {
			parent = parent + ".";
		} else parent = "";

		for (int i = 0; i < size; ++i)  {
			nv = (SRMNVPair)nvlist.get(i);
			if (nv.getValue() != null &&
			    (struct = (SizeStruct)cfgmap.get(parent+nv.getName()+type)) != null &&
			    nv.getValue().toString().length() > struct.fldsize	) {
				String[] args = new String[] { struct.fldlabel, Integer.toString(struct.fldsize) };
				boe = new SRMBOException (SRMBOException.ERROR_SIZEVALIDATION, args, boe);
			}
		}

		return boe;
	}


	public static SRMBOException  checkFieldSizes (SRMCollection innerCls, String parent, HashMap cfgmap, SRMBOException boe) {
		if (innerCls == null) return boe;
		for (int i = 0; i < innerCls.size(); ++i) {
			boe = checkFieldSizes ((SRMBase)innerCls.get(i), parent, null, cfgmap, boe);
		}
		return boe;
	}


	public static void  checkApplFieldSizes (SRMBOBase bo, String idname, Object idval, SRMBusinessContext bc)
	throws SRMPreWriteException  {
		try {
			HashMap applcfg = getApplConfig (bc, idname, idval);
			if (applcfg != null && applcfg.size() != 0) {
				checkFieldSizes (bo, applcfg);
			}
		} catch (SRMBaseException be) {
			throw new SRMPreWriteException (be.getErrorCode(), be);
		} catch (Exception ge) {
			throw new SRMPreWriteException (SRMBOException.ERROR_INTERNAL, ge);
		}
	}





	static class SizeStruct  {
		public int    fldsize;
		public String fldlabel;

		public SizeStruct (String fldsize, String fldlabel)
		throws NumberFormatException {
			this.fldsize = Integer.parseInt (fldsize);
			this.fldlabel = fldlabel;
		}

		public SizeStruct (int fldsize, String fldlabel) {
			this.fldsize = fldsize;
			this.fldlabel = fldlabel;
		}

		public int  getFieldSize() {
			return fldsize;
		}

		public String getFieldLabel() {
			return fldlabel;
		}

		public String toString() {
			return "(maxsize=" + fldsize + ", label=" + fldlabel + ")";
		}
	}


}
