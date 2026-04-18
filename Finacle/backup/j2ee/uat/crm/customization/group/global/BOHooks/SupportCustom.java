/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: SupportCustom.java $
 *
 * Author: APAC
 *
 * $History: SupportCustom.java $
 *****************************************************************************/

 package com.infy.cis.custom;

 public class SupportCustom
 {


	 public static boolean updateActivity(String activityType){

	 	  	if (activityType == null) {
	 			activityType = "";
	 		}

	 		if (activityType.equals("IncidentCreated")){
	 			return true;
	 		}

	 		if (activityType.equals("NewMessageCreated")){
	 			return true;
	 		}

	 		if (activityType.equals("FileAttached")){
	 			return true;
	 		}

	 		if (activityType.equals("WItemCreated")){
	 			return true;

	 		}

	 		if (activityType.equals("WItemUpdated")){
	 			return true;
	 		}

	 		return false;
  }
}