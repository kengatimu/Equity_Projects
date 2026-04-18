/* The RetSQDEdet_System.js is a XSLWorkbench generated JS file.*/

document
		.write('<script type="text/javascript" src="../cif/js/Message_cif_' + finaclecrmlocale + '.js"" language="javascript"></script>');
document
		.write('<script type="text/javascript" src="../common/js/Rendcommon.js" language="javascript"></script>');
document
		.write('<script type="text/javascript" src="../common/js/Reduce_Form.js" language="javascript"></script>');

/*Changes by Niharika for CR356016*/
document.write('<script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>');

	/*End of changes by Niharika for CR356016*/
var SwiftAddressDetails = "";

function call() {
	for (i = 0; i < document.all.RecordSet.rows.length; i++) {
		var row_bgcolor = document.all.RecordSet.rows(i).className;
		if (row_bgcolor == 'rowHighLighted') {
			if (i % 2 == 0) {
				document.all.RecordSet.rows(i).className = 'color1';
			} else {
				document.all.RecordSet.rows(i).className = 'color2';
			}
		}
	}
	if (event.srcElement.tagName == 'FONT'
			|| event.srcElement.tagName == 'INPUT') {
		event.srcElement.parentElement.parentElement.className = "rowHighLighted";
	} else if (event.srcElement.tagName == 'TD') {
		event.srcElement.parentElement.className = "rowHighLighted";
	}

}

/** End of function call() * */

function save(saveFlag) {
//Adhar changes for tracker 375136 start
var EdocCode_U = document.getElementsByName('EntityDocumentBO.DocCode')[0].value;
var ident_typeU;

var docCode_IDTypearr=new Array();
var elemStr;
elemStr = new String(docCode_IDType);
	if (elemStr!= ""){
		docCode_IDTypearr= elemStr.split("|");
	}
	 for(i=0;i < docCode_IDTypearr.length;i++){
	   	var elemStr3 = new String(docCode_IDTypearr[i]);
	        var elemArr2 = elemStr3.split("=");
	        if(elemArr2[0]==EdocCode_U){
	        	ident_typeU =elemArr2[1];
	        }
	}
	
	
	if(ident_typeU != null && ident_typeU != "" && ident_typeU !=undefined && ident_typeU == "Unique Identification Number"){
	var refObj = document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0];
	var refNum = document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0].value;
	 if(isNaN(refNum)) {
			   showMessage("Please enter a 12 digit numeric value for Unique Id.");
			   refObj.select();
			   return 'false';
		}
	if(refNum.length > 12 || refNum.length < 12) {
			   showMessage("Please enter a 12 digit numeric value for Unique Id.");
			   refObj.select();
			   return 'false';
		}
	}
//recon for call id 374174 and changes for call id 372009 starts
       document.frm2.hidUniqueIDType.value = ident_typeU;
      //recon for call id 374174 and changes for call id 372009 ends
	//Adhar changes for tracker 375136 end
//Checking national id card with custom on onboard menu national id card
var docType = document.getElementsByName("EntityDocumentBO.DocTypeCode")[0].value;
var docCode = document.getElementsByName("EntityDocumentBO.DocCode")[0].value;

document.frm2.currencyCode.value=Currency;


if(operationType != "Edit Entity")
{
{
	var Filter_uniqueId = getCookie('Filter_uniqueId');
	var Filter_documentcode = getCookie('Filter_documentcode');
	
	//alert("docType "+docType);
	//alert("docCode "+docCode);
	//alert("Filter_uniqueId "+Filter_uniqueId);
	//alert("Filter_documentcode "+Filter_documentcode);
	
	if(document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].value != Filter_uniqueId || Filter_documentcode!=docCode)
	{
		alert("The identification document details do not match with the details entered in customer onboard menu");
		document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].focus();
		return "interactive";
	}
}
}
	if (document.frm2.isMCEdited.value == "Y") {
		document.frm2.isMCEditedGeneral.value = "Y";
	}
	try {
		customSave();

		var hasOtherErrors = false;

		if (document.getElementsByName("AccountBO.ACCOUNTKEY")[0].value == "") {
			if (document.all.isAutoGenKey.value == 'true') {
				document.getElementsByName("AccountBO.ACCOUNTKEY")[0].IsMandatory = 'N';
			}
		}
		if (saveFlag == true) {
			noValidationMsg = false;
		} else {
			noValidationMsg = true;
		}

		var chkStat = "true";

		if (chkStat != "true") {
			return 'interactive_sqde';
		}
		if (saveFlag == false) {
			var validate = false;
			if (document.getElementsByName("AccountBO.Cust_Last_Name")[0].value == "") {
				parent.parent.parent.parent.messageFrm.addMessage(selTabId,
						getUserMessage("MSG086", "'Last Name'"),
						'AccountBO.Cust_Last_Name', 'HYPER_LINK');
				
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			    validate = "true";
			}
			if (document.getElementsByName("AccountBO.AccountKey")[0].value == "") {
				if (document.all.isAutoGenKey.value == 'true') {
					document.getElementsByName("AccountBO.ACCOUNTKEY")[0].IsMandatory = 'N';
				} else {
				//changes for ticket id-701600 starts
					parent.parent.parent.parent.messageFrm.addMessage(selTabId,
							getUserMessage("MSG086", "'Customer ID'"),
							'AccountBO.AccountKey', 'HYPER_LINK');
				//changes for ticket id-701600 ends
					parent.parent.parent.parent.messageFrm
							.showMessages(selTabId);
					//parent.parent.parent.parent.hideSaveButton('true');
					validate = "true";
					
				}
			}
			if (validate == "true") {
				return 'interactive_sqde';
			}
		}
		if (saveFlag == false) {
			document.frm2.saveFlag.value = 1;
		} else {
			document.frm2.saveFlag.value = 0;
		}

		if (saveFlag == true) {
			if (chkStat != "true" || hasOtherErrors == "true") {
				return 'interactive_sqde';
			}
		}
		selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();

		var isNRE;

		if (document.getElementsByName(boName + ".CustomerNREFlg")[0].value == "Y") {
			isNRE = true;
		} else {
			isNRE = false;
		}
		if (saveFlag == true) {
			preferredPhone = document
					.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType')[0];
			preferredEmail = document
					.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType1')[0];
			var preferredPhoneFlag = false;
			var preferredEmailFlag = false;

			var phoneCheck = phoneEmailCheck();
			if (phoneCheck == "false" || phoneCheck == false) {
				return "interactive_sqde";
			}

			if ((preferredPhone.value != null && preferredPhone.value != 'undefined')
					|| (preferredEmail.value != null && preferredEmail.value != 'undefined')) {
				for ( var r = 0; r < document.all.PhoneEmailRecordSet.rows.length; r++) {
					if (boName == 'AccountBO') {
						recordSetPhone = document.all.PhoneEmailRecordSet.rows(
								r).getAttribute(
								"AccountBO.PhoneEmail.PhoneEmailType");
						recordSetPhone1 = document.all.PhoneEmailRecordSet
								.rows(r).getAttribute(
										"AccountBO.PhoneEmail.PhoneEmailType1");
					} else if (boName == 'AccountModBO') {
						recordSetPhone = document.all.PhoneEmailRecordSet.rows(
								r).getAttribute(
								"AccountModBO.PhoneEmail.PhoneEmailType");
						recordSetPhone1 = document.all.PhoneEmailRecordSet
								.rows(r)
								.getAttribute(
										"AccountModBO.PhoneEmail.PhoneEmailType1");
					}
					if (preferredPhone.value == recordSetPhone
							&& preferredPhone.value != null) {
						preferredPhoneFlag = true;
					}
					if (preferredEmail.value == recordSetPhone1
							&& preferredEmail.value != null) {
						preferredEmailFlag = true;
					}
				}
			}
		}

	} catch (e) {
	}

	addEduCounter = 0;
	clearValues();
	try {
		//Changes for call id 399601 and recon of call id 395278 starts
		if(preferredAddressType==null || preferredAddressType==''){
		document.frm2.address_type.value = defAddress;
		}
		else{
		document.frm2.address_type.value = preferredAddressType;
		}
		//Changes for call id 399601 and recon of call id 395278 ends
		document.frm2.PhoneNoLocalCode.value = document
				.getElementsByName("AccountBO.PhoneEmail.PhoneNo.localCode")[0].value;
		document.frm2.PhoneNoCityCode.value = document
				.getElementsByName("AccountBO.PhoneEmail.PhoneNo.areacode")[0].value;
		document.frm2.PhoneNoCountryCode.value = document
				.getElementsByName("AccountBO.PhoneEmail.PhoneNo.cntrycode")[0].value;
	} catch (ge) {
		DebugMessage(ge.message);
	}
	document.getElementsByName("hidDocCode")[0].value = document
			.getElementsByName("EntityDocumentBO.DocCode")[0].value;
	document.getElementsByName("hidDocTypeCode")[0].value = document
			.getElementsByName("EntityDocumentBO.DocTypeCode")[0].value;

	var flag = false;

	if (defAddress == "M")
		defAddress = "Mailing";
	else if (defAddress == "H")
		defAddress = "Home";
	else if (defAddress == "W")
		defAddress = "Work";

	fnConvertDate();
	newPara = document.getElementById("myPar");

	var frame = 'formSaveFrame';
	//Changes for tracker ID 457939

	document.frm2.manager.value = manager;
	if (chkStat == true || chkStat == "true") {
		if (document.frm2.isMCEditedGeneral.value == "N") {
			appFlag = "false";
		}
 document.getElementsByName("AccountBO.Primary_sol_id")[0].disabled=false;
 document.getElementsByName("Cat_AccountBO.Primary_sol_id")[0].disabled=false;
 document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].disabled=false;

		if ((appFlag == "false" && operationType == "null" && saveFlag == true)
				|| (appFlag == "true" && operationType == "null" && saveFlag == true)
				|| (appFlag == "false" && operationType == "Edit Entity" && saveFlag == true)
				|| (appFlag == "true" && operationType == "Edit Entity" && saveFlag == true)) {

			var SubmitURL = "../servlet/com.infy.cis.ui.cif.RetSQDEWriter?IntWFID="
					+ IntWFID
					+ "&SwiftAddressDetails="
					+ SwiftAddressDetails
					+ "&dual=" + dualflag;

			document.frm2.action = SubmitURL;
			document.frm2.target = 'formSaveFrame';
			document.frm2.submit();

			// fnRemoveNull(newPara, SubmitURL, document.frm2, frame);
		}
	}
	flag = true;
	clearValues();
	return 'true';
}
/** End of function save() * */

function loadID() {
	try {
		customLoad();
	} catch (e) {
	}
	if (document.frm2.hid_accountURL.value != '') {
		editMode = true;
		if (entityDocumentBO_Name == 'EntityDocumentBO') {
			for (i = 2; i < document.all.EDocRecordSet.rows.length; i++) {
				var EntityDocumentID = document.all.EDocRecordSet.rows(i)
						.getAttribute("EntityDocumentBO.EntityDocumentID");
				if ((EntityDocumentID != null)
						&& (EntityDocumentID != 'undefined')) {
					identifier_type_Code = trim(document.all.EDocRecordSet
							.rows(i).getAttribute(
									"EntityDocumentBO.IdentificationType"));
					unique_id = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.ReferenceNumber"));
					placeofissue = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.PlaceOfIssue"));
					placeofissue_cat = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("Cat_EntityDocumentBO.PlaceOfIssue"));
					countryofissue = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.CountryOfIssue"));
					countryofissue_cat = trim(document.all.EDocRecordSet
							.rows(i).getAttribute(
									"Cat_EntityDocumentBO.CountryOfIssue"));
					dateofissue = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.DocIssueDate"));
					validity_date = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.DocExpiryDate"));
					EntityDocumentID = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.EntityDocumentID"));
					EntityDocumentURL = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.url_"));
					docCode = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.DocCode"));
					docDescr = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.DocDescr"));
					docTypeCode = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.DocTypeCode"));
					docTypeDescr = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.DocTypeDescr"));
					docReceivedDate = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.DocReceivedDate"));
					docRemarks = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.DocRemarks"));
					status = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.Status"));
					isMandatory = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.IsMandatory"));
					scanRequired = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentBO.ScanRequired"));
					isPreferredUniqueID = trim(document.all.EDocRecordSet.rows(
							i).getAttribute(
							"EntityDocumentBO.PreferredUniqueId"));
					EDoc_identifier_type_Code[i - 2] = identifier_type_Code;
					EDoc_docCode[i - 2] = docCode;
					EDoc_docDescr[i - 2] = docDescr;
					EDoc_docTypeCode[i - 2] = docTypeCode;
					EDoc_docTypeDescr[i - 2] = docTypeDescr;
					EDoc_docReceivedDate[i - 2] = docReceivedDate;
					EDoc_docRemarks[i - 2] = docRemarks;
					EDoc_Status[i - 2] = status;
					EDoc_isMandatory[i - 2] = isMandatory;
					EDoc_scanRequired[i - 2] = scanRequired;
					EDoc_unique_id[i - 2] = unique_id;
					EDoc_placeofissue[i - 2] = placeofissue;
					EDoc_countryofissue[i - 2] = countryofissue;
					EDoc_placeofissue_cat[i - 2] = placeofissue_cat;
					EDoc_countryofissue_cat[i - 2] = countryofissue_cat;
					EDoc_dateofissue[i - 2] = dateofissue;
					EDoc_validity_date[i - 2] = validity_date;
					EDoc_EntityDocumentID[i - 2] = EntityDocumentID;
					EDoc_EntityDocumentURL[i - 2] = EntityDocumentURL;
					EDoc_URL[i - 2] = identifier_type_Code + unique_id
							+ placeofissue + dateofissue + countryofissue;
					EDoc_IsDirty[i - 2] = 'N';
					document.all.EDocRecordSet.rows(i).setAttribute(
							"EntityDocumentBO.url",
							identifier_type_Code + unique_id + placeofissue
									+ dateofissue + countryofissue);
					var objHidUniqueID = document
							.getElementsByName(identifier_type_Code + ".txt_ID")[0];
					if (objHidUniqueID != null) {
						objHidUniqueID.value = unique_id;
					}
					var objHidIssueDate = document
							.getElementsByName(identifier_type_Code
									+ ".txt_Issue_Date")[0];
					if (objHidIssueDate != null) {
						objHidIssueDate.value = dateofissue;
					}
					var objHidValidDate = document
							.getElementsByName(identifier_type_Code
									+ ".txt_Valid_Date")[0];
					if (objHidValidDate != null) {
						objHidValidDate.value = validity_date;
					}
					var objHidIssuePlace = document
							.getElementsByName(identifier_type_Code
									+ ".txt_Issue_Place")[0];
					if (objHidIssuePlace != null) {
						objHidIssuePlace.value = placeofissue;
					}
					if (isPreferredUniqueID == "Y") {
						document.all.EDocRecordSet.rows(i).childNodes(0).innerHTML = "<INPUT TYPE='radio' name='radio1' onClick = 'AddSelectedRowToList()' CHECKED>";
						uniqueID = trim(document.all.EDocRecordSet.rows(i)
								.getAttribute(
										"EntityDocumentBO.ReferenceNumber"));
						uniqueIDType = trim(document.all.EDocRecordSet.rows(i)
								.getAttribute(
										"EntityDocumentBO.IdentificationType"));
					}
				}
			}
		} else if (entityDocumentBO_Name == 'EntityDocumentModBO') {

			for (i = 2; i < document.all.EDocRecordSet.rows.length; i++) {
				var EntityDocumentID = document.all.EDocRecordSet.rows(i)
						.getAttribute("EntityDocumentBO.EntityDocumentID");
				if ((EntityDocumentID != null)
						&& (EntityDocumentID != 'undefined')) {
					identifier_type_Code = trim(document.all.EDocRecordSet
							.rows(i).getAttribute(
									"EntityDocumentModBO.IdentificationType"));
					unique_id = trim(document.all.EDocRecordSet
							.rows(i)
							.getAttribute("EntityDocumentModBO.ReferenceNumber"));
					placeofissue = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.PlaceOfIssue"));
					placeofissue_cat = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute(
									"Cat_EntityDocumentModBO.PlaceOfIssue"));
					countryofissue = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.CountryOfIssue"));
					countryofissue_cat = trim(document.all.EDocRecordSet
							.rows(i).getAttribute(
									"Cat_EntityDocumentModBO.CountryOfIssue"));
					dateofissue = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.DocIssueDate"));
					validity_date = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.DocExpiryDate"));
					EntityDocumentID = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute(
									"EntityDocumentModBO.EntityDocumentID"));
					EntityDocumentURL = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.url_"));
					docCode = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.DocCode"));
					docDescr = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.DocDescr"));
					docTypeCode = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.DocTypeCode"));
					docTypeDescr = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.DocTypeDescr"));
					docReceivedDate = trim(document.all.EDocRecordSet
							.rows(i)
							.getAttribute("EntityDocumentModBO.DocReceivedDate"));
					docRemarks = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.DocRemarks"));
					status = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.Status"));
					isMandatory = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.IsMandatory"));
					scanRequired = trim(document.all.EDocRecordSet.rows(i)
							.getAttribute("EntityDocumentModBO.ScanRequired"));
					isPreferredUniqueID = trim(document.all.EDocRecordSet.rows(
							i).getAttribute(
							"EntityDocumentModBO.PreferredUniqueId"));
					EDoc_identifier_type_Code[i - 2] = identifier_type_Code;
					EDoc_docCode[i - 2] = docCode;
					EDoc_docDescr[i - 2] = docDescr;
					EDoc_docTypeCode[i - 2] = docTypeCode;
					EDoc_docTypeDescr[i - 2] = docTypeDescr;
					EDoc_docReceivedDate[i - 2] = docReceivedDate;
					EDoc_docRemarks[i - 2] = docRemarks;
					EDoc_Status[i - 2] = status;
					EDoc_isMandatory[i - 2] = isMandatory;
					EDoc_scanRequired[i - 2] = scanRequired;
					EDoc_unique_id[i - 2] = unique_id;
					EDoc_placeofissue[i - 2] = placeofissue;
					EDoc_countryofissue[i - 2] = countryofissue;
					EDoc_placeofissue_cat[i - 2] = placeofissue_cat;
					EDoc_countryofissue_cat[i - 2] = countryofissue_cat;
					EDoc_dateofissue[i - 2] = dateofissue;
					EDoc_validity_date[i - 2] = validity_date;
					EDoc_EntityDocumentID[i - 2] = EntityDocumentID;
					EDoc_EntityDocumentURL[i - 2] = EntityDocumentURL;
					EDoc_URL[i - 2] = identifier_type_Code + unique_id
							+ placeofissue + dateofissue + countryofissue;
					EDoc_IsDirty[i - 2] = 'N';
					document.all.EDocRecordSet.rows(i).setAttribute(
							"EntityDocumentModBO.url",
							identifier_type_Code + unique_id + placeofissue
									+ dateofissue + countryofissue);
					var objHidUniqueID = document
							.getElementsByName(identifier_type_Code + ".txt_ID")[0];
					if (objHidUniqueID != null) {
						objHidUniqueID.value = unique_id;
					}
					var objHidIssueDate = document
							.getElementsByName(identifier_type_Code
									+ ".txt_Issue_Date")[0];
					if (objHidIssueDate != null) {
						objHidIssueDate.value = dateofissue;
					}
					var objHidValidDate = document
							.getElementsByName(identifier_type_Code
									+ ".txt_Valid_Date")[0];
					if (objHidValidDate != null) {
						objHidValidDate.value = validity_date;
					}
					var objHidIssuePlace = document
							.getElementsByName(identifier_type_Code
									+ ".txt_Issue_Place")[0];
					if (objHidIssuePlace != null) {
						objHidIssuePlace.value = placeofissue;
					}
					if (isPreferredUniqueID == "Y") {
						document.all.EDocRecordSet.rows(i).childNodes(0).innerHTML = "<INPUT TYPE='radio' name='radio1' onClick = 'AddSelectedRowToList()' CHECKED>";
						uniqueID = trim(document.all.EDocRecordSet.rows(i)
								.getAttribute(
										"EntityDocumentModBO.ReferenceNumber"));
						uniqueIDType = trim(document.all.EDocRecordSet
								.rows(i)
								.getAttribute(
										"EntityDocumentModBO.IdentificationType"));

					}

				}
			}
		}
		// Tracker ID: 135125: XMLEncoding Changes ENDS
	}
}

/** End of function loadID() * */

function onRecordSelectCIFID(reservedID) {
	document.getElementsByName("AccountBO.AccountKey")[0].value = reservedID;
	document.getElementsByName("hid_reservestatus")[0].value = "Lookup";
	reserveCIFID = reservedID;
}

function closebtn() {
/*Changes by Niharika to call a new screen like Customer Onboard*/
	if (accountURL == '') {
		//parent.frames(0).location.href = parent.frames(0).location.href;
	} else {
		top.window.close();
	}
	//parent.parent.frames(0).location.href = parent.parent.frames(0).location.href;
var dataArea = parent.parent.parent.parent.parent;
var screenTitle= parent.parent.parent.parent.parent.parent.ScreenTitleFrm;
screenTitle.titleMsg.innerHTML = "CIF Retail > New Entity > Customer Onboarding";
dataArea.location.href="../../../servlet/com.infy.cis.custom.OnboardDetWizard?type=Retail";

/*End of changes by Niharika to call a new screen like Customer Onboard*/
	//parent.parent.frames(0).location.href = parent.parent.frames(0).location.href;
}

function loadSubSeg()
{
//added function for tracker 382557
}
function selectProcess() {

	var entityType = "";
	if (document.frm2.mcJNDIFlag.value == "true"
			&& document.frm2.isMCEditedGeneral.value == "N") {
		appFlag = "false";
	}
	if (appFlag == 'true') {
		entityType = "AccountMod";
	} else {
		entityType = "Account";
	}
	//Checksum recon from 10.3 SUPP
	var secureHKey = document.getElementsByName("SECUREHKEY")[0].value;	
	var keyField = document.getElementsByName("FLDHASHKEY")[0].value;						
	//Checksum recon from 10.3 SUPP
	var accountId = parent.formSaveFrame.savedValue;
	/*Changes by Niharika for CR356016*/
	/*window.open(
					'../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='
							+ accountId + '&entityType=' + entityType
							+ '&IntWFID=' + IntWFID +'&SECUREHKEY='+secureHKey+'&FLDHASHKEY='+keyField+'&isPopup=Yes',
					'save',
					'directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');*/

		var strProcessURL = '../servlet/com.infy.cis.custom.EquityRetailProcessSelection?entityId='+accountId+'&entityType='+entityType;
			var strBOURL = accountURL;
			//alert('strBOURL    '+strBOURL);
			//alert('strProcessURL     '+strProcessURL);
			fnProcessSelection(strProcessURL, strBOURL);
       		/*End of changes by Niharika for CR356016*/
}