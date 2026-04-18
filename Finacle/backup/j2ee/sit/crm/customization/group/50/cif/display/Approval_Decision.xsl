<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
        <xsl:param name="locale"/>
<!--Tracker Id 124359 Changes Starts --> 
<xsl:param name="altLocaleActv"/>
<!--Tracker Id 124359 Changes Ends --> 
<xsl:param name="file1"/>
<xsl:variable name="file1XML" select="substring-before(substring-after($file1,'resource/'),'.xml')"/>
		<xsl:variable name="configFields" select="SRM/SRMBO/ResourceFile[@filename=$file1XML]/*"/>
<xsl:variable name="customFields" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z"/>
<!-- Changes for Deceased CIF Starts-->
<xsl:variable name="strStatus" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strStatus']" />
<!-- Changes for Deceased CIF Ends-->
<xsl:variable name="boCrea" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boCrea']"></xsl:variable> 
<xsl:variable name="Assigned" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Assigned']"></xsl:variable> 
<xsl:variable name="ArrDecision2" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='Decision1']"/>
<xsl:variable name="flagGcif" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='Flag']"/>
<xsl:variable name="BOName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BOName']"></xsl:variable> 
<!--Changes for tracker ID 455533 start-->
<xsl:variable name="lastOperation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='lastOperation']"></xsl:variable> 
<!--Changes for  tracker ID 455533 end-->
<xsl:variable name="BOIDStr" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BOID']"></xsl:variable> <!-- Approval Screen Perf fix -->
<xsl:variable name="cifIDStr" select="$customFields[@n='cifID']"></xsl:variable> <!-- Approval Screen Perf fix -->
<xsl:variable name="userArea" select="/SRM/SRMData[@SRMDataSpace='UserData']"/>
<xsl:variable name="objectId" select="$customFields[@n='objectId']"></xsl:variable>
<!-- Changes for ticket 312337 starts -->
<!-- Changes for ticket 339680 starts -->

<!--<xsl:variable name="corpName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='corpName']"></xsl:variable> 
<xsl:variable name="shortName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='shortName']"></xsl:variable> 
<xsl:variable name="corpName_alt1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='corpName_alt1']"></xsl:variable> 
<xsl:variable name="shortName_alt1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='shortName_alt1']"></xsl:variable>-->
<!-- Changes for ticket 339680 ends -->
<!-- Changes for ticket 312337 ends -->

<!-- Changes for ticket 441980 Start -->
<xsl:variable name="CustomerID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='customerID']"></xsl:variable> 
<!-- <xsl:variable name="CustomerID" select="$userArea//Z[@n='customerID']"/> -->
<!-- Changes for ticket 441980 ends -->    
<!-- CIF Changes for Caching Views : Start -->
    <xsl:param name="viewname"/>
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.CIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
    <xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
    <xsl:variable name="PresData" select="SRM/SRMPresentation"/>
	<xsl:variable name="salutation" select="$customFields[@n='salutation']"/>
	<xsl:variable name="lastName" select="$customFields[@n='lastName']"/>
	<xsl:variable name="firstName" select="$customFields[@n='firstName']"/>
	<xsl:variable name="lastName_alt1" select="$customFields[@n='lastName_alt1']"/>
	<xsl:variable name="firstName_alt1" select="$customFields[@n='firstName_alt1']"/>
	<xsl:variable name="cifID" select="$customFields[@n='cifID']"/>
	<xsl:variable name="DOB" select="$customFields[@n='DOB']"/>
	<xsl:variable name="corpName" select="$customFields[@n='corpName']"/>
	<xsl:variable name="shortName" select="$customFields[@n='shortName']"/>
	<xsl:variable name="dateOfInc" select="$customFields[@n='dateOfInc']"/>
	<xsl:variable name="corpName_alt1" select="$customFields[@n='corpName_alt1']"/>
	<xsl:variable name="shortName_alt1" select="$customFields[@n='shortName_alt1']"/>
<!-- CIF Changes for Caching Views : End -->
    
<xsl:template match="/">
<html>
<head>
<!-- tracker id 336352 changes starts -->
<!-- <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title> -->
<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"></xsl:value-of></title>		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
<!-- tracker id 336352 changes ends -->
<!--Tracker id 161273 Changes Begin-->
<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
<!--<script type="text/javascript" src="../Customization/cif/js/RendSRMEntityRightClick.js" ></script>-->

<!--Tracker id 161273 Changes End-->
<script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js"></script>
<!--Tracker Id 124359 Changes Starts --> 
<script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
<script type="text/javascript" language="javascript" src="../Customization/cif/js/RendSRMEntityRightClick.js"></script>
<!--Tracker Id 124359 Changes Ends -->
<!-- tracker id 336352 changes starts -->
<!-- <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/> -->
<!-- tracker id 336352 changes ends -->
<script language='javascript'>
<!-- Changes for Deceased CIF Starts-->
var strStatus = '<xsl:value-of select="$strStatus"></xsl:value-of>';
<!-- Changes for Deceased CIF Ends-->
var locale = '<xsl:value-of select="$locale"/>';
var boCrea = '<xsl:value-of select="$boCrea"/>';
var Assigned = '<xsl:value-of select="$Assigned"/>';
var BOName = '<xsl:value-of select="$BOName"/>';
var lastOperation = '<xsl:value-of select="$lastOperation"/>'; //Changes for  tracker ID 455533
var BOIDjsVar = '<xsl:value-of select="$BOIDStr"/>'; <!-- Approval Screen Perf Fix -->
var CustomerID = '<xsl:value-of select="$CustomerID"/>';
 var Flag ='<xsl:value-of select="$flagGcif"/>';
<!--Tracker Id 124359 Changes Starts --> 
var altLocaleActv = '<xsl:value-of select="$altLocaleActv"/>';
<!--Tracker Id 124359 Changes Ends -->
/* Changes for ticket 312337 starts */
/* Changes for ticket 339680 starts */

<!--var corpName = '<xsl:value-of select="$corpName"/>';
var shortName = '<xsl:value-of select="$shortName"/>';
var corpName_alt1 = '<xsl:value-of select="$corpName_alt1"/>';
var shortName_alt1 = '<xsl:value-of select="$shortName_alt1"/>';-->
/* Changes for ticket 339680 ends */
/* Changes for ticket 312337 ends */

function functionBodyOnload(){
	bodyOnLoad();
	showDeceasedInfo();
	removeVal();
}

var no_errors = true;
 function bodyOnLoad()
        {          
        setFocusOnComp("Decision");
		parent.parent.parent.parent.setButtonsVisible(true);    
		parent.MiscFormContainer.rows="100%,*%,0%,0%";
		/* Changes for ticket 312337 starts */
	    /* Changes for ticket 339680 starts */
		//changes for callid 760963 starts
		 var opts=document.getElementsByName("Decision")[0];
                        for(i=0;i&lt; opts.length;i++){
						 if(lastOperation != "C"){
	  	if(lastOperation != "E"){
						
                                    if(opts.options[i].value=='Reject'){
									
                                                opts.options.remove(i);
					i--;
                                   }
					   }
								   
			   }
                         }  
						 
						 
	  //Changes for tracker ID 455533 start
	/*  if(lastOperation != "C"){
	  	if(lastOperation != "E"){
			document.getElementsByName("Decision")[0].options.length=4; 
		}
	  }
	  else if(lastOperation != "E"){
	  	if(lastOperation != "C"){
	  		document.getElementsByName("Decision")[0].options.length=4;
	  	}
	  }*/
}//changes for callid 760963 ends
var newwin ;
		
	function showAuditTrail() {  <!-- Approval Screen Perf Fix -->
		var cifIDStr = '<xsl:value-of select="$cifIDStr"/>'; <!-- Approval Screen Perf Fix -->
		var auditUrl = '../servlet/com.infy.cis.ui.common.AuditTrailForm?BOName='+BOName+'&amp;BOID='+BOIDjsVar+'&amp;isAppScr=Y'+'&amp;Header='+MSG_AU0081+'~'+escape(cifIDStr); ;
		windowAlign();
		newwin = window.open(auditUrl,'','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,status=no,scrollbars=yes');
	}
	var ViewdCust="N";
	function fnViewCustDetails()
	{
		
			ViewdCust="Y";				
			showAuditTrail();
		<!--var Viewurl='../servlet/com.infy.cis.ui.cif.AccountDetWizard?accountId='+objectId+'&amp;IsReadOnly=Y';	
		windowAlign();
	    viewwin=window.open(Viewurl,'','directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+', location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');-->
		 
		
	}
        
function save() {


	if(!( typeof newwin == 'undefined') ) {
		newwin.close();
	}
	var selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
	var retStat = parent.parent.parent.parent.ValidateFormContents(document.Frm2,true);
	
	//Fix for ticket ID : 310835
	//if (Flag == 'true'){
	//       var decision=document.getElementsByName("ArrDecision")[0].value;
	//       }
	//	else{
	        	var decision=document.getElementsByName("Decision")[0].value;
	 //        }
	      if(decision=="Approve") {
		
		if(ViewdCust=="N")
		{
		alert("Kindly view Customer Edited details before Approving");
		return "interactive";
		}
		
	}
	if(retStat=="false") {
		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		return "interactive";
	}
	
	if(decision=='Duplicate'){
		
		//var CustID=parent.formListFrame.window.getCookie('CustomerID');	
		  
		  <!-- Changes for ticket 441980 Start -->
		  //var CustID=parent.frmSearch.window.getCookie('CustomerID');
		 var CustID=CustomerID;
		 <!-- Changes for ticket 441980 end -->
		 
/**** Code Changes for ticket 329128 starts here****/
		  var expirationdate = new Date ();

		  expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));

		  parent.frmSearch.window.setCookie('CustomerID','',expirationdate);

		
		if(CustID==null || CustID=='null'|| CustID==""){		
			/*Tracker id 161273 Changes Begin*/ 
            showMessage(MSGJ0007);
            /*Tracker id 161273 Changes End*/ 
			return "false";
		}

	/**** Code Changes for ticket 329128 ends here****/
		document.Frm2.action='../servlet/com.infy.cis.ui.cif.DecisionWriter?CustomerID='+CustID;
	}
	else{		
	document.Frm2.action='../servlet/com.infy.cis.ui.cif.DecisionWriter?Flag='+Flag;
	
	}
		
	document.Frm2.target= "formSaveFrame";
	document.Frm2.submit();
	/* TRACKER ID:146544 CHANGES BEGIN */
	return "true";
	/* TRACKER ID:146544 CHANGES BEGIN */
	
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


function clear(){
//parent.parent.parent.parent.parent.parent.window.opener.parent.parent.parent.parent.frames[0].frames[0].frames[1].location.reload(true);
parent.parent.parent.parent.parent.parent.window.opener.parent.parent.parent.parent.frames[0].frames[0].frames[1].navigate (parent.parent.parent.parent.parent.parent.window.opener.parent.parent.parent.parent.frames[0].frames[0].frames[1].location.href);
//parent.parent.parent.parent.parent.parent.window.opener.parent.parent.parent.parent.frames[0].frames[1].navigate (parent.parent.parent.parent.parent.parent.window.opener.parent.parent.parent.parent.frames[0].frames[1].location.href);

/****Begin Of Changes tracker: 168078********/
parent.parent.parent.parent.parent.parent.window.opener.parent.parent.parent.parent.dynamicTabFrm.location.href='../../common/html/blank.html';
/****End Of Changes tracker: 276561********/
top.window.close();
}
function closebtn(){
top.window.close();
}
function shouldRefresh(){
return false;
}
function setRemarks(){
var visited  =parent.formListFrame.window.getCookie('visited');


	//Fix for ticket ID : 310835
       //if (Flag == 'true'){
       //var decision=document.getElementsByName("ArrDecision")[0].value;
       //}
	//else{
	var decision=document.getElementsByName("Decision")[0].value;
	//}
	
	
	if(decision=="Reject") {
		setRemarksMandatory(true);
		
	}else if(decision=="Duplicate") {
	
	//Changes for call id: 439782 start
	setRemarksMandatory(false);
	//Changes for call id: 439782 start
	/*
	document.frmSearch.target="formListFrame";
	document.frmSearch.action="com.infy.cis.ui.cif.ListofDeDupSearch";
	document.frmSearch.submit();
	*/
		/**** Code Changes for ticket 329128 starts here****/
	if (BOName == 'CorporateModBO' || BOName == 'CorporateBO') {
		document.formDispFrame.target="frmSearch";
		document.formDispFrame.action="com.infy.cis.ui.corpcif.ListOfCorpDeDupSearch";
		document.formDispFrame.submit();
	}
	else {
	document.formDispFrame.target="frmSearch";
	document.formDispFrame.action="com.infy.cis.ui.cif.ListofDeDupSearch";
	document.formDispFrame.submit();
	}
	/**** Code Changes for ticket 329128 ends here****/
	
	}
	/* Changes for ticket 365445 : AXIS Changes for Approval Screen */
	//else if(BOName=="CorporateModBO" || BOName == "GcifRetailModBO" ||  BOName == "GcifCorporateModBO" ){
		else if(BOName == "GcifRetailModBO" ||  BOName == "GcifCorporateModBO" ){
	//	setRemarksMandatory(true);
	} else {
		setRemarksMandatory(false);
	}
}
/* Changes done by Ekta For Cif Deceased starts */       
function showDeceasedInfo(){
	if(strStatus == "DCSED"){
	
	  parent.parent.parent.parent.removeTips(parent.parent.parent.parent.frames[0].getSelectedTabId());
	  parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames[0].getSelectedTabId(),MSGJ51882);
	  parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames[0].getSelectedTabId());
	  parent.parent.parent.parent.showTipsButton();
      }
}
/* Changes done by Ekta For Cif Deceased ends */
//Fix for ticket ID : 310835
function removeVal(){
try{
            if(Flag){
                        var opts=document.getElementsByName("Decision")[0];
                        for(i=0;i&lt; opts.length;i++){
                                    if(opts.options[i].value=='Duplicate'){
                                                opts.options.remove(i);
                                    }
                         }  
            }
            }catch(e){
            DebugMessage(e.message);
            }
}
	
function setRemarksMandatory(isMandatory){
    if(isMandatory){
	document.getElementsByName("mandStarRemarks")[0].style.visibility="";
	document.getElementsByName("Remarks")[0].setAttribute('IsMandatory' , "true");
    }else{
	document.getElementsByName("mandStarRemarks")[0].style.visibility="hidden";
	document.getElementsByName("Remarks")[0].setAttribute('IsMandatory' , "false");
    }
}
</script>
</head>
<body class="popup">
 
<!-- Changes for ticket 312337 starts --> 
<!-- Changes for ticket 339680 starts -->
<!-- Changes for Deceased CIF starts -->
<xsl:attribute name="onload">bodyOnLoad();showDeceasedInfo();removeVal()</xsl:attribute>
<!-- Changes for Deceased CIF ends -->

<!-- Changes for ticket 339680 ends -->
<xsl:apply-templates select="SRM"/>
<!-- Changes for ticket 312337 ends -->
<form name="frmSearch" method="post"> 

</form>	
</body>
</html>
</xsl:template>


<!-- Coomented for ticket ID : 310835
GCIF Process changes: fix for ticket 231486
<xsl:template name="DecisionGCIF">
<xsl:call-template name="mdrpdown">
<xsl:with-param name="res_name" select="$configFields[@name='DECISION']"/>
<xsl:with-param name="selectname">Decision</xsl:with-param>
<xsl:with-param name="selectdisp">Decision</xsl:with-param>
<xsl:with-param name="onchangefn">setRemarks();</xsl:with-param> 
CIF Changes for Caching Views : Start
<xsl:with-param name="presdata" select="$PresData"/>               
CIF Changes for Caching Views : End 
</xsl:call-template>
</xsl:template> -->

<!-- FIX ends-->
<xsl:template name="Decision">
<xsl:call-template name="mdrpdown">
<xsl:with-param name="res_name" select="$configFields[@name='DECISION']"/>
<xsl:with-param name="selectname">Decision</xsl:with-param>
<xsl:with-param name="selectdisp">Decision</xsl:with-param>
<xsl:with-param name="onchangefn">setRemarks();</xsl:with-param>
<xsl:with-param name="search_type">value</xsl:with-param>
<!-- CIF Changes for Caching Views : Start -->
	<xsl:with-param name="presdata" select="$PresData"/>                
<!-- CIF Changes for Caching Views : End -->
</xsl:call-template>
</xsl:template>

<!--FR4 changes for Equity starts-->
<xsl:template name="ViewCustDet">
	<xsl:call-template name="hyperlink">
		<xsl:with-param name="fncname">fnViewCustDetails()</xsl:with-param>
		<xsl:with-param name="res_name">View Customer Edited Details</xsl:with-param>		
		</xsl:call-template>


</xsl:template>
<!--FR4 changes for Equity ends-->


<!--Approval Changes:start-->
<xsl:template name="AccountBO.Salutation">
    <td class="d1">
       <xsl:value-of select="$configFields[@name='Salutation']/@configLabel"/>
    </td><td class="d3">
	<input type="text" name="salutation" value="{$salutation}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
    </td>
</xsl:template>

<xsl:template name="AccountBO.Cust_Last_Name">
    <td class="d1">
	<xsl:value-of select="$configFields[@name='Last Name']/@configLabel"/>
    </td><td class="d3">
	<input type="text" name="lastName" value="{$lastName}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
    </td>
</xsl:template>
<xsl:template name="AccountBO.Cust_First_Name">
   <td class="d1">
	<xsl:value-of select="$configFields[@name='First Name']/@configLabel"/>
   </td><td class="d3">
	<input type="text" name="firstName" value="{$firstName}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
    </td>
</xsl:template>
<!--Tracker Id 124359 Changes Starts --> 
<xsl:template name="AccountBO.Cust_Last_Name_alt1">
    <td class="d1">
	<xsl:value-of select="$configFields[@name='Last Name']/@configLabel"/>
    </td><td class="d3">
	<input type="text" name="lastName_alt1" value="{$lastName_alt1}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
    </td>
</xsl:template>
<xsl:template name="AccountBO.Cust_First_Name_alt1">
   <td class="d1">
	<xsl:value-of select="$configFields[@name='First Name']/@configLabel"/>
   </td><td class="d3">
	<input type="text" name="firstName_alt1" value="{$firstName_alt1}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
    </td>
</xsl:template>

<!--Tracker Id 124359 Changes Ends -->
<xsl:template name="AccountBO.AccountKey">
   <td class="d1">
	<xsl:value-of select="$configFields[@name='CIF ID']/@configLabel"/>
   </td><td class="d3">
	<input type="text" name="cifID" value="{$cifID}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
    </td>
</xsl:template>
<xsl:template name="AccountBO.Cust_DOB">
  <td class="d1">
	<xsl:value-of select="$configFields[@name='Date of Birth']/@configLabel"/>
  </td><td class="d3">
	<input type="text" name="DOB" value="{$DOB}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
    </td>
</xsl:template>
<xsl:template name="GcifCorporateBO.gcifId">
  <td class="d1">
	<xsl:value-of select="$configFields[@name='gcifId']/@configLabel"/>
  </td><td class="d3">
	<input type="text" name="cifID" value="{$cifID}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
  </td>
</xsl:template>
<xsl:template name="GcifCorporateBO.corporate_Name">
  <td class="d1">
	<xsl:value-of select="$configFields[@name='Corporate Name']/@configLabel"/>
  </td><td class="d3">
	<input type="text" name="corpName" value="{$corpName}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
  </td>
</xsl:template>
<xsl:template name="GcifCorporateBO.shortName">
  <td class="d1">
	<xsl:value-of select="$configFields[@name='Short Name']/@configLabel"/>
  </td><td class="d3">
	<input type="text" name="shortName" value="{$shortName}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
  </td>
</xsl:template>
<xsl:template name="GcifCorporateBO.date_Of_Incorporation">
  <td class="d1">
	<xsl:value-of select="$configFields[@name='Date of Incorporation']/@configLabel"/>
  </td><td class="d3">
	<input type="text" name="dateOfInc" value="{$dateOfInc}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
  </td>
</xsl:template>
<xsl:template name="CorporateBO.corp_Key">
  <td class="d1">
	<xsl:value-of select="$configFields[@name='CIF ID']/@configLabel"/>
  </td><td class="d3">
	<input type="text" name="cifID" value="{$cifID}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
  </td>
</xsl:template>
<!-- Changes for ticket 312337 starts -->
<!-- Changes for ticket 339680 starts -->

<xsl:template name="CorporateBO.corporate_Name">
  <td class="d1">
	<xsl:value-of select="$configFields[@name='Corporate Name']/@configLabel"/>
  </td><td class="d3">
	<input type="text" name="corpName" value="{$corpName}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
  </td>
</xsl:template>
<xsl:template name="CorporateBO.date_Of_Incorporation">
  <td class="d1">
	<xsl:value-of select="$configFields[@name='Date of Incorporation']/@configLabel"/>
  </td><td class="d3">
	<input type="text" name="dateOfInc" value="{$dateOfInc}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
  </td>
</xsl:template>
<xsl:template name="CorporateBO.short_Name">
  <td class="d1">
	<xsl:value-of select="$configFields[@name='Short Name']/@configLabel"/>
  </td><td class="d3">
	<input type="text" name="shortName" value="{$shortName}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
  </td>
</xsl:template>

<!--Tracker Id 124359 Changes Starts --> 
<xsl:template name="CorporateBO.corporate_Name_alt1">
  <td class="d1">
	<xsl:value-of select="$configFields[@name='Corporate Name']/@configLabel"/>
  </td><td class="d3">
	<input type="text" name="corpName_alt1" value="{$corpName_alt1}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
  </td>
</xsl:template>

<xsl:template name="CorporateBO.short_Name_alt1">
  <td class="d1">
	<xsl:value-of select="$configFields[@name='Short Name']/@configLabel"/>
  </td><td class="d3">
	<input type="text" name="shortName_alt1" value="{$shortName_alt1}" readonly="true" style="font-size:9pt; width: 218px; border-right: #7F9DB9 1pt solid; border-top: #7F9DB9 1pt solid; border-bottom: #7F9DB9 1pt solid; border-left: #7F9DB9 1pt solid;"/>	
  </td>
</xsl:template>
<!-- Changes for ticket 339680 ends -->

<!-- Changes for ticket 312337 ends -->
<!--Tracker Id 124359 Changes Ends -->
<!--Approval Changes:end-->


<xsl:template name="Remarks">
<xsl:call-template name="mtextarea">
<xsl:with-param name="res_name" select="$configFields[@name='REMARKS']"/>
<xsl:with-param name="mname">Remarks</xsl:with-param>
 <xsl:with-param name="mvalue">Remarks</xsl:with-param>
 <xsl:with-param name="mwrap">on</xsl:with-param>
 <xsl:with-param name="mrows">2</xsl:with-param>
 <xsl:with-param name="mcols">40</xsl:with-param>
 <xsl:with-param name="mcolspan">3</xsl:with-param>
 <xsl:with-param name="starshow">true</xsl:with-param>
 <xsl:with-param name="fn_onblur">txtLimit(this,1000,"REMARKS","Remarks")</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template name="mode1">

<input type="hidden" name="Mode" value="FindAuditDetails"/>
<input type="hidden" name="BOName" value="{$customFields[@n='BOName']}"/>
<input type="hidden" name="BOID" value="{$customFields[@n='BOID']}"/>
<input type="hidden" name="starttm" value="{$customFields[@n='starttm']}"/>
<input type="hidden" name="processId" value="{$customFields[@n='processId']}"/>
<input type="hidden" name="objectId" value="{$customFields[@n='objectId']}"/>
<input type="hidden" name="processStep" value="{$customFields[@n='processStep']}"/>
<input type="hidden" name="nextStep" value="{$customFields[@n='nextStep']}"/>
<input type="hidden" name="strictProc" value="{$customFields[@n='strictProc']}"/>
<input type="hidden" name="isConditional" value="{$customFields[@n='isConditional']}"/>
<input type="hidden" name="startdt" value="{$customFields[@n='startdt']}"/>
<input type="hidden" name="dueDate" value="{$customFields[@n='dueDate']}"/>
<input type="hidden" name="sIsApplAttach" value="{$customFields[@n='sIsApplAttach']}"/>


<!--Approval Changes:start-->

<xsl:choose>
<xsl:when test= "(normalize-space($BOName)='CorporateModBO')">
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.corp_Key"/>
<xsl:call-template name="CorporateBO.corporate_Name"/>
<xsl:call-template name="End"/>
<tr></tr>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.short_Name"/>
<xsl:call-template name="CorporateBO.date_Of_Incorporation"/>
<xsl:call-template name="End"/>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test= "(normalize-space($BOName)='GcifCorporateModBO')">
<xsl:call-template name="Begin"/>
<xsl:call-template name="GcifCorporateBO.gcifId"/>
<xsl:call-template name="GcifCorporateBO.corporate_Name"/>
<xsl:call-template name="End"/>
<tr></tr>
<xsl:call-template name="Begin"/>
<xsl:call-template name="GcifCorporateBO.shortName"/>
<xsl:call-template name="GcifCorporateBO.date_Of_Incorporation"/>
<xsl:call-template name="End"/>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="Begin"/>
<xsl:call-template name="AccountBO.Salutation"/>
<xsl:call-template name="AccountBO.Cust_Last_Name"/>
<xsl:call-template name="End"/>
<tr></tr>
<xsl:call-template name="Begin"/>
<xsl:call-template name="AccountBO.Cust_First_Name"/>
<xsl:call-template name="AccountBO.AccountKey"/>
<xsl:call-template name="End"/>
<tr></tr>
<xsl:call-template name="Begin"/>				
	<xsl:call-template name="AccountBO.Cust_DOB"/>
	
<xsl:call-template name="End"/>

</xsl:otherwise>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>


<!-- Coomented for ticket ID : 310835

 GCIF Process changes. fix for ticket 231486 
<xsl:choose>
<xsl:when test= "(normalize-space($BOName)='GcifRetailModBO')">
<xsl:call-template name="Begin"/>
<xsl:call-template name="DecisionGCIF"/>
<xsl:call-template name="Remarks"/>
<xsl:call-template name="End"/>
</xsl:when>
<xsl:otherwise> -->
<xsl:call-template name="Begin"/>
<xsl:call-template name="Decision"/>
<xsl:call-template name="Remarks"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
<xsl:call-template name="ViewCustDet" />	
<xsl:call-template name="End"/>
<!--</xsl:otherwise>
</xsl:choose>-->





    <!-- Fix for Ticket ID 278905 -->
         <!-- <script>
		        var ArrDecision1 ='<xsl:value-of select="$ArrDecision2"/>';
			var index = ArrDecision1.indexOf('[');
			var index1 = ArrDecision1.indexOf(']');
			var comma = ', ';
			var compSub = ArrDecision1.substr((index+1),(index1-1));
			var comp = (comma+compSub);
			var arrTemp = new Array();
			arrTemp =  comp.split(",");
			var count =1;
		          while (arrTemp[count]!=null) {
			       var Decision = arrTemp[count];
			     
			      // var length = document.getElementsByName("ArrDecision")[0].options.length;
			      // var obj = new Option(Decision,Decision);
			      // document.getElementsByName("ArrDecision")[0].options[length] = obj;
			      
			      var length = document.getElementsByName("Decision")[0].options.length;
			      var obj = new Option(Decision,Decision);
			      document.getElementsByName("Decision")[0].options[length] = obj;
			      count++;
		               }
	</script> -->				
<!-- Fix for Ticket ID 278905 -->

<!-- FIX ends -->
<!--Tracker Id 124359 Changes Starts --> 
<xsl:choose>
	<xsl:when test="normalize-space($altLocaleActv)='true'">
	<xsl:variable name="DUAL"><xsl:value-of select="$configFields[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>
		<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
				<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rowdual" name="rowdual">
					<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
				<td onclick="Toggle('dual','all');" colspan = "5" NOWRAP="true" class="LabelFont">
				     <A HREF="javascript:Toggle('DUAL','all');"><IMG onclick="Toggle('dual','all');" SRC="../reports/images/minus.gif" ID="dualgif"
				      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
				     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$DUAL"/>
				     </label>
				</td>
				</tr>
		</table>		
		
		<DIV ID = 'native' STYLE= 'visibility:visible;'>
		<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
		<xsl:choose>
                <xsl:when test= "not(normalize-space($BOName)='CorporateModBO')">	
			<TR ID='rowdual' name='rowdual'>
				<xsl:call-template name="Begin"/>
				<xsl:call-template name="AccountBO.Cust_Last_Name_alt1"/>
				<xsl:call-template name="AccountBO.Cust_First_Name_alt1"/>
				<xsl:call-template name="End"/>
							 				
			</TR>
		</xsl:when>
                <xsl:otherwise>	
			<TR ID='rowdual' name='rowdual'>
				<xsl:call-template name="Begin"/>
				<xsl:call-template name="CorporateBO.corporate_Name_alt1"/>
				<xsl:call-template name="CorporateBO.short_Name_alt1"/>
				<xsl:call-template name="End"/>
				 				
			</TR>
		</xsl:otherwise>
                </xsl:choose>	
		</table>
		</DIV>
	 
	</xsl:when>

</xsl:choose>

<!--Tracker Id 124359 Changes Ends -->
<!--Approval Changes:end-->

<xsl:call-template name="Begin"/> <!-- Approval Screen Perf Fix -->
<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
<tr><a href="#" onclick="showAuditTrail(); return false;"><xsl:value-of select="$configFields[@name='View Audit Trail']/@configLabel"/></a></tr></table> 
<xsl:call-template name="End"/>


</xsl:template>
<xsl:template match="SRM">
<xsl:for-each select=".">
	<tr>
	<td colspan="9">
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
	<tr>
	<xsl:call-template name="apply">
	<xsl:with-param name="apply_head" select="$configFields[@name='Header']/@configLabel"/>
	</xsl:call-template>
	</tr>
	<xsl:if test="not(normalize-space($customFields[@n='extra_header'])='')">
	<tr><td xsl:use-attribute-sets="cellstyle">
	<font face="Arial, Helvetica, sans-serif" color="#000000" size="1">
	<script>document.write('<xsl:value-of select="$customFields[@n='extra_header']"/>')</script>
	</font>
	</td></tr>
	</xsl:if>
	</table>
	</td>
	</tr>
	<form name="Frm2" id="Frm2" method="post">
	<table  align='center' width="100%" cellpadding="0" cellspacing="5" border="0">
	<xsl:call-template name="mode1"/>
	</table>
	</form>
	</xsl:for-each>
</xsl:template>
</xsl:stylesheet>















