<?xml version="1.0"?>
    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
<xsl:import href="../Renderer/common/display/FCRMCommonWidgets.xsl"/>
        <xsl:param name="locale"/>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->
    <xsl:variable name="file1">../Renderer/Customization/11/cif/resource/RetCustAddress_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_1" select="document(concat($file1,''))"/>
    <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
    <xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
 <!-- MAPTT fix:Loading Defalut format Changes:Start  -->
    <xsl:variable name="PreferredAddrFormat" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.PreferredFormat']"/>
  <!-- MAPTT fix:Loading Defalut format Changes:End  -->
    <!--Chanses By Suman for Approval:Start-->
    <xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"/>
    <!--Chanses By Suman for Approval:End-->
    <xsl:variable name="allfields" select="//SRMData//Z"/>
<!-- refCode Changes  -->
	<xsl:variable name="cntryCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.Country_code']"/>
	<xsl:variable name="stateCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.State_code']"/>
	<xsl:variable name="cityCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.City_code']"/>
	<xsl:variable name="dtCurr" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtCurr']"/>
<xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"/>
<xsl:variable name="getRole" select="/SRM/SRMData[@SRMDataSpace='RoleCode']//Z"/>

<!--     CIF PhoneEmail Changes : Start -->
    <xsl:variable name="isFormatReadOnly" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsFormatReadOnly']"/>
<!--     CIF PhoneEmail Changes : End -->
<!-- QED Changes: START -->
<xsl:variable name="isQuickEdit" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isQuickEdit']"/>   
<!-- QED Changes: END -->
<!-- CIF Changes for Caching Views : Start -->
    <xsl:param name="viewname"/>
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.CIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
    <xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
    <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/> 
<!-- CIF Changes for Caching Views : End -->
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
<xsl:variable name="IsAddProp" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsAddProp']" />
<xsl:variable name="IsAddressVerified" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsAddressVerified']" />
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->
    
    <xsl:template match="/">
    <html>
        <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
    <head>
<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>

<script type="text/javascript" src="../common/js/Message_common_{$locale}.js" language="javascript"></script>
    <script>
    var locale = '<xsl:value-of select="$locale"/>';
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
var IsAddProp = '<xsl:value-of select="$IsAddProp"></xsl:value-of>';
var flag_IsAddressVerified = '<xsl:value-of select="$IsAddressVerified"></xsl:value-of>';
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->
    </script>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
    <SCRIPT LANGUAGE='javascript' SRC='../common/js/FieldValidate.js'></SCRIPT>
    <script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
       <script type="text/javascript" src="../admin/js/AttributeAccess.js" language="javascript"></script>
    <!--CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES-->
    <!-- changes for 404 error -->
    <!-- <script type="text/javascript" src="../Customization/js/DemographicEducationDetailsCustom.js" language="javascript"></script> -->   <!-- changes for tracker id 334810-->
    <!-- changes for 404 error -->
    <!--CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES-->
    <!-- CIF PhoneEmail Changes : Start -->
    <script type="text/javascript" src="../cif/js/CIFCustomerAddress.js" language="javascript"></script>
    <!-- Tracker ID 209607 Changes Starts -->
    <script type="text/javascript" src="../cif/js/CIFCustomerAddress_Reduced.js" language="javascript"></script> 
    <!-- Tracker ID 209607 Changes Ends --> 
           
    <!-- CIF PhoneEmail Changes : End -->
    	

<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
		<script type="text/javascript" src="../common/js/SearchAddress.js" language="javascript"></script>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->
 
    
    <script type="text/javascript" language="javascript">
	var AddressID = "";
///////begining of new code inserted by jait//////////////////////////////
	
	
	
	
function load(){

try{
//Changes for Ticket 725047 begin
populateHoldMail(document.getElementsByName("AccountBO.Address.addressCategory")[0].value);
//Changes for Ticket 725047 ends
customLoad();
}catch(e)
{ }
try{
var isQuickEdit='<xsl:value-of select="$isQuickEdit"/>';
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
	if("Y" == flag_IsAddressVerified){
		HouseNo		= document.getElementsByName("AccountBO.Address.house_no")[0].value;
		PremiseName	= document.getElementsByName("AccountBO.Address.premise_name")[0].value;
		BuildingLevel	= document.getElementsByName("AccountBO.Address.building_level")[0].value ;
		StreetNo	= document.getElementsByName("AccountBO.Address.street_no")[0].value ;
		Suburb		= document.getElementsByName("AccountBO.Address.suburb")[0].value ;
		StreetName	= document.getElementsByName("AccountBO.Address.street_name")[0].value ;
		Locality	= document.getElementsByName("AccountBO.Address.locality_name")[0].value ;
		Town		= document.getElementsByName("AccountBO.Address.town")[0].value ;
		City		= document.getElementsByName("Cat_AccountBO.Address.city")[0].value ;
		State		= document.getElementsByName("Cat_AccountBO.Address.state")[0].value ;
		Country		= document.getElementsByName("Cat_AccountBO.Address.country")[0].value ;
		PostalCode	= document.getElementsByName("AccountBO.Address.zip")[0].value ;
	}
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
SetCookie("isQuickEdit",isQuickEdit)
	/*MAPTT fix Start:Loading default value for PreferredFormat*/
	var vPrefAddrFormat='<xsl:value-of select="$PreferredAddrFormat"/>';
	if(vPrefAddrFormat==null || vPrefAddrFormat==''){
		selectDrpDwnValue(document.getElementsByName('AccountBO.Address.PreferredFormat')[0],'STRUCTURED_FORMAT');
	}
	/*MAPTT fix End: Loading default value for PreferredFormat*/
    AddressID = '<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.addressID']"/>';
 /*TRACKER 96605 BEGIN*/
    Startdate = '<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.Start_Date']"/>';  

		if((AddressID == "" || AddressID =='undefined' || AddressID == null) &amp;&amp; (Startdate == "" || Startdate =='undefined' || Startdate == null)){

			var locDate = '<xsl:value-of select="$dtCurr"/>';
			locDate = getCurrentDate();
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To convert start date to hijri - start*/
									
				if(calType=='H')
				{	
					locDate = convertGregToHij(locDate);
				}		
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To convert start date to hijri - END*/
			document.getElementsByName('3_AccountBO.Address.Start_Date')[0].value = locDate;
				
		}
 /*TRACKER 96605 END*/	 
     /* CIF PhoneEmail Changes : Start*/
     
// Tracker 180411 Hold Mail Changes : Begin
         var holdMailFlag = '<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.HoldMailFlag']"/>';
         //Changes for Ticket 725047 begin
         var holdMailChecked  = document.getElementsByName("AccountBO.Address.HoldMailFlag")[0].value;
         if((holdMailFlag==null || holdMailFlag=='') &amp;&amp; holdMailChecked!='Y'){
         //Changes for Ticket 725047 ends
     	   	selectDrpDwnValue(document.getElementsByName('AccountBO.Address.HoldMailFlag')[0],'N');
     	}	    
         /* var holdMailChecked  = document.getElementsByName("AccountBO.Address.HoldMailFlag")[0]; */
         if(holdMailFlag == "Y")
         {
             // holdMailChecked.checked = true;
     	 disableEnableHoldMail();
         }
         else
         {
              //holdMailChecked.checked = false;
     	document.getElementsByName('AccountBO.Address.HoldMailReason')[0].disabled = true;
     	document.getElementsByName('btnone_AccountBO.Address.BusinessCenter')[0].disabled = true;
     	document.getElementsByName('btntwo_AccountBO.Address.BusinessCenter')[0].disabled = true;
     	document.getElementsByName('AccountBO.Address.BusinessCenter')[0].disabled = true;
         	document.getElementsByName('AccountBO.Address.HoldMailInitiatedBy')[0].disabled = true;
     	 disableEnableHoldMail();
         }
         /*if(holdMailChecked.checked == false )
         {
     	document.getElementsByName('AccountBO.Address.HoldMailReason')[0].disabled = true;
     	document.getElementsByName('btnone_AccountBO.Address.BusinessCenter')[0].disabled = true;
     	document.getElementsByName('btntwo_AccountBO.Address.BusinessCenter')[0].disabled = true;
     	document.getElementsByName('AccountBO.Address.BusinessCenter')[0].disabled = true;
         	document.getElementsByName('AccountBO.Address.HoldMailInitiatedBy')[0].disabled = true;
    }*/
// Tracker 180411 Hold Mail Changes : End

     if('<xsl:value-of select="$isFormatReadOnly"/>' == 'Yes')
     {
	document.getElementsByName('AccountBO.Address.PreferredFormat')[0].disabled = true;
     }

     if('<xsl:value-of select="$readMode"/>' != 'Y'){

			if(document.getElementsByName('AccountBO.Address.PreferredFormat')[0].value == "FREE_TEXT_FORMAT")
			{
			disableEnableFreeTextFields(false);
			disableEnableStructuredFields(true);
			}
			else
			{
			disableEnableStructuredFields(false);
			disableEnableFreeTextFields(true);
			}
    }
    else
    {
    	
            document.getElementsByName("AccountBO.Address.HoldMailFlag")[0].disabled=true;
           	
    }
    
    /*CIF PhoneEmail Changes : End */
}catch(e){
}
}
	  
    function setMCAttModifyFlag(){
		document.frm2.isMCEditedGeneralAddress.value="Y";
	}
	    
	    
	    
 function enableClose(){
			try{
				document.getElementsByName("Close")[0].disabled = false;
			}catch(e){
			}
    }
	
function makeDateMand(){   
		if(document.getElementsByName("AccountBO.Address.addressCategory")[0].value == "Work") {
			document.getElementsByName("mandStarAccountBO.Address.WorkExtension")[0].style.visibility="visible";
			document.getElementsByName("AccountBO.Address.WorkExtension")[0].IsMandatory = "true";
			}
			else{
			document.getElementsByName("mandStarAccountBO.Address.WorkExtension")[0].style.visibility="hidden";
			document.getElementsByName("AccountBO.Address.WorkExtension")[0].IsMandatory = "false";
			}
		}
function saveEduDet(){
                
   
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
//changes for callid 460087 starts
var v_city = document.getElementsByName("AccountBO.Address.city")[0].value;
var v_state = document.getElementsByName("AccountBO.Address.state")[0].value;



if(v_city == ""){

				   showMessage(MSG_LOOKUP_INVALID+'City');
				   document.getElementsByName("AccountBO.Address.city")[0].value = "";
				   document.getElementsByName('Cat_AccountBO.Address.city')[0].value = "";
				    return "interactive";
			}
			else if(v_state == ""){

					showMessage(MSG_LOOKUP_INVALID+'State');
					document.getElementsByName('AccountBO.Address.state')[0].value = "";
				   document.getElementsByName('Cat_AccountBO.Address.state')[0].value = "";
					return "interactive";
		}
//changes for callid 460087 ends
try{
var strtDt;
var endDt;
var res;


var ZIP = document.getElementsByName('AccountBO.Address.zip')[0];
      var zip = trim(ZIP.value);
      var res2;
      
      
      //Fix for the Tracker 332769 starts here
// Changes for Tracker Id: 222965 Begin
      	/*	if(isNaN(zip)){
      		                
      				showMessage(MSGJ50161);
      				document.getElementsByName('AccountBO.Address.zip')[0].value =  "";
      				document.getElementsByName('AccountBO.Address.zip')[0].focus();
      				return;
      		} */
// Changes for Tracker Id: 222965 End
      //Fix for the tracker  332769 ends here
	
	
	
strtDt=document.getElementsByName('AccountBO.Address.Start_Date')[0];
endDt=document.getElementsByName('AccountBO.Address.End_Date')[0];
res = Validate_toDate1(strtDt, endDt, true, false);
if (res == false){
//Changes for call id 430311 STARTS
showMessage(getUserErrorMessage ('MSG016', [ strtDt.Display, endDt.Display]));
//Changes for call id 430311 ENDS
return "interactive";
 }
var url;
var res1;
url=document.getElementsByName('AccountBO.Address.URL')[0];
URL = url.value;
res1 = validate_url(url,false,false);
 
if (res1 == false){
 if(URL != ''){
	return "interactive";
	 }
}

var email;
var res2;

	
	
	if (zip.length > 10){
		showMessage(MSGX0059);
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
	
	
	
	

}
catch(e){
}
	
	    AddrDetails[0] = trim(''+document.getElementsByName('AccountBO.Address.addressCategory')[0].value);
            AddrDetails[1] = trim(''+document.getElementsByName('AccountBO.Address.house_no')[0].value);
            AddrDetails[2] = trim(''+document.getElementsByName('AccountBO.Address.premise_name')[0].value);
             <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
           AddrDetails[3] = trim(''+document.getElementsByName('AccountBO.Address.End_Date')[0].value);
            AddrDetails[4] = trim(''+document.getElementsByName('3_AccountBO.Address.Start_Date')[0].value);
            AddrDetails[5] = trim(''+document.getElementsByName('AccountBO.Address.city')[0].value);
            AddrDetails[6] = trim(''+document.getElementsByName('AccountBO.Address.country')[0].value);
            AddrDetails[7] = trim(''+document.getElementsByName('AccountBO.Address.state')[0].value);
            AddrDetails[8] = trim(''+document.getElementsByName('AccountBO.Address.zip')[0].value);
            AddrDetails[9] = trim(''+document.getElementsByName('AccountBO.Address.building_level')[0].value);
            AddrDetails[10]= trim(''+AddressID);
            
            AddrDetails[11] = document.getElementsByName('AccountBO.Address.street_no')[0].value;
	    AddrDetails[12] = document.getElementsByName('AccountBO.Address.locality_name')[0].value;
	    AddrDetails[13] = document.getElementsByName('AccountBO.Address.town')[0].value;
	   // AddrDetails[14] = document.getElementsByName('AccountBO.Address.domicile')[0].value;
	    AddrDetails[15] = document.getElementsByName('AccountBO.Address.street_name')[0].value;
	    AddrDetails[16] = document.getElementsByName('AccountBO.Address.suburb')[0].value;
	    //CORE Fields Inclusion:end
	    //AddrDetails[17] = document.getElementsByName('city_code')[0].value;
	    //AddrDetails[18] = document.getElementsByName('state_code')[0].value;
	    //AddrDetails[19] = document.getElementsByName('country_code')[0].value;
	    AddrDetails[17] = document.getElementsByName('city_code')[0].value;
	    AddrDetails[18] = document.getElementsByName('state_code')[0].value;
	    AddrDetails[19] = document.getElementsByName('country_code')[0].value;
	    //CIF PhoneEmail Changes : Start
	    AddrDetails[20] = document.getElementsByName('AccountBO.Address.PreferredFormat')[0].value;
   	    AddrDetails[21] = document.getElementsByName('AccountBO.Address.HoldMailReason')[0].value;
    	    AddrDetails[22] = document.getElementsByName('AccountBO.Address.BusinessCenter')[0].value;
    	    AddrDetails[23] = document.getElementsByName('AccountBO.Address.HoldMailInitiatedBy')[0].value;
    	    
    	    // Fix for ticket: 247736
    	    AddrDetails[24] = document.getElementsByName('AccountBO.Address.HoldMailFlag')[0].value;
// AdressLine changes: START 
     	    //AddrDetails[25] = document.getElementsByName('AccountBO.Address.AddressLine1')[0].value;
     	   //AddrDetails[26] = document.getElementsByName('AccountBO.Address.AddressLine2')[0].value;
     	    //AddrDetails[27] = document.getElementsByName('AccountBO.Address.AddressLine3')[0].value;
// AdressLine changes: END 
       	    //AddrDetails[28] = document.getElementsByName('AccountBO.Address.FreeTextLabel')[0].value;
	    //AddrDetails[29] = document.getElementsByName('AccountBO.Address.mailStop')[0].value;
	    //AddrDetails[30] = document.getElementsByName('AccountBO.Address.URL')[0].value;
	    AddrDetails[36] = document.getElementsByName('AccountBO.Address.IsAddressProofRcvd')[0].value;
	    
	    // Start of Fix for Ticket:243851  
	    AddrDetails[31] = trim(''+document.getElementsByName('Cat_AccountBO.Address.city')[0].value);
	    AddrDetails[32] = trim(''+document.getElementsByName('Cat_AccountBO.Address.state')[0].value);
	    AddrDetails[33] = trim(''+document.getElementsByName('Cat_AccountBO.Address.country')[0].value);
	    // End of Fix for Ticket:243851  
		AddrDetails[34] = document.getElementsByName('LastUpdate_Date')[0].value;
	    AddrDetails[35] ='Y';
// changes for Tracker ID 456637 - TOL ID 455246
		AddrDetails[43] = trim(''+document.getElementsByName("AccountBO.Address.addressCategory")[0].options[document.getElementsByName("AccountBO.Address.addressCategory")[0].options.selectedIndex].text);
// changes for Tracker ID 456637 - TOL ID 455246
	    //CIF PhoneEmail Changes : End
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
<![CDATA[

	    var City_Val = document.getElementsByName('Cat_AccountBO.Address.city')[0].value;
	    var State_Val = document.getElementsByName('Cat_AccountBO.Address.state')[0].value;
	    var Country_Val = document.getElementsByName('Cat_AccountBO.Address.country')[0].value;
	    if( (HouseNo == AddrDetails[1]) && (PremiseName == AddrDetails[2]) && (City == City_Val) &&
	    	(Country == Country_Val) && (State == State_Val) && (PostalCode == AddrDetails[8]) &&
	    	(BuildingLevel == AddrDetails[9]) && (StreetNo == AddrDetails[11]) && (Locality == AddrDetails[12])
	    	&& (Town == AddrDetails[13]) && (StreetName == AddrDetails[15]) && (Suburb == AddrDetails[16]) ){
		AddrDetails[42] = 'Y';
	    } else{
		 if (IsAddProp == 'true'){
			if ( !this.parent.parent.showConfirmMessage(MSGJ51481)) {
					return;
			}else{
				AddrDetails[42] = 'N';
			}
		} else{
				AddrDetails[42] = '';
		}
	    }
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
// QED Changes: START 
	    
	    var statecode = getCookie("AccountBO.Address.city"+"CITY_ParCode");
	    var countrycode = getCookie("AccountBO.Address.state"+"STE_ParCode");

	    /******Begin of changes ticket id:269054******/ 
	    if(locMapping)
	    {
	    	if(AddrDetails[7] != statecode || AddrDetails[6] != countrycode)
	    	{	
	    		showMessage(MSG_LOC);
	    		return "interactive";
	    	}
	    }
	    /******End of changes ticket id:269054******/ 
	    /*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
	    //if('<xsl:value-of select="$isQuickEdit"/>' == 'Yes')
	    if(getCookie("isQuickEdit") == 'Yes')
	    {
		/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
/*Ticket 294850 Changes : Begin */
		if (top.window.opener.addQuickAddrDetails(AddrDetails,true) == 'true') {
/*Ticket 294850 Changes : End */
			if(document.frm2.isMCEditedGeneralAddress.value=="Y"){
				top.window.opener.setMCAttModifyFlag();
			}
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
	    }
	    else{
	   // alert("in else");
            if (top.window.opener.addAddrDetails(AddrDetails,true) == 'true') {
            //alert("in elsif");
	    					if(document.frm2.isMCEditedGeneralAddress.value=="Y"){
							top.window.opener.setMCAttModifyFlag();
	    					}

/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
						if(null != loadURL && '' != loadURL && 'undefined' != loadURL){
							loadURL.close();
						}
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
					//Changes for Tracker #292776 begin
						top.window.opener.setcheckWinOpen();
					//Changes for Tracker #292776 end
	    					top.window.close();
	    					top.window.opener.focus();
		}
		else{
		top.window.focus();
		}
  	   }	
// QED Changes: END
          
        } catch(e) {
            showUserMessage('MSG106','MSG_WINDOW');
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
		if(null != loadURL && '' != loadURL && 'undefined' != loadURL){
			loadURL.close();
		}
/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
            top.window.close();
        }
        ]]>

    }
    <!-- TRACKER ID 108387 begin changes for close button -->
    
    function cancel(){
    	if ( !this.parent.parent.showConfirmMessage("Are you sure you want to close this operation?")) {
    		return;
	}
        try {
            ProdLookupWindow = null;
            //Changes for Tracker #292776 begin
			//changes for RBS recon TOL 447882
           // top.window.opener.setcheckWinOpen();
			//changes for RBS recon TOL 447882
            //Changes for Tracker #292776 end
            window.close();
            window.opener.focus();
        }catch(e) {
        }
    }
    
    /**********  Changes made for Ticket ID 238235  ************/
    
    /* Changes made for tracker id 169489 Begin */
	function validateIssueFutureDate(){
	
    /* Changes made for tracker id 169489 End */
	        
	        		/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
	    		/* calling the function isGregDate for on blur functionality*/
	               	isGregDate("3_AccountBO.Address.Start_Date");
	               	/* ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/	
	           		
	           				
	           		var todaydate = new String();
	           		todaydate.value = getTodayDate(); 

	           		
	           		/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
	    		/* calling the function isGregDate for on blur functionality*/
	    		var date = document.getElementsByName("3_AccountBO.Address.Start_Date")[0];
	    				if (date.value != '')
	                    {
	    		
	    		todaydate.value = convertDate(todaydate.value);

	    		}
	    		/* ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/
	           		
	           		elem1 = document.getElementsByName("3_AccountBO.Address.Start_Date")[0];
	           		var mill1 = changetoMillis(todaydate.value);
	           		var mill2 = changetoMillis(elem1.value); 

	           		/* Changes made for tracker id 169489 Begin */
	           		
	           		/*if (mill2 &gt; mill1){
	           			showMessage(MSGX0026);
	           			elem1.value = "";                                    
	           		}*/
	           		
	           		/* Changes made for tracker id 169489 End */
	           			
	} 
	/* changes for ticket 592441 n recon for TOL 320266 starts */
	function validateAddressDates(){ 
	         try{
	             var vStartDate = document.getElementsByName("3_AccountBO.Address.Start_Date")[0];
		     var vEndDate= document.getElementsByName("AccountBO.Address.End_Date")[0];
		     if(vEndDate.value!=''){
			var millStartDate = changetoMillis(vStartDate.value);
		        var millEndDate = changetoMillis(vEndDate.value);			   
		        if (millEndDate &lt; millStartDate){
			    //showMessage(MSGJ0114);
			    document.getElementsByName('AccountBO.Address.End_Date')[0].value =  "";
      			    //document.getElementsByName('AccountBO.Address.Start_Date')[0].focus();
			}
	             }
	          }catch(e){}
	
       }
	/* changes for ticket 592441 n recon for TOL 320266 ends */

    
    
     <!-- TRACKER ID 108387 end changes for close button -->
     
     
    <!-- Fix for tickte 322406 BEGINS -->
    function SetLocCookies(){
     //alert("inside SetLocCookies");
     		onLoadSetLocCookies('AccountBO.Address.city','AccountBO.Address.state','AccountBO.Address.country');
	}
	
    <!-- Fix for tickte 322406 ENDS -->
    
    function enableClose(){
		try{
			document.getElementsByName("Close")[0].disabled = false;
		}catch(e){
		}
    }
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
/*************************************************************************************
* This function auto populates the fields selecting any record in address results
*************************************************************************************/
function populateAddrResults(addressResults){
	try{
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
		document.getElementsByName("AccountBO.Address.city")[0].value = '';
		document.getElementsByName("AccountBO.Address.state")[0].value = '';
		document.getElementsByName("AccountBO.Address.country")[0].value = '';
		//Setting cookies for city,state and country
		setLocCookies(City,State,Country,"CITY",'AccountBO.Address.city','AccountBO.Address.state','AccountBO.Address.country');
		setLocCookies(State,Country,null,"STATE",'','AccountBO.Address.state','AccountBO.Address.country');
		setLocCookies(Country,null,null,"COUNTRY",'','','AccountBO.Address.country');

		// Setting into the values of the widgets
		document.getElementsByName("AccountBO.Address.house_no")[0].value = HouseNo;
		document.getElementsByName("AccountBO.Address.premise_name")[0].value = PremiseName;
		document.getElementsByName("AccountBO.Address.building_level")[0].value = BuildingLevel;
		document.getElementsByName("AccountBO.Address.street_no")[0].value = StreetNo;
		document.getElementsByName("AccountBO.Address.suburb")[0].value = Suburb;
		document.getElementsByName("AccountBO.Address.street_name")[0].value = StreetName;
		document.getElementsByName("AccountBO.Address.locality_name")[0].value = Locality;
		document.getElementsByName("AccountBO.Address.town")[0].value = Town;
		document.getElementsByName("Cat_AccountBO.Address.city")[0].value = City;
		document.getElementsByName("Cat_AccountBO.Address.state")[0].value = State;
		document.getElementsByName("Cat_AccountBO.Address.country")[0].value = Country;
		document.getElementsByName("AccountBO.Address.zip")[0].value = PostalCode;



		// Validation for lookups Just focus and remove focus
		document.getElementsByName("Cat_AccountBO.Address.city")[0].focus();
		document.getElementsByName("Cat_AccountBO.Address.state")[0].focus();
		document.getElementsByName("Cat_AccountBO.Address.country")[0].focus();
		document.getElementsByName("SAVE")[0].focus();
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
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->

    </script>
    </head>
    <body class="popup">
    <xsl:choose>
		<xsl:when test="normalize-space($readMode)='Y'">
			<xsl:attribute name="onload">load();showInReadOnlyMode('<xsl:value-of select="$readMode"/>');enableClose();</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="onload">load();SetLocCookies();</xsl:attribute>
		</xsl:otherwise>
    </xsl:choose>
       <table class="tableborder" width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
              <td>
       	<table border="0" cellspacing="0" cellpadding="0" class="innertable" width="100%" vspace="0" hspace="0">
       		<tr>	
       
       		<xsl:apply-templates select="SRM"/>
       		</tr>
       	</table>
              </td>
       
              </tr>
        </table>
        <table class="background" width="100%" cellpadding="0" cellspacing="0" border="0"  align="center">
		<xsl:choose>
			<xsl:when test="normalize-space($readMode)='Y'">
				<xsl:call-template name="user_button">
					<xsl:with-param name="button_name">Close</xsl:with-param>
					<xsl:with-param name="button_fnc">cancel()</xsl:with-param>
				</xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
		        <xsl:call-template name="user_button">
		            <xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='SAVE']/@configLabel"/></xsl:with-param>
		            <xsl:with-param name="button_fnc">saveEduDet()</xsl:with-param>
		        </xsl:call-template>&#160;
		        <xsl:call-template name="user_button">
			<!--TRACKER ID 108387 begin changes for close button --> 
		            <xsl:with-param name="button_name">Close<xsl:value-of select="$configLabels[@name='CLOSE']/@configLabel"/></xsl:with-param>
		            <xsl:with-param name="button_fnc">cancel()</xsl:with-param>
		   <!-- TRACKER ID 108387 end changes -->      
		        </xsl:call-template>
			</xsl:otherwise>
    	</xsl:choose>
        </table>
    </body>
    </html>
    </xsl:template>
                       <!-- cif -->
		       
		       <xsl:template name="AccountBO.Address.addressCategory">
		                   <xsl:call-template name="mdrpdown">
		                       <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.addressCategory']"/>
		                       <xsl:with-param name="selectname">AccountBO.Address.addressCategory</xsl:with-param>
		                       <xsl:with-param name="selectdisp">AccountBO.Address.addressCategory</xsl:with-param>
		                       <xsl:with-param name="search_type">value</xsl:with-param>
		                       <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		                       <xsl:with-param name="defValByUrl">true</xsl:with-param>
		                       <!-- changes for ticket 592441 n recon for TOL 320266 starts -->
		                       <xsl:with-param name="onchangefn">checkFormatForAddressType();validateAddressDates();</xsl:with-param>
		                       <!-- changes for ticket 592441 n recon for TOL 320266 ends -->
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>                
	<!-- CIF Changes for Caching Views : End -->
		                   </xsl:call-template>
		               </xsl:template>
		               
		             
		               
		               
		       <xsl:template name="AccountBO.Address.End_Date">
		                   <xsl:call-template name="label">
		                       <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.End_Date']"/>
		                       <xsl:with-param name="ele_name">AccountBO.Address.End_Date</xsl:with-param>
		                       <xsl:with-param name="ele_val">AccountBO.Address.End_Date</xsl:with-param>
		                       <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		                       <xsl:with-param name="disable_val">true</xsl:with-param>
		                       <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		                       <!-- calling the function isGregDate for on blur functionality-->
		                       <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.Address.End_Date");</xsl:with-param>
		                       <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
		                   </xsl:call-template>
		               </xsl:template>
		               
		               
		               <!--  Changes made for Ticket ID 238235  -->
		               
		               
		               
			<xsl:template name="AccountBO.Address.Start_Date">
						    <xsl:call-template name="label">
							<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.Start_Date']"/>
							<xsl:with-param name="ele_name">AccountBO.Address.Start_Date</xsl:with-param>
							<xsl:with-param name="ele_val">AccountBO.Address.Start_Date</xsl:with-param>
							<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
							<!-- Changes made for tracker id 169489 Begin -->
							<!-- changes for ticket 592441 n recon for TOL 320266 starts -->
							<xsl:with-param name="fn_onBlur">validateIssueFutureDate();validateAddressDates();</xsl:with-param>
							<!-- changes for ticket 592441 n recon for TOL 320266 ends -->
							<!-- Changes made for tracker id 169489 End -->
							</xsl:call-template>
					       </xsl:template>




		               
		               <!--  Changes made for Ticket ID 238235  -->
		               
		                       
		               <xsl:template name="AccountBO.Address.city">
		       	            <!-- Converting text box to city lookup-->
		       	            <xsl:call-template name="lookup">
		       		        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.city']"/>
		       		        <xsl:with-param name="elename">AccountBO.Address.city</xsl:with-param>
		       		        <xsl:with-param name="eleval">AccountBO.Address.city</xsl:with-param>
					<xsl:with-param name="starshow">true</xsl:with-param>
		       		        <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       		        <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		       		 	<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>

         		         
         		           <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('CITY', 'AccountBO.Address.city','city_code','AccountBO.Address.state','AccountBO.Address.country')</xsl:with-param>
		       		       <xsl:with-param name="buttontwo_fnc">clearLocValue('AccountBO.Address.city','CITY')</xsl:with-param>
         		         
         		         <!-- <xsl:with-param name="buttonone_fnc">categoryLookupCode('CITY', 'AccountBO.Address.city','city_code')</xsl:with-param>-->
  		         
		       		        <!--<xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.Address.city')</xsl:with-param>-->
 
		       		        <xsl:with-param name="checkASCII">false</xsl:with-param>
		       	            </xsl:call-template>
				<input type="hidden" name="city_code" value="{$cityCode}"/>
		       	        </xsl:template>
		       	
		       	        <xsl:template name="AccountBO.Address.country">
		       	        <xsl:call-template name="lookup">
		       	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.country']"/>
		       	        <xsl:with-param name="elename">AccountBO.Address.country</xsl:with-param>
		       	        <xsl:with-param name="eleval">AccountBO.Address.country</xsl:with-param>
				<xsl:with-param name="starshow">true</xsl:with-param>
		       	        <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		             	<!-- Field Rationalization changes start-->
        			<xsl:with-param name="code_req">true</xsl:with-param>
       				 <!-- Field Rationalization changes end-->        
		       	        <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		       	      <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>

         		         
         		         <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('COUNTRY', 'AccountBO.Address.country','country_code','AccountBO.Address.state','AccountBO.Address.city')</xsl:with-param>
		       	        <xsl:with-param name="buttontwo_fnc">clearLocValue('AccountBO.Address.country','COUNTRY','AccountBO.Address.state','AccountBO.Address.city')</xsl:with-param>
		       	        <!-- <xsl:with-param name="buttonone_fnc">categoryLookupCode('COUNTRY', 'AccountBO.Address.country','country_code')</xsl:with-param>-->
		       	        <!--<xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.Address.country')</xsl:with-param>-->
						
		       	        <xsl:with-param name="checkASCII">false</xsl:with-param>
		       	        </xsl:call-template>
				<input type="hidden" name="country_code" value="{$cntryCode}"/>
	       	                </xsl:template>
       
	                       <xsl:template name="AccountBO.Address.state">
		       	        <xsl:call-template name="lookup">
		       	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.state']"/>
		       	        <xsl:with-param name="elename">AccountBO.Address.state</xsl:with-param>
		       	        <xsl:with-param name="eleval">AccountBO.Address.state</xsl:with-param>
				<xsl:with-param name="starshow">true</xsl:with-param>
		       	        <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       	        <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		       	       	<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>


         		         
         		         <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('STATE', 'AccountBO.Address.state','state_code','AccountBO.Address.city','AccountBO.Address.country')</xsl:with-param>
		       	        <xsl:with-param name="buttontwo_fnc">clearLocValue('AccountBO.Address.state','STATE','AccountBO.Address.city')</xsl:with-param>
         		         <!-- <xsl:with-param name="buttonone_fnc">categoryLookupCode('STATE', 'AccountBO.Address.state','state_code')</xsl:with-param> -->
		       	        <!-- <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.Address.state')</xsl:with-param>-->
		       	        <xsl:with-param name="checkASCII">false</xsl:with-param>
		       	        </xsl:call-template>
				<input type="hidden" name="state_code" value="{$stateCode}"/>
	       	                </xsl:template>
		               
		                      
		               <xsl:template name="AccountBO.Address.zip">
		       		            <xsl:call-template name="label">
		       		                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.zip']"/>
		       		                <xsl:with-param name="ele_name">AccountBO.Address.zip</xsl:with-param>
		       		                <xsl:with-param name="ele_val">AccountBO.Address.zip</xsl:with-param>
		       		                <!-- changes for ticket 315122 start -->
		       		                 <!-- Fix for tickte 322406 BEGINS -->
		       		                <xsl:with-param name="fn_onBlur">txtLimit(this,10,"AccountBO.Address.zip","Zip");fnAutoPopulate('AccountBO.Address.zip','AccountBO.Address.city', 'AccountBO.Address.country','AccountBO.Address.state','');</xsl:with-param>
		       		                <!-- Fix for tickte 322406 ENDS -->
		       		                <!-- changes for ticket 315122 end -->
						<xsl:with-param name="starshow">true</xsl:with-param>
		       		                 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       		            </xsl:call-template>
		               </xsl:template>
		               
		               <xsl:template name="AccountBO.Address.house_no">
		       			            <xsl:call-template name="label">
		       			                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.house_no']"/>
		       			                <xsl:with-param name="ele_name">AccountBO.Address.house_no</xsl:with-param>
		       			                <xsl:with-param name="ele_val">AccountBO.Address.house_no</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
<!-- AdressLine changes: START -->							
							<xsl:with-param name="max_length">9</xsl:with-param>
<!-- AdressLine changes: END -->
		       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       			            </xsl:call-template>
		               </xsl:template>
		               <xsl:template name="AccountBO.Address.premise_name">
		       			            <xsl:call-template name="label">
		       			                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.premise_name']"/>
		       			                <xsl:with-param name="ele_name">AccountBO.Address.premise_name</xsl:with-param>
		       			                <xsl:with-param name="ele_val">AccountBO.Address.premise_name</xsl:with-param>
										<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- AdressLine changes: START -->							
							<xsl:with-param name="max_length">25</xsl:with-param>
<!-- AdressLine changes: END -->
		       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       			            </xsl:call-template>
		               </xsl:template>
		               
		               <xsl:template name="AccountBO.Address.building_level">
		       			            <xsl:call-template name="label">
		       			                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.building_level']"/>
		       			                <xsl:with-param name="ele_name">AccountBO.Address.building_level</xsl:with-param>
		       			                <xsl:with-param name="ele_val">AccountBO.Address.building_level</xsl:with-param>
		       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!-- AdressLine changes: START -->							
							<xsl:with-param name="max_length">9</xsl:with-param>
<!-- AdressLine changes: END -->
		       			            </xsl:call-template>
		               </xsl:template>
		               
		               <xsl:template name="AccountBO.Address.street_no">
		       			            <xsl:call-template name="label">
		       			                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.street_no']"/>
		       			                <xsl:with-param name="ele_name">AccountBO.Address.street_no</xsl:with-param>
		       			                <xsl:with-param name="ele_val">AccountBO.Address.street_no</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
		       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!-- AdressLine changes: START -->							
							<xsl:with-param name="max_length">9</xsl:with-param>
<!-- AdressLine changes: END -->
		       			            </xsl:call-template>
		               </xsl:template>
		               
		               <xsl:template name="AccountBO.Address.suburb">
		       			            <xsl:call-template name="label">
		       			                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.suburb']"/>
		       			                <xsl:with-param name="ele_name">AccountBO.Address.suburb</xsl:with-param>
		       			                <xsl:with-param name="ele_val">AccountBO.Address.suburb</xsl:with-param>
										<xsl:with-param name="checkASCII">false</xsl:with-param>
		       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!-- AdressLine changes: START -->							
							<xsl:with-param name="max_length">19</xsl:with-param>
<!-- AdressLine changes: END -->
		       			            </xsl:call-template>
		               </xsl:template>
		               
		               <xsl:template name="AccountBO.Address.street_name">
		       				    <xsl:call-template name="label">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.street_name']"/>
		       					<xsl:with-param name="ele_name">AccountBO.Address.street_name</xsl:with-param>
		       					<xsl:with-param name="ele_val">AccountBO.Address.street_name</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
<!-- AdressLine changes: START -->							
<!--Tracker 167673 changes -->						
							<!--call id 595911 changes -->	
							<xsl:with-param name="max_length">19</xsl:with-param>
							<!--call id 595911 changes -->	
<!-- AdressLine changes: END -->
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       				    </xsl:call-template>
		               </xsl:template>
		               
		               <xsl:template name="AccountBO.Address.locality_name">
		       				    <xsl:call-template name="label">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.locality_name']"/>
		       					<xsl:with-param name="ele_name">AccountBO.Address.locality_name</xsl:with-param>
		       					<xsl:with-param name="ele_val">AccountBO.Address.locality_name</xsl:with-param>
								<xsl:with-param name="checkASCII">false</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!-- AdressLine changes: START -->							
							<xsl:with-param name="max_length">15</xsl:with-param>
<!-- AdressLine changes: END -->
		       				    </xsl:call-template>
		               </xsl:template>
		               
		               <xsl:template name="AccountBO.Address.town">
		       				    <xsl:call-template name="label">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.town']"/>
		       					<xsl:with-param name="ele_name">AccountBO.Address.town</xsl:with-param>
		       					<xsl:with-param name="ele_val">AccountBO.Address.town</xsl:with-param>
								<xsl:with-param name="checkASCII">false</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!-- AdressLine changes: START -->							
							<xsl:with-param name="max_length">25</xsl:with-param>
<!-- AdressLine changes: END -->
		       				    </xsl:call-template>
		               </xsl:template>
		               
	
				<!-- CIF PhoneEmail Changes Start -->
				<xsl:template name="AccountBO.Address.FreeTextLabel">
		       				    <xsl:call-template name="label">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.FreeTextLabel']"/>
		       					<xsl:with-param name="ele_name">AccountBO.Address.FreeTextLabel</xsl:with-param>
		       					<xsl:with-param name="ele_val">AccountBO.Address.FreeTextLabel</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       				    </xsl:call-template>
		               </xsl:template>
<!-- AdressLine changes: START -->		               
				<xsl:template name="AccountBO.Address.AddressLine1">
		       				    <xsl:call-template name="label">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.address_Line1']"/>
		       					<xsl:with-param name="ele_name">AccountBO.Address.AddressLine1</xsl:with-param>
		       					<xsl:with-param name="ele_val">AccountBO.Address.address_Line1</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
		       					<xsl:with-param name="mcols">50</xsl:with-param>
							<xsl:with-param name="max_length">45</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       				    </xsl:call-template>
		               </xsl:template>
				<xsl:template name="AccountBO.Address.AddressLine2">
		       				    <xsl:call-template name="label">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.address_Line2']"/>
		       					<xsl:with-param name="ele_name">AccountBO.Address.AddressLine2</xsl:with-param>
		       					<xsl:with-param name="ele_val">AccountBO.Address.address_Line2</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
		       					<xsl:with-param name="mcols">50</xsl:with-param>
							<xsl:with-param name="max_length">45</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       				    </xsl:call-template>
		               </xsl:template>
			       <xsl:template name="AccountBO.Address.AddressLine3">
		       				    <xsl:call-template name="label">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.address_Line3']"/>
		       					<xsl:with-param name="ele_name">AccountBO.Address.AddressLine3</xsl:with-param>
		       					<xsl:with-param name="ele_val">AccountBO.Address.address_Line3</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
		       					<xsl:with-param name="mcols">50</xsl:with-param>
							<xsl:with-param name="max_length">45</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       				    </xsl:call-template>
		               </xsl:template>
<!-- AdressLine changes: END -->
			       <xsl:template name="AccountBO.Address.HoldMailFlag">
		       				    <xsl:call-template name="mdrpdown">
		       				    	<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       				    	<xsl:with-param name="presdata" select="$PresData" />
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.HoldMailFlag']"/>
		       					<xsl:with-param name="search_type">value</xsl:with-param>
							<xsl:with-param name="selectdisp">AccountBO.Address.HoldMailFlag</xsl:with-param>
							<xsl:with-param name="selectname">AccountBO.Address.HoldMailFlag</xsl:with-param>
							<xsl:with-param name="onchangefn">disableEnableHoldMail()</xsl:with-param>
		       					
		       					<!--<xsl:with-param name="name">AccountBO.Address.HoldMailFlag</xsl:with-param>
		       					<xsl:with-param name="checkbox_val">false</xsl:with-param>
						        <xsl:with-param name="fncname">disableEnableHoldMail()</xsl:with-param>
		       					-->
		       				    </xsl:call-template>
		               </xsl:template>
		               
			       <xsl:template name="AccountBO.Address.HoldMailInitiatedBy">
		       				    <xsl:call-template name="mdrpdown">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.HoldMailInitiatedBy']"/>
		       					<xsl:with-param name="selectname">AccountBO.Address.HoldMailInitiatedBy</xsl:with-param>
		       					<xsl:with-param name="selectdisp">AccountBO.Address.HoldMailInitiatedBy</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
				                        <xsl:with-param name="search_type">value</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					         	<xsl:with-param name="presdata" select="$PresData"/>                
		       				    </xsl:call-template>
		               </xsl:template>
		               
			       <xsl:template name="AccountBO.Address.BusinessCenter">
		       				    <xsl:call-template name="lookup">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.BusinessCenter']"/>
		       					<xsl:with-param name="elename">AccountBO.Address.BusinessCenter</xsl:with-param>
		       					<xsl:with-param name="eleval">AccountBO.Address.BusinessCenter</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
				       		        <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
				       		 	<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
				       		 	
				       	                <!--113276 changes start -->
	 	
						        <xsl:with-param name="buttonone_fnc">fnBlurlookupBC('AccountBO.Address.BusinessCenter')</xsl:with-param>
						        
						        <!--113276 changes end -->

				       		        <xsl:with-param name="buttontwo_fnc">clearBCValue('AccountBO.Address.BusinessCenter')</xsl:with-param>
		       				    </xsl:call-template>
		               </xsl:template>
		               
				<xsl:template name="AccountBO.Address.HoldMailReason">
		       				    <xsl:call-template name="mtextarea">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.HoldMailReason']"/>
		       					<xsl:with-param name="mname">AccountBO.Address.HoldMailReason</xsl:with-param>
		       					<xsl:with-param name="mvalue">AccountBO.Address.HoldMailReason</xsl:with-param>
							<xsl:with-param name="starshow">true</xsl:with-param>
		       					<xsl:with-param name="mcols">50</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       				    </xsl:call-template>
		               </xsl:template>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
<xsl:template name="SearchAddressLabel">
	<xsl:call-template name="simple_label">
		<xsl:with-param name="res_name" select="$configLabels[@name='SearchAddress']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="SearchAddressButton">
	<xsl:call-template name="user_button">
		<xsl:with-param name="button_fnc">searchAddress()</xsl:with-param>
		<xsl:with-param name="button_name" select="$configLabels[@name='SEARCH']/@configLabel" />
	</xsl:call-template>
</xsl:template>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->
		               
			       <xsl:template name="AccountBO.Address.PreferredFormat">
		       				    <xsl:call-template name="mdrpdown">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.PreferredFormat']"/>
		       					<xsl:with-param name="selectname">AccountBO.Address.PreferredFormat</xsl:with-param>
		       					<xsl:with-param name="selectdisp">AccountBO.Address.PreferredFormat</xsl:with-param>
				                        <xsl:with-param name="search_type">value</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
				                        <xsl:with-param name="onchangefn">disableEnableFreeTextAddress()</xsl:with-param>
					         	<xsl:with-param name="presdata" select="$PresData"/>                
		       				    </xsl:call-template>
		               </xsl:template>
		               
		 
		                <xsl:template name="LastUpdate_Date">
			       		       	            <xsl:call-template name="label">
			       		       	                <xsl:with-param name="res_name" select="$configLabels[@name='LastUpdate_Date']"/>
			       		       	                <xsl:with-param name="ele_name">LastUpdate_Date</xsl:with-param>
			       		       	                <xsl:with-param name="ele_val">LastUpdate_Date</xsl:with-param>
			       		       	                <xsl:with-param name="disable_val">true</xsl:with-param>
			       		       	                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			       		       	                <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
			       		       	                <!-- calling the function isGregDate for on blur functionality-->
			       		       	                <xsl:with-param name="fn_onBlur">isGregDate("3_LastUpdate_Date");</xsl:with-param>
			       		       	            <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
			       		       	            </xsl:call-template>
		               </xsl:template>
				<xsl:template name="AccountBO.Address.URL">
						    <xsl:call-template name="label">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.URL']"/>
		       					<xsl:with-param name="ele_name">AccountBO.Address.URL</xsl:with-param>
		       					<xsl:with-param name="ele_val">AccountBO.Address.URL</xsl:with-param>
							<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
						    </xsl:call-template>
		               </xsl:template>
				<!-- CIF PhoneEmail Changes End -->
<!--WMS Field additions start-->
			       <xsl:template name="AccountBO.Address.IsAddressProofRcvd">
		       				    <xsl:call-template name="mdrpdown">
		       					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.IsAddressProofRcvd']"/>
		       					<xsl:with-param name="selectname">AccountBO.Address.IsAddressProofRcvd</xsl:with-param>
		       					<xsl:with-param name="selectdisp">AccountBO.Address.IsAddressProofRcvd</xsl:with-param>
				                        <xsl:with-param name="search_type">value</xsl:with-param>
		       					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					         	<xsl:with-param name="presdata" select="$PresData"/>                
		       				    </xsl:call-template>
		               </xsl:template>
<!--WMS Field additions end-->
		               
    <xsl:template match="*" mode="mode1">
        <xsl:call-template name="Begin"/>
        <form name="frm2"  method="post" action="">
        	<input type="hidden" name="apprFlag" value="{$apprFlag}"/>
        	<input type="hidden" name="isMCEditedGeneralAddress" value="N"/>
        	<input type="hidden" name="mainAccId" value=""/>
<!-- changes for Tracker ID 456637 - TOL ID 455246 -->
			<input type="hidden" name="vAddTypeLT" value=""/>
<!-- changes for Tracker ID 456637 - TOL ID 455246 -->
        			<!-- Change for DBS ticket 325152 -->
        			<input type="hidden" name="SwiftAddressDetails" value=""/>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
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
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->
                	<xsl:call-template name="Begin"/>
                	    <xsl:call-template name="AccountBO.Address.PreferredFormat"/>
		            <xsl:call-template name="AccountBO.Address.addressCategory"/>
		         <xsl:call-template name="End"/>
		            
		            <xsl:call-template name="Begin"/>
			    <xsl:call-template name="AccountBO.Address.house_no"/>
			    <xsl:call-template name="AccountBO.Address.premise_name"/>
		            <xsl:call-template name="End"/>
		            
		            <xsl:call-template name="Begin"/>
			    <xsl:call-template name="AccountBO.Address.building_level"/>
			    <xsl:call-template name="AccountBO.Address.street_no"/>
		            <xsl:call-template name="End"/>
		            
		            
		            <xsl:call-template name="Begin"/>
			    <xsl:call-template name="AccountBO.Address.suburb"/>
			    <xsl:call-template name="AccountBO.Address.street_name"/>
		            <xsl:call-template name="End"/>
		            
		            
		            <xsl:call-template name="Begin"/>
			    <xsl:call-template name="AccountBO.Address.locality_name"/>
			    <xsl:call-template name="AccountBO.Address.town"/>
		            <xsl:call-template name="End"/>
		            
		            
		            <xsl:call-template name="Begin"/>
		            <xsl:call-template name="AccountBO.Address.city"/>
		            <xsl:call-template name="AccountBO.Address.state"/>
		            <xsl:call-template name="End"/> 
		            
		          <!-- TRACKER# 92380 START-->  
		            <xsl:call-template name="Begin"/>
		            <xsl:call-template name="AccountBO.Address.country"/>
		            <xsl:call-template name="AccountBO.Address.zip"/>
		            <xsl:call-template name="End"/> 
		            
		        
		            <xsl:call-template name="Begin"/>
			    	<xsl:call-template name="AccountBO.Address.Start_Date"/>
			    	<xsl:call-template name="AccountBO.Address.End_Date"/>
			    <xsl:call-template name="End"/>
			    
		            <xsl:call-template name="Begin"/>
		             <xsl:call-template name="AccountBO.Address.IsAddressProofRcvd"/>  
			    <xsl:call-template name="LastUpdate_Date"/>
			  
			    <xsl:call-template name="End"/>		
		     
		             <xsl:call-template name="Begin"/>
			    <xsl:call-template name="apply">
			    <xsl:with-param name="apply_head">
			     <xsl:value-of select="$configLabels[@name='MLHeader1']/@configLabel"/>
			    </xsl:with-param>
			    </xsl:call-template>
                            <xsl:call-template name="End"/>
		            
		              <xsl:call-template name="Begin"/>
			      <xsl:call-template name="AccountBO.Address.HoldMailFlag"/>  
			      <xsl:call-template name="AccountBO.Address.HoldMailInitiatedBy"/>                                
			     <xsl:call-template name="End"/>

			    <xsl:call-template name="Begin"/>
			    <xsl:call-template name="AccountBO.Address.BusinessCenter"/> 
			    <xsl:call-template name="AccountBO.Address.HoldMailReason"/>                                
			    <xsl:call-template name="End"/>

                           
        </form>
        <xsl:call-template name="End"/>
        </xsl:template>
        <xsl:template match="SRM">
            <xsl:for-each select=".">
                <xsl:call-template name="startTable"/>
                    <table bgcolor='FFFFFF' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
                        <tr>
                            <xsl:call-template name="apply">
                                <xsl:with-param name="apply_head">
                                <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
                                </xsl:with-param>
                            </xsl:call-template>
                        </tr>
                    </table>
                    <table bgcolor='FFFFFF' width="100%" border="0" cellspacing="0" cellpadding="2">
                        <xsl:apply-templates select="." mode="mode1"/>
                    </table>
                <xsl:call-template name="endTable"/>
            </xsl:for-each>
        </xsl:template>
    </xsl:stylesheet>


























