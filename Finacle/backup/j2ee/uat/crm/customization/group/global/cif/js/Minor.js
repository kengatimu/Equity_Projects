// BEGIN OF ML CHANGES 
//--Performance--
//document.write('<script type="text/javascript" src="'+applPath+'/cif/js/Message_cif_'+finaclecrmlocale+'.js" language="javascript"></script>');
//--Performance--
// END OF ML CHANGES
          var lookupFor = '';
          var cifType = '';
          var accLookUpWin = null;
	  var sSelectType = '';
          var loading = "false";
	  var minor="false";
	  var Dob='';
  	  var intro = false;
	  var TDS = false;
          var boName = document.frm2.boName.value;
	  var bodateCreated='';
	 /*** Tracker ID 162087 Starts **/
	  var strMinorTabLastName='';
	  var flgMinorTabLastName=false;
	 /*** Tracker ID 162087 Ends **/
        function onRecordSelect(){
	//Tracker Id 124315 chages Begin
	var altLocaleActv= document.frm2.altLocaleActv.value;
	//Tracker Id 124315 chages End
	if(minor=="false" && !intro && !TDS)
	{
	                        	setAgentValues (agentLookupType, getCookie("LookupAgentName"), getCookie("LookupLoginID"));
	                        	return;
	                        }
	                     else if(minor == "true" && !TDS){  //changes for callid 727343
	                        loadPersistData();
            		      var isMinor = getCookie('isMinor');
            		      if(isMinor == "Y"){
							showUserMessage("MSGJ50252",'');
							if(accLookUpWin && accLookUpWin != null) {
							  accLookUpWin.focus();
	                        }
							return false;
            		      }
	            		//fvMakeComboEnable();

	            		//var AccessType = (document.frm2.AccessType.value).toUpperCase();
	            		var ID     =  document.frm2.ID.value;
	                        if (lookupFor == 'CUSTOMER') {
	                                var primaryCustomerName = getCookie('LookupAccountName');
	                                var primaryCustomerURL = getCookie('LookupAccountURL');
	                                var primaryCustomerID = getCookie('AccountID');
				/* CRM70t-ST :TRACKER# 79244 **BEGIN OF CHANGES **/
					var accountKey = getCookie('AccountKey');
					var CIFID = document.getElementsByName("AccountBO.AccountKey")[0].value;
	           try{
	            if(AccessType.indexOf("ACC") != -1 || AccessType.indexOf("CUST") != -1){
	                if(primaryCustomerID == ID){
	                    showUserMessage("MSG518",null);
	                                if(accLookUpWin && accLookUpWin != null) {
	                                accLookUpWin.focus();
	                        }
	                    return;
	                    }
	            }
	                }catch(e){}
	                if(accountKey == CIFID) {
	                    showMessage(MSGJ0081);
	                                    if(accLookUpWin && accLookUpWin != null) {
	                                        accLookUpWin.focus();
	                                    }
	                                    return;
	                                }
			/* CRM70t-ST :TRACKER# 79244 **END OF CHANGES **/
	                    document.frm2.hid_accountIDvalue.value = primaryCustomerID;
	                    var tempvar = '';
	                    tempvar = getCookie('LookupAccountFirstName');
	                    document.getElementsByName("ContactBO.firstName")[0].value = validationForCookie(tempvar);
	                    tempvar = getCookie('LookupAccountMiddleName');
	                    document.getElementsByName("ContactBO.middleName")[0].value = validationForCookie(tempvar);
	                    tempvar = getCookie('LookupAccountLastName');
	                    document.getElementsByName("ContactBO.lastName")[0].value = validationForCookie(tempvar);
			    /*Tracker ID 113227 Ankit Multilingual changes for Minor lookup SRART  */
			    /* Tracker 159446 : begin of changes */
			    if(altLocaleActv =="true"){
			    try{
			   tempvar = getCookie('LookupFirstName_alt1');
	                    document.getElementsByName("ContactBO.firstName_alt1")[0].value = validationForCookie(tempvar);
	                    tempvar = getCookie('LookupMiddleName_alt1');
	                    document.getElementsByName("ContactBO.middleName_alt1")[0].value = validationForCookie(tempvar);
	                    tempvar = getCookie('LookupLastName_alt1');
	                    document.getElementsByName("ContactBO.lastName_alt1")[0].value = validationForCookie(tempvar);
			   }catch(e){
			   }
			    }
			   /* Tracker 159446 : begin of changes */
			   /*Tracker ID 113227 Ankit Multilingual changes for Minor lookup SRART  */
	                    tempvar = getCookie('LookupAccountDOB');
	                    document.getElementsByName("3_ContactBO.DOB")[0].value = validationForCookie(tempvar);
			    Dob=validationForCookie(tempvar);
	                    tempvar = getCookie('LookupAccountGender');
	                    document.getElementsByName("ContactBO.gender")[0].value = validationForCookie(tempvar);
	                    tempvar = getCookie('LookupAccountTitle');
	                    document.getElementsByName("ContactBO.salutation")[0].value = validationForCookie(tempvar);
	              	    tempvar = getCookie('AccountKey');
	              	    document.getElementsByName("ContactBO.contactsKey")[0].value = validationForCookie(tempvar);
			    tempvar = getCookie('LookupAccountFirstNative');
			    document.getElementsByName("ContactBO.Contact_First_Name_Native")[0].value = validationForCookie(tempvar);
			    tempvar = getCookie('LookupAccountMiddleNative');
			    document.getElementsByName("ContactBO.Contact_Middle_Name_Native")[0].value = validationForCookie(tempvar);
			    tempvar = getCookie('LookupAccountLastNative');
			    document.getElementsByName("ContactBO.Contact_Last_Name_Native")[0].value = validationForCookie(tempvar);
	               }
	                if(lookupFor == 'CONTACT')
	                {
	                    var primaryContactName = getCookie('LookupContactName');
	                    var primaryContactURL = getCookie('LookupContactURL');
	                    var primaryContactID = getCookie('ContactID');
	                try{
	                if(AccessType.indexOf("CONT") != -1 ){
	                    if(primaryContactID == ID){
	                        showUserMessage("MSG518",null);
	                                    if(accLookUpWin && accLookUpWin != null) {
	                                    accLookUpWin.focus();
	                            }
	                        return false;
	                    }
	                }
	                }catch(e){}
	                document.frm2.hid_accountIDvalue.value = primaryContactID;
	                tempvar = getCookie('LookupContactFirstName');
	                document.getElementsByName("ContactBO.firstName")[0].value = validationForCookie(tempvar);
	                tempvar = getCookie('LookupContactMiddleName');
	                document.getElementsByName("ContactBO.middleName")[0].value = validationForCookie(tempvar);
	                tempvar = getCookie('LookupContactLastName');
	                document.getElementsByName("ContactBO.lastName")[0].value = validationForCookie(tempvar);

			/*Tracker ID 113227 Ankit Multilingual changes for Minor lookup START  */
			 /* Tracker 159446 : begin of changes */
			 if(altLocaleActv == 'true'){
			 try{
			tempvar = getCookie('LookupFirstName_alt1');
			document.getElementsByName("ContactBO.firstName_alt1")[0].value = validationForCookie(tempvar);
			tempvar = getCookie('LookupMiddleName_alt1');
			document.getElementsByName("ContactBO.middleName_alt1")[0].value = validationForCookie(tempvar);
			tempvar = getCookie('LookupLastName_alt1');
			document.getElementsByName("ContactBO.lastName_alt1")[0].value = validationForCookie(tempvar);
			   }catch(e){
			   }
			}
			 /* Tracker 159446 : end of changes */
			/*Tracker ID 113227 Ankit Multilingual changes for Minor lookup END  */
	                tempvar = getCookie('LookupContactDOB');
	                document.getElementsByName("3_ContactBO.DOB")[0].value = validationForCookie(tempvar);
			Dob=validationForCookie(tempvar);
	                tempvar = getCookie('LookupContactGenderName');
	           	document.getElementsByName("ContactBO.gender")[0].value = validationForCookie(tempvar);
	                tempvar = getCookie('LookupContactTitleName');
	                document.getElementsByName("ContactBO.salutation")[0].value = validationForCookie(tempvar);
	                tempvar = getCookie('ContactKey');
	                document.getElementsByName("ContactBO.contactsKey")[0].value = validationForCookie(tempvar);
	                tempvar = getCookie('LookupContactFirstNative');
	                document.getElementsByName("ContactBO.Contact_First_Name_Native")[0].value = validationForCookie(tempvar);
	                tempvar = getCookie('LookupContactMiddleNative');
	                document.getElementsByName("ContactBO.Contact_Middle_Name_Native")[0].value = validationForCookie(tempvar);
	                tempvar = getCookie('LookupContactLastNative');
	                document.getElementsByName("ContactBO.Contact_Last_Name_Native")[0].value = validationForCookie(tempvar);
	                      }
	            if(lookupFor == 'PROSPECT')
	            {
	            var primaryProspectName = getCookie('LookupProspectName');
	            var primaryProspectURL = getCookie('ProspectURL');
	            var primaryProspectID = getCookie('ProspectID');
	            try{
	            if(AccessType.indexOf("PROS") != -1 || AccessType.indexOf("SUSP") != -1){
	                if(primaryProspectID == ID){
	                    showUserMessage("MSG518",null);
	                    if(accLookUpWin && accLookUpWin != null) {
	                    accLookUpWin.focus();
	                    }
	                    return false;
	                }
	            }
	            }catch(e){}
	            document.frm2.hid_accountIDvalue.value = primaryProspectID;
	            tempvar = getCookie('LookupProspectFirstName');
	            document.getElementsByName("ContactBO.firstName")[0].value = validationForCookie(tempvar);
	            tempvar = getCookie('LookupProspectMiddleName');
	            document.getElementsByName("ContactBO.middleName")[0].value = validationForCookie(tempvar);
	            tempvar = getCookie('LookupProspectLastName');
	            document.getElementsByName("ContactBO.lastName")[0].value = validationForCookie(tempvar);
		    /*Tracker ID 113227 Ankit Multilingual changes for Minor lookup START  */
		    /* Tracker 159446 : begin of changes */
		    if(altLocaleActv == 'true'){
		    try{
		    tempvar = getCookie('LookupFirstName_alt1');
		    document.getElementsByName("ContactBO.firstName_alt1")[0].value = validationForCookie(tempvar);
		    tempvar = getCookie('LookupMiddleName_alt1');
		    document.getElementsByName("ContactBO.middleName_alt1")[0].value = validationForCookie(tempvar);
		    tempvar = getCookie('LookupLastName_alt1');
		    document.getElementsByName("ContactBO.lastName_alt1")[0].value = validationForCookie(tempvar);
		     }catch(e){
			}
		    }
		    /* Tracker 159446 : end of changes */
		    /*Tracker ID 113227 Ankit Multilingual changes for Minor lookup END  */
	            tempvar = getCookie('LookupProspectDOB');
	            document.getElementsByName("3_ContactBO.DOB")[0].value = validationForCookie(tempvar);
		    Dob=validationForCookie(tempvar);
	            tempvar = getCookie('LookupProspectGender');
	            document.getElementsByName("ContactBO.gender")[0].value = validationForCookie(tempvar);
	            tempvar = getCookie('LookupProspectTitle');
	            document.getElementsByName("ContactBO.salutation")[0].value = validationForCookie(tempvar);
	            tempvar = getCookie('SuspectsKey');
	            document.getElementsByName("ContactBO.contactsKey")[0].value = validationForCookie(tempvar);
	            tempvar = getCookie('LookupProspectFirstNative');
	            document.getElementsByName("ContactBO.Contact_First_Name_Native")[0].value = validationForCookie(tempvar);
	            tempvar = getCookie('LookupProspectMiddleNative');
	            document.getElementsByName("ContactBO.Contact_Middle_Name_Native")[0].value = validationForCookie(tempvar);
	            tempvar = getCookie('LookupProspectLastNative');
		    document.getElementsByName("ContactBO.Contact_Last_Name_Native")[0].value = validationForCookie(tempvar);
	                     }
	                      fvDisableObject();
		     document.getElementsByName("RelationshipBO.Bank_Entity_Name")[0].fireEvent("onChange");
	             }else if(intro){
	                    var tempvar = '';
	                        loadPersistData();
            		      document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = false;
	if(cifType == 'Retail'){
            		      var isMinor = getCookie('isMinor');
            		      if(isMinor == "Y"){
							showUserMessage("MSGJ50252",'');
							if(accLookUpWin && accLookUpWin != null) {
								accLookUpWin.focus();
	                        }
							return false;
            		      }
          // Fix for Ticket ID 286386 Ends
	 var blacklisted	= "";
	 var negated		= "";
	 var suspended		= "";
	 var AllowBL	= "";
	 var AllowNeg		= "";
	 var AllowSus		= "";
	                        if (lookupFor == 'CUSTOMER') {
	 	blacklisted	= getCookie('LookupAccountBlacklisted');
	 	negated		= getCookie('LookupAccountNegated');
		suspended	= getCookie('LookupAccountSuspended');
	  }
	  else if(lookupFor == 'CONTACT') {
		blacklisted	= getCookie('LookupContactBlacklisted');
		negated		= getCookie('LookupContactNegated');
		suspended	= getCookie('LookupContactSuspended');	                
	  }             
	  else if(lookupFor == 'PROSPECT') {
		blacklisted	= getCookie('LookupProspectBlacklisted');
		negated		= getCookie('LookupProspectNegated');
		suspended	= getCookie('LookupProspectSuspended');	  
	  }
	  for (i=0; i<=RetRelValues.length-1;i++) {
		 if(RetRelValues[i] =='INTRODUCER')
		 {
			 AllowBL 	= AllowBlklisted[i];
			 AllowNeg	= AllowNegated[i];
			 AllowSus	= AllowSuspended[i];
		 }
	  }
		
	    if(AllowBL == 'N' && blacklisted == 'Y') {
		showMessage(MSGJ50177);
		self.location.close();
		return;
	    }
	    if(AllowNeg == 'N' && negated == 'Y') {
		showMessage(MSGJ50178);
		self.location.close();
		return;
	    }
	    if(AllowSus == 'N' && suspended == 'Y') {
		showMessage(MSGJ50179);
		self.location.close();
		return;
	    }
          // Fix for Ticket ID 286386 Ends
	                        if (lookupFor == 'CUSTOMER') {
	            	    var primaryCustomerID = getCookie('AccountID');
	            	    document.frm2.hid_introIDvalue.value = primaryCustomerID;
	                    tempvar = getCookie('LookupAccountLastName');
	                    document.getElementsByName("AccountBO.IntroducerName")[0].value = validationForCookie(tempvar);
	                    //tkt 351073 start
			    tempvar = getCookie('LookupAccountFirstName');
			    document.getElementsByName("IntroducerFirstName")[0].value = validationForCookie(tempvar);
			    tempvar = getCookie('LookupAccountGender');
	                    document.getElementsByName("Gender")[0].value = validationForCookie(tempvar);
	                    //tkt 351073 end
	                    tempvar = getCookie('LookupAccountTitle');
	                    document.getElementsByName(boName +".IntroducerSalutation")[0].value = validationForCookie(tempvar);
			//changes for call is 410026 and recon of call id 407523 starts
	                    tempvar = getCookie('LookupAccountTitleCode');
	                    //document.getElementsByName(boName +".IntroducerSalutation")[0].value = validationForCookie(tempvar);
	                    document.getElementsByName("Cat_"+boName +".IntroducerSalutation")[0].value = validationForCookie(tempvar);
			//changes for call is 410026 and recon of call id 407523 ends
                            var cust = document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0];
			    cust.value = document.getElementsByName("AccountBO.IntroducerName")[0].value;
	              	    tempvar = getCookie('AccountKey');
 		            document.getElementsByName("AccountBO.IntroducerID")[0].value = validationForCookie(tempvar);
					/* Changes for ticket 336240 starts */
					/* Changes for ticket 371155 starts */
					document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = true;
					document.getElementsByName("Cat_"+boName +".IntroducerSalutation")[0].disabled = true;
				document.getElementsByName("btnone_"+boName+".IntroducerSalutation")[0].disabled = true;
		document.getElementsByName("btntwo_"+boName+".IntroducerSalutation")[0].disabled = true;
					/* Changes for ticket 371155 ends */	               	    
					/* Changes for ticket 336240 ends */	               	    
	               	    bodateCreated=getCookie('LookupAccountBODateCreated');
             	            document.frm2.hid_bodateCreated.value = validationForCookie(bodateCreated);
				//Tracker Id 124315 changes start
				if(altLocaleActv == 'true'){
				tempvar = getCookie('LookupLastName_alt1');
				document.getElementsByName("AccountBO.IntroducerName_alt1")[0].value = validationForCookie(tempvar);
				document.getElementsByName("AccountBO.IntroducerName_alt1")[0].readOnly = true;
				}
				//Tracker Id 124315 changes End
	               }
	                if(lookupFor == 'CONTACT')
	                {
                    	var primaryContactID = getCookie('ContactID');
	            	document.frm2.hid_introIDvalue.value = primaryContactID;
	                tempvar = getCookie('LookupContactLastName');
	                document.getElementsByName("AccountBO.IntroducerName")[0].value = validationForCookie(tempvar);
	                //tkt 351073 start
			tempvar = getCookie('LookupContactFirstName');
			document.getElementsByName("IntroducerFirstName")[0].value = validationForCookie(tempvar);
			tempvar = getCookie('LookupContactGenderName');
		        document.getElementsByName("Gender")[0].value = validationForCookie(tempvar);
	                 //tkt 351073 end
	                var Cont = document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0];
	                Cont.value = document.getElementsByName("AccountBO.IntroducerName")[0].value;
	                tempvar = getCookie('LookupContactTitleName');
	                document.getElementsByName(boName +".IntroducerSalutation")[0].value = validationForCookie(tempvar);
	                // Changes for call id 427106 starts here 
	                tempvar = getCookie('CatLookupContactTitleName');
	                document.getElementsByName("Cat_"+boName +".IntroducerSalutation")[0].value = validationForCookie(tempvar);
	                // Changes for call id 427106 ends here
					/* Changes for ticket 336240 starts */
					/* Changes for ticket 371155 starts */
					document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = true;
					document.getElementsByName("Cat_"+boName +".IntroducerSalutation")[0].disabled = true;
			document.getElementsByName("btnone_"+boName+".IntroducerSalutation")[0].disabled = true;
	document.getElementsByName("btntwo_"+boName+".IntroducerSalutation")[0].disabled = true;
					/* Changes for ticket 336240 ends */	                
					/* Changes for ticket 371155 ends */	               	    
	                tempvar = getCookie('ContactKey');
	                document.getElementsByName("AccountBO.IntroducerID")[0].value = validationForCookie(tempvar);
	                bodateCreated=getCookie('LookupContactBODateCreated');
             	        document.frm2.hid_bodateCreated.value = validationForCookie(bodateCreated);
				//Tracker Id 124315 changes start
				if(altLocaleActv == 'true'){
				tempvar = getCookie('LookupLastName_alt1');
				document.getElementsByName("AccountBO.IntroducerName_alt1")[0].value = validationForCookie(tempvar);
				document.getElementsByName("AccountBO.IntroducerName_alt1")[0].readOnly = true;
				}
				//Tracker Id 124315 changes End
	                      }
	            if(lookupFor == 'PROSPECT')
	            {
	            var primaryProspectID = getCookie('ProspectID');
	            document.frm2.hid_introIDvalue.value = primaryProspectID;
	            tempvar = getCookie('LookupProspectLastName');
	            document.getElementsByName("AccountBO.IntroducerName")[0].value = validationForCookie(tempvar);
	            //tkt 351073 start
		    tempvar = getCookie('LookupProspectFirstName');
		    document.getElementsByName("IntroducerFirstName")[0].value = validationForCookie(tempvar);
		    tempvar = getCookie('LookupProspectGender');
		    document.getElementsByName("Gender")[0].value = validationForCookie(tempvar);
	            //tkt 351073 end
	            var Cont = document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0];
	            Cont.value = document.getElementsByName("AccountBO.IntroducerName")[0].value;
	            tempvar = getCookie('LookupProspectTitle');
	            document.getElementsByName(boName +".IntroducerSalutation")[0].value = validationForCookie(tempvar);
	            // Changes for call id 427106 starts here
	            tempvar = getCookie('CatLookupProspectTitle');
	            document.getElementsByName("Cat_"+boName +".IntroducerSalutation")[0].value = validationForCookie(tempvar);
	            // Changes for call id 427106 ends here
				/* Changes for ticket 336240 starts */
					/* Changes for ticket 371155 starts */	               	    
				document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = true;
				document.getElementsByName("Cat_"+boName +".IntroducerSalutation")[0].disabled = true;
				document.getElementsByName("btnone_"+boName+".IntroducerSalutation")[0].disabled = true;
		document.getElementsByName("btntwo_"+boName+".IntroducerSalutation")[0].disabled = true;
					/* Changes for ticket 371155 ends */	               	    
				/* Changes for ticket 336240 ends */
	            tempvar = getCookie('SuspectsKey');
	            document.getElementsByName("AccountBO.IntroducerID")[0].value = validationForCookie(tempvar);
	            bodateCreated=getCookie('LookupProspectBODateCreated');
             	    document.frm2.hid_bodateCreated.value = validationForCookie(bodateCreated);
				//Tracker Id 124315 changes start
				if(altLocaleActv == 'true'){
				tempvar = getCookie('LookupLastName_alt1');
				document.getElementsByName("AccountBO.IntroducerName_alt1")[0].value = validationForCookie(tempvar);
				document.getElementsByName("AccountBO.IntroducerName_alt1")[0].readOnly = true;
				}
				//Tracker Id 124315 changes End
	                     }
	           }
	           else
	           {
	           try{
			if (lookupFor == 'CUSTOMER') {
				var tempvar = getCookie('LookupCustCorpID');
				document.frm2.hid_introIDvalue.value = validationForCookie(tempvar);
			var tempvar = getCookie('LookupCorpCustKey');
	            document.getElementsByName("AccountBO.IntroducerID")[0].value = validationForCookie(tempvar);
				var tempvar = getCookie('LookupCorpCustName');
				document.getElementsByName("AccountBO.IntroducerName")[0].value = validationForCookie(tempvar);
				var cust = document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0];
				cust.value = document.getElementsByName("AccountBO.IntroducerName")[0].value;
				document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = true;
				/*Changes for Ticket id:319932 Start*/
				/* Changes for Ticket id:336240 Starts commenting the below lines as corporate customer do not have salutations */
				/* var tempvar = getCookie('LookupAccountTitle');
				document.getElementsByName(boName +".IntroducerSalutation")[0].value = validationForCookie(tempvar);
				/* Changes for Ticket id:336240 ends */
				/*Changes for Ticket id:319932 End*/
					//Tracker Id 124315 changes start
					if(altLocaleActv == 'true'){
					tempvar = getCookie('LookupCorpCustName_alt1');
					document.getElementsByName("AccountBO.IntroducerName_alt1")[0].value = validationForCookie(tempvar);
					document.getElementsByName("AccountBO.IntroducerName_alt1")[0].readOnly = true;
					}
					//Tracker Id 124315 changes End
				}
				else
				{
				var tempvar = getCookie('LookupProspectCorpID');
				document.frm2.hid_introIDvalue.value = validationForCookie(tempvar);
				/*Changes for Ticket id:319932 Start*/
				/*var tempvar = getCookie('LookupCorpProspectKey');*/
				var tempvar = getCookie('LookupProspectCorpKey');
				/*Changes for Ticket id:319932 End*/
	            document.getElementsByName("AccountBO.IntroducerID")[0].value = validationForCookie(tempvar);
	            var tempvar = getCookie('LookupCorpProspectName');
				document.getElementsByName("AccountBO.IntroducerName")[0].value = validationForCookie(tempvar);
				var cust = document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0];
				cust.value = document.getElementsByName("AccountBO.IntroducerName")[0].value;
				document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = true;
				/*Changes for Ticket id:319932 Start*/
				/*Changes for Ticket id:336240 Starts commenting the below lines as corporate customer do not have salutations */
				/* var tempvar = getCookie('LookupAccountTitle');
				document.getElementsByName(boName +".IntroducerSalutation")[0].value = validationForCookie(tempvar);
				/*Changes for Ticket id:336240 ends */
				/*Changes for Ticket id:319932 End*/
					//Tracker Id 124315 changes start
					if(altLocaleActv == 'true'){
					tempvar = getCookie('LookupCorpProspectName_alt1');
					document.getElementsByName("AccountBO.IntroducerName_alt1")[0].value = validationForCookie(tempvar);
					document.getElementsByName("AccountBO.IntroducerName_alt1")[0].readOnly = true;
					}
					//Tracker Id 124315 changes End
		     	      				}
  			}catch(e){}
	           }
	                      fvDisableObjectIntro();
	               document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].fireEvent("onChange");
	           }
	            else{
		    //changes for callid 709300 starts
					if(getCookie('TDSType'))
					{
						if(getCookie('TDSType')=='Tds_CIF_Id_corpCust')
						{
									    var CoreCustID = getCookie('LookupChildCoreCustID');
			    var TDS_CIFID= getCookie('LookupChildCIFID');
					}
					else{
							    var CoreCustID = getCookie('corecustId');
			    var TDS_CIFID= getCookie('AccountKey');
					}
					deleteCookie('TDSType');
					}
					else{
						var CoreCustID = getCookie('corecustId');
			    var TDS_CIFID= getCookie('AccountKey');
					}
					//changes for callid 709300 ends
  			    document.getElementsByName("AccountBO.Tds_cust_id")[0].value = TDS_CIFID;
			    document.frm2.TDS_CORECUSTID.value=CoreCustID;
			}
			var partnerKey = getCookie("LookupPartnerKey");
			document.getElementsByName("AccountBO.DSA_ID")[0].value = partnerKey;
			document.getElementsByName("AccountBO.DSA_ID")[0].fireEvent("onChange");
	}
	        function validationForCookie(CookieVal)
	        {
	            var BLANKSPACE = '';
	            if(CookieVal == "null") {
	                return BLANKSPACE;
	            } else {
	                return CookieVal;
	            }
        }
        function IsMinor(dobDay,dobMonth,dobYear){
	    var MINOR_YEAR = document.all.MINOR_YEAR.value;
           /*Tracker ID 113227 Ankit  Defect Fix  changes for ID 113  END  */
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
            /*Tracker ID 113227 Ankit Defect Fix 113 changes for  END  */
            date = new Date(locDate);
            try
            {
                var thisYear = date.getFullYear() ;
                var thisMonth = date.getMonth()+1 ;
                var thisDay = date.getDate() ;
                var yearDiff = thisYear - dobYear ;
                if ( yearDiff > MINOR_YEAR)
                {
                    return 'false';
                }else if ( yearDiff < MINOR_YEAR)
                {
                    return 'true';
                }
                //Changes for date issue Starts-379887
                else if ( yearDiff == MINOR_YEAR && thisMonth < dobMonth){
                    return 'true';
                }else if ( yearDiff == MINOR_YEAR && thisMonth == dobMonth && thisDay < dobDay){
                    return 'true';
                }
                //Changes for date issue Ends-379887
                else {
                    return 'false';
                }
            }catch(e) {
                return 'false';
            }
        }
	/*Fix for Tracker #: SIDDHARTH Starts*/
         function IsMinor_loc(dobDay,dobMonth,dobYear){
		    var MINOR_YEAR = document.all.MINOR_YEAR.value;
		    /*Tracker ID 113227 Ankit  Defect Fix  changes for ID 113  START  */
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
            /*Tracker ID 113227 Ankit  Defect Fix  changes for ID 113  END  */
	            date = new Date(locDate);
	            try
	            {
	                var thisYear = date.getFullYear() ;
	                var thisMonth = date.getMonth()+1 ;
	                var thisDay = date.getDate() ;
	                var yearDiff = thisYear - dobYear ;
	                if ( yearDiff > MINOR_YEAR)
	                {
	                    return 'false';
	                }else if ( yearDiff < MINOR_YEAR)
	                {
	                    return 'true';
	                }else if ( thisMonth < dobMonth){
	                    return 'true';
	                }else if ( thisMonth > dobMonth){
            		    return 'false';
            		}else if ( thisDay < dobDay){
	                    return 'true';
	                }else {
	                    return 'false';
	                }
	            }catch(e) {
	                return 'false';
	            }
        }
        /*Fix for Tracker #: SIDDHARTH Ends*/
        
        
        // Senior Starts
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
			 			return seniorDate;
			 		}catch(e){
			 		}
 	}
 	//Senior Ends
 	
     function DisplayLookUP() {
		var sStr = document.getElementsByName("RelationshipBO.Bank_Entity")[0].value;
		/* Fix for ticket 220098 and tracker 132135 start*/
		  /* TRACKER ID 148769 CHANGES BEGIN */
		  /* Try catch block added */
		try{
		if(sStr!='')
		{
		if(readMode != 'Y'){
		document.getElementsByTagName("img")[6].style.visibility='hidden';// fix for ticket 272220
		}
		}
		else
		{
		document.getElementsByTagName("img")[6].style.visibility='visible';
		}
		/* Fix for ticket 220098 and tracker 132135 ends*/
		document.frm2.Bank_Entity.value = sStr;
		}catch(e){}
		/* TRACKER ID 148769 CHANGES END */
		if(loading != "true"){
		if( sStr != "" && sSelectType != sStr)
		{
			fvClearAll();
		}else if(sStr != "" && sSelectType == sStr){
		}else if(sStr != "" && sSelectType == ''){
		}
		else {
		fvClearAll();
			}
  	 	}
                fvDisableObject();
                loading = "false";
                try{
               /* Tracker ID 162087 start */  
                if(document.getElementsByName("RelationshipBO.Bank_Entity")[0].value != ''){
                   	if(flgMinorTabLastName==false){   	
	                   	flgMinorTabLastName=true;
	                   	strMinorTabLastName=document.getElementsByName("lbDynamic")[9].innerText;	
                   	}
                   	
                   	//Changes for Call Id:376172 , recon of call id 373398 Starts
                   	document.getElementsByName("lbDynamic")[14].innerText = sStr;
                   	//Changes for Call Id:376172 , recon of call id 373398 Ends
                   	
                }else{
                	if(flgMinorTabLastName){
				document.getElementsByName("lbDynamic")[9].innerText = strMinorTabLastName;	
			}
                }
                /* Tracker ID 162087 end */  
                }catch(e){}
     }
     function DisplayLookUPIntro() {
     cifType = document.getElementsByName("RelationshipBO.ChildEntityType")[0].value;
         if(cifType == '')
         {
         showMessage(MSGJ0087);
		 /* Tracker ID 113276 start */ 
		 /* Tracker ID- 150493, Ticket ID : 249521 Changes Start */
          document.getElementsByName("RelationshipBO.Bank_Entity1")[0].value = '';
          //360106
          document.getElementsByName("AccountBO.StrUserField21")[0].disabled = false;
          //360106
		 /* Tracker ID- 150493, Ticket ID : 249521 Changes End */
         /* Tracker ID 113276 end */
         setFocusOnComp("RelationshipBO.ChildEntityType");
    }
    else{
		 document.getElementsByName("AccountBO.StrUserField21")[0].disabled = true;
		var sStr = document.getElementsByName("RelationshipBO.Bank_Entity1")[0].value;
		document.frm2.Bank_Entity1.value = sStr;
		if(loading != "true"){
		if( sStr != "" && sSelectType != sStr)
		{
		/* Tracker ID- 150493, Ticket ID : 249521 Changes Start */
			//document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value = "";
			//fvClearAllIntro();
		/* Tracker ID- 150493, Ticket ID : 249521 Changes End */
		}else if(sStr != "" && sSelectType == sStr){
		}else if(sStr != "" && sSelectType == ''){
		}
		else {
		/* Tracker ID- 150493, Ticket ID : 249521 Changes Start */
		//document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value = "";
		//fvClearAllIntro();
		/* Tracker ID- 150493, Ticket ID : 249521 Changes End */
			}
  	 	}

                fvDisableObjectIntro();
                loading = "false";
                try{
                if(document.getElementsByName("RelationshipBO.Bank_Entity1")[0].value != ''){
                   	lbDynamic.innerText = "Entity Last Name";
                }else{
                        lbDynamic.innerText = "Entity Last Name";
                }
                }catch(e){}
                }
       /* Change done as a part of ticket 296094 starts, this condition for calling the function at this place is unnecessary as the same is handled in Account.xsl for ordinary and readonly mode */
       //changes for the ticket id 302135 starts
         var bankEntityType = document.getElementsByName("RelationshipBO.Bank_Entity1")[0].value;
		if((bankEntityType != null && bankEntityType != '') && (cifType != null && cifType != '')){
			enable_LookUp();
					/* Changes for ticket 371155 */	               	    
		document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value='';
		document.getElementsByName(boName+".Introd_Status")[0].value='';
		document.getElementsByName(boName+".IntroducerSalutation")[0].value='';
		document.getElementsByName("Cat_"+boName+".IntroducerSalutation")[0].value='';
		document.getElementsByName("AccountBO.IntroducerID")[0].value='';
		document.getElementsByName("AccountBO.IntroducerName")[0].value='';
//changes for recon tracker 403626
		document.getElementsByName("AccountBO.IntroducerID")[0].readOnly = true;
		document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = true;
		}else{
			disable_LookUp();
		} 
	//changes for the ticket id 302135 ends
	/* Change done as a part of ticket 296094 ends */
     }
	 function disable_LookUp() {
		var bankEntityType = document.getElementsByName("RelationshipBO.Bank_Entity1")[0].value;
		var cifType = document.getElementsByName("RelationshipBO.ChildEntityType")[0].value;
		/* Change done as a part of ticket 296094 starts */
		var bank_entity_name1 = document.getElementsByName("AccountBO.IntroducerName")[0].value;
		if(bank_entity_name1 != null && bank_entity_name1 != ''){
		document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value= bank_entity_name1;
		}
		/* Change done as a part of ticket 296094 ends */
		if((bankEntityType == null || bankEntityType == '') || (cifType == null || cifType == '')){
		  document.getElementsByName("btnone_RelationshipBO.Bank_Entity_Name1")[0].disabled = true;
		  document.getElementsByName("btntwo_RelationshipBO.Bank_Entity_Name1")[0].disabled = true;
		}
	}
	function enable_LookUp() {
	 document.getElementsByName("btnone_RelationshipBO.Bank_Entity_Name1")[0].disabled = false;
	 document.getElementsByName("btntwo_RelationshipBO.Bank_Entity_Name1")[0].disabled = false;
	}
        function fvDisableObject(){
            if(document.getElementsByName("RelationshipBO.Bank_Entity")[0].value != ''){
                document.getElementsByName("ContactBO.salutation")[0].disabled = true;
                document.getElementsByName("ContactBO.firstName")[0].readOnly = true;
                document.getElementsByName("ContactBO.middleName")[0].readOnly = true;
                document.getElementsByName("ContactBO.lastName")[0].readOnly = true;
		//Changes for Tracker id 146713 Start
		<!-- Fix for ticket 272220 starts -->
                //document.getElementsByName("3_ContactBO.DOB")[0].readOnly = true;
                if(readMode != 'Y')
		{
		 document.getElementsByName("3_ContactBO.DOB")[0].readOnly = true;
		}
		else {
		document.getElementsByName("ContactBO.DOB")[0].readOnly = true;
		
		}
		<!-- Fix for ticket 272220 end -->

		//Changes for Tracker id 146713 End
                /*Tracker ID 113227 Ankit Multilingual changes for Minor lookup SRART  */
		  if(altLocaleActv == 'true'){
		document.getElementsByName("ContactBO.firstName_alt1")[0].readOnly = true;
                document.getElementsByName("ContactBO.middleName_alt1")[0].readOnly = true;
                document.getElementsByName("ContactBO.lastName_alt1")[0].readOnly = true;
                }
		/*Tracker ID 113227 Ankit Multilingual changes for Minor lookup SRART  */
                document.getElementsByName("ContactBO.gender")[0].disabled = true;
                document.getElementsByName("ContactBO.salutation")[0].IsMandatory="false";
                document.getElementsByName("mandStarContactBO.salutation")[0].style.visibility="hidden";
               document.getElementsByName("ContactBO.gender")[0].IsMandatory="false";
               document.getElementsByName("mandStarContactBO.gender")[0].style.visibility="hidden";
               }else {
                document.getElementsByName("ContactBO.salutation")[0].disabled = false;
                document.getElementsByName("ContactBO.firstName")[0].readOnly = false;
                document.getElementsByName("ContactBO.middleName")[0].readOnly = false;
                document.getElementsByName("ContactBO.lastName")[0].readOnly = false;
		/*Tracker ID 113227 Ankit Multilingual changes for Minor lookup SRART  */
		if(altLocaleActv == 'true'){
		document.getElementsByName("ContactBO.firstName_alt1")[0].readOnly = false;
                document.getElementsByName("ContactBO.middleName_alt1")[0].readOnly = false;
                document.getElementsByName("ContactBO.lastName_alt1")[0].readOnly = false;
		}

		/*Tracker ID 113227 Ankit Multilingual changes for Minor lookup SRART  */

                document.getElementsByName("ContactBO.contactsKey")[0].readOnly = false;
                document.getElementsByName("ContactBO.gender")[0].disabled = false;
			// fix for defect id:209637 starts
			if(readMode=='Y')
			{
				document.getElementsByName("ContactBO.DOB")[0].disabled = false;
			}
			else
			{
                document.getElementsByName("3_ContactBO.DOB")[0].disabled = false;
			}
			// fix for defect id:209637 ends
                if(document.getElementsByName("ContactBO.contactsKey")[0].value == "") {
		       if(document.all.isAutoGenKey.value == 'true') {
		       document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "false";
		       document.getElementsByName("ContactBO.contactsKey")[0].disabled = true;
		       }
		       else{
		       document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "true";
		        /* Fix for ticket 255486 and tracker 154577 start*/
		        document.getElementsByName("mandStarContactBO.contactsKey")[0].style.visibility="visible";
		        /* Fix for ticket 255486 and tracker 154577 ends*/
		       }
            	}
            	else{
            	document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "true";
            	 /* Fix for ticket 255486 and tracker 154577 start*/
		    document.getElementsByName("mandStarContactBO.contactsKey")[0].style.visibility="visible";
	
            	}

                	
					/* Fix for ticket 255486 and tracker 154577 ends*/
                document.getElementsByName("ContactBO.salutation")[0].IsMandatory="true";
		document.getElementsByName("mandStarContactBO.salutation")[0].style.visibility="visible";
		document.getElementsByName("ContactBO.gender")[0].IsMandatory="true";
                document.getElementsByName("mandStarContactBO.gender")[0].style.visibility="visible";


                //document.getElementsByName("RelationshipBO.Bank_Entity_Name")[0].IsMandatory =false;
                //document.getElementsByName("mandStarRelationshipBO.Bank_Entity_Name")[0].style.visibility="hidden";

               disableLookup();
                }
	}
        function fvDisableObjectIntro(){
        if(cifType == 'Retail'){
			/* Changes for ticket 336240 starts */
			if(document.getElementsByName("RelationshipBO.Bank_Entity1")[0].value == ''){
			/* Changes for ticket 336240 ends */
		//changes for 371155
		document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = true;
		document.getElementsByName("Cat_"+boName +".IntroducerSalutation")[0].disabled = true;
		document.getElementsByName(boName+".IntroducerSalutation")[0].value='';
		document.getElementsByName("Cat_"+boName+".IntroducerSalutation")[0].value='';
		document.getElementsByName("btnone_"+boName+".IntroducerSalutation")[0].disabled = true;
		document.getElementsByName("btntwo_"+boName+".IntroducerSalutation")[0].disabled = true;
                document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = true;
                document.getElementsByName("AccountBO.IntroducerID")[0].readOnly = true;
                document.getElementsByName(boName +".IntroducerSalutation")[0].IsMandatory="false";
                document.getElementsByName("mandStar" + boName +".IntroducerSalutation")[0].style.visibility="hidden";
                document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory="false";
                document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="hidden";
                document.getElementsByName("AccountBO.IntroducerName")[0].IsMandatory="false";
                document.getElementsByName("mandStarAccountBO.IntroducerName")[0].style.visibility="hidden";

       		document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].IsMandatory =false;
                /* CRM102ST: Tracker ID:182172 Being of Change */
                //document.getElementsByName("mandStarRelationshipBO.Bank_Entity_Name1")[0].style.visibility="visible";
                /* CRM102ST: Tracker ID:182172 End of Change */
		/* Changes for ticket 336240 starts */
		fvClearAllIntro();
		/* Changes for ticket 336240 ends */
                enableLookup();
               }else {
					/* Changes for ticket 371155 */	               	    
                document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = true;
                document.getElementsByName("Cat_"+boName +".IntroducerSalutation")[0].disabled = true;
                //changes done for tracker 393479
		//document.getElementsByName(boName+".IntroducerSalutation")[0].value='';
		//document.getElementsByName("Cat_"+boName+".IntroducerSalutation")[0].value='';
		 //changes done for tracker 393479
		document.getElementsByName("btnone_"+boName+".IntroducerSalutation")[0].disabled = true;
		document.getElementsByName("btntwo_"+boName+".IntroducerSalutation")[0].disabled = true;
                document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = false;

                if(document.getElementsByName("AccountBO.IntroducerID")[0].value == "") {
		       if(document.all.isAutoGenKey.value == 'true') {
		       document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory = "false";
		       }
		       else{
		       document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory = "true";
		       document.getElementsByName("AccountBO.IntroducerID")[0].readOnly = false;
		       /* CRM102ST: Tracker ID:182172 Being of Change */
		       document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="visible";
		       /* CRM102ST: Tracker ID:182172 End of Change */
		       }
            	}
            	else{
            	document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory = "true";
            	}

                /* CRM102ST: Tracker ID:182172 Being of Change */
                //document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="visible";
                /* CRM102ST: Tracker ID:182172 End of Change */
                document.getElementsByName(boName +".IntroducerSalutation")[0].IsMandatory="true";
		document.getElementsByName("mandStar" + boName +".IntroducerSalutation")[0].style.visibility="visible";
				/* Changes for ticket 336240 starts */
				document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="visible";
				/* Changes for ticket 336240 ends */
                document.getElementsByName("mandStarAccountBO.IntroducerName")[0].style.visibility="visible";
                document.getElementsByName("AccountBO.IntroducerName")[0].IsMandatory="true";
                document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].IsMandatory =false;
                document.getElementsByName("mandStarRelationshipBO.Bank_Entity_Name1")[0].style.visibility="hidden";

               disableLookup();
                }
	}
	else if(cifType == 'Corporate')
	{
//Changes for Tracker id 148280 Start
	/* Changes for ticket 336240 starts */
	if(document.getElementsByName("RelationshipBO.Bank_Entity1")[0].value == ""){
	/* Changes for ticket 336240 ends */
					/* Changes for ticket 371155 */	               	    
	 document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = true;
	 document.getElementsByName("Cat_"+boName +".IntroducerSalutation")[0].disabled = true;
		document.getElementsByName(boName+".IntroducerSalutation")[0].value='';
		document.getElementsByName("Cat_"+boName+".IntroducerSalutation")[0].value='';
		document.getElementsByName("btnone_"+boName+".IntroducerSalutation")[0].disabled = true;
		document.getElementsByName("btntwo_"+boName+".IntroducerSalutation")[0].disabled = true;
	 document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = true;
         document.getElementsByName("AccountBO.IntroducerID")[0].readOnly = true;
		 document.getElementsByName(boName +".IntroducerSalutation")[0].IsMandatory="false";
		 document.getElementsByName("mandStar" + boName +".IntroducerSalutation")[0].style.visibility="hidden";
		 document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory="false";
		 document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="hidden";
		 document.getElementsByName("AccountBO.IntroducerName")[0].IsMandatory="false";
		 document.getElementsByName("mandStarAccountBO.IntroducerName")[0].style.visibility="hidden";
		document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].IsMandatory ="true"
	        /* CRM102ST: Tracker ID:182172 Being of Change */
	        //document.getElementsByName("mandStarRelationshipBO.Bank_Entity_Name1")[0].style.visibility="visible";
                /* CRM102ST: Tracker ID:182172 End of Change */
		/* Changes for ticket 336240 starts */
		fvClearAllIntro();
		/* Changes for ticket 336240 ends */
                enableLookup();
	}else{
		/* Changes for ticket 336240 starts */
					/* Changes for ticket 371155*/	               	    
		document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = true;
		document.getElementsByName("Cat_"+boName +".IntroducerSalutation")[0].disabled = true;
		document.getElementsByName(boName+".IntroducerSalutation")[0].value='';
		document.getElementsByName("Cat_"+boName+".IntroducerSalutation")[0].value='';
		document.getElementsByName("btnone_"+boName+".IntroducerSalutation")[0].disabled = true;
		document.getElementsByName("btntwo_"+boName+".IntroducerSalutation")[0].disabled = true;
		/* Changes for ticket 336240 ends */
		document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = false;

		if(document.getElementsByName("AccountBO.IntroducerID")[0].value == "") {
		       if(document.all.isAutoGenKey.value == 'true') {
			 document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory="false";
		       }
		       else{
		       document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory = "true";
		       document.getElementsByName("AccountBO.IntroducerID")[0].readOnly = false;
		       /* CRM102ST: Tracker ID:182172 Being of Change */
		       document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="visible";
		       /* CRM102ST: Tracker ID:182172 End of Change */
		       }
		}
		else{
		document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory = "true";
		}

		/* CRM102ST: Tracker ID:182172 Being of Change */
		//document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="visible";
		/* CRM102ST: Tracker ID:182172 End of Change */
		/* Changes for ticket 336240 starts */
		document.getElementsByName(boName +".IntroducerSalutation")[0].IsMandatory="false";
		document.getElementsByName("mandStar" + boName +".IntroducerSalutation")[0].style.visibility="hidden";
		document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="visible";
		/* Changes for ticket 336240 ends */
		document.getElementsByName("mandStarAccountBO.IntroducerName")[0].style.visibility="visible";
		document.getElementsByName("AccountBO.IntroducerName")[0].IsMandatory="true";
		document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].IsMandatory =false;
	        document.getElementsByName("mandStarRelationshipBO.Bank_Entity_Name1")[0].style.visibility="hidden";

               disableLookup();
	}
	}
	else if((cifType != 'Corporate')&(cifType != 'Retail')){


					/* Changes for ticket 371155*/	               	    
		document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = false;
		document.getElementsByName("Cat_"+boName +".IntroducerSalutation")[0].disabled = false;
		document.getElementsByName("btnone_"+boName+".IntroducerSalutation")[0].disabled = false;
		document.getElementsByName("btntwo_"+boName+".IntroducerSalutation")[0].disabled = false;
		document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = false;

		if(document.getElementsByName("AccountBO.IntroducerID")[0].value == "") {
		       if(document.all.isAutoGenKey.value == 'true') {
		       document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory = "false";
		       }
		       else{
		       document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory = "true";
		       document.getElementsByName("AccountBO.IntroducerID")[0].readOnly = false;
		       }
		}
		else{
		document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory = "true";
		}
		/* Changes for ticket 336240 starts */
		document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="hidden";
		document.getElementsByName(boName +".IntroducerSalutation")[0].IsMandatory="false";
		document.getElementsByName("mandStar" + boName +".IntroducerSalutation")[0].style.visibility="hidden";

		document.getElementsByName("mandStarAccountBO.IntroducerName")[0].style.visibility="hidden";
		document.getElementsByName("AccountBO.IntroducerName")[0].IsMandatory="false";
		document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].IsMandatory =false;
		document.getElementsByName("mandStarRelationshipBO.Bank_Entity_Name1")[0].style.visibility="hidden";
		/* Changes for ticket 336240 ends */
               disableLookup();
//Changes for Tracker id 148280 End
	}
	}
        function fvClearAll(){
        
                entityName = document.getElementsByName("RelationshipBO.Bank_Entity")[0].value;
                document.getElementsByName("ContactBO.salutation")[0].value = '';
                document.getElementsByName("ContactBO.firstName")[0].value = '';
                document.getElementsByName("ContactBO.middleName")[0].value = '';
                document.getElementsByName("ContactBO.lastName")[0].value = '';
                /*Tracker ID 113227 Ankit Multilingual changes for Minor lookup SRART  */
                if(altLocaleActv == 'true'){
                document.getElementsByName("ContactBO.firstName_alt1")[0].value = '';
		document.getElementsByName("ContactBO.middleName_alt1")[0].value = '';
                document.getElementsByName("ContactBO.lastName_alt1")[0].value = '';
                }
                /*Tracker ID 113227 Ankit Multilingual changes for Minor lookup SRART  */
                 document.getElementsByName("ContactBO.contactsKey")[0].value='';
                if(entityName == "")
                	document.getElementsByName("3_ContactBO.DOB")[0].value = '';
                else
                	document.getElementsByName("3_ContactBO.DOB")[0].value = '';
                document.getElementsByName("ContactBO.gender")[0].value = '';
                Dob='';
        }
        function fvClearAllIntro(){
					/* Changes for ticket 371155 */	               	    
            document.getElementsByName("AccountBO.IntroducerName")[0].value = '';
            document.getElementsByName(boName +".IntroducerSalutation")[0].value = '';
           	document.getElementsByName("Cat_"+boName+".IntroducerSalutation")[0].value='';
            document.getElementsByName("AccountBO.IntroducerID")[0].value = '';
			/* Changes for ticket 336240 starts */
			document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value = '';
			document.getElementsByName(boName + ".Introd_Status")[0].value = '';
			/* Changes for ticket 336240 ends */
            document.frm2.hid_bodateCreated.value='';
             document.getElementsByName("AccountBO.StrUserField21")[0].value = '';
             var var1 = document.getElementsByName("RelationshipBO.ChildEntityType")[0].value;
             
            
            if(var1) 
            {
            
             document.getElementsByName("AccountBO.StrUserField21")[0].disabled = true;
            }
            else
            {
            
            document.getElementsByName("AccountBO.StrUserField21")[0].disabled = false;
            }
        }
        function accountLookup() {
             minor="true";
             intro = false;
             TDS = false;
             lookup = document.getElementsByName("RelationshipBO.Bank_Entity")[0].value;
             if (lookup == ""){
                document.getElementsByName("ContactBO.DOB")[0].value = '';
                showUserMessage("MSG_BANKRELFOR","");
             }
            if(lookup == 'CUSTOMER') {
                lookupFor = 'CUSTOMER';
                 accLookUpWin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForAccount',
                         'Lookup',
                         'height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
            }
            /* Changes for Ticket ID 354077 Start */
            if(lookup == 'CONTACT') {
                lookupFor = 'CONTACT';
                 accLookUpWin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForContact',
                 'lookup',
                 'height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');    updateContact = false;
            }
            /* Changes for Ticket ID 354077 End */
            if(lookup == 'PROSPECT') {
                lookupFor = 'PROSPECT';
                 accLookUpWin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForSuspect',
                 'lookup',
                 'height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');    updateContact = false;
            }
        }
        function cifTypeIntro()
        {
        cifType = document.getElementsByName("RelationshipBO.ChildEntityType")[0].value;
			fvClearAllIntro();
document.getElementsByName("RelationshipBO.Bank_Entity1")[0].value = "";
document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value = "";
populateBankEntity();
fvDisableObjectIntro();

	disable_LookUp();

}
function populateBankEntity()
{
//changes for recon tracker 403626
	document.getElementsByName("AccountBO.IntroducerID")[0].readOnly = true;
	document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = true;
var object = document.getElementsByName("RelationshipBO.Bank_Entity1")[0];
	if(cifType == 'Corporate')
	{
		for(var i=0;i<object.length;i++){
			if((object.options[i].value)=="CONTACT"){
				object.remove(i);
			}
		}
	}
	else if(cifType == 'Retail')
	{
	var i;
	var flag;
	for( i=0;i<object.length;i++){
				if((object.options[i].value)=="CONTACT"){
					flag = 'Y';
					break;
				}
				else
				{
				flag = 'N';
				}
		}
		if(flag == 'N')
		{
		        object.options[i] = new Option('CONTACT', 'CONTACT');
		}
	}
}
        function ShowDiv()
        {
            RelationshipInfo.style.visibility="show"
        }
        function disableLookup() {
        	var input = document.getElementsByTagName("input");
        	var count = 0;
            	for(i=0; i<input.length;i++)
            	{
               	    if(input.item(i).type == "button" && input.item(i).value =="LookUp"  ) {
                    break;
                	}
            	}
       	 }
     function enableLookup() {
            var input = document.getElementsByTagName("input");
            var count = 0;
            for(i=0; i<input.length;i++)
            {
                if(input.item(i).type == "button" && input.item(i).value =="LookUp"  ) {
                    input.item(i).disabled=false;
                    input.item(i+1).disabled=false;
                    break;
                }
            }
        }
      function  openAgentLookup (type, bank_id)	{
      			agentLookupType = type;
      			minor="false";
			intro = false;
             		TDS = false;
      			var url;
      			/* Tracker ID 113276 start */
			    var expirationdate = new Date ();
			    expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 60 * 1000));
			    if(type == 'Acc_manager')
					{
					setCookie('agentLookupType', type, expirationdate);
			    		}
      			/* Tracker ID 113276 over */
				/*RMLookup CHANGES START: Using only the RM/AM lookup for Acc Manager instead of all Agents Lookup, as in CorpCIF*/
			if(type == 'Acc_manager' || type == 'Sec_manager' || type == 'Ter_manager'){
				if(typeof bank_id != 'undefined'){
					url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=CorpAM_Lookup&bank_id="+bank_id;
				}
				else{
					url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=CorpAM_Lookup";
				}
			}
			else{
				if(typeof bank_id != 'undefined'){
					url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForAgent&bank_id="+bank_id;
				}
				else{
					url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForAgent";
				}
			}
				/*RMLookup CHANGES END*/
			/* Tracker-id:108379 Changes for centering Lookup BEGIN */
			var wh = 460;
			var ww = 900;
			var left_x = (screen.width - ww) / 2 ;
			var left_y = (screen.height - wh) / 2 ;
      			var style = 'height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes';
      			/*Tracker-id:108379 Changes for centering Lookup END*/
      			window.open (url, "Lookup", style);
      		}
        /* Tracker id 113276 changes start */
	function fnValidateLookupFields(type,entity){
	if(type == "Acc_manager" || type == "Sec_manager" || type == "RelationshipCreatedBy" )
	{
	LookupValidateMgr(type,entity);
	return;
	}
        if(type == "RMID"){
        fnRMID();
        }
        if(type == "RelationshipBO.Bank_Entity_Name"){
        	LookupValidateLastName(type);
        }
}
	function LookupValidateMgr(type,entity)
		   {
		   //changes for the callid 141936 starts
		   		   var expirationdate = new Date ();
		   		   expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 60 * 1000));
		   		    //changes for the callid 141936 ends


		   var manager = "";
		   var Type = "manager";
		   if(type == "Acc_manager")
		   {
		   manager = document.getElementsByName("Acc_manager")[0].value;
		   }
		   else if(type == "Sec_manager")
		   {
		   manager = document.getElementsByName("Sec_manager")[0].value;
		   }
		   else{
		   manager = document.getElementsByName("RelationshipCreatedBy")[0].value;
		   Type = "RelationshipCreatedBy";
		   }
		  /* Ticket Id 209238 - Begin  */
		  /* If the value of lookup is blank then the code should not proceed */
		     if(manager == ""){
		   	   	 return;
		     }
	  	  /* Ticket Id 209238 - End  */
		   var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
		   	var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?Manager='+manager+"&Type="+Type;
		  /* Tracker id 113276 MATT FIX changes start */
		   s_xmlHttp.open("GET",strURL,false);
		   	s_xmlHttp.send();
		   	var lastName = '';
		   	/* CRM102ST:TrackerID:178969 Being of Change */
		   	var clearflag = false;
		   	/* CRM102ST:TrackerID:178969 End of Change */
		   	if(s_xmlHttp.status == 200)
			{
				lastName = getColorCookie('sBoolean');
				//changes for the callid 141936 starts
								//retrieving value of RelationshipMgrID which got from the query
								AccManagerID = getColorCookie('RelationshipMgrID');
								//changes for the callid 141936 ends
		
				var check1 = new Array();
				check1 = lastName.split("^");
				if(check1[0]=='False'){
				  showUserMessage(MSGJ50716,"");
				  /* CRM102ST:TrackerID:178969 Being of Change */
				  clearflag = true;
				  /* CRM102ST:TrackerID:178969 End of Change */
				  if(type == "Acc_manager")
				  {
				  	document.getElementsByName("Acc_manager")[0].value="";
				  }
				  else if(type == "Sec_manager")
				  {
				  	document.getElementsByName("Sec_manager")[0].value="";
				  }
				  //Start:TrackerID 125612
				  else
				  {
				       document.getElementsByName("RelationshipCreatedBy")[0].value="";
				       document.getElementsByName("RelationshipCreatedBy")[0].focus();

				  }
				  //End:TrackerID 125612
				}
		   	}
		   	/* Tracker id 113276 changes end */
		var boName1 ="";
		/*if(entity =="Customer"){
		boName1 = "AccountBO";
		}
		else if(entity == "Contact"){
		boName1 = "ContactBO";
		}
		else if(entity=="Suspect"){
		boName1 = "SuspectBO";
		}*/
		//changes for the callid 141936 starts
				 //deleting previous cookies and then setting values corresponding to manages.
				deleteCookie('LookupLoginID');
				deleteCookie('LookupAgentName');
				deleteCookie('LookupAccManagerID');
				 
				setCookie('LookupLoginID', manager, expirationdate);
				setCookie('LookupAgentName', '', expirationdate);
				setCookie('LookupAccManagerID', AccManagerID, expirationdate);
				
				/* CRM102ST:TrackerID:178969 Being of Change */
				if(!clearflag){
				
					setAgentValues (type, getCookie("LookupAgentName"), getCookie("LookupLoginID"));
				}
				/* CRM102ST:TrackerID:178969 End of Change */
				
				 //changes for the callid 141936 ends
				
		
		//document.getElementsByName("AccountBO.RelationshipMgrID")[0].value = neha[1];
		//alert(' document.getElementsByName("boName1.RelationshipMgrID")[0].value    ' + document.getElementsByName("AccountBO.RelationshipMgrID")[0].value);
		}

      function  fnBluropenAgentLookup (type,entity, bank_id)	{
      var check = chkBlurFrom1();
       if(check)
       {
       fnValidateLookupFields(type,entity);
       return;

       }
       else{
       openAgentLookup(type,bank_id);
       }
 }
    function fnTabOutMinor(){
   		lookup = document.getElementsByName("RelationshipBO.Bank_Entity")[0].value;
   		/* ticket id: 334896  changes Begin */
        var strCIFId4 = '' + document.getElementsByName("ContactBO.lastName")[0].value;
   		 /* ticket id: 334896  changes End */
   		var flag = '';
   		var recFlag='';
   		if(strCIFId4==''){
   			return;
   		}
   	         if (lookup == ""){
   		 	   showUserMessage("MSG_BANKRELFOR","");
   	             }
   		     	if(lookup == 'CUSTOMER' || lookup == 'Customer') {
   			     lookupFor = 'CUSTOMER';
   			 }
   			 if(lookup == 'CONTACT' || lookup == 'Contact') {
   			     lookupFor = 'CONTACT';
   			   }
   			 if(lookup == 'PROSPECT' || lookup == 'Prospect') {
   			     lookupFor = 'PROSPECT';
   				   }
   			      var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
   					var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?cifID='+strCIFId4+"&lookup="+lookupFor+"&RELATION=Minor";
   				s_xmlHttp.open("POST",strURL,false);
   				s_xmlHttp.send();
   				if(s_xmlHttp.status == 200)
   				{
   					recFlag   = getColorCookie('sManyRecords');
   					flag   = getColorCookie('sBooleans');
   					if ((recFlag=="True")){
   					flag='';
   					}
   				}
   				s_xmlHttp.open("GET",strURL,false);
   				s_xmlHttp.send();
			 if(recFlag=='True'){
  				flag=='';
  				document.getElementsByName("ContactBO.firstName")[0].value= "";
  				document.getElementsByName("ContactBO.lastName")[0].value= "";
  				document.getElementsByName("ContactBO.gender")[0].value= "";
  				document.getElementsByName("3_ContactBO.DOB")[0].value= "";
  				document.getElementsByName("ContactBO.contactsKey")[0].value= "";
  				/* ticket id: 334896  changes Begin */
                //document.getElementsByName("RelationshipBO.Bank_Entity_Name")[0].value= "";
  				/* ticket id: 334896  changes End */  
  				  if( lookup == "CUSTOMER" ) {
			    	    	lookupFor = 'CUSTOMER';
			    	  	vMode='ForAccount';
			    	  	}
			    	  else if ( lookup == "CONTACT" ) {
			    	  	lookupFor = 'CONTACT';
			    	  	vMode='ForContact';
			    	  	}
			    	  else if( lookup == "PROSPECT" ) {
			    	  	lookupFor = 'PROSPECT';
			    	  	vMode='ForSuspect';
			    	  	}
			    	  	var strCorpLastName1;
			    	  	var the_length=strCIFId4.length;
					var last_char=strCIFId4.charAt(the_length-1);
					if(last_char=='*'){
					strCorpLastName1=strCIFId4;
					}
			    	  	else{
			    	  	 	strCorpLastName1 = strCIFId4 + '*';
			    	  	 }
			    	  	minor="true";
			    	  	intro = false;
			    	  	TDS = false;
			    	  	wid=900;
			    	  	ht=460;
			    	  	topCord=(screen.height-ht)/2;
			    	  	leftCord=(screen.width-wid)/2;
			    	    	var newwin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode='+vMode+"&lastName="+strCorpLastName1,
			    	    	     'Lookup',
			    	    	     'height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
			    	  }
   			if(flag=='False'){
   					showUserMessage("MSGJ50716","");
   				document.getElementsByName("ContactBO.firstName")[0].value= "";
   				document.getElementsByName("ContactBO.lastName")[0].value= "";
   				document.getElementsByName("ContactBO.gender")[0].value= "";
   				document.getElementsByName("3_ContactBO.DOB")[0].value= "";
   				document.getElementsByName("ContactBO.contactsKey")[0].value= "";
   			/* ticket id: 334896  changes Begin */	
               //document.getElementsByName("RelationshipBO.Bank_Entity_Name")[0].value= "";
   		    /* ticket id: 334896  changes End */	
   			}
   			else if(flag=='True'){
   				var firstname   = getColorCookie('strFirstName');
   				var lastName    = getColorCookie('lastName');
   				var gender      = getColorCookie('gender');
   				var dob         = getColorCookie('dob');
   				var IDcif = getColorCookie('cif');
   				var salutation=getColorCookie('strSaltn');   				
   				 var primaryCustomerID = getColorCookie('cifID');
   				 document.frm2.hid_accountIDvalue.value = primaryCustomerID;
   					if(firstname!= "undefined" && firstname!="null"){	//Changes for 371674
   				document.getElementsByName("ContactBO.firstName")[0].value= firstname;
   					}
   					else{
   					document.getElementsByName("ContactBO.firstName")[0].value= "";
   					}
   				document.getElementsByName("ContactBO.contactsKey")[0].value= IDcif;
   				document.getElementsByName("ContactBO.lastName")[0].value= lastName;
   				document.getElementsByName("ContactBO.gender")[0].value= gender;
   				document.getElementsByName("ContactBO.salutation")[0].value= salutation;
   					if(dob != "undefined"){
   				document.getElementsByName('3_ContactBO.DOB')[0].value = dob;
   					}
   					else
   					{
   					document.getElementsByName('3_ContactBO.DOB')[0].value= "";
   					}
   			    }
        }
   function  fnBlurFunction(Type)
		{
			var check = chkBlurFrom1();
			if(check)
			{
				var manager = "";
				if(Type == "BusinessCenter"){
					manager=document.getElementsByName("AccountBO.accessOwnerBC")[0].value;
					// Change for call id 670127 starts
				}else if(Type == "Tds_cust_id_retail"){
					manager=document.getElementsByName("AccountBO.Tds_cust_id")[0].value;
				}
					// Change for call id 670127 ends
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
					}
				}
			}
			else{
				// Change for call id 670127 starts
				if(Type == "Tds_cust_id_retail"){
					TDS = true;
					lookupFor = 'Customer';
					windowAlign();
					var newwin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForAccount',
    			     'Lookup',
			     'height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
				}else{
					openBCCodeLookup('accessOwnerBC');
				}
				// Change for call id 670127 ends
			}
		}
   function  fnBlurFunctionSus(Type)
		{
			var check = chkBlurFrom1();
			if(check)
			{
				var manager = "";
				if(Type == "BusinessCenter"){
					manager=eval("document.getElementsByName('SuspectBO.accessOwnerBC')[0]").value;
				}
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
					eval("document.getElementsByName('SuspectBO.accessOwnerBC')[0]").value='';
					document.getElementsByName('SuspectBO.accessOwnerBC')[0].focus(); //line added for ticket id 209780
					}
				}
			}
			else{
				openBCCodeLookup('accessOwnerBC')
			}
		}
       /* Tracker id 113276 changes end */
function validateDateMinor(){
		isGregDate("3_ContactBO.DOB");
		if(document.getElementsByName("RelationshipBO.Bank_Entity")[0].value != ''){
		
			document.getElementsByName("3_ContactBO.DOB")[0].value=Dob;
		}
		return;
	}
function clearLookUpMinor()
        {
            
            if(document.getElementsByName("RelationshipBO.Bank_Entity")[0].value!=""){
            document.frm2.hid_accountIDvalue.value = '';
            document.getElementsByName("ContactBO.salutation")[0].value = '';
		/*Tracker Id : 220977 Begin of changes*/
            document.getElementsByName("ContactBO.salutation")[0].disabled = true;
            document.getElementsByName("ContactBO.firstName")[0].value = '';
            document.getElementsByName("ContactBO.firstName")[0].readOnly = true;
            document.getElementsByName("ContactBO.middleName")[0].value = '';
            document.getElementsByName("ContactBO.middleName")[0].readOnly = true;
            document.getElementsByName("ContactBO.lastName")[0].value = '';
            /*Tracker ID 113227 Ankit Multilingual changes for Minor lookup SRART  */
            /* Tracker 159446 : begin of changes */
            if(altLocaleActv =="true"){
	    document.getElementsByName("ContactBO.firstName_alt1")[0].value = '';
            document.getElementsByName("ContactBO.middleName_alt1")[0].value = '';
            document.getElementsByName("ContactBO.lastName_alt1")[0].value = '';
            }
             /* Tracker 159446 : end of changes */
            /*Tracker ID 113227 Ankit Multilingual changes for Minor lookup SRART  */
            document.getElementsByName("ContactBO.gender")[0].value = '';
            document.getElementsByName("ContactBO.gender")[0].disabled = true;
            document.getElementsByName("3_ContactBO.DOB")[0].value='';
            document.getElementsByName("3_ContactBO.DOB")[0].readOnly=true;
		/*Tracker Id : 220977 End of changes*/
            document.getElementsByName("ContactBO.contactsKey")[0].value='';
            Dob='';
          }
          else{
          	//Tracker ID : 225185 , Begin of changes
          	//showMessage(MSGJ0084);
          	//Tracker ID : 225185 , Begin of changes
          	
          	//Tracker ID : 222697 , Begin of changes
          	document.getElementsByName("ContactBO.salutation")[0].disabled = false;
          	document.getElementsByName("ContactBO.salutation")[0].value = '';
		    document.getElementsByName("ContactBO.firstName")[0].value = '';
		    document.getElementsByName("ContactBO.firstName")[0].readOnly = false;
		    document.getElementsByName("ContactBO.middleName")[0].value = '';
		    document.getElementsByName("ContactBO.middleName")[0].readOnly = false;
		    document.getElementsByName("ContactBO.lastName")[0].value = '';
		    document.getElementsByName("ContactBO.lastName")[0].readOnly = false;

		    if(altLocaleActv =="true"){
		    document.getElementsByName("ContactBO.firstName_alt1")[0].value = '';
		    document.getElementsByName("ContactBO.middleName_alt1")[0].value = '';
		    document.getElementsByName("ContactBO.lastName_alt1")[0].value = '';
		    }


		            
		    document.getElementsByName("ContactBO.gender")[0].value = '';
		    document.getElementsByName("ContactBO.gender")[0].disabled = false;
		    document.getElementsByName("3_ContactBO.DOB")[0].value='';
		           
                    document.getElementsByName("3_ContactBO.DOB")[0].readOnly=false;
                    document.getElementsByName("ContactBO.contactsKey")[0].value='';
                 //Tracker ID : 222697 , End of changes
	   }
        }
function clearLookUpIntro()
        {
					/* Changes for ticket 371155*/	               	    
            if(document.getElementsByName("RelationshipBO.Bank_Entity1")[0].value!=""){
            document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value = '';
            document.frm2.hid_accountIDvalue.value = '';
            document.getElementsByName("AccountBO.IntroducerName")[0].value = '';
            document.getElementsByName(boName +".IntroducerSalutation")[0].value = '';
			document.getElementsByName("Cat_"+boName+".IntroducerSalutation")[0].value='';
            document.getElementsByName("AccountBO.IntroducerID")[0].value = '';
          }
          else{
          	showMessage(MSGJ0084);
	   }
	   /*CRM102ST: Tracker ID:182172 Begin of Change */
	   document.getElementsByName(boName+".Introd_Status")[0].value = '';
	   /*CRM102ST: Tracker ID:182172 End of Change */
        }
  function fnBlurAccountLookupIntro(type)	 {
  		var chk1 = chkBlurFrom1();
  		if(chk1== true) {
  		fnTabOutIntro();
  		return;
	        }
                intro= true;
                minor="false";
                TDS = false;
                lookup = document.getElementsByName("RelationshipBO.Bank_Entity1")[0].value;
                 /* Tracker:108379: Changes for centering lookup begin */
   	     var wh = 460;
   	     var ww = 900;
   	     var left_x = (screen.width - ww) / 2 ;
   		var left_y = (screen.height - wh) / 2 ;
                if (lookup == ""){
                   showUserMessage("MSG_BANKRELFOR","");
                }
              /*Tracker id:145001 changes begin*/  
              cifType = document.getElementsByName("RelationshipBO.ChildEntityType")[0].value;
              /*Tracker id:145001 changes end*/ 
              if( cifType == 'Retail')
              {
               if(lookup == 'CUSTOMER') {
                   lookupFor = 'CUSTOMER';
                    accLookUpWin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForAccount',
                            'Lookup',
                            'height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
               }
               if(lookup == 'CONTACT') {
                   lookupFor = 'CONTACT';
                    accLookUpWin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForContact',
                    'lookup',
                    'height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');    updateContact = false;
               }
               if(lookup == 'PROSPECT') {
                   lookupFor = 'PROSPECT';
                    accLookUpWin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForSuspect',
                    'lookup',
                    'height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');    updateContact = false;
               }
              }
               else
               {
               if(lookup == 'CUSTOMER') {
   	                    lookupFor = 'CUSTOMER';
   	                     accLookUpWin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForCorpCust',
   	                             'Lookup',
   	                             'height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars');
   	                }
   	                   if(lookup == 'PROSPECT') {
   	                    lookupFor = 'PROSPECT';
   	                     accLookUpWin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForCorpProspect',
   	                     'lookup',
   	                     'height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');    updateContact = false;
   				/* Tracker:108379: Changes for centering lookup End */
               }
               }
               try{
   		     	document.getElementsByName("AccountBO.Introd_Status")[0].value = 'EXISTING CUSTOMER';
   			}catch(e){
   				try{
   					document.getElementsByName("AccountModBO.Introd_Status")[0].value = 'EXISTING CUSTOMER';
   				}catch(e1){}
   			}
        }
   function fnTabOutIntro(){
   		/*CRM102ST: Tracker ID:182172 Begin of Change */
   		//var cifType  = "";
		/*CRM102ST: Tracker ID:182172 End of Change */
		cifType = document.getElementsByName("RelationshipBO.ChildEntityType")[0].value;
      		lookup = document.getElementsByName("RelationshipBO.Bank_Entity1")[0].value;
		var strCIFId4 = '' + document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value;
		if(strCIFId4=='')
		{
		return;
		}
		var flag = '';
		var recFlag='';
		 if (lookup == ""){
			   showUserMessage("MSG_BANKRELFOR","");
			   /*CRM102ST: Tracker ID:182172 Begin of Change */
			   document.getElementsByName("RelationshipBO.Bank_Entity1")[0].focus();
			   document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value = "";
			   return;
			   /*CRM102ST: Tracker ID:182172 End of Change */
		     }
		     
		     /*Tracker ID 242475 Recon For Ticket ID 398088 start*/
		     			
			var isblacklisted	= "";
			var isnegated		= "";
			var issuspended		= "";
			var AllowBL	= "";
			var AllowNeg		= "";
			var AllowSus		= "";
			/*Changes made for call id 198528; in the below if ladder, we replaced
			the variable lookupFor with lookup*/
			if (lookup == 'CUSTOMER') {
				isblacklisted	= getCookie('LookupAccountBlacklisted');
				isnegated	= getCookie('LookupAccountNegated');
				issuspended	= getCookie('LookupAccountSuspended');
			}
			else if(lookup == 'CONTACT') {
				isblacklisted	= getCookie('LookupContactBlacklisted');
				isnegated	= getCookie('LookupContactNegated');
				issuspended	= getCookie('LookupContactSuspended');	                
			}             
			else if(lookup == 'PROSPECT') {
				isblacklisted	= getCookie('LookupProspectBlacklisted');
				isnegated		= getCookie('LookupProspectNegated');
				issuspended	= getCookie('LookupProspectSuspended');	  
			}
			for (i=0; i<=RetRelValues.length-1;i++) {
				if(RetRelValues[i] =='INTRODUCER')
				{
				AllowBL 	= AllowBlklisted[i];
				AllowNeg	= AllowNegated[i];
				AllowSus	= AllowSuspended[i];
				}
			}
			if(AllowBL == 'N' && isblacklisted == 'Y') {
				showMessage(MSGJ50177);
				self.location.close();
				return;
			}
			if(AllowNeg == 'N' && isnegated == 'Y') {
				showMessage(MSGJ50178);
				self.location.close();
				return;
			}
			if(AllowSus == 'N' && issuspended == 'Y') {
				showMessage(MSGJ50179);
				self.location.close();
				return;
			}

			/*Tracker ID 242475 Recon For Ticket ID 398088 end*/
		     
		    if(cifType == 'RETAIL' || cifType == 'Retail' || cifType == ''){
			if(lookup == 'CUSTOMER' || lookup == 'Customer') {
			     lookupFor = 'CUSTOMER';
			     /*TRACKER ID 125384 CHANGES BEGIN*/
			     var primaryCustomerID = getCookie('AccountID');
			     document.frm2.hid_introIDvalue.value = primaryCustomerID;
			     /*TRACKER ID 125384 CHANGES END*/
			 }
			 if(lookup == 'CONTACT' || lookup == 'Contact') {
			     lookupFor = 'CONTACT';
			     /*TRACKER ID 125384 CHANGES BEGIN*/
			     var primaryContactID = getCookie('ContactID');
	            	     document.frm2.hid_introIDvalue.value = primaryContactID;
			     /*TRACKER ID 125384 CHANGES END*/
			   }
			 if(lookup == 'PROSPECT' || lookup == 'Prospect') {
			     lookupFor = 'PROSPECT';
			     /*TRACKER ID 125384 CHANGES BEGIN*/
			     var primaryProspectID = getCookie('ProspectID');
	            	     document.frm2.hid_introIDvalue.value = primaryProspectID;
			     /*TRACKER ID 125384 CHANGES END*/
				   }
			      var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
			      var RELATION = "nonBene";
			      /* Changes for the ticketid:363569 Starts*/
					//var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?lastName='+strCIFId4+"&lookup="+lookupFor+"&RELATION=Bene&cifType="+cifType;
					var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?lastName='+encodeURIComponent(strCIFId4)+"&lookup="+lookupFor+"&RELATION=Bene&cifType="+cifType;
				  /* Changes for the ticketid:363569 Ends*/
				s_xmlHttp.open("POST",strURL,false);
				s_xmlHttp.send();
				if(s_xmlHttp.status == 200)
				{
					recFlag   = getColorCookie('sManyRecords');
					flag   = getColorCookie('sBooleans');
					if ((recFlag=="True")){
						flag='';
					}
				}
				s_xmlHttp.open("GET",strURL,false);
				s_xmlHttp.send();
  			if(recFlag=='True'){
  				flag=='';
  				document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value='';
  				document.getElementsByName("AccountBO.IntroducerID")[0].value= "";
  				document.getElementsByName("AccountBO.IntroducerName")[0].value= "";
  				  if( lookup == "CUSTOMER" ) {
			    	  	intro= true;
			    	    	lookupFor = 'CUSTOMER';
			    	  	vMode='ForAccount';
			    	  	}
			    	  else if ( lookup == "CONTACT" ) {
			    	  	intro= true;
			    	  	lookupFor = 'CONTACT';
			    	  	vMode='ForContact';
			    	  	}
			    	  else if( lookup == "PROSPECT" ) {
			    	  	intro= true;
			    	  	lookupFor = 'PROSPECT';
			    	  	vMode='ForSuspect';
			    	  	}
			    	  	var strCorpLastName1;
			    	  	var the_length=strCIFId4.length;
					var last_char=strCIFId4.charAt(the_length-1);
					if(last_char=='*'){
					strCorpLastName1=strCIFId4;
					}
			    	  	else{
			    	  	 	strCorpLastName1 = strCIFId4 + '*';
			    	  	 	}
			    	  	wid=900;
			    	  	ht=460;
			    	  	topCord=(screen.height-ht)/2;
			    	  	leftCord=(screen.width-wid)/2;
			    	    	var newwin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode='+vMode+"&lastName="+strCorpLastName1,
			    	    	     'Lookup',
			    	    	     'height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
			    	  }
			if(flag=='False'){
					showUserMessage("MSGJ50716","");
				document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value='';
				//ticket number 209778 Fix :Start
				document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].focus();
                                //ticket number 209778 Fix :End
				document.getElementsByName("AccountBO.IntroducerID")[0].value= "";
				document.getElementsByName("AccountBO.IntroducerName")[0].value= "";
			}
			else if(flag=='True'){
				/* Changes for the ticketid:365744 Starts*/
				var lastName = getColorCookie_decodeURI('strLastName');
				document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value = lastName;
				/* Changes for the ticketid:365744 Ends*/
				var cif_id = getColorCookie('strcifID');
				/*CRM102ST: Tracker ID:182172 Begin of Change */
				var salutation      = getColorCookie_decodeURI('strSaltn');// Fix for the ticketid:365744
				/* Changes for the ticketid:365144 Starts*/
				var primaryID = getColorCookie('LookupAccountID');
				 document.frm2.hid_introIDvalue.value = primaryID;
				/*CRM102ST: Tracker ID:182172 End of Change */
				//defect fix 212739, addtional check for junk value in unix setup
					if(lastName != "undefined" && lastName != '""'){
				document.getElementsByName("AccountBO.IntroducerName")[0].value= lastName;
					}
					/* Changes for the ticketid:365144 Ends*/
					else{
					document.getElementsByName("AccountBO.IntroducerName")[0].value= "";
					}
				document.getElementsByName("AccountBO.IntroducerID")[0].value=cif_id;
				/*CRM102ST: Tracker ID:182172 Begin of Change */
				if(salutation != "undefined"  && salutation != '""'){
					document.getElementsByName(boName +".IntroducerSalutation")[0].value = validationForCookie(salutation);
				}else{
					/* Changes for ticket 371155*/	               	    
					document.getElementsByName(boName+".IntroducerSalutation")[0].value= "";
					document.getElementsByName("Cat_"+boName+".IntroducerSalutation")[0].value='';
				}
				fvDisableObjectIntro();
				/*CRM102ST: Tracker ID:182172 End of Change */
			    }
			}
			 else{
			 if(lookup == 'CUSTOMER') {
			     lookupFor = 'CUSTOMER';
			     /*TRACKER ID 125384 CHANGES BEGIN*/
			     var tempvar = getCookie('LookupCustCorpID');
			     document.frm2.hid_introIDvalue.value = validationForCookie(tempvar);
			     /*TRACKER ID 125384 CHANGES END*/
			}
			    if(lookup == 'PROSPECT') {
			     lookupFor = 'PROSPECT';
			     /*TRACKER ID 125384 CHANGES BEGIN*/
			     var tempvar = getCookie('LookupProspectCorpID');
			     document.frm2.hid_introIDvalue.value = validationForCookie(tempvar);
			     /*TRACKER ID 125384 CHANGES END*/
				}
				var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
				/* Changes for the ticketid:363569 Starts*/
					//var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?lastName='+strCIFId4+"&lookup="+lookupFor+"&RELATION=Bene&cifType="+cifType;
					var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?lastName='+encodeURIComponent(strCIFId4)+"&lookup="+lookupFor+"&RELATION=Bene&cifType="+cifType;
				/* Changes for the ticketid:363569 Ends*/
				s_xmlHttp.open("POST",strURL,false);
				s_xmlHttp.send();
				if(s_xmlHttp.status == 200)
				{
					recFlag   = getColorCookie('sManyRecords');
					flag   = getColorCookie('sBooleans');
					if ((recFlag=="True")){
						flag='';
					}
				}
				s_xmlHttp.open("GET",strURL,false);
				s_xmlHttp.send();
			if(recFlag=='True'){
  				flag=='';
  				document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value='';
  				document.getElementsByName("AccountBO.IntroducerID")[0].value= "";
  				document.getElementsByName("AccountBO.IntroducerName")[0].value= "";
  				  if( lookup == "CUSTOMER" ) {
			    	  	intro= true;
			    	    	lookupFor = 'CUSTOMER';
			    	  	vMode='ForCorpCust';
			    	  	}
			    	  else if( lookup == "PROSPECT" ) {
			    	  	intro= true;
			    	  	lookupFor = 'PROSPECT';
			    	  	vMode='ForCorpProspect';
			    	  	}
			    	  	var strCorpLastName1;
			    	  	var the_length=strCIFId4.length;
					var last_char=strCIFId4.charAt(the_length-1);
					if(last_char=='*'){
					strCorpLastName1=strCIFId4;
					}
			    	  	else{
			    	  	 	strCorpLastName1 = strCIFId4 + '*';
			    	  	 	}
			    	  	wid=900;
			    	  	ht=460;
			    	  	topCord=(screen.height-ht)/2;
			    	  	leftCord=(screen.width-wid)/2;
			    	    	var newwin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode='+vMode+"&lastName="+strCorpLastName1,
			    	    	     'Lookup',
			    	    	     'height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
			    	  }
			if(flag=='False'){
					showUserMessage("MSGJ50716","");
				document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value='';
				document.getElementsByName("AccountBO.IntroducerID")[0].value= "";
				document.getElementsByName("AccountBO.IntroducerName")[0].value= "";
			  }
			else if(flag=='True'){
				/* Changes for the ticketid:365744 Starts*/
				var lastName = getColorCookie_decodeURI('strCorpName');
				document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value = lastName;
				/* Changes for the ticketid:365744 Ends*/
				var cif_id = getColorCookie('strcifID');
				document.getElementsByName("AccountBO.IntroducerID")[0].value= cif_id;
				/* Changes for the ticketid:365144 Starts*/
				var primaryID = getColorCookie('strCorpId');
				document.frm2.hid_introIDvalue.value = primaryID;
				//defect fix 212739, addtional check for junk value in unix setup
				if(lastName != 'undefined' && lastName != '""'){
				document.getElementsByName("AccountBO.IntroducerName")[0].value = lastName;
				}
				/* Changes for the ticketid:365144 Ends*/
				else{
				document.getElementsByName("AccountBO.IntroducerName")[0].value='' ;
				}
			   }
           }
   }
   /* Changes Begin for Tracker 126433 */
   function formatMobile (){
   		 var Phone = document.frm2.elements("AccountBO.SMSBankingMobileNumber").value;
   		 var bPhone=true;
    		for (var k=0;k<Phone.length ;k++ )
   		{
   			if ( !((Phone.charAt(0)=='+' && Phone.length > 1) ||( (Phone.charAt(k) >='0') && (Phone.charAt(k)<='9'))) ){
   						bPhone=false;
   			}
   		}
   		if (!(bPhone)){
   				showUserMessage('MSGJ50161','');
   				/* Changes for Tracker id:300588 starts here */
   				document.frm2.elements("AccountBO.SMSBankingMobileNumber").value='';
   				/* Changes for Tracker id:300588 ends here */
   		}
   }
/* Changes End for Tracker 126433 */
		 //venika changes:start
		function  setAgentValues (type, agentName, loginId)	{
		
		eval("document.frm2." + type).value = loginId;
		if(type=='RelationshipCreatedBy'){
			document.getElementsByName("RelationshipCreatedBy")[0].fireEvent("onChange");
		}
		if(type == 'Acc_manager'){
					Acc_managerURL = getCookie("AgentURL");
		document.getElementsByName("Acc_manager")[0].fireEvent("onChange");
		if(boName=="SuspectBO"){
		document.getElementsByName("SuspectBO.RelationshipMgrID")[0].value = getCookie("LookupAccManagerID");
		document.getElementsByName("SuspectBO.RelationshipMgrID")[0].fireEvent("onChange");
		}else{
			document.getElementsByName("AccountBO.RelationshipMgrID")[0].value = getCookie("LookupAccManagerID");
			//Field Rationalization fix
			
			}

		}
		/* *** Tracker# 89187, End of Changes *** */
		//Field Rationalization fix  start
		else if(type == 'Sec_manager'){
			Sec_managerURL = getCookie("AgentURL");
			document.getElementsByName("Sec_manager")[0].fireEvent("onChange");
		}else if(type == 'Ter_manager'){
			Ter_managerURL = getCookie("AgentURL");
			document.getElementsByName("Ter_manager")[0].fireEvent("onChange");
		}
		//Field Rationalization fix  end
		var primaryRM=document.getElementsByName("Acc_manager")[0].value;
		if(boName=="AccountBO" ||boName=="AccountModBO") {
		var secondaryRM=document.getElementsByName("Sec_manager")[0].value;
		/* CRM102ST:TrackerID:178969 Being of Change */
		if ( (primaryRM!="" && primaryRM != defaultPrimaryRM && primaryRM!=null && primaryRM!="null") || (secondaryRM !="" && secondaryRM != defaultSecondaryRM && secondaryRM !=null && secondaryRM!="null") ) {
		/* CRM102ST:TrackerID:178969 End of Change */
			RMChanged='true';
				}
				else {
					RMChanged='false';
				}
				}else{
				
				if(primaryRM!="" && primaryRM != defaultPrimaryRM && primaryRM!=null && primaryRM!="null") {			
				
							RMChanged='true';
						}
						else {
							RMChanged='false';
		}
				}

		
		//Tracker ID 113276 Changes Start
        //var tertiaryRM=document.getElementsByName("Ter_manager")[0].value;
		//Tracker ID 113276 Changes End
  // if ( (primaryRM!="" && primaryRM != defaultPrimaryRM && primaryRM!=null && primaryRM!="null") || (secondaryRM !="" && secondaryRM != defaultSecondaryRM && secondaryRM !=null && secondaryRM!="null") || (tertiaryRM!="" && tertiaryRM != defaultTertiaryRM && tertiaryRM!=null && tertiaryRM!="null") ) {
	


		}	  
 //venika changes:end
 // changes with TOL : 585289 starts 
   /*function MajorDate(dobDay,dobMonth,dobYear){ 
                           try{ 
                                   var MINOR_YEAR = document.all.MINOR_YEAR.value; 
                                   var majorYear   = parseInt(dobYear) + parseInt(MINOR_YEAR); 
                                   if  (( ( dobYear % 4 == 0 ) && ( ( dobYear % 100 != 0 ) || ( dobYear % 400 == 0 ) ) ) ) 
                                                                   { 
    
    
                                                                   if ( (dobMonth == 2 ) &&  ( dobDay == 29 )) { 
    
                                                                    if  (!( ( majorYear % 4 == 0 ) && ( ( majorYear % 100 != 0 ) || ( majorYear % 400 == 0 ) ) ))  { 
    
                                                                   dobDay =01; 
                                                                   dobMonth=parseInt(dobMonth)+parseInt(1); 
                                                                   } 
    
                                                                   } 
                                   } 
                                   var majorDate   = dobDay + "/" + dobMonth + "/" + majorYear; 
    
                                   return majorDate; 
                           }catch(e){} 
                   }*/ 
