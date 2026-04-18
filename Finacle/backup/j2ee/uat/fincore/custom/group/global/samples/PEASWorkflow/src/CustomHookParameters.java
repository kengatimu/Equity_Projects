/* This is a Peas generated Class
   This method is used when a System Activity is used in the 
   definition of a Workflow Process .*/
  
/*Used with CustomHook.java */

package com.peas;

import java.util.HashMap;
import java.io.Serializable;

public class CustomHookParameters implements Serializable{
	private HashMap outMap = new HashMap();
	private HashMap inMap = null;

	public CustomHookParameters(HashMap inMap,HashMap outMap){
		this.inMap=inMap;
		if(outMap!=null)
		this.outMap=outMap;
	}

	//generate a setter method for each key in output hashmap
	public void setacctName(String value){
		outMap.put("acctName",value);
	}

	// get output hashmap
	public HashMap getOutputMap() {
		return outMap;
	}
	// get input hashmap
	public HashMap getInputMap() {
		return inMap;
	}

	//generate a getter method for each key in input hashmap
	public String getscriptName() throws Exception{
		if (!isscriptNameSet()){
			throw new Exception("Value for CustomHookParameters scriptName is not set ");
		}
		return (String) inMap.get("scriptName");
	}

	public boolean isscriptNameSet(){
		if (inMap.containsKey("scriptName")){
			return true;
		}
		return false;
	}
	public String getforacid() throws Exception{
		if (!isforacidSet()){
			throw new Exception("Value for CustomHookParameters foracid is not set ");
		}
		return (String) inMap.get("foracid");
	}

	public boolean isforacidSet(){
		if (inMap.containsKey("foracid")){
			return true;
		}
		return false;
	}
}

