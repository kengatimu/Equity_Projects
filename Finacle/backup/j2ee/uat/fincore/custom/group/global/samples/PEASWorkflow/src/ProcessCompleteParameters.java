/**
 * Auto generated code from InFluxPA
 * Version 0.96
 * Generated on 23-10-2007 17:56
 * Author poornima_rao
 */
package com.infy.finacle.workflow.mdb.processcomplete;
import java.util.HashMap;
import java.io.Serializable;

public class ProcessCompleteParameters implements Serializable{

	private HashMap outMap = new HashMap();
	
	private HashMap inMap = null;

	public ProcessCompleteParameters(HashMap inMap,HashMap outMap){
		this.inMap=inMap;
		System.out.println("This.inMap = " + this.inMap + "Parameter inMap = "+ inMap);
		if(outMap != null) {
			this.outMap=outMap;
			System.out.println(" Inside if This.outMap = " + this.outMap + "Parameter outMap = "+ outMap);
		}
		System.out.println("This.outMap = " + this.outMap + "Parameter outMap = "+ outMap);
	}
	
//	set output hashmap
	public void setOutputMap(HashMap outMap) {
		this.outMap = outMap;
		System.out.println("This.outMap = " + this.outMap + "Parameter outMap = "+ outMap);
	}

//	set input hashmap
	public void setInputMap(HashMap inMap){
		this.inMap = inMap;
		System.out.println("This.inMap = " + this.inMap + "Parameter inMap = "+ inMap);
	}
//	get output hashmap
	public HashMap getOutputMap() {
		return outMap;
	}

//	get input hashmap
	public HashMap getInputMap(){
		return inMap;
	}
	
//generate a getter method for each key in input hashmap

//	generate a setter method for each key in output hashmap
}
