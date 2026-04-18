//--Performance--
//document.write('<script language=javascript src="'+applPath+'/Renderer/cif/js/RetCustFreeAddress.js">'+'<\/script>');
//document.write('<script language=javascript src="'+applPath+'/Renderer/customization/js/DemographicEducationDetailsCustom.js">'+'<\/script>');
//--Performance--
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
document.write('<script type="text/javascript" src="'+applPath+'/cif/js/Message_cif_'+finaclecrmlocale+'.js" language="javascript"></script>');
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/

// Changes for Ticket 297056 - Function for Enabling Close Button : Begin
 function enableClose(){
			try{
				document.getElementsByName("Close")[0].disabled = false;
			}catch(e){
			}
    }
// Changes for Ticket 297056 - Function for Enabling Close Button : End
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
var loadURL = null;
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/

function saveEduDet(){
		//NIDA Changes Start
		//alert("NIDA on save");
		document.getElementsByName('Cat_AccountBO.Address.city')[0].disabled = false;
		document.getElementsByName('Cat_AccountBO.Address.state')[0].disabled = false;
		//NIDA Changes End
   
	try{
		customSaveEduDet();
		
	   }catch(e){
		}
 
    		AddrDetails = new Array();
    
	try{

    		retStat = ValidateFormContents(document.frm2,false);
    
    	if(retStat == "false") {
   		 return "interactive";
    		}
    		/*changes for Ticket ID 487187 Begin*/
    		
    		var v_city = document.getElementsByName("AccountBO.Address.city")[0].value;
    		var v_state = document.getElementsByName("AccountBO.Address.state")[0].value;
    		
    		if(v_city == "" && v_state == "" ){
			   	     
		 	      showMessage(MSG_LOOKUP_INVALID+'City,State');
			   return "interactive";
		}
		else if(v_city == ""){
			   	  	
			   showMessage(MSG_LOOKUP_INVALID+'City');
			//changes for callid 561860 starts
			document.getElementsByName("AccountBO.Address.city")[0].value = "";
			document.getElementsByName('Cat_AccountBO.Address.city')[0].value = "";
			//changes for callid 561860 ends			 
			    return "interactive";
		}
		else if(v_state == ""){
				
				showMessage(MSG_LOOKUP_INVALID+'State');
				//changes for callid 561860 starts
				document.getElementsByName('AccountBO.Address.state')[0].value = "";
				document.getElementsByName('Cat_AccountBO.Address.state')[0].value = "";
				//changes for callid 561860 ends
				return "interactive";
		}
			  	 
						
		/*changes for Ticket ID 487187 End*/
		
	try{
		var strtDt;
		var endDt;
		var res;
		strtDt=document.getElementsByName('AccountBO.Address.Start_Date')[0];
		endDt=document.getElementsByName('AccountBO.Address.End_Date')[0];
		res = Validate_toDate1(strtDt, endDt, true, false);
		//Changes for call id 430311 STARTS
		if (res == false){
		showMessage(getUserErrorMessage ('MSG016', [ strtDt.Display, endDt.Display]));
		return "interactive";
		 }
		//Changes for call id 430311 ENDS
 
		/*var url;
		var res1;
		url=document.getElementsByName('AccountBO.Address.URL')[0];
		URL = url.value;
		res1 = validate_url(url,false,false);
		if (res1 == false){
		 if(URL != ''){
			return "interactive";
			 }
		}
		var email;
		var res32;
		*/

		var ZIP = document.getElementsByName('AccountBO.Address.zip')[0]
      		var zip = trim(ZIP.value);
		if (zip.length > 10){
				showMessage(MSGX0059);
				return "interactive"
			}
			//Fix for Tracker 99537
			var numZip = eval(zip);
			if(numZip == 0){
			var errorMsg = getUserErrorMessage ('MSGNOTEQZERO',MSG_ADDR_ZIP );
			showMessage(errorMsg);
			return "interactive";
			}
			//Fix for Tracker 99537


	}
catch(e){

	
}


	AddrDetails[0] = trim(''+document.getElementsByName('AccountBO.Address.addressCategory')[0].value);
	//Sonali for multi addresses CR
	//changes for the ticket id 305710 starts
	AddrDetails[3] = trim(''+document.getElementsByName('AccountBO.Address.End_Date')[0].value);
	//changes for the ticket id 305710 ends
        AddrDetails[4] = trim(''+document.getElementsByName('3_AccountBO.Address.Start_Date')[0].value);
        AddrDetails[5] = trim(''+document.getElementsByName('AccountBO.Address.city')[0].value);
        AddrDetails[6] = trim(''+document.getElementsByName('AccountBO.Address.country')[0].value);
        AddrDetails[7] = trim(''+document.getElementsByName('AccountBO.Address.state')[0].value);
        AddrDetails[8] = trim(''+document.getElementsByName('AccountBO.Address.zip')[0].value);
        //FIx for Ticket ID 259906
	try{
        AddrDetails[10]= trim(''+AddressID);
        }catch(e)
        {	
        }
        //FIx for Ticket ID 259906
        AddrDetails[17] = document.getElementsByName('city_code')[0].value;
	AddrDetails[18] = document.getElementsByName('state_code')[0].value;
	AddrDetails[19] = document.getElementsByName('country_code')[0].value;
	AddrDetails[20] = document.getElementsByName('AccountBO.Address.PreferredFormat')[0].value;
   	AddrDetails[21] = document.getElementsByName('AccountBO.Address.HoldMailReason')[0].value;
    	AddrDetails[22] = document.getElementsByName('AccountBO.Address.BusinessCenter')[0].value;
    	AddrDetails[23] = document.getElementsByName('AccountBO.Address.HoldMailInitiatedBy')[0].value;
// Tracker 180411 Hold Mail Changes : Begin
    	AddrDetails[24] = document.getElementsByName('AccountBO.Address.HoldMailFlag')[0].value;
// Tracker 180411 Hold Mail Changes : End
// AdressLine changes: START 
     	AddrDetails[25] = document.getElementsByName('AccountBO.Address.address_Line1')[0].value;
        AddrDetails[26] = document.getElementsByName('AccountBO.Address.address_Line2')[0].value;
     	AddrDetails[27] = document.getElementsByName('AccountBO.Address.Address_Line3')[0].value;
// AdressLine changes: END 
        AddrDetails[28] = document.getElementsByName('AccountBO.Address.FreeTextLabel')[0].value;
	AddrDetails[36] = document.getElementsByName('AccountBO.Address.IsAddressProofRcvd')[0].value;
	AddrDetails[34] = document.getElementsByName('AccountBO.Address.LastUpdate_Date')[0].value;
	
	//Sonali for multi addresses CR
	AddrDetails[35] = 'Y';
	// Start of Fix for Ticket:243851  
	AddrDetails[31] = trim(''+document.getElementsByName('Cat_AccountBO.Address.city')[0].value);
        AddrDetails[32] = trim(''+document.getElementsByName('Cat_AccountBO.Address.state')[0].value);
	AddrDetails[33] = trim(''+document.getElementsByName('Cat_AccountBO.Address.country')[0].value);
// changes for Tracker ID 456637 - TOL ID 455246
	AddrDetails[43] = trim(''+document.getElementsByName("AccountBO.Address.addressCategory")[0].options[document.getElementsByName("AccountBO.Address.addressCategory")[0].options.selectedIndex].text);
// changes for Tracker ID 456637 - TOL ID 455246
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
	    var City_Val	= document.getElementsByName('Cat_AccountBO.Address.city')[0].value;
	    var State_Val	= document.getElementsByName('Cat_AccountBO.Address.state')[0].value;
	    var Country_Val	= document.getElementsByName('Cat_AccountBO.Address.country')[0].value;
	try
	{
	    if( (AddressLabel == AddrDetails[28]) && (AddressLine1 == AddrDetails[25]) && (City == City_Val) &&
		(Country == Country_Val) && (State == State_Val) && (PostalCode == AddrDetails[8]) &&
		(AddressLine2 == AddrDetails[26]) && (AddressLine3 == AddrDetails[27])){
		AddrDetails[42] = 'Y';
	    } else{
		if (IsAddProp == 'true'){
		if ( !this.parent.parent.showConfirmMessage(MSGJ51481)) {
				return;
		  }else {
			AddrDetails[42] = 'N';
		  }
		}else{
		  AddrDetails[42] = '';
		}
	    }
	}
	catch(e)
	{
	}
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
	  // End of Fix for Ticket:243851  
	    
// QED Changes: START 

	    var 	isQuickEdit1 = GetCookie('isQuickEdit');
	     if(isQuickEdit1 == 'Yes')
	    {
	    
		if (top.window.opener.addQuickAddrDetails(AddrDetails,true) == 'true') {
			if(document.frm2.isMCEditedGeneralAddress.value=="Y"){
				top.window.opener.setMCAttModifyFlag();
			}
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			if(null != loadURL && '' != loadURL && 'undefined' != loadURL){
				loadURL.close();
			}
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/

			top.window.close();
			top.window.opener.focus();
		}
		else{
		top.window.focus();
		}
	    }
	    else{
	    
	    
            if (top.window.opener.addAddrDetails(AddrDetails, true) == 'true') {

			//if(document.frm2.isMCEditedGeneralAddress.value=="Y"){
				try
				{top.window.opener.setMCAttModifyFlag();
//changes for recon tracker 403626
				}
			catch(e){}
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			if(null != loadURL && '' != loadURL && 'undefined' != loadURL){
				loadURL.close();
			}
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
			top.window.close();
			top.window.opener.focus();
		}
		else{
		top.window.focus();
		}
  	   }	
// QED Changes: END
          
        } catch(e) {
            //showUserMessage('MSG106','MSG_WINDOW');
            top.window.close();
        }
    }

function load(){


try{
//SetCookie("isQuickEdit",isQuickEdit);//Fix for ticket 326990
SetCookie("isQuickEdit",isQuickEdit);//Reverted Fix provided for ticket 350760, Fix for 349460
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
	if('Y' == flag_IsAddressVerified){
		AddressLine1	= document.getElementsByName('AccountBO.Address.address_Line1')[0].value;
		AddressLine2	= document.getElementsByName('AccountBO.Address.address_Line2')[0].value;
		AddressLine3	= document.getElementsByName('AccountBO.Address.address_Line3')[0].value;
		AddressLabel	= document.getElementsByName('AccountBO.Address.FreeTextLabel')[0].value;
		City		= document.getElementsByName("Cat_AccountBO.Address.city")[0].value ;
		State		= document.getElementsByName("Cat_AccountBO.Address.state")[0].value ;
		Country		= document.getElementsByName("Cat_AccountBO.Address.country")[0].value ;
		PostalCode	= document.getElementsByName("AccountBO.Address.zip")[0].value ;
	}
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
SetCookie("AccountBO.Address.country","");
SetCookie("AccountBO.Address.city","");
SetCookie("AccountBO.Address.state","");
/* Begin ** populating start date field with current date */   
                 var locDate = getCurrentDate();   
                          /* Tracker-ID 113259:ERPBOCF1:Hijri:To convert start date to hijri - start */   
    
                                 if(calType=='H')   
                                 {   
                                         locDate = convertGregToHij(locDate);   
                                 }   
                                 
                   /* Tracker - ID 243352 : To set the Start Date as the user choiced date */              
                                 
                         /* Tracker-ID 113259:ERPBOCF1:Hijri:To convert start date to hijri - END */ 
                         
                         if(Startdate == '' || Startdate == "null"){
                         
               document.getElementsByName('3_AccountBO.Address.Start_Date')[0].value = locDate; 
               
               }   
         /* End ** populating start date field with current date */   
  
                    /* Ticket ID 243352 ENDS here */
	
	if(PreferredAddrFormat==null || PreferredAddrFormat==''){
			//selectDrpDwnValue(document.getElementsByName('AccountBO.Address.PreferredFormat')[0],'STRUCTURED_FORMAT');
	}
	
	
	
	 if(isFormatReadOnly == 'Yes')
	     {
		document.getElementsByName('AccountBO.Address.PreferredFormat')[0].disabled = true;
     }
     
     if(readMode != 'Y'){
     
     			if(document.getElementsByName('AccountBO.Address.PreferredFormat')[0].value == "FREE_TEXT_FORMAT")
     			{
     			//disableEnableFreeTextFields(false);
     			//disableEnableStructuredFields(true);
     			}
     			else
     			{
     			//disableEnableStructuredFields(false);
     			//disableEnableFreeTextFields(true);
     			}
         }
         else
         {
         	
                 document.getElementsByName("AccountBO.Address.HoldMailFlag")[0].disabled=true;
                	
    }
    
    
    
// Tracker 180411 Hold Mail Changes : Begin
   /* var holdMailChecked  = document.getElementsByName("AccountBO.Address.HoldMailFlag")[0]; */
       if(holdMailFlag==null || holdMailFlag==''){
           	selectDrpDwnValue(document.getElementsByName('AccountBO.Address.HoldMailFlag')[0],'N');
     	}	
      
       if(holdMailFlag == "Y")
        {
             //holdMailChecked.checked = true;
    	// disableEnableHoldMail();
        }
        else
        {
          //   holdMailChecked.checked = false;
    	document.getElementsByName('AccountBO.Address.HoldMailReason')[0].disabled = true;
    	document.getElementsByName('btnone_AccountBO.Address.BusinessCenter')[0].disabled = true;
    	document.getElementsByName('btntwo_AccountBO.Address.BusinessCenter')[0].disabled = true;
    	document.getElementsByName('AccountBO.Address.BusinessCenter')[0].disabled = true;
        document.getElementsByName('AccountBO.Address.HoldMailInitiatedBy')[0].disabled = true;
             
    	 //disableEnableHoldMail();
        } 
        /* if(holdMailChecked.checked == false )
        {
    	document.getElementsByName('AccountBO.Address.HoldMailReason')[0].disabled = true;
    	document.getElementsByName('btnone_AccountBO.Address.BusinessCenter')[0].disabled = true;
    	document.getElementsByName('btntwo_AccountBO.Address.BusinessCenter')[0].disabled = true;
    	document.getElementsByName('AccountBO.Address.BusinessCenter')[0].disabled = true;
        	document.getElementsByName('AccountBO.Address.HoldMailInitiatedBy')[0].disabled = true;
    } */
	//Sonali for multi addresses CR
document.getElementsByName('AccountBO.Address.LastUpdate_Date')[0].value = LastUpdate_Date;
document.getElementsByName('AccountBO.Address.LastUpdate_Date')[0].disabled = true;	
       //change for callid 389337 begins
       //Changes for call id 414665-recon for 412597 starts
   if(AddrType!=""){
       document.getElementsByName('AccountBO.Address.addressCategory')[0].value =  AddrType;
     }	
     //Changes for call id 414665-recon for 412597 ends
     //change for callid 389337 ends
}catch(e){
}
}
// Tracker 180411 Hold Mail Changes : End

function validateDate(){                           
		try{	   
			    var vStartDate = document.getElementsByName("3_AccountBO.Address.Start_Date")[0];
			    
			    var vEndDate= document.getElementsByName("AccountBO.Address.End_Date")[0];
			    
			    if(vEndDate.value!=''){
			    var millStartDate = changetoMillis(vStartDate.value);
			    var millEndDate = changetoMillis(vEndDate.value); 
			    
			   
			    if (millEndDate < millStartDate){
					showMessage(MSGJ0114);
					vStartDate.value = "";
					vEndDate.value = "";
					return 'false';
				}
			   else{
			   		return 'true';
				}
			
			}
			else
			{
				return 'true';
			
			}
              }
              catch(e){}

       }                                                                



  function cancel(){
    	if ( !this.parent.parent.showConfirmMessage("Are you sure you want to close this operation?")) {
    		return;
	}
        try {
            ProdLookupWindow = null;
            window.close();
            window.opener.focus();
        }catch(e) {
        }
    }
    
    
  function SetLocCookies(){
 
 		onLoadSetLocCookies('AccountBO.Address.city','AccountBO.Address.state','AccountBO.Address.country');
	}  
  
  
/*function categoryLookup('CITY', ''{0}'') {
	 alert('Please implement functionality');
}
function clearCategoryValue(''{0}'') {
	 alert('Please implement functionality');
}
function categoryLookupCode_Location('STATE', 'AccountBO.Address.state','corp_state_code','AccountBO.Address.city','AccountBO.Address.country') {
	 alert('Please implement functionality');
}
function clearLocValue('AccountBO.Address.state','STATE','AccountBO.Address.city') {
	 alert('Please implement functionality');
}
function categoryLookupCode_Location('COUNTRY', 'AccountBO.Address.country','corp_cntry_code','AccountBO.Address.state','AccountBO.Address.city') {
	 alert('Please implement functionality');
}
function clearLocValue('AccountBO.Address.country','COUNTRY','AccountBO.Address.state','AccountBO.Address.city') {
	 alert('Please implement functionality');
}
function fnBlurBccodLookup("BusinessCenter") {
	 alert('Please implement functionality');
}
function clearBCValue('AccountBO.Address.BusinessCenter') {
	 alert('Please implement functionality');
}
function clearLocValue('AccountBO.Address.city','CITY') {
	 alert('Please implement functionality');
}
function categoryLookupCode_Location('STATE', 'AccountBO.Address.state','state_code','AccountBO.Address.city','AccountBO.Address.country') {
	 alert('Please implement functionality');
}
function clearLocValue('AccountBO.Address.state','STATE','AccountBO.Address.city') {
	 alert('Please implement functionality');
}
function categoryLookupCode_Location('COUNTRY', 'AccountBO.Address.country','corp_cntry_code','AccountBO.Address.state','AccountBO.Address.city') {
	 alert('Please implement functionality');
}
function clearLocValue('AccountBO.Address.country','COUNTRY','AccountBO.Address.state','AccountBO.Address.city') {
	 alert('Please implement functionality');
}
function fnBlurBccodLookup("BusinessCenter") {
	 alert('Please implement functionality');
}
function clearBCValue('AccountBO.Address.BusinessCenter') {
	 alert('Please implement functionality');
}
function categoryLookupCode_Location('CITY', 'AccountBO.Address.city','city_code','AccountBO.Address.state','AccountBO.Address.country') {
	 alert('Please implement functionality');
}
function clearLocValue('AccountBO.Address.city','CITY') {
	 alert('Please implement functionality');
}
function categoryLookupCode_Location('STATE', 'AccountBO.Address.state','state_code','AccountBO.Address.city','AccountBO.Address.country') {
	 alert('Please implement functionality');
}
function clearLocValue('AccountBO.Address.state','STATE','AccountBO.Address.city') {
	 alert('Please implement functionality');
}
function categoryLookupCode_Location('COUNTRY', 'AccountBO.Address.country','corp_cntry_code','AccountBO.Address.state','AccountBO.Address.city') {
	 alert('Please implement functionality');
}
function clearLocValue('AccountBO.Address.country','COUNTRY','AccountBO.Address.state','AccountBO.Address.city') {
	 alert('Please implement functionality');
}
function fnBlurBccodLookup("BusinessCenter") {
	 alert('Please implement functionality');
}
function clearBCValue('AccountBO.Address.BusinessCenter') {
	 alert('Please implement functionality');
}
function categoryLookupCode_Location('CITY', 'AccountBO.Address.city','city_code','AccountBO.Address.state','AccountBO.Address.country') {
	 alert('Please implement functionality');
}
function clearLocValue('AccountBO.Address.city','CITY') {
	 alert('Please implement functionality');
}
function categoryLookupCode_Location('STATE', 'AccountBO.Address.state','state_code','AccountBO.Address.city','AccountBO.Address.country') {
	 alert('Please implement functionality');
}
function clearLocValue('AccountBO.Address.state','STATE','AccountBO.Address.city') {
	 alert('Please implement functionality');
}
function categoryLookupCode_Location('COUNTRY', 'AccountBO.Address.country','corp_cntry_code','AccountBO.Address.state','AccountBO.Address.city') {
	 alert('Please implement functionality');
}
function clearLocValue('AccountBO.Address.country','COUNTRY','AccountBO.Address.state','AccountBO.Address.city') {
	 alert('Please implement functionality');
}
function fnBlurBccodLookup("BusinessCenter") {
	 alert('Please implement functionality');
}
function clearBCValue('AccountBO.Address.BusinessCenter') {
	 alert('Please implement functionality');
}
*/
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
/*************************************************************************************
* This function auto populates the fields selecting any record in address results
*************************************************************************************/
function populateAddrResults(addressResults){
	try{
		// Retrive the selected results in to global variables
		HouseNo= addressResults[0].toUpperCase();
		PremiseName= addressResults[1].toUpperCase();
		BuildingLevel= addressResults[2].toUpperCase();
		StreetNo= addressResults[3];
		Suburb= addressResults[4].toUpperCase();
		StreetName= addressResults[5].toUpperCase();
		Locality= addressResults[6].toUpperCase();
		Town= addressResults[7].toUpperCase();
		AddressLabel= addressResults[8].toUpperCase();
		AddressLine1= addressResults[9].toUpperCase();
		AddressLine2= addressResults[10].toUpperCase();
		AddressLine3= addressResults[11].toUpperCase();
		City= addressResults[12].toUpperCase();
		State= addressResults[13].toUpperCase();
		Country= addressResults[14].toUpperCase();
		PostalCode= addressResults[15].toUpperCase();
		UserField1= addressResults[16].toUpperCase();
		UserField2= addressResults[17].toUpperCase();
		UserField3= addressResults[18].toUpperCase();
		UserField4= addressResults[19].toUpperCase();
		UserField5= addressResults[20].toUpperCase();
		UserFieldDate1= addressResults[21];
		UserFieldDate2= addressResults[22];
		// Clearing all the lookup fields before populating
		document.getElementsByName("AccountBO.Address.city")[0].value = '';
		document.getElementsByName("AccountBO.Address.state")[0].value = '';
		document.getElementsByName("AccountBO.Address.country")[0].value = '';
		//Setting cookies for city,state and country
		setLocCookies(City,State,Country,"CITY",'AccountBO.Address.city','AccountBO.Address.state','AccountBO.Address.country');
		setLocCookies(State,Country,null,"STATE",'','AccountBO.Address.state','AccountBO.Address.country');
		setLocCookies(Country,null,null,"COUNTRY",'','','AccountBO.Address.country');

		document.getElementsByName("AccountBO.Address.FreeTextLabel")[0].value = AddressLabel;
		document.getElementsByName("AccountBO.Address.address_Line1")[0].value = AddressLine1;
		document.getElementsByName("AccountBO.Address.address_Line2")[0].value = AddressLine2;
		document.getElementsByName("AccountBO.Address.address_Line3")[0].value = AddressLine3;
		document.getElementsByName("Cat_AccountBO.Address.city")[0].value = City;
		document.getElementsByName("Cat_AccountBO.Address.state")[0].value = State;
		document.getElementsByName("Cat_AccountBO.Address.country")[0].value = Country;
		document.getElementsByName("AccountBO.Address.zip")[0].value = PostalCode;

		// Validation for lookups Just focus and remove focus
		document.getElementsByName("Cat_AccountBO.Address.city")[0].focus();
		document.getElementsByName("Cat_AccountBO.Address.state")[0].focus();
		document.getElementsByName("Cat_AccountBO.Address.country")[0].focus();
		document.getElementsByName("Save")[0].focus();
	}catch(e){
	}
}

 /*****************************************************************************************
 * Description	: On click of search button it will call a function to create a popup
 		  for searching & listing address screen
 ******************************************************************************************/
function searchAddress(){
	var wh = 460;
	var ww = 900;
	var left_x = (screen.width - ww) / 2 ;
	var left_y = (screen.height - wh) / 2 ;
	wh = 660;
	left_y = 330;
	url = '../servlet/com.infy.cis.ui.common.SearchAddressDet';
	loadURL = window.open(url,'AddressList','directories=No, height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars=yes');
	loadURL.focus();

}

/* Postal Address File Changes by Vasanth S01 Ends Here */
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/

