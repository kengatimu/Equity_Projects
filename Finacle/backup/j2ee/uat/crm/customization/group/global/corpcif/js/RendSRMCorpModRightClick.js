document.write('<script language="javascript" src="'+applPath+'/common/js/SSOUtils.js"></script>');
document.write('<script language=javascript src="'+applPath+'/corpcif/js/Message_corpcif_'+finaclecrmlocale+'.js">'+'<\/script>');

var corpId     = "";
var corpKey     = "";
var corpName     = "";
var entityType     = "";
var corpMod_ID     = "";
var CorpList     = new Array();
var CorpId  = new Array();
var BOCrId  = new Array();
var AssitoId  = new Array();
var OwnerID  = new Array();
var GroupID  = new Array();
var OwnGroupID  = new Array();
var Record  = new Array();
var Doi = "";
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

var parentFrame =""
if(parent.parent.parent.dynamicTabFrm){
    parentFrame = parent ;
}else{
    parentFrame = parent.parent ;
}


//changes for right click menu start


function showAuditTrail(wndName,auditUrl)
{

    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false") {
               showUserMessage("MSG014","MSG_CUSTOMER");
            return;
    }
    IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    corpMod_ID = getCookie('corpMod_ID');

    corpKey = getCookie('corp_Key');


    if(checkCookie(corpMod_ID)=="InValid"){
        return;
	}
/*Fix for the ticket 239277, Tracker ID 144187*/
	auditUrl=auditUrl+'&BOName=CorporateModBO&BOID='+corpMod_ID;
	/*changes for ticket id 362237 start*/
    if (checkCookie(corpMod_ID) != 'InValid')
        auditUrl += '&Header='+MSG_AU0001+'~'+escape(corpKey);
        /*changes for ticket id 362237 end*/
/*End of Fix for the ticket 239277*/        
    /* Tracker: 108382: Changes for centering popup */
    windowAlign();
    //window.open(auditUrl,'','height=436, left=70, top=120, width=860,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    window.open(auditUrl,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    /* Tracker: 108382: End of Changes */
}

/***********changes made by shikhar for corporate  showDefTabs**********/
function showDefTabs( ) {
	rClickURLDS = new Array()
    try{IsTampered = getCookie('IsTampered');
		
	if(IsTampered=='Y')
	{ 	showMessage(MSGJ50260);
		return;
	}

        if(CheckIfRowSelected()=="false"){

            parentFrame.parent.parent.dynamicTabFrm.location.href='../common/html/blank.html';
            return;
        }
         parentFrame.removeDefTabs();


        populateRClickViewDS();




        allTabNames = new Array();
        selectedTabName = '';
       if(parentFrame.parent.parent.dynamicTabFrm.tabViewFrm) {

            allTabNames = parentFrame.parent.parent.dynamicTabFrm.tabViewFrm.getAllSelectedTabNames();
         }
        if(parentFrame.parent.parent.dynamicTabFrm.tabViewFrm) {

            selectedTabName = parentFrame.parent.parent.dynamicTabFrm.tabViewFrm.getSelectedTabName();
           }
       /* if(allTabNames.length == 0) {
	defTabs();

	}*/

	defTabs();



     /*for(i = 0; i < allTabNames.length; i++) {

            for(j = 0; j <  rClickNameDS.length; j++) {

                if(allTabNames[i] == rClickNameDS[j]) {

                parentFrame.addDefTab(rClickNameDS[j], rClickURLDS[j]);
                break;
                }
            }
        }
        */

        parentFrame.addDefSelTab(selectedTabName);
        parentFrame.showTabFrm();

    }catch(e){}
}

/***********changes made by shikhar for corporate  def_showEntityInfo**********/
function def_showEntityInfo(name, url, screenid) {

    viewName  = '';
    entityID  = '';
    corpMod_ID = getCookie('corpMod_ID');
    IsTampered = getCookie('IsTampered');
    //Recon for Security Audit Changes from CRM10301BSUPP
    var hashkey=getCookie('HASHKEY');
    var fldhashkey=getCookie('FLDHASHKEY');
    //Recon for Security Audit Changes from CRM10301BSUPP		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    // Tracker ID - 90197 Begin of Changes for attribute masking
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    //  Tracker ID - 90197 End of Changes

	viewName = "CorpModInfoSummary";
        entityID = corpMod_ID;

	// Fix for ticket ID 259665
	//Recon for Security Audit Changes from CRM10301BSUPP
    url = url + viewName + "&param2=" + entityID+ "&AccessOwnerGroup=" + AccessOwnerGroup + "&ScreenID=" + screenid+"&SECUREHKEY="+hashkey+"&FLDHASHKEY="+fldhashkey;
        //Recon for Security Audit Changes from CRM10301BSUPP
	 // Fix for ticket ID 259665
      	parentFrame.addDefTab(name, url);
   }
/***********changes made by shikhar for corporate  populate_showEntityInfo**********/
function populate_showEntityInfo(url, screenid) {

    viewName  = '';
    entityID  = '';
    corpMod_ID = getCookie('corpMod_ID');
        
    IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    // Tracker ID - 90197 Begin of Changes for attribute masking
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    //  Tracker ID - 90197 End of Changes

    	viewName = "CorpModInfoSummary";
        entityID = corpMod_ID;
// Fix for ticket ID 259665
      	url = url + viewName + "&param2=" + entityID+ "&AccessOwnerGroup=" + AccessOwnerGroup + "&ScreenID=" + screenid;
 // Fix for ticket ID 259665
    rClickURLDS[rClickURLDS.length] = url;
  }


//changes for right click menu end

/***********changes made by shikhar for corporate  showEntityInfo**********/
function showEntityInfo(name, url , screenid) {

    if(CheckIfRowSelected()=="false"){
        showUserMessage('MSG014','MSG_ENT');
        return;
    }
    IsTampered = getCookie('IsTampered');
    //Recon for Security Audit Changes from CRM10301BSUPP
    var hashkey=getCookie('HASHKEY');
    var fldhashkey=getCookie('FLDHASHKEY');
    //Recon for Security Audit Changes from CRM10301BSUPP		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}
    // Tracker ID - 90197 Begin of Changes for attribute masking
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    //  Tracker ID - 90197 End of Changes
    	viewName  = '';
    	entityID  = '';
    	corpMod_ID = getCookie('corpMod_ID');
 	viewName = "CorpModInfoSummary";
	entityID = corpMod_ID;
	// Fix for ticket ID 259665
	//Recon for Security Audit Changes from CRM10301BSUPP
    url = url + viewName + "&param2=" + entityID +"&AccessOwnerGroup=" + AccessOwnerGroup + "&ScreenID=" + screenid+"&SECUREHKEY="+hashkey+"&FLDHASHKEY="+fldhashkey;
        //Recon for Security Audit Changes from CRM10301BSUPP
	// Fix for ticket ID 259665
    parentFrame.parent.parent.dynamicTabFrm.addTab(name, url);
}

/***************** Save and Submit Changes : DELETE option in Entity Queue : Start***************/
function deleteEntity(name,url)
{
/* Changes for Security begins */
var hashkey=getBrowserCookieHash('HASHKEY');
var fldhashkey=getBrowserCookieHash('FLDHASHKEY'); 
/* Changes for Security ends */
	var Record=getCookie('Record');
	/* Ticket id 361810 changes start */
	var corpIds="";
	for(var i = 0; i < CorpList.length; i++)
		{
			if(CorpList[i] != -1)
			{
				corpIds += CorpList[i] + ",";
				var last=corpIds.lastIndexOf(',');
			}
		}
	     corpIds=corpIds.substr(0,last);
	     if (corpIds=="")
		{

				showMessage(MSGJ0378);
				return "false";
	}
	/* Ticket id 361810 changes end */
	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
	{
		showMessage(MSGJ50330);//Tracker 98346 changes 
		return;
	}
	else if(Record=='U')
	{
	    showMessage(MSGJ0385);
	    return;
	}
	else if( showConfirmMessage(MSGJ50377) ) //Tracker 98346 changes 
	{
		entityID  = '';
	    	corpMod_ID = getCookie('corpMod_ID');
	    	entityID = corpMod_ID;
	   	entityType = getCookie('EntityType');
	   	corp_Key = getCookie('corp_Key');

	    	var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
	    	s_xmlHttp.abort();
	    	var strURL = '../servlet/com.infy.cis.ui.common.DeleteModEntity?EntityType='+EntityType+'&entityID='+entityID+'&cifID='+corp_Key+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
	        s_xmlHttp.open("GET",strURL,false);
	        s_xmlHttp.send();
//Recon from CRM10301BSUPP for SSV fixes
	        //Server side validation changes
		if(s_xmlHttp.status == 200)
		{
		    try{
			var node1 = s_xmlHttp.responseXML.selectSingleNode("ErrCode");
			var errCode = node1.text;
			if(errCode != null && errCode.indexOf('Serverside')>-1){
				alert(errCode);
				return;
			}
		    }catch(e){}
//changes for call id 385525 and recon of call id 382484 starts
			try{
				var nod1 = s_xmlHttp.responseXML.selectSingleNode("DEL");
				var errMsg = nod1.text;
				if(errMsg != null){
					alert(errMsg);
					return;
				}
			}catch(e){ 
			}
//changes for call id 385525 and recon of call id 382484 ends
		}       
		//Server side validation changes
	        //Tracker 98346 changes BEGIN
	        //alert('Entity With '+ entityID+' Deleted Successfully');
	        //showUserMessage('MSGJ50372','corp_Key'); 
	        //Tracker 98346 changes END
	        //s_xmlHttp.send();
	        if(s_xmlHttp.status == 200)
		{
		  showUserMessage('MSGJ50372','corp_Key');
		   try
		   {
			window.location.href = window.location;
	   	   }
	   	   catch(e){}
		}
	}
}
/***************** Save and Submit Changes : DELETE option in Entity Queue : End***************/

function showProcessRelatedInfo(name, url) {

	 var RepID = document.frm2.RepID.value;
	//var boCreatedById = getCookie('boCreatedById');
	 var makerID = getCookie('makerID');
// 409010 changes
	 var OwnerID=getCookie('OwnerID');
      	 var CorporateURL='';
   if(CheckIfRowSelected()=="false"){
    	    showUserMessage('MSG014','MSG_ENT');
            return;
        }
        IsTampered = getCookie('IsTampered');
        //Recon for Security Audit Changes from CRM10301BSUPP
	var hashkey=getCookie('HASHKEY');
	var fldhashkey=getCookie('FLDHASHKEY');
	//Recon for Security Audit Changes from CRM10301BSUPP	

		if(IsTampered=='Y')
		{ 	showMessage(MSGJ50260);
			return;
		}
	if(SavedSubmitted !='Saved') {
        //TrackerID:79355 Maker Validation
// 409010 changes
        if(RepID==makerID || RepID==OwnerID) {
		showMessage(MSGJ0375);
		return false;
	}
	}
	//TrackerID:79355 END

        entityID  = '';
        corpMod_ID = getCookie('corpMod_ID');
        CorporateURL = getCookie('CorporateURL');
       	entityID = corpMod_ID;
        prefix = local_prefix;
        local_prefix = "";
        local_prefix = prefix;

	//Recon for Security Audit Changes from CRM10301BSUPP
   	url=url+'&corpMod_ID='+entityID+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&type=Corporate';
	//Recon for Security Audit Changes from CRM10301BSUPP

    if(name == 'Process Steps'){
    /*
        var hnew=  eval("window.open('../common/html/SSOblank.html',  '' ,'directories=No, height=436, left=70, top=120, width=860, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');");

        try {
            hnew.document.write("<Title>" + name + "</Title>");
        } catch (e) {
            hnew.document.write("<Title>FinacleCRM</Title>");
       }
        hnew.document.write("<FRAMESET id='TOCFrmSet' FRAMEBORDER=0 FRAMESPACING=0 ROWS='95%,*'>")
        hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= '"+ url+"'/>");
        hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= '../common/html/CloseOption.html'/>");
        hnew.document.write('</FRAMESET>');
     */
	loadURL=url;
	writeToNewWindow();
    }else {
        parentFrame.parent.parent.dynamicTabFrm.addTab(name, url );
    }

}

/*function def_showProcessRelatedInfo(name, url) {
    try{
    	IsTampered = getCookie('IsTampered');

		if(IsTampered=='Y')
		{ 	showMessage(MSGJ50260);
			return;
		}

 	corpMod_ID = getCookie('corpMod_ID');
        local_prefix = "";
       // type = getCookie('ModEntityType');
        local_prefix = prefix;


	        viewName = "CorpModInfoSummary";
	        entityID = corpMod_ID;



    if(type == 'Group') {
            return;
        }

           url=url+'&corpMod_ID=';
        parentFrame.addDefTab(name, url + entityID);
    }catch(e){}

}*/


/*function populate_showProcessRelatedInfo(url) {

    corpMod_ID= getCookie('corpMod_ID');
    IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}
    prefix = local_prefix;
    local_prefix = "";

    local_prefix = prefix;
    if(checkCookie(corpMod_ID)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
    }else{
        if(type == 'Group') {
            rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
        return;
        } else {
        url=url+'&corpMod_ID=';
            rClickURLDS[rClickURLDS.length] = url + corpMod_ID;
        }
    }

}*/

/********************* Tracker : 79497 ***********************/
// Changes to load the Current Process tab by default

function def_showProcessRelatedInfo(name, url) {
	entityID  = '';
	corpMod_ID = getCookie('corpMod_ID');
	IsTampered = getCookie('IsTampered');
	//Recon for Security Audit Changes from CRM10301BSUPP
	var hashkey=getCookie('HASHKEY');
	var fldhashkey=getCookie('FLDHASHKEY');
	//Recon for Security Audit Changes from CRM10301BSUPP
			
		if(IsTampered=='Y')
		{ 	showMessage(MSGJ50260);
			return;
		}
	entityID = corpMod_ID;
	var RepID = document.frm2.RepID.value;
	var boCreatedById = getCookie('boCreatedById');
	var makerID = getCookie('makerID');
	var OwnerID=getCookie('OwnerID');
	//Equity Bank Customization//
	//if((RepID==OwnerID) || (RepID==makerID)){
	if((RepID==makerID)){
		return;
	}
	//Equity Bank Customization//
	//Recon for Security Audit Changes from CRM10301BSUPP
	url = url + "&corpMod_ID=" + entityID+"&SECUREHKEY="+hashkey+"&FLDHASHKEY="+fldhashkey+"&type=Corporate";
	//Recon for Security Audit Changes from CRM10301BSUPP
	parentFrame.addDefTab(name, url);

}

function populate_showProcessRelatedInfo(url) {
    entityID  = '';
    corpMod_ID = getCookie('corpMod_ID');
    IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}
    entityID = corpMod_ID;
    url = url + "&corp_ID=" + entityID;
    rClickURLDS[rClickURLDS.length] = url;

}
/********************* Tracker : 79497 ***********************/


/***********Begin of changes made by Prashant Raj Goel for corporate**********/
function activityHistory(name, url)
{

    if(CheckIfRowSelected()=="false")
    {
        showMessage(getUserMessage("MSG014","MSG_OPPR"));
        return;
    }
    IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}
    corpMod_ID = getCookie('corpMod_ID');
    //Recon for Security Audit Changes from CRM10301BSUPP
    	var hashkey=getCookie('HASHKEY');
    	var fldhashkey=getCookie('FLDHASHKEY');
	//Recon for Security Audit Changes from CRM10301BSUPP
    if(checkCookie(corpMod_ID)=="InValid")
    {
        showUserMessage('MSG007','MSG_OPPR');
        return;
    }
    var sortOrder = getCookie('SORT_ORDER_OpportunityHistory');
    if(sortOrder==null || sortOrder == 'null' || sortOrder=='undefined') {
        sortOrder='';
    }
    var sortColumn = getCookie('SORT_COLUMN_OpportunityHistory');
    if(sortColumn==null || sortColumn == 'null' || sortColumn=='undefined') {
        sortColumn='';
    }
    accountURL = getCookie("searchAccURL");
    //Recon for Security Audit Changes from CRM10301BSUPP
    wizardurl = '../servlet/com.infy.cis.ui.wizards.SRMWizardWrapper?FormBaseURL=' + url + '&EntityType=CorporateMod&ViewName=OpportunityHistory&parComp=parentFrame.parent.parent.dynamicTabFrm.frames(0)&FormTitle='+name+'&typeId=' +corpMod_ID + '&accountURL=' +accountURL+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
    //Recon for Security Audit Changes from CRM10301BSUPP
    /* Tracker: 108382: Changes for centering popup */
    windowAlign();
    //newWindowActHist = window.open(wizardurl , 'ActivityHistory','height=436, left=70, top=120, width=860,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    newWindowActHist = window.open(wizardurl , 'ActivityHistory','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    /* Tracker: 108382: End of Changes */
    newWindowActHist.focus();
}

function createActivity(name,url)
{
/* Checksum security recon changes from 10.3 SUPP start */
	var hashkey=getCookie('HASHKEY');
	var fldhashkey=getCookie('FLDHASHKEY');
/* Checksum security recon changes from 10.3 SUPP end */
    accountURL= getCookie("corpURL");

    corpMod_ID= getCookie('corpMod_ID');
    processId= getCookie('processID');
    IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}
    status1= getCookie('status');
    var isConditional = "N";
    var currStep= getCookie('currStep');
    var nextStepID = "";

    if(corpMod_ID=="")
    {
        showMessage(MSGJ0376);
        return;
    }

    if(status1=='error'||status1=='ERROR'||status1=='Error')
    {
	/*url = url + "?objectType=CorporateMod&objectId=" + corpMod_ID + "&accountURL="+accountURL+"&TabName="+name+"&processId="+processId+"&status="+status1;*/
	/* Checksum security recon changes from 10.3 SUPP start */
	url = url + '&objectType=CorporateMod&objectId=' + corpMod_ID +'&processStep=' + currStep + '&isConditional=' + isConditional + '&processId=' + processId +'&FromDaemon=true&nextStep=' + nextStepID + '&status='+status1.toUpperCase()+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
	/* Checksum security recon changes from 10.3 SUPP end */
	/* Tracker: 108382: Changes for centering popup */
	windowAlign();
	//newWindowcreateActivity = window.open(url, 'CreateActivity', 'height=436, left=70, top=120, width=860,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
	newWindowcreateActivity = window.open(url, 'CreateActivity', 'height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
	/* Tracker: 108382: End of Changes */
	newWindowcreateActivity.focus();
    }
    else
    {
        showMessage(MSGJ0377);
        return;
    }
}

function showProcessSteps(name,url)
{
    corpMod_ID= getCookie('corpMod_ID');
	/*  TRACKER:78453:BEGINOFCHANGES */


	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false") {
               showUserMessage("MSG014","MSG_ENT");
            return;
    }
    IsTampered = getCookie('IsTampered');
    //Recon for Security Audit Changes from CRM10301BSUPP
	var hashkey=getCookie('HASHKEY');
	var fldhashkey=getCookie('FLDHASHKEY');
	//Recon for Security Audit Changes from CRM10301BSUPP		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

	/* TRACKER:78453:ENDOFCHANGES */
    //Recon for Security Audit Changes from CRM10301BSUPP
    url = url + "&objectType=Corporate&corpMod_ID=" + corpMod_ID+"&SECUREHKEY="+hashkey+"&FLDHASHKEY="+fldhashkey+"&type=Corporate";
    //Recon for Security Audit Changes from CRM10301BSUPP
    /* TrackerID:160448: Changes done for close button*/
    loadURL=url;
    /* Tracker: 108382: Changes for centering popup */
    windowAlign();
     writeToNewWindow();
    //newWindowcreateActivity = window.open(url, 'ProcessSteps', 'height=436, left=70, top=120, width=860,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    //newWindowcreateActivity = window.open(url, 'ProcessSteps', 'height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    /* Tracker: 108382: End of Changes */
    //newWindowcreateActivity.focus();
     /* TrackerID:160448: Changes End */
   
}
/***********End of changes made by Prashant Raj Goel for corporate**********/

/*******made by shikhar for corporate  getEntity**********/

var response;

function getEntity(name,url) {

    var temp = local_prefix;
    local_prefix = "";
    local_prefix = temp;
    var Flag='Y';
    var EntityType=getCookie('EntityType');
    var RepID = document.frm2.RepID.value;
    var elements = document.getElementsByTagName("input");
    var corpIds="";
    IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}
    for(var i = 0; i < CorpList.length; i++)
	{
		if(CorpList[i] != -1)
		{
			corpIds += CorpList[i] + ",";
			var last=corpIds.lastIndexOf(',');
		}
	}
     corpIds=corpIds.substr(0,last);
     if (corpIds=="")
	{
			showMessage(MSGJ0378);
			return "false";
	}


    var getFirst = "";
    entityURL = getCookie('CorporateURL');
    var entityURLs = corpIds;
    parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.corpcif.getModCorporate?EntityType='+EntityType+'&entityURL='+ entityURLs+ '&getFirst='+ getFirst+'&Flag='+Flag;



}


function checkCookie(x){
    if(x!=0 &&x != null && x != 'null' && x != "" && x!='undefined') {
        return "Valid" ;
    }else{
        return "InValid";
    }
}




var BOCreaID;
function assignEntity(name, url)
{
    //Recon for Security Audit Changes from CRM10301BSUPP
	var hashkey=getCookie('HASHKEY');
	var fldhashkey=getCookie('FLDHASHKEY');
    //Recon for Security Audit Changes from CRM10301BSUPP
    for(var i=0;i<Record.length;i++) {
	if(Record[i]=="D") {
	showMessage(MSGJ0379);
	return;
	}
    }
    IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}
    var EntityType=getCookie('EntityType');
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ENT");
        return;
    }
  	var k = 0;
        var RepID = document.frm2.RepID.value;
       	var action = url;
        var corpMod_ID=getCookie('corpMod_ID');
        var elements = document.getElementsByTagName("input");
	var corpIds="";

	for(var i = 0; i < CorpList.length; i++) {
	if(CorpList[i] != -1) {
		corpIds += CorpList[i] + ",";
		var last=corpIds.lastIndexOf(',');
	}
	}
	corpIds=corpIds.substr(0,last);
	if (corpIds==""){
	 showMessage(MSGJ0378);
	 return "false";
	 }
	entityURL = getCookie('CorporateURL');
	entityURLs = corpIds;

for(var j = 0; j<OwnerID.length; j++){
for(var i=0;i<AssitoId.length;i++) {

if((RepID!=OwnerID[j])&&(AssitoId[i]!=RepID)){

	showMessage(MSGJ0380)
	return;

/* CRM102BETA : TrackerID:198543 Begin of Change */
} else if(RepID==OwnerID[j]||RepID==AssitoId[i]) {
	var BOFlag="Y";

	if (OwnerID.length>1) {
	var corporateIds = "";
        for(var i = 0; i < CorpList.length; i++) {
		if(CorpList[i] != -1) {
		 corporateIds += CorpList[i] + "`";
		}
	}

	for( l=0;l<GroupID.length;l++)
	{
	  for( k=GroupID.length-1;k>l;k--){
	    if(GroupID[l]!=GroupID[k]){
		  showMessage(MSGJ0381);
		  return;
	     }
	    else if(GroupID[l]==GroupID[k]){
			grpID=GroupID[l];
			break;
	     }
	  }
	}
	GroupID=grpID;
			// changes for security audit
    //Recon for Security Audit Changes from CRM10301BSUPP
			action +="&EntityType="+EntityType+"&entityId="+ corporateIds+"&RepID="+RepID+"&BOCreatedByID="+BOCrId+"&GroupID="+GroupID+"&OwnerID="+OwnerID+"&BOFlag="+BOFlag+"&SECUREHKEY="+hashkey+"&FLDHASHKEY="+fldhashkey;
    //Recon for Security Audit Changes from CRM10301BSUPP
	/* Tracker: 108382: Changes for centering popup */
        windowAlign();
	//window.open(action,'','height=436, left=70, top=120, width=860 , resizable=no, scrollbars=yes');
	window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+' , resizable=no, scrollbars=yes');
	/* Tracker: 108382: End of Changes */
	return;
} else if(OwnerID.length<=1||AssitoId.length<=1){
				// changes for security audit
    //Recon for Security Audit Changes from CRM10301BSUPP
				action += "&EntityType="+EntityType+"&entityId=" + corpMod_ID+"&RepID="+RepID+"&BOCreatedByID="+BOCrId+"&GroupID="+GroupID+"&OwnerID="+OwnerID+"&BOFlag="+BOFlag+"&SECUREHKEY="+hashkey+"&FLDHASHKEY="+fldhashkey;
    //Recon for Security Audit Changes from CRM10301BSUPP
		window.open(action,'','height=436, left=70, top=120, width=860 , resizable=no, scrollbars=yes');
		return;
	}


} /*else if(RepID==AssitoId[i] ) {
	if(AssitoId.length>1) {
		var Flag='Y';
		var getFirst = "";
		parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.corpcif.AssignToGroup?EntityType='+EntityType+'&entityURL='+ entityURLs+ '&getFirst='+ getFirst+'&Flag='+Flag;
		return;
	}else if(AssitoId.length<=1) {
		Flag='Y';
		getFirst = 'true';*/

		/* CRM70T-ST TRACKER:78879:BEGINOFCHANGES */
		//parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.corpcif.AssignToGroup?EntityType='+EntityType+'&entityURL='+ entityURLs+ '&getFirst='+ getFirst+'&Flag='+Flag;
		/* CRM70T-ST TRACKER:78879:BEGINOFCHANGES */

		/*return;
	}
}*/
/* CRM102BETA : TrackerID:198543 End of Change */
}
}
}





function transferEntity(name, url)
{

    //Recon for Security Audit Changes from CRM10301BSUPP
	var hashkey=getCookie('HASHKEY');
	var fldhashkey=getCookie('FLDHASHKEY');
    //Recon for Security Audit Changes from CRM10301BSUPP
   var EntityType=getCookie('EntityType');
   var RepID = document.frm2.RepID.value;
   if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ENT");
        return;
    }

	/*tracker id:188937 Changes Begin*/
	   for(var i=0;i<Record.length;i++) {
	   	if(Record[i]=="D") {
	   	showMessage(MSGJ51504);
	   	return;
	   	}
	    }
   	/*tracker id:188937 Changes End*/
    	IsTampered = getCookie('IsTampered');
			
		if(IsTampered=='Y')
		{ 	showMessage(MSGJ50260);
			return;
		}
       	var action = url;
        var corpMod_ID=getCookie('corpMod_ID');
        var elements = document.getElementsByTagName("input");
      	var corpIds="";

      	for(var i = 0; i < CorpList.length; i++) {
      		if(CorpList[i] != -1) {
      			corpIds += CorpList[i] + ",";
      			var last=corpIds.lastIndexOf(',');
      		}
      	    }
      	 corpIds=corpIds.substr(0,last);
      	    if (corpIds==""){
		showMessage(MSGJ0378);
		return "false";
	    }

        for(var j = 0; j<OwnerID.length; j++){
		if((RepID!=OwnerID[j])&&(OwnerID[j]!=''))
		{
			showMessage(MSGJ0382)
			return;
		}
	}

    if(CorpList.length < 2) {
        corpMod_ID=getCookie('corpMod_ID');
       try {
//Security changes
            action += "&EntityType="+EntityType+"&entityId=" + corpMod_ID+"&RepID="+RepID+"&BOCreatedByID="+BOCreaID+"&SECUREHKEY="+hashkey+"&FLDHASHKEY="+fldhashkey+"&BOFlag=Y";
            /* Tracker: 108382: Changes for centering popup */
	    windowAlign();
	    //window.open(action,'','height=436, left=70, top=120, width=860, resizable=no, scrollbars=yes');
	    window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');
	    /* Tracker: 108382: End of Changes */
        } catch (e) {
						DebugMessage(e.message);
        }
        return true;
    }
    else {
        try {

            var corporateIds = "";
            for(var i = 0; i < CorpList.length; i++) {
                if(CorpList[i] != -1) {
                    corporateIds += CorpList[i] + "`";

                }
            }
           action +="&EntityType="+EntityType+"&entityId="+ corporateIds+"&RepID="+RepID+"&BOCreatedByID="+BOCrId+"&SECUREHKEY="+hashkey+"&FLDHASHKEY="+fldhashkey+"&BOFlag=Y";
           /* Tracker: 108382: Changes for centering popup */
	   windowAlign();
           //window.open(action,'','height=436, left=70, top=120, width=860, resizable=no, scrollbars=yes');
           window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');
            /* Tracker: 108382: End of Changes */           

        } catch (e)
        {
              DebugMessage(e.message);
        }
    }


}


/***********changes made by shikhar for corporate  AddSelectedRowToList**********/
function AddSelectedRowToList(ID) {


    var flag = false;
    var tempCorpList     	= new Array();
    var tempCorpId  		= new Array();
    var tempBOCrId  		= new Array();
    var tempAssitoId  		= new Array();
    var tempOwnerID  		= new Array();
    var tempGroupID 		= new Array();
    var tempRecord 		= new Array();
    var tempOwnGroupID 		= new Array();
    var j =0;
    IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}
    for(var i = 0; i < CorpList.length; i++) {

        if(CorpList[i] == ID ) {

            flag = true;

        }
        else{
		tempCorpList[j] 	= CorpList[i];
		tempCorpId[j]   	= CorpId[i];
		tempBOCrId[j]   	= BOCrId[i];
		tempAssitoId[j] 	= AssitoId[i];
		tempOwnerID[j]  	= OwnerID[i];
		tempGroupID[j]  	= GroupID[i];
		tempRecord[j]		=Record[i];
		tempOwnGroupID[j]  	= OwnGroupID[i]; 
		j= j+1;
        }

    }

    CorpList     	= 	    tempCorpList;
    CorpId  		= 	    tempCorpId;
    BOCrId  		= 	    tempBOCrId;
    AssitoId  		= 	    tempAssitoId;
    OwnerID  		= 	    tempOwnerID;
    GroupID 		= 	    tempGroupID;
    Record 		= 	    tempRecord;
    OwnGroupID 		= 	    tempOwnGroupID; 	


    if(!flag) {

        var corpID  = event.srcElement.parentElement.parentElement.getAttribute('CorporateModBO.corpMod_ID');
        var bOCreId  = event.srcElement.parentElement.parentElement.getAttribute('CorporateModBO.bOCreatedBy');
        var assitoId  = event.srcElement.parentElement.parentElement.getAttribute('CorporateModBO.assigned_User_ID');
        var ownersID  = event.srcElement.parentElement.parentElement.getAttribute('CorporateModBO.owner_User_ID');
        var groupID  = event.srcElement.parentElement.parentElement.getAttribute('CorporateModBO.assigned_Group_ID');
        var record  = event.srcElement.parentElement.parentElement.getAttribute('CorporateModBO.record_Status');
        var ownGroupID  = event.srcElement.parentElement.parentElement.getAttribute('CorporateModBO.OwnerGroup');



        CorpList[CorpList.length]        = ID;
        CorpId[CorpId.length]       	 = corpID;
        BOCrId[BOCrId.length]        	 = bOCreId;
        AssitoId[AssitoId.length]        = assitoId;
        OwnerID[OwnerID.length]  	 = ownersID;
        GroupID[GroupID.length]  	 = groupID;
        Record[Record.length]  		 = record;
        OwnGroupID[OwnGroupID.length]  	= ownGroupID;


      }
    }



var bSelectFlag = false;
function selectAll()
{
    try {
    	IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

        var elements = document.getElementsByTagName("input");
        if(bSelectFlag == false) {

            CorpList = new Array ();
            checkit(elements);
            var link = document.getElementsByName("Select All")[0];
            bSelectFlag = true;
        }
        else {

            CorpList = new Array ();
            uncheckit(elements);
            bSelectFlag = false;
        }
        /*return false;*/ /*TRACKER -92380 the select all checkbox to remain checked */
    }
    catch(e) {

        DebugMessage(e.message);
    }

}

function checkit(elements)
{
    IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}

    for(var i = 0; i < elements.length; i++) {
        if(elements[i].type == "checkbox") {
            elements[i].checked = true;
//changes for call id 351970 and recon for call id 349917 starts
	     	     	     if (elements[i].id != "select"){
             CorpList[CorpList.length] = elements[i].id;
             
//changes for call id 351970 and recon for call id 349917 ends
	      //Changes for tracker id: 333751 starts
    		    var corpID  = elements[i].parentElement.parentElement.getAttribute('CorporateModBO.corpMod_ID');
		    var bOCreId  = elements[i].parentElement.parentElement.getAttribute('CorporateModBO.bOCreatedBy');
     		    var assitoId  = elements[i].parentElement.parentElement.getAttribute('CorporateModBO.assigned_User_ID');
     		    var ownersID  = elements[i].parentElement.parentElement.getAttribute('CorporateModBO.owner_User_ID');
     		    var groupID  = elements[i].parentElement.parentElement.getAttribute('CorporateModBO.assigned_Group_ID');
	    	    var record  = elements[i].parentElement.parentElement.getAttribute('CorporateModBO.record_Status');
    		   
    		    CorpId[CorpId.length]        = corpID;
		    BOCrId[BOCrId.length]        = bOCreId;
		    AssitoId[AssitoId.length]    = assitoId;
		    OwnerID[OwnerID.length]  	 = ownersID;
		    GroupID[GroupID.length]  	 = groupID;
		    Record[Record.length]  	 = record;
    		 } 
    		 
     	      //Changes for tracker id: 333751 starts
		}
 	}
}


function uncheckit(elements)
{

    for(var i = 0; i < elements.length; i++) {
        if(elements[i].type == "checkbox") {
            elements[i].checked = false;
        }
    }

}

/* Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START */
function editLastEditedPage(name) {
	var LastEditedPage=getCookie('LastEditedPage');
	var entityType = getCookie('EntityType');
	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
	{
		//alert('Please select the Entity');
		showMessage(MSGJ50330);
		return;
	}
	/* Tracker 96261 Changes START */
	//LastEditedPage = 'CorporateQDE';
	/* Tracker 96261 Changes END */
	if(LastEditedPage == 'General Details' && entityType=='Non Customer'){
		editDetails('General Details','../servlet/com.infy.cis.ui.corpcif.CorpNonCustomerDetWizard?ScreenID=1211586&loadTab=General&operationType=Queue');
	}
	else
	if(LastEditedPage == 'Trade Finance Details' && entityType=='Non Customer'){
		editDetails('Trade Finance Details','../servlet/com.infy.cis.ui.corpcif.CorpNonCustomerDetWizard?ScreenID=1211587&loadTab=TradeFinance&operationType=Queue');
	}
	else
	if(LastEditedPage == 'General Details'){
		editDetails('General Details','../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?loadTab=General&operationType=Queue');
	}
	else
	if(LastEditedPage == 'Corp Rep Details'){
		editDetails('Corp Rep Details','../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?ScreenID=1191566&loadTab=CorpRep&operationType=Queue');
	}
	else
	if(LastEditedPage == 'Preferences Details'){
		editDetails('Preferences Details','../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?ScreenID=1191568&loadTab=Preferences&operationType=Queue');
	}
	else
	if(LastEditedPage == 'Financial Details'){
		editDetails('Financial Details','../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?ScreenID=1191569&loadTab=Financial&operationType=Queue');
	}
	else
	if(LastEditedPage == 'Beneficial Owner Details'){
		editDetails('Beneficial Owner Details','../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?loadTab=BeneficialOwner&operationType=Queue');
	}
	else
	if(LastEditedPage == 'Trade Finance Details'){
		editDetails('Trade Finance Details','../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?ScreenID=1191571&loadTab=TradeFinance&operationType=Queue');
	}
	else
	if(LastEditedPage == 'CorporateQDE'){
		editDetails('CorporateQDE','../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?loadTab=CorporateQDE&operationType=Queue&editFlag=Y');
	}
	else
	if(LastEditedPage == 'Relationship Details'){
			editDetails('CorporateQDE','../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?loadTab=Relationship&operationType=Queue&editFlag=Y');
	}
	else
	if(LastEditedPage == 'Basel Profiling'){
			editDetails('Basel Profiling','../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?loadTab=BaselProfiling&operationType=Queue&editFlag=Y');
        }
	else{
		//alert("LastEditedPage is not applicable for this record");
		/* Changes for Tracker # 100035 start */
		showMessage(MSGJ50331);
		/* Changes for Tracker # 100035 end */
	}
}
/* Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END */

function Recal(name,url)
{
 //alert("in recal function "+url);
  //alert("in recal function "+name);
var MakerID=getCookie('makerID');
	//alert("MakerID "+MakerID);
	var repId=getCookie('RepID');
	//alert("repId "+repId);
	
	var corpMod_ID=getCookie('corpMod_ID');
	 //alert("in recal function corpMod_ID "+corpMod_ID);
	 //alert("in recal function BOCreaID "+BOCreaID);
	
		if (repId!=MakerID)
		{	
		showMessage("Only the Maker Can Recall the Entity for Editing");
		return;
	}
	 try {
	        if (url.indexOf('?') !=-1){
	            url += "&EntityType=Customer&entityId=" + corpMod_ID+"&RepID="+repId+"&BOCreatedByID="+BOCreaID; 
	            }
	          else{
		       url += "?EntityType=Customer&entityId=" + corpMod_ID+"&RepID="+repId+"&BOCreatedByID="+BOCreaID; 
	            }
	           // alert("in recal function before "+url);
	           // parent.hiddenFrame.location.href = url;
	            parent.hiddenFrame.location.href = url+ "&TabName=" + name ;
	           // alert("in recal function after "+url);
	        } catch (ex) {
	                        DebugMessage('ex '+ ex.description);
	        }
        return true;

}
function editDetails(name, url,aScreenID) {

	var Record=getCookie('Record');
	var processId=getCookie('processID');   
	IsTampered = getCookie('IsTampered');
	//Recon for Security Audit Changes from CRM10301BSUPP
	var hashkey=getCookie('HASHKEY');
	var fldhashkey=getCookie('FLDHASHKEY');
	//Recon for Security Audit Changes from CRM10301BSUPP
			
		if(IsTampered=='Y')
		{ 	showMessage(MSGJ50260);
			return;
		}
    // Start of changes Traccker ID- 150071 for Ticket - 248867 Fix
	/* if((Record=="Under Verification") || (Record=="U"))
	{
	    Record= "U";
	    showMessage(MSGJ0385);
	    return;
	}*/
	//if(processId!='' && Record!= 'D'){                        //  || Record != 'D'){		   
	// End of changes Traccker ID- 150071 for Ticket - 248867 Fix	
    //Changes Begin for Tracker Id :122031
	//if(processId!='' && (Record== 'F'||Record== 'C'||Record== 'A'||Record== 'U')){
	//Changes End for Tracker Id :122031
	//alert("in editDetails function RendSRMCorpModRightClick Record in if "+Record);
		//showMessage(MSGJ0385);

	//}else {
	
	var MakerID=getCookie('makerID');
	//alert("MakerID "+MakerID);
	var repId=getCookie('RepID');
	//alert("repId "+repId);
	if (repId!=MakerID)
		{	
		showMessage("Only the Maker can Edit the Entity");
		return;
	}

		if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
		showUserMessage("MSG014","MSG_ACCT");
		return;
		}
		// Tracker ID - 90197 Begin of Changes for attribute masking
		AccessOwnerGroup = getCookie('AccessOwnerGroup');
       		//  Tracker ID - 90197 End of Changes
		expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));
		corpId  = getCookie('corpMod_ID');
		corpKey  = getCookie('corp_Key');
		corpName  = getCookie('corpName');
		entityType = getCookie('EntityType');
		coreCustID = getCookie('coreCustID');
		/* Tracker # 98769 Begin of Changes */
    		var isMCEdited=getCookie('isMCEdited');
		Doi	= getCookie('doi');
		//CIF fix
		fromEdit = 'N';
        var tfFlag = getCookie("tfFlag");
        /* Changes for Tracker # 100035 - check done for 'Non Customer' also - start */
        if((tfFlag == 'N' || tfFlag == '') && (name == 'Trade Finance Details') && (entityType != 'Non Customer')) /* Changes for Tracker # 100035 end */
        {
        showMessage(MSGJ50276);
        return;
        }
		if(checkCookie(corpId)=="InValid"){
		showUserMessage("MSG007","MSG_ACCT");
		return;

		}
     var blacklisted = getCookie("BlackListed");
     var suspended = getCookie("Suspended"); 
     var negated = getCookie("Negated");
		/*Tracker ID 105265 begin of Changes */
		/* Change for ticket 321682 start */
		servletURL = url + '&corpId='+corpId + '&entityType='+entityType+'&corpKey='+corpKey+ '&coreCustID=' + coreCustID + '&fetchFrom=Mod'+'&doi='+Doi +'&AccessOwnerGroup='+AccessOwnerGroup+'&fromEdit='+fromEdit+'&isMCEdited='+isMCEdited;
		/* Change for ticket 321682 end */
		/*Tracker ID 105265 end of Changes */
		/* Tracker # 98769 End of Changes */ 
/*Recon for Security Audit Changes from CRM10301BSUPP */
servletURL = servletURL + '&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&chkBSN=true';
/*Recon for Security Audit Changes from CRM10301BSUPP */
		/* Tracker: 108382: Changes for centering popup */
        	windowAlign();
		//window.open(servletURL,'','height=436, left=70, top=120, width=860, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
		window.open(servletURL,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', location=no, menubar=no, resizable=yes, status=no, toolbar=no,scrollbars=yes');//Fix for ticket 321672
		/* Tracker: 108382: End of Changes */

	 //}

}

function copyRec(url) {


	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
	        showUserMessage("MSG014","MSG_ACCT");
	        return;
	    }
	    IsTampered = getCookie('IsTampered');
	    //Recon for Security Audit Changes from CRM10301BSUPP
	var hashkey=getCookie('HASHKEY');
	var fldhashkey=getCookie('FLDHASHKEY');
	//Recon for Security Audit Changes from CRM10301BSUPP		
	    	if(IsTampered=='Y')
	    	{ 	showMessage(MSGJ50260);
	    		return;
		}
	    // Tracker ID - 90197 Begin of Changes for attribute masking
	    AccessOwnerGroup = getCookie('AccessOwnerGroup');
           //  Tracker ID - 90197 End of Changes
		corpId  = getCookie('corpMod_ID');
		corpKey  = getCookie('corp_Key');
		corpName  = getCookie('corpName');
		entityType = getCookie('EntityType');
		coreCustID = getCookie('coreCustID');
	    if(checkCookie(corpId)=="InValid"){

	        showUserMessage("MSG007","MSG_ACCT");
	        return;

	    }
			//Recon of Changes for FS : 716376 TOL : 444472 starts
	    if(entityType=='Non Customer'){
	    url='../servlet/com.infy.cis.ui.corpcif.CorpNonCustomerDetWizard?menuItemId=700716&IsReadOnly=Y';
}
			//Recon of Changes for FS : 716376 TOL : 444472 ends
	    /* Change for ticket 321682 start */
	    //Recon for Security Audit Changes from CRM10301BSUPP
   	servletURL = url + '&corpId='+corpId + '&entityType='+entityType+'&corpKey='+corpKey+ '&fetchFrom=Mod'+'&coreCustID='+coreCustID+'&AccessOwnerGroup='+AccessOwnerGroup+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
   	//Recon for Security Audit Changes from CRM10301BSUPP
   	/* Change for ticket 321682 end */
	/* Tracker: 108382: Changes for centering popup */
        windowAlign();
	//window.open(servletURL,'','height=436, left=70, top=120, width=860,  location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
	window.open(servletURL,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',  location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
	/* Tracker: 108382: End of Changes */





    }

/* changes for RCL starts */	
function editEvent(a,constURL)
/* changes for RCL end */	
{

      //Recon for Security Audit Changes from CRM10301BSUPP
      	var hashkey=getCookie('HASHKEY');
      	var fldhashkey=getCookie('FLDHASHKEY');
	//Recon for Security Audit Changes from CRM10301BSUPP

      corpId = getCookie('corpMod_ID');

      corpKey = getCookie('corp_Key');
      IsTampered = getCookie('IsTampered');
      		
      	if(IsTampered=='Y')
      	{ 	showMessage(MSGJ50260);
      		return;
	}

      // Tracker ID - 90197 Begin of Changes for attribute masking
      AccessOwnerGroup = getCookie('AccessOwnerGroup');
      //  Tracker ID - 90197 End of Changes



      if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){

      showUserMessage("MSG014","MSG_ACCT");

      return;

      }


       /* changes for RCL starts */	
        //Recon for Security Audit Changes from CRM10301BSUPP
       var fServletURL = constURL+"&isPopup=Yes&corpID="+corpId+"&AccessOwnerGroup="+AccessOwnerGroup+"&corpKey="+corpKey+"&CIFType=C"+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
     
       /* changes for RCL ends */
       var win = window.open(fServletURL, '','height=436, left=70, top=120, width=860, resizable=yes, ,titlebar=no,toolbar=no,status=no,scrollbars=yes');//Fix for ticket 321672

}


/*Changes for Escalation Log in CIF*/
function showEscalationLogs(wndName,Url)
{
     
     if(CheckIfRowSelected() == 'false') {
            showUserMessage ('MSG014','MSG_ENT');
            return;
    }
    
    
     corpId = getCookie('corpMod_ID');
     //Recon for Security Audit Changes from CRM10301BSUPP
     	var hashkey=getCookie('HASHKEY');
     	var fldhashkey=getCookie('FLDHASHKEY');
	//Recon for Security Audit Changes from CRM10301BSUPP	
     
     if(checkCookie(corpId)=="InValid"){
                 return;
        }
     
     
     if (corpId != null) 
     {
	     sEntity="CorporateMod";
	     /* TRACKER ID:164783 CHANGES BEGIN */ 
         //Recon for Security Audit Changes from CRM10301BSUPP
	     Url=Url+'&sCifID='+corpId+'&sEntity='+sEntity+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
         //Recon for Security Audit Changes from CRM10301BSUPP
	     /* TRACKER ID:164783 CHANGES END */
     }

    /* Tracker: 108382: Changes for centering popup */
    windowAlign();
    //window.open(Url,'','height=436, left=70, top=120, width=860, resizable=no ,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    window.open(Url,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no ,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    /* Tracker: 108382: End of Changes */
}
/*Changes for Escalation Log in CIF*/




function GetAsAssignee(name,url) {
    IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}    
    var strAssOwn = 'Y';
    var temp = local_prefix;
    local_prefix = "";
    local_prefix = temp;
    var Flag='Y';
    var EntityType=getCookie('EntityType');
    //Recon for Security Audit Changes from CRM10301BSUPP
    var hashkey=getCookie('HASHKEY');
    var fldhashkey=getCookie('FLDHASHKEY'); 
    //Recon for Security Audit Changes from CRM10301BSUPP
    var RepID = document.frm2.RepID.value;
    for(var i=0; i < CorpList.length; i++)
    {
	 if(CorpList[i]!=-1)
	  {
	  
	  

	    if(GroupID[i]!=grpid){
	    strAssOwn='P';
	    
	  }
     }
     }
     //Tracker 106344
     
     if(strAssOwn=='Y'){	
	
           var elements = document.getElementsByTagName("input");
 	   var corpIds="";
	   for(var i = 0; i < CorpList.length; i++)
	   {
		if(CorpList[i] != -1)
		{
			corpIds += CorpList[i] + ",";
			var last=corpIds.lastIndexOf(',');
		}
	   }
           corpIds=corpIds.substr(0,last);
	   if (corpIds=="")
	   {
		showMessage(MSGJ0378);
		return "false";
	   }


	   var getFirst = "";
	   entityURL = getCookie('CorporateURL');
	   var entityURLs = corpIds;
	   strAssOwn = 'A';
    //Recon for Security Audit Changes from CRM10301BSUPP
 	   parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.corpcif.getModCorporate?EntityType='+EntityType+'&entityURL='+ entityURLs+ '&getFirst='+ getFirst+'&param2='+ entityURLs +'&Flag='+Flag+'&strAssOwn='+strAssOwn+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
    //Recon for Security Audit Changes from CRM10301BSUPP
	}
	else
	    verifyCorp(strAssOwn);



}
//}


function GetAsOwner(name,url) {
    IsTampered = getCookie('IsTampered');
    		
    	if(IsTampered=='Y')
    	{ 	showMessage(MSGJ50260);
    		return;
	}	 
	 var strAssOwn = 'Y';
 	 var len=0;    
	 var temp = local_prefix;
	 local_prefix = "";
	 local_prefix = temp;
	 var Flag='Y';
	 var EntityType=getCookie('EntityType');
    //Recon for Security Audit Changes from CRM10301BSUPP
	 var hashkey=getCookie('HASHKEY');
         var fldhashkey=getCookie('FLDHASHKEY');
    //Recon for Security Audit Changes from CRM10301BSUPP
	 var RepID = document.frm2.RepID.value;
	 for(var i=0; i < CorpList.length; i++)
	 {
	    if(CorpList[i]!=-1)
	    {
	       
	       
	       if(OwnGroupID[i]!=grpid)
		   strAssOwn='Q';
	     }
	 }
	 
	 if(strAssOwn=='Y'){
	    var elements = document.getElementsByTagName("input");
	    var corpIds="";
	    for(var i = 0; i < CorpList.length; i++)
		{
			if(CorpList[i] != -1)
			{
				corpIds += CorpList[i] + ",";
				var last=corpIds.lastIndexOf(',');
			}
		}
	     corpIds=corpIds.substr(0,last);
	     if (corpIds=="")
		{
				showMessage(MSGJ0378);
				return "false";
		}


	    var getFirst = "";
	    entityURL = getCookie('CorporateURL');
	    var entityURLs = corpIds;
	    strAssOwn = 'O';
    //Recon for Security Audit Changes from CRM10301BSUPP
	    parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.corpcif.getModCorporate?EntityType='+EntityType+'&entityURL='+ entityURLs+ '&getFirst='+ getFirst+'&param2='+ entityURLs +'&Flag='+Flag+'&strAssOwn='+strAssOwn+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
    //Recon for Security Audit Changes from CRM10301BSUPP
	}
	else
	    verifyCorp(strAssOwn);



}

function verifyCorp(strAssOwn){
	var len=0;
	var a=0;
	var o=0;
	for(var i = 0; i < CorpList.length; i++)
	{
	 if(CorpList[i]!=-1)
	     len++;
	}
	if(strAssOwn=='P')
	{
	 for(var i = 0; i < CorpList.length; i++)
	   {
	     if(CorpList[i]!=-1)
	      {
		 if(OwnGroupID[i]==grpid && GroupID[i]!=grpid)
			 o++;
	      }
	    }

	 if(o==len)
	     showMessage(MSGJ50404);
	 else
	     showMessage(MSGJ50405);
	}
	if(strAssOwn=='Q')
	{
	 for(var i = 0; i < CorpList.length; i++)
	   {
	     if(CorpList[i]!=-1)
	      {
		 if(GroupID[i]==grpid && OwnGroupID[i]!=grpid)
		 	a++;
	       }
	    }
	 if(a==len)
	     showMessage(MSGJ50406);
	 else
	     showMessage(MSGJ50405);
	}
}























