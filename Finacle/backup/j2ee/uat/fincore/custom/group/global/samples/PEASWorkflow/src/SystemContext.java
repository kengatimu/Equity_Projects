/*
* SystemContext.java
*/

package com.peas;

import com.infy.bbu.context.IServiceContext;
import fabclasses.ServiceRoutines;
import FABCommon.SecurityInfo70;
import com.infy.COTP.LinkList;
import java.util.HashMap;
import java.util.Properties;
//import FABCommon.*;
//import FABInquiry.*;
import finbranchUtil.MenuMiscInfo;
//import FabServer.*;
//import gcode.utils.*;
import java.io.FileInputStream;

import com.infy.bbu.LimoClient;
import core_session.CoreSessionHandle;
import core_session.CoreSession;

/**
 * This class is implements IServiceContext and is used
 * by workflow to populate data.
 * This will go to WEB-INF/lib of the servlet container along with other
 * Finacle jars. 
 * It needs two paths namely RESIN_HOME and JLIMO_DIR from the env.
 * The path for the jlimo has to be read from a env JLIMO_DIR. 
 * Later on this will be moved to a peas config file.
 * @author 
 **/


public abstract class SystemContext implements IServiceContext
{
	private ServiceRoutines srvcRoutine; 
	private static String finSessionId = "";

	private	static CoreSession CSObj; 
	private static CoreSessionHandle SessHandle;

	/**
	 * Gets the security info
	 *
	 * @param 				none
	 *
	 * @return				SecurityInfo70 contains the security information
	 *
	 * @throws				none
	 **/
	public SecurityInfo70 getSecurityInfo()
	{

		/*
			Call the API from CoreSession here to get the details of the
			session for virtual user. (For the real user id should we keep the
			user id of the user who has sent to this system activity or should
			there be a separate real user id for workflow?)
			That API will return handle to one LGI session. Call
			getsessioninfo using the same and get securityinfo.
		*/

		SecurityInfo70 secInfo = new SecurityInfo70();
		String[] crvBaseUrl = new String[1];

		LinkList errLL = null;
        try {
            errLL = new LinkList("FABInquiry.Err");
        } catch (Exception cnfe) {
         //   throw new Exception("LinkList Creation Failed", cnfe);
			System.out.println("ClassNotFoundException For FABInquiry.ERR");
        }

		/*
		 *	doRealOnsLogin will give the finsessionid
		 */
		finSessionId = doRealOnsLogin();

		//ServiceRoutines srvcRoutine = getServiceRoutines();
		if(null == srvcRoutine){
			srvcRoutine = getServiceRoutines(); 
		}

		if(null !=srvcRoutine){
			try
			{
			int iRetVal = srvcRoutine.getSecurityInfoFromFin(finSessionId,secInfo,crvBaseUrl, errLL);
			}
			catch ( fabclasses.FinErrException fe)
			{
			}
		}

		System.out.println("SecInfo is ["+secInfo+"]");

		return secInfo;
	}

	/**
	 * Gets the customization data inside
	 *
	 * @param 		none
	 *
	 * @return		String contains the customization data in.
	 *
	 * @throws		none
	 **/
	public String getCustDataIn()
	{
		String custDataIn = "";
		return custDataIn;
	}

	/**
	 * Sets the customization data sent by the backend service.
	 *
	 * @param 		String[] contains the customization data.
	 *
	 * @return		void
	 *
	 * @throws		none
	 **/
	public void setCustDataOut(String[] custDataOut)
	{
		return;
	}

	/**
	 * Gets the customization data sent by the backend service.
	 *
	 * @param 		none
	 *
	 * @return		String[] contains the customization data.
	 *
	 * @throws		none
	 **/
	public String[] getCustDataOut()
	{
		String[] custDataOut	=	new String[1];
		return custDataOut;
	}

	/**
	 * Gets the Service routines object.
	 * To be deprecated
	 *
	 * @param 		none
	 *
	 * @return		ServiceRoutines contains the service routines object.
	 *
	 * @throws		none
	 **/
	public ServiceRoutines getServiceRoutines()
	{
		/*
			Get the prop map properly
		*/
		//ServiceRoutines srvcRoutine = new ServiceRoutines(); 
		srvcRoutine = new ServiceRoutines(); 
		HashMap propObj = new HashMap();
		String path = System.getProperty("RESIN_HOME");

		try{

			FileInputStream finProp = new FileInputStream(path + "/webapps/finbranch/WEB-INF/properties/finbranch.properties");
			Properties propFinbranch = new Properties();
			propFinbranch.load(finProp);

			propObj.put("appPath", propFinbranch.getProperty("appPath"));
			propObj.put("clientAppId", propFinbranch.getProperty("clientAppId"));
			propObj.put("traceFlag", propFinbranch.getProperty("traceFlag"));
			propObj.put("minPoolInstances", propFinbranch.getProperty("minPoolInstances"));
			propObj.put("maxPoolInstances", propFinbranch.getProperty("maxPoolInstances"));
			propObj.put("refreshDaysForInstances", propFinbranch.getProperty("refreshDaysForInstances"));
			propObj.put("poolLogReqd", propFinbranch.getProperty("poolLogReqd"));
			propObj.put("prod_env", propFinbranch.getProperty("prod_env"));
			srvcRoutine.init(propObj);
		}
		catch(Exception e){
			e.printStackTrace();
		}

      	return srvcRoutine;
     }

	/**
	 * Gets the Function code value.
	 *
	 * @param 		none
	 *
	 * @return		char contains the function code value.
	 *
	 * @throws		none
	 **/
	public char getFunctionCode()
	{
		char cFuncCode = '\0';
		return cFuncCode;
	}

	private String doRealOnsLogin(){

		int iRet=0;
		String SessId=null;
		String ClntSessId=null;
		LimoClient LimClnt;
		String [] sWorkClass={""};
		String [] sBodDate={""}; 
		String [] sTermClass={""};
		String [] sHomeSolId={""}; 
		long [] iMaxInactiveTime={0}; 
		String [] ErrMsg={""};

		try
		{
			String path = System.getProperty("JLIMO_DIR");
			LimClnt = new LimoClient("PID", "UID", "ExecC", path + "/jlimoclient.cfg", 1);
			CSObj = new CoreSession(LimClnt,"ExecC",true,"CoreSession"); 
		} 
		catch (Exception e)
        {
            e.printStackTrace();
        }
	
		try
		{
			SessHandle = new CoreSessionHandle(); 
			
            System.out.println("Calling CoreLogin......." );
			iRet = CSObj.CoreLogin("WFSRE", ".", "WFSRE", SessHandle, ErrMsg);
			
			if(iRet != CoreSession.Success)
            {
                System.out.println("CoreLogin User returned error : " );
				PrintError(iRet, ErrMsg);
				SessHandle=null;
				//return SessHandle;
				return null;
            }
			else
            	System.out.println("Core LOGIN successful......." );
			
			SessId = CSObj.GetSessionId();
			System.out.println("CoreObject - Session ID : [" + SessId + "]");

			ClntSessId = SessHandle.GetSessionId();
			System.out.println("Handle - Session ID : [" + ClntSessId + "]");

			SessHandle.GetParameters(sWorkClass, sBodDate, sTermClass, sHomeSolId, iMaxInactiveTime);

            System.out.println("sWorkClass : " + sWorkClass[0]);
            System.out.println("sBodDate : " + sBodDate[0]);
            System.out.println("sTermClass : " + sTermClass[0]);
            System.out.println("sHomeSolId : " + sHomeSolId[0]);
            System.out.println(iMaxInactiveTime[0]);

		} 
		catch (Exception e)
        {
            e.printStackTrace();
        }
		return SessId;
	}

	private static void PrintError(int iValue,String [] ErrMsg)
	{
		Exception csException;
		switch(iValue)
		{
			case CoreSession.Failure:
            		System.out.println("Error in Limo ");
					csException = CSObj.getLastException();
					if(csException != null) csException.printStackTrace();
					break;
			case CoreSession.ServiceNotAvailable:
            		System.out.println("Limo Service Not Available ");
					break;
			case CoreSession.ErrorInTransieve:
            		System.out.println("Limo : Error in Transieve ");
					break;
			case CoreSession.AbnormalTermination:
            		System.out.println("Limo : Error in Transieve ");
					break;
			case CoreSession.ServerReturnedError:
            		System.out.println("ERROR : [" + ErrMsg[0] + "]");
					break;
			case CoreSession.UnknownError:
            		System.out.println("Unable to Decifer Message ");
					break;
			default :
            		System.out.println("Unknown Error ");
			
		}
	}

	// Added as part of FET tool changes for bypassing backend service in IServiceContext.
	// Dummy getter and setter methods defined here.
	public void setFETDataXmlName( String fetDataXmlName )
	{
	}

	public String getFETDataXmlName()
	{
		return "";
	}

};

