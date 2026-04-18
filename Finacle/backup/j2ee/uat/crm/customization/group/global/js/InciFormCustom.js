// CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES

function customSave() {
 }
// CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES
 
 //APAC modification for support Req # 21
 //This function is written for a text field 
 //Depending on the conditions such as ServiceRequest type,userfield and value of userfield
 //some other field is made mandatory
 //Reqtype over here is ServiceRequest type which is Type1_Type2_Type3
 //Depending on the name of userfield and its value which over here is IncidentBO.userField1
 //and only if its value is not null IncidentBO.userField2 is made mandatory and a star is displayed 
 //indicating that the userField2 has been made mandatory else it is not made mandatory
 function coMandatoryText(userField){
  	if ( Reqtype == 'ARUN_SS_HH'){
   		if(userField.name=='IncidentBO.userField1'){
   			if(userField.value!= ""){	
   				document.getElementsByName("IncidentBO.userField2")[0].IsMandatory = "true";
  				document.getElementsByName("mandStarIncidentBO.userField2")[0].style.visibility="visible";
  				}
  			else{
  				document.getElementsByName("IncidentBO.userField2")[0].IsMandatory = "false";
  				document.getElementsByName("mandStarIncidentBO.userField2")[0].style.visibility="hidden";
  			}	
  		}
  	}
  }
 
 //This function is written for change in values of a combo box 
 //Depending on the conditions such as ServiceRequest type,value of userfield in a combo box
 //some other field is made mandatory
 //Reqtype over here is ServiceRequest type which is Type1_Type2_Type3
 //Depending on the value of the userField ie the value in the combo IncidentBO.userField2 is 
 //made mandatory and a star is displayed next to it indicating that the userField2 has been made
 //mandatory else it is not made mandatory

 
  function coMandatoryCombo(userField){
  
  if (Reqtype=='ARUN_SS_HH' & userField.value == "Y"){
   	document.getElementsByName("IncidentBO.userField2")[0].IsMandatory = "true";
  	document.getElementsByName("mandStarIncidentBO.userField2")[0].style.visibility="visible"; 	
  }
  else {
  	document.getElementsByName("IncidentBO.userField2")[0].IsMandatory = "false";
  	document.getElementsByName("mandStarIncidentBO.userField2")[0].style.visibility="hidden";
 
    }
  }
 
 //This method is Written for on blur of a textarea
 //Depending on the conditions such as ServiceRequest type,userfield and value of userfield
 //some other field is made mandatory
 //Reqtype over here is ServiceRequest type which is Type1_Type2_Type3
 //Depending on the name of userfield and its value which over here is IncidentBO.userField1
 //and only if its value is not null IncidentBO.userField2 is made mandatory and a star is displayed 
 //indicating that the userField2 has been made mandatory else it is not made mandatory

 
 function coMandatoryTextArea(userField){
   	if ( Reqtype == 'ARUN_SS_HH'){
   		if(userField.name=='IncidentBO.userField1'){
   			if(userField.value!= ""){	
   				document.getElementsByName("IncidentBO.userField2")[0].IsMandatory = "true";
  				document.getElementsByName("mandStarIncidentBO.userField2")[0].style.visibility="visible";
  				}
  			else{
  				document.getElementsByName("IncidentBO.userField2")[0].IsMandatory = "false";
  				document.getElementsByName("mandStarIncidentBO.userField2")[0].style.visibility="hidden";
  			}	
  		}
  	}
 }
 
 //End of APAC modification for Support Req # 21