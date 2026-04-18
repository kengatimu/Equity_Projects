<?xml version="1.0" encoding="UTF-8"?>
<!-- **********	This XSL is Regenerated using the XSLWorkBench tool **********@2076863@--> 
<!-- ***************	  Please do not alter this file manually   ***************--> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="../Renderer/common/display/getJVMProperties.xsl"></xsl:import>
<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"></xsl:import>
<xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"></xsl:import>
<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"></xsl:import>
<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin-->
<xsl:import href="../Renderer/common/display/FCRMCommonWidgets.xsl"></xsl:import>
<xsl:param name="locale" />
<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
<xsl:param name="viewname" />
<xsl:variable name="resFile_ML1">../Renderer/Customization/11/corpcif/resource/CorpFreeTxtAddress</xsl:variable>
<xsl:variable name="resConfigFile1" select="document(concat($resFile_ML1,'_',$locale,'.xml'))"/>
<xsl:variable name="configLabels1" select="$resConfigFile1/SRMBO/*"/>

<xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.corpcif.CorpCIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"></xsl:value-of>&amp;amp;amp;Locale=<xsl:value-of select="$locale"></xsl:value-of></xsl:variable>
<xsl:variable name="PreferredAddrFormat" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.PreferredFormat']" />
<xsl:variable name="dtValid" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtValid']" />
<xsl:variable name="dtCurr" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtCurr']" />
<xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']" />
<xsl:variable name="isFormatReadOnly" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsFormatReadOnly']" />
<xsl:variable name="isQuickEdit" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isQuickEdit']" />
<xsl:variable name="entitytype" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entitytype']" />
<xsl:variable name="PresFile" select="document(concat($PresFileName, ''))" />
<xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation" />
<xsl:variable name="locDate"><xsl:value-of select="$dtValid"></xsl:value-of></xsl:variable>
<xsl:variable name="holdMailFlag"><xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.HoldMailFlag']"></xsl:value-of></xsl:variable>
<xsl:variable name="corp_city_code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.city_Code']" />
<xsl:variable name="corp_state_code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.state_Code']" />
<xsl:variable name="corp_cntry_code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.country_Code']" />
<xsl:variable name="AddressID"><xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.addressID']"></xsl:value-of></xsl:variable>
<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin-->
<xsl:variable name="IsAddProp" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsAddProp']" />
<xsl:variable name="IsAddressVerified" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsAddressVerified']" />
<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
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
				var PresData = '<xsl:value-of select="$PresData"></xsl:value-of>';
				var locDate = '<xsl:value-of select="$locDate"></xsl:value-of>';
				var holdMailFlag = '<xsl:value-of select="$holdMailFlag"></xsl:value-of>';
				var corp_city_code = '<xsl:value-of select="$corp_city_code"></xsl:value-of>';
				var viewname = '<xsl:value-of select="$viewname"></xsl:value-of>';
				var corp_state_code = '<xsl:value-of select="$corp_state_code"></xsl:value-of>';
				var corp_cntry_code = '<xsl:value-of select="$corp_cntry_code"></xsl:value-of>';
				var AddressID = '<xsl:value-of select="$AddressID"></xsl:value-of>';
                <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin-->
				var IsAddProp = '<xsl:value-of select="$IsAddProp"></xsl:value-of>';
                var flag_IsAddressVerified = '<xsl:value-of select="$IsAddressVerified"></xsl:value-of>';
				<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
</script>
<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"></xsl:value-of></title>
		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
		<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
		<script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
		<script type="text/javascript" src="../admin/js/AttributeAccess.js" language="javascript"></script>
<!-- Tracker ID Begins : 209607 -->
		<!--Division of js start-->
		<script type="text/javascript" src="../corpcif/js/CorpCIFAddress.js" language="javascript"></script>
		<script type="text/javascript" src="../corpcif/js/CorpCIFAddress_RCL.js" language="javascript"></script>
		<script type="text/javascript" src="../corpcif/js/CorpCIFAddress_Reduced.js" language="javascript"></script>
		<!--Division of js end-->
<!-- Tracker ID Ends : 209607 -->
		<script type="text/javascript" src="../common/html/Rendvalidate.js" language="javascript"></script>
		<script type="text/javascript" src="../corpcif/js/CorpFreeTxtAddress_System.js" language="javascript"></script>
		<script type="text/javascript" src="../corpcif/js/Message_corpcif_{$locale}.js" language="javascript"></script>
		<script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/MLValidate.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/FieldValidate.js" language="javascript"></script>
        <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin-->
		<script type="text/javascript" src="../common/js/SearchAddress.js" language="javascript"></script>
        <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
</head>
<body style="width: 1125px; height: 531px" padding-top="" padding-right="" padding-left="" padding-bottom="">
	<xsl:if test="(normalize-space($readMode)='Y')"> 
		<xsl:attribute name="onload">load();showInReadOnlyMode('<xsl:value-of select="$readMode"></xsl:value-of>');enableClose();</xsl:attribute> 
	</xsl:if>

	<xsl:if test="(not(normalize-space($readMode)='Y'))"> 
		<xsl:attribute name="onload">SetLocCookies();load();</xsl:attribute> 
	</xsl:if>

<table width="100%" vspace="0" hspace="0" cellspacing="0" cellpadding="0" border="0">
<xsl:apply-templates select="SRM"></xsl:apply-templates>
</table>
</body>
</html>
</xsl:template>
<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin-->
<xsl:template name="SearchAddressLabel">
	<xsl:call-template name="simple_label">
		<xsl:with-param name="res_name" select="$configLabels1[@name='SearchAddress']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="SearchAddressButton">
	<xsl:call-template name="user_button">
		<xsl:with-param name="button_fnc">searchAddress()</xsl:with-param>
		<xsl:with-param name="button_name" select="$configLabels1[@name='SEARCH']/@configLabel" />
	</xsl:call-template>
</xsl:template>
<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
<xsl:template name="CorporateBO.Address.PreferredFormat">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="onchangefn">disableEnableFreeTextAddress()</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData" />
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.PreferredFormat']" />
		
		<xsl:with-param name="selectdisp">CorporateBO.Address.PreferredFormat</xsl:with-param>
		<xsl:with-param name="selectname">CorporateBO.Address.PreferredFormat</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.addressCategory">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="defaultValue">true</xsl:with-param>
		<xsl:with-param name="onchangefn">checkFormatForAddressType()</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData" />
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.addressCategory']" />
		
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">CorporateBO.Address.addressCategory</xsl:with-param>
		<xsl:with-param name="selectname">CorporateBO.Address.addressCategory</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.FreeTextLabel">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.Address.FreeTextLabel</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.FreeTextLabel</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.FreeTextLabel']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.Address_Line1">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.Address.Address_Line1</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.Address_Line1</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.Address_Line1']" />
		<!--Changes for 595911 Starts here-->
		<xsl:with-param name="max_length">45</xsl:with-param>
		<!--Changes for 595911 ends here-->
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.Address_Line2">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.Address.Address_Line2</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.Address_Line2</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.Address_Line2']" />
		<!--Changes for 595911 Starts here-->
		<xsl:with-param name="max_length">45</xsl:with-param>
		<!--Changes for 595911 ends here-->
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.Address_Line3">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.Address.Address_Line3</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.Address_Line3</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.Address_Line3']" />
		<!--Changes for 595911 Starts here-->
		<xsl:with-param name="max_length">45</xsl:with-param>
		<!--Changes for 595911 ends here-->
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.city">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('CITY', 'CorporateBO.Address.city','corp_city_code','CorporateBO.Address.state','CorporateBO.Address.country')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels1[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearLocValue('CorporateBO.Address.city','CITY')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels1[@name='CLEAR']/@configLabel" />
		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="elename">CorporateBO.Address.city</xsl:with-param>
		<xsl:with-param name="eleval">CorporateBO.Address.city</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.city']" />
		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.state">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('STATE', 'CorporateBO.Address.state','corp_state_code','CorporateBO.Address.city','CorporateBO.Address.country')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels1[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearLocValue('CorporateBO.Address.state','STATE','CorporateBO.Address.city')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels1[@name='CLEAR']/@configLabel" />
		
		<xsl:with-param name="elename">CorporateBO.Address.state</xsl:with-param>
		<xsl:with-param name="eleval">CorporateBO.Address.state</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.state']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.country">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('COUNTRY', 'CorporateBO.Address.country','corp_cntry_code','CorporateBO.Address.state','CorporateBO.Address.city')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels1[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearLocValue('CorporateBO.Address.country','COUNTRY','CorporateBO.Address.state','CorporateBO.Address.city')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels1[@name='CLEAR']/@configLabel" />
		<!-- Changes for ticket id 636682 Starts -->
                 <!--Changes for 426454 recon of 404109 start here-->
		<xsl:with-param name="checkASCII">false</xsl:with-param>
                       <!--Changes for 426454 recon of 404109 end here-->
		<xsl:with-param name="code_req">true</xsl:with-param>
		<!-- Changes for ticket id 636682 Ends -->
		<xsl:with-param name="elename">CorporateBO.Address.country</xsl:with-param>
		<xsl:with-param name="eleval">CorporateBO.Address.country</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.country']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.zip">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.Address.zip</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.zip</xsl:with-param>
		<xsl:with-param name="fn_onBlur">txtLimit(this,10,"CorporateBO.Address.zip","Zip");fnAutoPopulate('CorporateBO.Address.zip','CorporateBO.Address.city', 'CorporateBO.Address.country','CorporateBO.Address.state','');</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.zip']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.Start_Date">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.Address.Start_Date</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.Start_Date</xsl:with-param>
		<xsl:with-param name="fn_onBlur">validateIssueDate()</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.Start_Date']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.End_Date">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="disable_val">true</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.Address.End_Date</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.End_Date</xsl:with-param>
		<xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.Address.End_Date");</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.End_Date']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.IsAddressProofRcvd">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData" />
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.IsAddressProofRcvd']" />
		
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">CorporateBO.Address.IsAddressProofRcvd</xsl:with-param>
		<xsl:with-param name="selectname">CorporateBO.Address.IsAddressProofRcvd</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="LastUpdate_Date">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="disable_val">true</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.Address.LastUpdate_Date</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.LastUpdate_Date</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='LastUpdate_Date']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.HoldMailFlag">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="onchangefn">disableEnableHoldMail()</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData" />
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.HoldMailFlag']" />
		
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">CorporateBO.Address.HoldMailFlag</xsl:with-param>
		<xsl:with-param name="selectname">CorporateBO.Address.HoldMailFlag</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.HoldMailInitiatedBy">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData" />
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.HoldMailInitiatedBy']" />
		
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">CorporateBO.Address.HoldMailInitiatedBy</xsl:with-param>
		<xsl:with-param name="selectname">CorporateBO.Address.HoldMailInitiatedBy</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.BusinessCenter">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">lookupBC('CorporateBO.Address.BusinessCenter')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels1[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearBCValue('CorporateBO.Address.BusinessCenter')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels1[@name='CLEAR']/@configLabel" />
		
		<xsl:with-param name="elename">CorporateBO.Address.BusinessCenter</xsl:with-param>
		<xsl:with-param name="eleval">CorporateBO.Address.BusinessCenter</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.BusinessCenter']" />
		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.HoldMailReason">
	<xsl:call-template name="mtextarea">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="mcols">50</xsl:with-param>
		<xsl:with-param name="mcolspan">50</xsl:with-param>
		<xsl:with-param name="mname">CorporateBO.Address.HoldMailReason</xsl:with-param>
		<xsl:with-param name="mrows">2</xsl:with-param>
		<xsl:with-param name="mvalue">CorporateBO.Address.HoldMailReason</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels1[@name='CorporateBO.Address.HoldMailReason']" />
		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="Save">
	<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_fnc">saveEduDet()</xsl:with-param>
		<xsl:with-param name="button_name">Save</xsl:with-param>
		<xsl:with-param name="button_text" select="$configLabels1[@name='Save']/@configLabel" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="Close">
	<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_fnc">cancel()</xsl:with-param>
		<xsl:with-param name="button_name">Close</xsl:with-param>
		<xsl:with-param name="button_text" select="$configLabels1[@name='Close']/@configLabel" />
		
	</xsl:call-template>
</xsl:template>

<xsl:template mode="mode1" match="*"><xsl:call-template name="Begin"></xsl:call-template>
<td><form name="frm2" method="post">	<input name="isMCEditedGeneralAdd" res_name_resource="corpcif/resource/CorpFreeTxtAddress" type="hidden" value="N">
	</input>	<input name="corp_state_code" type="hidden">
	</input>	<input name="corp_cntry_code" type="hidden">
	</input>	<input name="corp_city_code" type="hidden">
	</input>
	<xsl:call-template name="Begin" />	<table align="center" bgcolor="E5E5E5" border="0" bordercolor="" cellpadding="0" cellspacing="0" style="border-right-style: double; border-top-color: #D5E0FD; border-bottom-style: double; border-left-style: double; border-top-style: double; border-right-color: #D5E0FD; border-bottom-color: #D5E0FD; border-left-color: #D5E0FD" frame="" hspace="4" id="0"  name="" name_resource="" rules="none" tableheader="" tableheader_resource="" tabpagedisplaynameres="" tabpagedisplaynameres_resource="" templatename="" vspace="0" widget="" width="100%">
	<xsl:call-template name="Begin" />

	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head"><b><xsl:value-of select="$configLabels1[@name='MLHeader']/@configLabel" /></b></xsl:with-param>
		
	</xsl:call-template>
	<!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin-->
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
	<xsl:if test="normalize-space($IsAddProp)='true'">
		<xsl:call-template name="SearchAddressLabel" />
	</xsl:if>
	<xsl:if test="normalize-space($IsAddProp)='true'">
	<xsl:call-template name="BeginCell" />
		<xsl:call-template name="SearchAddressButton" />
	<xsl:call-template name="EndCell" />
	</xsl:if>
    <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.PreferredFormat" />
		<xsl:call-template name="CorporateBO.Address.addressCategory" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.FreeTextLabel" />
		<xsl:call-template name="CorporateBO.Address.Address_Line1" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.Address_Line2" />
		<xsl:call-template name="CorporateBO.Address.Address_Line3" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.city" />
		<xsl:call-template name="CorporateBO.Address.state" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.country" />
		<xsl:call-template name="CorporateBO.Address.zip" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.Start_Date" />
		<xsl:call-template name="CorporateBO.Address.End_Date" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.IsAddressProofRcvd" />
		<xsl:call-template name="LastUpdate_Date" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />

	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head"><b><xsl:value-of select="$configLabels1[@name='MLHeader1']/@configLabel" /></b></xsl:with-param>
		
	</xsl:call-template>

	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.HoldMailFlag" />
		<xsl:call-template name="CorporateBO.Address.HoldMailInitiatedBy" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.BusinessCenter" />
		<xsl:call-template name="CorporateBO.Address.HoldMailReason" />
	<xsl:call-template name="End" />	<table border="0" cellspacing="0" style="" hspace="" id="tableid"  tabborder="0" tbody_id="" vspace="">
	<xsl:call-template name="Begin" />
	<xsl:if test="not(normalize-space($readMode)='Y')">
	<xsl:call-template name="BeginCell" />
		<xsl:call-template name="Save" />
	<xsl:call-template name="EndCell" />
	</xsl:if>
	<xsl:if test="not(normalize-space($readMode)='Y')">
	<xsl:call-template name="BeginCell" />
		<xsl:call-template name="Close" />
	<xsl:call-template name="EndCell" />
	</xsl:if>
	<xsl:if test="normalize-space($readMode)='Y'">
	<xsl:call-template name="BeginCell" />
		<xsl:call-template name="Close" />
	<xsl:call-template name="EndCell" />
	</xsl:if>
	<xsl:call-template name="End" />
	</table>
	</table>
	<xsl:call-template name="End" /></form>
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
