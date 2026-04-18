document.write('<script language="javascript" src="'+applPath+'/common/js/SSOUtils.js"></script>');
 /*Ticket ID: 312808 CHanges Begin */
document.write('<script language="javascript" src="'+applPath+'/common/js/ContextSwitch.js"></script>');
 /*Ticket ID: 312808 CHanges end */
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



//right click menu changes begin
function checkCookie(x){
    if(x!=0 &&x != null && x != 'null' && x != "" && x!='undefined') { 
        return "Valid" ;
    }else{
        return "InValid";
    }
}

function showDefTabs() {  
  try{
    //oldRows=parent.parent.SearchList.rows;
    /*if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
      if(oldRows.substring(0,2)=="22"){
        parent.parent.SearchList.rows="22%, 78%, 0%, 0%";
      }else if(oldRows.substring(0,2)=="33"){
        parent.parent.SearchList.rows="33%, 67%, 0%, 0%";
      }
      return; 
    }
    if(oldRows.substring(0,2)=="22"){
      parent.parent.SearchList.rows="22%, 38%, 40%, 0%";
    }else if(oldRows.substring(0,2)=="33"){
      parent.parent.SearchList.rows="33%, 38%, 29%, 0%";
    }*/
    
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="true"){
    
    	/*Tracker:108381:Search and Tertiary Pane Size Change for 360 Degrees*/
           
           parent.parent.SearchList.rows="29%, *, 25%, 0%";
           
    	/*Tracker:108381:End of Changes*/
      }
    
  }catch(e){
  }
    try{
            populateRClickViewDS(); 
        }catch (e){
            if(e.description == "Object expected"){
                window.setTimeout("showDefTabs()",50);
                return;
                
            }
        
        }
  parent.parent.defTabs = new Array();
    parent.parent.defTabsURL = new Array();

    allTabNames = new Array();    
    if(parent.parent.SecondaryWorkArea.tabViewFrm) {
        allTabNames = parent.parent.SecondaryWorkArea.tabViewFrm.getAllSelectedTabNames();
    }       
    selectedTabName = '';
    if(parent.parent.SecondaryWorkArea.tabViewFrm) {        
        selectedTabName = parent.parent.SecondaryWorkArea.tabViewFrm.getSelectedTabName()
    }
    if(allTabNames.length == 0) {
        defTabs();
    }   
    for(i = 0; i < allTabNames.length; i++) {
        for(j = 0; j <  rClickNameDS.length; j++) {
            if(allTabNames[i] == rClickNameDS[j]) {             
                parent.parent.defTabs[parent.parent.defTabs.length] = rClickNameDS[j];    
                parent.parent.defTabsURL[parent.parent.defTabsURL.length] = rClickURLDS[j];
                break;
            }     
        }
    }    
    //parent.parent.selTabName = selectedTabName;  
    parent.parent.SecondaryWorkArea.location.href='../servlet/com.infy.cis.ui.common.SRMDynamicTabsView';
}
  



///
function getURL(viewName,objectId){
    <!--Tracker:90196: Changes for Attribute Masking-->	    		
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    <!--Tracker:90196: End of Changes-->
    var sOrder = getCookie('SORT_ORDER_'+viewName);
    if(sOrder ==null || sOrder == 'null' || sOrder =='undefined') { 
        sOrder ='';
    }

    var sColumn = getCookie('SORT_COLUMN_'+viewName);
    if(sColumn ==null || sColumn == 'null' || sColumn =='undefined') {
    sColumn ='';
    }
    var url= "../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName="
            + viewName + "&Param1=" +  objectId 
            + '&SortOrder='+sOrder+'&SortColumn='+sColumn+'&AccessOwnerGroup='+AccessOwnerGroup ;

    return url;
}


function def_showUrl(name,url){
    objectId = getCookie("AccountID");
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    customerRole=getCookie('CustomerRole');
    contactRole=getCookie('ContactRole');
    contactID = getCookie('ContactID');
    if(checkCookie(objectId)=="InValid"){
        return;
    }
    if(customerRole=='Main Account Holder'){
          parent.parent.defTabs[parent.parent.defTabs.length] = name;  
          parent.parent.defTabsURL[parent.parent.defTabsURL.length] = url+objectId+'&AccessOwnerGroup='+AccessOwnerGroup;
        }
        else if(contactRole=='Main Account Holder'){
        conturl='../servlet/com.infy.cis.ui.admin.Contact_det?IsReadOnly=Y&contactId='
        parent.parent.defTabs[parent.parent.defTabs.length] = name; 
        parent.parent.defTabsURL[parent.parent.defTabsURL.length] = conturl+contactID+'&AccessOwnerGroup='+AccessOwnerGroup;
    } 

}

function showNewWindow(url){
loadURL = url;
/* Tracker: 108382: Changes for centering popup */
windowAlign();
/* Tracker: 108382: End of Changes */
writeToNewWindow();
/*    var hnew=  window.open('../common/html/SSOblank.html',  '','directories=No, height=600, left=100, top=100, width=900, location=no, menubar=no, resizable=yes, status=no, toolbar=no,scrollbars');

    hnew.document.write("<Title>" + getTitle() + "</Title>");
    hnew.document.write("<FRAMESET id='TOCFrmSet' FRAMEBORDER=0 FRAMESPACING=0 ROWS='95%,*'>")
    hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= \"" + url + "\"/>");    
    hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= '../common/html/CloseOption.html'/>");            
    hnew.document.write('</FRAMESET>');         
    hnew.focus();
*/
}

function showAccStatistics(name,url)
{ 
//Security Recon Changes : Tracker Id : 356601 

var hashkey=getCookie('HASHKEY');
var fldhashkey=getCookie('FLDHASHKEY');


  <!--Tracker:90196: Changes for Attribute Masking-->	    		
  AccessOwnerGroup = getCookie('AccessOwnerGroup');
  <!--Tracker:90196: End of Changes-->
  saleURL = getCookie('BankAccountURL');
  accountNumber= getCookie('BankAccountNumber');
  corpID = getCookie('CorpID');
  acckey= getCookie('AccountKey');
  mcyind= getCookie('MCYInd');
  AccountID = getCookie("AccountID");
  bankAccountId = getCookie('bankAccountID');
  
  
  if(checkCookie(accountNumber)=="InValid"){
        showUserMessage("MSG291","MSG_BANKACCT");
        return;
    }
  /*  FCRM6206 :TRACKER:62159: BEGIN OF CHANGES */
    url = url + "?accountNumber=" + accountNumber +"&saleURL=" + saleURL + "&AccessOwnerGroup="+AccessOwnerGroup+"&AccStatReadMode=Y&AccKey="+acckey+"&MCYInd="+mcyind+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&corpId='+corpID+'&AccountID='+AccountID+'&AccountNumber='+accountNumber; 
 
  
  Ornaments = 'directories=No, height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=yes, status=no, toolbar=no,scrollbars';
  loadURL = url;
  /* Tracker: 108382: Changes for centering popup */
  windowAlign();
 /* Tracker: 108382: End of Changes */
 writeToNewWindow();
//    showNewWindow(url);
  /*  FCRM6206 :TRACKER:62159: End OF CHANGES */

}

/*  CRM61SR:TRACKER:45175:BEGINOFCHANGES */ 
/*Added three new functions , first for the pop of small window instead of the bigger one , second 
  for showing the Online Account Balance from BankAway ejb's and third for getting the last 10
  transaction details from BankAway ejb's.
*/
/*
function showNewSmallWindow(url){
    var hnew=  window.open('../common/html/SSOblank.html',  '','directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=yes, status=no, toolbar=no,scrollbars');

    hnew.document.write("<Title>" + getTitle() + "</Title>");
    hnew.document.write("<FRAMESET id='TOCFrmSet' FRAMEBORDER=0 FRAMESPACING=0 ROWS='95%,*'>")
    hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= \"" + url + "\"/>");    
    hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= '../common/html/PrintCloseOption.html'/>");            
    hnew.document.write('</FRAMESET>');         
    hnew.focus();

}

function showOnlineAccountBalance(name,url)
{ 
//Security Recon Changes : Tracker Id : 356601 STARTS
var hashkey=getCookie('HASHKEY');									
var fldhashkey=getCookie('FLDHASHKEY');
  srmUrl = getCookie('BankAccountURL');
  accountNumber= getCookie('BankAccountNumber');
  var productskey = getCookie('productskey');
  if(checkCookie(accountNumber)=="InValid"){
        showUserMessage("MSG291","MSG_BANKACCT");
        return;
    }
   if(productskey == "SB190")
   {
   alert("You are not authorised to view");
   return;
   }
  showNewSmallWindow(url + "&accountNumber=" +accountNumber +"&srmUrl=" +srmUrl);
}

function showLast10Txn(name,url)
{ 


  srmUrl = getCookie('BankAccountURL');
  accountNumber= getCookie('BankAccountNumber');
  var productskey = getCookie('productskey');
  if(checkCookie(accountNumber)=="InValid"){
        showUserMessage("MSG291","MSG_BANKACCT");
        return;
    }

if(productskey == "SB190")
   {
   alert("You are not authorised to view");
   return;
   }
    showNewSmallWindow(url + "&accountNumber=" +accountNumber +"&srmUrl=" +srmUrl+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey);
}
*/
/* CRM61SR:TRACKER:45175:ENDOFCHANGES */ 


/********************************************************************
function populate_showUrl(url){

    objectId = getCookie("AccountID");
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    
    if(checkCookie(objectId)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
    }else{
        //rClickURLDS[rClickURLDS.length]=getURL(viewName,objectId);
        rClickURLDS[rClickURLDS.length] = url+objectId+"&AccessOwnerGroup="+AccessOwnerGroup;
    }

}


function getActivityHistoryURL(objectId){
        local_prefix = 'all';
        var activityCookieStr = '';
        var selectAll= getCookie('selectAll');
        var dateSelected= getCookie('selectByDate');            
        var rangeSelected = getCookie('dateSelection');
        var monthsText = getCookie('monthsOrDaysValue');           
        var fromTxt = getCookie('fromTxt');
        var toTxt = getCookie('toTxt');
        var channelSelected= getCookie('selectByChannel');            
        var channelsLst = getCookie('channelsSelected');                
        var channelsTxtLst = getCookie('channelsTextSelected');      
        var partnerSelected= getCookie('selectByPartner');            
        var partnersLst = getCookie('partnersSelected');
        var partnersTxtLst = getCookie('partnersTextSelected');
        var repSelected= getCookie('selectByRep');
        var repsLst = getCookie('repsSelected');
        var repsTxtLst = getCookie('repsTextSelected');
        var groupSelected= getCookie('selectByGroup');
        var groupsLst = getCookie('groupsSelected');
        var groupsTxtLst = getCookie('groupsTextSelected');
        var sysSelected= getCookie('selectBySys');            
        var sortOrder = getCookie('SORT_ORDER_AccountHistory');
        var sortColumn = getCookie('SORT_COLUMN_AccountHistory');            
        local_prefix = "SearchConsole";

        if(sortOrder ==null || sortOrder == 'null' || sortOrder =='undefined') { 
            sortOrder ='';
        }
        if(sortColumn ==null || sortColumn == 'null' || sortColumn =='undefined') {
            sortColumn ='';
        }

        if (selectAll != "null" && selectAll != null && selectAll == "true") {
            activityCookieStr = '&all=true&SortOrder='+sortOrder+'&SortColumn='+sortColumn;
        }else{
            if (dateSelected != "null" && dateSelected != null && dateSelected == "true") {
                var dateVal = "y";
            }
            if (rangeSelected != "null" && rangeSelected != null) {
                var dateSelection = rangeSelected;
            }
            if (channelSelected != "null" && channelSelected != null && channelSelected == "true") {
                var channelVal = "y";
            }
            if (partnerSelected != "null" && partnerSelected != null && partnerSelected == "true") {
                var partnerVal = "y";
            }
            if (repSelected != "null" && repSelected != null && repSelected == "true") {
                var repVal = "y";
            }
            if (groupSelected != "null" && groupSelected != null && groupSelected == "true") {
                var groupVal = "y";
            }
            if (sysSelected != "null" && sysSelected != null && sysSelected == "true") {
                var sysVal = "y";
            }
            if (channelsLst != "null" && channelsLst != null) {
                var channelAllVal = channelsLst;
            }
            if (partnersLst != "null" && partnersLst != null) {
                var partnerAllVal = partnersLst;
            }
            if (repsLst != "null" && repsLst != null) {
                var repAllVal = repsLst;
            }
            if (groupsLst != "null" && groupsLst != null) {
                var groupAllVal = groupsLst;
            }
            if (channelsLst != "null" && channelsLst != null) {
                var channelAllText = channelsTxtLst;
            }
            if (partnersLst != "null" && partnersLst != null) {
                var partnerAllText = partnersTxtLst;
            }
            if (repsLst != "null" && repsLst != null) {
                var repAllText = repsTxtLst;
            }
            if (groupsLst != "null" && groupsLst != null) {
                var groupAllText = groupsTxtLst;
            }

            activityCookieStr = '&dateVal='+dateVal+'&dateSelection='+dateSelection+'&monthsTxt='+monthsText
                +'&fromTxt='+fromTxt+'&toTxt='+toTxt+'&channelVal='+channelVal+'&partnerVal='+partnerVal
                +'&repVal='+repVal+'&groupVal='+groupVal+'&channelAllText='+channelAllText+'&partnerAllText='+partnerAllText
                +'&repAllText='+repAllText+'&groupAllText='+groupAllText+'&channelAllVal='+channelAllVal
                +'&partnerAllVal='+partnerAllVal+'&repAllVal='+repAllVal+'&groupAllVal='+groupAllVal
                +'&groupAllText='+groupAllText+'&sysVal='+sysVal+'&SortOrder='+sortOrder+'&SortColumn='+sortColumn;
        }

        var actURL=  '../servlet/com.infy.cis.ui.common.ActivityHistoryDisplay?'+
                'EntityType=Account&ViewName=AccountHistory'+
                '&parComp=parent.parent.parent.dynamicTabFrm.frames(0)&typeId=' 
                + objectId + activityCookieStr;
                
        return actURL               

}

function def_activityHistory(name,url){
    objectId = getCookie('AccountID');
    if(checkCookie(objectId)=="InValid"){
        return;
    }else{
        parent.parent.defTabs[parent.parent.defTabs.length] = name;    
        parent.parent.defTabsURL[parent.parent.defTabsURL.length] =getActivityHistoryURL(objectId);

    }
}


function populate_activityHistory(url){
    objectId = getCookie("AccountID");
    if(checkCookie(objectId)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
    }else{
        rClickURLDS[rClickURLDS.length] = getActivityHistoryURL(objectId);
    }

}



//right click menu changes end


function showAccountInfo(name, url) {  
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }

    accountID  = getCookie('AccountID');
    if(checkCookie(accountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;

    }
    servletURL = url + accountID;

    parent.parent.SecondaryWorkArea.addTab(name, servletURL);
}

function showNewWindow(url){
    var hnew=  window.open('../common/html/SSOblank.html',  '','directories=No, height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=yes, status=no, toolbar=no,scrollbars');

    hnew.document.write("<Title>" + getTitle() + "</Title>");
    hnew.document.write("<FRAMESET id='TOCFrmSet' FRAMEBORDER=0 FRAMESPACING=0 ROWS='95%,*'>")
    hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= \"" + url + "\"/>");    
    hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= '../common/html/CloseOption.html'/>");            
    hnew.document.write('</FRAMESET>');         
    hnew.focus();

}

function showAccountDet(name,url) {


    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }

    accountId = getCookie('AccountID');
    if(checkCookie(accountId)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }
    showNewWindow(url+accountId);    
}

**************************************************************************/


function createActivity(name, url) {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }

    saleURL= getCookie('BankAccountURL');
    if(checkCookie(accountURL)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;

    }
    window.open(url + "&objectType=Sale&objectURL=" + saleURL , 'CreateAccountActivity','height=436,width=900,left=50,top=120,resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');
}

 /* Begin of Changes for RCL Security Fix */  
function showUrl(aTabName,aViewName,aScreenID,constURL) {


var hashkey=getCookie('HASHKEY');
var fldhashkey=getCookie('FLDHASHKEY');

 /* end of Changes for RCL Security Fix */	  
    <!--Tracker:90196: Changes for Attribute Masking-->	    		
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    <!--Tracker:90196: End of Changes-->
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    /* Tracker No. 46461 change started */ 
    accountID  = getCookie('AccountID');
    /* Tracker No. 46461 change ended */
    if(checkCookie(accountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;

    }


    var sOrder = getCookie('SORT_ORDER_'+aViewName);
    if(sOrder ==null || sOrder == 'null' || sOrder =='undefined') { 
        sOrder ='';
    }

    var sColumn = getCookie('SORT_COLUMN_'+aViewName);
    if(sColumn ==null || sColumn == 'null' || sColumn =='undefined') {
        sColumn ='';
    }
    /* Changes for Audit Enquiry CRMBAR02 Starts*/
    
/* ScreenId has been included in the Query String */
 /* Begin of Changes for RCL Security Fix */  
    
    var fServletURL = constURL+"&ViewName="+aViewName+"&Param2=" + 
            accountID +"&OrgID="+accountID +'&AccessOwnerGroup='+AccessOwnerGroup+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&SortOrder='+sOrder+'&SortColumn='+sColumn+'&ScreenID=' + aScreenID ;
            /* Changes for Audit Enquiry CRMBAR02 Ends*/

	  /* End of Changes for RCL Security Fix */ 
    parent.parent.SecondaryWorkArea.addTab(aTabName, fServletURL);
}

/* CRM61SR:SREVNTBO:TRACKER# 44228 **BEGIN  CHANGES** */
function showUrl1(aTabName,aViewName) {

    <!--Tracker:90196: Changes for Attribute Masking-->	    		
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    <!--Tracker:90196: End of Changes-->
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    
    BankAccountID  = getCookie('bankAccountID');
    if(checkCookie(BankAccountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;

    }


    var sOrder = getCookie('SORT_ORDER_'+aViewName);
    if(sOrder ==null || sOrder == 'null' || sOrder =='undefined') { 
        sOrder ='';
    }

    var sColumn = getCookie('SORT_COLUMN_'+aViewName);
    if(sColumn ==null || sColumn == 'null' || sColumn =='undefined') {
        sColumn ='';
    }
    var fServletURL = "../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName="+aViewName+"&Param4=" + 
            BankAccountID + '&SortOrder='+sOrder+'&SortColumn='+sColumn+'&AccessOwnerGroup='+AccessOwnerGroup;

    parent.parent.SecondaryWorkArea.addTab(aTabName, fServletURL);
}

function EditEvent(name, url) {  
    <!--Tracker:90196: Changes for Attribute Masking-->	    		
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    <!--Tracker:90196: End of Changes-->
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
    saleID  = getCookie('bankAccountID');
    bankAccountNumber  = getCookie('BankAccountNumber');
  if(checkCookie(saleID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }
    
  if(checkCookie(bankAccountNumber)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }
    
    
    
    servletURL = url + saleID + "&bankAccountNumber=" + bankAccountNumber+"&AccessOwnerGroup="+AccessOwnerGroup;
    window.open(servletURL, 'NewEvent','height=436,width=900,left=50,top=120,resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');
}

/* CRM61SR:SREVNTBO:TRACKER# 44228 **END OF  CHANGES** */

function accessPriviledge(name, url) {

    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
  
    saleURL= getCookie('BankAccountURL');

    if(checkCookie(saleURL)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;

    }

    url=url+"?boName=Sale&boURL=" + saleURL ;
    parent.parent.hiddenFrame.location.href=url;
    
}

function showCustomerInfo(name, url) { 
  <!--Tracker:90196: Changes for Attribute Masking-->	    		
  AccessOwnerGroup = getCookie('AccessOwnerGroup');
  <!--Tracker:90196: End of Changes-->
  if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }

    accountID  = getCookie('AccountID');
    if(checkCookie(accountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;

    }
    servletURL = url + accountID+'&AccessOwnerGroup='+AccessOwnerGroup;
    

    parent.parent.SecondaryWorkArea.addTab(name, servletURL);
}

function showCorpCustomerInfo(name, url) {  


  <!--Tracker:90196: Changes for Attribute Masking-->	    		
  AccessOwnerGroup = getCookie('AccessOwnerGroup');
  <!--Tracker:90196: End of Changes-->
  if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }

    accountID  = getCookie('CorpID');
    if(checkCookie(accountID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;

    }
    servletURL = url + accountID+'&AccessOwnerGroup='+AccessOwnerGroup;
  
    if(parent.parent.SecondaryWorkArea.tabViewFrm) {        
        selectedTabName = parent.parent.SecondaryWorkArea.tabViewFrm.getSelectedTabName()
    	if(selectedTabName == "Customer Basic Information"){
    		parent.parent.SecondaryWorkArea.location.href='../servlet/com.infy.cis.ui.common.SRMDynamicTabsView';
    	}
    }
    parent.parent.SecondaryWorkArea.addTab(name, servletURL);
}


function def_showCustomerInfo(name, url){

//Security Recon Changes : Tracker Id : 356601 

var hashkey=getCookie('HASHKEY');									
var fldhashkey=getCookie('FLDHASHKEY');



    <!--Tracker:90196: Changes for Attribute Masking-->	    		
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    <!--Tracker:90196: End of Changes--> 
    accountID = getCookie('AccountID');
   accountNumber= getCookie('BankAccountNumber');
    
   
    /** TRACKER : 68864 BEGIN **/
    contactID = getCookie('ContactID');
    customerRole=getCookie('CustomerRole');
    contactRole=getCookie('ContactRole');
    if(checkCookie(accountID)=="InValid" && checkCookie(contactID)=="Invalid"){
       return;
    }   
    if(customerRole=='Main Account Holder'){
      parent.parent.defTabs[parent.parent.defTabs.length] = name;  
		//changes for ticket 626303
      parent.parent.defTabsURL[parent.parent.defTabsURL.length] = url+accountID+'&AccessOwnerGroup='+AccessOwnerGroup+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
    }
    else if(contactRole=='Main Account Holder'){
      conturl='../servlet/com.infy.cis.ui.admin.Contact_det?IsReadOnly=Y&contactId='
      parent.parent.defTabs[parent.parent.defTabs.length] = name; 
      parent.parent.defTabsURL[parent.parent.defTabsURL.length] = conturl+contactID+'&AccessOwnerGroup='+AccessOwnerGroup+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
    } 
    /** TRACKER : 68864 END **/
}

function populate_showCustomerInfo(url){


    <!--Tracker:90196: Changes for Attribute Masking-->	    		
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    <!--Tracker:90196: End of Changes-->    
    /** TRACKER : 68864 BEGIN **/
    customerRole=getCookie('CustomerRole');
    contactRole=getCookie('ContactRole');
    accountID = getCookie('AccountID');
    contactID = getCookie('ContactID');
    BankAccountID  = getCookie('bankAccountID');
    if(customerRole=='Main Account Holder'){
       if(checkCookie(accountID)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
       }else{
        rClickURLDS[rClickURLDS.length] = url + accountID+"&AccessOwnerGroup="+AccessOwnerGroup;
       }
    }    
    else if(contactRole=='Main Account Holder'){
       conturl='../servlet/com.infy.cis.ui.admin.Contact_det?IsReadOnly=Y&contactId='
       if(checkCookie(contactID)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
       }else{
        rClickURLDS[rClickURLDS.length] = conturl + contactID+"&AccessOwnerGroup="+AccessOwnerGroup;
       }
    }
    /** TRACKER : 68864 END **/
}

/*Tracker:108381:Changes for 360Degree tertiary pane default tab*/
function def_showIncidents(name, url){


//Security Recon Changes : Tracker Id : 356601 

var hashkey=getCookie('HASHKEY');									
var fldhashkey=getCookie('FLDHASHKEY');


   	    		
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
     
    accountID = getCookie('AccountID');
    contactID = getCookie('ContactID');
    customerRole=getCookie('CustomerRole');
    contactRole=getCookie('ContactRole');
    
   //Security Recon Changes : Tracker Id : 356601 
     accountNumber= getCookie('BankAccountNumber');
     incidentID = getCookie('IncidentId');
 
     
   
     
    if(checkCookie(accountID)=="InValid" && checkCookie(contactID)=="Invalid"){
       return;
    }   
    if(customerRole=='Main Account Holder'){
      parent.parent.defTabs[parent.parent.defTabs.length] = name;  
      
    
      parent.parent.defTabsURL[parent.parent.defTabsURL.length] = url+accountID+'&AccountNumber='+accountNumber+'&incidentId='+incidentID+'&AccessOwnerGroup='+AccessOwnerGroup+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
   
   }
    else if(contactRole=='Main Account Holder'){
      conturl='../servlet/com.infy.cis.ui.admin.Contact_det?IsReadOnly=Y&contactId='
      parent.parent.defTabs[parent.parent.defTabs.length] = name; 
      parent.parent.defTabsURL[parent.parent.defTabsURL.length] = conturl+contactID+'&AccessOwnerGroup='+AccessOwnerGroup+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
    } 
    
}

function populate_showIncidents(url){
     		
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    
    customerRole=getCookie('CustomerRole');
    contactRole=getCookie('ContactRole');
    accountID = getCookie('AccountID');
    contactID = getCookie('ContactID');
    BankAccountID  = getCookie('bankAccountID');
    if(customerRole=='Main Account Holder'){
       if(checkCookie(accountID)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
       }else{
        rClickURLDS[rClickURLDS.length] = url + accountID+"&AccessOwnerGroup="+AccessOwnerGroup;
       }
    }    
    else if(contactRole=='Main Account Holder'){
       conturl='../servlet/com.infy.cis.ui.admin.Contact_det?IsReadOnly=Y&contactId='
       if(checkCookie(contactID)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
       }else{
        rClickURLDS[rClickURLDS.length] = conturl + contactID+"&AccessOwnerGroup="+AccessOwnerGroup;
       }
    }
    
}

function def_showEvents(name, url){
 
   	    		
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    
    accountID = getCookie('AccountID');
    BankAccountID  = getCookie('bankAccountID');
    
   
    contactID = getCookie('ContactID');
    customerRole=getCookie('CustomerRole');
    contactRole=getCookie('ContactRole');
    if(checkCookie(accountID)=="InValid" && checkCookie(contactID)=="Invalid"){
       return;
    }   
    if(customerRole=='Main Account Holder'){
      parent.parent.defTabs[parent.parent.defTabs.length] = name;  
      parent.parent.defTabsURL[parent.parent.defTabsURL.length] = url+BankAccountID+'&AccountNumber='+accountNumber+'&AccessOwnerGroup='+AccessOwnerGroup;
    }
    else if(contactRole=='Main Account Holder'){
      conturl='../servlet/com.infy.cis.ui.admin.Contact_det?IsReadOnly=Y&contactId='
      parent.parent.defTabs[parent.parent.defTabs.length] = name; 
      parent.parent.defTabsURL[parent.parent.defTabsURL.length] = conturl+contactID+'&AccessOwnerGroup='+AccessOwnerGroup;
    } 
    
}

function populate_showEvents(url){
        		
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    
    customerRole=getCookie('CustomerRole');
    contactRole=getCookie('ContactRole');
    accountID = getCookie('AccountID');
    contactID = getCookie('ContactID');
    BankAccountID  = getCookie('bankAccountID');
    if(customerRole=='Main Account Holder'){
       if(checkCookie(accountID)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
       }else{
        rClickURLDS[rClickURLDS.length] = url + BankAccountID+"&AccessOwnerGroup="+AccessOwnerGroup;
       }
    }    
    else if(contactRole=='Main Account Holder'){
       conturl='../servlet/com.infy.cis.ui.admin.Contact_det?IsReadOnly=Y&contactId='
       if(checkCookie(contactID)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
       }else{
        rClickURLDS[rClickURLDS.length] = conturl + contactID+"&AccessOwnerGroup="+AccessOwnerGroup;
       }
    }
    
}

function def_showInteractions(name, url){
        		
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    
    accountID = getCookie('AccountID');
    
    contactID = getCookie('ContactID');
    customerRole=getCookie('CustomerRole');
    contactRole=getCookie('ContactRole');
    if(checkCookie(accountID)=="InValid" && checkCookie(contactID)=="Invalid"){
       return;
    }   
    if(customerRole=='Main Account Holder'){
      parent.parent.defTabs[parent.parent.defTabs.length] = name;  
      parent.parent.defTabsURL[parent.parent.defTabsURL.length] = url+accountID+'&AccessOwnerGroup='+AccessOwnerGroup+'&AccountNumber='+accountNumber;
    }
    else if(contactRole=='Main Account Holder'){
      conturl='../servlet/com.infy.cis.ui.admin.Contact_det?IsReadOnly=Y&contactId='
      parent.parent.defTabs[parent.parent.defTabs.length] = name; 
      parent.parent.defTabsURL[parent.parent.defTabsURL.length] = conturl+contactID+'&AccessOwnerGroup='+AccessOwnerGroup;
    } 
    
}

function populate_showInteractions(url){
       		
    AccessOwnerGroup = getCookie('AccessOwnerGroup');
    
    customerRole=getCookie('CustomerRole');
    contactRole=getCookie('ContactRole');
    accountID = getCookie('AccountID');
    contactID = getCookie('ContactID');
    BankAccountID  = getCookie('bankAccountID');
    if(customerRole=='Main Account Holder'){
       if(checkCookie(accountID)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
       }else{
        rClickURLDS[rClickURLDS.length] = url + accountID+"&AccessOwnerGroup="+AccessOwnerGroup;
       }
    }    
    else if(contactRole=='Main Account Holder'){
       conturl='../servlet/com.infy.cis.ui.admin.Contact_det?IsReadOnly=Y&contactId='
       if(checkCookie(contactID)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
       }else{
        rClickURLDS[rClickURLDS.length] = conturl + contactID+"&AccessOwnerGroup="+AccessOwnerGroup;
       }
    }
    
}
/*Tracker:108381:End of Changes*/

/*
function accessPriviledge(name, url) {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_SALE");
        return;
    }

  saleURL= getCookie('SaleURL');
    if(checkCookie(saleURL)=="InValid"){
        showUserMessage("MSG007","MSG_SALE");
        return;
    }

    url=url+"?boName=Sale&boURL=" + saleURL ;
    parent.parent.hiddenFrame.location.href=url;
   
}
*/
/*function showNewWindow(url){


    var hnew=  window.open('../common/html/SSOblank.html',  '','directories=No, height=600, left=25, top=100, width=950, location=no, menubar=no, resizable=yes, status=no, toolbar=no,scrollbars');

    hnew.document.write("<Title>" + getTitle() + "</Title>");
    hnew.document.write("<FRAMESET id='TOCFrmSet' FRAMEBORDER=0 FRAMESPACING=0 ROWS='95%,*'>")
    hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= \"" + url + "\"/>");    
    hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= '../common/html/CloseOption.html'/>");            
    hnew.document.write('</FRAMESET>');         
    hnew.focus();

}*/

function showBankAccountViewDocuments(name,url)
{
var hashkey=getCookie('HASHKEY');									
var fldhashkey=getCookie('FLDHASHKEY');
  corpID = getCookie('CorpID');
  acckey= getCookie('AccountKey');
  accbranchcode = getCookie('AccBranchCode');
  accountID = getCookie("bankAccountID"); 
  if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
    showUserMessage("MSG014","MSG_ACCT");
    return;
  }
  saleURL = getCookie('BankAccountURL');
  accountNumber= getCookie('BankAccountNumber');
  bankAccountId = getCookie('bankAccountID');
  if(checkCookie(accountNumber)=="InValid"){
    showUserMessage("MSG291","MSG_BANKACCT");
    return;
  }
    //Changes for  tracker id : 254080 begin
  //url=url+"?ExternalAppName=NewGen&search_Type=360_Acc&AccNumber=" +accountNumber ;  // CRM9.5 to CRM10.1  recon
  /* changes for FDMA 10.2.14 - tracker 368136 
   * Removing the External App Name
   */
    url=url+"&search_Type=360_Acc&AccNumber=" +accountNumber+ "&SalesID="+ "&accbranchcode="+accbranchcode+ "&accountID="+accountID+ "&corpID="+corpID+"&CifID="+acckey;  // CRM9.5 to CRM10.1  recon*/
  //Changes for  tracker id : 254080 end
  parent.parent.hiddenFrame.location.href=url;
  
 }

/* Tracker No 51451 Begin of Changes */
function showOffLineViewDocuments(name,url)
{

//Security Recon Changes : Tracker Id : 356601 

var hashkey=getCookie('HASHKEY');									
var fldhashkey=getCookie('FLDHASHKEY');
  //saleURL = getCookie('BankAccountURL');
  accountNumber= getCookie('BankAccountNumber');
  corpID = getCookie('CorpID');
  acckey= getCookie('AccountKey');
  mcyind= getCookie('MCYInd');
  bankAccountId = getCookie('bankAccountID');

  AccountID = getCookie("AccountID");       // Sec changes



  if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
  {
    showUserMessage("MSG014","MSG_ACCT");
    return;
  }
  var saleURL = getCookie('BankAccountURL');
  if(checkCookie(saleURL)=="InValid")
  {
    showUserMessage("MSG291","MSG_BANKACCT");
    return;
  }
  /* Change for ticket 329529 : Framing the URL properly */
  //url=url+"&saleURL="+saleURL;
  //Changes for  tracker id : 254080 begin
  //url=url+"?saleURL="+saleURL;
  
  
url=url+"?accountNumber=" + accountNumber +"&saleURL=" + saleURL + "&AccessOwnerGroup="+AccessOwnerGroup+"&AccStatReadMode=Y&AccKey="+acckey+"&MCYInd="+mcyind+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&corpId='+corpID+'&AccountNumber='+accountNumber;   
  //url=url+"&saleURL="+saleURL+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&corpId='+corpID+'&AccountNumber='+accountNumber + '&AccKey="+acckey+"&MCYInd="+mcyind;
  //Changes for  tracker id : 254080 end
	//changes for tracker 380190
  showNewWindowAcc(url);
  
}

function editRow()
{

  var url = '../servlet/com.infy.cis.ui.admin.DocumentOfflineDetails';
  var temp;
  identifyme();
  var servletURL = url +"?DocID=" +Check;
  if(Check != null || Check != 'undefined')
  {
  	/* Tracker: 108382: Changes for centering popup */
  	windowAlign();
   	 window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');
  	/* Tracker: 108382: End of Changes */
  }
}

function callmee(){

for (i=3; i < document.all.RecordSet.rows.length; i++)
{
var row_bgcolor=document.all.RecordSet.rows(i).className;        
document.all.RecordSet.rows(2).className= 'color1';   
if ( row_bgcolor == 'rowHighLighted')
{
if ( i % 2 != 0) 
{
document.all.RecordSet.rows(i).className= 'color2';   
}
else
{
document.all.RecordSet.rows(i).className= 'color3';     
}
}
} 
if(event.srcElement.tagName == 'FONT' || event.srcElement.tagName == 'INPUT') 
{
event.srcElement.parentElement.parentElement.className="rowHighLighted";
}
else if(event.srcElement.tagName == 'TD')
{
event.srcElement.parentElement.className="rowHighLighted";
}
}


function cancel() 
{  
  if(showConfirmMessage(MSG022))
  {
    self.close();
  }
  else
  {
    return true;
  }
}
    
function showNewWindowAcc(url)
{
Ornaments = 'directories=No, height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=yes, status=no, toolbar=no,scrollbars';
FrameSplit = '80%,*';
showNewWindow(url);
/*
  var hnew=  window.open(url, '','directories=No, height=400, left=125, top=200, width=750, location=no,'+
  'menubar=no, resizable=yes, status=no, toolbar=no,scrollbars');

  hnew.document.write("<title>FinacleCRM</title>")
  hnew.document.write("<FRAMESET id='TOCFrmSet' FRAMEBORDER=0 FRAMESPACING=0 ROWS='80%,*'>")
    hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= \"" + url + "\"/>");    
    hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= '../common/html/CloseOption.html'/>");            
    hnew.document.write('</FRAMESET>');         
    hnew.focus();
*/
}

/* Tracker No 51451 End of Changes */

/*  CRM61SR:TRACKER:45175:BEGINOFCHANGES */ 
/*Added three new functions , first for the pop of small window instead of the bigger one , second 
  for showing the Online Account Balance from BankAway ejb's and third for getting the last 10
  transaction details from BankAway ejb's.
*/
function showNewSmallWindow(url){
/* Tracker: 108382: Changes for centering popup */
windowAlign();
/* Tracker: 108382: End of Changes */

Ornaments = 'directories=No, height=600, left=260, top=100, width=500, location=no, menubar=no, resizable=yes, status=no, toolbar=no,scrollbars';
closeURL = applPath+'/common/html/PrintCloseOption.html';
showNewWindow(url);
/*    var hnew=  window.open('../common/html/SSOblank.html',  '','directories=No, height=600, left=25, top=100, width=500, location=no, menubar=no, resizable=yes, status=no, toolbar=no,scrollbars');

    hnew.document.write("<Title>" + getTitle() + "</Title>");
    hnew.document.write("<FRAMESET id='TOCFrmSet' FRAMEBORDER=0 FRAMESPACING=0 ROWS='95%,*'>")
    hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= \"" + url + "\"/>");    
    hnew.document.write("<FRAME MARGINHEIGHT=0 MARGINWIDTH=0 NAME='vv' SRC= '../common/html/PrintCloseOption.html'/>");            
    hnew.document.write('</FRAMESET>');         
    hnew.focus();
*/
}

function showOnlineAccountBalance(name,url)
{ 
//changes for call id 381932 and recon of call id 380639 starts
var hashkey=getCookie('HASHKEY');         
var fldhashkey=getCookie('FLDHASHKEY');
//changes for call id 381932 and recon of call id 380639 ends

var productskey = getCookie('productskey');
  srmUrl = getCookie('BankAccountURL');
  accountNumber= getCookie('BankAccountNumber');
    corpID = getCookie('CorpID');
    acckey= getCookie('AccountKey');
    mcyind= getCookie('MCYInd');
  bankAccountId = getCookie('bankAccountID');
  var prodCatID=getCookie('BankAccountprodCatID');
     //samarth
     if(productskey == "SB190")
          {
          alert("You are not authorised to view");
          return;
   }
  if (prodCatID == "11") {
  	showMessage(MSGJ50408);
  	return;
  }
  if(checkCookie(accountNumber)=="InValid"){
        showUserMessage("MSG291","MSG_BANKACCT");
        return;
    }
  showNewSmallWindow(url + "&accountNumber=" +accountNumber +"&srmUrl=" +srmUrl + "&AccessOwnerGroup="+AccessOwnerGroup+"&AccStatReadMode=Y&AccKey="+acckey+"&MCYInd="+mcyind+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&corpId='+corpID+'&AccountNumber='+accountNumber);
}

function showLast10Txn(name,url)
{ 

var productskey = getCookie('productskey');

  srmUrl = getCookie('BankAccountURL');
  accountNumber= getCookie('BankAccountNumber');
  var prodCatID=getCookie('BankAccountprodCatID');
  if(productskey == "SB190")
         {
         alert("You are not authorised to view");
         return;
   }
  if (prodCatID == "11") {
  	showMessage(MSGJ50408);
  	return;
  }  
  if(checkCookie(accountNumber)=="InValid"){
        showUserMessage("MSG291","MSG_BANKACCT");
        return;
    }

    showNewSmallWindow(url + "&accountNumber=" +accountNumber +"&srmUrl=" +srmUrl);
}

/* CRM61SR:TRACKER:45175:ENDOFCHANGES */ 


//Added for Auditing Link Delink Functionality
function ShowAuditTrailLinkDelink(wndName,auditUrl){

  if (CheckForSelectedRow(document.getElementsByName('RecordSet')) == 'false') {
    showUserMessage ('MSG014','MSG_OPPR');
    return;
  }
  var bankAccountId = getCookie('bankAccountID'); 
  var AccountID=getCookie('AccountID');
  if(checkCookie(bankAccountId)=="InValid"){  
    return;
      }    
  // Changes for ticket : 626295
  auditUrl=auditUrl+'&BOName=LinkDelinkBO&BOID='; 
  var bankAccountNumber = getCookie('BankAccountNumber');   
  if (checkCookie(bankAccountNumber) != 'InValid')
  auditUrl += '&Header='+MSG_AU0008+'~'+escape(bankAccountNumber); 
  /* Tracker: 108382: Changes for centering popup */
  windowAlign();
 
  window.open (auditUrl+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+ '&bankAccountNumber=' + bankAccountNumber,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');
  /* Tracker: 108382: End of Changes */
}


/*  Tracker : 66615 - Account Holder Maintenance - Begin of Changes */
//Added for Account Holder Maintenance
function accountHolder(name, url){

   <!--Tracker:90196: Changes for Attribute Masking-->	    		
   AccessOwnerGroup = getCookie('AccessOwnerGroup');
   <!--Tracker:90196: End of Changes-->
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_BANKACCT");
        return;
    }
    saleID  = getCookie('bankAccountID');
    
  if(checkCookie(saleID)=="InValid"){
        showUserMessage("MSG007","MSG_ACCT");
        return;
    }
    var viewName="";
    /*Changes for the ticket id 205286 starts */
    viewName=fngetViewName();
    /*Changes for the ticket id 205286 ends */
    servletURL = url + saleID +"&ViewName=" + viewName+"&AccessOwnerGroup="+AccessOwnerGroup;
    /* Tracker: 108382: Changes for centering popup */
    
    windowAlign();
    window.open(servletURL, '','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');
    /* Tracker: 108382: End of Changes */

}

//Added for Auditing Trail
function showAuditTrail(wndName,auditUrl){  //change for ticket id 210143 


//Security Recon Changes : Tracker Id : 356601 

var hashkey=getCookie('HASHKEY');								
var fldhashkey=getCookie('FLDHASHKEY');
var corpId = getCookie('CorpID');





  if (CheckForSelectedRow(document.getElementsByName('RecordSet')) == 'false') {
    showUserMessage ('MSG014','MSG_BANKACCT');
    return;
  }
  var bankAccountId = getCookie('bankAccountID'); 
  var AccountID=getCookie('AccountID');
  if(checkCookie(bankAccountId)=="InValid"){  
    return;
      }     
      /* Changes for security begins */
      // Changes for ticket : 626295
  //changes for callid 441059 begin
  auditUrl=auditUrl+'&BOName=SaleBO&BOID='+bankAccountId;
  //changes for callid 441059 ends
  

  /* Changes for security ends */
  var bankAccountNumber = getCookie('BankAccountNumber');   
  if (checkCookie(bankAccountNumber) != 'InValid')
  auditUrl += '&Header='+MSG_AU0008+escape(bankAccountNumber);   
 
  /* Tracker: 108382: Changes for centering popup */
  windowAlign();
  
  
  
//Security Recon Changes : Tracker Id : 356601 
  window.open (auditUrl+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&AccountID='+AccountID+'&ID='+AccountID+'&bankAccountNumber=' + bankAccountNumber+'&corpId='+corpId ,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');
  /* Tracker: 108382: End of Changes */
}
/*  Tracker : 66615 - End ofChanges */

/*Tracker:108381:Changes for 360Degree tertiary pane default tab*/
function def_TabHelper(){

	def_showCustomerInfo(decodeURIComponent('Customer%20Basic%20Information'),'../servlet/com.infy.cis.ui.common.allViews?viewname=UIAccountDetails&param2=');
	def_showIncidents("Incidents","../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Account_Incidents&Param2="+accountID+"&AccessOwnerGroup="+AccessOwnerGroup);
	/* Tracker # 153217 BEGIN */
	def_showEvents("Events","../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=ViewEvents&Param1="+accountID+"&AccessOwnerGroup="+AccessOwnerGroup);
	/* Tracker # 153217 END */
	/* Tracker # 153216 BEGIN */
        def_showInteractions("Interactions","../servlet/com.infy.cis.ui.common.SRMCommonListServlet?ViewName=Account_Interaction&Param1="+accountID+"&AccessOwnerGroup="+AccessOwnerGroup);
        /* Tracker # 153216 END */
}

/*Tracker:108381:End of Changes*/

/* CRM11.0:TRACKER:113058:BEGINOFCHANGES */
   function fnshowBranchCodeDetails(){
   
//Security Recon Changes : Tracker Id : 356601 
       
<!-- Changes for Ticketid:-(353382) Call ID:-172098 Begins -->
 var BranchCode  = getCookie('BranchCode');
 var hashkey=getCookie('HASHKEY');
 var fldhashkey=getCookie('FLDHASHKEY');
			var bankAccountNumber=getCookie('BankAccountNumber');
 

if (BranchCode== null || BranchCode=="" || BranchCode== 'null') {
	return;
	}
var AccessOwnerGroup  = getCookie('AccessOwnerGroup');
	    var accountID = getCookie('AccountID');	    
	
	var AccessOwnerGroup  = getCookie('AccessOwnerGroup');
	
	if (AccessOwnerGroup== null || AccessOwnerGroup=="" || AccessOwnerGroup== 'null') {
		return;
	}
<!-- Tracker 133057 Changes STart -->  
	//var url = '../servlet/com.infy.cis.ui.admin.Branch_Det?mode=Edit&isPopup=Yes &isReadOnly=Y &AccessOwnerGroup=' + AccessOwnerGroup;
        
        //Changes for tracker 431670 start
        var url = '../servlet/com.infy.cis.ui.admin.BranchDetWizard?mode=Edit&isPopup=Yes &isReadOnly=Y &AccessOwnerGroup='+AccessOwnerGroup+'&BranchCode='+BranchCode+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&BankAccountNumber='+ bankAccountNumber+'&accbranchcode='+BranchCode;
	//Changes for tracker 431670 end
	//var url = '../servlet/com.infy.cis.ui.admin.Branch_Det?ScreenID=HREF360ACCBR&isPopup=Yes&isReadOnly=Y&AccessOwnerGroup='+AccessOwnerGroup+'&accbranchcode='+accbranchcode+'&salesId='+BankAccountNumber+'&accountID='+accountID+'&bankAccountNumber='+ bankAccountNumber+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
      
       
       //showNewWindow(url);
       window.open(url,'','height=600,left=100,top=100,width=900,location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars');
	<!-- Changes for Ticketid:-(353382) Call ID:-172098 Ends -->
<!-- Tracker 133057 Changes ENd -->          
}
/* CRM11.0:TRACKER:113058:ENDOFCHANGES */








