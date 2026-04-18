/*
 * Created on Jan 12, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

package com.infy.finacle.workflow.mdb.common;

import java.io.*;
import java.util.*;


import javax.naming.*;

/**
 * @author Tamilselvan.R
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */


public class Utility {


	public static final String PARENT_PROC_ID_LITERAL = "TID";
	public static final String USER_ID = "UserID";
	public static final String USER_ROLE = "UserRole";
	public static final String PROCESSNAME_LITERAL = "Request";

	
	private static Properties properties;
	//public static final String CONFIGFILE_PATH_WIN =CommonUtils.getWASHome() + File.separator + "procserver1" + File.separator + "properties"+File.separator + "jndi.properties";
	public static final String CONFIGFILE_PATH_WIN = PeasUtils.getPEASHome() + File.separator + "Applications" + File.separator + "defaultApp" + File.separator + "ApplicationConfig" + File.separator + "jndi.properties";

	/**
	 * Static block to read the processsprok to read th
	 */
	static {
		loadProperties();
	}

	/**
	 * Get the user name to connect to qcf
	 * @return username
	 */
	public static String getUserName() {
		return (String)properties.get("USER_NAME");
	}

	/**
	 * Get the password
	 * @return password
	 */
	public static String getPassword() {
		return (String)properties.get("PASSWORD");
	}

	/**Create a Random Number using Date and Time
	 * and Creating a name Tag to xml file
	 * @return String
	 */
	
	public static String getDateTime(){
		Calendar calendar = new GregorianCalendar();
	    int am_pm;
	    int day=calendar.get(Calendar.DATE);
	    int month = calendar.get(Calendar.MONTH);
	    int Year = calendar.get(Calendar.YEAR);
	    int hour = calendar.get(Calendar.HOUR);
	    int minute = calendar.get(Calendar.MINUTE);
	    int second = calendar.get(Calendar.SECOND);
	    int milliSecond=calendar.get(Calendar.MILLISECOND);
	    if(calendar.get(Calendar.AM_PM) == 0)
	      am_pm = hour;
	    else
	      am_pm = hour+12;
	    System.out.println(day+"Current Time : " + am_pm + ":" 
	+ minute + ":" + second );
	    String dateString = String.valueOf(day)+String.valueOf(month+1)+String.valueOf(Year)+String.valueOf(am_pm)+String.valueOf(minute)+String.valueOf(second)+String.valueOf(milliSecond);
	    System.out.println("Num is " + dateString);
	
	return dateString;
	}
	
	
	
	
	
	/**
	 * Get the request queue name
	 * @return request queue name
	 */
	public static String getRequestQueueName() {
		return (String)properties.get("QUEUE1");
	}

	/**
	 * Get the response queue name
	 * @return response queue name
	 */
	public static String getResponseQueueName() {
		return (String)properties.get("QUEUE2");
	}

	/**
	 * Get the status queue name
	 * @return status queue name
	 */
	public static String getStatusQueueName() {
		return (String)properties.get("QUEUE3");
	}

	/**
	 * Get the JMS Queue connection factory name
	 * @return qcf name
	 */
	public static String getConnectionFactoryName() {
		return (String)properties.get("QCF");
	}

	/**
	 * Get the Initial Context Factory name
	 * @return context factory name
	 */
	public static String getProviderURL() {
		return (String)properties.get("java.naming.provider.url");
	}

	/**
	 * Get the Initial Context Factory name
	 * @return context factory name
	 */
	public static String getInitialContextFactory() {
		return (String)properties.get("java.naming.factory.initial");
	}

	/**
	 * Load the  properties file.
	 */
	private static void loadProperties() {
		File file = null;
		FileInputStream fis = null;

		try {
			file = new File(CONFIGFILE_PATH_WIN);
			fis = new FileInputStream(file);
			properties = new Properties();
			properties.load(fis);

		}
		catch(IOException ioe) {
			ioe.printStackTrace();
		}
		finally {
			try {
				if(fis != null) fis.close();
			}
			catch(IOException ioe) {
				ioe.printStackTrace();
			}
		}
	}

	/**
	 * Get the initial context.
	 */
	public static Context getInitialContext() {
		Context ctx = null;
		try {
			Properties prop = new Properties();
			prop.put(Context.PROVIDER_URL, properties.get(Context.PROVIDER_URL));
			prop.put(Context.INITIAL_CONTEXT_FACTORY, properties.get(Context.INITIAL_CONTEXT_FACTORY));
			ctx = new InitialContext(prop);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return ctx;
	}
}
