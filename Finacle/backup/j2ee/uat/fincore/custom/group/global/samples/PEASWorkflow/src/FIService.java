/*****************************************************************************
 *						Process Execution Analysis and Simulation
 *****************************************************************************
 * File Name       :    FIService.java
 * Description     :    Java program to call FI Services.
 *
 * Version History :
 * ----------------------
 *  #   Date        Author           		Modification	 	Version
 * ---  ------      ---------------  		--------------	 	---------
 *  1  06-05-2008   Tamilselvan.R		 	Initial Draft	 	1.0
 *
 *
 ******************************************************************************/


package com.infy.finacle.workflow.deployHook;

import java.util.Calendar;


import peas.common.intf.logging.PEASLoggerIF;
import peas.init.PEASClassLoader;

import com.infosys.ci.common.CIUserInfo;
import com.infosys.ci.common.CINonFatalException;
import com.infosys.ci.common.CIFatalException;
import com.infosys.ci.ons.common.CIOnsNonFatalException;
import com.infosys.ci.ons.common.CIOnsErr;
import com.infosys.ci.ons.cistruct.ExecuteFinacleScriptInputVO;
import com.infosys.ci.ons.cistruct.ExecuteFinacleScriptOutputVO;
import com.infosys.bankaway.accesslayer.bwyinterface.FICustomServiceALImplementation;

import com.infosys.ci.ons.cistruct.AcctCommonInfoOAOpen;
import com.infosys.ci.ons.cistruct.LocalCalMappingInputVO;
import com.infosys.ci.ons.cistruct.LocalCalMappingOutputVO;
import com.infosys.ci.ons.cistruct.EffectiveGenCalMapInqInputVO;
import com.infosys.ci.ons.cistruct.EffectiveGenCalMapInqOutputVO;



public class FIService
{
	private CIUserInfo ciUserInfo=new CIUserInfo();
	private ExecuteFinacleScriptInputVO inp =new ExecuteFinacleScriptInputVO();
	private ExecuteFinacleScriptOutputVO out =new ExecuteFinacleScriptOutputVO();
	private FICustomServiceALImplementation obj = new FICustomServiceALImplementation();
	private String ErrorMsg="";
	private int ErrorCode=0;
	private static PEASLoggerIF logger = PEASClassLoader.GetPEASClassLoader().getPEASLoggerIF(FIService.class);
	/*
	 * ===========================================================================
	 * Function Name    :  FIService.
	 * Description      :  Empty constructor.
	 * Input Parameters :  None
	 * Output Parameters:  None
	 * ===========================================================================
	 */
	public FIService()
	{
	}


	/*
	 * ===========================================================================
	 * Function Name    :  callAddMenuFIService.
	 * Description      :  Method will call Fi Service from peas and give success
	 * 					   or failure
	 * Input Parameters :  1. String Mop_id
	 * Output Parameters:  void - returns valid page count.
	 * ===========================================================================
	 */
	public  boolean  callAddMenuFIService(String Mop_id,Object bankId)

	{



		setErrorDetails("",0);


		System.setProperty("FI_APP_NAME", "FIONLINE");

		ciUserInfo.setChannelType("CRM");
		ciUserInfo.setAccessChannelId("CRM");
		ciUserInfo.setBankId((String) bankId);
		System.out.println("Bankid:==>"+(String) bankId);

		System.out.println("Mop_id"+Mop_id);


		inp.getFIIncidentInfo().setDccReqOrigTime(retCurSysTime());
		inp.getFIIncidentInfo().setDccReqRefNum("PEAS"+retCurSysTime());
		inp.setRequestId("Verify_Data.scr");
		inp.getCustomData().put("mop_id",Mop_id);
		inp.getCustomData().put("entity_id",(String) bankId);

		try
		{
			System.out.println("inside try block before out");
			out=obj.executeFinacleScript(ciUserInfo,inp);//ERROR


			System.out.println("out"+out);




		}
		catch (CINonFatalException cnf)
		{
			System.out.println("NonFatalException in callAddMenuFIService:"+cnf.getMessage());
			cnf.printStackTrace();
			setErrorDetails("EXCP_PEAS_FI_SERVICE_FAILED",-1);
			return false;
		}
		catch (CIFatalException cfe)
		{
			System.out.println("FatalException in callAddMenuFIService"+cfe.getMessage());
			cfe.printStackTrace();
			setErrorDetails("EXCP_PEAS_FI_SERVICE_FAILED",-1);
			return false;
		}
		catch (CIOnsNonFatalException confe)
		{
			System.out.println("CIOnsNonFatalException:"+confe.getMessage());
			confe.printStackTrace();
			for (int i = 0; i < confe.getErrorLL().length ; i++)
			{
				String strErrMsg = "";
				CIOnsErr errObj = (CIOnsErr)confe.getErrorLL()[i];


				if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1)
				{

					strErrMsg = "(" + (i + 1) + ") " + errObj.errDesc;
				}
				else
				{
					strErrMsg = "(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;
				}

				if (errObj.errCode.equalsIgnoreCase("SYS") || errObj.errCode.equalsIgnoreCase("FATAL"))
				{
					System.out.println("SYSTEM_ERROR:"+strErrMsg);
				}
				else
				{
					System.out.println("VALIDATION_ERROR:"+strErrMsg);
				}
			}
			setErrorDetails("EXCP_PEAS_FI_SERVICE_FAILED",-1);
			return false;
		}
		catch (Exception e)
		{
			System.out.println("Error Meassage(e): " + e.getMessage());
			e.printStackTrace();
			setErrorDetails("EXCP_PEAS_FI_SERVICE_FAILED",-1);
			return false;
		}
		return true;
	}
	/*
	 * ===========================================================================
	 * Function Name    :  getErrorDetails.
	 * Description      :  Method returns Error details
	 * Input Parameters :  None
	 * Output Parameters:  Error Message
	 * ===========================================================================
	 */
	public String getErrorDetails(){
		return this.ErrorMsg;
	}
	/*
	 * ===========================================================================
	 * Function Name    :  setErrorDetails.
	 * Description      :  Method sets the error details
	 * Input Parameters :  Error message
	 * Output Parameters:  None
	 * ===========================================================================
	 */
	public  void setErrorDetails(String errMsg,int ErrorCode){
		this.ErrorMsg=errMsg;
		this.ErrorCode=ErrorCode;
		return;
	}
	/*
	 * ===========================================================================
	 * Function Name    :  getErrorCode.
	 * Description      :  Method returns Error Code
	 * Input Parameters :  None
	 * Output Parameters:  Error Code
	 * ===========================================================================
	 */
	public int getErrorCode(){
		return this.ErrorCode;
	}

	/*
	 * ===========================================================================
	 * Function Name    :  retCurSysTime.
	 * Description      :  Method for getting date as yyyy-mm-dd HH:MM:SS.SSS.
	 * Input Parameters :  1.RILoggerFactory logFactory - For logging.
	 * Output Parameters:  String date - returns the current date and time.
	 * ===========================================================================
	 */
	private String retCurSysTime()
	{
		String yr,mnth,day,hr,min,sec,milisec;
		Calendar calender = Calendar.getInstance();



		yr = new String(Integer.toString(calender.get(Calendar.YEAR)));
		mnth = appZero(calender.get(Calendar.MONTH));
		day = appZero(calender.get(Calendar.DAY_OF_MONTH)			);
		hr = appZero(calender.get(Calendar.HOUR_OF_DAY));
		min = appZero(calender.get(Calendar.MINUTE));
		sec = appZero(calender.get(Calendar.SECOND));
		milisec = appZero(calender.get(Calendar.MILLISECOND));

		String date = new String(yr+"-"+mnth+"-"+day+"T"+hr+":"+min+":"+sec+"."+milisec);
		return date;
	}

	/*
	 * ===========================================================================
	 * Function Name    :  appZero.
	 * Description      :  Method for converting a number into string in two digit
	 * 					  format.
	 * Input Parameters :  1.int num - Number to be converted.
	 * Output Parameters:  String cnv - returns the converted number.
	 * ===========================================================================
	 */
	private String appZero(int num)
	{
		String cnv;
		if(num < 10)
			cnv = "0"+Integer.toString(num);
		else
			cnv = Integer.toString(num);
		return cnv;
	}
}
