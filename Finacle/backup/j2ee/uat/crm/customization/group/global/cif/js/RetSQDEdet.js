document.write('<script type="text/javascript" src="../common/js/Entity_Document.js" language="javascript"></script>');
document.write('<script language=javascript src="'+applPath+'/cif/js/Message_cif_'+finaclecrmlocale+'.js">'+'<\/script>');

var arraydoc_Type = new Array();
var docCodearr = new Array();
var elemStr;
var dualflag;
var CIF_Type = "Retail";
//changes for call id 367323 starts
var docCode_IDTypearr=new Array();
//changes for call id 367323 ends
var docCode_CIFTypearr = new Array();
var docType_docCodearr = new Array();
var docCode_docDescarr = new Array();
var doc_TypeDescarr = new Array();
//changes for call id 370280 starts
var docCode_IDTypearr=new Array();
//changes for call id 370280 ends

elemStr = new String(doc_Type);
if (elemStr != "") {
	arraydoc_Type = elemStr.split("|");
}
elemStr = new String(docCode);
if (elemStr != "") {
	docCodearr = elemStr.split("|");
}
//changes for call id 367323 starts
elemStr = new String(docCode_IDType);
if (elemStr!= ""){
	docCode_IDTypearr= elemStr.split("|");
}
//changes for call id 367323 ends
elemStr = new String(docCode_CIFType);
if (elemStr != "") {
	docCode_CIFTypearr = elemStr.split("|");
}

elemStr = new String(docType_docCode);
if (elemStr != "") {
	docType_docCodearr = elemStr.split("$");
}

elemStr = new String(docCode_docDesc);
if (elemStr != "") {
	docCode_docDescarr = elemStr.split("|");
}

elemStr = new String(doc_TypeDesc);
if (elemStr != "") {
	doc_TypeDescarr = elemStr.split("|");
}
//changes for call id 370280 starts
elemStr = new String(docCode_IDType);
if (elemStr!= ""){
	docCode_IDTypearr= elemStr.split("|");
}
//changes for call id 370280 ends
if (altLocaleActv == "true") {
	if (locale == altLocaleType) {
		dualflag = 0;
	} else if (locale == baseLocaleType) {
		dualflag = 1;
	}
} else {
	dualflag = 1;
}

if (boName == 'AccountBO') {
	entityDocumentBO_Name = 'EntityDocumentBO';
} else if (boName == 'AccountModBO') {
	entityDocumentBO_Name = 'EntityDocumentModBO';
}
//changes done for ticket id 435934 starts
function loadprimarysolid(){
/*Changes for firestone tracker id 350964  Starts*/
var indexValue= Cat_bcName.indexOf('#');
var Cat_value=Cat_bcName.substring(0,indexValue);
var Cat_textValue = Cat_bcName.substring(indexValue+1);
document.getElementsByName("Cat_AccountBO.Primary_sol_id")[0].value = Cat_textValue;
document.getElementsByName("AccountBO.Primary_sol_id")[0].value = Cat_value;
/*Changes for firestone tracker id 350964  Ends*/
}
//changes done for ticket id 435934 starts

// changes for call id 314285 ticket 592422 Tracker 353785 start
function populateCountry(){
	document.getElementsByName("AccountBO.Address.country")[0].value =code_country;
	//changes for tracker id id 361851 starts
	if(editMode){
	document.getElementsByName("AccountBO.Address.city")[0].value = cityCode;
	document.getElementsByName("AccountBO.Address.state")[0].value = stateCode;
//changes for call id 380596 and recon of call id 379953 starts
		//document.getElementsByName("AccountBO.Salutation_code")[0].value=salutation;
		//document.getElementsByName("Cat_AccountBO.Salutation_code")[0].value=cat_salutation;
//changes for call id 380596 and recon of call id 379953 ends
	}
// changes for call id 314285 ticket 592422 Tracker 353785 end
	//changes for tracker id id 361851 ends

	}
function fnLoad() {

	document.frm2.altLocaleActv.value = altLocaleActv;
	// parent.parent.parent.parent.hideSaveButton('true');
	//parent.frames[0].frames[3].hideSaveButton('true');
	//alert('frams'+parent.parent.frames[0].frames[0].name);
	
//	parent.frames[0].frames[3].all.saveBut.style.display = 'none';
	try {
		customLoad();
	} catch (e) {
	}
	try {
		var obj = parent.parent.parent.parent.frames(3);
		obj.enableButton_Ub();
		//changes for tracker 375136
		obj.hideSaveButton('true');
	} catch (e) {
	}
	if (isAutoGenKey == 'false' || isAutoGenKey == '') {
		document.getElementsByName("AccountBO.AccountKey")[0].IsMandatory = "true";
		document.getElementsByName("mandStarAccountBO.AccountKey")[0].style.visibility = "visible";
	}
	if (accountURL == "") {
		document.getElementsByName("AccountBO.AccountKey")[0].value = "";

		if (keyGeneration == 'Both'
				|| (keyGeneration == "" && (isAutoGenKey == 'false' || isAutoGenKey == ''))) {
			document.getElementsByName("AccountBO.AccountKey")[0].readOnly = false;
			if (keyGeneration != 'Both') {
				keyGeneration = 'Manual';
			}
		}
	}
	try {
		concatName();
		if (accountURL != '') {
			if (entityCreflg == 'N') {
				document.getElementsByName("AccountBO.AccountKey")[0].disabled = false;
				document.getElementsByName("AccountBO.AccountKey")[0].readOnly = false;
				document.getElementsByName("hid_cifid")[0].value = document
						.getElementsByName("AccountBO.AccountKey")[0].value;
			} else
				document.getElementsByName("AccountBO.AccountKey")[0].disabled = true;
		}
	} catch (ex) {
		// alert("ERROR7: " + ex.message);
	}

	if (nationality != null && nationality != "" && nationality != "undefined") {
		//changes for call id 379878 and recon of call id 379337 starts
		var indexValue= nationality_Text.indexOf('#');
		//Changes for tracker ID 448730 start
		var Nat_value=nationality;
		//Changes for tracker ID 448730 end
		var Nat_textValue = nationality_Text.substring(indexValue+1);
		document.getElementsByName("DemographicBO.Nationality")[0].value = Nat_value;
		document.getElementsByName("Cat_DemographicBO.Nationality")[0].value = Nat_textValue;
			//document.getElementsByName('DemographicBO.Nationality')[0].value = nationality;
	//changes for call id 379878 and recon of call id 379337 ends
	}
//Changes for call id 459500 and recon of 455727 starts
	//document.getElementsByName('AccountBO.Address.country')[0].value = cntryCode;
//Changes for call id 459500 and recon of 455727 ends
	document.getElementsByName('AccountBO.Address.state')[0].value = stateCode;
	document.getElementsByName('AccountBO.Address.city')[0].value = cityCode;

	if (docTypeCodeSel != null && docTypeCodeSel != "") {
		document.getElementsByName("EntityDocumentBO.DocTypeCode")[0].value = docTypeCodeSel;
		loadTypeData(document.getElementsByName("EntityDocumentBO.DocTypeCode")[0]);
		document.getElementsByName("EntityDocumentBO.DocCode")[0].value = docCodeSel;

	}
	if (document.frm2.hid_accountURL.value != '') {
		editMode = true;
	}
	//changes for tracker id 356455 starts
	
	locDate = getCurrentDate();		
											
	if(calType=='H')
	{	
	   locDate = convertGregToHij(locDate);
	}		
	//Changes for call id 399601 and recon of call id 395278 starts		
	if(document.getElementsByName('3_AccountBO.Address.Start_Date')[0].value == null || document.getElementsByName('3_AccountBO.Address.Start_Date')[0].value == ""){
	document.getElementsByName('3_AccountBO.Address.Start_Date')[0].value = locDate;
	}
	//Changes for call id 399601 and recon of call id 395278 ends
	//changes for tracker id 356455 ends
	//changes for call id: 350101
//changes for call id 379877 and recon of call id 378145 starts
//changes for call id 380596 and recon of call id 379953 starts
	//document.getElementsByName("AccountBO.Salutation_code")[0].value=salutation;
	//document.getElementsByName("Cat_AccountBO.Salutation_code")[0].value=cat_salutation;
//changes for call id 380596 and recon of call id 379953 ends
//changes for call id 379877 and recon of call id 378145 ends

}

function onRecordSelectCIFID(reservedID) {
	document.getElementsByName("AccountBO.AccountKey")[0].value = reservedID;
	document.getElementsByName("hid_reservestatus")[0].value = "Lookup";
	reserveCIFID = reservedID;
}

function loadDocCode(listObj) {
	var selectedType = listObj.options[listObj.selectedIndex].value;
	var selIndex = listObj.options[listObj.selectedIndex];
	loadSelectList(document.getElementsByName("EntityDocumentBO.DocCode")[0],
			docCodearr, selectedType);
}

function checkKeys() {
	if (event.keyCode == 42 || event.keyCode == 37) {
		event.keyCode = 0;
	}
}
       function setFocusOnComp(compName) {
            var elementName = document.getElementsByName(compName)[0];
            if(elementName) {
                if(elementName.displayFieldName){
                    elementName = document.getElementsByName(elementName.displayFieldName)[0];
                }
                if (elementName.type == "text" || elementName.type == "textarea")
                {
                    elementName.select();
                }else{
                    elementName.focus();
                }
            }
                    }

function checkStatus(elename, keyGeneration) {
	try {
		var elemValue = document.getElementsByName(elename)[0].value;
		if (elemValue == "" || reserveCIFID == elemValue
				|| keyGeneration == 'Reserved' || keyGeneration == "") {
			return;
		} else {
			checkReseravtion(elename, 'Retail', keyGeneration);
		}
	} catch (e) {

	}
}

function check(Tab, setFlag) {
//	try {
//		removePercentFormat('3_PsychographicBO.MiscellaneousInfo.dbFloat1');
//		removePercentFormat('3_PsychographicBO.MiscellaneousInfo.dbFloat2');
//		removePercentFormat('3_PsychographicBO.MiscellaneousInfo.dbFloat3');
//
//		FormatBeforeSave_Number('3_PsychographicBO.MiscellaneousInfo.dbFloat4');
//	} catch (e) {
//	}
	if (setFlag == false) {
		noValidationMsg = true;
	} else {
		noValidationMsg = false;
	}
	return parent.parent.parent.parent.ValidateFormContents(document.frm2,
			true, noValidationMsg, Tab);
}

function concatName() {
	var fullName = "";
	var lastNameLength = 0;
	var indexCustLastName = 0;
	var firstName = trim(document
			.getElementsByName("AccountBO.Cust_First_Name")[0].value);
	var middleName = trim(document
			.getElementsByName("AccountBO.Cust_Middle_Name")[0].value);
	var lastName = trim(document.getElementsByName("AccountBO.Cust_Last_Name")[0].value);
//changes for tracker 409869 begin
/**commenting to add equity changes*/
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
			fullName = fullName.toUpperCase();
			
		}
		else{
			fullName = "";
	} */
//changes for tracker 409869 ends
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
	 }
	
}

/** End of function concatName() * */

function txtLimit(field, max, str1, str2) {
	if (field.length > max + 1) {
		var tempList = new Array();
		tempList[0] = str2;
		tempList[1] = max;
		showUserMessage(MSGJ0063, tempList);
		document.getElementsByName(str1)[0].focus();
		return "false";
	} else {
		return "true";
	}
}
/** End of function txtLimit() * */

function fnConvertDate() {
	var arrDateList = new Array();
	var arrFinalDateList = new Array();
	var strALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
	var strCust_DOB = document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
	arrDateList[0] = strCust_DOB;
	var strLength = arrDateList.length - 1;
	if (strALTCALENDAR_TYPE = 'true') {
		for (iCount = 0; iCount <= strLength; iCount++) {
			strDate = arrDateList[iCount];
			if (strDate == '') {
				arrFinalDateList[iCount] = '';
			} else {
				var strFlag = isGregDateWithoutConv(strDate);
				if (strFlag != 'true') {
					strDate = convertHijToGreg(strDate);
					arrFinalDateList[iCount] = strDate;
				} else {
					arrFinalDateList[iCount] = strDate;
				}

			}
		}
		document.all.Cust_DOB.value = arrFinalDateList[0];
	}
}

/** End of function convertDate()* */

function clearValues() {
	document.frm2.address_type.value = "";
	document.frm2.country.value = "";
	document.frm2.city.value = "";
	document.frm2.state.value = "";
	document.frm2.start_date.value = "";
	document.frm2.zip.value = "";
	document.frm2.name.value = "";
}
/** End of function clearValues()* */

function changeGender() {
	var salutation = document.getElementsByName(boName + ".Salutation_code")[0].value;
	var sal = salutation.toLowerCase();
	if (sal == 'mr.') {
		document.getElementsByName(boName + ".Gender")[0].value = 'M';
	} else if (sal == 'mrs.' || sal == 'ms.') {
		document.getElementsByName(boName + ".Gender")[0].value = 'F';
	} else {
		document.getElementsByName(boName + ".Gender")[0].value = '';
	}
}

function validateMinorDOB() {
	isGregDate("3_AccountBO.Cust_DOB");
	var todaydate = new String();

	todaydate.value = getTodayDate1(locDate);

	var date = document.getElementsByName("3_AccountBO.Cust_DOB")[0];
	if (date.value != '') {
		todaydate.value = convertDate(todaydate.value);
	}

	var elem1 = document.getElementsByName("3_AccountBO.Cust_DOB")[0];
	var mill1 = changetoMillisForToday(todaydate.value);
	var mill2 = changetoMillis(elem1.value);

	if (mill1 < mill2) {
		showMessage(MSGX0060);
		document.getElementsByName("3_AccountBO.Cust_DOB")[0].value = '';
		document.getElementsByName("3_AccountBO.Cust_DOB")[0].focus();
		return;
	}
}

function checkAge()
		{
		var dob =document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
// call id:413154 changes
		/*if (dob == '') {
					
		document.getElementsByName("3_AccountBO.Cust_DOB")[0].focus();
				
				
		}
		else	{*/
			  	
		var dtFormDOB = gettingDateFormats();
		var  dobDay='';
		var  strMonth='';
		var  dobYear='';
		if(dtFormDOB == 'MM/dd/yyyy' || dtFormDOB == 'MM-dd-yyyy'){
		
			dobDay=dob.substring(3,5);
			strMonth=dob.substring(0,2);
			dobYear=dob.substring(6,10);
		}
		else{
			dobDay=dob.substring(0,2);
			strMonth=dob.substring(3,5);
			dobYear=dob.substring(6,10);
		}
		var isMinor = IsMinor(dobDay,strMonth,dobYear);
		if(isMinor=='true')
		{
		
			  // call id :413154 changes
			showMessage(MSGX0006);
			document.getElementsByName("3_AccountBO.Cust_DOB")[0].value='';
			document.getElementsByName("3_AccountBO.Cust_DOB")[0].focus();
			
			
			}	

// call id :413154 changes start
//document.getElementsByName(boName+".CustomerMinor")[0].value='Y';
				
			//}		
// call id :413154 changes end
		}
		
		function IsMinor(dobDay,dobMonth,dobYear){
		      var MINOR_YEAR = document.all.MINOR_YEAR.value;
		      date = new Date(locDate);
		      var thisYear = date.getYear() ;
		      var thisMonth = date.getMonth()+1 ;
		      var thisDay = date.getDate() ;
		      var yearDiff = thisYear - dobYear ;
		     
		      if ( yearDiff > MINOR_YEAR)
		      {
			  return 'false';
		      }
		      else if ( yearDiff < MINOR_YEAR)
		      {
			  return 'true';
		      }
		      else if ( thisMonth < dobMonth){
			  return 'true';
		      }
		      else if ( thisDay < dobDay){
			  return 'true';
		      }
		      else {
			  return 'false';
		      }
}
function changetoMillisForToday(datevalue) {
	if (datevalue.length == 0) {
		return 0;
	} else {
		date1 = new Date(datevalue.substring(3, 5) + "/"
				+ datevalue.substring(0, 2) + "/" + datevalue.substring(6, 10));
		var millis = date1.valueOf();
		return millis;
	}
}
function changetoMillis(datevalue) {
	if (datevalue.length == 0) {
		return 0;
	} else {
		var dtForm = gettingDateFormats();
		if (dtForm == 'MM/dd/yyyy' || dtForm == 'MM-dd-yyyy') {
			date1 = new Date(datevalue.substring(0, 2) + "/"
					+ datevalue.substring(3, 5) + "/"
					+ datevalue.substring(6, 10));
		} else {
			date1 = new Date(datevalue.substring(3, 5) + "/"
					+ datevalue.substring(0, 2) + "/"
					+ datevalue.substring(6, 10));
		}
		var millis = date1.valueOf();
		return millis;
	}
}
/** End of function changeToMillis() * */

function openEmployeeIDLookup() {
	var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=StaffEmployeeID&CategoryType=EMPLOYEE_ID";
	windowAlign();
	window
			.open(
					url,
					"Lookup",
					"height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
}
function clearEmployeeIDLookup() {
	document.getElementsByName("AccountBO.StaffEmployeeID")[0].value = "";
}

function onRecordSelectStaffEmp() {
	document.getElementsByName("AccountBO.StaffEmployeeID")[0].value = getCookie("LookupEmpID");
	document.getElementsByName("AccountBO.StaffEmployeeID")[0]
			.fireEvent("onChange");

}

function clear() {
	if ((IntWFID != null) & (IntWFID != undefined) & (IntWFID != '')) {
		Updatedb(IntWFID, "Accounts_Mod");
	}
	parent.parent.parent.parent.setButtonsVisible(true);
}
//changes for call id 367323 starts
// Function that load Doc Description when appropriate select DocCode is Selected.
function s_loadDocDesc(listObj)
{
    var selectedType = listObj.options[listObj.selectedIndex].value;
    var selIndex=listObj.options[listObj.selectedIndex];
    for(i=0;i < docCode_docDescarr.length;i++)
    {
        var elemStr = new String(docCode_docDescarr[i]);
        var elemArr = elemStr.split("=");
        var elemStr3 = new String(docCode_IDTypearr[i]);
        var elemArr2 = elemStr3.split("=");
        if(elemArr[0] == selectedType)
        {
			var elemStr1=new String(elemArr[1]);
			document.getElementsByName("EntityDocumentBO.DocDescr")[0].value=elemStr1;
			//Changes for callId 381073,recon of callid id 379583 Start
			
			document.getElementsByName("hidIdentificationType")[0].value=elemArr2[1];
			//Changes for callId 381073,recon of callid id 379583 End
			break;
    	}
    }
}
//changes for call id 367323 ends
// Fix For callid 389457 Starts
function validateIssueDate1(){   

	/* calling the function isGregDate for on blur functionality*/
	isGregDate("3_AccountBO.Address.Start_Date");


	var todaydate = new String();
	todaydate.value = getTodayDate1(locDate); 
	elem1 = document.getElementsByName("3_AccountBO.Address.Start_Date")[0];
	/* calling the function isGregDate for on blur functionality*/

	if (elem1.value != '')
	{
	todaydate.value = convertDate(todaydate.value);

	}
	
	var mill1 = changetoMillisInUSFormat(todaydate.value);
	var mill2 = changetoMillis(elem1.value);   

	if ( elem1.value > todaydate.value){
	showUserMessage("MSGJ50237");
	document.getElementsByName("3_AccountBO.Address.Start_Date")[0].value='';
	document.getElementsByName("3_AccountBO.Address.Start_Date")[0].focus();
	return;
	}
// Fix For callid 389457 ends
}
//changes for 450198

function loadrate()
{

	var len = document.getElementsByName("AccountBO.Rating")[0].options.length;
	
	for(i =0;i<len;i++)
	{


		if(document.getElementsByName("AccountBO.Rating")[0].options[i].text == Rating)
		{
		
			document.getElementsByName("AccountBO.Rating")[0].options[i].selected = true;
			break;
		}
		
	}
} 

//changes for 450198
