/**
 * Auto generated code from InFluxPA
 * Version 0.96
 * Generated on 23-10-2007 17:56
 * Author poornima_rao
 */

package com.infy.finacle.workflow.mdb.processcomplete;
import java.util.HashMap;
import peas.api.intf.javacompif.ComponentInterface;
import peas.api.intf.hooks.appenv.ApplicationGlobalContext;
import peas.api.intf.hooks.appenv.ApplicationProcessContext;
import peas.api.intf.javacompif.ApplicationException;
import peas.api.intf.javacompif.GlobalException;

public abstract class ProcessCompleteBase implements ComponentInterface{
	private ProcessCompleteParameters parameters = null;

	//method to be implemented
	protected abstract void execute(ProcessCompleteParameters parameters, ApplicationGlobalContext globContext, ApplicationProcessContext procContext) throws Exception;

	public void serviceRequest(ApplicationGlobalContext globContext, ApplicationProcessContext procContext, HashMap requestParams, HashMap responseParams) throws Exception{
		try{
			parameters = new ProcessCompleteParameters (requestParams,responseParams);
			//invoke execute method
			System.out.println("requestParams is = " + requestParams + "responseParams is  = " + responseParams);
			execute(parameters,globContext,procContext);
			responseParams = parameters.getOutputMap();
			System.out.println("responseParams .... " + responseParams);
		}catch(GlobalException e){//If GlobalExcpetion is caught just rethrow it
			throw e;
		}catch(ApplicationException e){//If ApplicationExcpetion is caught just rethrow it
			throw e;
		}catch(Exception e){//If any other excpeion is thrown, throw an ApplicationException
			throw new ApplicationException("GeneralException",e.getMessage());
		}
	}
}
