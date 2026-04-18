document.write('<script language=javascript src="'+applPath+'/corpcif/js/Message_corpcif_'+finaclecrmlocale+'.js">'+'<\/script>');
/*changes for ticket347162*/
document.write('<script language=javascript src="'+applPath+'/common/html/utils.js">'+'<\/script>');
/*changes for ticket347162*/
 /**********ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
/* including a file having conversion logic*/
document.write('<script type="text/javascript" src="'+applPath+'/common/js/Rendcommon.js" language="javascript"></script>');
document.write('<script type="text/javascript" src="../common/js/Reduce_Form.js" language="javascript"></script>');


/*************ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
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
var currIDTableRow      		= null;
var IDArrayIndex        		= null;
var IDRecordIndex       		= null;
var lookupwindow_UB = null;
var EDoc_docCode          		= new Array();
var EDoc_docDescr         		= new Array();
var EDoc_docTypeCode      		= new Array();
var EDoc_docTypeDescr     		= new Array();
var EDoc_docReceivedDate  		= new Array();
var EDoc_docRemarks       		= new Array();
var EDoc_isMandatory      		= new Array();
var EDoc_scanRequired     		= new Array();
var EDoc_IsDirty                	= new Array();
var EDoc_isDocumentVerified     	= new Array();
var EDoc_idIssuedOrg			= new Array();
var EDoc_UserField5             = new Array();
var updateIDDet 			= false;


/*Swift addess changes*/
    var SwiftName;
    var SwiftAddr1;
    var SwiftAddr2;
    var SwiftAddr3;
    var SwiftAddressDetails = "";
/*Swift addess changes*/

// IDENTIFICATION DOCUMENT CHANGES end

    var escChars = new Array(',');
    var escChars1 = new Array('@');
/*Tracker 159095 : Sonali begin of changes*/
    var escCharsAddr = new Array('%');
/*Tracker 159095 : Sonali end of changes*/
    var updateIDDet = false;
    var editMode = false;
    var recordIndex1 = null;
    var servletURL = null;
    try{
    var selTabId = parent.parent.parent.parent.frames(0).getSelectedTabId();
    }catch(e){}
    var updateAdrDet = false;
    var recordIndex = null;
    var lookupFor = '';
    var fetchFrom = "";
    var IntroducerPref 		= false;
    var currIntoducerTableRow;
    var IntroducerBankRelation 	= new Array();
    var IntroducerContact 	= new Array();
    var IntroducerRelation 	= new Array();
    var IntroducerFirstName 	= new Array();
    var IntroducerLastName 	= new Array();
    var IntroducerGender 	= new Array();
    var IntroducerIsDependent 	= new Array();
    var IntroducerGuardianType 	= new Array();
    var IntroducerDateOfBirth 	= new Array();
    var IntroducerCIFType	= new Array();
    var IntroducerIsPrimaryIntro= new Array();
    var IntroducerPsychoURL 	= new Array();
    var IntroducerStatus 	= new Array();
    var IntroducerBODateCreated = new Array();
    var IntroducerChildcoreCustID = new Array();
    var IntroducerKnownYears    = new Array();
    var DeletedIntroducerID	= new Array();
 	var reserveCIFID="";
/*Call ID 433921 : begin of changes*/
	var incorporationDate1 = document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0].value;
/*Call ID 433921 : end of changes*/


function addIdentdetails(dualflag)
<!--tracker id 113227 ends-->
{

	<!-- Tracker-id:108380 Changes for centering Popup BEGIN -->
	wid=900;
	ht=360;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	<!-- Tracker-id:108380 Changes for centering Popup END -->

	/* Tracker # 98769 Begin of Changes */
	var getMCRequired = document.frm2.getMCRequired.value;
	updateIDDet = false;
			  <!--tracker id 113227 starts-->
	//var servletURL = "../servlet/com.infy.cis.ui.common.EntityDocument_Det?mode=add&choice_nameIDType=ID_TYPE&getMCRequired="+getMCRequired;
/*Call ID 433921 : begin of changes*/
	   var servletURL = "../servlet/com.infy.cis.ui.common.EntityDocument_Det?mode=add&choice_nameIDType=ID_TYPE&getMCRequired="+getMCRequired+"&dual="+dualflag+"&incorporationDate1="+incorporationDate1;
/*Call ID 433921 : end of changes*/
	<!--tracker id 113227 ends-->



	/* Tracker # 98769 End of Changes */
	docTypeNew = window.open(servletURL, 'IDDetails','height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+', location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');<!-- Tracker-id:108380 Changes for centering Popup -->
}
function addIDDetails(IdentificationDetails)
{
	try
	{
		identifier_type_Code         = IdentificationDetails[0];
		unique_id                    = IdentificationDetails[1];
		placeofissue                 = IdentificationDetails[2];
		dateofissue                  = IdentificationDetails[3];
		validity_date                = IdentificationDetails[4];
		countryofissue               = IdentificationDetails[5];
		placeofissue_cat	     = IdentificationDetails[7];
		countryofissue_cat           = IdentificationDetails[8];
		identifier_type_Code_cat     = GetCookie('EntityDocumentBO.IdentificationType');
		docCode               	     = IdentificationDetails[10];
		docDescr              	     = IdentificationDetails[11];
		docTypeCode            	     = IdentificationDetails[12];
		docTypeDescr           	     = IdentificationDetails[13];
		docRemarks             	     = IdentificationDetails[14];
		isMandatory            	     = IdentificationDetails[15];
		scanRequired           	     = IdentificationDetails[16];
		strStatus               	 = IdentificationDetails[17];//Fix for callid 258648
		docReceivedDate              = IdentificationDetails[18];
		isDocumentVerified    	     = IdentificationDetails[24];
		idIssuedOrg                  = IdentificationDetails[25];
		UserField5  = IdentificationDetails[26];
//Tracker-ID 113259:ERPBOCF1:Hijri CR: changes start
/*Tracker-ID 113259:ERPBOCF1:Hijri:to convert docReceivedDate to Hijri date format - start
		var cal_Type = getCookie('SRMCalendar');
		Tracker-ID 113259:ERPBOCF1:Hijri:to convert docReceivedDate to Hijri date format - end*/
//Tracker-ID 113259:ERPBOCF1:Hijri CR: changes end
		//Tracker # 432845 changes begin
		IDURL                	     = identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue;
		//Tracker # 432845 changes end
		var noOfexistingURLs = EDoc_URL.length;
		var alreadyAdded = false;
		var tempIndex;
		/*  changes for ticketid 314223 starts */
		/*changes  for  tracker id :251266  / ticket id : 413789 begin*/
		                           for(var x = 0; x < noOfexistingURLs ; x++)
		                                                {
		               if(identifier_type_Code!= '' || EDoc_identifier_type_Code[x] !='' || identifier_type_Code != null || identifier_type_Code != 'null')
		                                                {
		                    if(identifier_type_Code == EDoc_identifier_type_Code[x])
		                                                {
		                                      alreadyAdded = true;
		                                             break;
		                                                }

		                                                }
		                                              else
		                                                {
		            if((EDoc_docTypeCode[x] == docTypeCode) && (EDoc_docCode[x] == docCode))
		                                                {
		                                      alreadyAdded = true;
		                                             break;
		                                                }
		                                                }
		                                                }
                             /*  changes for ticketid 314223 ends */
							 /*changes  for  tracker id :251266  / ticket id : 413789 end*/
		for(var x = 0; x < noOfexistingURLs ; x++)
		{
			if(IDURL == EDoc_URL[x])
			{
				alreadyAdded = true;
				break;
			}
		}
		if(updateIDDet)
		{
			tempIndex=IDArrayIndex;
		}
		else
		{
			if(alreadyAdded)
			{
				showUserMessage("MSG_IDEXISTS",null);
				return;
			}
			tempIndex=EDoc_URL.length;
			EDoc_EntityDocumentID[tempIndex] = null;
			EDoc_EntityDocumentURL[tempIndex] = null;
		}
		EDoc_identifier_type_Code[tempIndex] = identifier_type_Code;
		//Changes for tracker ID 432847 begins
		var Type_code = identifier_type_Code;
		var lenEDoc_URL=EDoc_URL.length;
		for(j=0; j < lenEDoc_URL; j++){
			if(EDoc_identifier_type_Code[j] == Type_code && EDoc_Status[j]=='Received' && j!=i && j!=tempIndex){
			showUserMessage("MSG_IDEXISTS",null);
			return;
			}
		}
		//Changes for tracker ID 432847 ends
		EDoc_docCode[tempIndex] = docCode;
		EDoc_docDescr[tempIndex] = docDescr;
		EDoc_docTypeCode[tempIndex] = docTypeCode;
		EDoc_docTypeDescr[tempIndex] = docTypeDescr;
		EDoc_docReceivedDate[tempIndex] = docReceivedDate;
		EDoc_docRemarks[tempIndex] = docRemarks;
		EDoc_Status[tempIndex] = strStatus; //Fix for callid 258648
		EDoc_isMandatory[tempIndex] = isMandatory;
		EDoc_scanRequired[tempIndex] = scanRequired;
		EDoc_unique_id[tempIndex] = unique_id;
		EDoc_placeofissue[tempIndex] = placeofissue;
		EDoc_placeofissue_cat[tempIndex] = placeofissue_cat;
		EDoc_dateofissue[tempIndex] = dateofissue;
		EDoc_validity_date[tempIndex] = validity_date;
		EDoc_countryofissue[tempIndex] = countryofissue;
		EDoc_countryofissue_cat[tempIndex] = countryofissue_cat;
		EDoc_URL[tempIndex] = IDURL;
		EDoc_isDocumentVerified[tempIndex] = isDocumentVerified;
		EDoc_idIssuedOrg[tempIndex] = idIssuedOrg;
		EDoc_UserField5[tempIndex] = UserField5;
		if(EDoc_IsDirty[tempIndex]=='N')
			EDoc_IsDirty[tempIndex]='Y';
		if(updateIDDet)
		{
			//Changes for tracker id 355214 STARTS
			currIDTableRow.childNodes(0).innerHTML="<font class='fntColData'>" + docCode + "</font>";
			//Changes for tracker id 355214 ENDS
			/*Changes for Tracker id: 222688 Start */
			currIDTableRow.childNodes(1).innerHTML="<font class='fntColData'>" + unique_id + "</font>";
			currIDTableRow.childNodes(2).innerHTML="<font class='fntColData'>" + placeofissue_cat + "</font>";
			/*Changes for Tracker id: 222688 End */
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
			if((dateofissue!= '') && (dateofissue != undefined))
			{
			//date converted acc to the present calendar type before displaing in the multirec
/* Fix for call id: 561269 starts */
				dateofissue = changeDateAccToPresentCalendar_IOC(dateofissue);
/* Fix for call id: 561269 ends */
			}
			/*Changes for Tracker id: 222688 Start */
			currIDTableRow.childNodes(3).innerHTML="<font class='fntColData'>" + dateofissue + "</font>";
			/*Changes for Tracker id: 222688 End */
//Tracker-ID 113259:ERPBOCF1:Hijri CR: changes start

			if((validity_date!=null) && (validity_date!= '') && (validity_date != undefined))
			{
			//date converted acc to the present calendar type before displaing in the multirec
/* Fix for call id: 561269 starts */
				validity_date = changeDateAccToPresentCalendar_IOC(validity_date);
/* Fix for call id: 561269 ends */
				  currIDTableRow.childNodes(4).innerHTML="<font class='fntColData'>" + validity_date + "</font>";
			        /*Changes for Tracker id: 222688 End */
			}
			/*Changes for firestone tracker id 360539 starts*/
			currIDTableRow.childNodes(4).innerHTML="<font class='fntColData'>" + validity_date + "</font>";
			/*Changes for firestone tracker id 360539 ends*/
			if((docReceivedDate!= '') && (docReceivedDate != undefined))
			{
			//date converted acc to the present calendar type before displaing in the multirec
				docReceivedDate = changeDateAccToPresentCalendar(docReceivedDate);
			}
			/*Changes for Tracker id: 222688 Start */
			currIDTableRow.childNodes(5).innerHTML="<font class='fntColData'>" + docReceivedDate + "</font>";
			/*Changes for Tracker id: 222688 End */
			//Tracker-ID 113259:ERPBOCF1:Hijri CR: changes end
			// Tracker ID: 135125: XMLEncoding Changes STARTS
			if(entityDocumentBO_Name=='EntityDocumentBO'){
				document.all.EDocRecordSet.rows(IDRecordIndex).setAttribute("EntityDocumentBO.url", IDURL);
			}
			else if(entityDocumentBO_Name=='EntityDocumentModBO'){
				document.all.EDocRecordSet.rows(IDRecordIndex).setAttribute("EntityDocumentModBO.url", IDURL);
			}
			// Tracker ID: 135125: XMLEncoding Changes ENDS
		}
		else
		{
			oNewNode = document.createElement("TR");
			if(TBODY_EDocRecordSet.childNodes.length % 2 == 0)
			{
				oNewNode.setAttribute("className", "color1");
			}
			else
			{
				oNewNode.setAttribute("className", "color2");
			}
			TBODY_EDocRecordSet.appendChild(oNewNode);

			var tdNode = document.createElement("TD");
			oNewNode.appendChild(tdNode);
			tdNode.innerHTML =  "<font class='fntColData'>" + docCode + "</font>";


			var tdNode2 = document.createElement("TD");
			oNewNode.appendChild(tdNode2);
			tdNode2.innerHTML =  "<font class='fntColData'>" + unique_id+ "</font>";
			var tdNode3 = document.createElement("TD");
			oNewNode.appendChild(tdNode3);
			tdNode3.innerHTML = "<font class='fntColData'>" + placeofissue_cat + "</font>";
			var tdNode4 = document.createElement("TD");
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
			//id has been set for the date field such dat "date" phrase has 0 index and rowindex has been appended to make id unique for ever row
			var idIndex = document.all.EDocRecordSet.rows.length;
			tdNode4.setAttribute("id","DATE1CorpCustIDoc"+idIndex);
			if((dateofissue!= '') && (dateofissue != undefined))
			{
			//date converted acc to the present calendar type before displaing in the multirec
/* Fix for call id: 561269 starts */
				dateofissue = changeDateAccToPresentCalendar_IOC(dateofissue);
/* Fix for call id: 561269 ends */
			}
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
			oNewNode.appendChild(tdNode4);
			tdNode4.innerHTML = "<font class='fntColData'>" + dateofissue + "</font>";
			var tdNode5 = document.createElement("TD");
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
			//id has been set for the date field such dat "date" phrase has 0 index and rowindex has been appended to make id unique for ever row
			tdNode5.setAttribute("id","DATE2CorpCustIDoc"+idIndex);
			if((validity_date!= '') && (validity_date != undefined))
			{
			//date converted acc to the present calendar type before displaing in the multirec
/* Fix for call id: 561269 starts */
				validity_date = changeDateAccToPresentCalendar_IOC(validity_date);
/* Fix for call id: 561269 ends */
			}
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
			oNewNode.appendChild(tdNode5);
			tdNode5.innerHTML = "<font class='fntColData'>" + validity_date + "</font>";
			var tdNode6 = document.createElement("TD");
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
			//id has been set for the date field such dat "date" phrase has 0 index and rowindex has been appended to make id unique for ever row
			tdNode6.setAttribute("id","DATE3CorpCustIDoc"+idIndex);
			if((docReceivedDate!= '') && (docReceivedDate != undefined))
			{
			//date converted acc to the present calendar type before displaing in the multirec
				docReceivedDate = changeDateAccToPresentCalendar(docReceivedDate);
			}
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
			oNewNode.appendChild(tdNode6);
//Tracker-ID 113259:ERPBOCF1:Hijri CR: changes start
//Tracker-ID 113259:ERPBOCF1:Hijri CR: changes end
			tdNode6.innerHTML = "<font class='fntColData'>" + docReceivedDate + "</font>";
//Tracker-ID 113259:ERPBOCF1:Hijri CR: changes start
  //Tracker-ID 113259:ERPBOCF1:Hijri CR: changes end
			var tdNode7 = document.createElement("TD");
			oNewNode.appendChild(tdNode7);
			tdNode7.innerHTML = "<INPUT class='sbttn' TYPE = 'button' value = '...' onclick='editIdentificationDetails()'>";
			oNewNode.attachEvent("onclick", callID);
			// Tracker ID: 135125: XMLEncoding Changes STARTS
			if(entityDocumentBO_Name=='EntityDocumentBO'){
				oNewNode.setAttribute("EntityDocumentBO.url", IDURL);
			}
			else if(entityDocumentBO_Name=='EntityDocumentModBO'){
				oNewNode.setAttribute("EntityDocumentModBO.url", IDURL);
			}
			// Tracker ID: 135125: XMLEncoding Changes ENDS
		}
		return ("true");
	}
        catch(e)
        {
	}

}

 function callID()
        {
            for (i=0; i < document.all.EDocRecordSet.rows.length; i++) {
                var row_bgcolor=document.all.EDocRecordSet.rows(i).className;
                 if ( row_bgcolor == 'rowHighLighted'){
                      if ( i % 2 == 0) {
                           document.all.EDocRecordSet.rows(i).className = 'color1';
                      }
                      else{
                           document.all.EDocRecordSet.rows(i).className = 'color2';
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
function editIdentificationDetails()
{
    try
    {
        updateIDDet = true;
        deleteCookie('EntityDocumentBO.IdentificationType');
        var tempTableRow = '';
        if(event.srcElement.parentElement.id == null || event.srcElement.parentElement.id == '')
        {
		   tempTableRow = event.srcElement.parentElement.parentElement;
        }
        else
        {
		tempTableRow = event.srcElement.parentElement;
	}
        currIDTableRow = tempTableRow;
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(entityDocumentBO_Name=='EntityDocumentBO'){
        	IDDetURL = tempTableRow.getAttribute("EntityDocumentBO.url");
	}
	else if(entityDocumentBO_Name=='EntityDocumentModBO'){
        	IDDetURL = tempTableRow.getAttribute("EntityDocumentModBO.url");
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS
        var i;
        for(i=0; i < EDoc_URL.length; i++)
        {
            if(EDoc_URL[i] == IDDetURL)
            {
				IDArrayIndex=i;
				break;
            }

        }
		var j;
	if(entityDocumentBO_Name=='EntityDocumentBO'){
		for (j=2; j < document.all.EDocRecordSet.rows.length; j++)
		{
				var docURL = document.all.EDocRecordSet.rows(j).getAttribute("EntityDocumentBO.url");
		    if(docURL == IDDetURL)
		    {
			break;
		    }
		}
	}
	else if(entityDocumentBO_Name=='EntityDocumentModBO'){
		for (j=2; j < document.all.EDocRecordSet.rows.length; j++)
		{
				var docURL = document.all.EDocRecordSet.rows(j).getAttribute("EntityDocumentModBO.url");
		    if(docURL == IDDetURL)
		    {
			break;
		    }
		}
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS
     //   alert("in try11111111 before list");
        IDRecordIndex = j;
        document.frm2.identifier_type_Code.value=srmEscape(EDoc_identifier_type_Code[i], '^', escChars);
        document.frm2.unique_id.value=srmEscape(EDoc_unique_id[i], '^', escChars);
         /*******ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
	 			      var ALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
	 				if(ALTCALENDAR_TYPE == 'true')
	 				{
	 				   if(EDoc_dateofissue[i] != '')
	 				   {
	 				    var strFlag = isGregDateWithoutConv(EDoc_dateofissue[i]);
	 				    if(strFlag != 'true')
	 					{
	 						EDoc_dateofissue[i]=convertHijToGreg(EDoc_dateofissue[i]);
	 					}
	 				   }
	 				if(EDoc_validity_date[i] != '')
	 				   {
	 				    var strFlag = isGregDateWithoutConv(EDoc_validity_date[i]);
	 				    if(strFlag != 'true')
	 					{
	 						EDoc_validity_date[i]=convertHijToGreg(EDoc_validity_date[i]);
	 					}
	 				   }
	 				}
	/************ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
        document.frm2.dateofissue.value = srmEscape(EDoc_dateofissue[i], '^', escChars);
        document.frm2.validity_date.value = srmEscape(EDoc_validity_date[i], '^', escChars);
	document.frm2.hidDocCode.value 			= srmEscape(EDoc_docCode[i], '^', escChars);
	document.frm2.hidDocDescr.value 			= srmEscape(EDoc_docDescr[i], '^', escChars);
	document.frm2.hidDocTypeCode.value 		= srmEscape(EDoc_docTypeCode[i], '^', escChars);
	document.frm2.hidDocTypeDescr.value 		= srmEscape(EDoc_docTypeDescr[i], '^', escChars);
	document.frm2.hidDocReceivedDate.value 	= srmEscape(EDoc_docReceivedDate[i], '^', escChars);
	document.frm2.hidDocRemarks.value 			= srmEscape(EDoc_docRemarks[i], '^', escChars);
	document.frm2.hidStatus.value			= srmEscape(EDoc_Status[i], '^', escChars);
	document.frm2.hidIsMandatory.value 		= srmEscape(EDoc_isMandatory[i], '^', escChars);
	document.frm2.hidScanRequired.value 		= srmEscape(EDoc_scanRequired[i], '^', escChars);
        document.frm2.placeofissue.value = srmEscape(EDoc_placeofissue[i], '^', escChars);
        document.frm2.placeofissue_cat.value = srmEscape(EDoc_placeofissue_cat[i], '^', escChars);
	//Fix for ticket 296576 starts
	<!-- document.frm2.countryofissue.value = srmEscape(EDoc_countryofissue[i], '^', escChars) +"|#"+srmEscape(EDoc_countryofissue_cat[i], '^', escChars);-->
	document.frm2.countryofissue.value = srmEscape(EDoc_countryofissue[i], '^', escChars);
	//Fix for ticket 296576 ends
	document.frm2.countryofissue_cat.value = srmEscape(EDoc_countryofissue_cat[i], '^', escChars);
	document.frm2.hidIsDocumentVerified.value	= srmEscape(EDoc_isDocumentVerified[i], '^', escChars);
	document.frm2.hidIDIssuedOrg.value 		= srmEscape(EDoc_idIssuedOrg[i], '^', escChars);
	document.frm2.hidUserField5.value          = srmEscape(EDoc_UserField5[i], '^', escChars);
	recordIndex1 = i;
	/* Tracker: 108382: Changes for centering popup */
	windowAlign();
	IDDetDetailsEdit = window.open('../common/html/SSOblank.html', 'IDDetails', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
	/* Tracker: 108382: End of Changes */
	document.frm2.target = 'IDDetails';


	 <!--tracker id 113227 starts-->
	//document.frm2.action = "../servlet/com.infy.cis.ui.common.EntityDocument_Det?choice_nameIDType=ID_TYPE";
	<!-- changes for tracker id 260265 starts  -->
/*Call ID 433921 : begin of changes*/
//changes for callid 740213
	   document.frm2.action = "../servlet/com.infy.cis.custom.EntityDocument_Det?mode=edit&choice_nameIDType=ID_TYPE&dual="+dualflag+"&incorporationDate1"+incorporationDate1+'&entityCreflg='+entityCreflg;
	   //document.frm2.action = "../servlet/com.infy.cis.custom.EntityDocument_Det?mode=edit&choice_nameIDType=ID_TYPE&dual="+dualflag+"&incorporationDate1"+incorporationDate1;
/*Call ID 433921 : end of changes*/
	 <!-- changes for tracker id 260265 ends  -->
	<!--tracker id 113227 ends-->

	if(readMode.toUpperCase()=="Y")
	{
		 <!--tracker id 113227 starts-->;
		//document.frm2.action = "../servlet/com.infy.cis.ui.common.EntityDocument_Det?readonly=Y&choice_nameIDType=ID_TYPE";
		 document.frm2.action = "../servlet/com.infy.cis.custom.EntityDocument_Det?readonly=Y&choice_nameIDType=ID_TYPE&dual="+dualflag;
		  <!--tracker id 113227 ends-->;
	}
	document.frm2.submit();
    }
    catch(e)
    {
	}
}

function populateAccContAttr()
{
		if(trim(corporateURL) == ""){
			/*Changes for firestone tracker id 351531 Starts*/
			var indexValue= Cat_bcName.indexOf('#');
			//changes for call id 369294 and recon of call id 366454 starts
			var indexValue1= bcName.indexOf('#');
			//var Cat_value=Cat_bcName.substring(0,indexValue);
			var Cat_value=bcName.substring(indexValue1+1);
			//changes for call id 369294 and recon of call id 366454 end
			var Cat_textValue = Cat_bcName.substring(indexValue+1);
			document.getElementsByName("Cat_CorporateBO.primary_Service_Center")[0].value = Cat_textValue;
			document.getElementsByName("CorporateBO.primary_Service_Center")[0].value = Cat_value;
			/*Changes for firestone tracker id 351531 Ends*/
		}
	elem1=eval("document.getElementsByName('CorporateBO.accessOwnerGroup')[0]");
	for(i=0;i<elem1.options.length;i++)
		{
			if(elem1.options[i].value==priGrpID)
			{
			elem1.selectedIndex=i
			break;
			}
		}
	elem2=eval("document.getElementsByName('CorporateBO.accessOwnerSegment')[0]");
	for(i=0;i<elem2.options.length;i++)
		{
			if(elem2.options[i].value==priSegName)
			{
			elem2.selectedIndex=i
			break;
			}
		}
	setAccessOwnerGroup();
	setBCCodeValues('accessOwnerBC',primBCCODE,primBCID);
}
function removeIDdetails()
{
	try
	{
        var tempIDDetURL = '';
        var tempEntityDocumentID = '';
        var tempIDRow;
        if(CheckForSelectedRow(document.getElementsByName('EDocRecordSet'))=="false")
        {
            showUserMessage("MSG158",'MSG_LODOC');
            return;
        }
        if(!showUserChoiceMessage("MSG045","MSG_LODOC"))
        	return;
        for (i=0; i < document.all.EDocRecordSet.rows.length ; i++)
        {
            var row_bgcolor = document.all.EDocRecordSet.rows(i).className;
            if ( row_bgcolor == 'rowHighLighted')
            {
				tempIDRow=document.all.EDocRecordSet.rows(i);
				break;
			}
        }
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(entityDocumentBO_Name=='EntityDocumentBO'){
    	   	tempEntityDocumentID=tempIDRow.getAttribute("EntityDocumentBO.EntityDocumentID");
		tempIDDetURL = tempIDRow.getAttribute("EntityDocumentBO.url");
	}
	else if(entityDocumentBO_Name=='EntityDocumentModBO'){
    	   	tempEntityDocumentID=tempIDRow.getAttribute("EntityDocumentModBO.EntityDocumentID");
		tempIDDetURL = tempIDRow.getAttribute("EntityDocumentModBO.url");
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS
		noOfAttachURLs = EDoc_URL.length;
		for(r=0; r< noOfAttachURLs; r++)
		{
			if(EDoc_URL[r] == tempIDDetURL)
			{
				EDoc_URL[r] = null;
				//  Tracker ID - 96453 Begin of Changes
				EDoc_identifier_type_Code[r] = null;
				//  Tracker ID - 96453 End of Changes
				break;
			}
		}
		document.all.EDocRecordSet.deleteRow(i);
		if(tempEntityDocumentID!=null)
		{
			EDoc_detachedURLs[EDoc_detachedURLs.length] = tempEntityDocumentID;
		}
		for (i=0; i < document.all.EDocRecordSet.rows.length ; i++)
		{
			if(i % 2 != 0)
			{
				document.all.EDocRecordSet.rows(i).setAttribute("className", "color2");
			}
			else
			{
				document.all.EDocRecordSet.rows(i).setAttribute("className", "color1");
			}
		}
    }
    catch(e)
    {
    }
}
function addAddressdetails()
{
	/* Tracker # 98769 Begin of Changes */
	var getMCRequired=document.frm2.getMCRequired.value;
updateEduDet = false;
	var servletURL = "../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?mode=create&getMCRequired="+getMCRequired;
	/* Tracker # 98769 End of Changes */
docTypeNew = window.open(servletURL, '','height=436, left=70, top=120, width=860, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
}
function check(Tab,corpsubmit) {
	if(corpsubmit == false) {
		noValidationMsg = true;
	}
	else {
		noValidationMsg = false;
	}
	//Equity DRC, Customization changes for CGCR22 starts 
	  FormatBeforeSave("3_CorporateBO.amount3");
//Equity DRC, Customization changes for CGCR22 end 
	//Fix for TRACKER:140599:BEGIN OF CHANGES
	  FormatBeforeSave("3_CorporateBO.average_AnnualIncome");
	//Fix for TRACKER:140599:END OF CHANGES
	/*Changes for ticket 375860 Starts(Uncommenting FormatBeforeSave for TotalFundBase, TotalNonFundBase and OFFLINECUMDEBITLIMIT)*/
	FormatBeforeSave("3_CorporateBO.TotalFundBase");

	<!-- ERPBOMNT: Sanity fix TRACKER:116162:BEGIN OF CHANGES-->
	FormatBeforeSave("3_CorporateBO.TotalNonFundBase");
	<!-- ERPBOMNT: Sanity fix TRACKER:116162:END OF CHANGES-->

	FormatBeforeSave("3_CoreInterfaceBO.OFFLINECUMDEBITLIMIT");
	/*Changes for ticket 375860 Ends*/

	// changes by Rozy for CNF
	//FormatBeforeSave_Number('2_CorporateBO.registration_Number');
	// GroupHouseHold Changes Start
	 	validateRM();
		var altCalendarHij1 = ALTCALENDAR_TYPE;
 		var dob = document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0].value;
 		var fieldDob = document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0];
		var hasOtherErrors = null;
		var hasOtherErrors1 = null;
		//tracker 113259:Hijri:to validate for hijri dates:change start
		hasOtherErrors1 = Validate_againstDobHij(altCalendarHij1,selTabId,document.getElementsByName("3_CorporateBO.date_Of_Commencement")[0],getLabel(fieldDob.Display),dob);
		//tracker 113259:Hijri:to validate for hijri dates:change end
		if(hasOtherErrors1 == "true") {
			hasOtherErrors = "true";
		}
		//tracker 113259:Hijri:to validate for hijri dates:change start
		hasOtherErrors1 = Validate_againstDobHij(altCalendarHij1,selTabId,document.getElementsByName("3_CorporateBO.relationship_StartDate")[0],getLabel(fieldDob.Display),dob);
		//tracker 113259:Hijri:to validate for hijri dates:change end
		if(hasOtherErrors1 == "true") {
			hasOtherErrors = "true";
		}
		//tracker 113259:Hijri:to validate for hijri dates:change start
		hasOtherErrors1 = Validate_againstDobHij(altCalendarHij1,selTabId,document.getElementsByName("3_CorporateBO.classified_On")[0],getLabel(fieldDob.Display),dob);
		//tracker 113259:Hijri:to validate for hijri dates:change end
		if(hasOtherErrors1 == "true") {
			hasOtherErrors = "true";
		}
		//tracker 113259:Hijri:to validate for hijri dates:change start
		hasOtherErrors1 = Validate_againstDobHij(altCalendarHij1,selTabId,document.getElementsByName("3_CorporateBO.effective_Date")[0],getLabel(fieldDob.Display),dob);
		//tracker 113259:Hijri:to validate for hijri dates:change end
		if(hasOtherErrors1 == "true") {
			hasOtherErrors = "true";
		}
		//tracker 113259:Hijri:to validate for hijri dates:change start
		hasOtherErrors1 = Validate_againstDobHij(altCalendarHij1,selTabId,document.getElementsByName("3_CorporateBO.AdvanceAsOnDate")[0],getLabel(fieldDob.Display),dob);
		//tracker 113259:Hijri:to validate for hijri dates:change end
		if(hasOtherErrors1 == "true") {
			hasOtherErrors = "true";
		}
		for(var i=0;i<ad_start_date.length;i++){
			//tracker 113259:Hijri:to validate for hijri dates:change start
		/*Changes for Ticketid:-311878 and Call id 157081(Once one address row is removed it should not come to this loop) :Start*/
		/* Changes for tracker id : 333417 starts here */
		if(adr_Status[i]!="Remove" && ad_address_type[i]!="Swift"){
		/* Changes for tracker id : 333417 Ends here */
		/*Changes for Ticketid:-311878 and Call id 157081 :End*/
		/* Changes for Call id : 339882 Starts */
			hasOtherErrors1 = Validate_againstDobHij(altCalendarHij1,selTabId,ad_start_date[i],getLabel(fieldDob.Display),dob,MSGJ51468);
		/* Changes for Call id : 339882 Ends here */
		}
		//tracker 113259:Hijri:to validate for hijri dates:change end
			if(hasOtherErrors1 == "true"){
				hasOtherErrors = "true";
				break;
			}
		}
		if(hasOtherErrors == 'true'){
			Screen = 0;
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive";
		}
		try{
				if(parent.parent.IFrmtab4.formDispFrame.document.frm2  != "undefined")
				{
	      		    hasOtherErrors1 = parent.parent.IFrmtab4.formDispFrame.ValidateDateFields(getUserErrorMessage("MSG_DOI",dob),dob);
	      		    if(hasOtherErrors1 == "true") {
	      		    	Screen = 5;
						parent.parent.parent.parent.messageFrm.showMessages(selTabId);
						return "interactive";
					}
				}
			}catch(e){
			}
			try{
				if(parent.parent.IFrmtab3.formDispFrame.document.frm2  != "undefined")
				{
	      		    hasOtherErrors1 = parent.parent.IFrmtab3.formDispFrame.ValidateDateFields(getUserErrorMessage("MSG_DOI",dob),dob);
	      		    if(hasOtherErrors1 == "true") {
	      		    	Screen = 3;
						parent.parent.parent.parent.messageFrm.showMessages(selTabId);
						return "interactive";
					}
				}
			}catch(e){
			}
			try{
				if(parent.parent.IFrmtab2.formDispFrame.document.frm2  != "undefined")
				{
	      		    hasOtherErrors1 = parent.parent.IFrmtab2.formDispFrame.ValidateDateFields(getUserErrorMessage("MSG_DOI",dob),dob);
	      		    if(hasOtherErrors1 == "true") {
	      		    	Screen = 2;
						parent.parent.parent.parent.messageFrm.showMessages(selTabId);
						return "interactive";
	      		    }
				}
			}catch(e){
		}
		Screen = 0;
	 if(document.getElementsByName("CorporateBO.corp_Key")[0].value == "")
	 	 {
	 		 	if(document.all.isAutoGenKey.value == 'true')
	 	 		{
	 	 			document.getElementsByName("CorporateBO.corp_Key")[0].IsMandatory = "false";
	 	 	    }
	}
	if(corpsubmit==true){
	return parent.parent.parent.parent.ValidateFormCorporate(document.frm2,true,Tab,noValidationMsg);
	}
	else
		return parent.parent.parent.parent.ValidateFormCorporate(document.frm2,false,Tab,noValidationMsg);
}
function save(corpsubmit){
//alert("in submit");

		try{
		var FatcaLeng = document.getElementsByName("FATCAReasonsSelected")[0].length;
	var sFatcaReasons = "";
	for (i=0; i < FatcaLeng; i++) {
		if(i==FatcaLeng-1)
		{
			sFatcaReasons += document.getElementsByName("FATCAReasonsSelected")[0].options[i].value ;
		}
		else{
	sFatcaReasons += document.getElementsByName("FATCAReasonsSelected")[0].options[i].value + ",";
		}
	}


		document.frm2.StrUserField6.value=sFatcaReasons;
		
		}catch(e)
		{
			DebugMessage(e.message);
		}
	

/* Tracker # 98769 Begin of Changes */
	var altCalendarHij = document.all.ALTCALENDAR_TYPE.value;
	if(document.frm2.isMCEdited.value=="Y"){
		document.frm2.isMCEditedGeneral.value="Y";
	}
	var relMCEDit="N";
	var prefMCEdit="N";
	var financialMCEdit="N";
	var tradeMCEDit="N";
	//Ticket 328946 changes
	var CorpRepRows = "";
	var corpRepAddExists;
	var repAdd = new Array();
	// Tracker ID 228683 changes for Basel
	var opertype=document.frm2.operationType.value;
	var p = 0;
// Checked-in for tracker 231104
	if(opertype=='Create' && (strBaselMand=='Y' || (document.getElementsByName("BaselProfiling")[0] != undefined && document.getElementsByName("BaselProfiling")[0].options.value == 'Yes'))){
		var object = eval("parent.parent.IFrmtab5");
		if(object == null ||  object == "undefined"){
		   parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserErrorMessage("MSGJ51930",""), "", 'NO_HLINK');
		   parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		   return "interactive";
		}
	}
	// Tracker ID 228683 changes for Basel

	if(parent.parent.IFrmtab1 !=undefined && parent.parent.IFrmtab1.formDispFrame.document.frm2 != "undefined"){
		relMCEDit=parent.parent.IFrmtab1.formDispFrame.document.mainForm.isMCEditedRelation.value;
		//Ticket 328946 changes
		CorpRepRows = parent.parent.IFrmtab1.formDispFrame.document.all.RowRecordSet.rows;

	}if(parent.parent.IFrmtab2 !=undefined && parent.parent.IFrmtab2.formDispFrame.document.frm2 != "undefined"){
		prefMCEdit=parent.parent.IFrmtab2.formDispFrame.document.frm2.isMCEditedPref.value;
	}if(parent.parent.IFrmtab3 !=undefined && parent.parent.IFrmtab3.formDispFrame.document.frm2 != "undefined"){
		financialMCEdit=parent.parent.IFrmtab3.formDispFrame.document.frm2.isMCEditedFinancial.value;
	}if(parent.parent.IFrmtab4 !=undefined && parent.parent.IFrmtab4.formDispFrame.document.frm2 != "undefined"){
		tradeMCEDit=parent.parent.IFrmtab4.formDispFrame.document.frm2.isMCEditedTF.value;
	}
	if(relMCEDit=="Y" || prefMCEdit=="Y" || financialMCEdit=="Y" || tradeMCEDit=="Y" ){
		document.frm2.isMCEditedGeneral.value="Y";
	}
/* Tracker # 98769 End of Changes */
	var notExistType = new Array();
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName=='CorporateBO'){
	    //Ticket 328946 changes begin
		for(var v = 2; v < CorpRepRows.length; v++){
			 if(CorpRepRows(v).getAttribute("CorporateRepBO.addressCateogry")=='Corporate'){
			 corpRepAddExists = 'false';
		       for (i=0; i < document.all.AdrRecordSet.rows.length ; i++){
			  if(CorpRepRows(v).getAttribute("CorporateRepBO.cifAddrEntity")==document.all.AdrRecordSet.rows(i).getAttribute("CorporateBO.Address.addressCategory")){
				corpRepAddExists = 'true';
			    }

			}
		       if(corpRepAddExists != 'true'){
		       	  repAdd[p] = CorpRepRows(v).getAttribute("CorporateRepBO.cifAddrEntity");
		       	  p = p+1;

			}
		     }
		}
		if(p>0){
		    showUserMessage('MSGJ50219',repAdd);
			  return "interactive";
			}

	    //Ticket 328946 changes	end

		for(var k = 2; k < delAddrtypes.length; k++){
			for (i=0; i < document.all.AdrRecordSet.rows.length ; i++){
				var existType = document.all.AdrRecordSet.rows(i).getAttribute("CorporateBO.Address.addressCategory");
				 if(delAddrtypes[k] == existType){
					delAddrtypes[k] = 'XXX';
					break;
				 }
			}
		}
	}
	else if(boName=='CorporateModBO'){
	//Ticket 328946 changes	begin
		for(var v = 2; v < CorpRepRows.length; v++){
			 if(CorpRepRows(v).getAttribute("CorporateRepModBO.addressCateogry")=='Corporate'){
			 corpRepAddExists = 'false';
		       for (i=0; i < document.all.AdrRecordSet.rows.length ; i++){
		          if(CorpRepRows(v).getAttribute("CorporateRepModBO.cifAddrEntity")==document.all.AdrRecordSet.rows(i).getAttribute("CorporateModBO.Address.addressCategory")){
				corpRepAddExists = 'true';
			    }

			}

		       if(corpRepAddExists != 'true'){
		         repAdd[p] = CorpRepRows(v).getAttribute("CorporateRepModBO.cifAddrEntity");
		          p = p+1;

		  	}
		     }
		}

		if(p>0){
		   showUserMessage('MSGJ50219',repAdd);
		    	  return "interactive";
		  	}

	//Ticket 328946 changes	end

		for(var k = 0; k < delAddrtypes.length; k++){
			for (i=0; i < document.all.AdrRecordSet.rows.length ; i++){
				var existType = document.all.AdrRecordSet.rows(i).getAttribute("CorporateModBO.Address.addressCategory");
				 if(delAddrtypes[k] == existType){
					delAddrtypes[k] = 'XXX';
					break;
				 }
			}
		}
	}
	// Tracker ID: 135125: XMLEncoding Changes ENDS
	for(var k = 0; k < delAddrtypes.length; k++){
		 if(delAddrtypes[k] != 'XXX'){
		     //Ticket 328946 changes
		 	var errList = new Array();
		 	errList[0] = delAddrtypes[k];
			showUserMessage('MSGJ50219',errList);
			return "interactive";
		  }
	}
	var swift_code = '';
	var is_swift_bank='';
		swift_code = document.getElementsByName('CorporateBO.Cust_Swift_Code_Desc')[0].value;

		/*code commented as swift code can contain special characters*/
		/* TRACKER#:185555 - END OF CHANGES*/
		//swift_code = trim(swift_code);
		/*TRACKER#:185555 - END OF CHANGES*/


			is_swift_bank= document.getElementsByName(boName+'.Is_Swift_Code_of_Bank')[0].value ;

		//if((swift_code.length == 0 && is_swift_bank.length !=0))
		if((swift_code.length == 0 && is_swift_bank =='Y'))
		{
			showMessage(MSGJ0551);
			return "interactive";
		}
		  /*
		   * Fix for ticket 236747 CHANGES START
		   * Commented below code As is done for all scenario
		   */
		  /*Added an additional condition if swift_code is not null*/
		if((swift_code.length != 0 && is_swift_bank.length ==0) && (swift_code.length == 0 && is_swift_bank.length !=0))
		  /* FIX For ticket 236747 CHANGES END */
		{
			// Fix for tracker : 104871
			// If Swift_Code is blank , default it to N
				document.getElementsByName("CorporateBO.Is_Swift_Code_of_Bank")[0].value = "N";
				document.getElementsByName("CorporateModBO.Is_Swift_Code_of_Bank")[0].value = "N";
			//showMessage(MSGJ0552);
			//return "interactive";
		}

		 /*TRACKER#:185555 - START OF CHANGES*/
		/*Code has been removed as to allow special characters for*/
		/* customer swift code*/
                /* TRACKER#:185555 - END OF CHANGES*/

	try{
	customSave();
	}
	catch(e)
	{}

/* CRM70T-ST TRACKER:79152:BEGINOFCHANGES */
MapAddressType();
/* CRM70T-ST TRACKER:79152:ENDOFCHANGES */
var url;
var res1;
url=document.getElementsByName('CorporateBO.website_Address')[0];
URL = url.value;
res1 = validate_url(url,false,false);
if (res1 == false){
 if(URL != ''){
	return "interactive";
	 }
}
/********* Save and Submit Changes :Start***********/
	if(corpsubmit=='false')
	{
		var validate=false;
		if(document.getElementsByName("CorporateBO.corp_Key")[0].value == "")
		{
			if(document.all.isAutoGenKey.value == 'true')
			{
				document.getElementsByName("CorporateBO.corp_Key")[0].IsMandatory = "false";
			}
			else
			{	if(entityType == 'Prospect'){
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG086","'Prospect ID'"),
								'CorporateBO.corp_Key' , 'HYPER_LINK');
				}
				else{
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG086","'CIF ID'"),
								'CorporateBO.corp_Key' , 'HYPER_LINK');
				}
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				validate = 'true';
			}
		}
		if(document.getElementsByName("CorporateBO.corporate_Name")[0].value == "")
		{
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG086","'Corporate Name'"),
					'CorporateBO.corporate_Name' , 'HYPER_LINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			validate = 'true';
		}
		if(validate == 'true')
		{
		return 'interactive';
		}
	}
try{
	/********* Save and Submit Changes :End ***********/
	if(corpsubmit == 'true' && entityType == 'Customer'){
		/* Changes for the ticketid:374030 Starts */
		//var  noOfCurrency = parent.parent.IFrmtab2.formDispFrame.document.all.ConcessionRecordSet.rows.length;
		var  noOfCurrency = document.all.ConcessionRecordSet.rows.length;
		/* Changes for the ticketid:374030 Ends */
	if(noOfCurrency==2)
	{
		/* Changes for the ticketid:374030 Starts- changed the currency error message to general tab*/
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSGJ50726",""),TBODY_AdrRecordSet.rows ,'NO_HLINK');
		/* Changes for the ticketid:374030 Ends*/
		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		return "interactive"
	}
	}
}catch(e){}
	chkadresID = document.all.EDocRecordSet.rows.length;
       if(corpsubmit == 'true')
       {
		if(chkadresID == 2){
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CORP_IDENT",""),TBODY_AdrRecordSet.rows ,'NO_HLINK');
		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		showTabFortabDemoForm('tpageCont1');
		document.all.AddIdentificationDetails.focus();
		return "interactive"
		}
	}
		var regad = true;
		var defad = true;
		noOfAdr = adr_URL.length;
		/*CIF PhoneEmail Changes : Start */
		noOfPhoneEmail = phoneEmail_URL.length;
		/*CIF PhoneEmail Changes : End */
		chkadres = document.all.AdrRecordSet.rows.length;
		if(corpsubmit == 'true')
		{
			if(chkadres == 2)
			{
			// Tracker : 79524
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CORPAD1",""),TBODY_AdrRecordSet.rows ,'NO_HLINK');
        		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
			}
		}
		for(var x = 0; x < noOfAdr ; x++) {
					 //Tracker:90196: Changes for Attribute Masking
		if((ad_address_type[x]) != sMasker)
		{
		if((ad_address_type[x]) != "Registered") {
		regad = false;
		}
		  //Tracker:90196: End of Changes
		else{
		regad = true;
		break;
		}
		}
		}
		if(corpsubmit == 'true')
		{
			if(regad == false){
	       	 	parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CORPAD1",""),TBODY_AdrRecordSet.rows ,'NO_HLINK');
	       	 	parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive";
			}
		}
try{
                /* CRM70T-ST TRACKER:79152:BEGINOFCHANGES */
   	            //var defadrtype = document.getElementsByName('CorporateBO.DefaultAddressType')[0].value;
      	            //var defadrtype = document.getElementsByName('CorporateModBO.DefaultAddressType')[0].value;
                var defadrtype = document.getElementsByName("addType")[0].value;
                /* CRM70T-ST TRACKER:79152:ENDOFCHANGES */
                if(defadrtype == "M")
                {
                for(var x = 0; x < noOfAdr ; x++) {
		if((ad_address_type[x]) != "Mailing") {
		defad = false;
		}
		else{
		defad = true;
		break;
		}
		}
		if(corpsubmit == 'true')
		{
		if(defad == false){
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CORPAD2",""),TBODY_AdrRecordSet.rows ,'NO_HLINK');
		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		return "interactive"
		 }
                }
                }
                else if(defadrtype == "H")
                {
		for(var x = 0; x < noOfAdr ; x++) {
		if((ad_address_type[x]) != "Head Office") {
		defad = false;
		}
		else{
		defad = true;
		break;
		}
		}
		if(corpsubmit=='true')
		{
		if(defad == false){
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CORPAD3",""),TBODY_AdrRecordSet.rows ,'NO_HLINK');
		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		return "interactive"
		 }
                }
                }
                }catch(e)
                {
                }
                chkadresID = document.all.EDocRecordSet.rows.length;
		if(corpsubmit=='true')
		{
		if(chkadresID == 2){
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CORP_IDENT",""),TBODY_AdrRecordSet.rows ,'NO_HLINK');
        	parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		return "interactive"
		}
		}
		try{
		if((corpsubmit == 'true' && entityType == 'Customer')||(corpsubmit == 'true' && entityType == 'Prospect')){
			/* Changes for the ticketid:374030 Starts */
			//var  noOfCurrency = parent.parent.IFrmtab2.formDispFrame.document.all.ConcessionRecordSet.rows.length;
			var  noOfCurrency = document.all.ConcessionRecordSet.rows.length;
			/* Changes for the ticketid:374030 Ends */
		if(noOfCurrency==2)
		{
			/* Changes for the ticketid:374030 Starts- changed the currency to general tab*/
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSGJ50726",""),TBODY_AdrRecordSet.rows ,'NO_HLINK');
			/* Changes for the ticketid:374030 Ends */
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
		}
		}
		}catch(e){}
				if(corpsubmit=='true')
		{
		if(k>1){
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_CORP_INTRODUCER_VALID",""),TBODY_AdrRecordSet.rows ,'NO_HLINK');
	        	parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive"
		}
	}//save and submit changes End
		// Fix :15



	// Tracker ID - 90197 End of Changes for attribute masking
		// fetching end date for addresstype 'mailing'
		try{
		var startdate  = new Array();
		var index      = new Array();
		var z=0;

		for(var k = 0; k < noOfAdr ; k++) {
		if((ad_address_type[k] == "Mailing") && !(adr_Status[k] == "Remove")) {
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
		//Change for Begin Ticket ID : 365978 and Tracker ID : 224750
		// fetching end date for addresstype 'Alt Lang Address'
		//Fix for tracker 258530  starts: Pref Address Mailing
				try{
						var startdate43  = new Array();
						var index43      = new Array();
						var z=0;
						for(var k = 0; k < noOfAdr ; k++) {
						if((ad_address_type[k] == "Alt Lang Address" ) && !(adr_Status[k] == "Remove")) {
						startdate43[z] = ad_start_date[k];
						index43[z] = k;
						z++;
						}
						}
						noOfaddress = startdate43.length;
						if( noOfaddress >1){
						for ( var i = (noOfaddress - 1); i >= 0; i-- )
						{
						for (var j = 1; j <= i; j++)
						{
						var millistartdate1 = changetoMillis(startdate43[j-1]);
						var millistartdate2 = changetoMillis(startdate43[j]);
						if (millistartdate1 > millistartdate2)
						{
						var temp = startdate43[j-1];
						startdate43[j-1] = startdate43[j];
						startdate43[j] = temp;

						var temp1 = index43[j-1];
						index43[j-1] = index43[j];
						index43[j] = temp1;
						}
						}
						}
						}
						for(var k = 0; k < noOfaddress ; k++) {
						findex = index43[k];
						if(!(startdate43[k+1]) == ''){
						//tracker 113259:Hijri:to validate for hijri dates:change start
						 ad_end_date[findex] = address_enddateHij(altCalendarHij,startdate43[k+1]);
				  		//tracker 113259:Hijri:to validate for hijri dates:change end
						}
						else{
						ad_end_date[findex] = "";
						}
						}
						}
						catch(e)
				{}
			//Fix for tracker 258530 ends: Pref Address Mailing
		// fetching end date for addresstype 'Alt Lang Address' -end

		//Changes END for Ticket ID : 365978 and Tracker ID : 224750
		// fetching end date for addresstype 'Registered'
		try{
		var startdate1  = new Array();
		var index1      = new Array();
		var z=0;
		for(var k = 0; k < noOfAdr ; k++) {
		if((ad_address_type[k] == "Registered") && !(adr_Status[k] == "Remove")) {
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
		/*TRACKER 86358 BEGIN*/
		//current registered address check start
		noOfRegAddress = startdate1.length;
		var currentCount = 0;
		var todayDate = new String();
		todayDate.value = getTodayDate1(locDate);
		for(var k = 0; k < noOfRegAddress ; k++)
		{
			var millistartdate1 = changetoMillis(startdate1[k]);
			var millistartdate2 = changetoMillisForToday(todayDate.value);
			if (millistartdate1 <= millistartdate2)
			{
				currentCount=currentCount+1;
			}
		}
		if(corpsubmit=='true')
		{
		/*TRACKER ID 122707 changes Begin For Sanity Bug Fixing*/
		//Condition added so that in Edit screen no error message is shown even when
		//Address is present in listing
		//Changes for ticket 298764 : Begin
		if (currentCount == 0 )
		{
		/*TRACKER ID 122707 changes End For Sanity Bug Fixing*/
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50496",""),TBODY_AdrRecordSet.rows ,'NO_HLINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive";
		}
		}
		//Changes for ticket 298764 : End
		//current registered address check end
		/*TRACKER 86358 END*/
		for(var k = 0; k < noOfaddress ; k++) {
		findex = index1[k];
		if(!(startdate1[k+1]) == ''){
		//tracker 113259:Hijri:to validate for hijri dates:change start
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
		// fetching end date for addresstype 'Registered' -end
		// fetching end date for addresstype 'Head Office'
		try{
		var startdate2  = new Array();
		var index2      = new Array();
		var z=0;
		for(var k = 0; k < noOfAdr ; k++) {
		if((ad_address_type[k] == "Head Office") && !(adr_Status[k] == "Remove")) {
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
		// fetching end date for addresstype 'Head Office' -end
		// TRACKER 112270  changes-Begin
		// fetching end date for addresstype Others -begin
		   setEndDateForOtherCorpAddrType(noOfAdr,ad_address_type,adr_Status)
		// fetching end date for addresstype Others -end
		// TRACKER 112270  changes-End
		// date validations-end
		preferredAddress = document.getElementsByName('CorporateBO.Address.preferredAddress')[0];
		var preferredAddressFlag = false;
		if(corpsubmit == 'true')
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
				for(var r=0 ; r < document.all.AdrRecordSet.rows.length ; r++)
				{
					// Tracker ID: 135125: XMLEncoding Changes STARTS
					if(boName=='CorporateBO'){
						recordSetAddressCategory = document.all.AdrRecordSet.rows(r).getAttribute("CorporateBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.AdrRecordSet.rows(r).getAttribute("CorporateBO.Address.PreferredFormat");
					}
					else if(boName=='CorporateModBO'){
						recordSetAddressCategory = document.all.AdrRecordSet.rows(r).getAttribute("CorporateModBO.Address.addressCategory");
						recordSetAddressPreferredFormat = document.all.AdrRecordSet.rows(r).getAttribute("CorporateModBO.Address.PreferredFormat");
					}
					// Tracker ID: 135125: XMLEncoding Changes ENDS
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
					if (preferredAddress.value == "Mailing") {
						noOfPrefaddress = startdate.length;
						prefStartDate =startdate;
					}
					  //Changes For ticket 312035
					   else if (preferredAddress.value == "Registered") {
						   noOfPrefaddress = startdate1.length;
						   prefStartDate =startdate1;
					   }
					   //Changes For ticket 312035
					else if (preferredAddress.value == "Head Office") {
						noOfPrefaddress = startdate2.length;
						prefStartDate =startdate2;
					}
					else {
						currentPrefCount=-1;
					}

					if (currentPrefCount != -1 ) {
						for(var k = 0; k < noOfPrefaddress ; k++)
						{
							var millistartdate1 = changetoMillis(prefStartDate[k]);
							var millistartdate2 = changetoMillis(todayDate.value);
							if (millistartdate1 <= millistartdate2)
							{
								currentPrefCount=currentPrefCount+1;
							}
						}
						if (currentPrefCount == 0)
						{
							 if(corpsubmit == 'true')
							 {
							parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ50495",""),TBODY_AdrRecordSet.rows ,'NO_HLINK');
							parent.parent.parent.parent.messageFrm.showMessages(selTabId);
							return "interactive"
							}
						}
					}
				}
			}
			preferredPhone = document.getElementsByName('CorporateBO.PhoneEmail.PhoneEmailType')[0];
			preferredEmail = document.getElementsByName('CorporateBO.PhoneEmail.PhoneEmailType1')[0];
			var preferredPhoneFlag = false;
			var preferredEmailFlag = false;

			//Tracker 184709 Starts
				var phoneCheck = phoneEmailCheck();
				if(phoneCheck == "false" || phoneCheck == false) {
					return "interactive";
				}

			//Tracker 184709 Ends
			//Equity DRC, Customization changes for CR20 starts
			var bflagCell="false";
			if(boName=='CorporateBO'){
			
			for(var r=0 ; r < document.all.PhoneEmailRecordSet.rows.length ; r++)
						{
						var PhoneType= document.all.PhoneEmailRecordSet.rows(r).getAttribute("CorporateBO.PhoneEmail.PhoneEmailType");
						if (PhoneType == 'CELLPH') {
							bflagCell="true";				
						}
						}
			}else if(boName=='CorporateModBO'){
				
			for(var r=0 ; r < document.all.PhoneEmailRecordSet.rows.length ; r++)
						{
				var PhoneType= document.all.PhoneEmailRecordSet.rows(r).getAttribute("CorporateModBO.PhoneEmail.PhoneEmailType");
			if (PhoneType == 'CELLPH') {
							bflagCell="true";				
						}
			}
			}
			if(bflagCell=="false")
		{
		//alert("phonechk");
			selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG086","Cell Phone Number"), preferredPhone.name, 'NO_HLINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				//showMessage(getUserErrorMessage('MSG086', "Cell Phone"));
				return "interactive";
		}

 //Equity DRC, Customization changes for CR20 ends
			

			if((preferredPhone.value != null && preferredPhone.value != 'undefined') || (preferredEmail.value != null && preferredEmail.value != 'undefined') )
			{
					// Tracker ID: 135125: XMLEncoding Changes STARTS
					if(boName=='CorporateBO'){
						for(var r=0 ; r < document.all.PhoneEmailRecordSet.rows.length ; r++)
						{
							recordSetPhone = document.all.PhoneEmailRecordSet.rows(r).getAttribute("CorporateBO.PhoneEmail.PhoneEmailType");
							if(preferredPhone.value == recordSetPhone && preferredPhone.value != null){
								preferredPhoneFlag = true;
							}
							recordSetPhone1 = document.all.PhoneEmailRecordSet.rows(r).getAttribute("CorporateBO.PhoneEmail.PhoneEmailType1");
							if(preferredEmail.value == recordSetPhone1 && preferredEmail.value != null){
								preferredEmailFlag = true;
							}
						}
					}
					else if(boName=='CorporateModBO'){
						for(var r=0 ; r < document.all.PhoneEmailRecordSet.rows.length ; r++)
						{
							recordSetPhone = document.all.PhoneEmailRecordSet.rows(r).getAttribute("CorporateModBO.PhoneEmail.PhoneEmailType");
							if(preferredPhone.value == recordSetPhone && preferredPhone.value != null){
								preferredPhoneFlag = true;
							}
							recordSetPhone1 = document.all.PhoneEmailRecordSet.rows(r).getAttribute("CorporateModBO.PhoneEmail.PhoneEmailType1");
							if(preferredEmail.value == recordSetPhone1 && preferredEmail.value != null){
								preferredEmailFlag = true;
							}
						}
					}
					// Tracker ID: 135125: XMLEncoding Changes ENDS
				if(!preferredPhoneFlag && preferredPhone.value != null && preferredPhone.value != '')
				{
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
					//recon of changes for FS : 714902 - TOL 444472  Start 
					parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSGJ51839",""), preferredPhone.name, 'NO_HLINK');
					//recon of changes for FS : 714902 - - TOL 444472  End
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
			}
		}
		addAdrCounter = 0 ;
		addPhoneEmailCounter = 0;
		clearValues();
		try {
		for(var i = 0; i <noOfAdr; i++) {
		if((adr_URL[i] != null) && !(adr_Status[i] == "Remove")) {
		if(addAdrCounter == 0) {
		document.frm2.address_type.value=srmEscape(ad_address_type[i], '^', escChars);
	/*Tracker 159095 : Sonali begin of changes*/
		document.frm2.houseno.value=srmEscapeAddr(ad_houseno[i], '^', escCharsAddr);;
		document.frm2.premiseno.value = srmEscapeAddr(ad_premiseno[i], '^', escCharsAddr);
		document.frm2.building.value = srmEscapeAddr(ad_building[i], '^', escCharsAddr);
	/*Tracker 159095 : Sonali  end of changes*/
		document.frm2.country.value = srmEscape(ad_country[i], '^', escChars);
		document.frm2.city.value = srmEscape(ad_city[i], '^', escChars);
		document.frm2.state.value = srmEscape(ad_state[i], '^', escChars);
	    /***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
			//address start and end date changes
			var strAltCalType = ALTCALENDAR_TYPE;
			if(strAltCalType == 'true')
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
	     /***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
		document.frm2.start_date.value = srmEscape(ad_start_date[i], '^', escChars);
		document.frm2.zip.value = srmEscape(ad_zip[i], '^', escChars);
		//Equity Bank DRC,Customization changes for CGCR19 start
		document.frm2.ADDR_USERFIELD1.value = srmEscape(ad_Region[i], '^', escChars);
		//Equity Bank DRC,Customization changes for CGCR19 end

		document.frm2.end_date.value = srmEscape(ad_end_date[i], '^', escChars);
		document.frm2.addrID.value = srmEscape(ad_addrID[i], '^', escChars);
	/*Tracker 159095 : Sonali begin of changes*/
		document.frm2.streetno.value = srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
		document.frm2.town.value = srmEscapeAddr(ad_town[i], '^', escCharsAddr);
		document.frm2.locality.value = srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
		document.frm2.domicile.value = srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
		document.frm2.website.value = srmEscapeAddr(ad_website[i], '^', escCharsAddr);
		document.frm2.mailstop.value = srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
		document.frm2.streetname.value = srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
		document.frm2.suburb.value = srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
	/*Tracker 159095 : Sonali  end of changes*/
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
		document.frm2.IsAddressVerified.value = srmEscape(ad_IsAddressVerified[i], '^', escChars);
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
		document.frm2.swiftcode.value = srmEscape(ad_swiftcode[i], '^', escChars);
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
		document.frm2.PreferredAddress.value = document.getElementsByName('CorporateBO.Address.preferredAddress')[0].value;
		document.frm2.addr_city_code.value = srmEscape(ad_city_cat[i], '^', escChars);
		document.frm2.addr_state_code.value = srmEscape(ad_state_cat[i], '^', escChars);
		document.frm2.addr_cntry_code.value = srmEscape(ad_country_cat[i], '^', escChars);
		document.frm2.IsAddressProofRcvd.value = srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
		addAdrCounter = 1;
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
	/***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
		 				//address start and end date changes
		 				var strAltCalType = ALTCALENDAR_TYPE;
		 				if(strAltCalType == 'true')
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
	/***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
		document.frm2.start_date.value = document.frm2.start_date.value + "," + srmEscape(ad_start_date[i], '^', escChars);
		document.frm2.zip.value = document.frm2.zip.value + "," + srmEscape(ad_zip[i], '^', escChars);
		//Equity Bank DRC,Customization changes for CGCR19 start
		document.frm2.ADDR_USERFIELD1.value = document.frm2.ADDR_USERFIELD1.value + "," + srmEscape(ad_Region[i], '^', escChars);
		//Equity Bank DRC,Customization changes for CGCR19 end

		document.frm2.end_date.value = document.frm2.end_date.value + "," + srmEscape(ad_end_date[i], '^', escChars);
		document.frm2.addrID.value = document.frm2.addrID.value + "," + srmEscape(ad_addrID[i], '^', escChars);
		/*CRM102ST:TrackerID:179465 Being of Change */
		//document.frm2.streetno.value = document.frm2.streetno.value + "," + srmEscape(ad_streetno[i], '^', escChars);
		/*CRM102ST:TrackerID:179465 End of Change */
	/*Tracker 159095 : Sonali begin of changes*/
		document.frm2.streetno.value = document.frm2.streetno.value + "%" + srmEscapeAddr(ad_streetno[i], '^', escCharsAddr);
		document.frm2.town.value = document.frm2.town.value + "%" + srmEscapeAddr(ad_town[i], '^', escCharsAddr);
		document.frm2.locality.value = document.frm2.locality.value + "%" + srmEscapeAddr(ad_locality[i], '^', escCharsAddr);
		document.frm2.domicile.value = document.frm2.domicile.value + "%" + srmEscapeAddr(ad_domicile[i], '^', escCharsAddr);
		document.frm2.website.value = document.frm2.website.value + "%" + srmEscapeAddr(ad_website[i], '^', escCharsAddr);
		document.frm2.mailstop.value = document.frm2.mailstop.value + "%" + srmEscapeAddr(ad_mailstop[i], '^', escCharsAddr);
		document.frm2.streetname.value = document.frm2.streetname.value + "%" + srmEscapeAddr(ad_streetname[i], '^', escCharsAddr);
		document.frm2.suburb.value = document.frm2.suburb.value + "%" + srmEscapeAddr(ad_suburb[i], '^', escCharsAddr);
	/*Tracker 159095 : Sonali end of changes*/
	//	document.frm2.extension.value = document.frm2.extension.value + "," +srmEscape(ad_extension[i], '^', escChars);
		document.frm2.swiftcode.value = document.frm2.swiftcode.value + "," +srmEscape(ad_swiftcode[i], '^', escChars);
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
	/*Tracker 159095 : Sonali end of changes*/		document.frm2.PreferredAddress.value = document.getElementsByName('CorporateBO.Address.preferredAddress')[0].value;
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
		document.frm2.IsAddressVerified.value = document.frm2.IsAddressVerified.value + "," + srmEscape(ad_IsAddressVerified[i], '^', escChars);
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
		document.frm2.addr_city_code.value = document.frm2.addr_city_code.value + "," +srmEscape(ad_city_cat[i], '^', escChars);
		document.frm2.addr_state_code.value = document.frm2.addr_state_code.value + "," +srmEscape(ad_state_cat[i], '^', escChars);
		document.frm2.addr_cntry_code.value = document.frm2.addr_cntry_code.value + "," +srmEscape(ad_country_cat[i], '^', escChars);
		document.frm2.IsAddressProofRcvd.value = document.frm2.IsAddressProofRcvd.value + "," + srmEscape(ad_IsAddressProofRcvd[i], '^', escChars);
		}
		}
		}
		var sep =",";
		var st ="";
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
					document.frm2.PreferredPhone.value = document.getElementsByName('CorporateBO.PhoneEmail.PhoneEmailType')[0].value;
					document.frm2.PreferredEmail.value = document.getElementsByName('CorporateBO.PhoneEmail.PhoneEmailType1')[0].value;
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
					document.frm2.extension.value = document.frm2.extension.value + " ," + srmEscape(ad_extension[i], '^', escChars);
					document.frm2.PreferredEmail.value = document.getElementsByName('CorporateBO.PhoneEmail.PhoneEmailType1')[0].value;
					document.frm2.PreferredPhone.value = document.getElementsByName('CorporateBO.PhoneEmail.PhoneEmailType')[0].value;
				 }
			 }
		 }
		} catch(ge) {  }
		document.frm2.AdrRemoved.value = getCSVforArray(adr_detachedURLs);
		document.frm2.PhoneEmailRemoved.value = getCSVforArray(phone_detachedURLs);
setHiddenFields();
	noOfID = EDoc_URL.length;
	clearIDValues();
	try
	{
		for(var i = 0; i <noOfID; i++)
		{
			/*221040 Changes start*/
			if(EDoc_URL[i] != null){
			/*221040 Changes end*/
			if(document.frm2.unique_id.value != "")
			{
				document.frm2.identifier_type_Code.value		= document.frm2.identifier_type_Code.value + "," + srmEscape(EDoc_identifier_type_Code[i], '^', escChars);
				document.frm2.unique_id.value					= document.frm2.unique_id.value + "," + srmEscape(EDoc_unique_id[i], '^', escChars);;
		 /*******ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
			      var ALTCALENDAR_TYPE = ALTCALENDAR_TYPE;
				if(ALTCALENDAR_TYPE == 'true')
				{
				   if(EDoc_dateofissue[i] != '')
				   {
				    var strFlag = isGregDateWithoutConv(EDoc_dateofissue[i]);
				    if(strFlag != 'true')
					{
						EDoc_dateofissue[i]=convertHijToGreg(EDoc_dateofissue[i]);
					}
				   }
				if(EDoc_validity_date[i] != '')
				   {
				    var strFlag = isGregDateWithoutConv(EDoc_validity_date[i]);
				    if(strFlag != 'true')
					{
						EDoc_validity_date[i]=convertHijToGreg(EDoc_validity_date[i]);
					}
				   }
				}
	/************ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
				document.frm2.dateofissue.value 				= document.frm2.dateofissue.value + "," + srmEscape(EDoc_dateofissue[i], '^', escChars);
				document.frm2.validity_date.value 				= document.frm2.validity_date.value + "," + srmEscape(EDoc_validity_date[i], '^', escChars);
				document.frm2.hidEntityDocumentID.value 		= document.frm2.hidEntityDocumentID.value + "," + srmEscape(EDoc_EntityDocumentID[i], '^', escChars);
				document.frm2.hidEntityDocumentURL.value		= document.frm2.hidEntityDocumentURL.value + "," + srmEscape(EDoc_EntityDocumentURL[i], '^', escChars);
				document.frm2.hidDocCode.value 					= document.frm2.hidDocCode.value + "," + srmEscape(EDoc_docCode[i], '^', escChars);
				document.frm2.hidDocDescr.value 				= document.frm2.hidDocDescr.value + "," + srmEscape(EDoc_docDescr[i], '^', escChars);
				document.frm2.hidDocTypeCode.value 				= document.frm2.hidDocTypeCode.value + "," + srmEscape(EDoc_docTypeCode[i], '^', escChars);
				document.frm2.hidDocTypeDescr.value 			= document.frm2.hidDocTypeDescr.value + "," + srmEscape(EDoc_docTypeDescr[i], '^', escChars);
				document.frm2.hidDocReceivedDate.value 			= document.frm2.hidDocReceivedDate.value + "," + srmEscape(EDoc_docReceivedDate[i], '^', escChars);
				document.frm2.hidDocRemarks.value 				= document.frm2.hidDocRemarks.value + "," + srmEscape(EDoc_docRemarks[i], '^', escChars);
				document.frm2.hidStatus.value 					= document.frm2.hidStatus.value + "," + srmEscape(EDoc_Status[i], '^', escChars);
				document.frm2.hidIsMandatory.value 				= document.frm2.hidIsMandatory.value + "," + srmEscape(EDoc_isMandatory[i], '^', escChars);
				document.frm2.hidScanRequired.value 			= document.frm2.hidScanRequired.value + "," + srmEscape(EDoc_scanRequired[i], '^', escChars);
				document.frm2.placeofissue.value 				= document.frm2.placeofissue.value + "," + srmEscape(EDoc_placeofissue[i], '^', escChars);
				document.frm2.countryofissue.value 				= document.frm2.countryofissue.value + "," + srmEscape(EDoc_countryofissue[i], '^', escChars);
				document.frm2.hidEDoc_IsDirty.value 			= document.frm2.hidEDoc_IsDirty.value + "," + srmEscape(EDoc_IsDirty[i], '^', escChars);
				document.frm2.hidIsDocumentVerified.value 		= document.frm2.hidIsDocumentVerified.value + "," + srmEscape(EDoc_isDocumentVerified[i], '^', escChars);
				document.frm2.hidIDIssuedOrg.value 		= document.frm2.hidIDIssuedOrg.value + "," + srmEscape(EDoc_idIssuedOrg[i], '^', escChars);
				
				document.frm2.hidUserField5.value 		= document.frm2.hidUserField5.value + "," + srmEscape(EDoc_UserField5[i], '^', escChars);
			}
			else
			{
				document.frm2.identifier_type_Code.value		        = srmEscape(EDoc_identifier_type_Code[i], '^', escChars);
				document.frm2.unique_id.value					= srmEscape(EDoc_unique_id[i], '^', escChars);;
			/*******ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
			      var ALTCALENDAR_TYPE = ALTCALENDAR_TYPE;
				if(ALTCALENDAR_TYPE == 'true')
				{
				   if(EDoc_dateofissue[i] != '')
				   {
				    var strFlag = isGregDateWithoutConv(EDoc_dateofissue[i]);
				    if(strFlag != 'true')
					{
						EDoc_dateofissue[i]=convertHijToGreg(EDoc_dateofissue[i]);
					}
				   }
				if(EDoc_validity_date[i] != '')
				   {
				    var strFlag = isGregDateWithoutConv(EDoc_validity_date[i]);
				    if(strFlag != 'true')
					{
						EDoc_validity_date[i]=convertHijToGreg(EDoc_validity_date[i]);
					}
				   }
				}
	/************ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
				document.frm2.dateofissue.value 				= srmEscape(EDoc_dateofissue[i], '^', escChars);
				document.frm2.validity_date.value 				= srmEscape(EDoc_validity_date[i], '^', escChars);
				document.frm2.hidEntityDocumentID.value 		    =  srmEscape(EDoc_EntityDocumentID[i], '^', escChars);
				document.frm2.hidEntityDocumentURL.value		=  srmEscape(EDoc_EntityDocumentURL[i], '^', escChars);
				document.frm2.hidDocCode.value 					=  srmEscape(EDoc_docCode[i], '^', escChars);
				document.frm2.hidDocDescr.value 				=  srmEscape(EDoc_docDescr[i], '^', escChars);
				document.frm2.hidDocTypeCode.value 				=  srmEscape(EDoc_docTypeCode[i], '^', escChars);
				document.frm2.hidDocTypeDescr.value 			=  srmEscape(EDoc_docTypeDescr[i], '^', escChars);
				document.frm2.hidDocReceivedDate.value 			=  srmEscape(EDoc_docReceivedDate[i], '^', escChars);
				document.frm2.hidDocRemarks.value 				=  srmEscape(EDoc_docRemarks[i], '^', escChars);
				document.frm2.hidStatus.value 					=  srmEscape(EDoc_Status[i], '^', escChars);
				document.frm2.hidIsMandatory.value 				= srmEscape(EDoc_isMandatory[i], '^', escChars);
				document.frm2.hidScanRequired.value 			=  srmEscape(EDoc_scanRequired[i], '^', escChars);
				document.frm2.placeofissue.value 				= srmEscape(EDoc_placeofissue[i], '^', escChars);
				document.frm2.countryofissue.value 				= srmEscape(EDoc_countryofissue[i], '^', escChars);
				document.frm2.hidEDoc_IsDirty.value 			=  srmEscape(EDoc_IsDirty[i], '^', escChars);
				document.frm2.hidIsDocumentVerified.value 		=  srmEscape(EDoc_isDocumentVerified[i], '^', escChars);
				document.frm2.hidIDIssuedOrg.value 		=  srmEscape(EDoc_idIssuedOrg[i], '^', escChars);
				
				document.frm2.hidUserField5.value 		=  srmEscape(EDoc_UserField5[i], '^', escChars);
				
			}
		/*221040 Changes start*/
		}
		/*221040 Changes end*/
		}
	}
	catch(e)
	{
		//alert("Exception>>save() while saving identification details:\n" + e.message);
	}
	
	if ((operationType == "Create") || (operationType == "EditEntity") || (operationType == "Queue") || (operationType == "ConvtoCust")) {
		var isFormedFlg = getCookie('Filter_isFormedFlg');
		alert("Filter_isFormedFlg g: " + isFormedFlg);
	
		if (isFormedFlg == "N") {
			var c = 0;
			alert("Count: " + document.all.EDocRecordSet.rows.length);
			for (var t = 2; t < document.all.EDocRecordSet.rows.length; t++) {
				var row = document.all.EDocRecordSet.rows[t];
				var EntityDocumentID = row.getAttribute("EntityDocumentBO.EntityDocumentID");
				if (EntityDocumentID !== null && EntityDocumentID !== undefined) {
					var docCodeValue = trim(row.getAttribute("EntityDocumentBO.DocCode"));
					var docTypeCodeValue = trim(row.getAttribute("EntityDocumentBO.DocTypeCode"));
					if (docCodeValue == "14" && (docTypeCodeValue == "INDIV" || docTypeCodeValue == "RGENT")) {
						c = 1;
						break;
					}
				}
			}
			
			alert("C: " + c);
			if (c == 0) {
				alert("The national ID must be entered / Le numéro d'identification national doit être saisi!");
				return "interactive";
			} else {
				deleteCookie('Filter_isFormedFlg');
			}
		}
	}
	
	  /*Customization to check if doc is same starts*/
	   if((operationType != 'EditEntity') && (operationType != 'Queue') && (operationType != 'ConvtoCust'))
	   {
     var Filter_uniqueId = getCookie('Filter_uniqueId');
     var Filter_documentcode = getCookie('Filter_documentcode');
	
     var temp = new Array();
     var temp1 = new Array();
     temp1= document.frm2.unique_id.value.split(",");
     temp= document.frm2.hidDocCode.value.split(",");
     var k=0;
     for(i=0;i<temp1.length;i++)
	{
	
	if(temp1[i]==Filter_uniqueId)
	  {
	  if(temp[i]==Filter_documentcode)
	    {
	     k=1;
	     break;			  
	    }
	  }
	}	                
	if(k==0)
	{
	alert("The identification document details do not match with the details entered in customer onboard menu");
	return "interactive";
	}
	}
	/*Customization to check if doc is same ends*/
	document.frm2.IDRemoved.value = getCSVforArray(EDoc_detachedURLs);
	//Change for DBS ticket 325152
	//document.frm2.SwiftAddressDetails.value 		= SwiftAddressDetails;
try {
	if (entityType == 'Customer') {
			 document.frm2.selAvailBackendID.value = "" ;
			 for(i=0;i<document.frm2.Available_BackendID.length;i++)
			 {
				 var Available_BackendID= document.frm2.Available_BackendID.options[i].text;
				 if(document.frm2.selAvailBackendID.value != "") {
						document.frm2.selAvailBackendID.value = document.frm2.selAvailBackendID.value + "," + Available_BackendID;
				 } else {
						document.frm2.selAvailBackendID.value = Available_BackendID;
				 }
			 }
	}
}
catch (Ex) {
}
	/* Changes for the ticketid:374030 Starts - for saving the currency tab */
	saveConcession();
	/* Changes for the ticketid:374030 Ends */
var saveFlag = 0;
if(corpsubmit=='false')
{
	saveFlag = 1;
}
	var ownerSegment= document.getElementsByName('CorporateBO.accessOwnerSegment')[0].value;
	var primaryRM=document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].value;
	var secondaryRM=document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].value;
	//fix for ticket 334796 starts
	<!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Starts-->
	var tertiaryRM=document.getElementsByName("CorporateBO.TertiaryRMLogin_ID")[0].value;
	<!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Ends-->
		//fix for ticket 334796 ends
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
		//fix for ticket 334796 starts
	else if (SegmentChanged=="true" && ((primaryRM!=null && primaryRM!='') || (secondaryRM!=null && secondaryRM!=''))) {
		//fix for ticket 334796 ends
		if(showConfirmMessage(MSGJ50357)){
		}else{
			return "interactive";
		}
	}
if(document.frm2.isMCEditedGeneral.value=="N" && document.frm2.mcJNDIFlag.value=="true"){
		approval="false";
	}





			fnConvertDate();

			newPara = document.getElementById("myPar");
			var frame='formSaveFrame';

	/***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/

var fetchFrom = document.frm2.fetchFrom.value;

/****      Swift Address Changes Begin   ****/




	if(SwiftAddressDetails==""){
	SwiftAddressDetails='YYY';
		if(corpsubmit == 'true'){
			parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(), "Swift Address is Defaulted from Preferred Address Type");
			parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames(0).getSelectedTabId());
		}
	}
//Change for ticket 326535
document.frm2.SwiftAddressDetails.value 		= SwiftAddressDetails;

if(operationType=="Queue"){
document.frm2.hid_reservestatus.value=operationType;
}
/*** 10.2.18 Techonline 857772 Fix ***/
           try{ 
               newPara.innerHTML=''; 
            }catch(e){
				
			} 
/*** 10.2.18 Techonline 857772 Fix ***/


if ((approval=="false" && operationType=="Create" && saveFlag==0)||(operationType=="EditEntity")||(approval=="false" && operationType=="Queue" && fetchFrom == 'Main'))
{

	   <!--tracker id 113227 starts-->
//document.frm2.action = "../servlet/com.infy.cis.ui.corpcif.CorpGenWriter?saveFlag="+saveFlag;
	 //Change for DBS ticket 325152

	  //document.frm2.action = "../servlet/com.infy.cis.ui.corpcif.CorpGenWriter?saveFlag="+saveFlag+"&SwiftAddressDetails="+SwiftAddressDetails+"&dual="+dualflag ;
	  <!--tracker id 113227 ends-->
	  /*Null Changes*/
	 /*changes for callid: 235861 Ticket: 454978 tracker: 275564  start */
	 var SubmitURL="../servlet/com.infy.cis.ui.corpcif.CorpGenWriter?saveFlag="+saveFlag+"&dual="+dualflag ;
	  /*changes for callid: 235861 Ticket: 454978 tracker: 275564  end */
	 fnRemoveNull(newPara,SubmitURL,document.frm2,frame);
	 /*Null Changes End*/

}
else
{
	<!--tracker id 113227 starts-->
//document.frm2.action = "../servlet/com.infy.cis.ui.corpcif.CorpModGenWriter?saveFlag="+saveFlag+"&boName="+boName+"&boNameCI="+boNameCI;
	//Change for DBS ticket 325152

	//document.frm2.action = "../servlet/com.infy.cis.ui.corpcif.CorpModGenWriter?saveFlag="+saveFlag+"&boName="+boName+"&boNameCI="+boNameCI+"&dual="+dualflag;
  <!--tracker id 113227 ends-->;
  /*Null Changes*/
   /*changes for callid: 235861 Ticket: 454978 tracker: 275564  start */
  var SubmitURL="../servlet/com.infy.cis.ui.corpcif.CorpModGenWriter?saveFlag="+saveFlag+"&boName="+boName+"&boNameCI="+boNameCI+"&dual="+dualflag;
   /*changes for callid: 235861 Ticket: 454978 tracker: 275564  ends */
  fnRemoveNull(newPara,SubmitURL,document.frm2,frame);
  /*Null Changes End*/

}
/************* Save and Submit Changes End***********/

//document.frm2.target="formSaveFrame";
//document.frm2.submit();
return "true";

clearValues();
//IDENTIFICATION DOCUMENT CHANGES start

clearIDValues();
//IDENTIFICATION DOCUMENT CHANGES end

}
 function fnConvertDate()
		{
			var arrDateList = new Array();
			var arrFinalDateList = new Array();
			var strAltCalType = document.all.ALTCALENDAR_TYPE.value;
			var strRelStrtDt =document.getElementsByName("3_CorporateBO.relationship_StartDate")[0].value;
			var strDateOfCommencmnt =document.getElementsByName("3_CorporateBO.date_Of_Commencement")[0].value;
			var strRiskProfileExpDt =document.getElementsByName("3_CorporateBO.RiskProfileExpiryDate")[0].value;
			var strDateOfIncorp =document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0].value;
			var strAdvAsOnDt =document.getElementsByName("3_CorporateBO.AdvanceAsOnDate")[0].value;
			var strCustStatChngDt =document.getElementsByName("3_CorporateBO.Cust_Stat_Chg_Date")[0].value;
			var strConvDt =document.getElementsByName("CorporateBO.converted_Date")[0].value;
			var strClassifiedOnDt =document.getElementsByName("3_CorporateBO.classified_On")[0].value;
			var strEffectiveDt =document.getElementsByName("3_CorporateBO.effective_Date")[0].value;
				arrDateList[0] = strRelStrtDt;
				arrDateList[1] = strDateOfCommencmnt;
				arrDateList[2] = strRiskProfileExpDt;
				arrDateList[3] = strDateOfIncorp;
				arrDateList[4] = strAdvAsOnDt;
				arrDateList[5] = strCustStatChngDt;
				arrDateList[6] = strConvDt;
				arrDateList[7] = strClassifiedOnDt;
				arrDateList[8] = strEffectiveDt;
			        var iLength = arrDateList.length-1;
				/*TRACKER ID 122707 changes Begin For Sanity Bug Fixing*/
				if(strAltCalType == "true")
				/*TRACKER ID 122707 changes End For Sanity Bug Fixing*/
				{
					for(var iCount=0;iCount<=iLength;iCount++)
					{
						/*TRACKER ID 122707 changes Begin For Sanity Bug Fixing*/
						//date variable declared properly
						var date = arrDateList[iCount];
						/*TRACKER ID 122707 changes End For Sanity Bug Fixing*/
						   if(date == '')
						   {
						   	  arrFinalDateList[iCount]= '';
						   }
						   else
						   {
							  var strFlag = isGregDateWithoutConv(date);
							if(strFlag != 'true')
							{
								date=convertHijToGreg(date);
								arrFinalDateList[iCount]= date;
							}
							else
							{

								arrFinalDateList[iCount]= date;

							}

						   }


					}

					  document.all.relationship_StartDate.value = arrFinalDateList[0];
					  document.all.date_Of_Commencement.value = arrFinalDateList[1];
					  document.all.RiskProfileExpiryDate.value = arrFinalDateList[2];
					  document.all.date_Of_Incorporation.value = arrFinalDateList[3];
					  document.all.AdvanceAsOnDate.value = arrFinalDateList[4];
					  document.all.Cust_Stat_Chg_Date.value = arrFinalDateList[5];
					  document.all.converted_Date.value = arrFinalDateList[6];
					  document.all.classified_On.value = arrFinalDateList[7];
					  document.all.effective_Date.value = arrFinalDateList[8];

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
		//Equity Bank DRC,Customization changes for CGCR19 start
		document.frm2.ADDR_USERFIELD1.value =  "";
		//Equity Bank DRC,Customization changes for CGCR19 end

		document.frm2.end_date.value =  "";
		document.frm2.addrID.value =  "";
		document.frm2.streetno.value= "";
		document.frm2.town.value= "";
		document.frm2.locality.value= "";
		document.frm2.domicile.value= "";
		document.frm2.website.value= "";
		document.frm2.mailstop.value= "";
		document.frm2.streetname.value= "";
	        document.frm2.suburb.value= "";
	        document.frm2.AdrRemoved.value = "";
		document.frm2.addr_city_code.value = "";
		document.frm2.addr_state_code.value = "";
		document.frm2.addr_cntry_code.value = "";
    }
function clearIDValues()
{
	document.frm2.identifier_type_Code.value		= "";
	document.frm2.unique_id.value					= "";
	document.frm2.dateofissue.value 				= "";
	document.frm2.validity_date.value 				= "";
	document.frm2.hidEntityDocumentID.value 		= "";
	document.frm2.hidEntityDocumentURL.value 		= "";
	document.frm2.hidDocCode.value 					= "";
	document.frm2.hidDocDescr.value 				= "";
	document.frm2.hidDocTypeCode.value 				= "";
	document.frm2.hidDocTypeDescr.value 			= "";
	document.frm2.hidDocReceivedDate.value 			= "";
	document.frm2.hidDocRemarks.value 				= "";
	document.frm2.hidStatus.value					= "";
	document.frm2.hidIsMandatory.value 				= "";
	document.frm2.hidScanRequired.value 			= "";
	document.frm2.placeofissue.value 				= "";
	document.frm2.countryofissue.value				= "";
	document.frm2.hidIsDocumentVerified.value 			= "";
		document.frm2.IDIssuedOrg.value =  "";
		document.frm2.hidUserField5.value 			= "";
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


    function openAgentLookup(type)	{
	lookupFor = "Agent_" + type;
	var url;
	if(type == "DSAID")
		url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForPartner";
	else
		url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForAgent&onlyActive=Y";

	<!-- Tracker-id:108380 Changes for centering Lookup BEGIN -->
	wid=900;
	ht=360;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	<!-- Tracker-id # 108380 Changes for centering Lookup END -->
	lookupwindow_UB = window.open (url, "Lookup", "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
}
function  clearGenLookup(type){
	if (type == "PRM")
	  {
		document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].value = "";
	}
  else if (type == "SRM")	{
		document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].value = "";
	}
		//fix for ticket 334796 starts
		<!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Starts-->
  else if (type == "TRM")	{
		document.getElementsByName("CorporateBO.TertiaryRMLogin_ID")[0].value = "";
	}
		<!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Ends-->
		//fix for ticket 334796 ends
  else if (type == "Parent")	{
		document.getElementsByName("CorporateBO.parent_CIF")[0].value = "";
	}
 // added as function
 else if (type == "Tds_CIF_Id")
  {
  	document.getElementsByName("CorporateBO.Tds_CIF_Id")[0].value = "";
  }
 else if (type == "RelCrea")	{
		document.getElementsByName("CorporateBO.relationship_CreatedBy")[0].value = "";
}else if (type == "DSAID")	{
		document.getElementsByName("CorporateBO.dsaID")[0].value = "";
}
if (type =="PRM" || type == "SRM" || type == "TRM" ) {
	setAgentValues();
}
}

function onRecordSelect() {
try{
 if (lookupFor == "Agent_PRM")	{
document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].value = getCookie("LookupLoginID");
document.frm2.prim_id.value = getCookie("LookupLoginID");
	prmURL = getCookie("AgentURL");
	document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].fireEvent("onChange");
        }
	if (lookupFor == "Agent_SRM")	{
	document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].value = getCookie("LookupLoginID");
	document.frm2.sec_id.value = getCookie("LookupLoginID");
	srmURL = getCookie("AgentURL");
	document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].fireEvent("onChange");
	}
// fix for ticket 334796 starts
<!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Starts-->
	if (lookupFor == "Agent_TRM")	{
	document.getElementsByName("CorporateBO.TertiaryRMLogin_ID")[0].value = getCookie("LookupLoginID");
	trmURL = getCookie("AgentURL");
	document.getElementsByName("CorporateBO.TertiaryRMLogin_ID")[0].fireEvent("onChange");
	}
<!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Ends-->
// fix for ticket 334796 ends
if (lookupFor == "Parent")	{
document.getElementsByName("CorporateBO.parent_CIF")[0].value = getCookie("LookupParentCIF");
}
if (lookupFor == "Agent_RelCrea")	{
document.getElementsByName("CorporateBO.relationship_CreatedBy")[0].value = getCookie("LookupLoginID");
document.getElementsByName("CorporateBO.relationship_CreatedBy")[0].fireEvent("onChange");
}
if (lookupFor == "Agent_DSAID")	{
document.getElementsByName("CorporateBO.dsaID")[0].value = getCookie("LookupPartnerKey");
document.getElementsByName("CorporateBO.dsaID")[0].fireEvent("onChange");
}

if (lookupFor == 'Customer')
{
var tempvar = getCookie('LookupChildCoreCustID');
var cifID = getCookie('LookupChildCIFID');
document.getElementsByName("Tds_Cust_Id")[0].value = tempvar;
document.getElementsByName("CorporateBO.Tds_CIF_Id")[0].value = cifID;
}
/*Fix for defect ticket 209648: start: For Corp Prospect, handling was missing*/
if (lookupFor == 'CorpProspect')
{
var tempvar = getCookie('LookupProspectCorpKey');
document.getElementsByName("CorporateBO.Tds_CIF_Id")[0].value = tempvar;
}
/*Fix for defect ticket 209648: ends*/
if (lookupFor =="Agent_PRM" || lookupFor == "Agent_SRM" || lookupFor =="Agent_TRM" ) {
	setAgentValues();
}
	}
	catch(e)
	{
	}
}
function Lookup(type) {
	if(type=="Tds_CIF_Id_corpCust")
	corpCustLookup();
	if(type=="Tds_CIF_Id_corpPros")
		corpProspectLookup();
}
function corpCustLookup() {
    lookupFor = 'Customer';
    /*Tracker Id - 110963 Begin Of Changes*/
     windowAlign();
     var newwin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForCorpCust',
    			     'Lookup',
			     'height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
     /*Tracker Id - 110963 End Of Changes*/
}
function corpProspectLookup() {
    lookupFor = 'CorpProspect';
    /*Tracker Id - 110963 Begin Of Changes*/
     windowAlign();
     var newwin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForCorpProspect',
     			     'Lookup',
			     'height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
     /*Tracker Id - 110963 End Of Changes*/
}
function AccMgrLookup(type)
 {
	 var iAccManagerID = "";
	 lookupFor = "Agent_" + type;
         var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=CorpAM_Lookup&OldAccManagerID="+iAccManagerID;

         <!-- Tracker-id:108380 Changes for centering Lookup BEGIN -->
	 wid=900;
	 ht=360;
	 topCord=(screen.height-ht)/2;
	 leftCord=(screen.width-wid)/2;
	 window.open (url, "Lookup", "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no, titlebar=no,toolbar=no,status=yes,scrollbars=yes");
	<!-- Tracker-id :108380 Changes for centering Lookup END -->
 }
/* CRM70T-ST TRACKER:79152:BEGINOFCHANGES */
function MapAddressType()
 {
 var defAddType = document.getElementsByName("CorporateBO.DefaultAddressType")[0].value;
 if( defAddType == 'M'){
    document.getElementsByName("addType")[0].value = "M";
 }else if( defAddType == 'R' ){
    document.getElementsByName("addType")[0].value = "R";
 }else if( defAddType == 'H'){
    document.getElementsByName("addType")[0].value = "H";
 }
 }
 /* CRM70T-ST TRACKER:79152:ENDOFCHANGES */
 	function fnDefaultShortName()
{

	var lastName = trim(document.getElementsByName("CorporateBO.corporate_Name")[0].value);
	var ShortName ="";
	if(lastName != null && lastName!= ""){
	ShortName = lastName.substring(0,10);
	ShortName = ShortName.toUpperCase();
	document.getElementsByName("CorporateBO.short_Name")[0].value=ShortName;
	}
	else{
	document.getElementsByName("CorporateBO.short_Name")[0].value="";
	}
}
function loadID()
{

document.getElementsByName("CorporateBO.short_Name")[0].readOnly = true;
	if(allowMulti=='N'){
	document.getElementsByName("CorporateBO.GroupHouseHold.GROUP_ID")[0].value=grouph_id;
}


	try
	{
		customLoad();
	}
	catch(e)
	{}
	if(document.frm2.hid_corporateURL.value != '')
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
					isDocumentVerified				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IsDocumentVerified"));
					 idIssuedOrg			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IDIssuedOrganisation"));
					 //alert("Loadid1");
					UserField5=trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.USERFIELD5"));
					//alert("Loadid2");
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
					EDoc_isDocumentVerified[i-2] 		= isDocumentVerified;
					EDoc_idIssuedOrg[i-2]			= idIssuedOrg;
					EDoc_UserField5[i-2]			=	UserField5;
					//alert("Loadid3");
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
				}
			}
		}
		else if(entityDocumentBO_Name=='EntityDocumentModBO'){
			for (i=2; i < document.all.EDocRecordSet.rows.length; i++)
			{
				var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.EntityDocumentID");
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
					isDocumentVerified				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IsDocumentVerified"));
					 idIssuedOrg			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IDIssuedOrganisation"));

					UserField5=					 trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.USERFIELD5"));
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
					EDoc_isDocumentVerified[i-2] 		= isDocumentVerified;
					EDoc_idIssuedOrg[i-2]			= idIssuedOrg;
					EDoc_UserField5[i-2]=UserField5;
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
				}
			}
		}
	}
}
function loadBackEnd() {
	var k = 0;
	if (assignedBackEndID!=null && assignedBackEndID!="" && assignedBackEndID!= "null" ) {
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
	}
}

function setAgentValues() {
	var primaryRM=document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].value;
	var secondaryRM=document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].value;
	// fix for ticket 334796 starts
<!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Starts-->
	var tertiaryRM=document.getElementsByName("CorporateBO.TertiaryRMLogin_ID")[0].value;
	if ( (primaryRM!="" && primaryRM != defaultPrimaryRM && primaryRM!=null && primaryRM!="null") || (secondaryRM !="" && secondaryRM != defaultSecondaryRM && secondaryRM !=null && secondaryRM!="null")||(tertiaryRM!="" && tertiaryRM != defaultTertiaryRM && tertiaryRM!=null && tertiaryRM!="null")) {
<!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Ends-->
	// fix for ticket 334796 ends

		RMChanged='true';
	}
	else {
		RMChanged='false';
	}
}
function onRecordSelectCIFID(reservedID) {
	document.getElementsByName("CorporateBO.corp_Key")[0].value=reservedID;
	reserveCIFID = reservedID;
	document.getElementsByName("hid_reservestatus")[0].value = "Lookup";
}
function checkStatus(elename,keyGeneration) {
try {
	var elemValue = document.getElementsByName(elename)[0].value;
	if (elemValue =="" || reserveCIFID == elemValue|| keyGeneration== 'Reserved'||keyGeneration=="") {
		return;
	}
	else {
		checkReseravtion(elename,'Corporate',keyGeneration);
	}
}
catch (e) {
}
}
/* Changes done for Ticket ID 354385 , Tracker ID 219374 Start */
/************************************************************************
	 *            	Swift Address Changes Begin
 ***********************************************************************/

function createSwiftAddress(corpID,readMode)
{

	var boName = "CorporateBO";
	try
	{
		if(corpID==""){
			corpID=null;
		}
		if(corpID==null){
			var mode="Create";
			var isEdit="N";
			var isReadOnly="N";
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
        			document.frm2.action ="../servlet/com.infy.cis.ui.cif.SwiftAddressForm_det?boName="+boName+"&isReadOnly="+isReadOnly+"&mode="+mode+"&getMCRequired="+getMCRequired;
				document.frm2.submit();
		 }else{
			 editSwiftAddress(corpID,readMode);
		 }


	}
	catch(e)
	{alert(e.message);}

 }
function editSwiftAddress(corpID,isReadOnly)
{
	var boName = "CorporateBO";
	var mode="Edit";
	//var isReadOnly;
	var getMCRequired=document.frm2.getMCRequired.value;
	var wh = 260;
	var ww = 900;
	var left_x = (screen.width - ww) / 2 ;
	var left_y = (screen.height - wh) / 2 ;
	var accID = corpID;

	//Change for DBS ticket 325152
	docTypeNew = window.open('../common/html/SSOblank.html', 'SwiftAddressDetails', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=no');

	document.frm2.target = 'SwiftAddressDetails';
	document.frm2.SwiftAddressDetails.value=SwiftAddressDetails;

	document.frm2.action ="../servlet/com.infy.cis.ui.cif.SwiftAddressForm_det?boName="+boName+"&isReadOnly="+isReadOnly+"&accID="+accID+"&mode="+mode+"&getMCRequired="+getMCRequired;

	document.frm2.submit();

}
 /*****************************************************************************************
 *		End of Swift Address changes
 ******************************************************************************************/
/* Changes done for Ticket ID 354385 , Tracker ID 219374 End */
function sortMe(col,order)
{





}
 function  openGroupLookup(){
 lookupFor = "Group"
 var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=CorpGroup&NewGroup=Y";
 window.open (url, "Lookup", "height=436, left=70, top=120, width=860,resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
  }
//  451152  
function langDesc()
{
	try{
		var len = document.getElementsByName(boName+'.Lang_desc')[0].options.length;
		
		for(i =0;i<len;i++)
		{
			if(document.getElementsByName(boName+'.Lang_desc')[0].options[i].value == lang_desc)
			{
				document.getElementsByName(boName+'.Lang_desc')[0].options[i].selected = true;
				break;
			}
		}
	}
	catch(e){alert(e.msg);}
}

//  451152
  
  
