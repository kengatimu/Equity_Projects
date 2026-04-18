//CIF PhoneEmail Changes: Start
//var mainAccId = document.frm2.mainAccId.value;
var ad_addrID           = new Array();
var ad_address_type     = new Array();
var ad_houseno          = new Array();
var ad_premiseno        = new Array();
var ad_end_date         = new Array();
var ad_LastUpdate_Date  = new Array();
var ad_LastUpdate_Flag  = new Array();
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
//Changes for Ticket id 386795 and Tracker id 235375 starts
//Commenting as part of TOL 556629 due to regression issue caused during copy and rectified the fix
//var copyFlag=false;
//Commenting as part of TOL 556629 due to regression issue caused during copy and rectified the fix
//Changes for Ticket id 386795 and Tracker id 235375 ends
var edu_URL             = new Array();
var name="";
var SwiftAddressDetails="";
//	CIF PhoneEmail Changes : Start
var ad_PreferredFormat = new Array();
var ad_HoldMailReason = new Array();
var ad_BusinessCenter = new Array();
var ad_HoldMailInitiatedBy = new Array();
var ad_HoldMailFlag = new Array();

/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
var HouseNo= '';
var PremiseName= '';
var BuildingLevel= '';
var StreetNo= '';
var Suburb= '';
var StreetName= '';
var Locality= '';
var Town= '';
var AddressLabel= '';
var AddressLine1= '';
var AddressLine2= '';
var AddressLine3= '';
var City= '';
var State= '';
var Country= '';
var PostalCode= '';
var UserField1= '';
var UserField2= '';
var UserField3= '';
var UserField4= '';
var UserField5= '';
var UserFieldDate1= '';
var UserFieldDate2= '';
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
// AdressLine changes: START 
var ad_AddressLine1 = new Array();
var ad_AddressLine2 = new Array();
var ad_AddressLine3 = new Array();
// AdressLine changes: END 
var ad_FreeTextLabel = new Array();

//Phone Details
var ad_PhoneOrEmail = new Array();
var ad_PhoneNo = new Array();
var ad_PhoneNoCountryCode = new Array();
var ad_PhoneNoCityCode = new Array();
var ad_PhoneNoLocalCode = new Array();
var ad_PhoneEmailType = new Array();
var ad_PhoneEmailID = new Array();
var ad_Email = new Array();
//	var ad_EmailPalm = new Array();
var phoneEmail_URL = new Array();
var phoneEmail_Status = new Array();
var phone_detachedURLs = new Array();
//	CIF PhoneEmail Changes : End
var ad_IsAddressProofRcvd = new Array();
// changes for Tracker ID 456637 - TOL ID 455246
var ad_vAddTypeLT = new Array();
// changes for Tracker ID 456637 - TOL ID 455246
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
var ad_IsAddressVerified = new Array();
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
var ad_cityCode	   = new Array();
var ad_stateCode	   = new Array();
var ad_cntryCode	   = new Array();

//CORE Fields Inclusion : end
var escChars = new Array(',');
/*Tracker 159095 : Sonali begin of changes*/
var escCharsAddr = new Array('%');
/*Tracker 159095 : Sonali end of changes*/
var updateEduDet = false;
var editMode = false;
var adrWindow = null;
var recordIndex = null;
/* CIF PhoneEmail Changes : Start*/
var phoneRecordIndex = null;
var emailRecordIndex = null;
/* CIF PhoneEmail Changes : End*/
var servletURL = null;
try {
	var selTabId = parent.parent.parent.parent.frames(0).getSelectedTabId();
} catch(e) {
}
 //<!-- House hold ID changes : Begin -->
var lookupFor = '';
//<!-- House hold ID changes : End -->
//Changes for Tracker #292776 begin 
   var checkWinOpen = false; 
           function setcheckWinOpen() 
           { 
               checkWinOpen =false; 
           } 
//Changes for Tracker #292776 end 
 //Country code autopopulation
 function getValue(addresstype){
	var len =ad_address_type.length;
	var country = '';
	for(i=0;i<len;i++){
		if(ad_address_type[i] != null && ad_address_type[i] == addresstype){
			country =ad_country[i];
			break;
		}
	}
	return country;

}
function checkForHoldMailValue(){
	var holdMailFieldsArray = new Array();
	holdMailFieldsArray[0] = document.getElementsByName("AccountBO.Address.HoldMailInitiatedBy")[0].value;
	holdMailFieldsArray[1] = document.getElementsByName("AccountBO.Address.BusinessCenter")[0].value;
	holdMailFieldsArray[2] = document.getElementsByName("AccountBO.Address.HoldMailReason")[0].value;
	for(var j=0;j < holdMailFieldsArray.length;j++)
	{
		if(holdMailFieldsArray[j] != ""){
			return false;
		}
	}
	return true;
}

/*Begin Of Changes, ME Phase 3 Tracker ID:131246
Changes by sonali narula for GCIF LookUp
This function is calling a generic servlet LookUp.java with mode CustQDEGcif*/
 
 function accountLookupGcif() 
 {
		var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=AccountGcif";
		windowAlign();
		window.open (url, "Lookup", "height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
 }
 
/*
Changes by sonali_narula for GCIF LookUp
Disabling GCIF ID Lookup If Not ME deployment or No Functional Privileges have been Given
*/	
function DisableGcifIdLookUp(){
	/*TRACKER ID 131246 CHANGES BEGIN BY Vandana*/
	  //Disabling gcif id lookup by default
	  document.getElementsByName("btnone_AccountBO.GCIFID")[0].disabled = true;
          document.getElementsByName("btntwo_AccountBO.GCIFID")[0].disabled = true;
        
	//Appended an OR condition to disable lookup in edit and view mode
	/*Ticket Id 228921 Changes Begin*/
	if(document.frm2.hid_accountURL.value== "") {
		//Enable Lookup only if User has access and ME Deployment is supported
		if((bGcifIdAccess == "true" && bMultiEntity=="true") ){
	/*TRACKER ID 131246 CHANGES END BY Vandana*/
		document.getElementsByName("btnone_AccountBO.GCIFID")[0].disabled = false;
		document.getElementsByName("btntwo_AccountBO.GCIFID")[0].disabled = false;
	}
}
	/*Ticket Id 228921 Changes End*/
}


/*This function is deafulting values to some textboxes for which the cookies are being set*/
function onRecordSelectCust() 
{
	document.getElementsByName("AccountBO.Cust_First_Name")[0].value = getCookie('LookupGcifFirstName');		
	document.getElementsByName("AccountBO.Cust_Last_Name")[0].value = getCookie('LookupGcifLastName');
	document.getElementsByName("AccountBO.Cust_Middle_Name")[0].value = getCookie('LookupGcifMiddleName');
	document.getElementsByName("AccountBO.short_name")[0].value = getCookie('LookupGcifShortName');		
	document.getElementsByName("3_AccountBO.Cust_DOB")[0].value = getCookie('LookupGcifDOB');
	document.getElementsByName("Acc_manager")[0].value = getCookie('LookupGcifPrimaryRelMgr');
	document.getElementsByName("Sec_manager")[0].value = getCookie('LookupGcifSecondaryRelMgr');
	document.getElementsByName("AccountBO.GCIFID")[0].value = getCookie('LookupGcifID');	
	//document.getElementsByName("AccountBO.gcifId")[0].value = getCookie('LookupGcifID');
	document.getElementsByName("AccountBO.Address.preferredAddress")[0].value = getCookie('LookupGcifAddressType');
	document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value = getCookie('LookupGcifPhoneEmailType');
	//FIX for ticket 245626 BEGINS
	document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value = getCookie('LookupGcifPhoneEmailType1');
	//FIX for ticket 245626 ENDS
	clearCookie();	
	
}

function clearCookie()
{				      
	/*TRACKER ID 131246 CHANGES BEGIN*/
	//Remove the expiration time while clearing cookies
	setCookie('LookupGcifFirstName', "");
	setCookie('LookupGcifLastName',"");	
	setCookie('LookupGcifMiddleName',"");
	setCookie('LookupGcifShortName',"");
	setCookie('LookupGcifDOB',"");
	setCookie('LookupGcifPrimaryRelMgr',"");	
	setCookie('LookupGcifSecondaryRelMgr', "");
	setCookie('LookupGcifID',"");
	setCookie('LookupGcifAddressType',"");
	setCookie('LookupGcifPhoneEmailType',"");
	//FIX for ticket 245626 BEGINS
	setCookie('LookupGcifPhoneEmailType1',"");
	//FIX for ticket 245626 ENDS
	/*TRACKER ID 131246 CHANGES END*/
	savePersistData();
}
/*Tracker ID:131246 End of Changes by sonali narula for GCIF LookUp*/

// This method will clear all holdMail Values
function clearHoldMailValues()
{
	
	document.getElementsByName("AccountBO.Address.HoldMailInitiatedBy")[0].value = "";
	document.getElementsByName("AccountBO.Address.BusinessCenter")[0].value = "";
	document.getElementsByName("AccountBO.Address.HoldMailReason")[0].value = "";
}






// Tracker 180411 Hold Mail Changes : Begin
function disableEnableHoldMail(){


   //making HoldMail Fields Disabled
   if(document.getElementsByName("AccountBO.Address.HoldMailFlag")[0].value == "N")
   {
	
	//varun changes
	//clearHoldMailValues();
	//varun ends
	var flag = true;
	flag = checkForHoldMailValue();
	if(!flag)
	{
		holdMailConfirmFlag = showConfirmMessage(MSGJ50270);
		if(holdMailConfirmFlag == true)
		{
			clearHoldMailValues();
		}
		else
		{
			document.getElementsByName("AccountBO.Address.HoldMailFlag")[0].value = "Y";
			return;
		}

	}

	document.getElementsByName("AccountBO.Address.HoldMailInitiatedBy")[0].disabled = true;
	document.getElementsByName("AccountBO.Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName("btnone_AccountBO.Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName("btntwo_AccountBO.Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName("AccountBO.Address.HoldMailReason")[0].disabled = true;

	document.getElementsByName("mandStarAccountBO.Address.HoldMailInitiatedBy")[0].style.visibility="hidden";
	document.getElementsByName("mandStarAccountBO.Address.BusinessCenter")[0].style.visibility="hidden";
	document.getElementsByName("mandStarAccountBO.Address.HoldMailReason")[0].style.visibility="hidden";

	document.getElementsByName("AccountBO.Address.HoldMailInitiatedBy")[0].IsMandatory = "false";
	document.getElementsByName("AccountBO.Address.BusinessCenter")[0].IsMandatory = "false";
	document.getElementsByName("AccountBO.Address.HoldMailReason")[0].IsMandatory = "false";


   }
   //making HoldMail Fields Enabled
   else if(document.getElementsByName("AccountBO.Address.HoldMailFlag")[0].value =="Y" )
   {	
	document.getElementsByName("AccountBO.Address.HoldMailInitiatedBy")[0].disabled = false;
	document.getElementsByName("AccountBO.Address.BusinessCenter")[0].disabled = false;
	document.getElementsByName("btntwo_AccountBO.Address.BusinessCenter")[0].disabled = false;
	document.getElementsByName("btnone_AccountBO.Address.BusinessCenter")[0].disabled = false;
	document.getElementsByName("AccountBO.Address.HoldMailReason")[0].disabled = false;

	document.getElementsByName("mandStarAccountBO.Address.HoldMailInitiatedBy")[0].style.visibility="visible";
	document.getElementsByName("mandStarAccountBO.Address.BusinessCenter")[0].style.visibility="visible";
	document.getElementsByName("mandStarAccountBO.Address.HoldMailReason")[0].style.visibility="visible";

	document.getElementsByName("AccountBO.Address.HoldMailInitiatedBy")[0].IsMandatory = "true";
	document.getElementsByName("AccountBO.Address.BusinessCenter")[0].IsMandatory = "true";
	document.getElementsByName("AccountBO.Address.HoldMailReason")[0].IsMandatory = "true";


   }
   else{
   	   
   		document.getElementsByName("AccountBO.Address.HoldMailInitiatedBy")[0].disabled = true;
   		document.getElementsByName("AccountBO.Address.BusinessCenter")[0].disabled = true;
   		document.getElementsByName("btnone_AccountBO.Address.BusinessCenter")[0].disabled = true;
   		document.getElementsByName("btntwo_AccountBO.Address.BusinessCenter")[0].disabled = true;
   		document.getElementsByName("AccountBO.Address.HoldMailReason")[0].disabled = true;
   
   		document.getElementsByName("mandStarAccountBO.Address.HoldMailInitiatedBy")[0].style.visibility="hidden"; 
   		document.getElementsByName("mandStarAccountBO.Address.BusinessCenter")[0].style.visibility="hidden"; 
   		document.getElementsByName("mandStarAccountBO.Address.HoldMailReason")[0].style.visibility="hidden"; 
   
   		document.getElementsByName("AccountBO.Address.HoldMailInitiatedBy")[0].IsMandatory = "false";
   		document.getElementsByName("AccountBO.Address.BusinessCenter")[0].IsMandatory = "false";
   		document.getElementsByName("AccountBO.Address.HoldMailReason")[0].IsMandatory = "false";
   	   
   	   
	   }

}
// Tracker 180411 Hold Mail Changes : End

function checkFormatForAddressType(){
	todayStart_date = 	document.getElementsByName("3_AccountBO.Address.Start_Date")[0];
	/* Tracker-ID 113259:ERPBOCF1:Hijri:to convert start date to Hijri date format - START*/
	//todayStart_date.value = getCurrentDate();
	//getting current date from system and converting it to  date format  selected by user 
	var current_Date = getCurrentDate();
//	 Tracker-ID 113259:ERPBOCF1:Hijri cr :changes start
	//if the selected calendar type is Hijri,current date is converted in the Hijr format
	//if(calType == 'H')  
if((current_Date!= '') && (current_Date != undefined))

	{
	//date converted acc to the present calendar type 
	current_Date = changeDateAccToPresentCalendar(current_Date);
	//current_Date = convertGregToHij(current_Date);	   
//	 Tracker-ID 113259:ERPBOCF1:Hijri cr :changes end
	}
	todayStart_date.value = current_Date;
	
	/* Tracker-ID 113259:ERPBOCF1:Hijri:to convert start date to Hijri date format - END*/
	//	var selectedFormat = document.getElementsByName("AccountBO.Address.PreferredFormat")[0].value;
/*
	var selectedAddressType = document.getElementsByName("AccountBO.Address.addressCategory")[0].value;
	var tempSelectedAddressType = document.getElementsByName('AccountBO.Address.addressCategory')[0].options[document.getElementsByName('AccountBO.Address.addressCategory')[0].selectedIndex].text;
	var format = top.window.opener.checkFormatForAddressTypeSelected(selectedAddressType);
	
	if(format != null && format != "")
	{
		if(format != document.getElementsByName('AccountBO.Address.PreferredFormat')[0].value)
		{
			var tmpArr = new Array();
			tmpArr[0] = tempSelectedAddressType;
			if(format == "FREE_TEXT_FORMAT"){
				tmpArr[1] = MSGJ50298;
			}
			else{
				tmpArr[1] = MSGJ50299;
			}
			showUserMessage(MSGJ50261,tmpArr);
		}
		document.getElementsByName('AccountBO.Address.PreferredFormat')[0].value = format;
		if(format == "FREE_TEXT_FORMAT")
		{
			//enabling free Text Label And Format
			//disableEnableFreeTextFields(false);

			//disabling structured field formats
			//disableEnableStructuredFields(true);
			//clearing Structured Values
			//clearStructuredValues();
		}
		else
		{
			//disabling free Text Label And Format
			//disableEnableFreeTextFields(true);
			//clearing free text Values
			//clearFreeTextValues();

			//enabling structured field formats
			//disableEnableStructuredFields(false);
		}
	}*/
	//Changes for Ticket 725047 begin
	populateHoldMail(document.getElementsByName("AccountBO.Address.addressCategory")[0].value);
	//Changes for Ticket 725047 ends

}

function disableEnableFreeTextAddress(){
// changes for ticketId : 366401 
var isQuickEdit=GetCookie("isQuickEdit");

// changes for ticketId : 366401 ends
	var selectedFormat = document.getElementsByName("AccountBO.Address.PreferredFormat")[0].value;
	var selectedAddressType = document.getElementsByName("AccountBO.Address.addressCategory")[0].value;
	var tempSelectedAddressType = document.getElementsByName('AccountBO.Address.addressCategory')[0].options[document.getElementsByName('AccountBO.Address.addressCategory')[0].selectedIndex].text;

	//Changes for CRM10202Beta Ticket 324814 Tracker 199141 : Begin
	/*if(selectedFormat != null && selectedFormat !="")
	{
		var flag = top.window.opener.checkFormatSelected(selectedFormat,selectedAddressType);
		
		if(flag != null || flag != "")
		{
			
			if(flag != selectedAddressType)
			{
				
				var tmpArr = new Array();
				tmpArr[0] = tempSelectedAddressType;
				if(flag == "FREE_TEXT_FORMAT"){
					
					tmpArr[1] = MSGJ50298;
				}
				else{
					
					tmpArr[1] = MSGJ50299;
				}
				showUserMessage(MSGJ50261,tmpArr);
				document.getElementsByName('AccountBO.Address.addressCategory')[0].value = flag;
			}
		}
		else if(flag == null  && (selectedAddressType != null || selectedAddressType != ""))
		{
			checkFormatForAddressType();
		}
	}
	else
	{
		return false;
	}*/

	//Changes for CRM10202Beta Ticket 324814 Tracker 199141  :End
  	//var preferredformat = null;
  	var preferredformat;
	var confirmFlag = true;
	//if(!checkForValue(document.getElementsByName("AccountBO.Address.PreferredFormat")[0].value))
	//{
		confirmFlag = showConfirmMessage(MSGJ50262);
		if(confirmFlag == true)
		{
			clearAddressValues();
		}
		else
		{
			if(selectedFormat == "STRUCTURED_FORMAT")
				document.getElementsByName("AccountBO.Address.PreferredFormat")[0].value = "FREE_TEXT_FORMAT";
			else
				document.getElementsByName("AccountBO.Address.PreferredFormat")[0].value = "STRUCTURED_FORMAT";
		}
	//}
	if(document.getElementsByName("AccountBO.Address.PreferredFormat")[0].value == "STRUCTURED_FORMAT" && confirmFlag)
	{
		//disabling free Text Label And Format
		//disableEnableFreeTextFields(true);

		//enabling structured field formats
		//disableEnableStructuredFields(false);
	preferredformat = "STRUCTURED_FORMAT";
	/* Changes for tracker 182231 starts */
//	self.location.href = "../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?PreferredFormat="+preferredformat+"&addrID="+AddressID+"&isQuickEdit=No";//Fix for 350760
	self.location.href = "../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?PreferredFormat="+preferredformat+"&addrID="+AddressID+"&isQuickEdit="+isQuickEdit;//Fix for 350760 // changes for ticketId : 366401 

	/* Changes for tracker 182231 ends */

	}
	else if(document.getElementsByName("AccountBO.Address.PreferredFormat")[0].value == "FREE_TEXT_FORMAT" && confirmFlag)
	{
		//enabling free Text Label And Format
		//disableEnableFreeTextFields(false);

		//disabling structured field formats
		//disableEnableStructuredFields(true);
   		preferredformat = "FREE_TEXT_FORMAT";
		/* Changes for tracker 182231 starts */
//		self.location.href = "../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?PreferredFormat="+preferredformat+"&addrID="+AddressID+"&isQuickEdit=No";//Fix for 350760
		self.location.href = "../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?PreferredFormat="+preferredformat+"&addrID="+AddressID+"&isQuickEdit="+isQuickEdit;//Fix for 350760 // changes for ticketId : 366401

		/* Changes for tracker 182231 ends */
	}
}

// Tracker 180411 Hold Mail Changes : End

function clearAddressValues(selectedPreferredFormat){

	 if(selectedPreferredFormat == "FREE_TEXT_FORMAT")
     {
	document.getElementsByName("Cat_AccountBO.Address.city")[0].value = "";
	document.getElementsByName("Cat_AccountBO.Address.country")[0].value = "";
	//Field Rationalization fix
	document.getElementsByName("AccountBO.Address.country")[0].value = "";
	document.getElementsByName("Cat_AccountBO.Address.state")[0].value = "";
	document.getElementsByName("AccountBO.Address.zip")[0].value = "";
	document.getElementsByName("AccountBO.Address.FreeTextLabel")[0].value = "";
	document.getElementsByName("AccountBO.Address.address_Line1")[0].value = "";
	document.getElementsByName("AccountBO.Address.address_Line2")[0].value = "";
	document.getElementsByName("AccountBO.Address.Address_Line3")[0].value = "";
 	document.getElementsByName("AccountBO.Address.Start_Date")[0].value = "";
	document.getElementsByName("AccountBO.Address.End_Date")[0].value = "";
	document.getElementsByName("AccountBO.Address.LastUpdate_Date")[0].value = "";
	document.getElementsByName("AccountBO.Address.HoldMailReason")[0].value = "";
	}
      else if(selectedPreferredFormat == "STRUCTURED_FORMAT"){
	
	document.getElementsByName("Cat_AccountBO.Address.city")[0].value = "";
	document.getElementsByName("Cat_AccountBO.Address.country")[0].value = "";
	document.getElementsByName("AccountBO.Address.country")[0].value = "";
	document.getElementsByName("Cat_AccountBO.Address.state")[0].value = "";
	document.getElementsByName("AccountBO.Address.zip")[0].value = "";
	document.getElementsByName("AccountBO.Address.house_no")[0].value = "";
	document.getElementsByName("AccountBO.Address.premise_name")[0].value = "";
	document.getElementsByName("AccountBO.Address.building_level")[0].value = "";
	document.getElementsByName("AccountBO.Address.street_no")[0].value = "";
	document.getElementsByName("AccountBO.Address.suburb")[0].value = "";
	document.getElementsByName("AccountBO.Address.street_name")[0].value = "";
	document.getElementsByName("AccountBO.Address.locality_name")[0].value = "";
	document.getElementsByName("AccountBO.Address.town")[0].value = "";
	document.getElementsByName("AccountBO.Address.Start_Date")[0].value = "";
	document.getElementsByName("AccountBO.Address.End_Date")[0].value = "";
	document.getElementsByName("AccountBO.Address.LastUpdate_Date")[0].value = "";
	document.getElementsByName("AccountBO.Address.HoldMailReason")[0].value = "";
	}
}

function disableEnableFreeTextFields(value){
	document.getElementsByName("AccountBO.Address.FreeTextLabel")[0].disabled = value;
// AdressLine changes: START
	document.getElementsByName("AccountBO.Address.address_Line1")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.address_Line2")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.Address_Line3")[0].disabled = value;
// AdressLine changes: END

	//making FreeTextFields mandatory
	if(value == false)
	{
		document.getElementsByName("AccountBO.Address.FreeTextLabel")[0].IsMandatory = "true";
// AdressLine changes: START
		document.getElementsByName("AccountBO.Address.address_Line1")[0].IsMandatory = "true";

		document.getElementsByName("mandStarAccountBO.Address.FreeTextLabel")[0].style.visibility="visible";
		document.getElementsByName("mandStarAccountBO.Address.address_Line1")[0].style.visibility="visible";
// AdressLine changes: END
	}
	//making FreeTextFields Non-Mandatory
	else
	{
		document.getElementsByName("AccountBO.Address.FreeTextLabel")[0].IsMandatory = "false";
// AdressLine changes: START
		document.getElementsByName("AccountBO.Address.address_Line1")[0].IsMandatory = "false";

		document.getElementsByName("mandStarAccountBO.Address.FreeTextLabel")[0].style.visibility="hidden";
		document.getElementsByName("mandStarAccountBO.Address.address_Line1")[0].style.visibility="hidden";
// AdressLine changes: END
	}
}

function disableEnableStructuredFields(value){
	document.getElementsByName("btnone_AccountBO.Address.city")[0].disabled = value;
	document.getElementsByName("btntwo_AccountBO.Address.city")[0].disabled = value;
	document.getElementsByName("btnone_AccountBO.Address.country")[0].disabled = value;
	document.getElementsByName("btntwo_AccountBO.Address.country")[0].disabled = value;
	document.getElementsByName("btnone_AccountBO.Address.state")[0].disabled = value;
	document.getElementsByName("btntwo_AccountBO.Address.state")[0].disabled = value;
	document.getElementsByName("Cat_AccountBO.Address.state")[0].disabled = value;
	document.getElementsByName("Cat_AccountBO.Address.country")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.country")[0].disabled = value;
	document.getElementsByName("Cat_AccountBO.Address.city")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.zip")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.house_no")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.premise_name")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.building_level")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.street_no")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.suburb")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.street_name")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.locality_name")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.town")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.domicile")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.mailStop")[0].disabled = value;
	document.getElementsByName("AccountBO.Address.URL")[0].disabled = value;

	//making StructuredFields mandatory
	if(value == false)
	{
		document.getElementsByName("Cat_AccountBO.Address.city")[0].IsMandatory = "true";
		document.getElementsByName("AccountBO.Address.house_no")[0].IsMandatory = "true";
		document.getElementsByName("Cat_AccountBO.Address.country")[0].IsMandatory = "true";
		document.getElementsByName("Cat_AccountBO.Address.state")[0].IsMandatory = "true";
		document.getElementsByName("AccountBO.Address.zip")[0].IsMandatory = "true";
		document.getElementsByName("AccountBO.Address.street_name")[0].IsMandatory = "true";
		document.getElementsByName("AccountBO.Address.street_no")[0].IsMandatory = "true";

		document.getElementsByName("mandStarAccountBO.Address.city")[0].style.visibility="visible";
		document.getElementsByName("mandStarAccountBO.Address.house_no")[0].style.visibility="visible";
		document.getElementsByName("mandStarAccountBO.Address.street_name")[0].style.visibility="visible";
		document.getElementsByName("mandStarAccountBO.Address.street_no")[0].style.visibility="visible";
		document.getElementsByName("mandStarAccountBO.Address.country")[0].style.visibility="visible";
		document.getElementsByName("mandStarAccountBO.Address.state")[0].style.visibility="visible";
		document.getElementsByName("mandStarAccountBO.Address.zip")[0].style.visibility="visible";


	}
	//making StructuredFields Non-Mandatory
	else
	{
		document.getElementsByName("Cat_AccountBO.Address.city")[0].IsMandatory = "false";
		document.getElementsByName("AccountBO.Address.house_no")[0].IsMandatory = "false";
		document.getElementsByName("Cat_AccountBO.Address.country")[0].IsMandatory = "false";
		document.getElementsByName("Cat_AccountBO.Address.state")[0].IsMandatory = "false";
		document.getElementsByName("AccountBO.Address.zip")[0].IsMandatory = "false";
		document.getElementsByName("AccountBO.Address.street_name")[0].IsMandatory = "false";
		document.getElementsByName("AccountBO.Address.street_no")[0].IsMandatory = "false";

		document.getElementsByName("mandStarAccountBO.Address.city")[0].style.visibility="hidden";
		document.getElementsByName("mandStarAccountBO.Address.house_no")[0].style.visibility="hidden";
		document.getElementsByName("mandStarAccountBO.Address.street_name")[0].style.visibility="hidden";
		document.getElementsByName("mandStarAccountBO.Address.street_no")[0].style.visibility="hidden";
		document.getElementsByName("mandStarAccountBO.Address.country")[0].style.visibility="hidden";
		document.getElementsByName("mandStarAccountBO.Address.state")[0].style.visibility="hidden";
		document.getElementsByName("mandStarAccountBO.Address.zip")[0].style.visibility="hidden";
	}
}

/* 113276 changes start */
function fnBusinessCenter(type)
{
	   var manager = "";
	   
	   manager = document.getElementsByName("AccountBO.Address.BusinessCenter")[0].value;
	     /* Ticket Id 209238 - Begin  */
	   	    /* If the value of lookup is blank then the code should not proceed */
	   	       if(manager == ""){
	   	  				return;
	   	  	}
	  	  /* Ticket Id 209238 - End  */
	    var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
	   
	   	var Type = "BusinessCenter";
	   	var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?Manager='+manager+"&Type="+Type;
	   	s_xmlHttp.open("GET",strURL,false);
	   	s_xmlHttp.send();
	   	var lastName = '';
	   	if(s_xmlHttp.status == 200)
		{
			lastName = s_xmlHttp.responseXML.text;
			if(lastName=='False'){
				showUserMessage(MSGJ50716,"");
				document.getElementsByName("AccountBO.Address.BusinessCenter")[0].value='';
			}
			
		
	   	}	   	
					      	

}

function fnValidateLookupBC(type){

if(type == "AccountBO.Address.BusinessCenter"){
        fnBusinessCenter(type);
	}
}
function  fnBlurlookupBC (type){
var check = chkBlurFrom1();
       if(check)
       {
       fnValidateLookupBC(type);
       return;
       }
       else{
       

       
bcLookupType = type;
var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForBCCode&isActive=Y&isAutomated=Y";
//var url = '../servlet/com.infy.cis.ui.common.SimpleLookupFilter?isActive=Y&isAutomated=N&ViewName=BCCode_Lookup';
/* Tracker: 108382: Changes for centering popup */
windowAlign();
var style = "height="+ wh+ ",left="+ left_x +",top="+ left_y+",width="+ww+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes";
/* Tracker: 108382: End of Changes */
window.open (url, "Lookup", style);
}
}
  /* 113276 changes end */
//CIF PhoneEmail Changes: End
/*function removeAddress()
{
    try{
        var EduDetURL = '';
        var addrID = '';
        if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
		showUserMessage("MSG158",'MSGJ0120');
		return;
        }
        for (i=0; i < document.all.RecordSet.rows.length ; i++)
        {
            var row_bgcolor = document.all.RecordSet.rows(i).className;
            if ( row_bgcolor == 'rowHighLighted')
            {
		//Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName=='AccountBO'){
		      EduDetURL = document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.url_");
		}else if(boName=='AccountModBO'){
		      EduDetURL = document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.url_");
		}
		//Tracker ID: 135125: XMLEncoding Changes ENDS
		if(showUserChoiceMessage('MSG045', 'MSG_LOROW')) {
			noOfAttachURLs = edu_URL.length;
			var deleteAlreadyExistingEduDet = true;
			for(r=0; r< noOfAttachURLs; r++) {
			    if(edu_URL[r] == EduDetURL){
				if(edu_Status[r] != "Add") {
				    deleteAlreadyExistingEduDet = false;
				}
				edu_URL[r] = null;
				//changes by Suman for making mailing address mandatory in edit
				ad_address_type[r]=null;
				edu_Status[r] = "Remove";
				addrID = ad_addrID[r];
				break;
			    }
			}
			document.all.RecordSet.deleteRow(i);
			if( (EduDetURL == null) || (EduDetURL == 'undefined')) {
			    EduDetURL= "";
			}
			if(deleteAlreadyExistingEduDet) {
			    edu_detachedURLs[edu_detachedURLs.length] = addrID;
			}
		    }
		}
        }
    }catch(e){
    }
}*/



function removeAddress(){

	var EduDetURL = '';
	var addrID = '';
	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
		showUserMessage("MSG158",'MSGJ0120');
		return;
        }

	for (i=0; i < document.all.RecordSet.rows.length ; i++){
	    var row_bgcolor = document.all.RecordSet.rows(i).className;
	    if ( row_bgcolor == 'rowHighLighted')
	    {
			//Tracker ID: 135125: XMLEncoding Changes STARTS
	    	var temp='';
	    	if(boName=='AccountBO'){
	    		temp=document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.addressCategory");
	    	}else if(boName=='AccountModBO'){
	    		temp=document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.addressCategory");
	    	}
			//Tracker ID: 135125: XMLEncoding Changes ENDS
	  
	    	for(j=0;j<ad_address_type.length;j++)
	    	{
    		  if(ad_address_type[j]==temp)
	    	    {
	    
	              ad_LastUpdate_Flag[j]=null;
	            }
	        }
		var entityID 		= accountID;
		var entityType 		= "CUSTOMER";
		var addressCateogry 	= "Retail"
		//Tracker ID: 135125: XMLEncoding Changes STARTS
		var addressType ='';
		
		var temp='';
		if(boName=='AccountBO'){
			addressType= document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.addressCategory");
		}else if(boName=='AccountModBO'){
			addressType= document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.addressCategory");
	    	}
		//Tracker ID: 135125: XMLEncoding Changes ENDS
	    }
	}

	hdifrm_empform.location.href="../servlet/com.infy.cis.ui.corpcif.AddressHelper?entityID=" + entityID+"&amp;entityType=" + entityType+"&amp;addressType=" + addressType+"&amp;addressCateogry=" + addressCateogry;
}


function removeAddressTrue(attribExists){

	var proceed = 'true';

	if(attribExists){
		proceed = showUserChoiceMessage('MSGJ50216', '');
	}else{
		proceed = showUserChoiceMessage('MSG045', 'MSG_LOROW');
	}

	if(attribExists && proceed){
		for (i=0; i < document.all.RecordSet.rows.length ; i++){
		    var row_bgcolor = document.all.RecordSet.rows(i).className;
		    if ( row_bgcolor == 'rowHighLighted'){
		    	//Tracker ID: 135125: XMLEncoding Changes STARTS
		        if(boName=='AccountBO'){
		    		delAddrtypes[delAddrtypes.length]= document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.addressCategory");
		    	}else if(boName=='AccountModBO'){
		    		delAddrtypes[delAddrtypes.length]= document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.addressCategory");
	    		}
				//Tracker ID: 135125: XMLEncoding Changes ENDS
		   }
		}
	}

	if(proceed){
		for (i=0; i < document.all.RecordSet.rows.length ; i++){
		    var row_bgcolor = document.all.RecordSet.rows(i).className;
		    if ( row_bgcolor == 'rowHighLighted'){

			//Tracker ID: 135125: XMLEncoding Changes STARTS
			if(boName=='AccountBO'){
				EduDetURL = document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.url_");
			}else if(boName=='AccountModBO'){
				EduDetURL = document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.url_");
	    		}
			//Tracker ID: 135125: XMLEncoding Changes ENDS
			//if(showUserChoiceMessage('MSG045', 'MSG_LOROW')) {
				noOfAttachURLs = edu_URL.length;
				var deleteAlreadyExistingEduDet = true;
				for(r=0; r< noOfAttachURLs; r++) {
				    if(edu_URL[r] == EduDetURL){
					//Changes for Ticket id 418590 and Tracker id 254334 Recon for call id 215081 starts
					if(edu_Status[r] != "New" && edu_Status[r] != "Edit") {
					    deleteAlreadyExistingEduDet = false;
					}
					edu_URL[r] = null;
					//changes by Suman for making mailing address mandatory in edit
					ad_address_type[r]=null;
					edu_Status[r] = "Remove";
					addrID = ad_addrID[r];
					ad_start_date[r]="";
					//Changes for Ticket id 418590 and Tracker id 254334 Recon for call id 215081 ends
					break;
				    }
				}
				document.all.RecordSet.deleteRow(i);
				if( (EduDetURL == null) || (EduDetURL == 'undefined')) {
				    EduDetURL= "";
				}
				if(deleteAlreadyExistingEduDet) {
				    edu_detachedURLs[edu_detachedURLs.length] = addrID;
				}
			    //}
			}
		}
	}else{
		return;
	}


}


function editAddressDetails()
{

	   // 817615 changes start    
if(checkWinOpen && (EduDetDetailsEdit != null && !EduDetDetailsEdit.closed)){
	
	alert(" Please close other windows");
	return ;
}
// 817615 changes end
	
    try{
        updateEduDet = true;
		// Changes for call Id 442528 Start
		copyFlag=false;
		// Changes for call Id 442528 End
        var tempTableRow = '';
        if(event.srcElement.parentElement.id == null || event.srcElement.parentElement.id == '') {

               tempTableRow = event.srcElement.parentElement.parentElement;
        } else {

                tempTableRow = event.srcElement.parentElement;
        }
        currEduTableRow = tempTableRow;
	//Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName=='AccountBO'){

		EduDetURL = tempTableRow.getAttribute("AccountBO.Address.url_");
		// CORE-CIF Approval Changes
		var addrID = '';
		if(mainAccId !=''){
			addrID = tempTableRow.getAttribute("AccountBO.Address.MainTableID");
		} else {
			addrID = tempTableRow.getAttribute("AccountBO.Address.addressID");
		}
        }else if(boName=='AccountModBO'){
        EduDetURL = tempTableRow.getAttribute("AccountModBO.Address.url_");
		// CORE-CIF Approval Changes
		var addrID = '';
		if(mainAccId !=''){
			addrID = tempTableRow.getAttribute("AccountModBO.Address.MainTableID");
		} else {
			addrID = tempTableRow.getAttribute("AccountModBO.Address.addressID");
		}
	}
    //Tracker ID: 135125: XMLEncoding Changes ENDS    
        var i = 0;
    	var x = edu_URL.length;
    	for(i=0; i < x; i++){
   		if(edu_URL[i] == EduDetURL) {
           		break;
            }else{

            }
        }
        for (j=2; j < document.all.RecordSet.rows.length; j++){
        	//Tracker ID: 135125: XMLEncoding Changes STARTS
            var docURL ='';
            if(boName=='AccountBO'){
            	docURL =document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.url_");
            }else if(boName=='AccountModBO'){
             	docURL =document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.url_");
            }
			//Tracker ID: 135125: XMLEncoding Changes ENDS
            if(docURL == EduDetURL) {
                break;
            }
        }
        eduRecordIndex = j;

	//for(i=0; i < x; i++){
	//alert("i"  +i);
        
        //}
//Changes for call Id 423428 Starts
      	if(currEduTableRow.id == null || currEduTableRow.id == ''){
        document.frm2.address_type.value=srmEscape(ad_address_type[i], '^', escChars);
        /*Tracker 159095 : Sonali begin of changes*/
      	document.frm2.houseno.value=srmEscapeAddr(ad_houseno[i], '^', escCharsAddr);
        document.frm2.premiseno.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
        document.frm2.building.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
        /*Tracker 159095 : Sonali  end of changes*/
			//if(ad_PreferredFormat[i] != "FREE_TEXT_FORMAT"){
	        /*document.frm2.country.value = srmEscape(ad_country[i], '^', escChars) +"|#"+srmEscape(ad_cntryCode[i], '^', escChars);
		SetCookie("AccountBO.Address.country",ad_cntryCode[i]);
		document.frm2.city.value = srmEscape(ad_city[i], '^', escChars) +"|#"+srmEscape(ad_city_cat[i], '^', escChars);
	        SetCookie("AccountBO.Address.city",ad_city_cat[i]);
		    document.frm2.state.value = srmEscape(ad_state[i], '^', escChars) +"|#"+srmEscape(ad_state_cat[i], '^', escChars);
			SetCookie("AccountBO.Address.state",ad_state_cat[i]);
	
	*/
	
		    // Start of Fix for Ticket:243851  
		document.frm2.country.value = srmEscape(ad_country[i], '^', escChars) +"|#"+srmEscape(ad_country_cat[i], '^', escChars);
		SetCookie("AccountBO.Address.country",ad_country_cat[i]);
		//alert("document.frm2.country.value"+document.frm2.country.value);
		
		document.frm2.city.value = srmEscape(ad_city[i], '^', escChars) +"|#"+srmEscape(ad_city_cat[i], '^', escChars);
		SetCookie("AccountBO.Address.city",ad_cityCode[i]);
		//alert("document.frm2.city.value"+document.frm2.city.value);
		
		document.frm2.state.value = srmEscape(ad_state[i], '^', escChars) +"|#"+srmEscape(ad_state_cat[i], '^', escChars);
		SetCookie("AccountBO.Address.state",ad_stateCode[i]);
		//alert("document.frm2.state.value"+document.frm2.state.value);
		 // End of Fix for Ticket:243851  
	
	 /* }
		else
		{
	        document.frm2.country.value = "";
			document.frm2.city.value = "";
			document.frm2.state.value = "";
		}	 */
		document.frm2.start_date.value = srmEscape(ad_start_date[i], '^', escChars);
		document.frm2.zip.value = srmEscape(ad_zip[i], '^', escChars);
		/* Ticket 297058 : Changes for tracker 181373 starts : Reverted */
		document.frm2.end_date.value = srmEscape(ad_end_date[i], '^', escChars);
		/*  Ticket 297058 : Changes for tracker 181373 ends : Reverted*/
		document.frm2.LastUpdate_Date.value = srmEscape(ad_LastUpdate_Date[i], '^', escChars);
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
		//change for ticket 259201 and tracker 157070 start
		document.frm2.AddressLine1.value = srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
		document.frm2.AddressLine2.value = srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
		document.frm2.AddressLine3.value = srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
		document.frm2.FreeTextLabel.value = srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
/*Tracker 159095 :Sonali end of changes*/

		//change for ticket 259201 and tracker 157070 ends
		//CIF PhoneEmail Changes : End
		/*Tracker 159095 : Sonali begin of changes*/
		document.frm2.website.value = srmEscapeAddr(ad_website[i], '^', escCharsAddr);
		document.frm2.mailstop.value = srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
		document.frm2.streetname.value = srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
		document.frm2.suburb.value = srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
		/*Tracker 159095 :Sonali end of changes*/


	  //CIF Changes for RefCodes
		document.frm2.country_code.value 	= srmEscape(ad_cntryCode[i], '^', escChars);
		document.frm2.state_code.value 		= srmEscape(ad_stateCode[i], '^', escChars);
		document.frm2.city_code.value 		= srmEscape(ad_cityCode[i], '^', escChars);
	  //CIF Changes for RefCodes
	  document.frm2.IsAddressProofRcvd.value = srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
// changes for Tracker ID 456637 - TOL ID 455246
	  document.frm2.vAddTypeLT.value = srmEscape(ad_vAddTypeLT[i], '^', escChars);
// changes for Tracker ID 456637 - TOL ID 455246
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
		document.frm2.IsAddressVerified.value = srmEscape(ad_IsAddressVerified[i], '^', escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
		}
		else{
	document.frm2.address_type.value   =    currEduTableRow.getAttribute("AccountBO.Address.addressCategory");
	document.frm2.houseno.value         =    currEduTableRow.getAttribute("AccountBO.Address.house_no");
	document.frm2.premiseno.value       =    currEduTableRow.getAttribute("AccountBO.Address.premise_name");
	document.frm2.building.value       =    currEduTableRow.getAttribute("AccountBO.Address.building_level");
	document.frm2.country.value = currEduTableRow.getAttribute("AccountBO.Address.country")+'|#'+currEduTableRow.getAttribute("Cat_AccountBO.Address.country");
	document.frm2.city.value = currEduTableRow.getAttribute("AccountBO.Address.city")+'|#'+currEduTableRow.getAttribute("Cat_AccountBO.Address.city");
	document.frm2.state.value = currEduTableRow.getAttribute("AccountBO.Address.state")+'|#'+currEduTableRow.getAttribute("Cat_AccountBO.Address.state");
	document.frm2.zip.value = currEduTableRow.getAttribute("AccountBO.Address.zip");
	document.frm2.end_date.value = currEduTableRow.getAttribute("AccountBO.Address.End_Date");
	document.frm2.start_date.value = currEduTableRow.getAttribute("AccountBO.Address.Start_Date");
	document.frm2.streetno.value = currEduTableRow.getAttribute("AccountBO.Address.street_no");
        document.frm2.town.value = currEduTableRow.getAttribute("AccountBO.Address.town");

        document.frm2.PreferredFormat.value = currEduTableRow.getAttribute("AccountBO.Address.PreferredFormat");
        document.frm2.HoldMailReason.value = currEduTableRow.getAttribute("AccountBO.Address.HoldMailReason");
        document.frm2.BusinessCenter.value = currEduTableRow.getAttribute("AccountBO.Address.BusinessCenter");
        document.frm2.HoldMailInitiatedBy.value = currEduTableRow.getAttribute("AccountBO.Address.HoldMailInitiatedBy");
	document.frm2.HoldMailFlag.value = currEduTableRow.getAttribute("AccountBO.Address.HoldMailFlag");
	document.frm2.FreeTextLabel.value = currEduTableRow.getAttribute("AccountBO.Address.FreeTextLabel");
	/* Changes for ticket id CRM10.2.02Beta : 326507 Begin */
	document.frm2.AddressLine1.value = currEduTableRow.getAttribute("AccountBO.Address.Address_Line1");
	document.frm2.AddressLine2.value = currEduTableRow.getAttribute("AccountBO.Address.Address_Line2");
	document.frm2.AddressLine3.value = currEduTableRow.getAttribute("AccountBO.Address.Address_Line3");
	/* Changes for ticket id CRM10.2.02Beta : 326507 end */	
	document.frm2.city_code.value = currEduTableRow.getAttribute("AccountBO.Address.City_code");
	document.frm2.state_code.value = currEduTableRow.getAttribute("AccountBO.Address.State_code");
	document.frm2.country_code.value = currEduTableRow.getAttribute("AccountBO.Address.Country_code");
	document.frm2.streetname.value = currEduTableRow.getAttribute("AccountBO.Address.street_name");
	document.frm2.suburb.value = currEduTableRow.getAttribute("AccountBO.Address.suburb");
	document.frm2.locality.value = currEduTableRow.getAttribute("AccountBO.Address.locality_name");
	document.frm2.domicile.value = currEduTableRow.getAttribute("AccountBO.Address.domicile");
	
	/* Pradeep_sathyamurthy Setting the missed out fields as a aprt of ticket 320028 - Starts */
	document.frm2.IsAddressProofRcvd.value = currEduTableRow.getAttribute("AccountBO.Address.IsAddressProofRcvd");
	document.frm2.LastUpdate_Date.value = currEduTableRow.getAttribute("AccountBO.Address.LastUpdate_Date");
	document.frm2.IsAddressVerified.value = currEduTableRow.getAttribute("AccountBO.Address.IsAddressVerified");
	}
        
//Changes for call Id 423428 Ends
    
        recordIndex = i;
 	/* Tracker: 108382: Changes for centering popup */
        windowAlign();
			checkWinOpen =true; // 817615 changes
        EduDetDetailsEdit = window.open('../common/html/SSOblank.html', 'AddrDetails', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
        /* Tracker: 108382: End of Changes */
        document.frm2.target = 'AddrDetails'
        document.frm2.action = '../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det';
        document.frm2.submit();
    }catch(e){
	DebugMessage(e.message);
	}
}
function copyAddress()
{
try{
   // 817615 changes start    
if(checkWinOpen && (EduDetDetailsEdit != null && !EduDetDetailsEdit.closed)){
	
	alert(" Please close other windows");
	return ;
}
// 817615 changes end

	   updateEduDet = false;
        var EduDetURL = '';
        var addrID = '';
//Changes for Ticket id 386795 and Tracker id 235375 starts
//Commenting as part of TOL 556629 due to regression issue caused during copy and rectified the fix
		//copyFlag=true;
//Commenting as part of TOL 556629 due to regression issue caused during copy and rectified the fix
//Changes for Ticket id 386795 and Tracker id 235375 ends
        if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
             showUserMessage("MSGCOPY",'MSGJ0120');
            return;
        }


        for (k=0; k < document.all.RecordSet.rows.length ; k++){
        var row_bgcolor = document.all.RecordSet.rows(k).className;
        if ( row_bgcolor == 'rowHighLighted')
            {
            //Tracker ID: 135125: XMLEncoding Changes STARTS
            if(boName=='AccountBO'){
			EduDetURL = document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.url_");
		}else if(boName=='AccountModBO'){
			EduDetURL = document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.url_");
		}
        //Tracker ID: 135125: XMLEncoding Changes ENDS    

            var i = 0;
	            var x = edu_URL.length;


	            for(i=0; i < x; i++){


	                if(edu_URL[i] == EduDetURL) {

	                //i--;
	                    break;
	                }
	                else{

	                }
	            }

	            for (j=2; j < document.all.RecordSet.rows.length; j++){
	        //Tracker ID: 135125: XMLEncoding Changes STARTS    
	            	var docURL = '';
			if(boName=='AccountBO'){
				docURL =document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.url_");
			}else if(boName=='AccountModBO'){
				docURL =document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.url_");
            		}
	         //Tracker ID: 135125: XMLEncoding Changes ENDS       
	                if(docURL == EduDetURL) {
	                    break;
	                }
	            }
	            eduRecordIndex = j;



			document.frm2.address_type.value=srmEscape(ad_address_type[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/
			document.frm2.houseno.value=srmEscapeAddr(ad_houseno[i], '^', escCharsAddr);
			document.frm2.premiseno.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
			document.frm2.building.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali end of changes*/
			/* Changes for the tracker 181256 starts */
			/* if(ad_PreferredFormat[i] != "FREE_TEXT_FORMAT"){*/
			/* Changes for the tracker 181256 ends */
				document.frm2.country.value = srmEscape(ad_country[i], '^', escChars) +"|#"+srmEscape(ad_country_cat[i], '^', escChars);
				SetCookie("AccountBO.Address.country",ad_country_cat[i]);
				document.frm2.city.value = srmEscape(ad_city[i], '^', escChars) +"|#"+srmEscape(ad_city_cat[i], '^', escChars);
				SetCookie("AccountBO.Address.city",ad_city_cat[i]);
				document.frm2.state.value = srmEscape(ad_state[i], '^', escChars) +"|#"+srmEscape(ad_state_cat[i], '^', escChars);
				SetCookie("AccountBO.Address.state",ad_state_cat[i]);
			/* Changes for the tracker 181256 starts */
			/*}
			else
			{
				document.frm2.country.value = "";
				document.frm2.city.value = "";
				document.frm2.state.value = "";
			}*/
			/* Changes for the tracker 181256 ends */
			document.frm2.start_date.value = srmEscape(ad_start_date[i], '^', escChars);
			document.frm2.zip.value = srmEscape(ad_zip[i], '^', escChars);
			document.frm2.end_date.value = '';
			document.frm2.LastUpdate_Date.value = srmEscape(ad_LastUpdate_Date[i], '^', escChars);
			
			/* Ticket Number 236271 Address getting overwritten while copying */
			//document.frm2.addrID.value = srmEscape(ad_addrID[i], '^', escChars);
			document.frm2.addrID.value = ""; //changes for 556629
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
			
			//CIF PhoneEmail Changes : End
			
			document.frm2.website.value = srmEscapeAddr(ad_website[i], '^', escCharsAddr);
			document.frm2.mailstop.value = srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
			document.frm2.streetname.value = srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
			document.frm2.suburb.value = srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali end of changes*/

		  //CIF Changes for RefCodes
			document.frm2.country_code.value 	= srmEscape(ad_cityCode[i], '^', escChars);
			document.frm2.state_code.value 		= srmEscape(ad_stateCode[i], '^', escChars);
			document.frm2.city_code.value 		= srmEscape(ad_cntryCode[i], '^', escChars);
		  //CIF Changes for RefCodes
			document.frm2.IsAddressProofRcvd.value = srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
// changes for Tracker ID 456637 - TOL ID 455246
			document.frm2.vAddTypeLT.value = srmEscape(ad_vAddTypeLT[i], '^', escChars);
// changes for Tracker ID 456637 - TOL ID 455246
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			document.frm2.IsAddressVerified.value = srmEscape(ad_IsAddressVerified[i], '^', escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/


	            recordIndex = i;

	            /* Tracker: 108382: Changes for centering popup */
		     windowAlign();
		//changes for callid 817615 starts
			 checkWinOpen = true;
		
		     EduDetDetailsEdit = window.open('../common/html/SSOblank.html', 'EduDetails', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
	            /* Tracker: 108382: End of Changes */
	            document.frm2.target = 'EduDetails'
	            document.frm2.action = '../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?IsFormatReadOnly=Yes';
		        document.frm2.submit();

            }
        }
        }catch(e){
        }

}
function addAddrDetails(AddrDetails, addressTypeFlag){
try{
//Changes for CRM10202Beta Ticket 321361 : Begin
    var tempUpdate = updateEduDet;	
//Changes for 434549 start :
    copyFlag=false;	
//Changes for 434549 end :
//Changes for CRM10202Beta Ticket 321361 : End
    address_type                = AddrDetails[0];
    if(address_type == '') return;
    houseno                     = AddrDetails[1];
    premiseno                   = AddrDetails[2];
    end_date                    = AddrDetails[3];
   LastUpdate_Date		= AddrDetails[34];

    start_date                  = AddrDetails[4];

    city                        = AddrDetails[5];
    country                     = AddrDetails[6];
    state                       = AddrDetails[7];
    zip                         = AddrDetails[8];
    building			= AddrDetails[9];
//Changes for Ticket id 386795 and Tracker id 235375 starts
//Commenting as part of TOL 556629 due to regression issue caused during copy and rectified the fix
	//if(!copyFlag){
    addrID			= AddrDetails[10];
	//}else{
	//addrID = '';
	//copyFlag=false;
	
	//}
	//Commenting as part of TOL 556629 due to regression issue caused during copy and rectified the fix
//Changes for Ticket id 386795 and Tracker id 235375 ends
    streetno			= AddrDetails[11];
    locality			= AddrDetails[12];
    town			= AddrDetails[13];
    domicile			= AddrDetails[14];
    streetname			= AddrDetails[15];
    suburb                      = AddrDetails[16];
		 updateflag			= AddrDetails[35];
    eduURL                      = address_type + start_date;

  //CIF Changes for RefCodes
	city_code		= AddrDetails[17];
	state_code		= AddrDetails[18];
	cntry_code		= AddrDetails[19];
  //CIF Changes for RefCodes

    //CIF PhoneEmail Changes : Start
	preferredFormat = AddrDetails[20];
	holdMailReason = AddrDetails[21];
	businessCenter = AddrDetails[22];
	holdMailInitiatedBy = AddrDetails[23];
	holdMailFlag = AddrDetails[24];
	if(holdMailFlag == true || holdMailFlag == 'Y')
	{
		holdMailFlag = "Y";
	}
	else
	{
		holdMailFlag = "N";
	}
// AdressLine changes: START
	addressLine1 = AddrDetails[25];
	addressLine2 = AddrDetails[26];
	addressLine3 = AddrDetails[27];
	name = AddrDetails[37];
	freeTextLabel = AddrDetails[28];
    mailstop		        = AddrDetails[29];
    website			= AddrDetails[30];
	city_cat = AddrDetails[31];
	state_cat = AddrDetails[32];
	country_cat = AddrDetails[33];
	IsAddressProofRcvd = AddrDetails[36];
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
	IsAddressVerified = AddrDetails[42];
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
// changes for Tracker ID 456637 - TOL ID 455246
	vAddTypeLT = AddrDetails[43];
// changes for Tracker ID 456637 - TOL ID 455246

if(preferredFormat == "STRUCTURED_FORMAT"){
freeTextLabel = "";
}
// AdressLine changes: END
  //CIF PhoneEmail Changes : End

    var uid = null;
    var alreadyAdded = false;
	if(!addressTypeFlag)//added from sorting
	{
    	city_cat = GetCookie('AccountBO.Address.city');
    	state_cat = GetCookie('AccountBO.Address.state');
    	country_cat = GetCookie('AccountBO.Address.country');
	}


    if(!alreadyAdded){

        var noOfexistingURLs = edu_URL.length;
        for(var x = 0; x < noOfexistingURLs ; x++) {
            //here compare with combination of Inst and Qualification
            
		/* Fix Start for ticket: 249866 */           
		if(eduURL == edu_URL[x]) {
	                  alreadyAdded = true;
	                  if(updateEduDet){
	                      if(x != recordIndex){
	                          updateEduDet = false;
	                      }
	                  }
	                  break;  
	          } 
	     }
		/* Fix End for ticket: 249866 */           
        
        if(updateEduDet){

            alreadyAdded = true;
            //edu_detachedURLs[edu_detachedURLs.length] = ad_addrID[recordIndex];
            ad_addrID[recordIndex] = addrID;

            ad_address_type[recordIndex] = address_type;
            ad_houseno[recordIndex] = houseno;
            ad_premiseno[recordIndex] = premiseno;
            ad_end_date[recordIndex] = end_date;
            ad_LastUpdate_Date[recordIndex] = LastUpdate_Date;

            ad_start_date[recordIndex] = start_date;
            ad_zip[recordIndex] = zip;
            ad_state[recordIndex] = state;
            ad_state_cat[recordIndex] = state_cat;
            ad_city[recordIndex] = city;
            ad_city_cat[recordIndex] = city_cat;
            ad_country[recordIndex] = country;
            ad_country_cat[recordIndex] = country_cat;
            ad_building[recordIndex] = building;
            ad_streetno[recordIndex] = streetno;
            ad_town[recordIndex] = town;
            ad_locality[recordIndex] = locality;
            ad_domicile[recordIndex] = domicile;

			//CIF PhoneEmail Changes : Start
			ad_PreferredFormat[recordIndex] = preferredFormat;
			ad_HoldMailReason[recordIndex] = holdMailReason;
			ad_BusinessCenter[recordIndex] = businessCenter;
			ad_HoldMailInitiatedBy[recordIndex] = holdMailInitiatedBy;
			ad_HoldMailFlag[recordIndex] =  holdMailFlag;
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			ad_IsAddressVerified[recordIndex] =  IsAddressVerified;
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
// AdressLine changes: START
			ad_AddressLine1[recordIndex] = addressLine1;
			ad_AddressLine2[recordIndex] = addressLine2;
			ad_AddressLine3[recordIndex] = addressLine3;
// AdressLine changes: END
			ad_FreeTextLabel[recordIndex] = freeTextLabel;
			//CIF PhoneEmail Changes : End

		    ad_website[recordIndex] = website;
            ad_mailstop[recordIndex] = mailstop;
            ad_streetname[recordIndex] = streetname;
            ad_suburb[recordIndex] = suburb;
       	    ad_LastUpdate_Flag[recordIndex] =updateflag;
       	     ad_IsAddressProofRcvd[recordIndex] = IsAddressProofRcvd;       	    
	    
// changes for Tracker ID 456637 - TOL ID 455246
       	    ad_vAddTypeLT[recordIndex] = vAddTypeLT;
// changes for Tracker ID 456637 - TOL ID 455246

		     //CIF Changes for RefCodes
		     ad_cityCode[recordIndex] 	       = city_code;
			 ad_stateCode[recordIndex] 	       = state_code;
		     ad_cntryCode[recordIndex] 	       = cntry_code;
			  //CIF Changes for RefCodes
			 edu_URL[recordIndex] = eduURL;

             edu_Status[recordIndex] = "Edit";


        }
    }
    if(!alreadyAdded) {


    adcount=edu_URL.length;

            ad_address_type[adcount] = address_type;

            ad_houseno[adcount] = houseno;
            ad_premiseno[adcount] = premiseno;
            ad_end_date[adcount] = end_date;
            ad_LastUpdate_Date[adcount] = LastUpdate_Date;
            ad_start_date[adcount] = start_date;
            ad_zip[adcount] = zip;
            ad_state[adcount] = state;
            ad_state_cat[adcount] = state_cat;
            ad_city[adcount] = city;
            ad_city_cat[adcount] = city_cat;
            ad_country[adcount] = country;
            ad_country_cat[adcount] = country_cat;
            ad_building[adcount] = building;
            ad_streetno[adcount] = streetno;
            ad_town[adcount] = town;
		    ad_locality[adcount] = locality;
		    ad_domicile[adcount] = domicile;
			//CIF PhoneEmail Changes : Start
			ad_PreferredFormat[adcount] = preferredFormat;
			ad_HoldMailReason[adcount] = holdMailReason;
			ad_BusinessCenter[adcount] = businessCenter;
			ad_HoldMailInitiatedBy[adcount] = holdMailInitiatedBy;
			ad_HoldMailFlag[adcount] =  holdMailFlag;
// AdressLine changes: START
			ad_AddressLine1[adcount] = addressLine1;
			ad_AddressLine2[adcount] = addressLine2;
			ad_AddressLine3[adcount] = addressLine3;
// AdressLine changes: END
			ad_FreeTextLabel[adcount] = freeTextLabel;
			//CIF PhoneEmail Changes : End
		    ad_website[adcount] = website;
            ad_mailstop[adcount] = mailstop;
            ad_streetname[adcount] = streetname;
            ad_suburb[adcount] = suburb;
            ad_LastUpdate_Flag[adcount] = updateflag;
             ad_IsAddressProofRcvd[adcount] = IsAddressProofRcvd;
// changes for Tracker ID 456637 - TOL ID 455246
			 ad_vAddTypeLT[adcount] = vAddTypeLT;
// changes for Tracker ID 456637 - TOL ID 455246
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
             ad_IsAddressVerified[adcount] = IsAddressVerified;
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/



		  //CIF Changes for RefCodes
			 ad_cityCode[ad_cityCode.length] 	       = city_code;
			 ad_stateCode[ad_stateCode.length] 	       = state_code;
			 ad_cntryCode[ad_cntryCode.length] 	       = cntry_code;
		  //CIF Changes for RefCodes
            edu_Status[adcount] = "New";
            edu_URL[adcount] = eduURL;
			if(addressTypeFlag)
			{
				ad_addrID[adcount] = addrID;
			}
			else
			{
				ad_addrID[adcount] = "";
			}

    }

   var add_category_ML = GetCookie('AccountBO.Address.addressCategory');
   var add_city_ML = "";
   var add_state_ML = "";
   var add_country_ML = "";
   if(addressTypeFlag)
   {
		add_city_ML = city_cat;
		add_state_ML =  state_cat;
		add_country_ML = country_cat;
   }
   else
   {
		add_city_ML =	GetCookie('AccountBO.Address.city');
		add_state_ML = GetCookie('AccountBO.Address.state');
		add_country_ML = GetCookie('AccountBO.Address.country');
   }
	/* CIF PhoneEmail Changes : Start*/
	if(preferredFormat == "FREE_TEXT_FORMAT"){
		/*add_city_ML = "";
		add_state_ML = "";
		add_country_ML = "";*/
		
		 if(addressTypeFlag)
		   {
				add_city_ML = city_cat;
				add_state_ML =  state_cat;
				add_country_ML = country_cat;
		   }
		   else
		   {
				add_city_ML =	GetCookie('AccountBO.Address.city');
				add_state_ML = GetCookie('AccountBO.Address.state');
				add_country_ML = GetCookie('AccountBO.Address.country');
   		   }
   		   
		//ticket 258354
		
		if(add_city_ML==null)
		{
		add_city_ML = "";
		}
		
		if(add_state_ML==null)
		{
		add_state_ML = "";
		}
		
		if(add_country_ML==null)
		{
		add_country_ML = "";
		}
		
		//ticket 258354
	}
	/* CIF PhoneEmail Changes : End*/
	if(address_type!="Swift"){
	/* changes for Tracker 181792 starts */	
		if(addressTypeFlag)
				{
					add_category_ML = address_type;
			}
        /* changes for Tracker 181792 Ends*/

    if (!updateEduDet)
    {
        if(alreadyAdded) {
//Changes for CRM10202Beta Ticket 321361 : Begin
                updateEduDet=tempUpdate;
//Changes for CRM10202Beta Ticket 321361 : End
                showUserMessage("MSG_CONTACT_IDEXISTS",null);
            return;
        }
        oNewNode = document.createElement("TR");
        if(TBODY_RecordSet.childNodes.length % 2 == 0) {
            oNewNode.setAttribute("className", "color1");
        } else {
            oNewNode.setAttribute("className", "color2");
        }
        TBODY_RecordSet.appendChild(oNewNode);
		//Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName=='AccountBO'){
			oNewNode.setAttribute("AccountBO.Address.addressCategory", address_type);
			oNewNode.setAttribute("AccountBO.Address.Start_Date", start_date);
			oNewNode.setAttribute("AccountBO.Address.country", country);
			oNewNode.setAttribute("AccountBO.Address.state", state);
			oNewNode.setAttribute("AccountBO.Address.city", city);
			/* CIF PhoneEmail Changes : Start */
			oNewNode.setAttribute("AccountBO.Address.PreferredFormat", preferredFormat);
			oNewNode.setAttribute("AccountBO.Address.HoldMailReason", holdMailReason);
			oNewNode.setAttribute("AccountBO.Address.BusinessCenter", businessCenter);
			oNewNode.setAttribute("AccountBO.Address.HoldMailInitiatedBy", holdMailInitiatedBy);
	// AdressLine changes: START
			oNewNode.setAttribute("AccountBO.Address.AddressLine1", addressLine1);
	// AdressLine changes: END
			oNewNode.setAttribute("AccountBO.Address.FreeTextLabel", freeTextLabel);
			oNewNode.setAttribute("AccountBO.Address.HoldMailFlag", holdMailFlag);
			oNewNode.setAttribute("AccountBO.Address.mailStop", mailstop);
			oNewNode.setAttribute("AccountBO.Address.URL", website);
			oNewNode.setAttribute("AccountBO.Address.IsAddressProofRcvd", IsAddressProofRcvd);
		}else if(boName=='AccountModBO'){
			oNewNode.setAttribute("AccountModBO.Address.addressCategory", address_type);
			oNewNode.setAttribute("AccountModBO.Address.Start_Date", start_date);
			oNewNode.setAttribute("AccountModBO.Address.country", country);
			oNewNode.setAttribute("AccountModBO.Address.state", state);
			oNewNode.setAttribute("AccountModBO.Address.city", city);
			/* CIF PhoneEmail Changes : Start */
			oNewNode.setAttribute("AccountModBO.Address.PreferredFormat", preferredFormat);
			oNewNode.setAttribute("AccountModBO.Address.HoldMailReason", holdMailReason);
			oNewNode.setAttribute("AccountModBO.Address.BusinessCenter", businessCenter);
			oNewNode.setAttribute("AccountModBO.Address.HoldMailInitiatedBy", holdMailInitiatedBy);
	// AdressLine changes: START
			oNewNode.setAttribute("AccountModBO.Address.AddressLine1", addressLine1);
	// AdressLine changes: END
			oNewNode.setAttribute("AccountModBO.Address.FreeTextLabel", freeTextLabel);
			oNewNode.setAttribute("AccountModBO.Address.HoldMailFlag", holdMailFlag);
			oNewNode.setAttribute("AccountModBO.Address.mailStop", mailstop);
			oNewNode.setAttribute("AccountModBO.Address.URL", website);
			oNewNode.setAttribute("AccountModBO.Address.IsAddressProofRcvd", IsAddressProofRcvd);
		}
		//Tracker ID: 135125: XMLEncoding Changes ENDS
		
		
		/* CIF PhoneEmail Changes : End */

		/*if(addressTypeFlag)
		{
			add_category_ML = address_type;
		}*/
		var tdNode = document.createElement("TD");
		oNewNode.appendChild(tdNode);
// changes for Tracker ID 456637 - TOL ID 455246
		tdNode.innerHTML =  "<font class='fntColData'>" + vAddTypeLT+ "</font>";
		/* CIF PhoneEmail Changes : Start*/
		var tdNode1 = document.createElement("TD");
		oNewNode.appendChild(tdNode1);
		tdNode1.innerHTML =  "<font class='fntColData'>" + freeTextLabel+ "</font>";
		/* CIF PhoneEmail Changes : End*/

		var tdNode2 = document.createElement("TD");
		/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
		var idIndex = document.all.RecordSet.rows.length;
		tdNode2.setAttribute("id","DATE1RetCustAddressDetails"+idIndex);
		
		
		if((start_date!= '') && (start_date != undefined))
		{
		//date converted acc to the present calendar type before displaing in the multirec 
		start_date = changeDateAccToPresentCalendar(start_date);
		}
		/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
		oNewNode.appendChild(tdNode2);
//	 Tracker-ID 113259:ERPBOCF1:Hijri cr :changes start
		/* Tracker-ID 113259:ERPBOCF1:Hijri:to convert start date to Hijri date format - start
		//if the selected calendar type is Hijri,start date is converted in the Hijr format
		if(calType == 'H')
		{
		start_date = convertGregToHij(start_date);
		}
Tracker-ID 113259:ERPBOCF1:Hijri:to convert start date to Hijri date format - end*/	  
//	 Tracker-ID 113259:ERPBOCF1:Hijri cr :changes end

		tdNode2.innerHTML =  "<font class='fntColData'>" + start_date+ "</font>";
		var tdNode3 = document.createElement("TD");
		oNewNode.appendChild(tdNode3);
		tdNode3.innerHTML = "<font class='fntColData'>" + add_city_ML + "</font>";
		var tdNode4 = document.createElement("TD");
		oNewNode.appendChild(tdNode4);
		tdNode4.innerHTML = "<font class='fntColData'>" + add_state_ML + "</font>";

		var tdNode5 = document.createElement("TD");
		oNewNode.appendChild(tdNode5);
		tdNode5.innerHTML = "<font class='fntColData'>" + add_country_ML + "</font>";

		var tdNode6 = document.createElement("TD");
		oNewNode.appendChild(tdNode6);
		tdNode6.innerHTML = "<INPUT class='sbttn' TYPE = 'button' value = '...' onclick='editAddressDetails()'>";

        oNewNode.attachEvent("onclick", call);

        totalProdRecortds = document.all.RecordSet.rows.length;
		//Tracker ID: 135125: XMLEncoding Changes STARTS
        if(boName=='AccountBO'){
        	document.all.RecordSet.rows(totalProdRecortds - 1).setAttribute("AccountBO.Address.url_", eduURL);
        }else if(boName=='AccountModBO'){
        	document.all.RecordSet.rows(totalProdRecortds - 1).setAttribute("AccountModBO.Address.url_", eduURL);
	}
		//Tracker ID: 135125: XMLEncoding Changes STARTS
		/* CIF PhoneEmail Changes : Start*/
		//updateAllHoldMailInfo(address_type);
		/* CIF PhoneEmail Changes : End*/
    }
    else
    {

// changes for Tracker ID 456637 - TOL ID 455246
    currEduTableRow.childNodes(0).innerHTML="<font class='fntColData'>" + vAddTypeLT + "</font>";
	//CIF PhoneEmail Changes : Start
	currEduTableRow.childNodes(1).innerHTML="<font class='fntColData'>" + freeTextLabel + "</font>";
	//CIF PhoneEmail Changes : End
	/* Tracker-ID 113259:ERPBOCF1:Hijri:to convert start date to Hijri date format - start*/
//	 Tracker-ID 113259:ERPBOCF1:Hijri cr :changes start	
/*if the selected calendar type is Hijri,current date is converted in the Hijr format
	if(calType == 'H')
	{
	start_date = convertGregToHij(start_date);
	}
	Tracker-ID 113259:ERPBOCF1:Hijri:to convert start date to Hijri date format - end*/
   if((start_date!= '') && (start_date != undefined))
	{
	//date converted acc to the present calendar type before displaing in the multirec 
	start_date = changeDateAccToPresentCalendar(start_date);
	}
//	 Tracker-ID 113259:ERPBOCF1:Hijri cr :changes end	
	currEduTableRow.childNodes(2).innerHTML="<font class='fntColData'>" + start_date + "</font>";
	currEduTableRow.childNodes(3).innerHTML="<font class='fntColData'>" + add_city_ML + "</font>";
	currEduTableRow.childNodes(4).innerHTML="<font class='fntColData'>" + add_state_ML + "</font>";
	currEduTableRow.childNodes(5).innerHTML="<font class='fntColData'>" + add_country_ML + "</font>";
	updateEduDet = false;
	//Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName=='AccountBO'){
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.addressCategory", address_type);
		//CIF PhoneEmail Changes : Start
	   	document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.FreeTextLabel", freeTextLabel);
		//CIF PhoneEmail Changes : End
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.Start_Date", start_date);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.country", country);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.state", state);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.city", city);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.url_", eduURL);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.PreferredFormat", preferredFormat);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.HoldMailFlag",holdMailFlag);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.HoldMailReason",holdMailReason);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.BusinessCenter",businessCenter);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
	}else if(boName=='AccountModBO'){
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.addressCategory", address_type);
		//CIF PhoneEmail Changes : Start
	    	document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.FreeTextLabel", freeTextLabel);
		//CIF PhoneEmail Changes : End
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.Start_Date", start_date);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.country", country);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.state", state);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.city", city);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.url_", eduURL);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.PreferredFormat", preferredFormat);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.HoldMailFlag",holdMailFlag);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.HoldMailReason",holdMailReason);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.BusinessCenter",businessCenter);
		document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
	}
	//Tracker ID: 135125: XMLEncoding Changes ENDS
	/* CIF PhoneEmail Changes : Start*/
	//updateAllHoldMailInfo(address_type);
	/* CIF PhoneEmail Changes : End*/
    }
    }else{
    /*Changes for callid 408434-recon for 405506 starts*/
    	if(addressLine1==""){
    		addressLine1="null";
    	}
    	if(addressLine2==""){
    		addressLine2="null";
    	}
    	if(addressLine3==""){
    		addressLine3="null";
    	}	
    /*Changes for callid 408434-recon for 405506 ends*/
		SwiftAddressDetails	= name+"|"+addressLine1+"|"+addressLine2+"|"+addressLine3;
	}	
}catch(e){DebugMessage(e.description);
}
    return ("true");
}

/*function updateAllHoldMailInfo(address_type)
{
	var recordSetSize =  document.all.RecordSet.rows.length;
	//Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName=='AccountBO'){
	for(var k=0 ;k<recordSetSize; k++)
	{
		if(address_type == document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.addressCategory"))
		{
			document.all.RecordSet.rows(k).setAttribute("AccountBO.Address.HoldMailFlag",holdMailFlag);
			document.all.RecordSet.rows(k).setAttribute("AccountBO.Address.HoldMailReason",holdMailReason);
			document.all.RecordSet.rows(k).setAttribute("AccountBO.Address.BusinessCenter",businessCenter);
			document.all.RecordSet.rows(k).setAttribute("AccountBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);

			ad_HoldMailReason[k-2] = holdMailReason;
			ad_BusinessCenter[k-2] = businessCenter;
			ad_HoldMailInitiatedBy[k-2] = holdMailInitiatedBy;
			ad_HoldMailFlag[k-2] = holdMailFlag;
		}
	}
	
	}else if(boName=='AccountModBO'){
	
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(address_type == document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.addressCategory"))
			{
				document.all.RecordSet.rows(k).setAttribute("AccountModBO.Address.HoldMailFlag",holdMailFlag);
				document.all.RecordSet.rows(k).setAttribute("AccountModBO.Address.HoldMailReason",holdMailReason);
				document.all.RecordSet.rows(k).setAttribute("AccountModBO.Address.BusinessCenter",businessCenter);
				document.all.RecordSet.rows(k).setAttribute("AccountModBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);

				ad_HoldMailReason[k-2] = holdMailReason;
				ad_BusinessCenter[k-2] = businessCenter;
				ad_HoldMailInitiatedBy[k-2] = holdMailInitiatedBy;
				ad_HoldMailFlag[k-2] = holdMailFlag;
			}
		}
	}
	//Tracker ID: 135125: XMLEncoding Changes ENDS
}*/


function checkFormatSelected(selectedFormat,selectedAddressType)
{
	var recordSetSize =  document.all.RecordSet.rows.length;
	//Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName=='AccountBO'){
		for(var j=0 ; j < recordSetSize; j++)
		{
			if(document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.PreferredFormat") != null)
			{
				if(selectedFormat == document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.PreferredFormat")  && selectedAddressType == document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.addressCategory"))
				{
					return document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.addressCategory");
				}
			}
		}
		
	}else if(boName=='AccountModBO'){		
		for(var j=0 ; j < recordSetSize; j++)
				{
					if(document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.PreferredFormat") != null)
					{
						if(selectedFormat == document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.PreferredFormat")  && selectedAddressType == document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.addressCategory"))
						{
							return document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.addressCategory");
						}
					}
		}
	}
		return null;
	//Tracker ID: 135125: XMLEncoding Changes STARTS
}


function onBCCodeSelect()
{
	try{
	document.getElementsByName(bcLookupType)[0].value = getCookie("bCCode");
	//Access Control changes
	}catch(e){
	setBCCodeValues ( bcCodeLookup , getCookie("bCCode"), getCookie("bCID"));
	}
}

function clearBCValue(type)
{
	document.getElementsByName(type)[0].value = "";
}

function addAddress()
{
	updateEduDet = false;
	// Changes for call Id 442528 Start
copyFlag=false;	
	// Changes for call Id 442528 End
	var getMCRequired=document.frm2.getMCRequired.value;
	//var servletURL = "../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?";
	//var servletURL = "../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?mode=create&getMCRequired="+getMCRequired;
	// vasanth's changes end
/* Tracker:108379: Changes for centering popup */
	
	// hardcoded values
	
	var wh = 460;
	
	var ww = 900;
	
	// end hardcoded values
	
	 
	
	var left_x = (screen.width - ww) / 2 ;
	
	var left_y = (screen.height - wh) / 2 ;
	
	 
	
	//left_x = 0 ;
	
	//servletURL = '../servlet/com.infy.cis.ui.cif.NonCustomerDetWizard?isCopy=Y&AcrossSearch=N&boType=Main&bank_id='+bank_id+'&nonCustomerId='+NonCustID;
	if(bank_id!=56)
	{
	servletURL = '../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?PreferredFormat=FREE_TEXT_FORMAT&getMCRequired='+getMCRequired;
	}
	else
	{
	servletURL = '../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?PreferredFormat=STRUCTURED_FORMAT&getMCRequired='+getMCRequired;
	}
	//Changes for Tracker #292776 begin
		if((checkWinOpen) && (adrWindow != null && !adrWindow.closed)){}
		else{
		checkWinOpen =true;	
		adrWindow = window.open(servletURL ,'AddrDetails','height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',location=no,menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
		}
		adrWindow.focus();
	//Changes for Tracker #292776 end
		
		/* Tracker:108379: Changes End */
	adrWindow.name = 'AddrDetails';

	
	 
	
	//docTypeNew = window.open(servletURL, '','height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
	
	
	/* Tracker:108379: Changes End */
}


/************************************************************************
 *            	Swift Address Changes Begin
 ***********************************************************************/
	
	
/* Tracker 146819 : added the variable readMode */	
function createSwiftAddress(readMode){
/* Tracker 146819: ends here */
	var boName = "AccountBO";
	try
	{       
		/*if(SwiftAddressDetails==""){
			SwiftAddressDetails=null;
		}*/
		var mode="Create"
		var isEdit="N";
		/* Tracker 146819 : commented the hardcoding */
		//var isReadOnly="N"		
		/* Tracker 146819: ends here*/

		var getMCRequired=document.frm2.getMCRequired.value;
		var wh = 260;
		var ww = 900;
		var left_x = (screen.width - ww) / 2 ;
		var left_y = (screen.height - wh) / 2 ;

		//Change for DBS ticket 325152
		if(SwiftAddressDetails==null)
		{		
			SwiftAddressDetails="a|b|c|d";		
		 }
		
	       isEdit="N";
               docTypeNew = window.open('../common/html/SSOblank.html', 'SwiftAddressDetails', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=no');
		document.frm2.target = 'SwiftAddressDetails';
		document.frm2.SwiftAddressDetails.value=SwiftAddressDetails;
		
		document.frm2.action ="../servlet/com.infy.cis.ui.cif.SwiftAddressForm_det?boName="+boName+"&isReadOnly="+readMode+"&mode="+mode+"&getMCRequired="+getMCRequired;		
		document.frm2.submit();			


	}
	catch(e)
	{alert(e.message);}

 }
 /*****************************************************************************************
 *		End of Swift Address changes
 ******************************************************************************************/
			
	
































