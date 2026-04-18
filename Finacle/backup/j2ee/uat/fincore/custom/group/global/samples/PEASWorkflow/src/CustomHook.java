package com.peas;

import java.lang.*;
import java.util.HashMap;
import com.peas.SystemContext;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import fabclasses.ONSErrHandler;
import fabclasses.ONSErrInfo;
import fabclasses.CommonFunctions;
import fabclasses.FinErrException;
import FABCommon.SecurityInfo70;
import fabclasses.ServiceRoutines;
import com.infy.COTP.LinkList;
import gcode.utils.ONSClassFactory;
import com.infy.bbu.context.IServiceContext;
import com.infy.bbu.ons.exception.FinSysException;
import com.infy.bbu.ons.exception.FinSysExpConstants;
import com.infy.bbu.ons.log.IFinLogger;
import com.infy.bbu.ons.log.LoggerCreator;
import FABInquiry.CustomList;

import peas.api.intf.hooks.appenv.ApplicationGlobalContext;
import peas.api.intf.hooks.appenv.ApplicationProcessContext;
import peas.api.intf.javacompif.GlobalException;
import peas.api.intf.javacompif.ApplicationException;

import java.util.HashMap;
import java.util.Set;
import java.util.Iterator;

/**
 *	This class is a sample implementation for a system activity to call custom
 *	script in backend in peas framework.
 *	This will go to PEAS_HOME/componentDir
 **/


public class CustomHook{

  
	private static final String CLASS_NAME  ="Workflow-CustomHook"; 
	
	public CustomHookParameters execute(CustomHookParameters parameters,
						ApplicationGlobalContext globContext,
						ApplicationProcessContext procContext)
						throws GlobalException ,ApplicationException,
						Exception{

		try{

	  	LinkList 			custInLL 		= new LinkList("FABInquiry.CustomList"); 
    	LinkList 			custOutLL 		= new LinkList("FABInquiry.CustomList");
	
		IServiceContext 	context 		= null;
		com.peas.SystemContext 		ctx 			= null;
		ONSErrHandler 		errHand 		= null;
		FinErrException 	fex 			= null;
		LinkList 			errLL 			= null;
		String 				userId          = null;
		SecurityInfo70      secuInfo    	= null;
		ServiceRoutines     srv         	= null;
		String				sScriptName		= "";
		HashMap 			inMap 			= new HashMap();
		String []			inputData		= null;

		final String 		LOG_SRC        	= CLASS_NAME;
		
		IFinLogger log;
        log =   LoggerCreator.getLogger();
		errLL=new LinkList("FABInquiry.Err");

		/**
		 *	Get the input scriptname
		 **/
		sScriptName = parameters.getscriptName();
		System.out.println("Script name is [" + sScriptName + "]");

		inMap = parameters.getInputMap();
		System.out.println("CustomHook::inMap is " + inMap);
		if(null != inMap){
			Set vals = inMap.keySet();
			Iterator itr = vals.iterator();
			System.out.println("inMap size is ["+inMap.size()+"]");
			inputData = new String[inMap.size()];
			
			String temp;
			for(int i=0; itr.hasNext();i++)
			{
				temp = (String)itr.next();
				System.out.println("temp is ["+temp+"]");
				System.out.println("inMap.get is [" + inMap.get(temp) + "]");
				if(null != temp && 
					!temp.equals("") && 
					null != inMap.get(temp) &&
					!("").equals(inMap.get(temp))){
					inputData[i] = temp + "|" + inMap.get(temp);
				}
			}
			if(null != inputData)
				custInLL = populateInputLL(inputData);

		}
		else{
			System.out.println("CustomHook::inMap was null");
		}

		/*
			Get the context from the global context present in peas engine
		*/
		//ctx = new SystemContext();
		//System.out.println("finAppContext is [" + globContext.getParam("finAppContext"));
		System.out.println("Class name is " +(globContext.getParam("finAppContext")).getClass().getName());
		//ctx  = (com.peas.SystemContext)globContext.getParam("finAppContext");
		srv = (ServiceRoutines)globContext.getParam("ServiceRoutines");
		secuInfo = (SecurityInfo70)globContext.getParam("SecurityInfo");

		System.out.println("CustomHook::secuInfo = ["+secuInfo +"]");

		try
		{
			srv.processCustomScr(secuInfo,sScriptName,custInLL,custOutLL,errLL);	
		}

		catch ( fabclasses.FinErrException fe)
		{
		}

		if (errLL.size() > 0){	
			System.out.println("Error occured" + errLL);
			FABInquiry.Err errObj = (FABInquiry.Err)errLL.elementAt(0); 
			if(("SYS").equals(errObj.errCode)){
				throw new GlobalException(errObj.errCode,errObj.errDesc);
			}
			else if(("FATAL").equals(errObj.errCode)){
				throw new ApplicationException(errObj.errCode,errObj.type+"");
			}
		}
		else{
			if(custOutLL.size()>0){
				populateOutputHashMap(parameters,custOutLL);
			}
			
			System.out.println("custOutLL is " + custOutLL);
		}
		/*
			Check how out data comes, whether as name value pairs separated by "|".
			If yes, populate the output hashmap using the same LL.
		*/
		}
		catch(ClassNotFoundException e){
			e.printStackTrace();
		}
		/*catch(Exception e){
			e.printStackTrace();
		}*/

		return parameters; 
	}

	private LinkList populateInputLL(String [] inputData) {

    	FABInquiry.CustomList customListObj=null;
		LinkList inputList=null;

		try{

		inputList=new LinkList("FABInquiry.CustomList");

		System.out.println("inputData.length is ["+inputData.length+"]");

		for (int i= 0; i < (inputData.length-1); i++) {
			customListObj=new CustomList();
			System.out.println("i is ["+ i + "] inputData is" + inputData[i] );
			if(null != inputData[i]){
				String keyStr = inputData[i].substring(0, inputData[i].indexOf("|"));
				String keyVal = inputData[i].substring(inputData[i].indexOf("|") + 1, inputData[i].length());
				customListObj.serialNo = Integer.toString(i+1);
				customListObj.name=keyStr;
				customListObj.value=keyVal;
				inputList.add(customListObj);
			}
		}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return inputList;
	}
			
	private void populateOutputHashMap(CustomHookParameters parameters,LinkList outputList){

		int size=outputList.size();
		CustomList customListObj=null;
		for (int index=0;index<size;index++){
			customListObj=(CustomList)outputList.get(index);
			System.out.println("name= " + customListObj.name );
			System.out.println("valeu = " + customListObj.value);
			(parameters.getOutputMap()).put(customListObj.name,customListObj.value);
		}
	}

	
}
