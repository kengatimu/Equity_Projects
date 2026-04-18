/*
 * Created on Jan 12, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

package com.infy.finacle.workflow.mdb.processcomplete;

/**
 * @author Tamilselvan.R
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

public class OutputUtility{

	private String paramName;
	
	private String paramValue;
	
	
	
	public OutputUtility(String paramName, String paramValue) {
		this.paramName = paramName;
		this.paramValue = paramValue;
			}
	
	public String getparamValue() {
		return paramValue;
	}

	public void setparamValue(String paramValue) {
		this.paramValue = paramValue;
	}

	public String getparamName() {
		return paramName;
	}

	public void setparamName(String paramName) {
		this.paramName = paramName;
	}
	
	

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append(" { Output parameters are --");
		sb.append("ParamName:" + getparamName());
		sb.append(",");
		sb.append("ParamValue:" + getparamValue());
		sb.append(". } \n");
		return sb.toString();
	}
}
