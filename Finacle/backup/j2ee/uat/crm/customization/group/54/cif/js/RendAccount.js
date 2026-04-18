// BEGIN OF ML CHANGESs
	//Ticket 349330 changes end
	/*c hanges for 404 error */
/* document.write('<script language=javascript src="'+applPath+'/Customization/js/AccFormCustom.js">'+'<\/script>'); */
/* changes for 404 error */
	//Ticket 349330 changes end
/* Tracker#174227 -: removal of duplicate imports */
/*document.write('<script language="javascript" src="'+applPath+'/common/js/SRMTableRowColor.js"></script>');*/
/* Tracker#174227 -: removal of duplicate imports */
// END OF ML CHANGES
/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
/* including a file having conversion logic*/
/* START  Changes for Tracker # 209607*/
document.write('<script type="text/javascript" src="../common/js/Reduce_Form.js" language="javascript"></script>');
/* END  Changes for Tracker # 209607*/
//Added by Mani validate based on scheme SB137,SB147,SB139,SB146,SB145,SB138,SB136,SB135,SB130
document.write('<script language=javascript src="../Customization/js/SchemeValidationCore.js"></script>');
document.write('<script language=javascript src="../Customization/js/DormantValidationCore.js"></script>');
//End
/*ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/

        var partnerSave = false;
        var gaurdianErr="false";
/* START  Changes for Tracker # 209607*/
	//Tracker 222035 undefined check added
        if(document.frm2!=null && document.frm2.boName!=undefined && document.frm2.mainAccId!=undefined){
	var boName= document.frm2.boName.value;
	var mainAccId= document.frm2.mainAccId.value;
	}
/* END  Changes for Tracker # 209607*/
    var ad_addrID           = new Array();
    var ad_address_type     = new Array();
    var ad_houseno          = new Array();
    var ad_premiseno        = new Array();
    var ad_end_date         = new Array();
    var ad_start_date       = new Array();
    var ad_state            = new Array();
    var ad_state_cat        = new Array();
    var ad_city             = new Array();
    var ad_city_cat         = new Array();
    var ad_zip              = new Array();
    var ad_country          = new Array();
    var ad_country_cat      = new Array();
    var ad_building         = new Array();
    var edu_detachedURLs    = new Array();
    var edu_Status          = new Array();
    var ad_streetno         = new Array();
    var ad_town	            = new Array();
    var ad_domicile         = new Array();
    var ad_locality	    = new Array();
    var ad_website	    = new Array();
    var ad_mailstop	    = new Array();
    var ad_streetname	    = new Array();
    var ad_suburb	    = new Array();
    var ad_extension	    = new Array();
    var ad_IsAddressProofRcvd= new Array();
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
    var ad_IsAddressVerified= new Array();
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
    var address_type = "";
    var EDoc_identifier_type_Code     = new Array();
    var EDoc_unique_id                = new Array();
    var EDoc_placeofissue             = new Array();
    var EDoc_placeofissue_cat         = new Array();
    var EDoc_countryofissue           = new Array();
    var EDoc_countryofissue_cat       = new Array();
    var EDoc_dateofissue              = new Array();
    var EDoc_validity_date            = new Array();
    var EDoc_EntityDocumentID         = new Array();
    var EDoc_EntityDocumentURL        = new Array();
    var EDoc_URL                      = new Array();
    var EDoc_Status                   = new Array();
    var EDoc_detachedURLs             = new Array();
    var currIDTableRow      		  = null;
    var IDArrayIndex        		  = null;
    var IDRecordIndex       		  = null;
    var EDoc_docCode          		  = new Array();
    var EDoc_docDescr         	      = new Array();
    var EDoc_docTypeCode      		  = new Array();
    var EDoc_docTypeDescr     		  = new Array();
    var EDoc_docReceivedDate  		  = new Array();
    var EDoc_docRemarks       		  = new Array();
    var EDoc_isMandatory      		  = new Array();
    var EDoc_scanRequired     		  = new Array();
    var EDoc_IsDirty                  = new Array();
    var EDoc_isDocumentVerified    	  = new Array();
    var EDoc_idIssuedOrg              = new Array();
    var updateIDDet 				  = false;
    var splittedCustids 			  = new Array();
    var edu_URL             = new Array();
	var ad_PreferredFormat = new Array();
	var ad_HoldMailReason = new Array();
	var ad_BusinessCenter = new Array();
	var ad_HoldMailInitiatedBy = new Array();
	var ad_HoldMailFlag = new Array();
	var ad_AddressLine1 = new Array();
	var ad_AddressLine2 = new Array();
	var ad_AddressLine3 = new Array();
	var ad_FreeTextLabel = new Array();
	var ad_PhoneOrEmail = new Array();
	var ad_PhoneNo = new Array();
	var ad_PhoneNoCountryCode = new Array();
	var ad_PhoneNoCityCode = new Array();
	var ad_PhoneNoLocalCode = new Array();
	var ad_PhoneEmailType = new Array();
	var ad_PhoneEmailID = new Array();
	var ad_Email = new Array();
	var phoneEmail_URL = new Array();
	var phoneEmail_Status = new Array();
	var phone_detachedURLs = new Array();
    // Fix for ticket 204571 and tracker 122535 start
     var ad_cellno_local = new Array();
     // Fix for ticket 204571 and tracker 122535 ends
    var ad_cityCode	   = new Array();
    var ad_stateCode	   = new Array();
    var ad_cntryCode	   = new Array();

    //CORE Fields Inclusion : end
    //Changes Done for Ticket id : 274391
/* START  Changes for Tracker # 209607*/
    //var escChars = new Array(',');
    var escChars = new Array('\'');
/* END  Changes for Tracker # 209607*/
    /*Tracker 159095 : Sonali begin of changes*/
    var escCharsAddr = new Array('%');
    /*Tracker 159095 : Sonali end of changes*/
    var updateEduDet = false;
    var editMode = false;
    var adrWindow = null;
    var recordIndex = null;
    var phoneRecordIndex = null;
    var emailRecordIndex = null;
    var servletURL = null;
    var reserveCIFID="";
    try {
		var selTabId = parent.parent.parent.parent.frames(0).getSelectedTabId();
	} catch(e) {
	}
    var lookupFor = '';
	//Added by Mani validate bansed on scheme SB137,SB147,SB139,SB146,SB145,SB138,SB136,SB135,SB130
document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0].IsMandatory = "false";
//END
/*Tracker 61887 Begin of Changes*/
function makeDateMand(){
		if(document.getElementsByName(boName+".CustomerNREFlg")[0].value == "Y") {
			document.getElementsByName("mandStarAccountBO.DateOfBecomingNRE")[0].style.visibility="visible";
			document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0].disabled=false;
        /* Fix for ticket 220098 and tracker 132135 start*/
	document.getElementsByTagName("img")[2].style.visibility='visible';
        /* Fix for ticket 220098 and tracker 132135 ends*/
        
        		/* Fix for ticket 330445 and tracker 218151 starts*/
			document.getElementsByTagName("a")[2].style.visibility='visible';
			/* Fix for ticket 330445 and tracker 218151 ends*/
			}
			else
			{
			//Changes for ticket id 220098 and tracker 132135 Start
			document.getElementsByName("mandStarAccountBO.DateOfBecomingNRE")[0].style.visibility="hidden";
			document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0].value='';
			document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0].disabled=true;
			//changes for callid 751687 starts
			if(document.getElementsByName("AccountBO.DateOfBecomingNRE")[0])
				document.getElementsByName("AccountBO.DateOfBecomingNRE")[0].value='';
					//changes for callid 751687 ends
			/* fix for tracker id 336787 starts */
			//document.getElementsByName(boName+".StaffFlag")[0].focus();
			//Changes for call id 408886 Starts Here
			//document.getElementsByName(boName+".Gender")[0].focus();
//Changes for call id 408886 Ends Here
			
			/* fix for tracker id 336787 ends */
			document.getElementsByTagName("img")[2].style.visibility='hidden';
			
			/* Fix for ticket 330445 and tracker 218151 starts*/
			document.getElementsByTagName("a")[2].style.visibility='hidden';
		 	/* Fix for ticket 330445 and tracker 218151 ends*/

			}
			//Changes for ticket id 220098 and tracker 132135 End
		}
	/*Tracker 61887 End of Changes*/
       
        /*Tracker 61888 Begin of Changes*/
 	function setStaffEmployeeIdMandatory(isMandatory){
 	    if(isMandatory){
 		document.getElementsByName("mandStarAccountBO.StaffEmployeeID")[0].style.visibility="";
 		document.getElementsByName("AccountBO.StaffEmployeeID")[0].IsMandatory = "true";
 	    }else{
 		document.getElementsByName("mandStarAccountBO.StaffEmployeeID")[0].style.visibility="hidden";
 		document.getElementsByName("AccountBO.StaffEmployeeID")[0].IsMandatory = "false";
 	    }
 	}
 	/*Tracker 61888 End of Changes*/
      
        function callValidateDoubleLength(object){
            var amtValid = "true";
            if(object.value != ''){
                if ("false" == parent.parent.parent.parent.parent.validateDoubleLength(object)){
                        amtValid = "false";
                }
            }
            return amtValid;
        }
        function ValidateDiscount(){
            try{
                var discValidate = "true";
                var prefRelshipDiscount1 = parent.formDispFrame.frames(1).SecUserArea.IFrmtab1.document.getElementsByName("PsychographicBO.prefRelshipDiscount1")[0];
                discValid = callValidateDoubleLength(prefRelshipDiscount1);
                if(discValid == "false"){
                    discValidate = discValid;
                }
                var prefRelshipDiscount2 = parent.formDispFrame.frames(1).SecUserArea.IFrmtab1.document.getElementsByName("PsychographicBO.prefRelshipDiscount2")[0];
                discValid = callValidateDoubleLength(prefRelshipDiscount2);
                if(discValid == "false"){
                    discValidate = discValid;
                }
                var prefRelshipDiscountPercent1 = parent.formDispFrame.frames(1).SecUserArea.IFrmtab1.document.getElementsByName("PsychographicBO.prefRelshipDiscountPercent1")[0];
                discValid = callValidateDoubleLength(prefRelshipDiscountPercent1);
                if(discValid == "false"){
                    discValidate = discValid;
                }
                var prefRelshipDiscountPercent2 = parent.formDispFrame.frames(1).SecUserArea.IFrmtab1.document.getElementsByName("PsychographicBO.prefRelshipDiscountPercent2")[0];
                discValid = callValidateDoubleLength(prefRelshipDiscountPercent2);
                if(discValid == "false"){
                    discValidate = discValid;
                }
                return discValidate;
            }catch(e){}
        }
        function setMailingAddressMandatory(){
            object = document.getElementsByName("Mailing.txt_Address1")[0];
            object.IsMandatory = "true";
            object.Display = "Mailing Address : Address Line 1";
            object.Name = "Address Line1";
            object = document.getElementsByName("Mailing.txt_Address2")[0];
            object.IsMandatory = "true";
            object.Display = "Mailing Address : Address Line 2";
            object.Name = "Address Line2";
            object = document.getElementsByName("Mailing.txt_Address3")[0];
            object.IsMandatory = "true";
            object.Display = "Mailing Address : Address Line 3";
            object.Name = "Address Line3";
            object = document.getElementsByName("Mailing.txt_City")[0];
            object.IsMandatory = "true";
            object.Display = "Mailing Address : City";
            object.Name = "City";
            object = document.getElementsByName("Mailing.txt_State")[0];
            object.IsMandatory = "true";
            object.Display = "Mailing Address : State";
            object.Name = "State";
            object = document.getElementsByName("Mailing.txt_Zip")[0];
            object.IsMandatory = "true";
            object.Display = "Mailing Address : Zip";
            object.Name = "Zip";
            object = document.getElementsByName("Mailing.txt_Country")[0];
            object.IsMandatory = "true";
            object.Display = "Mailing Address : Country";
            object.Name = "Country";
        }
        /* Function add for FATCA to validate Last Foreign Tax Reporting Review Date */
        
        
        
        
        
        
                /**changes for tracker id 343658 begin***/
        
        function validateLastTaxReprtReviewDate()
	{
	 
	 var final = document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
	 	 var elem10 = document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0];
	 	 if(elem10.value != null && elem10.value != '' && final != null && final != ''){
	 	 	 		
	 	 	 		isGregDate("3_AccountBO.LastForeignTaxReviewDate");
	 	 	 		
	 	 	 			
	 	 	 		var mill11 = changetoMillisInUSFormat(final);
						
					var mill22 = changetoMillis(elem10.value);
						
							if (mill11 > mill22){
							
												showMessage(MSGJ62623);
												document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0].value='';
												/*Changes done for ticket:366838 Starts*/
												//document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].value='';
												/*Changes done for ticket:366838 Starts*/
												document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0].focus();
												return;
				}
	 	}
	 	 
	 
	 
	 var varDate=document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0].value;
	 if((varDate!=null)&&(trim(varDate)!=""))
	  {
	 isGregDate("3_AccountBO.LastForeignTaxReviewDate");
      
         var todaydate = new String();
	 todaydate.value =  getTodayDate1(locDate);
 	
   	var date = document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0];
	
	
	
	 if (date.value != '')
	 {
			
			todaydate.value = convertDate(todaydate.value);
			
						
	 }					
	 
					
	 var elem1 = document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0];
	 
	 var mill1 = changetoMillisInUSFormat(todaydate.value);
	
	
	 
	  var mill2 = changetoMillis(elem1.value);
	
	
		if (mill1 < mill2){
							showMessage(MSGJ62624);
							document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0].value='';
							/*Changes done for ticket:366838 Starts*/
							//document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].value='';
							/*Changes done for ticket:366838 Starts*/
							document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0].focus();
							return;
		}
	//FIX FOR  TRACKER ID 162037 START
	       //Comparing incorporation date with issue date
	      
	       
	       
	          var nextTaxReprtReviewDate = document.getElementsByName("3_AccountBO.NextForeignTaxReviewDate")[0];
	     
	         compareDOB1(nextTaxReprtReviewDate,mill2);
	       
	   
	       }
	
	
	return "true";
}
        
                /**changes for tracker id 343658 end***/
        
        
        
     /*  FATCA Changes Ends */   
        
        
        
        
        
          /* Function add for FATCA to validate Last Foreign Tax Reporting Review Date */
        
        function validateNextTaxReprtReviewDate()
	{
	 var varDate=document.getElementsByName("3_AccountBO.NextForeignTaxReviewDate")[0].value;
		 if((varDate!=null)&&(trim(varDate)!=""))
	  {
	
	       
		        isGregDate("3_AccountBO.NextForeignTaxReviewDate");
		     
		       
		        
	 
	       
		var todaydate = new String();
		todaydate.value = getTodayDate();
		
	
	
	var date = document.getElementsByName("3_AccountBO.NextForeignTaxReviewDate")[0];
	
	if (date.value != '')
	{
			
			todaydate.value = convertDate(todaydate.value);
			
						
	}					
							
		
		
		elem1 = document.getElementsByName("3_AccountBO.NextForeignTaxReviewDate")[0];
		
		
		var mill1 = changetoMillisInUSFormat(todaydate.value);
		
		var mill2 = changetoMillis(elem1.value);
		
		
		if(mill1 > mill2)
		{
		
			
			 showMessage(MSGJ62320);
			elem1.value = "";
			// elem1.focus();
			return "false";
		}
		
	
	   
	       	       
	      var elem4 = document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0];
	    
	    
	    var mill5 = changetoMillis(elem4.value);
	    
	    var   mill4 = document.getElementsByName("3_AccountBO.NextForeignTaxReviewDate")[0];
	        
	        compareDOB1(mill4,mill5);
	        
	       
		
		return "true";
		
		}
		
		
}
        
        
        
        
        
     /*  FATCA Changes Ends */       
        
        /* Function add for FATCA  */
        
        
            
        function compareDOB1(dob,mill2)
	{
		/* CRM102ST: TrackerID:177826 Being of Change */
		/* Checking only if dob value is valid one */
		if(dob){
		var mill3 = changetoMillis(dob.value);
		
		if(elem1.value!='' && dob.value != '' && dob.value != null && dob.value != 'undefined')
		{
			if (mill3 < mill2)
			{       
			showMessage(MSGJ62321);
			 
				elem1.value = "";
				// elem1.focus();
				return "false";
			}
		}
		}
		/* CRM102ST: TrackerID:177826 End of Change */
}
        
        
        
        
        
        /*  FATCA Changes Ends */
        
        /* Changes Made for FATCA */
        
        
       function checkForeignAccTaxReport(){
       
         
      var v=document.getElementsByName(boName+".ForeignAccTaxReportingReq")[0].value;
       if(v=='Y'){
        document.getElementsByName("mandStarAccountBO.ForeignTaxReportingCountry")[0].style.visibility="visible";
       
      document.getElementsByName("Cat_AccountBO.ForeignTaxReportingCountry")[0].IsMandatory = "true";
         document.getElementsByName("btnone_AccountBO.ForeignTaxReportingCountry")[0].disabled = false;
         document.getElementsByName("AccountBO.ForeignTaxReportingCountry")[0].disabled = false;
        document.getElementsByName("btntwo_AccountBO.ForeignTaxReportingCountry")[0].disabled = false;
            document.getElementsByName("Cat_AccountBO.ForeignTaxReportingCountry")[0].disabled = false;
      
      document.getElementsByName("mandStar"+boName+".ForeignTaxReportingStatus")[0].style.visibility="visible";
	  document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].IsMandatory = "true";
	    document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].disabled = false;

                 document.getElementsByTagName("img")[11].style.visibility="visible";
		  document.getElementsByTagName("img")[11].style.display=""; 
		  document.getElementsByTagName("img")[12].style.visibility="visible";
		  document.getElementsByTagName("img")[12].style.display=""; 
      
      document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0].disabled = false;
        document.getElementsByName("3_AccountBO.NextForeignTaxReviewDate")[0].disabled = false;
        document.getElementsByName("AccountBO.FatcaRemarks")[0].disabled = false;
 
 }
 else{
 
   document.getElementsByName("mandStarAccountBO.ForeignTaxReportingCountry")[0].style.visibility="hidden";
       
        document.getElementsByName("Cat_AccountBO.ForeignTaxReportingCountry")[0].IsMandatory = "false";
        
 document.getElementsByName('Cat_AccountBO.ForeignTaxReportingCountry')[0].value="";
   
  document.getElementsByName('AccountBO.ForeignTaxReportingCountry')[0].value="";
         
       document.getElementsByName("Cat_AccountBO.ForeignTaxReportingCountry")[0].disabled = true;
       document.getElementsByName("AccountBO.ForeignTaxReportingCountry")[0].disabled = true;   
             
        document.getElementsByName("btnone_AccountBO.ForeignTaxReportingCountry")[0].disabled = true;
        
        document.getElementsByName("btntwo_AccountBO.ForeignTaxReportingCountry")[0].disabled = true;
         
        
       document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].value="";

  document.getElementsByName("mandStar"+boName+".ForeignTaxReportingStatus")[0].style.visibility="hidden";
	  document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].IsMandatory = "false";
	    document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].disabled = true;
      
       document.getElementsByName('3_AccountBO.LastForeignTaxReviewDate')[0].value="";
	         document.getElementsByTagName("img")[11].style.visibility="hidden";
		  document.getElementsByTagName("img")[11].style.display="none"; 
		         
		   document.getElementsByTagName("img")[12].style.visibility="hidden";
		  document.getElementsByTagName("img")[12].style.display="none"; 
          document.getElementsByName('AccountBO.LastForeignTaxReviewDate')[0].value="";
	          document.getElementsByName('AccountBO.NextForeignTaxReviewDate')[0].value="";
        document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0].disabled = true;
         document.getElementsByName('3_AccountBO.NextForeignTaxReviewDate')[0].value="";
       
        document.getElementsByName("3_AccountBO.NextForeignTaxReviewDate")[0].disabled = true;
  document.getElementsByName('AccountBO.FatcaRemarks')[0].value="";
 document.getElementsByName("AccountBO.FatcaRemarks")[0].disabled = true;
 
 }
       
       }
        
        
        
        
        
          /*  FATCA Changes Ends */
	function concatName(){

		var fullName=null;
		var lastNameLength = 0;
		var indexCustLastName=0;
		//Changes for Ticket Id 347210 :Start
		var firstName = trim(document.getElementsByName("AccountBO.Cust_First_Name")[0].value);
		var middleName = trim(document.getElementsByName("AccountBO.Cust_Middle_Name")[0].value);
		var lastName = trim(document.getElementsByName("AccountBO.Cust_Last_Name")[0].value);
		//Changes for Ticket Id 347210 :END
		//Changes for Ticket Id 347210 :END

//Equity Changes
	 if(firstName != null && firstName != ""){
				if(!(firstName.length>=80)){
					fullName = firstName.substring(0,80);
				}
				else{
					fullName = firstName;
				}
		}
	if(middleName != null && middleName != ""){
				if(fullName != null && !(fullName.length>=80)){
					fullName = fullName+" "+middleName.substring(0,80);
				}else{
					if(fullName==null){
						fullName = middleName.substring(0,80);
					}
				}
		}
		if(lastName != null && lastName!= ""){
			
			if(fullName != null && !(fullName.length>=80)){
				fullName = fullName+" "+lastName;
		
			}else{
				if(fullName==null){
					fullName = lastName;
				}
		  	}
		}
		if (fullName != null && fullName!= "")
		{
		fullName = fullName.substring(0,80);
		document.getElementsByName("AccountBO.Name")[0].value = fullName.toUpperCase();
		}
		else{
			document.getElementsByName("AccountBO.Name")[0].value = "";
//changes for tracker 401769 fullname alteration ends
		}
		//tracker id 113227 defect fix starts here

		// Tracker Id# 142101 Changes START
		if(parent.parent.IFrmtab4 != undefined){
		var tfpFlg = document.getElementsByName(boName+".TFPartyFlag")[0].value;
		if(tfpFlg == 'Y'){
		  parent.parent.IFrmtab4.formDispFrame.document.getElementsByName("TradeFinanceBO.Name")[0].value=parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("AccountBO.Name")[0].value;
			}
		}
		// Tracker Id# 142101 Changes END

		//tracker id 113227 defect fix ends here
	}
	//Tracker 113227 Begin of changes
	function concatName_alt(){
	if(altLocaleActv == 'true') {//Ticket 335919 changes
	           // Tracker #96121 change
	             var fullName="";
	             var lastNameLength = 0;
	    	 var indexCustLastName=0;
	    	 //Changes for Ticket Id 347210 :Start
	    	 var firstName = trim(document.getElementsByName("AccountBO.Cust_First_Name_alt1")[0].value);
	    	 var middleName = trim(document.getElementsByName("AccountBO.Cust_Middle_Name_alt1")[0].value);
	    	 var lastName = trim(document.getElementsByName("AccountBO.Cust_Last_Name_alt1")[0].value);
	    	 //Changes for Ticket Id 347210 :END
	    	 if(firstName != null && firstName != ""){
	    		fullName = firstName.substring(0,1);
	    	 }
	    	 if(middleName != null && middleName != ""){
	    		if(fullName != null){
	    			fullName = fullName+" "+middleName.substring(0,1);
	    		}else{
	    			fullName = middleName.substring(0,1);
	    		}
	    	 }
	    	 if(lastName != null && lastName!= ""){
	    		lastNameLength = lastName.length;
	    		//Changes for call id 390147- recon of 382974 starts
	    		if(lastNameLength > 76){
	    			indexCustLastName=76;
	    		//Changes for call id 390147- recon of 382974 ends
	    		}else{
	    			indexCustLastName = lastNameLength;
	    		}
	    		if(fullName != null){
	    			fullName=fullName+" "+lastName.substring(0,indexCustLastName);
	    		}else{
	    			fullName=lastName.substring(0,indexCustLastName);
	    		}
	    	 }
	    		document.getElementsByName("AccountBO.Name_alt1")[0].value = fullName;
	    	 	//tracker id 113227 defect fix starts here
			    var tfpFlg = document.getElementsByName(boName+".TFPartyFlag")[0].value;
			    if(tfpFlg == 'Y' && parent.parent.IFrmtab4 !=undefined && parent.parent.IFrmtab4.formDispFrame.document.frm2 != "undefined"){
				parent.parent.IFrmtab4.formDispFrame.document.getElementsByName("TradeFinanceBO.Name_alt1")[0].value=parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("AccountBO.Name_alt1")[0].value;
			    }
		   	//tracker id 113227 defect fix ends here
    		}
    	}
    	//Tracker 113227 End of changes
	function populateAccContAttr()
	{
		if(trim(accountURL) == ""){
			/*Changes for firestone tracker id 350964 Starts*/
			//Changes for Tracker id: 347074 starts

			var indexValue= Cat_bcName.indexOf('#');
			//changes for call id 369294 starts
			var indexValue1= bcName.indexOf('#');
			//var Cat_value=Cat_bcName.substring(0,indexValue);
			var Cat_value=bcName.substring(indexValue1+1);
			//changes for call id 369294 end
			var Cat_textValue = Cat_bcName.substring(indexValue+1);
			if (Cat_textValue == null || Cat_textValue == ''){
			document.getElementsByName("Cat_AccountBO.Primary_sol_id")[0].value = strSolId;
			}
			else{
			document.getElementsByName("Cat_AccountBO.Primary_sol_id")[0].value = Cat_textValue;
			}
			//Changes for Tracker id: 347074 ends
			if (Cat_value == null || Cat_value == ''){
			document.getElementsByName("AccountBO.Primary_sol_id")[0].value = solId;
			}
			else{
			document.getElementsByName("AccountBO.Primary_sol_id")[0].value = Cat_value;
			}
			/*Changes for firestone tracker id 350964 Ends*/
		}
		elem1=eval("document.getElementsByName('AccountBO.accessOwnerGroup')[0]");
		for(i=0;i<elem1.options.length;i++)
			{
				if(elem1.options[i].value==priGrpID)
				{
				elem1.selectedIndex=i
				break;
				}
			}
		elem2=eval("document.getElementsByName('AccountBO.accessOwnerSegment')[0]");
		for(i=0;i<elem2.options.length;i++)
			{
				if(elem2.options[i].value==priSegName)
				{
				elem2.selectedIndex=i
				break;
				}
			}
			setAccessOwnerGroup()
			setBCCodeValues('accessOwnerBC',primBCCODE,primBCID)
		}
          
    	 	
			function validateEmploymentProof()
           	{
           		var staffFlag = document.getElementsByName(boName+".StaffFlag")[0].value ;
      		  //Staff Id validations for 10.2.13    
				if(staffFlag == 'Y' || staffFlag == "EXSTF"){
					var empID = document.getElementsByName("AccountBO.StaffEmployeeID")[0].value ;
					if (empID == '' ){
						/*Tracker 61888 Begin of Changes*/
 						setStaffEmployeeIdMandatory(true);
 					}
 				 }else{
 					setStaffEmployeeIdMandatory(false);
 					/*Tracker 61888 End of Changes*/
				 }
			}
			


                /*Changes done by sonali for 286045 Begin ,
                Commented this function as to call the same function from RendValidate

                Changes done by sonali for 286045 End */

	function swiftAddr(SwiftAddrDet)
	{

		SwiftName=SwiftAddrDet[0];

		SwiftAddr1=SwiftAddrDet[1];
		SwiftAddr2=SwiftAddrDet[2];
		if(SwiftAddr2 == ""){
			SwiftAddr2 = "null";
		}
		SwiftAddr3=SwiftAddrDet[3];
		if(SwiftAddr3 == ""){
			SwiftAddr3 = "null";
		}

		SwiftAddressDetails = SwiftName+"|"+SwiftAddr1+"|"+SwiftAddr2+"|"+SwiftAddr3;
	//Ticket id 439883 and Tracker id 265600 Recon for Call id 225120 changes starts
		SwiftAddressDetails = SwiftAddressDetails.replace(/&/g, "%26");
	//Ticket id 439883 and Tracker id 265600 Recon for Call id 225120 changes ends		
		return true;
	}

	 function checkForIntroducer(BOdateCreated){
	        var JNDINoOfDays = document.frm2.noOfDaysIntro.value;
	       	var JNDINoOfDaysMilliSeconds = JNDINoOfDays*24*60*60*1000;
	       	var dtCreatedDate = BOdateCreated;
	       	var todaydate = new String();
	       	todaydate.value = getTodayDate();
	       	var mill1 = changetoMillis(dtCreatedDate);
	       	var mill2 = changetoMillisForToday(todaydate.value);
	       	var dtCreatedDateMilliSeconds = mill2-mill1;
	       	if (JNDINoOfDaysMilliSeconds > dtCreatedDateMilliSeconds){
	       		return true;
	       	}else{
			return false;
		}
	}
// TrackerID 97346 changes begin
	function check(Tab,setFlag){
	        if(setFlag == false) {
			noValidationMsg = true;
		}
		else {
			noValidationMsg = false;
		}
		//Fix for callid:430243 starts
		try{
		document.getElementsByName("3_ContactBO.DOB")[0].disabled = false;//priya
		}
		catch(e){}
	                  
		validate= parent.parent.parent.parent.ValidateFormContents(document.frm2,true,noValidationMsg,Tab);
		document.getElementsByName("3_ContactBO.DOB")[0].disabled = true;//priya
		return validate;
		//Fix for callid:430243 ends
	}
// TrackerID 97346 changes end
//Tracker ID 113276 changes for currency start
function saveCurrencyDet() {
      document.all.hCurrencyPsychoURL.value = "";
      document.all.hCustomerCurrency.value = "";
      document.all.hCreditDiscountPercent.value = "";
      document.all.hDebitDiscountPercent.value = "";
      document.all.hWithholdTaxPcnt.value = "";
      document.all.hWithholdTaxFloorLmt.value = "";
      document.all.hPreferentialExpiryDate.value = "";
      document.all.hDeletedCurrencyID.value = "";
      document.all.hDeletedCustomerCurrency.value = "";
    for (i=0;i< CU_CustomerCurrency.length;i++)
    {
        if (CU_CustomerCurrency[i] != null && CU_CustomerCurrency[i] != '')
        {
             /*TRACKER:113259:BUG FIX: START:MATPT:CIF Retail>New Entity>Customer>On submitting, Hirji dates are getting saved in misc.info. Start*/
		var strALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
		var strPreferentialExpiryDate = CU_PreferentialExpiryDate[i];
		if(strALTCALENDAR_TYPE = 'true')
		{
			if(strPreferentialExpiryDate != '')
			{
				var strFlag = isGregDateWithoutConv(strPreferentialExpiryDate);
				if(strFlag != 'true')
				{
					strPreferentialExpiryDate=convertHijToGreg(strPreferentialExpiryDate);
				}
			}
		}
		CU_PreferentialExpiryDate[i] = strPreferentialExpiryDate;
              /*TRACKER:113259:BUG FIX:MATPT: END:CIF Retail>New Entity>Customer>On submitting, Hirji dates are getting saved in misc.info. END*/
            if(document.all.hCustomerCurrency.value != '')
            {
              document.all.hCurrencyPsychoURL.value       = document.all.hCurrencyPsychoURL.value + "," + myEscape(CurrPsychoURL[i]);
              document.all.hCustomerCurrency.value        = document.all.hCustomerCurrency.value + "," + myEscape(CU_CustomerCurrency[i]);
              document.all.hCreditDiscountPercent.value   = document.all.hCreditDiscountPercent.value + "," + myEscape(CU_CreditDiscountPercent[i]);
              document.all.hDebitDiscountPercent.value    = document.all.hDebitDiscountPercent.value + "," + myEscape(CU_DebitDiscountPercent[i]);
              document.all.hWithholdTaxPcnt.value         = document.all.hWithholdTaxPcnt.value + "," + myEscape(CU_WithholdTaxPcnt[i]);
              document.all.hWithholdTaxFloorLmt.value     = document.all.hWithholdTaxFloorLmt.value + "," + myEscape(CU_WithholdTaxFloorLmt[i]);
              document.all.hPreferentialExpiryDate.value  = document.all.hPreferentialExpiryDate.value + "," + myEscape(CU_PreferentialExpiryDate[i]);
            }
            else
            {
              document.all.hCurrencyPsychoURL.value       = document.all.hCurrencyPsychoURL.value  + myEscape(CurrPsychoURL[i]);
              document.all.hCustomerCurrency.value        = document.all.hCustomerCurrency.value  + myEscape(CU_CustomerCurrency[i]);
              document.all.hCreditDiscountPercent.value   = document.all.hCreditDiscountPercent.value  + myEscape(CU_CreditDiscountPercent[i]);
              document.all.hDebitDiscountPercent.value    = document.all.hDebitDiscountPercent.value  + myEscape(CU_DebitDiscountPercent[i]);
              document.all.hWithholdTaxPcnt.value         = document.all.hWithholdTaxPcnt.value  + myEscape(CU_WithholdTaxPcnt[i]);
              document.all.hWithholdTaxFloorLmt.value     = document.all.hWithholdTaxFloorLmt.value + myEscape(CU_WithholdTaxFloorLmt[i]);
              document.all.hPreferentialExpiryDate.value  = document.all.hPreferentialExpiryDate.value + myEscape(CU_PreferentialExpiryDate[i]);
            }
        }
    }
/*************************SIT fix******************start**************************/
    if(CU_CustomerCurrency == null || CU_CustomerCurrency == ''){
    	document.all.hCurrencyPsychoURL.value       = currId;
    	document.all.hCustomerCurrency.value        = currText10;
    	document.all.hCreditDiscountPercent.value   = currFlt1;
    	document.all.hDebitDiscountPercent.value    = currFlt2;
    	document.all.hWithholdTaxPcnt.value         = currFlt3;
    	document.all.hWithholdTaxFloorLmt.value     = currFlt4;
    	document.all.hPreferentialExpiryDate.value  = currDate;
    }
/*************************SIT fix******************end**************************/

    //save the deleted url
    for (i=0;i< DeletedCurrencyID.length;i++)
     {
        if (DeletedCurrencyID[i] != null && DeletedCurrencyID[i] != '')
        {
            if(document.all.hDeletedCurrencyID.value != '')
            {
                document.all.hDeletedCurrencyID.value = document.all.hDeletedCurrencyID.value + "," + myEscape(DeletedCurrencyID[i]);
                document.all.hDeletedCustomerCurrency.value = document.all.hDeletedCustomerCurrency.value + "," + myEscape(DeletedCustomerCurrency[i]);
            } else {
                document.all.hDeletedCurrencyID.value = document.all.hDeletedCurrencyID.value  + myEscape(DeletedCurrencyID[i]);
                document.all.hDeletedCustomerCurrency.value = document.all.hDeletedCustomerCurrency.value + myEscape(DeletedCustomerCurrency[i]);
            }
        }
     }
}
//Tracker ID 113276 changes for currency end
	function save(blFlag) {
		// Changes done by sundar for HighRisk category check and mandatory kyc fields : Start
		var highriskcat = document.getElementsByName("AccountBO.StrUserField12")[0].options.value;
var KYC_Date = document.getElementsByName("AccountBO.KYC_Date")[0].value;
var test = KYC_Date.split('/');
var k_date = new Date(test[2],test[1]-1,test[0]);


//var secure_id = document.getElementsByName("AccountBO.Secure_id")[0].value;

var today = new Date();

var date = today.getDate()+'/'+(today.getMonth()+1)+'/'+ today.getFullYear();
var testT = date.split('/');
var today_date  = new Date(testT[2],testT[1]-1,testT[0]);
//kyc_date ends

// KYC review Date changes start
var next_date = today.getDate()+'/'+(today.getMonth()+1)+'/'+ (today.getFullYear()+1);
var nextd_split = next_date.split('/');
var next_date_test = new Date(nextd_split[2],nextd_split[1]-1,nextd_split[0]);

 
var KYC_ReviewDate = document.getElementsByName("AccountBO.KYC_ReviewDate")[0].value;


var rev_test = KYC_ReviewDate.split('/');
var k_reviewDate = new Date(rev_test[2],rev_test[1]-1,rev_test[0]);

		if((highriskcat !='')&&( highriskcat!=undefined))
	 	 {
			if(document.getElementsByName("AccountBO.submitForKYC")[0].value == "")
			{			 
				showUserMessage("Please Enter submitForKYC",'');
				document.getElementsByName("AccountBO.submitForKYC")[0].IsMandatory = "true"; 
				return "false";
			}
			if(document.getElementsByName("AccountBO.riskRating")[0].value == "")
			{			 
				showUserMessage("Please Enter Risk Rating",'');
				document.getElementsByName("AccountBO.riskRating")[0].IsMandatory = "true"; 
				return "false";
			}
			if(document.getElementsByName("AccountBO.KYC_ReviewDate")[0].value == "")
			{
				document.getElementsByName("AccountBO.KYC_ReviewDate")[0].IsMandatory = "true";
				alert("Please Enter KYC_ReviewDate");
				return "interactive";
			}
			if(document.getElementsByName("AccountBO.KYC_Date")[0].value == "")
			{
				document.getElementsByName("AccountBO.KYC_Date")[0].IsMandatory = "true";
				alert("Please Enter KYC_Date");
				return "interactive";
			}
			
		if(k_date.getTime()>today_date.getTime())
			{
				alert("KYC Date Cannot be greater than BOD");
				return "interactive";
			}

		 if(k_date.getTime()<today_date.getTime())
                        {
                                alert("KYC Date Cannot be less than BOD");
                                return "interactive";
                        }
		if(k_reviewDate.getTime()<k_date.getTime())
			{
				alert("KYC_ReviewDate cannot be less than KYC Date");
                                return "interactive";
			}

		if(k_reviewDate.getTime()>next_date_test.getTime())
			{
				alert("KYC_ReviewDate cannot be greater than one year from  KYC Date");
				return "interactive";
			}			


			if(document.getElementsByName("Sec_manager")[0].value == "")
			{
				document.getElementsByName("Sec_manager")[0].IsMandatory = "true";
				alert("Please Enter Secondary Relationship Manager ID ");
				return "interactive";
			}
		 }

		 // Changes done by sundar for HighRisk category check and mandatory kyc fields : Start
	/* Change for 374326 and 374328 start */
	/* Changes made for tracker id 259881:: start */
		if(document.getElementsByName("PsychographicBO.Preferred_Locale")[0]!=null){
		document.frm2.hid_preflocale.value = document.getElementsByName("PsychographicBO.Preferred_Locale")[0].value;
		}
	/* Changes made for tracker id 259881:: end */
	/* Change for tracker id 337846 starts */
	document.frm2.hid_IntroducerName.value = document.getElementsByName("AccountBO.IntroducerName")[0].value;
	document.frm2.hid_IntroducerId.value = document.getElementsByName("AccountBO.IntroducerID")[0].value;
	//change for callid 358638 begins
	if(document.getElementsByName("AccountBO.Introd_Status")[0]!=null){
	document.frm2.hid_Introdstatus.value = document.getElementsByName("AccountBO.Introd_Status")[0].value;
	}
		if(document.getElementsByName("AccountBO.IntroducerSalutation")[0]!=null){
         document.frm2.hid_Introdsalutation.value = document.getElementsByName("AccountBO.IntroducerSalutation")[0].value;
}

	 //Added Mani Certificate Mandatory
        if (operationType=="Edit Entity")
        //if ((operationType=="Edit Entity") || (operationType=="Queue"))
        if(operationType=='Edit Entity')
        {
		var pincertificateval = document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0].value;
		var custstatus = document.getElementsByName('AccountBO.StrUserField30')[0].value;

                if (pincertificateval == "" ) 
                {
					//alert(custstatus);
                    var retval = validatescheme(AccKEY);
					//if (retval == "NO")
                    if (retval == "NO")
                    {
						if (custstatus=='N')
						{
                                //document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0].IsMandatory = "true";
							showUserMessage('PIN Certificate is mandatory.','');
                               	return "interactive";
						}
					else
					{
						document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0].IsMandatory = "false";
						//alert("Pin Not required for now");
						document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0].value ='';
					}
					}
                        else
                        {
                                document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0].IsMandatory = "false";
						//document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0].IsMandatory = "false";
				
                        }
                }
        }
        //END Certificate Mandatory
		
	//change for callid 358638 ends
	/* Change for tracker id 337846 ends */
	/* Change for 374326 and 374328 end */
	// Tracker ID 113276 changes for currency start
	saveCurrencyDet();
	// Tracker ID 113276 changes for currency end
		if(document.frm2.isMCEdited.value=="Y"){
			document.frm2.isMCEditedGeneral.value="Y";
		}
		var tfpFlg = document.getElementsByName(boName+".TFPartyFlag")[0].value;
		// Tracker ID 228683 changes for Basel start
		var object = eval("parent.parent.IFrmtab5");
		var object1= eval("parent.parent.IFrmtab4");
		var opertype=document.frm2.operationType.value;
//changes for callid 676473 starts
		var isDummy=document.frm2.IsDummy.value;
//changes for callid 676473 ends
		if(object!=undefined && object1!=undefined && tfpFlg=='N'){
                         parent.parent.IFrmtab4.formSaveFrame.executionStatus='SUCCESS';
		 }
		if((opertype=='null' || opertype=='') && (isBasel=='Y' || (document.getElementsByName("BaselProfiling")[0] != undefined && document.getElementsByName("BaselProfiling")[0].options.value == 'Yes'))){
		   if(object == null ||  object == "undefined"){	
		   parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserErrorMessage("MSGJ51930",""), "", 'NO_HLINK');
		   parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		   return "interactive";
		}
		}
		// Tracker ID 228683 changes for Basel end
		/*Badri changes : 332591*/
		/* When a form element is disabled, its value is not passed to the processor file.*/
		/*Hence while save, we are enabling the form element so that its value is passed to the processor file */
		document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = false;
		/* End of changes : 332591 */
		var demoMCEDit="N";
		var PsychoMCEdit="N";
		var relBankMCEdit="N";
		var tradeMCEDit="N";
		if(parent.parent.IFrmtab1 !=undefined && parent.parent.IFrmtab1.formDispFrame.document.frm2 != "undefined"){
			demoMCEDit=parent.parent.IFrmtab1.formDispFrame.document.frm2.isMCEditedDemo.value;
		}if(parent.parent.IFrmtab2 !=undefined && parent.parent.IFrmtab2.formDispFrame.document.frm2 != "undefined"){
			PsychoMCEdit=parent.parent.IFrmtab2.formDispFrame.document.frm2.isMCEditedPsycho.value;
		}if(parent.parent.IFrmtab3 !=undefined && parent.parent.IFrmtab3.formDispFrame.document.frm2 != "undefined"){
			relBankMCEdit=parent.parent.IFrmtab3.formDispFrame.document.frm2.isMCEditedBank.value;
		}if(parent.parent.IFrmtab4 !=undefined && parent.parent.IFrmtab4.formDispFrame.document.frm2 != "undefined"){
			tradeMCEDit=parent.parent.IFrmtab4.formDispFrame.document.frm2.isMCEditedTF.value;
		}
		if(demoMCEDit=="Y" || PsychoMCEdit=="Y" || relBankMCEdit=="Y" || tradeMCEDit=="Y" ){
			document.frm2.isMCEditedGeneral.value="Y";
		}
		var dob = document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
		hasOtherErrors1 = "";
		var fieldDob = document.getElementsByName("3_AccountBO.Cust_DOB")[0];
		for(var i=0;i<ad_start_date.length;i++){
		/* Changes for Call id : 339882  Starts */
//changes for callid 676473 starts
		if(!(isDummy='Y' && i==0))
		{
			hasOtherErrors1 = Validate_againstDob(selTabId,ad_start_date[i],getLabel(fieldDob.Display),dob,MSGJ51468);
			}
//changes for callid 676473 ends
		/* Changes for Call id : 339882 Ends here */
			if(hasOtherErrors1 == "true"){
				hasOtherErrors = "true";
				break;
			}
		}
		for(var i=0;i<ad_end_date.length;i++){
			hasOtherErrors1 = Validate_againstDob(selTabId,ad_end_date[i],getLabel(fieldDob.Display),dob,MSG_END_DATE);
			if(hasOtherErrors1 == "true"){
				hasOtherErrors = "true";
				break;
			}
		}
			hasOtherErrors1 = Validate_againstDob(selTabId,document.getElementsByName("3_AccountBO.RelationshipOpeningDate")[0],getLabel(fieldDob.Display),dob);
			if(hasOtherErrors1 == "true") {
				hasOtherErrors = "true";
			}
		// TrackerID 96800 changes begin
			hasOtherErrors1 = Validate_againstDob(selTabId,document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0],getLabel(fieldDob.Display),dob);
			if(hasOtherErrors1 == "true") {
				hasOtherErrors = "true";
			}
		// TrackerID 96800 changes End
    		//TrackerID 97553 changes begin
  		// Tracker ID : 68932 Begin of Changes
			if(document.getElementsByName("3_AccountBO.RelationshipOpeningDate")[0].value != "") {
			/*Fix for Tracker #: SIDDHARTH Starts*/
			if (Validate_againstCurrDate_loc(document.getElementsByName("3_AccountBO.RelationshipOpeningDate")[0],locDate) == "false"){
					parent.parent.parent.parent.messageFrm.addMessage(selTabId,
					getUserMessage("MSG_INVALIDNREDATE","MSG_RELATIONSHIP"),'AccountBO.RelationshipOpeningDate','HYPER_LINK');
					hasOtherErrors = "true";
				}
			}
			/*Fix for Tracker #: SIDDHARTH Ends*/
		// Tracker ID : 68932 End of Changes
		//TrackerID 97553 changes End
			if(hasOtherErrors=="true"){
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				return "interactive";
			}
			var notExistType = new Array();
			if(boName=='AccountBO'){
			for(var k = 0; k < delAddrtypes.length; k++){
				for (i=0; i < document.all.RecordSet.rows.length ; i++){
					var existType = document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.addressCategory");
					 if(delAddrtypes[k] == existType){
					 	delAddrtypes[k] = 'XXX';
					 	break;
					 }
				}
			}
            }
			else if(boName=='AccountModBO'){
			for(var k = 0; k < delAddrtypes.length; k++){
				for (i=0; i < document.all.RecordSet.rows.length ; i++){
					var existType = document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.addressCategory");
					 if(delAddrtypes[k] == existType){
					 	delAddrtypes[k] = 'XXX';
					 	break;
					 }
				}
			}
			}
			for(var k = 0; k < delAddrtypes.length; k++){
				 if(delAddrtypes[k] != 'XXX'){
					showUserMessage('MSGJ50218',delAddrtypes[k]);
					return "interactive";
		 		  }
			}//if
			//validation for KRA
		var reg_kra= /^[A-Z]{1}*[0-9]{9}[A-Z]{1}*$/;
		var swift_code = '';
		var is_swift_bank='';
			//tracker-83236
			try{
		
			swift_code = document.getElementsByName('AccountBO.Cust_Swift_Code_Desc')[0].value;
			//added Mani for KRA validate
			if(swift_code!=""){
			if(swift_code.match(reg_kra) && swift_code.length == 11)
			{
				//alert("Correct details for KRA");
			}
			else{
			    document.getElementsByName('AccountBO.Cust_Swift_Code_Desc')[0].value ="";
				alert("Enter valid KRA PIN");
				return "interactive";
			}
			}
			is_swift_bank= document.getElementsByName(boName+".Is_Swift_Code_Of_Bank")[0].value ;
			/*Tracker ID: 85009 Begin Of Changes */
			swiftCode = document.getElementsByName('AccountBO.Cust_Swift_Code_Desc')[0];
			swiftFlag = document.getElementsByName(boName+".Is_Swift_Code_Of_Bank")[0];
			if((swift_code.length == 0 && is_swift_bank =='Y'))
			{
				selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
				/* Tracker ID 127120 Changes Begins */
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50605",""), swiftCode.name, 'NO_HYPER_LINK');
				/* Tracker ID 127120 Changes Ends */
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				return "interactive";
			}
			if(swift_code.length != 0 && is_swift_bank.length ==0)
			{
				document.getElementsByName(boName+".Is_Swift_Code_of_Bank")[0].value = "N";

			}

			/*Tracker ID: 85009 End Of Changes */
/* Fix for issue 329227 : Check for special chars in Swift Code field */
					/* Check for special characters provided.*/

					var sw_flag = validate_alphanumeric(document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0]);


					if(sw_flag==false){


						var tempList = new Array();
			    			/* Changed the label code as it is already used in sales module*/
			    			tempList[0] = MSGX50035;

			    			showUserMessage(MSG150,tempList);
						return "interactive";
					}
/* End of changes : 329227 */
			}
			catch(e) {}
			//tracker-83236
		if(!(document.frm2.hid_bodateCreated.value=='')){
			var introFlag=checkForIntroducer(document.frm2.hid_bodateCreated.value);
			if(introFlag){
				var tempMsg = getUserErrorMessage('MSGINTRO');
				if ( !(showConfirmMessage(tempMsg)))
				{
					return "interactive";
				}
			}
		}
		if(defAddress == "M")
			defAddress = "Mailing";
		else if(defAddress == "H")
			defAddress = "Home";
		else if(defAddress == "W")
			defAddress = "Work";
			try{
				try{
					if(parent.parent.IFrmtab4.formDispFrame.document.frm2 != "undefined"){
						document.frm2.isTFFlag.value='Y';
					}
				}catch(e){
           			}
            try{
		if(parent.parent.IFrmtab3.formDispFrame.document.frm2!= "undefined"){
			document.frm2.noOfCreditCard.value=parent.parent.IFrmtab3.formDispFrame.document.all.CreditCardRecordSet.rows.length;
	       }
	      }catch(e){
           }
		if(blFlag== true)
		{
		   try{
			/*DEF- 533 Start of changes*/
			if(parent.parent.IFrmtab0.formDispFrame.document.frm2!= "undefined"){
			var  noOfCurrency = parent.parent.IFrmtab0.formDispFrame.document.all.CurrencyDetRecordSet.rows.length;
			/*DEF- 533 End of changes*/			if(noOfCurrency==2){
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSGJ50726",""),TBODY_RecordSet.rows ,'NO_HLINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
//changes for recon tracker 403626
			showTabFortabDemoForm('tpageCont6');
			document.all.ADD_CURRENCYDET.focus();
			return "interactive"
				}
			}
		  }
			  catch(e){ }
           }
//changes for ticket 635409 start
           else
           {
           var curr1 = document.all.hCustomerCurrency.value;
           if(curr1 != ''){
           var  curr = document.all.hWithholdTaxPcnt.value;
           if (curr == null || curr =='')
           {
parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG162",""),TBODY_RecordSet.rows ,'NO_HLINK');
parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
           }
           }
           }
//changes for ticket 635409
            // CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES **
            try{
           try{
               	FormatBeforeSave_Number("3_AccountBO.Offline_cum_debit_limit");
            if(parent.parent.IFrmtab2.formDispFrame.document.frm2 != "undefined"){
		var disc1=parent.parent.IFrmtab2.formDispFrame.document.getElementsByName('3_PsychographicBO.prefRelshipDiscount1')[0];
		disc1.value = CIFFormatBeforeSave_Number(disc1.value);
		var disc2=parent.parent.IFrmtab2.formDispFrame.document.getElementsByName('3_PsychographicBO.prefRelshipDiscount2')[0];
		disc2.value = CIFFormatBeforeSave_Number(disc2.value);
		var perc1=parent.parent.IFrmtab2.formDispFrame.document.getElementsByName('3_PsychographicBO.prefRelshipDiscountPercent1')[0];
		perc1.value = CIFremovePercentFormat(perc1.value);
		var perc2=parent.parent.IFrmtab2.formDispFrame.document.getElementsByName('3_PsychographicBO.prefRelshipDiscountPercent2')[0];
		perc2.value = CIFremovePercentFormat(perc2.value);
		}
	 	if(parent.parent.IFrmtab4.formDispFrame.document.frm2 != "undefined")
		{
		var mp=parent.parent.IFrmtab4.formDispFrame.document.getElementsByName('3_TradeFinanceBO.dc_MarginPercentage')[0];
		mp.value = CIFremovePercentFormat(mp.value);
		var disc3=parent.parent.IFrmtab4.formDispFrame.document.getElementsByName('3_TradeFinanceBO.cntrct_Limit')[0];
		disc3.value = CIFFormatBeforeSave_Number(disc3.value);
		}
		}
		catch(e)
		{}
	if(parent.parent.IFrmtab1.formDispFrame.document.frm2 != "undefined"){
            var amt1=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.Annual_Salary_Income")[0];
            amt1.value = CIFFormatBeforeSave(amt1.value);
            var amt2=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.Annual_Rental_Income")[0];
            amt2.value = CIFFormatBeforeSave(amt2.value);
            var amt3=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.Annual_Stock_Bond_Income")[0];
            amt3.value = CIFFormatBeforeSave(amt3.value);
    /* Tracker id 113276 changes start */
 var amt4=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("_DemographicBO.Annual_Others_Income")[0];
    /* Tracker id 113276 changes end */
            amt4.value = CIFFormatBeforeSave(amt4.value);
            var amt5=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.Annual_Operating_Exp")[0];
            amt5.value = CIFFormatBeforeSave(amt5.value);
            var amt6=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.Annual_Loan_Instal")[0];
            amt6.value = CIFFormatBeforeSave(amt6.value);
            var amt7=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.Annual_IntProd_Exp")[0];
            amt7.value = CIFFormatBeforeSave(amt7.value);
            var amt8=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.Annual_ExtProd_Exp")[0];
            amt8.value = CIFFormatBeforeSave(amt8.value);
            var amt9=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.Annual_Commit_Exp")[0];
            amt9.value = CIFFormatBeforeSave(amt9.value);
            var amt10=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.Annual_Other_Exp")[0];
            amt10.value = CIFFormatBeforeSave(amt10.value);
            var amt11=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.SalAllowances")[0];
            amt11.value = CIFFormatBeforeSave(amt11.value);
            var amt12=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.SalProrataMonthlyIncentive")[0];
            amt12.value = CIFFormatBeforeSave(amt12.value);
            var amt13=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.SalInterestSubsidy")[0];
            amt13.value = CIFFormatBeforeSave(amt13.value);
            var amt14=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.SalOtherIncome2")[0];
            amt14.value = CIFFormatBeforeSave(amt14.value);
            var amt15=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.SalOtherIncome3")[0];
            amt15.value = CIFFormatBeforeSave(amt15.value);
            var amt16=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.TotalEstAccountValue")[0];
            amt16.value = CIFFormatBeforeSave(amt16.value);
            var amt17=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.TotalEstAccountValue_SelfEmployed")[0];
            amt17.value = CIFFormatBeforeSave(amt17.value);
            var amt18=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.SelfempGrossReciptCurrentYR")[0];
            amt18.value = CIFFormatBeforeSave(amt18.value);
            var amt19=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.SelfempGrossReceiptPriorYear")[0];
            amt19.value = CIFFormatBeforeSave(amt19.value);
            var amt20=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.SelfempNetProfitCurrentYR")[0];
            amt20.value = CIFFormatBeforeSave(amt20.value);
            var amt21=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.SelfempNetProfitPriorYR")[0];
            amt21.value = CIFFormatBeforeSave(amt21.value);
            var amt22=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.TotalMonthlyDebtServiceAmt")[0];
            amt22.value = CIFFormatBeforeSave(amt22.value);
            var amt23=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.SelfempDepreciationCurrentYear")[0];
            amt23.value = CIFFormatBeforeSave(amt23.value);
            var amt24=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.SelfempDepreciationPriorYear")[0];
            amt24.value = CIFFormatBeforeSave(amt24.value);
            var amt25=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.SelfempAverageAnnualTurnover")[0];
            amt25.value = CIFFormatBeforeSave(amt25.value);
            var amt26=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.TotalInvestmentInSharesandUnits")[0];
            amt26.value = CIFFormatBeforeSave(amt26.value);
            var amt27=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.Annual_Total_Exp")[0];
            amt27.value = CIFFormatBeforeSave(amt27.value);
            var amt28=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.Annual_Total_Income")[0];
            amt28.value = CIFFormatBeforeSave(amt28.value);
            var amt29=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.TotalHouseholdIncm")[0];
            amt29.value = CIFFormatBeforeSave(amt29.value);
            var amt30=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.TotalFundBase")[0];
	    amt30.value = CIFFormatBeforeSave(amt30.value);
	    var amt31=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.TotalNonFundBase")[0];
	    amt31.value = CIFFormatBeforeSave(amt31.value);
	    var amt32=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("3_DemographicBO.OtherLimits")[0];
            amt32.value = CIFFormatBeforeSave(amt32.value);
            }
            }catch(e){
            }
            try{
                customSave();
            }catch(e){}
            // CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES  **
	    	    if(blFlag == true) {
	    	    	noValidationMsg = false;
	    	    }
	    	    else {
	       	    	noValidationMsg = true;
	    	    }
				if(document.getElementsByName("AccountBO.ACCOUNTKEY")[0].value == "")
				{
					if(document.all.isAutoGenKey.value == 'true') {
					document.getElementsByName("AccountBO.ACCOUNTKEY")[0].IsMandatory = 'N';
					}
           		 }
	    	    var chkStat = "true";
	    	    if (chkStat != "true") {
	                  return 'interactive';
	    	    }
		if(blFlag == false)
		{
	    	    var validate=false;
	    	    if(document.getElementsByName("AccountBO.Cust_Last_Name")[0].value == ""){
	    	     parent.parent.parent.parent.messageFrm.addMessage(selTabId,
	    	     getUserMessage("MSG086","'Last Name'"),'AccountBO.Cust_Last_Name','HYPER_LINK');
	    	     parent.parent.parent.parent.messageFrm.showMessages(selTabId);// CRM70t-ST :TRACKER# 79438 - CHANGES
	    	    validate = "true";
	    	     }
	    	     if(document.getElementsByName("AccountBO.AccountKey")[0].value == "")
				 {
					 if(document.all.isAutoGenKey.value == 'true')
					 {
						  document.getElementsByName("AccountBO.ACCOUNTKEY")[0].IsMandatory = 'N';
					  }
					 else
					 {
						 parent.parent.parent.parent.messageFrm.addMessage(selTabId,
						 //changes for ticket id-701600 starts 
						getUserMessage("MSG086","'Customer ID'"),'AccountBO.AccountKey','HYPER_LINK');
						//changes for ticket id-701600 ends
						parent.parent.parent.parent.messageFrm.showMessages(selTabId);// CRM70t-ST :TRACKER# 79438 - CHANGES
						validate = "true";
					 }
	    	     }
	    	    if(validate == "true"){
	    	    	return 'interactive';
	    	    }
	     }
            var hasOtherErrors = false;
            // CRM62-ST:TRACKER# 49765 **BEGIN OF CHANGES **
            try {
				selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
			} catch(e) {
			}
            // CRM62-ST:TRACKER# 49765 **END OF CHANGES **
            Screen = 0;
	var condBirthDateChk = true;
            if(condBirthDateChk == false) {
                   if(blFlag==true)
			{
                   hasOtherErrors = "true";
        	    }
	 	else{
	 	//Changes for Ticket-->163101:Start
	 		var CustomerMinor=document.getElementsByName(boName+".CustomerMinor")[0];
				if (document.getElementsByName("3_AccountBO.Cust_DOB")[0].value == '')
	 			{
	 				if(CustomerMinor.value != '')
					{
	 				return "interactive";
	 				}
	 			}
	 			else
	 			{
	 			return "interactive";
	 			}
	       //Changes for Ticket-->163101:End
          	}
         }
            else {
		var dob =document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
		var dtFormDOB = gettingDateFormats();
		if(dtFormDOB == 'MM/dd/yyyy' || dtFormDOB == 'MM-dd-yyyy'){
			var  dobDay=dob.substring(3,5);
			var  strMonth=dob.substring(0,2);
			var  dobYear=dob.substring(6,10);
		}
		else{
			var  dobDay=dob.substring(0,2);
			var  strMonth=dob.substring(3,5);
			var  dobYear=dob.substring(6,10);
		}
		if((dobDay!='')&&(strMonth!='')&&(dobYear!=''))
		{
            var isMinor = IsMinor(dobDay,strMonth,dobYear);
            	}
            /* sanity fix on 22 jan build ends*/
	    //Added by Suman for Minor
	      if(document.frm2.byPassFlag.value!="Y"){
	      if(document.getElementsByName("3_ContactBO.DOB")[0].value != '')
	                     {
	                         var primaryCustomerDOB = document.getElementsByName("3_ContactBO.DOB")[0].value;
	                       //Call id 355750 change start
	                       /*var dobMinor = new Date(primaryCustomerDOB.substring(6,10),
					primaryCustomerDOB.substring(3,5),
					primaryCustomerDOB.substring(0,2));
	                         var yearDob = dobMinor.getFullYear();
	                         var monthDob = dobMinor.getMonth();
	                         var dateDob = dobMinor.getDate();
	                         */
				var yearDob = getYearFromDate(primaryCustomerDOB);
				var dateDob = getDayFromDate(primaryCustomerDOB);
				var monthDob = getMonthFromDate(primaryCustomerDOB);
	                         
	                         
	                         //Call id 355750 change end
	                         var isMinorContact = IsMinor(dateDob,monthDob,yearDob);
				 if(blFlag==true)
				 {
	                         if(isMinorContact=='true')
	                         {
	                            parent.parent.parent.parent.messageFrm.addMessage(selTabId,
				    							MSG_MINOR,'ContactBO.DOB','HYPER_LINK');
						hasOtherErrors = "true";
	                         }
	                         }//save and submit end
                	}
	}
	  //End of changes by Suman for Minor

	// TRACKER ID: 50914 Added Condition for Setting Is Customer Minor to 'Y' or 'N'
          var CustomerMinor=document.getElementsByName(boName+".CustomerMinor")[0];
	if(document.frm2.byPassFlag.value=="Y"){
	    	isMinor="false";
    }
         if(isMinor=='true')
		 {
			 /*tracker id 161937 changes starts*/
			if((document.frm2.minorLoaded.value=="false")&&(editMode==false)&&!(document.frm2.byPassFlag.value=="Y")&&!(document.frm2.flagRelType.value=="true")){
			/*tracker id 161937 changes ends*/
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,MSG_MINOR_SEL,boName+'.CustomerMinor', 'HYPER_LINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive";
			hasOtherErrors = "true";
			}
		 }else
			{
			 if (document.getElementsByName(boName+".CustomerMinor")[0].value=="Y")
			 {
			 parent.parent.parent.parent.messageFrm.addMessage(selTabId,MSG_MINOR_SEL,boName+'.CustomerMinor', 'HYPER_LINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive";
			hasOtherErrors = "true";
			 }
			 else if(CustomerMinor.value != '')
			 {
				CustomerMinor.value="N";
			 }
		 }
          }
		var setMandatory = "false";
        try{
	     if(blFlag==true){
            Screen = 0;
            if(document.getElementsByName("AccountBO.ACCOUNTKEY")[0].value == "") {
                if(document.all.isAutoGenKey.value == 'true') {
                document.getElementsByName("AccountBO.ACCOUNTKEY")[0].IsMandatory = 'N';
                }
            }
			retStatNRE = checkPassport();
            if (retStatNRE == "false"){
            	return "interactive";
            }
            retStat1 = FieldsForValidationCust();
            retStat = parent.parent.parent.parent.ValidateFormContents(document.frm2,true);
			if(document.getElementsByName(boName+".CustomerNREFlg")[0].value == "Y") {
				setMandatory = "true";
				try {
					if(document.getElementsByName("AccountBO.DateOfBecomingNRE")[0].value == "") {
						parent.parent.IFrmtab0.formDispFrame.showTabFortabDemoForm('tpageCont');
						parent.parent.parent.parent.messageFrm.addMessage(selTabId,
							getUserMessage("MSG086","MSG_NRE"),'AccountBO.DateOfBecomingNRE','HYPER_LINK');
						hasOtherErrors = "true";
					}
					else {
						/*Fix for Tracker #: SIDDHARTH Starts*/
						if (Validate_againstCurrDate_loc(document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0],locDate) == "false")
						/*Fix for Tracker #: SIDDHARTH Ends*/
						{
							parent.parent.parent.parent.messageFrm.addMessage(selTabId,
							getUserMessage("MSG_INVALIDNREDATE","MSG_NRE"),'AccountBO.DateOfBecomingNRE','HYPER_LINK');
							hasOtherErrors = "true";
						}
					}
				}catch(e) {
				}
            }
			else
			{
				try
				{
				//Changes for ticket id 220098 Start
					if(document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0].value != "") {
				//Changes for ticket id 220098 End
						parent.parent.parent.parent.messageFrm.addMessage(selTabId,
						getUserMessage("MSG_NREDATE","MSG_NRE"),'AccountBO.DateOfBecomingNRE','HYPER_LINK');
						hasOtherErrors = "true";
					}
				}
				catch (e) {
				}
			}
            if(retStat == "false"|| hasOtherErrors == "true" || retStat1 == "false") {
				// CRM62-ST:TRACKER# 49765 **BEGIN OF CHANGES **
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				// CRM62-ST:TRACKER# 49765 **END OF CHANGES **
                        return "interactive";
            }
            }
        }catch(e)
        {
        }
     //   ERPBOCF1 - Tracker Id 113276 Bug fixing - Begin
	 //   Defect Ticket Id 200830
          if(parent.parent.IFrmtab0 != null){
          try{
                if(parent.parent.IFrmtab0.formDispFrame.document.frm2 != "undefined"){
		    chkMinID = parent.parent.IFrmtab0.formDispFrame.EDocRecordSet.rows.length - 2;
		    if(blFlag == true)
			{
				if(chkMinID < 1)
				{
					parent.parent.parent.parent.tabViewFrm.selectTabForID(0);
					parent.parent.parent.parent.messageFrm.removeMessages(selTabId);
					parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CORP_IDENT",""),parent.parent.IFrmtab0.formDispFrame.TBODY_EDocRecordSet.rows ,'NO_HLINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					// Tracker#: 125742 Changes BEGIN
					showTabFortabDemoForm('tpageCont5');
					document.all.AddIdentificationDetails.focus();
					// Tracker#: 125742 Changes END
					return "interactive";
				}
				var noOfEdoc = parent.parent.IFrmtab0.formDispFrame.EDocRecordSet.rows.length - 2;
				if(noOfEdoc > 0){
					if(uniqueID == null || uniqueID == 'undefined' || uniqueID == '' )
					{
						showMessage(MSGJ50573);
						return "false";
					}
					if(placeofissue== '')
					{
					alert("please enter place of issue in identification");
					return "false";
					}
				}
							}
		                      retStat="true";
		                      if(retStat == "false" || retstat1 == "false") {
		                      	   Screen = 1;
		                           return "interactive";
	                      		}
	                      	  }
	                      } catch(e){ }
	                      }
                 if(parent.parent.IFrmtab1 != null){
                  try{
  	  		if(parent.parent.IFrmtab1.formDispFrame.document.frm2 != "undefined"){
      		    hasOtherErrors = parent.parent.IFrmtab1.formDispFrame.ValidateDateFields(getUserErrorMessage("MSG_DOB",dob),dob);
		   		    if(hasOtherErrors == "true") {
      		    	Screen = 1;
      				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
      				return "interactive";
      		    }
      		}
        // ERPBOCF1 - Tracker Id 113276 Bug fixing - Begin
	// Defect Ticket Id 200830
        // The code for checking whether identification docs are present when we are submitting customer
	// is moved before the if - "if(parent.parent.IFrmtab1 != null){" which checks whether demographic tab is present or not
	// since Identification docs are moved from Demographic to general screen

//Changes for call id: 389624 and recon for TOL 388300
       			//Making Identification Detail not Mandatory When Saving:Start
       			var demoretstat = "true";
       			if(blFlag == true)
       			{
                  demoretstat = parent.parent.IFrmtab1.formDispFrame.FieldsForValidation(setMandatory);
						 	}
//Changes for call id: 389624 and recon for TOL 388300
			 	//Making Identification Detail not Mandatory When Saving:End
			            	//if(parent.parent.IFrmtab1.formDispFrame.document.frm2 != "undefined"){
//IDENTIFICATION DOCUMENT CHANGES start
								/*chkMinID = parent.parent.IFrmtab1.formDispFrame.EDocRecordSet.rows.length - 2;
					if(blFlag == true)
					{
						if(chkMinID < 1)
						{
							parent.parent.parent.parent.tabViewFrm.selectTabForID(1);
							parent.parent.parent.parent.messageFrm.removeMessages(selTabId);
							parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CORP_IDENT",""),parent.parent.IFrmtab1.formDispFrame.TBODY_EDocRecordSet.rows ,'NO_HLINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							parent.parent.IFrmtab1.formDispFrame.showTabFortabDemoForm('tpageODet');
							//Tracker 96667 changes BEGIN
							//parent.parent.IFrmtab1.formDispFrame.showTabFortabIDDocForm('tpageIDDoc');
							//Tracker 96667 changes END
							parent.parent.IFrmtab1.formDispFrame.document.all.AddIdentificationDetails.focus();

							return "interactive";
						}
			 			var noOfEdoc = parent.parent.IFrmtab1.formDispFrame.EDocRecordSet.rows.length - 2;
						var uniqueID = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName('objHidUniqueID')[0].value
			 			if(noOfEdoc > 0){
							if(uniqueID == null || uniqueID == 'undefined' || uniqueID == '' )
							{
								showMessage(MSGJ50573);
								return "false";
							}
						}
								}*/
//IDENTIFICATION DOCUMENT CHANGES end
                      //retStat = parent.parent.parent.parent.ValidateFormContents(parent.parent.IFrmtab1.formDispFrame.document.frm2,true,noValidationMsg);
//Changes for call id: 389624 and recon for TOL 388300
			                      retStat="true";
                      if(retStat == "false" || demoretstat == "false") {
                                  Screen = 1;
                                  
                            return "interactive";
			                      }
//Changes for call id: 389624 and recon for TOL 388300
                      /* CRM6206RECON:TRACKER# 59146 **BEGIN   CHANGES*/

			                      	//document.getElementsByName("isDemoLoaded")[0].value = "true";

                      /* CRM6206RECON:TRACKER# 59146 **END   CHANGES*/

			                  //}
			                  // ERPBOCF1 - Bug fixing - End

                  }catch(e){
                  }
              /* CRM62MNT:TRACKER# 53901 **BEGIN   CHANGES** */
      		/* CRM62MNT:TRACKER# 55633 **BEGIN   CHANGES** */
      		if(parent.parent.IFrmtab1.formDispFrame.document.frm2 != "undefined"){
      		try{
      		    retStat = parent.parent.IFrmtab1.formDispFrame.ValAmtFieldsForExchRate(selTabId);
      		    }catch(e){
      		    }
      		    if(retStat == "false") {
      				Screen = 1;
      				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
      				return "interactive";
      		    }
      		}
      	}
      		/* CRM62MNT:TRACKER# 55633 **END   CHANGES** */
        /* CRM62MNT:TRACKER# 53901 **BEGIN   CHANGES** */
	       try{
	      if(parent.parent.IFrmtab2.formDispFrame.document.frm2  != "undefined"){
				hasOtherErrors = parent.parent.IFrmtab2.formDispFrame.ValidateDateFields(getUserErrorMessage("MSG_DOB",dob),dob);
      		    if(hasOtherErrors == "true") {
      				Screen = 2;
      				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
      				return "interactive";
      		    }
			   retStat = "true"
			   var validateDiscount = ValidateDiscount();
			   retstat1 = parent.parent.IFrmtab2.formDispFrame.FieldsForValidation();
			   var isCopyTemp = document.frm2.IsCopy.value;
			   var retstat2="true";
			   if(isCopyTemp=='Y'){
			   }
			   if(retStat == "false" || validateDiscount == "false" || retstat1 == "false" ||
			   retStat == false || validateDiscount == false || retstat1 == false||retstat2=="false") {
				   Screen = 2;
			       return "interactive";
			   }
			   /* CRM6206RECON:TRACKER# 59146 **BEGIN   CHANGES*/
				document.getElementsByName("isPsychoLoaded")[0].value = "true";
			   /* CRM6206RECON:TRACKER# 59146 **END   CHANGES*/
	       }
	       }catch(e){
	       }
	      try{
	      	if(parent.parent.IFrmtab3.formDispFrame.document.frm2  != "undefined"){
      		    hasOtherErrors = parent.parent.IFrmtab3.formDispFrame.ValidateDateFields(getUserErrorMessage("MSG_DOB",dob),dob);
      		    if(hasOtherErrors == "true") {
      				Screen = 3;
      				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
      				return "interactive";
      		    }
//changes for recon tracker 403626
      		    document.getElementsByName("isRelLoaded")[0].value = "true";
			  }
	       }catch(e){
	       }
		    var chk =  document.getElementsByName(boName+".TFPartyFlag")[0].value;
	     if( chk == 'Y'){

		try{
			if(parent.parent.IFrmtab4.formDispFrame.document.frm2  != "undefined")
			{
      		    hasOtherErrors = parent.parent.IFrmtab4.formDispFrame.ValidateDateFields(getUserErrorMessage("MSG_DOB",dob),dob);
      		    if(hasOtherErrors == "true") {
      				Screen = 4;
      				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
      				return "interactive";
      		    }
			   retStat = "true";
			   if(retStat == "false" || retStat == false)
			   {
				Screen = 4;
				return "interactive";
			   }
			   document.getElementsByName("isTFLoaded")[0].value = "true";
			}
		}catch(e){
		}
             }
   /****************************************************/
//cif address changes --> start
/****************************************************/

            var mailingad;// = false;
			var otherAdd;
            noOfEdu = edu_URL.length;
			//CIF PhoneEmail Changes : Start
			noOfPhoneEmail = phoneEmail_URL.length;
			//CIF PhoneEmail Changes : End
      	    //NRE Relative Changes -Begin
            var NRERel;// = false;
            //NRE Relative Changes -End
            //CIF Changes for NRE - Begin
	       var isNRE;// = true;
	       if(document.getElementsByName(boName+".CustomerNREFlg")[0].value == "Y" ){
		isNRE = true;
	       }
	       else{
		isNRE = false;
	       }
            chkadres = document.all.RecordSet.rows.length;
            if(blFlag == true)
            {
            if(chkadres == 2 && isNRE == true){
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CONTACT_DEFID",""),TBODY_RecordSet.rows ,'NO_HLINK');
		//changes for 258713 starts
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_NREREL",""),TBODY_RecordSet.rows ,'NO_HLINK');
		//changes for 258713 ends
		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
//changes for recon tracker 403626
		showTabFortabDemoForm('tpageCont3');
		showTabFortabContactDetails('tpageAddr');
		return "interactive"
            }
	    }
        if(noOfEdu > 0) {
			for(var x = 0; x < noOfEdu ; x++) {
				if((ad_address_type[x]) != "Mailing") {
					mailingad = false;
				}
				else {
					mailingad = true;
					break;
				}
			}
		}
		else
			mailingad = false;
		if(defAddress != "Mailing" && defAddress!= "" && noOfEdu > 0) {
			for(var x = 0; x < noOfEdu ; x++) {
				if((ad_address_type[x]) != defAddress)
					otherAdd = false;
				else {
					otherAdd = true;
					break;
				}
			}
		}
		if(isNRE ==true){
			if(noOfEdu > 0) {
				for(var x = 0; x < noOfEdu ; x++) {
					if((ad_address_type[x]) != "NRERelative") {
						NRERel = false;
					}
					else {
						NRERel = true;
						break;
					}
				}
			}
			else
				NRERel = false;
		}
	    else{
	for(var x = 0; x < noOfEdu ; x++) {
		if(blFlag==true)
		{
	 if((ad_address_type[x]) == "NRERelative") {
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_NREREL1",""),TBODY_RecordSet.rows ,'NO_HLINK');
		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		return "interactive"
	   	 }
		}
	   	}
	   	}
		if(blFlag==true)
		{
	    if(mailingad == false){
		//changes for callId 686015 starts
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSGJ51806",defAddress_Value),TBODY_RecordSet.rows ,'NO_HLINK');
			//changes for callId 686015 ends
			 parent.parent.parent.parent.messageFrm.showMessages(selTabId);
//changes for recon tracker 403626
			 showTabFortabDemoForm('tpageCont3');
			 showTabFortabContactDetails('tpageAddr');
			 return "interactive"
		}
		//changes for 258713 starts
		if(NRERel == false && isNRE == true){
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_NREREL",""),TBODY_RecordSet.rows ,'NO_HLINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
//changes for recon tracker 403626
			showTabFortabDemoForm('tpageCont3');
			showTabFortabContactDetails('tpageAddr');
			return "interactive"
		}
		//changes for 258713 ends
		if(otherAdd == false && defAddress != "Mailing") {
			if(defAddress == "Home")
			{
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG_HOME_ADD",""),TBODY_RecordSet.rows ,'NO_HLINK');
			}/* ***** Ticket# 337931  : Start ******/
			else if(defAddress == "Work")
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG_WORK_ADD",""),TBODY_RecordSet.rows ,'NO_HLINK');
			else
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ51806","defAddress"),TBODY_RecordSet.rows ,'NO_HLINK');
			/* ***** Ticket# 337931  : end ******/
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
		}
		}
	   /* ***** Tracker# 97236 SMS Banking Mobile Number changes : Start ***** */
       var SMSBankingMobileNumber = document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0];
       var SMSBankingNo = SMSBankingMobileNumber.value;
       SMSBankingNo = trim(SMSBankingNo);
  	   /* ***** Tracker# 97236 SMS Banking Mobile Number changes : End ***** */
		try{
		var startdate  = new Array();
		var index      = new Array();
		/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		var mobileNo   = new Array();
		/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Mailing") && !(edu_Status[k] == "Remove")) {
		startdate[z] = ad_start_date[k];
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		mobileNo[z] = ad_cellno_local[k];
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		index[z] = k;
		z++;
		}
		}
		noOfaddress = startdate.length;
		if( noOfaddress >1){
		for ( var i = (noOfaddress - 1); i >= 0; i-- )
		{
		for (var j = 1; j <= i; j++)
		{
		var millistartdate1 = changetoMillis(startdate[j-1]);
		var millistartdate2 = changetoMillis(startdate[j]);
		if (millistartdate1 > millistartdate2)
		{
		var temp = startdate[j-1];
		startdate[j-1] = startdate[j];
		startdate[j] = temp;
		var temp1 = index[j-1];
		index[j-1] = index[j];
		index[j] = temp1;
		}
		}
		}
		}
		for(var k = 0; k < noOfaddress ; k++) {
		findex = index[k];
		if(!(startdate[k+1]) == ''){
		ad_end_date[findex] = address_enddate(startdate[k+1]);
		}
		else{
        // Fix for Multi addresses issue
		//Call id 346606 and 348767 change start
		//ad_end_date[findex] = "31/12/2099";
		ad_end_date[findex] =getEndDate1();
		//Call id 346606 and 348767 change end
//changes for ticket 635409 start
		var cc = document.frm2.streetno.value;
		if(cc == '' || cc == null)
		{
		ad_end_date[findex] = "";
		}
		//ad_end_date[findex] = "";
//changes for ticket 635409
		}
		}
		}
		catch(e)
		{}
		noOfmailingaddress = startdate.length;
		var currentCount = 0;
		var todaydate = new String();
		/*Fix for Tracker #: SIDDHARTH Starts*/
		todaydate.value = getTodayDate1(locDate);
		/*Fix for Tracker #: SIDDHARTH Ends*/
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		var currMailIndex = 0;
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		for(var k = 0; k < noOfmailingaddress ; k++)
		{
			var millistartdate1 = changetoMillis(startdate[k]);
			var millistartdate2 = changetoMillis(todaydate.value);
			if (millistartdate1 <= millistartdate2)
			{
			currentCount=currentCount+1;
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
			if(defAddress=="Mailing")
			{
				currDefAddrMobile = mobileNo[k];
			}
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
			}
		}
		if(blFlag==true)
		{
		if (currentCount == 0)
		{
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG_MAIL_CURR_ADD",""),TBODY_RecordSet.rows ,'NO_HLINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
		}
		}
		try{
		var startdate1  = new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		var mobileNo1   = new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		var index1      = new Array();
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Home") && !(edu_Status[k] == "Remove")) {
		startdate1[z] = ad_start_date[k];
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		mobileNo1[z]  = ad_cellno_local[k];
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		index1[z] = k;
		z++;
		}
		}
		noOfaddress = startdate1.length;
		if( noOfaddress >1){
		for ( var i = (noOfaddress - 1); i >= 0; i-- )
		{
		for (var j = 1; j <= i; j++)
		{
		var millistartdate1 = changetoMillis(startdate1[j-1]);
		var millistartdate2 = changetoMillis(startdate1[j]);
		if (millistartdate1 > millistartdate2)
		{
		var temp = startdate1[j-1];
		startdate1[j-1] = startdate1[j];
		startdate1[j] = temp;
		var temp1 = index1[j-1];
		index1[j-1] = index1[j];
		index1[j] = temp1;
		}
		}
		}
		}
		for(var k = 0; k < noOfaddress ; k++) {
		findex = index1[k];
		if(!(startdate1[k+1]) == ''){
		ad_end_date[findex] = address_enddate(startdate1[k+1]);
		}
		else{
        // Fix for Multi addresses issue
		//Call id 346606 and 348767 change start
		//ad_end_date[findex] = "31/12/2099";
		ad_end_date[findex] =getEndDate1();
		//Call id 346606 and 348767 change end
		//ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		if(defAddress=="Home")
		{
			var noOfHomeAddress = startdate1.length;
			currentCount = 0;
			todaydate = new String();
			todaydate.value = getTodayDate1(locDate);
			currMailIndex = 0;
			for(var k = 0; k < noOfHomeAddress ; k++)
			{
				var millistartdate1 = changetoMillis(startdate1[k]);
				var millistartdate2 = changetoMillis(todaydate.value);
				if (millistartdate1 <= millistartdate2)
				{
					currentCount=currentCount+1;
 					currDefAddrMobile = mobileNo1[k];
 				}
			}
		}
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		try{
		var startdate2  = new Array();
		var index2      = new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		var mobileNo2	= new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Work") && !(edu_Status[k] == "Remove")) {
		startdate2[z] = ad_start_date[k];
		index2[z] = k;
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		mobileNo2[z]=ad_cellno_local[k];
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		z++;
		}
		}
		noOfaddress = startdate2.length;
		if( noOfaddress >1){
		for ( var i = (noOfaddress - 1); i >= 0; i-- )
		{
		for (var j = 1; j <= i; j++)
		{
		var millistartdate1 = changetoMillis(startdate2[j-1]);
		var millistartdate2 = changetoMillis(startdate2[j]);
		if (millistartdate1 > millistartdate2)
		{
		var temp = startdate2[j-1];
		startdate2[j-1] = startdate2[j];
		startdate2[j] = temp;
		var temp1 = index2[j-1];
		index2[j-1] = index2[j];
		index2[j] = temp1;
		}
		}
		}
		}
		for(var k = 0; k < noOfaddress ; k++) {
		findex = index2[k];
		if(!(startdate2[k+1]) == ''){
		ad_end_date[findex] = address_enddate(startdate2[k+1]);
		}
		else{
        // Fix for Multi addresses issue
		//Call id 346606 and 348767 change start
		//ad_end_date[findex] = "31/12/2099";
		ad_end_date[findex] =getEndDate1();
		//Call id 346606 and 348767 change end
		//ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		if(defAddress=="Work")
		{
 			var noOfWorkAddress = startdate2.length;
			var currentCount = 0;
			var todaydate = new String();

			todaydate.value = getTodayDate1(locDate);
			var currMailIndex = 0;
 			for(var k = 0; k < noOfWorkAddress ; k++)
			{
				var millistartdate1 = changetoMillis(startdate2[k]);
				var millistartdate2 = changetoMillis(todaydate.value);
				if (millistartdate1 <= millistartdate2)
				{
				    currentCount=currentCount+1;
 					currDefAddrMobile = mobileNo2[k];
 				}
			}
		}
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		try{
		var startdate3  = new Array();
		var index3      = new Array();
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Future/OnSite") && !(edu_Status[k] == "Remove")) {
		startdate3[z] = ad_start_date[k];
		index3[z] = k;
		z++;
		}
		}
		noOfaddress = startdate3.length;
		if( noOfaddress >1){
		for ( var i = (noOfaddress - 1); i >= 0; i-- )
		{
		for (var j = 1; j <= i; j++)
		{
		var millistartdate1 = changetoMillis(startdate3[j-1]);
		var millistartdate2 = changetoMillis(startdate3[j]);
		if (millistartdate1 > millistartdate2)
		{
		var temp = startdate3[j-1];
		startdate3[j-1] = startdate3[j];
		startdate3[j] = temp;
		var temp1 = index3[j-1];
		index3[j-1] = index3[j];
		index3[j] = temp1;
		}
		}
		}
		}
		for(var k = 0; k < noOfaddress ; k++) {
		findex = index3[k];
		if(!(startdate3[k+1]) == ''){
		ad_end_date[findex] = address_enddate(startdate3[k+1]);
		}
		else{
        // Fix for Multi addresses issue
		//Call id 346606 and 348767 change start
		//ad_end_date[findex] = "31/12/2099";
		ad_end_date[findex] =getEndDate1();
		//Call id 346606 and 348767 change end
		//ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
		   try{
		   var startdate4  = new Array();
		   var index1      = new Array();
		   var z=0;

		   for(var k = 0; k < noOfEdu ; k++) {
		   /*Changes done for Ticket#348257 begin*/
		   if((ad_address_type[k] == "NRERelative") && !(edu_Status[k] == "Remove")) {
		   startdate4[z] = ad_start_date[k];
		   /*Changes done for Ticket#348257 end*/
		   index1[z] = k;
		   z++;
		   }
		   }
		   noOfaddress = startdate4.length;
		   if( noOfaddress >1){
		   for ( var i = (noOfaddress - 1); i >= 0; i-- )
		   {
		   for (var j = 1; j <= i; j++)
		   {
		   var millistartdate1 = changetoMillis(startdate4[j-1]);
		   var millistartdate2 = changetoMillis(startdate4[j]);
		   if (millistartdate1 > millistartdate2)
		   {
		   var temp = startdate4[j-1];
		   startdate4[j-1] = startdate4[j];
		   startdate4[j] = temp;
		   var temp1 = index1[j-1];
		   index1[j-1] = index1[j];
		   index1[j] = temp1;
		   }
		   }
		   }
		   }
		   for(var k = 0; k < noOfaddress ; k++) {
		   findex = index1[k];
		   if(!(startdate4[k+1]) == ''){
		   end_date[findex] = address_enddate(startdate4[k+1]);
		   }
		   else{
        // Fix for Multi addresses issue
		//Call id 346606 and 348767 change start
		//end_date[findex] = "31/12/2099";
		end_date[findex] =getEndDate1();
		//Call id 346606 and 348767 change end
		   //end_date[findex] = "";
		   }
		   }
		   }
		   catch(e)
		   {}
 		// TRACKER 112270  changes-Begin
 		   setEnddateForOtherRetailAddrType(noOfEdu,ad_address_type,address_type,edu_Status);
 		// TRACKER 112270  changes-End
		// date validations-end
		/* CIF PhoneEmail Changes : Start */
		if(document.frm2.byPassFlag.value!="Y"){
		preferredAddress = document.getElementsByName('AccountBO.Address.preferredAddress')[0];
		var preferredAddressFlag = false;
		if(blFlag==true)
		{
			if(preferredAddress.value == "")
			{
				selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50265",""), preferredAddress.name, 'NO_HLINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
//changes for recon tracker 403626
				showTabFortabDemoForm('tpageCont3');
		        	showTabFortabContactDetails('tpageAddr');
		        	preferredAddress.focus();
				return "interactive";
			}
			else
			{
				for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
				{
			if(boName=='AccountBO'){
					recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("AccountBO.Address.addressCategory");
					recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("AccountBO.Address.PreferredFormat");
            }
			else if(boName=='AccountModBO'){
					recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("AccountModBO.Address.addressCategory");
					recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("AccountModBO.Address.PreferredFormat");
            }

					/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
					{
						preferredAddressFlag = true
						selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
						parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50266",""), preferredAddress.name, 'NO_HLINK');
						parent.parent.parent.parent.messageFrm.showMessages(selTabId);
						return "interactive";
					}*/
					if(preferredAddress.value == recordSetAddressCategory)
					{
						preferredAddressFlag = true;
					}
				}
				if(!preferredAddressFlag)
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50267",""), preferredAddress.name, 'NO_HLINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
//changes for recon tracker 403626
					showTabFortabDemoForm('tpageCont3');
		        		showTabFortabContactDetails('tpageAddr');
					return "interactive";
				}
			else {
					   var currentPrefCount = 0;
					   var prefStartDate;
					   if (preferredAddress.value == "Home") {
							   noOfPrefaddress = startdate1.length;
							   prefStartDate =startdate1;
					   }
					   else  if (preferredAddress.value == "Future/OnSite") {
							   noOfPrefaddress = startdate3.length;
							   prefStartDate =startdate3;
					   }
					   else if (preferredAddress.value == "Work") {
							   noOfPrefaddress = startdate2.length;
							   prefStartDate =startdate2;
					   }
					   else if (preferredAddress.value == "NRERelative") {
							   noOfPrefaddress = startdate4.length;
							   prefStartDate =startdate4;
					   }
					   else {
							   currentPrefCount=-1;
					   }
					   if (currentPrefCount != -1 ) {
							   for(var k = 0; k < noOfPrefaddress ; k++)
							   {
									   var millistartdate1 = changetoMillis(prefStartDate[k]);
									   var millistartdate2 = changetoMillis(todaydate.value);
									   if (millistartdate1 <= millistartdate2)
									   {
											   currentPrefCount=currentPrefCount+1;
									   }
							   }
							   if (currentPrefCount == 0)
							   {
										if(blFlag == true)
										{
									   parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50495",""),TBODY_RecordSet.rows ,'NO_HLINK');
									   parent.parent.parent.parent.messageFrm.showMessages(selTabId);
//changes for recon tracker 403626
									   showTabFortabDemoForm('tpageCont3');
		        						   showTabFortabContactDetails('tpageAddr');
									   return "interactive"
									   }
							   }
					   }
			   }
			}
			preferredPhone = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType')[0];
			preferredEmail = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType1')[0];
			//Changes for call id 425426-recon for 423993 starts
			preferredMobileAlert = document.getElementsByName('AccountBO.Preferred_Mobile_Alert_Type')[0];
			var preferredAlertFlag = false;
			//Changes for call id 425426-recon for 423993 ends
			var preferredPhoneFlag = false;
			var preferredEmailFlag = false;
			//Tracker 184709 Starts
				var phoneCheck = phoneEmailCheck();
				if(phoneCheck == "false" || phoneCheck == false) {
					return "interactive";
				}

			//Tracker 184709 Ends

			if((preferredPhone.value != null && preferredPhone.value != 'undefined') || (preferredEmail.value != null && preferredEmail.value != 'undefined') )
			{
				for(var r=0 ; r < document.all.PhoneEmailRecordSet.rows.length ; r++)
				{
			if(boName=='AccountBO'){
					recordSetPhone = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountBO.PhoneEmail.PhoneEmailType");
					if(preferredPhone.value == recordSetPhone && preferredPhone.value != null){
						preferredPhoneFlag = true;
					}
					//Changes for call id 425426-recon for 423993 starts
					if(recordSetPhone!= null && preferredMobileAlert.value != null && recordSetPhone.indexOf(preferredMobileAlert.value)!=-1){
												preferredAlertFlag = true;
						  }
					//Changes for call id 425426-recon for 423993 ends
					recordSetPhone1 = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountBO.PhoneEmail.PhoneEmailType1");
            }
			else if(boName=='AccountModBO'){
					recordSetPhone = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountModBO.PhoneEmail.PhoneEmailType");
					if(preferredPhone.value == recordSetPhone && preferredPhone.value != null){
						preferredPhoneFlag = true;
					}
					//Changes for call id 425426-recon for 423993 starts
					if(recordSetPhone!= null && preferredMobileAlert.value != null && recordSetPhone.indexOf(preferredMobileAlert.value)!=-1){
												preferredAlertFlag = true;
						  }
					//Changes for call id 425426-recon for 423993 ends
					recordSetPhone1 = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountModBO.PhoneEmail.PhoneEmailType1");
            }
					if(preferredEmail.value == recordSetPhone1 && preferredEmail.value != null){
						preferredEmailFlag = true;
					}
				}
				if(!preferredPhoneFlag && preferredPhone.value != null && preferredPhone.value != '')
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50268",""), preferredPhone.name, 'NO_HLINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
				}
				if(!preferredEmailFlag && preferredEmail.value != null && preferredEmail.value != '')
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50269",""), preferredEmail.name, 'NO_HLINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
				}
				//Changes for call id 425426-recon for 423993 starts
				if(!preferredAlertFlag && preferredMobileAlert.value != null && preferredMobileAlert.value != '')
								{
								selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
								parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ51306",""), preferredMobileAlert.name, 'HYPER_LINK');
								parent.parent.parent.parent.messageFrm.showMessages(selTabId);
								return "interactive";
				}
				//Changes for call id 425426-recon for 423993 ends
			}
			//changes for tracker 353384 start
			try{
			emailingPreferred=getCookie('doNotSendEMailFlg');
			if(!preferredEmailFlag && emailingPreferred == 'Y'){
				selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50269",""), preferredEmail.name, 'NO_HLINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				return "interactive";
			}
			}catch(e){}
			//changes for tracker 353384 start
		}
		}
		//MATPT mahesh changes end

		/* CIF PhoneEmail Changes : End */

		/* Changes for Tracker #109562 -- start */

		var adMobileNo = '';
		for(var i = 0; i <noOfPhoneEmail; i++){
			 if (ad_PhoneEmailType[i] == 'CELLPH') {
				adMobileNo = ad_PhoneNoLocalCode[i];
			 }
		}
		/* Changes for Tracker #109562 -- end */
        /* ***** Tracker# 97236 SMS Banking Mobile Number changes : Start ***** */
        	//Changes for the Tracker Id: 361934
		if(document.getElementsByName(boName+".IsSMSBankingEnabled")[0].checked
		   && SMSBankingNo=='')   
		{
			/* Changes for Tracker #109562 -- start */
			var mobileNoEntered = adMobileNo;
			/* Changes for Tracker #109562 -- end */
 			if(mobileNoEntered=='')
			{
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50476",""),"AccountBO.SMSBankingMobileNumber",'HYPER_HLINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				return "interactive";
			}
			else
			{
				SMSBankingMobileNumber.value = mobileNoEntered;
			}
		}
        /* ***** Tracker# 97236 SMS Banking Mobile Number changes : End ***** */
            addEduCounter = 0 ;
	    addPhoneEmailCounter = 0;
            clearAddressValues();
 try {
             for(var i = 0; i <noOfEdu; i++) {
                 if((edu_URL[i] != null) && !(edu_Status[i] == "Remove")) {
                     if(addEduCounter == 0) {
                                 document.frm2.address_type.value=srmEscape(ad_address_type[i], '^', escChars);
                                 /*Tracker 159095 : Sonali begin of changes*/
 			        document.frm2.houseno.value = srmEscapeAddr(ad_houseno[i], '^', escCharsAddr);
 			        document.frm2.premiseno.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
 			        document.frm2.building.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
 			        /*Tracker 159095 : Sonali end of changes*/
 			        document.frm2.country.value = srmEscape(ad_country[i], '^', escChars);
 			        document.frm2.city.value = srmEscape(ad_city[i], '^', escChars);
 			        document.frm2.state.value = srmEscape(ad_state[i], '^', escChars);
 			        /*ERPBOCF1:TRACKER:113259:STORAGE OF DATES :START OF CHANGES*/
				//tarcker id 113227 changes
				var strALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
				if(strALTCALENDAR_TYPE = 'true')
				{
					if(ad_start_date[i] != '')
					{
						var strFlag = isGregDateWithoutConv(ad_start_date[i]);
						if(strFlag != 'true')
						{
							ad_start_date[i]=convertHijToGreg(ad_start_date[i]);
						}
					}
					if(ad_end_date[i] != '')
					{
						var strFlag = isGregDateWithoutConv(ad_end_date[i]);
						if(strFlag != 'true')
						{
							ad_end_date[i]=convertHijToGreg(ad_end_date[i]);
						}
					}
				}
				/*ERPBOCF1:TRACKER:113259:STORAGE OF DATES :END OF CHANGES*/
 			        document.frm2.start_date.value = srmEscape(ad_start_date[i], '^', escChars);
 			        document.frm2.zip.value = srmEscape(ad_zip[i], '^', escChars);
 			        document.frm2.end_date.value = srmEscape(ad_end_date[i], '^', escChars);
 				document.frm2.addrID.value = srmEscape(ad_addrID[i], '^', escChars);
 				/*Tracker 159095 : Sonali begin of changes*/
 				document.frm2.streetno.value = srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);

 				document.frm2.town.value = srmEscapeAddr(ad_town[i], '^', escCharsAddr);
 				document.frm2.locality.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
 				document.frm2.domicile.value = srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
 				/*Tracker 159095 : Sonali end of changes*/
				//CIF PhoneEmail Changes : Start
				document.frm2.PreferredFormat.value = srmEscape(ad_PreferredFormat[i], '^', escChars);
				document.frm2.HoldMailReason.value = srmEscape(ad_HoldMailReason[i], '^', escChars);
				document.frm2.BusinessCenter.value = srmEscape(ad_BusinessCenter[i], '^', escChars);
				document.frm2.HoldMailInitiatedBy.value = srmEscape(ad_HoldMailInitiatedBy[i], '^', escChars);
				document.frm2.HoldMailFlag.value = srmEscape(ad_HoldMailFlag[i], '^', escChars);
// AdressLine changes: START
				/*Tracker 159095 : Sonali begin of changes*/
				document.frm2.AddressLine1.value = srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
				document.frm2.AddressLine2.value = srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
				document.frm2.AddressLine3.value = srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
// AdressLine changes: END
				document.frm2.FreeTextLabel.value = srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
				/*Tracker 159095 : Sonali end of changes*/
				if(document.frm2.byPassFlag.value!="Y"){
				document.frm2.PreferredAddress.value = document.getElementsByName('AccountBO.Address.preferredAddress')[0].value;
				}
				//CIF PhoneEmail Changes : End
				/*Tracker 159095 : Sonali  begin of changes*/
 				document.frm2.website.value = srmEscapeAddr(ad_website[i], '^', escCharsAddr);
 				document.frm2.mailstop.value = srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
 				document.frm2.streetname.value = srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
 	                        document.frm2.suburb.value = srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
 	                        /*Tracker 159095 : Sonali end of changes*/
 	                        document.frm2.IsAddressProofRcvd.value = srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
 	                        document.frm2.IsAddressVerified.value = srmEscape(ad_IsAddressVerified[i], '^', escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
				document.frm2.city_code.value 		= srmEscape(ad_cityCode[i], '^', escChars);
				document.frm2.state_code.value 		= srmEscape(ad_stateCode[i], '^', escChars);
				document.frm2.country_code.value 	= srmEscape(ad_cntryCode[i], '^', escChars);
                         addEduCounter = 1;
                     }else{
                         document.frm2.address_type.value = document.frm2.address_type.value + " ," + srmEscape(ad_address_type[i], '^', escChars);
                        /*Tracker 159095 : Sonali begin of changes*/
                         document.frm2.houseno.value = document.frm2.houseno.value + "%" + srmEscapeAddr(ad_houseno[i], '^', escCharsAddr);
                         document.frm2.premiseno.value = document.frm2.premiseno.value + "%" + srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
                         document.frm2.building.value = document.frm2.building.value + "%" + srmEscapeAddr(ad_building[i], '^', escCharsAddr);
                         /*Tracker 159095 : Sonali end of changes*/
                         /*Changes for call 201306 Starts*/
                         document.frm2.country.value = document.frm2.country.value + "," + srmEscape(ad_country[i], '^', escChars);
                         document.frm2.city.value = document.frm2.city.value + "," + srmEscape(ad_city[i], '^', escChars);
                         document.frm2.state.value = document.frm2.state.value + "," + srmEscape(ad_state[i], '^', escChars);
                         /*Changes for call 201306 Ends*/
                	/*ERPBOCF1:TRACKER:113259:STORAGE OF DATES :START OF CHANGES*/
			//tracker id 113227 changes
			var strALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
			if(strALTCALENDAR_TYPE = 'true')
			{
				if(ad_start_date[i] != '')
				{
					var strFlag = isGregDateWithoutConv(ad_start_date[i]);
					if(strFlag != 'true')
					{
						ad_start_date[i]=convertHijToGreg(ad_start_date[i]);
					}
				}
				if(ad_end_date[i] != '')
				{
					var strFlag = isGregDateWithoutConv(ad_end_date[i]);
					if(strFlag != 'true')
					{
						ad_end_date[i]=convertHijToGreg(ad_end_date[i]);
					}
				}
			}
				/*ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES*/
                         document.frm2.start_date.value = document.frm2.start_date.value + " ," + srmEscape(ad_start_date[i], '^', escChars);
                         document.frm2.zip.value = document.frm2.zip.value + " ," + srmEscape(ad_zip[i], '^', escChars);
                         document.frm2.end_date.value = document.frm2.end_date.value + " ," + srmEscape(ad_end_date[i], '^', escChars);
                         document.frm2.addrID.value = document.frm2.addrID.value + " ," + srmEscape(ad_addrID[i], '^', escChars);
 			/*Tracker 159095 :Sonali begin of changes*/
                         document.frm2.streetno.value = document.frm2.streetno.value + "%" + srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
                         document.frm2.town.value = document.frm2.town.value + "%" + srmEscapeAddr(ad_town[i], '^', escCharsAddr);
                         document.frm2.locality.value = document.frm2.locality.value + "%" + srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
                         document.frm2.domicile.value = document.frm2.domicile.value + "%" + srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
                         /*Tracker 159095 : Sonali end of changes*/
			 //CIF PhoneEmail Changes : Start
			 document.frm2.PreferredFormat.value = document.frm2.PreferredFormat.value + " ," + srmEscape(ad_PreferredFormat[i], '^', escChars);
			 document.frm2.HoldMailReason.value = document.frm2.HoldMailReason.value + " ," + srmEscape(ad_HoldMailReason[i], '^', escChars);
			 document.frm2.BusinessCenter.value = document.frm2.BusinessCenter.value + " ," + srmEscape(ad_BusinessCenter[i], '^', escChars);
			 document.frm2.HoldMailInitiatedBy.value = document.frm2.HoldMailInitiatedBy.value + " ," + srmEscape(ad_HoldMailInitiatedBy[i], '^', escChars);
			 document.frm2.HoldMailFlag.value = document.frm2.HoldMailFlag.value + " ," + srmEscape(ad_HoldMailFlag[i], '^', escChars);
// AdressLine changes: START
			/*Tracker 159095 : Sonali begin of changes*/
			document.frm2.AddressLine1.value = document.frm2.AddressLine1.value+ "%" + srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
			document.frm2.AddressLine2.value = document.frm2.AddressLine2.value+ "%" + srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
			document.frm2.AddressLine3.value = document.frm2.AddressLine3.value+ "%" + srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
// AdressLine changes: END
			 document.frm2.FreeTextLabel.value = document.frm2.FreeTextLabel.value + "%" + srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
                         /*Tracker 159095 : Sonali end of changes*/
			 if(document.frm2.byPassFlag.value!="Y"){
			 document.frm2.PreferredAddress.value = document.getElementsByName('AccountBO.Address.preferredAddress')[0].value;
			 }
			 //CIF PhoneEmail Changes : End
			/*Tracker 159095 : Sonali begin of changes*/
 			 document.frm2.website.value = document.frm2.website.value + "%" + srmEscapeAddr(ad_website[i], '^', escCharsAddr);
 			 document.frm2.mailstop.value = document.frm2.mailstop.value + "%" + srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
 			 document.frm2.streetname.value = document.frm2.streetname.value + "%" + srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
 			 document.frm2.suburb.value = document.frm2.suburb.value + "%" + srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
                         /*Tracker 159095 : Sonali end of changes*/
 			 document.frm2.IsAddressProofRcvd.value = document.frm2.IsAddressProofRcvd.value + " ," + srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
 			 document.frm2.IsAddressVerified.value = document.frm2.IsAddressVerified.value + " ," + srmEscape(ad_IsAddressVerified[i], '^', escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
			document.frm2.city_code.value 		= document.frm2.city_code.value + " ," +srmEscape(ad_cityCode[i], '^', escChars);
			document.frm2.state_code.value 		= document.frm2.state_code.value + " ," +srmEscape(ad_stateCode[i], '^', escChars);
			document.frm2.country_code.value 	= document.frm2.country_code.value + " ," +srmEscape(ad_cntryCode[i], '^', escChars);
 			 }
 			 }
 			 }
			var st=" ";
			var sep =",";
			for(p=0;p<ad_LastUpdate_Flag.length;p++)
			{
				if(ad_LastUpdate_Flag[p]!=null && ad_LastUpdate_Flag[p]!='')
				{
				 st+=ad_LastUpdate_Flag[p]+sep;
				}
			}
 			 document.getElementsByName("hidSt")[0].value=st;

//changes for ticket 635409 start
if(blFlag==false){
		if(mailingad == true){    
		var cc = document.frm2.streetno.value;
		if(cc == '' || cc == null){
parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CORPAD",""),TBODY_RecordSet.rows ,'NO_HLINK');
			 parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			 return "interactive"
			 }
		}
		}

//changes for ticket 635409 


 			 /* CIF PhoneEmail Changes : Start */
 			 if(document.frm2.byPassFlag.value!="Y"){
 			 for(var i = 0; i <noOfPhoneEmail; i++){
 			 if((phoneEmail_URL[i] != null) && !(phoneEmail_Status[i] == "Remove")) {
 			 if(addPhoneEmailCounter == 0) {
 			 document.frm2.PhoneNo.value = srmEscape(ad_PhoneNo[i], '^', escChars);
 			 document.frm2.PhoneOrEmail.value = srmEscape(ad_PhoneOrEmail[i], '^', escChars);
 			 document.frm2.PhoneEmailType.value = srmEscape(ad_PhoneEmailType[i], '^', escChars);
 			 document.frm2.PhoneEmailID.value = srmEscape(ad_PhoneEmailID[i], '^', escChars);
 			 document.frm2.Email.value = srmEscape(ad_Email[i], '^', escChars);
 			 document.frm2.PhoneNoCountryCode.value = srmEscape(ad_PhoneNoCountryCode[i], '^', escChars);
 			 document.frm2.PhoneNoCityCode.value = srmEscape(ad_PhoneNoCityCode[i], '^', escChars);
 			 document.frm2.PhoneNoLocalCode.value = srmEscape(ad_PhoneNoLocalCode[i], '^', escChars);
 			 document.frm2.extension.value = srmEscape(ad_extension[i], '^', escChars);
 			 document.frm2.PreferredPhone.value = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType')[0].value;
 			 document.frm2.PreferredEmail.value = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType1')[0].value;
 			 addPhoneEmailCounter = 1;
 			 }
 			 else
 			 {
  		         /*Modified For Recon Id : 435250 - Extra space Removed while Appending Starts */
 			 document.frm2.PhoneEmailID.value = document.frm2.PhoneEmailID.value + "," + srmEscape(ad_PhoneEmailID[i], '^', escChars);
 			 document.frm2.PhoneOrEmail.value = document.frm2.PhoneOrEmail.value + "," + srmEscape(ad_PhoneOrEmail[i], '^', escChars);
 			 document.frm2.PhoneNo.value = document.frm2.PhoneNo.value + "," + srmEscape(ad_PhoneNo[i], '^', escChars);
 			 document.frm2.PhoneEmailType.value = document.frm2.PhoneEmailType.value + "," + srmEscape(ad_PhoneEmailType[i], '^', escChars);
 			 document.frm2.Email.value = document.frm2.Email.value + "," + srmEscape(ad_Email[i], '^', escChars);
 			 document.frm2.PhoneNoCountryCode.value = document.frm2.PhoneNoCountryCode.value + "," + srmEscape(ad_PhoneNoCountryCode[i], '^', escChars);
 			 document.frm2.PhoneNoCityCode.value = document.frm2.PhoneNoCityCode.value + "," + srmEscape(ad_PhoneNoCityCode[i], '^', escChars);
 			 document.frm2.PhoneNoLocalCode.value = document.frm2.PhoneNoLocalCode.value + "," + srmEscape(ad_PhoneNoLocalCode[i], '^', escChars);
 			 document.frm2.extension.value = document.frm2.extension.value + "," +srmEscape(ad_extension[i], '^', escChars);
			 /*Modified For Recon Id : 435250 - Extra space Removed while Appending Ends */
 			 document.frm2.PreferredEmail.value = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType1')[0].value;
 			 document.frm2.PreferredPhone.value = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType')[0].value;
 			 }
 			 }
 			 }
 			 }
 			 /* CIF PhoneEmail Changes : End */

 } catch(ge) { DebugMessage(ge.message); }
                         document.frm2.AdrRemoved.value = getCSVforArray(edu_detachedURLs);
                         document.frm2.PhoneEmailRemoved.value = getCSVforArray(phone_detachedURLs);
      	      if(blFlag == true)
      	      {
      		    document.frm2.saveFlag.value = 0;
      	       }
      	       else
      	       {
      		    document.frm2.saveFlag.value = 1;
      	       }
            try{
					validateAccRM();
					setHiddenFieldsHH();
/*IDENTIFICATION DOCUMENT CHANGES Tracker ID 113276 start*/
					setHiddenIDFields();
					// Change for DBS ticket 325152
					//document.frm2.SwiftAddressDetails.value 		= SwiftAddressDetails;
/*IDENTIFICATION DOCUMENT CHANGES Tracker ID 113276 end*/
                if(!hasOtherErrors){
                    supplementAttrib();
                    var isCopy = document.frm2.IsCopy.value;
					if(defAddress == "Mailing") {
						defAddress = "M";
					}
					else if(defAddress == "Home")
						defAddress = "H";
					else
						defAddress = "W";
		setHiddenFieldsGrp();
	var ownerSegment= document.getElementsByName('AccountBO.accessOwnerSegment')[0].value;
	var primaryRM=document.getElementsByName("Acc_manager")[0].value;
	var secondaryRM=document.getElementsByName("Sec_manager")[0].value;
	if (RMChanged=="true" && SegmentChanged=="true") {
		if(showConfirmMessage(MSGJ50358)){
		}else{
			return "interactive";
		}
	}
	else if (RMChanged=="true" && ownerSegment!=null && ownerSegment!='') {
		if(showConfirmMessage(MSGJ50358)){
		}else{
			return "interactive";
		}
	}
	else if (SegmentChanged=="true" && ((primaryRM!=null && primaryRM!='') || (secondaryRM!=null && secondaryRM!='') || (tertiaryRM!='' && tertiaryRM!=null))) {
		if(showConfirmMessage(MSGJ50357)){
		}else{
			return "interactive";
		}
	}
/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/

	/***calling functions****/
	fnConvertDate();


/*ERPBOCF1:TRACKER:113259:STORAGE OF DATES :END OF CHANGES*/



                    document.frm2.accKey.value=document.getElementsByName("AccountBO.ACCOUNTKEY")[0].value;
                    //Tracker ID 113276 - Start
                    /*var introSal = document.getElementsByName(boName + ".IntroducerSalutation")[0].value;	 */
                    //Tracker ID 113276 - End

			if(SwiftAddressDetails == ""){

				SwiftAddressDetails='YYY';
				if(blFlag == true){
					parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(), "Swift Address is Defaulted from Preferred Address Type");
					parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames(0).getSelectedTabId());
				}
			}
			//Ticket id 439883 and Tracker id 265600 Recon for Call id 225120 changes starts
			SwiftAddressDetails = SwiftAddressDetails.replace(/&/g, "%26");
			//Ticket id 439883 and Tracker id 265600 Recon for Call id 225120 changes ends
			//Change for ticket 326535
			document.frm2.SwiftAddressDetails.value 		= SwiftAddressDetails;
			var lastName_alt = getCookie('LookupAccountLastName_alt1');
			// Change for DBS ticket 325152
/* START  Changes for Tracker # 209607*/
			/* Null cahnges Begin*/
			newPara = document.getElementById("myPar");
			var frame='formSaveFrame';
                        
//changes for call id 371696 and recon for 359045 starts
			document.frm2.Minor_guard_code.value = document.getElementsByName("RelationshipBO.Guard_Code")[0].value;
//changes for call id 371696 and recon for 359045 ends
                        // Changes for ticket id 576082
			   if (operationType == "ConvtoCust") {			                        
			document.frm2.hid_reservestatus.value=operationType;
			}
			//Customer Onboarding Validation
				   if((operationType != 'Edit Entity') && (operationType != 'Queue') && (operationType != 'ConvtoCust'))

				{
				try{
				var Filter_uniqueId = getCookie('Filter_uniqueId');
				var Filter_documentcode = getCookie('Filter_documentcode');
				
				
				
				var nationalCardID =document.getElementsByName("National Card Number.txt_ID")[0].value;
				
				var PANID =document.getElementsByName("PAN.txt_ID")[0].value;
				var IDTypeR1ID =document.getElementsByName("IDTypeR1.txt_ID")[0].value;
				var IDTypeR2ID =document.getElementsByName("IDTypeR2.txt_ID")[0].value;
				var IDTypeR3ID =document.getElementsByName("IDTypeR3.txt_ID")[0].value;
				var IDTypeR4ID =document.getElementsByName("IDTypeR4.txt_ID")[0].value;
				var IDTypeR5ID =document.getElementsByName("IDTypeR5.txt_ID")[0].value;
				var RationCardID =document.getElementsByName("Ration Card Number.txt_ID")[0].value;
				var SSNID =document.getElementsByName("SSN.txt_ID")[0].value;
				var TINID =document.getElementsByName("TIN.txt_ID")[0].value;
				var electionCardID =document.getElementsByName("Election ID Card.txt_ID")[0].value;
				var DrivingLicenceID =document.getElementsByName("Driving Licence.txt_ID")[0].value;
				var passportID =document.getElementsByName("Passport Number.txt_ID")[0].value;
				
				
		if(!((Filter_uniqueId==nationalCardID) || (Filter_uniqueId==PANID) ||  (Filter_uniqueId==IDTypeR1ID)
	|| (Filter_uniqueId==IDTypeR2ID) || (Filter_uniqueId==IDTypeR3ID) || (Filter_uniqueId==IDTypeR4ID)
			|| (Filter_uniqueId==IDTypeR5ID) || (Filter_uniqueId==RationCardID) || (Filter_uniqueId==SSNID) 
			|| (Filter_uniqueId==TINID) ||  (Filter_uniqueId==electionCardID) || (Filter_uniqueId==DrivingLicenceID)
			|| (Filter_uniqueId==passportID)))	

{
				   
				   
				  alert("The identification document details do not match with the details entered in customer onboard menu");
				 
				  return "interactive";
				 
				
				}
				
				
				}
				
				catch(e)
				{}
				
				
				}
				
				
				
				
				
	//Customer Onboarding Validation
                        
                        /*changes for callid: 235861 Ticket: 454978 tracker: 275564  start*/
                        genralURL="../servlet/com.infy.cis.ui.common.AccWriter?isCopy="+isCopy+"&introLastName_alt1="+lastName_alt+"&showMsg=No&amp;CreatePartner=N";
                        /*changes for callid: 235861 Ticket: 454978 tracker: 275564  ends*/
                        fnRemoveNull(newPara,genralURL,document.frm2,frame);
                        /* Null cahnges End*/
			//document.frm2.action = "../servlet/com.infy.cis.ui.common.AccWriter?isCopy="+isCopy+"&introLastName_alt1="+lastName_alt+"&showMsg=No&amp;CreatePartner=N";

			/****** End of Swift Address changes ****/



                    //document.frm2.target="formSaveFrame";
                   // document.frm2.submit();
/* END  Changes for Tracker # 209607*/
                    return "true";
                }else{
                    return "false";
                }
            }catch(e){}
}catch(exp){}
    }


	 function fnConvertDate()
	 {
	 	var arrDateList = new Array();
	 	var arrFinalDateList = new Array();
	 	//tracker id 113227 changes
	 	var ALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
	 	var strCust_DOB =document.getElementsByName("AccountBO.Cust_DOB")[0].value;
	 	var strConverted_Date =document.all.converted_Date.value;
	 	var strRelationshipOpeningDate =document.getElementsByName("3_AccountBO.RelationshipOpeningDate")[0].value;
	 	var strRiskProfileExpiryDate =document.getElementsByName("3_AccountBO.RiskProfileExpiryDate")[0].value;
	 	var strDateOfBecomingNRE =document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0].value;
	 	arrDateList[0] = strCust_DOB;
		arrDateList[1] = strConverted_Date;
		arrDateList[2] = strRelationshipOpeningDate;
		arrDateList[3] = strRiskProfileExpiryDate;
		arrDateList[4] = strDateOfBecomingNRE;
		var strLength = arrDateList.length-1;
		if(strALTCALENDAR_TYPE = 'true')
		{
			for(iCount=0;iCount<=strLength;iCount++)
			{
				strDate=arrDateList[iCount];
				if(strDate == '')
				{
					arrFinalDateList[iCount]= '';
				}
				else
				{
					var strFlag = isGregDateWithoutConv(strDate);
					if(strFlag != 'true')
					{
						strDate=convertHijToGreg(strDate);
						arrFinalDateList[iCount]= strDate;
					}
					else
					{
						arrFinalDateList[iCount]= strDate;
					}
				}
			}
			document.all.Cust_DOB.value = arrFinalDateList[0];
			document.all.converted_Date.value = arrFinalDateList[1];
			document.all.RelationshipOpeningDate.value = arrFinalDateList[2];
			document.all.RiskProfileExpiryDate.value = arrFinalDateList[3];
			document.all.DateOfBecomingNRE.value = arrFinalDateList[4];
		}
	}

        /*
                   function used to fetch the duplicate fields
                   to populate the Account/suspect/contact.
               */
              function supplementAttrib(){
                   try{
                          if(parent.parent.IFrmtab1.formDispFrame.document.frm2 != "undefined"){
                              parent.parent.IFrmtab1.formDispFrame.getQualificationforAccount();
                              document.all.PAN_txt_ID.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("PAN.txt_ID")[0].value;
                              document.all.SSN_txt_ID.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("SSN.txt_ID")[0].value;
                              // changes for adhar for tracker 375136 starts
                              document.all.UniqueIDNumber_txt_ID.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("Unique Identification Number.txt_ID")[0].value;
                              // changes for adhar for tracker 375136 ends
                              document.all.Driving_Licence_txt_ID.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("Driving Licence.txt_ID")[0].value;
                              document.all.Passport_Number_txt_ID.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("Passport Number.txt_ID")[0].value;
                              //Tracker 85215
                              document.all.Nat_id_card_num.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("National Card Number.txt_ID")[0].value;
							  document.all.Psprt_issue_date.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("Passport Number.txt_Issue_Date")[0].value;
							  document.all.Psprt_exp_date.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("Passport Number.txt_Valid_Date")[0].value;
                              document.all.DemographicBO_Qualification.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("DemographicBO.Qualification")[0].value;
                              if(boName=="AccountBO"){
                              		document.all.DemographicBO_MiscellaneousInfo_strText9.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("DemographicBO.MiscellaneousInfo.strText9")[0].value;
                              		document.all.DemographicBO_MiscellaneousInfo_strText3.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("DemographicBO.MiscellaneousInfo.strText3")[0].value;
       			        document.all.DemographicBO_MiscellaneousInfo_strText2.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("DemographicBO.MiscellaneousInfo.strText2")[0].value;
       			        document.getElementsByName("AccountBO.Occupation_code")[0].value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("DemographicBO.MiscellaneousInfo.StrText2_code")[0].value;
              			}else{
						document.all.DemographicBO_MiscellaneousInfo_strText2.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("DemographicModBO.MiscellaneousInfo.strText2")[0].value;
						document.all.DemographicBO_MiscellaneousInfo_strText9.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("DemographicModBO.MiscellaneousInfo.strText9")[0].value;
						document.getElementsByName("AccountBO.Occupation_code")[0].value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("DemographicModBO.MiscellaneousInfo.StrText2_code")[0].value;
						document.all.DemographicBO_MiscellaneousInfo_strText3.value = parent.parent.IFrmtab1.formDispFrame.document.getElementsByName("DemographicModBO.MiscellaneousInfo.strText3")[0].value; 
       		        }
                              }
                          }catch(e)
                          {
                          }
               }
                function disableConditionally(obj1,obj2){
                   try{
			elem1 = document.getElementsByName(obj1)[0];
			elem2 = document.getElementsByName(obj2)[0];
                        if(elem1.options[elem1.selectedIndex].value == "Y"){
                            elem2.disabled = false;
                        if(elem2 == document.getElementsByName("AccountBO.StaffEmployeeID")[0])
			    	{
			    	document.getElementsByName("btnone_AccountBO.StaffEmployeeID")[0].style.visibility = "";
				document.getElementsByName("btntwo_AccountBO.StaffEmployeeID")[0].style.visibility = "";
    				}

                        } else{
                            elem2.value = "";
                            elem2.disabled = true;
                            elem2.IsMandatory = "false";
                        if(elem2 == document.getElementsByName("AccountBO.StaffEmployeeID")[0])
			     		{
			     		document.getElementsByName("btnone_AccountBO.StaffEmployeeID")[0].style.visibility = "hidden";
			 		document.getElementsByName("btntwo_AccountBO.StaffEmployeeID")[0].style.visibility = "hidden";
				}
                        }
                    }catch(e){
                    }
                }
        //Staff Id validations for 10.2.13    
	function disableStaffFieldConditionally(obj1,obj2){
	   try{

		elem1 = document.getElementsByName(obj1)[0];
		elem2 = document.getElementsByName(obj2)[0];
		var sFlag = elem1.value;
		if(sFlag == "Y" || sFlag == "EXSTF"){
			elem2.disabled = false;
			document.getElementsByName("btnone_AccountBO.StaffEmployeeID")[0].style.visibility = "";
			document.getElementsByName("btntwo_AccountBO.StaffEmployeeID")[0].style.visibility = "";

		} 
		else{
			elem2.value = "";
			elem2.disabled = true;
			document.getElementsByName("btnone_AccountBO.StaffEmployeeID")[0].style.visibility = "hidden";
			document.getElementsByName("btntwo_AccountBO.StaffEmployeeID")[0].style.visibility = "hidden";
		}

	    }
	    catch(e){
	    }
	}
        function FieldsForValidationCust(){
            try{
                Screen = 0;
                flag = "true";
                addressType = new Array("Mailing", "Work", "Home", "Future/OnSite");
                for(i=0; i < addressType.length ; i++){
                    try {
						selTabId = parent.parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					} catch(e) {
					}
                    start_date = document.getElementsByName(addressType[i]+".txt_Start_Date")[0];
                    start_date.Display = addressType[i]+" Address : Start Date";
                    start_date.Name = "Start Date";
                    end_date = document.getElementsByName(addressType[i]+".txt_End_Date")[0];
                    end_date.Display = addressType[i]+" Address : End Date";
                    end_date.Name = "End Date";
                    user_date1 = document.getElementsByName(addressType[i]+".txt_userDateField1")[0];
                    user_date1.Display = addressType[i]+" Address : User Date Field1";
                    user_date1.Name = "User Date Field1";
                    user_date2 = document.getElementsByName(addressType[i]+".txt_userDateField2")[0];
                    user_date2.Display = addressType[i]+" Address : User Date Field2";
                    user_date2.Name = "User Date Field2";
                    if(user_date1.value != "" ){
                        if(parent.parent.parent.parent.parent.validate_date2(user_date1, true,  false,"dd/MM/yyyy") == false) {
                            flag = "false";
                        }
                    }
                    if(user_date2.value != "" ){
                        if(parent.parent.parent.parent.parent.validate_date2(user_date2, true,  false,"dd/MM/yyyy") == false) {
                            flag = "false";
                        }
                    }
                    if(start_date.value != "" ){
                        if(parent.parent.parent.parent.parent.validate_date2(start_date, true,  false,"dd/MM/yyyy") == false) {
                            flag = "false";
                        }
                    }
                    if(end_date.value != "" ){
                        if(parent.parent.parent.parent.parent.validate_date2(end_date, true,  false,"dd/MM/yyyy") == false) {
                            flag = "false";
                        }
                    }
                    if(start_date.value != "" && end_date.value != ""){
                        if(parent.parent.parent.parent.parent.valdateStartDate_EndDate(start_date, end_date, 1) == "false"){
                            flag = "false";
                        }
                    }
                }
               return flag;
            }catch(e){
                return "true";
            }
        }
        function IsMinor(dobDay,dobMonth,dobYear){
            var MINOR_YEAR = document.all.MINOR_YEAR.value;
/*ERPBOCF1:TRACKER:113259:START OF CHANGES(HIJRI:MINOR TO MAJOR CONVERSION)*/
   var strCalType = getCookie('SRMCalendar');
	    if(strCalType == 'H')
	    {
	        var FormatOfDate = getColorCookie('SRMDateFormat');
		var dobDMY;
		if (FormatOfDate=="dd/MM/yyyy")
		{
		dobDMY=dobDay+"/"+dobMonth+"/"+dobYear;
		}
		if (FormatOfDate=="dd-MM-yyyy")
		{
		dobDMY=dobDay+"-"+dobMonth+"-"+dobYear;
		}
		if (FormatOfDate=="MM/dd/yyyy")
		{
		dobDMY=dobMonth+"/"+dobDay+"/"+dobYear;
		}
		if (FormatOfDate=="MM-dd-yyyy")
		{
		dobDMY=dobMonth+"-"+dobDay+"-"+dobYear;
		}
		dobDMY=convertHijToGreg(dobDMY);
		var a_strDate=new Array();
		if(dobDMY.indexOf("/") != -1)
			a_strDate = dobDMY.split("/");
		if(dobDMY.indexOf("-") != -1)
			a_strDate = dobDMY.split("-");
		if(dobDMY.indexOf(".") != -1)
		a_strDate = dobDMY.split(".");
		if (FormatOfDate=="dd/MM/yyyy")
		{
		dobDay=a_strDate[0];
		dobMonth=a_strDate[1];
		dobYear=a_strDate[2];
		}
		if (FormatOfDate=="dd-MM-yyyy")
		{
		dobDay=a_strDate[0];
		dobMonth=a_strDate[1];
		dobYear=a_strDate[2];
		}
		if (FormatOfDate=="MM/dd/yyyy")
		{
		dobDay=a_strDate[1];
		dobMonth=a_strDate[0];
		dobYear=a_strDate[2];
		}
		if (FormatOfDate=="MM-dd-yyyy")
		{
		dobDay=a_strDate[1];
		dobMonth=a_strDate[0];
		dobYear=a_strDate[2];
		}
	}
		/*ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI:MINOR TO MAJOR CONVERSION)*/
	    // Fix for TRACKER ID : 122350 STARTS
	    var date = new Date(locDate);
	    // Fix for TRACKER ID : 122350 ENDS
	    /*Fix for Tracker #: SIDDHARTH Ends*/
	    var thisYear = date.getYear() ;
            var thisMonth = date.getMonth()+1;
            var thisDay = date.getDate() ;
            var yearDiff = thisYear - dobYear ;
            //Ticket 291435 changes begin
            var convType = document.all.CONV_CALENDAR_TYPE.value;
            if (convType == 'Hijri')
            {
            var ConvertedMajorDate=MajorDate(dobDay,dobMonth,dobYear);
            var a_strMajorDate=new Array();
	    		if(ConvertedMajorDate.indexOf("/") != -1)
	    			a_strMajorDate = ConvertedMajorDate.split("/");
	    		if(ConvertedMajorDate.indexOf("-") != -1)
	    			a_strMajorDate = ConvertedMajorDate.split("-");
	    		if(ConvertedMajorDate.indexOf(".") != -1)
	    		a_strMajorDate = ConvertedMajorDate.split(".");

	    		DateFormat= getColorCookie('SRMDateFormat');
	    		if (DateFormat=="dd/MM/yyyy")
	    		{
	    		dobMajorDay=a_strMajorDate[0];
	    		dobMajorMonth=a_strMajorDate[1];
	    		dobMajorYear=a_strMajorDate[2];
	    		}
	    		if (DateFormat=="dd-MM-yyyy")
	    		{
	    		dobMajorDay=a_strMajorDate[0];
	    		dobMajorMonth=a_strMajorDate[1];
	    		dobMajorYear=a_strMajorDate[2];
	    		}
	    		if (DateFormat=="MM/dd/yyyy")
	    		{
	    		dobMajorDay=a_strMajorDate[1];
	    		dobMajorMonth=a_strMajorDate[0];
	    		dobMajorYear=a_strMajorDate[2];
	    		}
	    		if (DateFormat=="MM-dd-yyyy")
	    		{
	    		dobMajorDay=a_strMajorDate[1];
	    		dobMajorMonth=a_strMajorDate[0];
	    		dobMajorYear=a_strMajorDate[2];
			}

			if ( dobMajorYear < thisYear)
			{
			return 'false';
			}else if ( dobMajorYear > thisYear)
			{
			return 'true';
			}else if ( dobMajorMonth > thisMonth){
			return 'true';
			}else if ( dobMajorMonth < thisMonth){
			return 'false';
			}else if ( dobMajorDay > thisDay){
			return 'true';
			}else {
			return 'false';
			}
            }else{

            //Ticket 291435 changes ends
            if ( yearDiff > MINOR_YEAR)
            {
                return 'false';
            }else if ( yearDiff < MINOR_YEAR)
            {
                return 'true';
            }else if ( thisMonth < dobMonth){
                return 'true';
            }/*Fix for Tracker #: SIDDHARTH Starts*/
            else if ( thisMonth > dobMonth){
                return 'false';
            }/*Fix for Tracker #: SIDDHARTH Ends*/
            else if ( thisDay < dobDay){
                return 'true';
            }else {
                return 'false';
            }
        }
        }
	 function MajorDate(dobDay,dobMonth,dobYear){
		try{
			/*ERPBOCF1:TRACKER:113259:START OF CHANGES(HIJRI:MINOR TO MAJOR CONVERSION)*/
			if(dobDay.length == 1)
			{
			 dobDay="0"+dobDay;
			}
			if(dobMonth.length == 1)
			{
			 dobMonth="0"+dobMonth;
 			}
 			var FormatOfDate = getColorCookie('SRMDateFormat');
 			var dobDMY;
 			if (FormatOfDate=="dd/MM/yyyy")
			{
			dobDMY=dobDay+"/"+dobMonth+"/"+dobYear;
			}
			if (FormatOfDate=="dd-MM-yyyy")
			{
			dobDMY=dobDay+"-"+dobMonth+"-"+dobYear;
			}
			if (FormatOfDate=="MM/dd/yyyy")
			{
			dobDMY=dobMonth+"/"+dobDay+"/"+dobYear;
			}
			if (FormatOfDate=="MM-dd-yyyy")
			{
			dobDMY=dobMonth+"-"+dobDay+"-"+dobYear;
			}
		   	var CONV_CALENDAR_TYPE = document.all.CONV_CALENDAR_TYPE.value;
		    	var checkDateType=isGregDateWithoutConv(dobDMY);
		    	if(checkDateType == 'true' && CONV_CALENDAR_TYPE == "Hijri")
		    	{
		    	 dobDMY=convertGregToHij(dobDMY);
		    	}
		    	if(checkDateType == 'false' && CONV_CALENDAR_TYPE == "Gregorian")
		    	{
		    	 dobDMY=convertHijToGreg(dobDMY);
		    	}
		    	var a_strDate=new Array();
		    	if(dobDMY.indexOf("/") != -1)
				a_strDate = dobDMY.split("/");
			if(dobDMY.indexOf("-") != -1)
				a_strDate = dobDMY.split("-");
			if(dobDMY.indexOf(".") != -1)
				a_strDate = dobDMY.split(".");
		    	dobYear=a_strDate[2];
			var MINOR_YEAR = document.all.MINOR_YEAR.value;
			var majorYear 	= parseInt(dobYear) + parseInt(MINOR_YEAR);
			//Changes for Tracker id:299797 and Ticket Id:490790 starts Here
			 			var month =a_strDate[1];
			 			var day=a_strDate[0];
			 
	 if  (!( ( majorYear % 4 == 0 ) && ( ( majorYear % 100 != 0 ) || ( majorYear % 400 == 0 ) ) ))	{
			 if ( (month == 2 ) &&  ( day == 29 )) {
			
			
			 day=01;
			 month=parseInt(month)+parseInt(1);
			 
			 }
			 
 }
 a_strDate[0] = day;
 a_strDate[1] = month;
 
 // Changes for Tracker id:299797 and Ticket Id:490790 ends here 
			if(a_strDate[0].length == 1)
			{
			 a_strDate[0]="0"+a_strDate[0];
			}
			if(a_strDate[1].length == 1)
			{
			 a_strDate[1]="0"+a_strDate[1];
 			}
			var majorDate;
			/*ERPBOCF1: Fix for defect ticket 205305 start*/
			if (FormatOfDate=="dd/MM/yyyy" || FormatOfDate=="MM/dd/yyyy")
			{
			majorDate=a_strDate[0]+"/"+a_strDate[1]+"/"+majorYear;
			}
			if (FormatOfDate=="dd-MM-yyyy" || FormatOfDate=="MM-dd-yyyy")
			{
			majorDate=a_strDate[0]+"-"+a_strDate[1]+"-"+majorYear;
			}
			/*ERPBOCF1: Fix for defect ticket 205305 end*/
			checkDateType=isGregDateWithoutConv(majorDate);
			if(checkDateType == 'false')
			{
			 document.frm2.minorAttainMajorDateHij.value=majorDate;
			 majorDateGreg=convertHijToGreg(majorDate);
			 /*ERPBOCF1: Fix for defect ticket 205305 start*/
			 if(majorDateGreg == majorDate || majorDateGreg == "")
			 /*ERPBOCF1: Fix for defect ticket 205305 end*/
			 {
			 	showMessage(MSGJ50645);
			 	dobDMY=convertHijToGreg(dobDMY);
			 	if(dobDMY.indexOf("/") != -1)
					a_strDate = dobDMY.split("/");
				if(dobDMY.indexOf("-") != -1)
					a_strDate = dobDMY.split("-");
				if(dobDMY.indexOf(".") != -1)
					a_strDate = dobDMY.split(".");
				dobYear=a_strDate[2];
				majorYear 	= parseInt(dobYear) + parseInt(MINOR_YEAR);
				if(a_strDate[0].length == 1)
				{
				 a_strDate[0]="0"+a_strDate[0];
				}
				if(a_strDate[1].length == 1)
				{
				 a_strDate[1]="0"+a_strDate[1];
				}
				/*ERPBOCF1: Fix for defect ticket 205305 start*/
				if (FormatOfDate=="dd/MM/yyyy" || FormatOfDate=="MM/dd/yyyy")
				{
				majorDate=a_strDate[0]+"/"+a_strDate[1]+"/"+majorYear;
				}
				if (FormatOfDate=="dd-MM-yyyy" || FormatOfDate=="MM-dd-yyyy")
				{
				majorDate=a_strDate[0]+"-"+a_strDate[1]+"-"+majorYear;
				}
				/*ERPBOCF1: Fix for defect ticket 205305 end*/
			 }
			 else
			 {
			 majorDate = majorDateGreg;
			 }
		}
		    	/*ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI:MINOR TO MAJOR CONVERSION)*/
			return majorDate;
		}catch(e){
		}
	}
		/* *** Tracker# 49738, Begin of Changes *** */
		var agentLookupType = "";
		function  setAgentValues (type, agentName, loginId)	{
		eval("document.frm2." + type).value = loginId;
		if(type=='RelationshipCreatedBy'){
			document.getElementsByName("RelationshipCreatedBy")[0].fireEvent("onChange");
		}
		if(type == 'Acc_manager'){
			document.getElementsByName("AccountBO.RelationshipMgrID")[0].value = getCookie("LookupAccManagerID");
			Acc_managerURL = getCookie("AgentURL");
			document.getElementsByName("Acc_manager")[0].fireEvent("onChange");
		}
		/* *** Tracker# 89187, End of Changes *** */
		else if(type == 'Sec_manager'){
			Sec_managerURL = getCookie("AgentURL");
			document.getElementsByName("Sec_manager")[0].fireEvent("onChange");
		}else if(type == 'Ter_manager'){
			Ter_managerURL = getCookie("AgentURL");
			document.getElementsByName("Ter_manager")[0].fireEvent("onChange");
		}
		var primaryRM=document.getElementsByName("Acc_manager")[0].value;
		var secondaryRM=document.getElementsByName("Sec_manager")[0].value;
        if ( (primaryRM!="" && primaryRM != defaultPrimaryRM && primaryRM!=null && primaryRM!="null") || (secondaryRM !="" && secondaryRM != defaultSecondaryRM && secondaryRM !=null && secondaryRM!="null") || (tertiaryRM!="" && tertiaryRM != defaultTertiaryRM && tertiaryRM!=null && tertiaryRM!="null") ) {
			RMChanged='true';
		}
		else {
			RMChanged='false';
		}
		}
		function  setRMgrValue (type, agentName, loginId)	{
			eval("document.frm2." + type).value = loginId;
			document.getElementsByName("AccountBO.Manager")[0].value = loginId;
		}
		/* *** Tracker# 49738, End of Changes *** */
// TRACKER ID : 50914 Added Function For Checking Customer is Minor or Not
 
 
 
 
 
 //Senior Citizen Starts
 
 function IsSenior(dobDay,dobMonth,dobYear){
             var SENIOR_YEAR = document.all.SENIOR_YEAR.value;
    var strCalType = getCookie('SRMCalendar');
 	    if(strCalType == 'H')
 	    {
 	        var FormatOfDate = getColorCookie('SRMDateFormat');
 		var dobDMY;
 		if (FormatOfDate=="dd/MM/yyyy")
 		{
 		dobDMY=dobDay+"/"+dobMonth+"/"+dobYear;
 		}
 		if (FormatOfDate=="dd-MM-yyyy")
 		{
 		dobDMY=dobDay+"-"+dobMonth+"-"+dobYear;
 		}
 		if (FormatOfDate=="MM/dd/yyyy")
 		{
 		dobDMY=dobMonth+"/"+dobDay+"/"+dobYear;
 		}
 		if (FormatOfDate=="MM-dd-yyyy")
 		{
 		dobDMY=dobMonth+"-"+dobDay+"-"+dobYear;
 		}
 		dobDMY=convertHijToGreg(dobDMY);
 		var a_strDate=new Array();
 		if(dobDMY.indexOf("/") != -1)
 			a_strDate = dobDMY.split("/");
 		if(dobDMY.indexOf("-") != -1)
 			a_strDate = dobDMY.split("-");
 		if(dobDMY.indexOf(".") != -1)
 		a_strDate = dobDMY.split(".");
 		if (FormatOfDate=="dd/MM/yyyy")
 		{
 		dobDay=a_strDate[0];
 		dobMonth=a_strDate[1];
 		dobYear=a_strDate[2];
 		}
 		if (FormatOfDate=="dd-MM-yyyy")
 		{
 		dobDay=a_strDate[0];
 		dobMonth=a_strDate[1];
 		dobYear=a_strDate[2];
 		}
 		if (FormatOfDate=="MM/dd/yyyy")
 		{
 		dobDay=a_strDate[1];
 		dobMonth=a_strDate[0];
 		dobYear=a_strDate[2];
 		}
 		if (FormatOfDate=="MM-dd-yyyy")
 		{
 		dobDay=a_strDate[1];
 		dobMonth=a_strDate[0];
 		dobYear=a_strDate[2];
 		}
 	}
 	    var date = new Date(locDate);
 	    var thisYear = date.getYear() ;
             var thisMonth = date.getMonth()+1;
             var thisDay = date.getDate() ;
             var yearDiff = thisYear - dobYear ;
             var convType = document.all.CONV_CALENDAR_TYPE.value;
             if (convType == 'Hijri')
             {
             var ConvertedSeniorDate=SeniorDate(dobDay,dobMonth,dobYear);
             var a_strMajorDate=new Array();
 	    		if(ConvertedSeniorDate.indexOf("/") != -1)
 	    			a_strMajorDate = ConvertedSeniorDate.split("/");
 	    		if(ConvertedSeniorDate.indexOf("-") != -1)
 	    			a_strMajorDate = ConvertedSeniorDate.split("-");
 	    		if(ConvertedSeniorDate.indexOf(".") != -1)
 	    		a_strMajorDate = ConvertedSeniorDate.split(".");
 
 	    		DateFormat= getColorCookie('SRMDateFormat');
 	    		if (DateFormat=="dd/MM/yyyy")
 	    		{
 	    		dobMajorDay=a_strMajorDate[0];
 	    		dobMajorMonth=a_strMajorDate[1];
 	    		dobMajorYear=a_strMajorDate[2];
 	    		}
 	    		if (DateFormat=="dd-MM-yyyy")
 	    		{
 	    		dobMajorDay=a_strMajorDate[0];
 	    		dobMajorMonth=a_strMajorDate[1];
 	    		dobMajorYear=a_strMajorDate[2];
 	    		}
 	    		if (DateFormat=="MM/dd/yyyy")
 	    		{
 	    		dobMajorDay=a_strMajorDate[1];
 	    		dobMajorMonth=a_strMajorDate[0];
 	    		dobMajorYear=a_strMajorDate[2];
 	    		}
 	    		if (DateFormat=="MM-dd-yyyy")
 	    		{
 	    		dobMajorDay=a_strMajorDate[1];
 	    		dobMajorMonth=a_strMajorDate[0];
 	    		dobMajorYear=a_strMajorDate[2];
 			}
 
 			if ( dobMajorYear < thisYear)
 			{
 			return 'false';
 			}else if ( dobMajorYear > thisYear)
 			{
 			return 'true';
 			}else if ( dobMajorMonth > thisMonth){
 			return 'true';
 			}else if ( dobMajorMonth < thisMonth){
 			return 'false';
 			}else if ( dobMajorDay > thisDay){
 			return 'true';
 			}else {
 			return 'false';
 			}
             }else{
              if ( yearDiff < SENIOR_YEAR)
             {
                 return 'false';
             }else if ( yearDiff > SENIOR_YEAR)
             {
                 return 'true';
             }else if ( thisMonth > dobMonth){
                 return 'true';
             }
             else if ( thisMonth < dobMonth){
                 return 'false';
             }
             else if ( thisDay > dobDay){
                 return 'true';
             }else {
                 return 'false';
             }
         }
         }
 	 function SeniorDate(dobDay,dobMonth,dobYear){
 		try{
 			if(dobDay.length == 1)
 			{
 			 dobDay="0"+dobDay;
 			}
 			if(dobMonth.length == 1)
 			{
 			 dobMonth="0"+dobMonth;
  			}
  			var FormatOfDate = getColorCookie('SRMDateFormat');
  			var dobDMY;
  			if (FormatOfDate=="dd/MM/yyyy")
 			{
 			dobDMY=dobDay+"/"+dobMonth+"/"+dobYear;
 			}
 			if (FormatOfDate=="dd-MM-yyyy")
 			{
 			dobDMY=dobDay+"-"+dobMonth+"-"+dobYear;
 			}
 			if (FormatOfDate=="MM/dd/yyyy")
 			{
 			dobDMY=dobMonth+"/"+dobDay+"/"+dobYear;
 			}
 			if (FormatOfDate=="MM-dd-yyyy")
 			{
 			dobDMY=dobMonth+"-"+dobDay+"-"+dobYear;
 			}
 		   	var CONV_CALENDAR_TYPE = document.all.CONV_CALENDAR_TYPE.value;
 		    	var checkDateType=isGregDateWithoutConv(dobDMY);
 		    	if(checkDateType == 'true' && CONV_CALENDAR_TYPE == "Hijri")
 		    	{
 		    	 dobDMY=convertGregToHij(dobDMY);
 		    	}
 		    	if(checkDateType == 'false' && CONV_CALENDAR_TYPE == "Gregorian")
 		    	{
 		    	 dobDMY=convertHijToGreg(dobDMY);
 		    	}
 		    	var a_strDate=new Array();
 		    	if(dobDMY.indexOf("/") != -1)
 				a_strDate = dobDMY.split("/");
 			if(dobDMY.indexOf("-") != -1)
 				a_strDate = dobDMY.split("-");
 			if(dobDMY.indexOf(".") != -1)
 				a_strDate = dobDMY.split(".");
 		    	dobYear=a_strDate[2];
 			var SENIOR_YEAR = document.all.SENIOR_YEAR.value;
 			var seniorYear 	= parseInt(dobYear) + parseInt(SENIOR_YEAR);
 			 			var month =a_strDate[1];
 			 			var day=a_strDate[0];
 			 
 	 if  (!( ( seniorYear % 4 == 0 ) && ( ( seniorYear % 100 != 0 ) || ( seniorYear % 400 == 0 ) ) ))	{
 			 if ( (month == 2 ) &&  ( day == 29 )) {
 			
 			
 			 day=01;
 			 month=parseInt(month)+parseInt(1);
 			 
 			 }
 			 
  }
  a_strDate[0] = day;
  a_strDate[1] = month;
   			 // changes with TOL : 585289 starts
                 if  (( ( dobYear % 4 == 0 ) && ( ( dobYear % 100 != 0 ) || ( dobYear % 400 == 0 ) ) ) )
                 {
 
                           if ( (dobMonth == 2 ) &&  ( dobDay == 29 )) {
 
                          if(( (seniorYear % 4 == 0 ) &&  ( seniorYear % 100 != 0 )) || ( seniorYear % 400 == 0 ) )
                          {
                          a_strDate[0] = a_strDate[0];
                          a_strDate[1] = a_strDate[1];
                           }
                                 else{
                                 a_strDate[0]="0"+a_strDate[0];
                                 a_strDate[1]="0"+a_strDate[1];
                                 }
                          }
                 }
 
                                         /*
                                                 if(a_strDate[0].length == 1)
                                                 {
                                                  a_strDate[0]="0"+a_strDate[0];
                                                 }
                                                 if(a_strDate[1].length == 1)
                                                 {
                                                  a_strDate[1]="0"+a_strDate[1];
                                                 }
                                         */
                 // changes with TOL : 585289 ends

 			var seniorDate;
 			if (FormatOfDate=="dd/MM/yyyy" || FormatOfDate=="MM/dd/yyyy")
 			{
 			seniorDate=a_strDate[0]+"/"+a_strDate[1]+"/"+seniorYear;
 			}
 			if (FormatOfDate=="dd-MM-yyyy" || FormatOfDate=="MM-dd-yyyy")
 			{
 			seniorDate=a_strDate[0]+"-"+a_strDate[1]+"-"+seniorYear;
 			}
 			checkDateType=isGregDateWithoutConv(seniorDate);
 			if(checkDateType == 'false')
 			{
 			 document.frm2.seniorAttainSeniorDateHij.value=seniorDate;
 			 seniorDateGreg=convertHijToGreg(seniorDate);
 			 if(seniorDateGreg == seniorDate || seniorDateGreg == "")
 			 {
 			 	showMessage(MSGJ50645);
 			 	dobDMY=convertHijToGreg(dobDMY);
 			 	if(dobDMY.indexOf("/") != -1)
 					a_strDate = dobDMY.split("/");
 				if(dobDMY.indexOf("-") != -1)
 					a_strDate = dobDMY.split("-");
 				if(dobDMY.indexOf(".") != -1)
 					a_strDate = dobDMY.split(".");
 				dobYear=a_strDate[2];
 				seniorYear 	= parseInt(dobYear) + parseInt(SENIOR_YEAR);
 				 // changes with TOL : 585289 starts              

							   if  (( ( dobYear % 4 == 0 ) && ( ( dobYear % 100 != 0 ) || ( dobYear % 400 == 0 ) ) ) )
                 {
 
                           if ( (dobMonth == 2 ) &&  ( dobDay == 29 )) {
 
                          if(( (seniorYear % 4 == 0 ) &&  ( seniorYear % 100 != 0 )) || ( seniorYear % 400 == 0 ) )
                          {
                          a_strDate[0] = a_strDate[0];
                          a_strDate[1] = a_strDate[1];
                          }
                                 else{
                                 a_strDate[0]="0"+a_strDate[0];
                                 a_strDate[1]="0"+a_strDate[1];
                                 }
                          }
                 }
 
                                         /*
                                                 if(a_strDate[0].length == 1)
                                                 {
                                                  a_strDate[0]="0"+a_strDate[0];
                                                 }
                                                 if(a_strDate[1].length == 1)
                                                 {
                                                  a_strDate[1]="0"+a_strDate[1];
                                                 }
                                         */
                 // changes with TOL : 585289 ends

 				if (FormatOfDate=="dd/MM/yyyy" || FormatOfDate=="MM/dd/yyyy")
 				{
 				majorDate=a_strDate[0]+"/"+a_strDate[1]+"/"+seniorYear;
 				}
 				if (FormatOfDate=="dd-MM-yyyy" || FormatOfDate=="MM-dd-yyyy")
 				{
 				majorDate=a_strDate[0]+"-"+a_strDate[1]+"-"+seniorYear;
 				}
 			 }
 			 else
 			 {
 			 seniorDate = seniorDateGreg;
 			 }
 		}
 			return seniorDate;
 		}catch(e){
 		}
 	}
 //Senior Citizen Ends
 
 
 function call()
        {
            for (i=0; i < document.all.RecordSet.rows.length; i++) {
                var row_bgcolor=document.all.RecordSet.rows(i).className;
                 if ( row_bgcolor == 'rowHighLighted'){
                      if ( i % 2 == 0) {
                           document.all.RecordSet.rows(i).className = 'color1';
                      }
                      else{
                           document.all.RecordSet.rows(i).className = 'color2';
                      }
                 }
            }
            if(event.srcElement.tagName == 'FONT' || event.srcElement.tagName == 'INPUT') {
                event.srcElement.parentElement.parentElement.className="rowHighLighted";
            }
            else if(event.srcElement.tagName == 'TD'){
                event.srcElement.parentElement.className="rowHighLighted";
            }
}

 function clearAddressValues(){
		document.frm2.address_type.value= "";
		document.frm2.houseno.value= "";
		document.frm2.premiseno.value =  "";
		document.frm2.building.value =  "";
		document.frm2.country.value =  "";
		document.frm2.city.value =  "";
		document.frm2.state.value =  "";
		document.frm2.start_date.value =  "";
		document.frm2.zip.value =  "";
		document.frm2.end_date.value =  "";
		document.frm2.addrID.value =  "";
		document.frm2.AdrRemoved.value = "";
		document.frm2.streetno.value= "";
		document.frm2.town.value= "";
		document.frm2.locality.value= "";
		document.frm2.domicile.value= "";
		document.frm2.website.value= "";
		document.frm2.mailstop.value= "";
		document.frm2.streetname.value= "";
	        document.frm2.suburb.value= "";
		document.frm2.IsAddressProofRcvd.value= "";
		document.frm2.core_cust_id.value 	= "";
		document.frm2.salutation_code.value 	= "";
		document.frm2.country_code.value 	= "";
		document.frm2.state_code.value 		= "";
		document.frm2.city_code.value 		= "";
              	document.frm2.name.value 		= "";
		document.frm2.PreferredFormat.value = "";
		document.frm2.HoldMailReason.value = "";
		document.frm2.BusinessCenter.value = "";
		document.frm2.HoldMailInitiatedBy.value = "";
		document.frm2.HoldMailFlag.value = "";
		document.frm2.AddressLine1.value = "";
		document.frm2.AddressLine2.value = "";
		document.frm2.AddressLine3.value = "";
		document.frm2.FreeTextLabel.value = "";
    }
    function getCSVforArray(arr){
            retVal = "";
            tmpCnt = 0;
            noOfElems = arr.length;
            for(var i = 0; i < noOfElems; i++) {
                if(arr[i] != null) {
                    if(tmpCnt == 0) {
                        tmpCnt  = 1;
                        retVal = arr[i];
                    } else {
                        retVal = retVal + "," + arr[i];
                    }
                }
            }
            return retVal;
    }
	//The method is commented and changed back by recon. Recommenting the same
	/*
commented for IDENTIFICATION DOCUMENT CHANGES end*/
	// NRE Changes shanmuga in edit mode - End
//IDENTIFICATION DOCUMENT CHANGES start
	function checkPassport(){
		if(document.getElementsByName(boName+".CustomerNREFlg")[0].value == "Y")
		{
			if (accountURL!='')	//checking passport details for existing NREcustomer
			{
				if(document.getElementsByName("Passport Number.txt_ID")[0].value=="")
				{

				/* Change for tracker: 152724 */
				//changes done by vikas for tracker id: 260270 begins

				if(uniqueIDType != 'Passport Number' )
				{
                                 if( (uniqueIDType!="Passport Number") || (PassportId =='') || (PassportPlace =='')||(PassportIdate =='')){
					showMessage(MSGJ0059);
					return "false";
					}
				//changes done by vikas for tracker id: 260270 ends
				/* Tracker #153321 Changes BEGIN */
				}
				/* Tracker #153321 Changes END */
				}

				/* End of changes Tracker : 152724 */
			}
			else //checking passport details for new Entity
			{

					/*Tracker 136202 Changes */
					/*Ticket 277419 changes starts*/
					/* CRM102ST:TrackerID:168273 Being of Change */
					if(document.getElementsByName("Passport Number.txt_ID")[0].value=="")
					/* CRM102ST:TrackerID:168273 End of Change */
					/*Ticket 277419 changes ends*/
					{
						parent.parent.parent.parent.tabViewFrm.selectTabForID(0);
						parent.parent.parent.parent.messageFrm.removeMessages(selTabId);
						parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSGJ0059",""),parent.parent.IFrmtab0.formDispFrame.TBODY_EDocRecordSet.rows ,'NO_HLINK');
						parent.parent.parent.parent.messageFrm.showMessages(selTabId);
						parent.parent.IFrmtab0.formDispFrame.showTabFortabDemoForm('tpageCont5');
						parent.parent.IFrmtab0.formDispFrame.document.all.AddIdentificationDetails.focus();
						return "false";
					}
					/*Tracker 136202 Changes Ends */
			}
		}
	}
	
	
	
	function  clearLookup(type){
	if (type == "HsHld")	{
	}
	//tracker 84832 -begin
		if (type == "EmpID")	{
			document.getElementsByName("AccountBO.StaffEmployeeID")[0].value = "";
		}
	//tracker 84832 -end
	}
		function  fnBluropenEmployeeIDLookup(type)
		{
			var check = chkBlurFrom1();
			if(check)
			{
				var manager = "";
				var Type = "Employer";
				if(type == "StaffEmployeeID")
				{
					manager = document.getElementsByName("AccountBO.StaffEmployeeID")[0].value;
				}
				/* Ticket Id 209238 - Begin  */
				   if(manager == ""){
						return;
				    }
	  			/* Ticket Id 209238 - End  */
				TYPE = "StaffEmployeeID";
				var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
				var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?Manager='+manager+"&Type="+Type;
				s_xmlHttp.open("GET",strURL,false);
				s_xmlHttp.send();
				var lastName = '';
				if(s_xmlHttp.status == 200)
				{
					lastName = s_xmlHttp.responseXML.text;
					var neha = new Array();
					neha = lastName.split("^");
					if(neha=='False' || neha == 'false' ){
					showUserMessage(MSGJ50716,"");
					clearLookup("EmpID");
					}
				}
			}
			else{
				openEmployeeIDLookup();
			}
		}
	//Tracker id : 119498 end of changes
	// TRACKER ID : 50914 Added Function For Checking Customer is Minor or Not
	// TRACKER ID : 78625 validation for staff flag
	function validateStaff(obj1,obj2) {
		try{
			elem1 = document.getElementsByName(obj1)[0];
			elem2 = document.getElementsByName(obj2)[0];
			if((elem1.value== "EX-STAFF")||(elem1.value== "Ex-Staff")){
				document.getElementsByName(obj2)[0].selectedIndex = 2;
			    	elem2.disabled = true;
			} else {
		                elem2.disabled = false;
                              }
		//Staff Id validations for 10.2.13 
			disableStaffFieldConditionally("AccountBO.StaffFlag", "AccountBO.StaffEmployeeID");
			validateEmploymentProof();
		}catch(e){
                	}
	}
	//tracker 84832 -begin
		function  openEmployeeIDLookup()
		{
		var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=StaffEmployeeID&CategoryType=EMPLOYEE_ID";
		window.open (url, "Lookup", "height=436, left=70, top=120, width=860,resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
		}
		function onRecordSelectStaffEmp()
			{
			document.getElementsByName("AccountBO.StaffEmployeeID")[0].value = getCookie("LookupEmpID");
			document.getElementsByName("AccountBO.StaffEmployeeID")[0].fireEvent("onChange");
		}
	//tracker 84832 -end
var globalAddrDetails = new Array();
function sortList(recordSetName){

var temp = new Array();
temp=LastUpdate_Date.split(",");
	var addrDetails = new Array();
	var addressId = '';
	var deleteFlag = false;
	var previousRowDeleted = false;
	var previousAddressType = "";
	var noOfAddressCount = eval('document.all.'+recordSetName).rows.length;

			if(boName=='AccountBO'){
	for(k=0 ; k < noOfAddressCount ; k++)
	{
		addressType = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("AccountBO.Address.addressCategory"));
		arr_AddressType = new Array();
		arr_AddressType[0] = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("AccountBO.Address.AddressCategory"));
		arr_AddressType[1] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.house_no"));
		arr_AddressType[2] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.premise_name"));
		arr_AddressType[3] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.End_Date"));
		arr_AddressType[4] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.Start_Date"));
		arr_AddressType[5] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.city"));
		arr_AddressType[6] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.country"));
		arr_AddressType[7] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.state"));
		arr_AddressType[8] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.zip"));
		arr_AddressType[9] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.building_level"));
		addressId = document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.addressID");
		arr_AddressType[10]= trim(''+addressId);
		arr_AddressType[11] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.street_no"));
		arr_AddressType[12] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.locality_name"));
		arr_AddressType[13] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.town"));
		arr_AddressType[14] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.domicile"));
		arr_AddressType[15] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.street_name"));
		arr_AddressType[16] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.suburb"));
		arr_AddressType[17] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.City_code"));
		arr_AddressType[18] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.State_code"));
		arr_AddressType[19] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.Country_code"));
		arr_AddressType[20] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.PreferredFormat"));
		arr_AddressType[21] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.HoldMailReason"));
		arr_AddressType[22] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.BusinessCenter"));
		arr_AddressType[23] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.HoldMailInitiatedBy"));
		arr_AddressType[24] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.HoldMailFlag"));
		arr_AddressType[25] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.address_Line1"));
		arr_AddressType[26] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.address_Line2"));
		arr_AddressType[27] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.address_Line3"));
		arr_AddressType[28] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.FreeTextLabel"));
		arr_AddressType[29] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.mailStop"));
		arr_AddressType[30] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.URL"));
		arr_AddressType[31] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountBO.Address.city"));
		arr_AddressType[32] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountBO.Address.state"));
		arr_AddressType[33] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountBO.Address.country"));
		arr_AddressType[34] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.LastUpdate_Date"));
		arr_AddressType[35] ='N';
		arr_AddressType[36] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.IsAddressProofRcvd"));
 		arr_AddressType[37] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.Swift_Name"));

/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
 		arr_AddressType[42] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.IsAddressVerified"));
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
// AdressLine changes: END
		arr_AddressType[43] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountBO.Address.AddressCategory"));
// changes for Tracker ID 456637 - TOL ID 455246
		if(addressType != previousAddressType)
		{
			reOrder(addrDetails);
			previousAddressType = addressType;
			addrDetails = new Array();
			addrDetails[k] = arr_AddressType;
		}
		else
		{
			addrDetails[k] = arr_AddressType;
		}
		if((k+1) > noOfAddressCount-1)
		{
			reOrder(addrDetails);
		}
	}
            }
			else if(boName=='AccountModBO'){
	for(k=0 ; k < noOfAddressCount ; k++)
	{
		addressType = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("AccountModBO.Address.addressCategory"));
		arr_AddressType = new Array();
		arr_AddressType[0] = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("AccountModBO.Address.AddressCategory"));
		arr_AddressType[1] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.house_no"));
		arr_AddressType[2] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.premise_name"));
		arr_AddressType[3] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.End_Date"));
		arr_AddressType[4] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.Start_Date"));
		arr_AddressType[5] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.city"));
		arr_AddressType[6] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.country"));
		arr_AddressType[7] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.state"));
		arr_AddressType[8] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.zip"));
		arr_AddressType[9] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.building_level"));
		addressId = document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.addressID");
		arr_AddressType[10]= trim(''+addressId);
		arr_AddressType[11] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.street_no"));
		arr_AddressType[12] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.locality_name"));
		arr_AddressType[13] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.town"));
		arr_AddressType[14] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.domicile"));
		arr_AddressType[15] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.street_name"));
		arr_AddressType[16] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.suburb"));
		arr_AddressType[17] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.City_code"));
		arr_AddressType[18] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.State_code"));
		arr_AddressType[19] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.Country_code"));
		arr_AddressType[20] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.PreferredFormat"));
		arr_AddressType[21] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.HoldMailReason"));
		arr_AddressType[22] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.BusinessCenter"));
		arr_AddressType[23] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.HoldMailInitiatedBy"));
		arr_AddressType[24] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.HoldMailFlag"));
		arr_AddressType[25] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.address_Line1"));
		arr_AddressType[26] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.address_Line2"));
		arr_AddressType[27] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.address_Line3"));
		arr_AddressType[28] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.FreeTextLabel"));
		arr_AddressType[29] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.mailStop"));
		arr_AddressType[30] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.URL"));
		arr_AddressType[31] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountModBO.Address.city"));
		arr_AddressType[32] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountModBO.Address.state"));
		arr_AddressType[33] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountModBO.Address.country"));
		arr_AddressType[34] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.LastUpdate_Date"));
		arr_AddressType[35] ='N';
		arr_AddressType[36] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.IsAddressProofRcvd"));
 		arr_AddressType[37] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.Swift_Name"));

/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
 		arr_AddressType[42] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.IsAddressVerified"));
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
arr_AddressType[43] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountModBO.Address.AddressCategory"));
// changes for Tracker ID 456637 - TOL ID 455246
// AdressLine changes: END


		if(addressType != previousAddressType)
		{
			reOrder(addrDetails);
			previousAddressType = addressType;
			addrDetails = new Array();
			addrDetails[k] = arr_AddressType;
		}
		else
		{
			addrDetails[k] = arr_AddressType;
		}
		if((k+1) > noOfAddressCount-1)
		{
			reOrder(addrDetails);
		}
	}
            }

}
function reOrder(addrDetails)
{
	previousFilled = false;
	currentAddrFound = false;
	var date = getTodayDate();
	currentDate = changetoMillis(date);
	currentArrayLength = globalAddrDetails.length;
	if(addrDetails != null && addrDetails != '')
	{
		for(i=0 ; i < addrDetails.length; i++)
		{
			if(addrDetails[i] != null && addrDetails[i] != undefined)
			{
				tempArr = new Array(addrDetails[i]);
				if(tempArr[0][4] != 'null' && tempArr[0][4] != 'undefined')
				{
					dateFromList = changetoMillis(tempArr[0][4]);//getting Start Date from array
					endDateFromList = changetoMillis(tempArr[0][3]);//getting End Date from array
					if(dateFromList <= currentDate && endDateFromList >= currentDate && !currentAddrFound) //currentAddress is not found
					{
						if(!previousFilled)
						{
							globalAddrDetails[globalAddrDetails.length] = addrDetails[i];
						}
						else
						{
							globalAddrDetails[tempPos] = addrDetails[i];
						}
						previousFilled = true;
						currentAddrFound = true;
					}
					else
					{
						if(!previousFilled)
						{
							tempPos = globalAddrDetails.length;
							globalAddrDetails[globalAddrDetails.length] = '';
							globalAddrDetails[globalAddrDetails.length] = addrDetails[i];
						}
						else
						{
							globalAddrDetails[globalAddrDetails.length] = addrDetails[i];
						}
						previousFilled = true;
					}
				}
			}
		}
	}
}
function addAddressList()
{
	var currentAddressType = "";
	var clientCurrentDate = getTodayDate();
	clientCurrentDate = changetoMillis(clientCurrentDate);
	if(globalAddrDetails != '')
	{
	for(i=0; i < globalAddrDetails.length; i++)
	{
			if(globalAddrDetails[i] != 'undefined' && globalAddrDetails[i] != null && globalAddrDetails[i] != '')
		{
			addAddrDetails(globalAddrDetails[i],true);
				if(globalAddrDetails[i][0] != currentAddressType && changetoMillis(globalAddrDetails[i][4]) <= clientCurrentDate  && changetoMillis(globalAddrDetails[i][3]) >= clientCurrentDate)
				{
					/*if(document.all.RecordSet.rows(i+2) != undefined)
			{
                document.all.RecordSet.rows(i+2).className = 'color3';
				currentAddressType = globalAddrDetails[i][0];
			}
					else
					{
						document.all.RecordSet.rows(i+1).className = 'color3';
						currentAddressType = globalAddrDetails[i][0];
					}*/
				}
			}
		}//end of for
	}
}
function deleteList(recordSetName)
{
	var noOfAddressCount = document.all.RecordSet.rows.length;
			if(boName=='AccountBO'){
	for(k = noOfAddressCount-1 ; k > 1 ; k--)
	{
		addrCat = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.AddressCategory"));
		if(addrCat != null && addrCat != 'undefined')
		{
			document.all.RecordSet.deleteRow(k);
		}
	}
            }
			else if(boName=='AccountModBO'){
	for(k = noOfAddressCount-1 ; k > 1 ; k--)
	{
		addrCat = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.AddressCategory"));
		if(addrCat != null && addrCat != 'undefined')
		{
			document.all.RecordSet.deleteRow(k);
		}
	}
            }
}
	/* ***** Tracker# 97236 SMS Banking Mobile Number changes : Start ***** */
	
    /* ***** Tracker# 97236 SMS Banking Mobile Number changes : End ***** */
	function isTFPartyFlag(){
		var tfpFlg = document.getElementsByName(boName+".TFPartyFlag")[0].value;
    		//Changes made for TradeFinance tab to load on demand in view mode
		if(readMode!='Y') {
		parent.parent.parent.parent.frames(0).selectTab("Trade Finance");
		}
		var tabID =parent.parent.parent.parent.frames(0).getSelectedTabId();
	        if((tfpFlg == 'N' || tfpFlg == '') && tabID != 'tab0' ){
			eval("parent.parent.parent.parent.tabViewFrm." + tabID + ".style.display = 'none';");
		}
 	        else{
			eval("parent.parent.parent.parent.tabViewFrm." + tabID + ".style.display = '';");
		}
		parent.parent.parent.parent.frames(0).selectTab("General");
		document.frm2.TfFlag.value = tfpFlg;
	}

// Changes for call id 417355 starts here
function checkSalutation(check,boName){

                if(boName == 'ContactBO'){
	        var Salutation = document.getElementsByName(boName+".Salutation")[0].value;
	        }
	        else{
	        boName= document.frm2.boName.value;
	        var Salutation = document.getElementsByName(boName+".Salutation_code")[0].value;
	        }

		var gender = document.getElementsByName(boName+".Gender")[0].value;
// Changes for call id // Changes for call id 417355 ends here			
		<!-- Changes for Call Id 355758 and Recon For Tracker id 391911 Starts -->
		var Salutation = document.getElementsByName(boName+".Salutation_code")[0].value;
		<!-- Changes for Call Id 355758 and Recon For Tracker id 391911 Ends -->
		var found = "false";
		if(gender != '' && Salutation != '' && gender == 'F'){
			for(i=0;i<Male.length;i++){
				if(Male[i].toUpperCase() == Salutation.toUpperCase()){
					found = "true";
					break;
				}
			}
		}
		if(gender != '' && Salutation != '' && gender == 'M'){
			for(i=0;i<Female.length;i++){
				if(Female[i].toUpperCase() == Salutation.toUpperCase()){
					found = "true";
					break;
				}
			}
		}
		if(found == "true"){
			showMessage(MSG_GEN_SAL);
			if(check == 'S'){
				document.getElementsByName(boName+".Salutation")[0].value="";
			}else{
				document.getElementsByName(boName+".Gender")[0].value="";
			}
		}
}
//IDENTIFICATION DOCUMENT CHANGES TRACKER ID 321176 start
//Tracker id : 253845   starts
		function loadID()
		{
			try
			{
				customLoad();
			}
			catch(e)
			{}
			if(document.frm2.hid_accountURL.value != '' ||convToCust=='Y')
			{
				editMode = true;
				if("EntityDocumentBO"==entityDocumentBO_Name){
					for (i=2; i < document.all.EDocRecordSet.rows.length; i++)
					{
						var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.EntityDocumentID");
						// Chanegs for ticket id 206326 start
						if(EntityDocumentID == null && convToCust!='Y')
						{
						 entityDocumentBO_Name='EntityDocumentModBO';
						 var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.EntityDocumentID");
						 }
						 // Chanegs for ticket id 206326 end
						if (((EntityDocumentID != null) && (EntityDocumentID != 'undefined'))||convToCust=='Y' )
						//Tracker id : 253845   ends
						{
							identifier_type_Code			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IdentificationType"));
							unique_id 						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.ReferenceNumber"));
							placeofissue 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.PlaceOfIssue"));
							placeofissue_cat 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentBO.PlaceOfIssue"));
							countryofissue 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.CountryOfIssue"));
							countryofissue_cat 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentBO.CountryOfIssue"));
							dateofissue  					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocIssueDate"));
							validity_date 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocExpiryDate"));
							EntityDocumentID 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.EntityDocumentID"));
							EntityDocumentURL 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.url_"));
							isPreferredUniqueID				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.PreferredUniqueId"));
							docCode							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocCode"));
							docDescr						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocDescr"));
							docTypeCode						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocTypeCode"));
							docTypeDescr					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocTypeDescr"));
							docReceivedDate					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocReceivedDate"));
							docRemarks						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocRemarks"));
							status							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.Status"));
							isMandatory						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IsMandatory"));
							//Ticket Id 202790 - Begin
							isDocumentVerified	 			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.isDocumentVerified"));
							//Ticket Id 202790 - Begin

							//Fix for 296370
							IDIssuedOrg	 			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IDIssuedOrganisation"));

							scanRequired					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.ScanRequired"));
							EDoc_identifier_type_Code[i-2] 	= identifier_type_Code;
							EDoc_docCode[i-2] 		= docCode;
							EDoc_docDescr[i-2] 		= docDescr;
							EDoc_docTypeCode[i-2] 		= docTypeCode;
							EDoc_docTypeDescr[i-2] 		= docTypeDescr;
							EDoc_docReceivedDate[i-2] 	= docReceivedDate;
							EDoc_docRemarks[i-2]		= docRemarks;
							EDoc_Status[i-2] 		= status;
							EDoc_isMandatory[i-2] 		= isMandatory;
							//Ticket Id 202790 - Begin
							EDoc_isDocumentVerified[i-2] 	= isDocumentVerified;
							//Ticket Id 202790 - End
							EDoc_scanRequired[i-2] 		= scanRequired;
							EDoc_unique_id[i-2] 		= unique_id;
							EDoc_placeofissue[i-2] 		= placeofissue;
							EDoc_countryofissue[i-2] 	= countryofissue;
							EDoc_placeofissue_cat[i-2] 	= placeofissue_cat;
							EDoc_countryofissue_cat[i-2] 	= countryofissue_cat;
							EDoc_dateofissue[i-2] 		= dateofissue;
							EDoc_validity_date[i-2] 	= validity_date;
							EDoc_EntityDocumentID[i-2] 	= EntityDocumentID;
							EDoc_EntityDocumentURL[i-2] 	= EntityDocumentURL;
							EDoc_URL[i-2] 			= identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue;
							//Tracker id : 253845   starts
							if(convToCust!='Y')
							{
							EDoc_IsDirty[i-2] 				= 'N';
							}else
							{
							EDoc_EntityDocumentID[i-2] 		= "";
							EDoc_EntityDocumentURL[i-2] 	= null;
							EDoc_IsDirty[i-2] 				= 'Y';
							}
							//Tracker id : 253845   ends
							//Fix for 296370
							EDoc_idIssuedOrg[i-2]		= IDIssuedOrg;

							document.all.EDocRecordSet.rows(i).setAttribute("EntityDocumentBO.url", identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue);
							if (isPreferredUniqueID == "Y"){
										document.all.EDocRecordSet.rows(i).
												childNodes(0).innerHTML="<INPUT TYPE='radio' name='radio1' onClick='AddSelectedRowToList()' CHECKED>";
												uniqueID =trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.ReferenceNumber"));
												uniqueIDType=trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IdentificationType"));
												/*tracker Id: 166086 Changes Begin */
                                                document.frm2.hidUniqueID.value = uniqueID;
												/*tracker Id: 166086 Changes End */
						/*210879 changes start*/
						document.frm2.hidUniqueIDType.value = uniqueIDType;
                                                /*210879 changes end*/

				}
							var objHidUniqueID=document.getElementsByName(identifier_type_Code + ".txt_ID")[0];
							if(objHidUniqueID!=null)
							{
								objHidUniqueID.value=unique_id;
							}
							var objHidIssueDate=document.getElementsByName(identifier_type_Code + ".txt_Issue_Date")[0];
							if(objHidIssueDate!=null)
							{
								objHidIssueDate.value=dateofissue;
							}
							var objHidValidDate=document.getElementsByName(identifier_type_Code + ".txt_Valid_Date")[0];
							if(objHidValidDate!=null)
							{
								objHidValidDate.value=validity_date;
							}

							var objHidIssuePlace=document.getElementsByName(identifier_type_Code + ".txt_Issue_Place")[0];
							if(objHidIssuePlace!=null)
							{
								objHidIssuePlace.value=placeofissue;
							}
						}
					}
				}else if("EntityDocumentModBO"==entityDocumentBO_Name){
					for (i=2; i < document.all.EDocRecordSet.rows.length; i++)
					{
						var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.EntityDocumentID");
						// Chanegs for ticket id 206326 start
						if(EntityDocumentID == null)
						{
						 entityDocumentBO_Name='EntityDocumentModBO';
						 var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.EntityDocumentID");
						 }
						 // Chanegs for ticket id 206326 end
						if ((EntityDocumentID != null) && (EntityDocumentID != 'undefined'))
						{
							identifier_type_Code			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IdentificationType"));
							unique_id 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.ReferenceNumber"));
							placeofissue 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.PlaceOfIssue"));
							placeofissue_cat 			= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentModBO.PlaceOfIssue"));
							countryofissue 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.CountryOfIssue"));
							countryofissue_cat 			= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentModBO.CountryOfIssue"));
							dateofissue  				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocIssueDate"));
							validity_date 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocExpiryDate"));
							EntityDocumentID 			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.EntityDocumentID"));
							EntityDocumentURL 			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.url_"));
							isPreferredUniqueID			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.PreferredUniqueId"));
							docCode					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocCode"));
							docDescr				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocDescr"));
							docTypeCode				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocTypeCode"));
							docTypeDescr				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocTypeDescr"));
							docReceivedDate				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocReceivedDate"));
							docRemarks				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocRemarks"));
							status					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.Status"));
							isMandatory				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IsMandatory"));
							//Ticket Id 202790 - Begin
							isDocumentVerified	 		= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.isDocumentVerified"));
							//Ticket Id 202790 - Begin
							scanRequired				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.ScanRequired"));
							IDIssuedOrg	 			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IDIssuedOrganisation"));
							EDoc_identifier_type_Code[i-2] 	        = identifier_type_Code;
							EDoc_docCode[i-2] 			= docCode;
							EDoc_docDescr[i-2] 			= docDescr;
							EDoc_docTypeCode[i-2] 			= docTypeCode;
							EDoc_docTypeDescr[i-2] 			= docTypeDescr;
							EDoc_docReceivedDate[i-2] 		= docReceivedDate;
							EDoc_docRemarks[i-2]		 	= docRemarks;
							EDoc_Status[i-2] 			= status;
							EDoc_isMandatory[i-2] 			= isMandatory;
							//Ticket Id 202790 - Begin
							EDoc_isDocumentVerified[i-2] 		= isDocumentVerified;
							//Ticket Id 202790 - End
							EDoc_scanRequired[i-2] 			= scanRequired;
							EDoc_unique_id[i-2] 			= unique_id;
							EDoc_placeofissue[i-2] 			= placeofissue;
							EDoc_countryofissue[i-2] 		= countryofissue;
							EDoc_placeofissue_cat[i-2] 		= placeofissue_cat;
							EDoc_countryofissue_cat[i-2] 		= countryofissue_cat;
							EDoc_dateofissue[i-2] 			= dateofissue;
							EDoc_validity_date[i-2] 		= validity_date;
							EDoc_EntityDocumentID[i-2] 		= EntityDocumentID;
							EDoc_EntityDocumentURL[i-2] 		= EntityDocumentURL;
							EDoc_URL[i-2] 				= identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue;
							EDoc_IsDirty[i-2] 			= 'N';
							EDoc_idIssuedOrg[i-2]			= IDIssuedOrg;


							document.all.EDocRecordSet.rows(i).setAttribute("EntityDocumentModBO.url", identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue);
							if (isPreferredUniqueID == "Y"){
										document.all.EDocRecordSet.rows(i).
												childNodes(0).innerHTML="<INPUT TYPE='radio' name='radio1' onClick='AddSelectedRowToList()' CHECKED>";
												uniqueID =trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.ReferenceNumber"));
												uniqueIDType=trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IdentificationType"));
												/*tracker Id: 166086 Changes Begin */
                                                document.frm2.hidUniqueID.value = uniqueID;
												/*tracker Id: 166086 Changes End */
						/*210879 Changes starts*/
						document.frm2.hidUniqueIDType.value = uniqueIDType;						
						/*210879 Changes ends*/

				}
							var objHidUniqueID=document.getElementsByName(identifier_type_Code + ".txt_ID")[0];
							if(objHidUniqueID!=null)
							{
								objHidUniqueID.value=unique_id;
							}
							var objHidIssueDate=document.getElementsByName(identifier_type_Code + ".txt_Issue_Date")[0];
							if(objHidIssueDate!=null)
							{
								objHidIssueDate.value=dateofissue;
							}
							var objHidValidDate=document.getElementsByName(identifier_type_Code + ".txt_Valid_Date")[0];
							if(objHidValidDate!=null)
							{
								objHidValidDate.value=validity_date;
							}

							var objHidIssuePlace=document.getElementsByName(identifier_type_Code + ".txt_Issue_Place")[0];
							if(objHidIssuePlace!=null)
							{
								objHidIssuePlace.value=placeofissue;
							}
						}
					}
				}
			}
		}
//IDENTIFICATION DOCUMENT CHANGES TRACKER ID 321176 end

function fnCheckNreStatus() {
	if(document.getElementsByName(boName+".CustomerNREFlg")[0].value == "N") {
		document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0].value='';
		document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0].disabled = true;
	}
}
// Changes for call id 417355 starts here 
function changeGender(boName) {
	<!-- Changes for Call Id 355758 Starts -->
	
	if(boName == 'ContactBO'){
	var salutation = document.getElementsByName(boName+".Salutation")[0].value;
	}
	else{
	boName= document.frm2.boName.value;
	var salutation = document.getElementsByName(boName+".Salutation_code")[0].value;
	}
	
// Changes for call id 417355 ends here 
	
	<!-- Changes for Call Id 355758 Ends -->
	 salutation = salutation.toLowerCase();
	if (salutation == 'mr.' ) {
		document.getElementsByName(boName+".Gender")[0].value ='M';
	}
	else if (salutation == 'mrs.' ||salutation == 'ms.') {
		document.getElementsByName(boName+".Gender")[0].value ='F';
	}
	/* Changes for the Tracker id:299800 and Ticket Id:490796 begins */
	/* else {
		document.getElementsByName(boName+".Gender")[0].value ='';
	} */
	/* Changes for the Tracker id:299800 and Ticket Id:490796 ends */
}
function defaultResCtry(AddrDetails) {
try {
	var type = AddrDetails[0];
	var format = AddrDetails[20];
	try {
	resiCtry=parent.parent.IFrmtab1.formDispFrame.document.getElementsByName('DemographicBO.Residence_Country')[0].value;
	}
	catch (ex) {
		return;
	}
	if (type == 'Mailing' && format =='STRUCTURED_FORMAT' && (resiCtry!=''|| resiCtry!=null)) {

		var start_date= AddrDetails[4];
		var todaydate = new String();
	       	todaydate.value = getTodayDate();
		var millistartdate1 = changetoMillis(start_date);
		var millistartdate2 = changetoMillis(todaydate.value);
		if (millistartdate1 <= millistartdate2)
		{
			var ctry=AddrDetails[6];
			var ctry_code= AddrDetails[40];
			parent.parent.IFrmtab1.formDispFrame.document.getElementsByName('DemographicBO.Residence_Country')[0].value =ctry;
			parent.parent.IFrmtab1.formDispFrame.document.getElementsByName('Cat_DemographicBO.Residence_Country')[0].value = ctry_code;
		}
	}
}
catch (e) {
	}
}
	function validateDOB(){
		var todaydate = new String();
		/*Fix for Tracker #: SIDDHARTH Begins*/
		todaydate.value =  getTodayDate1(locDate);
		/*Fix for Tracker #: SIDDHARTH Ends*/
		/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
		/* calling the function isGregDate for on blur functionality*/
		isGregDate("3_AccountBO.Cust_DOB");
		var date = document.getElementsByName("3_AccountBO.Cust_DOB")[0];
		if (date.value != '')
		{
		todaydate.value = convertDate(todaydate.value);
		/*ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/
		}
		var elem1 = document.getElementsByName("3_AccountBO.Cust_DOB")[0];
		var mill1 = changetoMillis(todaydate.value);
	        var mill2 = changetoMillis(elem1.value);
		if (mill1 < mill2){
			showMessage(MSGX0060);
			document.getElementsByName("3_AccountBO.Cust_DOB")[0].value='';
			/*Changes done for ticket:366838 Starts*/
			document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].value='';
			/*Changes done for ticket:366838 Starts*/
			document.getElementsByName("3_AccountBO.Cust_DOB")[0].focus();
			return;
		}
	}
function onRecordSelectCIFID(reservedID) {
	document.getElementsByName("AccountBO.AccountKey")[0].value=reservedID;
	document.getElementsByName("hid_reservestatus")[0].value = "Lookup";
	reserveCIFID = reservedID;
}
function checkStatus(elename,keyGeneration) {
try {
	var elemValue = document.getElementsByName(elename)[0].value;
	if (elemValue =="" || reserveCIFID == elemValue|| keyGeneration== 'Reserved'||keyGeneration=="") {
		return;
	}
	else {
		checkReseravtion(elename,'Retail',keyGeneration);
	}
}
catch (e) {

}
}
//KYC Changes Start
function onReferChange()
{

//deleteCookie('sOverAllStatus');
  var sOverAllStatus='Approve';
  var Status=document.getElementsByName("changedStatus")[0].value;

  setCookie('sOverAllStatus',sOverAllStatus,"");
   try{
   
  if(Status!=sOverAllStatus){
  document.getElementsByName("mandStar")[0].style.visibility = "visible";
  }
  else{
  document.getElementsByName("mandStar")[0].style.visibility = "hidden";
  }
  }catch(e){}
 }
//KYC Changes End

//change sfor TOL 561329
function setCurrencyArraysOnConvToCust(){
	//if(convToCust=='Y'){
	try{
		for (i=2; i <= document.all.CurrencyDetRecordSet.rows.length; i++){

				var miscCurrInfoID =document.all.CurrencyDetRecordSet.rows(i).getAttribute("PsychographicBO.MiscellaneousInfo.MiscellaneousID");
				if (miscCurrInfoID != null)
				{
							CustomerCurrency			= trim(document.all.CurrencyDetRecordSet.rows(i).getAttribute("PsychographicBO.MiscellaneousInfo.strText10"));
							CreditDiscountPercent = trim(document.all.CurrencyDetRecordSet.rows(i).getAttribute("PsychographicBO.MiscellaneousInfo.dbFloat1"));
							DebitDiscountPercent = trim(document.all.CurrencyDetRecordSet.rows(i).getAttribute("PsychographicBO.MiscellaneousInfo.dbFloat2"));
							WithholdTaxPcnt = trim(document.all.CurrencyDetRecordSet.rows(i).getAttribute("PsychographicBO.MiscellaneousInfo.dbFloat3"));
							WithholdTaxFloorLmt = trim(document.all.CurrencyDetRecordSet.rows(i).getAttribute("PsychographicBO.MiscellaneousInfo.dbFloat4"));
							PreferentialExpiryDate = trim(document.all.CurrencyDetRecordSet.rows(i).getAttribute("PsychographicBO.MiscellaneousInfo.dtDate1"));
							CurrPsychoURL[i-2]             		= miscCurrInfoID;
	                        CU_CustomerCurrency[i-2]         	= CustomerCurrency;
	      	                CU_CreditDiscountPercent[i-2]      	= CreditDiscountPercent;
	      	                CU_DebitDiscountPercent[i-2]       	= DebitDiscountPercent;
	      	                CU_WithholdTaxPcnt[i-2]       	        = WithholdTaxPcnt;
	      	                CU_WithholdTaxFloorLmt[i-2]       	= WithholdTaxFloorLmt;
	      	                CU_PreferentialExpiryDate[i-2]          = PreferentialExpiryDate;
				}

		}

	}catch(e){
	}


	//}



}   //change sfor TOL 561329
																					 

/*Changes for call id 406431*/
function saveAddress(blFlag)
{
			if(document.getElementsByName("PsychographicBO.Preferred_Locale")[0]!=null)
		{		
			document.frm2.hid_preflocale.value = document.getElementsByName("PsychographicBO.Preferred_Locale")[0].value;
		}
		var object = eval("parent.parent.IFrmtab5");
		var object1= eval("parent.parent.IFrmtab4");
		var opertype=document.frm2.operationType.value;
		if(object!=undefined && object1!=undefined && tfpFlg=='N')
		{
			parent.parent.IFrmtab4.formSaveFrame.executionStatus='SUCCESS';                 
		}
		if((opertype=='null' || opertype=='') && (isBasel=='Y' || (document.getElementsByName("BaselProfiling")[0] != undefined && document.getElementsByName("BaselProfiling")[0].options.value == 'Yes'))){
		   if(object == null ||  object == "undefined")
		{	
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserErrorMessage("MSGJ51930",""), "", 'NO_HLINK');
		    parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		    return "interactive";
		}
		}
		var notExistType = new Array();
		if(boName=='AccountBO')
		{
			for(var k = 0; k < delAddrtypes.length; k++)
			{
				for (i=0; i < document.all.RecordSet.rows.length ; i++)
				{
					var existType = document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.addressCategory");
					if(delAddrtypes[k] == existType)
					{
					 	delAddrtypes[k] = 'XXX';
					 	break;
					}
				}
			}
         }
		else if(boName=='AccountModBO')
		{
			for(var k = 0; k < delAddrtypes.length; k++)
			{
				for (i=0; i < document.all.RecordSet.rows.length ; i++)
				{
					var existType = document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.addressCategory");
					if(delAddrtypes[k] == existType)
					{
					 	delAddrtypes[k] = 'XXX';
					 	break;
					}
				}
			}
		}
		for(var k = 0; k < delAddrtypes.length; k++)
		{
			if(delAddrtypes[k] != 'XXX')
			{
				showUserMessage('MSGJ50218',delAddrtypes[k]);
				return "interactive";
		 	}
		}
		if(defAddress == "M")
			defAddress = "Mailing";
		else if(defAddress == "H")
			defAddress = "Home";
		else if(defAddress == "W")
			defAddress = "Work";
			
		if(blFlag == true) 
		{
	       	noValidationMsg = false;
	    }
		else 
		{
			noValidationMsg = true;
		}
		/*if(document.getElementsByName("AccountBO.ACCOUNTKEY")[0].value == "")
		{
			if(document.all.isAutoGenKey.value == 'true') 
			{
				document.getElementsByName("AccountBO.ACCOUNTKEY")[0].IsMandatory = 'N';
			}
		}*/
		var chkStat = "true";
		if (chkStat != "true") 
		{
			  return 'interactive';
		}
		 /****************************************************/
//cif address changes --> start
/****************************************************/
            var mailingad;// = false;
			var otherAdd;
            noOfEdu = edu_URL.length;
			//CIF PhoneEmail Changes : Start
			noOfPhoneEmail = phoneEmail_URL.length;
			//CIF PhoneEmail Changes : End
      	    //NRE Relative Changes -Begin
            var NRERel;// = false;
            //NRE Relative Changes -End
            //CIF Changes for NRE - Begin
	       var isNRE;// = true;
	       /*if(document.getElementsByName(boName+".CustomerNREFlg")[0].value == "Y" ){
		   alert('1111');
		isNRE = true;
	       }
	       else{
		isNRE = false;
	       }*/
            /*chkadres = document.all.RecordSet.rows.length;
            if(blFlag == true)
            {
            if(chkadres == 2 && isNRE == true){
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CONTACT_DEFID",""),TBODY_RecordSet.rows ,'NO_HLINK');
		//changes for 258713 starts
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_NREREL",""),TBODY_RecordSet.rows ,'NO_HLINK');
		//changes for 258713 ends
		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		return "interactive"
            }
	    }
		alert('3');*/
        if(noOfEdu > 0) {
			for(var x = 0; x < noOfEdu ; x++) {
				if((ad_address_type[x]) != "Mailing") {
					mailingad = false;
				}
				else {
					mailingad = true;
					break;
				}
			}
		}
		else
			mailingad = false;
			
		if(defAddress != "Mailing" && defAddress!= "" && noOfEdu > 0) {
			for(var x = 0; x < noOfEdu ; x++) {
				if((ad_address_type[x]) != defAddress)
					otherAdd = false;
				else {
					otherAdd = true;
					break;
				}
			}
		}
		/*if(isNRE ==true){
			if(noOfEdu > 0) {
				for(var x = 0; x < noOfEdu ; x++) {
					if((ad_address_type[x]) != "NRERelative") {
						NRERel = false;
					}
					else {
						NRERel = true;
						break;
					}
				}
			}
			else
				NRERel = false;
		}
	    else{
	for(var x = 0; x < noOfEdu ; x++) {
		if(blFlag==true)
		{
	 if((ad_address_type[x]) == "NRERelative") {
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_NREREL1",""),TBODY_RecordSet.rows ,'NO_HLINK');
		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		return "interactive"
	   	 }
		}
	   	}
	   	}*/
		if(blFlag==true)
		{
	    if(mailingad == false){
		//changes for callId 686015 starts
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSGJ51806",defAddress_Value),TBODY_RecordSet.rows ,'NO_HLINK');
			//changes for callId 686015 ends
			 parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			 return "interactive"
		}
		//changes for 258713 starts
		/*if(NRERel == false && isNRE == true){
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_NREREL",""),TBODY_RecordSet.rows ,'NO_HLINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
		}*/
		//changes for 258713 ends
		if(otherAdd == false && defAddress != "Mailing") {
			if(defAddress == "Home")
			{
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG_HOME_ADD",""),TBODY_RecordSet.rows ,'NO_HLINK');
			}/* ***** Ticket# 337931  : Start ******/
			else if(defAddress == "Work")
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG_WORK_ADD",""),TBODY_RecordSet.rows ,'NO_HLINK');
			else
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ51806","defAddress"),TBODY_RecordSet.rows ,'NO_HLINK');
			/* ***** Ticket# 337931  : end ******/
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
		}
		}
	   /* ***** Tracker# 97236 SMS Banking Mobile Number changes : Start ***** */
       /*var SMSBankingMobileNumber = document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0];
       var SMSBankingNo = SMSBankingMobileNumber.value;
       SMSBankingNo = trim(SMSBankingNo);
	   */
  	   /* ***** Tracker# 97236 SMS Banking Mobile Number changes : End ***** */
		try{
		var startdate  = new Array();
		var index      = new Array();
		/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		var mobileNo   = new Array();
		/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Mailing") && !(edu_Status[k] == "Remove")) {
		startdate[z] = ad_start_date[k];
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		mobileNo[z] = ad_cellno_local[k];
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		index[z] = k;
		z++;
		}
		}
		noOfaddress = startdate.length;
		if( noOfaddress >1){
		for ( var i = (noOfaddress - 1); i >= 0; i-- )
		{
		for (var j = 1; j <= i; j++)
		{
		var millistartdate1 = changetoMillis(startdate[j-1]);
		var millistartdate2 = changetoMillis(startdate[j]);
		if (millistartdate1 > millistartdate2)
		{
		var temp = startdate[j-1];
		startdate[j-1] = startdate[j];
		startdate[j] = temp;
		var temp1 = index[j-1];
		index[j-1] = index[j];
		index[j] = temp1;
		}
		}
		}
		}
		for(var k = 0; k < noOfaddress ; k++) {
		findex = index[k];
		if(!(startdate[k+1]) == ''){
		ad_end_date[findex] = address_enddate(startdate[k+1]);
		}
		else{
        // Fix for Multi addresses issue
		//Call id 346606 and 348767 change start
		//ad_end_date[findex] = "31/12/2099";
		ad_end_date[findex] =getEndDate1();
		//Call id 346606 and 348767 change end
//changes for ticket 635409 start
		var cc = document.frm2.streetno.value;
		if(cc == '' || cc == null)
		{
		ad_end_date[findex] = "";
		}
		//ad_end_date[findex] = "";
//changes for ticket 635409
		}
		}
		}
		catch(e)
		{}
		noOfmailingaddress = startdate.length;
		var currentCount = 0;
		var todaydate = new String();
		/*Fix for Tracker #: SIDDHARTH Starts*/
		todaydate.value = getTodayDate1(locDate);
		/*Fix for Tracker #: SIDDHARTH Ends*/
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		var currMailIndex = 0;
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		for(var k = 0; k < noOfmailingaddress ; k++)
		{
			var millistartdate1 = changetoMillis(startdate[k]);
			var millistartdate2 = changetoMillis(todaydate.value);
			if (millistartdate1 <= millistartdate2)
			{
			currentCount=currentCount+1;
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
			if(defAddress=="Mailing")
			{
				currDefAddrMobile = mobileNo[k];
			}
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
			}
		}
		if(blFlag==true)
		{
		if (currentCount == 0)
		{
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG_MAIL_CURR_ADD",""),TBODY_RecordSet.rows ,'NO_HLINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
		}
		}
		try{
		var startdate1  = new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		var mobileNo1   = new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		var index1      = new Array();
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Home") && !(edu_Status[k] == "Remove")) {
		startdate1[z] = ad_start_date[k];
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		mobileNo1[z]  = ad_cellno_local[k];
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		index1[z] = k;
		z++;
		}
		}
		noOfaddress = startdate1.length;
		if( noOfaddress >1){
		for ( var i = (noOfaddress - 1); i >= 0; i-- )
		{
		for (var j = 1; j <= i; j++)
		{
		var millistartdate1 = changetoMillis(startdate1[j-1]);
		var millistartdate2 = changetoMillis(startdate1[j]);
		if (millistartdate1 > millistartdate2)
		{
		var temp = startdate1[j-1];
		startdate1[j-1] = startdate1[j];
		startdate1[j] = temp;
		var temp1 = index1[j-1];
		index1[j-1] = index1[j];
		index1[j] = temp1;
		}
		}
		}
		}
		for(var k = 0; k < noOfaddress ; k++) {
		findex = index1[k];
		if(!(startdate1[k+1]) == ''){
		ad_end_date[findex] = address_enddate(startdate1[k+1]);
		}
		else{
        // Fix for Multi addresses issue
		//Call id 346606 and 348767 change start
		//ad_end_date[findex] = "31/12/2099";
		ad_end_date[findex] =getEndDate1();
		//Call id 346606 and 348767 change end
		//ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		if(defAddress=="Home")
		{
			var noOfHomeAddress = startdate1.length;
			currentCount = 0;
			todaydate = new String();
			todaydate.value = getTodayDate1(locDate);
			currMailIndex = 0;
			for(var k = 0; k < noOfHomeAddress ; k++)
			{
				var millistartdate1 = changetoMillis(startdate1[k]);
				var millistartdate2 = changetoMillis(todaydate.value);
				if (millistartdate1 <= millistartdate2)
				{
					currentCount=currentCount+1;
 					currDefAddrMobile = mobileNo1[k];
 				}
			}
		}
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		try{
		var startdate2  = new Array();
		var index2      = new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		var mobileNo2	= new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Work") && !(edu_Status[k] == "Remove")) {
		startdate2[z] = ad_start_date[k];
		index2[z] = k;
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		mobileNo2[z]=ad_cellno_local[k];
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		z++;
		}
		}
		noOfaddress = startdate2.length;
		if( noOfaddress >1){
		for ( var i = (noOfaddress - 1); i >= 0; i-- )
		{
		for (var j = 1; j <= i; j++)
		{
		var millistartdate1 = changetoMillis(startdate2[j-1]);
		var millistartdate2 = changetoMillis(startdate2[j]);
		if (millistartdate1 > millistartdate2)
		{
		var temp = startdate2[j-1];
		startdate2[j-1] = startdate2[j];
		startdate2[j] = temp;
		var temp1 = index2[j-1];
		index2[j-1] = index2[j];
		index2[j] = temp1;
		}
		}
		}
		}
		for(var k = 0; k < noOfaddress ; k++) {
		findex = index2[k];
		if(!(startdate2[k+1]) == ''){
		ad_end_date[findex] = address_enddate(startdate2[k+1]);
		}
		else{
        // Fix for Multi addresses issue
		//Call id 346606 and 348767 change start
		//ad_end_date[findex] = "31/12/2099";
		ad_end_date[findex] =getEndDate1();
		//Call id 346606 and 348767 change end
		//ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		if(defAddress=="Work")
		{
 			var noOfWorkAddress = startdate2.length;
			var currentCount = 0;
			var todaydate = new String();

			todaydate.value = getTodayDate1(locDate);
			var currMailIndex = 0;
 			for(var k = 0; k < noOfWorkAddress ; k++)
			{
				var millistartdate1 = changetoMillis(startdate2[k]);
				var millistartdate2 = changetoMillis(todaydate.value);
				if (millistartdate1 <= millistartdate2)
				{
				    currentCount=currentCount+1;
 					currDefAddrMobile = mobileNo2[k];
 				}
			}
		}
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		try{
		var startdate3  = new Array();
		var index3      = new Array();
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Future/OnSite") && !(edu_Status[k] == "Remove")) {
		startdate3[z] = ad_start_date[k];
		index3[z] = k;
		z++;
		}
		}
		noOfaddress = startdate3.length;
		if( noOfaddress >1){
		for ( var i = (noOfaddress - 1); i >= 0; i-- )
		{
		for (var j = 1; j <= i; j++)
		{
		var millistartdate1 = changetoMillis(startdate3[j-1]);
		var millistartdate2 = changetoMillis(startdate3[j]);
		if (millistartdate1 > millistartdate2)
		{
		var temp = startdate3[j-1];
		startdate3[j-1] = startdate3[j];
		startdate3[j] = temp;
		var temp1 = index3[j-1];
		index3[j-1] = index3[j];
		index3[j] = temp1;
		}
		}
		}
		}
		for(var k = 0; k < noOfaddress ; k++) {
		findex = index3[k];
		if(!(startdate3[k+1]) == ''){
		ad_end_date[findex] = address_enddate(startdate3[k+1]);
		}
		else{
        // Fix for Multi addresses issue
		//Call id 346606 and 348767 change start
		//ad_end_date[findex] = "31/12/2099";
		ad_end_date[findex] =getEndDate1();
		//Call id 346606 and 348767 change end
		//ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
		   try{
		   var startdate4  = new Array();
		   var index1      = new Array();
		   var z=0;

		   for(var k = 0; k < noOfEdu ; k++) {
		   /*Changes done for Ticket#348257 begin*/
		   if((ad_address_type[k] == "NRERelative") && !(edu_Status[k] == "Remove")) {
		   startdate4[z] = ad_start_date[k];
		   /*Changes done for Ticket#348257 end*/
		   index1[z] = k;
		   z++;
		   }
		   }
		   noOfaddress = startdate4.length;
		   if( noOfaddress >1){
		   for ( var i = (noOfaddress - 1); i >= 0; i-- )
		   {
		   for (var j = 1; j <= i; j++)
		   {
		   var millistartdate1 = changetoMillis(startdate4[j-1]);
		   var millistartdate2 = changetoMillis(startdate4[j]);
		   if (millistartdate1 > millistartdate2)
		   {
		   var temp = startdate4[j-1];
		   startdate4[j-1] = startdate4[j];
		   startdate4[j] = temp;
		   var temp1 = index1[j-1];
		   index1[j-1] = index1[j];
		   index1[j] = temp1;
		   }
		   }
		   }
		   }
		   for(var k = 0; k < noOfaddress ; k++) {
		   findex = index1[k];
		   if(!(startdate4[k+1]) == ''){
		   end_date[findex] = address_enddate(startdate4[k+1]);
		   }
		   else{
        // Fix for Multi addresses issue
		//Call id 346606 and 348767 change start
		//end_date[findex] = "31/12/2099";
		end_date[findex] =getEndDate1();
		//Call id 346606 and 348767 change end
		   //end_date[findex] = "";
		   }
		   }
		   }
		   catch(e)
		   {}
 		// TRACKER 112270  changes-Begin
 		   setEnddateForOtherRetailAddrType(noOfEdu,ad_address_type,address_type,edu_Status);
 		// TRACKER 112270  changes-End
		// date validations-end
		/* CIF PhoneEmail Changes : Start */
		if(document.frm2.byPassFlag.value!="Y"){
		preferredAddress = document.getElementsByName('AccountBO.Address.preferredAddress')[0];
		var preferredAddressFlag = false;
		if(blFlag==true)
		{
			if(preferredAddress.value == "")
			{
				selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50265",""), preferredAddress.name, 'NO_HLINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				return "interactive";
			}
			else
			{
				for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
				{
			if(boName=='AccountBO'){
					recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("AccountBO.Address.addressCategory");
					recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("AccountBO.Address.PreferredFormat");
            }
			else if(boName=='AccountModBO'){
					recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("AccountModBO.Address.addressCategory");
					recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("AccountModBO.Address.PreferredFormat");
            }

					/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
					{
						preferredAddressFlag = true
						selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
						parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50266",""), preferredAddress.name, 'NO_HLINK');
						parent.parent.parent.parent.messageFrm.showMessages(selTabId);
						return "interactive";
					}*/
					if(preferredAddress.value == recordSetAddressCategory)
					{
						preferredAddressFlag = true;
					}
				}
				if(!preferredAddressFlag)
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50267",""), preferredAddress.name, 'NO_HLINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
				}
			else {
					   var currentPrefCount = 0;
					   var prefStartDate;
					   if (preferredAddress.value == "Home") {
							   noOfPrefaddress = startdate1.length;
							   prefStartDate =startdate1;
					   }
					   else  if (preferredAddress.value == "Future/OnSite") {
							   noOfPrefaddress = startdate3.length;
							   prefStartDate =startdate3;
					   }
					   else if (preferredAddress.value == "Work") {
							   noOfPrefaddress = startdate2.length;
							   prefStartDate =startdate2;
					   }
					   else if (preferredAddress.value == "NRERelative") {
							   noOfPrefaddress = startdate4.length;
							   prefStartDate =startdate4;
					   }
					   else {
							   currentPrefCount=-1;
					   }
					   if (currentPrefCount != -1 ) {
							   for(var k = 0; k < noOfPrefaddress ; k++)
							   {
									   var millistartdate1 = changetoMillis(prefStartDate[k]);
									   var millistartdate2 = changetoMillis(todaydate.value);
									   if (millistartdate1 <= millistartdate2)
									   {
											   currentPrefCount=currentPrefCount+1;
									   }
							   }
							   if (currentPrefCount == 0)
							   {
										if(blFlag == true)
										{
									   parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50495",""),TBODY_RecordSet.rows ,'NO_HLINK');
									   parent.parent.parent.parent.messageFrm.showMessages(selTabId);
									   return "interactive"
									   }
							   }
					   }
			   }
			}
			preferredPhone = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType')[0];
			preferredEmail = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType1')[0];
			//Changes for call id 423993 starts
			preferredMobileAlert = document.getElementsByName('AccountBO.Preferred_Mobile_Alert_Type')[0];
			var preferredAlertFlag = false;
			//Changes for call id 423993 ends
			var preferredPhoneFlag = false;
			var preferredEmailFlag = false;
			//Tracker 184709 Starts
				var phoneCheck = phoneEmailCheck();
				if(phoneCheck == "false" || phoneCheck == false) {
					return "interactive";
				}

			//Tracker 184709 Ends
			if((preferredPhone.value != null && preferredPhone.value != 'undefined') || (preferredEmail.value != null && preferredEmail.value != 'undefined') )
			{
				for(var r=0 ; r < document.all.PhoneEmailRecordSet.rows.length ; r++)
				{
			if(boName=='AccountBO'){
					recordSetPhone = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountBO.PhoneEmail.PhoneEmailType");
					if(preferredPhone.value == recordSetPhone && preferredPhone.value != null){
						preferredPhoneFlag = true;
					}
					//Changes for call id 423993 starts
					if(recordSetPhone!= null && preferredMobileAlert.value != null && recordSetPhone.indexOf(preferredMobileAlert.value)!=-1){
												preferredAlertFlag = true;
						  }
					//Changes for call id 423993 ends
					recordSetPhone1 = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountBO.PhoneEmail.PhoneEmailType1");
            }
			else if(boName=='AccountModBO'){
					recordSetPhone = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountModBO.PhoneEmail.PhoneEmailType");
					if(preferredPhone.value == recordSetPhone && preferredPhone.value != null){
						preferredPhoneFlag = true;
					}
					//Changes for call id 423993 starts
					if(recordSetPhone!= null && preferredMobileAlert.value != null && recordSetPhone.indexOf(preferredMobileAlert.value)!=-1){
												preferredAlertFlag = true;
						  }
					//Changes for call id 423993 ends
					recordSetPhone1 = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountModBO.PhoneEmail.PhoneEmailType1");
            }
					if(preferredEmail.value == recordSetPhone1 && preferredEmail.value != null){
						preferredEmailFlag = true;
					}
				}
				if(!preferredPhoneFlag && preferredPhone.value != null && preferredPhone.value != '')
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50268",""), preferredPhone.name, 'NO_HLINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
				}
				if(!preferredEmailFlag && preferredEmail.value != null && preferredEmail.value != '')
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50269",""), preferredEmail.name, 'NO_HLINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
				}
				//Changes for call id 423993 starts
				if(!preferredAlertFlag && preferredMobileAlert.value != null && preferredMobileAlert.value != '')
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ51306",""), preferredMobileAlert.name, 'HYPER_LINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
				}
				//Changes for call id 423993 ends
			}
			//changes for tracker 353384 start
			try{
			emailingPreferred=getCookie('doNotSendEMailFlg');
			if(!preferredEmailFlag && emailingPreferred == 'Y'){
				selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50269",""), preferredEmail.name, 'NO_HLINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				return "interactive";
			}
			}catch(e){}
			//changes for tracker 353384 start
		}
		}
		//MATPT mahesh changes end

		/* CIF PhoneEmail Changes : End */

		/* Changes for Tracker #109562 -- start */

		var adMobileNo = '';
		for(var i = 0; i <noOfPhoneEmail; i++){
			 if (ad_PhoneEmailType[i] == 'CELLPH') {
				adMobileNo = ad_PhoneNoLocalCode[i];
			 }
		}
		/* Changes for Tracker #109562 -- end */
        /* ***** Tracker# 97236 SMS Banking Mobile Number changes : Start ***** */
        	//Changes for the Tracker Id: 361934
		/*if(document.getElementsByName(boName+".IsSMSBankingEnabled")[0].checked
		   && SMSBankingNo=='')   
		{
			
			var mobileNoEntered = adMobileNo;
		
 			if(mobileNoEntered=='')
			{
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50476",""),"AccountBO.SMSBankingMobileNumber",'HYPER_HLINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				return "interactive";
			}
			else
			{
				SMSBankingMobileNumber.value = mobileNoEntered;
			}
		}*/
        /* ***** Tracker# 97236 SMS Banking Mobile Number changes : End ***** */
            addEduCounter = 0 ;
	    addPhoneEmailCounter = 0;
            clearAddressValues();
 try {
             for(var i = 0; i <noOfEdu; i++) {
                 if((edu_URL[i] != null) && !(edu_Status[i] == "Remove")) {
                     if(addEduCounter == 0) {
                                 document.frm2.address_type.value=srmEscape(ad_address_type[i], '^', escChars);
                                 /*Tracker 159095 : Sonali begin of changes*/
 			        document.frm2.houseno.value = srmEscapeAddr(ad_houseno[i], '^', escCharsAddr);
 			        document.frm2.premiseno.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
 			        document.frm2.building.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
 			        /*Tracker 159095 : Sonali end of changes*/
 			        document.frm2.country.value = srmEscape(ad_country[i], '^', escChars);
 			        document.frm2.city.value = srmEscape(ad_city[i], '^', escChars);
 			        document.frm2.state.value = srmEscape(ad_state[i], '^', escChars);
 			        /*ERPBOCF1:TRACKER:113259:STORAGE OF DATES :START OF CHANGES*/
				//tarcker id 113227 changes
				var strALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
				if(strALTCALENDAR_TYPE = 'true')
				{
					if(ad_start_date[i] != '')
					{
						var strFlag = isGregDateWithoutConv(ad_start_date[i]);
						if(strFlag != 'true')
						{
							ad_start_date[i]=convertHijToGreg(ad_start_date[i]);
						}
					}
					if(ad_end_date[i] != '')
					{
						var strFlag = isGregDateWithoutConv(ad_end_date[i]);
						if(strFlag != 'true')
						{
							ad_end_date[i]=convertHijToGreg(ad_end_date[i]);
						}
					}
				}
				/*ERPBOCF1:TRACKER:113259:STORAGE OF DATES :END OF CHANGES*/
 			        document.frm2.start_date.value = srmEscape(ad_start_date[i], '^', escChars);
 			        document.frm2.zip.value = srmEscape(ad_zip[i], '^', escChars);
 			        document.frm2.end_date.value = srmEscape(ad_end_date[i], '^', escChars);
 				document.frm2.addrID.value = srmEscape(ad_addrID[i], '^', escChars);
 				/*Tracker 159095 : Sonali begin of changes*/
 				document.frm2.streetno.value = srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);

 				document.frm2.town.value = srmEscapeAddr(ad_town[i], '^', escCharsAddr);
 				document.frm2.locality.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
 				document.frm2.domicile.value = srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
 				/*Tracker 159095 : Sonali end of changes*/
				//CIF PhoneEmail Changes : Start
				document.frm2.PreferredFormat.value = srmEscape(ad_PreferredFormat[i], '^', escChars);
				document.frm2.HoldMailReason.value = srmEscape(ad_HoldMailReason[i], '^', escChars);
				document.frm2.BusinessCenter.value = srmEscape(ad_BusinessCenter[i], '^', escChars);
				document.frm2.HoldMailInitiatedBy.value = srmEscape(ad_HoldMailInitiatedBy[i], '^', escChars);
				document.frm2.HoldMailFlag.value = srmEscape(ad_HoldMailFlag[i], '^', escChars);
// AdressLine changes: START
				/*Tracker 159095 : Sonali begin of changes*/
				document.frm2.AddressLine1.value = srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
				document.frm2.AddressLine2.value = srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
				document.frm2.AddressLine3.value = srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
// AdressLine changes: END
				document.frm2.FreeTextLabel.value = srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
				/*Tracker 159095 : Sonali end of changes*/
				if(document.frm2.byPassFlag.value!="Y"){
				document.frm2.PreferredAddress.value = document.getElementsByName('AccountBO.Address.preferredAddress')[0].value;
				}
				//CIF PhoneEmail Changes : End
				/*Tracker 159095 : Sonali  begin of changes*/
 				document.frm2.website.value = srmEscapeAddr(ad_website[i], '^', escCharsAddr);
 				document.frm2.mailstop.value = srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
 				document.frm2.streetname.value = srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
 	                        document.frm2.suburb.value = srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
 	                        /*Tracker 159095 : Sonali end of changes*/
 	                        document.frm2.IsAddressProofRcvd.value = srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
 	                        document.frm2.IsAddressVerified.value = srmEscape(ad_IsAddressVerified[i], '^', escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
				document.frm2.city_code.value 		= srmEscape(ad_cityCode[i], '^', escChars);
				document.frm2.state_code.value 		= srmEscape(ad_stateCode[i], '^', escChars);
				document.frm2.country_code.value 	= srmEscape(ad_cntryCode[i], '^', escChars);
                         addEduCounter = 1;
                     }else{
                         document.frm2.address_type.value = document.frm2.address_type.value + " ," + srmEscape(ad_address_type[i], '^', escChars);
                        /*Tracker 159095 : Sonali begin of changes*/
                         document.frm2.houseno.value = document.frm2.houseno.value + "%" + srmEscapeAddr(ad_houseno[i], '^', escCharsAddr);
                         document.frm2.premiseno.value = document.frm2.premiseno.value + "%" + srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
                         document.frm2.building.value = document.frm2.building.value + "%" + srmEscapeAddr(ad_building[i], '^', escCharsAddr);
                         /*Tracker 159095 : Sonali end of changes*/
                         /*Changes for call 201306 Starts*/
                         document.frm2.country.value = document.frm2.country.value + "," + srmEscape(ad_country[i], '^', escChars);
                         document.frm2.city.value = document.frm2.city.value + "," + srmEscape(ad_city[i], '^', escChars);
                         document.frm2.state.value = document.frm2.state.value + "," + srmEscape(ad_state[i], '^', escChars);
                         /*Changes for call 201306 Ends*/
                	/*ERPBOCF1:TRACKER:113259:STORAGE OF DATES :START OF CHANGES*/
			//tracker id 113227 changes
			var strALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
			if(strALTCALENDAR_TYPE = 'true')
			{
				if(ad_start_date[i] != '')
				{
					var strFlag = isGregDateWithoutConv(ad_start_date[i]);
					if(strFlag != 'true')
					{
						ad_start_date[i]=convertHijToGreg(ad_start_date[i]);
					}
				}
				if(ad_end_date[i] != '')
				{
					var strFlag = isGregDateWithoutConv(ad_end_date[i]);
					if(strFlag != 'true')
					{
						ad_end_date[i]=convertHijToGreg(ad_end_date[i]);
					}
				}
			}
				/*ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES*/
                         document.frm2.start_date.value = document.frm2.start_date.value + " ," + srmEscape(ad_start_date[i], '^', escChars);
                         document.frm2.zip.value = document.frm2.zip.value + " ," + srmEscape(ad_zip[i], '^', escChars);
                         document.frm2.end_date.value = document.frm2.end_date.value + " ," + srmEscape(ad_end_date[i], '^', escChars);
                         document.frm2.addrID.value = document.frm2.addrID.value + " ," + srmEscape(ad_addrID[i], '^', escChars);
 			/*Tracker 159095 :Sonali begin of changes*/
                         document.frm2.streetno.value = document.frm2.streetno.value + "%" + srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
                         document.frm2.town.value = document.frm2.town.value + "%" + srmEscapeAddr(ad_town[i], '^', escCharsAddr);
                         document.frm2.locality.value = document.frm2.locality.value + "%" + srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
                         document.frm2.domicile.value = document.frm2.domicile.value + "%" + srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
                         /*Tracker 159095 : Sonali end of changes*/
			 //CIF PhoneEmail Changes : Start
			 document.frm2.PreferredFormat.value = document.frm2.PreferredFormat.value + " ," + srmEscape(ad_PreferredFormat[i], '^', escChars);
			 document.frm2.HoldMailReason.value = document.frm2.HoldMailReason.value + " ," + srmEscape(ad_HoldMailReason[i], '^', escChars);
			 document.frm2.BusinessCenter.value = document.frm2.BusinessCenter.value + " ," + srmEscape(ad_BusinessCenter[i], '^', escChars);
			 document.frm2.HoldMailInitiatedBy.value = document.frm2.HoldMailInitiatedBy.value + " ," + srmEscape(ad_HoldMailInitiatedBy[i], '^', escChars);
			 document.frm2.HoldMailFlag.value = document.frm2.HoldMailFlag.value + " ," + srmEscape(ad_HoldMailFlag[i], '^', escChars);
// AdressLine changes: START
			/*Tracker 159095 : Sonali begin of changes*/
			document.frm2.AddressLine1.value = document.frm2.AddressLine1.value+ "%" + srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
			document.frm2.AddressLine2.value = document.frm2.AddressLine2.value+ "%" + srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
			document.frm2.AddressLine3.value = document.frm2.AddressLine3.value+ "%" + srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
// AdressLine changes: END
			 document.frm2.FreeTextLabel.value = document.frm2.FreeTextLabel.value + "%" + srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
                         /*Tracker 159095 : Sonali end of changes*/
			 if(document.frm2.byPassFlag.value!="Y"){
			 document.frm2.PreferredAddress.value = document.getElementsByName('AccountBO.Address.preferredAddress')[0].value;
			 }
			 //CIF PhoneEmail Changes : End
			/*Tracker 159095 : Sonali begin of changes*/
 			 document.frm2.website.value = document.frm2.website.value + "%" + srmEscapeAddr(ad_website[i], '^', escCharsAddr);
 			 document.frm2.mailstop.value = document.frm2.mailstop.value + "%" + srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
 			 document.frm2.streetname.value = document.frm2.streetname.value + "%" + srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
 			 document.frm2.suburb.value = document.frm2.suburb.value + "%" + srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
                         /*Tracker 159095 : Sonali end of changes*/
 			 document.frm2.IsAddressProofRcvd.value = document.frm2.IsAddressProofRcvd.value + " ," + srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
 			 document.frm2.IsAddressVerified.value = document.frm2.IsAddressVerified.value + " ," + srmEscape(ad_IsAddressVerified[i], '^', escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
			document.frm2.city_code.value 		= document.frm2.city_code.value + " ," +srmEscape(ad_cityCode[i], '^', escChars);
			document.frm2.state_code.value 		= document.frm2.state_code.value + " ," +srmEscape(ad_stateCode[i], '^', escChars);
			document.frm2.country_code.value 	= document.frm2.country_code.value + " ," +srmEscape(ad_cntryCode[i], '^', escChars);
 			 }
 			 }
 			 }
			var st=" ";
			var sep =",";
			for(p=0;p<ad_LastUpdate_Flag.length;p++)
			{
				if(ad_LastUpdate_Flag[p]!=null && ad_LastUpdate_Flag[p]!='')
				{
				 st+=ad_LastUpdate_Flag[p]+sep;
				}
			}
 			 document.getElementsByName("hidSt")[0].value=st;

//changes for ticket 635409 start
if(blFlag==false){
		if(mailingad == true){    
		var cc = document.frm2.streetno.value;
		if(cc == '' || cc == null){
parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CORPAD",""),TBODY_RecordSet.rows ,'NO_HLINK');
			 parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			 return "interactive"
			 }
		}
		}

//changes for ticket 635409 


 			 /* CIF PhoneEmail Changes : Start */
 			 if(document.frm2.byPassFlag.value!="Y"){
 			 for(var i = 0; i <noOfPhoneEmail; i++){
 			 if((phoneEmail_URL[i] != null) && !(phoneEmail_Status[i] == "Remove")) {
 			 if(addPhoneEmailCounter == 0) {
 			 document.frm2.PhoneNo.value = srmEscape(ad_PhoneNo[i], '^', escChars);
 			 document.frm2.PhoneOrEmail.value = srmEscape(ad_PhoneOrEmail[i], '^', escChars);
 			 document.frm2.PhoneEmailType.value = srmEscape(ad_PhoneEmailType[i], '^', escChars);
 			 document.frm2.PhoneEmailID.value = srmEscape(ad_PhoneEmailID[i], '^', escChars);
 			 document.frm2.Email.value = srmEscape(ad_Email[i], '^', escChars);
 			 document.frm2.PhoneNoCountryCode.value = srmEscape(ad_PhoneNoCountryCode[i], '^', escChars);
 			 document.frm2.PhoneNoCityCode.value = srmEscape(ad_PhoneNoCityCode[i], '^', escChars);
 			 document.frm2.PhoneNoLocalCode.value = srmEscape(ad_PhoneNoLocalCode[i], '^', escChars);
 			 document.frm2.extension.value = srmEscape(ad_extension[i], '^', escChars);
 			 document.frm2.PreferredPhone.value = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType')[0].value;
 			 document.frm2.PreferredEmail.value = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType1')[0].value;
 			 addPhoneEmailCounter = 1;
 			 }
 			 else
 			 {
 			 document.frm2.PhoneEmailID.value = document.frm2.PhoneEmailID.value + " ," + srmEscape(ad_PhoneEmailID[i], '^', escChars);
 			 document.frm2.PhoneOrEmail.value = document.frm2.PhoneOrEmail.value + " ," + srmEscape(ad_PhoneOrEmail[i], '^', escChars);
 			 document.frm2.PhoneNo.value = document.frm2.PhoneNo.value + " ," + srmEscape(ad_PhoneNo[i], '^', escChars);
 			 document.frm2.PhoneEmailType.value = document.frm2.PhoneEmailType.value + " ," + srmEscape(ad_PhoneEmailType[i], '^', escChars);
 			 document.frm2.Email.value = document.frm2.Email.value + " ," + srmEscape(ad_Email[i], '^', escChars);
 			 document.frm2.PhoneNoCountryCode.value = document.frm2.PhoneNoCountryCode.value + " ," + srmEscape(ad_PhoneNoCountryCode[i], '^', escChars);
 			 document.frm2.PhoneNoCityCode.value = document.frm2.PhoneNoCityCode.value + " ," + srmEscape(ad_PhoneNoCityCode[i], '^', escChars);
 			 document.frm2.PhoneNoLocalCode.value = document.frm2.PhoneNoLocalCode.value + " ," + srmEscape(ad_PhoneNoLocalCode[i], '^', escChars);
 			 document.frm2.extension.value = document.frm2.extension.value + " ," +srmEscape(ad_extension[i], '^', escChars);
 			 document.frm2.PreferredEmail.value = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType1')[0].value;
 			 document.frm2.PreferredPhone.value = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType')[0].value;
 			 }
 			 }
 			 }
 			 }
 			 /* CIF PhoneEmail Changes : End */

 } catch(ge) { DebugMessage(ge.message); }
                         document.frm2.AdrRemoved.value = getCSVforArray(edu_detachedURLs);
                         document.frm2.PhoneEmailRemoved.value = getCSVforArray(phone_detachedURLs);
      	      if(blFlag == true)
      	      {
      		    document.frm2.saveFlag.value = 0;
      	       }
      	       else
      	       {
      		    document.frm2.saveFlag.value = 1;
      	       }
            try{
					/*validateAccRM();
					setHiddenFieldsHH();
/*IDENTIFICATION DOCUMENT CHANGES Tracker ID 113276 start
					setHiddenIDFields();*/
					// Change for DBS ticket 325152
					//document.frm2.SwiftAddressDetails.value 		= SwiftAddressDetails;
/*IDENTIFICATION DOCUMENT CHANGES Tracker ID 113276 end*/
				var hasOtherErrors = false;
                if(!hasOtherErrors){
                    supplementAttrib();
                    var isCopy = document.frm2.IsCopy.value;
					if(defAddress == "Mailing") {
						defAddress = "M";
					}
					else if(defAddress == "Home")
						defAddress = "H";
					else
						defAddress = "W";

		//setHiddenFieldsGrp();
	//var ownerSegment= document.getElementsByName('AccountBO.accessOwnerSegment')[0].value;
	//var primaryRM=document.getElementsByName("Acc_manager")[0].value;
	/*var secondaryRM=document.getElementsByName("Sec_manager")[0].value;
	if (RMChanged=="true" && SegmentChanged=="true") {
		if(showConfirmMessage(MSGJ50358)){
		}else{
			return "interactive";
		}
	}
	else if (RMChanged=="true" && ownerSegment!=null && ownerSegment!='') {
		if(showConfirmMessage(MSGJ50358)){
		}else{
			return "interactive";
		}
	}
	else if (SegmentChanged=="true" && ((primaryRM!=null && primaryRM!='') || (secondaryRM!=null && secondaryRM!='') || (tertiaryRM!='' && tertiaryRM!=null))) {
		if(showConfirmMessage(MSGJ50357)){
		}else{
			return "interactive";
		}
	}*/
/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/

	/***calling functions****/
	//fnConvertDate();


/*ERPBOCF1:TRACKER:113259:STORAGE OF DATES :END OF CHANGES*/


                   // document.frm2.accKey.value=document.getElementsByName("AccountBO.ACCOUNTKEY")[0].value;
                    //Tracker ID 113276 - Start
                    /*var introSal = document.getElementsByName(boName + ".IntroducerSalutation")[0].value;	 */
                    //Tracker ID 113276 - End
			if(SwiftAddressDetails == ""){
				SwiftAddressDetails='YYY';
				if(blFlag == true){
					parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(), "Swift Address is Defaulted from Preferred Address Type");
					parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames(0).getSelectedTabId());
				}
			}
			//Ticket id 439883 and Tracker id 265600 Recon for Call id 225120 changes starts
			SwiftAddressDetails = SwiftAddressDetails.replace(/&/g, "%26");
			//Ticket id 439883 and Tracker id 265600 Recon for Call id 225120 changes ends
			//Change for ticket 326535
			document.frm2.SwiftAddressDetails.value 		= SwiftAddressDetails;
			var lastName_alt = getCookie('LookupAccountLastName_alt1');
			// Change for DBS ticket 325152
/* START  Changes for Tracker # 209607*/
			/* Null cahnges Begin*/
			newPara = document.getElementById("myPar");
			var frame='formSaveFrame';
                        
                        // Changes for ticket id 576082
			   if (operationType == "ConvtoCust") {			                        
			document.frm2.hid_reservestatus.value=operationType;
			}
                        /*changes for callid: 235861 Ticket: 454978 tracker: 275564  start*/
                        genralURL="../servlet/com.infy.cis.ui.common.AccWriter?isCopy="+isCopy+"&introLastName_alt1="+lastName_alt+"&showMsg=No&amp;CreatePartner=N";
                        /*changes for callid: 235861 Ticket: 454978 tracker: 275564  ends*/
                        fnRemoveNull(newPara,genralURL,document.frm2,frame);
                        /* Null cahnges End*/
			//document.frm2.action = "../servlet/com.infy.cis.ui.common.AccWriter?isCopy="+isCopy+"&introLastName_alt1="+lastName_alt+"&showMsg=No&amp;CreatePartner=N";

			/****** End of Swift Address changes ****/



                    //document.frm2.target="formSaveFrame";
                   // document.frm2.submit();
/* END  Changes for Tracker # 209607*/
                    return "true";
                }else{
                    return "false";
                }
       }catch(e){}
}
