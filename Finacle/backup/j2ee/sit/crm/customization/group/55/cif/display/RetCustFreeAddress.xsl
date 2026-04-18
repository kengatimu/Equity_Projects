<?xml version="1.0" encoding="UTF-8"?>
<!-- **********	This XSL is Regenerated using the XSLWorkBench tool **********@2074904@--> 
<!-- ***************	  Please do not alter this file manually   ***************--> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="../Renderer/common/display/getJVMProperties.xsl"></xsl:import>
<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"></xsl:import>
<xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"></xsl:import>
<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"></xsl:import>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
<xsl:import href="../Renderer/common/display/FCRMCommonWidgets.xsl"></xsl:import><xsl:param name="locale" />
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->

<xsl:param name="viewname" />
<xsl:variable name="resFile_ML1">../Renderer/Customization/55/cif/resource/RetCustFreeAddress</xsl:variable>
<xsl:variable name="resConfigFile1" select="document(concat($resFile_ML1,'_',$locale,'.xml'))"/>
<xsl:variable name="configLabels1" select="$resConfigFile1/SRMBO/*"/>

<xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.CIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"></xsl:value-of>&amp;amp;amp;Locale=<xsl:value-of select="$locale"></xsl:value-of></xsl:variable>
<xsl:variable name="PreferredAddrFormat" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.PreferredFormat']" />
<!--change for callid 389337 begins-->
<xsl:variable name="AddrType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.addressCategory']" />
<!--change for callid 389337 ends-->
<xsl:variable name="dtValid" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtValid']" />
<xsl:variable name="dtCurr" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtCurr']" />
<xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']" />
<xsl:variable name="isFormatReadOnly" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsFormatReadOnly']" />
<xsl:variable name="isQuickEdit" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isQuickEdit']" />
<xsl:variable name="entitytype" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entitytype']" />
<xsl:variable name="PresFile" select="document(concat($PresFileName, ''))" />
<xsl:variable name="locDate"><xsl:value-of select="$dtValid"></xsl:value-of></xsl:variable>
<xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation" />
<xsl:variable name="holdMailFlag"><xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.HoldMailFlag']"></xsl:value-of></xsl:variable>
<xsl:variable name="AddressID"><xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.addressID']"></xsl:value-of></xsl:variable>
<xsl:variable name="cntryCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.country_Code']" />
<xsl:variable name="stateCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.state_Code']" />
<xsl:variable name="cityCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.city_Code']" />
<xsl:variable name="Startdate" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.Start_Date']" />
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
<xsl:variable name="IsAddProp" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsAddProp']" />
<xsl:variable name="IsAddressVerified" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsAddressVerified']" />
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->
 <!-- changes for tracker id 356489 start--> 
<xsl:variable name="defAddress" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='defAddress']"/>
 <!-- changes for tracker id 356489 end--> 

<xsl:variable name="End_date" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.End_Date']" />
<xsl:variable name="LastUpdate_Date" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='LastUpdate_Date']" />
<xsl:template match="/">
<html>
<head>
<script>
var locale = '<xsl:value-of select="$locale"></xsl:value-of>';
				var PresFileName = '<xsl:value-of select="$PresFileName"></xsl:value-of>';
				var PreferredAddrFormat = '<xsl:value-of select="$PreferredAddrFormat"></xsl:value-of>';
				var dtValid = '<xsl:value-of select="$dtValid"></xsl:value-of>';
				var dtCurr = '<xsl:value-of select="$dtCurr"></xsl:value-of>';
				var readMode = '<xsl:value-of select="$readMode"></xsl:value-of>';
				var isFormatReadOnly = '<xsl:value-of select="$isFormatReadOnly"></xsl:value-of>';
				var isQuickEdit = '<xsl:value-of select="$isQuickEdit"></xsl:value-of>';
				var entitytype = '<xsl:value-of select="$entitytype"></xsl:value-of>';
				//Fix for Free Text Address Not saving
				//var PresFile = '<xsl:value-of select="$PresFile"></xsl:value-of>';
				//Fix for Free Text Address Not saving
				var locDate = '<xsl:value-of select="$locDate"></xsl:value-of>';
				var PresData = '<xsl:value-of select="$PresData"></xsl:value-of>';
				var holdMailFlag = '<xsl:value-of select="$holdMailFlag"></xsl:value-of>';
				var AddressID = '<xsl:value-of select="$AddressID"></xsl:value-of>';
				var cntryCode = '<xsl:value-of select="$cntryCode"></xsl:value-of>';
				var stateCode = '<xsl:value-of select="$stateCode"></xsl:value-of>';
				var cityCode = '<xsl:value-of select="$cityCode"></xsl:value-of>';
				var Startdate = '<xsl:value-of select="$Startdate"></xsl:value-of>';
				var viewname = '<xsl:value-of select="$viewname"></xsl:value-of>';
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
				var IsAddProp = '<xsl:value-of select="$IsAddProp"></xsl:value-of>';
				var flag_IsAddressVerified = '<xsl:value-of select="$IsAddressVerified"></xsl:value-of>';
				var vPrefAddrFormat = '<xsl:value-of select="$PreferredAddrFormat"></xsl:value-of>';
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->

				var LastUpdate_Date = '<xsl:value-of select="$LastUpdate_Date"></xsl:value-of>';
				var End_date = '<xsl:value-of select="$End_date"></xsl:value-of>';
				<!-- changes for tracker id 356489 start-->
				var defAddress = '<xsl:value-of select="$defAddress"/>';
				<!-- changes for tracker id 356489 end -->
				<!--change for callid 389337 begins-->
                                var AddrType = '<xsl:value-of select="$AddrType"></xsl:value-of>';
                                <!--change for callid 389337 ends-->
</script>
<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"></xsl:value-of></title>		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
		<script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
		<script type="text/javascript" src="../admin/js/AttributeAccess.js" language="javascript"></script>
		<script type="text/javascript" src="../cif/js/RetCustFreeAddress_System.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/FieldValidate.js" language="javascript"></script>
		<!-- changes for 404 error -->
		<!-- <script type="text/javascript" src="../Customization/js/DemographicEducationDetailsCustom.js" language="javascript"></script> -->
		<!-- changes for 404 error -->
		<script type="text/javascript" src="../cif/js/CIFCustomerAddress.js" language="javascript"></script>
		<!-- Tracker ID 209607 Changes Starts -->
		<script type="text/javascript" src="../cif/js/CIFCustomerAddress_Reduced.js" language="javascript"></script> 
		<!-- Tracker ID 209607 Changes Ends --> 
		<!-- tracker id 356552 Changes and recon for 322106 starts -->
		<script type="text/javascript" language="javascript">
		function validateAddressDates(){ 
			 try{
                             isGregDate("3_AccountBO.Address.Start_Date");			 
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
	        </script>
		<!-- tracker id 356552 Changes and recon for 322106 ends -->

</head>
<body style="width: 1125px; height: 531px" padding-top="" padding-right="" padding-left="" padding-bottom="">
	<xsl:if test="(normalize-space($readMode)='Y')"> 
		<xsl:attribute name="onload">load();enableClose();</xsl:attribute> 
	</xsl:if>

	<xsl:if test="(not(normalize-space($readMode)='Y'))"> 
		<xsl:attribute name="onload">load();</xsl:attribute> 
	</xsl:if>

<table width="100%" vspace="0" hspace="0" cellspacing="0" cellpadding="0" border="0">
<xsl:apply-templates select="SRM"></xsl:apply-templates>
</table>
</body>
</html>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
</xsl:template><xsl:template name="SearchAddressLabel">
	<xsl:call-template name="simple_label">
		<xsl:with-param name="res_name" select="$configLabels1[@name='SearchAddress']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="SearchAddressButton">
	<xsl:call-template name="user_button">
		<xsl:with-param name="button_fnc">searchAddress()</xsl:with-param>
		<xsl:with-param name="button_name" select="$configLabels1[@name='SEARCH']/@configLabel" />
	</xsl:call-template>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->
</xsl:template><xsl:template name="AccountBO.Address.PreferredFormat">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="onchangefn">disableEnableFreeTextAddress()</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData" />
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.PreferredFormat']" />
		
		<xsl:with-param name="selectdisp">AccountBO.Address.PreferredFormat</xsl:with-param>
		<xsl:with-param name="selectname">AccountBO.Address.PreferredFormat</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.addressCategory">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData" />
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.addressCategory']" />
		
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.Address.addressCategory</xsl:with-param>
		<xsl:with-param name="selectname">AccountBO.Address.addressCategory</xsl:with-param>
		<!--changes for call id 440750 begin-->
		<xsl:with-param name="defValByUrl">true</xsl:with-param>
		<!-- changes for tracker id 356489 start-->
		<!--<xsl:with-param name="defaultValue"><xsl:value-of select="$defAddress"/></xsl:with-param>-->
		<!-- changes for tracker id 356489 end-->
		<!--changes for call id 440750 ends-->
		<!-- Changes made for CRM10.2.02Beta Ticket id 322452 :  Begin --> 
		<!-- tracker id 356552 Changes and recon for 322106 starts -->
		<xsl:with-param name="onchangefn">checkFormatForAddressType();validateAddressDates();</xsl:with-param>
		<!-- tracker id 356552 Changes and recon for 322106 ends -->
		<!-- Changes made for CRM10.2.02Beta Ticket id 322452 :  End -->
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.FreeTextLabel">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.Address.FreeTextLabel</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Address.FreeTextLabel</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.FreeTextLabel']" />
		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.address_Line1">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.Address.address_Line1</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Address.address_Line1</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.address_Line1']" />
			<!--Changes for tracker 337080 Starts here-->
		<xsl:with-param name="max_length">45</xsl:with-param>	
		<!--Changes for tracker 337080 ends here-->
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.address_Line2">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.Address.address_Line2</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Address.address_Line2</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.address_Line2']" />
			<!--Changes for tracker 337080 Starts here-->
		<xsl:with-param name="max_length">45</xsl:with-param>	
			<!--Changes for tracker 337080 ends here-->
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.Address_Line3">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.Address.address_Line3</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Address.address_Line3</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.address_Line3']" />
			<!--Changes for tracker 337080 Starts here-->
		<xsl:with-param name="max_length">45</xsl:with-param>
			<!--Changes for tracker 337080 ends here-->
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.city">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('CITY', 'AccountBO.Address.city','city_code','AccountBO.Address.state','AccountBO.Address.country')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels1[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearLocValue('AccountBO.Address.city','CITY')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels1[@name='CLEAR']/@configLabel" />
		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="elename">AccountBO.Address.city</xsl:with-param>
		<xsl:with-param name="eleval">AccountBO.Address.city</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.city']" />
		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.state">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('STATE', 'AccountBO.Address.state','state_code','AccountBO.Address.city','AccountBO.Address.country')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels1[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearLocValue('AccountBO.Address.state','STATE','AccountBO.Address.city')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels1[@name='CLEAR']/@configLabel" />
		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="elename">AccountBO.Address.state</xsl:with-param>
		<xsl:with-param name="eleval">AccountBO.Address.state</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.state']" />
		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.country">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('COUNTRY', 'AccountBO.Address.country','country_code','AccountBO.Address.state','AccountBO.Address.city')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels1[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearLocValue('AccountBO.Address.country','COUNTRY','AccountBO.Address.state','AccountBO.Address.city')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels1[@name='CLEAR']/@configLabel" />
		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="code_req">true</xsl:with-param>
		<xsl:with-param name="elename">AccountBO.Address.country</xsl:with-param>
		<xsl:with-param name="eleval">AccountBO.Address.country</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.country']" />
		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.zip">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.Address.zip</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Address.zip</xsl:with-param>
		<xsl:with-param name="fn_onBlur">txtLimit(this,10,"AccountBO.Address.zip","Zip");fnAutoPopulate('AccountBO.Address.zip','AccountBO.Address.city', 'AccountBO.Address.country','AccountBO.Address.state','');</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.zip']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.Start_Date">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.Address.Start_Date</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Address.Start_Date</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.Start_Date']" />
		<!-- tracker id 356552 Changes and recon for 322106 starts -->
		<xsl:with-param name="fn_onBlur">validateAddressDates();</xsl:with-param>
		<!-- tracker id 356552 Changes and recon for 322106 ends -->
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.End_Date">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="disable_val">true</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.Address.End_Date</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Address.End_Date</xsl:with-param>
		<xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.Address.End_Date");</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.End_Date']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.IsAddressProofRcvd">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData" />
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.IsAddressProofRcvd']" />
		
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.Address.IsAddressProofRcvd</xsl:with-param>
		<xsl:with-param name="selectname">AccountBO.Address.IsAddressProofRcvd</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.LastUpdate_Date">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">AccountBO.Address.LastUpdate_Date</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Address.LastUpdate_Date</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='LastUpdate_Date']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.HoldMailFlag">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="onchangefn">disableEnableHoldMail()</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData" />
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.HoldMailFlag']" />
		
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.Address.HoldMailFlag</xsl:with-param>
		<xsl:with-param name="selectname">AccountBO.Address.HoldMailFlag</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.HoldMailInitiatedBy">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData" />
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.HoldMailInitiatedBy']" />
		
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.Address.HoldMailInitiatedBy</xsl:with-param>
		<xsl:with-param name="selectname">AccountBO.Address.HoldMailInitiatedBy</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.BusinessCenter">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">fnBlurlookupBC('AccountBO.Address.BusinessCenter')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels1[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearBCValue('AccountBO.Address.BusinessCenter')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels1[@name='CLEAR']/@configLabel" />
		
		<xsl:with-param name="elename">AccountBO.Address.BusinessCenter</xsl:with-param>
		<xsl:with-param name="eleval">AccountBO.Address.BusinessCenter</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.BusinessCenter']" />
		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.HoldMailReason">
	<xsl:call-template name="mtextarea">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="mcols">16</xsl:with-param>
		<xsl:with-param name="mcolspan">0</xsl:with-param>
		<xsl:with-param name="mname">AccountBO.Address.HoldMailReason</xsl:with-param>
		<xsl:with-param name="mrows">2</xsl:with-param>
		<xsl:with-param name="mvalue">AccountBO.Address.HoldMailReason</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='AccountBO.Address.HoldMailReason']" />
		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="Close1">
	<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_fnc">cancel()</xsl:with-param>
		<xsl:with-param name="button_name">Close</xsl:with-param>
		<xsl:with-param name="button_text" select="$configLabels1[@name='Close']/@configLabel" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="Save1">
	<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_fnc">saveEduDet()</xsl:with-param>
		<xsl:with-param name="button_name">Save</xsl:with-param>
		<xsl:with-param name="button_text" select="$configLabels1[@name='SAVE']/@configLabel" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="Close2">
	<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_fnc">cancel()</xsl:with-param>
		<xsl:with-param name="button_name">Close</xsl:with-param>
		<xsl:with-param name="button_text" select="$configLabels1[@name='Close']/@configLabel" />
		
	</xsl:call-template>
</xsl:template>

<xsl:template mode="mode1" match="*"><xsl:call-template name="Begin"></xsl:call-template>
<td><form name="frm2" method="post">	<input name="country_code" type="hidden" value="{$cntryCode}">
	</input>	<input name="state_code" type="hidden" value="{$stateCode}">
	</input>	<input name="city_code" type="hidden" value="{$cityCode}">
	<!-- changes for Ticket 701661 begin-->
	</input>	<table align="center" bgcolor="FFFFFF" border="0" cellspacing="0" style="border-right-style: double; border-top-color: #D5E0FD; border-bottom-style: double; border-left-style: double; border-top-style: double; border-right-color: #D5E0FD; border-bottom-color: #D5E0FD; border-left-color: #D5E0FD" hspace="4" id="0"  vspace="0" width="100%">
	<!-- changes for Ticket 701661 ends-->
	<xsl:call-template name="Begin" />

	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head"><b><xsl:value-of select="$configLabels1[@name='Header']/@configLabel" /></b></xsl:with-param>
		
	</xsl:call-template>

	<xsl:call-template name="End" />
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
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.PreferredFormat" />
		<xsl:call-template name="AccountBO.Address.addressCategory" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.FreeTextLabel" />
		<xsl:call-template name="AccountBO.Address.address_Line1" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.address_Line2" />
		<xsl:call-template name="AccountBO.Address.Address_Line3" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.city" />
		<xsl:call-template name="AccountBO.Address.state" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.country" />
		<xsl:call-template name="AccountBO.Address.zip" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.Start_Date" />
		<xsl:call-template name="AccountBO.Address.End_Date" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.IsAddressProofRcvd" />
		<xsl:call-template name="AccountBO.Address.LastUpdate_Date" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />

	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head"><b><xsl:value-of select="$configLabels1[@name='Header']/@configLabel" /></b></xsl:with-param>
		
	</xsl:call-template>

	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.HoldMailFlag" />
		<xsl:call-template name="AccountBO.Address.HoldMailInitiatedBy" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.BusinessCenter" />
		<xsl:call-template name="AccountBO.Address.HoldMailReason" />
	<xsl:call-template name="End" />	
	<table border="0" cellpadding="0" cellspacing="0" style="" hspace="" id="tableid"  tabborder="0" tbody_id="" vspace="">
	<xsl:call-template name="Begin" />
	<!-- ticket id 360220 start-->
		<xsl:choose>
				<xsl:when test="normalize-space($readMode)='Y'">
					<xsl:call-template name="Close2" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="BeginCell" />
				<!--<xsl:call-template name="Close1" />-->
			<xsl:call-template name="Save1" />&#160;
			<xsl:call-template name="Close2" />
			<xsl:call-template name="EndCell" />
		        </xsl:otherwise>
</xsl:choose>
	<!-- tkt 360220 end-->
	<xsl:call-template name="End" />
	</table>
	</table></form>
</td>
<xsl:call-template name="End"></xsl:call-template></xsl:template><xsl:template match="SRM">
<xsl:for-each select=".">
<xsl:call-template name="startTable"></xsl:call-template>
<table width="100%" cellspacing="0" cellpadding="2" border="0">
<xsl:apply-templates select="." mode="mode1"></xsl:apply-templates>
</table>
<xsl:call-template name="endTable"></xsl:call-template>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
