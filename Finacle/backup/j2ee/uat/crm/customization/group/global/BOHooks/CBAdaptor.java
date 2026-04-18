/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CBAdaptor.java $
 *
 * Author: Pradeep S.V
 *
 * Tracker ID : 44693
 *
 * $Archive: /CRM61DEV/com/infy/cis/custom/BOHooks/CBAdaptor.java $
 *
 * $History: CBAdaptor.java $
 *
 * *****************  Version 1  *****************
 * User: Prashanth_nandakumar Date: 13/01/03   Time: 8:34p
 * Created in $/CRM61DEV/com/infy/cis/custom/BOHooks
 * Adding basic implementation. Patch needs to applied for testing.
 *******************************************************************************/

package com.infy.cis.custom;

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
import com.infy.cis.ui.loans.*;
import com.infy.cis.daemons.*;

  /**
	* Brief Description of Class :
	*
	* @author : Pradeep S.V
	*
	* Functionality : Send request to External Credit Bureau system using CBbean & get the
	* Bureau results information from the external system.
	* Actual full implementation of this class cannot be done at this point of time as
	* the details of the external Credit Bureau system is not known currently. Once the
	* same is obtained, the exact coding to do the implementation specific to the
	* external system to be done then. This class should reside in the package meant
    * for  customization implementation.
	*
	* External Methods Called : @see<method>
	*
	* Known Bugs :
	*
	* Start Date :
	*
	* Modification Log :
	*
    */


public class CBAdaptor
{

	public CBbean [] CBData;
	public int size;

	public Hashtable htbCBResults=new Hashtable();
	public ArrayList arrCBHistoryDetails[];
	private int count=0;


	public CBAdaptor(CBbean CBdata[])
	{
		try
		{
				size	= CBdata.length;
				CBData	= new CBbean[CBdata.length];

				for(int j=0;j<CBdata.length;j++)
				{
					CBData[j] = new CBbean();
					CBData[j] = CBdata[j];
				}
		}
		catch(Exception e){
			//System.out.println(e.toString());
		}
	}


   /**
	 *  Description Follow method is meant to interface with the external credit Bureau system, send
	 *  request details in the CBbean. It receives & returns results along with status of operation.
	 * @return Hashtable Hashtable contains
	 */

	public Hashtable creditBureauInterface()
	{/*
		Connection con = null;
		Statement stmt = null;
		PreparedStatement pstmt=null;
		ResultSet rs   = null;
		DaemonDBConn daemonDBConn = new DaemonDBConn();
		try
		{
			con = daemonDBConn.getConnection();
			pstmt = con.prepareStatement("UPDATE ExternalCreditBureau SET BorrowerID=? WHERE(Borrower_PassportNO=?)");
			for(int i=0;i<CBData.length;i++)
			{
				pstmt.setInt( 1, Integer.parseInt(CBData[i].getID()));
				pstmt.setString( 2, CBData[i].getPassportNO());
				int iSQLUpdateResult = pstmt.executeUpdate();

				if(iSQLUpdateResult == 1)
				{
					stmt = con.createStatement();

					rs = stmt.executeQuery(
					"select	s.CreditBureau_Score,s.CB_Score_validity,h.Industry,"+
					"h.Date_Reported,h.Date_opened,h.High_Credit_Amt,h.High_Credit_Currency, "+
					"h.Balance_Amt,h.Balance_Currency,h.Current_Rating,h.Delinquency "+
					"from externalcreditbureau s LEFT OUTER JOIN externalcbhistory h "+
					"ON  s.External_CB_ID = h.External_CB_ID where "+
					"s.Borrower_PassportNO='"+CBData[i].getPassportNO()+"'");

					count=0;
					while(rs.next())
					{
						count++;
					}
					arrCBHistoryDetails = new ArrayList[count];

					rs = stmt.executeQuery(
					"select	s.CreditBureau_Score,s.CB_Score_validity,h.Industry,"+
					"h.Date_Reported,h.Date_opened,h.High_Credit_Amt,h.High_Credit_Currency, "+
					"h.Balance_Amt,h.Balance_Currency,h.Current_Rating,h.Delinquency "+
					"from externalcreditbureau s LEFT OUTER JOIN externalcbhistory h "+
					"ON  s.External_CB_ID = h.External_CB_ID where "+
					"s.Borrower_PassportNO='"+CBData[i].getPassportNO()+"'");

					int iCount=0;
					while(rs.next())
					{
						CBData[i].setCreditBureauScore(rs.getString("CreditBureau_Score"));
						CBData[i].setCBScoreValidity(rs.getDate("CB_Score_Validity"));

						arrCBHistoryDetails[iCount]=new ArrayList();
						arrCBHistoryDetails[iCount].add(rs.getString(3));
						arrCBHistoryDetails[iCount].add(rs.getDate(4));
						arrCBHistoryDetails[iCount].add(rs.getDate(5));
						arrCBHistoryDetails[iCount].add(rs.getString(6));
						arrCBHistoryDetails[iCount].add(rs.getString(7));
						arrCBHistoryDetails[iCount].add(rs.getString(8));
						arrCBHistoryDetails[iCount].add(rs.getString(9));
						arrCBHistoryDetails[iCount].add(rs.getString(10));
						arrCBHistoryDetails[iCount].add(rs.getString(11));
						iCount++;
					}
						CBData[i].setCBHistoryDetails(arrCBHistoryDetails);
						CBData[i].setStatus(new String("Success"));
				}
				else
				{
						CBData[i].setStatus(new String("Failure"));
				}
			}
						htbCBResults.put("CBData",CBData);
						htbCBResults.put("Result","PASS");

		}
		catch(Exception e)
		{
			//System.out.println("Error in obtaining results from External System: "+e.toString());
		}
		finally
		{
			closeAll(con, stmt, rs);
		}
		*/

		return htbCBResults;

	}


	/*
	public void closeAll( Connection con, Statement stmt, ResultSet rs)
	{
			try
			{
				rs.close();
				stmt.close();
				con.close();
			}
			catch(Exception e)
			{
				//System.out.println("Error closing connection: "+e.toString());
			}
	}
	*/
}
