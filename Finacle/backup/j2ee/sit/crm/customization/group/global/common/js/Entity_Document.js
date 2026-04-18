// Function which is called on load of the form that populates data in DocCode select list.

function populateDocCodeOnLoad()
{
    createTypeData(docCodearr, document.getElementsByName("EntityDocumentBO.DocCode")[0]);
}
// Function which is called on load of the form that populates the data in DocTypeCode select list.

function populateDocTypeOnLoad()
{
    createTypeData(arraydoc_Type, document.getElementsByName("EntityDocumentBO.DocTypeCode")[0]);
}

//changes for tracker id 260265 starts
function loadCodeforType(listObj)
{
	loadSelectList(document.getElementsByName("EntityDocumentBO.DocCode")[0], docType_docCodearr, listObj);
}
//changes for tracker id 260265 ends

// Function that creates select list options for each type data.
function createTypeData(dataArr, typeObj)
{
    for(i=0;i < dataArr.length;i++)
    {
		var o = new Option(dataArr[i],dataArr[i]);
		typeObj.options[typeObj.options.length] = o;
    }
}

// Function that clears the given select list and retains the [None] value alone.
function clearList(typeObj)
{
    typeObj.options.length = 1;
    typeObj.selectedIndex = 0;
}

// Function takes arrDocCodes, filters the arrDocCodes for particular CIF_Type, and returns the arrFilterDocCodes
function filterDocCodeForCIF(arrDocCodes)
{
	arrFilterDocCodes=new Array();
	var iFiltered=-1;
//	alert('filtering CIF_Type: ' + CIF_Type);
	for(i=0;i<arrDocCodes.length;i++)
	{
		tempDocCode=arrDocCodes[i];
		for(j=0;j<docCode_CIFTypearr.length;j++)
		{
			docCode_CIFType=docCode_CIFTypearr[j].split("=");
//			alert("comparing " + tempDocCode + " with " + docCode_CIFType[0] + " and " + docCode_CIFType[1]);
			if(tempDocCode==docCode_CIFType[0])
			{
				if(CIF_Type.toUpperCase()==docCode_CIFType[1].toUpperCase()) // Changes for call id 556482
				{
					arrFilterDocCodes[++iFiltered]=arrDocCodes[i];
//					alert('filtered:' + arrDocCodes[i]);
				}
				break;
			}
		}
	}
	return arrFilterDocCodes;
}

// Function that populates the select list
function loadSelectList(typeObj,typeDataArr,selectedType)
{
    var dataArr = new Array();
    dataArr = getDataArray(typeDataArr,selectedType);
    //changes for recon callID 151489 BEGIN
    if(CIF_Type!=null)
    {
		dataArr=filterDocCodeForCIF(dataArr)
	}
   //changes for recon callID 151489 END
//	alert(dataArr);
    clearList(typeObj);
    createTypeData(dataArr, typeObj);
}

// Function that creates the type data array
function getDataArray(typeDataArr,selectedType)
{
    var dataArray = new Array();
    var boolSelected = 0;

    for(i=0;i < typeDataArr.length;i++){
		var elemStr = new String(typeDataArr[i]);
		var elemArr = elemStr.split("=");

		if(elemArr[0] == selectedType){
			var elemStr1=new String(elemArr[1]);
			var elemArr1 = elemStr1.split("|");
			boolSelected =1;
			break;
		}
    }
    if(boolSelected ==1)
    return elemArr1 ;
    else
    return docCodearr;
}

// Function that loads the type data in appropriate select list.
function loadTypeData(listObj)
{
    var selectedType = listObj.options[listObj.selectedIndex].value;
    // added if/else condition for fixing the ticketID: 435634
    if (selectedType != null && selectedType != ""){

        var selIndex=listObj.options[listObj.selectedIndex];
        document.getElementsByName("EntityDocumentBO.DocTypeDescr")[0].value="";
//changes for tracker 375136 
	for(i=0;i < doc_TypeDescarr.length;i++)
	{
		var elemStr = new String(doc_TypeDescarr[i]);
		var elemArr = elemStr.split("=");
		if(elemArr[0] == selectedType)
		{
			var elemStr1=new String(elemArr[1]);
			if(elemStr1=='null'){
				break;
			}
			document.getElementsByName("EntityDocumentBO.DocTypeDescr")[0].value=elemStr1;
			break;
		}
	}

	document.getElementsByName("EntityDocumentBO.DocDescr")[0].value="";
	loadSelectList(document.getElementsByName("EntityDocumentBO.DocCode")[0], docType_docCodearr, selectedType);
	
     }else{
     	clearList(document.getElementsByName("EntityDocumentBO.DocCode")[0]);
     }
}

// Function that load Doc Description when appropriate select DocCode is Selected.
function loadDocDesc(listObj)
{
//	alert('loadDocDesc');
    var selectedType = listObj.options[listObj.selectedIndex].value;
    var selIndex=listObj.options[listObj.selectedIndex];

    for(i=0;i < docCode_docDescarr.length;i++)
    {
        var elemStr = new String(docCode_docDescarr[i]);
        var elemArr = elemStr.split("=");

        var elemStr2 = new String(isExpiryDateMandatoryarr[i]);
        var elemArr1 = elemStr2.split("=");

        var elemStr3 = new String(docCode_IDTypearr[i]);
        var elemArr2 = elemStr3.split("=");

        if(elemArr[0] == selectedType)
        {
			var elemStr1=new String(elemArr[1]);
			document.getElementsByName("EntityDocumentBO.DocDescr")[0].value=elemStr1;
			document.getElementsByName("hidIdentificationType")[0].value=elemArr2[1];

			if(elemArr1[1]=="Y")
			{
				document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].readOnly=false;
				document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].setAttribute('IsMandatory','true');
				document.getElementsByName("mandStarEntityDocumentBO.DocExpiryDate")[0].style.visibility="visible";
				//defect number 537 fix tracker id 113227 starts here
				
				// Tracker #: 123062 BEGINS Here
				//10.2 Fix tracker 187372
				document.getElementsByTagName("img")[1].style.visibility='visible';
				document.getElementsByTagName("img")[1].style.display='';
				//document.getElementsByTagName("img")[3].style.visibility='visible';
				// Tracker #: 123062 ENDS Here
				
				//tracker id 113227 ends here
			}
			else
			{
				document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].value="";
				document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].readOnly=true;
				document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].setAttribute('IsMandatory','false');
				document.getElementsByName("mandStarEntityDocumentBO.DocExpiryDate")[0].style.visibility="hidden";
				//defect number 537 fix tracker id 113227 starts here
				
				// Tracker #: 123062 BEGINS Here
				//10.2 Fix tracker 187372
				document.getElementsByTagName("img")[1].style.visibility='hidden';
				document.getElementsByTagName("img")[1].style.display='none';
				//document.getElementsByTagName("img")[3].style.visibility='hidden';
				// Tracker #: 123062 ENDS Here
				
				//tracker id 113227 ends here
			}
			break;
    	}
    }
}

function checkWithIssueDate()
{
/*	if(boolIsExpDtMand==false){
		return;
	}
*/

/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
		/* calling the function isGregDate for on blur functionality*/
/* Fix for call id: 561269 starts */
     	isGregDate_IOC("3_EntityDocumentBO.DocExpiryDate");
/* Fix for call id: 561269 ends */
     	/*ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/
     	
     	
 /* vineet changes end here*/



	var validityDate = document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0];
	var issueDate = document.getElementsByName("3_EntityDocumentBO.DocIssueDate")[0];
	var mill1 = changetoMillis(issueDate.value);
	var mill2 = changetoMillis(validityDate.value);
	if(issueDate.value!='' && validityDate.value!='')
	{
		if (mill1 > mill2)
		{
			showMessage(MSGX0043);
			validityDate.value = '';
			validityDate.focus();
			return "false";
		}
	}
	/* Changes for the tracker id 147568 starts here
	 * check whether the expiry Date is less than the current Date 
     */
    
	var todaydate = new String();
 	todaydate.value =  getTodayDate1();
 	todaydate.value = convertDate(todaydate.value);
 	var currDate = changetoMillis(todaydate.value);	
	
	if(validityDate.value!='') {		
		if(mill2 < currDate){
			showMessage(MSG50528);<!-- Fix for ticket 296582 -->
			validityDate.value = '';
			validityDate.focus();
			return "false";
		}
	}
	/* Changes for the tracker id 147568 ends here */
	return "true";
}
function validateIssueDate()
{
       /*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
		/* calling the function isGregDate for on blur functionality*/
/* Fix for call id: 561269 starts */
	        isGregDate_IOC("3_EntityDocumentBO.DocIssueDate");
/* Fix for call id: 561269 ends */
	        /*ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/
	       
	        
   /* vineet changes end here*/
       
	var todaydate = new String();
	todaydate.value = getTodayDate();
	
/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
var date = document.getElementsByName("3_EntityDocumentBO.DocIssueDate")[0];
if (date.value != '')
{
		/* calling the function isGregDate for on blur functionality*/
		todaydate.value = convertDate(todaydate.value);
		/*ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/
					
}					
					 /* vineet changes end here*/	
	
	
	elem1 = document.getElementsByName("3_EntityDocumentBO.DocIssueDate")[0];
	
	/*Admin Locale Date Format 330982 issue correction Start : done by Swathi_Baratam */
	//var mill1 = changetoMillisInUSFormat(todaydate.value);
	var mill1 = changetoMillis(todaydate.value);
	/*Admin Locale Date Format 330982 issue correction End*/
	var mill2 = changetoMillis(elem1.value);
	//alert("mill1"+mill1);
	//alert("mill2"+mill2);
	if(mill1 < mill2)
	{
		showMessage(MSGX0039);
		elem1.value = "";
		elem1.focus();
		return "false";
	}
//FIX FOR  TRACKER ID 162037 START
       //Comparing incorporation date with issue date
// Call id 433921 changes Start
	for(j=0;j<docCode_CIFTypearr.length;j++)
		{
			docCode_CIFType=docCode_CIFTypearr[j].split("=");
			
// FIX for call id: 729085 starts 
			//if(tempDocCode==docCode_CIFType[0])
			if(document.getElementsByName("EntityDocumentBO.DocCode")[0].value==docCode_CIFType[0])
//Changes for TOL 729085 ends			
			{
				if(CIF_Type==docCode_CIFType[1])
				{
					if(top.window.opener.boName == "CorporateBO" || top.window.opener.boName == "CorporateModBO"){
						var incorporation_date = top.window.opener.document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0];
						compareDOB(incorporation_date,mill2);
					}
					if(incorporationDate1 != null && incorporationDate1 != '' && incorporationDate1 != 'undefined'){
						compareDOB(incorporationDate1,mill2);
					}
				}
			}			
// Call id 433921 changes End
       }
//FIX FOR TRACKER ID 162037 END


	//Tracker:161726 begin
	//Comparing DOB with issue date
	if(top.window.opener.boName == "AccountBO" || top.window.opener.boName == "AccountModBO")
	{
		var dob = top.window.opener.document.getElementsByName("3_AccountBO.Cust_DOB")[0];
		compareDOB(dob,mill2);
	}
	else if(top.window.opener.boName == "SuspectBO" || top.window.opener.boName == "SuspectModBO")
	{
		var dob = top.window.opener.document.getElementsByName("3_SuspectBO.Suspects_DOB")[0];
		compareDOB(dob,mill2);
	}else if(top.window.opener.boName == "NonCustomerBO" || top.window.opener.boName == "NonCustomerModBO")
	{
		var dob = top.window.opener.document.getElementsByName("3_NonCustomerBO.DOB")[0];
		compareDOB(dob,mill2);
		
	}
	else if(top.window.opener.boName == "ContactBO" || top.window.opener.boName == "ContactModBO")
	{
		var dob = top.window.opener.document.getElementsByName("3_ContactBO.DOB")[0];
		compareDOB(dob,mill2);			
		
	}
	//Tracker:161726 end
		
	
	
	return "true";
}
//Tracker:161726 begin
//function to compare dob with date of issue
function compareDOB(dob,mill2)
{
// Call id 433921 changes Start
var valueToUse;
	if(incorporationDate1 != 'undefined' && incorporationDate1 != null && incorporationDate1 != ''){
		valueToUse = incorporationDate1;
	}else{
		valueToUse = dob.value;
	}
	var mill3 = changetoMillis(valueToUse);
	if(elem1.value!='' && valueToUse != 'undefined' && valueToUse != '' && valueToUse != null)
	{
	/* CRM102ST: TrackerID:177826 Being of Change */
	/* Checking only if dob value is valid one */
		if (mill3 > mill2)
		{
		        //FIX FOR TRACKER ID 162037 START
		        if(top.window.opener.boName == "CorporateBO" || top.window.opener.boName == "CorporateModBO" || CIF_Type == "Corporate"){
		            showMessage(getUserErrorMessage('MSG017', [MSGJ0138,MSG50446]));
		        }//FIX FOR TRACKER ID 162037 END
		        else{
			showMessage(getUserErrorMessage('MSG016', [CMSGH0115,MSGJ0138]));
			}
			elem1.value = "";
			elem1.focus();
			return "false";
		}
// Call id 433921 changes End
	}
	/* CRM102ST: TrackerID:177826 End of Change */
}
//Tracker:161726 end

//Changes for call id 335295 Starts Here
/*function changetoMillis(datevalue)
{
	if(datevalue.length == 0)
	{
		return 0;
	}
	else
	{
		var DocIssueDate = new Date(datevalue.substring(3,5) + "/" + datevalue.substring(0,2) + "/" + datevalue.substring(6,10));
		var millis = DocIssueDate.valueOf();
		return millis;
	}
}*/

//Changes for call id 335295 Ends Here
function saveDet()
{
    try
    {
        customSave();
    }
    catch(e)
    {}
    //changes for callid 460087 starts
     var v_city = document.getElementsByName('EntityDocumentBO.PlaceOfIssue')[0].value;
   	   


   if(v_city == "" && fromProcess!="Y"){

   				   showMessage(MSG_LOOKUP_INVALID+'City');
   				   document.getElementsByName('EntityDocumentBO.PlaceOfIssue')[0].value = "";
   				   document.getElementsByName('Cat_EntityDocumentBO.PlaceOfIssue')[0].value  = "";
   				    return "interactive";
   			}


//changes for callid 460087 ends

	isValidDates = validateIssueDate();
	if(isValidDates == "false")
	{
		return "interactive";
	}
	else{
		isValidDates = checkWithIssueDate();
		if(isValidDates == "false")
		{
			return "interactive";
		}		
	}
	
    IdentificationDetails = new Array();
	var retStat = ValidateFormContents(document.frm2,false);
	
	if(retStat == "false")
	{
		return "interactive";
	}
		//changes for  Ticket ID 455808
		 retVal = chkUniqueID();
		if(retVal == "false") 
		{
		return "interactive";
                }
		//changes for  Ticket ID 455808
//	var identype = document.getElementsByName('EntityDocumentBO.IdentificationType')[0].value;
//	alert(GetCookie('EntityDocumentBO.IdentificationType'));
//	if(identype == "")
//	{
//		showMessage(MSGX0041);
//		return "interactive";
//	}
	if(document.getElementsByName('hidIdentificationType')[0]!=null)
		IdentificationDetails[0] = trim(''+document.getElementsByName('hidIdentificationType')[0].value);
	if(document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0]!=null)
		IdentificationDetails[1] = trim(''+document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0].value);
	if(document.getElementsByName('EntityDocumentBO.PlaceOfIssue')[0]!=null)
		IdentificationDetails[2] = trim(''+document.getElementsByName('EntityDocumentBO.PlaceOfIssue')[0].value);
	if(IdentificationDetails[2] == "" || IdentificationDetails[2] == "undefined")
		IdentificationDetails[2] = placeofissue;
	if(document.getElementsByName('3_EntityDocumentBO.DocIssueDate')[0]!=null)
		IdentificationDetails[3] = trim(''+document.getElementsByName('3_EntityDocumentBO.DocIssueDate')[0].value);
	if(document.getElementsByName('3_EntityDocumentBO.DocExpiryDate')[0]!=null)
		IdentificationDetails[4] = trim(''+document.getElementsByName('3_EntityDocumentBO.DocExpiryDate')[0].value);
	if(document.getElementsByName('EntityDocumentBO.CountryOfIssue')[0]!=null)
		IdentificationDetails[5] = trim(''+document.getElementsByName('EntityDocumentBO.CountryOfIssue')[0].value);
	if(IdentificationDetails[5] == "" || IdentificationDetails[5] == "undefined")
		IdentificationDetails[5] = countryofissue;
	if(document.getElementsByName('Cat_EntityDocumentBO.PlaceOfIssue')[0]!=null)
		IdentificationDetails[7] = trim(''+document.getElementsByName('Cat_EntityDocumentBO.PlaceOfIssue')[0].value);
	if(document.getElementsByName('Cat_EntityDocumentBO.CountryOfIssue')[0]!=null)
		IdentificationDetails[8] = trim(''+document.getElementsByName('Cat_EntityDocumentBO.CountryOfIssue')[0].value);
//	if(document.getElementsByName('Cat_EntityDocumentBO.IdentificationType')[0]!=null)
//		IdentificationDetails[9] = trim(''+document.getElementsByName('Cat_EntityDocumentBO.IdentificationType')[0].value);
	if(document.getElementsByName('EntityDocumentBO.DocCode')[0]!=null)
		IdentificationDetails[10] = trim(''+document.getElementsByName('EntityDocumentBO.DocCode')[0].value);
	if(document.getElementsByName('EntityDocumentBO.DocDescr')[0]!=null)
		IdentificationDetails[11] = trim(''+document.getElementsByName('EntityDocumentBO.DocDescr')[0].value);
	if(document.getElementsByName('EntityDocumentBO.DocTypeCode')[0]!=null)
		IdentificationDetails[12] = trim(''+document.getElementsByName('EntityDocumentBO.DocTypeCode')[0].value);
	if(document.getElementsByName('EntityDocumentBO.DocTypeDescr')[0]!=null)
		IdentificationDetails[13] = trim(''+document.getElementsByName('EntityDocumentBO.DocTypeDescr')[0].value);
	if(document.getElementsByName('EntityDocumentBO.DocRemarks')[0]!=null)
		IdentificationDetails[14] = trim(''+document.getElementsByName('EntityDocumentBO.DocRemarks')[0].value);
	if(document.getElementsByName('EntityDocumentBO.IsMandatory')[0]!=null)
		IdentificationDetails[15] = trim(''+document.getElementsByName('EntityDocumentBO.IsMandatory')[0].value);
	if(document.getElementsByName('EntityDocumentBO.ScanRequired')[0]!=null)
		IdentificationDetails[16] = trim(''+document.getElementsByName('EntityDocumentBO.ScanRequired')[0].value);
	if(document.getElementsByName('EntityDocumentBO.Status')[0]!=null)
		IdentificationDetails[17] = trim(''+document.getElementsByName('EntityDocumentBO.Status')[0].value);
	if(document.getElementsByName('3_EntityDocumentBO.DocReceivedDate')[0]!=null)
		IdentificationDetails[18] = trim(''+document.getElementsByName('3_EntityDocumentBO.DocReceivedDate')[0].value);
	if(fromProcess!="Y"){
		IdentificationDetails[17] = "Received"
		IdentificationDetails[18] = getTodayDate();
	}
	if(document.getElementsByName('3_EntityDocumentBO.WaivedOrDeferedDate')[0]!=null)
		IdentificationDetails[19] = trim(''+document.getElementsByName('3_EntityDocumentBO.WaivedOrDeferedDate')[0].value);
	if(document.getElementsByName('3_EntityDocumentBO.DocDueDate')[0]!=null)
		IdentificationDetails[20] = trim(''+document.getElementsByName('3_EntityDocumentBO.DocDueDate')[0].value);
	if(document.getElementsByName('EntityDocumentBO.Scanned')[0]!=null)
		IdentificationDetails[21] = trim(''+document.getElementsByName('EntityDocumentBO.Scanned')[0].value);
	if(document.getElementsByName('EntityDocumentBO.MinDocsReqd')[0]!=null)
		IdentificationDetails[22] = trim(''+document.getElementsByName('EntityDocumentBO.MinDocsReqd')[0].value);
	if(document.getElementsByName('EntityDocumentBO.DocDelFlg')[0]!=null)
		IdentificationDetails[23] = trim(''+document.getElementsByName('EntityDocumentBO.DocDelFlg')[0].value);
	if(document.getElementsByName('EntityDocumentBO.IsDocumentVerified')[0]!=null)
		IdentificationDetails[24] = trim(''+document.getElementsByName('EntityDocumentBO.IsDocumentVerified')[0].value);	
	if(document.getElementsByName('EntityDocumentBO.IDIssuedOrganisation')[0]!=null)
		IdentificationDetails[25] = trim(''+document.getElementsByName('EntityDocumentBO.IDIssuedOrganisation')[0].value);	

//arrUndefined=new Array();
//iUndefined=-1;
	for(i=0;i<24;i++)
	{
		if(IdentificationDetails[i] == undefined)
		{
//			arrUndefined[++iUndefined]=i;
			IdentificationDetails[i] = '';
		}
		if(IdentificationDetails[i] == 'null')
		{
			IdentificationDetails[i] = '';
		}

//alert("IdentificationDetails[" + i + "]: " + IdentificationDetails[i]);
	}
//alert('arrUndefined: ' + arrUndefined);

	if (top.window.opener.addIDDetails(IdentificationDetails) == 'true')
	{
	//Changes for field based maker checker
	if(document.frm2.isMCEditedDoc.value=="Y"){
		top.window.opener.setMCAttModifyFlag();
	}

		top.window.close();
		top.window.opener.focus();
	}
	else
	{
		top.window.focus();
	}
}

function disableFields()
{
	if(fromProcess=="Y")
	{
		strStatus=document.getElementsByName("EntityDocumentBO.Status")[0].value;
		document.getElementsByName('EntityDocumentBO.IsMandatory')[0].disabled=true;
		document.getElementsByName("EntityDocumentBO.ScanRequired")[0].disabled = true;
		if(strStatus.toUpperCase()!='RECEIVED'){
			document.getElementsByName("EntityDocumentBO.Scanned")[0].disabled = true;
			document.getElementsByName("EntityDocumentBO.Scanned")[0].selectedIndex = 0;
		}
		document.getElementsByName("EntityDocumentBO.DocDelFlg")[0].disabled = true;
	}
	//10.2 Fix Tracker 188428
	var ExpDate = document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].value;

	if(ExpDate != null && ExpDate != "" ){

	document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].readOnly=false;
	document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].setAttribute('IsMandatory','true');
	document.getElementsByName("mandStarEntityDocumentBO.DocExpiryDate")[0].style.visibility="visible";
	document.getElementsByTagName("img")[1].style.visibility='visible';
	document.getElementsByTagName("img")[1].style.display='';
	}
	else{

	document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].value="";
	document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].readOnly=true;
	document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].setAttribute('IsMandatory','false');
	document.getElementsByName("mandStarEntityDocumentBO.DocExpiryDate")[0].style.visibility="hidden";
	document.getElementsByTagName("img")[1].style.visibility='hidden';
	document.getElementsByTagName("img")[1].style.display='none';
        }
}
var boolIsExpDtMand;
function makeFieldsMandatory(){
//alert('inside makeFieldsMandatory');
	boolIsExpDtMand=false;
	for(i=0;i < isExpiryDateMandatoryarr.length;i++)
    {
        var temArr = isExpiryDateMandatoryarr[i].split("=");
		if(temArr[0].toUpperCase()==strDocCode.toUpperCase()){
			if(temArr[1].toUpperCase()=="Y"){
				boolIsExpDtMand=true;
			}
			break;
		}
	}
//alert(boolIsExpDtMand);
//alert(indexOfDtOfIssCalender);
<!-- Tracker ID :756914 - Chrome Porting Changes -->
	document.getElementsByTagName("img")[indexOfDtOfIssCalender+1].style.visibility='hidden';
	document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].setAttribute('IsMandatory','false');
	document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].readOnly = true;
	document.getElementsByName("mandStarEntityDocumentBO.DocExpiryDate")[0].style.visibility="hidden";

	document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].setAttribute('IsMandatory','true');
	document.getElementsByName("mandStarEntityDocumentBO.ReferenceNumber")[0].style.visibility="visible";
	document.getElementsByName("Cat_EntityDocumentBO.PlaceOfIssue")[0].setAttribute('IsMandatory','true');
	document.getElementsByName("mandStarEntityDocumentBO.PlaceOfIssue")[0].style.visibility="visible";
	document.getElementsByName("Cat_EntityDocumentBO.CountryOfIssue")[0].setAttribute('IsMandatory','true');
	document.getElementsByName("mandStarEntityDocumentBO.CountryOfIssue")[0].style.visibility="visible";
	document.getElementsByName("3_EntityDocumentBO.DocIssueDate")[0].setAttribute('IsMandatory','true');
	document.getElementsByName("mandStarEntityDocumentBO.DocIssueDate")[0].style.visibility="visible";
	if(boolIsExpDtMand==true){
		document.getElementsByTagName("img")[indexOfDtOfIssCalender+1].style.visibility='visible';
		document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].setAttribute('IsMandatory','true');
		document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].readOnly = false;
		document.getElementsByName("mandStarEntityDocumentBO.DocExpiryDate")[0].style.visibility="visible";
	}
	else
	{
	document.getElementsByTagName("img")[indexOfDtOfIssCalender+1].style.visibility='visible';
	document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].readOnly = false;
	}
//alert('finished');
}
//changes for  Ticket ID 455808
function chkUniqueID(){
ReferenceNo = document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].value;
DocumentType =trim(''+document.getElementsByName('hidIdentificationType')[0].value);
//Fix for TOL id:451789 Starts
var Status='';
if(fromProcess=="Y"){
if(document.getElementsByName('EntityDocumentBO.Status')[0]!=null){
Status=document.getElementsByName("EntityDocumentBO.Status")[0].value;
}
//Fix for TOL id:451789 Ends
}
	if((DocumentType=="Passport Number"||DocumentType=="Driving Licence"||DocumentType=="PAN") && ReferenceNo.length > 25 )
	  {
	       showMessage(getUserErrorMessage('MSG076', [MSGJ51517,25]));
	       document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].select();
	       return "false";
	   }
	 //Changes for call id 691576 starts      
	 if(DocumentType=="National Card Number" && ReferenceNo.length > 30 )
	   {
	      showMessage(getUserErrorMessage('MSG076', [MSGJ51517,30]));
	      document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].select();
	      return "false";
	   }
	  //Changes for call id 691576 ends   
	  if((DocumentType=="IDTypeR1"||DocumentType=="IDTypeR2"||DocumentType=="IDTypeR3"||DocumentType=="IDTypeR4"||DocumentType=="IDTypeR5") && ReferenceNo.length > 50 )
	    {
	      showMessage(getUserErrorMessage('MSG076', [MSGJ51517,50]));
	      document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].select();
	      return "false";
	     }
	     //Changes for tracker ID 430428 begin
	  if((DocumentType=="IDTypeC1"||DocumentType=="IDTypeC2"||DocumentType=="IDTypeC3"||DocumentType=="IDTypeC4"||DocumentType=="IDTypeC5"||DocumentType=="IDTypeC6"||DocumentType=="IDTypeC7"||DocumentType=="IDTypeC8"||DocumentType=="IDTypeC9"||DocumentType=="IDTypeC10") && ReferenceNo.length > 50 )
	    {
	      showMessage(getUserErrorMessage('MSG076', [MSGJ51517,50]));
	      document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].select();
	      return "false";
	     }   
	     //Changes for tracker ID 430428 end
	//Adhar changes for tracker 375136 start
	     if(DocumentType != null && DocumentType != "" && DocumentType !=undefined && DocumentType == "Unique Identification Number"){
	     	//Fix for TOL id:451789 Starts
	     	if(Status.toUpperCase() == "RECEIVED"||fromProcess!="Y"){
	      if(isNaN(ReferenceNo)) {
	     			   showMessage("Please enter a 12 digit numeric value for Unique Id.");
	     			   document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].select();
	     			   return "false";
	     		}
	     	if(ReferenceNo.length > 12 || ReferenceNo.length < 12) {
	     			   showMessage("Please enter a 12 digit numeric value for Unique Id.");
	     			   document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].select();
	     			   return "false";
	     		}
	     		}
		 //Fix for TOL id:451789 Ends
	     }
	
	//Adhar changes for tracker 375136  end
	     
	    }
//changes for  Ticket ID 455808
	        
