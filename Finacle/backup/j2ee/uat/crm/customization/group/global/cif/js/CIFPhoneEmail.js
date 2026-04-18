/* CIF PhoneEmail Changes : Start */
var ph_emailWindow = null;
//	CIF PhoneEmail Changes : Start
var ad_PreferredFormat = new Array();
var ad_HoldMailReason = new Array();
var ad_BusinessCenter = new Array();
var ad_HoldMailInitiatedBy = new Array();
var ad_HoldMailFlag = new Array();
var ad_FreeTextAddress = new Array();
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
var ad_extension = new Array();
//	var ad_EmailPalm = new Array();
var phoneEmail_URL = new Array();
//	var email_URL = new Array();
var phoneEmail_Status = new Array();
var phone_detachedURLs = new Array();
var updatePhoneDet = false;
var updateEmailDet = false;
var tempBoName = '';

// Viswa's Changes Begin
var s_xmlHttp;
s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
// Viswa's Changes END


function populateLocationCode(entity_type){
try
{
	var phonetype ;
	var country = '';
	if(entity_type =='Prospect'){
	phonetype = document.getElementsByName('SuspectBO.PhoneEmail.PhoneEmailType')[0].value;
	}
	else if(entity_type =='NonCustomer'){
	phonetype = document.getElementsByName('NonCustomerBO.PhoneEmail.PhoneEmailType')[0].value;
	}
	else if(entity_type =='Contact'){
	phonetype = document.getElementsByName('ContactBO.PhoneEmail.PhoneEmailType')[0].value;
	}	
	else if(entity_type =='Customer'){
	phonetype = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType')[0].value;
	/*****************fix for ticket 337633 *****************/
	//Changes for call id 304518 STARTS
	//document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.cntrycode')[0].value="";
	//document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.areacode')[0].value="";
	//document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.localcode')[0].value="";
	//document.getElementsByName('AccountBO.PhoneEmail.WorkExtension')[0].value="";
	//Changes for call id 304518 ENDS
	/*****************fix for ticket 337633 *****************/
	}
	if(!(entity_type =='Contact')){
	if(phonetype != null && (phonetype == 'HOMEPH2' || phonetype == 'HOMEPH1')){
		country = top.window.opener.getValue('Home');
	}else if(phonetype != null && (phonetype == 'COMMPH2' || phonetype == 'COMMPH1' || phonetype == 'PAGER' || phonetype == 'REGPH1' || phonetype == 'REGPH2' || phonetype == 'TELEX' || phonetype == 'CELLPH' || phonetype == 'FAX1' || phonetype == 'FAX2')){
		country = top.window.opener.getValue('Mailing');
	}else if(phonetype != null && (phonetype == 'WORKPH2' || phonetype == 'WORKPH1')){
		country = top.window.opener.getValue('Worke');
	}
	s_xmlHttp.abort();
	var strURL = '../servlet/com.infy.cis.ui.common.DefaulCountryCode?LocationType=Country&Location='+country+'';
	s_xmlHttp.open("GET",strURL,false);
	s_xmlHttp.send();
	if(s_xmlHttp.status == 200)
	{
		var node= s_xmlHttp.responseXML.selectSingleNode("CRMLoaction/LocationCode");
		var locationCode = node.text;
	// being changes : Tracker id 137566
		if(entity_type =='Prospect'){
			if (document.getElementsByName('SuspectBO.PhoneEmail.PhoneNo.cntrycode')[0].value == null || document.getElementsByName('SuspectBO.PhoneEmail.PhoneNo.cntrycode')[0].value == '') {
		document.getElementsByName('SuspectBO.PhoneEmail.PhoneNo.cntrycode')[0].value = locationCode;
		}
		}
		else if(entity_type =='NonCustomer'){
			if (document.getElementsByName('NonCustomerBO.PhoneEmail.PhoneNo.cntrycode')[0].value == null || document.getElementsByName('NonCustomerBO.PhoneEmail.PhoneNo.cntrycode')[0].value == '') {
		document.getElementsByName('NonCustomerBO.PhoneEmail.PhoneNo.cntrycode')[0].value = locationCode;
		}
		}
		else if(entity_type =='Contact'){
			if (document.getElementsByName('ContactBO.PhoneEmail.PhoneNo.cntrycode')[0].value == null || document.getElementsByName('ContactBO.PhoneEmail.PhoneNo.cntrycode')[0].value == '') {
		document.getElementsByName('ContactBO.PhoneEmail.PhoneNo.cntrycode')[0].value = locationCode;
		}		
		}		
		else if(entity_type =='Customer'){
			if (document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.cntrycode')[0].value == null || document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.cntrycode')[0].value == '') {
		document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.cntrycode')[0].value = locationCode;
		}
		}
	// end changes : Tracker id 137566 		
		}
	
	}
	/*ticket id 206317 tracker id 125619 changes starts here*/
	//Changes for tracker ID 443088 start
	//if(phonetype=="HOMEPH2"||phonetype=="HOMEPH1"||phonetype=="CELLPH"||phonetype=="FAX1"||phonetype=="FAX2"){
	if (!(phonetype=="WORKPH2"||phonetype=="WORKPH1")){
	//Changes for tracker ID 443088 end
		 if(entity_type =='Customer'){
		             document.getElementsByName('AccountBO.PhoneEmail.WorkExtension')[0].value = "";
		              document.getElementsByName('AccountBO.PhoneEmail.WorkExtension')[0].disabled=true;
		}
		
		if(entity_type =='NonCustomer'){
		              document.getElementsByName('NonCustomerBO.PhoneEmail.WorkExtension')[0].value = "";
		              document.getElementsByName('NonCustomerBO.PhoneEmail.WorkExtension')[0].disabled=true;
		}
		
		if(entity_type =='Prospect'){
			     document.getElementsByName('SuspectBO.PhoneEmail.WorkExtension')[0].value = "";
			      document.getElementsByName('SuspectBO.PhoneEmail.WorkExtension')[0].disabled=true;
		}
		
		if(entity_type =='Contact'){
			     document.getElementsByName('ContactBO.PhoneEmail.WorkExtension')[0].value = "";
			     document.getElementsByName('ContactBO.PhoneEmail.WorkExtension')[0].disabled=true;
		}
			
	}
	
	else{
	         if(entity_type =='Customer'){
		/*changes made for ticket 337631 start*/
		 if(phonetype=="WORKPH2"||phonetype=="WORKPH1"){
			document.getElementsByName('AccountBO.PhoneEmail.WorkExtension')[0].disabled=false;
		 }else{
			document.getElementsByName('AccountBO.PhoneEmail.WorkExtension')[0].value = "";
			document.getElementsByName('AccountBO.PhoneEmail.WorkExtension')[0].disabled=true;
		}
		     // document.getElementsByName('AccountBO.PhoneEmail.WorkExtension')[0].disabled=false;
		     /*changes made for ticket 337631 end */	
	         }
	
	        if(entity_type =='NonCustomer'){ 
			     document.getElementsByName('NonCustomerBO.PhoneEmail.WorkExtension')[0].disabled=false;
		}
		
		if(entity_type =='Prospect'){
			     document.getElementsByName('SuspectBO.PhoneEmail.WorkExtension')[0].disabled=false;
		}
		
		if(entity_type =='Contact'){
			     document.getElementsByName('ContactBO.PhoneEmail.WorkExtension')[0].disabled=false;
		}
	
	
	}
	/*ticket id 206317 tracker id 125619  changes ends here*/

}

catch(e)
{
}
}


function callPhoneEmail()
{
	for (i=0; i < document.all.PhoneEmailRecordSet.rows.length; i++) {
		var row_bgcolor=document.all.PhoneEmailRecordSet.rows(i).className;
		 if ( row_bgcolor == 'rowHighLighted'){
			  if ( i % 2 == 0) {
				   document.all.PhoneEmailRecordSet.rows(i).className = 'color1';
			  }
			  else{
				   document.all.PhoneEmailRecordSet.rows(i).className = 'color2';
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

function editPhoneDetails()
{
	try{
		updatePhoneDet = true;
		if(boName == 'SuspectModBO' || boName == 'SuspectBO')
		{
			tempBoName = 'SuspectBO';
		}
		else if(boName == 'ContactModBO' || boName == 'ContactBO'){
			tempBoName = 'ContactBO';
		}
		else if(boName == 'AccountBO' || boName == 'AccountModBO'){
			tempBoName = 'AccountBO';
		}
		/*Changes for Tracker 173927  starts*/
		else if(boName == 'NonCustomerBO' || boName == 'NonCustomerModBO'){
			tempBoName = 'NonCustomerBO';
		}
		/*Changes for Tracker 173927 ends*/
		var tempTableRow = '';
		var phoneEmailID = '';
		if(event.srcElement.parentElement.id == null || event.srcElement.parentElement.id == '') {

			   tempTableRow = event.srcElement.parentElement.parentElement;
		} else {

				tempTableRow = event.srcElement.parentElement;
		}
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName == 'SuspectModBO' ){
			phoneEmailID = tempTableRow.getAttribute("SuspectModBO.PhoneEmail.PhoneEmailID");
			currPhoneTableRow = tempTableRow;

			phoneDetURL = tempTableRow.getAttribute("SuspectModBO.PhoneEmail.url_");
		}
		else if(boName == 'SuspectBO')
		{
			phoneEmailID = tempTableRow.getAttribute("SuspectBO.PhoneEmail.PhoneEmailID");
			currPhoneTableRow = tempTableRow;

			phoneDetURL = tempTableRow.getAttribute("SuspectBO.PhoneEmail.url_");
		}
		else if(boName == 'ContactModBO' ){
			phoneEmailID = tempTableRow.getAttribute("ContactModBO.PhoneEmail.PhoneEmailID");
			currPhoneTableRow = tempTableRow;

			phoneDetURL = tempTableRow.getAttribute("ContactModBO.PhoneEmail.url_");
		
		}
		else if( boName == 'ContactBO'){
			phoneEmailID = tempTableRow.getAttribute("ContactBO.PhoneEmail.PhoneEmailID");
			currPhoneTableRow = tempTableRow;

			phoneDetURL = tempTableRow.getAttribute("ContactBO.PhoneEmail.url_");
		}
		else if(boName == 'AccountBO' ){
			phoneEmailID = tempTableRow.getAttribute("AccountBO.PhoneEmail.PhoneEmailID");
			currPhoneTableRow = tempTableRow;

			phoneDetURL = tempTableRow.getAttribute("AccountBO.PhoneEmail.url_");
		
		}
		else if( boName == 'AccountModBO'){
			phoneEmailID = tempTableRow.getAttribute("AccountModBO.PhoneEmail.PhoneEmailID");
			currPhoneTableRow = tempTableRow;

			phoneDetURL = tempTableRow.getAttribute("AccountModBO.PhoneEmail.url_");
		}
		/*Changes for Tracker 173927 starts*/
		else if(boName == 'NonCustomerBO' ){
					phoneEmailID = tempTableRow.getAttribute("NonCustomerBO.PhoneEmail.PhoneEmailID");
					currPhoneTableRow = tempTableRow;
				
					phoneDetURL = tempTableRow.getAttribute("NonCustomerBO.PhoneEmail.url_");
						
						}
				else if( boName == 'NonCustomerModBO'){
					phoneEmailID = tempTableRow.getAttribute("NonCustomerModBO.PhoneEmail.PhoneEmailID");
					currPhoneTableRow = tempTableRow;
				
					phoneDetURL = tempTableRow.getAttribute("NonCustomerModBO.PhoneEmail.url_");
		}
		/*Changes for Tracker 173927 ends*/
		// Tracker ID: 135125: XMLEncoding Changes ENDS
		var i = 0;
		var x = phoneEmail_URL.length;
		for(i=0; i < x; i++){
			if(phoneEmail_URL[i] == phoneDetURL) {
				break;
			}
			else{

			}
		}
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName == 'SuspectModBO' ){
			for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
				var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("SuspectModBO.PhoneEmail.url_");
				if(docURL == phoneDetURL) {
					break;
				}
			}
		}
		else if(boName == 'SuspectBO')
		{
			for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
				var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("SuspectBO.PhoneEmail.url_");
				if(docURL == phoneDetURL) {
					break;
				}
			}
		}
		else if(boName == 'ContactModBO' ){
			for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
				var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("ContactModBO.PhoneEmail.url_");
				if(docURL == phoneDetURL) {
					break;
				}
			}

		}
		else if( boName == 'ContactBO'){
			for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
				var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("ContactBO.PhoneEmail.url_");
				if(docURL == phoneDetURL) {
					break;
				}
			}
		}
		else if(boName == 'AccountBO' ){
			for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
				var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("AccountBO.PhoneEmail.url_");
				if(docURL == phoneDetURL) {
					break;
				}
			}

		}
		else if( boName == 'AccountModBO'){
			for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
				var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("AccountModBO.PhoneEmail.url_");
				if(docURL == phoneDetURL) {
					break;
				}
			}
		}
		/*Changes for Tracker 173927 starts*/
		else if(boName == 'NonCustomerBO' ){
					for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
						var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("NonCustomerBO.PhoneEmail.url_");
						if(docURL == phoneDetURL) {
							break;
						}
					}
				
				}
				else if( boName == 'NonCustomerModBO'){
					for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
						var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("NonCustomerModBO.PhoneEmail.url_");
						if(docURL == phoneDetURL) {
							break;
						}
					}
		}
		/*Changes for Tracker 173927 ends*/
		// Tracker ID: 135125: XMLEncoding Changes ENDS
		eduPhoneRecordIndex = j;

		document.frm2.PhoneOrEmail.value = srmEscape(ad_PhoneOrEmail[i], '^', escChars);
		document.frm2.PhoneNo.value = srmEscape(ad_PhoneNo[i], '^', escChars);
		document.frm2.PhoneNoCountryCode.value=srmEscape(ad_PhoneNoCountryCode[i], '^', escChars);
		document.frm2.PhoneNoCityCode.value = srmEscape(ad_PhoneNoCityCode[i], '^', escChars);
		document.frm2.PhoneNoLocalCode.value = srmEscape(ad_PhoneNoLocalCode[i], '^', escChars);
		document.frm2.PhoneNo.value = srmEscape(ad_PhoneNo[i], '^', escChars);
		document.frm2.extension.value = srmEscape(ad_extension[i], '^', escChars);
		var phoneno="+"+document.frm2.PhoneNoCountryCode.value+"("+document.frm2.PhoneNoCityCode.value+")"+document.frm2.PhoneNoLocalCode.value;
		
		//alert("phoneno "+phoneno);
		
		document.frm2.PhoneNo.value = phoneno;
		
		//alert("document.frm2.PhoneNo.value "+document.frm2.PhoneNo.value);

		document.frm2.PhoneEmailType.value = srmEscape(ad_PhoneEmailType[i], '^', escChars);
		document.frm2.PhoneEmailID.value = srmEscape(ad_PhoneEmailID[i], '^', escChars);
		document.frm2.Email.value = srmEscape(ad_Email[i], '^', escChars);

		  //CIF Changes for RefCodes
			phoneRecordIndex = i;

			/* Tracker: 108382: Changes for centering popup */
			windowAlign();
			ph_emailWindow = window.open('../common/html/SSOblank.html', 'PhoneEmailDetails', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
			/* Tracker: 108382: End of Changes */
			document.frm2.target = 'PhoneEmailDetails'
			document.frm2.action = "../servlet/com.infy.cis.ui.cif.PhoneEmailForm_Det?IsEdit=Yes&boName="+boName;
			document.frm2.submit();
		}catch(e){
		DebugMessage(e.message);
		}
}

function editEmailDetails()
{
	try{
		updateEmailDet = true;
		if(boName == 'SuspectModBO' || boName == 'SuspectBO')
		{
			tempBoName = 'SuspectBO';
		}
		else if(boName == 'ContactModBO' || boName == 'ContactBO'){
			tempBoName = 'ContactBO';
		}
		else if(boName == 'AccountBO' || boName == 'AccountModBO'){
			tempBoName = 'AccountBO';
		}
		/*Changes for Tracker 173927 starts*/
		else if(boName == 'NonCustomerBO' || boName == 'NonCustomerModBO'){
					tempBoName = 'NonCustomerBO';
		}
		/*Changes for Tracker 173927 ends*/
		var tempTableRow = '';
		if(event.srcElement.parentElement.id == null || event.srcElement.parentElement.id == '') {

			   tempTableRow = event.srcElement.parentElement.parentElement;
		} else {

				tempTableRow = event.srcElement.parentElement;
		}

		currEmailTableRow = tempTableRow;
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName == 'SuspectModBO' ){
			emailDetURL = tempTableRow.getAttribute("SuspectModBO.PhoneEmail.url_");
		}
		else if(boName == 'SuspectBO')
		{
			emailDetURL = tempTableRow.getAttribute("SuspectBO.PhoneEmail.url_");
		}
		else if(boName == 'ContactModBO' ){
			emailDetURL = tempTableRow.getAttribute("ContactModBO.PhoneEmail.url_");
		}
		else if( boName == 'ContactBO'){
			emailDetURL = tempTableRow.getAttribute("ContactBO.PhoneEmail.url_");
		}
		else if(boName == 'AccountBO' ){
			emailDetURL = tempTableRow.getAttribute("AccountBO.PhoneEmail.url_");
		}
		else if( boName == 'AccountModBO'){
			emailDetURL = tempTableRow.getAttribute("AccountModBO.PhoneEmail.url_");
		}
		/*Changes for Tracker 173927 starts*/
		else if(boName == 'NonCustomerBO' ){
					emailDetURL = tempTableRow.getAttribute("NonCustomerBO.PhoneEmail.url_");
						}
		else if( boName == 'NonCustomerModBO'){
					emailDetURL = tempTableRow.getAttribute("NonCustomerModBO.PhoneEmail.url_");
		}
		/*Changes for Tracker 173927 ends*/
		// Tracker ID: 135125: XMLEncoding Changes ENDS
		var i = 0;
		var x = phoneEmail_URL.length;
		for(i=0; i < x; i++){
		if(phoneEmail_URL[i] == emailDetURL) {
				break;
			}
			else{

			}
		}
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName == 'SuspectModBO' ){
			for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
				var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("SuspectModBO.PhoneEmail.url_");
				if(docURL == emailDetURL) {
					break;
				}
			}
		}
		else if(boName == 'SuspectBO')
		{
			for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
				var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("SuspectBO.PhoneEmail.url_");
				if(docURL == emailDetURL) {
					break;
				}
			}
		}
		else if(boName == 'ContactModBO' ){
			for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
				var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("ContactModBO.PhoneEmail.url_");
				if(docURL == emailDetURL) {
					break;
				}
			}
		}
		else if( boName == 'ContactBO'){
			for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
				var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("ContactBO.PhoneEmail.url_");
				if(docURL == emailDetURL) {
					break;
				}
			}
		}
		else if(boName == 'AccountBO' ){
			for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
				var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("AccountBO.PhoneEmail.url_");
				if(docURL == emailDetURL) {
					break;
				}
			}
		}
		else if( boName == 'AccountModBO'){
			for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
				var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("AccountModBO.PhoneEmail.url_");
				if(docURL == emailDetURL) {
					break;
				}
			}
		}
		/*Changes for Tracker 173927 starts*/
		else if(boName == 'NonCustomerBO' ){
					for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
						var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("NonCustomerBO.PhoneEmail.url_");
						if(docURL == emailDetURL) {
							break;
						}
					}
						
				}
				else if( boName == 'NonCustomerModBO'){
					for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
						var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("NonCustomerModBO.PhoneEmail.url_");
						if(docURL == emailDetURL) {
							break;
						}
					}
		}
		/*Changes for Tracker 173927 ends*/
		// Tracker ID: 135125: XMLEncoding Changes ENDS
		eduEmailRecordIndex = j;

		document.frm2.PhoneOrEmail.value = srmEscape(ad_PhoneOrEmail[i], '^', escChars);
		SetCookie(tempBoName+".PhoneEmail.PhoneOrEmail",ad_PhoneOrEmail[i]);
		document.frm2.PhoneNoCountryCode.value=srmEscape(ad_PhoneNoCountryCode[i], '^', escChars);
		document.frm2.PhoneNoCityCode.value = srmEscape(ad_PhoneNoCityCode[i], '^', escChars);
		document.frm2.PhoneNoLocalCode.value = srmEscape(ad_PhoneNoLocalCode[i], '^', escChars);
		document.frm2.PhoneNo.value = srmEscape(ad_PhoneNo[i], '^', escChars);

		document.frm2.PhoneEmailType.value = srmEscape(ad_PhoneEmailType[i], '^', escChars);
		SetCookie(tempBoName+".PhoneEmail.PhoneEmailType1",ad_PhoneEmailType[i]);
		document.frm2.PhoneEmailID.value = srmEscape(ad_PhoneEmailID[i], '^', escChars);
		document.frm2.Email.value = srmEscape(ad_Email[i], '^', escChars);
		document.frm2.extension.value = srmEscape(ad_extension[i], '^', escChars);
		  //CIF Changes for RefCodes
			emailRecordIndex = i;

			/* Tracker: 108382: Changes for centering popup */
			windowAlign();
			ph_emailWindow = window.open('../common/html/SSOblank.html', 'PhoneEmailDetails', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=no');
			/* Tracker: 108382: End of Changes */
			document.frm2.target = 'PhoneEmailDetails'
			document.frm2.action = "../servlet/com.infy.cis.ui.cif.PhoneEmailForm_Det?IsEdit=Yes&boName="+boName;
			document.frm2.submit();
		}catch(e){
		DebugMessage(e.message);
		}
}

function addPhoneEmail()
{
	try
	{
	var getMCRequired=document.frm2.getMCRequired.value;
	/* Tracker:108379: Changes for centering popup */
	
	// hardcoded values
	
	var wh = 260;
	
	var ww = 900;
	
	// end hardcoded values
	
	 
	
	var left_x = (screen.width - ww) / 2 ;
	
	var left_y = (screen.height - wh) / 2 ;
	
	 
	
	//left_x = 0 ;
	


	ph_emailWindow = window.open("../servlet/com.infy.cis.ui.cif.PhoneEmailForm_Det?boName="+boName+"&getMCRequired="+getMCRequired, 'PhoneEmailDetails','height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=no');
	
	/* Tracker:108379: Changes End */
	ph_emailWindow.name = 'PhoneEmailDetails';

	updatePhoneDet = false;
	updateEmailDet = false;
	}
	catch(e)
	{
	}

}

function removePhoneEmail()
{
	
	try
	{

		 var phoneURL = '';
		 var emailURL = '';
		 var phoneEmailID = '';
		if(CheckForSelectedRow(document.getElementsByName('PhoneEmailRecordSet'))=="false"){
			
			showUserMessage("MSG158",'MSGJ50374');
			return;
		}
		
		for (k=0; k < document.all.PhoneEmailRecordSet.rows.length ; k++){
			
			var row_bgcolor = document.all.PhoneEmailRecordSet.rows(k).className;
			phoneOrEmail = "";
			if ( row_bgcolor == 'rowHighLighted')
			{
				
				// Tracker ID: 135125: XMLEncoding Changes STARTS
				if(boName == 'SuspectModBO' ){
					phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectModBO.PhoneEmail.PhoneOrEmail");
				}
				else if(boName == 'SuspectBO')
				{
					phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectBO.PhoneEmail.PhoneOrEmail");
				}
				else if(boName == 'ContactModBO' ){
					phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactModBO.PhoneEmail.PhoneOrEmail");
				}
				else if( boName == 'ContactBO'){
					phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactBO.PhoneEmail.PhoneOrEmail");
				}
				else if(boName == 'AccountBO' ){
					phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountBO.PhoneEmail.PhoneOrEmail");
				}
				else if( boName == 'AccountModBO'){
					phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountModBO.PhoneEmail.PhoneOrEmail");
				}
				//Begin Changes for ticket id 253121
				else if( boName == 'NonCustomerModBO'){
					phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerModBO.PhoneEmail.PhoneOrEmail");
					
				}
				else if( boName == 'NonCustomerBO'){
									phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerBO.PhoneEmail.PhoneOrEmail");
									
				}
				// End Changes for ticket id 253121
			}
			if(phoneOrEmail == 'PHONE'){
				// Tracker ID: 135125: XMLEncoding Changes STARTS
				if(boName == 'SuspectModBO' ){
					phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectModBO.PhoneEmail.url_");
				}
				else if(boName == 'SuspectBO')
				{
					phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectBO.PhoneEmail.url_");
				}
				else if(boName == 'ContactModBO' ){
					phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactModBO.PhoneEmail.url_");
				}
				else if( boName == 'ContactBO'){
					phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactBO.PhoneEmail.url_");
				}
				else if(boName == 'AccountBO' ){
					phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountBO.PhoneEmail.url_");
				}
				else if( boName == 'AccountModBO'){
					phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountModBO.PhoneEmail.url_");
				}//changes for call id 450870 starts
				else if( boName == 'NonCustomerBO'){
					phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerBO.PhoneEmail.url_");
				}
				else if( boName == 'NonCustomerModBO'){
					phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerModBO.PhoneEmail.url_");
				}
				else if( boName == 'NonCustomerBO'){
					phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerBO.PhoneEmail.url_");
				}
				// Tracker ID: 135125: XMLEncoding Changes ENDS
				if(showUserChoiceMessage('MSG045', 'MSG_LOROW')) {
					noOfAttachURLs = phoneEmail_URL.length;
					var deleteAlreadyExistingPhoneDet = true;
					for(r=0; r< noOfAttachURLs; r++) {
						if(phoneEmail_URL[r] == phoneURL){
					//Changes for Ticket id 425381  and Tracker id 257595,258521 Recon for call id 220451 starts
							if(phoneEmail_Status[r] != "Add" && phoneEmail_Status[r] != "Edit") {
					//Changes for Ticket id 425381 and Tracker id 257595,258521 Recon for call id 220451 ends
								deleteAlreadyExistingPhoneDet = false;
							}
							phoneEmail_URL[r] = null;
							//changes by Suman for making mailing address mandatory in edit
							ad_PhoneEmailType[r] = null;
							phoneEmail_Status[r] = "Remove";
							phoneEmailID = ad_PhoneEmailID[r];
							break;
						}
					}
					document.all.PhoneEmailRecordSet.deleteRow(k);
					if( (phoneURL == null) || (phoneURL == 'undefined')) {
						phoneURL= "";
					}
					if(deleteAlreadyExistingPhoneDet) {
						phone_detachedURLs[phone_detachedURLs.length] = phoneEmailID;
					}
				}
			}//end of OuterMost if
			else if(phoneOrEmail == 'EMAIL')
			{
				// Tracker ID: 135125: XMLEncoding Changes STARTS
				if(boName == 'SuspectModBO' ){
					emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectModBO.PhoneEmail.url_");
				}
				else if(boName == 'SuspectBO')
				{
					emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectBO.PhoneEmail.url_");
				}
				else if(boName == 'ContactModBO' ){
					emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactModBO.PhoneEmail.url_");

				}
				else if( boName == 'ContactBO'){
					emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactBO.PhoneEmail.url_");
				}
				else if(boName == 'AccountBO' ){
					emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountBO.PhoneEmail.url_");
				}
				else if( boName == 'AccountModBO'){
					emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountModBO.PhoneEmail.url_");
				}//changes for call id 450870 starts
				else if( boName == 'NonCustomerBO'){
					emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerBO.PhoneEmail.url_");
				}
				else if( boName == 'NonCustomerModBO'){
					emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerModBO.PhoneEmail.url_");
				}
				else if( boName == 'NonCustomerBO'){
					emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerBO.PhoneEmail.url_");
				}
				// Tracker ID: 135125: XMLEncoding Changes ENDS
				if(showUserChoiceMessage('MSG045', 'MSG_LOROW')) {
					noOfAttachURLs = phoneEmail_URL.length;
					var deleteAlreadyExistingPhoneDet = true;
					for(r=0; r< noOfAttachURLs; r++) {
						if(phoneEmail_URL[r] == emailURL){
						        //Change for Call Id:369932
							if(phoneEmail_Status[r] != "Add" && phoneEmail_Status[r] != "Edit") {
								deleteAlreadyExistingPhoneDet = false;
							}
							phoneEmail_URL[r] = null;
							//changes by Suman for making mailing address mandatory in edit
							ad_PhoneEmailType[r]=null;
							phoneEmail_Status[r] = "Remove";
							phoneEmailID = ad_PhoneEmailID[r];
							break;
						}
					}
					document.all.PhoneEmailRecordSet.deleteRow(k);
					if( (emailURL == null) || (emailURL == 'undefined')) {
						emailURL= "";
					}
					if(deleteAlreadyExistingPhoneDet) {
						phone_detachedURLs[phone_detachedURLs.length] = phoneEmailID;
					}
				}
			}
		}
	}
	catch(e)
	{
	}
}

function copyPhoneEmail()
{
	if(CheckForSelectedRow(document.getElementsByName('PhoneEmailRecordSet'))=="false"){
		showUserMessage("MSGCOPY", 'MSGJ50374');
		return;
	}
	if(boName == 'SuspectModBO' || boName == 'SuspectBO')
	{
		tempBoName = 'SuspectBO';
	}
	else if(boName == 'ContactModBO' || boName == 'ContactBO'){
		tempBoName = 'ContactBO';
	}
	else if(boName == 'AccountBO' || boName == 'AccountModBO'){
		tempBoName = 'AccountBO';
	}
	else if(boName == 'NonCustomerBO' || boName == 'NonCustomerModBO'){
		tempBoName = 'NonCustomerBO';
	}
	for (k=0; k < document.all.PhoneEmailRecordSet.rows.length ; k++){
		var row_bgcolor = document.all.PhoneEmailRecordSet.rows(k).className;
		phoneOrEmail = "";
		if ( row_bgcolor == 'rowHighLighted')
		{
			// Tracker ID: 135125: XMLEncoding Changes STARTS
			if(boName == 'SuspectModBO' ){
				phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectModBO.PhoneEmail.PhoneOrEmail");
			}
			else if(boName == 'SuspectBO')
			{
				phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectBO.PhoneEmail.PhoneOrEmail");
			}
			else if(boName == 'ContactModBO' ){
				phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactModBO.PhoneEmail.PhoneOrEmail");

			}
			else if( boName == 'ContactBO'){
				phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactBO.PhoneEmail.PhoneOrEmail");
			}
			else if(boName == 'AccountBO' ){
				phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountBO.PhoneEmail.PhoneOrEmail");

			}
			else if( boName == 'AccountModBO'){
				phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountModBO.PhoneEmail.PhoneOrEmail");
			}
			/*Begin Changes for ticket id 253121*/
			else if( boName == 'NonCustomerModBO'){
				phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerModBO.PhoneEmail.PhoneOrEmail");
				
				
			}
			else if( boName == 'NonCustomerBO'){
							phoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerBO.PhoneEmail.PhoneOrEmail");
							
							
			}
			/*End Changes for ticket id 253121*/
			// Tracker ID: 135125: XMLEncoding Changes ENDS
		}
		if(phoneOrEmail == 'PHONE'){
			var phoneURL = '';
			var phoneEmailID = '';
			updatePhoneDet = false;
			// Tracker ID: 135125: XMLEncoding Changes STARTS
			if(boName == 'SuspectModBO' ){
				phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectModBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectModBO.PhoneEmail.PhoneOrEmail");
			}
			else if(boName == 'SuspectBO')
			{
				phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectBO.PhoneEmail.PhoneOrEmail");
			}
			else if(boName == 'ContactModBO' ){
				phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactModBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactModBO.PhoneEmail.PhoneOrEmail");

			}
			else if( boName == 'ContactBO'){
				phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactBO.PhoneEmail.PhoneOrEmail");
			}
			else if(boName == 'AccountBO' ){
				phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountBO.PhoneEmail.PhoneOrEmail");

			}
			else if( boName == 'AccountModBO'){
				phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountModBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountModBO.PhoneEmail.PhoneOrEmail");
			}
			/*Begin Changes for ticket id 253121*/
			else if( boName == 'NonCustomerModBO'){
				phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerModBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerModBO.PhoneEmail.PhoneOrEmail");
			}
			else if( boName == 'NonCustomerBO'){
							phoneURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerBO.PhoneEmail.url_");
							tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerBO.PhoneEmail.PhoneOrEmail");
			}
			/*End Changes for ticket id 253121*/
			// Tracker ID: 135125: XMLEncoding Changes ENDS
			var i = 0;
			var x = phoneEmail_URL.length;

			for(i=0; i < x; i++){
			   if(phoneEmail_URL[i] == phoneURL && tempPhoneOrEmail == 'PHONE') {
					//i--;
					break;
				}
				else{

				}
			}
			// Tracker ID: 135125: XMLEncoding Changes STARTS
			if(boName == 'SuspectModBO' ){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("SuspectModBO.PhoneEmail.url_");
					if(docURL == phoneURL) {
						break;
					}
				}
			}
			else if(boName == 'SuspectBO')
			{
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("SuspectBO.PhoneEmail.url_");
					if(docURL == phoneURL) {
						break;
					}
				}
			}
			else if(boName == 'ContactModBO' ){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("ContactModBO.PhoneEmail.url_");
					if(docURL == phoneURL) {
						break;
					}
				}

			}
			else if( boName == 'ContactBO'){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("ContactBO.PhoneEmail.url_");
					if(docURL == phoneURL) {
						break;
					}
				}
			}
			else if(boName == 'AccountBO' ){
					for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
						var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("AccountBO.PhoneEmail.url_");
						if(docURL == phoneURL) {
							break;
						}
					}

			}
			else if( boName == 'AccountModBO'){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("AccountModBO.PhoneEmail.url_");
					if(docURL == phoneURL) {
						break;
					}
				}
			}
			/*Begin Changes for ticket id 253121*/
			else if( boName == 'NonCustomerModBO'){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("NonCustomerModBO.PhoneEmail.url_");
					if(docURL == phoneURL) {
						break;
					}
				}
			}
			else if( boName == 'NonCustomerBO'){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("NonCustomerBO.PhoneEmail.url_");
					if(docURL == phoneURL) {
						break;
					}
				}
			}
			
			/*End Changes for ticket id 253121*/
			// Tracker ID: 135125: XMLEncoding Changes ENDS
				eduPhoneRecordIndex = j;


		SetCookie(tempBoName+'.PhoneEmail.PhoneOrEmail',ad_PhoneOrEmail[i]);
		document.frm2.PhoneOrEmail.value=srmEscape(ad_PhoneOrEmail[i], '^', escChars);
		document.frm2.PhoneNoCountryCode.value=srmEscape(ad_PhoneNoCountryCode[i], '^', escChars);
		document.frm2.PhoneNoCityCode.value=srmEscape(ad_PhoneNoCityCode[i], '^', escChars);
		document.frm2.PhoneNoLocalCode.value=srmEscape(ad_PhoneNoLocalCode[i], '^', escChars);
		document.frm2.PhoneNo.value=srmEscape(ad_PhoneNo[i], '^', escChars);
		document.frm2.PhoneEmailType.value = srmEscape(ad_PhoneEmailType[i], '^', escChars);
		document.frm2.PhoneEmailID.value = srmEscape(ad_PhoneEmailID[i], '^', escChars);
		document.frm2.Email.value = srmEscape(ad_Email[i], '^', escChars);
		document.frm2.extension.value = srmEscape(ad_extension[i], '^', escChars);

		phoneRecordIndex = i;

		/* Tracker: 108382: Changes for centering popup */
		windowAlign();
		ph_emailWindow = window.open('../common/html/SSOblank.html', 'PhoneEmailDetails', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
		/* Tracker: 108382: End of Changes */
		document.frm2.target = 'PhoneEmailDetails'
		/* Changes for Tracker 174169 starts */
		document.frm2.action = "../servlet/com.infy.cis.ui.cif.PhoneEmailForm_Det?IsEdit=Yes&IsCopy=Y&boName="+boName;
		/* Changes for Tracker 174169 ends */
		document.frm2.submit();

		}
		else if(phoneOrEmail == 'EMAIL'){
			var emailURL = '';
			var phoneEmailID = '';
			updateEmailDet = false;
			// Tracker ID: 135125: XMLEncoding Changes STARTS
			if(boName == 'SuspectModBO' ){
				emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectModBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectModBO.PhoneEmail.PhoneOrEmail");
			}
			else if(boName == 'SuspectBO')
			{
				emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectBO.PhoneEmail.PhoneOrEmail");
			}
			else if(boName == 'ContactModBO' ){
				emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactModBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactModBO.PhoneEmail.PhoneOrEmail");

			}
			else if( boName == 'ContactBO'){
				emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactBO.PhoneEmail.PhoneOrEmail");
			}
			else if(boName == 'AccountBO' ){
				emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountBO.PhoneEmail.PhoneOrEmail");

			}
			else if( boName == 'AccountModBO'){
				emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountModBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountModBO.PhoneEmail.PhoneOrEmail");
			}
			else if( boName == 'NonCustomerModBO'){
				emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerModBO.PhoneEmail.url_");
				tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerModBO.PhoneEmail.PhoneOrEmail");
			}
			else if( boName == 'NonCustomerBO'){
							emailURL = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerBO.PhoneEmail.url_");
							tempPhoneOrEmail = document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerBO.PhoneEmail.PhoneOrEmail");
			}
			// Tracker ID: 135125: XMLEncoding Changes ENDS
			var i = 0;
			var x = phoneEmail_URL.length;

			for(i=0; i < x; i++){
			   if(phoneEmail_URL[i] == emailURL && tempPhoneOrEmail == 'EMAIL') {
					break;
				}
				else{

				}
			}
			// Tracker ID: 135125: XMLEncoding Changes STARTS
			if(boName == 'SuspectModBO' ){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("SuspectModBO.PhoneEmail.url_");
					if(docURL == emailURL) {
						break;
					}
				}
			}
			else if(boName == 'SuspectBO')
			{
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("SuspectBO.PhoneEmail.url_");
					if(docURL == emailURL) {
						break;
					}
				}
			}
			else if(boName == 'ContactModBO' ){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("ContactModBO.PhoneEmail.url_");
					if(docURL == emailURL) {
						break;
					}
				}

			}
			else if( boName == 'ContactBO'){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("ContactBO.PhoneEmail.url_");
					if(docURL == emailURL) {
						break;
					}
				}
			}
			else if(boName == 'AccountBO' ){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("AccountBO.PhoneEmail.url_");
					if(docURL == emailURL) {
						break;
					}
				}

			}
			else if( boName == 'AccountModBO'){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("AccountModBO.PhoneEmail.url_");
					if(docURL == emailURL) {
						break;
					}
				}
			}
			else if( boName == 'NonCustomerModBO'){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("NonCustomerModBO.PhoneEmail.url_");
					if(docURL == emailURL) {
						break;
					}
				}
			}
			else if( boName == 'NonCustomerBO'){
				for (j=2; j < document.all.PhoneEmailRecordSet.rows.length; j++){
					var docURL = document.all.PhoneEmailRecordSet.rows(j).getAttribute("NonCustomerBO.PhoneEmail.url_");
					if(docURL == emailURL) {
						break;
					}
				}
			}
			// Tracker ID: 135125: XMLEncoding Changes ENDS
			eduEmailRecordIndex = j;


			SetCookie(tempBoName+'.PhoneEmail.PhoneOrEmail',ad_PhoneOrEmail[i]);
			document.frm2.PhoneOrEmail.value=srmEscape(ad_PhoneOrEmail[i], '^', escChars);
			document.frm2.PhoneEmailType.value = srmEscape(ad_PhoneEmailType[i], '^', escChars);
			document.frm2.PhoneEmailID.value = srmEscape(ad_PhoneEmailID[i], '^', escChars);
			document.frm2.Email.value = srmEscape(ad_Email[i], '^', escChars);
			document.frm2.PhoneNoCountryCode.value=srmEscape(ad_PhoneNoCountryCode[i], '^', escChars);
			document.frm2.PhoneNoCityCode.value=srmEscape(ad_PhoneNoCityCode[i], '^', escChars);
			document.frm2.PhoneNoLocalCode.value=srmEscape(ad_PhoneNoLocalCode[i], '^', escChars);
			document.frm2.PhoneNo.value=srmEscape(ad_PhoneNo[i], '^', escChars);
			document.frm2.extension.value = srmEscape(ad_extension[i], '^', escChars);


			emailRecordIndex = i;

			/* Tracker: 108382: Changes for centering popup */
			windowAlign();
			ph_emailWindow = window.open('../common/html/SSOblank.html', 'PhoneEmailDetails', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
			/* Tracker: 108382: End of Changes */
			document.frm2.target = 'PhoneEmailDetails'
			/* Changes for Tracker 174169 starts */
			document.frm2.action = "../servlet/com.infy.cis.ui.cif.PhoneEmailForm_Det?IsEdit=Yes&IsCopy=Y&boName="+boName;
			/* Changes for Tracker 174169 ends */
			document.frm2.submit();
		}
	}
}

function addPhoneDetails(PhoneEmailDetails){
/* Recon From 10.3 Lead Management Changes Start */
var LeadID = getCookie('LeadID');
/* Recon From 10.3 Lead Management Changes Ends */
try{

		if(boName == 'SuspectModBO' || boName == 'SuspectBO')
		{
			tempBoName = 'SuspectBO';
		}
		else if(boName == 'ContactModBO' || boName == 'ContactBO'){
			tempBoName = 'ContactBO';
		}
		else if(boName == 'AccountBO' || boName == 'AccountModBO'){
			tempBoName = 'AccountBO';
		}
		else if(boName == 'NonCustomerBO' || boName == 'NonCustomerModBO'){
			tempBoName = 'NonCustomerBO';
		}
		phoneOrEmail  = PhoneEmailDetails[0];
		phoneNo = PhoneEmailDetails[1];
		phoneNoCountryCode = PhoneEmailDetails[2];
		phoneNoCityCode = PhoneEmailDetails[3];
		phoneNoLocalCode = PhoneEmailDetails[4];
		phoneEmailType = PhoneEmailDetails[5];
		phoneEmailID = PhoneEmailDetails[6];
		extension = PhoneEmailDetails[7];
		phoneURL = phoneNo + phoneEmailType;

		email = "";
	        var phone_alreadyAdded = false;
		
		/* Recon From 10.3 Lead Management Changes Start */
		if (LeadID!="" && LeadID!= null){
			//changes for call id 417057 and recon of call id 411623 starts
			//document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options.selectedIndex=2;
//Ticket 463005 changes
			if(phoneOrEmail=='PHONE' && phoneEmailType=='WORKPH1'){
			var phoneValLength=document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options.length;
			for(var z=0;z<phoneValLength;z++)
			{
				if(document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options[z].value=='WORKPH1')
				{
					document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options.selectedIndex=z;
					//changes for call id 417057 and recon of call id 411623 ends
					var add_phoneEmailType_ML =document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options[z].text;
					break;
				}
			}
			}
			//changes for call id 417057 and recon of call id 411623 starts
			else if(phoneOrEmail=='PHONE' && phoneEmailType=='CELLPH'){
			var phoneValLength=document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options.length;
			for(var z=0;z<phoneValLength;z++)
			{
				if(document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options[z].value=='CELLPH')
				{
					var add_phoneEmailType_ML =document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options[z].text;
					break;
				}
			}
			}
			//changes for call id 417057 and recon of call id 411623 ends
			else{
			var add_phoneEmailType_ML = ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options[ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].selectedIndex].text;
			var add_phoneOrEmail_ML = ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneOrEmail")[0].options[ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneOrEmail")[0].selectedIndex].text;
			}
			
			var add_phoneOrEmail_ML =phoneOrEmail;
			/*if (phoneOrEmail=='PHONE' && phoneEmailType !='CELLPH'){
			var add_phoneEmailType_ML =document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options[2].text;
			phoneEmailType=document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options[2].value;
			}else {
			var add_phoneEmailType_ML =document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options[1].text;
			phoneEmailType=document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options[1].value;
			}
			var add_phoneOrEmail_ML =phoneOrEmail;*/

		}else{
			var add_phoneEmailType_ML = ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options[ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].selectedIndex].text;
			var add_phoneOrEmail_ML = ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneOrEmail")[0].options[ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneOrEmail")[0].selectedIndex].text;
		}
		/* Recon From 10.3 Lead Management Changes End */
		
		if(!phone_alreadyAdded)
		{
			var noOfexistingURLs = phoneEmail_URL.length;
			for(var x = 0; x < noOfexistingURLs ; x++)
			{
				//changed if Condition for Ticket:373113
			if(phoneEmailType == ad_PhoneEmailType[x] && ad_PhoneOrEmail[x]!='EMAIL')
				{
					phone_alreadyAdded = true;
					if(updatePhoneDet)
					{
						if(x != phoneRecordIndex)
						{
							updatePhoneDet = false;
						}
					}
					break;
				}
			}
			if(updatePhoneDet)
			{
		   		phone_alreadyAdded = true;

				ad_PhoneOrEmail[phoneRecordIndex] = phoneOrEmail;
				ad_PhoneNo[phoneRecordIndex] = phoneNo;
				ad_PhoneNoCountryCode[phoneRecordIndex] = phoneNoCountryCode;
				ad_PhoneNoCityCode[phoneRecordIndex] = phoneNoCityCode;
				ad_PhoneNoLocalCode[phoneRecordIndex] = phoneNoLocalCode;
				ad_PhoneEmailType[phoneRecordIndex] = phoneEmailType;
				ad_PhoneEmailID[phoneRecordIndex] = phoneEmailID;
				ad_extension[phoneRecordIndex] = extension;
				ad_Email[phoneRecordIndex] = email;
				phoneEmail_URL[phoneRecordIndex] = phoneURL;
				phoneEmail_Status[phoneRecordIndex] = "Edit";
			}
		}
		if(!phone_alreadyAdded)
		{
				adcount = phoneEmail_URL.length;

				ad_PhoneOrEmail[ad_PhoneOrEmail.length] = phoneOrEmail;
				ad_PhoneNo[ad_PhoneNo.length] = phoneNo;
				ad_PhoneNoCountryCode[ad_PhoneNoCountryCode.length] = phoneNoCountryCode;
				ad_PhoneNoCityCode[ad_PhoneNoCityCode.length] = phoneNoCityCode;
				ad_PhoneNoLocalCode[ad_PhoneNoLocalCode.length] = phoneNoLocalCode;
				ad_PhoneEmailType[ad_PhoneEmailType.length] = phoneEmailType;
				ad_PhoneEmailID[ad_PhoneEmailID.length] = null;
				ad_extension[ad_extension.length] = extension;
				ad_Email[ad_Email.length] = email;
				phoneEmail_Status[phoneEmail_Status.length] = "New";
				phoneEmail_URL[phoneEmail_URL.length] = phoneURL;
		}

		
		/* Recon From 10.3 Lead Management Changes Start */
		//var add_phoneEmailType_ML = ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].options[ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType")[0].selectedIndex].text;
		//var add_phoneOrEmail_ML = ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneOrEmail")[0].options[ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneOrEmail")[0].selectedIndex].text;
                /* Recon From 10.3 Lead Management Changes End */
                
		if (!updatePhoneDet)
		{
			if(phone_alreadyAdded)
			{
			        showUserMessage("MSGJ50373",null);
				return;
			}
			oNewNode = document.createElement("TR");
			if(TBODY_PhoneEmailRecordSet.childNodes.length % 2 == 0)
			{
				oNewNode.setAttribute("className", "color1");
			}
			else
			{
				oNewNode.setAttribute("className", "color2");
			}
			TBODY_PhoneEmailRecordSet.appendChild(oNewNode);
			// Tracker ID: 135125: XMLEncoding Changes STARTS
			if(boName == 'SuspectModBO' ){
				oNewNode.setAttribute("SuspectModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				oNewNode.setAttribute("SuspectModBO.PhoneEmail.PhoneNo", phoneNo);
				oNewNode.setAttribute("SuspectModBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				oNewNode.setAttribute("SuspectModBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				oNewNode.setAttribute("SuspectModBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);

				oNewNode.setAttribute("SuspectModBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				oNewNode.setAttribute("SuspectModBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				oNewNode.setAttribute("SuspectModBO.PhoneEmail.Email", email);
			}
			else if(boName == 'SuspectBO')
			{
				oNewNode.setAttribute("SuspectBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				oNewNode.setAttribute("SuspectBO.PhoneEmail.PhoneNo", phoneNo);
				oNewNode.setAttribute("SuspectBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				oNewNode.setAttribute("SuspectBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				oNewNode.setAttribute("SuspectBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);

				oNewNode.setAttribute("SuspectBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				oNewNode.setAttribute("SuspectBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				oNewNode.setAttribute("SuspectBO.PhoneEmail.Email", email);
			}
			else if(boName == 'ContactModBO' ){
				oNewNode.setAttribute("ContactModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				oNewNode.setAttribute("ContactModBO.PhoneEmail.PhoneNo", phoneNo);
				oNewNode.setAttribute("ContactModBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				oNewNode.setAttribute("ContactModBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				oNewNode.setAttribute("ContactModBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);

				oNewNode.setAttribute("ContactModBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				oNewNode.setAttribute("ContactModBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				oNewNode.setAttribute("ContactModBO.PhoneEmail.Email", email);

			}
			else if( boName == 'ContactBO'){
				oNewNode.setAttribute("ContactBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				oNewNode.setAttribute("ContactBO.PhoneEmail.PhoneNo", phoneNo);
				oNewNode.setAttribute("ContactBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				oNewNode.setAttribute("ContactBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				oNewNode.setAttribute("ContactBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);

				oNewNode.setAttribute("ContactBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				oNewNode.setAttribute("ContactBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				oNewNode.setAttribute("ContactBO.PhoneEmail.Email", email);
			}
			else if(boName == 'AccountBO' ){
				oNewNode.setAttribute("AccountBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				oNewNode.setAttribute("AccountBO.PhoneEmail.PhoneNo", phoneNo);
				oNewNode.setAttribute("AccountBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				oNewNode.setAttribute("AccountBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				oNewNode.setAttribute("AccountBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);

				oNewNode.setAttribute("AccountBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				oNewNode.setAttribute("AccountBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				oNewNode.setAttribute("AccountBO.PhoneEmail.Email", email);
			}
			else if( boName == 'AccountModBO'){
				oNewNode.setAttribute("AccountModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				oNewNode.setAttribute("AccountModBO.PhoneEmail.PhoneNo", phoneNo);
				oNewNode.setAttribute("AccountModBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				oNewNode.setAttribute("AccountModBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				oNewNode.setAttribute("AccountModBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);

				oNewNode.setAttribute("AccountModBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				oNewNode.setAttribute("AccountModBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				oNewNode.setAttribute("AccountModBO.PhoneEmail.Email", email);
			}
			/*Begin Changes for ticket id 253121*/
			else if( boName == 'NonCustomerModBO'){
				oNewNode.setAttribute("NonCustomerModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				oNewNode.setAttribute("NonCustomerModBO.PhoneEmail.PhoneNo", phoneNo);
				oNewNode.setAttribute("NonCustomerModBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				oNewNode.setAttribute("NonCustomerModBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				oNewNode.setAttribute("NonCustomerModBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);

				oNewNode.setAttribute("NonCustomerModBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				oNewNode.setAttribute("NonCustomerModBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				oNewNode.setAttribute("NonCustomerModBO.PhoneEmail.Email", email);
			}
			else if( boName == 'NonCustomerBO'){
							oNewNode.setAttribute("NonCustomerBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
							oNewNode.setAttribute("NonCustomerBO.PhoneEmail.PhoneNo", phoneNo);
							oNewNode.setAttribute("NonCustomerBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
							oNewNode.setAttribute("NonCustomerBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
							oNewNode.setAttribute("NonCustomerBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
			
							oNewNode.setAttribute("NonCustomerBO.PhoneEmail.PhoneEmailType", phoneEmailType);
							oNewNode.setAttribute("NonCustomerBO.PhoneEmail.PhoneEmailID", phoneEmailID);
							oNewNode.setAttribute("NonCustomerBO.PhoneEmail.Email", email);
			}
			/*End Changes for ticket id 253121*/
			// Tracker ID: 135125: XMLEncoding Changes ENDS
			var tdNode = document.createElement("TD");
			oNewNode.appendChild(tdNode);
			tdNode.innerHTML =  "<font class='fntColData'>" + add_phoneOrEmail_ML+ "</font>";
				var tdNode2 = document.createElement("TD");
			oNewNode.appendChild(tdNode2);
			tdNode2.innerHTML =  "<font class='fntColData'>" + add_phoneEmailType_ML+ "</font>";
			var tdNode3 = document.createElement("TD");
			oNewNode.appendChild(tdNode3);
			tdNode3.innerHTML = "<font class='fntColData'>" + phoneNoCountryCode + "</font>";
			var tdNode4 = document.createElement("TD");
			oNewNode.appendChild(tdNode4);
			tdNode4.innerHTML = "<font class='fntColData'>" + phoneNoCityCode + "</font>";
			var tdNode5 = document.createElement("TD");
			oNewNode.appendChild(tdNode5);
			//Changes for call id 422593 starts
			tdNode5.innerHTML = "<font class='fntColData'>" + phoneNo + "</font>";
			//Changes for call id 422593 ends
			var tdNode6 = document.createElement("TD");
			oNewNode.appendChild(tdNode6);
			tdNode6.innerHTML = "<font class='fntColData'>" + email + "</font>";

			var tdNode7 = document.createElement("TD");
			oNewNode.appendChild(tdNode7);
			tdNode7.innerHTML = "<INPUT class='sbttn' TYPE = 'button' value = '...' onclick='editPhoneDetails()'>";

			oNewNode.attachEvent("onclick", callPhoneEmail);

			totalProdRecortds = document.all.PhoneEmailRecordSet.rows.length;
			// Tracker ID: 135125: XMLEncoding Changes STARTS
			if(boName == 'SuspectModBO' ){
				document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("SuspectModBO.PhoneEmail.url_", phoneURL);
			}
			else if(boName == 'SuspectBO')
			{
				document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("SuspectBO.PhoneEmail.url_", phoneURL);
			}
			else if(boName == 'ContactModBO' ){
				document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("ContactModBO.PhoneEmail.url_", phoneURL);
			}
			else if( boName == 'ContactBO'){
				document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("ContactBO.PhoneEmail.url_", phoneURL);
			}
			else if(boName == 'AccountBO' ){
				document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("AccountBO.PhoneEmail.url_", phoneURL);

			}
			else if( boName == 'AccountModBO'){
				document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("AccountModBO.PhoneEmail.url_", phoneURL);
			}
			/*Begin Changes for ticket id 253121*/
			else if( boName == 'NonCustomerModBO'){
				document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("NonCustomerModBO.PhoneEmail.url_", phoneURL);
			}/*End Changes for ticket id 253121*/
			else if( boName == 'NonCustomerBO'){
							document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("NonCustomerBO.PhoneEmail.url_", phoneURL);
			}
			// Tracker ID: 135125: XMLEncoding Changes ENDS
		}
		else
		{

			currPhoneTableRow.childNodes(0).innerHTML="<font class='fntColData'>" + add_phoneOrEmail_ML + "</font>";
			currPhoneTableRow.childNodes(1).innerHTML="<font class='fntColData'>" + add_phoneEmailType_ML + "</font>";
			currPhoneTableRow.childNodes(2).innerHTML="<font class='fntColData'>" + phoneNoCountryCode + "</font>";
			currPhoneTableRow.childNodes(3).innerHTML="<font class='fntColData'>" + phoneNoCityCode + "</font>";
			//Changes for call id 422593 starts
			currPhoneTableRow.childNodes(4).innerHTML="<font class='fntColData'>" + phoneNo + "</font>";
			//Changes for call id 422593 ends
			currPhoneTableRow.childNodes(5).innerHTML="<font class='fntColData'>" + email + "</font>";

			updatePhoneDet = false;
			// Tracker ID: 135125: XMLEncoding Changes STARTS
			if(boName == 'SuspectModBO' ){
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneNo", phoneNo);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectModBO.PhoneEmail.Email", email);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectModBO.PhoneEmail.url_", phoneURL);
			}
			else if(boName == 'SuspectBO')
			{
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneNo", phoneNo);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectBO.PhoneEmail.Email", email);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("SuspectBO.PhoneEmail.url_", phoneURL);
			}
			else if(boName == 'ContactModBO' ){
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneNo", phoneNo);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactModBO.PhoneEmail.Email", email);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactModBO.PhoneEmail.url_", phoneURL);

			}
			else if( boName == 'ContactBO'){
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneNo", phoneNo);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactBO.PhoneEmail.Email", email);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("ContactBO.PhoneEmail.url_", phoneURL);
			}
			else if(boName == 'AccountBO' ){
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneNo", phoneNo);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountBO.PhoneEmail.Email", email);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountBO.PhoneEmail.url_", phoneURL);
			}
			else if( boName == 'AccountModBO'){
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneNo", phoneNo);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountModBO.PhoneEmail.Email", email);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("AccountModBO.PhoneEmail.url_", phoneURL);
			}
			/*Begin Changes for ticket id 253121*/
			else if( boName == 'NonCustomerModBO'){
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneEmailType", phoneEmailType);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneEmailID", phoneEmailID);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneNo", phoneNo);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.Email", email);
				document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.url_", phoneURL);
			}
			else if( boName == 'NonCustomerBO'){
							document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
							document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneEmailType", phoneEmailType);
							document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneEmailID", phoneEmailID);
							document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
							document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
							document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
							document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneNo", phoneNo);
							document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.Email", email);
							document.all.PhoneEmailRecordSet.rows(eduPhoneRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.url_", phoneURL);
			}
			/*End Changes for ticket id 253121*/
			// Tracker ID: 135125: XMLEncoding Changes ENDS
		}
	}
	catch(e){DebugMessage(e.description);
	}
		return ("true");
}

function addEmailDetails(PhoneEmailDetails){
/* Recon From 10.3 Lead Management Changes Start */
var LeadID = getCookie('LeadID');
/* Recon From 10.3 Lead Management Changes End */
		 try
		 {
			if(boName == 'SuspectModBO' || boName == 'SuspectBO')
			{
				tempBoName = 'SuspectBO';
			}
			else if(boName == 'ContactModBO' || boName == 'ContactBO'){
				tempBoName = 'ContactBO';
			}
			else if(boName == 'AccountBO' || boName == 'AccountModBO'){
				tempBoName = 'AccountBO';
			}
			else if(boName == 'NonCustomerBO' || boName == 'NonCustomerModBO'){
				tempBoName = 'NonCustomerBO';
			}
			phoneOrEmail  = PhoneEmailDetails[0];
			email = PhoneEmailDetails[1];
			phoneEmailType = PhoneEmailDetails[2];
			phoneEmailID = PhoneEmailDetails[3];

			phoneNoCountryCode = "";
			phoneNoCityCode = "";
			phoneNoLocalCode = "";
			phoneNo = "";
			//586201 changes starts Recon for 309582
			extension="";
			//586201 changes ends Recon for 309582

			emailURL = email + phoneEmailType;

			 var email_alreadyAdded = false;
			/* Recon From 10.3 Lead Management Changes Start */
			if (LeadID!="" && LeadID!= null){
			//changes for call id 417057 and recon of call id 411623 starts
				//document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType1")[0].options.selectedIndex=1;
//Ticket 463005 changes
				if(phoneOrEmail=='EMAIL' && phoneEmailType=='WORKEML'){
				var emailValLength=document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType1")[0].options.length;
				for(var i=0;i<emailValLength;i++)
				  {
					if(document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType1")[0].options[i].value=='WORKEML')
					{
					document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType1")[0].options.selectedIndex=i;
			//changes for call id 417057 and recon of call id 411623 ends
					var add_phoneEmailType_ML =document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType1")[0].options[i].text;
					break;
					}
				}
			}else{
				var add_phoneEmailType_ML = ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType1")[0].options[ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType1")[0].selectedIndex].text;
				var add_phoneOrEmail_ML = ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneOrEmail")[0].options[ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneOrEmail")[0].selectedIndex].text;
			}
			var add_phoneOrEmail_ML =phoneOrEmail;
			}else{
							var add_phoneEmailType_ML = ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType1")[0].options[ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType1")[0].selectedIndex].text;
							var add_phoneOrEmail_ML = ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneOrEmail")[0].options[ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneOrEmail")[0].selectedIndex].text;
			}
			
			
			
			
			
	
			/* Recon From 10.3 Lead Management Changes End */
			if(!email_alreadyAdded)
			{
				var noOfexistingURLs = phoneEmail_URL.length;
				for(var x = 0; x < noOfexistingURLs ; x++)
				{
					//here compare with combination of Inst and Qualification
					//changed if Condition for Ticket:373113
					if(phoneEmailType == ad_PhoneEmailType[x] && ad_PhoneOrEmail[x]!='PHONE')
					{
						email_alreadyAdded = true;
						if(updateEmailDet)
						{
							if(x != emailRecordIndex)
							{
								updateEmailDet = false;
							}
						}
						break;
					}
				}
				if(updateEmailDet)
				{
					email_alreadyAdded = true;

					ad_PhoneOrEmail[emailRecordIndex] = phoneOrEmail;
					ad_Email[emailRecordIndex] = email;
					ad_PhoneEmailType[emailRecordIndex] = phoneEmailType;
					ad_PhoneEmailID[emailRecordIndex] = phoneEmailID;

					ad_PhoneNo[emailRecordIndex] = phoneNo;
					ad_PhoneNoCountryCode[emailRecordIndex] = phoneNoCountryCode;
					ad_PhoneNoCityCode[emailRecordIndex] = phoneNoCityCode;
					ad_PhoneNoLocalCode[emailRecordIndex] = phoneNoLocalCode;
					//586201 changes starts Recon for 309582
					ad_extension[emailRecordIndex] = extension;
					//586201 changes ends Recon for 309582

					phoneEmail_URL[emailRecordIndex] = emailURL;
					phoneEmail_Status[emailRecordIndex] = "Edit";
				}
			}
			if(!email_alreadyAdded)
			{
					adcount = phoneEmail_URL.length;
					ad_PhoneOrEmail[ad_PhoneOrEmail.length] = phoneOrEmail;
					ad_PhoneEmailType[ad_PhoneEmailType.length] = phoneEmailType;
					ad_Email[ad_Email.length] = email;

					ad_PhoneNo[ad_PhoneNo.length] = phoneNo;
					ad_PhoneNoCountryCode[ad_PhoneNoCountryCode.length] = phoneNoCountryCode;
					ad_PhoneNoCityCode[ad_PhoneNoCityCode.length] = phoneNoCityCode;
					ad_PhoneNoLocalCode[ad_PhoneNoLocalCode.length] = phoneNoLocalCode;
					//586201 changes starts Recon for 309582
					ad_extension[ad_extension.length] = extension;
					//586201 changes ends Recon for 309582

					phoneEmail_Status[phoneEmail_Status.length] = "New";
					phoneEmail_URL[phoneEmail_URL.length] = emailURL;
					ad_PhoneEmailID[ad_PhoneEmailID.length] = null;

			}
			/* Recon From 10.3 Lead Management Changes Start */
			//var add_phoneEmailType_ML = ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType1")[0].options[ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneEmailType1")[0].selectedIndex].text;
			//var add_phoneOrEmail_ML = ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneOrEmail")[0].options[ph_emailWindow.document.getElementsByName(tempBoName+".PhoneEmail.PhoneOrEmail")[0].selectedIndex].text;
			/* Recon From 10.3 Lead Management Changes End */
			if (!updateEmailDet)
			{
				if(email_alreadyAdded)
				{
					showUserMessage("MSGJ50373",null);
					return;
				}
				oNewNode = document.createElement("TR");
				if(TBODY_PhoneEmailRecordSet.childNodes.length % 2 == 0)
				{
					oNewNode.setAttribute("className", "color1");
				}
				else
				{
					oNewNode.setAttribute("className", "color2");
				}
				TBODY_PhoneEmailRecordSet.appendChild(oNewNode);
				// Tracker ID: 135125: XMLEncoding Changes STARTS
				if(boName == 'SuspectModBO' ){
					oNewNode.setAttribute("SuspectModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail );
					oNewNode.setAttribute("SuspectModBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					oNewNode.setAttribute("SuspectModBO.PhoneEmail.PhoneEmailID", phoneEmailID);
					oNewNode.setAttribute("SuspectModBO.PhoneEmail.Email", email);
				}
				else if(boName == 'SuspectBO')
				{
					oNewNode.setAttribute("SuspectBO.PhoneEmail.PhoneOrEmail", phoneOrEmail );
					oNewNode.setAttribute("SuspectBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					oNewNode.setAttribute("SuspectBO.PhoneEmail.PhoneEmailID", phoneEmailID);
					oNewNode.setAttribute("SuspectBO.PhoneEmail.Email", email);
				}
				else if(boName == 'ContactModBO' ){
					oNewNode.setAttribute("ContactModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail );
					oNewNode.setAttribute("ContactModBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					oNewNode.setAttribute("ContactModBO.PhoneEmail.PhoneEmailID", phoneEmailID);
					oNewNode.setAttribute("ContactModBO.PhoneEmail.Email", email);

				}
				else if( boName == 'ContactBO'){
					oNewNode.setAttribute("ContactBO.PhoneEmail.PhoneOrEmail", phoneOrEmail );
					oNewNode.setAttribute("ContactBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					oNewNode.setAttribute("ContactBO.PhoneEmail.PhoneEmailID", phoneEmailID);
					oNewNode.setAttribute("ContactBO.PhoneEmail.Email", email);
				}
				else if(boName == 'AccountBO' ){
					oNewNode.setAttribute("AccountBO.PhoneEmail.PhoneOrEmail", phoneOrEmail );
					oNewNode.setAttribute("AccountBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					oNewNode.setAttribute("AccountBO.PhoneEmail.PhoneEmailID", phoneEmailID);
					oNewNode.setAttribute("AccountBO.PhoneEmail.Email", email);

				}
				else if( boName == 'AccountModBO'){
					oNewNode.setAttribute("AccountModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail );
					oNewNode.setAttribute("AccountModBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					oNewNode.setAttribute("AccountModBO.PhoneEmail.PhoneEmailID", phoneEmailID);
					oNewNode.setAttribute("AccountModBO.PhoneEmail.Email", email);
				}
				/*Begin Changes for ticket id 253121*/
				else if( boName == 'NonCustomerModBO'){
					oNewNode.setAttribute("NonCustomerModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail );
					oNewNode.setAttribute("NonCustomerModBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					oNewNode.setAttribute("NonCustomerModBO.PhoneEmail.PhoneEmailID", phoneEmailID);
					oNewNode.setAttribute("NonCustomerModBO.PhoneEmail.Email", email);
				}
				else if( boName == 'NonCustomerBO'){
									oNewNode.setAttribute("NonCustomerBO.PhoneEmail.PhoneOrEmail", phoneOrEmail );
									oNewNode.setAttribute("NonCustomerBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
									oNewNode.setAttribute("NonCustomerBO.PhoneEmail.PhoneEmailID", phoneEmailID);
									oNewNode.setAttribute("NonCustomerBO.PhoneEmail.Email", email);
				}
				/*End Changes for ticket id 253121*/
				// Tracker ID: 135125: XMLEncoding Changes ENDS

				var tdNode = document.createElement("TD");
				oNewNode.appendChild(tdNode);
				tdNode.innerHTML =  "<font class='fntColData'>" + add_phoneOrEmail_ML+ "</font>";
				var tdNode2 = document.createElement("TD");
				oNewNode.appendChild(tdNode2);
				tdNode2.innerHTML =  "<font class='fntColData'>" + add_phoneEmailType_ML+ "</font>";
				var tdNode3 = document.createElement("TD");
				oNewNode.appendChild(tdNode3);
				tdNode3.innerHTML = "<font class='fntColData'>" + phoneNoCountryCode + "</font>";
				var tdNode4 = document.createElement("TD");
				oNewNode.appendChild(tdNode4);
				tdNode4.innerHTML = "<font class='fntColData'>" + phoneNoCityCode + "</font>";
				var tdNode5 = document.createElement("TD");
				oNewNode.appendChild(tdNode5);
				tdNode5.innerHTML = "<font class='fntColData'>" + phoneNoLocalCode + "</font>";
				var tdNode6 = document.createElement("TD");
				oNewNode.appendChild(tdNode6);
				tdNode6.innerHTML = "<font class='fntColData'>" + email + "</font>";

				var tdNode7 = document.createElement("TD");
				oNewNode.appendChild(tdNode7);
				tdNode7.innerHTML = "<INPUT class='sbttn' TYPE = 'button' value = '...' onclick='editEmailDetails()'>";

				oNewNode.attachEvent("onclick", callPhoneEmail);

				totalProdRecortds = document.all.PhoneEmailRecordSet.rows.length;
				// Tracker ID: 135125: XMLEncoding Changes STARTS
				if(boName == 'SuspectModBO' ){
					document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("SuspectModBO.PhoneEmail.url_", emailURL);
				}
				else if(boName == 'SuspectBO')
				{
					document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("SuspectBO.PhoneEmail.url_", emailURL);
				}
				else if(boName == 'ContactModBO' ){
					document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("ContactModBO.PhoneEmail.url_", emailURL);

				}
				else if( boName == 'ContactBO'){
					document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("ContactBO.PhoneEmail.url_", emailURL);
				}
				else if(boName == 'AccountBO' ){
					document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("AccountBO.PhoneEmail.url_", emailURL);

				}
				else if( boName == 'AccountModBO'){
					document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("AccountModBO.PhoneEmail.url_", emailURL);
				}
				/*Begin Changes for ticket id 253121*/
				else if( boName == 'NonCustomerModBO'){
					document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("NonCustomerModBO.PhoneEmail.url_", emailURL);
				/*End Changes for ticket id 253121*/
				}
				else if( boName == 'NonCustomerBO'){
					document.all.PhoneEmailRecordSet.rows(totalProdRecortds - 1).setAttribute("NonCustomerBO.PhoneEmail.url_", emailURL);
								
				}
				// Tracker ID: 135125: XMLEncoding Changes ENDS
			}
			else
			{

				currEmailTableRow.childNodes(0).innerHTML="<font class='fntColData'>" + add_phoneOrEmail_ML + "</font>";
				currEmailTableRow.childNodes(1).innerHTML="<font class='fntColData'>" + add_phoneEmailType_ML + "</font>";
				currEmailTableRow.childNodes(2).innerHTML="<font class='fntColData'>" + phoneNoCountryCode + "</font>";
				currEmailTableRow.childNodes(3).innerHTML="<font class='fntColData'>" + phoneNoCityCode + "</font>";
				currEmailTableRow.childNodes(4).innerHTML="<font class='fntColData'>" + phoneNoLocalCode + "</font>";
				currEmailTableRow.childNodes(5).innerHTML="<font class='fntColData'>" + email + "</font>";

				updateEmailDet = false;
				// Tracker ID: 135125: XMLEncoding Changes STARTS
				if(boName == 'SuspectModBO' ){
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectModBO.PhoneEmail.PhoneNo", phoneNo);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectModBO.PhoneEmail.Email", email);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectModBO.PhoneEmail.url_", emailURL);
				}
				else if(boName == 'SuspectBO')
				{
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectBO.PhoneEmail.PhoneNo", phoneNo);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectBO.PhoneEmail.Email", email);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("SuspectBO.PhoneEmail.url_", emailURL);
				}
				else if(boName == 'ContactModBO' ){
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactModBO.PhoneEmail.PhoneNo", phoneNo);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactModBO.PhoneEmail.Email", email);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactModBO.PhoneEmail.url_", emailURL);
				}
				else if( boName == 'ContactBO'){
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactBO.PhoneEmail.PhoneNo", phoneNo);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactBO.PhoneEmail.Email", email);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("ContactBO.PhoneEmail.url_", emailURL);
				}
				else if(boName == 'AccountBO' ){
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountBO.PhoneEmail.PhoneNo", phoneNo);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountBO.PhoneEmail.Email", email);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountBO.PhoneEmail.url_", emailURL);
				}
				else if( boName == 'AccountModBO'){
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountModBO.PhoneEmail.PhoneNo", phoneNo);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountModBO.PhoneEmail.Email", email);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("AccountModBO.PhoneEmail.url_", emailURL);
				}
				/*Begin Changes for ticket id 253121*/
				else if( boName == 'NonCustomerModBO'){
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.PhoneNo", phoneNo);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.Email", email);
					document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerModBO.PhoneEmail.url_", emailURL);
				}
				else if( boName == 'NonCustomerBO'){
									document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneOrEmail", phoneOrEmail);
									document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneEmailType1", phoneEmailType);
									document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneNo.cntrycode", phoneNoCountryCode);
									document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneNo.areacode", phoneNoCityCode);
									document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneNo.localCode", phoneNoLocalCode);
									document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.PhoneNo", phoneNo);
									document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.Email", email);
									document.all.PhoneEmailRecordSet.rows(eduEmailRecordIndex).setAttribute("NonCustomerBO.PhoneEmail.url_", emailURL);
				}
				/*End Changes for ticket id 253121*/
				// Tracker ID: 135125: XMLEncoding Changes STARTS
			}
		}
		catch(e)
		{
		}
		return ("true");
}

function checkForExistingPhoneType(selectedPhoneType)
{
	try{
		var recordSetSize =  document.all.PhoneEmailRecordSet.rows.length;
		// Tracker ID: 135125: XMLEncoding Changes STARTS
		if(boName == 'SuspectModBO' ){
			for(var k=0 ;k<recordSetSize; k++)
			{
				if(selectedPhoneType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectModBO.PhoneEmail.PhoneEmailType"))
				{
					return false;
				}
			}
		}
		else if(boName == 'SuspectBO')
		{
			for(var k=0 ;k<recordSetSize; k++)
			{
				if(selectedPhoneType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectBO.PhoneEmail.PhoneEmailType"))
				{
					return false;
				}
			}
		}
		else if(boName == 'ContactModBO' ){
			for(var k=0 ;k<recordSetSize; k++)
			{
				if(selectedPhoneType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactModBO.PhoneEmail.PhoneEmailType"))
				{
					return false;
				}
			}
		}
		else if( boName == 'ContactBO'){
			for(var k=0 ;k<recordSetSize; k++)
			{
				if(selectedPhoneType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactBO.PhoneEmail.PhoneEmailType"))
				{
					return false;
				}
			}
		}
		else if(boName == 'AccountBO' ){
			for(var k=0 ;k<recordSetSize; k++)
			{
				if(selectedPhoneType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountBO.PhoneEmail.PhoneEmailType"))
				{
					return false;
				}
			}
		}
		else if( boName == 'AccountModBO'){
			for(var k=0 ;k<recordSetSize; k++)
			{
				if(selectedPhoneType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountModBO.PhoneEmail.PhoneEmailType"))
				{
					return false;
				}
			}
		}
		/*Begin Changes for ticket id 253121*/
		else if( boName == 'NonCustomerModBO'){
			for(var k=0 ;k<recordSetSize; k++)
			{
				if(selectedPhoneType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerModBO.PhoneEmail.PhoneEmailType"))
				{
					return false;
				}
			}
		}
		else if( boName == 'NonCustomerBO'){
					for(var k=0 ;k<recordSetSize; k++)
					{
						if(selectedPhoneType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerBO.PhoneEmail.PhoneEmailType"))
						{
							return false;
						}
					}
		}
		/*End Changes for ticket id 253121*/
		// Tracker ID: 135125: XMLEncoding Changes ENDS
	}
	catch(e)
	{
	}
	return null;
}

function checkForExistingEmailType(selectedEmailType)
{
	
	var recordSetSize =  document.all.PhoneEmailRecordSet.rows.length;
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName == 'SuspectModBO' ){
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(selectedEmailType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectModBO.PhoneEmail.PhoneEmailType1"))
			{
				return false;
			}
		}
	}
	else if(boName == 'SuspectBO')
	{
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(selectedEmailType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("SuspectBO.PhoneEmail.PhoneEmailType1"))
			{
				return false;
			}
		}
	}
	else if(boName == 'ContactModBO' ){
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(selectedEmailType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactModBO.PhoneEmail.PhoneEmailType1"))
			{
				return false;
			}
		}
	}
	else if( boName == 'ContactBO'){
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(selectedEmailType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("ContactBO.PhoneEmail.PhoneEmailType1"))
			{
				return false;
			}
		}
	}
	else if(boName == 'AccountBO' ){
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(selectedEmailType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountBO.PhoneEmail.PhoneEmailType1"))
			{
				return false;
			}
		}

	}
	else if( boName == 'AccountModBO'){
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(selectedEmailType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("AccountModBO.PhoneEmail.PhoneEmailType1"))
			{
				return false;
			}
		}
	}
	/*Begin Changes for ticket id 253121*/
	else if( boName == 'NonCustomerModBO'){
		for(var k=0 ;k<recordSetSize; k++)
		{
			if(selectedEmailType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerModBO.PhoneEmail.PhoneEmailType1"))
			{
				return false;
			}
		}
	}
	else if( boName == 'NonCustomerBO'){
			for(var k=0 ;k<recordSetSize; k++)
			{
				if(selectedEmailType == document.all.PhoneEmailRecordSet.rows(k).getAttribute("NonCustomerBO.PhoneEmail.PhoneEmailType1"))
				{
					return false;
				}
			}
	}
	/*End Changes for ticket id 253121*/
	// Tracker ID: 135125: XMLEncoding Changes ENDS
	return null;
}

function editPhoneEmailDetails()
{
	if(event.srcElement.parentElement.id == null || event.srcElement.parentElement.id == '') {

		   tempTableRow = event.srcElement.parentElement.parentElement;
	} else {

			tempTableRow = event.srcElement.parentElement;
	}
	currEduTableRow = tempTableRow;
	// Tracker ID: 135125: XMLEncoding Changes STARTS
	if(boName == 'SuspectModBO' ){
		phoneOrEmailClicked = currEduTableRow.getAttribute('SuspectModBO.PhoneEmail.PhoneOrEmail');
	}
	else if(boName == 'SuspectBO')
	{
		phoneOrEmailClicked = currEduTableRow.getAttribute('SuspectBO.PhoneEmail.PhoneOrEmail');
	}
	else if(boName == 'ContactModBO' ){
		phoneOrEmailClicked = currEduTableRow.getAttribute('ContactModBO.PhoneEmail.PhoneOrEmail');
	}
	else if( boName == 'ContactBO'){
		phoneOrEmailClicked = currEduTableRow.getAttribute('ContactBO.PhoneEmail.PhoneOrEmail');
	}
	else if(boName == 'AccountBO' ){
		phoneOrEmailClicked = currEduTableRow.getAttribute('AccountBO.PhoneEmail.PhoneOrEmail');
	}
	else if( boName == 'AccountModBO'){
		phoneOrEmailClicked = currEduTableRow.getAttribute('AccountModBO.PhoneEmail.PhoneOrEmail');
	}
	/*Changes for Tracker 173927 starts*/
	else if( boName == 'NonCustomerModBO'){
		phoneOrEmailClicked = currEduTableRow.getAttribute('NonCustomerModBO.PhoneEmail.PhoneOrEmail');
		}
	else if( boName == 'NonCustomerBO'){
		phoneOrEmailClicked = currEduTableRow.getAttribute('NonCustomerBO.PhoneEmail.PhoneOrEmail');
	}
	/*Changes for Tracker 173927 ends*/
	// Tracker ID: 135125: XMLEncoding Changes ENDS
	if(phoneOrEmailClicked == "PHONE")
	{
		editPhoneDetails();
	}
	else
	{
		editEmailDetails();
	}
}











