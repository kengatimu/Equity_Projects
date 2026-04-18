/*
 * Created on Jan 10, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Generation - Code and Comments
 */


package com.infy.finacle.workflow.mdb.common;


import java.io.File;

/**
 * @author Tamilselvan.R
 *
 * Description:
 *
 * This class contains common utility methods that can be used by any class in PEAS.
 *
 */


public class PeasUtils {

	private static String peas_home = null;
	/**
	 * This method checks whether the supplied type is a simple type or a complex type. It returns true if the type is
	 * a simple type as per PEAS platform and false if it is not a simple type. This method can be used to
	 * generically check in PEAS if a property in a process context is of simple type as per PEAS or not, given the
	 * Property.getType() as input to it.
	 *
	 * @param type
	 * @return boolean
	 */
	public static boolean isSimpleType(String type)
	{
		if ((Object) type == null)
			return false;
		if (type.length() == 0)
			return false;

		if ( type.equals(StringConstants.STRING_PROP_TYPE) || type.equals(StringConstants.INT_PROP_TYPE) ||
			type.equals(StringConstants.CHAR_PROP_TYPE) ||	type.equals(StringConstants.SHORT_PROP_TYPE) ||
			type.equals(StringConstants.LONG_PROP_TYPE) || type.equals(StringConstants.FLOAT_PROP_TYPE) ||
			type.equals(StringConstants.DOUBLE_PROP_TYPE) || type.equals(StringConstants.BOOLEAN_PROP_TYPE) ||
			type.equals(StringConstants.BYTE_PROP_TYPE))

			return true;
		else
			return false;
	}

	/**
	 * This method returns value of System varibale PEAS_HOME
	 *
	 * @return String
	 */
	public static String getPEASHome(){
		if(null != peas_home)
			return peas_home;

		// kept this code for future
		// if we use Java 1.5 then we may not set the PEAS_HOME
		// variable at the time of start up of web/app server
		if (System.getProperty("java.runtime.version").startsWith("1.5")) {
			peas_home =  (String) System.getenv("PEAS_HOME");
		}else{
			// read the system variable set at the startup of web/app server
			peas_home = System.getProperty("PEAS_HOME");
			if (peas_home == null || peas_home.length() == 0) {
				peas_home = System.getProperty("user.dir");
			}
		}
		if(null == peas_home){
			String errMessage = "Value for PEAS_HOME is not set";
			System.out.println("PEAS_HOME Error: " + errMessage);
		}
		return peas_home;
	}
	private static boolean isValidPeasHome(String peas_home){
		boolean flag = true;
		File file = new File(peas_home);
//		Check whethet the directory peas_home exists or not
		if(!file.isDirectory())  
			flag = false;
		else{ 
			//If peas_home directory exists, then check whether it is a valid peas_home or not
			String tmp = peas_home + File.separator + "Applications"; //Just check whether procserver1 directory exist inside PEAS_HOME or not
			File file2 = new File(tmp);
			if(!file2.isDirectory())
				flag = false;
		}
		return flag;
	}
}
