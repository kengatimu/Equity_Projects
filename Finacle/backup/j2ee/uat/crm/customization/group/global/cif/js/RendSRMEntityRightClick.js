// BEGIN OF ML CHANGES
document.write('<script type="text/javascript" src="'+applPath+'/cif/js/Message_cif_'+finaclecrmlocale+'.js" language="javascript"></script>');
document.write('<script language=javascript src="'+applPath+'/corpcif/js/Message_corpcif_'+finaclecrmlocale+'.js">'+'<\/script>');
// END OF ML CHANGES
document.write('<script language="javascript" src="'+applPath+'/common/js/SSOUtils.js"></script>');
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
function ViewEntity(name, url) {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
     // Tracker ID - 90197 Begin of Changes for attribute masking
             AccessOwnerGroup = getCookie('AccessOwnerGroup');
    //  Tracker ID - 90197 End of Changes 
    expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));
    accountId  = getCookie('accountId');
    contactId = getCookie('contId');
    prospectId = getCookie('prosId');
    noncustomerId=getCookie('noncustId'); 
    //Checksum recon from 10.3 SUPP
    var hashkey=getBrowserCookie('HASHKEY');
    var fldhashkey=getBrowserCookie('FLDHASHKEY');
    //Checksum recon from 10.3 SUPP
    if(checkCookie(accountId)=="InValid")
    {
	if(checkCookie(contactId)=="InValid")
	{
		if(checkCookie(prospectId)=="InValid")
		{ 
			if(checkCookie(noncustomerId)=="InValid")
			{ 
			return;
			} 
		    	else 
		    	{
			entityID = noncustomerId;
	    		}
	    	} 
	    	else 
	    	{
		entityID = prospectId;
	    	}
    	} 
    	else 
    	{
	entityID = contactId;
    	}
    } 
    else 
    {
	entityID = accountId;       
    }   
   /*Changes done by kanika for Cif Deceased starts*/
   var creFlag = getCookie('creFlag');
   if(name == "Basel Profiling"){   
		 //Checksum recon from 10.3 SUPP
        /* servletURL = url + entityID + "&AccessOwnerGroup=" + AccessOwnerGroup+"&IsReadOnly=Y"+'&type=Queue&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&entityID='+entityID;*/
         servletURL = url + entityID + "&AccessOwnerGroup=" + AccessOwnerGroup+"&IsReadOnly=Y"+'&type=Queue&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&entityID='+entityID+"&operationType=Queue"+"&creFlag="+creFlag;
   /*Changes done by kanika for Cif Deceased ends */
   }
   else {
       //Checksum recon from 10.3 SUPP
   /*Changes done by kanika for Cif Deceased starts*/
       /* servletURL = url + entityID + "&AccessOwnerGroup=" + AccessOwnerGroup+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey; */
       servletURL = url + entityID + "&AccessOwnerGroup=" + AccessOwnerGroup+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+"&operationType=Queue"+"&creFlag="+creFlag;
   /*Changes done by kanika for Cif Deceased ends */
   }
   /* Tracker: 108382: Changes for centering popup */
   windowAlign();
   window.open(servletURL,'','directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
   /* Tracker: 108382: End of Changes */
}
function ViewRemarks(name, url) {
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
    accountId  = getCookie('accountId');
    contactId = getCookie('contId');
    prospectId = getCookie('prosId');
    noncustomerId=getCookie('noncustId'); 
    if(checkCookie(accountId)=="InValid")
    {
	if(checkCookie(contactId)=="InValid")
	{
		if(checkCookie(prospectId)=="InValid")
		{ 
			if(checkCookie(noncustomerId)=="InValid")
			{ 
			return;
	    		} 	    		
		    	else 
		    	{
			entityID = noncustomerId;
			Type="NonCustomer";
	    		}
	    	}
	    	else 
	    	{
		entityID = prospectId;
		Type="Suspect";
	    	}
    	} 
    	else 
    	{
	entityID = contactId;
	Type="Contact";
    	}
    } 
    else 
    {
	entityID = accountId;
	Type="Account";
    }
   servletURL = url + entityID;
   window.open(servletURL,'','directories=No, height=436, left=70, top=120, width=860, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
}
/*Equity Bank Customization*/
function Recal(name,url)
{
 
 var MakerID=getCookie('MakerID');
  
	var repId=getCookie('RepID');
	
	var accountId=getCookie('accountId');
	 
	
		if (repId!=MakerID)
		{	
		showMessage("Only the Maker Can Recall the Entity for Editing");
		return;
	}
	 try {
	        if (url.indexOf('?') !=-1){
	            url += "&EntityType=Customer&entityId=" + accountId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID; 
	            }
	          else{
		       url += "?EntityType=Customer&entityId=" + accountId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID; 
	            }
	           
	           // parent.hiddenFrame.location.href = url;
	            parent.hiddenFrame.location.href = url+ "&TabName=" + name ;
	           
	        } catch (ex) {
	                        DebugMessage('ex '+ ex.description);
	        }
        return true;

}
/*Equity Bank Customization*/
function EditAccount(name, url) {
IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
	{	 showMessage(MSGJ50260);
		return;
	}
	var MakerID=getCookie('MakerID');	
	var repId=getCookie('RepID');
	var RecordStatus=getCookie('RecordStatus');
	var creFlag = getCookie('creFlag');	
	var mainID = getCookie('mainID');	
        var hashkey=getBrowserCookie('HASHKEY');
        var fldhashkey=getBrowserCookie('FLDHASHKEY');
       
	 // Tracker ID - 90197 Begin of Changes for attribute masking
             AccessOwnerGroup = getCookie('AccessOwnerGroup');
        //  Tracker ID - 90197 End of Changes 	
    var dob = getCookie('dob');
    var isMCEdited=getCookie('isMCEdited');
	if(RecordStatus=="F")
	{
	showMessage(MSGJ0099); 
	return;
	}
	if (repId!=MakerID)
	{	
	showMessage(MSGJ0100);
	return;
	}
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ACCT");
        return;
    }
        var tfFlag = getCookie("tfFlag");
            
      
        
    expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));
    accountId  = getCookie('accountId');
    contactId = getCookie('contId');
    prospectId = getCookie('prosId');
    noncustomerId=getCookie('noncustId'); 
    nonCustomerName=getCookie('nonCustName');
//changes for tracker 401769 fullname alteration begins
    fullname = getCookie('fullname');
//changes for tracker 401769 fullname alteration ends
    noncustomersKey = getCookie('noncustomersKey');
    var entityName='';
    var entityKey='';
    
    if(checkCookie(accountId)=="InValid")
    {
	if(checkCookie(contactId)=="InValid")
	{
		if(checkCookie(prospectId)=="InValid")
		{ 
			if(checkCookie(noncustomerId)=="InValid")
			{ 
			return;
	    		} 
	    		else 
		    	{
			entityID = noncustomerId;
			entityName=nonCustomerName;
			entityKey=noncustomersKey;
	    		}
	    	}
	    	else 
	    	{
		entityID = prospectId;
	    	}
    	} 
    	else 
    	{
	entityID = contactId;
    	}
    } 
    else 
    {
	entityID = accountId;       
    }
//IUT fix for PAF, Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin
    if(!(noncustomerId !="" && noncustomerId != null && noncustomerId !='undefined' && noncustomerId !='null')){
        if((tfFlag == 'N' || tfFlag == '') && (name == 'Trade Finance Details') )
		    {
		    showMessage(MSGJ50276);
		    return;
		}
	}	
  //IUT fix for PAF, Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end  
    if(creFlag =='N'){
          	 servletURL = url + entityID+"&mainAccId=" + mainID+ "&AccessOwnerGroup=" + AccessOwnerGroup+ "&isMCEdited="+isMCEdited+"&SECUREHKEY="+hashkey+"&FLDHASHKEY="+fldhashkey+"&entityName="+entityName+"&entityKey="+entityKey ;
     } else {
//changes for tracker 401769 fullname alteration begins
          	 servletURL = url + entityID+"&mainAccId="+ "&AccessOwnerGroup=" + AccessOwnerGroup+ "&isMCEdited="+isMCEdited +"&SECUREHKEY="+hashkey+"&FLDHASHKEY="+fldhashkey+"&entityName="+entityName+"&entityKey="+entityKey+"&fullname="+fullname; 
//changes for tracker 401769 fullname alteration ends
    }
     var blacklisted = getCookie("BlackListed");
         var suspended = getCookie("Suspended"); 
         var negated = getCookie("Negated");
    servletURL = servletURL +'&dob='+dob;
    /*Changes done by kanika for Cif Deceased starts*/
    /* servletURL = servletURL + '&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&chkBSN=true'; */
    servletURL = servletURL + '&blacklisted='+blacklisted+'&suspended='+suspended+'&negated='+negated+'&chkBSN=true'+"&creFlag="+creFlag;
    /*Changes done by kanika for Cif Deceased ends */
    /* Tracker: 108382: Changes for centering popup */
    windowAlign();
    window.open(servletURL,'','directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars=yes');
   /* Tracker: 108382: End of Changes */
}
function showDefTabs() {
    try{    	
        if(CheckIfRowSelected()=="false"){       
            parentFrame.parent.parent.dynamicTabFrm.location.href='../common/html/blank.html';
            return; 
        }        
        IsTampered = getCookie('IsTampered');
		if(IsTampered=='Y')
		{	 showMessage(MSGJ50260);
			return;
		}
        parentFrame.removeDefTabs();
        populateRClickViewDS();
        allTabNames = new Array();    
        selectedTabName = '';
        if(parentFrame.parent.parent.dynamicTabFrm.tabViewFrm) {  
        
            selectedTabName = parentFrame.parent.parent.dynamicTabFrm.tabViewFrm.getSelectedTabName();
       }  
	/*if(allTabNames.length == 0) {
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
        }*/          
       
        parentFrame.addDefSelTab(selectedTabName);      
        parentFrame.showTabFrm();        
    }catch(e){
    
   //Tracker ID 96139 Changes BEGIN
   // DebugMessage("error  "+ e.message);
   //Tracker ID 96139 Changes END
    }
}
function def_showEntityInfo(name, url,screenid) { 

 IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
	{	 showMessage(MSGJ50260);
		return;
	}
    viewName  = '';
    entityID  = '';
    accountId = getCookie('accountId');    
    contactId = getCookie('contId');
    prospectId = getCookie('prosId');   
    noncustomerId=getCookie('noncustId'); 
     // Tracker ID - 90197 Begin of Changes for attribute masking
         AccessOwnerGroup = getCookie('AccessOwnerGroup');
    //  Tracker ID - 90197 End of Changes  
    if(checkCookie(accountId)=="InValid"){
        if(checkCookie(contactId)=="InValid"){
        if(checkCookie(prospectId)=="InValid"){ 
        if(checkCookie(noncustomerId)=="InValid"){ 
        return;
            } 
            else {        
	            viewName = "UIModNonCustomerDetails";
	            entityID = noncustomerId;
            }
            }
            else {        
            viewName = "UIModSuspectDetails";
        entityID = prospectId;
            }
    } else {        
        viewName = "UIModContactDetails";
        entityID = contactId;
    }
    } else {        	
        viewName="CustModInfoSummary";
        entityID = accountId;       
    }
    url = url + viewName + "&param2=" + entityID + "&AccessOwnerGroup=" + AccessOwnerGroup;
    
    parentFrame.addDefTab(name, url);       
}
function populate_showEntityInfo(url,screenid) {  
	IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
	{	 showMessage(MSGJ50260);
		return;
	}
    viewName  = '';
    entityID  = '';
    accountId = getCookie('accountId');
    contactId = getCookie('contId');
     // Tracker ID - 90197 Begin of Changes for attribute masking
             AccessOwnerGroup = getCookie('AccessOwnerGroup');
        //  Tracker ID - 90197 End of Changes  
    prospectId = getCookie('prosId');
    noncustomerId=getCookie('noncustId'); 
    if(checkCookie(accountId)=="InValid"){
        if(checkCookie(contactId)=="InValid"){
            if(checkCookie(prospectId)=="InValid"){  
            	if(checkCookie(noncustomerId)=="InValid"){  
                	rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
                	return;
            	} else {
			viewName = "UIModNonCustomerDetails";
		        entityID = noncustomerId;  
            	}
            } else {
                viewName = "UIModSuspectDetails";
                entityID = prospectId;  
            }
        } else {
            viewName = "UIModContactDetails";
            entityID = contactId;
        }
    } else {        
        viewName = "CustModInfoSummary";
        entityID = accountId;
    }
    url = url + viewName + "&param2=" + entityID+ "&AccessOwnerGroup=" + AccessOwnerGroup;
    rClickURLDS[rClickURLDS.length] = url;    
}
function def_showProcessRelatedInfo(name, url) {
    try{
    	IsTampered = getCookie('IsTampered');
    
    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
    //Checksum recon from 10.3 SUPP
	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');
	//Checksum recon from 10.3 SUPP
        accountId = getCookie('accountId'); 
        contactId = getCookie('contId');
    	prospectId = getCookie('prosId');
    	noncustomerId=getCookie('noncustId'); 
        prefix = local_prefix;
        local_prefix = "";
        type = getCookie('ModEntityType'); 
        local_prefix = prefix;
        var RepID = document.frm2.RepID.value;
        OwnerID=getCookie('OwnerID'); 
        BOCreatedByID=getCookie('MakerID');
        //Equity Bank Customization//
	//if((RepID==OwnerID)||(RepID==BOCreatedByID))
	if((RepID==BOCreatedByID))
	{	
	return;
	}	
	//Equity Bank Customization//
        if(checkCookie(accountId)=="InValid"){
	        if(checkCookie(contactId)=="InValid"){
	        if(checkCookie(prospectId)=="InValid"){ 
	       	if(checkCookie(noncustomerId)=="InValid"){ 
	        return;
	            } else {        
		    	       viewName = "UIModNonCustomerDetails";
		    	       entityID = noncustomerId;
	            }
	            } else {        
	            viewName = "UIModSuspectDetails";
	        entityID = prospectId;
	            }
	    } else {        
	        viewName = "UIModContactDetails";
	        entityID = contactId;
	    }
	    } else {    
	        viewName = "CustModInfoSummary";
	        entityID = accountId;       
    	}
        if(type == 'Group') {
            return;
        }
        //Checksum recon from 10.3 SUPP
        parentFrame.addDefTab(name, url + entityID+'&type=Queue&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&entityId='+entityID);
        //Checksum recon from 10.3 SUPP
    }catch(e){}    
}
function populate_showProcessRelatedInfo(url) {
 //Checksum recon from 10.3 SUPP
	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');
	//Checksum recon from 10.3 SUPP
IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
	{	 showMessage(MSGJ50260);
		return;
	}
    opportunityId = getCookie('opportunityId');
    prefix = local_prefix;
    local_prefix = "";
    type = getCookie('SalesOpprTrakType');
    local_prefix = prefix;
    if(checkCookie(opportunityId)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
    }else{
        if(type == 'Group') {
            rClickURLDS[rClickURLDS.length]='../html/NoItem.html';            
        return;
        } else {
            //Checksum recon from 10.3 SUPP
            rClickURLDS[rClickURLDS.length] = url + opportunityId+'&type=Queue&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&entityId='+entityID;
            //Checksum recon from 10.3 SUPP
        }
    }
}
function getActivityHistoryURL(objectId){
	IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
	{	 showMessage(MSGJ50260);
		return;
	}
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
        var sortOrder = getCookie('SORT_ORDER_OpportunityHistory');
        var sortColumn = getCookie('SORT_COLUMN_OpportunityHistory');            
        local_prefix = "SaOppr";
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
                'EntityType=Opportunity&ViewName=OpportunityHistory'+
                '&parComp=parentFrame.parent.parent.dynamicTabFrm.frames(0)&typeId=' 
                + objectId + activityCookieStr;
                
        return actURL               
}
function def_activityHistory(name,url){
 IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
	{	 showMessage(MSGJ50260);
		return;
	}
    objectId = getCookie('opportunityId');
    if(checkCookie(objectId)=="InValid"){
        return;
    }else{
        parentFrame.addDefTab(name, getActivityHistoryURL(objectId));
    }
}
function populate_activityHistory(url){
    objectId = getCookie("opportunityId");
    if(checkCookie(objectId)=="InValid"){
        rClickURLDS[rClickURLDS.length]='../html/NoItem.html';
    }else{
        rClickURLDS[rClickURLDS.length] = getActivityHistoryURL(objectId);
    }
}
//changes for right click menu end
function showEntityInfo(name, url,screenid) {
	IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
	{	 showMessage(MSGJ50260);
		return;
	}
    if(CheckIfRowSelected()=="false"){
        showUserMessage('MSG014','MSG_ENT');
        return;
    }    
    viewName  = '';
    entityID  = '';
    // Tracker ID - 90197 Begin of Changes for attribute masking
                 AccessOwnerGroup = getCookie('AccessOwnerGroup');
    //  Tracker ID - 90197 End of Changes
    accountId = getCookie('accountId');
    contactId = getCookie('contId');
    prospectId = getCookie('prosId');
    noncustomerId=getCookie('noncustId'); 
    if(checkCookie(accountId)=="InValid"){
        if(checkCookie(contactId)=="InValid"){
            if(checkCookie(prospectId)=="InValid"){
            	if(checkCookie(noncustomerId)=="InValid"){ 
			showUserMessage('MSG014','MSG_ENT');
			return;
		} else {        
		viewName = "UIModNonCustomerDetails";
		entityID = noncustomerId;
        	}
        } else {        
        viewName = "UIModSuspectDetails";
        entityID = prospectId;
        }
    } else {        
        viewName = "UIModContactDetails";
        entityID = contactId;
    }
    } else {        
        viewName = "CustModInfoSummary";
        entityID = accountId;
    }
    url = url + viewName + "&param2=" + entityID + "&AccessOwnerGroup=" + AccessOwnerGroup;
    parentFrame.parent.parent.dynamicTabFrm.addTab(name, url);
}
function showProcessRelatedInfo(name, url) {
 //Checksum recon from 10.3 SUPP
var hashkey=getBrowserCookie('HASHKEY');
var fldhashkey=getBrowserCookie('FLDHASHKEY');

//Checksum recon from 10.3 SUPP
IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
	{	 showMessage(MSGJ50260);
		return;
	}
	var RepID = document.frm2.RepID.value;
	OwnerID=getCookie('OwnerID'); 
	BOCreatedByID=getCookie('MakerID');
    	if(CheckIfRowSelected()=="false"){
            showUserMessage('MSG014','MSG_ENT');
            return;
        }        
        /*Equity Bank Customization*/
        //if((RepID==OwnerID)||(RepID==BOCreatedByID))
        if(RepID==BOCreatedByID)
	{	
	showMessage("Maker cannot view the current process step");
	return;
	}	
	/*Equity Bank Customization*/
        entityID  = '';
        accountId = getCookie('accountId');
        contactId = getCookie('contId');
        prospectId = getCookie('prosId');
       	noncustomerId=getCookie('noncustId'); 
        if(checkCookie(accountId)=="InValid"){
            if(checkCookie(contactId)=="InValid"){
                if(checkCookie(prospectId)=="InValid"){  
                	if(checkCookie(noncustomerId)=="InValid"){ 
			    showUserMessage('MSG014','MSG_ENT');
			    return;
			} else { 
		        entityID = noncustomerId;
            		}
            } else { 
            entityID = prospectId;
            }
        } else { 
            entityID = contactId;
        }
        } else { 
            entityID = accountId;
    }
	/*Changes for Ticket#349877 begin*/
	type = getCookie('ModEntityType');
	/*Changes for Ticket#349877 begin*/
    if(type == 'Group') {
            showUserMessage('MSG_PROCENT','');
        return;
    }
    prefix = local_prefix;
    local_prefix = "";
    local_prefix = prefix;    
     //Checksum recon from 10.3 SUPP
    url = url + entityID+'&type=Queue'+'&entityId='+entityID+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
     //Checksum recon from 10.3 SUPP
    if(name == 'Process Steps'){
	loadURL=url;
	writeToNewWindow();
    }else {
        parentFrame.parent.parent.dynamicTabFrm.addTab(name, url );
    }
}
function showProcessStepsRelatedInfo(name, url) {
	//Checksum recon from 10.3 SUPP
	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');
	//Checksum recon from 10.3 SUPP
    	if(CheckIfRowSelected()=="false"){
            showUserMessage('MSG014','MSG_ENT');
            return;
        }    
        IsTampered = getCookie('IsTampered');
		if(IsTampered=='Y')
		{	 showMessage(MSGJ50260);
			return;
		}
        entityID  = '';
        accountId = getCookie('accountId');
        contactId = getCookie('contId');
        prospectId = getCookie('prosId');
       	noncustomerId=getCookie('noncustId'); 
        if(checkCookie(accountId)=="InValid"){
            if(checkCookie(contactId)=="InValid"){
                if(checkCookie(prospectId)=="InValid"){  
                	if(checkCookie(noncustomerId)=="InValid"){ 
			    showUserMessage('MSG014','MSG_ENT');
			    return;
			} else { 
		        entityID = noncustomerId;
            		}
            } else { 
            entityID = prospectId;
            }
        } else { 
            entityID = contactId;
        }
        } else { 
            entityID = accountId;
    }
    if(type == 'Group') {
            showUserMessage('MSG_PROCENT','');
        return;
    }       
    prefix = local_prefix;
    local_prefix = "";
    type = getCookie('ModEntityType');
    local_prefix = prefix;    
	//Checksum recon from 10.3 SUPP
    url = url + entityID+'&type=Queue&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey+'&entityId='+entityID;
    //Checksum recon from 10.3 SUPP
    if(name == 'Process Steps'){
	loadURL=url;
	/* Tracker: 108382: Changes for centering popup */
	windowAlign();
	/* Tracker: 108382: End of Changes */
	writeToNewWindow();
    }else {
        parentFrame.parent.parent.dynamicTabFrm.addTab(name, url );
    }
}
var response;
function getEntity(name,url) {		
IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
	{	 showMessage(MSGJ50260);
		return;
	}
    var temp = local_prefix;
    local_prefix = "";    
    local_prefix = temp;
    var EntityType=getCookie('EntityType');    
	var RepID = document.frm2.RepID.value;       	
	if (EntityType=='Customer')
	{		
		var elements = document.getElementsByTagName("input");
		var accIds="";
		for(var i = 0; i < AccList.length; i++) 
		{
			if(AccList[i] != -1) 
			{
				accIds += AccList[i] + ",";
				var last=accIds.lastIndexOf(',');
			}
		 }
	    	accIds=accIds.substr(0,last);
		if (accIds=="")
		{
			showMessage(MSGJ0102);
			return "false";
		}
		var WItemFlag;
    		var getFirst = "";
   		entityURL = getCookie('AccountURL');    
    		entityURLs = accIds;
    		parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.cif.getModAccount?EntityType=Customer&entityURL='+ entityURLs+ '&getFirst='+ getFirst;    
    	}
       	else if (EntityType=='Contact')
        {    	
        	var elements = document.getElementsByTagName("input");
    		var contIds="";
		for(var i = 0; i < ContList.length; i++) 
		{
			if(ContList[i] != -1) 
			{
			contIds += ContList[i] + ",";
			var last=contIds.lastIndexOf(',');
			}
		 }
		contIds=contIds.substr(0,last);
		if (contIds=="")
		{
			showMessage(MSGJ0103);
			return "false";
		}
    		var WItemFlag;
		var getFirst = "";
		contactURL = getCookie('contactURL');    
		entityURLs = contIds;
    		parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.cif.getModAccount?EntityType=Contact&entityURL='+ entityURLs+ '&getFirst='+ getFirst;    
    }
    else if (EntityType=='Suspect')
            {    
            	var elements = document.getElementsByTagName("input");
        	var suspIds="";
    		for(var i = 0; i < SuspList.length; i++) 
    		{
    			if(SuspList[i] != -1) 
    			{
    			suspIds += SuspList[i] + ",";
    			var last=suspIds.lastIndexOf(',');
    			}
    		 }
    		suspIds=suspIds.substr(0,last);
    		if (suspIds=="")
    		{
    			showMessage(MSGJ0104);
    			return "false";
    		}
    		var getFirst = "";
    		entityURLs = suspIds;
        	parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.cif.getModAccount?EntityType=Suspect&entityURL='+ entityURLs+ '&getFirst='+ getFirst;    
    }    
    else if (EntityType=='NonCustomer')
                { 
                	var elements = document.getElementsByTagName("input");
            		var noncustIds="";
        		for(var i = 0; i < NonCustList.length; i++) 
        		{
        			if(NonCustList[i] != -1) 
        			{
        			noncustIds += NonCustList[i] + ",";
        			var last=noncustIds.lastIndexOf(',');
        			}
        		 }
        		noncustIds=noncustIds.substr(0,last);
        		if (noncustIds=="")
        		{
        			showMessage(MSGJ0105);
        			return "false";
        		}
        		var getFirst = "";
        		entityURLs = noncustIds;
            	parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.cif.getModAccount?EntityType=NonCustomer&entityURL='+ entityURLs+ '&getFirst='+ getFirst;    
    }
}
function activityHistory(name,url) {
    if(CheckIfRowSelected()=="false"){
        showUserMessage('MSG014','MSG_ENT');
        return;
    }
    IsTampered = getCookie('IsTampered');
    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
        return;
    }
    accountId = getCookie('accountId');
    contactId = getCookie('contId');
    prospectId = getCookie('prosId');
    prospectURL = getCookie('susURL');
    noncustomerId=getCookie('noncustId'); 
    noncustomerURL = getCookie('noncustomerURL');
     //Checksum recon from 10.3 SUPP
        var hashkey=getBrowserCookie('HASHKEY');
        var fldhashkey=getBrowserCookie('FLDHASHKEY');
    //Checksum recon from 10.3 SUPP
        EntityType = '';
        if(checkCookie(accountId)=="InValid"){
            if(checkCookie(contactId)=="InValid"){
                 if(checkCookie(prospectId)=="InValid"){ 
                 	if(checkCookie(noncustomerId)=="InValid"){  
				showUserMessage('MSG007','MSG_ENT');
				return;
			} else {   
			      entityID = noncustomerId;
			      EntityType = 'NonCustomer';                
			}
                 } else {   
                    entityID = prospectId;
                    EntityType = 'Prospect';                
                 }
            } else {    
                entityID = contactId;
                EntityType = 'Contact';                
            }
        } else {     
            entityID = accountId;
            EntityType = 'Account';           
    }
    var reqType = 'Mod';
    accountURL = getCookie("searchAccURL");    
    wizardurl = '../servlet/com.infy.cis.ui.wizards.SRMWizardWrapper?FormBaseURL=' + url + '&EntityType='+EntityType+'&ViewName=OpportunityHistory&parComp=parentFrame.parent.parent.dynamicTabFrm.frames(0)&FormTitle=' + name+ '&typeId=' + entityID + '&reqType=' + reqType + '&accountURL='+accountURL+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;     
    /* Tracker: 108382: Changes for centering popup */
    windowAlign();
    newWindowActHistory = window.open( wizardurl , 'ActivityHistory','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    /* Tracker: 108382: End of Changes */
    newWindowActHistory.focus();
}
function createActivity(name,url) {
    if(CheckIfRowSelected()=="false"){
        showUserMessage('MSG014','MSG_ENT');
        return;
    }
    IsTampered = getCookie('IsTampered');
    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
    accountURL= getCookie("searchAccURL");
    contactURL= getCookie("contactURL");
    prospectURL= getCookie("prospectURL");
    accountId= getCookie('accountId');
    contactId = getCookie('contId');
    prospectId = getCookie('prosId');
    noncustomerId=getCookie('noncustId'); 
    noncustomerURL = getCookie('noncustomerURL');
    nonCustModStepID = getCookie('nonCustModStepID');
    susModStepID = getCookie('susModStepID');
    conModStepID = getCookie('conModStepID');
    custModStepID = getCookie('custModStepID');
    var objectType;
    var entityID;
    var entityURL;
    processId= getCookie('ProcessGroupID');
    status1= getCookie('ProcessStatus'); 
    if(checkCookie(accountId)=="InValid")
        {
		if(checkCookie(contactId)=="InValid")
		{
			if(checkCookie(prospectId)=="InValid")
			{ 
				if(checkCookie(noncustomerId)=="InValid")
				{ 
				showUserMessage('MSG007','MSG_ENT');
				return;
				} 
				else 
				{
				entityID = noncustomerId;
				/* CRM102ST: TrackerID:178298 Being of Change */
				objectType = "NonCustomerMod";
				/* CRM102ST: TrackerID:178298 End of Change */
				entityURL = noncustomerURL;
				StepID = nonCustModStepID;
				}
			}
			else 
			{
			entityID = prospectId;
			objectType = "Prospect";
			entityURL = prospectURL;
			StepID = susModStepID;
			}
			} 
		else 
		{
		entityID = contactId;
		objectType= "Contact";
		entityURL = contactURL;
		StepID = conModStepID;
		}
		} 
        else 
        {
    	entityID = accountId;       
    	objectType= "Account";
    	entityURL = accountURL;
    	StepID = custModStepID;
    	}
    	if(status1=='error'||status1=='ERROR'||status1=='Error')
	{	
		/* CRM102ST: TrackerID:178298 Being of Change */
		if(objectType=='Account'){
		//Checksum security Fix
		url = url+"&objectType="+objectType
		}
		else{
		url = url+"&objectType="+objectType
		}
		//Changes For Tracker: 166097 Starts ? symbol changed to &
	      	url = url+ "&objectId=" + entityID +"&processStep=" + StepID + "&processId=" + processId +"&FromDaemon=true";
		/* CRM102ST: TrackerID:178298 End of Change */
			//Changes For Tracker: 166097 Ends
    	    	//window.open(url ,'','height=436, left=70, top=120, width=860,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');    		
		newWindowcreateActivity = window.open(url, 'CreateActivity', 'height=500,width=700,left=100,top=100,resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars');	
    		newWindowcreateActivity.focus();
	}else
	{
		showMessage("Activity can be linked only to an errored entity");
		return;
	}
}
function deleteEntity(name,url)
{
	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');
	var RecordStatus=getCookie('RecordStatus');
	var EntityType=getCookie('EntityType');
         var elements = document.getElementsByTagName("input");
         	var accIds="";	    	
	    	if (EntityType=='Customer'){
	    	for(var i = 0; i < AccList.length; i++) {
	    		if(AccList[i] != -1) {
	    			accIds += AccList[i] + ",";
	    			var last=accIds.lastIndexOf(',');
	    		}
	    	 }
	    	 /* Fix For Tracker ID- 127227, Ticket- 211463 changes Begin */
		 accIds=accIds.substr(0,last);
		 if (accIds==""){
			 showMessage(MSGJ0102);
			 return "false";
			 }	    	 
	    	 }
	    	 else if (EntityType=='Contact'){
	    	 /* Fix For Tracker ID- 127227, Ticket- 211463 changes END */
	    	 for(var i = 0; i < ContList.length; i++) {
			if(ContList[i] != -1) {
				accIds += ContList[i] + ",";
				var last=accIds.lastIndexOf(',');
			}
	    	 }
	    	 /* Fix For Tracker ID- 127227, Ticket- 211463 changes Begin */
		 accIds=accIds.substr(0,last);
		 if (accIds==""){
			 showMessage(MSGJ0103);
			 return "false";
			 }		
	    	 }
	    	 else if (EntityType=='Suspect'){
	    	 /* Fix For Tracker ID- 127227, Ticket- 211463 changes END */
	    	 for(var i = 0; i < SuspList.length; i++) {
			if(SuspList[i] != -1) {
				accIds += SuspList[i] + ",";
				var last=accIds.lastIndexOf(',');
			}
	    	 }
	    	 /* Fix For Tracker ID- 127227, Ticket- 211463 changes Begin */
		 accIds=accIds.substr(0,last);
		 if (accIds==""){
			showMessage(MSGJ0104);
			return "false";
			}
	    	 }
	    	 /* Fix For Tracker ID- 127227, Ticket- 211463 changes Begin */
	    	 else if (EntityType=='NonCustomer'){
		 for(var i = 0; i < NonCustList.length; i++) {
			if(NonCustList[i] != -1) {
				accIds += NonCustList[i] + ",";		 				
				var last=accIds.lastIndexOf(',');
			}
		 }
		 accIds=accIds.substr(0,last);
		 if (accIds==""){
			showMessage(MSGJ0105);
			return "false";
			}
	    	 }
	    	 /* Fix For Tracker ID- 127227, Ticket- 211463 changes END */	    	 
	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
	{
		showMessage(MSGJ50378);//Tracker 98346 changes 
		return;
	}
	else if(RecordStatus=='F')
	{
		showMessage(MSGJ0099);
	    	return;
	}
	else if(RecordStatus=='U')
	{
		    showMessage(MSGJ0385);
		    return;
	}
	else if( showConfirmMessage(MSGJ50376) ) //Tracker 98346 changes 
	{
	   var isRetail='Yes';
	   corp_Key = getCookie('corp_Key');
	   var accountId= getCookie('accountId');
	   var contactId = getCookie('contId');
	   var prospectId = getCookie('prosId');
    	   var noncustomerId=getCookie('noncustId');
    	   accountKey = getCookie('accountKey');
    	   contactsKey = getCookie('contactsKey');
           suspectsKey = getCookie('suspectsKey');
           noncustomersKey = getCookie('noncustomersKey');
    	   if(checkCookie(accountId)=="InValid")
	   {
	   	if(checkCookie(contactId)=="InValid")
	   	{
	   		if(checkCookie(prospectId)=="InValid")
	   		{
	   			if(checkCookie(noncustomerId)=="InValid")
	   			{
	   				showUserMessage('MSG007','MSG_ENT');
	   				return;
	   			}
	   			else
	   			{
	   			   entityID = noncustomerId;
	   			   cifID=noncustomersKey;
	   			 }
	   		}
	   		else
	   		{
	   		  entityID = prospectId;
	   		  cifID=suspectsKey;
	   		 }
	   	}
	   	else
	   	{
	   	  entityID = contactId;
	   	  cifID=contactsKey;
	     	 }
	   }
	   else
	   {
	     entityID = accountId;
	     cifID=accountKey;
	   }
    	   var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
    	   s_xmlHttp.abort();
	   var strURL = '../servlet/com.infy.cis.ui.common.DeleteModEntity?EntityType='+EntityType+'&entityID='+entityID+'&cifID='+cifID+'&isRetail='+isRetail+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
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
	        showUserMessage('MSGJ50371','cifID'); 
	   //Tracker 98346 changes END
	  // s_xmlHttp.send();
	   if(s_xmlHttp.status == 200)
	   {
	      //  showUserMessage('MSGJ50371','cifID'); 
	        try
		{
			window.location.href = window.location;
		 }
		   catch(e){}
	}
      }
  }
function checkCookie(x){
    if(x!=0 &&x != null && x != 'null' && x != "" && x!='undefined') { 
        return "Valid" ;
    }else{
        return "InValid";
    }
}
function ShowAuditTrail(wndName,auditUrl)
{
    if(CheckIfRowSelected() == 'false') {
        showUserMessage ('MSG014','MSG_ENT');
        return;
    }
    IsTampered = getCookie('IsTampered');
    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
    accountId = getCookie('accountId');
    accountKey = getCookie('accountKey'); 
    contactId = getCookie('contId');
    contactsKey = getCookie('contactsKey'); 
    prospectId = getCookie('prosId');
    suspectsKey = getCookie('suspectsKey');
    noncustomerId=getCookie('noncustId');
    noncustomersKey = getCookie('noncustomersKey');
    entityID = '';    
    BOName=''; 
    entityKey = '';
	if(checkCookie(accountId)=="InValid")
	{
		if(checkCookie(contactId)=="InValid")
		{
			if(checkCookie(prospectId)=="InValid")
			{ 
				if(checkCookie(noncustomerId)=="InValid")
				{ 
				showUserMessage('MSG007','MSG_ENT');
				return;
				} 
				else 
				{
				entityID = noncustomerId;
				BOName = "NonCustomerModBO";
				entityKey = noncustomersKey;			
				}
			}
			else 
			{
			entityID = prospectId;
			BOName = "SuspectModBO";
			entityKey = suspectsKey;
			}
			} 
		else 
		{
		entityID = contactId;
		BOName= "ContactModBO";	
		entityKey = contactsKey;		
		}
		} 
	else 
	{
	entityID = accountId;       
	BOName= "AccountModBO";	
	entityKey = accountKey;
	}    
    
    /* Changes for Tracker id 144187 starts here
           If AuditUrl already contains a '?' then 
           the BOName should be added after an '&'
           else after a '?'
        */
           retval = false;
           for (var i=1;i<=auditUrl.length;i++) {
              if (auditUrl.substring(i,i+1)=='?') {
        		retval = true;			
        	  }
           }
        	
           if(retval==true){		
           /* Start of Changes for Tracker id 149846 */
        	       auditUrl=auditUrl+'&BOName='+BOName+'&BOID='+entityID; 
       	   /* End of Changes for Tracker id 149846  */	 	       
           }
           else {
    	       auditUrl=auditUrl+'?BOName='+BOName+'&BOID='+entityID;
           }
                 
    auditUrl += '&Header=' + MSG_AU0082 + escape(entityKey);
    /*End of Fix for the ticket 239277*/
    
    
    /* Tracker: 108382: Changes for centering popup */
    windowAlign();
    window.open(auditUrl,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=no,scrollbars');
   /* Tracker: 108382: End of Changes */
}
var BOCreaID;
function assignEntity(name, url)
{    
    var EntityType=getCookie('EntityType');    
    IsTampered = getCookie('IsTampered');
    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
    
    if (EntityType=='Customer' || EntityType=='Account')
    {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ENT");
        return;
    }
    	var k = 0;
        var RepID = document.frm2.RepID.value;   
        var action = url;
        var accountId=getCookie('accountId');     
    var elements = document.getElementsByTagName("input");
    	var accIds="";
    	for(var i = 0; i < AccList.length; i++) {    	
    		if(AccList[i] != -1) {
    			accIds += AccList[i] + ",";    			
    			var last=accIds.lastIndexOf(',');     			
    		}
    	    }
    	    accIds=accIds.substr(0,last);  
    	    if (accIds==""){
    	    	showMessage(MSGJ0102);
    		return "false";
	    }
	var ncount=0;
	var ycount=0;
	var pgrpid="";
	if(AccList.length>1)
	{
		for(var j = 0; j<AccList.length; j++){			
			if(AccList[j]==-1)
			{
				ncount=ncount+1;
			}
			else
			{
				ycount=ycount+1;
			}
		}
		if(ycount>1)
		{
		showMessage(MSGJ0106);
		return;
		}
	}
	for(var j = 0; j<ProcessGroupIDFCust.length; j++){		
		if(ProcessGroupIDFCust[j]=="")
		{		
			showMessage(MSGJ0107);
			return;
		}
	}	
	for(var j = 0; j<ProcessGroupIDFCust.length; j++){			
		if(ProcessGroupIDFCust[j]!=-1)
		{
			pgrpid=ProcessGroupIDFCust[j];
		}
	}
    	for(var j = 0; j<OwnerIDFCust.length; j++){		
		if((RepID!=OwnerIDFCust[j])&&(OwnerIDFCust[j] != -1))
		{		
		/* CRM102BETA : TrackerID:198543 Begin of Change */
		if ((RepID!=AsstoId[j])&&(AsstoId[j] != -1))
		{
			showMessage(MSGJ0380)
			return;
		}	 
		/* CRM102BETA : TrackerID:198543 End of Change */
		}
	}	
    if(AccList.length < 2) {  	 
        accountId=AccList[0];        
        try {
        
            action += "&EntityType=Customer&entityId=" + accountId+"&RepID="+repId+"&ProcessGroupID="+pgrpid+"&BOCreatedByID="+BOCreaID+"&apprFlag=true";
            //parent.hiddenFrame.location.href = action;
            
            
            /* Tracker: 108382: Changes for centering popup */
            windowAlign();
            window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');            
           /* Tracker: 108382: End of Changes */
        } catch (ex) {
             DebugMessage('ex '+ ex.description);
        }
        return true;
    }
    else {
        try {        
            action += "&EntityType=Customer&entityId=";
            var accountIds = "";            
            for(var i = 0; i < AccList.length; i++) {
                if(AccList[i] != -1) {
                    accountIds += AccList[i] + "`";                    
                    //AccList[i] = -1;
                }
            }
             //Checksum IUT fix
            
	    		     if(accountIds.lastIndexOf('`')==accountIds.indexOf('`')){
	    					var last=accountIds.lastIndexOf('`');
	    					accountIds=accountIds.substr(0,last);
		    } 
		    //Checksum IUT fix
            
            action += accountIds+"&ProcessGroupID="+pgrpid+"&RepID="+repId+"&BOCreatedByID="+BOCreaID+"&apprFlag=true";   
            /* Tracker: 108382: Changes for centering popup */
            windowAlign();
            window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+'0, resizable=no, scrollbars=yes');
            /* Tracker: 108382: End of Changes */
        } catch (ex) 
        {
             DebugMessage('ex '+ ex.description);
        }
    }
   }
   else if (EntityType=='Contact')
    {
    	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
    	{
            showUserMessage("MSG014","MSG_ENT");
            return;
        }
        var k = 0;
        var RepID = document.frm2.RepID.value;   
        var action = url;        
        contactId=getCookie('contId');	
	    	var elements = document.getElementsByTagName("input");
		var contIds="";
		for(var i = 0; i < ContList.length; i++) 
		{
			if(ContList[i] != -1) 
			{
			contIds += ContList[i] + ",";
			var last=contIds.lastIndexOf(',');
			}
		 }
		contIds=contIds.substr(0,last);
		if (contIds=="")
		{
			showMessage(MSGJ0103);
			return "false";
		}
		var ncount=0;
		var ycount=0;
		var pgrpid="";
		if(ContList.length>1)
		{
			for(var j = 0; j<ContList.length; j++){			
				if(ContList[j]==-1)
				{
					ncount=ncount+1;
				}
				else
				{
					ycount=ycount+1;
				}
			}
			if(ycount>1)
			{
			showMessage(MSGJ0106);
			return;
			}
		}
		for(var j = 0; j<ProcessGroupIDFCont.length; j++){		
			if(ProcessGroupIDFCont[j]=="")
			{		
				showMessage(MSGJ0107);
				return;
			}
		}	
		for(var j = 0; j<ProcessGroupIDFCont.length; j++){			
			if(ProcessGroupIDFCont[j]!=-1)
			{
				pgrpid=ProcessGroupIDFCont[j];
			}
		}
		for(var j = 0; j<OwnerIdFCont.length; j++){		
			if((RepID!=OwnerIdFCont[j])&&(OwnerIdFCont[j] != -1))
			{				
			/* AXIS ISSUE : TIcket 336247 Begin of Change */
			if ((RepID!=AsstoIdFC[j])&&(AsstoIdFC[j] != -1))
			{
				showMessage(MSGJ0380)
				return;
			}							
			/* AXIS ISSUE : TIcket 336247 : End of Change */
			}
		}
	if(ContList.length < 2) 
	{  	 
		contactId=ContList[0];
		try 
		{		    
		    action += "&EntityType=Contact&entityId=" + contactId+"&RepID="+repId+"&ProcessGroupID="+pgrpid+"&BOCreatedByID="+BOCreaID+"&apprFlag=true";
		    
		    
		    /* Tracker: 108382: Changes for centering popup */
		    windowAlign();
		    window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');            
		    /* Tracker: 108382: End of Changes */
		} 
		catch (ex) 
		{
                  DebugMessage('ex '+ ex.description);
		}
	return true;
	}
	else 
	{
	        try
	        {        
	            action += "&EntityType=Contact&entityId=";
	            var contactIds = "";
	            for(var i = 0; i < ContList.length; i++) 
	            {
	                if(ContList[i] != -1) 
	                {
	                    contactIds += ContList[i] + "`";
	                }
	            }	            
	            action += contactIds+"&ProcessGroupID="+pgrpid+"&RepID="+repId+"&BOCreatedByID="+BOCreaID+"&apprFlag=true";            
	        /* Tracker: 108382: Changes for centering popup */
	         windowAlign();
	          window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');
	           /* Tracker: 108382: End of Changes */
	        } 
	        catch (ex) 
	        {
                  DebugMessage('ex '+ ex.description);
	        }
    	}
    }
       else if (EntityType=='Suspect')
        {
	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
	{
		showUserMessage("MSG014","MSG_ENT");
		return;
	}
	var k = 0;
	var RepID = document.frm2.RepID.value;   
	var action = url;
	prospectId=getCookie('prosId');
	var elements = document.getElementsByTagName("input");
	var suspIds="";
	for(var i = 0; i < SuspList.length; i++) 
	{
		if(SuspList[i] != -1) 
		{
		suspIds += SuspList[i] + ",";
		var last=suspIds.lastIndexOf(',');
		}
	 }
	suspIds=suspIds.substr(0,last);
	if (suspIds=="")
	{
		showMessage(MSGJ0104);
		return "false";
	}
	var ncount=0;
	var ycount=0;
	var pgrpid="";
	if(SuspList.length>1)
	{
		for(var j = 0; j<SuspList.length; j++){			
			if(SuspList[j]==-1)
			{
				ncount=ncount+1;
			}
			else
			{
				ycount=ycount+1;
			}
		}
		if(ycount>1)
		{
		showMessage(MSGJ0106);
		return;
		}
	}
	for(var j = 0; j<ProcessGroupIDFS.length; j++){		
		if(ProcessGroupIDFS[j]=="")
		{	
			showMessage(MSGJ0107);
			return;
		}
	}
	for(var j = 0; j<ProcessGroupIDFS.length; j++){			
		if(ProcessGroupIDFS[j]!=-1)
		{
			pgrpid=ProcessGroupIDFS[j];
		}
	}
	for(var j = 0; j<OwnerIdFS.length; j++){		
		if((RepID!=OwnerIdFS[j])&&(OwnerIdFS[j] != -1))
		{		
		/* AXIS ISSUE : TIcket 336247 Begin of Change */
		if ((RepID!=AsstoIdFS[j])&&(AsstoIdFS[j] != -1))
		{
			showMessage(MSGJ0380)
			return;
		}							
		/* AXIS ISSUE : TIcket 336247 End of Change */
		}
	}
    	if(SuspList.length < 2) 
    	{  	 
    		prospectId=SuspList[0];
    		try 
    		{    		    
    		    action += "&EntityType=Suspect&entityId=" + prospectId+"&RepID="+repId+"&ProcessGroupID="+pgrpid+"&BOCreatedByID="+BOCreaID+"&apprFlag=true";
    		    
    		    
    		    /* Tracker: 108382: Changes for centering popup */
    		    windowAlign();
    		    window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');            
    		    /* Tracker: 108382: End of Changes */
    		} 
    		catch (ex) 
    		{
                      DebugMessage('ex '+ ex.description);
    		}
    	return true;
    	}
    	else 
    	{
    	        try
    	        {        
    	            action += "&EntityType=Suspect&entityId=";
    	            var suspectIds = "";
    	            for(var i = 0; i < SuspList.length; i++) 
    	            {
    	                if(SuspList[i] != -1) 
    	                {
    	                    suspectIds += SuspList[i] + "`";
    	                }
    	            }    	            
    	            action += suspectIds+"&ProcessGroupID="+pgrpid+"&RepID="+repId+"&BOCreatedByID="+BOCreaID+"&apprFlag=true";            
    	            /* Tracker: 108382: Changes for centering popup */
    	            windowAlign();
    	            window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');
    	           /* Tracker: 108382: End of Changes */
    	        } 
    	        catch (ex) 
    	        {
                                DebugMessage('ex '+ ex.description);
    	        }
        	}
    }
    else if (EntityType=='NonCustomer')
            {
            	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
            	{
                    showUserMessage("MSG014","MSG_ENT");
                    return;
                }
                var k = 0;
                var RepID = document.frm2.RepID.value;   
                var action = url;
		noncustomerId=getCookie('noncustId'); 
		var elements = document.getElementsByTagName("input");
		var noncustIds="";
		for(var i = 0; i < NonCustList.length; i++) 
		{
			if(NonCustList[i] != -1) 
			{
			noncustIds += NonCustList[i] + ",";
			var last=noncustIds.lastIndexOf(',');
			}
		 }
		noncustIds=noncustIds.substr(0,last);
		if (noncustIds=="")
		{
			showMessage(MSGJ0105);
			return "false";
		}
		var ncount=0;
		var ycount=0;
		var pgrpid="";
		if(NonCustList.length>1)
		{
			for(var j = 0; j<NonCustList.length; j++){			
				if(NonCustList[j]==-1)
				{
					ncount=ncount+1;
				}
				else
				{
					ycount=ycount+1;
				}
			}
			if(ycount>1)
			{
			showMessage(MSGJ0106);
			return;
			}
		}
		for(var j = 0; j<ProcessGroupIDFNC.length; j++){		
			if(ProcessGroupIDFNC[j]=="")
			{		
				showMessage(MSGJ0107);
				return;
			}
		}
		for(var j = 0; j<ProcessGroupIDFNC.length; j++){			
			if(ProcessGroupIDFNC[j]!=-1)
			{
				pgrpid=ProcessGroupIDFNC[j];
			}
		}
		for(var j = 0; j<OwnerIdFNC.length; j++){		
			if((RepID!=OwnerIdFNC[j])&&(OwnerIdFNC[j] != -1))
			{		
			/* AXIS ISSUE : TIcket 336247 Begin of Change */
			if ((RepID!=AsstoIdFNC[j])&&(AsstoIdFNC[j] != -1))
			{
				showMessage(MSGJ0380)
				return;
			}							
			/* AXIS ISSUE : TIcket 336247 End of Change */
			}
		}
        	if(NonCustList.length < 2) 
        	{         
        		noncustomerId=NonCustList[0];
        		try 
        		{        		    
        		    action += "&EntityType=NonCustomer&entityId=" + noncustomerId+"&RepID="+repId+"&ProcessGroupID="+pgrpid+"&BOCreatedByID="+BOCreaID+"&apprFlag=true";
        		    
        		    
        		    /* Tracker: 108382: Changes for centering popup */
        		    windowAlign();
        		    window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');            
        		    /* Tracker: 108382: End of Changes */
        		} 
        		catch (ex) 
        		{
                          DebugMessage('ex '+ ex.description);
        		}
        	return true;
        	}
        	else 
        	{
        	        try
        	        {        
        	            action += "&EntityType=NonCustomer&entityId=";
        	            var noncustomerIds = "";
        	            for(var i = 0; i < NonCustList.length; i++) 
        	            {
        	                if(NonCustList[i] != -1) 
        	                {
        	                    noncustomerIds += NonCustList[i] + "`";
        	                }
        	            }        	            
        	            action += noncustomerIds+"&ProcessGroupID="+pgrpid+"&RepID="+repId+"&BOCreatedByID="+BOCreaID+"&apprFlag=true";            
        	           /* Tracker: 108382: Changes for centering popup */
        	           windowAlign();
        	           window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');
        	           /* Tracker: 108382: End of Changes */
        	        } 
        	        catch (ex) 
        	        {
                                    DebugMessage('ex '+ ex.description);
        	        }
            	}
    }
}
var BOCreaID;
function transferEntity(name, url)
{
    var EntityType=getCookie('EntityType');    
    var RepID = document.frm2.RepID.value;
    var OwnerID=getCookie('OwnerID'); 
    var BOCreatedByID=getCookie('MakerID');
// Checksum security fix start
			var strHashKey=getHashKey(EntityType);
			var strFldKey=getFldKey(EntityType);
// Checksum security fix end
    if (EntityType=='Customer')
    {    
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){    
        showUserMessage("MSG014","MSG_ENT");
        return;
    }
    	var k = 0;
        var RepID = document.frm2.RepID.value;   
        var action = url;
        var accountId=getCookie('accountId');
         var elements = document.getElementsByTagName("input");
	    	var accIds="";	    	
	    	for(var i = 0; i < AccList.length; i++) {
	    		if(AccList[i] != -1) {
	    			accIds += AccList[i] + ",";
	    			var last=accIds.lastIndexOf(',');
	    		}
	    	    }
	    	    accIds=accIds.substr(0,last);
	    	    if (accIds==""){
	    		showMessage(MSGJ0102);
	    		return "false";
	    }
	    for(var j = 0; j<ProcessGroupIDFCust.length; j++){		
		if(ProcessGroupIDFCust[j]=="")
		{		
			showMessage(MSGJ0107);
			return;
		}
	}
        for(var j = 0; j<OwnerIDFCust.length; j++){		
		if((RepID!=OwnerIDFCust[j])&&(OwnerIDFCust[j] != -1))
		{					
			showMessage(MSGJ0110)
			return;
		}
	}   	
    if(AccList.length < 2) {  	 
        accountId=AccList[0]; 
        try {
            // Checksum security recon changes from 10.3 SUPP start
            action += "&EntityType="+EntityType+"&entityId=" + accountId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID+"&TransferFlag=true&apprFlag=true&SECUREHKEY="+strHashKey+"&FLDHASHKEY="+strFldKey; 
            
            // Checksum security recon changes from 10.3 SUPP end
           /* Tracker: 108382: Changes for centering popup */
           windowAlign();
            window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');            
/* Tracker: 108382: End of Changes */
        } catch (ex) {
                        DebugMessage('ex '+ ex.description);
        }
        return true;
        }
    else {
        try {        
            // Checksum security recon changes from 10.3 SUPP start       
            action += "&EntityType=Customer&entityId=";		 
          // Checksum security recon changes from 10.3 SUPP end
            var accountIds = "";
            for(var i = 0; i < AccList.length; i++) {
                if(AccList[i] != -1) {
                    accountIds += AccList[i] + "`";
                }
            }
            // Checksum security recon changes from 10.3 SUPP start       

	    	    			    
	    	    if(accountIds.lastIndexOf('`')==accountIds.indexOf('`')){
	    		var last=accountIds.lastIndexOf('`');
	    		accountIds=accountIds.substr(0,last);
	    	    } 
	      // Checksum security recon changes from 10.3 SUPP end      

            action += accountIds+"&RepID="+repId+"&BOCreatedByID="+BOCreaID+"&TransferFlag=true&apprFlag=true&SECUREHKEY="+strHashKey+"&FLDHASHKEY="+strFldKey;            
           /* Tracker: 108382: Changes for centering popup */
           windowAlign();
            window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');
/* Tracker: 108382: End of Changes */
        } catch (ex) 
        {
                            DebugMessage('ex '+ ex.description);
        }
    }
   }
   else if (EntityType=='Contact')
    {
    	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
    	{
            showUserMessage("MSG014","MSG_ENT");
            return;
        }
        var k = 0;
        var RepID = document.frm2.RepID.value;   
        var action = url;
        contactId=getCookie('contId');				
	    	var elements = document.getElementsByTagName("input");
		var contIds="";
		for(var i = 0; i < ContList.length; i++) 
		{
			if(ContList[i] != -1) 
			{
			contIds += ContList[i] + ",";
			var last=contIds.lastIndexOf(',');
			}
		 }
		contIds=contIds.substr(0,last);
		if (contIds=="")
		{
			showMessage(MSGJ0103);
			return "false";
	}
	for(var j = 0; j<ProcessGroupIDFCont.length; j++){		
			if(ProcessGroupIDFCont[j]=="")
			{		
				showMessage(MSGJ0107);
				return;
			}
		}
	for(var j = 0; j<OwnerIdFCont.length; j++){		
		if((RepID!=OwnerIdFCont[j])&&(OwnerIdFCont[j] != -1))
		{		
			showMessage(MSGJ0110)
			return;
		}
	}   
	if(ContList.length < 2) 
	{  	 
		contactId=ContList[0];
		try 
		{		    
          // Checksum security recon changes from 10.3 SUPP start       
	    
		    action += "&EntityType=Contact&entityId=" + contactId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID+"&TransferFlag=true&apprFlag=true&SECUREHKEY="+strHashKey+"&FLDHASHKEY="+strFldKey;  
		  // Checksum security recon changes from 10.3 SUPP end      
		   /* Tracker: 108382: Changes for centering popup */
		    windowAlign();
		    window.open(action,'','height=436, left=70, top=120, width=860, resizable=no, scrollbars=yes');            
/* Tracker: 108382: End of Changes */
		} 
		catch (ex) 
		{
                   DebugMessage('ex '+ ex.description);
		}
	return true;
	}
	else 
	{
	        try
	        {        
                // Checksum security recon changes from 10.3 SUPP start       
     
	            action += "&EntityType=Contact&entityId=";	
                // Checksum security recon changes from 10.3 SUPP end      
	            var contactIds = "";
	            for(var i = 0; i < ContList.length; i++) 
	            {
	                if(ContList[i] != -1) 
	                {
	                    contactIds += ContList[i] + "`";
	                }
	            }	            
	            
	            // Checksum security recon changes from 10.3 SUPP start
		    	      if(contactIds.lastIndexOf('`')==contactIds.indexOf('`')){
					var last=contactIds.lastIndexOf('`');
					contactIds=contactIds.substr(0,last);
		    
		    			}
		    			
	            action += contactIds+"&RepID="+repId+"&BOCreatedByID="+BOCreaID+"&TransferFlag=true&apprFlag=true&SECUREHKEY="+strHashKey+"&FLDHASHKEY="+strFldKey;       
                // Checksum security recon changes from 10.3 SUPP end
	            /* Tracker: 108382: Changes for centering popup */
	            windowAlign();
	            window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');
	           /* Tracker: 108382: End of Changes */
	        } 
	        catch (ex) 
	        {
                             DebugMessage('ex '+ ex.description);
	        }
    	}
    }
       else if (EntityType=='Suspect')
        {
		if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
		{
			showUserMessage("MSG014","MSG_ENT");
			return;
            	}
		var k = 0;
		var RepID = document.frm2.RepID.value;   
		var action = url;
		prospectId=getCookie('prosId');
		var elements = document.getElementsByTagName("input");
		var suspIds="";
		for(var i = 0; i < SuspList.length; i++) 
		{
			if(SuspList[i] != -1) 
			{
			suspIds += SuspList[i] + ",";
			var last=suspIds.lastIndexOf(',');
			}
		 }
		suspIds=suspIds.substr(0,last);
		if (suspIds=="")
		{
			showMessage(MSGJ0104);
			return "false";
		}
		for(var j = 0; j<ProcessGroupIDFS.length; j++){		
			if(ProcessGroupIDFS[j]=="")
			{		
				showMessage(MSGJ0107);
				return;
			}
		}
		for(var j = 0; j<OwnerIdFS.length; j++){		
			if((RepID!=OwnerIdFS[j])&&(OwnerIdFS[j] != -1))
			{		
				showMessage(MSGJ0110)
				return;
			}
		}   
    	if(SuspList.length < 2) 
    	{  	 
    		prospectId=SuspList[0];    		
    		try 
    		{
                // Checksum security recon changes from 10.3 SUPP start
    		    action += "&EntityType=Suspect&entityId=" + prospectId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID+"&TransferFlag=true&apprFlag=true&SECUREHKEY="+strHashKey+"&FLDHASHKEY="+strFldKey;	  
               
				// Checksum security recon changes from 10.3 SUPP end
    		   /* Tracker: 108382: Changes for centering popup */
    		   windowAlign();
    		   window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');            
    		/* Tracker: 108382: End of Changes */
    		} 
    		catch (ex) 
    		{
                       DebugMessage('ex '+ ex.description);
    		}
    	return true;
    	}
    	else 
    	{
    	        try
    	        {        
                    // Checksum security recon changes from 10.3 SUPP start    
    	            action += "&EntityType=Suspect&entityId=";		
                    // Checksum security recon changes from 10.3 SUPP end
    	            var suspectIds = "";
    	            for(var i = 0; i < SuspList.length; i++) 
    	            {
    	                if(SuspList[i] != -1) 
    	                {
    	                    suspectIds += SuspList[i] + "`";
    	                }
    	            }    	            
    	            
    	             // Checksum security recon changes from 10.3 SUPP start
		      if(suspectIds.lastIndexOf('`')==suspectIds.indexOf('`')){
				var last=suspectIds.lastIndexOf('`');
				suspectIds=suspectIds.substr(0,last);

				}
    	            action += suspectIds+"&RepID="+repId+"&BOCreatedByID="+BOCreaID+"&TransferFlag=true&apprFlag=true&SECUREHKEY="+strHashKey+"&FLDHASHKEY="+strFldKey; 
             	   // Checksum security recon changes from 10.3 SUPP end
    	           /* Tracker: 108382: Changes for centering popup */
    	           windowAlign();
    	            window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');
    	           /* Tracker: 108382: End of Changes */
    	        } 
    	        catch (ex) 
    	        {
                                 DebugMessage('ex '+ ex.description);
    	        }
        	}
    }
    else if (EntityType=='NonCustomer')
            {
            	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
            	{
                    showUserMessage("MSG014","MSG_ENT");
                    return;
                }
                var k = 0;
                var RepID = document.frm2.RepID.value;   
                var action = url;
                noncustomerId=getCookie('noncustId'); 
		var elements = document.getElementsByTagName("input");
		var noncustIds="";
		for(var i = 0; i < NonCustList.length; i++) 
		{
			if(NonCustList[i] != -1) 
			{
			noncustIds += NonCustList[i] + ",";
			var last=noncustIds.lastIndexOf(',');
			}
		 }
		noncustIds=noncustIds.substr(0,last);
		if (noncustIds=="")
		{
			showMessage(MSGJ0105);
			return "false";
		}
		for(var j = 0; j<ProcessGroupIDFNC.length; j++){		
			if(ProcessGroupIDFNC[j]=="")
			{		
				showMessage(MSGJ0107);
				return;
			}
		}
		for(var j = 0; j<OwnerIdFNC.length; j++){		
			if((RepID!=OwnerIdFNC[j])&&(OwnerIdFNC[j] != -1))
			{		
				showMessage(MSGJ0110)
				return;
			}
		}         	
        	if(NonCustList.length < 2) 
        	{         
        		noncustomerId=NonCustList[0];
        		try 
        		{
                    // Checksum security recon changes from 10.3 SUPP start
        		    action += "&EntityType=NonCustomer&entityId=" + noncustomerId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID+"&TransferFlag=true&apprFlag=true&SECUREHKEY="+strHashKey+"&FLDHASHKEY="+strFldKey;
					// Checksum security recon changes from 10.3 SUPP end
        		 /* Tracker: 108382: Changes for centering popup */
        		 windowAlign();
        		  window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');            
        		/* Tracker: 108382: End of Changes */
        		} 
        		catch (ex) 
        		{
                           DebugMessage('ex '+ ex.description);
        		}
        	return true;
        	}
        	else 
        	{
        	        try
        	        {        
                        // Checksum security recon changes from 10.3 SUPP start    
        	            action += "&EntityType=NonCustomer&entityId=";		
                        // Checksum security recon changes from 10.3 SUPP end
        	            var noncustomerIds = "";
        	            for(var i = 0; i < NonCustList.length; i++) 
        	            {
        	                if(NonCustList[i] != -1) 
        	                {
        	                    noncustomerIds += NonCustList[i] + "`";
        	                }
        	            }        	            
        	            
        	            // Checksum security recon changes from 10.3 SUPP start
			    	    	    			    
			    if(noncustomerIds.lastIndexOf('`')==noncustomerIds.indexOf('`')){
				var last=noncustomerIds.lastIndexOf('`');
				noncustomerIds=noncustomerIds.substr(0,last);
			    } 
        	            action += noncustomerIds+"&RepID="+repId+"&BOCreatedByID="+BOCreaID+"&TransferFlag=true&apprFlag=true&SECUREHKEY="+strHashKey+"&FLDHASHKEY="+strFldKey;    
	    		      // Checksum security recon changes from 10.3 SUPP end
        	          /* Tracker: 108382: Changes for centering popup */
        	          windowAlign();
        	           window.open(action,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, scrollbars=yes');
        	            /* Tracker: 108382: End of Changes */
        	        } 
        	        catch (ex) 
        	        {
                                     DebugMessage('ex '+ ex.description);
        	        }
            	}
    }
}
var BOCreaID;
function assignEntityToGroup(name, url)
{
    var EntityType=getCookie('EntityType');    
    IsTampered = getCookie('IsTampered');
    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
    if (EntityType=='Customer')
    {
    if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false"){
        showUserMessage("MSG014","MSG_ENT");
        return;
    }
    	var k = 0;
        var RepID = document.frm2.RepID.value;   
        var action = url;
        var accountId=getCookie('accountId');
    var elements = document.getElementsByTagName("input");
    	var accIds="";
    	for(var i = 0; i < AccList.length; i++) {
    		if(AccList[i] != -1) {
    			accIds += AccList[i] + ",";
    			var last=accIds.lastIndexOf(',');
    		}
    	    }
    	    accIds=accIds.substr(0,last);
    	    if (accIds==""){
    		showMessage(MSGJ0102);
    		return "false";
	    }
	for(var j = 0; j<ProcessGroupIDFCust.length; j++){		
		if(ProcessGroupIDFCust[j]=="")
		{		
			showMessage(MSGJ0107);
			return;
		}
	}
	     for(var j = 0; j<OwnerIDFCust.length; j++){		
	    		if((RepID!=OwnerIDFCust[j])&&(OwnerIDFCust[j] != -1))
	    		{		
	    			if ((RepID!=AsstoId[j])&&(AsstoId[j] != -1))
	    			{
	    			showMessage(MSGJ0111)
	    			return;
	    			}
	    		}
		}   	
    if(AccList.length < 2) {  	 
        accountId=AccList[0]; 
        try {
        if (url.indexOf('?') !=-1){
            action += "&EntityType=Customer&entityId=" + accountId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID; 
            }
          else{
	       action += "?EntityType=Customer&entityId=" + accountId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID; 
            }
            parent.hiddenFrame.location.href = action;
        } catch (ex) {
                        DebugMessage('ex '+ ex.description);
        }
        return true;
    }
    else {
        try {        
         if (url.indexOf('?') !=-1){
            action += "&EntityType=Customer&entityId=";
             }
          else{
          action += "?EntityType=Customer&entityId=";
          }
            var accountIds = "";
            for(var i = 0; i < AccList.length; i++) {
                if(AccList[i] != -1) {
                    accountIds += AccList[i] + "`";
                    var last=accountIds.lastIndexOf('`');
                }
            }
            accountIds=accountIds.substr(0,last);
            action += accountIds+"&RepID="+repId+"&BOCreatedByID="+BOCreaID;            
            parent.hiddenFrame.location.href = action+ "&TabName=" + name ;
        } catch (ex) 
        {
                            DebugMessage('ex '+ ex.description);
        }
    }
   }
   else if (EntityType=='Contact')
    {
    	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
    	{
            showUserMessage("MSG014","MSG_ENT");
            return;
        }
        var k = 0;
        var RepID = document.frm2.RepID.value;   
        var action = url;    	
	contactId=getCookie('contId');	
    	var elements = document.getElementsByTagName("input");
	var contIds="";
	for(var i = 0; i < ContList.length; i++) 
	{
		if(ContList[i] != -1) 
		{
		contIds += ContList[i] + ",";
		var last=contIds.lastIndexOf(',');
		}
	 }
	contIds=contIds.substr(0,last);
	if (contIds=="")
	{
		showMessage(MSGJ0103);
		return "false";
	}
	for(var j = 0; j<ProcessGroupIDFCont.length; j++){		
		if(ProcessGroupIDFCont[j]=="")
		{		
			showMessage(MSGJ0107);
			return;
		}
	}
	for(var j = 0; j<OwnerIdFCont.length; j++){		
		if((RepID!=OwnerIdFCont[j])&&(OwnerIdFCont[j] != -1))
		{		
			if ((RepID!=AsstoIdFC[j])&&(AsstoIdFC[j] != -1))
			{
			showMessage(MSGJ0111)
			return;
			}
		}
	}   
	if(ContList.length < 2) 
	{  	 
		contactId=ContList[0]; 		
		try 
		{
		if (url.indexOf('?') !=-1){
		    action += "&EntityType=Contact&entityId=" + contactId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID;
		   }
		else {
		 action += "?EntityType=Contact&entityId=" + contactId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID;
		}    
		    parent.hiddenFrame.location.href = action;
		} 
		catch (ex) 
		{
                  DebugMessage('ex '+ ex.description);
		}
	return true;
	}
	else 
	{
	        try
	        {        
	        if (url.indexOf('?') !=-1){
	            action += "&EntityType=Contact&entityId=";
	           }
		else {
		  action += "?EntityType=Contact&entityId=";
	           }
	            var contactIds = "";
	            for(var i = 0; i < ContList.length; i++) 
	            {
	                if(ContList[i] != -1) 
	                {
	                    contactIds += ContList[i] + "`";
	                    var last=contactIds.lastIndexOf('`');
			                    }
			                }
			                
		    contactIds=contactIds.substr(0,last);
	            action += contactIds+"&RepID="+repId+"&BOCreatedByID="+BOCreaID;            
	            parent.hiddenFrame.location.href = action+ "&TabName=" + name ;
	        } 
	        catch (ex) 
	        {
                              DebugMessage('ex '+ ex.description);
	        }
    	}
    }
       else if (EntityType=='Suspect')
        {
        	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
        	{
                showUserMessage("MSG014","MSG_ENT");
                return;
            }
            var k = 0;
            var RepID = document.frm2.RepID.value;   
            var action = url;
            prospectId=getCookie('prosId');
		var elements = document.getElementsByTagName("input");
		var suspIds="";
		for(var i = 0; i < SuspList.length; i++) 
		{
			if(SuspList[i] != -1) 
			{
			suspIds += SuspList[i] + ",";
			var last=suspIds.lastIndexOf(',');
			}
		 }
		suspIds=suspIds.substr(0,last);
		if (suspIds=="")
		{
			showMessage(MSGJ0104);
			return "false";
		}
		for(var j = 0; j<ProcessGroupIDFS.length; j++){		
			if(ProcessGroupIDFS[j]=="")
			{		
				showMessage(MSGJ0107);
				return;
			}
		}
		for(var j = 0; j<OwnerIdFS.length; j++){		
			if((RepID!=OwnerIdFS[j])&&(OwnerIdFS[j] != -1))
			{		
				if ((RepID!=AsstoIdFS[j])&&(AsstoIdFS[j] != -1))
				{
				showMessage(MSGJ0111)
				return;
				}
			}
		}   
    	if(SuspList.length < 2) 
    	{  	 
    		prospectId=SuspList[0];
    		try 
    		{
    		if (url.indexOf('?') !=-1){
    		    action += "&EntityType=Suspect&entityId=" + prospectId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID;
    		    }
    		else {
    			action += "?EntityType=Suspect&entityId=" + prospectId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID;
    		}
    		    parent.hiddenFrame.location.href = action;
    		} 
    		catch (ex) 
    		{
                       DebugMessage('ex '+ ex.description);
    		}
    	return true;
    	}
    	else 
    	{
    	        try
    	        {        
    	            if (url.indexOf('?') !=-1){
    	            action += "&EntityType=Suspect&entityId=";
    	             }
    			else {
    			 action += "?EntityType=Suspect&entityId=";
    			 }
    	            var suspectIds = "";
    	            for(var i = 0; i < SuspList.length; i++) 
    	            {
    	                if(SuspList[i] != -1) 
    	                {
    	                    suspectIds += SuspList[i] + "`";
    	                    var last=suspectIds.lastIndexOf('`');
			    }
			}
			                
		    suspectIds=suspectIds.substr(0,last);
    	            action += suspectIds+"&RepID="+repId+"&BOCreatedByID="+BOCreaID;            
    	            parent.hiddenFrame.location.href = action+ "&TabName=" + name;
    	        } 
    	        catch (ex) 
    	        {
                                 DebugMessage('ex '+ ex.description);
    	        }
        	}
    }
    else if (EntityType=='NonCustomer')
            {
            	if(CheckForSelectedRow(document.getElementsByName('RecordSet'))=="false")
            	{
                    showUserMessage("MSG014","MSG_ENT");
                    return;
                }
                var k = 0;
                var RepID = document.frm2.RepID.value;   
                var action = url;
                noncustomerId=getCookie('noncustId'); 
		var elements = document.getElementsByTagName("input");
		var noncustIds="";
		for(var i = 0; i < NonCustList.length; i++) 
		{
			if(NonCustList[i] != -1) 
			{
			noncustIds += NonCustList[i] + ",";
			var last=noncustIds.lastIndexOf(',');
			}
		 }
		noncustIds=noncustIds.substr(0,last);
		if (noncustIds=="")
		{
			showMessage(MSGJ0105);
			return "false";
		}
		for(var j = 0; j<ProcessGroupIDFNC.length; j++){		
			if(ProcessGroupIDFNC[j]=="")
			{		
				showMessage(MSGJ0107);
				return;
			}
		}
		for(var j = 0; j<OwnerIdFNC.length; j++){		
			if((RepID!=OwnerIdFNC[j])&&(OwnerIdFNC[j] != -1))
			{		
				if ((RepID!=AsstoIdFNC[j])&&(AsstoIdFNC[j] != -1))
				{
				showMessage(MSGJ0111)
				return;
				}
			}
		} 
        	if(NonCustList.length < 2) 
        	{         
        		noncustomerId=NonCustList[0];
        		try 
        		{
        		if (url.indexOf('?') !=-1){
        		    action += "&EntityType=NonCustomer&entityId=" + noncustomerId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID;
        		    }
        		else {
        		 action += "?EntityType=NonCustomer&entityId=" + noncustomerId+"&RepID="+repId+"&BOCreatedByID="+BOCreaID;
        		 }
        		    parent.hiddenFrame.location.href = action;
        		} 
        		catch (ex) 
        		{
                           DebugMessage('ex '+ ex.description);
        		}
        	return true;
        	}
        	else 
        	{
        	        try
        	        {        
        	     		if (url.indexOf('?') !=-1){
        	            	action += "&EntityType=NonCustomer&entityId=";
        	            	}
        	            	else {
        	                action += "?EntityType=NonCustomer&entityId=";
        	                }
        	            var noncustomerIds = "";
        	            for(var i = 0; i < NonCustList.length; i++) 
        	            {
        	                if(NonCustList[i] != -1) 
        	                {
        	                    noncustomerIds += NonCustList[i] + "`";
        	                    var last=noncustomerIds.lastIndexOf('`');
        	                }
        	            }
		   		 noncustomerIds=noncustomerIds.substr(0,last);
        	            action += noncustomerIds+"&RepID="+repId+"&BOCreatedByID="+BOCreaID;            
        	            parent.hiddenFrame.location.href = action+ "&TabName=" + name ;
        	        } 
        	        catch (ex) 
        	        {
                                     DebugMessage('ex '+ ex.description);
        	        }
            	}
    }
}
var AccList     = new Array();
var AccId  = new Array();
var BOCrId  = new Array();
var AsstoId  = new Array();
var OwnerIDFCust  = new Array();
var ProcessGroupIDFCust  = new Array();
var AssignGrpFCust = new Array();
var OwnerGrpFCust = new Array();
// Checksum security fix start
var selHashKeysCust = new Array();
var selFldKeysCust = new Array();
// Checksum security fix end
function AddSelectedRowToList(ID) { 
IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
	{	 showMessage(MSGJ50260);
		return;
	}
    var flag = false;     
    for(var i = 0; i < AccList.length; i++) {	
        if(AccList[i] == ID) {	   
            AccList[i]     = -1;
            AccId[i]  = -1;
            BOCrId[i]  = -1;
            AsstoId[i]  = -1;
            OwnerIDFCust[i]  = -1;
            ProcessGroupIDFCust[i]  = -1;
            AssignGrpFCust[i]  = -1;
            OwnerGrpFCust[i]  = -1;
            selHashKeysCust[i] = -1;
            selFldKeysCust[i] = -1;
            flag = true;            
            break;
        }
    }
    if(!flag) {    
        var AccoId  = event.srcElement.parentElement.parentElement.getAttribute('AccountModBO.accountID');        
        var BOCreId  = event.srcElement.parentElement.parentElement.getAttribute('AccountModBO.MakerID');        
        var AssitoId  = event.srcElement.parentElement.parentElement.getAttribute('AccountModBO.AssignedTo');
        var OwnersIDFCust  = event.srcElement.parentElement.parentElement.getAttribute('AccountModBO.ownedUserID');        
        var ProcessGroupsIDFCust  = event.srcElement.parentElement.parentElement.getAttribute('AccountModBO.ProcessID');    
        var AssignGrpsFCust  = event.srcElement.parentElement.parentElement.getAttribute('AccountModBO.AssignedToGroup');        
        var OwnerGrpsFCust  = event.srcElement.parentElement.parentElement.getAttribute('AccountModBO.OwnerGroup');    
        // Checksum security fix start
			    var HashKey=event.srcElement.parentElement.parentElement.getAttribute('hashkey');
			    var FldKey=event.srcElement.parentElement.parentElement.getAttribute('fieldHashkey1');
	    // Checksum security fix end
        AccList[AccList.length]         = ID;
        AccId[AccId.length]       = AccoId;
        BOCrId[BOCrId.length]       = BOCreId;
        AsstoId[AsstoId.length]       = AssitoId;
        OwnerIDFCust[OwnerIDFCust.length] = OwnersIDFCust;
        ProcessGroupIDFCust[ProcessGroupIDFCust.length] = ProcessGroupsIDFCust;
        AssignGrpFCust[AssignGrpFCust.length] = AssignGrpsFCust;
        OwnerGrpFCust[OwnerGrpFCust.length] = OwnerGrpsFCust;
        // Checksum security fix start
					selHashKeysCust[selHashKeysCust.length]=HashKey;
					selFldKeysCust[selFldKeysCust.length]=FldKey;
	    // Checksum security fix end
    }    
}
var ContList     = new Array();
var ContId  = new Array();
var BOCrIdFC  = new Array();
var AsstoIdFC  = new Array();
var OwnerIdFCont  = new Array();
var ProcessGroupIDFCont  = new Array();
var AssignGrpFCont = new Array();
var OwnerGrpFCont = new Array();
// Checksum security fix start
var selHashKeysCont = new Array();
var selFldKeysCont = new Array();
// Checksum security fix end
function AddSelectedRowToListForContact(ID) {	
IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
	{	 showMessage(MSGJ50260);
		return;
	}
    var flag = false;
    for(var i = 0; i < ContList.length; i++) {
        if(ContList[i] == ID) {
            ContList[i]     = -1;
            ContId[i]  = -1;
            BOCrIdFC[i]  = -1;
            AsstoIdFC[i]  = -1;
            OwnerIdFCont[i]  = -1;
            ProcessGroupIDFCont[i]  = -1;
            AssignGrpFCont[i]  = -1;
            OwnerGrpFCont[i]  = -1;
            selHashKeysCont[i] = -1;
            selFldKeysCont[i] = -1;
            flag = true;
            break;
        }
    }
    if(!flag) {
        var ContaId  	= event.srcElement.parentElement.parentElement.getAttribute('ContactModBO.contactID');        
        var BOCreIdFC  	= event.srcElement.parentElement.parentElement.getAttribute('ContactModBO.MakerID');        
        var AssitoIdFC  = event.srcElement.parentElement.parentElement.getAttribute('ContactModBO.AssignedTo');                
        var OwnersIdFCont  = event.srcElement.parentElement.parentElement.getAttribute('ContactModBO.ownedUserID');        
        var ProcessGroupsIDFCont  = event.srcElement.parentElement.parentElement.getAttribute('ContactModBO.ProcessID');        
        var AssignGrpsFCont  = event.srcElement.parentElement.parentElement.getAttribute('ContactModBO.AssignedToGroup');        
        var OwnerGrpsFCont  = event.srcElement.parentElement.parentElement.getAttribute('ContactModBO.OwnerGroup');    
        // Checksum security fix start
       			    var HashKey=event.srcElement.parentElement.parentElement.getAttribute('hashkey');
       			    var FldKey=event.srcElement.parentElement.parentElement.getAttribute('fieldHashkey1');
       	
	  // Checksum security fix end
        ContList[ContList.length]   = ID;
        ContId[ContId.length]       = ContaId;
        BOCrIdFC[BOCrIdFC.length]   = BOCreIdFC;
        AsstoIdFC[AsstoIdFC.length] = AssitoIdFC;
        OwnerIdFCont[OwnerIdFCont.length] = OwnersIdFCont;
        ProcessGroupIDFCont[ProcessGroupIDFCont.length] = ProcessGroupsIDFCont;
        AssignGrpFCont[AssignGrpFCont.length] = AssignGrpsFCont;
        OwnerGrpFCont[OwnerGrpFCont.length] = OwnerGrpsFCont;
         // Checksum security fix start
				selHashKeysCont[selHashKeysCont.length]=HashKey;
				selFldKeysCont[selFldKeysCont.length]=FldKey;
	     // Checksum security fix end
    }
}
var SuspList = new Array();
var SuspId  = new Array();
var BOCrIdFS  = new Array();
var AsstoIdFS  = new Array();
var OwnerIdFS  = new Array();
var ProcessGroupIDFS  = new Array();
var AssignGrpFSusp = new Array();
var OwnerGrpFSusp = new Array();
// Checksum security fix start
var selHashKeysSusp = new Array();
var selFldKeysSusp = new Array();
// Checksum security fix end
function AddSelectedRowToListForSuspect(ID) {	
 IsTampered = getCookie('IsTampered'); 
           if(IsTampered=='Y') 
           {        showMessage(MSGJ50260); 
                   return; 
           } 
    var flag = false;
    for(var i = 0; i < SuspList.length; i++) {
        if(SuspList[i] == ID) {
            SuspList[i]     = -1;
            SuspId[i]  = -1;
            BOCrIdFS[i]  = -1;
            AsstoIdFS[i]  = -1;
            OwnerIdFS[i]  = -1;
            ProcessGroupIDFS[i]  = -1;
            AssignGrpFSusp[i]  = -1;
            OwnerGrpFSusp[i]  = -1;
            selHashKeysSusp[i] = -1;
            selFldKeysSusp[i] = -1;
            flag = true;
            break;
        }
    }
    if(!flag) {
        var SuspeId  	= event.srcElement.parentElement.parentElement.getAttribute('SuspectModBO.suspectID');        
        var BOCreIdFS  	= event.srcElement.parentElement.parentElement.getAttribute('SuspectModBO.MakerID');        
        var AssitoIdFS  = event.srcElement.parentElement.parentElement.getAttribute('SuspectModBO.AssignedTo');        
        var OwnersIdFS  = event.srcElement.parentElement.parentElement.getAttribute('SuspectModBO.owneduserid');        
        var ProcessGroupsIDFS  = event.srcElement.parentElement.parentElement.getAttribute('SuspectModBO.ProcessID');        
        var AssignGrpsFSusp  = event.srcElement.parentElement.parentElement.getAttribute('SuspectModBO.AssignedToGroup');        
        var OwnerGrpsFSusp  = event.srcElement.parentElement.parentElement.getAttribute('SuspectModBO.OwnerGroup');    
         // Checksum security fix start
				    var HashKey=event.srcElement.parentElement.parentElement.getAttribute('hashkey');
				    var FldKey=event.srcElement.parentElement.parentElement.getAttribute('fieldHashkey1');
		
	    // Checksum security fix end
        SuspList[SuspList.length]   = ID;
        SuspId[SuspId.length]       = SuspeId;
        BOCrIdFS[BOCrIdFS.length]   = BOCreIdFS;
        AsstoIdFS[AsstoIdFS.length] = AssitoIdFS;
        OwnerIdFS[OwnerIdFS.length] = OwnersIdFS;
        ProcessGroupIDFS[ProcessGroupIDFS.length] = ProcessGroupsIDFS;
        AssignGrpFSusp[AssignGrpFSusp.length] = AssignGrpsFSusp;
        OwnerGrpFSusp[OwnerGrpFSusp.length] = OwnerGrpsFSusp;
        // Checksum security fix start
			selHashKeysSusp[selHashKeysSusp.length]=HashKey;
			selFldKeysSusp[selFldKeysSusp.length]=FldKey;
	    // Checksum security fix end
    }
}
var NonCustList = new Array();
var NonCustId  = new Array();
var AsstoIdFNC  = new Array();
var OwnerIdFNC  = new Array();
var ProcessGroupIDFNC  = new Array();
var AssignGrpFNC = new Array();
var OwnerGrpFNC = new Array();
// Checksum security fix start
var selHashKeysFNC = new Array();
var selFldKeysFNC = new Array();
// Checksum security fix end
function AddSelectedRowToListForNonCustomer(ID) {	
IsTampered = getCookie('IsTampered');
	if(IsTampered=='Y')
	{	 showMessage(MSGJ50260);
		return;
	}
    var flag = false;
    for(var i = 0; i < NonCustList.length; i++) {
        if(NonCustList[i] == ID) {
            NonCustList[i]     = -1;
            NonCustId[i]  = -1;            
            AsstoIdFNC[i]  = -1;
            OwnerIdFNC[i]  = -1;
            ProcessGroupIDFNC[i]  = -1;
            AssignGrpFNC[i]  = -1;
            OwnerGrpFNC[i]  = -1;
            selHashKeysFNC[i] = -1;
            selFldKeysFNC[i] = -1;
            flag = true;
            break;
        }
    }
    if(!flag) {
        var NonCustmrID  	= event.srcElement.parentElement.parentElement.getAttribute('NonCustomerModBO.NonCustomerID');                
        var AssitoIdFNC  	= event.srcElement.parentElement.parentElement.getAttribute('NonCustomerModBO.AssignedTo');        
        var OwnersIdFNC  	= event.srcElement.parentElement.parentElement.getAttribute('NonCustomerModBO.ownedUserID');        
        var ProcessGroupsIDFNC  = event.srcElement.parentElement.parentElement.getAttribute('NonCustomerModBO.ProcessID');        
        var AssignGrpsFNC  = event.srcElement.parentElement.parentElement.getAttribute('NonCustomerModBO.AssignedToGroup');        
        var OwnerGrpsFNC  = event.srcElement.parentElement.parentElement.getAttribute('NonCustomerModBO.OwnerGroup');    
         // Checksum security fix start
				    var HashKey=event.srcElement.parentElement.parentElement.getAttribute('hashkey');
				    var FldKey=event.srcElement.parentElement.parentElement.getAttribute('fieldHashkey1');
		
	// Checksum security fix end
        NonCustList[NonCustList.length]   = ID;
        NonCustId[NonCustId.length]       = NonCustmrID;        
        AsstoIdFNC[AsstoIdFNC.length] = AssitoIdFNC;
        OwnerIdFNC[OwnerIdFNC.length] = OwnersIdFNC;
        ProcessGroupIDFNC[ProcessGroupIDFNC.length] = ProcessGroupsIDFNC;
        AssignGrpFNC[AssignGrpFNC.length] = AssignGrpsFNC;
        OwnerGrpFNC[OwnerGrpFNC.length] = OwnerGrpsFNC;
        // Checksum security fix start
				selHashKeysFNC[selHashKeysFNC.length]=HashKey;
				selFldKeysFNC[selFldKeysFNC.length]=FldKey;
	   // Checksum security fix end
    }
}
var bSelectFlag = false;
function selectAll()
{
    try {
    IsTampered = getCookie('IsTampered');
    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}
        var elements = document.getElementsByTagName("input");
        if(bSelectFlag == false) {
            checkit(elements);
            var link = document.getElementsByName("Select All")[0];
            bSelectFlag = true;
        }
        else {
            uncheckit(elements);
            bSelectFlag = false;
        }
    }
    catch(e) {
        DebugMessage(e.message);
    }
}
function checkit(elements)
{
/* recon changes begin call id 139087*/
 var EntityType=getCookie('EntityType'); 

 var boName="";
var tempIDs = new Array();
var tempGroup = new Array();
var length =0;
 if (EntityType=="Customer")
 	{		
    boName="AccountModBO";
 
    }else if(EntityType=="Contact"){
     boName="ContactModBO";
 
    
    }else if(EntityType=="NonCustomer"){
     boName="NonCustomerModBO";

    
    }else if(EntityType=="Suspect"){
     boName="SuspectModBO";

    
    }

    
    var count=0;
   
    for(var i=0; i < elements.length; i++) {
        if(elements[i].type == "checkbox") { 
 
        	if (elements[i].id != "select"){ 
        
        	    
		    elements[i].checked = true;
		    var AssignedGroupID = elements[i].parentElement.parentElement.getAttribute(boName+".AssignedToGroup");
		    tempIDs[count] = elements[i].id;      
		    tempGroup[count]  = AssignedGroupID;
		    count++;
		    
		   }
 	
        }
    }


    if (EntityType=="Customer")
     	{
     	AccList=tempIDs;
     	AssignGrpFCust=tempGroup;       
        }else if(EntityType=="Contact"){
         ContList=tempIDs;
         AssignGrpFCont=tempGroup; 
        
        }else if(EntityType=="NonCustomer"){
        NonCustList=tempIDs;
        AssignGrpFNC=tempGroup; 
        }else if(EntityType=="Suspect"){
         SuspList=tempIDs;
         AssignGrpFSusp=tempGroup;
        
    }
  


   /* recon changes ends call id 139087*/
}
function uncheckit(elements)
{
    for(var i = 0; i < elements.length; i++) {
        if(elements[i].type == "checkbox") {
            elements[i].checked = false;
            for(var iCount = 0; iCount < AccList.length; iCount++) {
                if(AccList[iCount] == elements[i].id) {
                    AccList[iCount] = -1;                    
                    break;
                }
            }
        }
    }
}
function LastEditedPage () {
	var EntityType=getCookie('EntityType');
    var LastEdit = getCookie('LastEdited');
	if(EntityType == 'Customer') {
   		 if(LastEdit == 'General') {
			EditAccount( 'General Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?isPopup=Yes&isGeneral=Yes&boType=Mod&operationType=Queue&accountId=');
		}
		else if(LastEdit == 'Demographic') {
			EditAccount( 'Demographic Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?isPopup=Yes&isDemo=Yes&boType=Mod&operationType=Queue&accountId=');
		}
		else if (LastEdit == 'Psychographic') {
			EditAccount( 'Psychographic Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?isPopup=Yes&isPsyco=Yes&boType=Mod&operationType=Queue&accountId=');
		}
		else if(LastEdit == 'OtherBank') {
			EditAccount( 'Other Bank Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?isPopup=Yes&isBank=Yes&boType=Mod&operationType=Queue&accountId=');
		}
		else if(LastEdit == 'TradeFinance') {
			EditAccount( 'Trade Finance Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?isPopup=Yes&isTF=Yes&boType=Mod&operationType=Queue&accountId=')
		}
		else if(LastEdit == 'BaselProfiling') {
					EditAccount( 'Basel Profiling','../servlet/com.infy.cis.ui.cif.AccountDetWizard?isPopup=Yes&isBasel=Yes&boType=Mod&operationType=Queue&accountId=')
		}
		else if(LastEdit == 'QDE') {
			EditAccount( 'Customer QDE','../servlet/com.infy.cis.ui.cif.CustomerQDEDetWizard?isPopup=Yes&isGeneral=Yes&boType=Mod&operationType=Queue&accountId=');
		}
		else {
			showMessage(MSGJ50275);
		}
	}
	else if(EntityType == 'Suspect') {
   		if(LastEdit == 'General') {
			EditAccount( 'General Details','../servlet/com.infy.cis.ui.cif.SuspectDetWizard?isPopup=Yes&isGeneral=Yes&boType=Mod&operationType=Queue&suspectId=');
		}
		else if(LastEdit == 'Demographic') {
			EditAccount( 'Demographic Details','../servlet/com.infy.cis.ui.cif.SuspectDetWizard?isPopup=Yes&isDemo=Yes&boType=Mod&operationType=Queue&suspectId=');
		}
		else if (LastEdit == 'Psychographic') {
			EditAccount( 'Psychographic Details','../servlet/com.infy.cis.ui.cif.SuspectDetWizard?isPopup=Yes&isPsyco=Yes&boType=Mod&operationType=Queue&suspectId=');
		}
		else if(LastEdit == 'OtherBank') {
			EditAccount( 'Other Bank Details','../servlet/com.infy.cis.ui.cif.SuspectDetWizard?isPopup=Yes&isBank=Yes&boType=Mod&operationType=Queue&suspectId=');
		}
		else if(LastEdit == 'QDE') {
			EditAccount( 'Prospect QDE','../servlet/com.infy.cis.ui.cif.QDEProspectDetWizard?isPopup=Yes&isGeneral=Yes&boType=Mod&operationType=Queue&suspectId=');
		}
		else {
			showMessage(MSGJ50275);
		}
	}
	else if(EntityType == 'Contact') {
   		if(LastEdit == 'General') {
			EditAccount( 'General Details','../servlet/com.infy.cis.ui.cif.ContactDetWizard?isPopup=Yes&isGeneral=Yes&boType=Mod&operationType=Queue&contactId=');
		}
		else if(LastEdit == 'Demographic') {
			EditAccount( 'Demographic Details','../servlet/com.infy.cis.ui.cif.ContactDetWizard?isPopup=Yes&isDemo=Yes&boType=Mod&operationType=Queue&contactId=');
		}
		else if (LastEdit == 'Psychographic') {
			EditAccount( 'Psychographic Details','../servlet/com.infy.cis.ui.cif.ContactDetWizard?isPopup=Yes&isPsyco=Yes&boType=Mod&operationType=Queue&contactId=');
		}
		else if(LastEdit == 'OtherBank') {
			EditAccount( 'Other Bank Details','../servlet/com.infy.cis.ui.cif.ContactDetWizard?isPopup=Yes&isBank=Yes&boType=Mod&operationType=Queue&contactId=');
		}
		else if(LastEdit == 'QDE') {
			EditAccount( 'Prospect QDE','../servlet/com.infy.cis.ui.cif.ContactQDEDetWizard?isPopup=Yes&isGeneral=Yes&boType=Mod&operationType=Queue&contactId=');
		}
		else {
			showMessage(MSGJ50275);
		}
	}
	else if(EntityType == 'NonCustomer') {
   		if(LastEdit == 'General') {
   			/* Tracker 194674 starts */
			//EditAccount( 'General Details','../servlet/com.infy.cis.ui.cif.ContactDetWizard?isPopup=Yes&isGeneral=Yes&boType=Mod&operationType=Queue&contactId=');
			EditAccount( 'General Details','../servlet/com.infy.cis.ui.cif.NonCustomerDetWizard?isPopup=Yes&isGeneral=Yes&boType=Mod&operationType=Queue&nonCustomerId=');
			/* Tracker 194674 ends */
		}
		else if(LastEdit == 'TradeFinance') {
			EditAccount( 'Trade Finance Details','../servlet/com.infy.cis.ui.cif.NonCustomerDetWizard?isPopup=Yes&isTF=Yes&boType=Mod&operationType=Queue&nonCustomerId=');
		}
		else {
			showMessage(MSGJ50275);
		}
	}
}
/******Tracker:132511   *******/
function getaccId(strEntity) {
    var x = parent.servletFrm.document.getElementsByName('RecordSet')
    for (i=0; i < x.length; i++) {
        for (j=2; j < x(i).rows.length; j++) {
                var row_bgcolor=x(i).rows(j).className;
                if ( row_bgcolor == 'rowHighLighted'){
                  if(EntityType == 'Customer' && strEntity == 'Customer'){                  
                    accIdtest = x(i).rows(j).getAttribute("AccountModBO.accountID");
	            return accIdtest;
                  }else if (EntityType == 'Contact' && strEntity == 'Contact'){
                    contIdtest = x(i).rows(j).getAttribute("ContactModBO.contactID");
	            return contIdtest;
                  }else if (EntityType == 'Suspect' && strEntity == 'Suspect'){
                    suspIdtest = x(i).rows(j).getAttribute("SuspectModBO.suspectID");
	            return suspIdtest;
                  }else if (EntityType == 'NonCustomer' && strEntity == 'NonCustomer'){
                    ncustIdtest = x(i).rows(j).getAttribute("NonCustomerModBO.NonCustomerID");
	            return ncustIdtest;
                  }
                }
        }
    }
}
/******Tracker:132511   *******/
function showEscalationLogs(wndName,Url)
{
     if(CheckIfRowSelected() == 'false') {
            showUserMessage ('MSG014','MSG_ENT');
            return;
    }
     /******Tracker:132511   *******/
     accountId = getaccId('Customer');
     contactId = getaccId('Contact');
     prospectId = getaccId('Suspect');
     noncustomerId = getaccId('NonCustomer');
      /******Tracker:132511   *******/
      //Checksum IUT fix start
   
           var hashkey=getBrowserCookie('HASHKEY');
           var fldhashkey=getBrowserCookie('FLDHASHKEY');
          
    //Checksum IUT fix end
     if((checkCookie(accountId)=="InValid") && (checkCookie(contactId)=="InValid") && (checkCookie(prospectId)=="InValid") && (checkCookie(noncustomerId)=="InValid") ){
                 return;
        }
     if (accountId != null) 
     {
	     sEntity="AccountMod";
	     Url=Url+'&sCifID='+accountId+'&sEntity='+sEntity+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey; /*Fix for ticket 272554*/
     }
     if (contactId != null) 
     {
	     sEntity="ContactMod";
	     Url=Url+'&sCifID='+contactId+'&sEntity='+sEntity+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey; /*Fix for ticket 272554*/
     }
     if (prospectId != null) 
     {
	     sEntity="SuspectMod";
	     Url=Url+'&sCifID='+prospectId+'&sEntity='+sEntity+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey; /*Fix for ticket 272554*/
     }
     if (noncustomerId != null)
     {
	     sEntity="NonCustomerMod";
	     Url=Url+'&sCifID='+noncustomerId+'&sEntity='+sEntity+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey; /*Fix for ticket 272554*/
     }
    /* Tracker: 108382: Changes for centering popup */
    //alert('Url'+Url);
    windowAlign();
    window.open(Url,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', resizable=no, resizable=yes,titlebar=no,toolbar=no,status=no,scrollbars=yes');
    /* Tracker: 108382: End of Changes */
}
function GetAsAssignee(name,url){
//Security Changes start
var hashkey=getBrowserCookie('HASHKEY');
var fldhashkey=getBrowserCookie('FLDHASHKEY');
//Security Changes end
       IsTampered = getCookie('IsTampered');
       //Start of changes:Ticket Id 290214  
       var savedSubmitted="SubmittedAppr";
    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	}     
    var flag = 'Y';	
    var len=0; 
    local_prefix = "";  
   //change for callid 366731 begins
   // var EntityType=getCookie('EntityType');  
   var EntityType = getCookie('SelectEntityType');
       //change for callid 366731 ends    
	var RepID = document.frm2.RepID.value;       	
	if (EntityType=='Customer')
	{		
	    for(var i=0; i < AccList.length; i++)
	    {
		 if(AccList[i]!=-1)
		  { 
		    if(AssignGrpFCust[i]!=grpid){
		    flag='P';
		    }
		  }
	     }
	     if(flag=='Y'){	
		var elements = document.getElementsByTagName("input");
		var accIds="";
		for(var i = 0; i < AccList.length; i++) 
		{
			if(AccList[i] != -1) 
			{
				accIds += AccList[i] + ",";
				var last=accIds.lastIndexOf(',');
			}
		 }
	    	accIds=accIds.substr(0,last);
		if (accIds=="")
		{
			showMessage(MSGJ0102);
			return "false";
		}
		var WItemFlag;
    		var getFirst = "";
   		entityURL = getCookie('AccountURL');    
    		entityURLs = accIds;
    		flag='A';  		
    		setCookie('SavedSubmittedType', savedSubmitted, expirationdate);    		
//Security Changes start
    		parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.cif.getModAccount?EntityType=Customer&entityURL='+ entityURLs+ '&getFirst='+ getFirst+ '&param2='+ entityURLs +'&flag='+flag+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;      
//Security Changes end
    	     }
    	     else
    		verifyCust(flag);
    	}
       	else if (EntityType=='Contact')
        {    	
	    for(var i=0; i < ContList.length; i++)
	    {
		 if(ContList[i]!=-1)
		  {
		    if(AssignGrpFCont[i]!=grpid){
		    	flag='P';
		    }
		  }
	     }
	     if(flag=='Y'){	
        	var elements = document.getElementsByTagName("input");
    		var contIds="";
		for(var i = 0; i < ContList.length; i++) 
		{
			if(ContList[i] != -1) 
			{
			contIds += ContList[i] + ",";
			var last=contIds.lastIndexOf(',');
			}
		 }
		contIds=contIds.substr(0,last);
		if (contIds=="")
		{
			showMessage(MSGJ0103);
			return "false";
		}
    		var WItemFlag;
		var getFirst = "";
		contactURL = getCookie('contactURL');    
		entityURLs = contIds;
    		flag='A';
    		setCookie('SavedSubmittedType', savedSubmitted, expirationdate);
//Security Changes start
    		parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.cif.getModAccount?EntityType=Contact&entityURL='+ entityURLs+ '&getFirst='+ getFirst+ '&param2='+ entityURLs +'&flag='+flag+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;    
//Security Changes end
             }
   	     else
    		verifyCont(flag);
    }
    else if (EntityType=='Prospect'||EntityType=='Suspect')
    {    
	    for(var i=0; i < SuspList.length; i++)
	    {
		 if(SuspList[i]!=-1)
		  {
		    if(AssignGrpFSusp[i]!=grpid){
		    	flag='P';
		    }
		  }
	     }
	     if(flag=='Y'){	
            	var elements = document.getElementsByTagName("input");
        	var suspIds="";
    		for(var i = 0; i < SuspList.length; i++) 
    		{
    			if(SuspList[i] != -1) 
    			{
    			suspIds += SuspList[i] + ",";
    			var last=suspIds.lastIndexOf(',');
    			}
    		 }
    		suspIds=suspIds.substr(0,last);
    		if (suspIds=="")
    		{
    			showMessage(MSGJ0104);
    			return "false";
    		}
    		var getFirst = "";
    		entityURLs = suspIds;
    		flag='A';
    		setCookie('SavedSubmittedType', savedSubmitted, expirationdate);
//Security Changes start
        	parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.cif.getModAccount?EntityType=Suspect&entityURL='+ entityURLs+ '&getFirst='+ getFirst+ '&param2='+ entityURLs +'&flag='+flag+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;    
//Security Changes end
             }
    	     else
    		verifySusp(flag);
    }    
    else if (EntityType=='NonCustomer')
    { 
	    for(var i=0; i < NonCustList.length; i++)
	    {
		 if(NonCustList[i]!=-1)
		  {
		    if(AssignGrpFNC[i]!=grpid){
		    	flag='P';
		    }
		  }
	     }
	     if(flag=='Y'){	
		var elements = document.getElementsByTagName("input");
		var noncustIds="";
		for(var i = 0; i < NonCustList.length; i++) 
		{
			if(NonCustList[i] != -1) 
			{
			noncustIds += NonCustList[i] + ",";
			var last=noncustIds.lastIndexOf(',');
			}
		 }
		noncustIds=noncustIds.substr(0,last);
		if (noncustIds=="")
		{
			showMessage(MSGJ0105);
			return "false";
		}
		var getFirst = "";
		entityURLs = noncustIds;
    		flag='A';
    		setCookie('SavedSubmittedType', savedSubmitted, expirationdate);
//Security Changes start
            	parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.cif.getModAccount?EntityType=NonCustomer&entityURL='+ entityURLs+ '&getFirst='+ getFirst+ '&param2='+ entityURLs +'&flag='+flag+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;
//Security Changes end
             //End of changes:Ticket Id 290214  
             }
    	     else
    		verifyNonCust(flag);
    }
}
function GetAsOwner(name,url){
//Security Changes start
var hashkey=getBrowserCookie('HASHKEY');
var fldhashkey=getBrowserCookie('FLDHASHKEY');
//Security Changes end
       IsTampered = getCookie('IsTampered');
    	if(IsTampered=='Y')
    	{	 showMessage(MSGJ50260);
    		return;
	} 
    var flag = 'Y';	
    var len=0;    
    var temp = local_prefix;
    local_prefix = "";    
    local_prefix = temp;
    var EntityType=getCookie('EntityType');    
	var RepID = document.frm2.RepID.value;       	
	if (EntityType=='Customer')
	{		
	    for(var i=0; i < AccList.length; i++)
	    {
		 if(AccList[i]!=-1)
		  {
		    if(OwnerGrpFCust[i]!=grpid){
		    flag='Q';
		    }
		  }
	     }
	     if(flag=='Y'){	
		var elements = document.getElementsByTagName("input");
		var accIds="";
		for(var i = 0; i < AccList.length; i++) 
		{
			if(AccList[i] != -1) 
			{
				accIds += AccList[i] + ",";
				var last=accIds.lastIndexOf(',');
			}
		 }
	    	accIds=accIds.substr(0,last);
		if (accIds=="")
		{
			showMessage(MSGJ0102);
			return "false";
		}
		var WItemFlag;
    		var getFirst = "";
   		entityURL = getCookie('AccountURL');    
    		entityURLs = accIds;
    		flag='O';
//Security Changes start
    		parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.cif.getModAccount?EntityType=Customer&entityURL='+ entityURLs+ '&getFirst='+ getFirst+ '&param2='+ entityURLs +'&flag='+flag+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;    
//Security Changes end
    	     }
    	     else
    		verifyCust(flag);
    	}
       	else if (EntityType=='Contact')
        {    	
	    for(var i=0; i < ContList.length; i++)
	    {
		 if(ContList[i]!=-1)
		  {
		    if(OwnerGrpFCont[i]!=grpid){
		    	flag='Q';
		    }
		  }
	     }
	     if(flag=='Y'){	
        	var elements = document.getElementsByTagName("input");
    		var contIds="";
		for(var i = 0; i < ContList.length; i++) 
		{
			if(ContList[i] != -1) 
			{
			contIds += ContList[i] + ",";
			var last=contIds.lastIndexOf(',');
			}
		 }
		contIds=contIds.substr(0,last);
		if (contIds=="")
		{
			showMessage(MSGJ0103);
			return "false";
		}
    		var WItemFlag;
		var getFirst = "";
		contactURL = getCookie('contactURL');    
		entityURLs = contIds;
    		flag='O';
//Security Changes start
    		parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.cif.getModAccount?EntityType=Contact&entityURL='+ entityURLs+ '&getFirst='+ getFirst+ '&param2='+ entityURLs +'&flag='+flag+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;    
//Security Changes end
             }
   	     else
    		verifyCont(flag);
    }
    else if (EntityType=='Suspect')
            {    
	    for(var i=0; i < SuspList.length; i++)
	    {
		 if(SuspList[i]!=-1)
		  {
		    if(OwnerGrpFSusp[i]!=grpid){
		    	flag='Q';
		    }
		  }
	     }
	     if(flag=='Y'){	
            	var elements = document.getElementsByTagName("input");
        	var suspIds="";
    		for(var i = 0; i < SuspList.length; i++) 
    		{
    			if(SuspList[i] != -1) 
    			{
    			suspIds += SuspList[i] + ",";
    			var last=suspIds.lastIndexOf(',');
    			}
    		 }
    		suspIds=suspIds.substr(0,last);
    		if (suspIds=="")
    		{
    			showMessage(MSGJ0104);
    			return "false";
    		}
    		var getFirst = "";
    		entityURLs = suspIds;
    		flag='O';
//Security Changes start
        	parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.cif.getModAccount?EntityType=Suspect&entityURL='+ entityURLs+ '&getFirst='+ getFirst+ '&param2='+ entityURLs +'&flag='+flag+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;    
//Security Changes end
             }
    	     else
    		verifySusp(flag);
    }    
    else if (EntityType=='NonCustomer')
                { 
	    for(var i=0; i < NonCustList.length; i++)
	    {
		 if(NonCustList[i]!=-1)
		  {
		    if(OwnerGrpFNC[i]!=grpid){
		    	flag='Q';
		    }
		  }
	     }
	     if(flag=='Y'){	
		var elements = document.getElementsByTagName("input");
		var noncustIds="";
		for(var i = 0; i < NonCustList.length; i++) 
		{
			if(NonCustList[i] != -1) 
			{
			noncustIds += NonCustList[i] + ",";
			var last=noncustIds.lastIndexOf(',');
			}
		 }
		noncustIds=noncustIds.substr(0,last);
		if (noncustIds=="")
		{
			showMessage(MSGJ0105);
			return "false";
		}
		var getFirst = "";
		entityURLs = noncustIds;
    		flag='O';
//Security Changes start
            	parent.hiddenFrame.location.href = '../servlet/com.infy.cis.ui.cif.getModAccount?EntityType=NonCustomer&entityURL='+ entityURLs+ '&getFirst='+ getFirst+ '&param2='+ entityURLs +'&flag='+flag+'&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey;    
//Security Changes end
             }
    	     else
    		verifyNonCust(flag);
    }
}
function verifyCust(flag){
	var len=0;
	var a=0;
	var o=0;
	for(var i = 0; i < AccList.length; i++)
	{
	 if(AccList[i]!=-1)
	 len++;
	}
	if(flag=='P')
	{
	 for(var i = 0; i < AccList.length; i++)
	   {
	     if(AccList[i]!=-1)
	      {
		 if(OwnerGrpFCust[i]==grpid && AssignGrpFCust[i]!=grpid)
			 o++;
	      }
	    }
	 if(o==len)
	     showMessage(MSGJ50404);
	 else
	     showMessage(MSGJ50405);
	}
	if(flag=='Q')
	{
	 for(var i = 0; i < AccList.length; i++)
	   {
	     if(AccList[i]!=-1)
	      {
		 if(AssignGrpFCust[i]==grpid && OwnerGrpFCust[i]!=grpid)
		 	a++;
	       }
	    }
	 if(a==len)
	     showMessage(MSGJ50406);
	 else
	     showMessage(MSGJ50405);
	}
}
function verifyCont(flag){
	var len=0;
	var a=0;
	var o=0;
	for(var i = 0; i < ContList.length; i++)
	{
	 if(ContList[i]!=-1)
	 len++;
	}
	if(flag=='P')
	{
	 for(var i = 0; i < ContList.length; i++)
	   {
	     if(ContList[i]!=-1)
	      {
		 if(OwnerGrpFCont[i]==grpid && AssignGrpFCont[i]!=grpid)
			 o++;
	      }
	    }
	 if(o==len)
	     showMessage(MSGJ50404);
	 else
	     showMessage(MSGJ50405);
	}
	if(flag=='Q')
	{
	 for(var i = 0; i < ContList.length; i++)
	   {
	     if(ContList[i]!=-1)
	      {
		 if(AssignGrpFCont[i]==grpid && OwnerGrpFCont[i]!=grpid)
		 	a++;
	       }
	    }
	 if(a==len)
	     showMessage(MSGJ50406);
	 else
	     showMessage(MSGJ50405);
	}
}
function verifySusp(flag){
	var len=0;
	var a=0;
	var o=0;
	for(var i = 0; i < SuspList.length; i++)
	{
	 if(SuspList[i]!=-1)
	 len++;
	}
	if(flag=='P')
	{
	 for(var i = 0; i < SuspList.length; i++)
	   {
	     if(SuspList[i]!=-1)
	      {
		 if(OwnerGrpFSusp[i]==grpid && AssignGrpFSusp[i]!=grpid)
			 o++;
	      }
	    }
	 if(o==len)
	     showMessage(MSGJ50404);
	 else
	     showMessage(MSGJ50405);
	}
	if(flag=='Q')
	{
	 for(var i = 0; i < SuspList.length; i++)
	   {
	     if(SuspList[i]!=-1)
	      {
		 if(AssignGrpFSusp[i]==grpid && OwnerGrpFSusp[i]!=grpid)
		 	a++;
	       }
	    }
	 if(a==len)
	     showMessage(MSGJ50406);
	 else
	     showMessage(MSGJ50405);
	}
}
function verifyNonCust(flag){
	var len=0;
	var a=0;
	var o=0;
	for(var i = 0; i < NonCustList.length; i++)
	{
	 if(NonCustList[i]!=-1)
	 len++;
	}
	if(flag=='P')
	{
	 for(var i = 0; i < NonCustList.length; i++)
	   {
	     if(NonCustList[i]!=-1)
	      {
		 if(OwnerGrpFNC[i]==grpid && AssignGrpFNC[i]!=grpid)
			 o++;
	      }
	    }
	 if(o==len)
	     showMessage(MSGJ50404);
	 else
	     showMessage(MSGJ50405);
	}
	if(flag=='Q')
	{
	 for(var i = 0; i < NonCustList.length; i++)
	   {
	     if(NonCustList[i]!=-1)
	      {
		 if(AssignGrpFNC[i]==grpid && OwnerGrpFNC[i]!=grpid)
		 	a++;
	       }
	    }
	 if(a==len)
	     showMessage(MSGJ50406);
	 else
	     showMessage(MSGJ50405);
	}
}
// Checksum security fix start
function getFldKey(EntityType)
{
	var strFldKey="";
                if (EntityType=='Customer')
                {
			for(var iCount=0;iCount<AccList.length;iCount++)
			{
				if(selFldKeysCust[iCount] != -1) {	
				strFldKey += selFldKeysCust[iCount] + '-';
				}
			}
		}
		  if (EntityType=='Contact')
		                {
					for(var iCount=0;iCount<ContList.length;iCount++)
					{
						if(selFldKeysCont[iCount] != -1) {
						strFldKey += selFldKeysCont[iCount] + '-';
						}
					}
				}
		  if (EntityType=='Suspect')
		                {
					for(var iCount=0;iCount<SuspList.length;iCount++)
					{
					        if(selFldKeysSusp[iCount] != -1) {
					        strFldKey += selFldKeysSusp[iCount] + '-';
					        }
					}
		}
		  if (EntityType=='NonCustomer')
		                {
					for(var iCount=0;iCount<NonCustList.length;iCount++)
					{
						if(selFldKeysFNC[iCount] != -1) {
						strFldKey += selFldKeysFNC[iCount] + '-';
						}
					}
		}
     
	return strFldKey;
}
function getHashKey(EntityType)
{
	var strHashKey="";
		  if (EntityType=='Customer')
		  {
					for(var iCount=0;iCount<AccList.length;iCount++)
					{
					      if(selHashKeysCust[iCount] != -1) {
					       strHashKey += selHashKeysCust[iCount] + '-';
					      }
					}	
		}
		  if (EntityType=='Contact')
		  {
					for(var iCount=0;iCount<ContList.length;iCount++)
					{
						if(selHashKeysCont[iCount] != -1) {
					          strHashKey += selHashKeysCont[iCount] + '-';
						 }
					}
		}
		  if (EntityType=='Suspect')
		 { 
					for(var iCount=0;iCount<SuspList.length;iCount++)
					{ 
                    	                         if(selHashKeysSusp[iCount] != -1) {
					          strHashKey += selHashKeysSusp[iCount] + '-';
					         }
                                         }
		  }
		  if (EntityType=='NonCustomer')
		  {
					for(var iCount=0;iCount<NonCustList.length;iCount++)
					{ 
                     				if(selHashKeysFNC[iCount] != -1) {
                              			strHashKey += selHashKeysFNC[iCount] + '-';
                                               }
                                        }
		  }
       
	return strHashKey;
}

// Checksum security fix end
