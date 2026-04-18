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
var adr_detachedURLs    = new Array();
var adr_Status          = new Array();
var ad_streetno         = new Array();
var ad_town	            = new Array();
var ad_domicile         = new Array();
var ad_locality	    = new Array();
var ad_website	    = new Array();
var ad_mailstop	    = new Array();
var ad_streetname	    = new Array();
var ad_suburb	    = new Array();
var ad_extension	    = new Array();
// changes for Tracker ID 456637 - TOL ID 455246
var ad_vAddTypeLT	    = new Array();
// changes for Tracker ID 456637 - TOL ID 455246
//Changes for 442528 start :
var copyFlag=false;
//Changes for 442528 end :

var ad_IsAddressProofRcvd = new Array();
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
var ad_IsAddressVerified = new Array();
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
var adr_URL             = new Array();
var ad_PreferredFormat = new Array();
var ad_HoldMailReason = new Array();
var ad_BusinessCenter = new Array();
var ad_HoldMailInitiatedBy = new Array();
var ad_HoldMailFlag = new Array();
var ad_AddressLine1 = new Array();
var ad_AddressLine2 = new Array();
var ad_AddressLine3 = new Array();
var ad_FreeTextLabel = new Array();
var ad_swiftcode = new Array();
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
var escChars = new Array(',');
var escChars1 = new Array('@');

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
var name = "";
try {
	var selTabId = parent.parent.parent.parent.frames(0).getSelectedTabId();
} catch(e) {
}
var lookupFor = '';
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
function checkForHoldMailValue()
{
	var holdMailFieldsArray = new Array();
	holdMailFieldsArray[0] = document.getElementsByName("CorporateBO.Address.HoldMailInitiatedBy")[0].value;
	holdMailFieldsArray[1] = document.getElementsByName("CorporateBO.Address.BusinessCenter")[0].value;
	holdMailFieldsArray[2] = document.getElementsByName("CorporateBO.Address.HoldMailReason")[0].value;
	for(var j=0;j < holdMailFieldsArray.length;j++)
	{
		if(holdMailFieldsArray[j] != ""){
			return false;
		}
	}
	return true;
}
function clearHoldMailValues()
{
	document.getElementsByName("CorporateBO.Address.HoldMailInitiatedBy")[0].value = "";
	document.getElementsByName("CorporateBO.Address.BusinessCenter")[0].value = "";
	document.getElementsByName("CorporateBO.Address.HoldMailReason")[0].value = "";
}
function disableEnableHoldMail(){

// Tracker 180411 Hold Mail Changes : Begin

   //making HoldMail Fields Disabled
   if(document.getElementsByName("CorporateBO.Address.HoldMailFlag")[0].value == "N")
   {
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
			document.getElementsByName("CorporateBO.Address.HoldMailFlag")[0].value = "Y";
			return;
		}
	}
	document.getElementsByName("CorporateBO.Address.HoldMailInitiatedBy")[0].disabled = true;
	document.getElementsByName("btnone_CorporateBO.Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName("btntwo_CorporateBO.Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName("CorporateBO.Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName("CorporateBO.Address.HoldMailReason")[0].disabled = true;
	document.getElementsByName("mandStarCorporateBO.Address.HoldMailInitiatedBy")[0].style.visibility="hidden";
	document.getElementsByName("mandStarCorporateBO.Address.BusinessCenter")[0].style.visibility="hidden";
	document.getElementsByName("mandStarCorporateBO.Address.HoldMailReason")[0].style.visibility="hidden";
	document.getElementsByName("CorporateBO.Address.HoldMailInitiatedBy")[0].IsMandatory = "false";
	document.getElementsByName("CorporateBO.Address.BusinessCenter")[0].IsMandatory = "false";
	document.getElementsByName("CorporateBO.Address.HoldMailReason")[0].IsMandatory = "false";
   }
   else if(document.getElementsByName("CorporateBO.Address.HoldMailFlag")[0].value == "Y")
   {
	document.getElementsByName("CorporateBO.Address.HoldMailInitiatedBy")[0].disabled = false;
	document.getElementsByName("btnone_CorporateBO.Address.BusinessCenter")[0].disabled = false;
	document.getElementsByName("btntwo_CorporateBO.Address.BusinessCenter")[0].disabled = false;
	document.getElementsByName("CorporateBO.Address.BusinessCenter")[0].disabled = false;
	document.getElementsByName("CorporateBO.Address.HoldMailReason")[0].disabled = false;
	document.getElementsByName("mandStarCorporateBO.Address.HoldMailInitiatedBy")[0].style.visibility="visible";
	document.getElementsByName("mandStarCorporateBO.Address.BusinessCenter")[0].style.visibility="visible";
	document.getElementsByName("mandStarCorporateBO.Address.HoldMailReason")[0].style.visibility="visible";
	document.getElementsByName("CorporateBO.Address.HoldMailInitiatedBy")[0].IsMandatory = "true";
	document.getElementsByName("CorporateBO.Address.BusinessCenter")[0].IsMandatory = "true";
	document.getElementsByName("CorporateBO.Address.HoldMailReason")[0].IsMandatory = "true";
   }
   else {
   
   	document.getElementsByName("CorporateBO.Address.HoldMailInitiatedBy")[0].disabled = true;
   	document.getElementsByName("btnone_CorporateBO.Address.BusinessCenter")[0].disabled = true;
   	document.getElementsByName("btntwo_CorporateBO.Address.BusinessCenter")[0].disabled = true;
   	document.getElementsByName("CorporateBO.Address.BusinessCenter")[0].disabled = true;
   	document.getElementsByName("CorporateBO.Address.HoldMailReason")[0].disabled = true;
   	document.getElementsByName("mandStarCorporateBO.Address.HoldMailInitiatedBy")[0].style.visibility="hidden";
   	document.getElementsByName("mandStarCorporateBO.Address.BusinessCenter")[0].style.visibility="hidden";
   	document.getElementsByName("mandStarCorporateBO.Address.HoldMailReason")[0].style.visibility="hidden";
   	document.getElementsByName("CorporateBO.Address.HoldMailInitiatedBy")[0].IsMandatory = "false";
   	document.getElementsByName("CorporateBO.Address.BusinessCenter")[0].IsMandatory = "false";
	document.getElementsByName("CorporateBO.Address.HoldMailReason")[0].IsMandatory = "false";
	
	// Tracker 180411 Hold Mail Changes : End
   
   }
}
function checkFormatForAddressType(){
	todayStart_date = 	document.getElementsByName("3_CorporateBO.Address.Start_Date")[0];
	/* Tracker-ID 113259:ERPBOCF1:Hijri:To convert current date to Hijri date format - start*/
	//when the calendar type selected by the user is Hijri then the current date will be converted to Hijri date format
	var current_Date = getCurrentDate();
	if((current_Date!= '') && (current_Date != undefined))
	{
		//date converted acc to the present calendar type 
		current_Date = changeDateAccToPresentCalendar(current_Date);
	}
	//Changes for 415603 starts
	if(current_Date != null && current_Date !='undefined'){
	todayStart_date.value = current_Date;
	}else{
	todayStart_date.value = getCurrentDate();
	}
	//Changes for 415603 ends
	// Removing the Check for Two Address Types having different Formats : begin
	/* Tracker-ID 113259:ERPBOCF1:Hijri:To convert current date to Hijri date format  - END*/
	//var selectedAddressType = document.getElementsByName("CorporateBO.Address.addressCategory")[0].value;
	//var tempSelectedAddressType = document.getElementsByName('CorporateBO.Address.addressCategory')[0].options[document.getElementsByName('CorporateBO.Address.addressCategory')[0].selectedIndex].text;
	/* Changes for tracker 182231 starts */
	//var format = checkFormatForAddressTypeSelected(selectedAddressType);
	/* Changes for tracker 182231 ends */
	/*if(format != null && format != "")
	{
		if(format != document.getElementsByName('CorporateBO.Address.PreferredFormat')[0].value)
		{
				if(format != selectedAddressType)
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
		}
		document.getElementsByName('CorporateBO.Address.PreferredFormat')[0].value = format;
		if(format == "FREE_TEXT_FORMAT")
		{
			//enabling free Text Label And Format
			//disableEnableFreeTextFields(false);

			//disabling structured field formats
			//disableEnableStructuredFields(true);
		}
		else
		{
			//disabling free Text Label And Format
			//disableEnableFreeTextFields(true);

			//enabling structured field formats
			//disableEnableStructuredFields(false);
		}
	}*/
	// Removing the Check for Two Address Types having different Formats : end
	//Changes for 415603
	//populateHoldMail(document.getElementsByName("CorporateBO.Address.addressCategory")[0].value);
	
}

function disableEnableFreeTextAddress(){
	/* Changes for tracker 182231 starts */
	if(isQuickEdit=='' || isQuickEdit ==null){
		isQuickEdit = GetCookie('isQuickEdit');
	}
	/* Changes for tracker 182231 ends */
	// Removing the Check for Two Address Types having different Formats : begin
//Changes for CRM10202Beta Ticket 321361 : Begin
	var selectedFormat = document.getElementsByName("CorporateBO.Address.PreferredFormat")[0].value;
	var selectedAddressType = document.getElementsByName("CorporateBO.Address.addressCategory")[0].value;
	var tempSelectedAddressType = document.getElementsByName('CorporateBO.Address.addressCategory')[0].options[document.getElementsByName('CorporateBO.Address.addressCategory')[0].selectedIndex].text;
	/*if(selectedFormat != null && selectedFormat !="")
//Changes for CRM10202Beta Ticket 321361 : End
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
				document.getElementsByName('CorporateBO.Address.addressCategory')[0].value = flag;
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
	// Removing the Check for Two Address Types having different Formats : begin
	var confirmFlag = true;
	if(!checkForValue(document.getElementsByName("CorporateBO.Address.PreferredFormat")[0].value))
	{
		confirmFlag = showConfirmMessage(MSGJ50262);
		if(confirmFlag == true)
		{
			clearAddressValues();
		}
		else
		{
			if(selectedFormat == "STRUCTURED_FORMAT")
				document.getElementsByName("CorporateBO.Address.PreferredFormat")[0].value = "FREE_TEXT_FORMAT";
			else
				document.getElementsByName("CorporateBO.Address.PreferredFormat")[0].value = "STRUCTURED_FORMAT";
		}
	}
	if(document.getElementsByName("CorporateBO.Address.PreferredFormat")[0].value == "STRUCTURED_FORMAT" && confirmFlag)
	{
		//disabling free Text Label And Format
		//disableEnableFreeTextFields(true);
		var preferredformat = "STRUCTURED_FORMAT";
		//self.location.href = "../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?PreferredFormat="+preferredformat;
if(isQuickEdit=="Yes")
		{
		/* Changes for tracker 182231 starts */
		self.location.href = "../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?isQuickEdit=Yes&PreferredFormat="+preferredformat+"&addrID="+AddressID;
		/* Changes for tracker 182231 ends */
}
else {
		/* Changes for tracker 182231 starts */
		self.location.href = "../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?PreferredFormat="+preferredformat+"&addrID="+AddressID;
		/* Changes for tracker 182231 ends */
}
		//enabling structured field formats
		//disableEnableStructuredFields(false);

	}
	else if(document.getElementsByName("CorporateBO.Address.PreferredFormat")[0].value == "FREE_TEXT_FORMAT" && confirmFlag)
	{
		//enabling free Text Label And Format
		//disableEnableFreeTextFields(false);
		var preferredformat = "FREE_TEXT_FORMAT";
		//self.location.href = "../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?PreferredFormat="+preferredformat;
if(isQuickEdit=="Yes")
		{
		/* Changes for tracker 182231 starts */
		self.location.href = "../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?isQuickEdit=Yes&PreferredFormat="+preferredformat+"&addrID="+AddressID;
		/* Changes for tracker 182231 ends */
}
else {
		/* Changes for tracker 182231 starts */
		self.location.href = "../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?PreferredFormat="+preferredformat+"&addrID="+AddressID;
		/* Changes for tracker 182231 ends */
}
		//disabling structured field formats
		//disableEnableStructuredFields(true);
	}
}

function populateHoldMail(selectedAddressType)
{
if(selectedAddressType != null && selectedAddressType != "")
{
// Tracker 180411 Hold Mail Changes : Begin
	var holdMailValues = top.window.opener.populateHoldMailForAddressType(selectedAddressType);
	if(holdMailValues != null)
	{
		/* if(holdMailValues[0] == "Y")
		{
			document.getElementsByName("CorporateBO.Address.HoldMailFlag")[0].value = "Y";
		}
		else
		{
			document.getElementsByName("CorporateBO.Address.HoldMailFlag")[0].value = "N";
		} */
		document.getElementsByName("CorporateBO.Address.HoldMailFlag")[0].value = holdMailValues[0];
		document.getElementsByName("CorporateBO.Address.HoldMailInitiatedBy")[0].value = holdMailValues[1];
		document.getElementsByName("CorporateBO.Address.BusinessCenter")[0].value = holdMailValues[2];
		document.getElementsByName("CorporateBO.Address.HoldMailReason")[0].value = holdMailValues[3];
		disableEnableHoldMail();

// Tracker 180411 Hold Mail Changes : End		
	}
//Ticket 364531 chages
	else{
		document.getElementsByName("CorporateBO.Address.HoldMailFlag")[0].value = "N";
		disableEnableHoldMail();
	}  
//Ticket 364531 chages	end
	
}
}

function checkForValue(selectedPreferredFormat)
{
if(selectedPreferredFormat == "FREE_TEXT_FORMAT")
{
	var structuredFieldsArray = new Array();
	structuredFieldsArray[0] = document.getElementsByName("CorporateBO.Address.city")[0].value;
	structuredFieldsArray[1] = document.getElementsByName("CorporateBO.Address.country")[0].value;
	structuredFieldsArray[2] = document.getElementsByName("CorporateBO.Address.state")[0].value;
	structuredFieldsArray[3] = document.getElementsByName("CorporateBO.Address.zip")[0].value;
	structuredFieldsArray[15] = document.getElementsByName("CorporateBO.Address.Start_Date")[0].value;
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
	freeFieldsArray[4] = document.getElementsByName("CorporateBO.Address.Start_Date")[0].value;
	for(var j=0;j<freeFieldsArray.length;j++)
	{
		if(freeFieldsArray[j] != ""){
			return false;
		}
	}
	return true;
}
}

function clearAddressValues(selectedPreferredFormat)
{
     if(selectedPreferredFormat == "FREE_TEXT_FORMAT")
     {
document.getElementsByName("Cat_CorporateBO.Address.city")[0].value = "";
document.getElementsByName("Cat_CorporateBO.Address.country")[0].value = "";
//Field Rationalization fix
document.getElementsByName("CorporateBO.Address.country")[0].value = "";
document.getElementsByName("Cat_CorporateBO.Address.state")[0].value = "";
document.getElementsByName("CorporateBO.Address.zip")[0].value = "";
	document.getElementsByName("CorporateBO.Address.FreeTextLabel")[0].value = "";
	document.getElementsByName("CorporateBO.Address.Address_Line1")[0].value = "";
	document.getElementsByName("CorporateBO.Address.Address_Line2")[0].value = "";
	document.getElementsByName("CorporateBO.Address.Address_Line3")[0].value = "";
	document.getElementsByName("CorporateBO.Address.Start_Date")[0].value = "";
	document.getElementsByName("CorporateBO.Address.End_Date")[0].value = "";
	document.getElementsByName("CorporateBO.Address.LastUpdate_Date")[0].value = "";
	document.getElementsByName("CorporateBO.Address.HoldMailReason")[0].value = "";
      }
      else if(selectedPreferredFormat == "STRUCTURED_FORMAT"){
	document.getElementsByName("Cat_CorporateBO.Address.city")[0].value = "";
	document.getElementsByName("Cat_CorporateBO.Address.country")[0].value = "";
	document.getElementsByName("CorporateBO.Address.country")[0].value = "";
	document.getElementsByName("Cat_CorporateBO.Address.state")[0].value = "";
	document.getElementsByName("CorporateBO.Address.zip")[0].value = "";
	document.getElementsByName("CorporateBO.Address.house_no")[0].value = "";
	document.getElementsByName("CorporateBO.Address.premise_name")[0].value = "";
	document.getElementsByName("CorporateBO.Address.building_level")[0].value = "";
	document.getElementsByName("CorporateBO.Address.street_no")[0].value = "";
	document.getElementsByName("CorporateBO.Address.suburb")[0].value = "";
	document.getElementsByName("CorporateBO.Address.street_name")[0].value = "";
	document.getElementsByName("CorporateBO.Address.locality_name")[0].value = "";
	document.getElementsByName("CorporateBO.Address.town")[0].value = "";
	document.getElementsByName("CorporateBO.Address.Start_Date")[0].value = "";
	document.getElementsByName("CorporateBO.Address.End_Date")[0].value = "";
	document.getElementsByName("CorporateBO.Address.LastUpdate_Date")[0].value = "";
	document.getElementsByName("CorporateBO.Address.HoldMailReason")[0].value = "";
      }
}


function  lookupBC (type){
bcLookupType = type;
var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForBCCode&isActive=Y&isAutomated=Y";
/*Tracker Id - 110963 Begin Of Changes*/
windowAlign();
var style = 'height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes';
/*Tracker Id - 110963 End Of Changes*/
window.open (url, "Lookup", style);
}
function removeAddressdetails(){
        var EduDetURL = '';
        var addrID = '';
        var entityID = '';
        if(CheckForSelectedRow(document.getElementsByName('AdrRecordSet'))=="false"){
		showUserMessage("MSG158",'MSGJ0120');
		return;
        }
	for (i=0; i < document.all.AdrRecordSet.rows.length ; i++){
	    var row_bgcolor = document.all.AdrRecordSet.rows(i).className;
	    if ( row_bgcolor == 'rowHighLighted')
	    {
			// Tracker ID: 135125: XMLEncoding Changes STARTS
	    	var temp='';
            	if(boName=='CorporateBO'){
			temp=document.all.AdrRecordSet.rows(i).getAttribute("CorporateBO.Address.addressCategory");
           	
            	}
            	else if(boName=='CorporateModBO'){
 			temp=document.all.AdrRecordSet.rows(i).getAttribute("CorporateModBO.Address.addressCategory");
            	}
 			// Tracker ID: 135125: XMLEncoding Changes ENDS
		for(j=0;j<ad_address_type.length;j++)
		{
		if(ad_address_type[j]==temp)
		{
		ad_LastUpdate_Flag[j]=null;
		}
		}
		entityID 		= corpID;
		var entityType 		= "CUSTOMER";
		var addressCateogry 	= "Corporate"
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		var addressType 	='';
            	if(boName=='CorporateBO'){
			addressType 	= document.all.AdrRecordSet.rows(i).getAttribute("CorporateBO.Address.addressCategory");
            	}
            	else if(boName=='CorporateModBO'){
 			addressType 	= document.all.AdrRecordSet.rows(i).getAttribute("CorporateModBO.Address.addressCategory");
            	}
		// Tracker ID: 135125: XMLEncoding Changes ENDS
	    }
	}
	hdifrm_empform.location.href="../servlet/com.infy.cis.ui.corpcif.AddressHelper?entityID=" + entityID+"&amp;entityType=" + entityType+"&amp;addressType=" + addressType+"&amp;addressCateogry=" + addressCateogry;
}
function removeAddressTrue(attribExists){
	var proceed = 'true';
	if(attribExists){
		proceed = showUserChoiceMessage('MSGJ50217', '');
	}else{
		proceed = showUserChoiceMessage('MSG045', 'MSG_LOROW');
	}
	if(attribExists && proceed){
		for (i=0; i < document.all.AdrRecordSet.rows.length ; i++){
		    var row_bgcolor = document.all.AdrRecordSet.rows(i).className;
		    if ( row_bgcolor == 'rowHighLighted'){
			// Tracker ID: 135125: XMLEncoding Changes STARTS
			if(boName=='CorporateBO'){
				delAddrtypes[delAddrtypes.length]= document.all.AdrRecordSet.rows(i).getAttribute("CorporateBO.Address.addressCategory");
			}
			else if(boName=='CorporateModBO'){
				delAddrtypes[delAddrtypes.length]= document.all.AdrRecordSet.rows(i).getAttribute("CorporateModBO.Address.addressCategory");
			}
			// Tracker ID: 135125: XMLEncoding Changes ENDS
		    }
		}
	}
	if(proceed){
		for (i=0; i < document.all.AdrRecordSet.rows.length ; i++){
		    var row_bgcolor = document.all.AdrRecordSet.rows(i).className;
		    if ( row_bgcolor == 'rowHighLighted'){
			// Tracker ID: 135125: XMLEncoding Changes ENDS
			if(boName=='CorporateBO'){
				EduDetURL = document.all.AdrRecordSet.rows(i).getAttribute("CorporateBO.Address.url_");
			}
			else if(boName=='CorporateModBO'){
				EduDetURL = document.all.AdrRecordSet.rows(i).getAttribute("CorporateModBO.Address.url_");
			}
			// Tracker ID: 135125: XMLEncoding Changes ENDS
				noOfAttachURLs = adr_URL.length;
				var deleteAlreadyExistingEduDet = true;
				for(r=0; r< noOfAttachURLs; r++) {
				    if(adr_URL[r] == EduDetURL){
			//Changes for Ticket id 418590 and Tracker id 254334 Recon for call id 215081 starts
					if(adr_Status[r] != "New" && adr_Status[r] != "Edit") {
					    deleteAlreadyExistingEduDet = false;
					}
					adr_URL[r] = null;
					ad_address_type[r]=null;
					adr_Status[r] = "Remove";
					ad_start_date[r]="";
			//Changes for Ticket id 418590 and Tracker id 254334 Recon for call id 215081 ends
					addrID = ad_addrID[r];
					break;
				    }
				}
				document.all.AdrRecordSet.deleteRow(i);
				if( (EduDetURL == null) || (EduDetURL == 'undefined')) {
				    EduDetURL= "";
				}
				if(deleteAlreadyExistingEduDet) {
				    adr_detachedURLs[adr_detachedURLs.length] = addrID;
				}
			}
		}
        }else{
		return;
	}
}
function editAddressDetails(entitytype)
{
//Changes for Recon:373373 and call id :372227 STARTS
var AccessOwnerGroup = document.frm2.accessOwnerGroup.value;
//Changes for Recon:373373 and call id :372227  ENDS
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
        		// Tracker ID: 135125: XMLEncoding Changes STARTS
            	if(boName=='CorporateBO'){
			EduDetURL = tempTableRow.getAttribute("CorporateBO.Address.url_");
			var addrID = '';
            	}
            	else if(boName=='CorporateModBO'){
 			EduDetURL = tempTableRow.getAttribute("CorporateModBO.Address.url_");
			var addrID = '';
            	}
				// Tracker ID: 135125: XMLEncoding Changes ENDS
        var i = 0;
    	var x = adr_URL.length;
    	for(i=0; i < x; i++){
   		if(adr_URL[i] == EduDetURL) {
           		break;
            }
            else{

            }
        }
        		// Tracker ID: 135125: XMLEncoding Changes STARTS
            	if(boName=='CorporateBO'){
			for (j=2; j < document.all.AdrRecordSet.rows.length; j++){
			    var docURL = document.all.AdrRecordSet.rows(j).getAttribute("CorporateBO.Address.url_");
			    if(docURL == EduDetURL) {
				break;
			    }
			}
            	}
            	else if(boName=='CorporateModBO'){
 			for (j=2; j < document.all.AdrRecordSet.rows.length; j++){
			    var docURL = document.all.AdrRecordSet.rows(j).getAttribute("CorporateModBO.Address.url_");
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
/*Tracker 159095 : Sonali  end of changes*/
      		/* if(ad_PreferredFormat[i] != "FREE_TEXT_FORMAT"){
	        document.frm2.country.value = srmEscape(ad_country[i], '^', escChars) +"|#"+srmEscape(ad_country_cat[i], '^', escChars);
		    SetCookie("CorporateBO.Address.country",ad_country_cat[i]);
			document.frm2.city.value = srmEscape(ad_city[i], '^', escChars) +"|#"+srmEscape(ad_city_cat[i], '^', escChars);
	        SetCookie("CorporateBO.Address.city",ad_city_cat[i]);
		    document.frm2.state.value = srmEscape(ad_state[i], '^', escChars) +"|#"+srmEscape(ad_state_cat[i], '^', escChars);
			SetCookie("CorporateBO.Address.state",ad_state_cat[i]);
		//}
		//else
		{
	       // document.frm2.country.value = "";
		//	document.frm2.city.value = "";
		//	document.frm2.state.value = "";
		//} */
		document.frm2.country.value = srmEscape(ad_country[i], '^', escChars) +"|#"+srmEscape(ad_country_cat[i], '^', escChars);
		SetCookie("CorporateBO.Address.country",ad_country_cat[i]);
		document.frm2.city.value = srmEscape(ad_city[i], '^', escChars) +"|#"+srmEscape(ad_city_cat[i], '^', escChars);
		SetCookie("CorporateBO.Address.city",ad_city_cat[i]);
		document.frm2.state.value = srmEscape(ad_state[i], '^', escChars) +"|#"+srmEscape(ad_state_cat[i], '^', escChars);
		SetCookie("CorporateBO.Address.state",ad_state_cat[i]);
		document.frm2.start_date.value = srmEscape(ad_start_date[i], '^', escChars);
		document.frm2.zip.value = srmEscape(ad_zip[i], '^', escChars);
		/* Ticket 301594 : Changes for tracker 181373 starts : Reverted */
		document.frm2.end_date.value = srmEscape(ad_end_date[i], '^', escChars);
		/*  Ticket 301594 : Changes for tracker 181373 ends : Reverted*/
		document.frm2.LastUpdate_Date.value = srmEscape(ad_LastUpdate_Date[i], '^', escChars);
		document.frm2.addrID.value = srmEscape(ad_addrID[i], '^', escChars);
/*Tracker 159095 : Sonali begin of changes*/
		document.frm2.streetno.value = srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
		document.frm2.town.value = srmEscapeAddr(ad_town[i], '^', escCharsAddr);
		document.frm2.locality.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
		document.frm2.domicile.value = srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
/*Tracker 159095 : Sonali  end of changes*/
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
		document.frm2.IsAddressVerified.value = srmEscape(ad_IsAddressVerified[i], '^', escChars);
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
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
/*Tracker 159095 : Sonali end of changes*/
// changes for Tracker ID 456637 - TOL ID 455246
document.frm2.vAddTypeLT.value = srmEscapeAddr(ad_vAddTypeLT[i], '^', escCharsAddr);
// changes for Tracker ID 456637 - TOL ID 455246
		
/*Tracker 159095 : Sonali begin of changes*/		
		document.frm2.website.value = srmEscapeAddr(ad_website[i], '^', escCharsAddr);
		document.frm2.mailstop.value = srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
		document.frm2.streetname.value = srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
		document.frm2.suburb.value = srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
/*Tracker 159095 : Sonali  end of changes*/
		
		document.frm2.swiftcode.value 		= srmEscape(ad_swiftcode[i], '^', escChars);
		document.frm2.IsAddressProofRcvd.value = srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
        recordIndex = i;
        /* Tracker: 108382: Changes for centering popup */
        windowAlign();
        EduDetDetailsEdit = window.open('../common/html/SSOblank.html', 'AddrDetails', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
        /* Tracker: 108382: End of Changes */
        document.frm2.target = 'AddrDetails'
        if (entitytype == 'NonCustomer') {
        	document.frm2.action = '../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?entitytype=NonCustomer&AccessOwnerGroup='+AccessOwnerGroup;
        }
        else {
        document.frm2.action = '../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?AccessOwnerGroup='+AccessOwnerGroup;
        }
        document.frm2.submit();
    }catch(e){
	DebugMessage(e.message);
	}
}
function copyAddressdetails(entitytype)
{
try{
        updateEduDet = false;
        var EduDetURL = '';
        var addrID = '';
//Changes for 442528 start :
		copyFlag=true;
//Changes for 442528 end:
        if(CheckForSelectedRow(document.getElementsByName('AdrRecordSet'))=="false"){
             showUserMessage("MSGCOPY", new String("Address"));
            return;
        }
        for (k=0; k < document.all.AdrRecordSet.rows.length ; k++){
        var row_bgcolor = document.all.AdrRecordSet.rows(k).className;
        if ( row_bgcolor == 'rowHighLighted')
            {
				// Tracker ID: 135125: XMLEncoding Changes STARTS
            	if(boName=='CorporateBO'){
    		        EduDetURL = document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.url_");
            	}
            	else if(boName=='CorporateModBO'){
           		EduDetURL = document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.url_");
            	}
				// Tracker ID: 135125: XMLEncoding Changes ENDS
            var i = 0;
	            var x = adr_URL.length;
	            for(i=0; i < x; i++){
	                if(adr_URL[i] == EduDetURL) {
	                    break;
	                }
	                else{
	                }
	            }
				// Tracker ID: 135125: XMLEncoding Changes STARTS
            	if(boName=='CorporateBO'){
	            for (j=2; j < document.all.AdrRecordSet.rows.length; j++){
	                var docURL = document.all.AdrRecordSet.rows(j).getAttribute("CorporateBO.Address.url_");
	                if(docURL == EduDetURL) {
	                    break;
	                }
	            }
            	}
            	else if(boName=='CorporateModBO'){
 	            for (j=2; j < document.all.AdrRecordSet.rows.length; j++){
	                var docURL = document.all.AdrRecordSet.rows(j).getAttribute("CorporateModBO.Address.url_");
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
		/*Tracker 159095 : Sonali  end of changes*/
			document.frm2.country.value = srmEscape(ad_country[i], '^', escChars) +"|#"+srmEscape(ad_country_cat[i], '^', escChars);
			SetCookie("CorporateBO.Address.country",ad_country_cat[i]);
			document.frm2.city.value = srmEscape(ad_city[i], '^', escChars) +"|#"+srmEscape(ad_city_cat[i], '^', escChars);
			SetCookie("CorporateBO.Address.city",ad_city_cat[i]);
			document.frm2.state.value = srmEscape(ad_state[i], '^', escChars) +"|#"+srmEscape(ad_state_cat[i], '^', escChars);
			SetCookie("CorporateBO.Address.state",ad_state_cat[i]);
			document.frm2.start_date.value = srmEscape(ad_start_date[i], '^', escChars);
			document.frm2.zip.value = srmEscape(ad_zip[i], '^', escChars);
			document.frm2.end_date.value = '';
			document.frm2.LastUpdate_Date.value = srmEscape(ad_LastUpdate_Date[i], '^', escChars);
			/*changes done for ticket id:323212 Begin */
			document.frm2.addrID.value = "";
			/*changes done for ticket id:323212 End */
		/*Tracker 159095 : Sonali begin of changes*/
			document.frm2.streetno.value = srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
			document.frm2.town.value = srmEscapeAddr(ad_town[i], '^', escCharsAddr);
			document.frm2.locality.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
			document.frm2.domicile.value = srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
		/*Tracker 159095 : Sonali  end of changes*/
			/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			document.frm2.IsAddressVerified.value = srmEscape(ad_IsAddressVerified[i], '^', escChars);
            /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
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
			document.frm2.website.value = srmEscapeAddr(ad_website[i], '^', escCharsAddr);
			document.frm2.mailstop.value = srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
			document.frm2.streetname.value = srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
			document.frm2.suburb.value = srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
		/*Tracker 159095 : Sonali  end of changes*/

// changes for Tracker ID 456637 - TOL ID 455246
document.frm2.vAddTypeLT.value = srmEscapeAddr(ad_vAddTypeLT[i], '^', escCharsAddr);
// changes for Tracker ID 456637 - TOL ID 455246
			//document.frm2.swiftcode.value 		= srmEscape(ad_swiftcode[i], '^', escChars);
			document.frm2.IsAddressProofRcvd.value = srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
	            recordIndex = i;
	            /* Tracker: 108382: Changes for centering popup */
        	    windowAlign();
	            EduDetDetailsEdit = window.open('../common/html/SSOblank.html', 'AdrDetails', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
	            /* Tracker: 108382: End of Changes */
	            document.frm2.target = 'AdrDetails'
	            if (entitytype == 'NonCustomer') {
	           	document.frm2.action = '../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?IsFormatReadOnly=Yes&entitytype=NonCustomer';
	           }
	           else {
	            document.frm2.action = '../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?IsFormatReadOnly=Yes';
	           }
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
//Changes for CRM10202Beta Ticket 321361 : End
//Changes for 434549 start :
    copyFlag=false;	
//Changes for 434549 end :
    if (AddrDetails.length==37) {
    //tracker 116162
	var entitytype='"NonCustomer"';
    }
    address_type                = AddrDetails[0];
    houseno                     = AddrDetails[1];
    premiseno                   = AddrDetails[2];
    end_date                    = AddrDetails[3];
    start_date                  = AddrDetails[4];
    city                        = AddrDetails[5];
    country                     = AddrDetails[6];
    state                       = AddrDetails[7];
    zip                         = AddrDetails[8];
    building			= AddrDetails[9];
//Changes for 442528 start :
	if(!copyFlag){
    addrID			= AddrDetails[10];
	}else{
	addrID = '';
	copyFlag=false;
	}
	 // addrID			= AddrDetails[10];
//Changes for 442528 end :
    streetno			= AddrDetails[11];
    locality			= AddrDetails[12];
    town			= AddrDetails[13];
    domicile			= AddrDetails[14];
    streetname			= AddrDetails[15];
    suburb                      = AddrDetails[16];
     LastUpdate_Date		= AddrDetails[35];
     updateflag			= AddrDetails[36];
    /* Changes for Tracker # 100035 -- start */
    IsAddressProofRcvd 		= AddrDetails[38];
    /* Changes for Tracker # 100035 end */
    eduURL                      = address_type + start_date;
	preferredFormat = AddrDetails[20];
	holdMailReason = AddrDetails[21];
	businessCenter = AddrDetails[22];
	holdMailInitiatedBy = AddrDetails[23];
	holdMailFlag = AddrDetails[24];
      /* changes for tracker id 173129 begins */
      // Tracker 180411 Hold Mail Changes : Begin
	if(holdMailFlag == true || holdMailFlag=='Y' || holdMailFlag=='y')
	{
		holdMailFlag = "Y";
	}
	else
	{
		holdMailFlag = "N";
	}
	// Tracker 180411 Hold Mail Changes : End
	
     /* changes for tracker id 173129 ends */

	addressLine1 = AddrDetails[25];
	addressLine2 = AddrDetails[26];
	addressLine3 = AddrDetails[27];
	freeTextLabel = AddrDetails[28];
	name = AddrDetails[39];
	
// changes for Tracker ID 456637 - TOL ID 455246
	vAddTypeLT = AddrDetails[41];
// changes for Tracker ID 456637 - TOL ID 455246
	/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
	IsAddressVerified = AddrDetails[40];
	/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
	if(freeTextLabel==undefined || freeTextLabel=="undefined")
	{
	freeTextLabel="";
	}
    mailstop		        = AddrDetails[29];
    website			= AddrDetails[30];
	swiftcode = AddrDetails[31];
	city_cat = AddrDetails[32];
	state_cat = AddrDetails[33];
	country_cat = AddrDetails[34];
    var uid = null;
    var alreadyAdded = false;
	if(!addressTypeFlag)//added from sorting
	{
    	city_cat = GetCookie('CorporateBO.Address.city');
    	state_cat = GetCookie('CorporateBO.Address.state');
    	country_cat = GetCookie('CorporateBO.Address.country');
	}
    if(!alreadyAdded){
        var noOfexistingURLs = adr_URL.length;
        for(var x = 0; x < noOfexistingURLs ; x++) {
            //here compare with combination of Inst and Qualification
            if(eduURL == adr_URL[x]) {
                alreadyAdded = true;
                if(updateEduDet){
                    if(x != recordIndex){
                        updateEduDet = false;
                    }
                }
                break;
            }
        }
        if(updateEduDet){
		alreadyAdded = true;
		ad_addrID[recordIndex] = addrID;
		ad_address_type[recordIndex] = address_type;
		ad_houseno[recordIndex] = houseno;
		ad_premiseno[recordIndex] = premiseno;
		ad_end_date[recordIndex] = end_date;
		ad_LastUpdate_Date[recordIndex] = LastUpdate_Date;
		ad_LastUpdate_Flag[recordIndex] =updateflag;
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
		ad_PreferredFormat[recordIndex] = preferredFormat;
		ad_HoldMailReason[recordIndex] = holdMailReason;
		ad_BusinessCenter[recordIndex] = businessCenter;
		ad_HoldMailInitiatedBy[recordIndex] = holdMailInitiatedBy;
		ad_HoldMailFlag[recordIndex] =  holdMailFlag;
		ad_AddressLine1[recordIndex] = addressLine1;
		ad_AddressLine2[recordIndex] = addressLine2;
		ad_AddressLine3[recordIndex] = addressLine3;
		ad_FreeTextLabel[recordIndex] = freeTextLabel;
		ad_website[recordIndex] = website;
		ad_mailstop[recordIndex] = mailstop;
		ad_streetname[recordIndex] = streetname;
		ad_suburb[recordIndex] = suburb;
// changes for Tracker ID 456637 - TOL ID 455246
		ad_vAddTypeLT[recordIndex] = vAddTypeLT;
// changes for Tracker ID 456637 - TOL ID 455246
		ad_swiftcode[recordIndex]	= swiftcode;
		adr_URL[recordIndex] = eduURL;
		ad_IsAddressProofRcvd[recordIndex] = IsAddressProofRcvd;
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
        ad_IsAddressVerified[recordIndex] = IsAddressVerified;
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
		adr_Status[recordIndex] = "Edit";
        }
    }
    if(!alreadyAdded) {
    		adcount=adr_URL.length;
            	ad_address_type[adcount] = address_type;
		ad_houseno[adcount] 	= houseno;
		ad_premiseno[adcount] 	= premiseno;
		ad_end_date[adcount] 	= end_date;
		ad_start_date[adcount] 	= start_date;
		ad_zip[adcount] 	= zip;
		ad_state[adcount] 	= state;
		ad_state_cat[adcount] 	= state_cat;
		ad_city[adcount] 	= city;
		ad_city_cat[adcount] 	= city_cat;
		ad_country[adcount] 	= country;
		ad_country_cat[adcount] = country_cat;
		ad_building[adcount] 	= building;
		ad_streetno[adcount] 	= streetno;
		ad_town[adcount] 	= town;
		ad_locality[adcount] 	= locality;
		ad_domicile[adcount] 	= domicile;
		ad_PreferredFormat[adcount] 	= preferredFormat;
		ad_HoldMailReason[adcount] 	= holdMailReason;
		ad_BusinessCenter[adcount] 	= businessCenter;
		ad_HoldMailInitiatedBy[adcount] = holdMailInitiatedBy;
		ad_HoldMailFlag[adcount] 	= holdMailFlag;
		ad_AddressLine1[adcount] 	= addressLine1;
		ad_AddressLine2[adcount] 	= addressLine2;
		ad_AddressLine3[adcount] 	= addressLine3;
		ad_FreeTextLabel[adcount] 	= freeTextLabel;
		ad_website[adcount] 		= website;
		ad_mailstop[adcount] 		= mailstop;
		ad_streetname[adcount] 		= streetname;
		ad_suburb[adcount] 		= suburb;
		ad_LastUpdate_Date[adcount] = LastUpdate_Date;
		ad_LastUpdate_Flag[adcount] = updateflag;
		ad_swiftcode[ad_swiftcode.length]		= swiftcode;
// changes for Tracker ID 456637 - TOL ID 455246
		ad_vAddTypeLT[adcount] = vAddTypeLT;
// changes for Tracker ID 456637 - TOL ID 455246
		adr_Status[adcount] = "New";
		adr_URL[adcount] = eduURL;
		ad_IsAddressProofRcvd[adcount] 		= IsAddressProofRcvd;
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
		ad_IsAddressVerified[adcount] = IsAddressVerified;
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
		if(addressTypeFlag)
		{
			ad_addrID[adcount] = addrID;
		}
		else
		{
		ad_addrID[adcount] = "";
    }
    }
  
  /* Change for tracker 188232 : BEGIN */
   var add_category_ML = "";
   var add_city_ML = "";
   var add_state_ML = "";
   var add_country_ML = "";
   if(addressTypeFlag)
   {
		add_city_ML =	city_cat;
		add_state_ML = state_cat;
		add_country_ML = country_cat;
		add_category_ML=address_type;
   }
   else
   {
		add_city_ML =	GetCookie('CorporateBO.Address.city');
		add_state_ML = GetCookie('CorporateBO.Address.state');
		add_country_ML = GetCookie('CorporateBO.Address.country');
		add_category_ML = GetCookie('CorporateBO.Address.addressCategory');
   }
   /* Change for tracker 188232 : END */
	if(preferredFormat == "FREE_TEXT_FORMAT"){
		/*add_city_ML =  GetCookie('CorporateBO.Address.city');
		add_state_ML = GetCookie('CorporateBO.Address.state');		
		add_country_ML=GetCookie('CorporateBO.Address.country');*/
		
		
		if(addressTypeFlag)
		   {
				add_city_ML = city_cat;
				add_state_ML =  state_cat;
				add_country_ML = country_cat;
		   }
		   else
		   {
				add_city_ML =	GetCookie('CorporateBO.Address.city');
				add_state_ML = GetCookie('CorporateBO.Address.state');
				add_country_ML = GetCookie('CorporateBO.Address.country');
   		   }
		
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
	/*	add_city_ML = "";
		add_state_ML = "";
		add_country_ML = "";*/
	}
	/* CIF PhoneEmail Changes : End*/

	if(address_type!="Swift"){
    if (!updateEduDet)
    {
   
   /* Change for tracker 188232 : BEGIN */
    if(addressTypeFlag)
    	{
    		add_category_ML = address_type;
	}
	/* Change for tracker 188232 : END */
       
        if(alreadyAdded) {
//Changes for CRM10202Beta Ticket 321361 : Begin
        updateEduDet=tempUpdate;
//Changes for CRM10202Beta Ticket 321361 : End


                showUserMessage("MSG_CONTACT_IDEXISTS",null);
            return;
        }
        oNewNode = document.createElement("TR");
        if(TBODY_AdrRecordSet.childNodes.length % 2 == 0) {
            oNewNode.setAttribute("className", "color1");
        } else {
            oNewNode.setAttribute("className", "color2");
        }
        TBODY_AdrRecordSet.appendChild(oNewNode);
			// Tracker ID: 135125: XMLEncoding Changes STARTS
            	if(boName=='CorporateBO'){
			oNewNode.setAttribute("CorporateBO.Address.addressCategory", address_type);
			oNewNode.setAttribute("CorporateBO.Address.Start_Date", start_date);
			oNewNode.setAttribute("CorporateBO.Address.country", country);
			oNewNode.setAttribute("CorporateBO.Address.state", state);
			oNewNode.setAttribute("CorporateBO.Address.city", city);
			oNewNode.setAttribute("CorporateBO.Address.PreferredFormat", preferredFormat);
			oNewNode.setAttribute("CorporateBO.Address.HoldMailReason", holdMailReason);
			oNewNode.setAttribute("CorporateBO.Address.BusinessCenter", businessCenter);
			oNewNode.setAttribute("CorporateBO.Address.HoldMailInitiatedBy", holdMailInitiatedBy);
			oNewNode.setAttribute("CorporateBO.Address.FreeTextLabel", freeTextLabel);
			oNewNode.setAttribute("CorporateBO.Address.HoldMailFlag", holdMailFlag);
			oNewNode.setAttribute("CorporateBO.Address.mailStop", mailstop);
			oNewNode.setAttribute("CorporateBO.Address.URL", website);
			oNewNode.setAttribute("CorporateBO.Address.house_no", houseno);
			oNewNode.setAttribute("CorporateBO.Address.premise_name", premiseno);
			oNewNode.setAttribute("CorporateBO.Address.building_level", building);
			oNewNode.setAttribute("CorporateBO.Address.street_no", streetno);
			oNewNode.setAttribute("CorporateBO.Address.suburb", suburb);
			oNewNode.setAttribute("CorporateBO.Address.street_name", streetname);
			oNewNode.setAttribute("CorporateBO.Address.locality_name", locality);
			oNewNode.setAttribute("CorporateBO.Address.town", town);
			oNewNode.setAttribute("CorporateBO.Address.zip", zip);
			oNewNode.setAttribute("CorporateBO.Address.domicile", domicile);
			oNewNode.setAttribute("CorporateBO.Address.End_Date", end_date);
			oNewNode.setAttribute("CorporateBO.Address.website", website);
			oNewNode.setAttribute("CorporateBO.Address.mailStop", mailstop);
			oNewNode.setAttribute("CorporateBO.Address.Swift_Code", swiftcode);
            	}
            	else if(boName=='CorporateModBO'){
 			oNewNode.setAttribute("CorporateModBO.Address.addressCategory", address_type);
			oNewNode.setAttribute("CorporateModBO.Address.Start_Date", start_date);
			oNewNode.setAttribute("CorporateModBO.Address.country", country);
			oNewNode.setAttribute("CorporateModBO.Address.state", state);
			oNewNode.setAttribute("CorporateModBO.Address.city", city);
			oNewNode.setAttribute("CorporateModBO.Address.PreferredFormat", preferredFormat);
			oNewNode.setAttribute("CorporateModBO.Address.HoldMailReason", holdMailReason);
			oNewNode.setAttribute("CorporateModBO.Address.BusinessCenter", businessCenter);
			oNewNode.setAttribute("CorporateModBO.Address.HoldMailInitiatedBy", holdMailInitiatedBy);
			oNewNode.setAttribute("CorporateModBO.Address.FreeTextLabel", freeTextLabel);
			oNewNode.setAttribute("CorporateModBO.Address.HoldMailFlag", holdMailFlag);
			oNewNode.setAttribute("CorporateModBO.Address.mailStop", mailstop);
			oNewNode.setAttribute("CorporateModBO.Address.URL", website);
			oNewNode.setAttribute("CorporateModBO.Address.house_no", houseno);
			oNewNode.setAttribute("CorporateModBO.Address.premise_name", premiseno);
			oNewNode.setAttribute("CorporateModBO.Address.building_level", building);
			oNewNode.setAttribute("CorporateModBO.Address.street_no", streetno);
			oNewNode.setAttribute("CorporateModBO.Address.suburb", suburb);
			oNewNode.setAttribute("CorporateModBO.Address.street_name", streetname);
			oNewNode.setAttribute("CorporateModBO.Address.locality_name", locality);
			oNewNode.setAttribute("CorporateModBO.Address.town", town);
			oNewNode.setAttribute("CorporateModBO.Address.zip", zip);
			oNewNode.setAttribute("CorporateModBO.Address.domicile", domicile);
			oNewNode.setAttribute("CorporateModBO.Address.End_Date", end_date);
			oNewNode.setAttribute("CorporateModBO.Address.website", website);
			oNewNode.setAttribute("CorporateModBO.Address.mailStop", mailstop);
			oNewNode.setAttribute("CorporateModBO.Address.Swift_Code", swiftcode);
            	}
			// Tracker ID: 135125: XMLEncoding Changes ENDS
	
	/* Change for tracker 188232 : BEGIN */
	/*if(addressTypeFlag)
	{
		add_category_ML = address_type;
	}*/
	/* Change for tracker 188232 : END */
	var tdNode = document.createElement("TD");
	oNewNode.appendChild(tdNode);
	tdNode.innerHTML =  "<font class='fntColData'>" + vAddTypeLT+ "</font>";
	var tdNode1 = document.createElement("TD");
	oNewNode.appendChild(tdNode1);
	tdNode1.innerHTML =  "<font class='fntColData'>" + freeTextLabel+ "</font>";
	var tdNode2 = document.createElement("TD");
	/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
	//id has been set for the date field such dat "date" phrase has 0 index and rowindex has been appended to make id unique for ever row
	var idIndex = document.all.AdrRecordSet.rows.length;
	tdNode2.setAttribute("id","DATE1CorpCustAddressDetail"+idIndex);
	if((start_date!= '') && (start_date != undefined))
	{
		//date converted acc to the present calendar type before displaing in the multirec 
		start_date = changeDateAccToPresentCalendar(start_date);
	}
	/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
	oNewNode.appendChild(tdNode2);
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
	// Fix for ticket 322267 and 322705 begins
	tdNode6.innerHTML = "<INPUT class='sbttn' TYPE = 'button' value = '...' onclick='editAddressDetails(" + entitytype + ")' IsEnabledInReadMode='true'>";
	// Fix for ticket 322267 and 322705 ends
    oNewNode.attachEvent("onclick", call);
    totalProdRecortds = document.all.AdrRecordSet.rows.length;
				// Tracker ID: 135125: XMLEncoding Changes STARTS
            	if(boName=='CorporateBO'){
		    document.all.AdrRecordSet.rows(totalProdRecortds - 1).setAttribute("CorporateBO.Address.url_", eduURL);
            	}
            	else if(boName=='CorporateModBO'){
 		    document.all.AdrRecordSet.rows(totalProdRecortds - 1).setAttribute("CorporateModBO.Address.url_", eduURL);
            	}
	//updateAllHoldMailInfo(address_type,eduURL);
    }
    else
    {
	    

	     /*Ticket ID 234886 CHANGES BEGIN*/
	       
	     add_city_ML =	GetCookie('CorporateBO.Address.city');
	     add_state_ML = GetCookie('CorporateBO.Address.state');
	     add_country_ML = GetCookie('CorporateBO.Address.country');
	     
	     
	    if(add_category_ML == null){
		add_category_ML = address_type;
	     }
	     /*Ticket ID 234886 CHANGES END*/

    currEduTableRow.childNodes(0).innerHTML="<font class='fntColData'>" + vAddTypeLT + "</font>";
	currEduTableRow.childNodes(1).innerHTML="<font class='fntColData'>" + freeTextLabel + "</font>";
	/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
	if((start_date!= '') && (start_date != undefined))
	{
		//date converted acc to the present calendar type before displaing in the multirec 
		start_date = changeDateAccToPresentCalendar(start_date);
	}
	/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
	currEduTableRow.childNodes(2).innerHTML="<font class='fntColData'>" + start_date + "</font>";
	currEduTableRow.childNodes(3).innerHTML="<font class='fntColData'>" + add_city_ML + "</font>";
	currEduTableRow.childNodes(4).innerHTML="<font class='fntColData'>" + add_state_ML + "</font>";
	currEduTableRow.childNodes(5).innerHTML="<font class='fntColData'>" + add_country_ML + "</font>";
	updateEduDet = false;
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName=='CorporateBO'){
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateBO.Address.addressCategory", address_type);
	    document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateBO.Address.FreeTextLabel", freeTextLabel);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateBO.Address.Start_Date", start_date);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateBO.Address.country", country);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateBO.Address.state", state);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateBO.Address.city", city);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateBO.Address.url_", eduURL);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateBO.Address.PreferredFormat", preferredFormat);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateBO.Address.HoldMailFlag",holdMailFlag);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateBO.Address.HoldMailReason",holdMailReason);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateBO.Address.BusinessCenter",businessCenter);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
	}
	else if(boName=='CorporateModBO'){
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateModBO.Address.addressCategory", address_type);
	    document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateModBO.Address.FreeTextLabel", freeTextLabel);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateModBO.Address.Start_Date", start_date);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateModBO.Address.country", country);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateModBO.Address.state", state);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateModBO.Address.city", city);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateModBO.Address.url_", eduURL);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateModBO.Address.PreferredFormat", preferredFormat);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateModBO.Address.HoldMailFlag",holdMailFlag);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateModBO.Address.HoldMailReason",holdMailReason);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateModBO.Address.BusinessCenter",businessCenter);
		document.all.AdrRecordSet.rows(eduRecordIndex).setAttribute("CorporateModBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS
	//updateAllHoldMailInfo(address_type,eduURL);
	/* CIF PhoneEmail Changes : End*/
	 }
	}else{
		
		SwiftAddressDetails = name+"|"+addressLine1+"|"+addressLine2+"|"+addressLine3;
		

	} 	    



}catch(e){alert('Err in addaddressdet '+e.description);
DebugMessage(e.description);
}
    return ("true");
}
/*function updateAllHoldMailInfo(address_type,eduURL)
{
	var recordSetSize =  document.all.AdrRecordSet.rows.length;
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName=='CorporateBO'){
		for(var k=0 ;k<recordSetSize; k++)
		{
		if((eduURL!="" ||eduURL != null) && eduURL == document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.url_"))
			{
				document.all.AdrRecordSet.rows(k).setAttribute("CorporateBO.Address.HoldMailFlag",holdMailFlag);
				document.all.AdrRecordSet.rows(k).setAttribute("CorporateBO.Address.HoldMailReason",holdMailReason);
				document.all.AdrRecordSet.rows(k).setAttribute("CorporateBO.Address.BusinessCenter",businessCenter);
				document.all.AdrRecordSet.rows(k).setAttribute("CorporateBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
				ad_HoldMailReason[k] = holdMailReason;
				ad_BusinessCenter[k] = businessCenter;
				ad_HoldMailInitiatedBy[k] = holdMailInitiatedBy;
				ad_HoldMailFlag[k] = holdMailFlag;
			}
		}
	}
	else if(boName=='CorporateModBO'){
		for(var k=0 ;k<recordSetSize; k++)
		{
		if((eduURL!="" ||eduURL != null) && eduURL == document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.url_"))			
			{
				document.all.AdrRecordSet.rows(k).setAttribute("CorporateModBO.Address.HoldMailFlag",holdMailFlag);
				document.all.AdrRecordSet.rows(k).setAttribute("CorporateModBO.Address.HoldMailReason",holdMailReason);
				document.all.AdrRecordSet.rows(k).setAttribute("CorporateModBO.Address.BusinessCenter",businessCenter);
				document.all.AdrRecordSet.rows(k).setAttribute("CorporateModBO.Address.HoldMailInitiatedBy",holdMailInitiatedBy);
				ad_HoldMailReason[k] = holdMailReason;
				ad_BusinessCenter[k] = businessCenter;
				ad_HoldMailInitiatedBy[k] = holdMailInitiatedBy;
				ad_HoldMailFlag[k] = holdMailFlag;
			}
		}
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS
}*/
function populateHoldMailForAddressType(selectedAddressType)
{
		var recordSetSize =  document.all.AdrRecordSet.rows.length;
		var holdMailValues = new Array();
				// Tracker ID: 135125: XMLEncoding Changes STARTS
            	if(boName=='CorporateBO'){
				for(var j=0 ; j < recordSetSize; j++)
			{
				if(selectedAddressType == document.all.AdrRecordSet.rows(j).getAttribute("CorporateBO.Address.addressCategory"))
				{
					holdMailValues[0] = document.all.AdrRecordSet.rows(j).getAttribute("CorporateBO.Address.HoldMailFlag");
					holdMailValues[1] = document.all.AdrRecordSet.rows(j).getAttribute("CorporateBO.Address.HoldMailInitiatedBy");
					holdMailValues[2] = document.all.AdrRecordSet.rows(j).getAttribute("CorporateBO.Address.BusinessCenter");
					holdMailValues[3] = document.all.AdrRecordSet.rows(j).getAttribute("CorporateBO.Address.HoldMailReason");
					return holdMailValues;
				}
			}
            	}
            	else if(boName=='CorporateModBO'){
 			for(var j=0 ; j < recordSetSize; j++)
			{
				if(selectedAddressType == document.all.AdrRecordSet.rows(j).getAttribute("CorporateModBO.Address.addressCategory"))
				{
					holdMailValues[0] = document.all.AdrRecordSet.rows(j).getAttribute("CorporateModBO.Address.HoldMailFlag");
					holdMailValues[1] = document.all.AdrRecordSet.rows(j).getAttribute("CorporateModBO.Address.HoldMailInitiatedBy");
					holdMailValues[2] = document.all.AdrRecordSet.rows(j).getAttribute("CorporateModBO.Address.BusinessCenter");
					holdMailValues[3] = document.all.AdrRecordSet.rows(j).getAttribute("CorporateModBO.Address.HoldMailReason");
					return holdMailValues;
				}
			}
            	}
				// Tracker ID: 135125: XMLEncoding Changes ENDS
}


function onBCCodeSelect()
{
	try{
	document.getElementsByName("CorporateBO.Address.BusinessCenter")[0].value = getCookie("bCCode");
	}
	catch(e){
	setBCCodeValues ( bcCodeLookup , getCookie("bCCode"), getCookie("bCID"));
	}
}
function clearBCValue(type)
{
	document.getElementsByName(type)[0].value = "";
}
function addAddressdetails()
{
	/* Tracker # 98769 Begin of Changes */
	var getMCRequired=document.frm2.getMCRequired.value;
updateEduDet = false;
// Changes for call Id 442528 Start
copyFlag=false;
// Changes for call Id 442528 End
	var servletURL = "../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?mode=create&getMCRequired="+getMCRequired;
	/* Tracker # 98769 End of Changes */
//Tracker:108380: Changes for centering popup 
	wid=900;
	ht=460;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	// Ticket ID 349230 and tracker ID 213541 changes start ('Add Address' window issue)
	//docTypeNew = window.open(servletURL, '','height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+',location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
	adrWindow = window.open(servletURL, 'AddrDetails','height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+',location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
	adrWindow.name = 'AddrDetails';
	// Ticket ID 349230 and tracker ID 213541 changes end ('Add Address' window issue)
//Tracker:108380: End of Changes
}
function call(){
	for (i=0; i < document.all.AdrRecordSet.rows.length; i++) {
		var row_bgcolor=document.all.AdrRecordSet.rows(i).className;
		if ( row_bgcolor == 'rowHighLighted'){
			if ( i % 2 == 0) {
				document.all.AdrRecordSet.rows(i).className = 'color1';
			}
			else{
				document.all.AdrRecordSet.rows(i).className = 'color2';
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
var globalAddrDetails = new Array();





//Fix for ticket 297100 starts

function setStartDate(AddressID,strtDate)
{
if((AddressID == "" || AddressID =='undefined' || AddressID == null) && (strtDate == '' || strtDate =='undefined' || strtDate == null)){

			var locDate = '<xsl:value-of select="$dtCurr"/>';
			locDate = getCurrentDate();
			
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To convert start date to hijri - start*/
						
				if(calType=='H')
				{	
					locDate = convertGregToHij(locDate);
				}		
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To convert start date to hijri - END*/
			document.getElementsByName('3_CorporateBO.Address.Start_Date')[0].value = locDate;

		}
}
//Fix for ticket 297100 ends
