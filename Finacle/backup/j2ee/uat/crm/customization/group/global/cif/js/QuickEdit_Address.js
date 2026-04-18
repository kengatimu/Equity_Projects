var mainAccId = document.frm2.mainAccId.value;	
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

var addr_URL             = new Array();
//Tracker 105266
var ad_LastUpdate_Date  = new Array();
var ad_IsAddressProofRcvd = new Array();
/*changes for Ticketid 682574 starts*/
var ad_vAddTypeLT = new Array();
/*changes for Ticketid 682574 ends*/
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
var ad_IsAddressVerified = new Array();
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
var ad_PreferredFormat = new Array();
var ad_HoldMailReason = new Array();
var ad_BusinessCenter = new Array();
var ad_HoldMailInitiatedBy = new Array();
var ad_HoldMailFlag = new Array();
// AdressLine changes: START
var ad_AddressLine1 = new Array();
var ad_AddressLine2 = new Array();
var ad_AddressLine3 = new Array();
// AdressLine changes: END
var ad_FreeTextLabel = new Array();

var ad_cityCode	   = new Array();
var ad_stateCode	   = new Array();
var ad_cntryCode	   = new Array();

//Changes for call id: 401260 and recon for TOL 397571
var ad_LastUpdate_Flag  = new Array();
var escChars = new Array(',');
/*Tracker 159095 : Sonali begin of changes*/
var escCharsAddr = new Array('%');
/*Tracker 159095 : Sonali end of changes*/
var updateDet = false;
var currBOName = '';
var editMode = false;
var adrWindow = null;
var recordIndex = null;
var servletURL = null;
// 817615 changes start
 var checkWinOpen = false; 
           function setcheckWinOpen() 
           {           
			  checkWinOpen =false; 
           } 
	   // 81751 changes end
try {
	var selTabId = parent.parent.parent.parent.frames(0).getSelectedTabId();
} catch(e) {
}
var lookupFor = '';
var globalAddrDetails = new Array();

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

function addAddress(boName)
{
	if(boName == "AccountBO" || boName == "AccountModBO")
	{
		adrWindow = window.open('../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?isQuickEdit=Yes', 'AddrDetails','height=436, left=70, top=120, width=860, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
		currBOName = "AccountBO";
	}
	if(boName == "ContactBO" || boName == "ContactModBO")
	{
		adrWindow = window.open('../servlet/com.infy.cis.ui.cif.QDEContactAddressdetail?isQuickEdit=Yes', 'AddrDetails','height=436, left=70, top=120, width=860, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
		currBOName = "ContactBO";
	}
	if(boName == "SuspectBO" || boName == "SuspectModBO")
	{
		adrWindow = window.open('../servlet/com.infy.cis.ui.cif.QDEProspectAddressForm_Det?isQuickEdit=Yes', 'AddrDetails','height=436, left=70, top=120, width=860, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
		currBOName = "SuspectBO";
	}
	if(boName == "NonCustomerBO" || boName == "NonCustomerModBO")
	{
		adrWindow = window.open('../servlet/com.infy.cis.ui.cif.NonCustomerAddress_Det?isQuickEdit=Yes', 'AddrDetails','height=436, left=70, top=120, width=860, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
		currBOName = "NonCustomerBO";
	}
	adrWindow.name = 'AddrDetails';
	updateDet = false;
}
function checkForHoldMailValue()
{
	var holdMailFieldsArray = new Array();
	holdMailFieldsArray[0] = document.getElementsByName(currBOName+".Address.HoldMailInitiatedBy")[0].value;
	holdMailFieldsArray[1] = document.getElementsByName(currBOName+".Address.BusinessCenter")[0].value;
	holdMailFieldsArray[2] = document.getElementsByName(currBOName+".Address.HoldMailReason")[0].value;
	for(var j=0;j < holdMailFieldsArray.length;j++)
	{
		if(holdMailFieldsArray[j] != ""){
			return false;
		}
	}
	return true;
}

// This method will clear all holdMail Values
function clearHoldMailValues()
{
	document.getElementsByName(currBOName+".Address.HoldMailInitiatedBy")[0].value = "";
	document.getElementsByName(currBOName+".Address.BusinessCenter")[0].value = "";     
	document.getElementsByName(currBOName+".Address.HoldMailReason")[0].value = "";     
}

function disableEnableHoldMail(){

   
   //making HoldMail Fields Disabled
   if(document.getElementsByName(currBOName+".Address.HoldMailFlag")[0].checked == false)
   {
	var flag = true;
	flag = checkForHoldMailValue();
	if(!flag)
	{
		holdMailConfirmFlag = confirm("All his hold mail flag setting will be cleared. Do you want to continue?");
		if(holdMailConfirmFlag == true)
		{
			clearHoldMailValues();
		}
		else
		{
			document.getElementsByName(currBOName+".Address.HoldMailFlag")[0].checked = true;
			return;
		}

	}
	   
	document.getElementsByName(currBOName+".Address.HoldMailInitiatedBy")[0].disabled = true;
	document.getElementsByName(currBOName+".Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName("btntwo_AccountBO.Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName("btnone_AccountBO.Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName(currBOName+".Address.HoldMailReason")[0].disabled = true;

	document.getElementsByName("mandStarAccountBO.Address.HoldMailInitiatedBy")[0].style.visibility="hidden"; 
	document.getElementsByName("mandStarAccountBO.Address.BusinessCenter")[0].style.visibility="hidden"; 
	document.getElementsByName("mandStarAccountBO.Address.HoldMailReason")[0].style.visibility="hidden"; 

	document.getElementsByName(currBOName+".Address.HoldMailInitiatedBy")[0].IsMandatory = "false";
	document.getElementsByName(currBOName+".Address.BusinessCenter")[0].IsMandatory = "false";
	document.getElementsByName(currBOName+".Address.HoldMailReason")[0].IsMandatory = "false";


   }
   //making HoldMail Fields Enabled
   else
   {
	document.getElementsByName(currBOName+".Address.HoldMailInitiatedBy")[0].disabled = false;
	document.getElementsByName(currBOName+".Address.BusinessCenter")[0].disabled = false;
	document.getElementsByName("btntwo_AccountBO.Address.BusinessCenter")[0].disabled = false;
	document.getElementsByName("btnone_AccountBO.Address.BusinessCenter")[0].disabled = false;
	document.getElementsByName(currBOName+".Address.HoldMailReason")[0].disabled = false;

	document.getElementsByName("mandStarAccountBO.Address.HoldMailInitiatedBy")[0].style.visibility="visible"; 
	document.getElementsByName("mandStarAccountBO.Address.BusinessCenter")[0].style.visibility="visible"; 
	document.getElementsByName("mandStarAccountBO.Address.HoldMailReason")[0].style.visibility="visible"; 

	document.getElementsByName(currBOName+".Address.HoldMailInitiatedBy")[0].IsMandatory = "true";
	document.getElementsByName(currBOName+".Address.BusinessCenter")[0].IsMandatory = "true";
	document.getElementsByName(currBOName+".Address.HoldMailReason")[0].IsMandatory = "true";

	
   }

}

function checkFormatForAddressType(){
	todayStart_date = 	document.getElementsByName("3_AccountBO.Address.Start_Date")[0];
	/* Tracker-ID 113259:ERPBOCF1:Hijri:To convert start date to Hijri date format - start*/
	//getting current date from system and converting it to Hijri date format if the calendar type selected by user is Hijri
	//todayStart_date.value = getTodayDate();
	var current_Date = getCurrentDate();
//Tracker-ID 113259:ERPBOCF1:Hijri CR:changes start
	/*if the selected calendar type is Hijri,current date is converted in the Hijr format
	if(calType == 'H')
	{
	current_Date = convertGregToHij(current_Date);
	}*/   
if((current_Date!= '') && (current_Date != undefined))
	{
		//date converted acc to the present calendar type 
		current_Date = changeDateAccToPresentCalendar(current_Date);
	}
//Tracker-ID 113259:ERPBOCF1:Hijri CR:changes end
	todayStart_date.value = current_Date;
	/* Tracker-ID 113259:ERPBOCF1:Hijri:To convert start date to Hijri date format - end*/
	var selectedAddressType = document.getElementsByName(currBOName+".Address.addressCategory")[0].value;
	var format = top.window.opener.checkFormatForAddressTypeSelected(selectedAddressType);
	if(format != null && format != "")
	{
		if(format != document.getElementsByName('AccountBO.Address.PreferredFormat')[0].value)
		{
			alert("Existing " +selectedAddressType +" Address is of "+format+" Format, so the format of the address will remain in same format");
		}
		document.getElementsByName('AccountBO.Address.PreferredFormat')[0].value = format;
		if(format == "FREE_TEXT_FORMAT")
		{
			//enabling free Text Label And Format
			//disableEnableFreeTextFields(false);

			//disabling structured field formats
			//disableEnableStructuredFields(true);
			//clearing Structured Values
			clearStructuredValues();
		}
		else
		{
			//disabling free Text Label And Format
			//disableEnableFreeTextFields(true);
			//clearing free text Values
			clearFreeTextValues();
				
			//enabling structured field formats
			//disableEnableStructuredFields(false);
		}
	}
	populateHoldMail(selectedAddressType);
}

function disableEnableFreeTextAddress(){
	var selectedFormat = document.getElementsByName(currBOName+".Address.PreferredFormat")[0].value;
	var selectedAddressType = document.getElementsByName(currBOName+".Address.addressCategory")[0].value;
	if(selectedFormat != null && selectedFormat !="")
	{
		var flag = top.window.opener.checkFormatSelected(selectedFormat,selectedAddressType);
		if(flag != null && flag != "")
		{
			if(flag != selectedAddressType)
			{
				alert("Existing " +flag +" Address is of "+selectedFormat+" Format, so the format of the address will remain in same format");
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
	}
	var confirmFlag = true;
	if(!checkForValue(document.getElementsByName(currBOName+".Address.PreferredFormat")[0].value))
	{
		confirmFlag = confirm("All the data will be cleared for the current address format. Do you want to continue?");
		if(confirmFlag == true)
		{
			clearAddressValues();
		}
		else
		{
			if(selectedFormat == "STRUCTURED_FORMAT")
				document.getElementsByName(currBOName+".Address.PreferredFormat")[0].value = "FREE_TEXT_FORMAT";
			else
				document.getElementsByName(currBOName+".Address.PreferredFormat")[0].value = "STRUCTURED_FORMAT";
		}
	}
	if(document.getElementsByName(currBOName+".Address.PreferredFormat")[0].value == "STRUCTURED_FORMAT" && confirmFlag)
	{
		//disabling free Text Label And Format
		//disableEnableFreeTextFields(true);
				
		//enabling structured field formats
		//disableEnableStructuredFields(false);

	}
	else if(document.getElementsByName(currBOName+".Address.PreferredFormat")[0].value == "FREE_TEXT_FORMAT" && confirmFlag)
	{
		//enabling free Text Label And Format
		//disableEnableFreeTextFields(false);

		//disabling structured field formats
		//disableEnableStructuredFields(true);
	}
}

function populateHoldMail(selectedAddressType)
{
	if(selectedAddressType != null && selectedAddressType != "")
	{
		var holdMailValues = top.window.opener.populateHoldMailForAddressType(selectedAddressType);
		if(holdMailValues != null)
		{
			if(holdMailValues[0] == "Y")
			{
				document.getElementsByName(currBOName+".Address.HoldMailFlag")[0].checked = true;				
			}
			else
			{
				document.getElementsByName(currBOName+".Address.HoldMailFlag")[0].checked = false;			
			}
			document.getElementsByName(currBOName+".Address.HoldMailInitiatedBy")[0].value = holdMailValues[1];
			document.getElementsByName(currBOName+".Address.BusinessCenter")[0].value = holdMailValues[2];
			document.getElementsByName(currBOName+".Address.HoldMailReason")[0].value = holdMailValues[3];
			disableEnableHoldMail();
		}
	}
}

function checkForValue(selectedPreferredFormat)
{
	if(selectedPreferredFormat == "FREE_TEXT_FORMAT")
	{
		var structuredFieldsArray = new Array();
		structuredFieldsArray[0] = document.getElementsByName(currBOName+".Address.city")[0].value;
		structuredFieldsArray[1] = document.getElementsByName(currBOName+".Address.country")[0].value;
		structuredFieldsArray[2] = document.getElementsByName(currBOName+".Address.state")[0].value;
		structuredFieldsArray[3] = document.getElementsByName(currBOName+".Address.zip")[0].value;
		structuredFieldsArray[4] = document.getElementsByName(currBOName+".Address.premise_name")[0].value;
		structuredFieldsArray[5] = document.getElementsByName(currBOName+".Address.building_level")[0].value;
		structuredFieldsArray[6] = document.getElementsByName(currBOName+".Address.street_no")[0].value;
		structuredFieldsArray[7] = document.getElementsByName(currBOName+".Address.suburb")[0].value;
		structuredFieldsArray[8] = document.getElementsByName(currBOName+".Address.street_name")[0].value;
		structuredFieldsArray[9] = document.getElementsByName(currBOName+".Address.locality_name")[0].value;
		structuredFieldsArray[10] = document.getElementsByName(currBOName+".Address.town")[0].value;
		structuredFieldsArray[11] = document.getElementsByName(currBOName+".Address.domicile")[0].value;
		structuredFieldsArray[12] = document.getElementsByName(currBOName+".Address.mailStop")[0].value;
		structuredFieldsArray[13] = document.getElementsByName(currBOName+".Address.URL")[0].value;
		structuredFieldsArray[14] = document.getElementsByName(currBOName+".Address.house_no")[0].value;
		structuredFieldsArray[15] = document.getElementsByName(currBOName+".Address.Start_Date")[0].value;
		//Tracker 105266
		structuredFieldsArray[16] = document.getElementsByName(currBOName+".Address.LastUpdate_Date")[0].value;
		structuredFieldsArray[17] = document.getElementsByName(currBOName+".Address.IsAddressProofRcvd")[0].value;
		

		for(var j=0;j<structuredFieldsArray.length;j++)
		{
			if(structuredFieldsArray[j] != ""){
				return false;
			}
		}
		return true;
	}
	else if(selectedPreferredFormat == "STRUCTURED_FORMAT"){

		var freeFieldsArray = new Array();
		freeFieldsArray[0] = document.getElementsByName(currBOName+".Address.FreeTextLabel")[0].value;
/* QED Changes: START */
		freeFieldsArray[1] = document.getElementsByName(currBOName+".Address.AddressLine1")[0].value;
		freeFieldsArray[2] = document.getElementsByName(currBOName+".Address.AddressLine2")[0].value;
		freeFieldsArray[3] = document.getElementsByName(currBOName+".Address.AddressLine3")[0].value;
		freeFieldsArray[4] = document.getElementsByName(currBOName+".Address.Start_Date")[0].value;
/* QED Changes: END */
		for(var j=0;j<freeFieldsArray.length;j++)
		{
			if(freeFieldsArray[j] != ""){
				return false;
			}
		}
		return true;
	}
}

function clearAddressValues()
{
	document.frm2.address_type.value= ""; 
	
	document.frm2.houseno.value= ""; 
	document.frm2.premiseno.value =  ""; 
	document.frm2.building.value =  ""; 
	//Tracker 105266
	document.frm2.premisename.value =  ""; 
	document.frm2.buildinglevel.value =  ""; 
	
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
	//Tracker 105266
	document.frm2.localityName.value= ""; 
	document.frm2.domicile.value= ""; 
	//document.frm2.website.value= ""; 
	//Tracker 105266
	document.frm2.url.value= ""; 
	document.frm2.mailstop.value= ""; 
	document.frm2.streetname.value= ""; 
	document.frm2.suburb.value= "";
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
/* AdressLine changes: START */
	document.frm2.AddressLine1.value = "";
	document.frm2.AddressLine2.value = "";
	document.frm2.AddressLine3.value = "";
/* AdressLine changes: END */
	document.frm2.FreeTextLabel.value = "";
	//Tracker 105266
	document.frm2.LastUpdate_Date.value = "";
//Changes for call id: 401260 and recon for TOL 397571
	document.frm2.LastUpdate_Date_Flag.value = "";
	document.frm2.IsAddressProofRcvd.value = "";
}

function disableEnableFreeTextFields(value){
	document.getElementsByName(currBOName+".Address.FreeTextLabel")[0].disabled = value;
/* AdressLine changes: START */
	document.getElementsByName(currBOName+".Address.AddressLine1")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.AddressLine2")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.AddressLine3")[0].disabled = value;
/* AdressLine changes: END */
	//making FreeTextFields Non-mandatory
	if(value == false)
	{
		document.getElementsByName(currBOName+".Address.FreeTextLabel")[0].IsMandatory = "true";
/* AdressLine changes: START */
		document.getElementsByName(currBOName+".Address.AddressLine1")[0].IsMandatory = "true";
		document.getElementsByName(currBOName+".Address.AddressLine2")[0].IsMandatory = "true";
		document.getElementsByName(currBOName+".Address.AddressLine3")[0].IsMandatory = "true";
/* AdressLine changes: END */

		document.getElementsByName("mandStarAccountBO.Address.FreeTextLabel")[0].style.visibility="visible"; 
/* AdressLine changes: START */
		document.getElementsByName("mandStarAccountBO.Address.AddressLine1")[0].style.visibility="visible"; 
		document.getElementsByName("mandStarAccountBO.Address.AddressLine2")[0].style.visibility="visible"; 
		document.getElementsByName("mandStarAccountBO.Address.AddressLine3")[0].style.visibility="visible"; 
/* AdressLine changes: END */
	}
	//making FreeTextFields Mandatory
	else
	{
		document.getElementsByName(currBOName+".Address.FreeTextLabel")[0].IsMandatory = "false";
/* AdressLine changes: START */
		document.getElementsByName(currBOName+".Address.AddressLine1")[0].IsMandatory = "false";
		document.getElementsByName(currBOName+".Address.AddressLine2")[0].IsMandatory = "false";
		document.getElementsByName(currBOName+".Address.AddressLine3")[0].IsMandatory = "false";
/* AdressLine changes: END */

		document.getElementsByName("mandStarAccountBO.Address.FreeTextLabel")[0].style.visibility="hidden"; 
/* AdressLine changes: START */
		document.getElementsByName("mandStarAccountBO.Address.AddressLine1")[0].style.visibility="hidden"; 
		document.getElementsByName("mandStarAccountBO.Address.AddressLine2")[0].style.visibility="hidden"; 
		document.getElementsByName("mandStarAccountBO.Address.AddressLine3")[0].style.visibility="hidden"; 
		//Tracker 105266
		document.getElementsByName("mandStarAccountBO.Address.LastUpdate_Date")[0].style.visibility="hidden"; 
/* AdressLine changes: END */
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
	document.getElementsByName(currBOName+".Address.zip")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.house_no")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.premise_name")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.building_level")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.street_no")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.suburb")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.street_name")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.locality_name")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.town")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.domicile")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.mailStop")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.URL")[0].disabled = value;
	//Tracker 105266
	document.getElementsByName(currBOName+".Address.IsAddressProofRcvd")[0].disabled = value;
	document.getElementsByName(currBOName+".Address.LastUpdate_Date")[0].disabled = value;
		
	//making StructuredFields mandatory
	if(value == false)
	{
		document.getElementsByName("Cat_AccountBO.Address.city")[0].IsMandatory = "true";
		document.getElementsByName(currBOName+".Address.house_no")[0].IsMandatory = "true";
		document.getElementsByName("Cat_AccountBO.Address.country")[0].IsMandatory = "true";
		document.getElementsByName("Cat_AccountBO.Address.state")[0].IsMandatory = "true";
		document.getElementsByName(currBOName+".Address.zip")[0].IsMandatory = "true";
		document.getElementsByName(currBOName+".Address.street_name")[0].IsMandatory = "true";
		document.getElementsByName(currBOName+".Address.street_no")[0].IsMandatory = "true";

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
		document.getElementsByName(currBOName+".Address.house_no")[0].IsMandatory = "false";
		document.getElementsByName("Cat_AccountBO.Address.country")[0].IsMandatory = "false";
		document.getElementsByName("Cat_AccountBO.Address.state")[0].IsMandatory = "false";
		document.getElementsByName(currBOName+".Address.zip")[0].IsMandatory = "false";
		document.getElementsByName(currBOName+".Address.street_name")[0].IsMandatory = "false";
		document.getElementsByName(currBOName+".Address.street_no")[0].IsMandatory = "false";

		document.getElementsByName("mandStarAccountBO.Address.city")[0].style.visibility="hidden"; 
		document.getElementsByName("mandStarAccountBO.Address.house_no")[0].style.visibility="hidden"; 
		document.getElementsByName("mandStarAccountBO.Address.street_name")[0].style.visibility="hidden"; 
		document.getElementsByName("mandStarAccountBO.Address.street_no")[0].style.visibility="hidden";
		document.getElementsByName("mandStarAccountBO.Address.country")[0].style.visibility="hidden"; 
		document.getElementsByName("mandStarAccountBO.Address.state")[0].style.visibility="hidden"; 
		document.getElementsByName("mandStarAccountBO.Address.zip")[0].style.visibility="hidden";
	}
}

function  lookupBC (type){
bcLookupType = type;
var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForBCCode&isActive=Y&isAutomated=Y";
//var url = '../servlet/com.infy.cis.ui.common.SimpleLookupFilter?isActive=Y&isAutomated=N&ViewName=BCCode_Lookup';
var style = "height=436, left=70, top=120, width=860,resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes";
window.open (url, "Lookup", style);
}

//CIF PhoneEmail Changes: End
function removeAddress()
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
				// Tracker ID: 135125: XMLEncoding Changes STARTS
            	if(boName == "AccountBO" )
            	{
            		EduDetURL = document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.url_");
            	}
            	else if(boName == "AccountModBO")
		{
			EduDetURL = document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.url_");
		}
		else if(boName == "ContactBO" )
		{
			EduDetURL = document.all.RecordSet.rows(i).getAttribute("ContactBO.Address.url_");
		}
		else if( boName == "ContactModBO")
		{	
			EduDetURL = document.all.RecordSet.rows(i).getAttribute("ContactModBO.Address.url_");
		}
		else if(boName == "SuspectBO" )
		{
			EduDetURL = document.all.RecordSet.rows(i).getAttribute("SuspectBO.Address.url_");
		}
		else if(boName == "SuspectModBO")
		{
			EduDetURL = document.all.RecordSet.rows(i).getAttribute("SuspectModBO.Address.url_");
		}
		else if(boName == "NonCustomerBO" )
		{
			EduDetURL = document.all.RecordSet.rows(i).getAttribute("NonCustomerBO.Address.url_");
		}
		else if( boName == "NonCustomerModBO")
		{
			EduDetURL = document.all.RecordSet.rows(i).getAttribute("NonCustomerModBO.Address.url_");
		}
        // Tracker ID: 135125: XMLEncoding Changes ENDS        
		if(showUserChoiceMessage('MSG045', 'MSG_LOROW')) {	                
			noOfAttachURLs = addr_URL.length;
			var deleteAlreadyExistingEduDet = true;
			for(r=0; r< noOfAttachURLs; r++) {
			    if(addr_URL[r] == EduDetURL){
//Changes for call id: 401260 and recon for TOL 397571
			//Changes for tracker ID 442887 start
			    ad_LastUpdate_Flag[r]=null;
			    //Changes for tracker ID 442887 ends
			    //recon for 378296  begins
				if(edu_Status[r] != "New" && edu_Status[r] != "Edit"){
				//recon for 378296  ends
				    deleteAlreadyExistingEduDet = false;
				}
				addr_URL[r] = null;
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
    }catch(e){alert("Exception in remove Address"+e.description);
    }
}
function editQuickAddressDetails()
{
    try{
		if(boName == "AccountBO" || boName == "AccountModBO")
		{
			currBOName = "AccountBO";
		}
		if(boName == "ContactBO" || boName == "ContactModBO")
		{	
			currBOName = "ContactBO";
		}
		if(boName == "SuspectBO" || boName == "SuspectModBO")
		{
			currBOName = "SuspectBO";
		}
		if(boName == "NonCustomerBO" || boName == "NonCustomerModBO")
		{
			currBOName = "NonCustomerBO";
		}
        updateDet = true;
        var tempTableRow = '';
        if(event.srcElement.parentElement.id == null || event.srcElement.parentElement.id == '') {
               
               tempTableRow = event.srcElement.parentElement.parentElement;
        } else {
        
                tempTableRow = event.srcElement.parentElement;
        }
        currEduTableRow = tempTableRow;
		// Tracker ID: 135125: XMLEncoding Changes STARTS
        if(boName == "AccountBO" )
	{
		EduDetURL = tempTableRow.getAttribute("AccountBO.Address.url_");
		// CORE-CIF Approval Changes
		var addrID = '';
		if(mainAccId !=''){
			addrID = tempTableRow.getAttribute("AccountBO.Address.MainTableID");
		} else {
			addrID = tempTableRow.getAttribute("AccountBO.Address.addressID");
		}
	}
	else if(boName == "AccountModBO")
	{
		EduDetURL = tempTableRow.getAttribute("AccountModBO.Address.url_");
		// CORE-CIF Approval Changes
		var addrID = '';
		if(mainAccId !=''){
			addrID = tempTableRow.getAttribute("AccountModBO.Address.MainTableID");
		} else {
			addrID = tempTableRow.getAttribute("AccountModBO.Address.addressID");
		}
	}
	else if(boName == "ContactBO" )
	{
		EduDetURL = tempTableRow.getAttribute("ContactBO.Address.url_");
		// CORE-CIF Approval Changes
		var addrID = '';
		if(mainAccId !=''){
			addrID = tempTableRow.getAttribute("ContactBO.Address.MainTableID");
		} else {
			addrID = tempTableRow.getAttribute("ContactBO.Address.addressID");
		}
	}
	else if( boName == "ContactModBO")
	{	
		EduDetURL = tempTableRow.getAttribute("ContactModBO.Address.url_");
		// CORE-CIF Approval Changes
		var addrID = '';
		if(mainAccId !=''){
			addrID = tempTableRow.getAttribute("ContactModBO.Address.MainTableID");
		} else {
			addrID = tempTableRow.getAttribute("ContactModBO.Address.addressID");
		}
	}
	else if(boName == "SuspectBO" )
	{
		EduDetURL = tempTableRow.getAttribute("SuspectBO.Address.url_");
		// CORE-CIF Approval Changes
		var addrID = '';
		if(mainAccId !=''){
			addrID = tempTableRow.getAttribute("SuspectBO.Address.MainTableID");
		} else {
			addrID = tempTableRow.getAttribute("SuspectBO.Address.addressID");
		}
	}
	else if(boName == "SuspectModBO")
	{
		EduDetURL = tempTableRow.getAttribute("SuspectModBO.Address.url_");
		// CORE-CIF Approval Changes
		var addrID = '';
		if(mainAccId !=''){
			addrID = tempTableRow.getAttribute("SuspectModBO.Address.MainTableID");
		} else {
			addrID = tempTableRow.getAttribute("SuspectModBO.Address.addressID");
		}
	}
	else if(boName == "NonCustomerBO" )
	{
		EduDetURL = tempTableRow.getAttribute("NonCustomerBO.Address.url_");
		// CORE-CIF Approval Changes
		var addrID = '';
		if(mainAccId !=''){
			addrID = tempTableRow.getAttribute("NonCustomerBO.Address.MainTableID");
		} else {
			addrID = tempTableRow.getAttribute("NonCustomerBO.Address.addressID");
		}
	}
	else if( boName == "NonCustomerModBO")
	{
		EduDetURL = tempTableRow.getAttribute("NonCustomerModBO.Address.url_");
		// CORE-CIF Approval Changes
		var addrID = '';
		if(mainAccId !=''){
			addrID = tempTableRow.getAttribute("NonCustomerModBO.Address.MainTableID");
		} else {
			addrID = tempTableRow.getAttribute("NonCustomerModBO.Address.addressID");
		}
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS
		var i = 0;
    	var x = addr_URL.length;
    	for(i=0; i < x; i++){
   		if(addr_URL[i] == EduDetURL) {
           		break;
            }
            else{
           
            }
        }
        // Tracker ID: 135125: XMLEncoding Changes STARTS
        if(boName == "AccountBO" )
 	{
		for (j=2; j < document.all.RecordSet.rows.length; j++){
		    var docURL = document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.url_");
		    if(docURL == EduDetURL) {
			break;
		    }
		}
 	}
 	else if(boName == "AccountModBO")
 	{
		for (j=2; j < document.all.RecordSet.rows.length; j++){
		    var docURL = document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.url_");
		    if(docURL == EduDetURL) {
			break;
		    }
		}
 	}
 	else if(boName == "ContactBO" )
 	{
		for (j=2; j < document.all.RecordSet.rows.length; j++){
		    var docURL = document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.url_");
		    if(docURL == EduDetURL) {
			break;
		    }
		}
 	}
 	else if( boName == "ContactModBO")
 	{	
		for (j=2; j < document.all.RecordSet.rows.length; j++){
		    var docURL = document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.url_");
		    if(docURL == EduDetURL) {
			break;
		    }
		}
 	}
 	else if(boName == "SuspectBO" )
 	{
		for (j=2; j < document.all.RecordSet.rows.length; j++){
		    var docURL = document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.url_");
		    if(docURL == EduDetURL) {
			break;
		    }
		}
 	}
 	else if(boName == "SuspectModBO")
 	{
		for (j=2; j < document.all.RecordSet.rows.length; j++){
		    var docURL = document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.url_");
		    if(docURL == EduDetURL) {
			break;
		    }
		}
 	}
 	else if(boName == "NonCustomerBO" )
 	{
		for (j=2; j < document.all.RecordSet.rows.length; j++){
		    var docURL = document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.url_");
		    if(docURL == EduDetURL) {
			break;
		    }
		}
 	}
 	else if( boName == "NonCustomerModBO")
 	{
		for (j=2; j < document.all.RecordSet.rows.length; j++){
		    var docURL = document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.url_");
		    if(docURL == EduDetURL) {
			break;
		    }
		}
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS
        eduRecordIndex = j;
        document.frm2.address_type.value=srmEscape(ad_address_type[i], '^', escChars);
/*Tracker 159095 : Sonali begin of changes*/        
        document.frm2.houseno.value=srmEscapeAddr(ad_houseno[i], '^', escCharsAddr);
        document.frm2.premiseno.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
        document.frm2.building.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
        document.frm2.premisename.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
        document.frm2.buildinglevel.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
/*Tracker 159095 : Sonali  end of changes*/

		//if(ad_PreferredFormat[i] != "FREE_TEXT_FORMAT"){
			document.frm2.country.value = srmEscape(ad_country[i], '^', escChars) +"|#"+srmEscape(ad_country_cat[i], '^', escChars);
			SetCookie("AccountBO.Address.country",ad_country_cat[i]);
			document.frm2.city.value = srmEscape(ad_city[i], '^', escChars) +"|#"+srmEscape(ad_city_cat[i], '^', escChars);
			SetCookie("AccountBO.Address.city",ad_city_cat[i]);
			document.frm2.state.value = srmEscape(ad_state[i], '^', escChars) +"|#"+srmEscape(ad_state_cat[i], '^', escChars);
			SetCookie("AccountBO.Address.state",ad_state_cat[i]);

		/*}
		else
		{
	        	document.frm2.country.value = "";
			document.frm2.city.value = "";
			document.frm2.state.value = "";
		}*/
		document.frm2.start_date.value = srmEscape(ad_start_date[i], '^', escChars);
		document.frm2.zip.value = srmEscape(ad_zip[i], '^', escChars);
		document.frm2.end_date.value = srmEscape(ad_end_date[i], '^', escChars);
		document.frm2.addrID.value = srmEscape(ad_addrID[i], '^', escChars);
/*Tracker 159095 : Sonali begin of changes*/
		document.frm2.streetno.value = srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
		document.frm2.town.value = srmEscapeAddr(ad_town[i], '^', escCharsAddr);
		document.frm2.locality.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
		document.frm2.localityName.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
		document.frm2.domicile.value = srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
/*Tracker 159095 : Sonali  end of changes*/
		//CIF PhoneEmail Changes : Start
		document.frm2.PreferredFormat.value = srmEscape(ad_PreferredFormat[i], '^', escChars);
		document.frm2.HoldMailReason.value = srmEscape(ad_HoldMailReason[i], '^', escChars);
		document.frm2.BusinessCenter.value = srmEscape(ad_BusinessCenter[i], '^', escChars);
		document.frm2.HoldMailInitiatedBy.value = srmEscape(ad_HoldMailInitiatedBy[i], '^', escChars);
		document.frm2.HoldMailFlag.value = srmEscape(ad_HoldMailFlag[i], '^', escChars);
		//Tracker 105266
	        document.frm2.LastUpdate_Date.value = srmEscape(ad_LastUpdate_Date[i], '^', escChars);
//  AdressLine changes: START 


		document.frm2.AddressLine1.value = srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
		document.frm2.AddressLine2.value = srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
		document.frm2.AddressLine3.value = srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
		
		/* changes for tracker 159520 */
		/*Commented the below line as the fix is wrong 159095
		document.frm2.AddressLine1.value = ad_AddressLine1[i];
		document.frm2.AddressLine2.value = ad_AddressLine2[i];
		document.frm2.AddressLine3.value = ad_AddressLine3[i];	*/	
		/* changes for tracker 159520  */
//  AdressLine changes: END 
/*Tracker 159095 : Sonali begin of changes*/
		document.frm2.FreeTextLabel.value = srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
/*Tracker 159095 : Sonali  end of changes*/
		//CIF PhoneEmail Changes : End

		//document.frm2.website.value = srmEscape(ad_website[i], '^', escChars);
/*Tracker 159095 : Sonali begin of changes*/
		document.frm2.url.value = srmEscapeAddr(ad_website[i], '^', escCharsAddr);
		document.frm2.mailstop.value = srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
		document.frm2.streetname.value = srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
		document.frm2.suburb.value = srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
/*Tracker 159095 : Sonali  end of changes*/
		document.frm2.IsAddressProofRcvd.value = srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
		document.frm2.IsAddressVerified.value = srmEscape(ad_IsAddressVerified[i], '^', escChars);
        /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
		/*changes for Ticketid 682574 starts*/
	  document.frm2.vAddTypeLT.value = srmEscape(ad_vAddTypeLT[i], '^', escChars);
/*changes for Ticketid 682574 ends*/
		document.frm2.country_code.value 	= srmEscape(ad_cntryCode[i], '^', escChars);
		document.frm2.state_code.value 		= srmEscape(ad_stateCode[i], '^', escChars);
		document.frm2.city_code.value 		= srmEscape(ad_cityCode[i], '^', escChars);
        recordIndex = i;
		checkWinOpen =true; // 817615 changes 
        EduDetDetailsEdit = window.open('../common/html/SSOblank.html', 'AddrDetails', 'directories=No, height=436, left=70, top=120, width=860,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
        document.frm2.target = 'AddrDetails'
		if(boName == "AccountBO" || boName == "AccountModBO")
		{
			document.frm2.action = '../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?isQuickEdit=Yes';		
		}
		if(boName == "ContactBO" || boName == "ContactModBO")
		{
	        document.frm2.action = '../servlet/com.infy.cis.ui.cif.QDEContactAddressdetail?isQuickEdit=Yes';
		}
		if(boName == "SuspectBO" || boName == "SuspectModBO")
		{
			document.frm2.action = '../servlet/com.infy.cis.ui.cif.QDEProspectAddressForm_Det?isQuickEdit=Yes';
		}
		if(boName == "NonCustomerBO" || boName == "NonCustomerModBO")
		{
	        document.frm2.action = '../servlet/com.infy.cis.ui.cif.NonCustomerAddress_Det?isQuickEdit=Yes';
		}
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
		
		if(boName == "AccountBO" || boName == "AccountModBO")
		{
			currBOName = "AccountBO";
		}
		if(boName == "ContactBO" || boName == "ContactModBO")
		{
			currBOName = "ContactBO";
		}
		if(boName == "SuspectBO" || boName == "SuspectModBO")
		{
			currBOName = "SuspectBO";
		}
		if(boName == "NonCustomerBO" || boName == "NonCustomerModBO")
		{
			currBOName = "NonCustomerBO";
		}
		updateDet = false;
        var EduDetURL = '';
        var addrID = '';
        if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
             showUserMessage("MSGCOPY",'MSGJ0120');
            return;
        }
        
        for (k=0; k < document.all.RecordSet.rows.length ; k++){
        var row_bgcolor = document.all.RecordSet.rows(k).className;
        if ( row_bgcolor == 'rowHighLighted')
        {
				// Tracker ID: 135125: XMLEncoding Changes STARTS
                if(boName == "AccountBO" )
	     	{
			EduDetURL = document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.url_");	     	
		}
	     	else if(boName == "AccountModBO")
	     	{
			EduDetURL = document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.url_");	     	
		}
	     	else if(boName == "ContactBO" )
	     	{
			EduDetURL = document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.url_");	     	
		}
	     	else if( boName == "ContactModBO")
	     	{	
			EduDetURL = document.all.RecordSet.rows(k).getAttribute("ContactModBO.Address.url_");	     	
		}
	     	else if(boName == "SuspectBO" )
	     	{
			EduDetURL = document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.url_");	     	
		}
	     	else if(boName == "SuspectModBO")
	     	{
			EduDetURL = document.all.RecordSet.rows(k).getAttribute("SuspectModBO.Address.url_");	     	
		}
	     	else if(boName == "NonCustomerBO" )
	     	{
			EduDetURL = document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.url_");	     	
		}
	     	else if( boName == "NonCustomerModBO")
	     	{
			EduDetURL = document.all.RecordSet.rows(k).getAttribute("NonCustomerModBO.Address.url_");		
		}
            // Tracker ID: 135125: XMLEncoding Changes ENDS
            
            var i = 0;
	            var x = addr_URL.length;
	        
	            
	            for(i=0; i < x; i++){
	            
	            
	                if(addr_URL[i] == EduDetURL) {
	                
	                //i--;
	                    break;
	                }
	                else{
	               
	                }
	            }
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName == "AccountBO" )
		{
			for (j=2; j < document.all.RecordSet.rows.length; j++){
			    var docURL = document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.url_");
			    if(docURL == EduDetURL) {
				break;
			    }
			}
		}
		else if(boName == "AccountModBO")
		{
			for (j=2; j < document.all.RecordSet.rows.length; j++){
			    var docURL = document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.url_");
			    if(docURL == EduDetURL) {
				break;
			    }
			}
		}
		else if(boName == "ContactBO" )
		{
			for (j=2; j < document.all.RecordSet.rows.length; j++){
			    var docURL = document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.url_");
			    if(docURL == EduDetURL) {
				break;
			    }
			}
		}
		else if( boName == "ContactModBO")
		{	
			for (j=2; j < document.all.RecordSet.rows.length; j++){
			    var docURL = document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.url_");
			    if(docURL == EduDetURL) {
				break;
			    }
			}
		}
		else if(boName == "SuspectBO" )
		{
			for (j=2; j < document.all.RecordSet.rows.length; j++){
			    var docURL = document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.url_");
			    if(docURL == EduDetURL) {
				break;
			    }
			}
		}
		else if(boName == "SuspectModBO")
		{
			for (j=2; j < document.all.RecordSet.rows.length; j++){
			    var docURL = document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.url_");
			    if(docURL == EduDetURL) {
				break;
			    }
			}
		}
		else if(boName == "NonCustomerBO" )
		{
			for (j=2; j < document.all.RecordSet.rows.length; j++){
			    var docURL = document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.url_");
			    if(docURL == EduDetURL) {
				break;
			    }
			}
		}
		else if( boName == "NonCustomerModBO")
		{
			for (j=2; j < document.all.RecordSet.rows.length; j++){
			    var docURL = document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.url_");
			    if(docURL == EduDetURL) {
				break;
			    }
			}
		}
	    // Tracker ID: 135125: XMLEncoding Changes ENDS
           	eduRecordIndex = j;
	            
	            
	    
			document.frm2.address_type.value=srmEscape(ad_address_type[i], '^', escChars);
/*Tracker 159095 : Sonali begin of changes*/			
			document.frm2.houseno.value=srmEscapeAddr(ad_houseno[i], '^', escCharsAddr);;
			document.frm2.premiseno.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
			document.frm2.building.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
			document.frm2.premisename.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
			document.frm2.buildinglevel.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
/*Tracker 159095 : Sonali  end of changes*/
			
			/* Change for ticket 324797 start */
/*			if(ad_PreferredFormat[i] != "FREE_TEXT_FORMAT"){*/
				document.frm2.country.value = srmEscape(ad_country[i], '^', escChars) +"|#"+srmEscape(ad_country_cat[i], '^', escChars);
				SetCookie("AccountBO.Address.country",ad_country_cat[i]);
				document.frm2.city.value = srmEscape(ad_city[i], '^', escChars) +"|#"+srmEscape(ad_city_cat[i], '^', escChars);
				SetCookie("AccountBO.Address.city",ad_city_cat[i]);
				document.frm2.state.value = srmEscape(ad_state[i], '^', escChars) +"|#"+srmEscape(ad_state_cat[i], '^', escChars);
				SetCookie("AccountBO.Address.state",ad_state_cat[i]);
/*			}
			else
			{
				document.frm2.country.value = "";
				document.frm2.city.value = "";
				document.frm2.state.value = "";
			}*/
			/* Change for ticket 324797 end */
			document.frm2.start_date.value = srmEscape(ad_start_date[i], '^', escChars);
			document.frm2.zip.value = srmEscape(ad_zip[i], '^', escChars);
			document.frm2.end_date.value = '';
	            	/*ticket id: 323212 Changes Begin */
			document.frm2.addrID.value = "";
			/*ticket id: 323212 Changes End */
/*Tracker 159095 : Sonali begin of changes*/
			document.frm2.streetno.value = srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
			document.frm2.town.value = srmEscapeAddr(ad_town[i], '^', escCharsAddr);
			document.frm2.locality.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
			document.frm2.localityName.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);			
			document.frm2.domicile.value = srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
/*Tracker 159095 : Sonali  end of changes*/
			document.frm2.LastUpdate_Date.value = srmEscape(ad_LastUpdate_Date[i], '^', escChars);

			//CIF PhoneEmail Changes : Start
			document.frm2.PreferredFormat.value = srmEscape(ad_PreferredFormat[i], '^', escChars);
			document.frm2.HoldMailReason.value = srmEscape(ad_HoldMailReason[i], '^', escChars);
			document.frm2.BusinessCenter.value = srmEscape(ad_BusinessCenter[i], '^', escChars);
			document.frm2.HoldMailInitiatedBy.value = srmEscape(ad_HoldMailInitiatedBy[i], '^', escChars);
			document.frm2.HoldMailFlag.value = srmEscape(ad_HoldMailFlag[i], '^', escChars);
/*Tracker 159095 : Sonali begin of changes*/
			document.frm2.AddressLine1.value = srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
			document.frm2.AddressLine2.value = srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
			document.frm2.AddressLine3.value = srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
			document.frm2.FreeTextLabel.value = srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
/*Tracker 159095 : Sonali  end of changes*/
			//CIF PhoneEmail Changes : End
			//document.frm2.website.value = srmEscape(ad_website[i], '^', escChars);
			//Tracker 105266
			document.frm2.IsAddressProofRcvd.value = srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);			
/*Tracker 159095 : Sonali begin of changes*/
/*changes for Ticketid 682574 starts*/
			document.frm2.vAddTypeLT.value = srmEscape(ad_vAddTypeLT[i], '^', escChars);
/*changes for Ticketid 682574 ends*/
			document.frm2.url.value = srmEscapeAddr(ad_website[i], '^', escCharsAddr);
			document.frm2.mailstop.value = srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
			document.frm2.streetname.value = srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
			document.frm2.suburb.value = srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
/*Tracker 159095 : Sonali  end of changes*/
	    	/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			document.frm2.IsAddressVerified.value = srmEscape(ad_IsAddressVerified[i], '^', escChars);
			/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
		  //CIF Changes for RefCodes
			document.frm2.country_code.value 	= srmEscape(ad_cityCode[i], '^', escChars);
			document.frm2.state_code.value 		= srmEscape(ad_stateCode[i], '^', escChars);
			document.frm2.city_code.value 		= srmEscape(ad_cntryCode[i], '^', escChars);
		  //CIF Changes for RefCodes
	    
	    
			recordIndex = i;
	
			EduDetDetailsEdit = window.open('../common/html/SSOblank.html', 'EduDetails', 'directories=No, height=436, left=70, top=120, width=860,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
			document.frm2.target = 'EduDetails'
			if(boName == "AccountBO" || boName == "AccountModBO")
			{
				document.frm2.action = '../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?isQuickEdit=Yes&IsFormatReadOnly=Yes';		
			}
			if(boName == "ContactBO" || boName == "ContactModBO")
			{
				document.frm2.action = '../servlet/com.infy.cis.ui.cif.QDEContactAddressdetail?isQuickEdit=Yes&IsFormatReadOnly=Yes';
			}
			if(boName == "SuspectBO" || boName == "SuspectModBO")
			{
				/*Fix Start for ticket: 253707 */
				document.frm2.action = '../servlet/com.infy.cis.ui.cif.QDEProspectAddressForm_Det?isQuickEdit=Yes&IsFormatReadOnly=Yes';
				/*Fix End for ticket: 253707 */
			}
			if(boName == "NonCustomerBO" || boName == "NonCustomerModBO")
			{
				document.frm2.action = '../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?isQuickEdit=Yes&IsFormatReadOnly=Yes';
			}
			document.frm2.submit();
            
        }
        }
        }catch(e){
        }
        
}

function addQuickAddrDetails(AddrDetails, addressTypeFlag){
try{
		if(boName == "AccountBO" || boName == "AccountModBO")
		{
			currBOName = "AccountBO";
		}
		if(boName == "ContactBO" || boName == "ContactModBO")
		{
			currBOName = "ContactBO";
		}
		if(boName == "SuspectBO" || boName == "SuspectModBO")
		{
			currBOName = "SuspectBO";
		}
		if(boName == "NonCustomerBO" || boName == "NonCustomerModBO")
		{
			currBOName = "NonCustomerBO";
		}
		
    address_type                = AddrDetails[0];
    houseno                     = AddrDetails[1];
    //Tracker 105266
    premiseno                 = AddrDetails[2];
    premisename                 = AddrDetails[2];
    end_date                    = AddrDetails[3];
    start_date                  = AddrDetails[4];
    city                        = AddrDetails[5];
    country                     = AddrDetails[6];
    state                       = AddrDetails[7];
    zip                         = AddrDetails[8];
    building		    	= AddrDetails[9];
    buildinglevel	   	= AddrDetails[9];
    addrID			= AddrDetails[10];
    streetno		        = AddrDetails[11];
    locality			= AddrDetails[12];
    localityName		= AddrDetails[12];
    town			= AddrDetails[13];
    domicile			= AddrDetails[14];
    streetname		        = AddrDetails[15];
    suburb                      = AddrDetails[16];
   
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
/* QED Changes: START */

	addressLine1      = AddrDetails[25];
	addressLine2      = AddrDetails[26];
	addressLine3      = AddrDetails[27];
	/*ticket Id: 262532Changes Begin */
    if(AddrDetails[28])
	{
	     freeTextLabel     = AddrDetails[28];
	}
	else
	{
		freeTextLabel     = '';
	}
	/*ticket Id: 262532Changes End */
	
	/*Fix Start for ticket: 253707 */
	/* As Address.FreeTextLabel is commented in the further address xsl , it comes as undefined */
	/*Reverting the change for ticket 258221*/
	
	//freeTextLabel ='';
	/*Fix End for ticket: 253707 */
        mailstop	  = AddrDetails[29];
       //website	  = AddrDetails[30];
        url		  = AddrDetails[30];
	city_cat          = AddrDetails[31];
	state_cat         = AddrDetails[32];
	country_cat       = AddrDetails[33];
	LastUpdate_Date   = AddrDetails[34];
	// Fix for tracker 153485 
    /*ticket Id: 262532Changes Begin */ 
//Changes for call id: 401260 and recon for TOL 397571
        updateflag	= AddrDetails[35];
	IsAddressProofRcvd= AddrDetails[36];
    /*ticket Id: 262532Changes End */
	name 		=AddrDetails[37];	
	/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
	IsAddressVerified= AddrDetails[42];

	/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
	/*changes for Ticketid 682574 starts*/
vAddTypeLT = AddrDetails[43];
/*changes for Ticketid 682574 ends*/
/* QED Changes: END */
  //CIF PhoneEmail Changes : End

    var uid = null;
    var alreadyAdded = false;


	if(!addressTypeFlag)
	{
    	city_cat = GetCookie(boName+'.Address.city');
    	state_cat = GetCookie(boName+'.Address.state');
    	country_cat = GetCookie(boName+'.Address.country');


	}

    if(!alreadyAdded){
    
        var noOfexistingURLs = addr_URL.length;
        for(var x = 0; x < noOfexistingURLs ; x++) {
            //here compare with combination of Inst and Qualification
            if(eduURL == addr_URL[x]) {
                alreadyAdded = true;
                if(updateDet){
                    if(x != recordIndex){
                        updateDet = false;
                    }
                }
                break;
            }
        }
        if(updateDet){
			
            alreadyAdded = true;
            //edu_detachedURLs[edu_detachedURLs.length] = ad_addrID[recordIndex];
            ad_addrID[recordIndex] = addrID;
                       
            ad_address_type[recordIndex] = address_type;
            ad_houseno[recordIndex] = houseno;
            ad_premiseno[recordIndex] = premiseno;
            //Tracker 105266
            ad_premiseno[recordIndex] = premisename;
            ad_end_date[recordIndex] = end_date;
            
            ad_start_date[recordIndex] = start_date;
            ad_zip[recordIndex] = zip;
            ad_state[recordIndex] = state;
            ad_state_cat[recordIndex] = state_cat;
            ad_city[recordIndex] = city;
            ad_city_cat[recordIndex] = city_cat;
            ad_country[recordIndex] = country;
            ad_country_cat[recordIndex] = country_cat;
            ad_building[recordIndex] = building;
            ad_building[recordIndex] = buildinglevel;
            ad_streetno[recordIndex] = streetno;
            ad_town[recordIndex] = town;
            ad_locality[recordIndex] = locality;
             ad_locality[recordIndex] = localityName;
            ad_domicile[recordIndex] = domicile;
           ad_LastUpdate_Date[recordIndex]  = LastUpdate_Date;
			//CIF PhoneEmail Changes : Start
			ad_PreferredFormat[recordIndex] = preferredFormat;
			ad_HoldMailReason[recordIndex] = holdMailReason;
			ad_BusinessCenter[recordIndex] = businessCenter;
			ad_HoldMailInitiatedBy[recordIndex] = holdMailInitiatedBy;
			ad_HoldMailFlag[recordIndex] =  holdMailFlag;
/* AdressLine changes: START */
			ad_AddressLine1[recordIndex] = addressLine1;
			ad_AddressLine2[recordIndex] = addressLine2;
			ad_AddressLine3[recordIndex] = addressLine3;


/* AdressLine changes: END */
			ad_FreeTextLabel[recordIndex] = freeTextLabel;
			//CIF PhoneEmail Changes : End

		  //  ad_website[recordIndex] = website;
		  ad_website[recordIndex] = url;
            ad_mailstop[recordIndex] = mailstop;
            ad_streetname[recordIndex] = streetname;
            ad_suburb[recordIndex] = suburb;
	    ad_IsAddressProofRcvd[recordIndex] = IsAddressProofRcvd;
	    /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
	    ad_IsAddressVerified[recordIndex] = IsAddressVerified;
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
	    // changes for ticket 682574 starts
       	    ad_vAddTypeLT[recordIndex] = vAddTypeLT;
// changes for ticket 682574 startsends
		     //CIF Changes for RefCodes
		     ad_cityCode[recordIndex] 	       = city_code;
			 ad_stateCode[recordIndex] 	       = state_code;
		     ad_cntryCode[recordIndex] 	       = cntry_code;
			  //CIF Changes for RefCodes
			 addr_URL[recordIndex] = eduURL;
            
//Changes for call id: 401260 and recon for TOL 397571
	    ad_LastUpdate_Flag[recordIndex] =updateflag;
             edu_Status[recordIndex] = "Edit";
            
            
        }
    }
    if(!alreadyAdded) {
    
    	    adcount=addr_URL.length;
    
			ad_address_type[adcount] = address_type;
	        ad_houseno[adcount] = houseno;
            ad_premiseno[adcount] = premiseno;
          //Tracker 105266
          ad_premiseno[adcount] = premisename;
            ad_end_date[adcount] = end_date;
            ad_start_date[adcount] = start_date;
            ad_zip[adcount] = zip;
            ad_state[adcount] = state;
            ad_state_cat[adcount] = state_cat;
            ad_city[adcount] = city;
            ad_city_cat[adcount] = city_cat;
            ad_country[adcount] = country;
            ad_country_cat[adcount] = country_cat;
            ad_building[adcount] = building;
            ad_building[adcount] = buildinglevel;
            ad_streetno[adcount] = streetno;
            ad_town[adcount] = town;
		    ad_locality[adcount] = locality;
		    ad_locality[adcount] = localityName;
		    ad_domicile[adcount] = domicile;
		    ad_LastUpdate_Date[adcount] = LastUpdate_Date;
			ad_PreferredFormat[adcount] = preferredFormat;
			ad_HoldMailReason[adcount] = holdMailReason;
			ad_BusinessCenter[adcount] = businessCenter;
			ad_HoldMailInitiatedBy[adcount] = holdMailInitiatedBy;
			ad_HoldMailFlag[adcount] =  holdMailFlag;
/* AdressLine changes: START */
			ad_AddressLine1[adcount] = addressLine1;
			ad_AddressLine2[adcount] = addressLine2;
			ad_AddressLine3[adcount] = addressLine3;


/* AdressLine changes: END */
			ad_FreeTextLabel[adcount] = freeTextLabel;

		    //ad_website[adcount] = website;
		    ad_website[adcount] = url;
            ad_mailstop[adcount] = mailstop;
            ad_streetname[adcount] = streetname;
            ad_suburb[adcount] = suburb;
//Changes for call id: 401260 and recon for TOL 397571
	    ad_LastUpdate_Flag[adcount] = updateflag;
           ad_IsAddressProofRcvd[adcount] = IsAddressProofRcvd;
           /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
           ad_IsAddressVerified[adcount] = IsAddressVerified;
           /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
		   // changes for ticket 682574 starts
			 ad_vAddTypeLT[adcount] = vAddTypeLT;
// changes for ticket 682574 startsends
		  //CIF Changes for RefCodes
			 ad_cityCode[ad_cityCode.length] 	       = city_code;
			 ad_stateCode[ad_stateCode.length] 	       = state_code;
			 ad_cntryCode[ad_cntryCode.length] 	       = cntry_code;
		  //CIF Changes for RefCodes
            edu_Status[adcount] = "New";
            addr_URL[adcount] = eduURL;
			if(addressTypeFlag)
			{
				ad_addrID[adcount] = addrID;
			}
			else
			{
				ad_addrID[adcount] = "";
			}

    }
       var add_category_ML = "";
       var add_city_ML = "";
       var add_state_ML = "";
       var add_country_ML = "";

	if(addressTypeFlag)
	{
	    add_category_ML = GetCookie(boName+'.Address.addressCategory');
	    add_city_ML = city_cat;
	    add_state_ML = state_cat;
	    add_country_ML = country_cat;
	}
	else
	{
	   add_category_ML = GetCookie(currBOName+'.Address.addressCategory');
	   add_city_ML = GetCookie(currBOName+'.Address.city');
	   add_state_ML = GetCookie(currBOName+'.Address.state');
	   add_country_ML = GetCookie(currBOName+'.Address.country');
	}
	/* CIF PhoneEmail Changes : Start*/
	if(preferredFormat == "FREE_TEXT_FORMAT"){
		add_city_ML = "";
		add_state_ML = "";
		add_country_ML = "";
	}
	/* CIF PhoneEmail Changes : End*/
	if(address_type!="Swift"){
    if (!updateDet)
    {
        if(alreadyAdded) {
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
        
    // Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName == "AccountBO" )
	{
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

		/* AdressLine changes: START */
		oNewNode.setAttribute("AccountBO.Address.AddressLine1", addressLine1);
		oNewNode.setAttribute("AccountBO.Address.AddressLine2", addressLine2);
		oNewNode.setAttribute("AccountBO.Address.AddressLine3", addressLine3);
		/* AdressLine changes: END */

		oNewNode.setAttribute("AccountBO.Address.FreeTextLabel", freeTextLabel);
		oNewNode.setAttribute("AccountBO.Address.HoldMailFlag", holdMailFlag);
		oNewNode.setAttribute("AccountBO.Address.mailStop", mailstop);
		//Tracker 105266
		oNewNode.setAttribute("AccountBO.Address.URL", url);
		oNewNode.setAttribute("AccountBO.Address.url_", address_type+start_date);
		/* CIF PhoneEmail Changes : End */ 
	}
	else if(boName == "AccountModBO")
	{
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

		/* AdressLine changes: START */
		oNewNode.setAttribute("AccountModBO.Address.AddressLine1", addressLine1);
		oNewNode.setAttribute("AccountModBO.Address.AddressLine2", addressLine2);
		oNewNode.setAttribute("AccountModBO.Address.AddressLine3", addressLine3);
		/* AdressLine changes: END */

		oNewNode.setAttribute("AccountModBO.Address.FreeTextLabel", freeTextLabel);
		oNewNode.setAttribute("AccountModBO.Address.HoldMailFlag", holdMailFlag);
		oNewNode.setAttribute("AccountModBO.Address.mailStop", mailstop);
		//Tracker 105266
		oNewNode.setAttribute("AccountModBO.Address.URL", url);
		oNewNode.setAttribute("AccountModBO.Address.url_", address_type+start_date);
		/* CIF PhoneEmail Changes : End */ 
	}
	else if(boName == "ContactBO" )
	{
		oNewNode.setAttribute("ContactBO.Address.addressCategory", address_type);
		oNewNode.setAttribute("ContactBO.Address.Start_Date", start_date);
		oNewNode.setAttribute("ContactBO.Address.country", country);
		oNewNode.setAttribute("ContactBO.Address.state", state);  
		oNewNode.setAttribute("ContactBO.Address.city", city);
		/* CIF PhoneEmail Changes : Start */
		oNewNode.setAttribute("ContactBO.Address.PreferredFormat", preferredFormat);
		oNewNode.setAttribute("ContactBO.Address.HoldMailReason", holdMailReason);
		oNewNode.setAttribute("ContactBO.Address.BusinessCenter", businessCenter);
		oNewNode.setAttribute("ContactBO.Address.HoldMailInitiatedBy", holdMailInitiatedBy);

		/* AdressLine changes: START */
		oNewNode.setAttribute("ContactBO.Address.AddressLine1", addressLine1);
		oNewNode.setAttribute("ContactBO.Address.AddressLine2", addressLine2);
		oNewNode.setAttribute("ContactBO.Address.AddressLine3", addressLine3);
		/* AdressLine changes: END */

		oNewNode.setAttribute("ContactBO.Address.FreeTextLabel", freeTextLabel);
		oNewNode.setAttribute("ContactBO.Address.HoldMailFlag", holdMailFlag);
		oNewNode.setAttribute("ContactBO.Address.mailStop", mailstop);
		//Tracker 105266
		oNewNode.setAttribute("ContactBO.Address.URL", url);
		oNewNode.setAttribute("ContactBO.Address.url_", address_type+start_date);
		/* CIF PhoneEmail Changes : End */ 
	}
	else if( boName == "ContactModBO")
	{	
		oNewNode.setAttribute("ContactModBO.Address.addressCategory", address_type);
		oNewNode.setAttribute("ContactModBO.Address.Start_Date", start_date);
		oNewNode.setAttribute("ContactModBO.Address.country", country);
		oNewNode.setAttribute("ContactModBO.Address.state", state);  
		oNewNode.setAttribute("ContactModBO.Address.city", city);
		/* CIF PhoneEmail Changes : Start */
		oNewNode.setAttribute("ContactModBO.Address.PreferredFormat", preferredFormat);
		oNewNode.setAttribute("ContactModBO.Address.HoldMailReason", holdMailReason);
		oNewNode.setAttribute("ContactModBO.Address.BusinessCenter", businessCenter);
		oNewNode.setAttribute("ContactModBO.Address.HoldMailInitiatedBy", holdMailInitiatedBy);

		/* AdressLine changes: START */
		oNewNode.setAttribute("ContactModBO.Address.AddressLine1", addressLine1);
		oNewNode.setAttribute("ContactModBO.Address.AddressLine2", addressLine2);
		oNewNode.setAttribute("ContactModBO.Address.AddressLine3", addressLine3);
		/* AdressLine changes: END */

		oNewNode.setAttribute("ContactModBO.Address.FreeTextLabel", freeTextLabel);
		oNewNode.setAttribute("ContactModBO.Address.HoldMailFlag", holdMailFlag);
		oNewNode.setAttribute("ContactModBO.Address.mailStop", mailstop);
		//Tracker 105266
		oNewNode.setAttribute("ContactModBO.Address.URL", url);
		oNewNode.setAttribute("ContactModBO.Address.url_", address_type+start_date);
		/* CIF PhoneEmail Changes : End */ 
	}
	else if(boName == "SuspectBO" )
	{
		oNewNode.setAttribute("SuspectBO.Address.addressCategory", address_type);
		oNewNode.setAttribute("SuspectBO.Address.Start_Date", start_date);
		oNewNode.setAttribute("SuspectBO.Address.country", country);
		oNewNode.setAttribute("SuspectBO.Address.state", state);  
		oNewNode.setAttribute("SuspectBO.Address.city", city);
		/* CIF PhoneEmail Changes : Start */
		oNewNode.setAttribute("SuspectBO.Address.PreferredFormat", preferredFormat);
		oNewNode.setAttribute("SuspectBO.Address.HoldMailReason", holdMailReason);
		oNewNode.setAttribute("SuspectBO.Address.BusinessCenter", businessCenter);
		oNewNode.setAttribute("SuspectBO.Address.HoldMailInitiatedBy", holdMailInitiatedBy);

		/* AdressLine changes: START */
		oNewNode.setAttribute("SuspectBO.Address.AddressLine1", addressLine1);
		oNewNode.setAttribute("SuspectBO.Address.AddressLine2", addressLine2);
		oNewNode.setAttribute("SuspectBO.Address.AddressLine3", addressLine3);
		/* AdressLine changes: END */

		oNewNode.setAttribute("SuspectBO.Address.FreeTextLabel", freeTextLabel);
		oNewNode.setAttribute("SuspectBO.Address.HoldMailFlag", holdMailFlag);
		oNewNode.setAttribute("SuspectBO.Address.mailStop", mailstop);
		//Tracker 105266
		oNewNode.setAttribute("SuspectBO.Address.URL", url);
		oNewNode.setAttribute("SuspectBO.Address.url_", address_type+start_date);
		/* CIF PhoneEmail Changes : End */ 
 	}
	else if(boName == "SuspectModBO")
	{
		oNewNode.setAttribute("SuspectModBO.Address.addressCategory", address_type);
		oNewNode.setAttribute("SuspectModBO.Address.Start_Date", start_date);
		oNewNode.setAttribute("SuspectModBO.Address.country", country);
		oNewNode.setAttribute("SuspectModBO.Address.state", state);  
		oNewNode.setAttribute("SuspectModBO.Address.city", city);
		/* CIF PhoneEmail Changes : Start */
		oNewNode.setAttribute("SuspectModBO.Address.PreferredFormat", preferredFormat);
		oNewNode.setAttribute("SuspectModBO.Address.HoldMailReason", holdMailReason);
		oNewNode.setAttribute("SuspectModBO.Address.BusinessCenter", businessCenter);
		oNewNode.setAttribute("SuspectModBO.Address.HoldMailInitiatedBy", holdMailInitiatedBy);

		/* AdressLine changes: START */
		oNewNode.setAttribute("SuspectModBO.Address.AddressLine1", addressLine1);
		oNewNode.setAttribute("SuspectModBO.Address.AddressLine2", addressLine2);
		oNewNode.setAttribute("SuspectModBO.Address.AddressLine3", addressLine3);
		/* AdressLine changes: END */

		oNewNode.setAttribute("SuspectModBO.Address.FreeTextLabel", freeTextLabel);
		oNewNode.setAttribute("SuspectModBO.Address.HoldMailFlag", holdMailFlag);
		oNewNode.setAttribute("SuspectModBO.Address.mailStop", mailstop);
		//Tracker 105266
		oNewNode.setAttribute("SuspectModBO.Address.URL", url);
		oNewNode.setAttribute("SuspectModBO.Address.url_", address_type+start_date);
		/* CIF PhoneEmail Changes : End */ 
	}
	else if(boName == "NonCustomerBO" )
	{
		oNewNode.setAttribute("NonCustomerBO.Address.addressCategory", address_type);
		oNewNode.setAttribute("NonCustomerBO.Address.Start_Date", start_date);
		oNewNode.setAttribute("NonCustomerBO.Address.country", country);
		oNewNode.setAttribute("NonCustomerBO.Address.state", state);  
		oNewNode.setAttribute("NonCustomerBO.Address.city", city);
		/* CIF PhoneEmail Changes : Start */
		oNewNode.setAttribute("NonCustomerBO.Address.PreferredFormat", preferredFormat);
		oNewNode.setAttribute("NonCustomerBO.Address.HoldMailReason", holdMailReason);
		oNewNode.setAttribute("NonCustomerBO.Address.BusinessCenter", businessCenter);
		oNewNode.setAttribute("NonCustomerBO.Address.HoldMailInitiatedBy", holdMailInitiatedBy);

		/* AdressLine changes: START */
		oNewNode.setAttribute("NonCustomerBO.Address.AddressLine1", addressLine1);
		oNewNode.setAttribute("NonCustomerBO.Address.AddressLine2", addressLine2);
		oNewNode.setAttribute("NonCustomerBO.Address.AddressLine3", addressLine3);
		/* AdressLine changes: END */

		oNewNode.setAttribute("NonCustomerBO.Address.FreeTextLabel", freeTextLabel);
		oNewNode.setAttribute("NonCustomerBO.Address.HoldMailFlag", holdMailFlag);
		oNewNode.setAttribute("NonCustomerBO.Address.mailStop", mailstop);
		//Tracker 105266
		oNewNode.setAttribute("NonCustomerBO.Address.URL", url);
		oNewNode.setAttribute("NonCustomerBO.Address.url_", address_type+start_date);
		/* CIF PhoneEmail Changes : End */ 
	}
	else if( boName == "NonCustomerModBO")
	{
		oNewNode.setAttribute("NonCustomerModBO.Address.addressCategory", address_type);
		oNewNode.setAttribute("NonCustomerModBO.Address.Start_Date", start_date);
		oNewNode.setAttribute("NonCustomerModBO.Address.country", country);
		oNewNode.setAttribute("NonCustomerModBO.Address.state", state);  
		oNewNode.setAttribute("NonCustomerModBO.Address.city", city);
		/* CIF PhoneEmail Changes : Start */
		oNewNode.setAttribute("NonCustomerModBO.Address.PreferredFormat", preferredFormat);
		oNewNode.setAttribute("NonCustomerModBO.Address.HoldMailReason", holdMailReason);
		oNewNode.setAttribute("NonCustomerModBO.Address.BusinessCenter", businessCenter);
		oNewNode.setAttribute("NonCustomerModBO.Address.HoldMailInitiatedBy", holdMailInitiatedBy);

		/* AdressLine changes: START */
		oNewNode.setAttribute("NonCustomerModBO.Address.AddressLine1", addressLine1);
		oNewNode.setAttribute("NonCustomerModBO.Address.AddressLine2", addressLine2);
		oNewNode.setAttribute("NonCustomerModBO.Address.AddressLine3", addressLine3);
		/* AdressLine changes: END */

		oNewNode.setAttribute("NonCustomerModBO.Address.FreeTextLabel", freeTextLabel);
		oNewNode.setAttribute("NonCustomerModBO.Address.HoldMailFlag", holdMailFlag);
		oNewNode.setAttribute("NonCustomerModBO.Address.mailStop", mailstop);
		//Tracker 105266
		oNewNode.setAttribute("NonCustomerModBO.Address.URL", url);
		oNewNode.setAttribute("NonCustomerModBO.Address.url_", address_type+start_date);
		/* CIF PhoneEmail Changes : End */ 
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS
        
        
       // changes for ticket 682574 starts
		/*if(addressTypeFlag)
		{
			add_category_ML = address_type;
			alert("add_category_ML value is"+add_category_ML);
		}*/
		var tdNode = document.createElement("TD");
		oNewNode.appendChild(tdNode);                               
		tdNode.innerHTML =  "<font class='fntColData'>" + vAddTypeLT+ "</font>";
		/* CIF PhoneEmail Changes : Start*/
		var tdNode1 = document.createElement("TD");
		oNewNode.appendChild(tdNode1);                               
		tdNode1.innerHTML =  "<font class='fntColData'>" + freeTextLabel+ "</font>";
		/* CIF PhoneEmail Changes : End*/
 // changes for ticket 682574 ends
		var tdNode2 = document.createElement("TD");
		 //Tracker-ID 113259:ERPBOCF1:Hijri CR:changes start 
		/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
		//id has been set for the date field such dat "date" phrase has 0 index and rowindex has been appended to make id unique for ever row
		var idIndex = document.all.RecordSet.rows.length;
		tdNode2.setAttribute("id","DATE1RetQuickEditAddress"+idIndex);
		
		if((start_date!= '') && (start_date != undefined))
		{
		//date converted acc to the present calendar type before displaing in the multirec 
			start_date = changeDateAccToPresentCalendar(start_date);
		}
		/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
		                             
                            
		/* Tracker-ID 113259:ERPBOCF1:Hijri:To convert start date to Hijri date format - start
		//if the selected calendar type is Hijri,start_date  is converted in the Hijr format
		if(calType == 'H')
		{
			start_date = convertGregToHij(start_date);
		}
		 Tracker-ID 113259:ERPBOCF1:Hijri:To convert start date to Hijri date format - end*/ 
//Tracker-ID 113259:ERPBOCF1:Hijri CR:changes end 
        oNewNode.appendChild(tdNode2);  
		tdNode2.innerHTML =  "<font class='fntColData'>" + start_date+ "</font>";
		var tdNode3 = document.createElement("TD");
		oNewNode.appendChild(tdNode3);                              
		/*Fix Start for ticket: 253707 */
		tdNode3.innerHTML = "<font class='fntColData'>" + city_cat + "</font>";                                                                                               
		var tdNode4 = document.createElement("TD");
		oNewNode.appendChild(tdNode4);                              
		tdNode4.innerHTML = "<font class='fntColData'>" + state_cat + "</font>";
		
		var tdNode5 = document.createElement("TD");
		oNewNode.appendChild(tdNode5);                              
		tdNode5.innerHTML = "<font class='fntColData'>" + country_cat + "</font>";                                                                                               
		/*Fix End for ticket: 253707 */				
		var tdNode6 = document.createElement("TD");
		oNewNode.appendChild(tdNode6);                              
		tdNode6.innerHTML = "<INPUT class='sbttn' TYPE = 'button' value = '...' onclick='editQuickAddressDetails()'>";
	
		oNewNode.attachEvent("onclick", call);       

		totalProdRecortds = document.all.RecordSet.rows.length;
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName == "AccountBO" )
		{
			document.all.RecordSet.rows(totalProdRecortds - 1).setAttribute("AccountBO.Address.url_", eduURL);
		}
		else if(boName == "AccountModBO")
		{
			document.all.RecordSet.rows(totalProdRecortds - 1).setAttribute("AccountModBO.Address.url_", eduURL);
		}
		else if(boName == "ContactBO" )
		{
			document.all.RecordSet.rows(totalProdRecortds - 1).setAttribute("ContactBO.Address.url_", eduURL);
		}
		else if( boName == "ContactModBO")
		{	
			document.all.RecordSet.rows(totalProdRecortds - 1).setAttribute("ContactModBO.Address.url_", eduURL);
		}
		else if(boName == "SuspectBO" )
		{
			document.all.RecordSet.rows(totalProdRecortds - 1).setAttribute("SuspectBO.Address.url_", eduURL);
		}
		else if(boName == "SuspectModBO")
		{
			document.all.RecordSet.rows(totalProdRecortds - 1).setAttribute("SuspectModBO.Address.url_", eduURL);
		}
		else if(boName == "NonCustomerBO" )
		{
			document.all.RecordSet.rows(totalProdRecortds - 1).setAttribute("NonCustomerBO.Address.url_", eduURL);
		}
		else if( boName == "NonCustomerModBO")
		{
			document.all.RecordSet.rows(totalProdRecortds - 1).setAttribute("NonCustomerModBO.Address.url_", eduURL);
		}
 		// Tracker ID: 135125: XMLEncoding Changes ENDS

		/* CIF PhoneEmail Changes : Start*/
		//updateAllHoldMailInfo(address_type);
		/* CIF PhoneEmail Changes : End*/
    }
    else
    {
		 // changes for ticket 682574 starts
		/*ticket Id: 262532Changes Begin */
		currEduTableRow.childNodes(0).innerHTML="<font class='fntColData'>" + vAddTypeLT + "</font>";
			 // changes for ticket 682574 ends
		currEduTableRow.childNodes(1).innerHTML="<font class='fntColData'>" + freeTextLabel + "</font>";
		/*ticket Id: 262532Changes End */
        /* Tracker-ID 113259:ERPBOCF1:Hijri:To convert start date to Hijri date format - start*/
		//Tracker-ID 113259:ERPBOCF1:Hijri CR:changes start 
/*if the selected calendar type is Hijri,start_date  is converted in the Hijr format
		if(calType == 'H')
		{
			start_date = convertGregToHij(start_date);
			
		} */
if((start_date!= '') && (start_date != undefined))
		{
		//date converted acc to the present calendar type before displaing in the multirec 
			start_date = changeDateAccToPresentCalendar(start_date);
		}
//Tracker-ID 113259:ERPBOCF1:Hijri CR:changes end 
		/* Tracker-ID 113259:ERPBOCF1:Hijri:To convert start date to Hijri date format - end*/
		/*ticket Id: 262532Changes Begin */
        currEduTableRow.childNodes(2).innerHTML="<font class='fntColData'>" + start_date + "</font>";
		/*Fix Start for ticket: 253707 */
		currEduTableRow.childNodes(3).innerHTML="<font class='fntColData'>" + city_cat + "</font>";
		currEduTableRow.childNodes(4).innerHTML="<font class='fntColData'>" + state_cat + "</font>";
		currEduTableRow.childNodes(5).innerHTML="<font class='fntColData'>" + country_cat + "</font>";
		/*ticket Id: 262532Changes End */
        /*Fix End for ticket: 253707 */
		updateDet = false;
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName == "AccountBO" )
		{
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.addressCategory", address_type);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.FreeTextLabel", freeTextLabel);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.Start_Date", start_date);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.country", country);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.state", state);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.city", city);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.url_", eduURL);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.HoldMailFlag",holdMailFlag);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.HoldMailReason",holdMailReason);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.BusinessCenter",businessCenter);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
		}
		else if(boName == "AccountModBO")
		{
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.addressCategory", address_type);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.FreeTextLabel", freeTextLabel);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.Start_Date", start_date);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.country", country);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.state", state);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.city", city);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.url_", eduURL);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.HoldMailFlag",holdMailFlag);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.HoldMailReason",holdMailReason);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.BusinessCenter",businessCenter);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("AccountModBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
		}
		else if(boName == "ContactBO" )
		{
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactBO.Address.addressCategory", address_type);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactBO.Address.FreeTextLabel", freeTextLabel);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactBO.Address.Start_Date", start_date);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactBO.Address.country", country);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactBO.Address.state", state);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactBO.Address.city", city);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactBO.Address.url_", eduURL);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactBO.Address.HoldMailFlag",holdMailFlag);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactBO.Address.HoldMailReason",holdMailReason);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactBO.Address.BusinessCenter",businessCenter);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
		}
		else if( boName == "ContactModBO")
		{	
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactModBO.Address.addressCategory", address_type);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactModBO.Address.FreeTextLabel", freeTextLabel);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactModBO.Address.Start_Date", start_date);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactModBO.Address.country", country);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactModBO.Address.state", state);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactModBO.Address.city", city);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactModBO.Address.url_", eduURL);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactModBO.Address.HoldMailFlag",holdMailFlag);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactModBO.Address.HoldMailReason",holdMailReason);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactModBO.Address.BusinessCenter",businessCenter);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("ContactModBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
		}
		else if(boName == "SuspectBO" )
		{
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectBO.Address.addressCategory", address_type);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectBO.Address.FreeTextLabel", freeTextLabel);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectBO.Address.Start_Date", start_date);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectBO.Address.country", country);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectBO.Address.state", state);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectBO.Address.city", city);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectBO.Address.url_", eduURL);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectBO.Address.HoldMailFlag",holdMailFlag);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectBO.Address.HoldMailReason",holdMailReason);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectBO.Address.BusinessCenter",businessCenter);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
		}
		else if(boName == "SuspectModBO")
		{
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectModBO.Address.addressCategory", address_type);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectModBO.Address.FreeTextLabel", freeTextLabel);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectModBO.Address.Start_Date", start_date);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectModBO.Address.country", country);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectModBO.Address.state", state);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectModBO.Address.city", city);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectModBO.Address.url_", eduURL);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectModBO.Address.HoldMailFlag",holdMailFlag);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectModBO.Address.HoldMailReason",holdMailReason);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectModBO.Address.BusinessCenter",businessCenter);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("SuspectModBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
		}
		else if(boName == "NonCustomerBO" )
		{
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerBO.Address.addressCategory", address_type);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerBO.Address.FreeTextLabel", freeTextLabel);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerBO.Address.Start_Date", start_date);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerBO.Address.country", country);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerBO.Address.state", state);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerBO.Address.city", city);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerBO.Address.url_", eduURL);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerBO.Address.HoldMailFlag",holdMailFlag);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerBO.Address.HoldMailReason",holdMailReason);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerBO.Address.BusinessCenter",businessCenter);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
		}
		else if( boName == "NonCustomerModBO")
		{
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerModBO.Address.addressCategory", address_type);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerModBO.Address.FreeTextLabel", freeTextLabel);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerModBO.Address.Start_Date", start_date);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerModBO.Address.country", country);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerModBO.Address.state", state);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerModBO.Address.city", city);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerModBO.Address.url_", eduURL);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerModBO.Address.HoldMailFlag",holdMailFlag);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerModBO.Address.HoldMailReason",holdMailReason);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerModBO.Address.BusinessCenter",businessCenter);
			document.all.RecordSet.rows(eduRecordIndex).setAttribute("NonCustomerModBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
		}
		// Tracker ID: 135125: XMLEncoding Changes ENDS
		//updateAllHoldMailInfo(address_type);
    }
    
    
 }else{
	if(addressLine2 == ""){
		addressLine2 = "null";
		}
		if(addressLine3 == ""){
		addressLine3 = "null";
	}
	SwiftAddressDetails =  name+"|"+addressLine1+"|"+addressLine2+"|"+addressLine3;
 }
    
    
}catch(e){alert("error in Addquic Address"+e.description);
}
    return ("true");
}

/*function updateAllHoldMailInfo(address_type)
{
	var recordSetSize =  document.all.RecordSet.rows.length;
	
	
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName == "AccountBO" )
	{
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
	}
	else if(boName == "AccountModBO")
	{
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
	else if(boName == "ContactBO" )
	{
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(address_type == document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.addressCategory"))
			{
				document.all.RecordSet.rows(k).setAttribute("ContactBO.Address.HoldMailFlag",holdMailFlag);
				document.all.RecordSet.rows(k).setAttribute("ContactBO.Address.HoldMailReason",holdMailReason);
				document.all.RecordSet.rows(k).setAttribute("ContactBO.Address.BusinessCenter",businessCenter);
				document.all.RecordSet.rows(k).setAttribute("ContactBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);

				ad_HoldMailReason[k-2] = holdMailReason;
				ad_BusinessCenter[k-2] = businessCenter;
				ad_HoldMailInitiatedBy[k-2] = holdMailInitiatedBy;
				ad_HoldMailFlag[k-2] = holdMailFlag;
			}
		}
	}
	else if( boName == "ContactModBO")
	{	
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(address_type == document.all.RecordSet.rows(k).getAttribute("ContactModBO.Address.addressCategory"))
			{
				document.all.RecordSet.rows(k).setAttribute("ContactModBO.Address.HoldMailFlag",holdMailFlag);
				document.all.RecordSet.rows(k).setAttribute("ContactModBO.Address.HoldMailReason",holdMailReason);
				document.all.RecordSet.rows(k).setAttribute("ContactModBO.Address.BusinessCenter",businessCenter);
				document.all.RecordSet.rows(k).setAttribute("ContactModBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);

				ad_HoldMailReason[k-2] = holdMailReason;
				ad_BusinessCenter[k-2] = businessCenter;
				ad_HoldMailInitiatedBy[k-2] = holdMailInitiatedBy;
				ad_HoldMailFlag[k-2] = holdMailFlag;
			}
		}
	}
	else if(boName == "SuspectBO" )
	{
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(address_type == document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.addressCategory"))
			{
				document.all.RecordSet.rows(k).setAttribute("SuspectBO.Address.HoldMailFlag",holdMailFlag);
				document.all.RecordSet.rows(k).setAttribute("SuspectBO.Address.HoldMailReason",holdMailReason);
				document.all.RecordSet.rows(k).setAttribute("SuspectBO.Address.BusinessCenter",businessCenter);
				document.all.RecordSet.rows(k).setAttribute("SuspectBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);

				ad_HoldMailReason[k-2] = holdMailReason;
				ad_BusinessCenter[k-2] = businessCenter;
				ad_HoldMailInitiatedBy[k-2] = holdMailInitiatedBy;
				ad_HoldMailFlag[k-2] = holdMailFlag;
			}
		}
	}
	else if(boName == "SuspectModBO")
	{
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(address_type == document.all.RecordSet.rows(k).getAttribute("SuspectModBO.Address.addressCategory"))
			{
				document.all.RecordSet.rows(k).setAttribute("SuspectModBO.Address.HoldMailFlag",holdMailFlag);
				document.all.RecordSet.rows(k).setAttribute("SuspectModBO.Address.HoldMailReason",holdMailReason);
				document.all.RecordSet.rows(k).setAttribute("SuspectModBO.Address.BusinessCenter",businessCenter);
				document.all.RecordSet.rows(k).setAttribute("SuspectModBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);

				ad_HoldMailReason[k-2] = holdMailReason;
				ad_BusinessCenter[k-2] = businessCenter;
				ad_HoldMailInitiatedBy[k-2] = holdMailInitiatedBy;
				ad_HoldMailFlag[k-2] = holdMailFlag;
			}
		}
	}
	else if(boName == "NonCustomerBO" )
	{
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(address_type == document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.addressCategory"))
			{
				document.all.RecordSet.rows(k).setAttribute("NonCustomerBO.Address.HoldMailFlag",holdMailFlag);
				document.all.RecordSet.rows(k).setAttribute("NonCustomerBO.Address.HoldMailReason",holdMailReason);
				document.all.RecordSet.rows(k).setAttribute("NonCustomerBO.Address.BusinessCenter",businessCenter);
				document.all.RecordSet.rows(k).setAttribute("NonCustomerBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);

				ad_HoldMailReason[k-2] = holdMailReason;
				ad_BusinessCenter[k-2] = businessCenter;
				ad_HoldMailInitiatedBy[k-2] = holdMailInitiatedBy;
				ad_HoldMailFlag[k-2] = holdMailFlag;
			}
		}
	}
	else if( boName == "NonCustomerModBO")
	{
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(address_type == document.all.RecordSet.rows(k).getAttribute("NonCustomerModBO.Address.addressCategory"))
			{
				document.all.RecordSet.rows(k).setAttribute("NonCustomerModBO.Address.HoldMailFlag",holdMailFlag);
				document.all.RecordSet.rows(k).setAttribute("NonCustomerModBO.Address.HoldMailReason",holdMailReason);
				document.all.RecordSet.rows(k).setAttribute("NonCustomerModBO.Address.BusinessCenter",businessCenter);
				document.all.RecordSet.rows(k).setAttribute("NonCustomerModBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);

				ad_HoldMailReason[k-2] = holdMailReason;
				ad_BusinessCenter[k-2] = businessCenter;
				ad_HoldMailInitiatedBy[k-2] = holdMailInitiatedBy;
				ad_HoldMailFlag[k-2] = holdMailFlag;
			}
		}
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS
}*/

function populateHoldMailForAddressType(selectedAddressType)
{
	var recordSetSize =  document.all.RecordSet.rows.length;
	var holdMailValues = new Array();
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName == "AccountBO" )
	{
		for(var j=0 ; j < recordSetSize; j++)
		{
			if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.addressCategory"))
			{
				holdMailValues[0] = document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.HoldMailFlag");
				holdMailValues[1] = document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.HoldMailInitiatedBy");
				holdMailValues[2] = document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.BusinessCenter");
				holdMailValues[3] = document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.HoldMailReason");

				return holdMailValues;
			}
		}
	}
	else if(boName == "AccountModBO")
	{
		for(var j=0 ; j < recordSetSize; j++)
		{
			if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.addressCategory"))
			{
				holdMailValues[0] = document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.HoldMailFlag");
				holdMailValues[1] = document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.HoldMailInitiatedBy");
				holdMailValues[2] = document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.BusinessCenter");
				holdMailValues[3] = document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.HoldMailReason");

				return holdMailValues;
			}
		}
	}
	else if(boName == "ContactBO" )
	{
		for(var j=0 ; j < recordSetSize; j++)
		{
			if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.addressCategory"))
			{
				holdMailValues[0] = document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.HoldMailFlag");
				holdMailValues[1] = document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.HoldMailInitiatedBy");
				holdMailValues[2] = document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.BusinessCenter");
				holdMailValues[3] = document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.HoldMailReason");

				return holdMailValues;
			}
		}
	}
	else if( boName == "ContactModBO")
	{	
		for(var j=0 ; j < recordSetSize; j++)
		{
			if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.addressCategory"))
			{
				holdMailValues[0] = document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.HoldMailFlag");
				holdMailValues[1] = document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.HoldMailInitiatedBy");
				holdMailValues[2] = document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.BusinessCenter");
				holdMailValues[3] = document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.HoldMailReason");

				return holdMailValues;
			}
		}
	}
	else if(boName == "SuspectBO" )
	{
		for(var j=0 ; j < recordSetSize; j++)
		{
			if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.addressCategory"))
			{
				holdMailValues[0] = document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.HoldMailFlag");
				holdMailValues[1] = document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.HoldMailInitiatedBy");
				holdMailValues[2] = document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.BusinessCenter");
				holdMailValues[3] = document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.HoldMailReason");

				return holdMailValues;
			}
		}
	}
	else if(boName == "SuspectModBO")
	{
		for(var j=0 ; j < recordSetSize; j++)
		{
			if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.addressCategory"))
			{
				holdMailValues[0] = document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.HoldMailFlag");
				holdMailValues[1] = document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.HoldMailInitiatedBy");
				holdMailValues[2] = document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.BusinessCenter");
				holdMailValues[3] = document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.HoldMailReason");

				return holdMailValues;
			}
		}
	}
	else if(boName == "NonCustomerBO" )
	{
		for(var j=0 ; j < recordSetSize; j++)
		{
			if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.addressCategory"))
			{
				holdMailValues[0] = document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.HoldMailFlag");
				holdMailValues[1] = document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.HoldMailInitiatedBy");
				holdMailValues[2] = document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.BusinessCenter");
				holdMailValues[3] = document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.HoldMailReason");

				return holdMailValues;
			}
		}
	}
	else if( boName == "NonCustomerModBO")
	{
		for(var j=0 ; j < recordSetSize; j++)
		{
			if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.addressCategory"))
			{
				holdMailValues[0] = document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.HoldMailFlag");
				holdMailValues[1] = document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.HoldMailInitiatedBy");
				holdMailValues[2] = document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.BusinessCenter");
				holdMailValues[3] = document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.HoldMailReason");

				return holdMailValues;
			}
		}
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS

}

function checkFormatForAddressTypeSelected(selectedAddressType)
{
		var recordSetSize =  document.all.RecordSet.rows.length;
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName == "AccountBO" )
		{
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.PreferredFormat") != null)
				{
					if(selectedAddressType !=null && selectedAddressType != "")
					{
						if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.addressCategory"))
						{
							return document.all.RecordSet.rows(j).getAttribute("AccountBO.Address.PreferredFormat");
						}
					}
				}
			}
		}
		else if(boName == "AccountModBO")
		{
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.PreferredFormat") != null)
				{
					if(selectedAddressType !=null && selectedAddressType != "")
					{
						if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.addressCategory"))
						{
							return document.all.RecordSet.rows(j).getAttribute("AccountModBO.Address.PreferredFormat");
						}
					}
				}
			}
		}
		else if(boName == "ContactBO" )
		{
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.PreferredFormat") != null)
				{
					if(selectedAddressType !=null && selectedAddressType != "")
					{
						if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.addressCategory"))
						{
							return document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.PreferredFormat");
						}
					}
				}
			}
		}
		else if( boName == "ContactModBO")
		{	
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.PreferredFormat") != null)
				{
					if(selectedAddressType !=null && selectedAddressType != "")
					{
						if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.addressCategory"))
						{
							return document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.PreferredFormat");
						}
					}
				}
			}
		}
		else if(boName == "SuspectBO" )
		{
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.PreferredFormat") != null)
				{
					if(selectedAddressType !=null && selectedAddressType != "")
					{
						if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.addressCategory"))
						{
							return document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.PreferredFormat");
						}
					}
				}
			}
		}
		else if(boName == "SuspectModBO")
		{
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.PreferredFormat") != null)
				{
					if(selectedAddressType !=null && selectedAddressType != "")
					{
						if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.addressCategory"))
						{
							return document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.PreferredFormat");
						}
					}
				}
			}
		}
		else if(boName == "NonCustomerBO" )
		{
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.PreferredFormat") != null)
				{
					if(selectedAddressType !=null && selectedAddressType != "")
					{
						if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.addressCategory"))
						{
							return document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.PreferredFormat");
						}
					}
				}
			}
		}
		else if( boName == "NonCustomerModBO")
		{
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.PreferredFormat") != null)
				{
					if(selectedAddressType !=null && selectedAddressType != "")
					{
						if(selectedAddressType == document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.addressCategory"))
						{
							return document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.PreferredFormat");
						}
					}
				}
			}
		}
		// Tracker ID: 135125: XMLEncoding Changes ENDS
		return null;
}

function checkFormatSelected(selectedFormat,selectedAddressType)
{
		var recordSetSize =  document.all.RecordSet.rows.length;
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName == "AccountBO" )
		{
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
		}
		else if(boName == "AccountModBO")
		{
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
		else if(boName == "ContactBO" )
		{
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.PreferredFormat") != null)
				{
					if(selectedFormat == document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.PreferredFormat")  && selectedAddressType == document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.addressCategory"))
					{
						return document.all.RecordSet.rows(j).getAttribute("ContactBO.Address.addressCategory");
					}
				}
			}
		}
		else if( boName == "ContactModBO")
		{	
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.PreferredFormat") != null)
				{
					if(selectedFormat == document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.PreferredFormat")  && selectedAddressType == document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.addressCategory"))
					{
						return document.all.RecordSet.rows(j).getAttribute("ContactModBO.Address.addressCategory");
					}
				}
			}
		}
		else if(boName == "SuspectBO" )
		{
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.PreferredFormat") != null)
				{
					if(selectedFormat == document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.PreferredFormat")  && selectedAddressType == document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.addressCategory"))
					{
						return document.all.RecordSet.rows(j).getAttribute("SuspectBO.Address.addressCategory");
					}
				}
			}
		}
		else if(boName == "SuspectModBO")
		{
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.PreferredFormat") != null)
				{
					if(selectedFormat == document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.PreferredFormat")  && selectedAddressType == document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.addressCategory"))
					{
						return document.all.RecordSet.rows(j).getAttribute("SuspectModBO.Address.addressCategory");
					}
				}
			}
		}
		else if(boName == "NonCustomerBO" )
		{
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.PreferredFormat") != null)
				{
					if(selectedFormat == document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.PreferredFormat")  && selectedAddressType == document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.addressCategory"))
					{
						return document.all.RecordSet.rows(j).getAttribute("NonCustomerBO.Address.addressCategory");
					}
				}
			}
		}
		else if( boName == "NonCustomerModBO")
		{
			for(var j=0 ; j < recordSetSize; j++)
			{
				if(document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.addressCategory") != null && document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.PreferredFormat") != null)
				{
					if(selectedFormat == document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.PreferredFormat")  && selectedAddressType == document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.addressCategory"))
					{
						return document.all.RecordSet.rows(j).getAttribute("NonCustomerModBO.Address.addressCategory");
					}
				}
			}
		}
		// Tracker ID: 135125: XMLEncoding Changes ENDS
		return null;
}

function TodayDate(){
   var d, s = '';
   d = new Date();
   
   s += d.getDate() + "/";
   s += (d.getMonth() + 1) + "/";
   temp = new String(d.getYear());
   s += temp;
   return s;
}

function onBCCodeSelect()
{
	document.getElementsByName(bcLookupType)[0].value = getCookie("bCCode");
}

function clearBCValue(type)
{
	document.getElementsByName(type)[0].value = "";
}

function clearStructuredValues()
{
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName == "AccountBO" )
	{
		document.getElementsByName("Cat_AccountBO.Address.city")[0].value = "";
		document.getElementsByName("Cat_AccountBO.Address.country")[0].value = "";
		document.getElementsByName("Cat_AccountBO.Address.state")[0].value = "";
		document.getElementsByName("AccountBO.Address.zip")[0].value = "";
		document.getElementsByName("AccountBO.Address.house_no")[0].value = "";
		document.getElementsByName("AccountBO.Address.premise_name")[0].value = "";
		document.getElementsByName("AccountBO.Address.building_level")[0].value = "";
		document.getElementsByName("AccountBO.Address.street_no")[0].value = "";
		document.getElementsByName("AccountBO.Address.suburb")[0].value = "";
		//Tracker 105266
		document.getElementsByName("AccountBO.Address.IsAddressProofRcvd")[0].value = "";
		document.getElementsByName("AccountBO.Address.street_name")[0].value = "";
		document.getElementsByName("AccountBO.Address.locality_name")[0].value = "";
		document.getElementsByName("AccountBO.Address.town")[0].value = "";
		document.getElementsByName("AccountBO.Address.domicile")[0].value = "";
		document.getElementsByName("AccountBO.Address.mailStop")[0].value = "";
		document.getElementsByName("AccountBO.Address.URL")[0].value = "";
		document.getElementsByName("AccountBO.Address.LastUpdate_Date")[0].value = "";
	}
	
	else if(boName == "ContactBO" )
	{
		document.getElementsByName("Cat_"+"ContactBO.Address.city")[0].value = "";
		document.getElementsByName("Cat_"+"ContactBO.Address.country")[0].value = "";
		document.getElementsByName("Cat_"+"ContactBO.Address.state")[0].value = "";
		document.getElementsByName("ContactBO.Address.zip")[0].value = "";
		document.getElementsByName("ContactBO.Address.house_no")[0].value = "";
		document.getElementsByName("ContactBO.Address.premise_name")[0].value = "";
		document.getElementsByName("ContactBO.Address.building_level")[0].value = "";
		document.getElementsByName("ContactBO.Address.street_no")[0].value = "";
		document.getElementsByName("ContactBO.Address.suburb")[0].value = "";
		//Tracker 105266
		document.getElementsByName("ContactBO.Address.IsAddressProofRcvd")[0].value = "";
		document.getElementsByName("ContactBO.Address.street_name")[0].value = "";
		document.getElementsByName("ContactBO.Address.locality_name")[0].value = "";
		document.getElementsByName("ContactBO.Address.town")[0].value = "";
		document.getElementsByName("ContactBO.Address.domicile")[0].value = "";
		document.getElementsByName("ContactBO.Address.mailStop")[0].value = "";
		document.getElementsByName("ContactBO.Address.URL")[0].value = "";
		document.getElementsByName("ContactBO.Address.LastUpdate_Date")[0].value = "";
	}
	
	else if(boName == "SuspectBO" )
	{
		document.getElementsByName("Cat_"+"SuspectBO.Address.city")[0].value = "";
		document.getElementsByName("Cat_"+"SuspectBO.Address.country")[0].value = "";
		document.getElementsByName("Cat_"+"SuspectBO.Address.state")[0].value = "";
		document.getElementsByName("SuspectBO.Address.zip")[0].value = "";
		document.getElementsByName("SuspectBO.Address.house_no")[0].value = "";
		document.getElementsByName("SuspectBO.Address.premise_name")[0].value = "";
		document.getElementsByName("SuspectBO.Address.building_level")[0].value = "";
		document.getElementsByName("SuspectBO.Address.street_no")[0].value = "";
		document.getElementsByName("SuspectBO.Address.suburb")[0].value = "";
		//Tracker 105266
		document.getElementsByName("SuspectBO.Address.IsAddressProofRcvd")[0].value = "";
		document.getElementsByName("SuspectBO.Address.street_name")[0].value = "";
		document.getElementsByName("SuspectBO.Address.locality_name")[0].value = "";
		document.getElementsByName("SuspectBO.Address.town")[0].value = "";
		document.getElementsByName("SuspectBO.Address.domicile")[0].value = "";
		document.getElementsByName("SuspectBO.Address.mailStop")[0].value = "";
		document.getElementsByName("SuspectBO.Address.URL")[0].value = "";
		document.getElementsByName("SuspectBO.Address.LastUpdate_Date")[0].value = "";
	}
	
	else if(boName == "NonCustomerBO" )
	{
		document.getElementsByName("Cat_"+"NonCustomerBO.Address.city")[0].value = "";
		document.getElementsByName("Cat_"+"NonCustomerBO.Address.country")[0].value = "";
		document.getElementsByName("Cat_"+"NonCustomerBO.Address.state")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.zip")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.house_no")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.premise_name")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.building_level")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.street_no")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.suburb")[0].value = "";
		//Tracker 105266
		document.getElementsByName("NonCustomerBO.Address.IsAddressProofRcvd")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.street_name")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.locality_name")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.town")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.domicile")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.mailStop")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.URL")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.LastUpdate_Date")[0].value = "";
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS

}

function clearFreeTextValues()
{
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName == "AccountBO" )
	{
		document.getElementsByName("AccountBO.Address.FreeTextLabel")[0].value = "";

	/* AdressLine changes: START */
		document.getElementsByName("AccountBO.Address.AddressLine1")[0].value = "";
		document.getElementsByName("AccountBO.Address.AddressLine2")[0].value = "";
		document.getElementsByName("AccountBO.Address.AddressLine3")[0].value = "";
	/* AdressLine changes: END */
		document.getElementsByName("AccountBO.Address.Start_Date")[0].value = "";
	}
	
	else if(boName == "ContactBO" )
	{
		document.getElementsByName("ContactBO.Address.FreeTextLabel")[0].value = "";

	/* AdressLine changes: START */
		document.getElementsByName("ContactBO.Address.AddressLine1")[0].value = "";
		document.getElementsByName("ContactBO.Address.AddressLine2")[0].value = "";
		document.getElementsByName("ContactBO.Address.AddressLine3")[0].value = "";
	/* AdressLine changes: END */
		document.getElementsByName("ContactBO.Address.Start_Date")[0].value = "";
	}
	
	else if(boName == "SuspectBO" )
	{
		document.getElementsByName("SuspectBO.Address.FreeTextLabel")[0].value = "";

	/* AdressLine changes: START */
		document.getElementsByName("SuspectBO.Address.AddressLine1")[0].value = "";
		document.getElementsByName("SuspectBO.Address.AddressLine2")[0].value = "";
		document.getElementsByName("SuspectBO.Address.AddressLine3")[0].value = "";
	/* AdressLine changes: END */
		document.getElementsByName("SuspectBO.Address.Start_Date")[0].value = "";
	}
	
	else if(boName == "NonCustomerBO" )
	{
		document.getElementsByName("NonCustomerBO.Address.FreeTextLabel")[0].value = "";

	/* AdressLine changes: START */
		document.getElementsByName("NonCustomerBO.Address.AddressLine1")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.AddressLine2")[0].value = "";
		document.getElementsByName("NonCustomerBO.Address.AddressLine3")[0].value = "";
	/* AdressLine changes: END */
		document.getElementsByName("NonCustomerBO.Address.Start_Date")[0].value = "";
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS

}
function sortList(recordSetName){
	var addrDetails = new Array();
	var addressId = '';
	var deleteFlag = false;
	var previousRowDeleted = false;
	var previousAddressType = "";
	var noOfAddressCount = eval('document.all.'+recordSetName).rows.length; 
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName == "AccountBO" )
	{
		for(k=0 ; k < noOfAddressCount ; k++)
		{
			addressType = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("AccountBO.Address.addressCategory"));
			arr_AddressType = new Array();
			arr_AddressType[0] = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("AccountBO.Address.addressCategory"));
			arr_AddressType[1] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.house_no"));
			arr_AddressType[2] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.premise_name"));
			arr_AddressType[3] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.End_Date"));
			arr_AddressType[4] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.Start_Date"));
			arr_AddressType[5] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.city"));
			arr_AddressType[6] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.country"));
			arr_AddressType[7] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.state"));
			arr_AddressType[8] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.zip"));
			arr_AddressType[9] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.building_level"));
			if(mainAccId != ""){
				addressId = document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.MainTableID");
			} 
			else {
				addressId = document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.addressID");
			}
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

	/* QED Changes: START */
			arr_AddressType[25] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.address_Line1"));
			arr_AddressType[26] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.address_Line2"));
			arr_AddressType[27] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.address_Line3"));

			arr_AddressType[28] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.FreeTextLabel"));
			arr_AddressType[29] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.mailStop"));
			arr_AddressType[30] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.URL"));

			arr_AddressType[31] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountBO.Address.city"));
			arr_AddressType[32] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountBO.Address.state"));
			arr_AddressType[33] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountBO.Address.country"));
			//Tracker 105266
			arr_AddressType[34] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.LastUpdate_Date"));
//Changes for call id: 401260 and recon for TOL 397571
			arr_AddressType[35] = 'N';
			//10.2 ENH recon start
			arr_AddressType[36] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.IsAddressProofRcvd"));
            arr_AddressType[37] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.Swift_Name"));
			//10.2 ENH recon end
			/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			arr_AddressType[42] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.IsAddressVerified"));
			/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
			 // changes for ticket 682574 starts
			arr_AddressType[43] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountBO.Address.AddressCategory"));
 // changes for ticket 682574 ends
	/* QED Changes: END */
			if(addressType != null && addressType != previousAddressType)
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
		}//end of for loop	
	}
	else if(boName == "ContactBO" )
	{
		for(k=0 ; k < noOfAddressCount ; k++)
		{
			addressType = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("ContactBO.Address.addressCategory"));
			arr_AddressType = new Array();
			arr_AddressType[0] = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("ContactBO.Address.addressCategory"));
			arr_AddressType[1] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.house_no"));
			arr_AddressType[2] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.premise_name"));
			arr_AddressType[3] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.End_Date"));
			arr_AddressType[4] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.Start_Date"));
			arr_AddressType[5] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.city"));
			arr_AddressType[6] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.country"));
			arr_AddressType[7] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.state"));
			arr_AddressType[8] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.zip"));
			arr_AddressType[9] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.building_level"));
			if(mainAccId != ""){
				addressId = document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.MainTableID");
			} 
			else {
				addressId = document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.addressID");
			}
			arr_AddressType[10]= trim(''+addressId);
			arr_AddressType[11] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.street_no"));
			arr_AddressType[12] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.locality_name"));
			arr_AddressType[13] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.town"));
			arr_AddressType[14] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.domicile"));
			arr_AddressType[15] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.street_name"));
			arr_AddressType[16] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.suburb"));
			arr_AddressType[17] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.City_code"));
			arr_AddressType[18] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.State_code"));
			arr_AddressType[19] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.Country_code"));
			arr_AddressType[20] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.PreferredFormat"));
			arr_AddressType[21] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.HoldMailReason"));
			arr_AddressType[22] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.BusinessCenter"));
			arr_AddressType[23] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.HoldMailInitiatedBy"));
			arr_AddressType[24] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.HoldMailFlag"));

	/* QED Changes: START */
			arr_AddressType[25] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.address_Line1"));
			arr_AddressType[26] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.address_Line2"));
			arr_AddressType[27] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.address_Line3"));

			arr_AddressType[28] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.FreeTextLabel"));
			arr_AddressType[29] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.mailStop"));
			arr_AddressType[30] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.URL"));

			arr_AddressType[31] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_ContactBO.Address.city"));
			arr_AddressType[32] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_ContactBO.Address.state"));
			arr_AddressType[33] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_ContactBO.Address.country"));
			//Tracker 105266
			arr_AddressType[34] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.LastUpdate_Date"));
			//Change for tracker 160155
//Changes for call id: 401260 and recon for TOL 397571
			arr_AddressType[35] = 'N';
			arr_AddressType[36] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.IsAddressProofRcvd"));
			
			//10.2 ENH recon start
			//arr_AddressType[36] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.IsAddressProofRcvd"));
			arr_AddressType[37] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.Swift_Name"));
			//10.2 ENH recon end
			/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			arr_AddressType[42] = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.IsAddressVerified"));
			/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/

	/* QED Changes: END */
			if(addressType != null && addressType != previousAddressType)
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
		}//end of for loop	
	}
	else if(boName == "SuspectBO" )
	{
		for(k=0 ; k < noOfAddressCount ; k++)
		{
			addressType = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("SuspectBO.Address.addressCategory"));
			arr_AddressType = new Array();
			arr_AddressType[0] = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("SuspectBO.Address.addressCategory"));
			arr_AddressType[1] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.house_no"));
			arr_AddressType[2] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.premise_name"));
			arr_AddressType[3] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.End_Date"));
			arr_AddressType[4] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.Start_Date"));
			arr_AddressType[5] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.city"));
			arr_AddressType[6] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.country"));
			arr_AddressType[7] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.state"));
			arr_AddressType[8] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.zip"));
			arr_AddressType[9] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.building_level"));
			if(mainAccId != ""){
				addressId = document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.MainTableID");
			} 
			else {
				addressId = document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.addressID");
			}
			arr_AddressType[10]= trim(''+addressId);
			arr_AddressType[11] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.street_no"));
			arr_AddressType[12] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.locality_name"));
			arr_AddressType[13] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.town"));
			arr_AddressType[14] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.domicile"));
			arr_AddressType[15] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.street_name"));
			arr_AddressType[16] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.suburb"));
			arr_AddressType[17] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.City_code"));
			arr_AddressType[18] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.State_code"));
			arr_AddressType[19] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.Country_code"));
			arr_AddressType[20] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.PreferredFormat"));
			arr_AddressType[21] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.HoldMailReason"));
			arr_AddressType[22] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.BusinessCenter"));
			arr_AddressType[23] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.HoldMailInitiatedBy"));
			arr_AddressType[24] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.HoldMailFlag"));

	/* QED Changes: START */
			arr_AddressType[25] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.address_Line1"));
			arr_AddressType[26] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.address_Line2"));
			arr_AddressType[27] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.address_Line3"));

			arr_AddressType[28] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.FreeTextLabel"));
			arr_AddressType[29] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.mailStop"));
			arr_AddressType[30] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.URL"));

			arr_AddressType[31] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_SuspectBO.Address.city"));
			arr_AddressType[32] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_SuspectBO.Address.state"));
			arr_AddressType[33] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_SuspectBO.Address.country"));
			//Tracker 105266
			arr_AddressType[34] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.LastUpdate_Date"));
//Changes for call id: 401260 and recon for TOL 397571
			arr_AddressType[35] ='N';
			arr_AddressType[36] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.IsAddressProofRcvd"));
			
			//10.2 ENH recon start
			//arr_AddressType[36] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.IsAddressProofRcvd"));
			arr_AddressType[37] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.Swift_Name"));
			//10.2 ENH recon end
			/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			arr_AddressType[42] = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.IsAddressVerified"));
			/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
			 // changes for ticket 682574 starts
			arr_AddressType[43] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_SuspectBO.Address.AddressCategory"));
 // changes for ticket 682574 ends
	/* QED Changes: END */
			if(addressType != null && addressType != previousAddressType)
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
		}//end of for loop	
	}
	else if(boName == "NonCustomerBO" )
	{
		for(k=0 ; k < noOfAddressCount ; k++)
		{
			addressType = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("NonCustomerBO.Address.addressCategory"));
			arr_AddressType = new Array();
			arr_AddressType[0] = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("NonCustomerBO.Address.addressCategory"));
			arr_AddressType[1] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.house_no"));
			arr_AddressType[2] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.premise_name"));
			arr_AddressType[3] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.End_Date"));
			arr_AddressType[4] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.Start_Date"));
			arr_AddressType[5] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.city"));
			arr_AddressType[6] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.country"));
			arr_AddressType[7] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.state"));
			arr_AddressType[8] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.zip"));
			arr_AddressType[9] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.building_level"));
			if(mainAccId != ""){
				addressId = document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.MainTableID");
			} 
			else {
				addressId = document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.addressID");
			}
			arr_AddressType[10]= trim(''+addressId);
			arr_AddressType[11] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.street_no"));
			arr_AddressType[12] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.locality_name"));
			arr_AddressType[13] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.town"));
			arr_AddressType[14] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.domicile"));
			arr_AddressType[15] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.street_name"));
			arr_AddressType[16] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.suburb"));
			arr_AddressType[17] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.City_code"));
			arr_AddressType[18] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.State_code"));
			arr_AddressType[19] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.Country_code"));
			arr_AddressType[20] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.PreferredFormat"));
			arr_AddressType[21] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.HoldMailReason"));
			arr_AddressType[22] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.BusinessCenter"));
			arr_AddressType[23] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.HoldMailInitiatedBy"));
			arr_AddressType[24] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.HoldMailFlag"));

	/* QED Changes: START */
			arr_AddressType[25] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.address_Line1"));
			arr_AddressType[26] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.address_Line2"));
			arr_AddressType[27] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.address_Line3"));

			arr_AddressType[28] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.FreeTextLabel"));
			arr_AddressType[29] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.mailStop"));
			arr_AddressType[30] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.URL"));

			arr_AddressType[31] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_NonCustomerBO.Address.city"));
			arr_AddressType[32] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_NonCustomerBO.Address.state"));
			arr_AddressType[33] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_NonCustomerBO.Address.country"));
			//Tracker 105266
			arr_AddressType[34] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.LastUpdate_Date"));
//Changes for call id: 401260 and recon for TOL 397571
			arr_AddressType[35] = 'N';
			
			//10.2 ENH recon start
			arr_AddressType[36] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.IsAddressProofRcvd"));
			arr_AddressType[37] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.Swift_Name"));
			//10.2 ENH recon end
			/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			arr_AddressType[42] = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.IsAddressVerified"));
			/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/

	/* QED Changes: END */
			if(addressType != null && addressType != previousAddressType)
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
		}//end of for loop	
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS

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
		}//end of for loop
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
			addQuickAddrDetails(globalAddrDetails[i],true);
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
function deleteList()
{
	var noOfAddressCount = document.all.RecordSet.rows.length;
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName == "AccountBO" )
	{
		for(k = noOfAddressCount-1 ; k > 1 ; k--)
		{
			addrCat = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.AddressCategory"));
			if(addrCat != null && addrCat != 'undefined')
			{
				document.all.RecordSet.deleteRow(k);
			}

		}
	}
	else if(boName == "AccountModBO")
	{
		for(k = noOfAddressCount-1 ; k > 1 ; k--)
		{
			addrCat = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.AddressCategory"));
			if(addrCat != null && addrCat != 'undefined')
			{
				document.all.RecordSet.deleteRow(k);
			}

		}
	}
	else if(boName == "ContactBO" )
	{
		for(k = noOfAddressCount-1 ; k > 1 ; k--)
		{
			addrCat = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactBO.Address.AddressCategory"));
			if(addrCat != null && addrCat != 'undefined')
			{
				document.all.RecordSet.deleteRow(k);
			}

		}
	}
	else if( boName == "ContactModBO")
	{	
		for(k = noOfAddressCount-1 ; k > 1 ; k--)
		{
			addrCat = trim(''+document.all.RecordSet.rows(k).getAttribute("ContactModBO.Address.AddressCategory"));
			if(addrCat != null && addrCat != 'undefined')
			{
				document.all.RecordSet.deleteRow(k);
			}

		}
	}
	else if(boName == "SuspectBO" )
	{
		for(k = noOfAddressCount-1 ; k > 1 ; k--)
		{
			addrCat = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectBO.Address.AddressCategory"));
			if(addrCat != null && addrCat != 'undefined')
			{
				document.all.RecordSet.deleteRow(k);
			}

		}
	}
	else if(boName == "SuspectModBO")
	{
		for(k = noOfAddressCount-1 ; k > 1 ; k--)
		{
			addrCat = trim(''+document.all.RecordSet.rows(k).getAttribute("SuspectModBO.Address.AddressCategory"));
			if(addrCat != null && addrCat != 'undefined')
			{
				document.all.RecordSet.deleteRow(k);
			}

		}
	}
	else if(boName == "NonCustomerBO" )
	{
		for(k = noOfAddressCount-1 ; k > 1 ; k--)
		{
			addrCat = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerBO.Address.AddressCategory"));
			if(addrCat != null && addrCat != 'undefined')
			{
				document.all.RecordSet.deleteRow(k);
			}

		}
	}
	else if( boName == "NonCustomerModBO")
	{
		for(k = noOfAddressCount-1 ; k > 1 ; k--)
		{
			addrCat = trim(''+document.all.RecordSet.rows(k).getAttribute("NonCustomerModBO.Address.AddressCategory"));
			if(addrCat != null && addrCat != 'undefined')
			{
				document.all.RecordSet.deleteRow(k);
			}

		}
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS
}

//changes for callid 441810 starts

function saveAddress(blFlag)
{
	
	

	var altCalendarHij = ALTCALENDAR_TYPE;
	if(document.frm2.isMCEdited.value=="Y"){
		document.frm2.isMCEditedGeneral.value="Y";
	}
	if(document.frm2.isMCEdited.value=="Y"){
		document.frm2.isMCEditedGeneral.value="Y";
	}
	if(blFlag == false)
	{
		document.frm2.saveFlag.value=1;
	}
	else
	{
		document.frm2.saveFlag.value=0;
	}
	var noOfAddress = addr_URL.length;
	var chkStat = parent.parent.parent.parent.ValidateFormContents(document.frm2,false);
	     
	if (chkStat != "true")
		  return 'interactive';
        
    var mailingad;// = false;
	var otherAdd;
    noOfEdu = addr_URL.length;
	var NRERel;// = false;
    var isNRE;// = true;
	if(isEntityNRE == "Y" ){
		isNRE = true;
	 }
	 else{
		isNRE = false;
	 }
     chkadres = document.all.RecordSet.rows.length;      
     if(chkadres == 2 && isNRE == true){
		//showUserMessage("MSG_CONTACT_IDEXISTS",null);
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CONTACT_DEFID",""),TBODY_RecordSet.rows ,'NO_HLINK');
		//changes for 258713 starts
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_NREREL",""),TBODY_RecordSet.rows ,'NO_HLINK');
		//changes for 258713 ends
		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		return "interactive"
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
	 var defAddress = defAddressType;
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
		
      //CIF Changes for NRE - Begin
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
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_DEFID",""),TBODY_RecordSet.rows ,'NO_HLINK');
			 parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			 return "interactive"
		}
		//changes for 258713 starts
		if(NRERel == false && isNRE == true){
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_NREREL",""),TBODY_RecordSet.rows ,'NO_HLINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
		}
		//changes for 258713 ends
             //CIF Changes for NRE:end
		/* Changes for ticket 346170 : BEGIN  */
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
			return "interactive";
			/* Changes for ticket 346170 : END  */
		}
		}	
		/***adress validations****/
		// fetching end date for addresstype 'mailing'
		try{
		var startdate  = new Array();
		var index      = new Array();
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Mailing") && !(edu_Status[k] == "Remove")) {
		startdate[z] = ad_start_date[k];
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
		//tracker 113259:Hijri:to validate for hijri dates:change start
		// ad_end_date[findex] = address_enddate(startdate[k+1]);
			ad_end_date[findex] = address_enddateHij(altCalendarHij,startdate[k+1]);
  		 //tracker 113259:Hijri:to validate for hijri dates:change end
		
		}
		else{
		ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
		// fetching end date for addresstype 'mailing' -end
		//Changes for current mailing address - start
		noOfmailingaddress = startdate.length;		
		var currentCount = 0;	
		var todaydate = new String();
		//Rachit Change for quick edit
		todaydate.value = getTodayDate();  
		for(var k = 0; k < noOfmailingaddress ; k++) 
		{			
			var millistartdate1 = changetoMillis(startdate[k]);
			var millistartdate2 = changetoMillis(todaydate.value);
			if (millistartdate1 <= millistartdate2)
			{
			currentCount=currentCount+1;			
			}		
		}
		
		if (currentCount == 0)
		{		
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG_MAIL_CURR_ADD",""),TBODY_RecordSet.rows ,'NO_HLINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);				
			return "interactive"
		}		
		//Changes for current mailing address - end
		
		// fetching end date for addresstype 'home'
		try{
		var startdate1  = new Array();
		var index1      = new Array();
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Home") && !(edu_Status[k] == "Remove")) {
		startdate1[z] = ad_start_date[k];
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
		//tracker 113259:Hijri:to validate for hijri dates:change start
			// ad_end_date[findex] = address_enddate(startdate1[k+1]);
			ad_end_date[findex] = address_enddateHij(altCalendarHij,startdate1[k+1]);
  		 //tracker 113259:Hijri:to validate for hijri dates:change end
		
		}
		else{
		ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
		// fetching end date for addresstype 'home' -end
		// fetching end date for addresstype 'work'
		try{
		var startdate2  = new Array();
		var index2      = new Array();
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Work") && !(edu_Status[k] == "Remove")) {
		startdate2[z] = ad_start_date[k];
		index2[z] = k;
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
		//tracker 113259:Hijri:to validate for hijri dates:change start
		// ad_end_date[findex] = address_enddate(startdate2[k+1]);
		ad_end_date[findex] = address_enddateHij(altCalendarHij,startdate2[k+1]);
  		 //tracker 113259:Hijri:to validate for hijri dates:change end
		
		}
		else{
		ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
		// fetching end date for addresstype 'work' -end
		// fetching end date for addresstype 'future/onsite'
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
		//tracker 113259:Hijri:to validate for hijri dates:change start
		// ad_end_date[findex] = address_enddate(startdate3[k+1]);
		ad_end_date[findex] = address_enddateHij(altCalendarHij,startdate3[k+1]);
  		 //tracker 113259:Hijri:to validate for hijri dates:change end
		
		}
		else{
		ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
		// fetching end date for addresstype 'future/onsite'
		
		// TRACKER 112270  changes-Begin 
		
		// fetching end date for addresstype 'Others' -begin	 		
		   setEnddateForOtherRetailAddrType(noOfEdu,ad_address_type,address_type,edu_Status);
 		// fetching end date for addresstype 'Others' -end
 		
 		// TRACKER 112270  changes-End  		
		// date validations-end            
		preferredAddress = document.getElementsByName('Address.preferredAddress')[0];
		var preferredAddressFlag = false;
		if(blFlag == true)
		{
			if(preferredAddress.value == "")
			{
				selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Please select one Preferred Address",""), preferredAddress.name, 'NO_HYPER_LINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				return "interactive";
			}
			else
			{
				// Tracker ID: 135125: XMLEncoding Changes STARTS
				if(boName == "AccountBO" )
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("AccountBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("AccountBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if(boName == "AccountModBO")
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("AccountModBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("AccountModBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if(boName == "ContactBO" )
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("ContactBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("ContactBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if( boName == "ContactModBO")
				{	
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("ContactModBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("ContactModBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if(boName == "SuspectBO" )
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("SuspectBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("SuspectBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if(boName == "SuspectModBO")
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("SuspectModBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("SuspectModBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if(boName == "NonCustomerBO" )
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("NonCustomerBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("NonCustomerBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if( boName == "NonCustomerModBO")
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("NonCustomerModBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("NonCustomerModBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				// Tracker ID: 135125: XMLEncoding Changes ENDS
				if(!preferredAddressFlag)
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Does not exist in the Listing",""), preferredAddress.name, 'NO_HYPER_LINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
				}
			}
		}
		/* CIF PhoneEmail Changes : End */
            
            addEduCounter = 0 ;
			addPhoneEmailCounter = 0;
            clearAddressValues();
 
 try {
	 for(var i = 0; i <noOfEdu; i++) {
		 if((addr_URL[i] != null) && !(edu_Status[i] == "Remove")) {

			 if(addEduCounter == 0) {
				document.frm2.address_type.value=srmEscape(ad_address_type[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/			
				document.frm2.houseno.value=srmEscapeAddr(ad_houseno[i], '^', escCharsAddr);;
				document.frm2.premiseno.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
				document.frm2.building.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
				document.frm2.premisename.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
				document.frm2.buildinglevel.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/
				document.frm2.country.value = srmEscape(ad_country[i], '^', escChars);
				document.frm2.city.value = srmEscape(ad_city[i], '^', escChars);
				document.frm2.state.value = srmEscape(ad_state[i], '^', escChars);
				document.frm2.start_date.value = srmEscape(ad_start_date[i], '^', escChars);
				document.frm2.zip.value = srmEscape(ad_zip[i], '^', escChars);
				document.frm2.end_date.value = srmEscape(ad_end_date[i], '^', escChars);
				document.frm2.addrID.value = srmEscape(ad_addrID[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/
				document.frm2.streetno.value = srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
				document.frm2.town.value = srmEscapeAddr(ad_town[i], '^', escCharsAddr);
				document.frm2.locality.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
				document.frm2.localityName.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);			
				document.frm2.domicile.value = srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/

				document.frm2.PreferredFormat.value = srmEscape(ad_PreferredFormat[i], '^', escChars);
				document.frm2.HoldMailReason.value = srmEscape(ad_HoldMailReason[i], '^', escChars);
				document.frm2.BusinessCenter.value = srmEscape(ad_BusinessCenter[i], '^', escChars);
				document.frm2.HoldMailInitiatedBy.value = srmEscape(ad_HoldMailInitiatedBy[i], '^', escChars);
				document.frm2.HoldMailFlag.value = srmEscape(ad_HoldMailFlag[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/
				document.frm2.AddressLine1.value = srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
				document.frm2.AddressLine2.value = srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
				document.frm2.AddressLine3.value = srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
				document.frm2.FreeTextLabel.value = srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/   
                                document.frm2.LastUpdate_Date.value = srmEscape(ad_LastUpdate_Date[i], '^', escChars);
				document.frm2.PreferredAddress.value = document.getElementsByName('Address.preferredAddress')[0].value;
				//document.frm2.website.value = srmEscape(ad_website[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/
				document.frm2.url.value = srmEscapeAddr(ad_website[i], '^', escCharsAddr);
				document.frm2.mailstop.value = srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
				document.frm2.streetname.value = srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
				document.frm2.suburb.value = srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/
				document.frm2.IsAddressProofRcvd.value = srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);		
                /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
				document.frm2.IsAddressVerified.value = srmEscape(ad_IsAddressVerified[i], '^', escChars);
                /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x old*/
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
				 //Tracker 105266
				 /* CRM102ST:TrackerID:179465 Being of Change */
				 document.frm2.premisename.value = document.frm2.premisename.value + " %" + srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
				 document.frm2.buildinglevel.value = document.frm2.buildinglevel.value + " %" + srmEscapeAddr(ad_building[i], '^', escCharsAddr);
				 /* CRM102ST:TrackerID:179465 End of Change */
			/*Tracker 159095 : Sonali  end of changes*/
				 document.frm2.country.value = document.frm2.country.value + " ," + srmEscape(ad_country[i], '^', escChars);
				 document.frm2.city.value = document.frm2.city.value + " ," + srmEscape(ad_city[i], '^', escChars);
				 document.frm2.state.value = document.frm2.state.value + " ," + srmEscape(ad_state[i], '^', escChars);
				 document.frm2.start_date.value = document.frm2.start_date.value + " ," + srmEscape(ad_start_date[i], '^', escChars);
				 document.frm2.zip.value = document.frm2.zip.value + " ," + srmEscape(ad_zip[i], '^', escChars);
				 document.frm2.end_date.value = document.frm2.end_date.value + " ," + srmEscape(ad_end_date[i], '^', escChars);
				 document.frm2.addrID.value = document.frm2.addrID.value + " ," + srmEscape(ad_addrID[i], '^', escChars);

			/*Tracker 159095 : Sonali begin of changes*/
				 document.frm2.streetno.value = document.frm2.streetno.value + "%" + srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
				 document.frm2.town.value = document.frm2.town.value + "%" + srmEscapeAddr(ad_town[i], '^', escCharsAddr);
				 document.frm2.locality.value = document.frm2.locality.value + "%" + srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
				 document.frm2.localityName.value = document.frm2.localityName.value + "%" + srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
				 document.frm2.domicile.value = document.frm2.domicile.value + "%" + srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/

				 //CIF PhoneEmail Changes : Start
				document.frm2.PreferredFormat.value = document.frm2.PreferredFormat.value + " ," + srmEscape(ad_PreferredFormat[i], '^', escChars);
				document.frm2.HoldMailReason.value = document.frm2.HoldMailReason.value + " ," + srmEscape(ad_HoldMailReason[i], '^', escChars);
				document.frm2.BusinessCenter.value = document.frm2.BusinessCenter.value + " ," + srmEscape(ad_BusinessCenter[i], '^', escChars);
				document.frm2.HoldMailInitiatedBy.value = document.frm2.HoldMailInitiatedBy.value + " ," + srmEscape(ad_HoldMailInitiatedBy[i], '^', escChars);
				document.frm2.HoldMailFlag.value = document.frm2.HoldMailFlag.value + " ," + srmEscape(ad_HoldMailFlag[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/
				document.frm2.AddressLine1.value = document.frm2.AddressLine1.value + "%" + srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
				document.frm2.AddressLine2.value = document.frm2.AddressLine2.value + "%" + srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
				document.frm2.AddressLine3.value = document.frm2.AddressLine3.value + "%" + srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
				document.frm2.FreeTextLabel.value = document.frm2.FreeTextLabel.value + "%" + srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/
                                document.frm2.LastUpdate_Date.value = document.frm2.LastUpdate_Date.value + "$" + srmEscape(ad_LastUpdate_Date[i], '^', escChars);
				document.frm2.PreferredAddress.value = document.getElementsByName('Address.preferredAddress')[0].value;
				 //CIF PhoneEmail Changes : End
                                 //document.frm2.url.value = document.frm2.url.value + " ," + srmEscape(ad_website[i], '^', escChars);
				 //document.frm2.website.value = document.frm2.website.value + " ," + srmEscape(ad_website[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/
				 document.frm2.url.value = document.frm2.url.value + "%" + srmEscapeAddr(ad_website[i], '^', escCharsAddr);
				 document.frm2.mailstop.value = document.frm2.mailstop.value + "%" + srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
				 document.frm2.streetname.value = document.frm2.streetname.value + "%" + srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
				 document.frm2.suburb.value = document.frm2.suburb.value + "%" + srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/
				 document.frm2.IsAddressProofRcvd.value = document.frm2.IsAddressProofRcvd.value + " ," + srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
				 /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
				 document.frm2.IsAddressVerified.value = document.frm2.IsAddressVerified.value + " ," + srmEscape(ad_IsAddressVerified[i], '^', escChars);
				 /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
				document.frm2.city_code.value 		= document.frm2.city_code.value + " ," +srmEscape(ad_cityCode[i], '^', escChars);	
				document.frm2.state_code.value 		= document.frm2.state_code.value + " ," +srmEscape(ad_stateCode[i], '^', escChars);	
				document.frm2.country_code.value 	= document.frm2.country_code.value + " ," +srmEscape(ad_cntryCode[i], '^', escChars);	
				
			   }
		 }
	 }//end of for
     document.frm2.AdrRemoved.value = getCSVforArray(edu_detachedURLs);
     //Change for DBS ticket 325152
     document.frm2.SwiftAddressDetails.value 		= SwiftAddressDetails;	

	 }
	 catch(e)
	 {
				 alert("Exception in Quick Save->"+e.description);
	 }
	document.frm2.action="../servlet/com.infy.cis.ui.cif.QuickEntityWriter";
    document.frm2.target="formSaveFrame";
    document.frm2.submit();
    return "true";
}

//changes for callid 441810 ends
function save(blFlag)
{
	var altCalendarHij = ALTCALENDAR_TYPE;
	if(document.frm2.isMCEdited.value=="Y"){
		document.frm2.isMCEditedGeneral.value="Y";
	}
	if(document.frm2.isMCEdited.value=="Y"){
		document.frm2.isMCEditedGeneral.value="Y";
	}
	if(blFlag == false)
	{
		document.frm2.saveFlag.value=1;
	}
	else
	{
		document.frm2.saveFlag.value=0;
	}
	var noOfAddress = addr_URL.length;
	var chkStat = parent.parent.parent.parent.ValidateFormContents(document.frm2,false);
	     
	if (chkStat != "true")
		  return 'interactive';
        
    var mailingad;// = false;
	var otherAdd;
    noOfEdu = addr_URL.length;
	var NRERel;// = false;
    var isNRE;// = true;
	if(isEntityNRE == "Y" ){
		isNRE = true;
	 }
	 else{
		isNRE = false;
	 }
     chkadres = document.all.RecordSet.rows.length;      
     if(chkadres == 2 && isNRE == true){
		//showUserMessage("MSG_CONTACT_IDEXISTS",null);
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CONTACT_DEFID",""),TBODY_RecordSet.rows ,'NO_HLINK');
		//changes for 258713 starts
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_NREREL",""),TBODY_RecordSet.rows ,'NO_HLINK');
		//changes for 258713 ends
		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		return "interactive"
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
	 var defAddress = defAddressType;
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
		
      //CIF Changes for NRE - Begin
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
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_DEFID",""),TBODY_RecordSet.rows ,'NO_HLINK');
			 parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			 return "interactive"
		}
		//changes for 258713 starts
		if(NRERel == false && isNRE == true){
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_NREREL",""),TBODY_RecordSet.rows ,'NO_HLINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
		}
		//changes for 258713 ends
             //CIF Changes for NRE:end
		/* Changes for ticket 346170 : BEGIN  */
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
			return "interactive";
			/* Changes for ticket 346170 : END  */
		}
		}	
		/***adress validations****/
		// fetching end date for addresstype 'mailing'
		try{
		var startdate  = new Array();
		var index      = new Array();
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Mailing") && !(edu_Status[k] == "Remove")) {
		startdate[z] = ad_start_date[k];
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
		//tracker 113259:Hijri:to validate for hijri dates:change start
		// ad_end_date[findex] = address_enddate(startdate[k+1]);
			ad_end_date[findex] = address_enddateHij(altCalendarHij,startdate[k+1]);
  		 //tracker 113259:Hijri:to validate for hijri dates:change end
		
		}
		else{
		ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
		// fetching end date for addresstype 'mailing' -end
		//Changes for current mailing address - start
		noOfmailingaddress = startdate.length;		
		var currentCount = 0;	
		var todaydate = new String();
		//Rachit Change for quick edit
		todaydate.value = getTodayDate();  
		for(var k = 0; k < noOfmailingaddress ; k++) 
		{			
			var millistartdate1 = changetoMillis(startdate[k]);
			var millistartdate2 = changetoMillis(todaydate.value);
			if (millistartdate1 <= millistartdate2)
			{
			currentCount=currentCount+1;			
			}		
		}
		
		if (currentCount == 0)
		{		
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG_MAIL_CURR_ADD",""),TBODY_RecordSet.rows ,'NO_HLINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);				
			return "interactive"
		}		
		//Changes for current mailing address - end
		
		// fetching end date for addresstype 'home'
		try{
		var startdate1  = new Array();
		var index1      = new Array();
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Home") && !(edu_Status[k] == "Remove")) {
		startdate1[z] = ad_start_date[k];
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
		//tracker 113259:Hijri:to validate for hijri dates:change start
			// ad_end_date[findex] = address_enddate(startdate1[k+1]);
			ad_end_date[findex] = address_enddateHij(altCalendarHij,startdate1[k+1]);
  		 //tracker 113259:Hijri:to validate for hijri dates:change end
		
		}
		else{
		ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
		// fetching end date for addresstype 'home' -end
		// fetching end date for addresstype 'work'
		try{
		var startdate2  = new Array();
		var index2      = new Array();
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Work") && !(edu_Status[k] == "Remove")) {
		startdate2[z] = ad_start_date[k];
		index2[z] = k;
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
		//tracker 113259:Hijri:to validate for hijri dates:change start
		// ad_end_date[findex] = address_enddate(startdate2[k+1]);
		ad_end_date[findex] = address_enddateHij(altCalendarHij,startdate2[k+1]);
  		 //tracker 113259:Hijri:to validate for hijri dates:change end
		
		}
		else{
		ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
		// fetching end date for addresstype 'work' -end
		// fetching end date for addresstype 'future/onsite'
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
		//tracker 113259:Hijri:to validate for hijri dates:change start
		// ad_end_date[findex] = address_enddate(startdate3[k+1]);
		ad_end_date[findex] = address_enddateHij(altCalendarHij,startdate3[k+1]);
  		 //tracker 113259:Hijri:to validate for hijri dates:change end
		
		}
		else{
		ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
		// fetching end date for addresstype 'future/onsite'
		
		// TRACKER 112270  changes-Begin 
		
		// fetching end date for addresstype 'Others' -begin	 		
		   setEnddateForOtherRetailAddrType(noOfEdu,ad_address_type,address_type,edu_Status);
 		// fetching end date for addresstype 'Others' -end
 		
 		// TRACKER 112270  changes-End  		
		// date validations-end            
		preferredAddress = document.getElementsByName('Address.preferredAddress')[0];
		var preferredAddressFlag = false;
		if(blFlag == true)
		{
			if(preferredAddress.value == "")
			{
				selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Please select one Preferred Address",""), preferredAddress.name, 'NO_HYPER_LINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				return "interactive";
			}
			else
			{
				// Tracker ID: 135125: XMLEncoding Changes STARTS
				if(boName == "AccountBO" )
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("AccountBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("AccountBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if(boName == "AccountModBO")
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("AccountModBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("AccountModBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if(boName == "ContactBO" )
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("ContactBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("ContactBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if( boName == "ContactModBO")
				{	
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("ContactModBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("ContactModBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if(boName == "SuspectBO" )
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("SuspectBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("SuspectBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if(boName == "SuspectModBO")
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("SuspectModBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("SuspectModBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if(boName == "NonCustomerBO" )
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("NonCustomerBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("NonCustomerBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				else if( boName == "NonCustomerModBO")
				{
					for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
					{
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("NonCustomerModBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("NonCustomerModBO.Address.PreferredFormat");
						/*if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
						{
							preferredAddressFlag = true
							selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive";
						}*/
						if(preferredAddress.value == recordSetAddressCategory)
						{
							preferredAddressFlag = true;
						}
					}
				}
				// Tracker ID: 135125: XMLEncoding Changes ENDS
				if(!preferredAddressFlag)
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Does not exist in the Listing",""), preferredAddress.name, 'NO_HYPER_LINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
				}
			}
		}
		/* CIF PhoneEmail Changes : End */
            
            addEduCounter = 0 ;
			addPhoneEmailCounter = 0;
            clearAddressValues();
 
 try {
	 for(var i = 0; i <noOfEdu; i++) {
		 if((addr_URL[i] != null) && !(edu_Status[i] == "Remove")) {

			 if(addEduCounter == 0) {
				document.frm2.address_type.value=srmEscape(ad_address_type[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/			
				document.frm2.houseno.value=srmEscapeAddr(ad_houseno[i], '^', escCharsAddr);;
				document.frm2.premiseno.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
				document.frm2.building.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
				document.frm2.premisename.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
				document.frm2.buildinglevel.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/
				document.frm2.country.value = srmEscape(ad_country[i], '^', escChars);
				document.frm2.city.value = srmEscape(ad_city[i], '^', escChars);
				document.frm2.state.value = srmEscape(ad_state[i], '^', escChars);
				document.frm2.start_date.value = srmEscape(ad_start_date[i], '^', escChars);
				document.frm2.zip.value = srmEscape(ad_zip[i], '^', escChars);
				document.frm2.end_date.value = srmEscape(ad_end_date[i], '^', escChars);
				document.frm2.addrID.value = srmEscape(ad_addrID[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/
				document.frm2.streetno.value = srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
				document.frm2.town.value = srmEscapeAddr(ad_town[i], '^', escCharsAddr);
				document.frm2.locality.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
				document.frm2.localityName.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);			
				document.frm2.domicile.value = srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/

				document.frm2.PreferredFormat.value = srmEscape(ad_PreferredFormat[i], '^', escChars);
				document.frm2.HoldMailReason.value = srmEscape(ad_HoldMailReason[i], '^', escChars);
				document.frm2.BusinessCenter.value = srmEscape(ad_BusinessCenter[i], '^', escChars);
				document.frm2.HoldMailInitiatedBy.value = srmEscape(ad_HoldMailInitiatedBy[i], '^', escChars);
				document.frm2.HoldMailFlag.value = srmEscape(ad_HoldMailFlag[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/
//Changes for call id: 401260 and recon for TOL 397571
                                document.frm2.LastUpdate_Date_Flag.value =  srmEscape(ad_LastUpdate_Flag[i], '^', escChars);
				document.frm2.AddressLine1.value = srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
				document.frm2.AddressLine2.value = srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
				document.frm2.AddressLine3.value = srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
				document.frm2.FreeTextLabel.value = srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/   
                                document.frm2.LastUpdate_Date.value = srmEscape(ad_LastUpdate_Date[i], '^', escChars);
				document.frm2.PreferredAddress.value = document.getElementsByName('Address.preferredAddress')[0].value;
				//document.frm2.website.value = srmEscape(ad_website[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/
				document.frm2.url.value = srmEscapeAddr(ad_website[i], '^', escCharsAddr);
				document.frm2.mailstop.value = srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
				document.frm2.streetname.value = srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
				document.frm2.suburb.value = srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/
				document.frm2.IsAddressProofRcvd.value = srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);		
                /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
				document.frm2.IsAddressVerified.value = srmEscape(ad_IsAddressVerified[i], '^', escChars);
                /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x old*/
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
				 //Tracker 105266
				 /* CRM102ST:TrackerID:179465 Being of Change */
				 document.frm2.premisename.value = document.frm2.premisename.value + " %" + srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
				 document.frm2.buildinglevel.value = document.frm2.buildinglevel.value + " %" + srmEscapeAddr(ad_building[i], '^', escCharsAddr);
				 /* CRM102ST:TrackerID:179465 End of Change */
			/*Tracker 159095 : Sonali  end of changes*/
				 document.frm2.country.value = document.frm2.country.value + " ," + srmEscape(ad_country[i], '^', escChars);
				 document.frm2.city.value = document.frm2.city.value + " ," + srmEscape(ad_city[i], '^', escChars);
				 document.frm2.state.value = document.frm2.state.value + " ," + srmEscape(ad_state[i], '^', escChars);
				 document.frm2.start_date.value = document.frm2.start_date.value + " ," + srmEscape(ad_start_date[i], '^', escChars);
				 document.frm2.zip.value = document.frm2.zip.value + " ," + srmEscape(ad_zip[i], '^', escChars);
				 document.frm2.end_date.value = document.frm2.end_date.value + " ," + srmEscape(ad_end_date[i], '^', escChars);
				 document.frm2.addrID.value = document.frm2.addrID.value + " ," + srmEscape(ad_addrID[i], '^', escChars);

			/*Tracker 159095 : Sonali begin of changes*/
				 document.frm2.streetno.value = document.frm2.streetno.value + "%" + srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
				 document.frm2.town.value = document.frm2.town.value + "%" + srmEscapeAddr(ad_town[i], '^', escCharsAddr);
				 document.frm2.locality.value = document.frm2.locality.value + "%" + srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
				 document.frm2.localityName.value = document.frm2.localityName.value + "%" + srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
				 document.frm2.domicile.value = document.frm2.domicile.value + "%" + srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/

				 //CIF PhoneEmail Changes : Start
				document.frm2.PreferredFormat.value = document.frm2.PreferredFormat.value + " ," + srmEscape(ad_PreferredFormat[i], '^', escChars);
				document.frm2.HoldMailReason.value = document.frm2.HoldMailReason.value + " ," + srmEscape(ad_HoldMailReason[i], '^', escChars);
				document.frm2.BusinessCenter.value = document.frm2.BusinessCenter.value + " ," + srmEscape(ad_BusinessCenter[i], '^', escChars);
				document.frm2.HoldMailInitiatedBy.value = document.frm2.HoldMailInitiatedBy.value + " ," + srmEscape(ad_HoldMailInitiatedBy[i], '^', escChars);
				document.frm2.HoldMailFlag.value = document.frm2.HoldMailFlag.value + " ," + srmEscape(ad_HoldMailFlag[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/
				document.frm2.AddressLine1.value = document.frm2.AddressLine1.value + "%" + srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
				document.frm2.AddressLine2.value = document.frm2.AddressLine2.value + "%" + srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
				document.frm2.AddressLine3.value = document.frm2.AddressLine3.value + "%" + srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
				document.frm2.FreeTextLabel.value = document.frm2.FreeTextLabel.value + "%" + srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/
                                document.frm2.LastUpdate_Date.value = document.frm2.LastUpdate_Date.value + "$" + srmEscape(ad_LastUpdate_Date[i], '^', escChars);
//Changes for call id: 401260 and recon for TOL 397571
                                document.frm2.LastUpdate_Date_Flag.value = document.frm2.LastUpdate_Date_Flag.value + "," + srmEscape(ad_LastUpdate_Flag[i], '^', escChars);
				document.frm2.PreferredAddress.value = document.getElementsByName('Address.preferredAddress')[0].value;
				 //CIF PhoneEmail Changes : End
                                 //document.frm2.url.value = document.frm2.url.value + " ," + srmEscape(ad_website[i], '^', escChars);
				 //document.frm2.website.value = document.frm2.website.value + " ," + srmEscape(ad_website[i], '^', escChars);
			/*Tracker 159095 : Sonali begin of changes*/
				 document.frm2.url.value = document.frm2.url.value + "%" + srmEscapeAddr(ad_website[i], '^', escCharsAddr);
				 document.frm2.mailstop.value = document.frm2.mailstop.value + "%" + srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
				 document.frm2.streetname.value = document.frm2.streetname.value + "%" + srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
				 document.frm2.suburb.value = document.frm2.suburb.value + "%" + srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
			/*Tracker 159095 : Sonali  end of changes*/
				 document.frm2.IsAddressProofRcvd.value = document.frm2.IsAddressProofRcvd.value + " ," + srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
				 /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
				 document.frm2.IsAddressVerified.value = document.frm2.IsAddressVerified.value + " ," + srmEscape(ad_IsAddressVerified[i], '^', escChars);
				 /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
				document.frm2.city_code.value 		= document.frm2.city_code.value + " ," +srmEscape(ad_cityCode[i], '^', escChars);	
				document.frm2.state_code.value 		= document.frm2.state_code.value + " ," +srmEscape(ad_stateCode[i], '^', escChars);	
				document.frm2.country_code.value 	= document.frm2.country_code.value + " ," +srmEscape(ad_cntryCode[i], '^', escChars);	
				
			   }
		 }
	 }//end of for
     document.frm2.AdrRemoved.value = getCSVforArray(edu_detachedURLs);
     //Change for DBS ticket 325152
     document.frm2.SwiftAddressDetails.value 		= SwiftAddressDetails;	

	 }
	 catch(e)
	 {
				 alert("Exception in Quick Save->"+e.description);
	 }
	document.frm2.action="../servlet/com.infy.cis.ui.cif.QuickEntityWriter";
    document.frm2.target="formSaveFrame";
    document.frm2.submit();
    return "true";
}

function check(Tab,setFlag){
	  if(setFlag == false) {
		noValidationMsg = true;
		}
		else {
			noValidationMsg = false;
		}
        return parent.parent.parent.parent.ValidateFormContents(document.frm2,true,noValidationMsg,Tab);
	}
function clear() {
//	alert("in clear values");
}
function resubmit(){
	parent.parent.parent.parent.parent.parent.frames(0).submit();
}
function selectProcess()
{
	submit = true;	
	var entityType = "";
	var accountId=0;
	entityId  = parent.formSaveFrame.savedValue;
	entityType  = parent.formSaveFrame.entityType;
	var secureHKey = document.getElementsByName("SECUREHKEY")[0].value;	
	var keyField = document.getElementsByName("FLDHASHKEY")[0].value;						
	/*fix for ticket 456873 and tracker id 277967*/
	//alert('For Process secureHKey=='+secureHKey);
	//alert('For Process keyField=='+keyField);
	/*fix for ticket 456873 and tracker id 277967*/
	
	//window.open('../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+entityId+'&amp;entityType='+entityType+'&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField+'&amp;isPopup=Yes','save','directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
/*Changes by Niharika for CR356016*/
	//window.open('../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+entityId+'&amp;entityType='+entityType+'&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField+'&amp;isPopup=Yes','save','directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
	//var strProcessURL = '../servlet/com.infy.cis.custom.EquityRetailProcessSelection?entityId='+entityId+'&amp;entityType='+entityType;
	var strProcessURL = '../servlet/com.infy.cis.custom.EquityRetailProcessSelection?entityId='+entityId+'&entityType='+entityType;
	var strBOURL = "";
	
	fnProcessSelection(strProcessURL, strBOURL);
	
	/*End of changes by Niharika for CR356016*/
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
/* CIF PhoneEmail Changes : End */
var SwiftAddressDetails = "";
var SwiftName = "";
var SwiftAddr1 = "";
var SwiftAddr2 = "";
var SwiftAddr3 = "";
function editSwiftAddress(){
	var boName = "AccountBO";
	var mode="Edit";
	var isReadOnly;
	var getMCRequired=document.frm2.getMCRequired.value;
	var wh = 260;
	var ww = 900;
	var left_x = (screen.width - ww) / 2 ;
	var left_y = (screen.height - wh) / 2 ;
	
	//Change for DBS ticket 325152
	docTypeNew = window.open('../common/html/SSOblank.html', 'SwiftAddressDetails', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=no');
	
	document.frm2.target = 'SwiftAddressDetails';
	document.frm2.SwiftAddressDetails.value=SwiftAddressDetails;
	

	
	document.frm2.action ="../servlet/com.infy.cis.ui.cif.SwiftAddressForm_det?boName="+boName+"&isReadOnly="+isReadOnly+"&mode="+mode+"&getMCRequired="+getMCRequired;
	document.frm2.submit();

}
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

	return true;
}
                












