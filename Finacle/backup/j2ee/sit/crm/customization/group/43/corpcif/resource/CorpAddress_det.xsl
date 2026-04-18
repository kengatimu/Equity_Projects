<?xml version="1.0"?>
    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
    <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin-->
    <xsl:import href="../Renderer/common/display/FCRMCommonWidgets.xsl"/>
    <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
        <xsl:param name="locale"/>
    <xsl:variable name="file1">../Renderer/Customization/43/corpcif/resource/CorpAddress_det_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_1" select="document(concat($file1, ''))"/>
    <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
	<xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
 <!-- MAPTT fix:Loading Defalut format Changes:Start  -->
        <xsl:variable name="PreferredAddrFormat" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.PreferredFormat']"/>
   <!-- MAPTT fix:Loading Defalut format Changes:End  -->
	<xsl:variable name="dtValid" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtValid']"/>

    <xsl:variable name="allfields" select="//SRMData//Z"/>
		<xsl:variable name="dtCurr" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtCurr']"/>

	<!-- caching changes start -->
    <xsl:param name="viewname"/>
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.corpcif.CorpCIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
    <xsl:variable name="PresFile" select="document(concat($PresFileName, ''))"/>
    <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
	<!-- caching changes end -->
    <!--     CIF PhoneEmail Changes : Start -->
    <xsl:variable name="isFormatReadOnly" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsFormatReadOnly']"/>
<!-- QED Changes: START -->
    <xsl:variable name="isQuickEdit" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isQuickEdit']"/>
<!-- QED Changes: END -->
    <!--     CIF PhoneEmail Changes : End -->
    <!-- isaddressproof recieved changes -->
<xsl:variable name="entitytype" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entitytype']"/>
<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin--> 
<xsl:variable name="IsAddProp" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsAddProp']" />
<xsl:variable name="IsAddressVerified" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsAddressVerified']" />
<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
<!-- Equity Bank Customization changes for CGCR19 start-->

<xsl:variable name="catRegion" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='catRegion']" />
<xsl:variable name="valRegion" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='valRegion']" />
<xsl:variable name="mode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mode']" />
<!-- Equity Bank Customization changes for CGCR19 end-->
    <xsl:template match="/">
    <html>
        <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
    <head>
    <script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
<script type="text/javascript" src="../corpcif/js/Message_corpcif_{$locale}.js" language="javascript"></script>
<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin--> 
<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end--> 
    <script>
    var locale = '<xsl:value-of select="$locale"/>';
	var locDate = '<xsl:value-of select = "$dtValid"/>'
    <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin-->
	var IsAddProp = '<xsl:value-of select="$IsAddProp"/>';
    var flag_IsAddressVerified = '<xsl:value-of select="$IsAddressVerified"/>';
    <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
	//Equity Bank Customization changes for CGCR19 start
		var catRegion = '<xsl:value-of select="$catRegion"></xsl:value-of>';
		var valRegion = '<xsl:value-of select="$valRegion"></xsl:value-of>';
		var mode = '<xsl:value-of select="$mode"></xsl:value-of>';
	//Equity Bank Customization changes for CGCR19 end

    </script>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
    <script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
    <script type="text/javascript" src="../common/js/MLValidate.js" language="javascript"></script>
    <script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
    <script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
    <script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>
    <script type="text/javascript" src="../common/html/Rendvalidate.js" language="javascript"></script>
    <script type="text/javascript" src="../admin/js/AttributeAccess.js" language="javascript"></script>
    <SCRIPT LANGUAGE='javascript' SRC='../common/js/FieldValidate.js'></SCRIPT>
    <!-- CIF PhoneEmail Changes : Start -->

<!-- Equity bank DRC CGCR19 changes start -->
       <script type="text/javascript" language="javascript" src="../Customization/43/corpcif/js/CorpCIFAddress.js"></script>
	   <!-- Equity bank DRC CGCR19 changes end -->
    <!-- Tracker ID 209607 Changes Starts -->
    <script type="text/javascript" src="../corpcif/js/CorpCIFAddress_RCL.js" language="javascript"></script> 
    <script type="text/javascript" src="../corpcif/js/CorpCIFAddress_Reduced.js" language="javascript"></script>
    <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin-->
    <script type="text/javascript" src="../common/js/SearchAddress.js" language="javascript"></script> 
    <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
    <!-- Tracker ID 209607 Changes Ends --> 
    <!-- CIF PhoneEmail Changes : End -->
			<!-- Equity Bank Customization changes for CGCR19 start-->
	<script type="text/javascript" src="../Customization/43/cif/js/AddressCustom.js" language="javascript"></script>
	<!-- Equity Bank Customization changes for CGCR19 start-->

    <script>
	  var corp_city_code ='';
	  var corp_state_code='';
	  var corp_cntry_code='';
	  
	  <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin-->
	  <!--Get all the details fetched in global variables-->
	  
	  var HouseNo= '';
	  var PremiseName= '';
	  var BuildingLevel= '';
	  var StreetNo= '';
	  var Suburb= '';
	  var StreetName= '';
	  var Locality= '';
	  var Town= '';
	  var AddressLabel= '';
	  var AddressLine1= '';
	  var AddressLine2= '';
	  var AddressLine3= '';
	  var City= '';
	  var State= '';
	  var Country= '';
	  var PostalCode= '';
	  var UserField1= '';
	  var UserField2= '';
	  var UserField3= '';
	  var UserField4= '';
	  var UserField5= '';
	  var UserFieldDate1= '';
	  var UserFieldDate2= '';
	  var loadURL = null;
          <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
	  
	  
	  <xsl:variable name="str2Code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.city_Code']"/>
	  <xsl:variable name="str3Code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.state_Code']"/>
	  <xsl:variable name="str4Code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.country_Code']"/>
	  corp_city_code = '<xsl:value-of select="$str2Code"/>';
	  corp_state_code = '<xsl:value-of select="$str3Code"/>';
	  corp_cntry_code = '<xsl:value-of select="$str4Code"/>';
    </script>
    <script type="text/javascript" language="javascript">
	var AddressID = "";
<!-- QED Changes: START -->
	var isQuickEdit = '<xsl:value-of select="$isQuickEdit"/>';
<!-- QED Changes: END -->
<!-- isaddressproof recieved changes -->
	var entitytype = '<xsl:value-of select="$entitytype"/>';
function load(){
try{
//Ticket 364531 changes
populateHoldMail(document.getElementsByName("CorporateBO.Address.addressCategory")[0].value);

customLoad();
}catch(e)
{ }
try{
SetCookie("isQuickEdit",isQuickEdit);

	/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
		if("Y" == flag_IsAddressVerified){
			HouseNo		= document.getElementsByName("CorporateBO.Address.house_no")[0].value;
			PremiseName	= document.getElementsByName("CorporateBO.Address.premise_name")[0].value;
			BuildingLevel	= document.getElementsByName("CorporateBO.Address.building_level")[0].value ;
			StreetNo	= document.getElementsByName("CorporateBO.Address.street_no")[0].value ;
			Suburb		= document.getElementsByName("CorporateBO.Address.suburb")[0].value ;
			StreetName	= document.getElementsByName("CorporateBO.Address.street_name")[0].value ;
			Locality	= document.getElementsByName("CorporateBO.Address.locality_name")[0].value ;
			Town		= document.getElementsByName("CorporateBO.Address.town")[0].value ;
			City		= document.getElementsByName("Cat_CorporateBO.Address.city")[0].value ;
			State		= document.getElementsByName("Cat_CorporateBO.Address.state")[0].value ;
			Country		= document.getElementsByName("Cat_CorporateBO.Address.country")[0].value ;
			PostalCode	= document.getElementsByName("CorporateBO.Address.zip")[0].value ;
		}
	/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
		

	/*MAPTT fix Start:Loading default value for PreferredFormat*/
		var vPrefAddrFormat='<xsl:value-of select="$PreferredAddrFormat"/>';
		if(vPrefAddrFormat==null || vPrefAddrFormat=='')
		{
			selectDrpDwnValue(document.getElementsByName('CorporateBO.Address.PreferredFormat')[0],'STRUCTURED_FORMAT');
		}
	/*MAPTT fix End: Loading default value for PreferredFormat*/
    AddressID = '<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.addressID']"/>';
<!-- Fix for ticket 297100 starts -->
var strtDate = '<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.Start_Date']"/>';
setStartDate(AddressID,strtDate);
//Changes for tracker ID 450164 start
var lastUpdateDate = '<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.LastUpdate_Date']"/>';
if(lastUpdateDate==',,,'){
document.getElementsByName('CorporateBO.Address.LastUpdate_Date')[0].value = '';
}
//Changes for tracker ID 450164 end
<!-- Fix for ticket 297100 ends -->


     /* CIF PhoneEmail Changes : Start*/
     if('<xsl:value-of select="$isFormatReadOnly"/>' == 'Yes')
     {
	document.getElementsByName('CorporateBO.Address.PreferredFormat')[0].disabled = true;
     }

     if('<xsl:value-of select="$readMode"/>' != 'Y'){

			if(document.getElementsByName('CorporateBO.Address.PreferredFormat')[0].value == "FREE_TEXT_FORMAT")
			{
			//disableEnableFreeTextFields(false);
			//disableEnableStructuredFields(true);
			}
			else
			{
			//disableEnableStructuredFields(false);
			//disableEnableFreeTextFields(true);
			}
	}

	else
	{
        	document.getElementsByName("CorporateBO.Address.HoldMailFlag")[0].disabled=true;
        }
  //// Tracker 180411 Hold Mail Changes : Begin
    //Ticket 364531 changes 
     var holdMailChecked  = document.getElementsByName("CorporateBO.Address.HoldMailFlag")[0].value;
     var holdMailFlag = '<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.HoldMailFlag']"/>';
     if((holdMailFlag==null || holdMailFlag=='') &amp;&amp; holdMailChecked!= 'Y'){
     //Ticket 364531 changes end
         selectDrpDwnValue(document.getElementsByName('CorporateBO.Address.HoldMailFlag')[0],'N');
     	}
    /* var holdMailChecked  = document.getElementsByName("CorporateBO.Address.HoldMailFlag")[0]; */
     if(holdMailFlag == "Y")
    {
      /* changes for tracker id 173129 begins */
      //holdMailChecked.checked = true;
      /* changes for tracker id 173129 ends */

      disableEnableHoldMail();
    }
    else
    {
        /* changes for tracker id 173129 begins */
         //holdMailChecked.checked = false;
         /* changes for tracker id 173129 ends */
	document.getElementsByName('CorporateBO.Address.HoldMailReason')[0].disabled = true;
	document.getElementsByName("btnone_CorporateBO.Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName("btntwo_CorporateBO.Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName('CorporateBO.Address.BusinessCenter')[0].disabled = true;
    	document.getElementsByName('CorporateBO.Address.HoldMailInitiatedBy')[0].disabled = true;
	 disableEnableHoldMail();
    }
  /*  if(holdMailFlag == "N" )
    {
	document.getElementsByName('CorporateBO.Address.HoldMailReason')[0].disabled = true;
	document.getElementsByName("btnone_CorporateBO.Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName("btntwo_CorporateBO.Address.BusinessCenter")[0].disabled = true;
	document.getElementsByName('CorporateBO.Address.BusinessCenter')[0].disabled = true;
    	document.getElementsByName('CorporateBO.Address.HoldMailInitiatedBy')[0].disabled = true;
    } */
    // Tracker 180411 Hold Mail Changes : End
    /*CIF PhoneEmail Changes : End */
	//Equity bank DRC  CGCR19 changes start
	if('<xsl:value-of select="$readMode"/>' != 'Y'){

if(mode == 'Edit' || mode =='Copy'){
	document.getElementsByName('Cat_CorporateBO.Address.userField1')[0].value=catRegion;
	document.getElementsByName('CorporateBO.Address.userField1')[0].text=catRegion;
	document.getElementsByName('CorporateBO.Address.userField1')[0].value=valRegion;


	countryVal=document.getElementsByName("CorporateBO.Address.country")[0].value;

	if (countryVal != 'CD'){
		document.getElementsByName('CorporateBO.Address.city')[0].disabled = true;
		document.getElementsByName('Cat_CorporateBO.Address.city')[0].disabled = true;

		document.getElementsByName('btnone_CorporateBO.Address.city')[0].disabled = true;
		document.getElementsByName('btntwo_CorporateBO.Address.city')[0].disabled = true;

		document.getElementsByName('CorporateBO.Address.state')[0].disabled = true;
		document.getElementsByName('Cat_CorporateBO.Address.state')[0].disabled = true;

		document.getElementsByName('btnone_CorporateBO.Address.state')[0].disabled = true;
		document.getElementsByName('btntwo_CorporateBO.Address.state')[0].disabled = true;
		document.getElementsByName('CorporateBO.Address.userField1')[0].disabled = true;
		document.getElementsByName('Cat_CorporateBO.Address.userField1')[0].disabled = true;
		document.getElementsByName('btnone_CorporateBO.Address.userField1')[0].disabled = true;
		document.getElementsByName('btntwo_CorporateBO.Address.userField1')[0].disabled = true;

	}
	else{
		document.getElementsByName('CorporateBO.Address.city')[0].disabled = false;
		document.getElementsByName('Cat_CorporateBO.Address.city')[0].disabled = false;
		document.getElementsByName('btnone_CorporateBO.Address.city')[0].disabled = false;
		document.getElementsByName('btntwo_CorporateBO.Address.city')[0].disabled = false;
		document.getElementsByName('CorporateBO.Address.state')[0].disabled = false;
		document.getElementsByName('Cat_CorporateBO.Address.state')[0].disabled = false;
		document.getElementsByName('btnone_CorporateBO.Address.state')[0].disabled = false;
		document.getElementsByName('btntwo_CorporateBO.Address.state')[0].disabled = false;
		document.getElementsByName('CorporateBO.Address.userField1')[0].disabled = false;
		document.getElementsByName('Cat_CorporateBO.Address.userField1')[0].disabled = false;
		document.getElementsByName('btnone_CorporateBO.Address.userField1')[0].disabled = false;
		document.getElementsByName('btntwo_CorporateBO.Address.userField1')[0].disabled = false;
	}

}
else{
	document.getElementsByName("Cat_CorporateBO.Address.country")[0].value='THE DEMOCRATIC REPUBLIC OF CONGO';
	document.getElementsByName("CorporateBO.Address.country")[0].value='CD';
}
}
else{
	document.getElementsByName('Cat_CorporateBO.Address.userField1')[0].value=catRegion;
	document.getElementsByName('CorporateBO.Address.userField1')[0].text=catRegion;
	document.getElementsByName('CorporateBO.Address.userField1')[0].value=valRegion;
}
//Equity bank DRC CGCR19 changes end
}catch(e){
}
}
/* Changes for Tracker #293856 Start*/
function setMCAttModifyFlag(){
        window.opener.parent.parent.IFrmtab0.formDispFrame.document.frm2.isMCEditedGeneral.value="Y";
        
}
/* Changes for Tracker #293856 End*/
/**********Tracker 78557 Validation for future date***********/
function PhoneValidate(wpCountryCode, wpAreaCode, wpLocalCode ){
    try{

		if(wpCountryCode.value != "") {
	      if (validate_phoneField(wpCountryCode,false,true)==false){
			return false;}
		}

		if(wpAreaCode.value != "") {
			 if (validate_phoneField(wpAreaCode,false,true)==false){
			return false;}
		}
		if(wpLocalCode.value != "") {
	     if (validate_phoneField(wpLocalCode,false,true)==false){
		  return false;}
		}
   }catch(e){}
   return true;
}
/* CallID:248979 Ticket 484795 tracker 294705 changes start */
function setMCAttModifyFlag(){
        window.opener.parent.parent.IFrmtab0.formDispFrame.document.frm2.isMCEditedGeneral.value="Y";
        }
/* Call ID : 248979 Ticket 484795 tracker 294705 changes end */

function validateIssueDate(){

	/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
	/* calling the function isGregDate for on blur functionality*/
	isGregDate("3_CorporateBO.Address.Start_Date");
	/* ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/

	var todaydate = new String();
	todaydate.value = getTodayDate1(locDate);

	elem1 = document.getElementsByName("3_CorporateBO.Address.Start_Date")[0];
	/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
	/* calling the function isGregDate for on blur functionality*/
	if (elem1.value != '')
	{
	todaydate.value = convertDate(todaydate.value);
	}
	/* ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/

	var mill1 = changetoMillisInUSFormat(todaydate.value);
	var mill2 = changetoMillis(elem1.value);
	/*TRACKER 278667 BEGIN*/
	/*if (mill1 &lt; mill2){
	showMessage(MSGX0006);
	elem1.value = "";

	}*/
	/*TRACKER 278667 END*/

}

function changetoMillis(datevalue){
	if(datevalue.length == 0){

			return 0;
		}

	 else{
		date1 = new Date(datevalue.substring(3,5) + "/" + datevalue.substring(0,2) + "/" + datevalue.substring(6,10));
		var millis = date1.valueOf();
		return millis;
	    }

}
/**********Tracker 785572 END***********/
 function enableClose(){
			try{
				document.getElementsByName("Close")[0].disabled = false;
			}catch(e){
			}
    }
 //Ticket 364531 changes   
 function fnChangeHoldMailDet(AddrDetails){
/*TICKET 365709 BEGIN*/ 
 if ((top.window.opener.AdrRecordSet != null)) {
  var recSet =  top.window.opener.AdrRecordSet;
  }
  else{
   var recSet =  top.window.opener.RecordSet;
  }
  /*TICKET 365709 end*/ 
 var recSetSize =  recSet.rows.length ;
 		var holdMailValues = new Array();
 				// Tracker ID: 135125: XMLEncoding Changes STARTS
 				for(var j=2 ; j &lt; recSetSize; j++)
 			{
 				if(AddrDetails[0] == recSet.rows(j).getAttribute("CorporateBO.Address.addressCategory"))
 				{
					recSet.rows(j).setAttribute("CorporateBO.Address.HoldMailFlag",AddrDetails[24])	;
					recSet.rows(j).setAttribute("CorporateBO.Address.HoldMailInitiatedBy",AddrDetails[23]);
					recSet.rows(j).setAttribute("CorporateBO.Address.BusinessCenter",AddrDetails[22]);
					recSet.rows(j).setAttribute("CorporateBO.Address.HoldMailReason",AddrDetails[21]);
 					
 				}
 			}
             	
 
 }   
    

function saveEduDet(){

// RefCode Changes: Begin
	if (document.getElementsByName("corp_city_code")[0].value=='') {
		document.getElementsByName("corp_city_code")[0].value=corp_city_code;
	}
	if (document.getElementsByName("corp_state_code")[0].value=='') {
		document.getElementsByName("corp_state_code")[0].value=corp_state_code;
	}
	if (document.getElementsByName("corp_cntry_code")[0].value=='') {
		document.getElementsByName("corp_cntry_code")[0].value=corp_cntry_code;
	}
	// RefCode Changes: End
		try{
		customSaveEduDet();
		}catch(e)
		{
		}
     AddrDetails = new Array();
try{
    retStat = ValidateFormContents(document.frm2,false);
    if(retStat == "false") {
    return "interactive";
    }
try{
var strtDt;
var endDt;
var res;
strtDt=document.getElementsByName('CorporateBO.Address.Start_Date')[0];
endDt=document.getElementsByName('CorporateBO.Address.End_Date')[0];
res = Validate_toDate1(strtDt, endDt, true, false);
if (res == false){
showMessage(getUserErrorMessage ('MSG016', [ strtDt.Display, endDt.Display ]));
return "interactive";
 }
var url;
var res1;
url=document.getElementsByName('CorporateBO.Address.URL')[0];
URL = url.value;
res1 = validate_url(url,false,false);
if (res1 == false){
 if(URL != ''){
	return "interactive";
	 }
}
var ZIP = document.getElementsByName('CorporateBO.Address.zip')[0]
      var zip = trim(ZIP.value);
      var res2;
	if (zip.length > 10){
		showMessage(MSGX0007);
		return "interactive"
	}

//Fix for Tracker 99537
var numZip = eval(zip);
if(numZip == 0){
	var errorMsg = getUserErrorMessage ('MSGNOTEQZERO',MSG_ADDR_ZIP );
	showMessage(errorMsg);
	return "interactive";
}
//Fix for Tracker 99537

if( zip == sMasker)
	{
		flag = 'true';
	}
	// ST defect : 78572
	// Validation for Special Characters
	<![CDATA[
	flag = 'true';
	len = (zip.length);
	for(i=0;i<len;i++){
		s= zip.charAt(i).charCodeAt();
		if((s>47 && s<58)||(s>96 && s<123)||(s>64 && s<91)){
		}else{
			//zip.charAt(i)="";
			flag = 'false';
		}
	}
	if(flag == 'false'){
		showMessage(MSGX0008);
		document.getElementsByName("CorporateBO.Address.zip")[0].focus();
		return "interactive"
	}
	]]>
	// ST defect : 78572
}

catch(e){
}
	    AddrDetails[0] = trim(''+document.getElementsByName('CorporateBO.Address.addressCategory')[0].value);
            AddrDetails[1] = trim(''+document.getElementsByName('CorporateBO.Address.house_no')[0].value);
            AddrDetails[2] = trim(''+document.getElementsByName('CorporateBO.Address.premise_name')[0].value);
              <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
            AddrDetails[3] = trim(''+document.getElementsByName('CorporateBO.Address.End_Date')[0].value);
            AddrDetails[4] = trim(''+document.getElementsByName('3_CorporateBO.Address.Start_Date')[0].value);
              <!-- Tracker ID : 90197 End of Changes -->
            AddrDetails[5] = trim(''+document.getElementsByName('CorporateBO.Address.city')[0].value);
            AddrDetails[6] = trim(''+document.getElementsByName('CorporateBO.Address.country')[0].value);
            AddrDetails[7] = trim(''+document.getElementsByName('CorporateBO.Address.state')[0].value);
            AddrDetails[8] = trim(''+document.getElementsByName('CorporateBO.Address.zip')[0].value);
            AddrDetails[9] = trim(''+document.getElementsByName('CorporateBO.Address.building_level')[0].value);
            AddrDetails[10] = trim(''+AddressID);
            AddrDetails[11] = document.getElementsByName('CorporateBO.Address.street_no')[0].value;
	    AddrDetails[12] = document.getElementsByName('CorporateBO.Address.locality_name')[0].value;
	    AddrDetails[13] = document.getElementsByName('CorporateBO.Address.town')[0].value;
	    AddrDetails[15] = document.getElementsByName('CorporateBO.Address.street_name')[0].value;
	    AddrDetails[16] = document.getElementsByName('CorporateBO.Address.suburb')[0].value;
//	    AddrDetails[25] = document.getElementsByName('CorporateBO.Address.WorkExtension')[0].value;
// RefCode Changes: Begin
	    AddrDetails[17] = document.getElementsByName("corp_city_code")[0].value;
	    AddrDetails[18] = document.getElementsByName("corp_state_code")[0].value;
	    AddrDetails[19] = document.getElementsByName("corp_cntry_code")[0].value;
// RefCode Changes: End
  	    //CIF PhoneEmail Changes : Start
  	    AddrDetails[20] = document.getElementsByName('CorporateBO.Address.PreferredFormat')[0].value;
   	    AddrDetails[21] = document.getElementsByName('CorporateBO.Address.HoldMailReason')[0].value;
    	    AddrDetails[22] = document.getElementsByName('CorporateBO.Address.BusinessCenter')[0].value;
    	    AddrDetails[23] = document.getElementsByName('CorporateBO.Address.HoldMailInitiatedBy')[0].value;
    	    AddrDetails[24] = document.getElementsByName('CorporateBO.Address.HoldMailFlag')[0].value;
            AddrDetails[32] = trim(''+document.getElementsByName('Cat_CorporateBO.Address.city')[0].value);
	    AddrDetails[33] = trim(''+document.getElementsByName('Cat_CorporateBO.Address.state')[0].value);
	    AddrDetails[34] = trim(''+document.getElementsByName('Cat_CorporateBO.Address.country')[0].value);
            AddrDetails[35] = document.getElementsByName('CorporateBO.Address.LastUpdate_Date')[0].value;
		AddrDetails[36] ='Y';
	    AddrDetails[38] = document.getElementsByName("CorporateBO.Address.IsAddressProofRcvd")[0].value;
	    
// changes for Tracker ID 456637 - TOL ID 455246
	    AddrDetails[41] = trim(''+document.getElementsByName("CorporateBO.Address.addressCategory")[0].options[document.getElementsByName("CorporateBO.Address.addressCategory")[0].options.selectedIndex].text);
// changes for Tracker ID 456637 - TOL ID 455246
	    /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
	    <![CDATA[
	    var City_Val = document.getElementsByName('Cat_CorporateBO.Address.city')[0].value;
	    var State_Val = document.getElementsByName('Cat_CorporateBO.Address.state')[0].value;
	    var Country_Val = document.getElementsByName('Cat_CorporateBO.Address.country')[0].value;

	    if( (HouseNo == AddrDetails[1]) && (PremiseName == AddrDetails[2]) && (City == City_Val) && 
		(Country == Country_Val) && (State == State_Val) && (PostalCode == AddrDetails[8]) && 
		(BuildingLevel == AddrDetails[9]) && (StreetNo == AddrDetails[11]) && (Locality == AddrDetails[12]) && 
		(Town == AddrDetails[13]) && (StreetName == AddrDetails[15]) && (Suburb == AddrDetails[16]) ){
		// Then make isaddressverfied as Yes
		AddrDetails[40] = 'Y';
	    } else{
		 if (IsAddProp == 'true'){
			if ( !this.parent.parent.showConfirmMessage(MSGJ51481)) {
					return;
			}else{
				AddrDetails[40] = 'N';
			}
		}else{
				AddrDetails[40] = '';
		}
	    }
	    /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
	    //Equity bank DRC  CGCR19 changes start
		AddrDetails[45] = trim(''+document.getElementsByName('CorporateBO.Address.userField1')[0].value);
		//Equity bank DRC  CGCR19 changes end
	    
	    //Ticket 364531 changes
	    try{
	    fnChangeHoldMailDet(AddrDetails);
	    }catch(e){
	    alert(e.message);
	    }

// QED Changes: START
 	    if(isQuickEdit == 'Yes')
	    {
/*Ticket 294850 Changes : Begin */
			if (top.window.opener.addQuickAddrDetails(AddrDetails,true) == 'true') {
			/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
			if(null != loadURL && '' != loadURL && 'undefined' != loadURL){
				loadURL.close();
			}
            /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
				top.window.close();
				top.window.opener.focus();
			}
/*Ticket 294850 Changes : End */
			else{
				top.window.focus();
			}
	     }
  	     else
	     {

// QED Changes: END

            if (top.window.opener.addAddrDetails(AddrDetails,true) == 'true') {
            /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
            if(null != loadURL && '' != loadURL && 'undefined' != loadURL){
			loadURL.close();
	        }
            /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
			top.window.close();
			top.window.opener.focus();
		}
		else{
		top.window.focus();
		}
// QED Changes: START
	     }
// QED Changes: END
        } catch(e) {
        /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
	    if(null != loadURL && '' != loadURL && 'undefined' != loadURL){
		loadURL.close();
	    }
        /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
            top.window.close();
        }
        ]]>
    }
    function cancel(){
/*
 * Sanity fix for address not saving BEGINS
 */
//{
/* SANITY Fix for address not saving ENDS */
	if ( !this.parent.parent.showConfirmMessage(MSG022)) {
		return;
	}
        try {
            ProdLookupWindow = null;
            window.close();
            window.opener.focus();
        }catch(e) {
        }
    }

    function enableClose(){
		try{
			document.getElementsByName("Close")[0].disabled = false;
		}catch(e){
		}
    }

     	function SetLocCookies(){

     		onLoadSetLocCookies('CorporateBO.Address.city','CorporateBO.Address.state','CorporateBO.Address.country');
    	}
    	
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/    	
/*************************************************************************************
* This function auto populates the fields selecting any record in address results
*************************************************************************************/
function populateAddrResults(addressResults){
	try{
		// Retrive the selected results in to global variables
		HouseNo= addressResults[0].toUpperCase();
		PremiseName= addressResults[1].toUpperCase();
		BuildingLevel= addressResults[2].toUpperCase();
		StreetNo= addressResults[3];
		Suburb= addressResults[4].toUpperCase();
		StreetName= addressResults[5].toUpperCase();
		Locality= addressResults[6].toUpperCase();
		Town= addressResults[7].toUpperCase();
		AddressLabel= addressResults[8].toUpperCase();
		AddressLine1= addressResults[9].toUpperCase();
		AddressLine2= addressResults[10].toUpperCase();
		AddressLine3= addressResults[11].toUpperCase();
		City= addressResults[12].toUpperCase();
		State= addressResults[13].toUpperCase();
		Country= addressResults[14].toUpperCase();
		PostalCode= addressResults[15].toUpperCase();
		UserField1= addressResults[16].toUpperCase();
		UserField2= addressResults[17].toUpperCase();
		UserField3= addressResults[18].toUpperCase();
		UserField4= addressResults[19].toUpperCase();
		UserField5= addressResults[20].toUpperCase();
		UserFieldDate1= addressResults[21];
		UserFieldDate2= addressResults[22];
		// Clearing all the lookup fields before populating
		document.getElementsByName("CorporateBO.Address.city")[0].value = '';
		document.getElementsByName("CorporateBO.Address.state")[0].value = '';
		document.getElementsByName("CorporateBO.Address.country")[0].value = '';
		//Setting cookies for city,state and country
		setLocCookies(City,State,Country,"CITY",'CorporateBO.Address.city','CorporateBO.Address.state','CorporateBO.Address.country');
		setLocCookies(State,Country,null,"STATE",'','CorporateBO.Address.state','CorporateBO.Address.country');
		setLocCookies(Country,null,null,"COUNTRY",'','','CorporateBO.Address.country');
		
		// Setting into the values of the widgets
		document.getElementsByName("CorporateBO.Address.house_no")[0].value = HouseNo;
		document.getElementsByName("CorporateBO.Address.premise_name")[0].value = PremiseName;
		document.getElementsByName("CorporateBO.Address.building_level")[0].value = BuildingLevel;
		document.getElementsByName("CorporateBO.Address.street_no")[0].value = StreetNo;
		document.getElementsByName("CorporateBO.Address.suburb")[0].value = Suburb;
		document.getElementsByName("CorporateBO.Address.street_name")[0].value = StreetName;
		document.getElementsByName("CorporateBO.Address.locality_name")[0].value = Locality;
		document.getElementsByName("CorporateBO.Address.town")[0].value = Town;
		document.getElementsByName("Cat_CorporateBO.Address.city")[0].value = City;
		document.getElementsByName("Cat_CorporateBO.Address.state")[0].value = State;
		document.getElementsByName("Cat_CorporateBO.Address.country")[0].value = Country;
		document.getElementsByName("CorporateBO.Address.zip")[0].value = PostalCode;
				
		// Validation for lookups Just focus and remove focus
		document.getElementsByName("Cat_CorporateBO.Address.city")[0].focus();
		document.getElementsByName("Cat_CorporateBO.Address.state")[0].focus();
		document.getElementsByName("Cat_CorporateBO.Address.country")[0].focus();
		document.getElementsByName("Save")[0].focus();
	}catch(e){
	}
}	

 /*****************************************************************************************
  * Description	: On click of search button it will call a function to create a popup	
  		  for searching listing address screen
  ******************************************************************************************/
 function searchAddress(){
 	var wh = 460;
 	var ww = 900;
 	var left_x = (screen.width - ww) / 2 ;
 	var left_y = (screen.height - wh) / 2 ;
 	wh = 660;
 	left_y = 330;
 	url = '../servlet/com.infy.cis.ui.common.SearchAddressDet';
 	loadURL = window.open(url,'AddressList','directories=No, height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars=yes');
 	loadURL.focus();
 	
}

/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/

    </script>
    </head>
    <body class="popup">
    <xsl:choose>
		<xsl:when test="normalize-space($readMode)='Y'">
			<xsl:attribute name="onload">load();showInReadOnlyMode('<xsl:value-of select="$readMode"/>');enableClose();</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="onload">SetLocCookies();load();</xsl:attribute>
		</xsl:otherwise>
    </xsl:choose>

	<xsl:apply-templates select="SRM"/>



        <table class="background" cellpadding="2" cellspacing="2" width ="100%" border="0"  align="left">

		<xsl:choose>
			<xsl:when test="normalize-space($readMode)='Y'">
				<xsl:call-template name="user_button_withText">
					<xsl:with-param name="button_name">Close</xsl:with-param>
					<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Close']/@configLabel"/></xsl:with-param>
					<xsl:with-param name="button_fnc">cancel()</xsl:with-param>
				</xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
		        <xsl:call-template name="user_button_withText">
		            <xsl:with-param name="button_name">Save</xsl:with-param>
		            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Save']/@configLabel"/></xsl:with-param>
		            <xsl:with-param name="button_fnc">saveEduDet()</xsl:with-param>
		        </xsl:call-template>&#160;
		        <xsl:call-template name="user_button_withText">
			<!--Tracker:108387: Changes for button name -->
		            <xsl:with-param name="button_name">Close</xsl:with-param>
		            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Close']/@configLabel"/></xsl:with-param>
			<!--Tracker:108387: End of Changes-->
		            <xsl:with-param name="button_fnc">cancel()</xsl:with-param>
		        </xsl:call-template>
			</xsl:otherwise>
    	</xsl:choose>
        </table>
    </body>
    </html>
</xsl:template>	
<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin--> 
<xsl:template name="SearchAddressLabel">
	<xsl:call-template name="simple_label">
		<xsl:with-param name="res_name" select="$configLabels[@name='SearchAddress']" />
		
	</xsl:call-template>
</xsl:template>
                       <!-- corpcif -->
<xsl:template name="SearchAddressButton">
	<xsl:call-template name="user_button">
		<xsl:with-param name="button_fnc">searchAddress()</xsl:with-param>
		<xsl:with-param name="button_name" select="$configLabels[@name='Search']/@configLabel" />
	</xsl:call-template>
</xsl:template>
<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
		       <xsl:template name="CorporateBO.Address.addressCategory">
		                   <xsl:call-template name="mdrpdown">
		                       <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.addressCategory']"/>
		                       <xsl:with-param name="selectname">CorporateBO.Address.addressCategory</xsl:with-param>
		                       <xsl:with-param name="selectdisp">CorporateBO.Address.addressCategory</xsl:with-param>
		                       <xsl:with-param name="search_type">value</xsl:with-param>
		                       <xsl:with-param name="max_length">400</xsl:with-param>
		                       <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		                       <xsl:with-param name="defValByUrl">true</xsl:with-param>
		                       <xsl:with-param name="onchangefn">checkFormatForAddressType()</xsl:with-param>
						   		<!-- caching changes start -->
								<xsl:with-param name="presdata" select="$PresData"/>
								<!-- caching changes end -->
		                   </xsl:call-template>
		               </xsl:template>




		       <xsl:template name="CorporateBO.Address.End_Date">
		                   <xsl:call-template name="label">
		                       <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.End_Date']"/>
		                       <xsl:with-param name="ele_name">CorporateBO.Address.End_Date</xsl:with-param>
		                       <xsl:with-param name="ele_val">CorporateBO.Address.End_Date</xsl:with-param>
		                       <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		                       <xsl:with-param name="disable_val">true</xsl:with-param>
		                       <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
			               <!-- calling the function isGregDate for on blur functionality-->
		                       <xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.Address.End_Date");</xsl:with-param>
		                       <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
		                   </xsl:call-template>
		               </xsl:template>
		              <!--Tracker 78557 Validation for future date-->
		               <xsl:template name="CorporateBO.Address.Start_Date">
		       	            <xsl:call-template name="label">
		       	                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.Start_Date']"/>
		       	                <xsl:with-param name="ele_name">CorporateBO.Address.Start_Date</xsl:with-param>
		       	                <xsl:with-param name="ele_val">CorporateBO.Address.Start_Date</xsl:with-param>
		       	                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
								<!-- Changes done for Ticket ID 278667 on 3/21/2009 -start -->
								<xsl:with-param name="fn_onBlur">validateIssueDate();</xsl:with-param>
								<!-- Changes done for Ticket ID 278667 on 3/21/2009 -end -->
																</xsl:call-template>
		               </xsl:template>


		               <xsl:template name="CorporateBO.Address.city">
		       	            <!-- Converting text box to city lookup-->
		       	            <xsl:call-template name="lookup">
		       		        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.city']"/>
		       		        <xsl:with-param name="elename">CorporateBO.Address.city</xsl:with-param>
		       		        <xsl:with-param name="eleval">CorporateBO.Address.city</xsl:with-param>
		       		        <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					<xsl:with-param name="starshow">true</xsl:with-param>
					<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
					<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>

         		         <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('CITY', 'CorporateBO.Address.city','corp_city_code','CorporateBO.Address.state','CorporateBO.Address.country')</xsl:with-param>
		       	         <xsl:with-param name="buttontwo_fnc">clearLocValue('CorporateBO.Address.city','CITY')</xsl:with-param>

		       		      <!-- <xsl:with-param name="buttonone_fnc">categoryLookupCode('CITY', 'CorporateBO.Address.city','corp_city_code')</xsl:with-param>
		       		        <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.Address.city')</xsl:with-param>-->
		       		        <xsl:with-param name="checkASCII">false</xsl:with-param>
		       	            </xsl:call-template>
		       	        </xsl:template>
						<!-- Equity bank DRC CGCR19 changes start -->
	
	 <xsl:template name="CorporateBO.Address.userField1">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">categoryLookup('REGION', 'CorporateBO.Address.userField1')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.Address.userField1')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel" />
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="elename">CorporateBO.Address.userField1</xsl:with-param>
		<xsl:with-param name="eleval">CorporateBO.Address.userField1</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.userField1']" />
		
	</xsl:call-template>
</xsl:template>
	<!-- Equity bank DRC CGCR19 changes end -->

		       	        <xsl:template name="CorporateBO.Address.country">
		       	        <xsl:call-template name="lookup">
		       	        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.country']"/>
		       	        <xsl:with-param name="elename">CorporateBO.Address.country</xsl:with-param>
		       	        <xsl:with-param name="eleval">CorporateBO.Address.country</xsl:with-param>
		       	        <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		           	 <!-- Field Rationalization changes start-->
				<xsl:with-param name="code_req">true</xsl:with-param>
				<!-- Field Rationalization changes end-->
				<xsl:with-param name="starshow">true</xsl:with-param>

				<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
				<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
         		         <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('COUNTRY', 'CorporateBO.Address.country','corp_cntry_code','CorporateBO.Address.state','CorporateBO.Address.city')</xsl:with-param>
		       	        <xsl:with-param name="buttontwo_fnc">clearLocValue('CorporateBO.Address.country','COUNTRY','CorporateBO.Address.state','CorporateBO.Address.city')</xsl:with-param>

		       	       <!-- <xsl:with-param name="buttonone_fnc">categoryLookupCode('COUNTRY', 'CorporateBO.Address.country','corp_cntry_code')</xsl:with-param>
		       	        <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.Address.country')</xsl:with-param>-->
		       	        <xsl:with-param name="checkASCII">false</xsl:with-param>
		       	        </xsl:call-template>
		       	                </xsl:template>

		                       <xsl:template name="CorporateBO.Address.state">
		       	        <xsl:call-template name="lookup">
		       	        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.state']"/>
		       	        <xsl:with-param name="elename">CorporateBO.Address.state</xsl:with-param>
		       	        <xsl:with-param name="eleval">CorporateBO.Address.state</xsl:with-param>
		       	        <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
				<xsl:with-param name="starshow">true</xsl:with-param>
				<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
				<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
        		         <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('STATE', 'CorporateBO.Address.state','corp_state_code','CorporateBO.Address.city','CorporateBO.Address.country')</xsl:with-param>
		       	        <xsl:with-param name="buttontwo_fnc">clearLocValue('CorporateBO.Address.state','STATE','CorporateBO.Address.city')</xsl:with-param>

		       	        <!--<xsl:with-param name="buttonone_fnc">categoryLookupCode('STATE', 'CorporateBO.Address.state','corp_state_code')</xsl:with-param>
		       	        <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.Address.state')</xsl:with-param>-->

		       	        <xsl:with-param name="checkASCII">false</xsl:with-param>
		       	        </xsl:call-template>
		       	                </xsl:template>


		               <xsl:template name="CorporateBO.Address.zip">
		       		            <xsl:call-template name="label">
		       		                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.zip']"/>
		       		                <xsl:with-param name="ele_name">CorporateBO.Address.zip</xsl:with-param>
		       		                <xsl:with-param name="ele_val">CorporateBO.Address.zip</xsl:with-param>
		       		                <xsl:with-param name="starshow">true</xsl:with-param>
									<!--  Changes For Tracker ID- 155055  -->
									<!-- changes for ticket 315122 start -->
									<!-- Fix for tickte 322406 BEGINS -->
		       		                <xsl:with-param name="fn_onBlur">txtLimit(this,10,"CorporateBO.Address.zip","Zip");fnAutoPopulate('CorporateBO.Address.zip','CorporateBO.Address.city', 'CorporateBO.Address.country','CorporateBO.Address.state','');</xsl:with-param>
		       		                			 <!-- Fix for tickte 322406 ENDS -->
		       		                			<!-- changes for ticket 315122 end -->
									<!--  Changes For Tracker ID- 155055  -->
		       		                 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
						<xsl:with-param name="max_length">10</xsl:with-param>
		       		            </xsl:call-template>
		               </xsl:template>
		               <!-- CHANGES DONE FOR TCKT ID : 247257 -->
		               <xsl:template name="CorporateBO.Address.house_no">
		       			            <xsl:call-template name="label">
		       			                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.house_no']"/>
		       			                <xsl:with-param name="ele_name">CorporateBO.Address.house_no</xsl:with-param>
		       			                <xsl:with-param name="ele_val">CorporateBO.Address.house_no</xsl:with-param>
		       			                <xsl:with-param name="max_length">10</xsl:with-param>
		       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!-- AdressLine changes: START -->
							<xsl:with-param name="max_length">9</xsl:with-param>
<!-- AdressLine changes: END -->
		       			            </xsl:call-template>
		               </xsl:template>
		               <xsl:template name="CorporateBO.Address.premise_name">
		       			            <xsl:call-template name="label">
		       			                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.premise_name']"/>
		       			                <xsl:with-param name="ele_name">CorporateBO.Address.premise_name</xsl:with-param>
		       			                <xsl:with-param name="ele_val">CorporateBO.Address.premise_name</xsl:with-param>
							<xsl:with-param name="max_length">50</xsl:with-param>
							<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
							<xsl:with-param name="checkASCII">false</xsl:with-param>
							<xsl:with-param name="max_length">25</xsl:with-param>
		       			            </xsl:call-template>
		               </xsl:template>

		               <xsl:template name="CorporateBO.Address.building_level">
		       			            <xsl:call-template name="label">
		       			                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.building_level']"/>
		       			                <xsl:with-param name="ele_name">CorporateBO.Address.building_level</xsl:with-param>
		       			                <xsl:with-param name="ele_val">CorporateBO.Address.building_level</xsl:with-param>
		       			                <xsl:with-param name="max_length">10</xsl:with-param>
		       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
							<xsl:with-param name="max_length">9</xsl:with-param>
		       			            </xsl:call-template>
		               </xsl:template>

		               <xsl:template name="CorporateBO.Address.street_no">
		       			            <xsl:call-template name="label">
		       			                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.street_no']"/>
		       			                <xsl:with-param name="ele_name">CorporateBO.Address.street_no</xsl:with-param>
		       			                <xsl:with-param name="ele_val">CorporateBO.Address.street_no</xsl:with-param>
		       			                <xsl:with-param name="max_length">50</xsl:with-param>
		       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
							<xsl:with-param name="max_length">9</xsl:with-param>
		       			            </xsl:call-template>
		               </xsl:template>

		               <xsl:template name="CorporateBO.Address.suburb">
		       			            <xsl:call-template name="label">
		       			                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.suburb']"/>
		       			                <xsl:with-param name="ele_name">CorporateBO.Address.suburb</xsl:with-param>
		       			                <xsl:with-param name="ele_val">CorporateBO.Address.suburb</xsl:with-param>
		       			                <xsl:with-param name="max_length">50</xsl:with-param>
										<xsl:with-param name="checkASCII">false</xsl:with-param>
		       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
							<xsl:with-param name="max_length">19</xsl:with-param>
		       			            </xsl:call-template>
		               </xsl:template>

		               <xsl:template name="CorporateBO.Address.street_name">
		       				    <xsl:call-template name="label">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.street_name']"/>
		       					<xsl:with-param name="ele_name">CorporateBO.Address.street_name</xsl:with-param>
		       					<xsl:with-param name="ele_val">CorporateBO.Address.street_name</xsl:with-param>
		       					<xsl:with-param name="max_length">50</xsl:with-param>
								<xsl:with-param name="checkASCII">false</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
							<xsl:with-param name="max_length">19</xsl:with-param>
		       				    </xsl:call-template>
		               </xsl:template>

		               <xsl:template name="CorporateBO.Address.locality_name">
		       				    <xsl:call-template name="label">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.locality_name']"/>
		       					<xsl:with-param name="ele_name">CorporateBO.Address.locality_name</xsl:with-param>
		       					<xsl:with-param name="ele_val">CorporateBO.Address.locality_name</xsl:with-param>
		       					<xsl:with-param name="max_length">50</xsl:with-param>
								<xsl:with-param name="checkASCII">false</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
							<xsl:with-param name="max_length">15</xsl:with-param>
		       				    </xsl:call-template>
		               </xsl:template>

		               <xsl:template name="CorporateBO.Address.town">
		       				    <xsl:call-template name="label">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.town']"/>
		       					<xsl:with-param name="ele_name">CorporateBO.Address.town</xsl:with-param>
		       					<xsl:with-param name="ele_val">CorporateBO.Address.town</xsl:with-param>
		       					<xsl:with-param name="max_length">50</xsl:with-param>
								<xsl:with-param name="checkASCII">false</xsl:with-param>
							<xsl:with-param name="max_length">25</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       				    </xsl:call-template>
		               </xsl:template>


       				<!-- CIF PhoneEmail Changes Start -->
				<xsl:template name="CorporateBO.Address.FreeTextLabel">
		       				    <xsl:call-template name="label">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.FreeTextLabel']"/>
		       					<xsl:with-param name="ele_name">CorporateBO.Address.FreeTextLabel</xsl:with-param>
		       					<xsl:with-param name="ele_val">CorporateBO.Address.FreeTextLabel</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       				    </xsl:call-template>
		               </xsl:template>


		               <xsl:template name="CorporateBO.Address.HoldMailFlag">
			       	<xsl:call-template name="mdrpdown">
			       		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			       		<xsl:with-param name="presdata" select="$PresData" />
			       		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.HoldMailFlag']" />
			       		<xsl:with-param name="search_type">value</xsl:with-param>
			       		<xsl:with-param name="selectdisp">CorporateBO.Address.HoldMailFlag</xsl:with-param>
			       		<xsl:with-param name="selectname">CorporateBO.Address.HoldMailFlag</xsl:with-param>
			       		<xsl:with-param name="onchangefn">disableEnableHoldMail()</xsl:with-param>

			       	</xsl:call-template>
				</xsl:template>

			       <xsl:template name="CorporateBO.Address.HoldMailInitiatedBy">
		       				    <xsl:call-template name="mdrpdown">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.HoldMailInitiatedBy']"/>
		       					<xsl:with-param name="selectname">CorporateBO.Address.HoldMailInitiatedBy</xsl:with-param>
		       					<xsl:with-param name="selectdisp">CorporateBO.Address.HoldMailInitiatedBy</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
				                        <xsl:with-param name="search_type">value</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					         	<xsl:with-param name="presdata" select="$PresData"/>
		       				    </xsl:call-template>
		               </xsl:template>


			      <xsl:template name="CorporateBO.Address.BusinessCenter">
			      	<xsl:call-template name="lookup">
			      		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			      		<xsl:with-param name="buttonone_fnc">lookupBC('CorporateBO.Address.BusinessCenter')</xsl:with-param>
			      		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			      		<xsl:with-param name="buttontwo_fnc">clearBCValue('CorporateBO.Address.BusinessCenter')</xsl:with-param>
			      		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			      		<xsl:with-param name="elename">CorporateBO.Address.BusinessCenter</xsl:with-param>
			      		<xsl:with-param name="eleval">CorporateBO.Address.BusinessCenter</xsl:with-param>
			      		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.BusinessCenter']"/>
			      		<xsl:with-param name="starshow">true</xsl:with-param>
			      	</xsl:call-template>
</xsl:template>

				<xsl:template name="CorporateBO.Address.HoldMailReason">
		       				    <xsl:call-template name="mtextarea">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.HoldMailReason']"/>
		       					<xsl:with-param name="mname">CorporateBO.Address.HoldMailReason</xsl:with-param>
		       					<xsl:with-param name="mvalue">CorporateBO.Address.HoldMailReason</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
		       					<xsl:with-param name="mcols">50</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       				    </xsl:call-template>
		               </xsl:template>


		               <xsl:template name="CorporateBO.Address.PreferredFormat">
			       	<xsl:call-template name="mdrpdown">
			       		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			       		<xsl:with-param name="onchangefn">disableEnableFreeTextAddress()</xsl:with-param>
			       		<xsl:with-param name="presdata" select="$PresData" />
			       		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.PreferredFormat']" />
			       		<xsl:with-param name="selectdisp">CorporateBO.Address.PreferredFormat</xsl:with-param>
			       		<xsl:with-param name="selectname">CorporateBO.Address.PreferredFormat</xsl:with-param>
			       	</xsl:call-template>
			</xsl:template>
	   		       		<xsl:template name="CorporateBO.Address.LastUpdate_Date">
		       				    <xsl:call-template name="label">
							<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.LastUpdate_Date']"/>
							<xsl:with-param name="ele_name">CorporateBO.Address.LastUpdate_Date</xsl:with-param>
							<xsl:with-param name="ele_val">CorporateBO.Address.LastUpdate_Date</xsl:with-param>
							<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
							<xsl:with-param name="disable_val">true</xsl:with-param>
		       					<!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
							<!-- calling the function isGregDate for on blur functionality-->
		       				<!--	<xsl:with-param name="fn_onBlur">isGregDate("3_LastUpdate_Date");</xsl:with-param> -->
		       				        <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
		       				    </xsl:call-template>
		               </xsl:template>


				<xsl:template name="CorporateBO.Address.Swift_Code">
					<xsl:call-template name="mdrpdown">
						<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.Swift_Code']"/>
						<xsl:with-param name="selectname">CorporateBO.Address.Swift_Code</xsl:with-param>
						<xsl:with-param name="selectdisp">CorporateBO.Address.Swift_Code</xsl:with-param>
						<xsl:with-param name="search_type">value</xsl:with-param>
						<xsl:with-param name="max_length">12</xsl:with-param>
						<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
						<!--<xsl:with-param name="onchangefn">makeDateMand()</xsl:with-param>
						 caching changes start -->
						<xsl:with-param name="presdata" select="$PresData"/>
						<!-- caching changes end -->
					</xsl:call-template>
				</xsl:template>
				<!--WMS Field added-->



			       <xsl:template name="CorporateBO.Address.IsAddressProofRcvd">
		       				    <xsl:call-template name="mdrpdown">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.IsAddressProofRcvd']"/>
		       					<xsl:with-param name="selectname">CorporateBO.Address.IsAddressProofRcvd</xsl:with-param>
		       					<xsl:with-param name="selectdisp">CorporateBO.Address.IsAddressProofRcvd</xsl:with-param>
				                        <xsl:with-param name="search_type">value</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					         	<xsl:with-param name="presdata" select="$PresData"/>
		       				    </xsl:call-template>
		               </xsl:template>

    <xsl:template match="*" mode="mode1">
        <xsl:call-template name="Begin"/>
        <form name="frm2"  method="post" action="">
		<input type="hidden" name="corp_state_code" value=""/>
		<input type="hidden" name="corp_cntry_code" value=""/>
		<input type="hidden" name="corp_city_code" value=""/>
				      

		
<!-- changes for Tracker ID 456637 - TOL ID 455246 -->
		<input type="hidden" name="vAddTypeLT" value=""/>
<!-- changes for Tracker ID 456637 - TOL ID 455246 -->
	<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin-->   
    <xsl:call-template name="Begin" />
	<xsl:if test="normalize-space($IsAddProp)='true'">
		<xsl:call-template name="SearchAddressLabel" />
	</xsl:if>
	<xsl:if test="normalize-space($IsAddProp)='true'">
	<xsl:call-template name="BeginCell" />
		<xsl:call-template name="SearchAddressButton" />
	<xsl:call-template name="EndCell" />
	</xsl:if>
	<xsl:call-template name="End" />
	<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->


                <xsl:call-template name="Begin"/>
                	    <xsl:call-template name="CorporateBO.Address.PreferredFormat"/>
		            <xsl:call-template name="CorporateBO.Address.addressCategory"/>
	        <xsl:call-template name="End"/>

		            <xsl:call-template name="Begin"/>
			    <xsl:call-template name="CorporateBO.Address.house_no"/>
			    <xsl:call-template name="CorporateBO.Address.premise_name"/>
		            <xsl:call-template name="End"/>

		            <xsl:call-template name="Begin"/>
			    <xsl:call-template name="CorporateBO.Address.building_level"/>
			    <xsl:call-template name="CorporateBO.Address.street_no"/>
		            <xsl:call-template name="End"/>


		            <xsl:call-template name="Begin"/>
			    <xsl:call-template name="CorporateBO.Address.suburb"/>
			    <xsl:call-template name="CorporateBO.Address.street_name"/>
		            <xsl:call-template name="End"/>


		            <xsl:call-template name="Begin"/>
			    <xsl:call-template name="CorporateBO.Address.locality_name"/>
			    <xsl:call-template name="CorporateBO.Address.town"/>
		            <xsl:call-template name="End"/>


		            <xsl:call-template name="Begin"/>
		            <xsl:call-template name="CorporateBO.Address.city"/>
		            <xsl:call-template name="CorporateBO.Address.state"/>
		            <xsl:call-template name="End"/>

				
				<!-- Equity bank DRC CGCR19 changes start -->
				<xsl:call-template name="Begin" /> 
					<xsl:call-template name="CorporateBO.Address.userField1" /> 
				<xsl:call-template name="End" />
	 		    <!-- Equity bank DRC CGCR19 changes end -->
						 
		            <xsl:call-template name="Begin"/>
		            <xsl:call-template name="CorporateBO.Address.country"/>
		            <xsl:call-template name="CorporateBO.Address.zip"/>
		            <xsl:call-template name="End"/>


		            <xsl:call-template name="Begin"/>
			    <xsl:call-template name="CorporateBO.Address.Start_Date"/>
			    <xsl:call-template name="CorporateBO.Address.End_Date"/>
		            <xsl:call-template name="End"/>


		         <xsl:call-template name="Begin"/>
				<xsl:call-template name="CorporateBO.Address.IsAddressProofRcvd"/>
				<xsl:call-template name="CorporateBO.Address.LastUpdate_Date"/>
				<xsl:call-template name="End"/>

			 <xsl:call-template name="Begin"/>
						    <xsl:call-template name="apply">
						    <xsl:with-param name="apply_head">
						    <xsl:value-of select="$configLabels[@name='MLHeader1']/@configLabel"/>
						    </xsl:with-param>
						    </xsl:call-template>
                            <xsl:call-template name="End"/>

			    <xsl:call-template name="Begin"/>
			     <xsl:call-template name="CorporateBO.Address.HoldMailFlag"/>
			    <xsl:call-template name="CorporateBO.Address.HoldMailInitiatedBy"/>

			  <xsl:call-template name="End"/>

		            <xsl:call-template name="Begin"/>
		            <xsl:call-template name="CorporateBO.Address.BusinessCenter"/>
			    <xsl:call-template name="CorporateBO.Address.HoldMailReason"/>
			 <xsl:call-template name="End"/>


        </form>
        <xsl:call-template name="End"/>
        </xsl:template>
        <xsl:template match="SRM">
            <xsl:for-each select=".">

                    <table border="0" cellspacing="0" cellpadding="0" width="100%" class="tableborder" vspace="0" hspace="0">
			<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0" class="innertable" width="100%" vspace="0" hspace="0">
			<tr>
			<td>
			<table bgcolor='ffffff' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
			<tr>
				<xsl:call-template name="apply">
                                <xsl:with-param name="apply_head">
                                <b><xsl:value-of select="$configLabels[@name='MLHeader']/@configLabel"/></b>
                                </xsl:with-param>
                            </xsl:call-template>
                       </tr>
		</table>
		<table bgcolor='ffffff' width="100%" border="0" cellspacing="0" cellpadding="2">
			<xsl:apply-templates select="." mode="mode1"/>
		</table>
	</td>
</tr>
</table>
</td>
</tr>
</table>

            </xsl:for-each>
        </xsl:template>
    </xsl:stylesheet>
























