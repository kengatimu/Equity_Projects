document.write('<script language="javascript" src="'+applPath+'/common/js/SSOUtils.js"></script>');
document.write('<script language=javascript src="'+applPath+'/corpcif/js/Message_corpcif_'+finaclecrmlocale+'.js">'+'<\/script>');

/*Begin of changes for tracker 131243 by sumeet gandhok - BANKID - */
var bank_id=null;
/*End of changes for tracker 131243 by sumeet gandhok - BANKID - */
var expirationdate = new Date ();
expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));

var corpName  = "";
var DOI	      = "";
var DOB	      = "";
var corpId    = "";
var cifId     = "";
var corpKey   = "";
var Suspended     = "";
var BlackListed   = "";
var RepBlackListed = "";
var Negated       = "";
var RepNegated    = "";
var entityType    = "";
var lastName	  = "";
var coreCustId	  = "";
var proStatus	  = "";
//changes for ticket id-690515 begin
var StrIsCoexistence ="";
//changes for ticket id-690515 ends
//Field Rationalization changes start
var tfFlag ="";
//Field Rationalization changes end

setCookie("corpName", "", expirationdate);
setCookie("DOI", "", expirationdate);
setCookie("DOB", "", expirationdate);
setCookie("corpId", "", expirationdate);
setCookie("cifId", "", expirationdate);
setCookie("corpKey", "", expirationdate);
setCookie("Suspended", "", expirationdate);
setCookie("BlackListed", "", expirationdate);
setCookie("RepBlackListed", "", expirationdate);
setCookie("Negated", "", expirationdate);
setCookie("RepNegated", "", expirationdate);
setCookie("entityType", "", expirationdate);
setCookie("lastName", "", expirationdate);
setCookie("coreCustId", "", expirationdate);
setCookie("proStatus", "", expirationdate);


function identifyme(){
	
	 alert("Edit 1");
 	var selectedRow ;
 	var RecordSet;
 	var item = null;


	if(event.srcElement.parentElement.id == null || event.srcElement.parentElement.id == '') {

            item = event.srcElement.parentElement.parentElement;
            if (item.id == null || item.id == '')
				item = item.parentElement;
	 } else {

             item = event.srcElement.parentElement;
        }
 // vasanth's changes start
 //Changes starts for TrackerID:236741
// if(ScreenName == "Screen"){
if(ScreenName == "CorpEdit"){
//Changes ends for TrackerID:236741

 	IsDummy      = item.getAttribute('CorporateBO.IsDummy');
	TabValidator      = item.getAttribute('CorporateBO.TabValidator');

 		var z = document.getElementsByTagName("DIV");
 		for (var i=0; i <z.length; i++) {

 			if((IsDummy == "Y")&& (TabValidator.indexOf('Corp_Customer_GE=Y') == "-1")) {
 				if(z[i].id == "ie5menu1"){
 				document.getElementById('ie5menu' + 1).disabled = true;
 				document.getElementById('ie5menu' + 2).disabled = false;
 				//Changes for call id 333209 STARTS
 				document.getElementById('ie5menu' + 3).disabled = false;
 				//Changes for call id 333209 ENDS
 				//Changes for tracker id 356332 STARTS
 				//document.getElementById('ie5menu' + 4).disabled = true;
 				//Changes for tracker id 356332 ENDS

 				}
 			}else if((IsDummy == "Y") && (TabValidator.indexOf('Corp_Customer_GE=Y') != "-1")){
 			if(z[i].id == "ie5menu1"){
 					document.getElementById('ie5menu' + 1).disabled = true;
 					document.getElementById('ie5menu' + 2).disabled = false;
 					document.getElementById('ie5menu' + 3).disabled = true;
 					document.getElementById('ie5menu' + 4).disabled = false;
					}
				}
 			else{
							//chnages for TOL ID 586220 starts 
                                   if(document.getElementsByName('ie5menu' + 1)[0]) 

 			    document.getElementById('ie5menu' + 1).disabled = false;
				 if(document.getElementsByName('ie5menu' + 2)[0])
//Recon of Call id :395366 changes start for 395879			    
if(z[i].id == "ie5menu2")
				document.getElementById('ie5menu' + 2).disabled = false;
				if(document.getElementsByName('ie5menu' + 3)[0])
				if(z[i].id == "ie5menu3")
				document.getElementById('ie5menu' + 3).disabled = false;
				  //chnages for TOL ID 586220 ends 
//Recon of Call id :395366 changes end 	 for 395879
//Recon MELC changes to Baseline
			//Commented By Ankitt Malhotra & Amit Malhotra for the undefined object Tracker ID :122920
				//document.getElementById('ie5menu' + 4).disabled = false;
//changes end
 			}
 		}
 }
// vasanth's changes end

 		corpName	= item.getAttribute('CorporateBO.corporate_Name');
		DOI		= item.getAttribute('CorporateBO.date_Of_Incorporation');
		DOB		= item.getAttribute('CorporateRepBO.dob');
		corpId		= item.getAttribute('CorporateBO.corp_ID');
		corpRepId	= item.getAttribute('CorporateRepBO.corp_Rep_ID');
		cifId		= item.getAttribute('CorporateBO.corp_Key');
		cifRepId	= item.getAttribute('CorporateRepBO.corp_Key');
		corpKey		= item.getAttribute('CorporateBO.corp_Key');
		Suspended	= item.getAttribute('CorporateBO.suspend_Flag');
		BlackListed	= item.getAttribute('CorporateBO.blacklist_Flag');
		RepBlackListed	= item.getAttribute('CorporateRepBO.blacklist_Flag');
		Negated		= item.getAttribute('CorporateBO.negative_Flag');
		RepNegated	= item.getAttribute('CorporateRepBO.negative_Flag');
		entityType      = item.getAttribute('CorporateBO.entity_Type');
		lastName        = item.getAttribute('CorporateRepBO.last_Name');
		coreCustId      = item.getAttribute('CorporateBO.Core_Cust_ID');
               	//Tracker 96762 changes
                record          = item.getAttribute('CorporateBO.record_Status');

		IsTampered      = item.getAttribute('CorporateBO.IsTampered');

		/*  Tracker ID : 90197 Begin of Changes for attribute masking*/
  		AccessOwnerGroup = item.getAttribute('CorporateBO.accessOwnerGroup');
		setCookie('AccessOwnerGroup', AccessOwnerGroup, expirationdate);
		/* Tracker ID : 90197 End of Changes */
		//Field Rationalization changes
		tfFlag	     = item.getAttribute('CorporateBO.trade_Services_Availed');
		setCookie('tfFlag', tfFlag, expirationdate);
		//Field Rationalization changes

		// Tracker ID - 96762 Begin of Changes
		proStatus	= item.getAttribute('CorporateBO.ProcessStatus');
		// Tracker ID - 96762 End of Changes

		// vasanth's changes start
				setCookie('doi', DOI, expirationdate);
		// vasanth's changes end

		setCookie('corpName', corpName, expirationdate);
		setCookie('corpId', corpId, expirationdate);
		setCookie('corpRepId', corpRepId, expirationdate);
		setCookie('corpKey', corpKey, expirationdate);
		setCookie('cifId', cifId, expirationdate);
		setCookie('cifRepId', cifRepId, expirationdate);
		setCookie('entityType', entityType, expirationdate);
		setCookie('BlackListed', BlackListed, expirationdate);
		setCookie('RepBlackListed', RepBlackListed, expirationdate);
		setCookie('Suspended', Suspended, expirationdate);
		setCookie('Negated', Negated, expirationdate);

		setCookie('RepNegated', RepNegated, expirationdate);
		setCookie('lastName', lastName, expirationdate);
		setCookie('coreCustId', coreCustId, expirationdate);
                setCookie('Record', record, expirationdate);
                setCookie('ProStatus', proStatus, expirationdate);
		setCookie('IsTampered', IsTampered, expirationdate);
//Recon MELC changes to Baseline
	   //113066 Amit Malhotra
		setCookie('StrLoggegInBankId1', StrLoggegInBankId1, expirationdate);
		setCookie('StrSearchedBankId1', StrSearchedBankId1, expirationdate);
		setCookie('StrCeTarget1', StrCeTarget1, expirationdate);
		setCookie('StrCeCopySusTarget1', StrCeCopySusTarget1, expirationdate);
		setCookie('StrCeCopyBlTarget1', StrCeCopyBlTarget1, expirationdate);
		setCookie('StrCeCopyNlTarget1', StrCeCopyNlTarget1, expirationdate);
		setCookie('StrCeSource1', StrCeSource1, expirationdate);
		setCookie('StrCeCopySusSource1', StrCeCopySusSource1, expirationdate);
		setCookie('StrCeCopyBlSource1', StrCeCopyBlSource1, expirationdate);
		setCookie('StrCeCopyNlSource1', StrCeCopyNlSource1, expirationdate);
	<!--Changes for Call id 381650,recon for call id 378232 starts-->
		setCookie('StrIsCoexistence', StrIsCoexistence, expirationdate);
	<!--Changes for Call id 381650,recon for call id 378232 ends-->

           //113066 Amit Malhotra
           setCookie('BlackCriteriaFlag1', BlackCriteriaFlag1, expirationdate);
	   setCookie('DedupCriteriaFlag1', DedupCriteriaFlag1, expirationdate);
	   setCookie('NegCriteriaFlag1', NegCriteriaFlag1, expirationdate);
	   /*Recon for Security Audit Changes from CRM10301BSUPP*/
		 secureKey=item.getAttribute('hashkey');
		 secureField=item.getAttribute('fieldHashkey1');
		 deleteCookie('HASHKEY');
		 deleteCookie('FLDHASHKEY');
		 setCookie('HASHKEY', secureKey, expirationdate);
		 setCookie('FLDHASHKEY', secureField, expirationdate);
	/*Recon for Security Audit Changes from CRM10301BSUPP*/
//Changes end
 }

function checkCookie(x){
    if(x!=0 &&x != null && x != 'null' && x != "" && x!='undefined') {
        return "Valid" ;
    }else{
        return "InValid";
    }
}

//right click menu changes begin

//Common function for editing details of respective tabs
function editDetails(name, url) {
	<!--Changes for Call id 381650,recon for call id 378232 starts-->
var isCoexistence=getCookie('StrIsCoexistence');
		<!--Changes for Call id 381650,recon for call id 378232 ends-->
	<!--Changes for Call id 393639, recon of 392565 starts-->
	
	 alert("Edit 2");
	
 if(entityType=='Non Customer' || entityType=='NonCustomer'){
   
   if(name.indexOf("General") !=-1)
   url='../servlet/com.infy.cis.ui.corpcif.CorpNonCustomerDetWizard?menuItemId=1542&ScreenID=RCL1181542&loadTab=General&operationType=EditEntity';
   else if(name.indexOf("Trade") !=-1 )
    url='../servlet/com.infy.cis.ui.corpcif.CorpNonCustomerDetWizard?menuItemId=1543&ScreenID=RCL1181543&loadTab=TradeFinance&operationType=EditEntity';
   
   }  
<!--Changes for Call id  393639, recon of 392565 ends-->
    /*Begin of changes for tracker 131243  by sumeet gandhok - BANKID - */
     bank_id = checkBankPrivilege();
     if(bank_id!=null){
     	showMessage(MSGJ50789);
     }
     else{

    /*End of changes for tracker 131243  by sumeet gandhok - BANKID - */
        var RecordSts=getCookie('Record');
        var ProStatus=getCookie('ProStatus');
	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
	showUserMessage("MSG014","MSG_ACCT");
	return;
	}
	IsTampered = getCookie('IsTampered');

		if(IsTampered=='Y')
		{ 	showMessage(MSGJ50260);
			return;
		}
	expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));

	// Tracker ID - 90197 Begin of Changes for attribute masking
	AccessOwnerGroup = getCookie('AccessOwnerGroup');
        //  Tracker ID - 90197 End of Changes

	corpId  = getCookie('corpId');
	corpKey  = getCookie('corpKey');
	corpName  = getCookie('corpName');
	entityType = getCookie('entityType');
	coreCustId = getCookie('coreCustId');
	//Recon of RBS FS : 716394
	//changes for 562462 starts
	 var strScreen=ScreenName.toUpperCase();  
  /*if(entityType=='Non Customer' && strScreen=='CORPEDIT' ){
url='../servlet/com.infy.cis.ui.corpcif.CorpNonCustomerDetWizard?menuItemId=700716&IsReadOnly=N';
}*/
//changes for 562462 ends
//Recon of RBS FS : 716394

	//Recon for Security Audit Changes from CRM10301BSUPP
	var hashkey=getCookie('HASHKEY');
	var fldhashkey=getCookie('FLDHASHKEY');
	//Recon for Security Audit Changes from CRM10301BSUPP
	if(checkCookie(corpId)=="InValid"){
	showUserMessage("MSG007","MSG_ACCT");
	return;

	}
	 /*ticket ID: 320689 Changes Begin */
	if(entityType=='Non Customer'){
		if(name.indexOf("Relation")!=-1){

			   showUserMessage("MSGJ51658","MSGJ51659");
			   return;
				   }
	   else if(name.indexOf("Preferences")!=-1){
			   showUserMessage("MSGJ51658","MSGJ51660");
			   return;
				   }
	   else if(name.indexOf("Financial")!=-1){
			   showUserMessage("MSGJ51658","MSGJ51661");
			   return;
			   }
		//Changes for call id 401212 and recon of call id 398154 starts
		else if(name.indexOf("Quick")!=-1){
				   showUserMessage("MSGJ51658","MSGJ63631");
				   return;
			   }
		//Changes for call id 401212 and recon of call id 398154 ends

	}
	//Changes for ticket id: 690091 starts
	if(entityType=='Prospect'){
			 if(name.indexOf("Quick")!=-1){
			showUserMessage("MSGJ63658","MSGJ63631");
			return;
				   }
	
	}
	//Changes for ticket id: 690091 ends
	 /*ticket ID: 320689 Changes End */
	//Tracker 96762 changes
	//Tracker 105361 begin of changes
//Changes for call id 579481
        if(RecordSts=='A'&& (ProStatus =='' || ProStatus !='Open' || ProStatus ==null || ProStatus =="null")){
	//Tracker 105361 end of changes
	//Field Rationalization changes
	var tfFlag = getCookie("tfFlag");
	if(tfFlag != 'Y' && (url.indexOf("../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard") != -1) && (url.indexOf("loadTab=TradeFinance")!= -1) && (url.indexOf("operationType=EditEntity")!= -1))
	{
	showMessage(MSGJ50276);
	return;
	}
	//Field Rationalization changes

	var fromEdit = "Y";
	//modified for 629798
	var edit= "Edit";
	// vasanth's changes start

	var blacklisted = getCookie("BlackListed");
	var suspended = getCookie("Suspended");
	var negated = getCookie("Negated");
        /* Tracker ID - 159549 Changes Starts */
        //10.2 Fix Tracker 188773
        /* Change for ticket 321682 start */
      //modified for 629798
	servletURL = url + '&corpId='+corpId + '&entityType='+entityType+ '&fromEdit='+fromEdit+ '&edit='+edit+'&corpKey='+escape(corpKey)+ '&coreCustID='+escape(coreCustId)+ '&fetchFrom=Main';
	servletURL = url + '&corpId='+corpId + '&entityType='+entityType+ '&fromEdit='+fromEdit+ '&edit='+edit+'&corpKey='+escape(corpKey)+ '&coreCustID='+escape(coreCustId)+ '&fetchFrom=Main'+ '&AccessOwnerGroup='+AccessOwnerGroup;
	/* Change for ticket 321682 end */
	/*Changes for call id 421769 starts*/
	servletURL = servletURL + '&corpName='+corpName;
	/*Changes for call id 421769 ends*/
servletURL = servletURL + '&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&chkBSN=true';
        /* Tracker ID - 159549 Changes Ends */
// vasanth's changes start
	var doi = getCookie('doi');
	servletURL = servletURL + '&doi=' +doi;
// vasanth's changes end

     // window.location.href=servletURL;
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
}
  else {
              //changes for call id 338600 starts
	      var accountdetails = getStatus(corpId);
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
	         showMessage(MSGJ0385);
	         }

   //changes for call id 338600 ends
    }
}
}



function showAuditTrail(wndName,auditUrl)
{
    /*Begin of changes for tracker 131243  by sumeet gandhok - BANKID - */
      bank_id = checkBankPrivilege();
      if(bank_id!=null){
           showMessage(MSGJ50789);
      }
     else{
    /*End of changes for tracker 131243  by sumeet gandhok - BANKID - */

    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false") {
               showUserMessage("MSG014","MSG_CUSTOMER");
            return;
    }
    IsTampered = getCookie('IsTampered');

    		if(IsTampered=='Y')
    		{ 	showMessage(MSGJ50260);
    			return;
		}
		//changes for tracker 387240 begin
		if(ScreenName == "CorpEdit"){
			corp_ID = getCookie('corpId');
			corpKey = getCookie('corpKey');
		}
		else{
			corp_ID = getCookie('CorpID');
			 corpKey = getCookie('CorpKey');
		}
		//changes for tracker 387240 ends
    	/* Changes for tracker id 178956 start */
	/* TrackerID:177869,Changes Begin */
	var RecordSts=getCookie('Record');
	/* TrackerID:177869,Changes End */
	/* Changes for tracker id 178956 end */
	/* Changes for tracker id 384820 */

    if(checkCookie(corp_ID)=="InValid"){
    	corp_ID = getCookie('corpId');
    		if(checkCookie(corp_ID)=="InValid"){
        	return;
        	}
	}
    /* Changes for tracker id 178956 start */
    /* TrackerID:177869,Changes Begin */
    if(RecordSts=="U"){
            corp_ID=fnGetCorp_Mod_ID(corpKey);
            auditUrl=auditUrl+'&BOName=CorporateModBO&BOID='+corp_ID;
        }
    else{
    	auditUrl=auditUrl+'&BOName=CorporateBO&BOID='+corp_ID;
        }
    /* TrackerID:177869,Changes End */
    /* Changes for tracker id 178956 end */


    if (checkCookie(corp_ID) != 'InValid')
        auditUrl += '&Header='+MSG_AU0001+'~'+escape(corpKey);

    window.open(auditUrl,'','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
}
}

function convToCust(name, url) {
	<!--Changes for Call id 381650,recon for call id 378232 starts-->
var isCoexistence=getCookie('StrIsCoexistence');
	<!--Changes for Call id 381650,recon for call id 378232 ends-->
	//changes for 10.2.14 Finlite CoExistence start
	if((isCoexistence != null && isCoexistence != "") && isCoexistence == "true")
	{
		showMessage(MSGJ63248);
	}
	else
	{
	//changes for 10.2.14 Finlite CoExistence end
   /*Begin of changes for tracker 131243  by sumeet gandhok - BANKID - */
     bank_id = checkBankPrivilege();
     if(bank_id!=null){
        showMessage(MSGJ50789);
     }
     else{
   /*End of changes for tracker 131243  by sumeet gandhok - BANKID - */
	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
	showUserMessage("MSG014","MSG_ACCT");
	return;
	}
	IsTampered = getCookie('IsTampered');

	if(IsTampered=='Y')
	{ 	showMessage(MSGJ50260);
		return;
	}
	expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));
        /*  Checksum security recon changes from 10.3 SUPP start */
	      	var hashkey=getCookie('HASHKEY');
	      	var fldhashkey=getCookie('FLDHASHKEY');
      /*  Checksum security recon changes from 10.3 SUPP end */
	corpId  = getCookie('corpId');
	corpKey  = getCookie('corpKey');
	corpName  = getCookie('corpName');
	entityType = getCookie('entityType');

	//ticket 283927

	BlackListed = getCookie('BlackListed');
	Negated = getCookie('Negated');
	if(BlackListed=='Y' && blacklistedIssue =='Y')
	{ 	showMessage(MSGH50070);
			return;
	}

	if(Negated=='Y' && negatedIssue =='Y')
	{ 	showMessage(MSGH50071);
			return;
	}

	//ticket 283927
	if(entityType == 'Non Customer')
	  entityType = "NonCustomer";

	coreCustId = getCookie('coreCustId');
	if(checkCookie(corpId)=="InValid"){
	showUserMessage("MSG007","MSG_ACCT");
	return;

	}

	/*Tracker 103938 changes BEGIN*/
	//servletURL = url + '&corpId='+corpId + '&entityType=Customer&fetchFrom=Main&convToCust=Y&corpKey='+corpKey+ '&corpName='+corpName+'&coreCustId='+coreCustId+'&operationType=EditEntity';
	//window.open(servletURL,'','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
	var RecordSts=getCookie('Record');
	ProStatus=getCookie('ProStatus');
	//Changes for call id 579481
	 if(RecordSts=='A'&& (ProStatus =='' || ProStatus !='Open' || ProStatus ==null || ProStatus =="null")){
	 	//Licensing changes starts
	 	/* Change for ticket 321682 start */
	 	//Checksum IUT changes
		//var fServletURL = url+"&isPopup=Yes&corpID="+corpId+"&corpKey="+escape(corpKey)+"&AccessOwnerGroup="+AccessOwnerGroup+"&CIFType=C&ScreenID="+ aScreenID+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
		//  Checksum security fix start
		var servletURL  = url+"&isPopup=Yes&corpId="+corpId+"&corpKey="+escape(corpKey)+"&AccessOwnerGroup="+AccessOwnerGroup+"&CIFType=C&SECUREHKEY="+hashkey+"&FLDHASHKEY="+fldhashkey+"&convToCust=Y"+"&convertFlag=Yes&PrevEntityType="+entityType+"&operationType=EditEntity&coreCustId="+coreCustId+"&entityType=Customer&fetchFrom=Main";
		//var servletURL = url+"&isPopup=Yes&corpID="+corpId+"&corpKey="+escape(corpKey)+"&AccessOwnerGroup="+AccessOwnerGroup+"&CIFType=C";
		//  Checksum security fix end
		/* Change for ticket 321682 end */
		//Licensing changes ends
		window.open(servletURL,'','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
	}else{
        	showMessage(MSGJ0385);
	}
	/*Tracker 103938 changes BEGIN*/
     }
   }
}


function editEvent(a,aScreenID,constURL){

   /*Begin of changes for tracker 131243  by sumeet gandhok - BANKID - */
    alert("Edit 3");
   bank_id = checkBankPrivilege();
   if(bank_id!=null && (ScreenName=="RetSearch"||ScreenName=="RetEdit"||ScreenName=="CorpEdit"||ScreenName=="CorpSearch")){
        showMessage(MSGJ50789);
   }
   else{
   /*End of changes for tracker 131243  by sumeet gandhok - BANKID - */

      // Tracker ID - 90197 Begin of Changes for attribute masking
      AccessOwnerGroup = getCookie('AccessOwnerGroup');
      //  Tracker ID - 90197 End of Changes



      corpID = getCookie('corpId');

      corpKey = getCookie('corpKey');
       var blacklisted = getCookie("BlackListed");
            var suspended = getCookie("Suspended");
      var negated = getCookie("Negated");
      /*  Checksum security recon changes from 10.3 SUPP start */
      	var hashkey=getCookie('HASHKEY');
      	var fldhashkey=getCookie('FLDHASHKEY');
      /*  Checksum security recon changes from 10.3 SUPP end */
      IsTampered = getCookie('IsTampered');

      	if(IsTampered=='Y')
      	{ 	showMessage(MSGJ50260);
      		return;
	}



      if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){

      showUserMessage("MSG014","MSG_ACCT");

      return;

      }

	/*Tracker 103938 changes BEGIN*/
     	//var fServletURL = "../servlet/com.infy.cis.ui.cif.EventWizard?isPopup=Yes&corpID="+corpID+"&corpKey="+corpKey+"&AccessOwnerGroup="+AccessOwnerGroup+"&CIFType=C";
      	//var win = window.open(fServletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
	var RecordSts=getCookie('Record');
	ProStatus=getCookie('ProStatus');
	//Changes for call id 579481
	if(RecordSts=='A'&& (ProStatus =='' || ProStatus !='Open' || ProStatus ==null || ProStatus =="null")){

	/* Changes for Audit Enquiry CRMBAR02 Starts*/
	/* ScreenId has been included in the Query String */
	 /* Changes for RCL starts */	  /* Tracker ID - 159549 Changes Ends */
	        /*  Checksum security recon changes from 10.3 SUPP start */
     		var fServletURL = constURL+"&isPopup=Yes&corpID="+corpID+"&corpKey="+escape(corpKey)+"&AccessOwnerGroup="+AccessOwnerGroup+"&CIFType=C&ScreenID="+ aScreenID+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
	        /*  Checksum security recon changes from 10.3 SUPP end */
	/* Changes for RCL ends */	 /* Tracker ID - 159549 Changes Ends */
     	/* Changes for Audit Enquiry CRMBAR02 Ends*/
       fServletURL = fServletURL + '&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&chkBSN=true';
     	        /* Tracker: 108382: Changes for centering popup */
		windowAlign();
		//var win = window.open(fServletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
		var win = window.open(fServletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars=yes');//Fix for ticket 321672
		/* Tracker: 108382: End of Changes */
	}else{
        	//changes for call id 338600 starts
			var accountdetails = getStatus(corpId);
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
		  	 showMessage(MSGJ0385);
		  	 }

   //changes for call id 338600 ends
	}
	/*Tracker 103938 changes BEGIN*/

}
}



/*****Function for adding performDeDup in rightclickoptions on corporate Entity********/
function performdedup(name,url,viewnameScreenID ) {

	/* Checksum changes made by Rajneet Singh */
	var hashkey = getCookie('HASHKEY');
	var fldhashkey = getCookie('FLDHASHKEY');

/* Checksum changes made by Rajneet Singh */
DedupCriteriaFlag2 = getCookie('DedupCriteriaFlag1');

 if(DedupCriteriaFlag2 == "N"){
 alert("Criteria not set for within bank");
}
 if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    corpId  = getCookie('corpId');
    cifId = getCookie('cifId');
    entityType = getCookie('entityType');
    ProStatus=getCookie('ProStatus');

	//alert("entity type="+entityType);
    if(checkCookie(corpId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }
     /* Changes for Audit Enquiry CRMBAR02 Starts*/

    /* ScreenId has been included in the Query String */
    else
	{

	    if(entityType == 'Customer')
			{
				if(viewnameScreenID='CorpCustAccLkUpListFilter'){//For Search Accounts

				ScreenId = 'RCL200700700';
				}

	 		else{	//For Entity type=Customer

	 			ScreenId = 'RCL200700700C';
	 		}

			}
	    if(entityType == 'Non Customer')
			{
			ScreenId = 'RCL200700700NC';
			}
	    if(entityType == 'Prospect')
		{
		ScreenId = 'RCL200700700P';
		}



	}
/* Changes for Audit Enquiry CRMBAR02 Ends*/

// Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
  if(ProStatus =='' || ProStatus =='CLOSED' || ProStatus =='Closed' || ProStatus ==null || ProStatus =="null"){

   /* Tracker: 108382: Changes for centering popup */
   windowAlign();
   //window.open(url+corpId+'&cifId='+cifId+'&entityType='+entityType+'&isPopup=Yes','','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
/* Changes for Audit Enquiry CRMBAR02 Starts*/

/* ScreenId has been included in the Query String */
   window.open(url+corpId+'&cifId='+cifId+'&entityType='+entityType+'&ScreenID='+ScreenId+'&isPopup=Yes&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
   /* Changes for Audit Enquiry CRMBAR02 Ends*/
   /* Tracker: 108382: End of Changes */
 }else {
           showMessage(MSGJ0385);
        }
// Tracker ID - 97668 End of Changes
}

/*****Function for adding performblacklist in rightclickoptions on Corporate Entity********/
function performblacklist(name,url) {

BlackCriteriaFlag2 = getCookie('BlackCriteriaFlag1');
/* Checksum changes made by Rajneet Singh */
var hashkey = getCookie('HASHKEY');
var fldhashkey = getCookie('FLDHASHKEY');
//alert('hashkey -- '+hashkey);
//alert('fldhashkey -- '+fldhashkey);
/* Checksum changes made by Rajneet Singh */

if(BlackCriteriaFlag2 == "N"){
alert("Criteria not set for within bank");
}
 if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    corpId  = getCookie('corpId');
    cifId = getCookie('cifId');
    entityType = getCookie('entityType');
     ProStatus=getCookie('ProStatus');

    if(checkCookie(corpId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }
// Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
 if(ProStatus =='' || ProStatus =='CLOSED' || ProStatus =='Closed' || ProStatus ==null || ProStatus =="null"){

   /* Tracker: 108382: Changes for centering popup */
   windowAlign();
   //window.open(url+corpId+'&cifId='+cifId+'&entityType='+entityType+'&isPopup=Yes','','height=600, left=100, top=100, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars');
   //window.open(url+corpId+'&cifId='+cifId+'&entityType='+entityType+'&isPopup=Yes','','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars');
/* Checksum changes made by Rajneet Singh */
   window.open(url+corpId+'&cifId='+cifId+'&entityType='+entityType+'&isPopup=Yes&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey,'','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
   /* Tracker: 108382: End of Changes */
 }else {
           showMessage(MSGJ0385);
        }
// Tracker ID - 97668 End of Changes
}


/*****Function for adding performrepblacklist in rightclickoptions on Corporate Entity********/
function performrepblacklist(name,url) {

 if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}


    corpRepId  = getCookie('corpRepId');
   cifId = getCookie('cifRepId');




     if(checkCookie(corpRepId)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
    }

   window.open(url+corpRepId+'&cifId='+cifId+'&isPopup=Yes','','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
}




/*****Function for adding performnegative in rightclickoptions on Corporate Entities********/
function performnegative(name,url) {

NegCriteriaFlag2 = getCookie('NegCriteriaFlag1');

if(NegCriteriaFlag2 == "N"){
alert("Criteria not set for within bank");
}
 if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    corpId  = getCookie('corpId');
    cifId = getCookie('cifId');
    entityType = getCookie('entityType');
    ProStatus=getCookie('ProStatus');

    if(checkCookie(corpId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

    /* Changes for Audit Enquiry CRMBAR02 Starts*/

    /* ScreenId has been included in the Query String */



	else
	{

	    if(entityType == 'Customer')
			{
			ScreenId = 'RCL1382038C';
			}
	    if(entityType == 'Non Customer')
			{
			ScreenId = 'RCL1382038NC';
			}
	    if(entityType == 'Prospect')
		{
		ScreenId = 'RCL1382038P';
		}



	}
/* Changes for Audit Enquiry CRMBAR02 Ends*/
// Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
  if(ProStatus =='' || ProStatus =='CLOSED' || ProStatus =='Closed' || ProStatus ==null || ProStatus =="null"){

   /* Tracker: 108382: Changes for centering popup */
   windowAlign();
   //window.open(url+corpId+'&cifId='+cifId+'&entityType='+entityType+'&isPopup=Yes','','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
   /* Changes for Audit Enquiry CRMBAR02 Starts*/

   /* ScreenId has been included in the Query String */
   //BEGIN OF Changes: 10.3.02: Security Audit Fix
   	var hashkey=getCookie('HASHKEY');
   	var fldhashkey=getCookie('FLDHASHKEY');
        window.open(url+corpId+'&cifId='+cifId+'&entityType='+entityType+ '&ScreenID='+ScreenId+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&isPopup=Yes','','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
  //END OF Changes: 10.3.02: Security Audit Fix
   /* Changes for Audit Enquiry CRMBAR02 Ends*/
   /* Tracker: 108382: End of Changes */
 }else {
        showMessage(MSGJ0385);
        }
// Tracker ID - 97668 End of Changes
}


/*****Function for adding performrepnegative in rightclickoptions on Corporate Entities********/
function performrepnegative(name,url) {

 if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}


    corpRepId  = getCookie('corpRepId');
    cifId = getCookie('cifRepId');


     if(checkCookie(corpRepId)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
    }

   window.open(url+corpRepId+'&cifId='+cifId+'&isPopup=Yes','','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
}





/*****Function for adding blacklisting entity in rightclickoptions on Corporate Entity********/
function BlackListEntity(name, url) {

	var hashkey = getCookie('HASHKEY');
	var fldhashkey = getCookie('FLDHASHKEY');
	//alert('hashkey -- '+hashkey);
	//alert('fldhashkey -- '+fldhashkey);
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    corpId  = getCookie('corpId');
    entityType  = getCookie('entityType');
    blackListFlag  = getCookie('BlackListed');
    ProStatus=getCookie('ProStatus');
    if(blackListFlag == "")
    {
       blackListFlag = "N";
    }

   if(checkCookie(corpId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }

   if(checkCookie(blackListFlag)=="InValid"){
        showMessage(MSGJ0309);
        return;
    }
// Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
     if(ProStatus =='' || ProStatus =='CLOSED' || ProStatus =='Closed' || ProStatus ==null || ProStatus =="null"){
    var RecordSts=getCookie('Record');


    	if(RecordSts=="A")
	{
		//changes for tracker 384922 begin
		var TabName1;
	if(entityType!=null){
		if(entityType=='Customer'){
			TabName1 = MSGJ0403;
		}
		else if(entityType=='Prospect'){
			TabName1 = MSGJ0150;
		}
		else if(entityType=='Non Customer'){
			TabName1 = MSGJ0154;
		}
		else{
			TabName1=MSGJ0403;
		}

	}
       servletURL = url + corpId +'&TabName='+TabName1+'&Operation=Blacklist'+ '&entityType='+entityType+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
		//changes for tracker 384922 ends
    //Tracker ID 96131 Changes BEGIN
    //Tracker ID 160792 Changes BEGIN
    /*if(blackListFlag=="Y"){
    showMessage(MSGJ0310);
    }
    else {*/

    /* Tracker: 108382: Changes for centering popup */
    windowAlign();
    //var win = window.open(servletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    /* Tracker: 108382: End of Changes */
    //Tracker ID 96131 Changes END
   // }
    //Tracker ID 160792 Changes End

    }else {
              showMessage(MSGJ0385);
        }

    }else {
           showMessage(MSGJ0385);
        }
// Tracker ID - 97668 End of Changes
}



/*****Function for adding blacklisting a Rep in rightclickoptions********/
function BlackListRep(name, url) {

    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

	corpRepId  = getCookie('corpRepId');
	blackListFlag  = getCookie('RepBlackListed');


    if(checkCookie(corpRepId)=="InValid"){
                showUserMessage("MSG007","MSG_ACCT");
                return;
    }


   if(checkCookie(blackListFlag)=="InValid"){
        showMessage(MSGJ0309);
        return;
    }


    servletURL = url + corpRepId+'&TabName='+MSGJ0404+'&Operation=Blacklist';
    if(blackListFlag=="Y"){
    showMessage(MSGJ0310);
    }
    else
    var win = window.open(servletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
}




/*****Function for adding RemoveBlackListEntity in rightclickoptions on customers in Customer Information Menu********/

function RemoveBlackListEntity(name, url) {

	var hashkey = getCookie('HASHKEY');
		var fldhashkey = getCookie('FLDHASHKEY');
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    corpId  = getCookie('corpId');
    entityType  = getCookie('entityType');
    blackListFlag  = getCookie('BlackListed');
    ProStatus=getCookie('ProStatus');

   if(checkCookie(corpId)=="InValid"){
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
// Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
     if(ProStatus =='' || ProStatus =='CLOSED' || ProStatus =='Closed' || ProStatus ==null || ProStatus =="null"){

    var RecordSts=getCookie('Record');

        	if(RecordSts=="A")
	{
		//changes for tracker 384922 begin

		var TabName1;
		if(entityType!=null){
			if(entityType=='Customer'){
				TabName1 = MSGJ0405;
			}
			else if(entityType=='Prospect'){
				TabName1 = MSGJ0151;
			}
			else if(entityType=='Non Customer'){
				TabName1 = MSGJ0155;
			}
			else{
				TabName1=MSGJ0405;
			}
		}

     servletURL = url + corpId +'&TabName='+TabName1+ '&Operation=UnBlacklist'+'&entityType='+entityType+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
		//changes for tracker 384922 ends
    if(blackListFlag=="N"){
        showMessage(MSGJ0311);
        }
    else
    {
    /* Tracker: 108382: Changes for centering popup */
    windowAlign();
    //var win = window.open(servletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    /* Tracker: 108382: End of Changes */
    }
  }else {
         showMessage(MSGJ0385);
        }

  }else {
     showMessage(MSGJ0385);
        }
// Tracker ID - 97668 End of Changes
}


/*****Function for adding RemoveBlackListRep in rightclickoptions on customers in Customer Information Menu********/

function RemoveBlackListRep(name, url) {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
        return;
    }

    corpRepId  = getCookie('corpRepId');
     blackListFlag  = getCookie('RepBlackListed');

    if(checkCookie(corpRepId)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
    }



   if(checkCookie(blackListFlag)=="InValid"){
        showUserMessage("MSG_SUSPEND","MSG_ACCT");
        return;
    }


    servletURL = url + corpRepId+'&TabName='+MSGJ0406+ '&Operation=UnBlacklist';
    if(blackListFlag=="N"){
        showMessage(MSGJ0311);
        }
    else
    var win = window.open(servletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
}

/*****Function for adding perform Negative Check in rightclickoptions on customers in Customer Information Menu********/
function NegateEntity(name, url) {
	//START of Security Changes
	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');
	//END of Security Changes

    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    corpId  = getCookie('corpId');
    entityType  = getCookie('entityType');
    negativeFlag  = getCookie('Negated');
    ProStatus=getCookie('ProStatus');

    if(negativeFlag == "")
    {
     negativeFlag = "N";
    }

   if(checkCookie(corpId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }

   if(checkCookie(negativeFlag)=="InValid"){
        showMessage(MSGJ0312);
        return;
    }

    /* Changes for Audit Enquiry CRMBAR02 Starts*/

    /* ScreenId has been included in the Query String */



	else
	{

	    if(entityType == 'Customer')
			{
			ScreenId = 'RCL1382040C';
			}
	    if(entityType == 'Non Customer')
			{
			ScreenId = 'RCL1382040NC';
			}
	    if(entityType == 'Prospect')
		{
		ScreenId = 'RCL1382040P';
		}



	}
/* Changes for Audit Enquiry CRMBAR02 Ends*/
// Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
  if(ProStatus =='' || ProStatus =='CLOSED' || ProStatus =='Closed' || ProStatus ==null || ProStatus =="null"){

 var RecordSts=getCookie('Record');

     	if(RecordSts=="A")
	{
		//changes for ticket no 634452 starts

		var TabName1;
		if(entityType!=null){
			if(entityType=='Customer'){
				TabName1 = MSGJ0162;
			}
			else if(entityType=='Prospect'){
				TabName1 = MSGJ0152;
			}
			else if(entityType=='Non Customer'){
				TabName1 = MSGJ0156;
			}
			else{
				TabName1=MSGJ0162;
			}

		}
    /* Changes for Audit Enquiry CRMBAR02 Starts*/

    /* ScreenId has been included in the Query String */

    servletURL = url + corpId +'&TabName='+TabName1+'&Operation=Negate'+ '&entityType='+entityType+ '&ScreenID='+ScreenId+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
    /* Changes for Audit Enquiry CRMBAR02 Ends*/

//changes for ticket no 634452 ends


    //Tracker ID 96131 Changes BEGIN
   /* if(negativeFlag=="Y"){
    showMessage(MSGJ0313);
    }
    else {
*/
    /* Tracker: 108382: Changes for centering popup */
    windowAlign();
    //var win = window.open(servletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    /* Tracker: 108382: End of Changes */
   // }
    //Tracker ID 96131 Changes END
   }else {
             showMessage(MSGJ0385);
   }

   }else {
         showMessage(MSGJ0385);
   }
// Tracker ID - 97668 End of Changes
}

/*****Function for adding  Negative Check in rightclickoptions on Rep in Customer Information Menu********/
function Negaterep(name, url) {

    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

     corpRepId  = getCookie('corpRepId');
    negativeFlag  = getCookie('RepNegated');


     if(checkCookie(corpRepId)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
    }


   if(checkCookie(negativeFlag)=="InValid"){
        showMessage(MSGJ0312);
        return;
    }


    servletURL = url + corpRepId+'&TabName='+MSGJ0408+'&Operation=Negative';
    if(negativeFlag=="Y"){
    showMessage(MSGJ0313);
    }
    else
    var win = window.open(servletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
}

/*****Function for adding Remove Negative Check in rightclickoptions on contact in Customer Information Menu********/

function RemoveNegateEntity(name, url) {

	//START of Security Changes
		var hashkey=getBrowserCookie('HASHKEY');
		var fldhashkey=getBrowserCookie('FLDHASHKEY');
		//END of Security Changes
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    corpId  = getCookie('corpId');
    entityType  = getCookie('entityType');
    negativeFlag  = getCookie('Negated');
    ProStatus=getCookie('ProStatus');

   if(checkCookie(corpId)=="InValid"){
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

       /* Changes for Audit Enquiry CRMBAR02 Starts*/

        /* ScreenId has been included in the Query String */



    	else
    	{

    	    if(entityType == 'Customer')
    			{
    			ScreenId = 'RCL1382041C';
    			}
    	    if(entityType == 'Non Customer')
    			{
    			ScreenId = 'RCL1382041NC';
    			}
    	    if(entityType == 'Prospect')
    		{
    		ScreenId = 'RCL1382041P';
    		}


    	}
/* Changes for Audit Enquiry CRMBAR02 Ends*/
// Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
  if(ProStatus =='' || ProStatus =='CLOSED' || ProStatus =='Closed' || ProStatus ==null || ProStatus =="null"){

 var RecordSts=getCookie('Record');

     	if(RecordSts=="A")
	{
	//changes for ticket 634452 starts

			var TabName1;
			if(entityType!=null){
				if(entityType=='Customer'){
					TabName1 = MSGJ0145;
				}
				else if(entityType=='Prospect'){
					TabName1 = MSGJ0153;
				}
				else if(entityType=='Non Customer'){
					TabName1 = MSGJ0157;
				}
				else{
					TabName1=MSGJ0145;
				}
		}
		/* Changes for Audit Enquiry CRMBAR02 Starts*/

		/* ScreenId has been included in the Query String */
		servletURL = url + corpId +'&TabName='+TabName1+ '&Operation=UnNegate'+'&entityType='+entityType+'&ScreenID='+ScreenId+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
//changes for ticket 634452 ends
		/* Changes for Audit Enquiry CRMBAR02 Ends*/
    if(negativeFlag=="N"){
        showMessage(MSGJ0314);
        }
    else {
    /* Tracker: 108382: Changes for centering popup */
    windowAlign();
    //var win = window.open(servletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    /* Tracker: 108382: End of Changes */
    }
  }else {
             showMessage(MSGJ0385);
   }

  }else {
      showMessage(MSGJ0385);
        }
// Tracker ID - 97668 End of Changes
}

/*****Function for adding Remove Negative Check in rightclickoptions on Rep Information Menu********/

function RemoveNegateRep(name, url) {

    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    corpRepId  = getCookie('corpRepId');
    negativeFlag  = getCookie('RepNegated');


    if(checkCookie(corpRepId)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
    }


   if(checkCookie(negativeFlag)=="InValid"){
        showUserMessage("MSG_SUSPEND","MSG_ACCT");
        return;
    }

       servletURL = url + corpRepId+'&TabName='+MSGJ0410+'&Operation=UnNegate';
       if(negativeFlag=="N"){
           showMessage(MSGJ0314);
           }
       else
       var win = window.open(servletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
   }



/*****Function for suspend operation in rightclickoptions on Corporate Entity********/
function performSuspend(name, url) {

	//START of Security Changes
	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');
	//END of Security Changes
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    corpId  = getCookie('corpId');
    entityType  = getCookie('entityType');
    suspendFlag  = getCookie('Suspended');
    ProStatus=getCookie('ProStatus');

     if(suspendFlag == "")
     {
         suspendFlag = "N";
     }


   if(checkCookie(corpId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }

   if(checkCookie(suspendFlag)=="InValid"){
        showMessage(MSGJ0315);
        return;
    }
// Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
  if(ProStatus =='' || ProStatus =='CLOSED' || ProStatus =='Closed' || ProStatus ==null || ProStatus =="null"){
 var RecordSts=getCookie('Record');

     	if(RecordSts=="A")
	{
    servletURL = url + corpId +'&TabName='+MSGJ0411+'&Operation=Suspend'+ '&entityType='+entityType+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
    /* Tracker-id:108382 Modal window BEGIN */
	/*childWindow= window.showModalDialog(servletURL, 'ContactDetails', 'dialogHeight:460px; dialogWidth:900px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');

 try{

 if (childWindow.opener == null){

                                                     childWindow.opener = window;

             }

  }catch(e){}



 if(childWindow != null)

             childWindow.open;*/
      // fix for perform suspend is opening in a new window
      windowAlign();
      var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
 /* Tracker-id:108382 Modal window END */

    //Tracker ID 96131 Changes BEGIN
  /*  if(suspendFlag=="Y"){
    showMessage(MSGJ0316);
    }
    else
    {*/
  //  var win = window.open(servletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    //}
    //Tracker ID 96131 Changes END
  }else {
             showMessage(MSGJ0385);
   }

  }else {
           showMessage(MSGJ0385);
        }
// Tracker ID - 97668 End of Changes
}


/*****Function for UnSuspend operation in rightclickoptions on customers in Customer Information Menu********/

function performUnSuspend(name, url) {
	//START of Security Changes
		var hashkey=getBrowserCookie('HASHKEY');
		var fldhashkey=getBrowserCookie('FLDHASHKEY');
		//END of Security Changes

    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    corpId  = getCookie('corpId');
    entityType  = getCookie('entityType');
    suspendFlag  = getCookie('Suspended');
    ProStatus=getCookie('ProStatus');

   if(checkCookie(corpId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }

   if(checkCookie(suspendFlag)=="InValid"){
        showUserMessage("MSG_SUSPEND","MSG_ACCT");
        return;
    }
// Tracker ID - 97668 Begin of Changes
//Changes for call id 579481
     if(ProStatus =='' || ProStatus =='CLOSED' || ProStatus =='Closed' || ProStatus ==null || ProStatus =="null"){

    var RecordSts=getCookie('Record');

        	if(RecordSts=="A")
	{

    servletURL = url + corpId +'&TabName='+MSGJ0412+ '&Operation=UnSuspend'+'&entityType='+entityType+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
    if(suspendFlag=="N"){
        showMessage(MSGJ0317);
        }
    else
     {
     /* Tracker: 108382: Changes for centering popup */
     windowAlign();
     //var win = window.open(servletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
     var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
     /* Tracker: 108382: End of Changes */
     }
     }else {
              showMessage(MSGJ0385);
   }
    }else {
       showMessage(MSGJ0385);
        }
 // Tracker ID - 97668 End of Changes
 }

// Function signature changed for the MELC
function copy(wndName, url) {
//change for callid 384633 begins
//Changes for tracker ID 448615 start
//Recon of RBS FS : 716394  SET4 starts
    entityType  = getCookie('entityType');
  var strScreen=ScreenName.toUpperCase();
  if(entityType=='Non Customer' && strScreen=='COPYENTITYCORP'){

	url='../servlet/com.infy.cis.ui.corpcif.CorpNonCustomerDetWizard?menuItemId=700716&IsReadOnly=N';
}
//Recon of RBS FS : 716394  SET4 ends
if(entityType=='Non Customer' && wndName=='Copy'){
url='../servlet/com.infy.cis.ui.corpcif.CorpNonCustomerDetWizard?menuItemId=700716&isCopy=Y';
}
if(entityType=='Non Customer' && wndName=='View'){
url='../servlet/com.infy.cis.ui.corpcif.CorpNonCustomerDetWizard?menuItemId=700715&IsReadOnly=Y';
}
//Changes for tracker ID 448615 end
//change for callid 384633 ends
//Recon MELC changes to Baseline

  //change for 393639 recon of callid 392565 begins
  entityType  = getCookie('entityType');
  var strScreen=ScreenName.toUpperCase();
  if(entityType=='Non Customer' && strScreen=='CORPEDIT'){
  
  url='../servlet/com.infy.cis.ui.corpcif.CorpNonCustomerDetWizard?menuItemId=1519&IsReadOnly=Y';
  }
//change for 393639 recon of callid 392565 ends
  /*Begin of changes for tracker 131243  by sumeet gandhok - BANKID -
   * copy function is called for both view and copy.
   * Put the following condition to disable copy and enable view for cross entity search**/
  var temp = new Array();
  temp = url.split("?");
  if(temp[1]!=null)
  temp = temp[1].split("=");

  //Sanity fix for RCL menuitemid changes
  var temp1 = new Array();
  temp1 = temp[1].split("&");
  var isView=temp1[1].toUpperCase();
  //Sanity fix for RCL menuitemid changes
//Recon of RBS FS : 716394  SET4 
  //var strScreen=ScreenName.toUpperCase();
  bank_id= checkBankPrivilege();
  //Tracker 193972
  if((isView=='ISREADONLY' && strScreen=='CORPEDIT') ||(strScreen=='COPYENTITYCORP') || (strScreen=='OPERATIONS')){
 /*End of changes for tracker 131243  by sumeet gandhok - BANKID - */
//113066 Amit Malhotra begin of changes
        StrLoggegInBankId2  = getCookie('StrLoggegInBankId1');
	StrSearchedBankId2  = getCookie('StrSearchedBankId1');
	/* Fix for ticket: 267275 Start */
	if(isView!='ISREADONLY')
	status1 = checkBNSRecord();
	else
		status1 = true;
	/* Fix for ticket: 267275 Start */
	if(status1){
//113066 Amit Malhotra end of changes
//Changes end
	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
	        showUserMessage("MSG014","MSG_ACCT");
	        return;
	    }
	    IsTampered = getCookie('IsTampered');

	    	if(IsTampered=='Y')
	    	{ 	showMessage(MSGJ50260);
	    		return;
		}
	  // Tracker ID - 90197 Begin of Changes for attribute masking
			      		AccessOwnerGroup = getCookie('AccessOwnerGroup');
	      	    //  Tracker ID - 90197 End of Changes

		corpId  = getCookie('corpId');

		corpKey  = getCookie('corpKey');
		corpName  = getCookie('corpName');
		entityType = getCookie('entityType');
		coreCustId = getCookie('coreCustId');
		//Recon for Security Audit Changes from CRM10301BSUPP
		var hashkey=getCookie('HASHKEY');
		var fldhashkey=getCookie('FLDHASHKEY');
		//Recon for Security Audit Changes from CRM10301BSUPP
		var RecordSts=getCookie('Record');


	    if(checkCookie(corpId)=="InValid"){

	        showUserMessage("MSG007","MSG_ACCT");
	        return;

	    }
    //if(RecordSts=='A'){
 	var blacklisted = getCookie("BlackListed");
    	var suspended = getCookie("Suspended");
	var negated = getCookie("Negated");
	        /* Tracker ID - 159549 Changes Starts */
	        //10.2 Fix Tracker 188773
	        /* Change for ticket 321682 start */
		servletURL = url + '&corpId='+corpId + '&entityType='+entityType+'&corpKey='+escape(corpKey)+ '&fetchFrom=Main'+'&coreCustId='+escape(coreCustId);
		/* Change for ticket 321682 end */
		/* Tracker ID - 159549 Changes Ends */
		//Recon for Security Audit Changes from CRM10301BSUPP
		servletURL = servletURL + '&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&chkBSN=true';
		//Recon for Security Audit Changes from CRM10301BSUPP
//Recon MELC changes to Baseline
	//113066 Amit Malhotra begin of changes
	/*Begin of changes for tracker 131243  by sumeet gandhok - BANKID -
	 *commented the following code as it was defined in fnc checkBankPrivilege()*/
		   // if(StrLoggegInBankId2!=StrSearchedBankId2){
			//var bank_id = StrSearchedBankId2;
			//servletURL = servletURL + '&bank_id='+bank_id+'&AcrossSearch=Y';
		   // }else{
		    //   var bank_id = StrLoggegInBankId2;
		/*Uncommented this code and added a new condition for bank id, for the fix for the ticket 249457 */
		       if(StrLoggegInBankId2!=StrSearchedBankId2)
		       {
		       		var bank_id = StrSearchedBankId2;
		       		servletURL = servletURL + '&bank_id='+bank_id+'&AcrossSearch=Y';
		       }
		/*End of Fix fix for the ticket 249457 */
		    //}
       /*End of changes for tracker 131243  by sumeet gandhok - BANKID - */
       //113066 Amit Malhotra end of changes
		window.open(servletURL,'','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
     }
//Changes end



    }
  }
function checkBNSRecord(){
		StrLoggegInBankId2  = getCookie('StrLoggegInBankId1');
		StrSearchedBankId2  = getCookie('StrSearchedBankId1');
		BlackListed  = getCookie('BlackListed');
		Suspended  = getCookie('Suspended');
		Negated = getCookie('Negated');
		StrCeTarget2  = getCookie('StrCeTarget1');
		StrCeCopySusTarget2  = getCookie('StrCeCopySusTarget1');
		StrCeCopyBlTarget2  = getCookie('StrCeCopyBlTarget1');
		StrCeCopyNlTarget2  = getCookie('StrCeCopyNlTarget1');
		StrCeSource2  = getCookie('StrCeSource1');
		StrCeCopySusSource2  = getCookie('StrCeCopySusSource1');
		StrCeCopyBlSource2 = getCookie('StrCeCopyBlSource1');
		StrCeCopyNlSource2 = getCookie('StrCeCopyNlSource1');

                if(StrLoggegInBankId2==StrSearchedBankId2){
			   return true;
	        }

		if(StrCeSource2=='N'){
		       showMessage(MSGJ50667);
		       return false;
		}
		if(StrCeTarget2=='N'){
		       showMessage(MSGJ50668);
		       return false;
		}
		if(BlackListed=='Y')
		{
			if(StrCeCopyBlTarget2=='N'){
			        showMessage(MSGJ50670);
				return false;
			}
			if(StrCeCopyBlSource2=='N'){
			        showMessage(MSGJ50669);
				return false;
			}
		}
		if(Suspended=='Y')
		{
			if(StrCeCopySusTarget2=='N'){
			showMessage(MSGJ50674);
			return false;
			}
			if(StrCeCopySusSource2=='N'){
			showMessage(MSGJ50673);
			return false;
			}
		}

		if(Negated=="Y")
		{
			if(StrCeCopyNlTarget2=='N'){
			showMessage(MSGJ50672);
			return false;
			}
			if(StrCeCopyNlSource2=='N'){
			showMessage(MSGJ50671);
			return false;
			}
		}
		return true;

}


	function createActivity(name,url)
{

 /*Begin of changes for tracker 131243  by sumeet gandhok - BANKID - */
  bank_id = checkBankPrivilege();
  if(bank_id!=null){
       	showMessage(MSGJ50789);
  }
  else{
 /*End of changes for tracker 131243  by sumeet gandhok - BANKID - */
    accountURL= getCookie("corpURL");

    corpMod_ID= getCookie('corpMod_ID');
    processId= getCookie('processId');
/* Checksum security fix start */
        corp_Id= getCookie('corpId');
	var hashkey=getCookie('HASHKEY');
	var fldhashkey=getCookie('FLDHASHKEY');
/* Checksum security fix end */
    status1= getCookie('status');
    IsTampered = getCookie('IsTampered');

    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    if(corpMod_ID=="")
    {
        showMessage(MSGJ0318);
        return;
    }

    if(status1=='error'||status1=='ERROR'||status1=='Error')
    {
    /* Checksum security fix start -  setting objectId as corp_Id because corpMod_ID is not present for Approved CIFs*/
	url = url + "&objectType=Corporate&objectId=" + corp_Id + "&accountURL="+accountURL+"&TabName="+name+"&processId="+processId+"&status="+status1+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
    /* Checksum security fix end */
	newWindowcreateActivity = window.open(url, 'CreateActivity', 'height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
	newWindowcreateActivity.focus();
    }
    else
    {
        showMessage(MSGJ0319);
        return;
    }
}
 }


/* CRA10MSC : TRACKER # 90015 : BEGIN OF CHANGES  */

/*****Function for adding View Reason Code in RCL Options for
                        Corporate Entities in Customer Information Menu********/

/* Changes for ticket 348439 starts */
function ViewReasonCodesBlacklist(name, url) {

var hashkey = getCookie('HASHKEY');
	var fldhashkey = getCookie('FLDHASHKEY');
	//alert('hashkey -- '+hashkey);
	//alert('fldhashkey -- '+fldhashkey);

if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
blackListFlag  = getCookie('BlackListed');
    corpId  = getCookie('corpId');
    entityType  = getCookie('entityType');
    if(blackListFlag == 'Y')
    {
    	Operation = "BlackList";
    }
    else
    {
    	Operation = "UnBlackList";
    }

   if(checkCookie(corpId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }
      /* Changes for Audit Enquiry CRMBAR02 Starts*/

    /* ScreenId has been included in the Query String */



	else
	{

	    if(entityType == 'Customer')
			{
			ScreenId = 'RCL138570101C';
			}
	    if(entityType == 'Non Customer')
			{
			ScreenId = 'RCL138570101NC';
			}
	    if(entityType == 'Prospect')
		{
		ScreenId = 'RCL138570101P';
		}


	}


	servletURL = url + corpId +'&Operation='+Operation+'&entityType='+entityType+'&ScreenID='+ScreenId+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;

	/* Changes for Audit Enquiry CRMBAR02 Ends*/


	//var win = window.open(servletURL, '','height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');

	/* Tracker-id:108382 Modal window BEGIN */
	/* Tracker: 108382: Changes for centering popup */
    	windowAlign();
		if(window.ActiveXObject){
	//childWindow= window.showModalDialog(servletURL, 'ContactDetails', 'dialogHeight:460px; dialogWidth:575px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
	childWindow= window.showModalDialog(servletURL, 'ContactDetails', 'dialogHeight:'+wh+'px; dialogWidth:'+ww+'px; dialogLeft:'+left_x+'px; dialogTop:'+left_y+'px; directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
	/* Tracker: 108382: End of Changes */

try{

if (childWindow.opener == null){

                                                    childWindow.opener = window;

            }

 }catch(e){}



if(childWindow != null)

            childWindow.open;
/* Tracker-id:108382 Modal window END */
}else{
	var win = window.open(servletURL, '','height='+wh+', left='+left_x+', top='+left_y+', width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
}


}
/* Changes for ticket 348439 ends */

/* CRA10MSC : TRACKER # 90015 : END OF CHANGES  */
/* QED Changes: START */
function EditAddress(name,url) {
	 alert("Edit 4");
		<!--Changes for Call id 381650,recon for call id 378232 starts-->
var isCoexistence=getCookie('StrIsCoexistence');
	<!--Changes for Call id 381650,recon for call id 378232 ends-->
	/*Fix for ticket 650538 starts*/
	if((entityType=='Non Customer' || entityType=='NonCustomer' || entityType=='Customer') && (isCoexistence != null && isCoexistence != "") && isCoexistence == "true")
	{
			showMessage(MSGJ63248);
	}
	else{
   /*Begin of changes for tracker 131243  by sumeet gandhok - BANKID - */
     bank_id = checkBankPrivilege();
     if(bank_id!=null){
          showMessage(MSGJ50789);
     }
     else{
   /*End of changes for tracker 131243  by sumeet gandhok - BANKID - */
	var RecordSts=getCookie('Record');
	var ProStatus=getCookie('ProStatus');

	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
	showUserMessage("MSG014","MSG_ACCT");
	return;
	}
	IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
		{ 	showMessage(MSGJ50260);
			return;
			}
		expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));

		corpId  = getCookie('corpId');
		//changes for RBS recon TOL 447882
		//if(corpId == null || corpId == ''){
		if(corpId == "null" || corpId == null || corpId == ''){
		//changes for RBS recon TOL 447882
			corpId  = getCookie('CorpID');
		}
		corpKey  = getCookie('corpKey');
		if(corpKey == null || corpKey == ''){
				corpKey  = getCookie('CorpKey');
		}
		corpName  = getCookie('corpName');
		if(corpName == null || corpName == ''){
				corpName  = getCookie('CorpName');
		}
	entityType = getCookie('entityType');
	coreCustId = getCookie('coreCustId');
	//Checksum Changes made by Rajneet Singh
			var hashkey=getCookie('HASHKEY');
			var fldhashkey=getCookie('FLDHASHKEY');
	//Checksum Changes made by Rajneet Singh
	if(checkCookie(corpId)=="InValid"){
	showUserMessage("MSG007","MSG_ACCT");
	return;

	}
	//Changes for call id 579481
	if(RecordSts=='A'&& (ProStatus =='' || ProStatus !='Open' || ProStatus ==null || ProStatus =="null")){

	var fromEdit = "Y";
	/* Change for ticket 321682 start */
	servletURL = url + '&corpID='+corpId + '&entityType='+entityType+ '&fromEdit='+fromEdit+ '&corpKey='+corpKey+ '&coreCustID='+ coreCustId +'&fetchFrom=Main'+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
	/* Change for ticket 321682 end */

    	/* CRM102ST: TrackerID:179247 Being of Change */
	//window.location.href=servletURL;
	windowAlign();
	var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');
	/* CRM102ST: TrackerID:179247 End of Change */

	}else{
        //changes for call id 338600 starts
	var accountdetails = getStatus(corpId);
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
	 	showMessage(MSGJ0385);
	 	}

   //changes for call id 338600 ends
		}
	}
}
/*Fix for ticket 650538 ends*/
}
function EditPhoneEmail(name,url) {
	 alert("Edit 5");
	<!--Changes for Call id 381650,recon for call id 378232 starts-->
var isCoexistence=getCookie('StrIsCoexistence');
	<!--Changes for Call id 381650,recon for call id 378232 ends-->
  /*Begin of changes for tracker 131243  by sumeet gandhok - BANKID - */
    bank_id = checkBankPrivilege();
    if(bank_id!=null){
         showMessage(MSGJ50789);
    }
    else{
   /*End of changes for tracker 131243  by sumeet gandhok - BANKID - */
	var RecordSts=getCookie('Record');
	var ProStatus=getCookie('ProStatus');

	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
	showUserMessage("MSG014","MSG_ACCT");
	return;
	}
	IsTampered = getCookie('IsTampered');
		if(IsTampered=='Y')
		{ 	showMessage(MSGJ50260);
			return;
		}
	expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));

	corpId  = getCookie('corpId');
	corpKey  = getCookie('corpKey');
	corpName  = getCookie('corpName');
	entityType = getCookie('entityType');
	coreCustId = getCookie('coreCustId');
	/*BEGIN OF Changes: 10.3.02: Security Audit Fix Changes Made by Angad Sandhawalia*/
	var hashkey=getCookie('HASHKEY');
   	var fldhashkey=getCookie('FLDHASHKEY');
	/*END OF Changes: 10.3.02: Security Audit Fix */

	if(checkCookie(corpId)=="InValid"){
	showUserMessage("MSG007","MSG_ACCT");
	return;

	}
	//Changes for call id 579481
	if(RecordSts=='A'&& (ProStatus =='' || ProStatus !='Open' || ProStatus ==null || ProStatus =="null")){

	var fromEdit = "Y";
	/* Change for ticket 321682 start */
	servletURL = url + '&corpID='+corpId + '&entityType='+entityType+ '&fromEdit='+fromEdit+ '&corpKey='+corpKey+ '&coreCustID='+ coreCustId +'&fetchFrom=Main';
	/* Change for ticket 321682 end */
	//BEGIN OF Changes: 10.3.02: Security Audit Fix Changes Made by Angad Sandhawalia
	servletURL = servletURL +'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
	//alert("URL:        "+servletURL);
	//END OF Changes: 10.3.02: Security Audit Fix
   	/* CRM102ST: TrackerID:179247 Being of Change */
	// window.location.href=servletURL;
	windowAlign();
	var win = window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');
	/* CRM102ST: TrackerID:179247 End of Change */

	}else{
        //changes for call id 338600 starts
	var accountdetails = getStatus(corpId);
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
	 showMessage(MSGJ0385);
	 }

   //changes for call id 338600 ends
	}
}
}
function EditName(name,url) {
	 alert("Edit 6");
	<!--Changes for Call id 381650,recon for call id 378232 starts-->
var isCoexistence=getCookie('StrIsCoexistence');
	<!--Changes for Call id 381650,recon for call id 378232 ends-->

  /*Begin of changes for tracker 131243  by sumeet gandhok - BANKID - */
   bank_id = checkBankPrivilege();
   if(bank_id!=null){
        showMessage(MSGJ50789);
   }
   else{
  /*End of changes for tracker 131243  by sumeet gandhok - BANKID - */
    var RecordSts=getCookie('Record');
    var ProStatus=getCookie('ProStatus');

	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
	showUserMessage("MSG014","MSG_ACCT");
	return;
	}
	IsTampered = getCookie('IsTampered');
		if(IsTampered=='Y')
		{ 	showMessage(MSGJ50260);
			return;
		}
	//CheckSum changes made by Rajneet Singh
			var hashkey=getCookie('HASHKEY');
			var fldhashkey=getCookie('FLDHASHKEY');
	//CheckSum changes made by Rajneet Singh
	expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));

	corpId  = getCookie('corpId');
	corpKey  = getCookie('corpKey');
	corpName  = getCookie('corpName');
	entityType = getCookie('entityType');
	coreCustId = getCookie('coreCustId');

	if(checkCookie(corpId)=="InValid"){
	showUserMessage("MSG007","MSG_ACCT");
	return;

	}
	//Changes for call id 579481
   if(RecordSts=='A'&& (ProStatus =='' || ProStatus !='Open' || ProStatus ==null || ProStatus =="null")){

	var fromEdit = "Y";
	/* Change for ticket 321682 start */
	servletURL = url + '&corpID='+corpId + '&entityType='+entityType+ '&fromEdit='+fromEdit+ '&corpKey='+corpKey+ '&coreCustID='+ coreCustId +'&fetchFrom=Main'+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
	/* Change for ticket 321682 end */
/*Tracker:108380: Changes for centering popup */
	wid=900;
	ht=460;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	window.open(servletURL,'','directories=No, height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+', location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
/*Tracker:108380: End of Changes*/
	}
	else{
	//changes for call id 338600 starts
	var accountdetails = getStatus(corpId);
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
        showMessage(MSGJ0385);
   }

   //changes for call id 338600 ends
	}

//    window.location.href=servletURL;

  }
}
/* QED Changes: END */
/* CRA10MSC:CIF:OPERATIONS: BEGIN    */
       //changes for call id 338600 starts
function getStatus(corpId)

{
var s_xmlHttp;
	if (window.XMLHttpRequest){
		s_xmlHttp = new XMLHttpRequest();
	}else{//For IE 
	 s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
	}

     //s_xmlHttp.abort();
    var strURL = '../servlet/com.infy.cis.custom.CIFVerification' + "?corpId="+corpId +"&boName=CorporateBO";
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
       //changes for call id 338600 ends

function CIFOperationsAgainstExtDB(name,url)
{


    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
    {
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }

    var corpId  = getCookie('corpId');
    var entityType  = getCookie('entityType');

    //alert('corpId:::'+corpId+" :::entityType:::"+entityType);

    if(checkCookie(corpId)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }

       if(checkCookie(entityType)=="InValid"){
                showUserMessage("MSG007","MSG_ACCT");
                return;
        }
	/* Changes for Audit Enquiry CRMBAR02 Starts*/

	/* ScreenId has been included in the Query String */

	else
	{

	    if(entityType == 'Customer')
			{
			ScreenId = 'RCL138570076C';
			}
	    if(entityType == 'Non Customer')
			{
			ScreenId = 'RCL138570076NC';
			}
	    if(entityType == 'Prospect')
		{
		ScreenId = 'RCL138570076P';
		}



	}
	//Recon of Security Audit Changes From CRM10301BSUPP
	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');



   	 var servletURL=url+corpId+'&EntityType='+entityType+'&ScreenID='+ ScreenId+'&IsBatch=No'+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey ;
	//Recon of Security Audit Changes From CRM10301BSUPP

 	/* Changes for Audit Enquiry CRMBAR02 Ends*/
     /* Tracker-id:108382 Modal window BEGIN */
 // window.open(servletURL, '','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
/* Tracker: 108382: Changes for centering popup */
windowAlign();
/*childWindow= window.showModalDialog(servletURL, 'ContactDetails', 'dialogHeight:460px; dialogWidth:575px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');*/
if(window.ActiveXObject){
childWindow= window.showModalDialog(servletURL, 'ContactDetails', 'dialogHeight:'+wh+'px; dialogWidth:'+ww+'px; dialogLeft:'+left_x+'px; dialogTop:'+left_y+'px; directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
}else{
	window.open(servletURL, '','height='+wh+', left='+left_x+', top='+left_y+', width='+ww+', location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
}
/* Tracker: 108382: End of Changes */
try{

if (childWindow.opener == null){

                            childWindow.opener = window;

           	 }

 	}catch(e){}



if(childWindow != null)

            childWindow.open;

         /* Tracker-id:108382 Modal window END */




}
/* Changes for tracker id 178956 start */
/* TrackerID:177869,Changes Begin */
/* Getting CorpModID from corporate_mod table for displaying audittrail records in editentity screen*/
function fnGetCorp_Mod_ID(corp_key) {

    var s_xmlHttp = "";
    if (window.XMLHttpRequest) {
         s_xmlHttp=new XMLHttpRequest();
    } else if (window.ActiveXObject) {
 	s_xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    var strURL = '../servlet/com.infy.cis.ui.common.MainAuditUserDetailsForm?CorpKey=' + corp_key;
    s_xmlHttp.open("GET",strURL,false);
    if(navigator.userAgent.indexOf("MSIE")!= -1)
    s_xmlHttp.send();//Done by Tool : SendPattern
else
    s_xmlHttp.send(null);
    var corp_mod_id = "";

    if (s_xmlHttp.readyState == 4) {
    corp_mod_id = s_xmlHttp.responseText;
    }

    return corp_mod_id;
}
/* TrackerID:177869,Changes End */
/* Changes for tracker id 178956 end */

/* CRA10MSC:CIF:OPERATIONS: END    */

/* Changes for ticket 348439 starts */
	function ViewReasonCodesSuspend(name, url) {
		var hashkey = getCookie('HASHKEY');
		var fldhashkey = getCookie('FLDHASHKEY');
if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    suspendFlag  = getCookie('Suspended');
	corpId  = getCookie('corpId');
    entityType  = getCookie('entityType');
    if(suspendFlag == 'Y')
    {
    	Operation = "Suspend";
    }
    else
    {
    	Operation = "UnSuspend";
    }

   if(checkCookie(corpId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }
	else
	{

	    if(entityType == 'Customer')
			{
			ScreenId = 'RCL138570101C';
			}
	    if(entityType == 'Non Customer')
			{
			ScreenId = 'RCL138570101NC';
			}
	    if(entityType == 'Prospect')
		{
		ScreenId = 'RCL138570101P';
		}
	}
	servletURL = url + corpId +'&Operation='+Operation+'&entityType='+entityType+'&ScreenID='+ScreenId+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
    	windowAlign();
		if(window.ActiveXObject){
	childWindow= window.showModalDialog(servletURL, 'ContactDetails', 'dialogHeight:'+wh+'px; dialogWidth:'+ww+'px; dialogLeft:'+left_x+'px; dialogTop:'+left_y+'px; directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
try{

if (childWindow.opener == null){
                                                   childWindow.opener = window;
            }
 }catch(e){}

if(childWindow != null)
            childWindow.open;
		}else{
			window.open(servletURL, '','height='+wh+', left='+left_x+', top='+left_y+', width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
		}
}
	function ViewReasonCodesNegate(name, url) {
		var hashkey = getCookie('HASHKEY');
			var fldhashkey = getCookie('FLDHASHKEY');
if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    negativeFlag  = getCookie('Negated');
	corpId  = getCookie('corpId');
    entityType  = getCookie('entityType');
    if(negativeFlag == 'Y')
    {
    	Operation = "Negate";
    }
    else
    {
    	Operation = "UnNegate";
    }

   if(checkCookie(corpId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }

   if(checkCookie(entityType)=="InValid"){
            showUserMessage("MSG007","MSG_ACCT");
            return;
        }
	else
	{

	    if(entityType == 'Customer')
			{
			ScreenId = 'RCL138570101C';
			}
	    if(entityType == 'Non Customer')
			{
			ScreenId = 'RCL138570101NC';
			}
	    if(entityType == 'Prospect')
		{
		ScreenId = 'RCL138570101P';
		}
	}
	servletURL = url + corpId +'&Operation='+Operation+'&entityType='+entityType+'&ScreenID='+ScreenId+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
    	windowAlign();
		if(window.ActiveXObject){
	childWindow= window.showModalDialog(servletURL, 'ContactDetails', 'dialogHeight:'+wh+'px; dialogWidth:'+ww+'px; dialogLeft:'+left_x+'px; dialogTop:'+left_y+'px; directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
try{

if (childWindow.opener == null){
                                                   childWindow.opener = window;
            }
 }catch(e){}

if(childWindow != null)
            childWindow.open;
	}else{
		window.open(servletURL, '','height='+wh+', left='+left_x+', top='+left_y+', width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
	}
}

/* Changes for ticket 348439 ends */




















