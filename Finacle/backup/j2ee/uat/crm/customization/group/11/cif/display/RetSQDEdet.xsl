<?xml version="1.0"?>
<!-- **********	This XSL is Regenerated using the XSLWorkBench tool **********@2316325@--> 
<!-- ***************	  Please do not alter this file manually   ***************--> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="../Renderer/common/display/getJVMProperties.xsl"></xsl:import>
<xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"></xsl:import>
<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"></xsl:import>
<xsl:param name="locale" />
<xsl:param name="viewname"/>
<xsl:param name="altLocaleActv"/>
<xsl:param name="ALTCALENDAR_TYPE"/>
<xsl:param name="altLocaleType"/>
<xsl:param name="baseLocaleType"/>
<xsl:param name="fileNameID"/>

<xsl:variable name="resFile_ML">../Renderer/Customization/11/cif/resource/RetSQDEdet</xsl:variable>
<xsl:variable name="resConfigFile" select="document(concat($resFile_ML,'_',$locale,'.xml'))"/>      

<xsl:variable name="fileName">../Renderer/cif/resource/RetCustomerQDE_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configLabels" select="$resConfigFile/SRMBO/*"/>
<xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"/>
<xsl:variable name="assignedBackEndID" select="//SRMData//Z[@n=concat($boName,'.BackEndID')]"/>
<xsl:variable name="boDet" select="/SRM/SRMData[@SRMDataSpace='Main']/SRMComposite [@n=$boName]/Z"/>
<xsl:variable name="entityCreflg" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityCreflg']"/>
<xsl:variable name="isCopy" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsCopy']"/>
<xsl:variable name="boNameDemo" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boNameDemo']"/>
<xsl:variable name="boNamePsycho" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boNamePsycho']"/>
<!--<xsl:variable name="docCode_IDType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='docCode_IDType']"/>-->
<xsl:variable name="accountURL" select="//SRMData//Z[@n=concat($boName,'.url_')]"/>
<xsl:variable name="accountID" select="$boDet[@n=concat($boName,'.accountID')]"/>
<xsl:variable name="mainAccId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mainAccId']"/>
<xsl:variable name="customfields" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z"/>
<xsl:variable name="flagRelType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='flagRelType']"/>
<xsl:variable name="ViewName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='productName']"/>
<xsl:variable name="LastUpdate_Date" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='LastUpdate_Date']"/>    
<xsl:variable name="bank_id" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bank_id']"/>
<xsl:variable name="allfields" select="/SRM/SRMData//Z"/>
<xsl:variable name="IsCustDefaulted" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsCustDefaulted']"/>
<xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
<xsl:variable name="locked" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='lockstate']"/>
<xsl:variable name="selectCategory" select="$configLabels[@name='SELECT_CATEGORY']/@configLabel"/>
<xsl:variable name="productCategory" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='productCategory']"/>
<xsl:variable name="ID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ID']"/>
<xsl:variable name="fName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.firstName']"/>
<xsl:variable name="lName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.lastName']"/>
<xsl:variable name="mName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.middleName']"/>
<xsl:variable name="defAddress" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='defAddress']"/>
<!--Changes for call id 399601 and recon of call id 395278 starts-->
<xsl:variable name="preferredAddressType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredAddressType']"/>
<!--Changes for call id 399601 and recon of call id 395278 ends-->
<xsl:variable name="aAllowBlklisted" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='aBlklist']"/>
<xsl:variable name="aAllowNegated" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='aNegated']"/>
<xsl:variable name="aAllowSuspended" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='aSuspend']"/>
<xsl:variable name="globalRM" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='GlobalRM']"/>
<xsl:variable name="operationType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operationType']"/>
<xsl:variable name="segmentValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='segmentValues']"/>
<xsl:variable name="Segment" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.Segmentation_Class')]"/>
<xsl:variable name="cntryCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.country_Code']" />
<!-- changes for tracker id id 361851 starts -->
<xsl:variable name="stateCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='StateCode']" />
<xsl:variable name="cityCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CityCode']" />
<!--<xsl:variable name="Salutation" select="$boDet[@n='Salutation']"/>-->
<!--Changes for call id: 350101 -->
<!--<xsl:variable name="Salutation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Salutation']"></xsl:variable>-->
<xsl:variable name="Salutation"   		select="$boDet[@n=concat($boName,'.Salutation')]"/>
<!--<xsl:variable name="Cat_Salutation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_Salutation']"></xsl:variable>-->
<xsl:variable name="Cat_Salutation" select="$boDet[@n=concat($boName,'.Salutation')]"/>
<!-- changes for call id : 346621 end -->
<!-- changes for call id 350101 ends -->
<xsl:variable name="mode" select="$customfields[@n='mode']"/>
<xsl:variable name="doc_Type" select="$customfields[@n='doc_Type']"/>
<xsl:variable name="docCode" select="$customfields[@n='docCode']"/>
<xsl:variable name="docType_docCode" select="$customfields[@n='docType_docCode']"/>
<xsl:variable name="doc_TypeDesc_Old" select="$customfields[@n='doc_TypeDesc']"/>
<xsl:variable name="docCode_docDesc_Old" select="$customfields[@n='docCode_docDesc']"/>
<xsl:variable name="docCode_CIFType" select="$customfields[@n='docCode_CIFType']"/>
<!--Changes for callId 370280 starts-->
<xsl:variable name="identification_Type" select="$customfields[@n='EntityDocumentBO.IdentificationType']"/>
<!--Changes for callId 370280 ends-->
<xsl:variable name="isAutoGenKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isAutoGenKey']"/>
<xsl:variable name="keyGeneration" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='keyGeneration']" />
<xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.RetCustQDE_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/>&amp;BankId=<xsl:value-of select="$bank_id"/></xsl:variable>
<xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
<xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
<xsl:variable name="SRMTips" select="$configLabels[@name='Tips']/@value"/>
<xsl:variable name="dtValid" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtValid']"/>
<xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"/>
<xsl:variable name="mcJNDIFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mcJNDIFlag']"/>
<xsl:variable name="isMCEdited" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isMCEdited']"/>
<xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"/>
<xsl:variable name="IntWFID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strIntWFID']"/>
<xsl:variable name="MINOR_YEAR" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='minorYear']"/>
<xsl:variable name="docTypeCodeSel" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='EntityDocumentBO.DocTypeCode']"/>
<xsl:variable name="docCodeSel" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='EntityDocumentBO.DocCode']"/>
<xsl:variable name="Nationality" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='DemographicBO.Nationality']"/>
<!-- changes for call id 379878 and recon of call id 379337 starts -->
<xsl:variable name="Nationality_Text" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Nationality_Text']"></xsl:variable>
<!-- changes for call id 379878 and recon of call id 379337 ends -->
<xsl:variable name="currencyCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='currencyCode']"/>
<xsl:variable name="city" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.city']"></xsl:variable>
<xsl:variable name="state" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.state']"></xsl:variable>
<xsl:variable name="country" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Address.country']"></xsl:variable>
<!-- Changes for tracker ID 457939 start -->
<xsl:variable name="manager" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Acc_manager']"/>
<!-- Changes for tracker ID 457939 end -->
<!--  changes for callid 314285 ticket 592422 Tracker 353785 start -->
<!-- changes for call id 381073,recon of call id 379583 starts -->
<xsl:variable name="docCode_IDType" select="$customfields[@n='docCode_IDType']"/>
<!-- changes for call id 381073,recon of call id 379583 ends -->

<xsl:variable name="code_country" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CountryCode']"></xsl:variable>
<!--  changes for call id 314285 ticket 592422 Tracker 353785 end -->
<!-- changes done for ticket id 435934 starts -->
<xsl:variable name="bcName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcName']"></xsl:variable>
<xsl:variable name="Cat_bcName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_bcName']"></xsl:variable>
<!-- changes done for ticket id 435934 ends -->
<!-- changes for 450198-->


<xsl:variable name="Rating" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.Rating')]"/>

<!-- changes for 450198 -->
<xsl:variable name="doc_TypeDesc">
	<xsl:call-template name="replace-string">
		<xsl:with-param name="text" select="$doc_TypeDesc_Old" />
		<xsl:with-param name="from">'</xsl:with-param>
		<xsl:with-param name="to">\'</xsl:with-param>
	</xsl:call-template>
</xsl:variable>
<xsl:variable name="docCode_docDesc">
	<xsl:call-template name="replace-string">
		<xsl:with-param name="text" select="$docCode_docDesc_Old" />
		<xsl:with-param name="from">'</xsl:with-param>
		<xsl:with-param name="to">\'</xsl:with-param>
	</xsl:call-template>
</xsl:variable>

<xsl:template match="/">
<html>
<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"></xsl:value-of></title>
<head>
<script>
                //changes done for ticket id 435934 starts
                var bcName = '<xsl:value-of select="$bcName"/>';
		var Cat_bcName = '<xsl:value-of select="$Cat_bcName"/>';
		//changes done for ticket id 435934 ends
		//changes for 450198
		var Rating = '<xsl:value-of select="$Rating"></xsl:value-of>';
		//changes for 450198
                <!--fix for the ticket 428996 starts-->

		<![CDATA[
			function decodeSpecialCharsXML(strTempArr){

			var re = new RegExp("&amp;", "g");

			strTempArr=strTempArr.replace(re,"&");

			re = new RegExp("&apos;", "g");
			strTempArr=strTempArr.replace(re,"'");

			re = new RegExp("&lt;", "g");
			strTempArr=strTempArr.replace(re,"<");
	
			re = new RegExp("&gt;", "g");
			strTempArr=strTempArr.replace(re,">");

			re = new RegExp("&macr;", "g");
			strTempArr=strTempArr.replace(re,"-");
		
			strTempArr = decodeURIComponent(strTempArr);
		
			return strTempArr;
			}
	     		]]>
	     		<!--fix for the ticket 428996 starts-->
		var nationality = '<xsl:value-of select="$Nationality"/>';
		//changes for call id 379878 and recon of call id 379337 starts
		var nationality_Text = '<xsl:value-of select="$Nationality_Text"/>';
		//changes for call id 379878 and recon of call id 379337 ends
		var city = '<xsl:value-of select="$city"/>';		
		var state = '<xsl:value-of select="$state"/>';
		var country = '<xsl:value-of select="$country"/>';		
		<!--  changes for call id 314285 ticket 592422 Tracker 353785 start -->
		var code_country = '<xsl:value-of select="$code_country"/>';
		<!--  changes for callid 314285 ticket 592422 Tracker 353785 end -->
		var docTypeCodeSel = '<xsl:value-of select="$docTypeCodeSel"/>';
		var docCodeSel = '<xsl:value-of select="$docCodeSel"/>';
    	var readMode = '<xsl:value-of select="$readMode"/>';	
		var lName = '<xsl:value-of select="$lName"/>';
		var mName = '<xsl:value-of select="$mName"/>';
		var fName = '<xsl:value-of select="$fName"/>';
		var defAddress = '<xsl:value-of select="$defAddress"/>';
		//Changes for call id 399601 and recon of call id 395278 starts
		var preferredAddressType = '<xsl:value-of select="$preferredAddressType"/>';
		//Changes for call id 399601 and recon of call id 395278 ends
		var boName = '<xsl:value-of select="$boName" />';
		var boDet = '<xsl:value-of select="$boDet" />';
		var boNameDemo = '<xsl:value-of select="$boNameDemo"/>';
		var boNamePsycho = '<xsl:value-of select="$boNamePsycho"/>';
		<!--Adhar changes for tracker 375136 begin-->
		var docCode_IDType = '<xsl:value-of select="$docCode_IDType"/>';
		<!--Adhar changes for tracker 375136 end-->
		var segment = '<xsl:value-of select="$segmentValues"/>';
		var salutation = '<xsl:value-of select="$Salutation"/>';
		<!-- changes for tracker id id 361851 starts -->
		var cat_salutation = '<xsl:value-of select="$Cat_Salutation"/>';
		<!-- changes for tracker id id 361851 ends -->
		var pres = '<xsl:value-of select="$PresData"/>';
		var cntryCode = '<xsl:value-of select="$cntryCode"/>';
		var stateCode = '<xsl:value-of select="$stateCode"/>';
		var cityCode = '<xsl:value-of select="$cityCode"/>';
		var doc_Type = '<xsl:value-of select="$doc_Type"/>';
        var custURL = '<xsl:value-of select="$accountURL"/>';
		var docCode = '<xsl:value-of select="$docCode"/>';		
		var docCode_CIFType='<xsl:value-of select="$docCode_CIFType"/>';
		var isAutoGenKey = '<xsl:value-of select="$isAutoGenKey"/>';
		var keyGeneration = '<xsl:value-of select="$keyGeneration"/>';
		var locDate = '<xsl:value-of select = "$dtValid"/>';
		var accountURL = '<xsl:value-of select = "$accountURL"/>';
		var appFlag = '<xsl:value-of select="$apprFlag"/>';
		var IntWFID = '<xsl:value-of select="$IntWFID"/>';
		var operationType = '<xsl:value-of select="$operationType"/>';
		var isCopy = '<xsl:value-of select="$isCopy"/>';
		var locale = '<xsl:value-of select="$locale"/>';
		var altLocaleType = '<xsl:value-of select="$altLocaleType"/>';
		var altLocaleActv = '<xsl:value-of select="$altLocaleActv"/>';
		var baseLocaleType = '<xsl:value-of select="$baseLocaleType"/>';
		var defAddress = '<xsl:value-of select="$defAddress"/>';
		var docType_docCode = '<xsl:value-of select="$docType_docCode"/>';
		//changes for call id 367323 starts
		var docCode_IDType='<xsl:value-of select="$docCode_IDType"/>';
		//changes for call id 367323 ends
		var doc_TypeDesc = decodeSpecialCharsXML('<xsl:value-of select="$doc_TypeDesc"/>');
		var docCode_docDesc=decodeSpecialCharsXML('<xsl:value-of select="$docCode_docDesc"/>');	
		<!-- Changes for tracker ID 457939 start -->
		var manager = '<xsl:value-of select="$manager"/>';
		<!-- Changes for tracker ID 457939 end -->
		
</script>

		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
		<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
		<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/SSOUtils.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/ContextSwitch.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
		<script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/SRMFormToggle.js" language="javascript"></script>
		<script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
		<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
		<script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>
		<!--Changes by Niharika for CR356016-->
		<script type="text/javascript" src="../Customization/cif/js/RetSQDEdet_System.js" language="javascript"></script>
		<!--End of changes by Niharika for CR356016-->
		<script type="text/javascript" src="../Customization/cif/js/RetSQDEdet.js" language="javascript"></script>
		<script type="text/javascript" src="../common/html/Rendvalidate.js" language="javascript"></script>
		<script type="text/javascript" src="../Customization/js/AccountCustom.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/WorkFlow.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/Entity_Document.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/SRMFormToggle.js" language="javascript"></script>	
		<script type="text/javascript" src="../Customization/cif/js/CustNameLength.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
		<script type="text/html" src="../Renderer/wizards/html/CifShowButtons.html"></script>
		
<script type="text/javascript">
function custFnLoad()
{
        var bank_id = '<xsl:value-of select="$bank_id"/>';
        document.getElementsByName("custBankId")[0].value = bank_id;
        document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0].disabled = true;
        var ReferenceNumber = getCookie('Filter_uniqueId');
        document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0].value = ReferenceNumber;
}
function validateDate()
{
 isGregDate("3_AccountBO.Address.Start_Date");
}


</script>
</head>
<!-- changes done for ticket id 435934 starts -->
<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 start-->
<body class="popup" onkeypress="onLoadSetTime()" onclick="onLoadSetTime()">

<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 end-->
<xsl:choose>            
<xsl:when test="normalize-space($operationType)='Edit Entity'">
<!-- change for call id 314285 ticket 592422 Tracker 353785 -->
<xsl:attribute name="onload"> populateDocTypeOnLoad();fnLoad();populateCountry();loadrate();</xsl:attribute>
</xsl:when>

<xsl:otherwise>
<xsl:attribute name="onload">fnloadSQDE();custFnLoad();loadprimarysolid();populateDocTypeOnLoad();fnLoad();loadrate();</xsl:attribute>
</xsl:otherwise>
</xsl:choose>
<!-- changes done for ticket id 435934 ends -->
<table width="100%" vspace="0" hspace="0" cellspacing="0" cellpadding="0" border="0">
<xsl:apply-templates select="SRM"></xsl:apply-templates>
</table>
</body></html>
</xsl:template>

<xsl:template name="AccountBO.AccountKey">
	<xsl:choose>
	    <xsl:when test= "normalize-space($keyGeneration)='Reserved' or normalize-space($keyGeneration)='Both' and (normalize-space($accountURL)='' or normalize-space($entityCreflg) = 'N')">
		<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.AccountKey']"/>
			<xsl:with-param name="elename">AccountBO.AccountKey</xsl:with-param>
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.AccountKey</xsl:with-param>
			<xsl:with-param name="buttonone_fnc">openReservation('AccountBO.AccountKey','Retail')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearReservation('AccountBO.AccountKey')</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="fn_onKeyPress">checkKeys()</xsl:with-param>
			<xsl:with-param name="toUpperCase">false</xsl:with-param>
			<xsl:with-param name="fn_onBlur">checkStatus('AccountBO.AccountKey',keyGeneration);txtLimit_CIF(this,"AccountBO.AccountKey","CIF ID");</xsl:with-param>
		 </xsl:call-template>
	    </xsl:when>
	    <xsl:when test= "normalize-space($keyGeneration)='Manual' and (normalize-space($accountURL)=''  or normalize-space($entityCreflg) = 'N')">
	        <xsl:call-template name="label">
		       <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.AccountKey']"/>
		       <xsl:with-param name="selectname">AccountBO.ACCOUNTKEY</xsl:with-param>
		       <xsl:with-param name="selectdisp">AccountBO.AccountKey</xsl:with-param>
		       <xsl:with-param name="ele_name">AccountBO.AccountKey</xsl:with-param>
		       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.AccountKey</xsl:with-param>
		       <xsl:with-param name="starshow">true</xsl:with-param>
		       <xsl:with-param name="fn_onBlur">checkStatus('AccountBO.AccountKey',keyGeneration);txtLimit_CIF(this,"AccountBO.AccountKey","CIF ID");</xsl:with-param>
		       <xsl:with-param name="fn_onKeyPress">checkKeys()</xsl:with-param>
			</xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
			<xsl:call-template name="label">
			    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.AccountKey']"/>
			    <xsl:with-param name="selectname">AccountBO.ACCOUNTKEY</xsl:with-param>
			    <xsl:with-param name="selectdisp">AccountBO.AccountKey</xsl:with-param>
			    <xsl:with-param name="ele_name">AccountBO.AccountKey</xsl:with-param>
			    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.AccountKey</xsl:with-param>
			    <xsl:with-param name="read_val">true</xsl:with-param>
			    <xsl:with-param name="IsMandatory" select="No"/>
			    <xsl:with-param name="starshow">true</xsl:with-param>
			    <xsl:with-param name="fn_onKeyPress">checkKeys()</xsl:with-param>
			    <xsl:with-param name="fn_onBlur">checkStatus('AccountBO.AccountKey',keyGeneration);txtLimit_CIF(this,"AccountBO.AccountKey","CIF ID");</xsl:with-param>
			</xsl:call-template>
	    </xsl:otherwise>
	 </xsl:choose>
</xsl:template>
<!--changes from dropdown to lookup ends-->
<!-- TRACKER:371155:BEGINOFCHANGES -->
<!-- Changes for tracker ID 464809 start -->
<xsl:template name="AccountBO.Salutation">
<xsl:call-template name="lookup">
<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Salutation_code']"/>
<xsl:with-param name="elename">AccountBO.Salutation_code</xsl:with-param>
<xsl:with-param name="eleval">AccountBO.Salutation</xsl:with-param>
<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
<xsl:with-param name="buttonone_fnc">categoryLookup('PERSONSALUTATION', 'AccountBO.Salutation_code')</xsl:with-param>
<xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.Salutation_code')</xsl:with-param>
<xsl:with-param name="checkASCII">false</xsl:with-param>
<xsl:with-param name="code_req">true</xsl:with-param>
</xsl:call-template>
</xsl:template>
<!-- Changes for tracker ID 464809 end -->

        <!-- TRACKER:371155:ENDOFCHANGES -->
<xsl:template name="AccountBO.Cust_First_Name">
	<xsl:call-template name="label">
		  <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_First_Name']"/>
		  <xsl:with-param name="selectname">AccountBO.Cust_First_Name</xsl:with-param>
		  <xsl:with-param name="selectdisp">AccountBO.Cust_First_Name</xsl:with-param>
		  <xsl:with-param name="ele_name">AccountBO.Cust_First_Name</xsl:with-param>		  
		  <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name</xsl:with-param>		
		  <xsl:with-param name="checkASCII">false</xsl:with-param>
          <xsl:with-param name="fn_onBlur">concatName();set_isName(this,true);fnNameLengthSQDE(this);</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Cust_Middle_Name">
	<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Middle_Name']"/>
    	<xsl:with-param name="selectname">AccountBO.Cust_Middle_Name</xsl:with-param>
    	<xsl:with-param name="selectdisp">AccountBO.Cust_Middle_Name</xsl:with-param>
    	<xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name</xsl:with-param>
       	<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name</xsl:with-param>
		<xsl:with-param name="checkASCII">false</xsl:with-param>
   		<xsl:with-param name="fn_onBlur">concatName();set_isName(this,true);fnNameLengthSQDE(this);</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="AccountBO.Cust_Last_Name">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Last_Name']"/>
	    <xsl:with-param name="selectname">AccountBO.Cust_Last_Name</xsl:with-param>
	    <xsl:with-param name="selectdisp">AccountBO.Cust_Last_Name</xsl:with-param>
	    <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name</xsl:with-param>
    	<xsl:with-param name="checkASCII">false</xsl:with-param>
 		<xsl:with-param name="fn_onBlur">concatName();set_isName(this,true);fnNameLengthSQDE(this);</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<!-- Changes by Elango to include start name - START -->
 <xsl:template name="AccountBO.short_name">
    	    <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.short_name']"/>
	        <xsl:with-param name="ele_name">AccountBO.short_name</xsl:with-param>
    	        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_name</xsl:with-param>
    	        <xsl:with-param name="checkASCII">false</xsl:with-param>
    	        <xsl:with-param name="max_length">10</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	    </xsl:call-template>
	</xsl:template>
<!-- Changes by Elango to include start name - END -->
<xsl:template name="AccountBO.Cust_DOB">
	<xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_DOB']"/>
        <xsl:with-param name="selectname">AccountBO.Cust_DOB</xsl:with-param>
        <xsl:with-param name="selectdisp">AccountBO.Cust_DOB</xsl:with-param>
        <xsl:with-param name="ele_name">AccountBO.Cust_DOB</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_DOB</xsl:with-param>
        <xsl:with-param name="fn_onBlur">validateMinorDOB();checkAge();</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="EntityDocumentBO.DocTypeCode">	
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocTypeCode']"/>
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="selectname">EntityDocumentBO.DocTypeCode</xsl:with-param>
		<xsl:with-param name="selectdisp">EntityDocumentBO.DocTypeCode</xsl:with-param>
		<xsl:with-param name="choice_name">EntityDocumentBO.DocTypeCode</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>		
		<xsl:with-param name="onchangefn">loadTypeData(this)</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
		
	</xsl:call-template>			
</xsl:template>
	
<xsl:template name="EntityDocumentBO.DocCode">	 
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocCode']"/>
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="selectname">EntityDocumentBO.DocCode</xsl:with-param>
		<xsl:with-param name="selectdisp">EntityDocumentBO.DocCode</xsl:with-param>				
<!-- Changes for tracker ID 409403 begins -->
		<xsl:with-param name="onchangefn">s_loadDocDesc(this)</xsl:with-param>
<!-- Changes for tracker ID 409403 ends -->
	</xsl:call-template>		
</xsl:template>
<xsl:template name="EntityDocumentBO.DocDescr">
		<xsl:call-template name="mtextarea">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocDescr']"/>
			<xsl:with-param name="mname">EntityDocumentBO.DocDescr</xsl:with-param>
			<xsl:with-param name="mwrap">on</xsl:with-param>
			<xsl:with-param name="mrows">2</xsl:with-param>
			<xsl:with-param name="mcols">20</xsl:with-param>
			<xsl:with-param name="mcolspan">2</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
<xsl:template name="EntityDocumentBO.DocTypeDescr">
		<xsl:call-template name="mtextarea">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocTypeDescr']"/>
			<xsl:with-param name="mname">EntityDocumentBO.DocTypeDescr</xsl:with-param>
			<xsl:with-param name="mwrap">on</xsl:with-param>
			<xsl:with-param name="mrows">2</xsl:with-param>
			<xsl:with-param name="mcols">20</xsl:with-param>
			<xsl:with-param name="mcolspan">2</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	

<xsl:template name="EntityDocumentBO.ReferenceNumber">
	 <xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.ReferenceNumber']"/>
		<xsl:with-param name="ele_name">EntityDocumentBO.ReferenceNumber</xsl:with-param>
		<xsl:with-param name="ele_val">EntityDocumentBO.ReferenceNumber</xsl:with-param>
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="AccountBO.Address.address_Line1">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.Address.address_Line1</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Address.address_Line1</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.address_Line1']" />		
		<!--Changes for tracker 407920 Starts here-->
				<xsl:with-param name="max_length">45</xsl:with-param>	
		<!--Changes for tracker 407920 ends here-->
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.address_Line2">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.Address.address_Line2</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Address.address_Line2</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.address_Line2']" />		
		<!--Changes for tracker 407920 Starts here-->
				<xsl:with-param name="max_length">45</xsl:with-param>	
		<!--Changes for tracker 407920 ends here-->
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.address_Line3">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.Address.address_Line3</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Address.address_Line3</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.address_Line3']" />		
		<!--Changes for tracker 407920 Starts here-->
				<xsl:with-param name="max_length">45</xsl:with-param>	
		<!--Changes for tracker 407920 ends here-->
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.city">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('CITY', 'AccountBO.Address.city','city_code','AccountBO.Address.state','AccountBO.Address.country')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel" />		
		<xsl:with-param name="buttontwo_fnc">clearLocValue('AccountBO.Address.city','CITY')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel" />		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="elename">AccountBO.Address.city</xsl:with-param>
		<xsl:with-param name="eleval">AccountBO.Address.city</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.city']" />		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.state">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('STATE', 'AccountBO.Address.state','state_code','AccountBO.Address.city','AccountBO.Address.country')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel" />		
		<xsl:with-param name="buttontwo_fnc">clearLocValue('AccountBO.Address.state','STATE','AccountBO.Address.city')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel" />		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="elename">AccountBO.Address.state</xsl:with-param>
		<xsl:with-param name="eleval">AccountBO.Address.state</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.state']" />		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.country">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('COUNTRY', 'AccountBO.Address.country','country_code','AccountBO.Address.state','AccountBO.Address.city')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel" />		
		<xsl:with-param name="buttontwo_fnc">clearLocValue('AccountBO.Address.country','COUNTRY','AccountBO.Address.state','AccountBO.Address.city')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel" />		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="code_req">true</xsl:with-param>
		<xsl:with-param name="elename">AccountBO.Address.country</xsl:with-param>
		<xsl:with-param name="eleval">AccountBO.Address.country</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.country']" />		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.zip">
	<xsl:call-template name="label">
    	<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.zip']"/>
        <xsl:with-param name="ele_name">AccountBO.Address.zip</xsl:with-param>
        <xsl:with-param name="ele_val">AccountBO.Address.zip</xsl:with-param>
        <xsl:with-param name="fn_onBlur">txtLimit(this,10,"AccountBO.Address.zip","Zip");fnAutoPopulate('AccountBO.Address.zip','AccountBO.Address.city', 'AccountBO.Address.country','AccountBO.Address.state','');</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
   		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
   	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Address.Start_Date">
	<xsl:call-template name="label">
		<!--Changes for call id 399601 and recon of call id 395278 starts-->
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<!--Changes for call id 399601 and recon of call id 395278 ends-->
		<xsl:with-param name="ele_name">AccountBO.Address.Start_Date</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Address.Start_Date</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.Start_Date']" />		
		<xsl:with-param name="fn_onBlur">validateIssueDate1()</xsl:with-param>
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.PhoneEmail.PhoneEmailType">
	<xsl:call-template name="mdrpdown">
	<!--Changes for Tracker Id 337335 Starts-->
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	<!--Changes for Tracker Id 337335 Ends-->
		<xsl:with-param name="res_name" select="$configLabels[@name='PREFERRED_PHONE']"/>
		<xsl:with-param name="selectname">AccountBO.PhoneEmail.PhoneEmailType</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.PhoneEmail.PhoneEmailType</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
	</xsl:call-template>
</xsl:template>

<xsl:template name="AccountBO.PhoneEmail.PhoneEmailType1">
	<xsl:call-template name="mdrpdown">
	<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='PREFERRED_EMAIL']"/>
		<xsl:with-param name="selectname">AccountBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.PhoneEmail.PhoneNo">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.PhoneEmail.PhoneNo</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.PhoneEmail.PhoneNo</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PhoneEmail.PhoneNo']" />		
		<xsl:with-param name="showphonelabels">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.PhoneEmail.Email">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.PhoneEmail.Email</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.PhoneEmail.Email</xsl:with-param>
		<xsl:with-param name="fn_onBlur">validateEmail(document.getElementsByName('AccountBO.PhoneEmail.Email')[0])</xsl:with-param>
		<xsl:with-param name="isPhoneTemplateFlag">false</xsl:with-param>
		<xsl:with-param name="max_length">50</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PhoneEmail.Email']" />		
		<xsl:with-param name="showphonelabels">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="DemographicBO.Nationality">
	<xsl:call-template name="lookup">
		<xsl:with-param name="buttonone_fnc">categoryLookup('NATIONALITY', 'DemographicBO.Nationality')</xsl:with-param>
		<xsl:with-param name="buttonone_name">LOOKUP</xsl:with-param>
		<xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.Nationality')</xsl:with-param>
		<xsl:with-param name="buttontwo_name">CLEAR</xsl:with-param>
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="code_req">true</xsl:with-param>
		<xsl:with-param name="elename">DemographicBO.Nationality</xsl:with-param>
		<xsl:with-param name="eleval"><xsl:value-of select="$boNameDemo"></xsl:value-of>.Nationality</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.Nationality']" />		
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.CustomerNREFlg">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.CustomerNREFlg']"/>
		<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CustomerNREFlg</xsl:with-param>
	    <xsl:with-param name="selectdisp">AccountBO.CustomerNREFlg</xsl:with-param>				
		<xsl:with-param name="presdata" select="$PresData"/>		          
	    <xsl:with-param name="search_type">value</xsl:with-param>     		     
		<xsl:with-param name="choice_name">AccountBO.CustomerNREFlg</xsl:with-param>     	      	 
	</xsl:call-template>
</xsl:template>
     	
<!--<xsl:template name="DemographicBO.MiscellaneousInfo.strText2">-->
<!--	<xsl:call-template name="mdrpdown">-->
<!--		<xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.StrText2_code']"/>			-->
<!--		<xsl:with-param name="selectname"><xsl:value-of select="$boNameDemo"/>.MiscellaneousInfo.strText2</xsl:with-param>-->
<!--		<xsl:with-param name="selectdisp">DemographicBO.MiscellaneousInfo.strText2</xsl:with-param>-->
<!--		<xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText2</xsl:with-param>-->
<!--		<xsl:with-param name="choice_name">DemographicBO.MiscellaneousInfo.strText2</xsl:with-param>-->
<!--		<xsl:with-param name="checkASCII">false</xsl:with-param>		      -->
<!--        <xsl:with-param name="presdata" select="$PresData"/>-->
<!--	</xsl:call-template>-->
<!--</xsl:template>-->
	<xsl:template name="DemographicBO.MiscellaneousInfo.strText2">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name"	select="$configLabels[@name='DemographicBO.MiscellaneousInfo.StrText2_code']" />
			<xsl:with-param name="selectname">DemographicBO.MiscellaneousInfo.strText2</xsl:with-param>
			<xsl:with-param name="selectdisp">DemographicBO.MiscellaneousInfo.strText2</xsl:with-param>
			<xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText2</xsl:with-param>
			<xsl:with-param name="choice_name">DemographicBO.MiscellaneousInfo.strText2</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData" />
		</xsl:call-template>
	</xsl:template>
	
<xsl:template name="DemographicBO.Employment_Status">
	<xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.Employment_Status']"/>
      	<xsl:with-param name="selectname"><xsl:value-of select="$boNameDemo"/>.Employment_Status</xsl:with-param>
      	<xsl:with-param name="selectdisp">DemographicBO.Employment_Status</xsl:with-param>
      	<xsl:with-param name="ele_name">DemographicBO.Employment_Status</xsl:with-param>
	<xsl:with-param name="choice_name">DemographicBO.Employment_Status</xsl:with-param>		      
        <xsl:with-param name="presdata" select="$PresData"/>
	</xsl:call-template>
</xsl:template>
	 
<xsl:template name="AccountBO.Cust_Language">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Language']"/>
		<xsl:with-param name="selectdisp">AccountBO.Cust_Language</xsl:with-param>
		<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Cust_Language</xsl:with-param>
		<xsl:with-param name="choice_name">AccountBO.Cust_Language</xsl:with-param>
		<xsl:with-param name="max_length">30</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Primary_sol_id">
	<xsl:call-template name="lookup">
		<xsl:with-param name="buttonone_fnc">categoryLookup('SERVICE_OUTLET', 'AccountBO.Primary_sol_id')</xsl:with-param>
		<xsl:with-param name="buttonone_name">LOOKUP</xsl:with-param>
		<xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.Primary_sol_id'),clearM2Mchanges()</xsl:with-param>
		<xsl:with-param name="buttontwo_name">CLEAR</xsl:with-param>
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="elename">AccountBO.Primary_sol_id</xsl:with-param>
		<xsl:with-param name="eleval"><xsl:value-of select="$boName"></xsl:value-of>.Primary_sol_id</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Primary_sol_id']" />		
    <xsl:with-param name="code_req">true</xsl:with-param>     <!-- change for callid 318169 -->
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.StaffEmployeeID">
	<xsl:call-template name="lookup">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StaffEmployeeID']"/>
	 	<xsl:with-param name="elename">AccountBO.StaffEmployeeID</xsl:with-param>		  		 	
	  	<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.StaffEmployeeID</xsl:with-param>		  		 	
	 	<xsl:with-param name="starshow">false</xsl:with-param>
	 	<xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
	 	<xsl:with-param name="buttonone_name">LOOKUP</xsl:with-param>
	 	<xsl:with-param name="buttontwo_name">CLEAR</xsl:with-param>
	 	<xsl:with-param name="buttonone_fnc">openEmployeeIDLookup()</xsl:with-param>
	 	<xsl:with-param name="buttontwo_fnc">clearEmployeeIDLookup();</xsl:with-param>
	 	<xsl:with-param name="checkASCII">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.Rating">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Rating_code']"/>
        <xsl:with-param name="selectdisp">AccountBO.Rating_code</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Rating</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
        <xsl:with-param name="choice_name">AccountBO.Rating_code</xsl:with-param>
        <xsl:with-param name="search_type">url</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.RiskProfileScore">
 	<xsl:call-template name="label">
 		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.RiskProfileScore']"/>
 		<xsl:with-param name="ele_name">AccountBO.RiskProfileScore</xsl:with-param>
 		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.RiskProfileScore</xsl:with-param>
 	</xsl:call-template>
</xsl:template>
<!-- changes for call id 314285 ticket 592422 Tracker 353785 start -->
 <xsl:template name="AccountBO.Segmentation_Class">
 		    		     <xsl:call-template name="lookup">
 		    		     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Segmentation_Class']"/>
 		    		     <xsl:with-param name="elename">AccountBO.Segmentation_Class</xsl:with-param>
 		    		     <xsl:with-param name="eleval">AccountBO.Segmentation_Class</xsl:with-param>
 		    		     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
 		    		     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
 		    		     <xsl:with-param name="buttonone_fnc">categoryLookup('SEGMENTATION_CLASS', 'AccountBO.Segmentation_Class')</xsl:with-param>
 		    		     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.Segmentation_Class')</xsl:with-param>
 		    		     <xsl:with-param name="checkASCII">false</xsl:with-param>
 		    		     <xsl:with-param name="code_req">true</xsl:with-param>
 		    		     </xsl:call-template>
 		    		     </xsl:template>  


<!-- changes for callid 314285 ticket 592422 Tracker 353785 end -->


<xsl:template mode="mode1" match="*">
<form name="frm2" method="post">
	<input type="hidden" name="altLocaleActv" />
	<input type="hidden" value="{$isAutoGenKey}" name="isAutoGenKey"/>
	<input type="hidden" name="salutation_code" value=""/>	
	<input type="hidden" name="Cust_DOB" value=""/>
	<input type="hidden" name="IsCopy" value="{$isCopy}"/>
	<input type="hidden" name="boName" value="{$boName}"/>
	<input type="hidden" name="accountID" value="{$accountID}"/>
    <input type="hidden" name="operationType" value="{$operationType}"/>
    <input type="hidden" name="AdrRemoved" value=""/>
    <input type="hidden" name="AccountBO.Name"/>
    <input type="hidden" name="boNameDemo" value="{$boNameDemo}"/>
    <input type="hidden" name="Nationality_Code" value=""/>
	<input type="hidden" name="saveFlag" value=""/>
	<input type="hidden" name="mainAccId" value=""/>
	<input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
	<input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>
	<input name="country_code" type="hidden" value="{$cntryCode}"/>
	<input name="state_code" type="hidden" value="{$stateCode}"/>
	<input name="city_code" type="hidden" value="{$cityCode}"/>
	<input type="hidden" name="hid_cifid" value=""/>
	<input type="hidden" name="CustomerMinor" value=""/>
	<input type="hidden" name="isMCEditedGeneral" value="N"/>
	<input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
	<input type="hidden" name="address_type" value=""/>
	<input type="hidden" name="country" value=""/>
	<input type="hidden" name="city" value=""/>
	<input type="hidden" name="state" value=""/>
	<input type="hidden" name="start_date" value=""/>
	<input type="hidden" name="zip" value=""/>
	<input type="hidden" name="email" value=""/>
	<input type="hidden" name="core_cust_id" value=""/>
	<input type="hidden" name="{$boName}.Name" value=""/>
	<input type="hidden" name="{$boName}.Gender" value=""/>
	<input type="hidden" name="hid_accountURL" value="{$accountURL}"/>
	<input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
	
	<input type="hidden" name="EntityDocumentBO.DocTypeDescr" value=""/>	
	<input type="hidden" name="EntityDocumentBO.DocDescr" value=""/>	
	<input type="hidden" name="unique_id" value=""/>
	<input type="hidden" name="hidDocTypeCode" value=""/>
	<input type="hidden" name="hidDocCode" value=""/>
	<input type="hidden" name="hidUniqueID" value=""/>
	<!-- Changes for callId 370280 starts -->
	<input type="hidden" name="hidIdentificationType" value="{$identification_Type}"/>
	<!-- Changes for callId 370280 ends -->
	<!-- Changes for Recon:374174 and Call ID:372009 Starts -->
	<input type="hidden" name="hidUniqueIDType" value=""/>
	<!-- //Changes for Recon:374174 and Call ID:372009 Ends -->
	<input type="hidden" name="AddressLine1" value=""/>
	<input type="hidden" name="AddressLine2" value=""/>
	<input type="hidden" name="AddressLine3" value=""/>
	<input type="hidden" name="FreeTextLabel" value=""/>
	<input type="hidden" name="IsAddressProofRcvd" value=""/>
	
	<input type="hidden" name="PhoneEmailType" value=""/>
	<input type="hidden" name="Email" value=""/>
	<input type="hidden" name="PhoneNo" value=""/>
	<input type="hidden" name="PhoneNoCountryCode" value=""/>
	<input type="hidden" name="PhoneNoCityCode" value=""/>
	<input type="hidden" name="PhoneNoLocalCode" value=""/>
	
	<input type="hidden" value="{$MINOR_YEAR}" name="MINOR_YEAR"/>
	<input type="hidden" value="{$currencyCode}" name="currencyCode"/>
	<!--Changes for call id 415849 and recon of callid 414031 STARTS-->
		<input type="hidden" name="hid_reservestatus" value=""/>
	<!--Changes for call id 415849 and recon of callid 414031 ENDS-->
	<input type="hidden" name="apprFlag" value="{$apprFlag}"/>
	
	<input type="hidden" name="IntWFID" value="{$IntWFID}"/>
	<input type="hidden" name="SwiftAddressDetails" value=""/>
	<!-- Changes for tracker ID 457939 start -->
	<input type="hidden" name="manager" value="{$manager}"/>
	<!-- Changes for tracker ID 457939 end -->
	<!-- Change done by Bharath -->
	<input type="hidden" name="custBankId" value="0"/>	
	
<xsl:call-template name="Begin" />
<table width="100%" bgcolor='ffffff' cellspacing="0" vspace="0" hspace="0" border="0">
	<td><xsl:call-template name="Begin" />
		<xsl:call-template name="apply">
			<xsl:with-param name="apply_head"><b><xsl:value-of select="'Basic Details'" /></b></xsl:with-param>
		</xsl:call-template>
	<xsl:call-template name="End" />
	<!-- Changes for tracker ID 456729 start -->
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.AccountKey" />
		<xsl:call-template name="AccountBO.Salutation" />
	<xsl:call-template name="End" />
	<!-- Changes for tracker ID 456729 end -->
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Cust_First_Name" />
		<xsl:call-template name="AccountBO.Cust_Middle_Name" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Cust_Last_Name" />
		 <xsl:call-template name="AccountBO.short_name"/>		
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="EntityDocumentBO.DocTypeCode" />
		<xsl:call-template name="EntityDocumentBO.DocTypeDescr"/>
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="EntityDocumentBO.DocCode" />
		<xsl:call-template name="EntityDocumentBO.DocDescr"/>  
	<xsl:call-template name="End" />	

	<xsl:call-template name="Begin" />
		<xsl:call-template name="EntityDocumentBO.ReferenceNumber" />
		<xsl:call-template name="AccountBO.Cust_DOB" />
		<!--<xsl:call-template name="addemptycell" />-->
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="addemptycell" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="apply">
			<xsl:with-param name="apply_head"><b><xsl:value-of select="'Contact Details'" /></b></xsl:with-param>
		</xsl:call-template>
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.address_Line1" />
		<xsl:call-template name="AccountBO.Address.address_Line2" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.address_Line3" />
		<xsl:call-template name="AccountBO.Address.city" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.state" />
		<xsl:call-template name="AccountBO.Address.country" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Address.zip" />
		<xsl:call-template name="AccountBO.Address.Start_Date" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.PhoneEmail.PhoneEmailType" />
		<xsl:call-template name="AccountBO.PhoneEmail.PhoneNo" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.PhoneEmail.PhoneEmailType1" />
		<xsl:call-template name="AccountBO.PhoneEmail.Email" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="addemptycell" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="apply">
			<xsl:with-param name="apply_head"><b><xsl:value-of select="'Additional CIF Details'" /></b></xsl:with-param>
		</xsl:call-template>
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="DemographicBO.Nationality" />
		<xsl:call-template name="AccountBO.CustomerNREFlg" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText2" />
		<xsl:call-template name="DemographicBO.Employment_Status" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Cust_Language" />
		<xsl:call-template name="AccountBO.Primary_sol_id" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.StaffEmployeeID" />
		<xsl:call-template name="addemptycell" />		
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="addemptycell" />
		<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="apply">
			<xsl:with-param name="apply_head"><b><xsl:value-of select="'Bank Defined CIF Details'" /></b></xsl:with-param>
		</xsl:call-template>
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Rating" />
		<xsl:call-template name="AccountBO.RiskProfileScore" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Segmentation_Class" />
		<xsl:call-template name="addemptycell" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="addemptycell" />	
	<xsl:call-template name="End" /></td>
</table>
<xsl:call-template name="End" />
</form>
<p id="myPar"></p>
<xsl:call-template name="End"></xsl:call-template>


</xsl:template>
<xsl:template match="SRM">
	<xsl:for-each select=".">
		<xsl:call-template name="startTable"></xsl:call-template>
		<table width="100%" vspace="0" hspace="0" cellspacing="0" cellpadding="2" border="0">
		</table>
		<table width="100%" cellspacing="0" cellpadding="2" border="0">
			<xsl:apply-templates select="." mode="mode1"></xsl:apply-templates>
		</table>
		<xsl:call-template name="endTable"></xsl:call-template>
	</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
