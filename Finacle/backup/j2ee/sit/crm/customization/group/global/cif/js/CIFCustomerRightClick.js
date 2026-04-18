// BEGIN OF ML CHANGES
document.write('<script type="text/javascript" src="'+applPath+'/cif/js/Message_cif_'+finaclecrmlocale+'.js" language="javascript"></script>');
// END OF ML CHANGES
document.write('<script language="javascript" src="'+applPath+'/common/js/SSOUtils.js"></script>');
//right click menu changes begin
/*Begin of changes for tracker 131243 by sumeet gandhok - BANKID - */
var bank_id=null;
/*End of changes for tracker 131243 by sumeet gandhok - BANKID - */
function checkCookie(x){
    if(x!=0 &&x != null && x != 'null' && x != "" && x!='undefined') {
        return "Valid" ;
    }else{
        return "InValid";
    }
}
function EditAccount(url) {
	alert("Edit 1");

/* CRM102ST: TrackerID:180825 Begin of Change */
var entityType = getCookie('entityType');
/* CRM102ST: TrackerID:180825 End of Change */
  /*Begin of changes for tracker 131243 by sumeet gandhok - BANKID -*/
  
  alert("Edit 1");
   bank_id = checkBankPrivilege();
   if(bank_id!=null && (ScreenName=="RetSearch"||ScreenName=="RetEdit"||ScreenName=="CorpEdit"||ScreenName=="CorpSearch")){
      	showMessage(MSGJ50789);
   }
   else{
  /*End of changes for tracker 131243 by sumeet gandhok - BANKID -*/
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
    expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));

    // Tracker ID - 90197 Begin of Changes for attribute masking
	AccessOwnerGroup = getCookie('AccessOwnerGroup');
    //  Tracker ID - 90197 End of Changes

    accountID  = getCookie('AccountID');
    var RecordSts=getCookie('RecordStatus');
    var ProcessSts=getCookie('ProcessStatus');

    if(checkCookie(accountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }
    //Field Rationalization changes
    var tfFlag = getCookie("tfFlag");
	//Changes for Tracker ID 474357 starts
	//Changes for call id 575231 
	//if(RecordSts=='A' && (ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null|| ProcessSts =="null")){

    if(tfFlag != 'Y' && (url.indexOf("../servlet/com.infy.cis.ui.cif.AccountDetWizard") != -1) && (url.indexOf("isTF=Yes")!= -1) && (url.indexOf("operationType=EditEntity")!= -1))
    {
    showMessage(MSGJ50276);
    return;
    }
    /*Changes done by kanika for Cif Deceased start */
    var custStatus  =getCookie('custStatus');
    if(custStatus == 'DCSED'){
    	if(!showConfirmMessage(MSGJ51883)){
    		return;
    	}
    } 
     /*Changes done by kanika for Cif Deceased end*/
    //Field Rationalization changes
	//changes for Tracker:404868 begin
    //if(RecordSts=='A' && (ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =='null')){
	//changes for Tracker:404868 ends
	//Changes for call id 575231 
    if(RecordSts=='A' && (ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null|| ProcessSts =="null")){
	//Changes for Tracker ID 474357 end
    servletURL = url + accountID+"&AccessOwnerGroup=" + AccessOwnerGroup;
    servletURL = servletURL  + "&AcrossSearch=N";

    // vasanth's changes start
		var blacklisted = getCookie("BlackListed");
		var suspended = getCookie("Suspended");
		var negated = getCookie("Negated");
		var dob = getCookie("dob");
		/* CRM102ST: TrackerID:180825 Begin of Change */
		 /*Changes done by kanika for Cif Deceased starts */
		servletURL = servletURL + '&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&chkBSN=true'+'&entityType='+entityType+'&dob='+dob+"&custStatus="+custStatus;
		/*Changes done by kanika for Cif Deceased ends */
		/* CRM102ST: TrackerID:180825 End of Change */
	// vasanth's changes end
    //window.location.href=servletURL;
//Recon of Security Audit Changes From CRM10301BSUPP
      var hashkey=getBrowserCookie('HASHKEY');
      var fldhashkey=getBrowserCookie('FLDHASHKEY');

      servletURL+='&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
//Recon of Security Audit Changes From CRM10301BSUPP
        //Fix for TOL id: 755796, preventing multiple windows to open - starts
		var isWindowOpened = sessionStorage.getItem("IsWindowOpened");
		if(isWindowOpened != "true")
		{
			var win = window.open(servletURL, '','height=500,width=900,left=75,top=100,resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');
			sessionStorage.setItem("IsWindowOpened", "true");
		}
		else
		{
			showMessage(MSGJ63927);
		}
		//Fix for TOL id: 755796, preventing multiple windows to open - ends
    } else {
    //changes for call id 338600 starts
	var accountdetails = getStatus(accountID);
        var valList = new Array();
        valList = accountdetails.split("|");
        var verificationValue = valList[0];
        var RecordStatus = valList[1];
        var userName = valList[2];
	
	if(((verificationValue!=null)||(verificationValue!=='')) && RecordStatus=='D')
		{
		alert(''+userName+' has modified this entity and it is in Draft status.');			    		
	}
	else if(((verificationValue!=null)||(verificationValue!=='')) && RecordStatus=='R')
	{
		alert(''+userName+' has modified this entity and it is in Rejected status.');			    		

	}
	else
	{
   showMessage(MSGJ0029);
   }
       //changes for call id 338600 ends
    }
  }
}
//changes for call id 338600  starts
function getStatus(accountID)
{
<!-- Tracker ID :756914 - Chrome Porting Changes -->
	var s_xmlHttp;
	if (window.XMLHttpRequest){
		s_xmlHttp = new XMLHttpRequest();
	}else{//For IE 
	 s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
	}

        
     s_xmlHttp.abort();
    var strURL = '../servlet/com.infy.cis.custom.CIFVerification' + "?accountID="+accountID;
    
    s_xmlHttp.open("GET",strURL,false);
    s_xmlHttp.send();    	
    	
        var verificationValue = '';
        var RecordStatus='';
        var userName='';
    	if(s_xmlHttp.status == 200)
    	{   try
    	    {
    		var node = s_xmlHttp.responseXML.selectSingleNode("CustomerValues/verificationValue");
    		verificationValue = node.text;
    		node = s_xmlHttp.responseXML.selectSingleNode("CustomerValues/RecordStatus");
    		RecordStatus = node.text;
    		node = s_xmlHttp.responseXML.selectSingleNode("CustomerValues/userName");
    		userName = node.text;
    		
    		 }
    	    catch( e )
    	    {
    	    }
	}
return verificationValue+"|"+RecordStatus+"|"+userName;
}
       //changes for call id 338600  ends
// Added by Vijay for Customer Events - Start
function EditEvent(name, url) {
//Recon of Security Audit Changes From CRM10301BSUPP
	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');
//Recon of Security Audit Changes From CRM10301BSUPP

/*Begin of changes for tracker 131243 by sumeet gandhok - BANKID -*/

alert("Edit 2");

bank_id = checkBankPrivilege();
if(bank_id!=null && (ScreenName=="RetSearch"||ScreenName=="RetEdit"||ScreenName=="CorpEdit"||ScreenName=="CorpSearch")){
   showMessage(MSGJ50789);
 }
 else{
/*End of changes for tracker 131243 by sumeet gandhok - BANKID -*/

    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
    expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));

    accountID  = getCookie('AccountID');
    accountKey = getCookie('AccountKey');

    // Tracker ID - 90197 Begin of Changes for attribute masking
   	AccessOwnerGroup = getCookie('AccessOwnerGroup');
     //  Tracker ID - 90197 End of Changes


    if(checkCookie(accountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

    if(checkCookie(accountKey)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }
    /* changes for ticket 305918 start */
     /*Changes done by kanika for Cif Deceased start*/
    var custStatus  =getCookie('custStatus');
    if(custStatus == 'DCSED'){
    	if(!showConfirmMessage(MSGJ51883)){
    		return;
    	}
    }   
     /*Changes done by kanika for Cif Deceased end*/
    var blacklisted = getCookie("BlackListed");
    var suspended = getCookie("Suspended");
    var negated = getCookie("Negated");
    //changes for call is 338600 starts
	var accountdetails = getStatus(accountID);
            var valList = new Array();
            valList = accountdetails.split("|");
            var verificationValue = valList[0];
            var RecordStatus = valList[1];
            var userName = valList[2];
              /*changes for call id:346622 START */
            var RecSts= getCookie("RecordStatus");
            var ProcessSts=getCookie('ProcessStatus');
           
	//Changes for ticket id: 668345         
            if(RecSts=='A' && (ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =='null')){
             servletURL = url + accountID + "&AccountKey=" + accountKey+"&AccessOwnerGroup=" +AccessOwnerGroup+'&chkBSN=true'+'&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
	        /* changes for ticket 305918 end */
	        //window.location.href=servletURL;
	    
	      /* Tracker: 108382: Changes for centering popup */
	      windowAlign();
	       var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');
	    
  /* Tracker: 108382: End of Changes */
            }
            else{
    	
		 if(((verificationValue!=null)||(verificationValue!=='')) && RecordStatus=='D')
		{
			alert(''+userName+' has modified this entity and it is in Draft status.');
			return;
		}
		else if(((verificationValue!=null)||(verificationValue!=='')) && RecordStatus=='R')
		{
		alert(''+userName+' has modified this entity and it is in Rejected status.');	
			return;		

    		}
        	else
        	{
        	
      		 showMessage(MSGJ0029);
      		 	return;
   		}
       //changes for call is 334482 ends
}
 /* changes for call id:346622 END*/  
}
}
// Added by Vijay for Customer Events - End
function ViewCustomer() {
//Recon of Security Audit Changes From CRM10301BSUPP
	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');
//Recon of Security Audit Changes From CRM10301BSUPP
 /*Begin of changes for tracker 131243 by sumeet gandhok - BANKID - */
  bank_id = checkBankPrivilege();
 /*End of changes for tracker 131243 by sumeet gandhok - BANKID - */

	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
	        showUserMessage("MSG014","MSG_ACCT");
	        return;
	    }
	IsTampered = getCookie('IsTampered');

		if(IsTampered=='Y')
		{	 showMessage(MSGJ50260);
			return;
		}

	     // Tracker ID - 90197 Begin of Changes for attribute masking
	    	     AccessOwnerGroup = getCookie('AccessOwnerGroup');
	    //  Tracker ID - 90197 End of Changes
	    AccountID  = getCookie('AccountID');

	    if(checkCookie(AccountID)=="InValid"){

	        showUserMessage("MSG007","MSG_ACCT");
	        return;

	    }
 		/*Begin of changes for tracker 131243 by sumeet gandhok - BANKID - passed additional bankid parameter */
				servletURL = '../servlet/com.infy.cis.ui.cif.AccountDetWizard?IsReadOnly=Y&AcrossSearch=N&boType=Main&bank_id='+bank_id+'&accountId='+AccountID+'&AccessOwnerGroup='+AccessOwnerGroup;
		/*End of changes for tracker 131243 by sumeet gandhok - BANKID - passed additional bankid parameter */

	       // vasanth's changes start
		var blacklisted = getCookie("BlackListed");
		var suspended = getCookie("Suspended");
		var negated = getCookie("Negated");
//Recon of Security Audit Changes From CRM10301BSUPP
		 /*Changes done by kanika for Cif Deceased starts*/
		servletURL = servletURL + '&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&chkBSN=true&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&operationType=EditEntity';
		/*Changes done by kanika for Cif Deceased ends*/
//Recon of Security Audit Changes From CRM10301BSUPP
	// vasanth's changes end
   // window.location.href=servletURL;
    // Popup commented
    //showNewWindow(servletURL);
    var win = window.open(servletURL, '','height='+ 700+ ',left='+ 200 +',top='+ 120+',width='+900+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');
}

   /*tracker id 231104 changes starts*/

function ViewBaselProfile() {
//Recon of Security Audit Changes From CRM10301BSUPP
	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');
//Recon of Security Audit Changes From CRM10301BSUPP

  bank_id = checkBankPrivilege();
////alert('bank_id :'+bank_id);

	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){

	 	showUserMessage("MSG014","MSG_ACCT");

	        return;
	    }
	IsTampered = getCookie('IsTampered');

		if(IsTampered=='Y')
		{	 showMessage(MSGJ50260);
			return;
		}

 	    AccessOwnerGroup = getCookie('AccessOwnerGroup');

 	   // //alert('AccessOwnerGroup :'+AccessOwnerGroup);

	    AccountID  = getCookie('AccountID');




	    if(checkCookie(AccountID)=="InValid"){

	        showUserMessage("MSG007","MSG_ACCT");
	        return;

	    }

		servletURL = '../servlet/com.infy.cis.ui.cif.AccountDetWizard?IsReadOnly=Y&isPopup=Yes&isBasel=Yes&boType=Main&AcrossSearch=N&bank_id='+bank_id+'&accountId='+AccountID+'&AccessOwnerGroup='+AccessOwnerGroup+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;



		var blacklisted = getCookie("BlackListed");
		var suspended = getCookie("Suspended");
		var negated = getCookie("Negated");

		servletURL = servletURL + '&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&chkBSN=true';



   		var win = window.open(servletURL, '','height='+ 700+ ',left='+ 200 +',top='+ 120+',width='+900+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');
}



 /*tracker id 231104 changes ends*/

function ViewCustomerDocs(url)
{
  if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
    showUserMessage("MSG014","MSG_ACCT");
    return;
  }
      accountKey = getCookie('AccountKey');

  if(checkCookie(accountKey)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

	document.frmOD.action =url+"?ExternalAppName=NewGen&search_Type=cif_Entity&CifID="+accountKey ;
	document.frmOD.target='Omnidoc';
	document.frmOD.submit();

}



//following function added for copy
function CopyCustomer() {
//Recon of Security Audit Changes From CRM10301BSUPP
	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');
//Recon of Security Audit Changes From CRM10301BSUPP
	//113066 Amit Malhotra begin of changes

	        StrLoggegInBankId2  = getCookie('StrLoggegInBankId1');
		StrSearchedBankId2  = getCookie('StrSearchedBankId1');
		status1 = checkBNSRecord();
		////alert(status1);
		if(status1){
				 ////alert("hi");
//113066 Amit Malhotra end of changes
	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
	        showUserMessage("MSG014","MSG_ACCT");
	        return;
	    }
	    IsTampered = getCookie('IsTampered');

	    	if(IsTampered=='Y')
	    	{	 showMessage(MSGJ50260);
	    		return;
		}

	    AccountID  = getCookie('AccountID');


	    if(checkCookie(AccountID)=="InValid"){

	        showUserMessage("MSG007","MSG_ACCT");
	        return;

	    }
   servletURL = '../servlet/com.infy.cis.ui.cif.AccountDetWizard?isCopy=Y&boType=Main&accountId='+AccountID;
//113066 Amit Malhotra begin of changes
	    if(StrLoggegInBankId2!=StrSearchedBankId2){
		////alert("I am in across entity");
		var bank_id = StrSearchedBankId2;
//Recon of Security Audit Changes From CRM10301BSUPP
		servletURL = '../servlet/com.infy.cis.ui.cif.AccountDetWizard?isCopy=Y&AcrossSearch=Y&boType=Main&bank_id='+bank_id+'&accountId='+AccountID+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
//Recon of Security Audit Changes From CRM10301BSUPP
	    }else{
	       var bank_id = StrLoggegInBankId2;
//Recon of Security Audit Changes From CRM10301BSUPP

	       servletURL = '../servlet/com.infy.cis.ui.cif.AccountDetWizard?isCopy=Y&AcrossSearch=N&boType=Main&bank_id='+bank_id+'&accountId='+AccountID+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
//Recon of Security Audit Changes From CRM10301BSUPP
	    }
//113066 Amit Malhotra end of changes
/* Changes for ticket 294629 starts */
//window.location.href=servletURL;
var win = window.open(servletURL,'','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
/* Changes for ticket 294629 ends */
	}
    }

/*****Function for adding performDeDup in rightclickoptions on customers in Customer Information Menu********/
function performdedup(name,url) {
//Recon of Security Audit Changes From CRM10301BSUPP

var hashkey=getCookie('HASHKEY');
var fldhashkey=getCookie('FLDHASHKEY');
//Recon of Security Audit Changes From CRM10301BSUPP
/*
 * BEGIN OF CHANGES Fix for 264329
 * No need to check for criteria, this is already hapening in deduppanel
 *
 DedupCriteriaFlag2 = getCookie('DedupCriteriaFlag1');

 if(DedupCriteriaFlag2 == "N"){
 //alert("Criteria not set for within bank");
}*/
/* END OF CHANGES 264329 */
 if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	showMessage(MSGJ50260);
    		return;
	}
    accountID  = getCookie('AccountID');
    accountKEY = getCookie('AccountKey');
    entityType = getCookie('entityType');
    ProcessSts=getCookie('ProcessStatus');


    if(checkCookie(accountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }
// Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
 if(ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =="null"){
//Recon of Security Audit Changes From CRM10301BSUPP

        var servURL= url+accountID+'&accountKey='+accountKEY+'&entityType='+entityType+'&isPopup=Yes&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
//Recon of Security Audit Changes From CRM10301BSUPP
   //window.open(url+accountID+'&accountKey='+accountKEY+'&entityType='+entityType+'&amp;isPopup=Yes','','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars');
 	//childWindow= window.showModalDialog(url+accountID+'&accountKey='+accountKEY+'&entityType='+entityType+'&amp;isPopup=Yes','','dialogHeight:436px; dialogWidth:900px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
 	//childWindow= window.showModalDialog(servURL,'','dialogHeight:460px; dialogWidth:900px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
       var win = window.open(servURL, '','height=436,width=900,left=50,top=120,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');

 	/*try{

	if (childWindow.opener == null){
						childWindow.opener = window;
	                                }
	}catch(e){}

	if(childWindow != null)
	childWindow.open;*/


 }else {
    showMessage(MSGJ0031);
  }
// Tracker ID - 97668 End of Changes

}
/***** Function for adding perform suspend in rightclickoptions on customers in Customer Information Menu********/
function SuspendEntity(name, url) {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
     AccountID  = getCookie('AccountID');
    suspendFlag  = getCookie('Suspended');
    ProcessSts=getCookie('ProcessStatus');
   if(suspendFlag == "")
   {
   	suspendFlag = "N";
   }
   if(checkCookie( AccountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

    if(checkCookie(suspendFlag)=="InValid"){
        showUserMessage("MSG_SUSPEND","MSG_ACCT");
        return;
    }

	/*Changes for Approval: start*/

    	var RecordSts=getCookie('RecordStatus');
 // Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
  if(ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =="null"){

	if(RecordSts=="A")
	{
	    	 /*Changes done by kanika for Cif Deceased start*/
	   	 var custStatus  =getCookie('custStatus');
	    	if(custStatus == 'DCSED'){
		   showMessage(MSGJ51904);
		   return;
    		} 
		servletURL = url +  AccountID + '&TabName='+MSGJ0158+'&Operation=Suspend';
		/*Changes done by kanika for Cif Deceased start end*/

/**************** CRA10MSC : TRACKER# 90015: START OF CHANGES *****************************/
		/*
		if(suspendFlag=="Y")
		{
			showMessage(MSGJ0030);
		}
		else
		{
		*/
			//var win = window.open(servletURL, '','height=436,width=900,left=50,top=100,resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');

		  //  <!--Tracker:108382:Modal Window change-->


			/* Tracker: 108382: Changes for centering popup */
			windowAlign();
		      //childWindow= window.showModalDialog(servletURL,'','dialogHeight:'+wh+'px; dialogWidth:'+ww+'px; dialogLeft:'+left_x+'px; dialogTop:'+left_y+'px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
			var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');

		        /* Tracker: 108382: End of Changes */

		 	/*try{

			if (childWindow.opener == null){
								childWindow.opener = window;
			                                }
			}catch(e){}

			if(childWindow != null)
			childWindow.open;*/
		   // <!--Tracker:108382:End of Changes-->
		//}

/**************** CRA10MSC : TRACKER# 90015: END OF CHANGES *****************************/
	}
	else
			{
			showMessage(MSGJ0031);
    }

// Tracker ID - 97668 End of Changes
	}
	else
	{
	showMessage(MSGJ0031);

	}
	/*Changes for Approval: end*/

}
/***** Function for adding perform unsuspend in rightclickoptions on customers in Customer Information Menu********/
function UnSuspendEntity(name, url) {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
    accountID  = getCookie('AccountID');
    suspendFlag  = getCookie('Suspended');
    ProcessSts=getCookie('ProcessStatus');

    if(checkCookie(accountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }
    if(checkCookie(suspendFlag)=="InValid"){
	    showUserMessage("MSG_SUSPEND","MSG_ACCT");
	    return;
    }

	/*Changes for Approval: start*/
	var RecordSts=getCookie('RecordStatus');
  // Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
 if(ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =="null"){

	if(RecordSts=="A")
	{
	    	/*Changes done by kanika for Cif Deceased starts*/
	   	 var custStatus  =getCookie('custStatus');
	    	if(custStatus == 'DCSED'){
		   showMessage("Entity is marked deceased. You have to update the customer status first.");
		   return;
    		}	
    		/*Changes done by kanika for Cif Deceased ends*/
		servletURL = url + accountID + '&TabName='+MSGJ0159+'&Operation=UnSuspend';
		if(suspendFlag=="N")
		{
			showMessage(MSGJ0032);
		}
		else
		{
			/* Tracker: 108382: Changes for centering popup */

			windowAlign();
			var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');

		      /* Tracker: 108382: End of Changes */
		}
	}
	else
			{
			showMessage(MSGJ0031);
	}

// Tracker ID - 97668 End of Changes
	}
	else
	{
	showMessage(MSGJ0031);

	}
	/*Changes for Approval: end*/
}
/*****Function for adding blacklisting entity in rightclickoptions on customers in Customer Information Menu********/
function BlackListEntity(name, url) {

    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
    entityId  = getCookie('AccountID');
    entityType  = getCookie('entityType');
    blackListFlag  = getCookie('BlackListed');
    ProcessSts=getCookie('ProcessStatus');

    if(blackListFlag == "")
    {
    	blackListFlag = "N";
    }

   if(checkCookie(entityId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }

   if(checkCookie(blackListFlag)=="InValid"){
        //showUserMessage("MSG_SUSPEND","MSG_ACCT");
        showMessage(MSGJ0022);
        return;
    }

    /*Changes for Approval: start*/

    var RecordSts=getCookie('RecordStatus');
 // Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
 if(ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =="null"){

    if(RecordSts=="A")
    {
        //Tracker 96279 changes
        servletURL = url + entityId +'&TabName='+MSGJ0160+'&Operation=Blacklist'+ '&entityType='+entityType;
     /*  if(blackListFlag=="Y")
        {
		showMessage(MSGJ0023);
	}
	else
    	{*/
    		var win = window.open(servletURL, '','height=436,width=900,left=50,top=120,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');
      //  }

  }
  else
  		{
  		showMessage(MSGJ0031);
    }
 // Tracker ID - 97668 End of Changes
    }
    else
    {
        showMessage(MSGJ0031);

    }
    //Tracker 96279 changes
    /*Changes for Approval: end*/

}
/*****Function for adding RemoveBlackListEntity in rightclickoptions on customers in Customer Information Menu********/
function RemoveBlackListEntity(name, url) {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
    entityId  = getCookie('AccountID');
    entityType  = getCookie('entityType');
    blackListFlag  = getCookie('BlackListed');
    ProcessSts=getCookie('ProcessStatus');

   if(checkCookie(entityId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }

   if(checkCookie(blackListFlag)=="InValid"){
        showUserMessage("MSG_SUSPEND","MSG_ACCT");
        return;
    }

	/*Changes for Approval: start*/

    	var RecordSts=getCookie('RecordStatus');
 // Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
 if(ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =="null"){

	if(RecordSts=="A")
	{
	    //servletURL = url + accountID + '&TabName=Suspend Customer';
		// changes for ticket 348439
	//Recon of Security Audit Changes From CRM10301BSUPP
	    servletURL = url + entityId +'&TabName='+MSGJ0161+'&Operation=UnBlacklist'+'&entityType='+entityType+'&type=RETAIL';
	//Recon of Security Audit Changes From CRM10301BSUPP
	    if(blackListFlag=="N")
	    {
		showMessage(MSGJ0025);
	    }
	    else
	    {
		var win = window.open(servletURL, '','height=436,width=900,left=50,top=120,resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');
	    }
	}
	else
			{
			showMessage(MSGJ0031);
	}

// Tracker ID - 97668 End of Changes
    	}
	else
	{
	    showMessage(MSGJ0031);

    	}
    	/*Changes for Approval: end*/
}
/*****Function for adding perform Negative Check in rightclickoptions on customers in Customer Information Menu********/
function NegateEntity(name, url) {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}

    entityId  = getCookie('AccountID');
    entityType  = getCookie('entityType');
    negativeFlag  = getCookie('Negated');
    ProcessSts=getCookie('ProcessStatus');

   if(negativeFlag == "")
    {
    	negativeFlag = "N";
    }
   if(checkCookie(entityId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }

   if(checkCookie(negativeFlag)=="InValid"){
        //showUserMessage("MSG_SUSPEND","MSG_ACCT");
        showMessage(MSGJ0026);
        return;
    }

	/*Changes for Approval: start*/
    	var RecordSts=getCookie('RecordStatus');
// Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
 if(ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =="null"){

    	if(RecordSts=="A")
    	{
    	    //servletURL = url + accountID + '&TabName=Suspend Customer';
    	    //Tracker 96279 changes
    	    servletURL = url + entityId +'&TabName='+MSGJ0162+'&Operation=Negate'+ '&entityType='+entityType;

/**************** CRA10MSC : TRACKER# 90015: START OF CHANGES *****************************/
	   /*if(negativeFlag=="Y")
	    {
	    	showMessage(MSGJ0027);
	    }
    		else
    	    {*/
    		//var win = window.open(servletURL, '','height=436,width=900,left=50,top=120,resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');
    	    //}
/**************** CRA10MSC : TRACKER# 90015: END OF CHANGES *****************************/

   //<!--Tracker:108382:Modal Window change-->


   	/* Tracker: 108382: Changes for centering popup */
   	windowAlign();
   	//childWindow= window.showModalDialog(servletURL,'','dialogHeight:'+wh+'px; dialogWidth:'+ww+'px; dialogLeft:'+left_x+'px; dialogTop:'+left_y+'px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
        var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');

     	/* Tracker: 108382: End of Changes */

     	/*try{

    		if (childWindow.opener == null){
    						 childWindow.opener = window;
    					   	}
    		}catch(e){}

    	 	if(childWindow != null)
   		childWindow.open;*/
  // <!--Tracker:108382:End of Changes-->
   	}
    	else
			{
			showMessage(MSGJ0031);
    }

 // Tracker ID - 97668 End of Changes
  	}
    	else
    	{
    	    showMessage(MSGJ0031);

    	}
    	//Tracker 96279 changes
    	/*Changes for Approval: end*/

}
/*****Function for adding Remove Negative Check in rightclickoptions on contact in Customer Information Menu********/
function RemoveNegateEntity(name, url) {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
    entityId  = getCookie('AccountID');
    entityType  = getCookie('entityType');
    negativeFlag  = getCookie('Negated');
    ProcessSts=getCookie('ProcessStatus');

   if(checkCookie(entityId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }

   if(checkCookie(negativeFlag)=="InValid"){
        showUserMessage("MSG_SUSPEND","MSG_ACCT");
        return;
    }

	/*Changes for Approval: start*/

    	var RecordSts=getCookie('RecordStatus');
// Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
  if(ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =="null"){         
    	if(RecordSts=="A")
    	{
    	    //servletURL = url + accountID + '&TabName=Suspend Customer';
    	    //Recon of Security Audit Changes From CRM10301BSUPP
    	    servletURL = url + entityId +'&TabName='+MSGJ0145+ '&Operation=UnNegate'+'&entityType='+entityType+'&type=RETAIL';
    	    //Recon of Security Audit Changes From CRM10301BSUPP
	    if(negativeFlag=="N")
	    {
	        showMessage(MSGJ0028);
	    }
    	    else
    	    {
    		//var win = window.open(servletURL, '','height=436,width=900,left=50,top=120,resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');

    	    	/* Tracker: 108382: Changes for centering popup */
    	    	windowAlign();
    	    	//childWindow= window.showModalDialog(servletURL,'','dialogHeight:'+wh+'px; dialogWidth:'+ww+'px; dialogLeft:'+left_x+'px; dialogTop:'+left_y+'px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
		var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');

		/* Tracker: 108382: End of Changes */
		     /*	try{

		    	if (childWindow.opener == null){
		    					 childWindow.opener = window;
		    				   	}
		    	}catch(e){}

		    	 if(childWindow != null)
   			childWindow.open;*/

    	    }
    	}
    	else
			{
			showMessage(MSGJ0031);
    	}

 // Tracker ID - 97668 End of Changes
    	}
    	else
    	{
    	    showMessage(MSGJ0031);

    	}
    	/*Changes for Approval: end*/

}
/*****Function for adding performblacklist in rightclickoptions on customers in Customer Information Menu********/
function performblacklist(name,url) {
//Recon of Security Audit Changes From CRM10301BSUPP
var hashkey=getCookie('HASHKEY');
var fldhashkey=getCookie('FLDHASHKEY');
//Recon of Security Audit Changes From CRM10301BSUPP
/*
 * BEGIN OF CHANGES Fix for 264329
 * No need to check for criteria, this is already hapening in deduppanel
 *
BlackCriteriaFlag2 = getCookie('BlackCriteriaFlag1');

if(BlackCriteriaFlag2 == "N"){
//alert("Criteria not set for within bank");
}*/
/* END OF CHANGES 264329 */
 if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){

         showUserMessage("MSG014","MSG_ACCT");
         return;
     }
     IsTampered = getCookie('IsTampered');

     	if(IsTampered=='Y')
     	{	 showMessage(MSGJ50260);
     		return;
	}

     accountID  = getCookie('AccountID');
     accountKEY = getCookie('AccountKey');
     entityType = getCookie('entityType');
     ProcessSts=getCookie('ProcessStatus');

     if(checkCookie(accountID)=="InValid"){
         showUserMessage("MSG007","MSG_ACCT");
         return;
     }
//Changes for call id 579481
 if(ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =="null"){  
//Recon of Security Audit Changes From CRM10301BSUPP

    window.open(url+accountID+'&accountKey='+accountKEY+'&entityType='+entityType+'&isPopup=Yes&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey,'','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=yes, status=no, toolbar=no,scrollbars');
//Recon of Security Audit Changes From CRM10301BSUPP
 }else {
           showMessage(MSGJ0031);
        }

}
/*****Function for adding performnegative in rightclickoptions on customers in Customer Information Menu********/
function performnegative(name,url) {
//Recon of Security Audit Changes From CRM10301BSUPP

var hashkey=getCookie('HASHKEY');
var fldhashkey=getCookie('FLDHASHKEY');
//Recon of Security Audit Changes From CRM10301BSUPP
/*
 * BEGIN OF CHANGES Fix for 264329
 * No need to check for criteria, this is already hapening in deduppanel
 *
NegCriteriaFlag2 = getCookie('NegCriteriaFlag1');

if(NegCriteriaFlag2 == "N"){
//alert("Criteria not set for within bank");
}*/
/* END OF CHANGES 264329 */
  if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){

         showUserMessage("MSG014","MSG_ACCT");
         return;
     }
     IsTampered = getCookie('IsTampered');

     	if(IsTampered=='Y')
     	{	 showMessage(MSGJ50260);
     		return;
	}

     accountID  = getCookie('AccountID');
     accountKEY = getCookie('AccountKey');
     entityType = getCookie('entityType');
     ProcessSts=getCookie('ProcessStatus');


     if(checkCookie(accountID)=="InValid"){
         showUserMessage("MSG007","MSG_ACCT");
         return;
     }
//Changes for call id 579481
 if(ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =="null"){
//Recon of Security Audit Changes From CRM10301BSUPP

     servletURL=url+accountID+'&accountKey='+accountKEY+'&entityType='+entityType+'&isPopup=Yes&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
//Recon of Security Audit Changes From CRM10301BSUPP
    //window.open(url+accountID+'&accountKey='+accountKEY+'&entityType='+entityType+'&amp;isPopup=Yes','','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=yes, status=no, toolbar=no,scrollbars');

   /* Tracker: 108382: Changes for centering popup */

   windowAlign();
   //childWindow= window.showModalDialog(servletURL,'','dialogHeight:'+wh+'px; dialogWidth:'+ww+'px; dialogLeft:'+left_x+'px; dialogTop:'+left_y+'px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
   var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');

/* Tracker: 108382: End of Changes */
	/*try{

		if (childWindow.opener == null){
						 childWindow.opener = window;
					   	}
	}catch(e){}

	 if(childWindow != null)
   	 childWindow.open; */
 }else {
      showMessage(MSGJ0031);
        }
}
/* CRA10MSC : TRACKER # 90015 : BEGIN OF CHANGES  */

/*****Function for adding View Reason Codes for an entity in rightclickoptions on customers in Customer Information Menu********/

function ViewReasonCodesBlacklist(name, url) {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    entityId  = getCookie('AccountID');
    entityType  = getCookie('entityType');
    blackListFlag  = getCookie('BlackListed');

   if(checkCookie(entityId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
   	    /* Ticket Id 206830 Changes Begin */
   	    showUserMessage(MSGJ80050);
   	    //showUserMessage("MSG007","MSG_ACCT");
   	    /* Ticket Id 206830 Changes End */
            return;
        }

   if(checkCookie(blackListFlag)=="InValid"){
        //showUserMessage("MSG_SUSPEND","MSG_ACCT");
        showMessage(MSGJ0022);
        return;
    }
     /* Changes for ticket 348439 starts */
      if(blackListFlag == 'Y')
    {
    	Operation = "BlackList";
    }
    else
    {
    	Operation = "UnBlackList";
    }

    var RecordSts=getCookie('RecordStatus');

	// Fix for ticket 458386 start
	var hashkey=getBrowserCookie('HASHKEY');
      var fldhashkey=getBrowserCookie('FLDHASHKEY');
        servletURL = url + entityId +'&TabName='+MSGJ0160+'&Operation='+Operation+ '&entityType='+entityType+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
	// Fix for ticket 458386 end
       /* Changes for ticket 348439 ends */
       /* Tracker: 108382: Changes for centering popup */
      	windowAlign();
      	var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');
	/* Tracker: 108382: End of Changes */
}



function ViewReasonCodesNegate(name, url) {


    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    entityId  = getCookie('AccountID');
    entityType  = getCookie('entityType');
	/* Changes for ticket 348439 starts */
	negativeListFlag  = getCookie('Negated');
	/* Changes for ticket 348439 ends */

   if(checkCookie(entityId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
   	    /* Ticket Id 206830 Changes Begin */
  	    showUserMessage(MSGJ80050);
            //showUserMessage("MSG007","MSG_ACCT");
            /* Ticket Id 206830 Changes End */
            return;
        }

   if(checkCookie(negativeListFlag)=="InValid"){
        //showUserMessage("MSG_SUSPEND","MSG_ACCT");
        showMessage(MSGJ0022);
        return;
    }
    /* Changes for ticket 348439 starts */
    if(negativeListFlag == 'Y')
    {
    	Operation = "Negate";
    }
    else
    {
    	Operation = "UnNegate";
    }

        servletURL = url + entityId +'&TabName='+MSGJ0160+'&Operation='+Operation+ '&entityType='+entityType;
       /* Changes for ticket 348439 ends */
      	//var win = window.open(servletURL, '','height=436,width=900,left=50,top=120,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');

     	/* Tracker: 108382: Changes for centering popup */

     	windowAlign();
     	//childWindow= window.showModalDialog(servletURL,'','dialogHeight:'+wh+'px; dialogWidth:'+ww+'px; dialogLeft:'+left_x+'px; dialogTop:'+left_y+'px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
     	var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');

     	/* Tracker: 108382: End of Changes */

     	/*try{

     		if (childWindow.opener == null){
     		   				 childWindow.opener = window;
     		    			   	}
     		}catch(e){}

     	 if(childWindow != null)
   	 childWindow.open;*/

}


function ViewReasonCodesSuspend(name, url) {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    entityId  = getCookie('AccountID');
    entityType  = getCookie('entityType');
	/* Changes for ticket 348439 starts */
    suspendListFlag  = getCookie('Suspended');
	/* Changes for ticket 348439 ends */

   if(checkCookie(entityId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
            /* Ticket Id 206830 Changes Begin */
            showUserMessage(MSGJ80050);
            //showUserMessage("MSG007","MSG_ACCT");
            /* Ticket Id 206830 Changes End */
            return;
        }

   if(checkCookie(suspendListFlag)=="InValid"){
        //showUserMessage("MSG_SUSPEND","MSG_ACCT");
        showMessage(MSGJ0022);
        return;
    }
	/* Changes for ticket 348439 starts */
    if(suspendListFlag == 'Y')
    {
    	Operation = "Suspend";
    }
    else
    {
    	Operation = "UnSuspend";
    }
    // <!--Tracker:108382:Modal Window change-->

        servletURL = url + entityId +'&TabName='+MSGJ0160+'&Operation='+Operation+ '&entityType='+entityType;
		/* Changes for ticket 348439 ends */

      	//var win = window.open(servletURL, '','height=436,width=900,left=50,top=120,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');


  	/* Tracker: 108382: Changes for centering popup */
  	windowAlign();
  	//childWindow= window.showModalDialog(servletURL,'','dialogHeight:'+wh+'px; dialogWidth:'+ww+'px; dialogLeft:'+left_x+'px; dialogTop:'+left_y+'px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
        var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');

       	/* Tracker: 108382: End of Changes */
       	/*try{

       		if (childWindow.opener == null){
       		   				 childWindow.opener = window;
       		    			   	}
       		}catch(e){}

       	 if(childWindow != null)
   	 childWindow.open;*/

    // <!--Tracker:108382:End of Changes-->
}

/* CRA10MSC : TRACKER # 90015 : END OF CHANGES  */
/* CRA10MSC : TRACKER # 90015 : START OF CHANGES  */

function CIFOperationsAgainstExtDB(name,url)
{


 if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }

    var entityId  = getCookie('AccountID');
    var entityType  = getCookie('entityType');

    ////alert('entityId:::'+entityId+" :::entityType:::"+entityType);

    if(checkCookie(entityId)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }

       if(checkCookie(entityType)=="InValid"){
                showUserMessage("MSG007","MSG_ACCT");
                return;
        }



    var servletURL=url+entityId+'&EntityType='+entityType+'&IsBatch=No';


 // window.open(servletURL, '','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars');

   /* Tracker: 108382: Changes for centering popup */

    windowAlign();



    //childWindow= window.showModalDialog(servletURL,'','dialogHeight:'+wh+'px; dialogWidth:'+ww+'px; dialogLeft:'+left_x+'px; dialogTop:'+left_y+'px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
     var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');


     /* Tracker: 108382: End of Changes */
     /*try{

     	if (childWindow.opener == null){
     						childWindow.opener = window;
     				 }
     	 }catch(e){}

     	 if(childWindow != null)
     	 childWindow.open;*/

 }
/* CRA10MSC : TRACKER # 90015 : END OF CHANGES  */

/* Functions to get popup commented
function getTitle()
{
    try
    {
        var topLevel = parent;
        var count = 0;
        while ( topLevel != null && count < 10)
        {
            count = count + 1;
            if ( topLevel.parent == null )
            {
                break;
            }
            topLevel = topLevel.parent;
        }
        if ( topLevel != null )
        {
            return topLevel.document.title;
        }
        else
        {
            return " ";
        }
    }
    catch ( e )
    {
        return "";
    }
}
function showNewWindow(url){
loadURL = url;
closeURL = "../common/html/CloseOption.html";
Ornaments = 'directories=No, height=600, left=25, top=100, width=950, location=no, menubar=no, resizable=yes, status=no, toolbar=no,scrollbars';
writeToNewWindow();
}

*/

//<!--changes begin for ticket 211172 -->
function ShowAuditTrail(wndName,auditUrl)
{
   /*Begin of changes for tracker 131243 by sumeet gandhok - BANKID -*/
     bank_id = checkBankPrivilege();
     if(bank_id!=null && (ScreenName=="RetSearch"||ScreenName=="RetEdit"||ScreenName=="CorpEdit"||ScreenName=="CorpSearch")){
        showMessage(MSGJ50789);
     }
     else{
   /*End of changes for tracker 131243 by sumeet gandhok - BANKID -*/

    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false") {
               showUserMessage("MSG014","MSG_CUSTOMER");
            return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
    AccountID = getCookie('AccountID');
    var AccountKey = getCookie('AccountKey');
    	/* Changes for tracker id 178956 start */
	/* TrackerID:177869,Changes Begin */
	var RecordSts = getCookie('RecordStatus');
	/* TrackerID:177869,Changes End */
    	/* Changes for tracker id 178956 end */
   if(checkCookie(AccountID)=="InValid"){
        return;
        }
        /* Changes for tracker id 178956 start */
        /* TrackerID:177869,Changes Begin */
       if(RecordSts=="U"){
	     AccountID=fnGetAccMod_ID(AccountKey);
	     auditUrl=auditUrl+'&BOName=AccountModBO&BOID='+AccountID;
       }
	else{

   	     auditUrl=auditUrl+'&BOName=AccountBO&BOID='+AccountID;
       }
     /* TrackerID:177869,Changes End */
//Recon of Security Audit Changes From CRM10301BSUPP
    var hashkey=getBrowserCookie('HASHKEY');
    var fldhashkey=getBrowserCookie('FLDHASHKEY');
   auditUrl+='&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
//Recon of Security Audit Changes From CRM10301BSUPP
     /* Changes for tracker id 178956 end */
    if (checkCookie(AccountID) != 'InValid')
        auditUrl += '&Header=' + MSG_AU0081 + '~' + escape(AccountKey);
    window.open(auditUrl,'','height=436,width=900,left=50,top=120,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');
}

}
<!--changes end for ticket 211172 -->



       function createActivity(name,url){

        /*Begin of changes for tracker 131243 by sumeet gandhok - BANKID -*/
	   bank_id = checkBankPrivilege();
	   if(bank_id!=null && (ScreenName=="RetSearch"||ScreenName=="RetEdit"||ScreenName=="CorpEdit"||ScreenName=="CorpSearch")){
	      	showMessage(MSGJ50789);
	   }
   	   else{
       /*End of changes for tracker 131243 by sumeet gandhok - BANKID -*/

                   if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false") {
                                 showUserMessage("MSG014","MSG_NC");
                              return;
           }
              accountURL= getCookie('accountURL');

               AccountID = getCookie('AccountID');
               processId= getCookie('processID');
               status1= getCookie('ProcessStatus');
               if(AccountID=="")
               {
                   showMessage(MSGJ0318);
                   return;
               }
               if(status1=='error'||status1=='ERROR'||status1=='Error')
               {
                   url = url + "?objectType=Account&objectId=" + AccountID + "&accountURL="+accountURL+"&TabName="+name+"&processId="+processId+"&status="+status1;
                   newWindowcreateActivity = window.open(url, 'CreateActivity', 'height=500,width=700,left=100,top=100,resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');
                   newWindowcreateActivity.focus();

               }
               else
               {
                   showMessage("Activity can be linked only to an errored entity");

                   return;
               }
              }

           }
    /* CIF Retail Corp Sync up End of changes */



/* QED Changes: START */
function EditAddress(name,url){
	alert("Edit xx");
//Recon of Security Audit Changes From CRM10301BSUPP

	var hashkey=getCookie('HASHKEY');
	var fldhashkey=getCookie('FLDHASHKEY');
//Recon of Security Audit Changes From CRM10301BSUPP
/*Begin of changes for tracker 131243 by sumeet gandhok - BANKID -*/

alert("Edit 3");

bank_id = checkBankPrivilege();
if(bank_id!=null && (ScreenName=="RetSearch"||ScreenName=="RetEdit"||ScreenName=="CorpEdit"||ScreenName=="CorpSearch")){
   showMessage(MSGJ50789);
}
else{
/*End of changes for tracker 131243 by sumeet gandhok - BANKID -*/

   if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		 return;
	}
    expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));

    accountID  = getCookie('AccountID');
    var RecordSts = getCookie('RecordStatus');
    var ProcessSts=getCookie('ProcessStatus');
    /* changes for ticket 305918 start */
    var blacklisted = getCookie("BlackListed");
    var suspended = getCookie("Suspended");
    var negated = getCookie("Negated");
    /* changes for ticket 305918 end */

    if(checkCookie(accountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

//Changes for call id 579481
    if(RecordSts=='A' && (ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =="null")){
    /*Changes done by kanika for Cif Deceased start*/
    var custStatus  =getCookie('custStatus');
    if(custStatus == 'DCSED'){
    	if(!showConfirmMessage(MSGJ51883)){
    		return;
    	}
    }  
    /*Changes done by kanika for Cif Deceased ends*/
    /* changes for ticket 305918 start */
//Recon of Security Audit Changes From CRM10301BSUPP
    servletURL = url + accountID+'&chkBSN=true'+'&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
//Recon of Security Audit Changes From CRM10301BSUPP
    /* changes for ticket 305918 end */
     //window.location.href=servletURL;
   window.open(servletURL,'','directories=No, height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=yes, status=no, toolbar=no');
    } else {
    //changes for call is 338600 starts
    	var accountdetails = getStatus(accountID);
            var valList = new Array();
            valList = accountdetails.split("|");
            var verificationValue = valList[0];
            var RecordStatus = valList[1];
            var userName = valList[2];
    	
		 if(((verificationValue!=null)||(verificationValue!=='')) && RecordStatus=='D')
		{
			alert(''+userName+' has modified this entity and it is in Draft status.');			    		
		}
		else if(((verificationValue!=null)||(verificationValue!=='')) && RecordStatus=='R')
		{
		alert(''+userName+' has modified this entity and it is in Rejected status.');			    		

    		}
        	else
        	{
      		 showMessage(MSGJ0029);
   		}
       //changes for call id 338600 ends
    }
 }
}
function EditPhoneEmail(name,url)
{
	alert("Edit hfgyu");
//Recon of Security Audit Changes From CRM10301BSUPP

	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');
//Recon of Security Audit Changes From CRM10301BSUPP
/*Begin of changes for tracker 131243 by sumeet gandhok - BANKID -*/

alert("Edit 4");

  bank_id = checkBankPrivilege();
  if(bank_id!=null && (ScreenName=="RetSearch"||ScreenName=="RetEdit"||ScreenName=="CorpEdit"||ScreenName=="CorpSearch")){
     showMessage(MSGJ50789);
  }
  else{
/*End of changes for tracker 131243 by sumeet gandhok - BANKID -*/
   if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		 return;
	}
    expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));

    accountID  = getCookie('AccountID');
    var RecordSts = getCookie('RecordStatus');
     var ProcessSts=getCookie('ProcessStatus');
    /* changes for ticket 305918 start */
    var blacklisted = getCookie("BlackListed");
    var suspended = getCookie("Suspended");
    var negated = getCookie("Negated");
    /* changes for ticket 305918 end */

    if(checkCookie(accountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }
//Changes for call id 579481
    if(RecordSts=='A' && (ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =="null")){

    /*Changes done by kanika for Cif Deceased starts */
    var custStatus  =getCookie('custStatus');
    if(custStatus == 'DCSED'){
    	if(!showConfirmMessage(MSGJ51883)){
    		return;
    	}
    }  
    /*Changes done by kanika for Cif Deceased ends */
    /* changes for ticket 305918 start */
//Recon of Security Audit Changes From CRM10301BSUPP

    servletURL = url + accountID+'&chkBSN=true'+'&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
//Recon of Security Audit Changes From CRM10301BSUPP
    /* changes for ticket 305918 end */
    //window.location.href=servletURL;
  window.open(servletURL,'','directories=No, height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=yes, status=no, toolbar=no');

    } else {
       //changes for call id 338600 starts
   	var accountdetails = getStatus(accountID);
           var valList = new Array();
           valList = accountdetails.split("|");
           var verificationValue = valList[0];
           var RecordStatus = valList[1];
           var userName = valList[2];
   	
		 if(((verificationValue!=null)||(verificationValue!=='')) && RecordStatus=='D')
		{
			alert(''+userName+' has modified this entity and it is in Draft status.');			    		
		}
		else if(((verificationValue!=null)||(verificationValue!=='')) && RecordStatus=='R')
		{
		alert(''+userName+' has modified this entity and it is in Rejected status.');			    		
      
    		}
       		else
       		{
      showMessage(MSGJ0029);
   }
       //changes for call id 338600 ends
    }
}
}
function EditName(name,url)
{
	alert("Edit 1vnmvmn");
//Recon of Security Audit Changes From CRM10301BSUPP

	var hashkey=getCookie('HASHKEY');
	var fldhashkey=getCookie('FLDHASHKEY');
//Recon of Security Audit Changes From CRM10301BSUPP
  /*Begin of changes for tracker 131243 by sumeet gandhok - BANKID -*/
  alert("Edit 5");
    bank_id = checkBankPrivilege();
    if(bank_id!=null && (ScreenName=="RetSearch"||ScreenName=="RetEdit"||ScreenName=="CorpEdit"||ScreenName=="CorpSearch")){
       	showMessage(MSGJ50789);
    }
    else{
  /*End of changes for tracker 131243 by sumeet gandhok - BANKID -*/
   if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		 return;
	}

    expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));

    accountID  = getCookie('AccountID');
    var RecordSts = getCookie('RecordStatus');
     var ProcessSts=getCookie('ProcessStatus');
   /* changes for ticket 305918 start */
    var blacklisted = getCookie("BlackListed");
    var suspended = getCookie("Suspended");
    var negated = getCookie("Negated");
    /* changes for ticket 305918 end */
    if(checkCookie(accountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }
//Changes for call id 579481
    if(RecordSts=='A' && (ProcessSts =='' || ProcessSts =='CLOSED' || ProcessSts =='Closed' || ProcessSts ==null || ProcessSts =="null")){

    /*Changes done by kanika for Cif Deceased starts */
    var custStatus  =getCookie('custStatus');
    if(custStatus == 'DCSED'){
    	if(!showConfirmMessage(MSGJ51883)){
    		return;
    	}
    }
    /*Changes done by kanika for Cif Deceased ends */
    /* changes for ticket 305918 start */
//Recon of Security Audit Changes From CRM10301BSUPP

    servletURL = url + accountID+'&chkBSN=true'+'&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
//Recon of Security Audit Changes From CRM10301BSUPP
    /* changes for ticket 305918 end */
   //window.location.href=servletURL;
   window.open(servletURL,'','directories=No, height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=yes, status=no, toolbar=no');
    } else {
       //changes for call id 338600 starts
	var accountdetails = getStatus(accountID);
        var valList = new Array();
        valList = accountdetails.split("|");
        var verificationValue = valList[0];
        var RecordStatus = valList[1];
        var userName = valList[2];
	
  		 if(((verificationValue!=null)||(verificationValue!=='')) && RecordStatus=='D')
       		{
   			alert(''+userName+' has modified this entity and it is in Draft status.');			    		
    		}
    		else if(((verificationValue!=null)||(verificationValue!=='')) && RecordStatus=='R')
    		{
			alert(''+userName+' has modified this entity and it is in Rejected status.');			    		

    		}
    		else
    		{
   showMessage(MSGJ0029);
   }
       //changes for call id 338600 ends
    }
   }

   /*End of changes for tracker 131243 by sumeet gandhok - BANKID -*/
}
/* QED Changes: END */

/* Changes for tracker id 178956 start */
/* TrackerID:177869,Changes Begin */
/* Getting Accountid from accounts_mod table for displaying audittrail records in editentity screen*/

function fnGetAccMod_ID(AccountKey) {

    var s_xmlHttp = "";
    if (window.XMLHttpRequest) {
         s_xmlHttp=new XMLHttpRequest();
    } else if (window.ActiveXObject) {
 	s_xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    var strURL = '../servlet/com.infy.cis.ui.common.MainAuditUserDetailsForm?OrgKey=' + AccountKey;
    s_xmlHttp.open("GET",strURL,false);
    s_xmlHttp.send();
    var AccountID = "";

    if (s_xmlHttp.readyState == 4) {
    AccountID = s_xmlHttp.responseText;
    }

    return AccountID;
}
/* TrackerID:177869,Changes End */
/* Changes for tracker id 178956 end */












