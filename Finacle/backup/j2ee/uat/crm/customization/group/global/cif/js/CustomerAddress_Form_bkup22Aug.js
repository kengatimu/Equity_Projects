
/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
/* including a file having conversion logic*/
/* START  Changes for Tracker # 209607*/
document.write('<script type="text/javascript" src="../common/js/Reduce_Form.js" language="javascript"></script>');
/* END  Changes for Tracker # 209607*/
/*ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/

/*****    Swift Address Changes Begin  *****/
    var SwiftName = "";
    var SwiftAddr1 = "";
    var SwiftAddr2 = "";
    var SwiftAddr3 = "";
    var SwiftAddressDetails = "";
/*****    Swift Address Changes Ends  *****/
    var ad_addrID           = new Array();
    var ad_address_type     = new Array();
    var ad_houseno          = new Array();
    var ad_premiseno        = new Array();
    var ad_end_date         = new Array();
    var ad_start_date       = new Array();
    var ad_state_cat        = new Array();
    var ad_state            = new Array();
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
    var ad_Email	    = new Array();
    var ad_website	    = new Array();
    var ad_mailstop	    = new Array();
    var ad_streetname	    = new Array();
    var ad_suburb	    = new Array();
    var ad_extension	    = new Array();
    /* Fix for Ticket ID 295893 */
     var address_type = "";
    /* Fix for Ticket ID 295893 */
    var st="";
    var edu_URL             = new Array();
	var ad_PreferredFormat = new Array();
	var ad_HoldMailReason = new Array();
	var ad_BusinessCenter = new Array();
	var ad_HoldMailInitiatedBy = new Array();
	var ad_HoldMailFlag = new Array();

/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
	var ad_IsAddressVerified = new Array();
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
	var ad_AddressLine1 = new Array();
	var ad_AddressLine2 = new Array();
	var ad_AddressLine3 = new Array();
	var ad_FreeTextLabel = new Array();
	var ad_PhoneOrEmail = new Array();
	/*Changes for Ticket id# 320401 begin*/
	var ad_IsAddressProofRcvd = new Array();
	/*Changes for Ticket id# 320401 ends*/
	/* Fix for Ticket ID 266328 */
	var ad_cellno_local = new Array();
	/* Fix for Ticket ID 266328 */
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
    var ad_cityCode	   = new Array();
    var ad_stateCode	   = new Array();
    var ad_cntryCode	   = new Array();
    var escChars = new Array(',');
/*Tracker 159095 : Sonali begin of changes*/
	var escCharsAddr = new Array('%');
/*Tracker 159095 : Sonali end of changes*/
    var updateEduDet = false;
    var editMode = false;
    var recordIndex = null;
	var phoneRecordIndex = null;
	var emailRecordIndex = null;
    var servletURL = null;
    var selTabId = parent.parent.parent.parent.frames(0).getSelectedTabId();
    var lookupFor = '';
 	var reserveCIFID="";
// KeyGeneration end
	var uniqueID="";


/*****    Swift Address Changes Begin  *****/

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

	SwiftAddressDetails=SwiftName+"|"+SwiftAddr1+"|"+SwiftAddr2+"|"+SwiftAddr3;
	return true;
}

/*****    End Of Swift Address changes  ******/
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
	}
}
// TrackerID 97346 changes begin
function check(Tab,setFlag){
		//Fix for callid:430243 starts
	try{
	document.getElementsByName("3_ContactBO.DOB")[0].disabled = false;//priya
	}
	catch(e){}
		//Fix for callid:430243 ends
	try{
	removePercentFormat('3_PsychographicBO.MiscellaneousInfo.dbFloat1');
	removePercentFormat('3_PsychographicBO.MiscellaneousInfo.dbFloat2');
	removePercentFormat('3_PsychographicBO.MiscellaneousInfo.dbFloat3');

	FormatBeforeSave_Number('3_PsychographicBO.MiscellaneousInfo.dbFloat4');
		}
		catch(e)
		{
	}
	if(setFlag == false) {
		noValidationMsg = true;
	}
	else {
		noValidationMsg = false;
	}
	//Fix for callid:430243 starts
	  validate= parent.parent.parent.parent.ValidateFormContents(document.frm2,true,noValidationMsg,Tab);
	document.getElementsByName("3_ContactBO.DOB")[0].disabled = true;//priya	  
	  return validate;
	  	//Fix for callid:430243 ends
	}

// TrackerID 97346 changes end
function save(saveFlag) {
//Tracker No 96447
//code added by Bharath
 	//var bank_id = document.getElementsByName("custBankId")[0].value
	if(bank_id == '54') {
		
		var cntry = "KE";
	}
	else {
		if(bank_id == '55') {
			var cntry = "TZ";
		}
		else {
			if(bank_id == '56') {
				var cntry = "UG";
			}
			else {
				if(bank_id == '50') {
					var cntry = "RW";
				}
				else {
					if(bank_id == '11') {
						var cntry = "SS";
					}
				}
			}
		}
	}

	
	if(document.getElementById("DemographicBO.Nationality").value == cntry)
	{
		/*try{
			if(document.getElementsByName("National Card Number.txt_ID")[0].value=="")
			{
				if(saveFlag == true)
				{
					showTabFortabEntityFieldDetails('tpageCustDetails');
					document.all.AddIdentificationDetails.focus();
					showMessage("Please add the Identification details for National Id Card");
					return "interactive";
				}
			}
		}catch(e) {alert(e.message);}*/
	}
	else
	{
		try{
			if(document.getElementsByName("Passport Number.txt_ID")[0].value=="")

			{
				if(saveFlag == true)
				{
					showTabFortabEntityFieldDetails('tpageCustDetails');
					document.all.AddIdentificationDetails.focus();
					showMessage(MSGJ0059);
					return "interactive";
				}
			}
		}catch(e) {alert(e.message);}
	}
	
	//Customer Onboarding Validation
	
	try{
	var Filter_uniqueId = getCookie('Filter_uniqueId');
	var Filter_documentcode = getCookie('Filter_documentcode');
	
	 //alert("Filter_uniqueId "+Filter_uniqueId);
	 //alert("Filter_documentcode "+Filter_documentcode);
	 
	 
	//var noOfEdoc = document.all.EDocRecordSet.rows.length - 2;
	
	//alert("noOfEdoc "+noOfEdoc);
	
	//for (i=2; i < document.all.EDocRecordSet.rows.length; i++)
	//{
	
	//alert("inside for loop");
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
	
	
	
	
	//var EntityDocID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.EntityDocumentID");
	
	
	
	
	if(!((Filter_uniqueId==nationalCardID) || (Filter_uniqueId==PANID) ||  (Filter_uniqueId==IDTypeR1ID)
				|| (Filter_uniqueId==IDTypeR2ID) || (Filter_uniqueId==IDTypeR3ID) || (Filter_uniqueId==IDTypeR4ID)
				|| (Filter_uniqueId==IDTypeR5ID) || (Filter_uniqueId==RationCardID) || (Filter_uniqueId==SSNID) 
				|| (Filter_uniqueId==TINID) ||  (Filter_uniqueId==electionCardID) || (Filter_uniqueId==DrivingLicenceID)
				|| (Filter_uniqueId==passportID)	
	))
	{
	   document.all.AddIdentificationDetails.focus();
	  alert("The identification document details do not match with the details entered in customer onboard menu");
	 
	  return "interactive";
	 
	
	}
	//}
	
	}
	
	catch(e)
	{}
	
	
	
	
	
	
	
	
	//Customer Onboarding Validation
	document.getElementsByName(boName + '.IntroducerSalutation')[0].disabled = false;
if(document.frm2.isMCEdited.value=="Y"){
		document.frm2.isMCEditedGeneral.value="Y";
	}
	if(!(document.frm2.hid_bodateCreated.value=='')){
		var introFlag=checkForIntroducer(document.frm2.hid_bodateCreated.value);
		if(introFlag){
			var tempMsg = getUserErrorMessage('MSGINTRO');
			if ( !(showConfirmMessage(tempMsg)))
			{
				showMessage(MSGJ0549);
				return "interactive";
			}
		}
	}
		//TRACKER NO : 92955 : BEGIN OF CHANGES
try{
		var dob = document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
		var fieldDob = document.getElementsByName("AccountBO.Cust_DOB")[0];
		var hasOtherErrors1 = "";
		for(var i=0;i<ad_start_date.length;i++){
			hasOtherErrors1 = Validate_againstDob(selTabId,ad_start_date[i],getLabel(fieldDob.Display),dob,MSGJ50388);
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
			if(hasOtherErrors){
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				return "interactive";
			}
	//TRACKER NO : 92955 : END OF CHANGES
	//TRACKER NO : 78621 : BEGIN OF CHANGES
	//TRACKER NO : 78621 : END OF CHANGES
		if(defAddress == "M")
			defAddress = "Mailing";
		else if(defAddress == "H")
			defAddress = "Home";
		else if(defAddress == "W")
			defAddress = "Work";
    // CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES **
    }catch(e){
}
/* Fix for issue 329227 : Check for special chars in Swift Code field */
var swift_code = '';
try{
			swift_code = document.getElementsByName('AccountBO.Cust_Swift_Code_Desc')[0].value;



			var sw_flag = validate_alphanumeric(document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0]);


			if(sw_flag==false){


				var tempList = new Array();
				/* Changed the label code as it is already used in sales module*/
				tempList[0] = MSGX50035;

				showUserMessage(MSG150,tempList);
				return "interactive";
			}

}
	catch(e) {}
/* End of changes : 329227 */
        try{
        customSave();
        }catch(e)
        { }
	try{
			if(saveFlag)
			{
			var  noOfCurrency = document.all.CurrencyDetRecordSet.rows.length;
			if(noOfCurrency==2)
			{
			//Changes for tracker ID 476857 start				
			//parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSGJ0553",""),TBODY_RecordSet.rows ,'NO_HLINK');
			document.all.ADD_CURRENCY.focus();
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSGJ0553","ADD_CURRENCY"),"ADD_CURRENCY",'HYPER_LINK');
			//Changes for tracker ID 476857 end				
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
			}
			
			
			var tempbankid=bank_id;
			
			try{
			if(tempbankid == 56)
			{
			
			var  noOfPhone = document.all.PhoneEmailRecordSet.rows.length;
			
			if(noOfPhone==2)
			  {
			   alert("Please add atleast one phone no details");
			   return "interactive";
			  }
			}
			}
			catch(e)
			{
			}
			}

			saveCurrencyDet();
		}
		catch(e)
		{
	}
    // CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES  **
	var hasOtherErrors = false;
	try{

	// CIF Changes shanmuga NRE - Start
		// Date validations
		
//	  	 validateDates();	commented for IDENTIFICATION DOCUMENT CHANGES
		// for Making the Identification type field enabled so that value can be retreived - Start
/*commented for IDENTIFICATION DOCUMENT CHANGES start
		document.getElementsByName("DemographicBO.MiscellaneousInfo.Type")[0].disabled=false;
commented for IDENTIFICATION DOCUMENT CHANGES end*/
        // CIF Changes shanmuga NRE - End
	 //CIF Changes Shanmuga: Formatting the amount field on save - start
	FormatBeforeSave("3_DemographicBO.Annual_Salary_Income");
	selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
}catch(e){}
	if(document.getElementsByName("3_AccountBO.Cust_DOB")[0].value!= '')
	     {
		 var primaryCustomerDOB = document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
		 //Changes for date issue Starts-379887
		 /*var dobMinor = new Date(primaryCustomerDOB.substring(6,10),
				primaryCustomerDOB.substring(3,5),
				primaryCustomerDOB.substring(0,2));*/
		 //Changes for date issue Ends-379887
		var CustomerMinor = document.getElementsByName(boName+".CustomerMinor")[0];
		//Changes for date issue Starts-379887
		 var yearDob = primaryCustomerDOB.substring(6,10);
		 var monthDob = primaryCustomerDOB.substring(3,5);
		 var dateDob = primaryCustomerDOB.substring(0,2);
		 //Changes for date issue Ends-379887
		 var isMinorContact = IsMinor(dateDob,monthDob,yearDob);
		 if(isMinorContact=='true')
		 {
			if(document.frm2.minorLoaded.value=="false"){
				parent.parent.parent.parent.messageFrm.addMessage(selTabId,MSG_MINOR_SEL,'AccountBO.CustomerMinor', '');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive";
			}
		 }else
		 {
			if (document.getElementsByName(boName+".CustomerMinor")[0].value=="Y")
			 {

			 parent.parent.parent.parent.messageFrm.addMessage(selTabId,MSG_MINOR_SEL,boName+'.CustomerMinor', '');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive";
			}
			 else

			 {
				 CustomerMinor.value="N";
			 }
		 }
	}
	var CustomerMinor = document.getElementsByName(boName+".CustomerMinor")[0];
		if(CustomerMinor.value != '')
		{
			if(document.getElementsByName("3_AccountBO.Cust_DOB")[0].value== '')
			{
				showMessage(MSGX0004);
				document.getElementsByName("3_AccountBO.Cust_DOB")[0].focus();
				return "interactive";
			}
		}
	//Changes for Ticket-->163101:End
	  if(document.getElementsByName("AccountBO.ACCOUNTKEY")[0].value == "") {
		   if(document.all.isAutoGenKey.value == 'true') {
		   document.getElementsByName("AccountBO.ACCOUNTKEY")[0].IsMandatory = 'N';
		   }
		}
	 		 if(saveFlag == true)
	 		 {
	 	 	     noValidationMsg = false;
	 	 	  }
	 	 	  else
	 	 	  {
	 	   		noValidationMsg = true;
	 	    	  }
	 		var chkStat ="true";
	 		if (chkStat != "true") {
	 		     return 'interactive';
	 	    	}
	 	if(saveFlag==false)
	 	{
	 		var validate = false;
	 		 if(document.getElementsByName("AccountBO.Cust_Last_Name")[0].value == "")
	 		 {
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
				 //changes for ticket id-701600 starts
	 		                         parent.parent.parent.parent.messageFrm.addMessage(selTabId,
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
	 	         if(saveFlag == false)
	 	         {
	 			document.frm2.saveFlag.value = 1;
	 		 }else{
	 			document.frm2.saveFlag.value = 0;
	 		}
	 if(document.getElementsByName(boName+".CustomerNREFlg")[0].value == "Y") {
		try {
			if(document.getElementsByName("AccountBO.DateOfBecomingNRE")[0].value == "") {
				parent.parent.parent.parent.messageFrm.addMessage(selTabId,
					getUserMessage("MSG086","MSG_NRE"),'AccountBO.DateOfBecomingNRE','HYPER_LINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);// CRM70t-ST :TRACKER# 79438 - CHANGES
				hasOtherErrors = "true";
			}
			else {
				if (Validate_againstCurrDate_loc(document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0],locDate) == "false")
				{
					parent.parent.parent.parent.messageFrm.addMessage(selTabId,
					getUserMessage("MSG_INVALIDNREDATE","MSG_NRE"),'AccountBO.DateOfBecomingNRE','HYPER_LINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);// CRM70t-ST :TRACKER# 79438 - CHANGES
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
	//Changes for ticket id 220098 end
				// CRM70t-ST :TRACKER# 79438 - CHANGES
				parent.parent.parent.parent.messageFrm.addMessage(selTabId,
				getUserMessage("MSG_NREDATE","MSG_NRE"),'AccountBO.DateOfBecomingNRE','HYPER_LINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);// CRM70t-ST :TRACKER# 79438 - CHANGES
				hasOtherErrors = "true";
			}
		}
		catch (e) {
		}
		}
	 if(document.getElementsByName(boName+".CustomerNREFlg")[0].value == "Y") {
		try {	/* Tracker ID 113276 - Turned Resident on Field is hidden from UI - Begin */
			/*if(document.getElementsByName("AccountBO.NREBecomingOrdDate")[0].value == "") {
				parent.parent.parent.parent.messageFrm.addMessage(selTabId,
					getUserMessage("MSG086","MSG_ORD"),'AccountBO.NREBecomingOrdDate','HYPER_LINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);// CRM70t-ST :TRACKER# 79438 - CHANGES
				hasOtherErrors = "true";
			}
			else {
				if (Validate_againstCurrDate_loc(document.getElementsByName("3_AccountBO.NREBecomingOrdDate")[0],locDate) == "true")
//				if (Validate_againstCurrDate(document.getElementsByName("3_AccountBO.NREBecomingOrdDate")[0]) == "true")
				{
					parent.parent.parent.parent.messageFrm.addMessage(selTabId,
					getUserMessage("MSG_INVALID_BECOMENREDATE","MSG_ORD"),'AccountBO.NREBecomingOrdDate','HYPER_LINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);// CRM70t-ST :TRACKER# 79438 - CHANGES
					hasOtherErrors = "true";
				}
			}*/
			/*Tracker ID 113276 - Turned Resident on Field is hidden from UI - End */
		}catch(e) {
		}
		}
		else
		{
		try
		{	/* Tracker ID 113276 - Turned Resident on Field is hidden from UI - Begin */
			/*if(document.getElementsByName("AccountBO.NREBecomingOrdDate")[0].value != "") {
				// CRM70t-ST :TRACKER# 79438 - CHANGES
				parent.parent.parent.parent.messageFrm.addMessage(selTabId,
				getUserMessage("MSG_NREDATE","MSG_ORD"),'AccountBO.NREBecomingOrdDate','HYPER_LINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);// CRM70t-ST :TRACKER# 79438 - CHANGES
				hasOtherErrors = "true";
			}*/
		/* Tracker ID 113276 - Turned Resident on Field is hidden from UI - End*/
		}
		catch (e) {
		}
		}
			if(document.getElementsByName("3_AccountBO.RelationshipOpeningDate")[0].value != "") {
				if (Validate_againstCurrDate_loc(document.getElementsByName("3_AccountBO.RelationshipOpeningDate")[0],locDate) == "false"){
					parent.parent.parent.parent.messageFrm.addMessage(selTabId,
					getUserMessage("MSG_INVALIDNREDATE","MSG_RELATIONSHIP"),'AccountBO.RelationshipOpeningDate','HYPER_LINK');
					//changes for call id 391472 and recon of call id 389451 starts
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					//changes for call id 391472 and recon of call id 389451 ends
					hasOtherErrors = "true";
				}
			}
	if(saveFlag==true){
	if (chkStat != "true"|| hasOtherErrors == "true")
	{      return 'interactive';
	}
	   }
	    selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
	      if(document.getElementsByName("3_ContactBO.DOB")[0].value != '')
	     {
		 var primaryCustomerDOB = document.getElementsByName("3_ContactBO.DOB")[0].value;
		 var dobMinor = new Date(primaryCustomerDOB.substring(6,10),
				primaryCustomerDOB.substring(3,5),
				primaryCustomerDOB.substring(0,2));
		 var yearDob = dobMinor.getFullYear();
		 var monthDob = dobMinor.getMonth();
		 var dateDob = dobMinor.getDate();
		 var isMinorContact = IsMinor(dateDob,monthDob,yearDob);
		 if(isMinorContact=='true')
		 {
		    parent.parent.parent.parent.messageFrm.addMessage(selTabId,
									MSG_MINOR,'ContactBO.DOB','HYPER_LINK');
		   parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		   return 'interactive';
		 }
	      }

	  //End of changes by Suman for Minor
//IDENTIFICATION DOCUMENT CHANGES start
// Last Edited Page changes
	/*Changes for ticket 279439 starts*/
		if(document.getElementsByName(boName+".CustomerNREFlg")[0].value == "Y")
		{
			if(document.getElementsByName("Passport Number.txt_ID")[0].value==""  && bank_id != '50')
			{
				if(saveFlag == true)
				{
					  //Tracker 96667 changes BEGIN
					  //showTabFortabIDDocForm('tpageIDDoc');
					  //Tracker 96667 changes BEGIN
					showTabFortabEntityFieldDetails('tpageCustDetails');
					document.all.AddIdentificationDetails.focus();
					showMessage(MSGJ0059);
					return "interactive";
				}
			}
		}
		/*Changes for ticket 279439 ends*/
		chkMinID = document.all.EDocRecordSet.rows.length - 2;
		if(saveFlag == true)
		{
			if(chkMinID <= 0)
			{
				parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_DEFID",""),TBODY_EDocRecordSet.rows ,'NO_HLINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				showTabFortabEntityFieldDetails('tpageCustDetails');
				document.all.AddIdentificationDetails.focus();
				return "interactive"
			}
		}
		setHiddenIDFields();
		showTabFortabEntityFieldDetails('tpageContDetails');
		var noOfEdoc = document.all.EDocRecordSet.rows.length - 2;
		if(saveFlag == true){
			if(noOfEdoc > 0){
				if(uniqueID == null || uniqueID == "undefined" || uniqueID == "")
				{
					showMessage(MSGJ50573);
					return "false";
				}
			}

		}
            var mailingad = true;
            var otherAdd;
            noOfEdu = edu_URL.length;
            chkadres = document.all.RecordSet.rows.length;
			/* Changes by Elango to make mailing address non mandatory in subsidiaries*/
         /*  if(saveFlag == true)
           {
           if(chkadres == 2){
	   parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CONTACT_DEFID",""),TBODY_RecordSet.rows ,'NO_HLINK');
	   parent.parent.parent.parent.messageFrm.showMessages(selTabId);
	//changes for Ticket id 724289 begin
	  showTabFortabEntityFieldDetails('tpageCont1');
	  showTabFortabContactDetails('tpageAddr');
	  document.all.ADD_ADDRESS.focus();
	//changes for Ticket id 724289 ends
            return "interactive"
            }
	    } */
		/*End of changes by Elango*/
	     	   var isNRE;
	     	   var NRERel;
	     	    	       if(document.getElementsByName(boName+".CustomerNREFlg")[0].value == "Y" ){
	     	    		isNRE = true;
	     	    	       }
	     	    	       else{
	     	    		isNRE = false;
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
					if(saveFlag==true)
					{
				 if((ad_address_type[x]) == "NRERelative") {
					parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_NREREL1",""),TBODY_RecordSet.rows ,'NO_HLINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive"
				   	 }
					}
				   	}
	   	}
           for(var x = 0; x < noOfEdu ; x++) {
			    if(ad_address_type[x] != "Mailing") {
			    mailingad = false;
				    }
			    else{
			     mailingad = true;
			     break;
			      }
			     }
	 /*TRACKER ID : 78621 : BEGIN OF CHANGES*/
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
 	    /*TRACKER ID : 78621 : END OF CHANGES*/
		/* Changes by Elango to make mailing address non mandatory in subsidiaries*/
           /* if(mailingad == false){
            	 if(saveFlag == true)
            	 {
	   parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_DEFID",""),TBODY_RecordSet.rows ,'NO_HLINK');
	   parent.parent.parent.parent.messageFrm.showMessages(selTabId);
            return "interactive"
            }
            }*/
			/*End of changes by Elango*/
            //changes for 258713 starts
		if(NRERel == false && isNRE == true){
		// Changes for Tracker id: 292427  and Ticket Id: 481441 Starts Here
		if(saveFlag == true)
		{
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_QDE_NREREL",""),TBODY_RecordSet.rows ,'NO_HLINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
			}
			// Changes for Tracker id: 292427  and Ticket Id: 481441 Ends Here
		}
		//changes for 258713 ends
            /*TRACKER ID : 78621 : BEGIN OF CHANGES*/
	    if(otherAdd == false && defAddress != "Mailing") {
	      	 if(saveFlag == true)
	    	 {
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
            /*TRACKER ID : 78621 : END OF CHANGES*/
   try{
        /* ***** Tracker# 97236 SMS Banking Mobile Number changes : Start ***** */
        var SMSBankingMobileNumber = document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0];
        var SMSBankingNo = SMSBankingMobileNumber.value;
        SMSBankingNo = trim(SMSBankingNo);
        /* ***** Tracker# 97236 SMS Banking Mobile Number changes : End ***** */
		try{
		var startdate  = new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		var mobileNo    = new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		var index      = new Array();
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
		ad_end_date[findex] = "";
		}
		}
		}
		catch(e)
		{}
		noOfmailingaddress = startdate.length;
		var currentCount = 0;
		var todaydate = new String();
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		var currMailIndex = 0;
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		//todaydate.value = getTodayDate();
		todaydate.value = getTodayDate1(locDate);
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
		/* Changes by Elango to make mailing address non mandatory in subsidiaries*/
		/*if (currentCount == 0)
		{
			 if(saveFlag == true)
			 {
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG_MAIL_CURR_ADD",""),TBODY_RecordSet.rows ,'NO_HLINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
		}
		} */
		/*End of changes by Elango*/
		try{
		var startdate1  = new Array();
		var index1      = new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		var mobileNo1   = new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Home") && !(edu_Status[k] == "Remove")) {
		startdate1[z] = ad_start_date[k];
		index1[z] = k;
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		mobileNo1[z]  = ad_cellno_local[k];
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
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
		ad_end_date[findex] = "";
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
		var mobileNo2   = new Array();
/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
		var z=0;
		for(var k = 0; k < noOfEdu ; k++) {
		if((ad_address_type[k] == "Work") && !(edu_Status[k] == "Remove")) {
		startdate2[z] = ad_start_date[k];
		index2[z] = k;
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
		mobileNo2[z]  = ad_cellno_local[k];
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
		ad_end_date[findex] = "";
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
		ad_end_date[findex] = "";
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
		   /*Changes done for ticket#348257 begin*/
		   if((ad_address_type[k] == "NRERelative") && !(edu_Status[k] == "Remove")) {
		   startdate4[z] = ad_start_date[k];
		   /*Changes done for ticket#348257 end*/
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
		   end_date[findex] = "";
		   }
		   }

		   }
		   catch(e)
		   {}

 		// TRACKER 112270  changes-Begin
 		   setEnddateForOtherRetailAddrType(noOfEdu,ad_address_type,address_type,edu_Status);
 		// TRACKER 112270  changes-End
		preferredAddress = document.getElementsByName('AccountBO.Address.preferredAddress')[0];
		var preferredAddressFlag = false;
	        if(saveFlag == true)
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
				for(var r=0 ; r < document.all.RecordSet.rows.length ; r++)
				{
					// Tracker ID: 135125: XMLEncoding Changes STARTS
					if(boName=='AccountBO'){
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("AccountBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("AccountBO.Address.PreferredFormat");
					}
					else if(boName=='AccountModBO'){
						recordSetAddressCategory = document.all.RecordSet.rows(r).getAttribute("AccountModBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.RecordSet.rows(r).getAttribute("AccountModBO.Address.PreferredFormat");
					}
					// Tracker ID: 135125: XMLEncoding Changes ENDS
					/* Tracker ID:148461 begin changes */
					/* if((preferredAddress.value == recordSetAddressCategory) && recordSetAddressPreferredFormat == "FREE_TEXT_FORMAT")
					{
						preferredAddressFlag = true
						selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
						parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Cannot Have free Text Format",""), preferredAddress.name, 'NO_HYPER_LINK');
						parent.parent.parent.parent.messageFrm.showMessages(selTabId);
						return "interactive";
					}*/

					/* Tracker ID:148461 end changes */




					if(preferredAddress.value == recordSetAddressCategory)
					{
						preferredAddressFlag = true;
					}
				}
				if(!preferredAddressFlag)
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Address Does not exist in the Listing",""), preferredAddress.name, 'NO_HYPER_LINK');
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
											if(saveFlag == true)
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
					// Tracker ID: 135125: XMLEncoding Changes STARTS
					if(boName=='AccountBO'){
						recordSetPhone = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountBO.PhoneEmail.PhoneEmailType");
						recordSetPhone1 = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountBO.PhoneEmail.PhoneEmailType1");
					}
					else if(boName=='AccountModBO'){
						recordSetPhone = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountModBO.PhoneEmail.PhoneEmailType");
						recordSetPhone1 = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountModBO.PhoneEmail.PhoneEmailType1");
					}
					// Tracker ID: 135125: XMLEncoding Changes ENDS

					if(preferredPhone.value == recordSetPhone && preferredPhone.value != null){
						preferredPhoneFlag = true;
					}
					 if(preferredEmail.value == recordSetPhone1 && preferredEmail.value != null){
						preferredEmailFlag = true;
					}
				}
				if(!preferredPhoneFlag && preferredPhone.value != null && preferredPhone.value != '')
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					
					//Fix for ticket 338310 by tracker 220511 - 10.2.05 starts
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Phone Does not exist in the Listing",""), preferredPhone.name, 'NO_HLINK');
					//Fix for ticket 338310 by tracker 220511 - 10.2.05 ends
					
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
				}
				if(!preferredEmailFlag && preferredEmail.value != null && preferredEmail.value != '')
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					
					//Fix for ticket 338310 by tracker 220511 - 10.2.05 starts
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Email Does not exist in the Listing",""), preferredEmail.name, 'NO_HLINK');
					//Fix for ticket 338310 by tracker 220511 - 10.2.05 ends

					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
				}
			}
		}
			addPhoneEmailCounter = 0;
			//Ticket Id - 203975 : Begin
			 var noOfPhoneEmail = phoneEmail_URL.length;
			 //Ticket Id - 203975 : End
		/* Changes for Tracker 110056 start*/
		var adMobileNo = '';
		for(var i = 0; i <noOfPhoneEmail; i++){
			 if (ad_PhoneEmailType[i] == 'CELLPH') {
				adMobileNo = ad_PhoneNoLocalCode[i];
			 }
		}
		/* Changes for Tracker 110056 end*/
		/* ***** Tracker# 97236 SMS Banking Mobile Number changes : Start ***** */
		//Changes for the Tracker Id: 361934
		//changes for call id 432988 and recon of call id 428918 starts
		/*if(document.getElementsByName(boName+".IsSMSBankingEnabled")[0].checked
		   && SMSBankingNo=='')*/
		if(document.getElementsByName("IsSMSBankingEnabled")[0].checked && SMSBankingNo=='')
		{
		//changes for call id 432988 and recon of call id 428918 ends
			/* Changes for Tracker #110056 -- start */
			var mobileNoEntered = adMobileNo;
			/* Changes for Tracker 110056 end*/
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
}catch(e){}
            addEduCounter = 0 ;
            clearValues();
try {
            for(var i = 0; i <noOfEdu; i++) {
                if((edu_URL[i] != null) && !(edu_Status[i] == "Add" || edu_Status[i] == "Remove")) {
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
				/*******ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
			      var ALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
				if(ALTCALENDAR_TYPE = 'true')
				{
				   if(EDoc_dateofissue[i] != '')
				   {
				    var strFlag = isGregDateWithoutConv(ad_start_date[i]);
				    if(strFlag != 'true')
					{
					ad_start_date[i]=convertHijToGreg(ad_start_date[i]);
					}
				   }
				if(EDoc_validity_date[i] != '')
				   {
				    var strFlag = isGregDateWithoutConv(ad_end_date[i]);
				    if(strFlag != 'true')
					{
						ad_end_date[i]=convertHijToGreg(ad_end_date[i]);
					}
				   }
				}
				/************ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
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

/*				document.frm2.address_proof.value = srmEscape(ad_address_proof[i], '^', escChars);
				document.frm2.home_phone.value = srmEscape(ad_home_phone[i], '^', escChars);
				document.frm2.work_phone.value = srmEscape(ad_work_phone[i], '^', escChars);

				document.frm2.cellno.value = srmEscape(ad_cellno[i], '^', escChars);
			        document.frm2.faxno.value = srmEscape(ad_faxno[i], '^', escChars);
				document.frm2.email.value = srmEscape(ad_email[i], '^', escChars);*/

        /*Tracker 159095 : Sonali begin of changes*/
				document.frm2.website.value = srmEscapeAddr(ad_website[i], '^', escCharsAddr);
				document.frm2.mailstop.value = srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
				document.frm2.streetname.value = srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
	                        document.frm2.suburb.value = srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
        /*Tracker 159095 : Sonali end of changes*/

/*                              document.frm2.extension.value = srmEscape(ad_extension[i], '^', escChars);

	                        document.frm2.work_phone_cntry.value = srmEscape(ad_work_phone_cntry[i], '^', escChars);
				document.frm2.work_phone_area.value = srmEscape(ad_work_phone_area[i], '^', escChars);
	                        document.frm2.work_phone_local.value = srmEscape(ad_work_phone_local[i], '^', escChars);

	                        document.frm2.home_phone_cntry.value = srmEscape(ad_home_phone_cntry[i], '^', escChars);
				document.frm2.home_phone_area.value = srmEscape(ad_home_phone_area[i], '^', escChars);
	                        document.frm2.home_phone_local.value = srmEscape(ad_home_phone_local[i], '^', escChars);

	                        document.frm2.cellno_cntry.value = srmEscape(ad_cellno_cntry[i], '^', escChars);
				document.frm2.cellno_area.value = srmEscape(ad_cellno_area[i], '^', escChars);
	                        document.frm2.cellno_local.value = srmEscape(ad_cellno_local[i], '^', escChars);


	                        document.frm2.faxno_cntry.value = srmEscape(ad_faxno_cntry[i], '^', escChars);
				document.frm2.faxno_area.value = srmEscape(ad_faxno_area[i], '^', escChars);
	                    document.frm2.faxno_local.value = srmEscape(ad_faxno_local[i], '^', escChars);*/
	                         //CORE Fields Inclusion:start
/*				document.frm2.telex.value 		= srmEscape(ad_telex[i], '^', escChars);
				document.frm2.telex_cntry.value 	= srmEscape(ad_telexno_cntry[i], '^', escChars);
				document.frm2.telex_area.value  	= srmEscape(ad_telexno_area[i], '^', escChars);
						document.frm2.telex_local.value 	= srmEscape(ad_telexno_local[i], '^', escChars);*/
		   		//CORE Fields Inclsuion:end
			//CIF Changes for RefCodes
				document.frm2.city_code.value 		= srmEscape(ad_cityCode[i], '^', escChars);
				document.frm2.state_code.value 		= srmEscape(ad_stateCode[i], '^', escChars);
				document.frm2.country_code.value 	= srmEscape(ad_cntryCode[i], '^', escChars);
			//CIF Changes for RefCodes
				//CIF PhoneEmail Changes : Start
				document.frm2.PreferredFormat.value = srmEscape(ad_PreferredFormat[i], '^', escChars);
				document.frm2.HoldMailReason.value = srmEscape(ad_HoldMailReason[i], '^', escChars);
				document.frm2.BusinessCenter.value = srmEscape(ad_BusinessCenter[i], '^', escChars);
				document.frm2.HoldMailInitiatedBy.value = srmEscape(ad_HoldMailInitiatedBy[i], '^', escChars);
				document.frm2.HoldMailFlag.value = srmEscape(ad_HoldMailFlag[i], '^', escChars);

/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
				document.frm2.IsAddressVerified.value = srmEscape(ad_IsAddressVerified[i],'^',escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/

        /*Tracker 159095 : Sonali begin of changes*/
				document.frm2.AddressLine1.value = srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
				document.frm2.AddressLine2.value = srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
				document.frm2.AddressLine3.value = srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
				document.frm2.FreeTextLabel.value = srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
        /*Tracker 159095 : Sonali end of changes*/
						document.frm2.PreferredAddress.value = document.getElementsByName('AccountBO.Address.preferredAddress')[0].value;
                        addEduCounter = 1;
//Changes for Ticket ID# 320401 begin
		document.frm2.IsAddressProofRcvd.value = srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
//Changes for Ticket ID# 320401 end
                    }else{
				document.frm2.address_type.value = document.frm2.address_type.value + "," + srmEscape(ad_address_type[i], '^', escChars);

        /*Tracker 159095 : Sonali begin of changes*/
				document.frm2.houseno.value = document.frm2.houseno.value + "%" + srmEscapeAddr(ad_houseno[i], '^', escCharsAddr);
				document.frm2.premiseno.value = document.frm2.premiseno.value + "%" + srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
				document.frm2.building.value = document.frm2.building.value + "%" + srmEscapeAddr(ad_building[i], '^', escCharsAddr);
        /*Tracker 159095 : Sonali end of changes*/
				document.frm2.country.value = document.frm2.country.value + "," + srmEscape(ad_country[i], '^', escChars);
				document.frm2.city.value = document.frm2.city.value + "," + srmEscape(ad_city[i], '^', escChars);
				document.frm2.state.value = document.frm2.state.value + "," + srmEscape(ad_state[i], '^', escChars);
				/*******ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
			      var ALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
				if(ALTCALENDAR_TYPE = 'true')
				{
				   if(EDoc_dateofissue[i] != '')
				   {
				    var strFlag = isGregDateWithoutConv(ad_start_date[i]);
				    if(strFlag != 'true')
					{
					ad_start_date[i]=convertHijToGreg(ad_start_date[i]);
					}
				   }
				if(EDoc_validity_date[i] != '')
				   {
				    var strFlag = isGregDateWithoutConv(ad_end_date[i]);
				    if(strFlag != 'true')
					{
						ad_end_date[i]=convertHijToGreg(ad_end_date[i]);
					}
				   }
				}
				/************ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
				document.frm2.start_date.value = document.frm2.start_date.value + "," + srmEscape(ad_start_date[i], '^', escChars);
				document.frm2.zip.value = document.frm2.zip.value + "," + srmEscape(ad_zip[i], '^', escChars);
				document.frm2.end_date.value = document.frm2.end_date.value + "," + srmEscape(ad_end_date[i], '^', escChars);
				document.frm2.addrID.value = document.frm2.addrID.value + "," + srmEscape(ad_addrID[i], '^', escChars);
        /*Tracker 159095 : Sonali begin of changes*/
				document.frm2.streetno.value = document.frm2.streetno.value + "%" + srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
				document.frm2.town.value = document.frm2.town.value + "%" + srmEscapeAddr(ad_town[i], '^', escCharsAddr);
				document.frm2.locality.value = document.frm2.locality.value + "%" + srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
				document.frm2.domicile.value = document.frm2.domicile.value + "%" + srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
        /*Tracker 159095 : Sonali end of changes*/
/*				document.frm2.address_proof.value = document.frm2.address_proof.value + "," + srmEscape(ad_address_proof[i], '^', escChars);
				document.frm2.home_phone.value = document.frm2.home_phone.value + "," + srmEscape(ad_home_phone[i], '^', escChars);
				document.frm2.work_phone.value = document.frm2.work_phone.value + "," + srmEscape(ad_work_phone[i], '^', escChars);
				document.frm2.cellno.value = document.frm2.cellno.value + "," + srmEscape(ad_cellno[i], '^', escChars);
				document.frm2.faxno.value = document.frm2.faxno.value + "," + srmEscape(ad_faxno[i], '^', escChars);
				document.frm2.email.value = document.frm2.email.value + "," + srmEscape(ad_email[i], '^', escChars);*/
        /*Tracker 159095 : Sonali begin of changes*/
				document.frm2.website.value = document.frm2.website.value + "%" + srmEscapeAddr(ad_website[i], '^', escCharsAddr);
				document.frm2.mailstop.value = document.frm2.mailstop.value + "%" + srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
				document.frm2.streetname.value = document.frm2.streetname.value + "%" + srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
				document.frm2.suburb.value = document.frm2.suburb.value + "%" + srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
        /*Tracker 159095 : Sonali end of changes*/
				document.frm2.extension.value = document.frm2.extension.value + "," +srmEscape(ad_extension[i], '^', escChars);
/*				document.frm2.work_phone_cntry.value = document.frm2.work_phone_cntry.value + "," + srmEscape(ad_work_phone_cntry[i], '^', escChars);
				document.frm2.work_phone_area.value = document.frm2.work_phone_area.value + "," + srmEscape(ad_work_phone_area[i], '^', escChars);
				document.frm2.work_phone_local.value = document.frm2.work_phone_local.value + "," +srmEscape(ad_work_phone_local[i], '^', escChars);
				document.frm2.home_phone_cntry.value = document.frm2.home_phone_cntry.value + "," + srmEscape(ad_home_phone_cntry[i], '^', escChars);
				document.frm2.home_phone_area.value = document.frm2.home_phone_area.value + "," + srmEscape(ad_home_phone_area[i], '^', escChars);
				document.frm2.home_phone_local.value = document.frm2.home_phone_local.value + "," +srmEscape(ad_home_phone_local[i], '^', escChars);
				document.frm2.cellno_cntry.value = document.frm2.cellno_cntry.value + "," + srmEscape(ad_cellno_cntry[i], '^', escChars);
				document.frm2.cellno_area.value = document.frm2.cellno_area.value + "," + srmEscape(ad_cellno_area[i], '^', escChars);
				document.frm2.cellno_local.value = document.frm2.cellno_local.value + "," +srmEscape(ad_cellno_local[i], '^', escChars);
				document.frm2.faxno_cntry.value = document.frm2.faxno_cntry.value + "," + srmEscape(ad_faxno_cntry[i], '^', escChars);
				document.frm2.faxno_area.value = document.frm2.faxno_area.value + "," + srmEscape(ad_faxno_area[i], '^', escChars);
				document.frm2.faxno_local.value = document.frm2.faxno_local.value + "," +srmEscape(ad_faxno_local[i], '^', escChars);*/
				//CORE Fields Inclusion:start
/*				document.frm2.telex.value 		= document.frm2.telex.value + " ," +srmEscape(ad_telex[i], '^', escChars);
				document.frm2.telex_cntry.value		= document.frm2.telex_cntry.value + " ," +srmEscape(ad_telexno_cntry[i], '^', escChars);
				document.frm2.telex_area.value  	= document.frm2.telex_area.value + " ," +srmEscape(ad_telexno_area[i], '^', escChars);
				document.frm2.telex_local.value 	= document.frm2.telex_local.value + " ," +srmEscape(ad_telexno_local[i], '^', escChars);	*/
				//CORE Fields Inclusion:end
			//CIF Changes for RefCodes
			document.frm2.city_code.value 		= document.frm2.city_code.value + " ," +srmEscape(ad_cityCode[i], '^', escChars);
			document.frm2.state_code.value 		= document.frm2.state_code.value + " ," +srmEscape(ad_stateCode[i], '^', escChars);
			document.frm2.country_code.value 	= document.frm2.country_code.value + " ," +srmEscape(ad_cntryCode[i], '^', escChars);
			//CIF Changes for RefCodes
				 //CIF PhoneEmail Changes : Start
				document.frm2.PreferredFormat.value = document.frm2.PreferredFormat.value + " ," + srmEscape(ad_PreferredFormat[i], '^', escChars);
				document.frm2.HoldMailReason.value = document.frm2.HoldMailReason.value + " ," + srmEscape(ad_HoldMailReason[i], '^', escChars);
				document.frm2.BusinessCenter.value = document.frm2.BusinessCenter.value + " ," + srmEscape(ad_BusinessCenter[i], '^', escChars);
				document.frm2.HoldMailInitiatedBy.value = document.frm2.HoldMailInitiatedBy.value + " ," + srmEscape(ad_HoldMailInitiatedBy[i], '^', escChars);
				document.frm2.HoldMailFlag.value = document.frm2.HoldMailFlag.value + " ," + srmEscape(ad_HoldMailFlag[i], '^', escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
				document.frm2.IsAddressVerified.value = document.frm2.IsAddressVerified.value + " ," + srmEscape(ad_IsAddressVerified[i], '^', escChars);
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/

        /*Tracker 159095 : Sonali begin of changes*/
				document.frm2.AddressLine1.value = document.frm2.AddressLine1.value + "%" + srmEscapeAddr(ad_AddressLine1[i], '^', escCharsAddr);
				document.frm2.AddressLine2.value = document.frm2.AddressLine2.value + "%" + srmEscapeAddr(ad_AddressLine2[i], '^', escCharsAddr);
				document.frm2.AddressLine3.value = document.frm2.AddressLine3.value + "%" + srmEscapeAddr(ad_AddressLine3[i], '^', escCharsAddr);
				document.frm2.FreeTextLabel.value = document.frm2.FreeTextLabel.value + "%" + srmEscapeAddr(ad_FreeTextLabel[i], '^', escCharsAddr);
        /*Tracker 159095 : Sonali end of changes*/
				document.frm2.PreferredAddress.value = document.getElementsByName('AccountBO.Address.preferredAddress')[0].value;
//Changes for Ticket ID# 320401 begin
		document.frm2.IsAddressProofRcvd.value = document.frm2.IsAddressProofRcvd.value + "," + srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
//Changes for Ticket ID# 320401 begin
                      }
                }
            }
			var sep =",";
			for(p=0;p<ad_LastUpdate_Flag.length;p++)
			{
			if(ad_LastUpdate_Flag[p]!=null && ad_LastUpdate_Flag[p]!='')
			{
			st+=ad_LastUpdate_Flag[p]+sep;
			}
			}
			document.getElementsByName("hidSt")[0].value=st;
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
							document.frm2.extension.value = document.frm2.extension.value + "," + srmEscape(ad_extension[i], '^', escChars);
						    /*Modified For Recon Id : 435250 - Extra space Removed while Appending Ends */
							document.frm2.PreferredEmail.value = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType1')[0].value;
							document.frm2.PreferredPhone.value = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType')[0].value;
						 }
					 }
			 }
			 /* CIF PhoneEmail Changes : End */
} catch(ge) { DebugMessage(ge.message); }
            document.frm2.AdrRemoved.value = getCSVforArray(edu_detachedURLs);
	    // Change for DBS ticket 325152
            //document.frm2.SwiftAddressDetails.value = SwiftAddressDetails;
			document.frm2.PhoneEmailRemoved.value = getCSVforArray(phone_detachedURLs);
            var flag = false;
             setHiddenFieldsHH();
	setHiddenFieldsGrp();
try{
	var ownerSegment= document.getElementsByName(boName+'.accessOwnerSegment')[0].value;
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
	else if (SegmentChanged=="true" && ((primaryRM!=null && primaryRM!='') || (secondaryRM!=null && secondaryRM!=''))) {
		if(showConfirmMessage(MSGJ50357)){
		}else{
			return "interactive";
		}
	}
}catch(e){}

             /*TRACKER ID : 78621 : BEGIN OF CHANGES*/
		if(defAddress == "Mailing") {
			defAddress = "M";
		}
		else if(defAddress == "Home")
			defAddress = "H";
		else
			defAddress = "W";
	/***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
fnConvertDate();
/* START  Changes for Tracker # 209607*/
           newPara = document.getElementById("myPar");


          var frame='formSaveFrame';
/* END  Changes for Tracker # 209607*/
/***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
	if(chkStat == true || chkStat == "true")
	{
if(document.frm2.isMCEditedGeneral.value=="N"){
		appFlag="false";
}


	/****      Swift Address Changes Begin   ****/



   if(SwiftAddressDetails == ""){
	SwiftAddressDetails='YYY';
	if(saveFlag == true){
		parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(), "Swift Address is Defaulted from Preferred Address Type");
		parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames(0).getSelectedTabId());
    	}
    }
//changes for Call ID 159787
   var ciftype = document.getElementsByName("RelationshipBO.ChildEntityType")[0].value;
   var Guard_Code = document.getElementsByName("RelationshipBO.Guard_Code")[0].value;
   //Change for ticket 326535
    document.frm2.SwiftAddressDetails.value = SwiftAddressDetails;
//Last Edited Page changes start
	if ((appFlag =="false" && operationType=="null" && saveFlag== true) || (appFlag =="true" && operationType=="null" && saveFlag== true) ){
//Last Edited Page changes ends
				  <!--tracker id 113227 starts-->
				  // document.frm2.action = "../servlet/com.infy.cis.ui.cif.QDECustomerWriter?IntWFID="+IntWFID /* Changes for 'WFlow' POC -- IntWFID also being passed */
				   //  document.frm2.action = "../servlet/com.infy.cis.ui.cif.QDECustomerWriter?IntWFID="+IntWFID+"&dual="+dualflag;
    	// Change for DBS ticket 325152
/* START  Changes for Tracker # 209607*/
    	//document.frm2.action = "../servlet/com.infy.cis.ui.cif.QDECustomerWriter?IntWFID="+IntWFID+"&dual="+dualflag;

				  <!--tracker id 113227 ends-->
/****** End of Swift Address changes ****/
                              /*Null Changes*/

                              /*changes for callid: 235861 Ticket: 454978 tracker: 275564  start*/
                               var SubmitURL="../servlet/com.infy.cis.ui.cif.QDECustomerWriter?IntWFID="+IntWFID+"&dual="+dualflag;
                               /*changes for callid: 235861 Ticket: 454978 tracker: 275564  ends*/
                               fnRemoveNull(newPara,SubmitURL,document.frm2,frame);
                               /*Null Changes End*/
		}
		else{
	                 /*Null Changes*/
				 //changes for Call ID 159787
	                           /*changes for callid: 235861 Ticket: 454978 tracker: 275564  start*/
	                           var servletURL="../servlet/com.infy.cis.ui.cif.QDECustomerModWriter?IntWFID="+IntWFID+"&boNamePsycho=" +boNamePsycho+"&isCopy="+isCopy+"&dual="+dualflag+"&ciftype="+ciftype+"&Guard_Code="+Guard_Code;
	                           /*changes for callid: 235861 Ticket: 454978 tracker: 275564  ends*/
	                           fnRemoveNull(newPara,servletURL,document.frm2,frame);

		         /*Null Changes End*/
		//Tracker No.96447
			  <!--tracker id 113227 starts-->
			  //document.frm2.action = "../servlet/com.infy.cis.ui.cif.QDECustomerModWriter?IntWFID="+IntWFID+ "&boNamePsycho=" +boNamePsycho/* Changes for 'WFlow' POC -- IntWFID also being passed */
			    // Change for DBS ticket 325152
			   // document.frm2.action = "../servlet/com.infy.cis.ui.cif.QDECustomerModWriter?IntWFID="+IntWFID+"&boNamePsycho=" +boNamePsycho+"&isCopy="+isCopy+"&dual="+dualflag;
			  <!--tracker id 113227 ends-->
		}
                //document.frm2.target='formSaveFrame';
               // document.frm2.submit();
	 }
/* END  Changes for Tracker # 209607*/
             /*TRACKER ID : 78621 : END OF CHANGES*/
                flag = true;
            clearValues();
            return 'true';

    }





 function fnConvertDate()
 {
	var arrDateList = new Array();
	var arrFinalDateList = new Array();
	var strALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
	var strCust_DOB =document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
	var strRelationshipOpeningDate =document.getElementsByName("3_AccountBO.RelationshipOpeningDate")[0].value;
	var strRiskProfileExpiryDate =document.getElementsByName("3_AccountBO.RiskProfileExpiryDate")[0].value;
	var strDateOfBecomingNRE =document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0].value;
	arrDateList[0] = strCust_DOB;
	arrDateList[1] = strRelationshipOpeningDate;
	arrDateList[2] = strRiskProfileExpiryDate;
	arrDateList[3] = strDateOfBecomingNRE;
	var strLength = arrDateList.length-1;
	if(strALTCALENDAR_TYPE = 'true')
	{
		for(iCount=0;iCount<=strLength;iCount++)
		{
			strDate=arrDateList[iCount];
		        if(strDate == '')
		        {
		   		arrFinalDateList[iCount]='';
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
		document.all.RelationshipOpeningDate.value = arrFinalDateList[1];
		document.all.RiskProfileExpiryDate.value = arrFinalDateList[2];
		document.all.DateOfBecomingNRE.value = arrFinalDateList[3];
	}
}
    function clearValues(){
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
		document.frm2.streetno.value= "";
		document.frm2.town.value= "";
		document.frm2.locality.value= "";
		document.frm2.domicile.value= "";
		document.frm2.email.value= "";
		document.frm2.website.value= "";
		document.frm2.mailstop.value= "";
		document.frm2.streetname.value= "";
	        document.frm2.suburb.value= "";
	        document.frm2.extension.value= "";
		document.frm2.country_code.value 	= "";
		document.frm2.state_code.value 		= "";
		document.frm2.city_code.value 		= "";
		document.frm2.name.value 		= "";
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
        function validateDate(){
        /*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
		isGregDate("3_AccountBO.DateOfBecomingNRE");
	/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
    	dateNRE = document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0];
    	/* Tracker ID 113276 - Turned Resident on Field is hidden from UI - Begin*/
    	dateDOB = document.getElementsByName("3_AccountBO.Cust_DOB")[0];
    	var millNRE = changetoMillis(dateNRE.value);
    	/* Tracker ID 113276 - Turned Resident on Field is hidden from UI */
    	var millDOB = changetoMillis(dateDOB.value);
    	    if (millNRE != 0 && millNRE < millDOB){
    			showMessage(MSGJ0061);
    			dateNRE.value = "";
    		}
    	}
    function setEmploymentProof()
    {
    	var getData = document.getElementsByName("AccountBO.StaffEmployeeID")[0];
    	var flag=txtLimit(getData,10,"AccountBO.StaffEmployeeID","StaffEmployeeID");

    	if(flag=="true"){
    		if(getData == ""){
    			document.getElementsByName("AccountBO.StaffFlag")[0].value = '';
    		}
    		else	{
    			document.getElementsByName("AccountBO.StaffFlag")[0].value = "Y"
    		}
    	}
    }
       function concatName(){
       // Tracker #96121 change
         var fullName="";
         var lastNameLength = 0;
	 var indexCustLastName=0;
	  //Changes for Ticket Id 347210 :Start
	 var firstName = trim(document.getElementsByName("AccountBO.Cust_First_Name")[0].value);
	 var middleName = trim(document.getElementsByName("AccountBO.Cust_Middle_Name")[0].value);
	 var lastName = trim(document.getElementsByName("AccountBO.Cust_Last_Name")[0].value);
//changes for tracker 401769 fullname alteration begin
//Equity Changes
	/* if(firstName != null && firstName != ""){
				if(!(firstName.length>=80)){
					fullName = firstName.substring(0,80);
				}
				else{
					fullName = firstName;
				}
		}
	if(middleName != null && middleName != ""){
				if(fullName != null && !(fullName.length>=80)){
					fullName = fullName+" "+middleName.substring(0,1);
				}else{
					if(fullName==null){
						fullName = middleName.substring(0,1);
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
	 }*/
	 //Changes done by Bharath
	fullName = firstName + " " + middleName + " " + lastName;
		document.getElementsByName("AccountBO.Name")[0].value = fullName;
		
	}
//changes for tracker 401769 fullname alteration ends
    //Tracker 113227 Begin of changes
    	function concatName_alt(){
    	         var fullName="";
    	         var lastNameLength = 0;
    	    	 var indexCustLastName=0;
    	    	 var firstName = trim(document.getElementsByName("AccountBO.Cust_First_Name_alt1")[0].value);
    	    	 var middleName = trim(document.getElementsByName("AccountBO.Cust_Middle_Name_alt1")[0].value);
    	    	 var lastName = trim(document.getElementsByName("AccountBO.Cust_Last_Name_alt1")[0].value);
    	    	 if(firstName != null && firstName != ""){
    	    		fullName = firstName.substring(0,1);
    	    	 }
    	    	 if(middleName != null && middleName != ""){
    	    		if(fullName != null){
    	    			fullName = trim(fullName+" "+middleName.substring(0,1));
    	    		}else{
    	    			fullName = trim(middleName.substring(0,1));
    	    		}
    	    	 }
    	    	 if(lastName != null && lastName!= ""){
    	    		lastNameLength = lastName.length;
    	    		if(lastNameLength > 46){
    	    			indexCustLastName=46;
    	    		}else{
    	    			indexCustLastName = lastNameLength;
    	    		}
    	    		if(fullName != null){
    	    			fullName=trim(fullName+" "+lastName.substring(0,indexCustLastName));
    	    		}else{
    	    			fullName=trim(lastName.substring(0,indexCustLastName));
    	    		}
    	    	 }
    	    		document.getElementsByName("AccountBO.Name_alt1")[0].value = fullName;
        	}
        	//Changes for Ticket Id 347210 :End
    	//Tracker 113227 End of changes
    function txtLimit(field, max,str1,str2)
    {
    	if (field.length > max + 1){
    	var tempList = new Array();
     tempList[0] = str2;
     tempList[1] = max;
     showUserMessage(MSGJ0063,tempList);
    	document.getElementsByName(str1)[0].focus();
    	return "false";
    	}
    	else{
    		return "true";
    	}
    }
     function disableConditionally(obj1,obj2)
       {
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
    
    function validateEmploymentProof()
    {
    	var staffFlag = document.getElementsByName(boName+".StaffFlag")[0].value ;
	//Staff Id validations for 10.2.13    

    	if(staffFlag == 'Y' || staffFlag == 'EXSTF'){
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
    function setStaffEmployeeIdMandatory(isMandatory)
    {
        if(isMandatory){
    	document.getElementsByName("mandStarAccountBO.StaffEmployeeID")[0].style.visibility="";
    	document.getElementsByName("AccountBO.StaffEmployeeID")[0].IsMandatory = "true";
        }else{
    	document.getElementsByName("mandStarAccountBO.StaffEmployeeID")[0].style.visibility="hidden";
    	document.getElementsByName("AccountBO.StaffEmployeeID")[0].IsMandatory = "false";
        }
    }
    function makeDateMand()
    {
    	if(document.getElementsByName(boName+".CustomerNREFlg")[0].value == "Y") {
    		document.getElementsByName("mandStarAccountBO.DateOfBecomingNRE")[0].style.visibility="visible";
    		document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0].disabled=false;
    		/* Tracker ID 113276 - Turned Resident on Field is hidden from UI - Begin */
    		//document.getElementsByName("mandStarAccountBO.NREBecomingOrdDate")[0].style.visibility="visible";
    		/* Tracker ID 113276 - Turned Resident on Field is hidden from UI - End */
    		/* Fix for ticket 220098 and tracker 132135 start*/
    		document.getElementsByTagName("img")[1].style.visibility='visible';
    		/* Fix for ticket 220098 and tracker 132135 ends*/
    		}
    		else{
    		document.getElementsByName("mandStarAccountBO.DateOfBecomingNRE")[0].style.visibility="hidden";
    		document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0].value='';
    		document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0].disabled=true;
    		//document.getElementsByName("AccountBO.StaffFlag")[0].focus();
    		document.getElementsByName(boName+".StaffFlag")[0].focus();
    // Tracker #: 123062 BEGIN of Changes
    		// Tracker #: 123062 END of Changes
    		/* Fix for ticket 220098 and tracker 132135 start*/
    		document.getElementsByTagName("img")[1].style.visibility='hidden';
    		/* Fix for ticket 220098 and tracker 132135 ends*/
    		}
    	}
function validateDates(){
	frameobj = parent.parent.parent.parent;
	selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
	var dtIssueDate = document.getElementsByName("3_DemographicBO.MiscellaneousInfo.dtDate1")[0];
	var dtValidityDate = document.getElementsByName("3_DemographicBO.MiscellaneousInfo.dtDate2")[0];
	var todaydate = new String();
	/*Fix for Tracker #: SIDDHARTH Starts*/
	todaydate.value = getTodayDate1(locDate);
	/*Fix for Tracker #: SIDDHARTH Ends*/
	var mill1 = changetoMillis(dtIssueDate.value);
	var mill2 = changetoMillisForToday(todaydate.value);
	var mill3 = changetoMillis(dtValidityDate.value);
	if (mill2 <= mill1){
		frameobj.messageFrm.addMessage(selTabId, dtIssueDate.Display + " " + getUserMessage("MSG302",""),
				       dtIssueDate.name, 'HYPER_LINK');
		frameobj.messageFrm.showMessages(selTabId);
	}
	if(dtValidityDate != null && dtValidityDate != "" && dtValidityDate != 'null' && dtValidityDate != ''){
		if (mill3 < mill1){
			var tempMsg = new Array();
			tempMsg[0] = getLabel(document.getElementsByName("3_DemographicBO.MiscellaneousInfo.dtDate2")[0].Display);
			tempMsg[1] = getLabel(document.getElementsByName("3_DemographicBO.MiscellaneousInfo.dtDate1")[0].Display);
			frameobj.messageFrm.addMessage(selTabId, eval(parentPrefix + "getUserErrorMessage('MSG017', tempMsg)"),
						     document.getElementsByName("3_DemographicBO.MiscellaneousInfo.dtDate1")[0].name, 'HYPER_LINK');
			frameobj.messageFrm.showMessages(selTabId);
		}
	}
}
function changetoMillisForToday(datevalue)
{
	if(datevalue.length == 0){
			return 0;
	}
	else{
			date1 = new Date(datevalue.substring(3,5) + "/" + datevalue.substring(0,2) + "/" + datevalue.substring(6,10));
			var millis = date1.valueOf();
			return millis;
	    }
}
function changetoMillis(datevalue){
	if(datevalue.length == 0){
		return 0;
	}
	else{
		var dtForm = gettingDateFormats();
		if(dtForm == 'MM/dd/yyyy' || dtForm == 'MM-dd-yyyy'){
			date1 = new Date(datevalue.substring(0,2) + "/" + datevalue.substring(3,5) + "/" + datevalue.substring(6,10));
		}
		else{
			date1 = new Date(datevalue.substring(3,5) + "/" + datevalue.substring(0,2) + "/" + datevalue.substring(6,10));
		}
		var millis = date1.valueOf();
		return millis;
	}
}
function createHHLd(mode)
{
var Mode = mode;
var servletURL = "../servlet/com.infy.cis.ui.cif.CIFCreateHsHld_Det?Mode="+Mode;
/* Tracker: 108382: Changes for centering popup */
windowAlign();
docTypeNew = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
/* Tracker: 108382: End of Changes */
}
function  clearLookup(type){
if (type == "HsHld")	{
	document.getElementsByName("AccountBO.householdID")[0].value = "";
	document.getElementsByName("AccountBO.householdName")[0].value = "";
}
//tracker 84832 -begin
	if (type == "EmpID")	{
		document.getElementsByName("AccountBO.StaffEmployeeID")[0].value = "";
	}
	//tracker 84832 -end
}
//tracker 84832 -begin
	function  openEmployeeIDLookup()
	{
	var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=StaffEmployeeID&CategoryType=EMPLOYEE_ID";
	/* Tracker: 108382: Changes for centering popup */
	windowAlign();
	window.open (url, "Lookup", "height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
	/* Tracker: 108382: End of Changes */
	}
	function onRecordSelectStaffEmp()
		{
		document.getElementsByName("AccountBO.StaffEmployeeID")[0].value = getCookie("LookupEmpID");
		document.getElementsByName("AccountBO.StaffEmployeeID")[0].fireEvent("onChange");

	}
/*CIF PhoneEmail Changes : Start */
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
	// Tracker ID: 135125: XMLEncoding Changes STARTS
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
			arr_AddressType[25] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.AddressLine1"));
			arr_AddressType[26] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.AddressLine2"));
			arr_AddressType[27] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.AddressLine3"));
			arr_AddressType[28] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.FreeTextLabel"));
			arr_AddressType[29] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.mailStop"));
			arr_AddressType[30] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.URL"));
			arr_AddressType[31] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountBO.Address.city"));
			arr_AddressType[32] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountBO.Address.country"));
			arr_AddressType[33] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountBO.Address.state"));
			arr_AddressType[34] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.LastUpdate_Date"));
	       arr_AddressType[35]='N';
       	arr_AddressType[37] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.Swift_Name"));
	// AdressLine changes: END
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			arr_AddressType[42] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.IsAddressVerified"));
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
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
			arr_AddressType[25] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.AddressLine1"));
			arr_AddressType[26] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.AddressLine2"));
			arr_AddressType[27] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.AddressLine3"));
			arr_AddressType[28] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.FreeTextLabel"));
			arr_AddressType[29] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.mailStop"));
			arr_AddressType[30] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.URL"));
			arr_AddressType[31] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountModBO.Address.city"));
			arr_AddressType[32] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountModBO.Address.country"));
			arr_AddressType[33] = trim(''+document.all.RecordSet.rows(k).getAttribute("Cat_AccountModBO.Address.state"));
			arr_AddressType[34] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.LastUpdate_Date"));
	       arr_AddressType[35]='N';
       	arr_AddressType[37] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.Swift_Name"));
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			arr_AddressType[42] = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.IsAddressVerified"));
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/

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
	// Tracker ID: 135125: XMLEncoding Changes ENDS
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
function deleteList(recordSetName)
{
	var noOfAddressCount = document.all.RecordSet.rows.length;
	for(k = noOfAddressCount-1 ; k > 1 ; k--)
	{
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName=='AccountBO'){
			addrCat = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountBO.Address.AddressCategory"));
		}
		else if(boName=='AccountModBO'){
			addrCat = trim(''+document.all.RecordSet.rows(k).getAttribute("AccountModBO.Address.AddressCategory"));
		}
		// Tracker ID: 135125: XMLEncoding Changes ENDS
		if(addrCat != null && addrCat != 'undefined')
		{
			document.all.RecordSet.deleteRow(k);
		}
	}
}
/* ***** Tracker# 97236 SMS Banking Mobile Number changes : Start ***** */
function checkMobileNoOfCurrentDefAddress()
{
	currDefAddrMobile = trim(currDefAddrMobile);
	return currDefAddrMobile;
}
/* ***** Tracker# 97236 SMS Banking Mobile Number changes : End ***** */
function loadBackEnd() {
	var k = 0;
	/*Tracker ID 113276 - Backend ID Details is hidden from UI - Begin */
	/*if (assignedBackEndID!=null && assignedBackEndID!="" && assignedBackEndID!= "null" ) {

		var backendid = new Array();

		var len_avail =0;
		backendid = assignedBackEndID.split(",");
		var len_backendid = backendid.length;

		var len_assign = document.frm2.Assigned_BackendID.length;

		for (var i=0;i < len_assign;i++ ) {
			var assign_backend=document.frm2.Assigned_BackendID.options[i].text;


			for (var j=0; j< len_backendid; j++ ) {

				if (backendid[j] == assign_backend) {
					try {
						k++;
						document.frm2.Available_BackendID.length =k;
						document.frm2.Available_BackendID.options[len_avail].text = assign_backend;
						len_avail++;
						document.frm2.Assigned_BackendID.options[i] = null;
						i--;
						len_assign--;
						break;

					} catch (ex) {
					}
				}
			}
		}
	}*/
	/*Tracker ID 113276 - Backend ID Details is hidden from UI - End */
}


//Last Edited Page changes start
function loadID()//deleted from CorpNonCustomer.xsl
{
	try
	{
		customLoad();
	}
	catch(e)
	{}
	if(document.frm2.hid_accountURL.value != '')
	{
		editMode = true;
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		if(entityDocumentBO_Name=='EntityDocumentBO'){
			for (i=2; i < document.all.EDocRecordSet.rows.length; i++)
			{
				var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.EntityDocumentID");
				if ((EntityDocumentID != null) && (EntityDocumentID != 'undefined'))
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
					docCode							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocCode"));
					docDescr						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocDescr"));
					docTypeCode						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocTypeCode"));
					docTypeDescr					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocTypeDescr"));
					docReceivedDate					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocReceivedDate"));
					docRemarks						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocRemarks"));
					status							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.Status"));
					isMandatory						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IsMandatory"));
					scanRequired					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.ScanRequired"));
					isPreferredUniqueID				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.PreferredUniqueId"));
					EDoc_identifier_type_Code[i-2] 	= identifier_type_Code;
					EDoc_docCode[i-2] 				= docCode;
					EDoc_docDescr[i-2] 				= docDescr;
					EDoc_docTypeCode[i-2] 			= docTypeCode;
					EDoc_docTypeDescr[i-2] 			= docTypeDescr;
					EDoc_docReceivedDate[i-2] 		= docReceivedDate;
					EDoc_docRemarks[i-2]		 	= docRemarks;
					EDoc_Status[i-2] 				= status;
					EDoc_isMandatory[i-2] 			= isMandatory;
					EDoc_scanRequired[i-2] 			= scanRequired;
					EDoc_unique_id[i-2] 			= unique_id;
					EDoc_placeofissue[i-2] 			= placeofissue;
					EDoc_countryofissue[i-2] 		= countryofissue;
					EDoc_placeofissue_cat[i-2] 		= placeofissue_cat;
					EDoc_countryofissue_cat[i-2] 	= countryofissue_cat;
					EDoc_dateofissue[i-2] 			= dateofissue;
					EDoc_validity_date[i-2] 		= validity_date;
					EDoc_EntityDocumentID[i-2] 		= EntityDocumentID;
					EDoc_EntityDocumentURL[i-2] 	= EntityDocumentURL;
					EDoc_URL[i-2] 					= identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue;
					EDoc_IsDirty[i-2] 				= 'N';
					document.all.EDocRecordSet.rows(i).setAttribute("EntityDocumentBO.url", identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue);
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
					if (isPreferredUniqueID == "Y"){
						document.all.EDocRecordSet.rows(i).
						childNodes(0).innerHTML="<INPUT TYPE='radio' name='radio1' onClick = 'AddSelectedRowToList()' CHECKED>";
						uniqueID =trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.ReferenceNumber"));
						uniqueIDType=trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IdentificationType"));
					}
				}
			}
		}else if(entityDocumentBO_Name=='EntityDocumentModBO'){

			for (i=2; i < document.all.EDocRecordSet.rows.length; i++)
			{
				/*Changes for Call Id:269631 Start*/
				//var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.EntityDocumentID");
				var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.EntityDocumentID");
				/*Changes for Call Id:269631 End*/
				if ((EntityDocumentID != null) && (EntityDocumentID != 'undefined'))
				{
					identifier_type_Code			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IdentificationType"));
					unique_id 						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.ReferenceNumber"));
					placeofissue 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.PlaceOfIssue"));
					placeofissue_cat 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentModBO.PlaceOfIssue"));
					countryofissue 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.CountryOfIssue"));
					countryofissue_cat 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentModBO.CountryOfIssue"));
					dateofissue  					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocIssueDate"));
					validity_date 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocExpiryDate"));
					EntityDocumentID 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.EntityDocumentID"));
					EntityDocumentURL 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.url_"));
					docCode							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocCode"));
					docDescr						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocDescr"));
					docTypeCode						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocTypeCode"));
					docTypeDescr					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocTypeDescr"));
					docReceivedDate					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocReceivedDate"));
					docRemarks						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocRemarks"));
					status							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.Status"));
					isMandatory						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IsMandatory"));
					scanRequired					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.ScanRequired"));
					isPreferredUniqueID				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.PreferredUniqueId"));
					EDoc_identifier_type_Code[i-2] 	= identifier_type_Code;
					EDoc_docCode[i-2] 				= docCode;
					EDoc_docDescr[i-2] 				= docDescr;
					EDoc_docTypeCode[i-2] 			= docTypeCode;
					EDoc_docTypeDescr[i-2] 			= docTypeDescr;
					EDoc_docReceivedDate[i-2] 		= docReceivedDate;
					EDoc_docRemarks[i-2]		 	= docRemarks;
					EDoc_Status[i-2] 				= status;
					EDoc_isMandatory[i-2] 			= isMandatory;
					EDoc_scanRequired[i-2] 			= scanRequired;
					EDoc_unique_id[i-2] 			= unique_id;
					EDoc_placeofissue[i-2] 			= placeofissue;
					EDoc_countryofissue[i-2] 		= countryofissue;
					EDoc_placeofissue_cat[i-2] 		= placeofissue_cat;
					EDoc_countryofissue_cat[i-2] 	= countryofissue_cat;
					EDoc_dateofissue[i-2] 			= dateofissue;
					EDoc_validity_date[i-2] 		= validity_date;
					EDoc_EntityDocumentID[i-2] 		= EntityDocumentID;
					EDoc_EntityDocumentURL[i-2] 	= EntityDocumentURL;
					EDoc_URL[i-2] 					= identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue;
					EDoc_IsDirty[i-2] 				= 'N';
					document.all.EDocRecordSet.rows(i).setAttribute("EntityDocumentModBO.url", identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue);
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
					if (isPreferredUniqueID == "Y"){
						document.all.EDocRecordSet.rows(i).
						childNodes(0).innerHTML="<INPUT TYPE='radio' name='radio1' onClick = 'AddSelectedRowToList()' CHECKED>";
						uniqueID =trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.ReferenceNumber"));
						uniqueIDType=trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IdentificationType"));

					}

				}
			}
		}
		// Tracker ID: 135125: XMLEncoding Changes ENDS
	}
}

// Changes for call id 417355 starts here
function changeGender(boName) {
   if(boName != 'ContactBO'){
        boName= document.frm2.boName.value;
        }
// Changes for call id 417355 ends here        
	var salutation = document.getElementsByName(boName+".Salutation_code")[0].value;
	//Ticket Id  - 203648 : Begin
	var sal = salutation.toLowerCase();
	if (sal == 'mr.' ) {
		document.getElementsByName(boName+".Gender")[0].value ='M';
	}
	else if (sal == 'mrs.' ||sal == 'ms.') {
	//Ticket Id  - 203648 : End
		document.getElementsByName(boName+".Gender")[0].value ='F';
	}
	/* Changes for the Tracker id:299800 and Ticket Id:490796 begins */
	
	/* else {
		document.getElementsByName(boName+".Gender")[0].value ='';
	} */
	
	/* Changes for the Tracker id:299800 and Ticket Id:490796 ends */
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
// KeyGeneration end

