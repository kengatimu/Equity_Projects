/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: GcifCorporateBOHook.java $
 *
 * Author: Jojen
 *
 * *********************************** */


package com.infy.cis.custom;



import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.IQuery;
import com.infy.cis.srmbo.SRMQueryBuilder;
import com.infy.cis.srmbo.SRMRecordSet;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.ui.common.*;
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
import com.infosys.insulate.util.HashMap;
import com.infy.cis.common.LCIFInterface;

public class GcifCorporateBOHook implements IHooks {

	public GcifCorporateBOHook() {
	}

	public void preWrite(SRMBusinessContext buscntxt, Object bo)
	throws SRMPreWriteException, SRMSecurityException {


	}

	public void postFill(SRMBusinessContext bc, Object bo)
	throws SRMPostFillException {
		// customized implementation place holder
	}

	public void preDelete(SRMBusinessContext bc, Object bo)
	throws SRMPreDeleteException {
		// customized implementation place holder

	}

	//	sample hook - postDelete
	public void postDelete(SRMBusinessContext bc, Object bo)
	throws SRMPostDeleteException {
		// customized implementation place holder
	}

	//	sample hook - preFill

	public void preFill(SRMBusinessContext bc, Object bo)
	throws SRMPreFillException {
		// customized implementation place holder

	}

	public void postWrite(SRMBusinessContext bc, Object bo)
	throws SRMPostWriteException {

	}



}


