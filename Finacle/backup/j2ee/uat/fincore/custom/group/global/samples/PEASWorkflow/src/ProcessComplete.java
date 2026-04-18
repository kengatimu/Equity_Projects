/**
 * Auto generated code from InFluxPA Version 0.96 Generated on 23-10-2007 17:56
 * Author poornima_rao
 */

package com.infy.finacle.workflow.mdb.processcomplete;



import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Properties;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.Context;
import javax.naming.InitialContext;

import peas.api.intf.hooks.appenv.ApplicationGlobalContext;
import peas.api.intf.hooks.appenv.ApplicationProcessContext;

import java.util.Iterator;
import java.util.Set;

import peas.init.PEASClassLoader;
import peas.client.cloader.intf.engine.interfacefactory.InstanceMgmtFactoryIF;
import peas.client.api.intf.engine.instancemgmt.PEASProcInstMgmtIF;
import com.infy.bbu.workflow.exception.WorkflowSysException;
import com.infy.bbu.workflow.exception.WorkflowSysExpConstants;
import com.infy.finacle.workflow.mdb.common.Utility;

public class ProcessComplete extends ProcessCompleteBase {

	static final String sLogName = "PEAS";

	ConnectionFactory qcf = null;

	Connection qc = null;

	Session qs = null;

	String Counter = "N";

	static Hashtable ht = new Hashtable();

	protected void execute(ProcessCompleteParameters parameters,
			ApplicationGlobalContext globContext,
			ApplicationProcessContext procContext) throws Exception {
			Counter = "N";
		//Code your Business logic here. You need to set the values in the
		// parameters object
		try
		{
			System.out.println("Inside ProcessComplete execute method");
			if (ht.get(procContext.getProcessId().toString())== null)
			{
				System.out.println("Counter in if :" + Counter);
				ht.put(procContext.getProcessId().toString(),"Completed");
				Counter = "Y";
			}
			else
			{
				System.out.println("Counter in else :" + Counter);
				ht.remove(procContext.getProcessId().toString());
				Counter = "N";
			}

			String userId = " ";
			String sRequest = " ";
			String processID=null;
			System.out.println("ProcessComplete:execute:Starts");
			System.out.println("ProcessComplete:execute:process Id="+procContext.getProcessId());
			processID=procContext.getProcessId();
			HashMap in = parameters.getInputMap();
			

				String mid = (String) in.get("WPS_MESSAGE_ID");
				System.out.println("\n WPS message Id obtained from input params is "+ mid);
				if (Counter == "Y")
				{
					System.out.println("Process Id in loop:" + procContext.getProcessId());
					notifyProcessCompletion(in,procContext.getProcessId(),mid);
				}
				
				System.out.println("End of ProcessComplete class");

		}
		catch(WorkflowSysException wfe)
		{
			System.out.println("Error occured is :" + wfe.getMessage());
		}
	}



	private void notifyProcessCompletion(HashMap outputParameters, String PID,String mid) throws JMSException {
		
		QueueConnectionFactory cf= null;
		QueueConnection conn = null;
		QueueSession jmsSession = null;
		Context context = null;
		try {
			Hashtable env = new Hashtable();
			
			conn = getQueueConnection(Utility.getConnectionFactoryName());
			Destination dest = getDestinationQueue(Utility.getStatusQueueName());
			jmsSession = conn.createQueueSession(false,
					Session.AUTO_ACKNOWLEDGE);
			System.out.println("After Getting QueueSession .. " + jmsSession);
			MessageProducer producer = jmsSession.createProducer(dest);
			System.out.println("starting Connection");
			conn.start();
			TextMessage message = jmsSession.createTextMessage();
			System.out.println("Output parameters are"+outputParameters.size()+"/n contents"+outputParameters);
			ResultXMLCreator  resultXMLCreator = new ResultXMLCreator(outputParameters);
			String xmlMsg =  resultXMLCreator.procCompleteTree(PID);
			message.setText(xmlMsg);
			System.out.println("notifyProcessCompletion MSG : "+xmlMsg);
			producer.send(message);
			producer.close();
			jmsSession.close();
			conn.close();

		} catch (Exception exp) {
			exp.printStackTrace();
		}
	}

	public void terminateWFProcess(String processId,String userId,String sRequest){
		try
		{
			PEASProcInstMgmtIF receiver = initiatePeas();
			receiver.terminateProcessInstance(processId,userId,sRequest);

		}catch(peas.client.api.intf.exception.PEASAPIException e)
		{
			System.out.println("\n\n **** Terminate exception caught");
			throw new WorkflowSysException(sLogName,e.getMessage(),e);
		}
	}

	private static PEASProcInstMgmtIF initiatePeas() {
		try
		{
			InstanceMgmtFactoryIF instMgmtFactory = (InstanceMgmtFactoryIF)PEASClassLoader.GetPEASClassLoader().getPEASAPIFactoryIF(InstanceMgmtFactoryIF.FACTORY_NAME);
			PEASProcInstMgmtIF receiver = instMgmtFactory.getPEASProcInstMgmtIF();
			return receiver ;
		}catch(Exception ex)
		{
			throw new WorkflowSysException(sLogName,WorkflowSysExpConstants.ERROR_GENERAL,ex);
        }
	}
		
	private QueueConnection getQueueConnection(String connFact) {
		QueueConnection conn = null;
		try {
			Context context = Utility.getInitialContext();
			QueueConnectionFactory cf = (QueueConnectionFactory) context
					.lookup(Utility.getConnectionFactoryName());
			conn = cf.createQueueConnection();
			//conn.start();
			System.out.println("Inside getQueueConnection() Got the conn .."+conn);
		}catch(Exception exp){
			exp.printStackTrace();
		}
		return conn;
	}

		/**
		 * Get the Destination queue
		 * @param String queueName
		 * @return dest Destination
		 */
		private Destination getDestinationQueue(String queueName){
			Destination dest = null;
			try {
				Context context = Utility.getInitialContext();
				dest = (Destination) context.lookup(queueName);
				System.out.println("After Getting Queue .. " + dest);
			}catch(Exception exp){
				exp.printStackTrace();
			}
			return dest;
		}
}
