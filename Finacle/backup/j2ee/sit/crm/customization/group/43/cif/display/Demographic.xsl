<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--impoting variables wich hold the jvm properties-->
<!--IDENTIFICATION DOCUMENT CHANGES start changed to relative url-->
    <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
<!--commented for IDENTIFICATION DOCUMENT CHANGES start
    <xsl:import href="../Renderer/common/display/CustomerUniqueID.xsl"/>
commented for IDENTIFICATION DOCUMENT CHANGES end-->
    <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
<!--IDENTIFICATION DOCUMENT CHANGES end-->

<!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
	<xsl:param name="ALTCALENDAR_TYPE"/>
<!--ERPBOCF1:TRACKER113259: STORAGE OF DATES :ENDOFCHANGES-->

        <xsl:param name="locale"/>
        <!--tracker id 113227 starts-->
        <xsl:param name="altLocaleType"/>
	<xsl:param name="baseLocaleType"/>
        <xsl:param name="altLocaleActv"/>
        <!--tracker id 113227 ends-->
        <!--CRM10.2ST:TrackerID:161298 Begin of Change-->
        <xsl:param name="currency"/>
        <!--CRM10.2ST:TrackerID:161298 End of Change-->
		<xsl:variable name="file1">../Renderer/cif/resource/DemographicContactInfo_<xsl:value-of select="$locale"/>.xml</xsl:variable>
		 <!-- Tracker ID :756914 - Chrome Porting Changes -->
    <xsl:variable name="file1XML" select="substring-before(substring-after($file1,'resource/'),'.xml')"/>
<xsl:variable name="configFile_1" select="SRM"/>
    <xsl:variable name="configLabels_1" select="$configFile_1/SRMBO/ResourceFile[@filename=$file1XML]/*"/>
     <xsl:variable name="SRMTips" select="$configLabels_1[@name='Tips']/@value"/>
    <xsl:variable name="fileName2">../../../Renderer/cif/resource/DemographicEducationQualification_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <xsl:variable name="file2">../Renderer/cif/resource/DemographicEducationQualification_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <xsl:variable name="file2XML" select="substring-before(substring-after($file2,'resource/'),'.xml')"/>
<xsl:variable name="configFile_2" select="SRM"/>
    <xsl:variable name="configLabels_2" select="$configFile_2/SRMBO/ResourceFile[@filename=$file2XML]/*"/>
<!-- Alternate BANKING CHANGES Starts-->
<xsl:variable name="file3">../Renderer/cif/resource/DemographicIncomeAndExpense_<xsl:value-of select="$locale"/><xsl:value-of select="$islamicResourceFileSuffix"/>.xml</xsl:variable>
<!-- Alternate BANKING CHANGES Ends-->
<xsl:variable name="file3XML" select="substring-before(substring-after($file3,'resource/'),'.xml')"/>
<xsl:variable name="configFile_3" select="SRM"/>
    <xsl:variable name="configLabels_3" select="$configFile_3/SRMBO/ResourceFile[@filename=$file3XML]/*"/>
    <xsl:variable name="file4">../Renderer/cif/resource/DemographicEmploymentDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <xsl:variable name="file4XML" select="substring-before(substring-after($file4,'resource/'),'.xml')"/>
<xsl:variable name="configFile_4" select="SRM"/>
    <xsl:variable name="configLabels_4" select="$configFile_4/SRMBO/ResourceFile[@filename=$file4XML]/*"/>
    <xsl:variable name="file5">../Renderer/Customization/43/cif/resource/DemographicOtherDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <xsl:variable name="file5XML" select="substring-before(substring-after($file5,'resource/'),'.xml')"/>
<xsl:variable name="configFile_5" select="SRM"/>
    <xsl:variable name="configLabels_5" select="$configFile_5/SRMBO/ResourceFile[@filename=$file5XML]/*"/>
    <xsl:variable name="file6">../Renderer/cif/resource/DemographicEmploymentDetails_Mod_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <xsl:variable name="file6XML" select="substring-before(substring-after($file6,'resource/'),'.xml')"/>
<xsl:variable name="configFile_6" select="SRM"/>
    <xsl:variable name="configLabels_6" select="$configFile_5/SRMBO/ResourceFile[@filename=$file6XML]/*"/>
    <xsl:variable name="file7">../Renderer/common/resource/TabMessage_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <xsl:variable name="file7XML" select="substring-before(substring-after($file7,'resource/'),'.xml')"/>
<xsl:variable name="configFile_7" select="SRM"/>
    <xsl:variable name="configLabels_7" select="$configFile_7/SRMBO/ResourceFile[@filename=$file7XML]/*"/>

<!-- Alternate BANKING CHANGES Starts-->
<xsl:variable name="islamicResourceFileSuffix" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='islamicResourceFileSuffix']"></xsl:variable>
<!-- Alternate BANKING CHANGES Ends-->

<!-- CIF Changes - EmploymentHistory MultiRec Start -->
    <xsl:variable name="fileName">../../../Renderer/cif/resource/ListOfEmploymentHistory_Details_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!-- CIF Changes - EmploymentHistory MultiRec End -->
<!--CIF LOS Bypass change:Start-->
 <xsl:variable name="byPassFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='byPassFlag']"></xsl:variable>
<!--CIF LOS Bypass change:End-->
    <xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"></xsl:variable>
    <xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"></xsl:variable>
    <xsl:variable name="operationType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operationType']"></xsl:variable>
<!--IDENTIFICATION DOCUMENT CHANGES start-->
	<xsl:param name="fileNameID"/>
	<xsl:variable name="configFileID" select="document(concat($fileNameID,''))"/>
	<xsl:variable name="configLabelsID" select="$configFileID/SRMBO/*"/>
<xsl:variable name="custNREFlg" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='custNREFlg']"></xsl:variable>
<!--IDENTIFICATION DOCUMENT CHANGES end-->
    <xsl:variable name="allfields" select="//SRMData//Z"/>
    <xsl:variable name="concurDetectX" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n=concat($boName,'.ConcurDetect_X')]"></xsl:variable>
    <xsl:variable name="NRECountryType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n=concat($boName,'.NRECountryType')]"></xsl:variable>
    <xsl:variable name="demographicID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n=concat($boName,'.DemographicID')]"></xsl:variable>
    <xsl:variable name="Type" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Type']"></xsl:variable>
     <!-- Tracker 63031-Begin of changes  -->
      <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
     <xsl:variable name="AccessOwnerGroup" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccessOwnerGroup']"></xsl:variable>
      <!-- Tracker ID : 90197 End of Changes -->
    <xsl:variable name="acctID" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.AccountID')]"></xsl:variable>
    <xsl:variable name="suspID" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.SuspectID')]"></xsl:variable>
    <xsl:variable name="contID" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.ContactID')]"></xsl:variable>
     <!-- Tracker 63031-End of changes  -->
    <xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
 <!-- CIF Changes : variable for Copy : START-->
    <xsl:variable name="isCopy" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsCopy']"></xsl:variable>
 <!-- CIF Changes : variable for Copy : END-->
    <xsl:variable name="BaseCurrency" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrency']"></xsl:variable>
	<xsl:variable name="Bank_id" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Bank_id']"></xsl:variable>
    <xsl:variable name="selectval_1" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n='$boName']/SRMComposite[@n='MiscellaneousInfo']/SRMRow/Z"/>
    <xsl:variable name="addressval_1" select="$selectval_1[@n=concat($boName,'.MiscellaneousInfo.Type')]"/>
	<!--****10.2.18: 800677*** -->
	  <xsl:variable name="accId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='accId']"></xsl:variable>
	  	 <!--****10.2.18: 800677*** -->
<!--variable for account key-->
    <xsl:variable name="accKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='accKey']"></xsl:variable>
    <!-- Core Dependency changes -->
    <xsl:variable name="susKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='susKey']"></xsl:variable>
    <xsl:variable name="contKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='contKey']"></xsl:variable>
    <!-- Core Dependency changes -->
     <xsl:variable name="mainAccId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mainAccId']"></xsl:variable>
<!-- CIF Changes for Refcodes : Start -->
    <xsl:variable name="CustCaste" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.CustCaste')]"></xsl:variable>
<!-- CRM70t-St Tracker# 78444, Begin of Changes -->
    <!-- <xsl:variable name="TDSTable" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.TDSTable')]"></xsl:variable> -->
<!-- CRM70t-St Tracker# 78444, End of Changes -->
    <xsl:variable name="NRERelative" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.NRERelative')]"></xsl:variable>
    <xsl:variable name="Marital_Status" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.Marital_Status')]"></xsl:variable>
    <xsl:variable name="Nationality" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.Nationality')]"></xsl:variable>
<!--Tracker ID:143802: Begin of Changes -->
   <xsl:variable name="occupation" select="//SRMData[@SRMDataSpace='CURRENTEMPLOYMENT']/SRMComposite[@n='RecordSet']/SRMRow/Z[@n=concat($boName,'.MiscellaneousInfo.strText2')]"></xsl:variable>
   <xsl:variable name="strText2_code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strText2']"></xsl:variable>
<!--Tracker ID:143802: End of Changes -->
<!-- CIF Changes for Refcodes : End -->
<!--changes for call id 407866 and recon of call id 400498 starts-->
 <xsl:variable name="employerName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Employer_Name']"></xsl:variable>
 <xsl:variable name="annualIncome" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.Annual_Salary_Income')]"></xsl:variable>
 <!--changes for call id:766708 starts-->
 <xsl:variable name="empDesignation" select="//SRMData[@SRMDataSpace='CURRENTEMPLOYMENT']/SRMComposite[@n='RecordSet']/SRMRow/Z[@n=concat($boName,'.MiscellaneousInfo.strText9')]"></xsl:variable>
  <!--changes for call id:766708 ends-->
 <xsl:variable name="CurrencyannualIncome" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.CU_Annual_Salary_Income')]"></xsl:variable>
<!--changes for call id 407866 and recon of call id 400498 ends-->
<!-- sonali: Begin of Changes -->
   <xsl:variable name="ChannelsAccessed" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.ChannelsAccessed')]"></xsl:variable>
<!-- sonali: End of Changes -->
	<!-- vasanth's changes start -->

    <xsl:variable name="BlackListed" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BlackListed']"></xsl:variable>
    <xsl:variable name="Suspended" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Suspended']"></xsl:variable>
    <xsl:variable name="Negated" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Negated']"></xsl:variable>
    <xsl:variable name="chkBSN" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='chkBSN']"></xsl:variable>
	<xsl:variable name="dob" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dob']"></xsl:variable>

	<!-- vasanth's changes end -->

	<!-- Field based maker checker changes-->
	<xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"></xsl:variable>
	<xsl:variable name="mcJNDIFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mcJNDIFlag']"></xsl:variable>
	<xsl:variable name="isMCEdited" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isMCEdited']"></xsl:variable>
<!-- CIF Changes for Caching Views : Start -->
    <xsl:param name="viewname"/>
	<xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.CIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/>&amp;BankId=<xsl:value-of select="$Bank_id"/></xsl:variable>  
    <xsl:variable name="PresFile" select="document(concat($PresFileName, ''))"/>
    <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
    <!-- CRM10.2 SPE CHANGES -->
    <xsl:variable name="PresCurrData" select="$PresFile/SRM/SRMData[@SRMDataSpace='Currency']"/>
    <xsl:variable name="PresExData" select="$PresFile/SRM/SRMData[@SRMDataSpace='ExRate']"/>
<!-- CIF Changes for Caching Views : End -->
<!-- ME changes 113066 Amit Malhotra : Start -->
    <xsl:variable name="AcrossSearch" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AcrossSearch']"></xsl:variable>
<!-- ME changes 113066 Amit Malhotra: End -->

<!-- Fix for Tracker #: SIDDHARTH Begins-->
    <xsl:variable name="dtValid" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtValid']"/>
<!-- Fix for Tracker #: SIDDHARTH Ends -->
  <xsl:variable name="EmployerId_code" select="//SRMData//Z[@n=concat($boName,'.EmployerId_code')]"></xsl:variable>
 	<!--  Tracker ID:144522  -->
  <xsl:variable name="convToCust" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='convToCust']"></xsl:variable>
  <xsl:variable name="oldEntityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='oldEntityType']"></xsl:variable>
  <xsl:variable name="oldEntityID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='oldEntityID']"></xsl:variable>
<!--  Tracker ID:144522  -->
    <xsl:template match="/">
    <html>
    <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
    <head>
<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
<!--Changes begin for ticket 195145-->
<script type="text/javascript" src="../common/js/TabMessage_{$locale}.js" language="javascript"></script>
<!--Changes end for ticket 195145-->
<!-- TrackerID:209607,CHANGES START -->
    <script type="text/javascript" src="../common/js/Rendcurrency_cif.js" language="javascript"></script>
    <!-- TrackerID:209607,CHANGES END -->
    <!--CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES-->
    	<!--Ticket 349330 changes start-->
    <script type="text/javascript" src="../Customization/43/cif/js/DemographicCustom.js" language="javascript"></script>
    	<!--Ticket 349330 changes end-->
    <!-- TrackerID:209607,CHANGES START -->
    <script type="text/javascript" language="javascript" src="../common/js/Reduce_Form.js"></script>
    <!-- TrackerID:209607,CHANGES END -->
    <!--CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES-->
    <script type="text/javascript" language="javascript" src="../cif/js/Demographic.js"></script>
    <script type="text/html" src="../Renderer/wizards/html/CifShowButtons.html"></script>
 <!-- vasanth's changes start -->


<!-- vasanth's changes end -->
<!--Changes by Niharika for CR356016-->
			<script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
	<!--End of changes by Niharika for CR356016-->
    <script>
        var ChannelsAccessed = '<xsl:value-of select="$ChannelsAccessed"/>';
        //changes for call id 407866 and recon of call id 400498 starts
        var employerName = '<xsl:value-of select="$employerName"/>';
		var oldEntityType = '<xsl:value-of select="$oldEntityType"/>';
        var annualIncome = '<xsl:value-of select="$annualIncome"/>';
		 //changes for call id:766708 starts
		 var empDesignation = '<xsl:value-of select="$empDesignation"/>';
		  //changes for call id:766708 ends
        var CurrencyannualIncome ='<xsl:value-of select="$CurrencyannualIncome"/>';
        //changes for call id 407866 and recon of call id 400498 ends
    var locale = '<xsl:value-of select="$locale"/>';
/*IDENTIFICATION DOCUMENT CHANGES start*/
    var readMode = '<xsl:value-of select="$readMode"/>';
    var custNREFlg = '<xsl:value-of select="$custNREFlg"/>';
/*IDENTIFICATION DOCUMENT CHANGES end*/
     <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
    var AccessOwnerGroup = '<xsl:value-of select="$AccessOwnerGroup"/>';
     <!-- Tracker ID : 90197 End of Changes -->
    var Type = '<xsl:value-of select="$Type"/>';
    var isCopy = '<xsl:value-of select="$isCopy"/>';
    <!-- Tracker ID : 178861 Start of Changes -->
    var isMCEdited = '<xsl:value-of select="$isMCEdited"/>';
    <!-- Tracker ID : 178861 End of Changes -->
   	<!--  Tracker ID:144522  -->
    var convToCust = '<xsl:value-of select="$convToCust"/>';
    var appFlag = '<xsl:value-of select="$apprFlag"/>';
    var submit=false;
    var btnFrmSize = 30;
    var NRECountryType = '<xsl:value-of select="$NRECountryType"/>';
    var mainAccId = '<xsl:value-of select="$mainAccId"/>';
		 /****10.2.18: 800677***/
		var accId = '<xsl:value-of select="$accId"/>';
		 /****10.2.18: 800677***/
    <!-- TrackerID 125726 starts -->
    <!-- CRM102Sanity: TrackerID:166781 Being of change-->
    var baseCurrency = '<xsl:value-of select="$currency"/>';
    //Changes for call id 344642 STARTS
    var byPassFlag = '<xsl:value-of select="$byPassFlag"/>';
    //Changes for call id 344642 ENDS
    <!-- CRM102Sanity: TrackerID:166781 End of change-->
     <!-- TrackerID 125726 ends -->

      <!--tracker id 113227 starts-->
      /*ticket id 219597 tracker id 132339 changes starts*/
    	var dualflag=1;
      /*ticket id 219597 tracker id 132339 changes ends*/
     	var altLocaleType = '<xsl:value-of select="$altLocaleType"/>';
      	var baseLocaleType = '<xsl:value-of select="$baseLocaleType"/>';
        var altLocaleActv = '<xsl:value-of select="$altLocaleActv"/>';

        if (altLocaleActv==true){
	        if (locale==altLocaleType){
	        dualflag=0;
	        }
	 }
	 /*ticket id 219597 tracker id 132339 changes starts*/
	        /*else if (locale==baseLocaleType){
	        dualflag=1;
	        }
	 }
	 else{
	        dualflag=1;

        }*/
	/*ticket id 219597 tracker id 132339 changes ends*/

          <!--tracker id 113227 ends-->


	<!-- vasanth's changes start -->
		var BlackListed = '<xsl:value-of select="$BlackListed"/>';
		var Suspended = '<xsl:value-of select="$Suspended"/>';
		var chkBSNFlg = '<xsl:value-of select="$chkBSN"/>';
		var Negated =  '<xsl:value-of select="$Negated"/>';
		var dob = '<xsl:value-of select="$dob"/>';
		var operationType = '<xsl:value-of select="$operationType"/>';
        <!-- ME changes 113066 Amit Malhotra : Start -->
		var AcrossSearch = '<xsl:value-of select="$AcrossSearch"/>';
        <!-- ME changes 113066 Amit Malhotra : End -->
	<!-- vasanth's changes end -->

    <!-- Fix for Tracker #: SIDDHARTH Begins -->
    var locDate = '<xsl:value-of select = "$dtValid"/>'
    <!-- Fix for Tracker #: SIDDHARTH Ends -->
	var boName = '<xsl:value-of select="$boName"/>';
/*IDENTIFICATION DOCUMENT CHANGES start*/
			var entityDocumentBO_Name;
			if(boName=='DemographicBO')
				entityDocumentBO_Name='EntityDocumentBO';
			else if(boName=='DemographicModBO')
				entityDocumentBO_Name='EntityDocumentModBO';
/*IDENTIFICATION DOCUMENT CHANGES end*/

    </script>
    <link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
    <link rel="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
     <!-- vasanth's changes start -->
     <script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>
	<!-- vasanth's changes end -->


   <script type="text/javascript" language="javascript">
	var boName = '<xsl:value-of select="$boName"/>';
	<!-- Tracker ID :756914 - Chrome Porting Changes -->
	function functionBodyOnload(){
		if(readMode=='Y'){
			//formatfields();
			showInReadOnlyMode('<xsl:value-of select="$readMode"/>');
			onEmpl("");
			load();
			chkBSN();
			loadBaseCurrency();
			loadCode();
			formatDemographyAmount();
			PreviousEmploymentDetails();
			showInReadOnlyMode('<xsl:value-of select="$readMode"/>');
		}else if(acctID=='' &amp;&amp; suspID=='' &amp;&amp; contID==''){
			disableFields();
			populateExRates();
			chkBSN();
			onEmpl("");
			load();
			formatDemographyAmount();
			PreviousEmploymentDetails();
			loadBaseCurrency();
			showbuttonsVisible(45);
			checkESFields();
		}else{
			disableFields();
			//formatfields();
			populateExRates();
			chkBSN();
			onEmpl("");
			showbuttonsVisible(30);
			load();
			loadBaseCurrency();
			checkESFields();
			loadCode();
			formatDemographyAmount();
			PreviousEmploymentDetails();
		}
	}
/*IDENTIFICATION DOCUMENT CHANGES start*/
			var entityDocumentBO_Name;
			if(boName=='DemographicBO')
				entityDocumentBO_Name='EntityDocumentBO';
			else if(boName=='DemographicModBO')
				entityDocumentBO_Name='EntityDocumentModBO';
/*IDENTIFICATION DOCUMENT CHANGES end*/
	var demoID = '<xsl:value-of select="$demographicID"/>';
	var accBO=null;
	var contBO=null;
	var suspBO=null;


	// Defect Fix:Ticket ID:219760 : Changes Start
	function fnChannelsDisabled()
   {
		 <!--Changes begin for ticket 195145-->

		var selTabId = top.frames(0).tabViewFrm.availableTabs[0];
        if(selTabId.indexOf(getUserMessage('MSGX50042',''))== -1)
        {

		if(readMode =='Y') {
			document.frm2.add.disabled=true;
			document.frm2.remove.disabled=true;
			document.frm2.AvailableChannels.disabled=true;
			document.frm2.ChannelsAccessed.disabled=true;
		}
       }
	    <!--Changes end for ticket 195145-->
	}
	// Defect Fix:Ticket ID:219760 : Changes Ends

function showbuttonsVisible(frmSize) {
        parent.parent.parent.parent.setCifButtonsVisible(true,frmSize);
    }
function focusFirstField () {
try {

	var nation = document.getElementsByName(boName + '.Nationality')[0].value;
	var cat_nation = document.getElementsByName('Cat_'+ boName + '.Nationality')[0].value;
	if (nation =='' &amp;&amp; cat_nation =='' ) {
	var birthcountry = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName('AccountBO.CountryOfBirth')[0].value;
	var cat_birthcountry = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName('Cat_AccountBO.CountryOfBirth')[0].value;
	if ( birthcountry !='' &amp;&amp; cat_birthcountry!= '' ) {
			populateNationality(birthcountry);
		}
	}
}
catch (e) {
}
try {	/* MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 - Begin */
	// The first field of screen is changed from Mail flag to Nationality.
	// So Nationality should be focussed form Load.
	//document.getElementsByName(boName + ".doNotMailFlag")[0].focus();
	//bhanu changes for TOL 402633 
		if (nation =='' &amp;&amp; cat_nation =='' )
		//bhanu changes for TOL 402633 
	document.getElementsByName(boName + ".Nationality")[0].focus();
	 /* MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 - End */
	}
	catch (e) {
		try
		{
			document.getElementsByName(boName + ".Employment_Status")[0].focus();
		}
		catch (e)
		{
			try
			{
				document.getElementsByName(boName + ".Employment_Status_Empl")[0].focus();
			}
			catch (e)
			{
				 try
				{
					document.getElementsByName(boName + ".Marital_Status")[0].focus();
				}
				catch (e)
				{
				}
/* CRM11.0:TRACKER:113058:BEGINOFCHANGES */
					try
					{
						document.getElementsByName("ADD_EDUDET")[0].focus();
					}
					catch (e)
					{
					}

/* CRM11.0:TRACKER:113058:ENDOFCHANGES */
			}
		}
	  }
}

	//Field Rationalization changes
	     function selfield1(x,y) {
                  var elem = new Array();
                  var a=0;
                  var nxt=0;
                  for (i=0; i &lt; x.length; i++)
                  {
                      if (x.options[i].selected)
                      {  var z = y.length;
                          for (var j=0; j &lt; y.length; j++)
                          {
                              if (x.options[i].text == y.options[j].text)
                              {
                              elem[a] = x.options[i].text;
                              elem[a] = x.options[i].value;
                              a++;
                              x.options[i] = null;
                              return;
                              }
                          }
                          if (j == y.length)
                          {
                              y.length = z + 1;
                              y.options[z].text = x.options[i].text;
                              y.options[z].value = x.options[i].value;
                              x.options[i] = null;
                              return;
                          }
                      }
                  }

		if (x.name == 'AvailableChannels')
		{
			if ( x.options.length == 0 )
			{
			  showUserMessage("MSG2018",'MSG_FR020');
			}
			else
			{
			  showUserMessage("MSG012",'MSG_FR020');
			}
		}
		else
		{
			if ( x.options.length == 0 )
			{
			  showUserMessage("MSG2019",'MSG_FR020');
			}
			else
			{
			  showUserMessage("MSG1037",'MSG_FR020');
                      }
                  }
              }
    <![CDATA[function showFormTips() {
	                parent.parent.parent.parent.removeTips(parent.parent.parent.parent.frames(0).getSelectedTabId());
	                parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(),"]]><xsl:value-of select="$SRMTips"/><![CDATA[");
	                parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames(0).getSelectedTabId());
	                parent.parent.parent.parent.showTipsButton();

	        }
    ]]>

    /* Tracker 63031-Begin of changes - load base currency as default currency */
    function loadBaseCurrency()
    {

	<!-- CRM102Sanity: TrackerID:166781 Being of change-->
	var baseCurrency = '<xsl:value-of select="$currency"/>';
	<!-- CRM102Sanity: TrackerID:166781 End of change-->
	var acctID = '<xsl:value-of select="$acctID"/>';
	if(acctID == null || acctID =="" || acctID =='')
	{
		document.getElementsByName(boName+".CU_SelfempGrossReciptCurrentYR")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_SelfempGrossReceiptPriorYear")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_SelfempNetProfitCurrentYR")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_SelfempNetProfitPriorYR")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_SelfempDepreciationCurrentYear")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_SelfempDepreciationPriorYear")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_SelfempAverageAnnualTurnover")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_TotalEstAccountValue_SelfEmployed")[0].value = baseCurrency;
		//changes for call id 407866 and recon of call id 400498 starts
		if(CurrencyannualIncome == null ||CurrencyannualIncome == ''||CurrencyannualIncome=='null'){
		document.getElementsByName(boName+".CU_Annual_Salary_Income")[0].value = baseCurrency;
		}
		else{
		document.getElementsByName(boName+".CU_Annual_Salary_Income")[0].value = CurrencyannualIncome;
		}
		//changes for call id 407866 and recon of call id 400498 ends
		document.getElementsByName(boName+".CU_Annual_Rental_Income")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_Annual_Stock_Bond_Income")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_Annual_Others_Income")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_Annual_Operating_Exp")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_Annual_Loan_Instal")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_Annual_IntProd_Exp")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_Annual_ExtProd_Exp")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_Annual_Commit_Exp")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_Annual_Other_Exp")[0].value = baseCurrency;
		//document.getElementsByName(boName+".CU_Annual_Total_Exp")[0].value = baseCurrency;<!--Fix for ticket 271915 -->
		document.getElementsByName(boName+".CU_SalAllowances")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_SalProrataMonthlyIncentive")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_SalInterestSubsidy")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_SalOtherIncome2")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_SalOtherIncome3")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_TotalEstAccountValue")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_TotalInvestmentInSharesandUnits")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_TotalMonthlyDebtServiceAmt")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_TotalHouseholdIncm")[0].value = baseCurrency;
	// CORE Fields Inclusion  -- Begin
		document.getElementsByName(boName+".CU_TotalFundBase")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_TotalNonFundBase")[0].value = baseCurrency;
		document.getElementsByName(boName+".CU_OtherLimits")[0].value = baseCurrency;
		document.getElementsByName(boName+".ShareholderType")[0].value = "N";
		/*Changes for ticket#355435 begin*/
		document.getElementsByName(boName+".CU_CustNetWorth")[0].value = baseCurrency;
		/*Changes for ticket#355435 end*/
/* Changes for Tracker # 88712 Start*/
		//document.getElementsByName(boName+".CU_CustBusinessAssets")[0].value = baseCurrency;<!--Fix for ticket 271915 -->
		//document.getElementsByName(boName+".CU_CustPropertyAssets")[0].value = baseCurrency;<!--Fix for ticket 271915 -->
		document.getElementsByName(boName+".CU_CustDepositsInOtherBanks")[0].value = baseCurrency;
		//Field Addition Tracker 172089:start of Changes
		if(document.frm2.elements(boName+".CU_income_from").value =='' || document.frm2.elements(boName+".CU_income_from").value  ==null){
			document.frm2.elements(boName+".CU_income_from").value =baseCurrency;
		}
		if(document.frm2.elements(boName+".CU_income_to").value=='' || document.frm2.elements(boName+".CU_income_to").value ==null){
				document.frm2.elements(boName+".CU_income_to").value =baseCurrency;
		}
		//Field Addition Tracker 172089:end of Changes
/* Changes for Tracker # 88712 End*/

	// CORE Fields Inclusion  -- End
	 }
	 /* Recon Changes for 167292 Start*/
	 	 if (acctID != null) {
	 	 	//Changes for tracker id 349372 STARTS
			if (document.getElementsByName(boName+".CU_TotalFundBase")[0].value == null || document.getElementsByName(boName+".CU_TotalFundBase")[0].value == '' ) {
				document.getElementsByName(boName+".CU_TotalFundBase")[0].value = baseCurrency;
			}
			if (document.getElementsByName(boName+".CU_CustNetWorth")[0].value == null || document.getElementsByName(boName+".CU_CustNetWorth")[0].value == '' ) {
				document.getElementsByName(boName+".CU_CustNetWorth")[0].value = baseCurrency;
			}                                              
	 	 	//Changes for tracker id 349372 ENDS
	 		if (document.getElementsByName(boName+".CU_SelfempGrossReciptCurrentYR")[0].value == null || document.getElementsByName(boName+".CU_SelfempGrossReciptCurrentYR")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_SelfempGrossReciptCurrentYR")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_SelfempGrossReceiptPriorYear")[0].value == null || document.getElementsByName(boName+".CU_SelfempGrossReceiptPriorYear")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_SelfempGrossReceiptPriorYear")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_SelfempNetProfitCurrentYR")[0].value == null || document.getElementsByName(boName+".CU_SelfempNetProfitCurrentYR")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_SelfempNetProfitCurrentYR")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_SelfempNetProfitPriorYR")[0].value == null || document.getElementsByName(boName+".CU_SelfempNetProfitPriorYR")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_SelfempNetProfitPriorYR")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_SelfempDepreciationCurrentYear")[0].value == null || document.getElementsByName(boName+".CU_SelfempDepreciationCurrentYear")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_SelfempDepreciationCurrentYear")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_SelfempDepreciationPriorYear")[0].value == null || document.getElementsByName(boName+".CU_SelfempDepreciationPriorYear")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_SelfempDepreciationPriorYear")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_SelfempAverageAnnualTurnover")[0].value == null || document.getElementsByName(boName+".CU_SelfempAverageAnnualTurnover")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_SelfempAverageAnnualTurnover")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_TotalEstAccountValue_SelfEmployed")[0].value == null || document.getElementsByName(boName+".CU_TotalEstAccountValue_SelfEmployed")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_TotalEstAccountValue_SelfEmployed")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_Annual_Salary_Income")[0].value == null || document.getElementsByName(boName+".CU_Annual_Salary_Income")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_Annual_Salary_Income")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_Annual_Rental_Income")[0].value == null || document.getElementsByName(boName+".CU_Annual_Rental_Income")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_Annual_Rental_Income")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_Annual_Stock_Bond_Income")[0].value == null || document.getElementsByName(boName+".CU_Annual_Stock_Bond_Income")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_Annual_Stock_Bond_Income")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_Annual_Others_Income")[0].value == null || document.getElementsByName(boName+".CU_Annual_Others_Income")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_Annual_Others_Income")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_Annual_Operating_Exp")[0].value == null || document.getElementsByName(boName+".CU_Annual_Operating_Exp")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_Annual_Operating_Exp")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_Annual_Loan_Instal")[0].value == null || document.getElementsByName(boName+".CU_Annual_Loan_Instal")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_Annual_Loan_Instal")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_Annual_IntProd_Exp")[0].value == null || document.getElementsByName(boName+".CU_Annual_IntProd_Exp")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_Annual_IntProd_Exp")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_Annual_ExtProd_Exp")[0].value == null || document.getElementsByName(boName+".CU_Annual_ExtProd_Exp")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_Annual_ExtProd_Exp")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_Annual_Commit_Exp")[0].value == null || document.getElementsByName(boName+".CU_Annual_Commit_Exp")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_Annual_Commit_Exp")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_Annual_Other_Exp")[0].value == null || document.getElementsByName(boName+".CU_Annual_Other_Exp")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_Annual_Other_Exp")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_SalAllowances")[0].value == null || document.getElementsByName(boName+".CU_SalAllowances")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_SalAllowances")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_SalProrataMonthlyIncentive")[0].value == null || document.getElementsByName(boName+".CU_SalProrataMonthlyIncentive")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_SalProrataMonthlyIncentive")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_SalInterestSubsidy")[0].value == null || document.getElementsByName(boName+".CU_SalInterestSubsidy")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_SalInterestSubsidy")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_SalOtherIncome2")[0].value == null || document.getElementsByName(boName+".CU_SalOtherIncome2")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_SalOtherIncome2")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_SalOtherIncome3")[0].value == null || document.getElementsByName(boName+".CU_SalOtherIncome3")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_SalOtherIncome3")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_TotalEstAccountValue")[0].value == null || document.getElementsByName(boName+".CU_TotalEstAccountValue")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_TotalEstAccountValue")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_TotalInvestmentInSharesandUnits")[0].value == null || document.getElementsByName(boName+".CU_TotalInvestmentInSharesandUnits")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_TotalInvestmentInSharesandUnits")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_TotalMonthlyDebtServiceAmt")[0].value == null || document.getElementsByName(boName+".CU_TotalMonthlyDebtServiceAmt")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_TotalMonthlyDebtServiceAmt")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_TotalHouseholdIncm")[0].value == null || document.getElementsByName(boName+".CU_TotalHouseholdIncm")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_TotalHouseholdIncm")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_TotalNonFundBase")[0].value == null || document.getElementsByName(boName+".CU_TotalNonFundBase")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_TotalNonFundBase")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_OtherLimits")[0].value == null || document.getElementsByName(boName+".CU_OtherLimits")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_OtherLimits")[0].value = baseCurrency;
	 		}
	 		if (document.getElementsByName(boName+".CU_CustDepositsInOtherBanks")[0].value == null || document.getElementsByName(boName+".CU_CustDepositsInOtherBanks")[0].value == '' ) {
	 			document.getElementsByName(boName+".CU_CustDepositsInOtherBanks")[0].value = baseCurrency;
	 		}
	 	 }
	  	/* Recon Changes for 167292 End*/ 

    }
    /* Tracker 63031-End of changes  */
   /*
        This function will set the fields Passport and Validity date as mandatory.
    */
    function fnSetMandatory(){
        try{

        /* Tracker Id : 62659 BEGIN OF CHANGES  */

		if(boName=='DemographicBO'){
			accBO='AccountBO';
			contBO='ContactBO';
			suspBO='SuspectBO';
		} else {
			accBO='AccountModBO';
			contBO='ContactModBO';
			suspBO='SuspectModBO';
		}

	    	if(parent.parent.IFrmtab0.formDispFrame.document.getElementsByName(accBO+".CustomerNREFlg")[0] == '[object]'){
				if(parent.parent.IFrmtab0.formDispFrame.document.getElementsByName(accBO+".CustomerNREFlg")[0].value == "Y" ) {
			/* Tracker Id : 129978 BEGIN OF CHANGES */
				    var object = document.getElementsByName("Passport Number.txt_Valid_Date")[0];
				    object.IsMandatory = "true";
				    var object1 = document.getElementsByName("Passport Number.txt_ID")[0];
				    object1.IsMandatory = "true";
				     /* Tracker Id : 69162 BEGIN OF CHANGES  */
				    var object2=document.getElementsByName("Passport Number.txt_Issue_Date")[0];
				    object2.IsMandatory = "true";
				    var object3=document.getElementsByName("Passport Number.txt_Issue_Place")[0];
				    object3.IsMandatory = "true";
				     /* Tracker Id : 69162 END OF CHANGES  */

				    }
			else {

				    var object = document.getElementsByName("Passport Number.txt_Valid_Date")[0];
				    object.IsMandatory = "false";
				    var object1 = document.getElementsByName("Passport Number.txt_ID")[0];
				    object1.IsMandatory = "false";
				    /* Tracker Id : 69162 BEGIN OF CHANGES  */
				    var object2=document.getElementsByName("Passport Number.txt_Issue_Date")[0];
				    object2.IsMandatory = "false";
				    var object3=document.getElementsByName("Passport Number.txt_Issue_Place")[0];
				    object3.IsMandatory = "false";
				    /* Tracker Id : 69162 END OF CHANGES  */

				    var DL_uniqueID = document.getElementsByName("Driving Licence.txt_ID")[0];
				    var DL_validDate = document.getElementsByName("Driving Licence.txt_Valid_Date")[0];
				    var DL_IssueDate = document.getElementsByName("Driving Licence.txt_Issue_Date")[0];
				    var DL_IssuePlace = document.getElementsByName("Driving Licence.txt_Issue_Place")[0];
				    var EID_uniqueID = document.getElementsByName("Election ID Card.txt_ID")[0];
				    var EID_validDate = document.getElementsByName("Election ID Card.txt_Valid_Date")[0];
				    var EID_IssueDate = document.getElementsByName("Election ID Card.txt_Issue_Date")[0];
				    var EID_IssuePlace = document.getElementsByName("Election ID Card.txt_Issue_Place")[0];
				    var NC_uniqueID = document.getElementsByName("National Card Number.txt_ID")[0];
				    var NC_validDate = document.getElementsByName("National Card Number.txt_Valid_Date")[0];
				    var NC_IssueDate = document.getElementsByName("National Card Number.txt_Issue_Date")[0];
				    var NC_IssuePlace = document.getElementsByName("National Card Number.txt_Issue_Place")[0];
					//changes for adhar for tracker 375136 starts
					var UniqueIDNumber_uniqueID = document.getElementsByName("Unique Identification Number.txt_ID")[0];
					var UniqueIDNumber_validDate = document.getElementsByName("Unique Identification Number.txt_Valid_Date")[0];
					var UniqueIDNumber_IssueDate = document.getElementsByName("Unique Identification Number.txt_Issue_Date")[0];
					var UniqueIDNumber_IssuePlace = document.getElementsByName("Unique Identification Number.txt_Issue_Place")[0];
					//change for adhar for tracker 375136 ends
				    var PAN_uniqueID = document.getElementsByName("PAN.txt_ID")[0];
				    var PAN_validDate = document.getElementsByName("PAN.txt_Valid_Date")[0];
				    var PAN_IssueDate = document.getElementsByName("PAN.txt_Issue_Date")[0];
				    var PAN_IssuePlace = document.getElementsByName("PAN.txt_Issue_Place")[0];
				    var RC_uniqueID = document.getElementsByName("Ration Card Number.txt_ID")[0];
				    var RC_validDate = document.getElementsByName("Ration Card Number.txt_Valid_Date")[0];
				    var RC_IssueDate = document.getElementsByName("Ration Card Number.txt_Issue_Date")[0];
				    var RC_IssuePlace = document.getElementsByName("Ration Card Number.txt_Issue_Place")[0];
				    var SSN_uniqueID = document.getElementsByName("SSN.txt_ID")[0];
				    var SSN_validDate = document.getElementsByName("SSN.txt_Valid_Date")[0];
				    var SSN_IssueDate = document.getElementsByName("SSN.txt_Issue_Date")[0];
				    var SSN_IssuePlace = document.getElementsByName("SSN.txt_Issue_Place")[0];
				    var TIN_uniqueID = document.getElementsByName("TIN.txt_ID")[0];
				    var TIN_validDate = document.getElementsByName("TIN.txt_Valid_Date")[0];
				    var TIN_IssueDate = document.getElementsByName("TIN.txt_Issue_Date")[0];
				    var TIN_IssuePlace = document.getElementsByName("TIN.txt_Issue_Place")[0];
					<![CDATA[
					if (object1.value!=""){
						if ((object.value!="")&&(object2.value!="")&&(object3.value!="")){
							var a= "true";
						}
						else{
							var a = "false";
						}
					}
					else{
						var a = "false";
					}
					if (DL_uniqueID.value!=""){
						if ((DL_validDate.value!="")&&(DL_IssueDate.value!="")&&(DL_IssuePlace.value!="")){
							var b= "true";
						}
						else{
							var b = "false";
						}
					}
					else{
						var b = "false";
					}
					if (EID_uniqueID.value!=""){
						if ((EID_validDate.value!="")&&(EID_IssueDate.value!="")&&(EID_IssuePlace.value!="")){
							var c= "true";
						}
						else{
							var c = "false";
						}
					}
					else{
						var c = "false";
					}
					if (PAN_uniqueID.value!=""){
						if ((PAN_validDate.value!="")&&(PAN_IssueDate.value!="")&&(PAN_IssuePlace.value!="")){
							var d= "true";
						}
						else{
							var d = "false";
						}
					}
					else{
						var d = "false";
					}
					//changes for adhar for tracker 375136 starts
					if (UniqueIDNumber_uniqueID.value!=""){
						if ((UniqueIDNumber_validDate.value!="")&&(UniqueIDNumber_IssueDate.value!="")&&(UniqueIDNumber_IssuePlace.value!="")){
							var i= "true";
					}
						else{
							var i = "false";
						}
					}
					else{
					var i = "false";
					}
					//changes for adhar for tracker 375136 ends
					if (RC_uniqueID.value!=""){
						if ((RC_validDate.value!="")&&(RC_IssueDate.value!="")&&(RC_IssuePlace.value!="")){
							var e= "true";
						}
						else{
							var e = "false";
						}
					}
					else{
						var e = "false";
					}
					if (NC_uniqueID.value!=""){
						if ((NC_validDate.value!="")&&(NC_IssueDate.value!="")&&(NC_IssuePlace.value!="")){
							var f= "true";
						}
						else{
							var f = "false";
						}
					}
					else{
						var f = "false";
					}
					if (SSN_uniqueID.value!=""){
						if ((SSN_validDate.value!="")&&(SSN_IssueDate.value!="")&&(SSN_IssuePlace.value!="")){
							var g= "true";
						}
						else{
							var g = "false";
						}
					}
					else{
						var g = "false";
					}
					if (TIN_uniqueID.value!=""){
						if ((TIN_validDate.value!="")&&(TIN_IssueDate.value!="")&&(TIN_IssuePlace.value!="")){
							var h= "true";
						}
						else{
							var h = "false";
						}
					}
					else{
						var h = "false";
					}
					//changes for adhar for tracker 375136 starts
					if((a=="true")||(b=="true")||(c=="true")||(d=="true")||(e=="true")||(f=="true")||(g=="true")||(h=="true") || (i=="true")){
					//changes for adhar for tracker 375136 ends
						return true;
					}
					else{

						var elem1 = document.getElementsByName("Driving Licence.txt_ID")[0];
						/* Tracker Id : 129978 END OF CHANGES */
						selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
						parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_IDENT",""),elem1.name, 'HYPER_LINK');
						parent.parent.parent.parent.messageFrm.showMessages(selTabId);
						return false;
					}

					]]>

				    }
			    }
	 /* Tracker Id : 62659 END OF CHANGES  */
		if(parent.parent.IFrmtab0.formDispFrame.document.getElementsByName(contBO+".ContactNREFlg")[0] == '[object]'){
			 if(parent.parent.IFrmtab0.formDispFrame.document.getElementsByName(contBO+".ContactNREFlg")[0].value == "Y" ){

				    var object = document.getElementsByName("Passport Number.txt_Valid_Date")[0];
				    object.IsMandatory = "true";
				    var object1 = document.getElementsByName("Passport Number.txt_ID")[0];
				    object1.IsMandatory = "true";
				    /* Tracker Id : 69162 BEGIN OF CHANGES  */
				    var object2=document.getElementsByName("Passport Number.txt_Issue_Date")[0];
				    object2.IsMandatory = "true";
				    var object3=document.getElementsByName("Passport Number.txt_Issue_Place")[0];
				    object3.IsMandatory = "true";
				    /* Tracker Id : 69162 END OF CHANGES  */


				    }
			else {

				    var object = document.getElementsByName("Passport Number.txt_Valid_Date")[0];
				    object.IsMandatory = "false";
				    var object1 = document.getElementsByName("Passport Number.txt_ID")[0];
				    object1.IsMandatory = "false";
				    /* Tracker Id : 69162 BEGIN OF CHANGES  */
				    var object2=document.getElementsByName("Passport Number.txt_Issue_Date")[0];
				    object2.IsMandatory = "false";
				    var object3=document.getElementsByName("Passport Number.txt_Issue_Place")[0];
				    object3.IsMandatory = "false";
				    /* Tracker Id : 69162 END OF CHANGES  */

				  }
	    		    }
	          if(parent.parent.IFrmtab0.formDispFrame.document.getElementsByName(suspBO+".SuspectsNREFlg")[0] == '[object]'){
			if(parent.parent.IFrmtab0.formDispFrame.document.getElementsByName(suspBO+".SuspectsNREFlg")[0].value == "Y" ){

				    var object = document.getElementsByName("Passport Number.txt_Valid_Date")[0];
				    object.IsMandatory = "true";
				    var object1 = document.getElementsByName("Passport Number.txt_ID")[0];
				    object1.IsMandatory = "true";
				    /* Tracker Id : 69162 BEGIN OF CHANGES  */
				    var object2=document.getElementsByName("Passport Number.txt_Issue_Date")[0];
				    object2.IsMandatory = "true";
				    var object3=document.getElementsByName("Passport Number.txt_Issue_Place")[0];
				    object3.IsMandatory = "true";
				    /* Tracker Id : 69162 END OF CHANGES  */


				    }
			else {

				    var object = document.getElementsByName("Passport Number.txt_Valid_Date")[0];
				    object.IsMandatory = "false";
				    var object1 = document.getElementsByName("Passport Number.txt_ID")[0];
				    object1.IsMandatory = "false";
				    /* Tracker Id : 69162 BEGIN OF CHANGES  */
				    var object2=document.getElementsByName("Passport Number.txt_Issue_Date")[0];
				    object2.IsMandatory = "false";
				    var object3=document.getElementsByName("Passport Number.txt_Issue_Place")[0];
				    object3.IsMandatory = "false";
				    /* Tracker Id : 69162 END OF CHANGES  */

				    }
	    		    }


        }catch(e){

        }
//alert('Demographic.xsl>> fnSetMandatory()>> Mandatory Fields Set'); //abhinav
    }
    //CIF Tabbing and Saving Changes
    	<!-- CRM102ST: TrackerID:414055 Begin of Change by mayur -->
    	function closebtn(){
		<!-- CRM102ST: TrackerID:166115 Begin of Change -->
		if(demoID==0){
		    parent.frames(0).location.href = parent.frames(0).location.href;
		}
		else if(!submit){
			top.window.close();
		}
<!-- CRM102ST: TrackerID:414055 end of Change by mayur -->
		else if(demoID!=0 &amp;&amp; (boName=='DemographicBO' || boName=='DemographicModBO')){
			top.window.close();
		}
      	}
      	/* Changes made for call id 260080: start */
      	function formatDemoEmpIntField(obj){	
      	/* Changes made for Tracker id: 292151 starts */
        var period = document.getElementsByName("DemographicBO.MiscellaneousInfo.strText10")[0].value;
        /* Changes for tracker ID 456112 start */
		if (period>9999)
		{ showMessage(MSGJ51520);
		  document.getElementsByName("DemographicBO.MiscellaneousInfo.strText10")[0].value="";
		  document.getElementsByName("DemographicBO.MiscellaneousInfo.strText10")[0].focus();
		}
	 /* Changes made for Tracker id: 292151 ends */  
	    		 if (isNaN(obj.value)) {
				showMessage(MSGJ50161);
				obj.value="";
				obj.focus();
					}
    		}
    	/* Changes made for call id 260080: end */
      	function refreshParent(){
		frm = top.opener.parent.frames(1);
		frm.navigate (frm.location.href);
	}
	<!-- CRM102ST: TrackerID:165886 End of Change -->

	  <![CDATA[
		function validateTdsDates(TdsDate){


		/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
		/* calling the function isGregDate for on blur functionality*/
		isGregDate("3_DemographicBO.TDSExcemptSubmitDate");
		/*  ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/

				var todaydate = new String();
				    //todaydate.value = getTodayDate();
					todaydate.value = getTodayDate1(locDate);

			/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
			/* calling the function isGregDate for on blur functionality*/
			var date = document.getElementsByName("3_DemographicBO.TDSExcemptSubmitDate")[0];
			if (date.value != '')
{
			todaydate.value = convertDate(todaydate.value);
			}
				/*  ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/


				    elem1 = document.getElementsByName(TdsDate)[0];
				//Changes for call id 352988 STARTS	
				    var mill1 = changetoMillis(todaydate.value);
				//Changes for call id 352988 ENDS
				    var mill2 = changetoMillis(elem1.value);

						if (mill1 < mill2){
 									showMessage(MSG302);
									elem1.value = "";
									//elem1.focus();
							}
						}

		function changetoMillis(datevalue)
		{
			if(datevalue.length == 0)
			{
				return 0;
			}
			else{
				var date1 = new Date(datevalue.substring(3,5) + "/" + datevalue.substring(0,2) + "/" + datevalue.substring(6,10));
				var millis = date1.valueOf();
				return millis;
			}
		}
	]]>

    //CIF Tabbing and Saving Changes
   function clear() {
	     var acctID = '<xsl:value-of select="$acctID"/>';
	     var suspID = '<xsl:value-of select="$suspID"/>';
	     var contID='<xsl:value-of select="$contID"/>';
	     if(suspID !=""){
			 acctID=suspID;
		 }
	     else if(contID!=""){
			 acctID=contID;
		}
		if(acctID =="" || acctID == null )
		{
		//CREATE
			document.getElementsByName("accID")[0].value = parent.formSaveFrame.savedValue;
		}
    }
    //Field based maker checker changes
    function setMCAttModifyFlag(){
		document.frm2.isMCEditedDemo.value="Y";

	}


        function selectProcess(){
		//Field based maker checker changes
		if(document.frm2.isMCEditedDemo.value=="N"){
       			appFlag="false";
       		}

               	submit = true;
               	//...added by vishal....
               	var entityType = '<xsl:value-of select="$Type"/>';
               	var savedID = parent.formSaveFrame.savedValue;


	     var acctID = '<xsl:value-of select="$acctID"/>';
	     var suspID = '<xsl:value-of select="$suspID"/>';
	     var contID='<xsl:value-of select="$contID"/>';
	     if(suspID !=""){
			 acctID=suspID;
		 }
	     else if(contID!=""){
			 acctID=contID;
		}
               	var accountId  = acctID;
       		if( appFlag=='true' &amp;&amp; mainAccId == '')
		  {
		  entityType = entityType+"Mod";
		  accountId  = savedID;
		  }
		  if(mainAccId != '') entityType = entityType+"Mod";
				 // Checksum IUT fix start
               	//if(!(document.frm2.byPassFlag.value=="Y")){
			// Checksum security recon(10.3 SUPP) changes start
            //var secureHKey = document.getElementsByName("SECUREHKEY")[0].value;
			//var keyField = document.getElementsByName("FLDHASHKEY")[0].value;
            		// Checksum security recon changes from 10.3 SUPP start
               		/* Tracker Id : 98728 Start OF CHANGES  */
               		//window.open('../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+accountId+'&amp;entityType='+entityType+'&amp;isPopup=Yes&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField,'save','directories=No, height=250, left=100, top=100, width=550, location=no, menubar=no, resizable=no, status=no, toolbar=no');
               		// Checksum security recon changes from 10.3 SUPP end
               		/* Tracker Id : 98728 End OF CHANGES  */
               //	}
				// Checksum IUT fix end


//changes for tracker 419294 vector clean up sanity begin
 if(appFlag=='false')
		 {
			 entityType = '<xsl:value-of select="$Type"/>';
			 accountId  = savedID;
		  }
//changes for tracker 419294 vector clean up sanity ends
		   //Save and submit changes End
		 // if(mainAccId == '') entityType = entityType+"Mod";

               	if(!(document.frm2.byPassFlag.value=="Y")){
			/*Tracker :93811 Fix start */
			// Checksum security recon changes from 10.3 SUPP start
			var secureHKey = document.getElementsByName("SECUREHKEY")[0].value;	
			var keyField = document.getElementsByName("FLDHASHKEY")[0].value;		
			/*Changes by Niharika for CR356016*/
            //window.open('../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+accountId+'&amp;entityType='+entityType+'&amp;isPopup=Yes&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField,'save','directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
			var strProcessURL = '../servlet/com.infy.cis.custom.EquityRetailProcessSelection?entityId='+accountId+'&amp;entityType='+entityType;
			var strBOURL = 'abc';
			//alert('strBOURL    '+strBOURL);
			//alert('strProcessURL     '+strProcessURL);
			fnProcessSelection(strProcessURL, strBOURL);
			top.window.close();
			/*End of changes by Niharika for CR356016*/
			// Checksum security recon changes from 10.3 SUPP end
			/*Tracker :93811 Fix End */
		 //Changes for call id 373394 Starts : Process window was not coming in focus	
		 //Fix for TOL id: 755796, preventing multiple windows to open - starts
		try
		{
			top.window.opener.sessionStorage.setItem("IsWindowOpened", "true");
		}
		catch(e)
		{
		}
		//Fix for TOL id: 755796, preventing multiple windows to open - ends
   //    window.showModalDialog('../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+accountId+'&amp;entityType='+entityType+'&amp;isPopup=Yes&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField,'save','dialogHeight:360px; dialogLeft:'+ (screen.width - 900) / 2 +'px;dialogTop:'+ (screen.height - 360) / 2+'px; dialogWidth:500px;center:yes;resizable:no;status:no;scroll:no;help:no;');
     //Changes for call id 373394 Ends : Process window was not coming in focus
			<!--Changes for Callid:406065 and recon of call id 402950 starts-->    			
		//	top.close();
			<!--Changes for Callid:406065 and recon of call id 402950 ends-->
               	}


        }


  	 function shouldRefresh() {
		// alert("Demo "+operationType);
			if(operationType == 'Queue') {
				return true;
			}
			else {
    	 	return false;
    	 }
    	 }
	function resubmit(){
		parent.parent.parent.parent.parent.parent.frames(0).submit();
	}

      function sortMe(sortColumn,sortOrder) {
		}
    //CIF Tabbing and Saving Changes
    function setFocusOnComp(compName) {
		  var object = "";
		  object = "parent.parent.IFrmtab0.formDispFrame.";
		  var elementName = eval(object + "document.getElementsByName(compName)[0]");
		  if(elementName) {
		      if(elementName.displayFieldName){
			  elementName = eval(object + "document.getElementsByName(elementName.displayFieldName)[0]");
		      }
		      try{
			  var ids = elementName.parentElement.parentElement.parentElement.parentElement.parentElement.id;
			  ids = trim(ids.replace("det_",""));
			  eval(object + "showTabFortabDemoForm('" + ids +"')");
		      }catch(e){
		      }
		      if (elementName.type == "text" || elementName.type == "textarea"){
			  elementName.select();
		      }else{
			  elementName.focus();
		      }
		  }
    }
    //CIF Tabbing and Saving Changes
    /******* Save and Submit Changes to know whether SAVE OR SUBMIT button pressed by passing the blFlag to the save()******/
    function save(blFlag){
	//alert('in save');
		if(document.frm2.byPassFlag.value!="Y"){
		if(document.frm2.isMCEdited.value=="Y"){
				document.frm2.isMCEditedDemo.value="Y";
			}
			if(operationType!="Edit Entity"){
				if(operationType!="Queue"){
					document.frm2.isMCEditedDemo.value=parent.parent.IFrmtab0.formDispFrame.document.frm2.isMCEditedGeneral.value;
				}
			else{
			   document.frm2.isMCEditedDemo.value = isMCEdited;
			}
		}
	   var strtextzip = document.getElementsByName('DemographicBO.MiscellaneousInfo.strText19')[0]
					      var StrTextZip = strtextzip.value;
						if (StrTextZip.length > 10){
							showMessage(MSGX0059);
							return "interactive"
				  }

		try{
						//Equity bank CR17 changes start

		save_flag=customSaveDemo(blFlag);
		if(save_flag == false){
					var  selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
//alert('document.frm2.hid_demographicID.value'+document.frm2.hid_demographicID.value);
		if(document.frm2.hid_demographicID.value != '' &amp;&amp; document.frm2.hid_demographicID.value != '0') {
			var elem1 = document.getElementsByName("3_DemographicBO.MiscellaneousInfo.dtDate1")[0];
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,
			getUserMessage("MSG086","'Date of Joining'"),elem1.name,'HYPER_LINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		}
		else{
		parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG086","Date Of Joining in Demographic tab"),"" ,'NO_HLINK');
		parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		}
			return 'interactive';
				//Equity bank CR17 changes end

		}
        }catch(e)
        { }
		// vasanth's changes start

			var hasErrors = "";
        	var selTabId;
			var frameobj;

				if (top.frames(0).tabViewFrm==null)
				{
					frameobj = parent.parent.parent.parent;
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
				}else{
					frameobj = top.frames(0);
					selTabId = top.frames(0).tabViewFrm.getSelectedTabId();
				}
			hasErrors = ValidateDateFields(getUserMessage("MSG_DOB","dob"),dob);

			if(hasErrors == "true") {
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
			}

		// vasanth's changes end



    	// Field Rationalization changes start
	var nationality = document.getElementsByName(boName + '.Nationality')[0].value;
	var channelsacc = document.frm2.ChannelsAccessed.length;
	var sChAccessed = "";
	for (i=0; i &lt; document.frm2.ChannelsAccessed.length; i++) {
	//Audit Fixes recon from 10.4 :BEGIN	
		/*sChAccessed += document.frm2.ChannelsAccessed.options[i].value + ",";*/
		if(i== 0){
			 sChAccessed += document.frm2.ChannelsAccessed.options[i].value ;
			 }else{
			 sChAccessed += ","+ document.frm2.ChannelsAccessed.options[i].value ;
		 }
	//Audit Fixes recon from 10.4 :END
	}
	try{
	document.frm2.ChsAccessed.value = sChAccessed;
	var a = document.frm2.ChsAccessed.value;
	}catch(e)
	{ }
	}
	// Field Rationalization changes end
	    getQualificationforAccount();
	    FormatBeforeSave("3_DemographicBO.Annual_Salary_Income");
	    FormatBeforeSave("3_DemographicBO.SalAllowances");
	    FormatBeforeSave("3_DemographicBO.SalProrataMonthlyIncentive");
	    FormatBeforeSave("3_DemographicBO.SalInterestSubsidy");
	    FormatBeforeSave("3_DemographicBO.Annual_Others_Income");
	    FormatBeforeSave("3_DemographicBO.Annual_Rental_Income");
	    FormatBeforeSave("3_DemographicBO.SalOtherIncome2");
	    FormatBeforeSave("3_DemographicBO.SalOtherIncome3");
	    FormatBeforeSave("3_DemographicBO.TotalEstAccountValue");
	    FormatBeforeSave("3_DemographicBO.TotalInvestmentInSharesandUnits");
	    FormatBeforeSave("3_DemographicBO.Annual_Stock_Bond_Income");
	    FormatBeforeSave("3_DemographicBO.Annual_Operating_Exp");
	    FormatBeforeSave("3_DemographicBO.Annual_Loan_Instal");
	    FormatBeforeSave("3_DemographicBO.Annual_IntProd_Exp");
	    FormatBeforeSave("3_DemographicBO.Annual_ExtProd_Exp");
	    FormatBeforeSave("3_DemographicBO.Annual_Commit_Exp");
	    FormatBeforeSave("3_DemographicBO.Annual_Other_Exp");
	    FormatBeforeSave("3_DemographicBO.TotalMonthlyDebtServiceAmt");
	    FormatBeforeSave("3_DemographicBO.SelfempGrossReciptCurrentYR");
	    FormatBeforeSave("3_DemographicBO.SelfempGrossReceiptPriorYear");
	    FormatBeforeSave("3_DemographicBO.SelfempNetProfitCurrentYR");
	    FormatBeforeSave("3_DemographicBO.SelfempNetProfitPriorYR");
	    FormatBeforeSave("3_DemographicBO.SelfempDepreciationCurrentYear");
	    FormatBeforeSave("3_DemographicBO.SelfempDepreciationPriorYear");
	    FormatBeforeSave("3_DemographicBO.SelfempNetProfitCurrentYR");
	    FormatBeforeSave("3_DemographicBO.SelfempNetProfitPriorYR");
	    FormatBeforeSave("3_DemographicBO.SelfempDepreciationCurrentYear");
	    FormatBeforeSave("3_DemographicBO.SelfempDepreciationPriorYear");
	    FormatBeforeSave("3_DemographicBO.SelfempAverageAnnualTurnover");
	    FormatBeforeSave("3_DemographicBO.TotalEstAccountValue_SelfEmployed");
	    FormatBeforeSaveForCustomer("3_DemographicBO.TotalHouseholdIncm");
	    FormatBeforeSaveForCustomer("3_DemographicBO.Annual_Total_Exp");
	    FormatBeforeSaveForCustomer("3_DemographicBO.Annual_Total_Income");
	// CORE Fields Inclusion  -- Begin
	   if(!(document.frm2.byPassFlag.value=="Y")){
	   // 113276 CHNAGES START
	    	//FormatBeforeSave("3_DemographicBO.TotalFundBase");
	    	FormatBeforeSave("3_DemographicBO.TotalNonFundBase");
	    	FormatBeforeSave("3_DemographicBO.OtherLimits");
/* Changes for Tracker # 88712 Start */
	    	//FormatBeforeSave("3_DemographicBO.CustBusinessAssets");
	    	//FormatBeforeSave("3_DemographicBO.CustPropertyAssets");
	    	FormatBeforeSave("3_DemographicBO.CustDepositsInOtherBanks");
	    	// 113276 CHANGES END
/* Changes for Tracker # 88712 End */
	    }
	// CORE Fields Inclusion  -- End








	var newflg = "N";
	var EntityType=null;
	if(Type=="Prospect"){
	EntityType="Suspect";
	}
	else{
	EntityType = Type;
	}
	 var acctID = '<xsl:value-of select="$acctID"/>';
	 var suspID = '<xsl:value-of select="$suspID"/>';
	 var contID = '<xsl:value-of select="$contID"/>';

	 //Tracker 174909 Starts
	 if(acctID == "")
	 {
	 if(suspID !=""){
		acctID=suspID;
	 }
	 else if(contID !=""){
		acctID=contID;
	 	}
	 }
	 //Tracker 174909 Ends
	var accountId = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("accID")[0].value;

	if(accountId != "" || acctID!="" || acctID!=null){
			if(accountId!=""){
			/***** Save and Submit Changes:Passing the blFlag as parameter to saveDemo****/
			temp = saveDemo(accountId,EntityType, newflg,blFlag);
			}else{
//Changes for call id: 389624 and recon for TOL 388300 Start
			if(blFlag){
			// save submit change
			    /*if(blFlag == true) {
				noValidationMsg = false;
			    }
			    else {
				noValidationMsg = true;
	    		    }*/
			  var retstat=FieldsForValidation(true);
			//var retstat1=parent.parent.parent.parent.ValidateFormContents(document.frm2,true,noValidationMsg);
			var retstat1 = "true";
			if(retstat !="true"||retstat1!="true" ) {
			 return "interactive";
			}
			}
//Changes for call id: 389624 and recon for TOL 388300 End
			temp = saveDemo(acctID,EntityType, newflg,blFlag);
			}
			if(temp == true){
				return "true";
			}else{
				return "false";
			}
		}else {
			showMessage(MSGX0041);
			return false;
}

}
//Changes begin for Tracker:97346

 function check(Tab,setFlag) {

	//Changes begin for Ticket 199750
		var Faxno = document.getElementsByName("DemographicBO.MiscellaneousInfo.strText8")[0].value;
		if(isNaN(Faxno))
		{
		     document.getElementsByName("DemographicBO.MiscellaneousInfo.strText8")[0].value = '';
		}
	//Changes end for Ticket 199750
	if(setFlag == false) {
		noValidationMsg = true;
	}
	else {
		noValidationMsg = false;
	}
    //Changes for call id 344642 STARTS
	    	if (byPassFlag=='Y' &amp;&amp; setFlag == false){
	    	noValidationMsg = false;
	}
    //Changes for call id 344642 ENDS
        return parent.parent.parent.parent.ValidateFormContents(document.frm2,true,noValidationMsg,Tab);

       }
function setFocusOnComp(compName) {
	    var elementName = document.getElementsByName(compName)[0];
	    if(elementName) {
		if(elementName.displayFieldName){
			elementName = document.getElementsByName(elementName.displayFieldName)[0];
		}
		/*Tracker 110987 CRM101ME MATT Chngs BEGIN*/
		try{
		  var ids = elementName.parentElement.parentElement.parentElement.parentElement.parentElement.id;
		  ids = trim(ids.replace("det_",""));
		  eval("showTabFortabDemoForm('"+ids+"')");
		}catch(e){}
		/*Tracker 110987 CRM101ME MATT Chngs END*/

		if (elementName.type == "text" || elementName.type == "textarea")
		{
			elementName.select();
		}else{
			elementName.focus();
		}
	    }
   }
//Changes end for Tracker:97346

    function saveDemo(accountId,Type, newflg,blFlag) {
	// change for call id 351006 and 353234 start
	var channelsacc = document.frm2.ChannelsAccessed.length;
	var sChAccessed = "";
	for (i=0; i &lt; document.frm2.ChannelsAccessed.length; i++) {
	//Change for TOL 650756 starts
	//sChAccessed += document.frm2.ChannelsAccessed.options[i].value + ",";
	if(i== 0){
		sChAccessed += document.frm2.ChannelsAccessed.options[i].value ;
	}else{
		sChAccessed += ","+ document.frm2.ChannelsAccessed.options[i].value ;
	}
	//Change for TOL 650756 ends
	}
	try{
	document.frm2.ChsAccessed.value = sChAccessed;
	}catch(e)
	{ }
	// change for call id 351006 and 353234 end


   // CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES **
        try{
		customSave();
		}
        catch(e)
        { }
        //changes for employer details
         EnableCategoryLookup();
    // CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES  **
        try{
/*IDENTIFICATION DOCUMENT CHANGES start*/
		   <!-- ERPBOCF1 CIF Usability Tracker ID 113276 changes start -->
         /* if(Type == "Account"){
			if(custNREFlg == "Y")	//passport details required for NRE Customer
			{
				if(document.getElementsByName("Passport Number.txt_ID")[0].value=="")
				{
					showMessage(MSGJ0059);
					return "false";
				}
			}
			chkMinID = document.all.EDocRecordSet.rows.length - 2;
			if(blFlag == true)
			{
				if(chkMinID &lt;= 0)
				{
					parent.parent.parent.parent.messageFrm.removeMessages(selTabId);
					parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_DEFID",""),TBODY_EDocRecordSet.rows ,'NO_HLINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					showTabFortabDemoForm('tpageODet');
					//Tracker 96667 changes BEGIN
					//showTabFortabIDDocForm('tpageIDDoc');
					//Tracker 96667 changes BEGIN
					document.all.AddIdentificationDetails.focus();
					return "interactive"
				}			}

		}*/
<!-- ERPBOCF1 CIF Usability Tracker ID 113276 changes end -->
		/*var noOfEdoc = document.all.EDocRecordSet.rows.length - 2;

		if(blFlag == true){
			if(noOfEdoc &gt; 0){
				if(uniqueID == null || uniqueID == "undefined" || uniqueID == "")
				{
					showMessage(MSGJ50573);
					return "false";
				}
			}

		}*/
		/* 113276 CHANGES END */

/*IDENTIFICATION DOCUMENT CHANGES end*/
		var elem1 = document.getElementsByName("3_DemographicBO.MiscellaneousInfo.dtDate1")[0];
		var error = tocheck() ;
		if( error == "DOJ"){
		  var  selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
		  parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_DOJ",""),elem1.name, 'HYPER_LINK');
		  parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		  return ;
		}
		if( error == "DOL"){
		   selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
		   parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSG_DOL",""),elem1.name, 'HYPER_LINK');
		   parent.parent.parent.parent.messageFrm.showMessages(selTabId);
		   return ;
		}



          try{
               var elem = document.getElementsByName(boName+".Employment_Status")[0];

               if(elem.options[elem.selectedIndex].value == "Self employed"){
                   var estvalue_SelfEmpl = document.getElementsByName("3_DemographicBO.TotalEstAccountValue_SelfEmployed")[0].value;
                   var estvalue = document.getElementsByName("3_DemographicBO.TotalEstAccountValue")[0];
                   estvalue.value =  estvalue_SelfEmpl;
                   var CU_estvalue = document.getElementsByName(boName+".CU_TotalEstAccountValue")[0];
                   CU_estvalue.value = document.getElementsByName(boName+".CU_TotalEstAccountValue_SelfEmployed")[0].value;
	//Changes for call id 418204 start
               }else{
               	   var estvalue_SelfEmpl = document.getElementsByName("3_DemographicBO.TotalEstAccountValue_SelfEmployed")[0];
                   var estvalue = document.getElementsByName("3_DemographicBO.TotalEstAccountValue")[0];
                   estvalue_SelfEmpl.value=estvalue.value;
                   var CU_estvalue = document.getElementsByName(boName+".CU_TotalEstAccountValue_SelfEmployed")[0];
                   CU_estvalue.value = document.getElementsByName(boName+".CU_TotalEstAccountValue")[0].value;	
               }
	//Changes for call id 418204 end
           }catch(e){
           }
            noOfEdu = edu_URL.length;
            addEduCounter = 0 ;
            clearValues();
try {
            for(var i = 0; i &lt; noOfEdu; i++) {
                //if(edu_URL[i] != null &amp;&amp; !(edu_Status[i] == "Add" || edu_Status[i] == "Remove" || isCopy == "Y")) {
                 //tracker 84836
                 if((edu_URL[i] != null) &amp;&amp; !(edu_Status[i] == "Remove")) {

                    if(addEduCounter == 0) {
                        document.frm2.Institution.value = srmEscape(edu_institute[i], '^', escChars);
                        document.frm2.Qualification.value = srmEscape(edu_qualification[i], '^', escChars);
                        document.frm2.AddressLine1.value = srmEscape(edu_addressLine1[i], '^', escChars);
                        document.frm2.AddressLine2.value = srmEscape(edu_addressLine2[i], '^', escChars);
                        document.frm2.AddressLine3.value = srmEscape(edu_addressLine3[i], '^', escChars);
                        document.frm2.City.value = srmEscape(edu_city[i], '^', escChars);
                        document.frm2.State.value = srmEscape(edu_state[i], '^', escChars);
                        document.frm2.Country.value = srmEscape(edu_country[i], '^', escChars);
                        document.frm2.Zip.value = srmEscape(edu_zip[i], '^', escChars);
                        document.frm2.ClubMembership.value = srmEscape(edu_clubMember[i], '^', escChars);
                        document.frm2.EduURL.value = srmEscape(edu_URL[i], '^', escChars);
                        document.frm2.EduID.value = srmEscape(edu_detID[i], '^', escChars);
                        document.frm2.MarksPercent.value = srmEscape(edu_marksPercent[i], '^', escChars);
			/***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/

			var strALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
			var strGradDate = edu_gradDate[i];

			if(strALTCALENDAR_TYPE = 'true')
			{
				if(strGradDate != '')

				{
					var strFlag = isGregDateWithoutConv(strGradDate);
					if(strFlag != 'true')
					{
						strGradDate=convertHijToGreg(strGradDate);
					}
				}
			}
			edu_gradDate[i] = strGradDate;

			/***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
                        document.frm2.gradDate.value = srmEscape(edu_gradDate[i], '^', escChars);
//                        document.frm2.DD.value = srmEscape(edu_DD[i], '^', escChars);
//                        document.frm2.YY.value = srmEscape(edu_YY[i], '^', escChars);
                        document.frm2.MainSubject.value  = srmEscape(edu_mainSubject[i], '^', escChars);
                        document.frm2.MClass.value = srmEscape(edu_Class[i], '^', escChars);
                        document.frm2.MarksObtained.value = srmEscape(edu_marksObtained[i], '^', escChars);
                        addEduCounter = 1;
                    }else{
                        document.frm2.Institution.value = document.frm2.Institution.value + " ," + srmEscape(edu_institute[i], '^', escChars);
                        document.frm2.Qualification.value = document.frm2.Qualification.value + " ," + srmEscape(edu_qualification[i], '^', escChars);
                        document.frm2.AddressLine1.value = document.frm2.AddressLine1.value + " ," + srmEscape(edu_addressLine1[i], '^', escChars);
                        document.frm2.AddressLine2.value = document.frm2.AddressLine2.value + " ," + srmEscape(edu_addressLine2[i], '^', escChars);
                        document.frm2.AddressLine3.value = document.frm2.AddressLine3.value + " ," + srmEscape(edu_addressLine3[i], '^', escChars);
                        document.frm2.City.value = document.frm2.City.value + " ," + srmEscape(edu_city[i], '^', escChars);
                        document.frm2.State.value = document.frm2.State.value + " ," + srmEscape(edu_state[i], '^', escChars);
                        document.frm2.Country.value = document.frm2.Country.value + " ," + srmEscape(edu_country[i], '^', escChars);
                        document.frm2.Zip.value = document.frm2.Zip.value + " ," + srmEscape(edu_zip[i], '^', escChars);
                        document.frm2.ClubMembership.value = document.frm2.ClubMembership.value + " ," + srmEscape(edu_clubMember[i], '^', escChars);
                        document.frm2.EduURL.value = document.frm2.EduURL.value + " ," + srmEscape(edu_URL[i], '^', escChars);
                        document.frm2.EduID.value = document.frm2.EduID.value + " ," + srmEscape(edu_detID[i], '^', escChars);
                        document.frm2.MarksPercent.value = document.frm2.MarksPercent.value + " ," + srmEscape(edu_marksPercent[i], '^', escChars);
                        /* Changes for the tracker 181151 starts */
                        /* document.frm2.Month.value = document.frm2.Month.value + " ," + srmEscape(edu_Month[i], '^', escChars); */
                        /* Changes for the tracker 181151 ends *
                       /***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/

			var strALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
			var strGradDate = edu_gradDate[i];

			if(strALTCALENDAR_TYPE = 'true')
			{
				if(strGradDate != '')
				{


					var strFlag = isGregDateWithoutConv(strGradDate);
					if(strFlag != 'true')
					{
						strGradDate=convertHijToGreg(strGradDate);
					}
				}
			}
			edu_gradDate[i] = strGradDate;

			/***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
                        document.frm2.gradDate.value = document.frm2.gradDate.value + " ," + srmEscape(edu_gradDate[i], '^', escChars);
//                        document.frm2.DD.value = document.frm2.DD.value + " ," + srmEscape(edu_DD[i], '^', escChars);
//                        document.frm2.YY.value = document.frm2.YY.value + " ," + srmEscape(edu_YY[i], '^', escChars);
                        document.frm2.MainSubject.value = document.frm2.MainSubject.value + " ," + srmEscape(edu_mainSubject[i], '^', escChars);
                        document.frm2.MClass.value = document.frm2.MClass.value + " ," + srmEscape(edu_Class[i], '^', escChars);
                        document.frm2.MarksObtained.value = document.frm2.MarksObtained.value + " ," + srmEscape(edu_marksObtained[i], '^', escChars);
                    }
                }
            }
} catch(ge) { DebugMessage(ge.message); }
            document.frm2.EduRemoved.value = getCSVforArray(edu_detachedURLs);
            var flag = false;
            if(accountId != null &amp;&amp; accountId != "0" ){
             /* Changes for Tracker id: 278988 and Ticket Id: 461060 Starts Here */
	                  if(operationType!="Edit Entity"){ 
	    	ToTalIncomeHouseHold();
	     /*Tracker ID: 142359 Changes begins */
	                    ToTalIncome();
	      /*Tracker ID: 142359 Changes ends */
	    		/*ticket id 220540 tracker id 132316 changes starts*/
	                   ToTalExp();
	                   	/*ticket id 220540 tracker id 132316 changes ends*/
	                   	               }
               /* Changes for Tracker id: 278988 and Ticket Id: 461060 Ends Here */ 

                <!-- CRM62MNT:TRACKER# 55270 **BEGIN   CHANGES** -->
                //document.frm2.elements("DemographicBO.CU_Annual_Total_Exp").disabled = false;
                //document.frm2.elements("DemographicBO.CU_Annual_Total_Income").disabled = false;
				<!-- CRM62MNT:TRACKER# 55270 **END   CHANGES** -->

                document.frm2.elements(boName+".CU_TotalHouseholdIncm").disabled = false;
		//passing account Key
		if(Type == "Account"){
		document.getElementsByName("accKey")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("accKey")[0].value;
		var accountKey = document.frm2.accKey.value;
		document.getElementsByName("ModAccID")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("ModAccID")[0].value;
		document.getElementsByName("CoreCustID")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("CoreCustID")[0].value;
		}
		else if(Type == "Suspect"){
			document.getElementsByName("accKey")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("susKey")[0].value;
			document.getElementsByName("ModAccID")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("modSusID")[0].value;
		}
		else if(Type == "Contact") {
			document.getElementsByName("accKey")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("contKey")[0].value;
			document.getElementsByName("ModAccID")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("modContID")[0].value;
		}
		/* CIF Changes - EmploymentHistory MultiRec Start */
		setHiddenFields();
		/* CIF Changes - EmploymentHistory MultiRec End */
/*IDENTIFICATION DOCUMENT CHANGES start*/
                 //Tracker-209607
		//setHiddenIDFields();
/*IDENTIFICATION DOCUMENT CHANGES end*/
       /********* Save and Submit Changes : Setting saveFlag=1 for SAVE and saveFlag=0 and operationType to the Writer for SUBMIT:Start***********/
		if(blFlag == true)
		{
			document.frm2.saveFlag.value = 0;
		}
		else
		{
			document.frm2.saveFlag.value = 1;
		}
		if(document.frm2.byPassFlag.value!="Y"){
		/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
		 fnConvertDate();
		 /*ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/
	    }
		 	<!--tracker id 113227 starts-->
		 	/* TrackerID:209607,CHANGES START */
		 	/*Null Changes Begin*/
		 	  var frame = 'formSaveFrame';
		 	  newPara = document.getElementById("myPar");
			  	  /****10.2.18: 800677***/
			  		//Added to check the accountid 
			if(accountId=="")
			{
			accountId=accId;
			
			}
/****10.2.18: 800677***/
		 	  demoURL="../servlet/com.infy.cis.ui.common.DemographicWriter?accountId=" + accountId +'&amp;operationType=' + operationType +'&amp;Type=' + Type + '&amp;newflag=' + newflg+'&amp;editFrom=CIF&amp;isCopy='+isCopy+'&amp;dual=' +dualflag ;
		 	  fnRemoveNull(newPara,demoURL,document.frm2,frame);
		 	/*Null changes End*/ 
		 	/* TrackerID:209607,CHANGES END */
		  //document.frm2.action = "../servlet/com.infy.cis.ui.common.DemographicWriter?accountId=" + accountId +'&amp;operationType=' + operationType +'&amp;Type=' + Type + '&amp;newflag=' + newflg+'&amp;editFrom=CIF&amp;isCopy='+isCopy ;
		  /* TrackerID:209607,CHANGES START */
		 //document.frm2.action = "../servlet/com.infy.cis.ui.common.DemographicWriter?accountId=" + accountId +'&amp;operationType=' + operationType +'&amp;Type=' + Type + '&amp;newflag=' + newflg+'&amp;editFrom=CIF&amp;isCopy='+isCopy+'&amp;dual=' +dualflag ;
		 /* TrackerID:209607,CHANGES START */
        /*113066 End of changse ME start*/
<!--tracker id 113227 ends-->
	    /********* Save and Submit Changes : Setting saveFlag=1 for SAVE and saveFlag=0 and operationType to the Writerfor SUBMIT:End***********/
	    /* TrackerID:209607,CHANGES START */
                //document.frm2.target='formSaveFrame';
                //document.frm2.submit();
                /* TrackerID:209607,CHANGES START */
                flag = true;
            }
            clearValues();
/*IDENTIFICATION DOCUMENT CHANGES start*/
            //Tracker-209607
           // clearIDValues();
/*IDENTIFICATION DOCUMENT CHANGES end*/
            return flag;
        }catch(e){
        DebugMessage(e.message);
        }
    }
    	//Changes for call id 433698 STARTS
	function disableFields(){
		document.frm2.elements("3_DemographicBO.Residence_Since").disabled = true;
		 /*Call ID: 583535 Changes Starts */ 
                   if(document.frm2.elements("Cat_DemographicBO.Residence_Country").value != null &amp;&amp; document.frm2.elements("Cat_DemographicBO.Residence_Country").value != ""){ 
                   document.frm2.elements("3_DemographicBO.Residence_Since").disabled = false; 
                   } 
    /*Call ID: 583535 Changes Ends */ 

		document.getElementsByTagName("img")[0].style.display="";
        document.getElementsByTagName("img")[0].style.visibility = "hidden"; 
		

	}
    	function enableFields(){
    		document.frm2.elements("3_DemographicBO.Residence_Since").disabled = false;
			document.getElementsByTagName("img")[0].style.display="";
            document.getElementsByTagName("img")[0].style.visibility = "visible"; 
	} 
	//Changes for call id 433698 ENDS
        function PreviousEmploymentDetails(){
        try{
            //parent.parent.parent.parent.formTopDispFrame.document.getElementsByName("WorkExtension")[0].readonly = false;
            //var Extension = parent.parent.parent.parent.formTopDispFrame.document.getElementsByName("WorkExtension")[0].value;
            //var Obj = document.getElementsByName("DemographicBO.Extension")[0];
           // Obj.value = Extension;
			<!-- CRM62MNT:TRACKER# 55270 **BEGIN   CHANGES** -->
            //document.frm2.elements("3_DemographicBO.Annual_Total_Exp").readOnly = true;
            //document.frm2.elements("3_DemographicBO.Annual_Total_Income").readOnly = true;
			<!-- CRM62MNT:TRACKER# 55270 **END   CHANGES** -->
            document.frm2.elements("3_DemographicBO.TotalHouseholdIncm").readOnly = true;
        }catch(e){
        }
        try{
            var PreviousProfessios = '<xsl:value-of select="//SRMData[@SRMDataSpace='PREVIOUSEMPLOYMENT']/SRMComposite[@n='RecordSet']/SRMRow/Z[@n='DemographicBO.MiscellaneousInfo.strText2']"/>';
            var PreviousIndustry = '<xsl:value-of select="//SRMData[@SRMDataSpace='PREVIOUSEMPLOYMENT']/SRMComposite[@n='RecordSet']/SRMRow/Z[@n='DemographicBO.MiscellaneousInfo.strText3']"/>';
            var PreviousDesig = '<xsl:value-of select="//SRMData[@SRMDataSpace='PREVIOUSEMPLOYMENT']/SRMComposite[@n='RecordSet']/SRMRow/Z[@n='DemographicBO.MiscellaneousInfo.strText8']"/>';
            var profession = document.getElementsByName("DemographicBO.EmploymentHistory.strText2")[0];
            var Industry = document.getElementsByName("DemographicBO.EmploymentHistory.strText3")[0];
            var Designation = document.getElementsByName("DemographicBO.EmploymentHistory.strText8")[0];
            profession.value = PreviousProfessios;
            Industry.value = PreviousIndustry;
            Designation.value = PreviousDesig;
        }catch(e){
        }
    }
    function formatDemographyAmount()
    {

	try{
		<!--CRM10.2ST:TrackerID:161298 Begin of Change-->
		var cu_GrossSalary = document.frm2.elements(boName+".CU_Annual_Salary_Income").value
		if(cu_GrossSalary=='' || cu_GrossSalary ==null)
		{
			document.getElementsByName("3_DemographicBO.Annual_Salary_Income")[0].value="";
		}
		<!--CRM10.2ST:TrackerID:161298 End of Change-->
	    <!-- CRM102Sanity: TrackerID:166781 Being of change-->
	    baseCurrency = '<xsl:value-of select="$currency"/>';
	    <!-- CRM102Sanity: TrackerID:166781 End of change-->
		formatAmount("3_DemographicBO.Annual_Salary_Income",boName+".CU_Annual_Salary_Income","N");
		formatAmount("3_DemographicBO.Annual_Rental_Income",boName+".CU_Annual_Rental_Income","N");
		formatAmount("3_DemographicBO.Annual_Stock_Bond_Income",boName+".CU_Annual_Stock_Bond_Income","N");
 /* Tracker id 113276 changes start */
		<!-- Changes for trackerid:-196638 Changes Start-->
		formatAmount("3_DemographicBO.Annual_Others_Income",boName+".CU_Annual_Others_Income","N");
 		<!-- Changes for trackerid:-196638 Changes End-->
 /* Tracker id 113276 changes end */
		formatAmount("3_DemographicBO.Annual_Operating_Exp",boName+".CU_Annual_Operating_Exp","N");
		formatAmount("3_DemographicBO.Annual_Loan_Instal",boName+".CU_Annual_Loan_Instal","N");
		formatAmount("3_DemographicBO.Annual_IntProd_Exp",boName+".CU_Annual_IntProd_Exp","N");
		formatAmount("3_DemographicBO.Annual_ExtProd_Exp",boName+".CU_Annual_ExtProd_Exp","N");
		formatAmount("3_DemographicBO.Annual_Commit_Exp",boName+".CU_Annual_Commit_Exp","N");
		formatAmount("3_DemographicBO.Annual_Other_Exp",boName+".CU_Annual_Other_Exp","N");
		formatAmount("3_DemographicBO.SalAllowances",boName+".CU_SalAllowances","N");
		formatAmount("3_DemographicBO.SalProrataMonthlyIncentive",boName+".CU_SalProrataMonthlyIncentive","N");
		formatAmount("3_DemographicBO.SalInterestSubsidy",boName+".CU_SalInterestSubsidy","N");
		formatAmount("3_DemographicBO.SalOtherIncome2",boName+".CU_SalOtherIncome2","N");
		formatAmount("3_DemographicBO.SalOtherIncome3",boName+".CU_SalOtherIncome3","N");
		formatAmount("3_DemographicBO.TotalEstAccountValue",boName+".CU_TotalEstAccountValue","N");
		formatAmount("3_DemographicBO.TotalMonthlyDebtServiceAmt",boName+".CU_TotalMonthlyDebtServiceAmt","N");
		formatAmount("3_DemographicBO.SelfempGrossReciptCurrentYR",boName+".CU_SelfempGrossReciptCurrentYR","N");
		formatAmount("3_DemographicBO.SelfempGrossReceiptPriorYear",boName+".CU_SelfempGrossReceiptPriorYear","N");
		formatAmount("3_DemographicBO.SelfempNetProfitCurrentYR",boName+".CU_SelfempNetProfitCurrentYR","N");
		formatAmount("3_DemographicBO.SelfempNetProfitPriorYR",boName+".CU_SelfempNetProfitPriorYR","N");
		formatAmount("3_DemographicBO.SelfempDepreciationCurrentYear",boName+".CU_SelfempDepreciationCurrentYear","N");
		formatAmount("3_DemographicBO.SelfempDepreciationPriorYear",boName+".CU_SelfempDepreciationPriorYear","N");
		formatAmount("3_DemographicBO.SelfempAverageAnnualTurnover",boName+".CU_SelfempAverageAnnualTurnover");
		formatAmount("3_DemographicBO.TotalInvestmentInSharesandUnits",boName+".CU_TotalInvestmentInSharesandUnits");
		formatAmount("3_DemographicBO.TotalEstAccountValue_SelfEmployed",boName+".CU_TotalEstAccountValue_SelfEmployed");
<!-- CRM62MNT:TRACKER# 55270 **BEGIN   CHANGES** -->
		//document.frm2.elements("DemographicBO.CU_Annual_Total_Exp").disabled = false;
		//document.frm2.elements("DemographicBO.CU_Annual_Total_Exp").value =baseCurrency;
		//formatAmount("3_DemographicBO.Annual_Total_Exp","DemographicBO.CU_Annual_Total_Exp","N");
		//document.frm2.elements("DemographicBO.CU_Annual_Total_Exp").disabled = true;
		//document.frm2.elements("DemographicBO.CU_Annual_Total_Income").disabled = false;
		//document.frm2.elements("DemographicBO.CU_Annual_Total_Income").value =baseCurrency;
		//formatAmount("3_DemographicBO.Annual_Total_Income","DemographicBO.CU_Annual_Total_Income","N");
		//document.frm2.elements("DemographicBO.CU_Annual_Total_Income").disabled = true;
<!-- CRM62MNT:TRACKER# 55270 **END   CHANGES** -->
		document.frm2.elements(boName+".CU_TotalHouseholdIncm").disabled = false;
		document.frm2.elements(boName+".CU_TotalHouseholdIncm").value =baseCurrency;
		formatAmount("3_DemographicBO.TotalHouseholdIncm",boName+".CU_TotalHouseholdIncm","N");
		document.frm2.elements(boName+".CU_TotalHouseholdIncm").disabled = true;
		//Field Addition Tracker 172089:start of Changes
		formatAmount("3_DemographicBO.income_from",boName+".CU_income_from","N");
		formatAmount("3_DemographicBO.income_to",boName+".CU_income_to","N");
if(document.frm2.elements(boName+".CU_income_from").value =='' || document.frm2.elements(boName+".CU_income_from").value  ==null){
	document.frm2.elements(boName+".CU_income_from").value =baseCurrency;
}
if(document.frm2.elements(boName+".CU_income_to").value=='' || document.frm2.elements(boName+".CU_income_to").value ==null){
		document.frm2.elements(boName+".CU_income_to").value =baseCurrency;
		}
		//Field Addition Tracker 172089:end of Changes
	// CORE Fields Inclusion  -- Begin
		formatAmount("3_DemographicBO.TotalFundBase",boName+".CU_TotalFundBase");
		formatAmount("3_DemographicBO.TotalNonFundBase",boName+".CU_TotalNonFundBase");
		formatAmount("3_DemographicBO.OtherLimits",boName+".CU_OtherLimits");
/* Changes for Tracker # 88712 Start */
		formatAmount("3_DemographicBO.CustBusinessAssets",boName+".CU_CustBusinessAssets");
		formatAmount("3_DemographicBO.CustPropertyAssets",boName+".CU_CustPropertyAssets");
		formatAmount("3_DemographicBO.CustDepositsInOtherBanks",boName+".CU_CustDepositsInOtherBanks");
/* Changes for Tracker # 88712 End */
/*Changes for Ticket#355435 begin*/
formatAmount("3_DemographicBO.CustNetWorth",boName+".CU_CustNetWorth");
/*Changes for Ticket#355435 end*/
	// CORE Fields Inclusion  -- End
	//Tracker 167815 changes:start
		 if(baseCurrency=='' || baseCurrency ==null){
baseCurrency =	cu_GrossSalary;
}
//Tracker 167815 changes: end
	}
	catch(e)
	{
	}
   }
//Changes for call id 434730 STARTS   
   function formatfields(){  
	try{
	var strText5 = document.getElementsByName('DemographicBO.MiscellaneousInfo.strText5')[0].value;
	strText5 = strText5.substring(0, strText5.length - 1);
	document.getElementsByName('DemographicBO.MiscellaneousInfo.strText5')[0].value = strText5;
	var strText6 = document.getElementsByName('DemographicBO.MiscellaneousInfo.strText6')[0].value;
	strText6 = strText6.substring(0, strText6.length - 1);
	document.getElementsByName('DemographicBO.MiscellaneousInfo.strText6')[0].value = strText6;
	var strText28 = document.getElementsByName('DemographicBO.MiscellaneousInfo.strText28')[0].value;
	strText28 = strText28.substring(0, strText28.length - 1);
	document.getElementsByName('DemographicBO.MiscellaneousInfo.strText28')[0].value = strText28;
	}catch(e){}
   }
//Changes for call id 434730 ENDS   
        function load(){
			//changes for call id:766708 starts
		try
		{
			document.getElementsByName('Cat_DemographicBO.MiscellaneousInfo.strText9')[0].value=empDesignation;
		}
		catch(e)
		{
		}
		//changes for call id:766708 ends
        /*TRACKER ID 119729 CHANGES BEGIN FOR TICKECT ID 200754*/
        //If local code is "+()" update its value to an empty string so that
        if(document.getElementsByName('DemographicBO.MiscellaneousInfo.strText8.localcode')[0].value == "+()")
        {
        	document.getElementsByName('DemographicBO.MiscellaneousInfo.strText8.localcode')[0].value = "";
        }
        /*TRACKER ID 119729 CHANGES END FOR TICKECT ID 200754*/

        <!--Tracker id 113227 start here-->
	 document.frm2.altLocaleActv.value='<xsl:value-of select="$altLocaleActv"/>';
	 <!--Tracker id 113227 end here-->
        // CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES **
        try{
        customLoad();
        }catch(e)
        { }
    // CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES  **
            try{
      		var obj = parent.parent.parent.parent.frames(3);
                  	obj.enableButton_Ub();
    	}catch(e)
    	{ }
            try{
            fnEnableFields();
        //employer details
//xml encoding changes -- start
	    if(boName=='DemographicBO'){
            if(document.frm2.hid_demographicID.value != '') {
                editMode = true;
                for (i=0; i &lt; document.all.EduDetRecordSet.rows.length; i++) {
                    var existId = '';
			if(mainAccId !=""){
					existId =document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.MainTableID");
			} else {
					existId =document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.MiscellaneousID");
			}
                    if ((existId != null) &amp;&amp; (existId != 'undefined')) {
				Address_Line1 = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText2");
				Address_Line2 = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText3");
				Address_Line3 = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText5");
				Institution = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText4");
				Qualification = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText10");
				City = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText6");
				City_Cat = document.all.EduDetRecordSet.rows(i).getAttribute("Cat_DemographicBO.MiscellaneousInfo.strText6");
				State = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText7");
				State_Cat = document.all.EduDetRecordSet.rows(i).getAttribute("Cat_DemographicBO.MiscellaneousInfo.strText7");
				Country = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText8");
				Country_Cat = document.all.EduDetRecordSet.rows(i).getAttribute("Cat_DemographicBO.MiscellaneousInfo.strText8");
				ClubMembership = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText15");
				Zip = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText16");
				MarksPercent = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.dbFloat3");
				gradDate = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.dtDate4");
	//			DD = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.intInteger13");
	//			YY = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.intInteger12");
				MainSubject = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText22");
				MClass = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText23");
				MarksObtained = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.intInteger14");
                        edu_addressLine1[edu_addressLine1.length] = Address_Line1;
                        edu_addressLine2[edu_addressLine2.length] = Address_Line2;
                        edu_addressLine3[edu_addressLine3.length] = Address_Line3;
                        edu_institute[edu_institute.length] = Institution;
                        edu_qualification[edu_qualification.length] = Qualification;
                        edu_city[edu_city.length] = City;
                        edu_city_cat[edu_city_cat.length] = City_Cat;
                        edu_state[edu_state.length] = State;
                        edu_state_cat[edu_state_cat.length] = State_Cat;
                        edu_country[edu_country.length] = Country;
                        edu_country_cat[edu_country_cat.length] = Country_Cat;
                        edu_zip[edu_zip.length] = Zip;
                        edu_clubMember[edu_clubMember.length] = ClubMembership;
                        edu_marksPercent[edu_marksPercent.length] = MarksPercent;
				edu_gradDate[edu_gradDate.length] = gradDate;
	//                        edu_DD[edu_DD.length] = DD;
	//                        edu_YY[edu_YY.length] = YY;
                        edu_mainSubject[edu_mainSubject.length] = MainSubject;
                        edu_Class[edu_Class.length] = MClass;
                        edu_marksObtained[edu_marksObtained.length] = MarksObtained;
                        edu_detID[edu_detID.length] = existId;
                        edu_URL[edu_URL.length] = Institution + Qualification;
                        edu_Status[edu_Status.length] = "Add";
				document.all.EduDetRecordSet.rows(i).setAttribute("DemographicBO.MiscellaneousInfo.url_", Institution + Qualification);
                    }
                }
            } else {
                for (i=0; i &lt; document.all.EduDetRecordSet.rows.length; i++) {
			    var existId = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.MiscellaneousID");
                    if ((existId != null) &amp;&amp; (existId != 'undefined')) {
				Qualification = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText10");
				Institution = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicBO.MiscellaneousInfo.strText4");
				document.all.EduDetRecordSet.rows(i).setAttribute("DemographicBO.MiscellaneousInfo.strText10", Qualification);
				document.all.EduDetRecordSet.rows(i).setAttribute("DemographicBO.MiscellaneousInfo.strText4", Institution);
                        edu_institute[edu_institute.length] = Institution;
                        edu_qualification[edu_qualification.length] = Qualification;
                        edu_id[edu_id.length] = existId;
                    }
                }
              }
	   }else if(boName=='DemographicModBO'){
                  if(document.frm2.hid_demographicID.value != '') {
			editMode = true;
			for (i=0; i &lt; document.all.EduDetRecordSet.rows.length; i++) {
			    var existId = '';
				//Fix for call id: 446063
				if(mainAccId !="" &amp;&amp; boName=='DemographicBO'){
					existId =document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.MainTableID");
				} else {
					existId =document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.MiscellaneousID");
				}
			    if ((existId != null) &amp;&amp; (existId != 'undefined')) {
				Address_Line1 = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText2");
				Address_Line2 = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText3");
				Address_Line3 = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText5");
				Institution = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText4");
				Qualification = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText10");
				City = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText6");
				City_Cat = document.all.EduDetRecordSet.rows(i).getAttribute("Cat_DemographicModBO.MiscellaneousInfo.strText6");
				State = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText7");
				State_Cat = document.all.EduDetRecordSet.rows(i).getAttribute("Cat_DemographicModBO.MiscellaneousInfo.strText7");
				Country = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText8");
				Country_Cat = document.all.EduDetRecordSet.rows(i).getAttribute("Cat_DemographicModBO.MiscellaneousInfo.strText8");
				ClubMembership = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText15");
				Zip = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText16");
				MarksPercent = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.dbFloat3");
				//Sonali changes for 297421
				gradDate = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.dtDate4");
	//			DD = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.intInteger13");
	//			YY = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.intInteger12");
				MainSubject = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText22");
				MClass = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText23");
				MarksObtained = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.intInteger14");
				edu_addressLine1[edu_addressLine1.length] = Address_Line1;
				edu_addressLine2[edu_addressLine2.length] = Address_Line2;
				edu_addressLine3[edu_addressLine3.length] = Address_Line3;
				edu_institute[edu_institute.length] = Institution;
				edu_qualification[edu_qualification.length] = Qualification;
				edu_city[edu_city.length] = City;
				edu_city_cat[edu_city_cat.length] = City_Cat;
				edu_state[edu_state.length] = State;
				edu_state_cat[edu_state_cat.length] = State_Cat;
				edu_country[edu_country.length] = Country;
				edu_country_cat[edu_country_cat.length] = Country_Cat;
				edu_zip[edu_zip.length] = Zip;
				edu_clubMember[edu_clubMember.length] = ClubMembership;
				edu_marksPercent[edu_marksPercent.length] = MarksPercent;
				edu_gradDate[edu_gradDate.length] = gradDate;
	//                        edu_DD[edu_DD.length] = DD;
	//                        edu_YY[edu_YY.length] = YY;
				edu_mainSubject[edu_mainSubject.length] = MainSubject;
				edu_Class[edu_Class.length] = MClass;
				edu_marksObtained[edu_marksObtained.length] = MarksObtained;
				edu_detID[edu_detID.length] = existId;
				edu_URL[edu_URL.length] = Institution + Qualification;
				edu_Status[edu_Status.length] = "Add";
				document.all.EduDetRecordSet.rows(i).setAttribute("DemographicModBO.MiscellaneousInfo.url_", Institution + Qualification);
			    }
		       }
		   } else {
			for (i=0; i &lt; document.all.EduDetRecordSet.rows.length; i++) {
			    var existId = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.MiscellaneousID");
			    if ((existId != null) &amp;&amp; (existId != 'undefined')) {
				Qualification = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText10");
				Institution = document.all.EduDetRecordSet.rows(i).getAttribute("DemographicModBO.MiscellaneousInfo.strText4");
				document.all.EduDetRecordSet.rows(i).setAttribute("DemographicModBO.MiscellaneousInfo.strText10", Qualification);
				document.all.EduDetRecordSet.rows(i).setAttribute("DemographicModBO.MiscellaneousInfo.strText4", Institution);
				edu_institute[edu_institute.length] = Institution;
				edu_qualification[edu_qualification.length] = Qualification;
				edu_id[edu_id.length] = existId;
			    }
			}
		   }
	   }
//xml encoding changes -- end
	/*  CIF Changes - EmploymentHistory MultiRec Start */
		loadEmpHist();
	/*  CIF Changes - EmploymentHistory MultiRec End   */
	//Changes for Tracker Id: 273325  - start
	/*if(document.frm2.byPassFlag.value=='Y'){
			showIncomeTabOnly();
	}*/
	//Changes for Tracker id Id: 273325  - End
// CORE Fields Inclusion  -- Begin
	if(NRECountryType != ''){
	//fix for Tracker 180656:start
		var elem = document.getElementsByName(boName+".NRECountryType")[0].value;
	//fix for Tracker 180656:end
		if(NRECountryType=='B')
			elem.value = 'BILATERAL';
		else elem.value = 'EXTERNAL';
	}
// CORE Fields Inclusion  -- End
            }catch(e){
            //alert(e.msg)
            }
		//changes for call id 407866 and recon of call id 400498 starts
            document.getElementsByName(boName + '.MiscellaneousInfo.StrText2_code')[0].value = '<xsl:value-of select="$strText2_code"/>';
		//changes for call id 407866 and recon of call id 400498 ends
        }
var previous_selection = '';

//Changes for tracker Id: 273325  - start
/* function showIncomeTabOnly(){
 		document.getElementById("td_tpageCont").disabled = true;
 		document.getElementById("td_tpageCont").style.visibility="hidden";
		document.getElementById("det_tpageCont").style.visibility="hidden";
		hideDetailstabDemoForm('tpageCont');

		document.getElementById("td_tpageQual").disabled = true;
		document.getElementById("td_tpageQual").style.visibility="hidden";
		document.getElementById("det_tpageQual").style.visibility="hidden";
		hideDetailstabDemoForm('tpageQual');

		document.getElementById("td_tpageEDet").disabled = true;
		document.getElementById("td_tpageEDet").style.visibility="hidden";
		document.getElementById("det_tpageEDet").style.visibility="hidden";
		hideDetailstabDemoForm('tpageEDet');

		document.getElementById("td_tpageODet").disabled = true;
		document.getElementById("td_tpageODet").style.visibility="hidden";
		document.getElementById("det_tpageODet").style.visibility="hidden";
		hideDetailstabDemoForm('tpageODet');*/
    <!-- CRM70t-ST TrackerId : 79456 ** BEGIN OF CHANGES ** -->
		//showbuttonsVisible(45);
    <!-- CRM70t-ST TrackerId : 79456 ** END OF CHANGES ** -->

   // }
    //Changes for tracker id Id: 273325  - End

















    function onEmpl(param){



        try{
            if(param == "Empl" || param == ""){
                elem = document.getElementsByName(boName+".Employment_Status")[0];
            }
            //Tracker:90196: Changes for attibute masking
            else  if(param == sMasker){
	                    return;
            }
            //Tracker:90196: End of changes for attribute masking
            else{

                elem = document.getElementsByName(boName+".Employment_Status_Empl")[0];

            }
            if(param == ""){
                previous_selection = elem.options[elem.selectedIndex].value;

            }
            var tbl;
            var iLength;
            var check = false;;


           if(elem.options[elem.selectedIndex].value == 'Self employed'){
            //check if data present in otherfields if yes
                if(previous_selection != elem.options[elem.selectedIndex].value &amp;&amp; (param == "Empl")){
                    check = checkifvaluepresentinOtherEmployment();
                    if (check == true){
                        if(!confirm("Income/Expense details you have entered will be lost if you change \n the Employment Status, Do you want to continue ?")){
                            elem.value = previous_selection;
                            return;
                        }
                    }
                }
                clearSalaryfields();
                iLength = document.all("rowSalaried").length;
                for (var i=0; i &lt; iLength; i++) {
                    tbl = document.all("rowSalaried")[i];
                    tbl.style.display = "none";
                }
                iLength = document.all("rowSelfEmployed").length;
                for (var i=0; i &lt; iLength; i++) {
                    tbl = document.all("rowSelfEmployed")[i];
                    tbl.style.display = "";
                }
                iLength = document.all("rowSalaried/selfEmployed").length;
                for (var i=0; i &lt; iLength; i++) {
                    tbl = document.all("rowSalaried/selfEmployed")[i];
                    tbl.style.display = "";
                }
                <!-- CRM62MNT:TRACKER# 55270 **BEGIN   CHANGES** -->
                var netincomelabel = document.getElementsByName("lbl_DemographicBO.Annual_Total_Income")[0];
                netincomelabel.innerText = "Annual Disposable Income : ";
                <!-- CRM62MNT:TRACKER# 55270 **END   CHANGES** -->
                document.getElementsByName("3_DemographicBO.Annual_Salary_Income")[0].IsMandatory = "false";	//Fix for ticket 245768
            }else if(elem.options[elem.selectedIndex].value == ''){
                //check if data in fields related to selfemployed present
                if(previous_selection != elem.options[elem.selectedIndex].value &amp;&amp; (param == "Empl")){
                    check = checkifvaluepresentinSelfEmployed();
                    if (check == true){
                        if(!confirm("Income/Expense details you have entered will be lost if you change \n the Employment Status, Do you want to continue ?")){
                            elem.value = previous_selection;
                            return;
                        }
                    }
                }

               clearSalaryfields();
                clearSelfEmplfields();
                iLength = document.all("rowSalaried").length;
                for (var i=0; i &lt; iLength; i++) {
                    tbl = document.all("rowSalaried")[i];
                    tbl.style.display = "none";
                }
                iLength = document.all("rowSelfEmployed").length;
                for (var i=0; i &lt; iLength; i++) {
                    tbl = document.all("rowSelfEmployed")[i];
                    tbl.style.display = "none";
                }
                iLength = document.all("rowSalaried/selfEmployed").length;
                for (var i=0; i &lt; iLength; i++) {
                    tbl = document.all("rowSalaried/selfEmployed")[i];
                    tbl.style.display = "none";
                }
            }else{
                //check if data in fields related to selfemployed present
                if(( previous_selection == 'Self employed') &amp;&amp; (previous_selection != elem.options[elem.selectedIndex].value) &amp;&amp; (param == "Empl")){
                    var check = checkifvaluepresentinSelfEmployed();
                    if (check == true){
                        if(!confirm("Income/Expense details you have entered will be lost if you change \n the Employment Status, Do you want to continue ?")){
                            elem.value = previous_selection;
                            return;
                        }
                    }
                }
                clearSelfEmplfields();
                iLength = document.all("rowSelfEmployed").length;
                for (var i=0; i &lt; iLength; i++) {
                    tbl = document.all("rowSelfEmployed")[i];
                    tbl.style.display = "none";
                }
                iLength = document.all("rowSalaried").length;
                for (var i=0; i &lt; iLength; i++) {
                    tbl = document.all("rowSalaried")[i];
                    tbl.style.display = "";
                }
                iLength = document.all("rowSalaried/selfEmployed").length;
                for (var i=0; i &lt; iLength; i++) {
                    tbl = document.all("rowSalaried/selfEmployed")[i];
                    tbl.style.display = "";
                }
                <!-- CRM62MNT:TRACKER# 55270 **BEGIN   CHANGES** -->
                var netincomelabel = document.getElementsByName("lbl_DemographicBO.Annual_Total_Income")[0];
                netincomelabel.innerText = "Monthly Disposable Income : ";
                <!-- CRM62MNT:TRACKER# 55270 **END   CHANGES** -->
            }
            if((previous_selection != elem.options[elem.selectedIndex].value) &amp;&amp; (previous_selection == 'Self employed' || elem.options[elem.selectedIndex].value == 'Self employed')){
                clearcommonfields();
            }



           if(param == "Empl" || param == ""){
                Employment_Status_Empl = document.getElementsByName(boName+".Employment_Status_Empl")[0];
                Employment_Status_Empl.value = elem.options[elem.selectedIndex].value;
            }else{
                Employment_Status = document.getElementsByName(boName+".Employment_Status")[0];
                Employment_Status.value = elem.options[elem.selectedIndex].value;
            }
                previous_selection = elem.options[elem.selectedIndex].value;
        }catch(e){
        }
    }

	<!--// Tracker ID : 68932 End of Changes-->
	function validateDate(){
	/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
	/* calling the function isGregDate for on blur functionality*/
	isGregDate("3_DemographicBO.MiscellaneousInfo.dtDate2");
	/*  ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/
		var todaydate = new String();

		/*Fix for Tracker #: SIDDHARTH Begins*/
		todaydate.value = getTodayDate1(locDate);
		/*Fix for Tracker #: SIDDHARTH Ends*/

		/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
		/*calling the function isGregDate for on blur functionality*/

						todaydate.value = convertDate(todaydate.value);

		/*  ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/
		elem1 = document.getElementsByName("3_DemographicBO.MiscellaneousInfo.dtDate2")[0];
		var mill1 = changetoMillis(todaydate.value);
		var mill2 = changetoMillis(elem1.value);
		if (mill1 &lt; mill2){
			showMessage(MSGX0042);
			elem1.focus();
		}
	}


   <!-- Fix as a part of ticket 351273 Starts-->
	function populateExRates(){

		try{
			var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
			var url = "../servlet/com.infy.cis.ui.common.AutoPopulateLocation?type=ExRate";
			s_xmlHttp.open("GET",url,false);
			s_xmlHttp.send();
			if(s_xmlHttp.status == 200){

				var returnedXML=s_xmlHttp.responseXML;
				for(i=0;i &lt; returnedXML.getElementsByTagName("Exchangerate").length;i++){
					ExArray[i] = returnedXML.getElementsByTagName("Exchangerate")[i].childNodes[0].nodeValue;

				}
			}
			}catch(e){

		}


	}
   <!-- Fix as a part of ticket 351273 Ends -->

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
	<!--// Tracker ID : 68932 End of Changes-->

	function SetLocCookies(){

		onLoadSetLocCookies('DemographicBO.MiscellaneousInfo.strText20','DemographicBO.MiscellaneousInfo.strText18','DemographicBO.MiscellaneousInfo.strText21');
	}
	//function to load refCodes
	function loadCode()
	{
			document.getElementsByName(boName + '.CustCaste')[0].value = '<xsl:value-of select="$CustCaste"/>';
		<!-- CRM70t-St Tracker# 78444, Begin of Changes -->
			<!--//document.getElementsByName(boName + '.TDSTable')[0].value = '<xsl:value-of select="$TDSTable"/>'; -->
		<!-- CRM70t-St Tracker# 78444, End of Changes -->
		//Changes for Tracker id: 299441 starts
		//document.getElementsByName(boName + '.NRERelative')[0].value = '<xsl:value-of select="$NRERelative"/>';
		//Changes for Tracker id: 299441 ends
		//Changes for Ticket id 433050 and Tracker id 260385 call id 226550 starts
       		<xsl:for-each select="//SRMData[@SRMDataSpace='CURRENTEMPLOYMENT']/SRMComposite[@n='RecordSet']//SRMRow//Z[@n=concat($boName,'.MiscellaneousInfo.strText20')]">
				var statecode = '<xsl:value-of select="."/>';
			</xsl:for-each>
			document.getElementsByName('DemographicBO.MiscellaneousInfo.strText20')[0].value = statecode;
       		<xsl:for-each select="//SRMData[@SRMDataSpace='CURRENTEMPLOYMENT']/SRMComposite[@n='RecordSet']//SRMRow//Z[@n=concat($boName,'.MiscellaneousInfo.strText18')]">
				var citycode = '<xsl:value-of select="."/>';
			</xsl:for-each>
			document.getElementsByName('DemographicBO.MiscellaneousInfo.strText18')[0].value = citycode;
		//Changes for Tracker id: 299441 starts
		<xsl:for-each select="//SRMData[@SRMDataSpace='CURRENTEMPLOYMENT']/SRMComposite[@n='RecordSet']//SRMRow//Z[@n=concat($boName,'.MiscellaneousInfo.strText21')]">
						var countrycode = '<xsl:value-of select="."/>';
				</xsl:for-each>
				document.getElementsByName('DemographicBO.MiscellaneousInfo.strText21')[0].value = countrycode;
		//Changes for Tracker id: 299441 ends
		//Changes for Ticket id 433050 and Tracker id 260385 call id 226550 ends
		//change for call id 351245 and 353235 start
		document.getElementsByName(boName + '.MiscellaneousInfo.StrText2_code')[0].value = '<xsl:value-of select="$strText2_code"/>';
		//change for call id 351245 and 353235 end
			document.getElementsByName(boName + '.Marital_Status')[0].value = '<xsl:value-of select="$Marital_Status"/>';
			//changes for tkt id 351073 (reconciled from tkt id 326505) start
			//document.getElementsByName(boName + '.Nationality')[0].value = '<xsl:value-of select="$Nationality"/>';
			//changes for tkt id 351073 (reconciled from tkt id 326505) end
			//change for call id 351245 and 353235 start
			//document.getElementsByName(boName + '.MiscellaneousInfo.StrText2_code')[0].value = '<xsl:value-of select="$strText2_code"/>';
			//change for call id 351245 and 353235 end

	}

    </script >
    </head>
    <!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 start-->
    <body class="popup"  onkeypress="onLoadSetTime()" onclick="onLoadSetTime()">
    <!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 end-->
    <xsl:choose>
    <xsl:when test="normalize-space($readMode)='Y'">
    <!--  recon Changes for call id 167292 Starts  -->
    <!-- Fix as a part of ticket 437856 Starts -->    
        <xsl:attribute name="onload">formatfields();showInReadOnlyMode('<xsl:value-of select="$readMode" />');onEmpl("");load();chkBSN();loadBaseCurrency();loadCode();formatDemographyAmount();PreviousEmploymentDetails();showInReadOnlyMode('<xsl:value-of select="$readMode"/>');</xsl:attribute>
    <!-- Fix as a part of ticket 437856 Ends-->
    </xsl:when>
    <!-- CRM70t-ST TrackerId : 78876 ** BEGIN OF CHANGES ** -->
    <xsl:when test="normalize-space($acctID)='' and normalize-space($suspID)='' and normalize-space($contID)=''">
	<!-- Fix as a part of ticket 351273 Starts -->
	<!-- Fix as a part of ticket 437856 Starts -->
    <!-- Fix for tracker 278386 Starts -->
		<xsl:attribute name="onload">disableFields();populateExRates();chkBSN();onEmpl("");load();formatDemographyAmount();PreviousEmploymentDetails();loadBaseCurrency();showbuttonsVisible(45);checkESFields();</xsl:attribute><!--Fix for ticket 271915 -->
    <!-- Fix for tracker 278386 Ends -->
	<!-- Fix as a part of ticket 437856 Ends-->
    <!-- Fix as a part of ticket 351273 Ends -->
    </xsl:when>
    <xsl:otherwise>

    <!-- tracker id: 173837 changes begin -->
    <!-- Fix as a part of ticket 351273 Starts-->
    <!-- Fix as a part of ticket 437856 Starts -->
    <!-- Fix for tracker 278386 Starts -->
    <xsl:attribute name="onload">disableFields();formatfields();populateExRates();chkBSN();onEmpl("");showbuttonsVisible(30);load();loadBaseCurrency();checkESFields();loadCode();formatDemographyAmount();PreviousEmploymentDetails();chkBSN();</xsl:attribute>
    <!-- Fix for tracker 278386 Ends -->
    <!-- Fix as a part of ticket 437856 Ends-->
    <!-- Fix as a part of ticket 351273 Ends-->
    <!-- tracker id: 173837 changes end -->


    <!-- CRM70t-ST TrackerId : 78876 ** END OF CHANGES ** -->
    </xsl:otherwise>
    </xsl:choose>
    <!--  recon Changes for call id 167292 ends  -->
    <!--performance patch:Commenting duplicate js call:354529-->
    <!--<script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>-->
        <script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
        <script type="text/javascript" src="../common/js/ListBoxFunctions.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>
        <!--<script type="text/javascript" language="javascript" src="../cif/js/AccountAddressRCLOptions_{$locale}.js"></script>
        <script type="text/javascript" language="javascript" src="../cif/js/Demographic.js"></script>-->
     <table width="100%" border="0" cellpadding="0" cellspacing="0" vspace="0" hspace="0">
         <xsl:apply-templates select="SRM"/>
     </table>
      </body>
      </html>
      </xsl:template>
<!-- View : DemographicContactInfo :Start   -->
    <xsl:attribute-set name="cellstyle1">
      <xsl:attribute name="font-family">Times New Roman</xsl:attribute>
      <xsl:attribute name="align">center</xsl:attribute>
      <xsl:attribute name="colspan">7</xsl:attribute>
      <xsl:attribute name="class">header</xsl:attribute>
    </xsl:attribute-set>
    <xsl:template name="apply1">
    <xsl:param name="apply_head">blank</xsl:param>
        <td xsl:use-attribute-sets="cellstyle1">
            <xsl:value-of select="$apply_head"/>
           </td>
    </xsl:template>
    <xsl:template name="DemographicBO.Phone_Work">
        <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.Phone_Work']"/>
            <xsl:with-param name="ele_name">DemographicBO.Phone_Work</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Phone_Work</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="DemographicBO.Extension">
        <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.Extension']"/>
            <xsl:with-param name="ele_name">DemographicBO.Extension</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Extension</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="DemographicBO.Phone_Home">
        <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.Phone_Home']"/>
            <xsl:with-param name="ele_name">DemographicBO.Phone_Home</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Phone_Home</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
        <xsl:template name="DemographicBO.Phone_Cell">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.Phone_Cell']"/>
              <xsl:with-param name="ele_name">DemographicBO.Phone_Cell</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Phone_Cell</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
        <xsl:template name="DemographicBO.Fax_Work">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.Fax_Work']"/>
              <xsl:with-param name="ele_name">DemographicBO.Fax_Work</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Fax_Work</xsl:with-param>
              <xsl:with-param name="is_phone">true</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
         <xsl:template name="DemographicBO.URL">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.URL']"/>
              <xsl:with-param name="ele_name">DemographicBO.URL</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.URL</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
         <xsl:template name="DemographicBO.Email_Work">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.Email_Work']"/>
              <xsl:with-param name="ele_name">DemographicBO.Email_Work</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Email_Work</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
         <xsl:template name="DemographicBO.Email_Home">
         <xsl:call-template name="label">
         <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.Email_Home']"/>
          <xsl:with-param name="ele_name">DemographicBO.Email_Home</xsl:with-param>
          <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Email_Home</xsl:with-param>
         </xsl:call-template>
         </xsl:template>
         <xsl:template name="DemographicBO.Email_Palm">
         <xsl:call-template name="label">
         <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.Email_Palm']"/>
           <xsl:with-param name="ele_name">DemographicBO.Email_Palm</xsl:with-param>
           <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Email_Palm</xsl:with-param>
         </xsl:call-template>
         </xsl:template>
          <xsl:template name="DemographicBO.PagerNo">
			<xsl:call-template name="label">
				<xsl:with-param name="is_phone">true</xsl:with-param>
				<!--<xsl:with-param name="showphonelabels">false</xsl:with-param>-->
				<xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.PagerNo']"/>
				<xsl:with-param name="ele_name">DemographicBO.PagerNo</xsl:with-param>
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.PagerNo</xsl:with-param>
			</xsl:call-template>
        </xsl:template>
          <xsl:template name="DemographicBO.PhoneOther">
			<xsl:call-template name="label">
				<xsl:with-param name="is_phone">true</xsl:with-param>
				<xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.PhoneOther']"/>
				<xsl:with-param name="ele_name">DemographicBO.PhoneOther</xsl:with-param>
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.PhoneOther</xsl:with-param>
			</xsl:call-template>
        </xsl:template>
          <xsl:template name="DemographicBO.prefDaytimeContNo">
			<xsl:call-template name="label">
				<xsl:with-param name="is_phone">true</xsl:with-param>
				<xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.prefDaytimeContNo']"/>
				<xsl:with-param name="ele_name">DemographicBO.prefDaytimeContNo</xsl:with-param>
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.prefDaytimeContNo</xsl:with-param>
			</xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.doNotMailFlag">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.doNotMailFlag']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.doNotMailFlag</xsl:with-param>
                <xsl:with-param name="selectdisp">DemographicBO.doNotMailFlag</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="choice_name">DemographicBO.doNotMailFlag</xsl:with-param>
                <xsl:with-param name="defValByUrl">true</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.doNotCallFlag">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.doNotCallFlag']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.doNotCallFlag</xsl:with-param>
                <xsl:with-param name="selectdisp">DemographicBO.doNotCallFlag</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="choice_name">DemographicBO.doNotCallFlag</xsl:with-param>
                <xsl:with-param name="defValByUrl">true</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.holdMailFlag">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.holdMailFlag']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.holdMailFlag</xsl:with-param>
                <xsl:with-param name="selectdisp">DemographicBO.holdMailFlag</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="choice_name">DemographicBO.holdMailFlag</xsl:with-param>
                <xsl:with-param name="defValByUrl">true</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.holdMailDescription">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.holdMailDescription']"/>
                <xsl:with-param name="ele_name">DemographicBO.holdMailDescription</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.holdMailDescription</xsl:with-param>
				<xsl:with-param name="checkASCII">false</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.doNotSendEMailFlg">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.doNotSendEMailFlg']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.doNotSendEMailFlg</xsl:with-param>
                <xsl:with-param name="selectdisp">DemographicBO.doNotSendEMailFlg</xsl:with-param>
               <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="choice_name">DemographicBO.doNotSendEMailFlg</xsl:with-param>
                <xsl:with-param name="defValByUrl">true</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.holdMailStartDate">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.holdMailStartDate']"/>
                <xsl:with-param name="ele_name">DemographicBO.holdMailStartDate</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.holdMailStartDate</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
 		<!-- calling the function isGregDate for on blur functionality-->
                <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.holdMailStartDate");</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.holdMailEndDate">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.holdMailEndDate']"/>
                <xsl:with-param name="ele_name">DemographicBO.holdMailEndDate</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.holdMailEndDate</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		<!-- calling the function isGregDate for on blur functionality-->
                <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.holdMailEndDate");</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.prefContTime">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.prefContTime']"/>
                <xsl:with-param name="ele_name">DemographicBO.prefContTime</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.prefContTime</xsl:with-param>
                <!-- Tracker 68932 Begin of Changes-->
	        <xsl:with-param name="fn_onBlur">validate_time(this,false,true)</xsl:with-param>
	        <!-- Tracker 68932 End of Changes-->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.userField1">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.userField1']"/>
                <xsl:with-param name="ele_name">DemographicBO.userField1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.userField1</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.userField2">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.userField2']"/>
                <xsl:with-param name="ele_name">DemographicBO.userField2</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.userField2</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.userField3">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.userField3']"/>
                <xsl:with-param name="ele_name">DemographicBO.userField3</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.userField3</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
<!-- View : DemographicContactInfo :End   -->
<!-- View : DemographicIncomeExpense : Start   -->

<!-- 	change done as a part of ticket 351273 starts
		Where ever the Currency exchange rate function has to be called the function rate()
		from RendCurrency.js is called, to which we pass 3 parameter, thus the 3rd parameter passed
		is BaseCurrency, this value get passed as blank and thus blocking the exchange rate functionality
		thus, the proper XSL parameter which holds the Base currency is passed when Rate function is called
-->
      <xsl:template name="DemographicBO.Annual_Salary_Income">
            <xsl:call-template name="amountlabel">
                <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Annual_Salary_Income']"/>
                <xsl:with-param name="ele_name">DemographicBO.Annual_Salary_Income</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Annual_Salary_Income</xsl:with-param>
                <xsl:with-param name="fncname">rate("3_DemographicBO.Annual_Salary_Income","<xsl:value-of select="$boName"/>.CU_Annual_Salary_Income",'<xsl:value-of select="$currency"/>');</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_Annual_Salary_Income</xsl:with-param>
                <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_Annual_Salary_Income</xsl:with-param>
                <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.Annual_Salary_Income","<xsl:value-of select="$boName"/>.CU_Annual_Salary_Income");</xsl:with-param>
		<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
             </xsl:call-template>
     </xsl:template>
         <xsl:template name="DemographicBO.Annual_Rental_Income">
            <xsl:call-template name="amountlabel">
                <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Annual_Rental_Income']"/>
                <xsl:with-param name="ele_name">DemographicBO.Annual_Rental_Income</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Annual_Rental_Income</xsl:with-param>  <xsl:with-param name="fncname">rate("3_DemographicBO.Annual_Rental_Income","<xsl:value-of select="$boName"/>.CU_Annual_Rental_Income",'<xsl:value-of select="$currency"/>');</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_Annual_Rental_Income</xsl:with-param>
                <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_Annual_Rental_Income</xsl:with-param>
                <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.Annual_Rental_Income","<xsl:value-of select="$boName"/>.CU_Annual_Rental_Income");</xsl:with-param>
                <xsl:with-param name="choice_name">DemographicBO.Annual_Rental_Income</xsl:with-param>
                <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
         </xsl:template>
         <xsl:template name="DemographicBO.Annual_Stock_Bond_Income">
            <xsl:call-template name="amountlabel">
                <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Annual_Stock_Bond_Income']"/>
                <xsl:with-param name="ele_name">DemographicBO.Annual_Stock_Bond_Income</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Annual_Stock_Bond_Income</xsl:with-param>  <xsl:with-param name="fncname">rate("3_DemographicBO.Annual_Stock_Bond_Income","<xsl:value-of select="$boName"/>.CU_Annual_Stock_Bond_Income",'<xsl:value-of select="$currency"/>');</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_Annual_Stock_Bond_Income</xsl:with-param>
                <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_Annual_Stock_Bond_Income</xsl:with-param>
                <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.Annual_Stock_Bond_Income","<xsl:value-of select="$boName"/>.CU_Annual_Stock_Bond_Income");</xsl:with-param>
             	<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
        </xsl:template>



 	<xsl:template name="DemographicBO.SourceOfIncome">
	    <xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SourceOfIncome']"/>
		<xsl:with-param name="ele_name">DemographicBO.SourceOfIncome</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SourceOfIncome</xsl:with-param>
	    </xsl:call-template>
	</xsl:template>



<!--Field Addition Tracker 172089:start of Changes-->
 <xsl:template name="DemographicBO.income_freq">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.income_freq']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.income_freq</xsl:with-param>
                <xsl:with-param name="selectdisp">DemographicBO.income_freq</xsl:with-param>
               <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="choice_name">DemographicBO.income_freq</xsl:with-param>
         	<xsl:with-param name="presdata" select="$PresData"/>
            </xsl:call-template>
        </xsl:template>

  <xsl:template name="DemographicBO.income_to">
             <xsl:call-template name="amountlabel">
                 <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.income_to']"/>
                 <xsl:with-param name="ele_name">DemographicBO.income_to</xsl:with-param>
                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.income_to</xsl:with-param>
                 <xsl:with-param name="linkshow">false</xsl:with-param>
                 <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_income_to</xsl:with-param>
                 <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_income_to</xsl:with-param>
                 <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.income_to","<xsl:value-of select="$boName"/>.CU_income_to");checkCurr('CU_income_to');</xsl:with-param>
                 <xsl:with-param name="choicename">Currency</xsl:with-param>
     				<xsl:with-param name="presdata" select="$PresData"/>
              </xsl:call-template>
     </xsl:template>

          <xsl:template name="DemographicBO.income_from">
                  <xsl:call-template name="amountlabel">
                      <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.income_from']"/>
                      <xsl:with-param name="ele_name">DemographicBO.income_from</xsl:with-param>
                      <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.income_from</xsl:with-param>
                      <xsl:with-param name="linkshow">false</xsl:with-param>
                      <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_income_from</xsl:with-param>
                      <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_income_from</xsl:with-param>
                      <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.income_from","<xsl:value-of select="$boName"/>.CU_income_from");checkCurr('CU_income_from');</xsl:with-param>
                      <xsl:with-param name="choicename">Currency</xsl:with-param>
          				<xsl:with-param name="presdata" select="$PresData"/>
                   </xsl:call-template>
     </xsl:template>

<!--Field Addition Tracker 172089:end of Changes-->

        <xsl:template name="DemographicBO.Annual_Others_Income">
             <xsl:call-template name="amountlabel">
             	<xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Annual_Others_Income']"/>
             	<xsl:with-param name="ele_name">DemographicBO.Annual_Others_Income</xsl:with-param>
            	<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Annual_Others_Income</xsl:with-param>
 <!-- Tracker id 113276 changes start -->
		 <!-- TRACKER ID 125488 CAHNGES BEGIN -->
		 <!-- Modify the amount field template name -->
		<xsl:with-param name="fncname">rate("3_DemographicBO.Annual_Others_Income","<xsl:value-of select="$boName"/>.CU_Annual_Others_Income",'<xsl:value-of select="$currency"/>');</xsl:with-param>
		<!-- TRACKER ID 125488 CAHNGES END -->
 <!-- Tracker id 113276 changes end -->
             	<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_Annual_Others_Income</xsl:with-param>
             	<xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_Annual_Others_Income</xsl:with-param>
<!-- Tracker id 113276 changes start -->
            	<xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.Annual_Others_Income","<xsl:value-of select="$boName"/>.CU_Annual_Others_Income");</xsl:with-param>
<!-- Tracker id 113276 changes end -->
           	<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
             </xsl:call-template>
         </xsl:template>
<!-- CRM62MNT:TRACKER# 55270 **BEGIN   CHANGES** -->
	<xsl:template name="DemographicBO.Annual_Total_Income">
		<xsl:call-template name="label_nolabel">
			<xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Annual_Total_Income']"/>
			<xsl:with-param name="ele_name">DemographicBO.Annual_Total_Income</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Annual_Total_Income</xsl:with-param>
			<xsl:with-param name="read_val">true</xsl:with-param>
			<xsl:with-param name="class">mtextbox</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
<!-- CRM62MNT:TRACKER# 55270 **END   CHANGES** -->
    <xsl:template name="DemographicBO.TotalHouseholdIncm">
        <xsl:call-template name="amountlabel">
            <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.TotalHouseholdIncm']"/>
            <xsl:with-param name="ele_name">DemographicBO.TotalHouseholdIncm</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TotalHouseholdIncm</xsl:with-param>
            <xsl:with-param name="linkshow">false</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_TotalHouseholdIncm</xsl:with-param>
            <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_TotalHouseholdIncm</xsl:with-param>
            <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.TotalHouseholdIncm","<xsl:value-of select="$boName"/>.CU_TotalHouseholdIncm");</xsl:with-param>
            <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
     </xsl:template>
    <xsl:template name="DemographicBO.Annual_Operating_Exp">
       <xsl:call-template name="amountlabel">
         <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Annual_Operating_Exp']"/>
         <xsl:with-param name="ele_name">DemographicBO.Annual_Operating_Exp</xsl:with-param>
         <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Annual_Operating_Exp</xsl:with-param> <xsl:with-param name="fncname">rate("3_DemographicBO.Annual_Operating_Exp","<xsl:value-of select="$boName"/>.CU_Annual_Operating_Exp",'<xsl:value-of select="$currency"/>');</xsl:with-param>
         <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_Annual_Operating_Exp</xsl:with-param>
         <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_Annual_Operating_Exp</xsl:with-param>
         <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.Annual_Operating_Exp","<xsl:value-of select="$boName"/>.CU_Annual_Operating_Exp");</xsl:with-param>
       	 <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
       </xsl:call-template>
    </xsl:template>
         <xsl:template name="DemographicBO.Annual_IntProd_Exp">
         <xsl:call-template name="amountlabel">
         <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Annual_IntProd_Exp']"/>
         <xsl:with-param name="ele_name">DemographicBO.Annual_IntProd_Exp</xsl:with-param>
         <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Annual_IntProd_Exp</xsl:with-param>   <xsl:with-param name="fncname">rate("3_DemographicBO.Annual_IntProd_Exp","<xsl:value-of select="$boName"/>.CU_Annual_IntProd_Exp",'<xsl:value-of select="$currency"/>');</xsl:with-param>
    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_Annual_IntProd_Exp</xsl:with-param>
    <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_Annual_IntProd_Exp</xsl:with-param>
    <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.Annual_IntProd_Exp","<xsl:value-of select="$boName"/>.CU_Annual_IntProd_Exp");</xsl:with-param>
       	<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
         </xsl:template>
          <xsl:template name="DemographicBO.Annual_Loan_Instal">
          <xsl:call-template name="amountlabel">
         <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Annual_Loan_Instal']"/>
         <xsl:with-param name="ele_name">DemographicBO.Annual_Loan_Instal</xsl:with-param>
         <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Annual_Loan_Instal</xsl:with-param>   <xsl:with-param name="fncname">rate("3_DemographicBO.Annual_Loan_Instal","<xsl:value-of select="$boName"/>.CU_Annual_Loan_Instal",'<xsl:value-of select="$currency"/>');</xsl:with-param>
    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_Annual_Loan_Instal</xsl:with-param>
    <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_Annual_Loan_Instal</xsl:with-param>
    <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.Annual_Loan_Instal","<xsl:value-of select="$boName"/>.CU_Annual_Loan_Instal");</xsl:with-param>
        <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
         </xsl:template>
    <xsl:template name="DemographicBO.Annual_ExtProd_Exp">
    <xsl:call-template name="amountlabel">
    <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Annual_ExtProd_Exp']"/>
    <xsl:with-param name="ele_name">DemographicBO.Annual_ExtProd_Exp</xsl:with-param>
    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Annual_ExtProd_Exp</xsl:with-param>
    <xsl:with-param name="fncname">rate("3_DemographicBO.Annual_ExtProd_Exp","<xsl:value-of select="$boName"/>.CU_Annual_ExtProd_Exp",'<xsl:value-of select="$currency"/>');</xsl:with-param>
    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_Annual_ExtProd_Exp</xsl:with-param>
    <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_Annual_ExtProd_Exp</xsl:with-param>
    <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.Annual_ExtProd_Exp","<xsl:value-of select="$boName"/>.CU_Annual_ExtProd_Exp");</xsl:with-param>
     <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
    </xsl:call-template>
    </xsl:template>
     <xsl:template name="DemographicBO.Annual_Commit_Exp">
        <xsl:call-template name="amountlabel">
          <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Annual_Commit_Exp']"/>
             <xsl:with-param name="ele_name">DemographicBO.Annual_Commit_Exp</xsl:with-param>
             <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Annual_Commit_Exp</xsl:with-param>    <xsl:with-param name="fncname">rate("3_DemographicBO.Annual_Commit_Exp","<xsl:value-of select="$boName"/>.CU_Annual_Commit_Exp",'<xsl:value-of select="$currency"/>');</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_Annual_Commit_Exp</xsl:with-param>
            <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_Annual_Commit_Exp</xsl:with-param>
            <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.Annual_Commit_Exp","<xsl:value-of select="$boName"/>.CU_Annual_Commit_Exp");</xsl:with-param>
            <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
     </xsl:template>
      <xsl:template name="DemographicBO.Annual_Other_Exp">
         <xsl:call-template name="amountlabel">
           <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Annual_Other_Exp']"/>
           <xsl:with-param name="ele_name">DemographicBO.Annual_Other_Exp</xsl:with-param>
           <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Annual_Other_Exp</xsl:with-param>   <xsl:with-param name="fncname">rate("3_DemographicBO.Annual_Other_Exp","<xsl:value-of select="$boName"/>.CU_Annual_Other_Exp",'<xsl:value-of select="$currency"/>');</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_Annual_Other_Exp</xsl:with-param>
            <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_Annual_Other_Exp</xsl:with-param>
            <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.Annual_Other_Exp","<xsl:value-of select="$boName"/>.CU_Annual_Other_Exp");</xsl:with-param>
	    <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
       </xsl:template>
<!-- CRM62MNT:TRACKER# 55270 **BEGIN   CHANGES** -->
         <xsl:template name="DemographicBO.Annual_Total_Exp">
            <xsl:call-template name="amountlabel">
            	<xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Annual_Total_Exp']"/>
              	<xsl:with-param name="ele_name">DemographicBO.Annual_Total_Exp</xsl:with-param>
              	<!-- Start Tracker 98065-->
              	<!--ticket id 220540 tracker id 132316 changes starts-->
              	<xsl:with-param name="linkshow">false</xsl:with-param>
              	<!--ticket id 220540 tracker id 132316 changes ends-->
              	<xsl:with-param name="showdropdown">false</xsl:with-param>
              	<xsl:with-param name="textwidth">180</xsl:with-param>
              	<xsl:with-param name="appendtext">true</xsl:with-param>
              	<xsl:with-param name="text_append"><xsl:value-of select="$BaseCurrency"/></xsl:with-param>
              	<!-- End Tracker 98065-->
              	<!--ticket id 220540 tracker id 132316 changes starts-->
              	<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Annual_Total_Exp</xsl:with-param>
	  	<xsl:with-param name="read_val">true</xsl:with-param>
	  	<!-- Tracker 123012 Changes Start -->
	  	<!--<xsl:with-param name="fncname">rate("3_DemographicBO.Annual_Total_Exp","<xsl:value-of select="$boName"/>.CU_Annual_Total_Exp",'<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>-->
	  	<!-- Tracker 123012 Changes End -->
		<!--ticket id 220540 tracker id 132316 changes ends-->
	  	<xsl:with-param name="presdata" select="$PresData"/>
	  		</xsl:call-template>
         </xsl:template>
<!-- CRM62MNT:TRACKER# 55270 **END   CHANGES** -->
         <xsl:template name="DemographicBO.Employment_Status_Empl">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.Employment_Status']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Employment_Status_Empl</xsl:with-param>
          	<xsl:with-param name="selectdisp">DemographicBO.Employment_Status</xsl:with-param>
          	<xsl:with-param name="search_type">value</xsl:with-param>
          	<!-- Changes for call id 441228 starts here -->
           	<xsl:with-param name="onchangefn">checkESFields1();onEmpl('Status_Empl')</xsl:with-param>
           	<!-- Changes for call id 441228 ends here -->
	    	<xsl:with-param name="choice_name">DemographicBO.Employment_Status</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
           </xsl:call-template>
         </xsl:template>
<!-- View : DemographicIncomeExpense : End   -->
<!-- View : DemographicEmploymentDetails : End  -->
             <xsl:template name="DemographicBO.Employment_Status">
                <xsl:call-template name="mdrpdown">
                    <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.Employment_Status']"/>
                    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Employment_Status</xsl:with-param>
                    <xsl:with-param name="selectdisp">DemographicBO.Employment_Status</xsl:with-param>
                    <xsl:with-param name="search_type">value</xsl:with-param>
                    <xsl:with-param name="defValByUrl">true</xsl:with-param>
                    <xsl:with-param name="onchangefn">checkESFields();onEmpl('Empl')</xsl:with-param>
                    <xsl:with-param name="choice_name">DemographicBO.Employment_Status</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
                </xsl:call-template>
             </xsl:template>
     	     <!-- TRACKER# : 59373
	        Income_Nature entity field is mapped to this template
	     -->
	     <xsl:template name="DemographicBO.Payment_Mode">
                <xsl:call-template name="mdrpdown">
                    <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.Payment_Mode']"/>
                    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Payment_Mode</xsl:with-param>
                    <xsl:with-param name="selectdisp">DemographicBO.Payment_Mode</xsl:with-param>
                    <xsl:with-param name="search_type">value</xsl:with-param>
                    <xsl:with-param name="onchangefn"></xsl:with-param>
                    <xsl:with-param name="choice_name">DemographicBO.Payment_Mode</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
                </xsl:call-template>
             </xsl:template>
	     <!-- TRACKER# : 59373
	     Payment_Mode entity field is mapped to this template
	     -->
	     <xsl:template name="DemographicBO.Income_Nature">
                <xsl:call-template name="mdrpdown">
                    <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.Income_Nature']"/>
                    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Income_Nature</xsl:with-param>
                    <xsl:with-param name="selectdisp">DemographicBO.Income_Nature</xsl:with-param>
                    <xsl:with-param name="search_type">value</xsl:with-param>
                    <xsl:with-param name="onchangefn"></xsl:with-param>
                    <xsl:with-param name="choice_name">DemographicBO.Income_Nature</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
                </xsl:call-template>
             </xsl:template>
        <!-- Incorporation Date-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.dtDate2">
                     <xsl:call-template name="label">
                     <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.dtDate2']"/>
                       <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.dtDate2</xsl:with-param>
                       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.dtDate2</xsl:with-param>
                       <!--  Tracker ID : 68932 Begin of Changes -->
		       <xsl:with-param name="fn_onBlur">validateDate();</xsl:with-param>
                       <!-- Tracker ID : 68932 End of Changes -->
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
                     </xsl:call-template>
              </xsl:template>
        <!-- Normal Retirement Date-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.dtDate3">
                     <xsl:call-template name="label">
                     <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.dtDate3']"/>
                       <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.dtDate3</xsl:with-param>
                       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.dtDate3</xsl:with-param>
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
                        <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
			<!-- calling the function isGregDate for on blur functionality-->
                      <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.MiscellaneousInfo.dtDate3");</xsl:with-param>
                      <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
                     </xsl:call-template>
              </xsl:template>
        <!-- Legal Status-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText1">
                     <xsl:call-template name="label">
                     <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText1']"/>
                       <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText1</xsl:with-param>
                       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText1</xsl:with-param>
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
                     </xsl:call-template>
              </xsl:template>
        <!-- Employer Incorporation No./Registration No -->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText17">
                     <xsl:call-template name="label">
                     <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText17']"/>
                       <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText17</xsl:with-param>
                       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText17</xsl:with-param>
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
                     </xsl:call-template>
              </xsl:template>
        <!-- Employer Address - City -->
             <xsl:template name="DemographicBO.MiscellaneousInfo.strText18">
             <xsl:call-template name="lookup">
             <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText18']"/>
             <xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.strText18</xsl:with-param>
             <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText18</xsl:with-param>
             <xsl:with-param name="buttonone_name" select="$configLabels_4[@name='BTN_LOOKUP']/@configLabel"/>
             <xsl:with-param name="buttontwo_name" select="$configLabels_4[@name='BTN_CLEAR']/@configLabel"/>
		<!-- vasanth's changes start -->

			 <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('CITY', 'DemographicBO.MiscellaneousInfo.strText18','','DemographicBO.MiscellaneousInfo.strText20','DemographicBO.MiscellaneousInfo.strText21')</xsl:with-param>
			 <xsl:with-param name="buttontwo_fnc">clearLocValue('DemographicBO.MiscellaneousInfo.strText18','CITY')</xsl:with-param>

             <!--<xsl:with-param name="buttonone_fnc">categoryLookup('CITY', 'DemographicBO.MiscellaneousInfo.strText18')</xsl:with-param>
             <xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.MiscellaneousInfo.strText18')</xsl:with-param>-->

		<!-- vasanth's changes end   -->
             <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
	     <xsl:with-param name="checkASCII">false</xsl:with-param>
             </xsl:call-template>
             </xsl:template>
        <!-- Employer Address - Zip Code -->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText19">
                     <xsl:call-template name="label">
                     <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText19']"/>
                       <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText19</xsl:with-param>
                       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText19</xsl:with-param>
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
                     <!-- Changes for Tracker #303242 -->
                     <xsl:with-param name="max_length">10</xsl:with-param>
                     </xsl:call-template>
              </xsl:template>
        <!-- Employer Address - State -->
             <xsl:template name="DemographicBO.MiscellaneousInfo.strText20">
             <xsl:call-template name="lookup">
             <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText20']"/>
             <xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.strText20</xsl:with-param>
             <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText20</xsl:with-param>
             <xsl:with-param name="buttonone_name" select="$configLabels_4[@name='BTN_LOOKUP']/@configLabel"/>
             <xsl:with-param name="buttontwo_name" select="$configLabels_4[@name='BTN_CLEAR']/@configLabel"/>
		<!-- vasanth's changes start -->

		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('STATE', 'DemographicBO.MiscellaneousInfo.strText20','','DemographicBO.MiscellaneousInfo.strText18','DemographicBO.MiscellaneousInfo.strText21')</xsl:with-param>
		<xsl:with-param name="buttontwo_fnc">clearLocValue('DemographicBO.MiscellaneousInfo.strText20','STATE','DemographicBO.MiscellaneousInfo.strText18')</xsl:with-param>

             <!--<xsl:with-param name="buttonone_fnc">categoryLookup('STATE', 'DemographicBO.MiscellaneousInfo.strText20')</xsl:with-param>
             <xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.MiscellaneousInfo.strText20')</xsl:with-param>-->

		<!-- vasanth's changes end   -->
             <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
	     <xsl:with-param name="checkASCII">false</xsl:with-param>
             </xsl:call-template>
             </xsl:template>
            <!-- Employer Address - Country -->
             <xsl:template name="DemographicBO.MiscellaneousInfo.strText21">
             <xsl:call-template name="lookup">
             <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText21']"/>
             <xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.strText21</xsl:with-param>
             <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText21</xsl:with-param>
	     <!-- Field Rationalization changes start -->
	     <xsl:with-param name="code_req">true</xsl:with-param>
	     <!-- Field Rationalization changes end -->
             <xsl:with-param name="buttonone_name" select="$configLabels_4[@name='BTN_LOOKUP']/@configLabel"/>
             <xsl:with-param name="buttontwo_name" select="$configLabels_4[@name='BTN_CLEAR']/@configLabel"/>
		<!-- vasanth's changes start -->

			<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('COUNTRY', 'DemographicBO.MiscellaneousInfo.strText21','','DemographicBO.MiscellaneousInfo.strText20','DemographicBO.MiscellaneousInfo.strText18')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearLocValue('DemographicBO.MiscellaneousInfo.strText21','COUNTRY','DemographicBO.MiscellaneousInfo.strText20','DemographicBO.MiscellaneousInfo.strText18')</xsl:with-param>

             <!--<xsl:with-param name="buttonone_fnc">categoryLookup('COUNTRY', 'DemographicBO.MiscellaneousInfo.strText21')</xsl:with-param>
             <xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.MiscellaneousInfo.strText21')</xsl:with-param>-->

		<!-- vasanth's changes end   -->
             	<!-- Changes for the ticket id 320003 starts -->
             	<!-- Changes for the Tracker id: 299441 starts -->
             	<xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
	        <!--<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>-->
             	<!-- Changes for the Tracker id: 299441 ends -->
             	<!-- Changes for the ticket id 320003 ends -->
	     <xsl:with-param name="checkASCII">false</xsl:with-param>
             </xsl:call-template>
             </xsl:template>
            <!-- Employer Pensioner Flag -->
             <xsl:template name="DemographicBO.Pensioner_Flag">
                <xsl:call-template name="mdrpdown">
                    <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText22']"/>
                    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText22</xsl:with-param>
                    <xsl:with-param name="selectdisp">DemographicBO.MiscellaneousInfo.strText22</xsl:with-param>
                    <xsl:with-param name="search_type">value</xsl:with-param>
                    <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
                    <xsl:with-param name="choice_name">DemographicBO.MiscellaneousInfo.strText22</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
                </xsl:call-template>
             </xsl:template>

                                     <!-- CODE ADDED BY KAMAL for tracker id 349409 -->
                     <xsl:template name="DemographicBO.MiscellaneousInfo.strText2">
				   <xsl:call-template name="lookup">
					  <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.StrText2_code']"/>
						  <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.MiscellaneousInfo.StrText2_code</xsl:with-param>
						  <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText2</xsl:with-param>
						   <!-- Field Rationalization changes start -->
								<!--   <xsl:with-param name="code_req">true</xsl:with-param> -->
										<!-- Field Rationalization changes end -->
								<!--  TRACKER ID:150150  CHANGES BEGIN   -->
										<xsl:with-param name="buttonone_name" select="$configLabels_4[@name='BTN_LOOKUP']/@configLabel"/>
										<xsl:with-param name="buttontwo_name" select="$configLabels_4[@name='BTN_CLEAR']/@configLabel"/>
										<xsl:with-param name="buttonone_fnc">categoryLookup('CONTACT_OCCUPATION', '<xsl:value-of select="$boName"/>.MiscellaneousInfo.StrText2_code')</xsl:with-param>
										<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.MiscellaneousInfo.StrText2_code')</xsl:with-param>
								<!--Changes for Ticket id: 663317 starts-->
										<!--<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>-->
										<xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
								<!--Changes for Ticket id: 663317 ends-->
										<xsl:with-param name="checkASCII">false</xsl:with-param>
								<!--  TRACKER ID:150150  CHANGES END  -->
										<!-- CIF Changes for Caching Views : Start -->
						<xsl:with-param name="presdata" select="$PresData"/>
						<!-- CIF Changes for Caching Views : End -->
						       </xsl:call-template>
		    </xsl:template>
        
  <!-- CODE ADDED BY KAMAL for tracker id 349409 -->
        <!-- Industry -->
       <!-- Field Rationalization changes start -->



                     <!--Changes Made for Ticket ID 248355 -->
	     <xsl:template name="DemographicBO.MiscellaneousInfo.strText3">
		   <xsl:call-template name="lookup">
		          <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText3']"/>
			  <xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.strText3</xsl:with-param>
			  <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText3</xsl:with-param>
			   <!-- Field Rationalization changes start -->
				   <xsl:with-param name="code_req">true</xsl:with-param>
	      	      			<!-- Field Rationalization changes end -->
	      	      		<!--  TRACKER ID:150150  CHANGES BEGIN   -->
	      	      			<xsl:with-param name="buttonone_name" select="$configLabels_4[@name='BTN_LOOKUP']/@configLabel"/>
	      	      			<xsl:with-param name="buttontwo_name" select="$configLabels_4[@name='BTN_CLEAR']/@configLabel"/>
	      	      			<xsl:with-param name="buttonone_fnc">categoryLookup('INDUSTRY_TYPE', 'DemographicBO.MiscellaneousInfo.strText3')</xsl:with-param>
	      	      			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.MiscellaneousInfo.strText3')</xsl:with-param>
	      	      			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	      	      			<xsl:with-param name="checkASCII">false</xsl:with-param>
	      	      		<!--  TRACKER ID:150150  CHANGES END  -->
	      	      			<!-- CIF Changes for Caching Views : Start -->
	      	               	<xsl:with-param name="presdata" select="$PresData"/>
	      	      	<!-- CIF Changes for Caching Views : End -->
	      	                       </xsl:call-template>
	                    </xsl:template>










              <!--Employer Name-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText4">
	               <xsl:call-template name="lookup">
                     <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText4']"/>
                     <!--  Ticket No-244716, Tracker ID -147829 Start of changes for Defect fix  -->
                       <xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.strText4</xsl:with-param>
                       <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText4</xsl:with-param>
                      <!--  Ticket No-244716, Tracker ID -147829 End of changes for Defect fix  -->
	               <xsl:with-param name="buttonone_name" select="$configLabels_4[@name='BTN_LOOKUP']/@configLabel"/>
	               <xsl:with-param name="buttontwo_name" select="$configLabels_4[@name='BTN_CLEAR']/@configLabel"/>
	              <xsl:with-param name="buttonone_fnc">empLookup()</xsl:with-param>
<!-- Changes for 10.2.02 Beta 329932 Begin -->
	  	     <xsl:with-param name="buttontwo_fnc">clearAll()</xsl:with-param>
<!--Changes for 10.2.02 Beta 329932 End-->
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
		      <xsl:with-param name="checkASCII">false</xsl:with-param>
                     </xsl:call-template>
	  <IFRAME name="hdifrm_empform" width="0" height="0"/>
              </xsl:template>
              <!--TrackerID: 113227 start of changes-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText4_alt1">
	                            <xsl:call-template name="label_alternate">
	                              <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText4']"/>
	                               <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText4_alt1</xsl:with-param>
	                               <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText4_alt1</xsl:with-param>
	                			   <xsl:with-param name="checkASCII">false</xsl:with-param>
	                			   <xsl:with-param name="starshow">false</xsl:with-param>
					<!--changes for Tracker 120416 start-->
					<xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
					<!--changes for Tracker 120416 end-->
	                		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>

	                            </xsl:call-template>
	                </xsl:template>
		<!--TrackerID: 113227 end of changes-->
              <!--Employer Address1-->
                  <xsl:template name="DemographicBO.MiscellaneousInfo.strText5">
                         <xsl:call-template name="label">
                         <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText5']"/>
                           <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText5</xsl:with-param>
                           <!-- changes for tracker 260249 start -->  
                           <!--<xsl:with-param name="concat">true</xsl:with-param>-->  
                           <!--<xsl:with-param name="ele1_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText5</xsl:with-param>-->  
                           <!--<xsl:with-param name="ele2_val">Premise</xsl:with-param>-->  
                           <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText5</xsl:with-param>
                           <!-- changes for tracker 260249 end -->  
                          <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
			  <xsl:with-param name="checkASCII">false</xsl:with-param>
                         </xsl:call-template>
                </xsl:template>
                <!--Employer Address2-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText6">
                     <xsl:call-template name="label">
                     <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText6']"/>
                       <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText6</xsl:with-param>
                     <!-- changes for tracker 260249 start -->  
                     <!--   <xsl:with-param name="concat">true</xsl:with-param> -->
                     <!-- <xsl:with-param name="ele1_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText6</xsl:with-param>-->
                     <!-- <xsl:with-param name="ele2_val">StreetName</xsl:with-param>-->
                     <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText6</xsl:with-param>
                     <!-- changes for tracker 260249 end -->  
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
		      <xsl:with-param name="checkASCII">false</xsl:with-param>
                     </xsl:call-template>
                </xsl:template>
                <!--Tracker ID 113276 changes start -->
                 <!--Employer Address3-->
		<xsl:template name="DemographicBO.MiscellaneousInfo.strText28">
		     <xsl:call-template name="label">
		     <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText28']"/>
		       <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText28</xsl:with-param>
		       <!-- changes for tracker 260249 start -->
		       <!-- <xsl:with-param name="concat">true</xsl:with-param>-->
		       <!-- <xsl:with-param name="ele1_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText28</xsl:with-param>-->
		      <!-- <xsl:with-param name="ele2_val">StreetName</xsl:with-param>-->
		      <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText28</xsl:with-param>
		     <!-- changes for tracker 260249 end -->	    
		      <!-- Changes for the ticket id 320003 starts -->
		      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
		      <!-- Changes for the ticket id 320003 ends -->
		      <xsl:with-param name="checkASCII">false</xsl:with-param>
		     </xsl:call-template>
		</xsl:template>
                <!--Tracker ID 113276 changes end -->
                <!--Employer Phone
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText7">
                     <xsl:call-template name="label">
                     <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText7']"/>
                       <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText7</xsl:with-param>
                       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText7</xsl:with-param>
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
                     </xsl:call-template>
                </xsl:template>-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText11">
			<xsl:call-template name="label">
				<xsl:with-param name="is_phone">true</xsl:with-param>
				<xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText7']"/>
				<xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText7</xsl:with-param>
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText11</xsl:with-param>
				<xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
			</xsl:call-template>
        </xsl:template>
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText8">
			<xsl:call-template name="label">
				<xsl:with-param name="is_phone">true</xsl:with-param>
				<xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText8']"/>
				<xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText8</xsl:with-param>
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText8</xsl:with-param>
				<xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
			</xsl:call-template>
        </xsl:template>
            <!--Employer Designation-->
                    <!-- CODE ADDED BY KAMAL for tracker id 349409 -->
	                                         <xsl:template name="DemographicBO.MiscellaneousInfo.strText9">
	                                                       <xsl:call-template name="lookup">
	                                                              <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText9']"/>
	                                                                      <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText9</xsl:with-param>
	                                                                      <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText9</xsl:with-param>
	                                                                       <!-- Field Rationalization changes start -->
	                                                                                    <!--   <xsl:with-param name="code_req">true</xsl:with-param> -->
	                                                                                                    <!-- Field Rationalization changes end -->
	                                                                                    <!--  TRACKER ID:150150  CHANGES BEGIN   -->
	                                                                                                    <xsl:with-param name="buttonone_name" select="$configLabels_4[@name='BTN_LOOKUP']/@configLabel"/>
	                                                                                                    <xsl:with-param name="buttontwo_name" select="$configLabels_4[@name='BTN_CLEAR']/@configLabel"/>
	                                                                                                    <xsl:with-param name="buttonone_fnc">categoryLookup('DESIGNATION', '<xsl:value-of select="$boName"/>.MiscellaneousInfo.strText9')</xsl:with-param>
	                                                                                                    <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.MiscellaneousInfo.strText9')</xsl:with-param>
	                                                                                                    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	                                                                                                    <xsl:with-param name="checkASCII">false</xsl:with-param>
	                                                                                    <!--  TRACKER ID:150150  CHANGES END  -->
	                                                                                                    <!-- CIF Changes for Caching Views : Start -->
	                                                                    <xsl:with-param name="presdata" select="$PresData"/>
	                                                                    <!-- CIF Changes for Caching Views : End -->
	                                                                           </xsl:call-template>
	                                        </xsl:template>
	            
  <!-- CODE ADDED BY KAMAL for tracker id 349409 -->
            <xsl:template name="DemographicBO.MiscellaneousInfo.dtDate1">
                     <xsl:call-template name="label">
                     <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.dtDate1']"/>
                       <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.dtDate1</xsl:with-param>
                       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.dtDate1</xsl:with-param>
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
                      <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
			<!-- calling the function isGregDate for on blur functionality-->
                      <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.MiscellaneousInfo.dtDate1");</xsl:with-param>
                      <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
                       </xsl:call-template>
            </xsl:template>
            <!-- Total Period of Employment-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText10">
                 <xsl:call-template name="label">
                      <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText10']"/>
                      <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText10</xsl:with-param>
                      <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText10</xsl:with-param>
                      <!-- Tracker 68932 Begin of Changes-->
                      <xsl:with-param name="max_length">50</xsl:with-param>
                      <!-- Tracker 68932 End of Changes-->
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
                      <!-- Changes made for call id 260080:: start-->
                      <xsl:with-param name="fn_onBlur">formatDemoEmpIntField(document.getElementsByName("DemographicBO.MiscellaneousInfo.strText10")[0]);</xsl:with-param>
                    <!-- <xsl:with-param name="fn_onBlur">formatInt(document.getElementsByName("DemographicBO.MiscellaneousInfo.strText10")[0],gettingDigitGroupNumber());</xsl:with-param> -->
                    <!-- Changes made for call id 260080:: end-->
               </xsl:call-template>
            </xsl:template>
            <!-- User Field1-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText23">
                 <xsl:call-template name="label">
                      <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText23']"/>
                      <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText23</xsl:with-param>
                      <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText23</xsl:with-param>
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
               </xsl:call-template>
            </xsl:template>
            <!-- User Field2-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText24">
                 <xsl:call-template name="label">
                      <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText24']"/>
                      <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText24</xsl:with-param>
                      <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText24</xsl:with-param>
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
               </xsl:call-template>
            </xsl:template>
            <!-- User Field3-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText25">
                 <xsl:call-template name="label">
                      <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText25']"/>
                      <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText25</xsl:with-param>
                      <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText25</xsl:with-param>
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
               </xsl:call-template>
            </xsl:template>
            <!-- User Field4-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText26">
             <xsl:call-template name="mdrpdown">
                      <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText26']"/>
             <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText26</xsl:with-param>
             <xsl:with-param name="selectdisp">DemographicBO.MiscellaneousInfo.strText26</xsl:with-param>
             <xsl:with-param name="search_type">value</xsl:with-param>
             <xsl:with-param name="choice_name">DemographicBO.MiscellaneousInfo.strText26</xsl:with-param>
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
             <xsl:with-param name="onchangefn">fnEnableFields();clearAll();</xsl:with-param>
 	<!-- CIF Changes for Caching Views : Start -->
          	<xsl:with-param name="presdata" select="$PresData"/>
 	<!-- CIF Changes for Caching Views : End -->
               </xsl:call-template>
            </xsl:template>
            <!-- User Field5-->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText27">
                 <xsl:call-template name="label">
                      <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.strText27']"/>
                      <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText27</xsl:with-param>
                      <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText27</xsl:with-param>
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
               </xsl:call-template>
            </xsl:template>
              <xsl:template name="DemographicBO.MiscellaneousInfo.EmployeeID">
                 <xsl:call-template name="label">
                      <xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.EmployeeID']"/>
                      <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.EmployeeID</xsl:with-param>
                      <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.EmployeeID</xsl:with-param>
					  <!--Changes for call id:::582419  begins-->
					  <xsl:with-param name="max_length">10</xsl:with-param>
					   <!--Changes for call id:::582419  ends -->
                      <xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
               </xsl:call-template>
            </xsl:template>

	<xsl:template name="DemographicBO.MiscellaneousInfo.EmployerID">
			<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels_4[@name='DemographicBO.MiscellaneousInfo.EmployerID']"/>
			<xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.EmployerID</xsl:with-param>
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.EmployerID</xsl:with-param>
            <!-- Recon for Call Id:358353 -->
			<xsl:with-param name="buttonone_fnc">fnBluropenCoreEmployerIDLookup('EmpID')</xsl:with-param>
			<!--Changes for TOL ID 583118 --> 
                           <xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.MiscellaneousInfo.EmployerID');clearEmployeeName();</xsl:with-param> 

			<xsl:with-param name="UsrDataSpace">CURRENTEMPLOYMENT</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
			</xsl:call-template>
		</xsl:template>
<!-- vinaya : Income / expenses for salaried start -->
      <xsl:template name="DemographicBO.SalAllowances">
         <xsl:call-template name="amountlabel">
             <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SalAllowances']"/>
             <xsl:with-param name="ele_name">DemographicBO.SalAllowances</xsl:with-param>
             <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SalAllowances</xsl:with-param>    <xsl:with-param name="fncname">rate("3_DemographicBO.SalAllowances","<xsl:value-of select="$boName"/>.CU_SalAllowances",'<xsl:value-of select="$currency"/>');</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_SalAllowances</xsl:with-param>
            <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_SalAllowances</xsl:with-param>
            <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.SalAllowances","<xsl:value-of select="$boName"/>.CU_SalAllowances");</xsl:with-param>
	    <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
      </xsl:template>
    <xsl:template name="DemographicBO.SalProrataMonthlyIncentive">
         <xsl:call-template name="amountlabel">
           <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SalProrataMonthlyIncentive']"/>
             <xsl:with-param name="ele_name">DemographicBO.SalProrataMonthlyIncentive</xsl:with-param>
             <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SalProrataMonthlyIncentive</xsl:with-param>   <xsl:with-param name="fncname">rate("3_DemographicBO.SalProrataMonthlyIncentive","<xsl:value-of select="$boName"/>.CU_SalProrataMonthlyIncentive",'<xsl:value-of select="$currency"/>');</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_SalProrataMonthlyIncentive</xsl:with-param>
            <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_SalProrataMonthlyIncentive</xsl:with-param>
            <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.SalProrataMonthlyIncentive","<xsl:value-of select="$boName"/>.CU_SalProrataMonthlyIncentive");</xsl:with-param>
	    <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
     </xsl:template>
         <xsl:template name="DemographicBO.SalInterestSubsidy">
            <xsl:call-template name="amountlabel">
                 <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SalInterestSubsidy']"/>
                 <xsl:with-param name="ele_name">DemographicBO.SalInterestSubsidy</xsl:with-param>
                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SalInterestSubsidy</xsl:with-param>   <xsl:with-param name="fncname">rate("3_DemographicBO.SalInterestSubsidy","<xsl:value-of select="$boName"/>.CU_SalInterestSubsidy",'<xsl:value-of select="$currency"/>');</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_SalInterestSubsidy</xsl:with-param>
                <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_SalInterestSubsidy</xsl:with-param>
                <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.SalInterestSubsidy","<xsl:value-of select="$boName"/>.CU_SalInterestSubsidy");</xsl:with-param>
		<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
         </xsl:template>
         <xsl:template name="DemographicBO.SalOtherIncome2">
            <xsl:call-template name="amountlabel">
                 <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SalOtherIncome2']"/>
                 <xsl:with-param name="ele_name">DemographicBO.SalOtherIncome2</xsl:with-param>
                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SalOtherIncome2</xsl:with-param>  <xsl:with-param name="fncname">rate("3_DemographicBO.SalOtherIncome2","<xsl:value-of select="$boName"/>.CU_SalOtherIncome2",'<xsl:value-of select="$currency"/>');</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_SalOtherIncome2</xsl:with-param>
                <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_SalOtherIncome2</xsl:with-param>
                <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.SalOtherIncome2","<xsl:value-of select="$boName"/>.CU_SalOtherIncome2");</xsl:with-param>
		<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
        </xsl:template>
     <xsl:template name="DemographicBO.SalOtherIncome3">
         <xsl:call-template name="amountlabel">
            <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SalOtherIncome3']"/>
            <xsl:with-param name="ele_name">DemographicBO.SalOtherIncome3</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SalOtherIncome3</xsl:with-param>   <xsl:with-param name="fncname">rate("3_DemographicBO.SalOtherIncome3","<xsl:value-of select="$boName"/>.CU_SalOtherIncome3",'<xsl:value-of select="$currency"/>');</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_SalOtherIncome3</xsl:with-param>
            <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_SalOtherIncome3</xsl:with-param>
            <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.SalOtherIncome3","<xsl:value-of select="$boName"/>.CU_SalOtherIncome3");</xsl:with-param>
	    <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
     </xsl:template>
    <xsl:template name="DemographicBO.TotalEstAccountValue">
        <xsl:call-template name="amountlabel">
            <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.TotalEstAccountValue']"/>
            <xsl:with-param name="ele_name">DemographicBO.TotalEstAccountValue</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TotalEstAccountValue</xsl:with-param>  <xsl:with-param name="fncname">rate("3_DemographicBO.TotalEstAccountValue","<xsl:value-of select="$boName"/>.CU_TotalEstAccountValue",'<xsl:value-of select="$currency"/>');</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_TotalEstAccountValue</xsl:with-param>
            <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_TotalEstAccountValue</xsl:with-param>
            <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.TotalEstAccountValue","<xsl:value-of select="$boName"/>.CU_TotalEstAccountValue");</xsl:with-param>
	    <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
     </xsl:template>
    <xsl:template name="DemographicBO.TotalEstAccountValue_SelfEmployed">
        <xsl:call-template name="amountlabel">
            <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.TotalEstAccountValue']"/>
            <xsl:with-param name="ele_name">DemographicBO.TotalEstAccountValue_SelfEmployed</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TotalEstAccountValue</xsl:with-param>  <xsl:with-param name="fncname">rate("3_DemographicBO.TotalEstAccountValue","<xsl:value-of select="$boName"/>.CU_TotalEstAccountValue_SelfEmployed",'<xsl:value-of select="$currency"/>');</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_TotalEstAccountValue_SelfEmployed</xsl:with-param>
            <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_TotalEstAccountValue</xsl:with-param>
            <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.TotalEstAccountValue_SelfEmployed","<xsl:value-of select="$boName"/>.CU_TotalEstAccountValue_SelfEmployed");</xsl:with-param>
	    <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
        </xsl:call-template>
    </xsl:template>
      <xsl:template name="DemographicBO.TotalInvestmentInSharesandUnits">
         <xsl:call-template name="amountlabel">
             <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.TotalInvestmentInSharesandUnits']"/>
             <xsl:with-param name="ele_name">DemographicBO.TotalInvestmentInSharesandUnits</xsl:with-param>
             <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TotalInvestmentInSharesandUnits</xsl:with-param>  <xsl:with-param name="fncname">rate("3_DemographicBO.TotalInvestmentInSharesandUnits","<xsl:value-of select="$boName"/>.CU_TotalInvestmentInSharesandUnits",'<xsl:value-of select="$currency"/>');</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_TotalInvestmentInSharesandUnits</xsl:with-param>
            <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_TotalInvestmentInSharesandUnits</xsl:with-param>
            <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.TotalInvestmentInSharesandUnits","<xsl:value-of select="$boName"/>.CU_TotalInvestmentInSharesandUnits");</xsl:with-param>
	    <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
       </xsl:template>
     <xsl:template name="DemographicBO.TotalMonthlyDebtServiceAmt">
         <xsl:call-template name="amountlabel">
             <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.TotalMonthlyDebtServiceAmt']"/>
             <xsl:with-param name="ele_name">DemographicBO.TotalMonthlyDebtServiceAmt</xsl:with-param>
             <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TotalMonthlyDebtServiceAmt</xsl:with-param>
             <xsl:with-param name="fncname">rate("3_DemographicBO.TotalMonthlyDebtServiceAmt","<xsl:value-of select="$boName"/>.CU_TotalMonthlyDebtServiceAmt",'<xsl:value-of select="$currency"/>');</xsl:with-param>
             <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_TotalMonthlyDebtServiceAmt</xsl:with-param>
             <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_TotalMonthlyDebtServiceAmt</xsl:with-param>
             <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.TotalMonthlyDebtServiceAmt","<xsl:value-of select="$boName"/>.CU_TotalMonthlyDebtServiceAmt");</xsl:with-param>
	     <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
     </xsl:template>
         <xsl:template name="DemographicBO.SelfempTaxReturnField">
            <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SelfempTaxReturnField']"/>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.SelfempTaxReturnField</xsl:with-param>
            <xsl:with-param name="selectdisp">DemographicBO.SelfempTaxReturnField</xsl:with-param>
            <xsl:with-param name="search_type">value</xsl:with-param>
            <xsl:with-param name="choice_name">DemographicBO.SelfempTaxReturnField</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
         </xsl:template>
    <xsl:template name="DemographicBO.SelfempGrossReciptCurrentYR">
         <xsl:call-template name="amountlabel">
            <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SelfempGrossReciptCurrentYR']"/>
             <xsl:with-param name="ele_name">DemographicBO.SelfempGrossReciptCurrentYR</xsl:with-param>
             <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SelfempGrossReciptCurrentYR</xsl:with-param>
             <xsl:with-param name="fncname">rate("3_DemographicBO.SelfempGrossReciptCurrentYR","<xsl:value-of select="$boName"/>.CU_SelfempGrossReciptCurrentYR",'<xsl:value-of select="$currency"/>');</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_SelfempGrossReciptCurrentYR</xsl:with-param>
            <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_SelfempGrossReciptCurrentYR</xsl:with-param>
            <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.SelfempGrossReciptCurrentYR","<xsl:value-of select="$boName"/>.CU_SelfempGrossReciptCurrentYR");</xsl:with-param>
	    <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
    </xsl:template>
     <xsl:template name="DemographicBO.SelfempGrossReceiptPriorYear">
          <xsl:call-template name="amountlabel">
              <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SelfempGrossReceiptPriorYear']"/>
              <xsl:with-param name="ele_name">DemographicBO.SelfempGrossReceiptPriorYear</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SelfempGrossReceiptPriorYear</xsl:with-param>
              <xsl:with-param name="fncname">rate("3_DemographicBO.SelfempGrossReceiptPriorYear",'<xsl:value-of select="$boName"/>.CU_SelfempGrossReceiptPriorYear','<xsl:value-of select="$currency"/>');</xsl:with-param>
              <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_SelfempGrossReceiptPriorYear</xsl:with-param>
              <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_SelfempGrossReceiptPriorYear</xsl:with-param>
              <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.SelfempGrossReceiptPriorYear","<xsl:value-of select="$boName"/>.CU_SelfempGrossReceiptPriorYear");</xsl:with-param>
	      <xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
     </xsl:template>
        <xsl:template name="DemographicBO.SelfempNetProfitCurrentYR">
             <xsl:call-template name="amountlabel">
                <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SelfempNetProfitCurrentYR']"/>
                <xsl:with-param name="ele_name">DemographicBO.SelfempNetProfitCurrentYR</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SelfempNetProfitCurrentYR</xsl:with-param>
                <xsl:with-param name="fncname">rate("3_DemographicBO.SelfempNetProfitCurrentYR",'<xsl:value-of select="$boName"/>.CU_SelfempNetProfitCurrentYR','<xsl:value-of select="$currency"/>');</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_SelfempNetProfitCurrentYR</xsl:with-param>
                <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_SelfempNetProfitCurrentYR</xsl:with-param>
                <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.SelfempNetProfitCurrentYR","<xsl:value-of select="$boName"/>.CU_SelfempNetProfitCurrentYR");</xsl:with-param>
		<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
         </xsl:template>
        <xsl:template name="DemographicBO.SelfempNetProfitPriorYR">
           <xsl:call-template name="amountlabel">
              <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SelfempNetProfitPriorYR']"/>
              <xsl:with-param name="ele_name">DemographicBO.SelfempNetProfitPriorYR</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SelfempNetProfitPriorYR</xsl:with-param>
              <xsl:with-param name="fncname">rate("3_DemographicBO.SelfempNetProfitPriorYR",'<xsl:value-of select="$boName"/>.CU_SelfempNetProfitPriorYR','<xsl:value-of select="$currency"/>');</xsl:with-param>
              <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_SelfempNetProfitPriorYR</xsl:with-param>
              <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_SelfempNetProfitPriorYR</xsl:with-param>
              <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.SelfempNetProfitPriorYR","<xsl:value-of select="$boName"/>.CU_SelfempNetProfitPriorYR");</xsl:with-param>
		<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
         </xsl:template>
       <xsl:template name="DemographicBO.SelfempDepreciationCurrentYear">
         <xsl:call-template name="amountlabel">
             <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SelfempDepreciationCurrentYear']"/>
             <xsl:with-param name="ele_name">DemographicBO.SelfempDepreciationCurrentYear</xsl:with-param>
             <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SelfempDepreciationCurrentYear</xsl:with-param>
             <xsl:with-param name="fncname">rate("3_DemographicBO.SelfempDepreciationCurrentYear",'<xsl:value-of select="$boName"/>.CU_SelfempDepreciationCurrentYear','<xsl:value-of select="$currency"/>');</xsl:with-param>
             <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_SelfempDepreciationCurrentYear</xsl:with-param>
             <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_SelfempDepreciationCurrentYear</xsl:with-param>
             <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.SelfempDepreciationCurrentYear","<xsl:value-of select="$boName"/>.CU_SelfempDepreciationCurrentYear");</xsl:with-param>
		<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
         </xsl:call-template>
       </xsl:template>
     <xsl:template name="DemographicBO.SelfempDepreciationPriorYear">
         <xsl:call-template name="amountlabel">
            <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SelfempDepreciationPriorYear']"/>
             <xsl:with-param name="ele_name">DemographicBO.SelfempDepreciationPriorYear</xsl:with-param>
             <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SelfempDepreciationPriorYear</xsl:with-param>
             <xsl:with-param name="fncname">rate("3_DemographicBO.SelfempDepreciationPriorYear","DemographicBO.CU_SelfempDepreciationPriorYear",'<xsl:value-of select="$currency"/>');</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_SelfempDepreciationPriorYear</xsl:with-param>
            <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_SelfempDepreciationPriorYear</xsl:with-param>
            <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.SelfempDepreciationPriorYear","<xsl:value-of select="$boName"/>.CU_SelfempDepreciationPriorYear");</xsl:with-param>
		<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
          </xsl:call-template>
       </xsl:template>
      <xsl:template name="DemographicBO.SelfempAverageAnnualTurnover">
         <xsl:call-template name="amountlabel">
             <xsl:with-param name="res_name" select="$configLabels_3[@name='DemographicBO.SelfempAverageAnnualTurnover']"/>
             <xsl:with-param name="ele_name">DemographicBO.SelfempAverageAnnualTurnover</xsl:with-param>
             <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SelfempAverageAnnualTurnover</xsl:with-param>
             <xsl:with-param name="fncname">rate("3_DemographicBO.SelfempAverageAnnualTurnover","DemographicBO.CU_SelfempAverageAnnualTurnover",'<xsl:value-of select="$currency"/>');</xsl:with-param>
             <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_SelfempAverageAnnualTurnover</xsl:with-param>
             <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_SelfempAverageAnnualTurnover</xsl:with-param>
             <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.SelfempAverageAnnualTurnover","<xsl:value-of select="$boName"/>.CU_SelfempAverageAnnualTurnover");</xsl:with-param>
		<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
          </xsl:call-template>
      </xsl:template>
       <!-- vinaya end -->
<!-- View : DemographicEmploymentDetails : End   -->
<!-- View : DemographicDemographicOtherDetails : Start   -->
<!--  RefCode Changes	-->
<!-- Field Rationalization changes start -->
          <xsl:template name="DemographicBO.Nationality">
	               <xsl:call-template name="lookup">
	               <xsl:with-param name="res_name" select="$configLabels_5[@name='DemographicBO.Nationality']"/>
	               <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Nationality</xsl:with-param>
	               <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Nationality</xsl:with-param>
	               <xsl:with-param name="code_req">true</xsl:with-param>
	               <xsl:with-param name="buttonone_name" select="$configLabels_4[@name='BTN_LOOKUP']/@configLabel"/>
	               <xsl:with-param name="buttontwo_name" select="$configLabels_4[@name='BTN_CLEAR']/@configLabel"/>
	               <xsl:with-param name="buttonone_fnc">categoryLookup('NATIONALITY', '<xsl:value-of select="$boName"/>.Nationality')</xsl:with-param>
	               <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Nationality')</xsl:with-param>
	               <xsl:with-param name="checkASCII">false</xsl:with-param>
	                     </xsl:call-template>
        </xsl:template>

       <xsl:template name="AvailableChannels">
            <xsl:call-template name="listview">
                <xsl:with-param name="ele_name">AvailableChannels</xsl:with-param>
                <xsl:with-param name="size">4</xsl:with-param>
                <xsl:with-param name="multiple">false</xsl:with-param>
                <xsl:with-param name="class">listBox</xsl:with-param>
  	      <xsl:with-param name="ondblclick">selfield1(AvailableChannels,ChannelsAccessed)</xsl:with-param>
                <xsl:with-param name="selectname">AvailableChannels</xsl:with-param>
  	      <xsl:with-param name="selectdisp">AvailableChannels</xsl:with-param>
    	      <xsl:with-param name="search_type">url</xsl:with-param>
    	      <xsl:with-param name="presdata" select="$PresData"/>
            </xsl:call-template>
        </xsl:template>

        <xsl:template name="ChannelsAccessed">
            <xsl:call-template name="listview">
                <xsl:with-param name="ele_name">ChannelsAccessed</xsl:with-param>
                <xsl:with-param name="size">4</xsl:with-param>
                <xsl:with-param name="multiple">false</xsl:with-param>
                <xsl:with-param name="class">listBox</xsl:with-param>
                <xsl:with-param name="ondblclick">selfield1(ChannelsAccessed,AvailableChannels)</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.ChannelsAccessed</xsl:with-param>
        	      <xsl:with-param name="selectdisp">DemographicBO.ChannelsAccessed</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>
<!--  RefCode Changes	-->
<!-- for time being this is a text box -->
<xsl:template name="DemographicBO.Residence_Country">
 <xsl:call-template name="lookup">
 <xsl:with-param name="res_name" select="$configLabels_5[@name='DemographicBO.Residence_Country']"/>
 <xsl:with-param name="elename">DemographicBO.Residence_Country</xsl:with-param>
 <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Residence_Country</xsl:with-param>
  <!-- Field Rationalization changes start -->
  <xsl:with-param name="code_req">true</xsl:with-param>
 <!-- Field Rationalization changes end -->
 <xsl:with-param name="buttonone_name" select="$configLabels_4[@name='BTN_LOOKUP']/@configLabel"/>
 <xsl:with-param name="buttontwo_name" select="$configLabels_4[@name='BTN_CLEAR']/@configLabel"/>
 <!--Changes for call id 433698 STARTS-->
 <xsl:with-param name="buttonone_fnc">categoryLookup('COUNTRY', 'DemographicBO.Residence_Country');enableFields();</xsl:with-param>
 <!--Changes for call id 433698 ENDS-->
 <xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.Residence_Country')</xsl:with-param>
 <xsl:with-param name="checkASCII">false</xsl:with-param>
 </xsl:call-template>
</xsl:template>
         <xsl:template name="DemographicBO.Residence_Since">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_5[@name='DemographicBO.Residence_Since']"/>
              <xsl:with-param name="ele_name">DemographicBO.Residence_Since</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Residence_Since</xsl:with-param>
              <!-- TICKET:320331:BEGIN OF CHANGES-->
              <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
	      <!-- calling the function isGregDate for on blur functionality-->
              <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.Residence_Since");validateAgainstFutureDate("3_DemographicBO.Residence_Since");FieldsForValidation(true);</xsl:with-param>
              <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
              <!-- TICKET:320331:END OF CHANGES-->
            </xsl:call-template>
         </xsl:template>
<!--  RefCode Changes	-->
            <xsl:template name="DemographicBO.Marital_Status">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels_5[@name='DemographicBO.Marital_status_code']"/>
                            <!-- Ticket Id 248273 Changes Begin -->
                            <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.Marital_status_code</xsl:with-param>
                            <xsl:with-param name="ele_name">DemographicBO.Marital_status_code</xsl:with-param>
                            <!-- Ticket Id 248273 Changes End -->
                            <xsl:with-param name="selectdisp">DemographicBO.Marital_status_code</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Marital_Status</xsl:with-param>
                            <xsl:with-param name="choice_name">DemographicBO.Marital_status_code</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>
<!--  RefCode Changes	-->
<!-- View : DemographicDemographicOtherDetails : end   -->
<!-- Core Fields Inclusion Begin   -->
<!--  RefCode Changes	-->
            <xsl:template name="DemographicBO.CustCaste">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.CustCaste_code']"/>
                            <!-- STAR changes for Tracker Id 161162 -->
                            <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.CustCaste_code</xsl:with-param>
                            <xsl:with-param name="ele_name">DemographicBO.CustCaste_code</xsl:with-param>
                            <xsl:with-param name="selectdisp">DemographicBO.CustCaste_code</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CustCaste</xsl:with-param>
                            <!-- END changes for Tracker Id 161162 -->
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                            <xsl:with-param name="choice_name">DemographicBO.CustCaste_code</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>

<!-- CRM70t-St Tracker# 78444, Begin of Changes -->
       <!-- <xsl:template name="DemographicBO.TDSTable">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.TDSTableCode']"/>
                            <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.TDSTable</xsl:with-param>
                            <xsl:with-param name="selectdisp">DemographicBO.TDSTableCode</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.TDSTableCode</xsl:with-param>
				<xsl:with-param name="presdata" select="$PresData"/>
                            <xsl:with-param name="choice_name">DemographicBO.TDSTableCode</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>  -->
<!-- CRM70t-St Tracker# 78444, End of Changes -->

		<xsl:template name="DemographicBO.CustFinYearEndMonth">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.CustFinYearEndMonth']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CustFinYearEndMonth</xsl:with-param>
                <xsl:with-param name="selectdisp">DemographicBO.CustFinYearEndMonth</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="choice_name">DemographicBO.CustFinYearEndMonth</xsl:with-param>
		<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
		<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
        </xsl:template>
		<xsl:template name="DemographicBO.ShareholderType">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.ShareholderType']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.ShareholderType</xsl:with-param>
                <xsl:with-param name="selectdisp">DemographicBO.ShareholderType</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="choice_name">DemographicBO.ShareholderType</xsl:with-param>
		<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
		<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
        </xsl:template>

        <!--<xsl:template name="DemographicBO.NRERelative">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels_5[@name='DemographicBO.NRERelativeCode']"/>
                            <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.NRERelative</xsl:with-param>
                            <xsl:with-param name="selectdisp">DemographicBO.NRERelativeCode</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.NRERelativeCode</xsl:with-param>
                            <xsl:with-param name="choice_name">DemographicBO.NRERelativeCode</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>-->


<!--  Customization Change: changes for dropdown to lookup starts:CallID 226569  -->

<xsl:template name="DemographicBO.NRERelative">
                     <xsl:call-template name="lookup">
                     <xsl:with-param name="res_name" select="$configLabels_5[@name='DemographicBO.NRERelativeCode']"/>
                     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.NRERelativeCode</xsl:with-param>
                     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.NRERelative</xsl:with-param>
                     <xsl:with-param name="buttonone_name" select="$configLabels_5[@name='LOOKUP']/@configLabel"/>
                     <xsl:with-param name="buttontwo_name" select="$configLabels_5[@name='CLEAR']/@configLabel"/>
                     <xsl:with-param name="buttonone_fnc">categoryLookup('RELATION', '<xsl:value-of select="$boName"/>.NRERelativeCode')</xsl:with-param>
                     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.NRERelativeCode')</xsl:with-param>
                     <xsl:with-param name="checkASCII">false</xsl:with-param>
                     <xsl:with-param name="code_req">true</xsl:with-param>
                     </xsl:call-template>
      </xsl:template>   

<!--  Customization Change: changes for dropdown to lookup ends:CallID 226569  -->

<!--  RefCode Changes	-->
 <xsl:template name="DemographicBO.NRECountryType">
            <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels_5[@name='DemographicBO.NRECountryType']"/>
              <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.NRECountryType</xsl:with-param>
          <xsl:with-param name="selectdisp">DemographicBO.NRECountryType</xsl:with-param>
          <xsl:with-param name="search_type">value</xsl:with-param>
          <xsl:with-param name="choice_name">DemographicBO.NRECountryType</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
        <xsl:template name="DemographicBO.TDSCustId">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.TDSCustId']"/>
                <xsl:with-param name="ele_name">DemographicBO.TDSCustId</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TDSCustId</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.TDSExcemptRefNo">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.TDSExcemptRefNo']"/>
                <xsl:with-param name="ele_name">DemographicBO.TDSExcemptRefNo</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TDSExcemptRefNo</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.TDSExcemptRemarks">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.TDSExcemptRemarks']"/>
                <xsl:with-param name="ele_name">DemographicBO.TDSExcemptRemarks</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TDSExcemptRemarks</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.EmployerId">
			<xsl:call-template name="lookup">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.EmployerId']"/>
			<xsl:with-param name="elename">DemographicBO.EmployerId</xsl:with-param>
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.EmployerId</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
 			<xsl:with-param name="buttonone_name" select="$configLabels_4[@name='BTN_LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels_4[@name='BTN_CLEAR']/@configLabel"/>
			<xsl:with-param name="buttonone_fnc">categoryLookupCode('EMPLOYER_ID', 'DemographicBO.EmployerId','EmployerId_code')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.EmployerId')</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
            </xsl:call-template>
<!--changes for recon id 146406 starts-->
			<!--<input type="hidden" name="EmployerId_code" value="{$EmployerId_code}"/>-->
<!--changes for recon id 146406 ends-->

        </xsl:template>
        <xsl:template name="DemographicBO.NRERelativeName">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_5[@name='DemographicBO.NRERelativeName']"/>
                <xsl:with-param name="ele_name">DemographicBO.NRERelativeName</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.NRERelativeName</xsl:with-param>
				<xsl:with-param name="checkASCII">false</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <!--TrackerID: 113227 start of changes-->
                <xsl:template name="DemographicBO.NRERelativeName_alt1">
	            <xsl:call-template name="label_alternate">
	                <xsl:with-param name="res_name" select="$configLabels_5[@name='DemographicBO.NRERelativeName']"/>
	                <xsl:with-param name="ele_name">DemographicBO.NRERelativeName_alt1</xsl:with-param>
	                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.NRERelativeName_alt1</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>
			<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
	            </xsl:call-template>
	        </xsl:template>


	  <!--TrackerID: 113227 end of changes-->
        <xsl:template name="DemographicBO.AdvanceAsOnDate">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.AdvanceAsOnDate']"/>
                <xsl:with-param name="ele_name">DemographicBO.AdvanceAsOnDate</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.AdvanceAsOnDate</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		<!-- calling the function isGregDate for on blur functionality-->
                <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.AdvanceAsOnDate");</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
            </xsl:call-template>
        </xsl:template>

        <xsl:template name="DemographicBO.CustAssetsAsOnDate">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.CustAssetsAsOnDate']"/>
                <xsl:with-param name="ele_name">DemographicBO.CustAssetsAsOnDate</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CustAssetsAsOnDate</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		<!-- calling the function isGregDate for on blur functionality-->
                <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.CustAssetsAsOnDate");</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
            </xsl:call-template>
        </xsl:template>

      <xsl:template name="DemographicBO.TotalFundBase">
            <xsl:call-template name="amountlabel">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.TotalFundBase']"/>
                <xsl:with-param name="ele_name">DemographicBO.TotalFundBase</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TotalFundBase</xsl:with-param>
                <xsl:with-param name="fncname">rate('3_DemographicBO.TotalFundBase','<xsl:value-of select="$boName"/>.CU_TotalFundBase','<xsl:value-of select="$currency"/>');</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_TotalFundBase</xsl:with-param>
                <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_TotalFundBase</xsl:with-param>
                <xsl:with-param name="onchangefn">checkDropValue('3_DemographicBO.TotalFundBase','<xsl:value-of select="$boName"/>.CU_TotalFundBase');</xsl:with-param>
		<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
             </xsl:call-template>
     </xsl:template>
      <xsl:template name="DemographicBO.TotalNonFundBase">
            <xsl:call-template name="amountlabel">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.TotalNonFundBase']"/>
                <xsl:with-param name="ele_name">DemographicBO.TotalNonFundBase</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TotalNonFundBase</xsl:with-param>
                <xsl:with-param name="fncname">rate('3_DemographicBO.TotalNonFundBase','<xsl:value-of select="$boName"/>.CU_TotalNonFundBase','<xsl:value-of select="$currency"/>');</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_TotalNonFundBase</xsl:with-param>
                <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_TotalNonFundBase</xsl:with-param>
                <xsl:with-param name="onchangefn">checkDropValue('3_DemographicBO.TotalNonFundBase','<xsl:value-of select="$boName"/>.CU_TotalNonFundBase');</xsl:with-param>
		<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
             </xsl:call-template>
     </xsl:template>
      <xsl:template name="DemographicBO.CustNetWorth">
            <xsl:call-template name="amountlabel">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.CustNetWorth']"/>
                <xsl:with-param name="ele_name">DemographicBO.CustNetWorth</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CustNetWorth</xsl:with-param>
                <xsl:with-param name="fncname">rate('3_DemographicBO.CustNetWorth','<xsl:value-of select="$boName"/>.CU_CustNetWorth','<xsl:value-of select="$currency"/>');</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_CustNetWorth</xsl:with-param>
                <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_CustNetWorth</xsl:with-param>
                <xsl:with-param name="onchangefn">checkDropValue('3_DemographicBO.CustNetWorth','<xsl:value-of select="$boName"/>.CU_CustNetWorth');</xsl:with-param>
		<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
        </xsl:call-template>
     </xsl:template>
        <xsl:template name="DemographicBO.OtherLimits">
            <xsl:call-template name="amountlabel">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.OtherLimits']"/>
                <xsl:with-param name="ele_name">DemographicBO.OtherLimits</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.OtherLimits</xsl:with-param>
                <xsl:with-param name="fncname">rate('3_DemographicBO.OtherLimits','<xsl:value-of select="$boName"/>.CU_OtherLimits','<xsl:value-of select="$currency"/>');</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_OtherLimits</xsl:with-param>
                <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_OtherLimits</xsl:with-param>
                <xsl:with-param name="onchangefn">checkDropValue('3_DemographicBO.OtherLimits','<xsl:value-of select="$boName"/>.CU_OtherLimits');</xsl:with-param>
		<xsl:with-param name="choicename">Currency</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
             </xsl:call-template>
     </xsl:template>
        <xsl:template name="DemographicBO.TDSExcemptEndDate">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.TDSExcemptEndDate']"/>
                <xsl:with-param name="ele_name">DemographicBO.TDSExcemptEndDate</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TDSExcemptEndDate</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		<!-- calling the function isGregDate for on blur functionality-->
				<!-- Changes done for tracker # 478146 for Tax Exemption start date & end date starts here -->
                <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.TDSExcemptEndDate");validateTax_Exmpt();</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="DemographicBO.TDSExcemptSubmitDate">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.TDSExcemptSubmitDate']"/>
                <xsl:with-param name="ele_name">DemographicBO.TDSExcemptSubmitDate</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TDSExcemptSubmitDate</xsl:with-param>
				<xsl:with-param name="fn_onBlur">validateTdsDates("3_DemographicBO.TDSExcemptSubmitDate");</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        
             <!--changes For TDS Enhancement starts -->
	        
	       <xsl:template name="DemographicBO.Tax_Exmpt_Start_Date">
	       	                     <xsl:call-template name="label">
	       	                     <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.Tax_Exmpt_Start_Date']"/>
	       	                     <xsl:with-param name="ele_name">DemographicBO.Tax_Exmpt_Start_Date</xsl:with-param>
	       	                     <!--changes for ticket id 766394-->
	       	                     <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Tax_Exmpt_Start_Date</xsl:with-param>
	       	                     <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.Tax_Exmpt_Start_Date");validateTax_Exmpt();</xsl:with-param>
	       	                     </xsl:call-template>
	                             </xsl:template>
	               
	               <xsl:template name="DemographicBO.No_Tax_Recal_Beyond_Date">
	       		           <xsl:call-template name="label">
	       		           <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.No_Tax_Recal_Beyond_Date']"/>
	       		           <xsl:with-param name="ele_name">DemographicBO.No_Tax_Recal_Beyond_Date</xsl:with-param>
	       		           <xsl:with-param name="ele_val">DemographicBO.No_Tax_Recal_Beyond_Date</xsl:with-param>
	       		           <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.No_Tax_Recal_Beyond_Date");</xsl:with-param>
	       		           </xsl:call-template>
	                           </xsl:template>
	               
	               
	               <xsl:template name="DemographicBO.Tax_Rate_Table_Code">
			         <xsl:call-template name="lookup">
			         <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.Tax_Rate_Table_Code']"/>
			         <xsl:with-param name="elename">DemographicBO.Tax_Rate_Table_Code</xsl:with-param>
			         <xsl:with-param name="eleval">DemographicBO.Tax_Rate_Table_Code</xsl:with-param>
			         <xsl:with-param name="buttonone_name" select="$configLabels_4[@name='BTN_LOOKUP']/@configLabel"/>
			         <xsl:with-param name="buttontwo_name" select="$configLabels_4[@name='BTN_CLEAR']/@configLabel"/>
			         <xsl:with-param name="buttonone_fnc">categoryLookup('TAX_SLAB', 'DemographicBO.Tax_Rate_Table_Code')</xsl:with-param>
			         <xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.Tax_Rate_Table_Code')</xsl:with-param>
				 <xsl:with-param name="checkASCII">false</xsl:with-param>
	       	                 </xsl:call-template>
	             </xsl:template>
	
	    <!-- changes For TDS Enhancement ends-->
        
        

<!-- Changes for Tracker # 88712 Start -->
       <xsl:template name="DemographicBO.CustBusinessAssets">
             <xsl:call-template name="amountlabel">
                 <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.CustBusinessAssets']"/>
                 <xsl:with-param name="ele_name">DemographicBO.CustBusinessAssets</xsl:with-param>
                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CustBusinessAssets</xsl:with-param>
                 <xsl:with-param name="fncname">rate('3_DemographicBO.CustBusinessAssets','<xsl:value-of select="$boName"/>.CU_CustBusinessAssets','<xsl:value-of select="$currency"/>');</xsl:with-param>
                 <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_CustBusinessAssets</xsl:with-param>
                 <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_CustBusinessAssets</xsl:with-param>
                 <xsl:with-param name="onchangefn">checkDropValue('3_DemographicBO.CustBusinessAssets','<xsl:value-of select="$boName"/>.CU_CustBusinessAssets');</xsl:with-param>
 		<xsl:with-param name="choicename">Currency</xsl:with-param>
 			<!-- CIF Changes for Caching Views : Start -->
 				<xsl:with-param name="presdata" select="$PresData"/>
 			<!-- CIF Changes for Caching Views : End -->
              </xsl:call-template>
      </xsl:template>

        <xsl:template name="DemographicBO.CustPropertyAssets">
              <xsl:call-template name="amountlabel">
                  <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.CustPropertyAssets']"/>
                  <xsl:with-param name="ele_name">DemographicBO.CustPropertyAssets</xsl:with-param>
                  <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CustPropertyAssets</xsl:with-param>
                  <xsl:with-param name="fncname">rate('3_DemographicBO.CustPropertyAssets','<xsl:value-of select="$boName"/>.CU_CustPropertyAssets','<xsl:value-of select="$currency"/>');</xsl:with-param>
                  <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_CustPropertyAssets</xsl:with-param>
                  <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_CustPropertyAssets</xsl:with-param>
                  <xsl:with-param name="onchangefn">checkDropValue('3_DemographicBO.CustPropertyAssets','<xsl:value-of select="$boName"/>.CU_CustPropertyAssets');</xsl:with-param>
  		<xsl:with-param name="choicename">Currency</xsl:with-param>
  			<!-- CIF Changes for Caching Views : Start -->
  				<xsl:with-param name="presdata" select="$PresData"/>
  			<!-- CIF Changes for Caching Views : End -->
               </xsl:call-template>
       </xsl:template>

        <xsl:template name="DemographicBO.CustDepositsInOtherBanks">
              <xsl:call-template name="amountlabel">
                  <xsl:with-param name="res_name" select="$configLabels_1[@name='DemographicBO.CustDepositsInOtherBanks']"/>
                  <xsl:with-param name="ele_name">DemographicBO.CustDepositsInOtherBanks</xsl:with-param>
                  <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CustDepositsInOtherBanks</xsl:with-param>
                  <xsl:with-param name="fncname">rate('3_DemographicBO.CustDepositsInOtherBanks','<xsl:value-of select="$boName"/>.CU_CustDepositsInOtherBanks','<xsl:value-of select="$currency"/>');</xsl:with-param>
                  <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_CustDepositsInOtherBanks</xsl:with-param>
                  <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_CustDepositsInOtherBanks</xsl:with-param>
                  <xsl:with-param name="onchangefn">checkDropValue('3_DemographicBO.CustDepositsInOtherBanks','<xsl:value-of select="$boName"/>.CU_CustDepositsInOtherBanks');</xsl:with-param>
  		<xsl:with-param name="choicename">Currency</xsl:with-param>
  			<!-- CIF Changes for Caching Views : Start -->
  				<xsl:with-param name="presdata" select="$PresData"/>
  			<!-- CIF Changes for Caching Views : End -->
               </xsl:call-template>
       </xsl:template>

<!-- Changes for Tracker # 88712 End-->

<!-- Core Fields Inclusion End   -->
<!-- unique Id's : start -->
<!--commented for IDENTIFICATION DOCUMENT CHANGES start
<xsl:template name="Customer_ID">
        <xsl:call-template name="CustUniqueID">
        <xsl:with-param name="CustUniqueIDBO"><xsl:value-of select="$boName"/></xsl:with-param>
        </xsl:call-template>
</xsl:template>
commented for IDENTIFICATION DOCUMENT CHANGES end-->
<!-- unique Id's : end -->
        <xsl:template match="*" mode="mode1">
        <xsl:call-template name="Begin"/>
        <td>
        <form name="frm2"  method="post" action="../servlet/com.infy.cis.ui.common.DemographicWriter">
        		   <!--Tracker id 113227 changes start-->
			   <input type="hidden" name="altLocaleActv" />
 			   <!--Tracker id 113227 changes end-->
                           <input type="hidden" name="hid_concurDetectX" value="{$concurDetectX}"/>
                           <input type="hidden" name="hid_demographicID" value="{$demographicID}"/>
			  <!-- new added hidden : for :Copy :start -->
          	           <!-- variable for account Key-->
          	           <input type="hidden" name="accKey" value="{$accKey}"/>
          	           <!-- Core Dependency changes -->
          	           <input type="hidden" name="susKey" value="{$susKey}"/>
          	           <input type="hidden" name="contKey" value="{$contKey}"/>
          	           <!-- Core Dependency changes -->
			   <input type="hidden" name="ModAccID" value=""/>
			   <input type="hidden" name="CoreCustID" value=""/>
			   <!-- Core Dependency changes -->
			   <input type="hidden" name="modSusID" value=""/>
			   <input type="hidden" name="modContID" value=""/>
			   <!-- Core Dependency changes -->
			   <input type="hidden" name="mainAccId" value="{$mainAccId}"/>
			   <input type="hidden" name="IsCopy" value="{$isCopy}"/>
          	          <!-- new added hidden : for :Copy :end -->
                           <input type="hidden" name="hid_UserID" value=""/>
			   <input type="hidden" name="accID" value=""/>
                           <input type="hidden" name="hTodayDate" value=""/>
                           <input type="hidden" name="WorkPhoneNoCountryCode" value=""/>
                           <input type="hidden" name="WorkPhoneNoCityCode" value=""/>
                           <input type="hidden" name="WorkPhoneNoLocalCode" value=""/>
                           <input type="hidden" name="HomePhoneNoCountryCode" value=""/>
                           <input type="hidden" name="HomePhoneNoCityCode" value=""/>
                           <input type="hidden" name="HomePhoneNoLocalCode" value=""/>
                           <input type="hidden" name="CellPhoneNoCountryCode" value=""/>
                           <input type="hidden" name="CellPhoneNoCityCode" value=""/>
                           <input type="hidden" name="CellPhoneNoLocalCode" value=""/>
                           <input type="hidden" name="FaxNoCountryCode" value=""/>
                           <input type="hidden" name="FaxNoCityCode" value=""/>
                           <input type="hidden" name="FaxNoLocalCode" value=""/>
                           <!-- for pager number -->
                           <input type="hidden" name="DemographicBO.PagerNoCountryCode"/>
                           <input type="hidden" name="DemographicBO.PagerNoAreaCode"/>
                           <input type="hidden" name="DemographicBO.PagerNoLocalCode"/>
                           <!-- for other phone number -->
                           <input type="hidden" name="DemographicBO.PhoneOtherCountry"/>
                           <input type="hidden" name="DemographicBO.PhoneOtherArea"/>
                           <input type="hidden" name="DemographicBO.PhoneOtherLocal"/>
                           <!-- for preferred daytime contact number -->
                           <input type="hidden" name="DemographicBO.prefDaytimeContNoCountry"/>
                           <input type="hidden" name="DemographicBO.prefDaytimeContNoArea"/>
                           <input type="hidden" name="DemographicBO.prefDaytimeContNoLocal"/>
                           <!-- for current employer's phone number -->
                           <input type="hidden" name="DemographicBO.MiscellaneousInfo.strText11"/>
                           <input type="hidden" name="DemographicBO.MiscellaneousInfo.strText12"/>
                           <input type="hidden" name="DemographicBO.MiscellaneousInfo.strText13"/>
                           <!-- for current employer's fax number -->
                           <input type="hidden" name="DemographicBO.MiscellaneousInfo.strText14"/>
                           <input type="hidden" name="DemographicBO.MiscellaneousInfo.strText15"/>
                           <input type="hidden" name="DemographicBO.MiscellaneousInfo.strText16"/>
                           <!-- for previous employer's phone number -->
                           <input type="hidden" name="DemographicBO.EmploymentHistory.strText11"/>
                           <input type="hidden" name="DemographicBO.EmploymentHistory.strText12"/>
                           <input type="hidden" name="DemographicBO.EmploymentHistory.strText13"/>
                           <!-- for previous employer's fax number -->
                           <input type="hidden" name="DemographicBO.EmploymentHistory.strText14"/>
                           <input type="hidden" name="DemographicBO.EmploymentHistory.strText15"/>
                           <input type="hidden" name="DemographicBO.EmploymentHistory.strText16"/>
                           <input type="hidden" name="Institution" value=""/>
                           <input type="hidden" name="Qualification" value=""/>
                           <input type="hidden" name="AddressLine1" value=""/>
                           <input type="hidden" name="AddressLine2" value=""/>
                           <input type="hidden" name="AddressLine3" value=""/>
                           <input type="hidden" name="City" value=""/>
                           <input type="hidden" name="State" value=""/>
                           <input type="hidden" name="Country" value=""/>
                           <input type="hidden" name="Zip" value=""/>
                           <input type="hidden" name="ClubMembership" value=""/>
                           <input type="hidden" name="EduRemoved" value=""/>
                           <input type="hidden" name="EduURL" value=""/>
                           <input type="hidden" name="EduID" value=""/>
                           <input type="hidden" name="MarksPercent" value=""/>
<!--
                           <input type="hidden" name="Month" value=""/>
                           <input type="hidden" name="DD" value=""/>
                           <input type="hidden" name="YY" value=""/>
-->
			   <input type="hidden" name="gradDate" value=""/>
                           <input type="hidden" name="MainSubject" value=""/>
                           <input type="hidden" name="MClass" value=""/>
                           <input type="hidden" name="MarksObtained" value=""/>
      		<!--Changes for call id 194291 Start-->
      		<input type="hidden" name="Edu_strText1" value=""/>
      		<input type="hidden" name="Edu_strText9" value=""/>
      		<input type="hidden" name="Edu_strText11" value=""/>
      		<input type="hidden" name="Edu_strText12" value=""/>
      		<input type="hidden" name="Edu_strText13" value=""/>
      		<input type="hidden" name="Edu_strText14" value=""/>
      		<input type="hidden" name="Edu_strText17" value=""/>
      		<input type="hidden" name="Edu_strText18" value=""/>
      		<input type="hidden" name="Edu_strText19" value=""/>
      		<input type="hidden" name="Edu_strText20" value=""/>
      		<input type="hidden" name="Edu_strText21" value=""/>
      		<input type="hidden" name="Edu_strText24" value=""/>
      		<input type="hidden" name="Edu_strText25" value=""/>
      		<input type="hidden" name="Edu_strText26" value=""/>
      		<input type="hidden" name="Edu_strText27" value=""/>
      		<!--Changes for call id 194291 End-->

		<!-- CIF changes for EmploymentHistory MultiRec starts -->
		<!-- Hidden fields added -->

			   <input type="hidden" name="isMCEditedDemo" value="N"/>
			   <input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
			   <input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
			   <input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>
			   <input type="hidden" name="EmpHistDetailID" value=""/>
			   <input type="hidden" name="miscInfoType" value=""/>
			   <input type="hidden" name="currEmpDOJ" value=""/>
			   <input type="hidden" name="Profession" value=""/>
			   <input type="hidden" name="Industry" value=""/>
			   <input type="hidden" name="EmployerName" value=""/>
			  <!--changes for Tracker 120416 start-->
			   <input type="hidden" name="EmployerName_alt1" value=""/>
			  <!--changes for Tracker 120416 end-->
			   <input type="hidden" name="Fax" value=""/>
			   <input type="hidden" name="Address" value=""/>
			   <input type="hidden" name="Phone" value=""/>
			   <input type="hidden" name="Designation" value=""/>
			   <input type="hidden" name="dateOfJoining" value=""/>
			   <input type="hidden" name="dateOfLeaving" value=""/>
			   <input type="hidden" name="Period" value=""/>
			   <input type="hidden" name="strText17" value=""/>
			   <input type="hidden" name="strText18" value=""/>
			   <input type="hidden" name="strText19" value=""/>
			   <input type="hidden" name="strText20" value=""/>
			   <input type="hidden" name="strText21" value=""/>
			   <input type="hidden" name="strText22" value=""/>
			   <input type="hidden" name="strText23" value=""/>
			   <input type="hidden" name="strText24" value=""/>
			   <input type="hidden" name="strText25" value=""/>
			   <!-- for employer lookup -->
			   <input type="hidden" name="strText26" value=""/>
			   <input type="hidden" name="EmployerID" value=""/>
			   <!-- Field Rationalization changes -->
			   <input type="hidden" name="ChsAccessed" value=""/>
			   <!-- Field Rationalization changes -->
			<!-- Core Fields Inclusion Begin   -->
			   <input type="hidden" name="NRERelativeCode" value=""/>
			   <input type="hidden" name="Marital_Status_code" value=""/>
			   <input type="hidden" name="ResidenceCountry_code" value=""/>
			   <input type="hidden" name="Nationality_Code" value=""/>
			   <input type="hidden" name="TDSTableCode" value=""/>
			   <input type="hidden" name="CustCaste_code" value=""/>
			   <!-- call id:146406 changes begin -->
			   <input type="hidden" name="EmployerId_code" value=""/>
			   <!-- call id:146406 changes end -->
			<!-- Core Fields Inclusion End   -->
			   <!-- Save and Submit Passing the saveFlag to the Writer : Start -->
			  <input type="hidden" name="saveFlag" value=""/>
	     		   <!-- Save and Submit Passing the saveFlag to the Writer : End -->

		<!-- CIF changes for EmploymentHistory MultiRec ends -->
		<!-- Hidden variables for identification tab end-->
<!--IDENTIFICATION DOCUMENT CHANGES start-->
<!--saving identifier_type (unique id, Issue_Date, Valid_Date) in EntityTable for Retail start-->
		<input type="hidden" name="PAN.txt_ID"/>
		<input type="hidden" name="PAN.txt_Issue_Date"/>
		<input type="hidden" name="PAN.txt_Valid_Date"/>
		<input type="hidden" name="PAN.txt_Issue_Place"/>
		<!-- changes for adhar for tracker 375136 starts -->
		<input type="hidden" name="Unique Identification Number.txt_ID"/>
		<input type="hidden" name="Unique Identification Number.txt_Issue_Date"/>
		<input type="hidden" name="Unique Identification Number.txt_Valid_Date"/>
		<input type="hidden" name="Unique Identification Number.txt_Issue_Place"/>
		<!-- changes for adhar for tracker 375136 ends -->
		<input type="hidden" name="Ration Card Number.txt_ID"/>
		<input type="hidden" name="Ration Card Number.txt_Issue_Date"/>
		<input type="hidden" name="Ration Card Number.txt_Valid_Date"/>
		<input type="hidden" name="Ration Card Number.txt_Issue_Place"/>
		<input type="hidden" name="SSN.txt_ID"/>
		<input type="hidden" name="SSN.txt_Issue_Date"/>
		<input type="hidden" name="SSN.txt_Valid_Date"/>
		<input type="hidden" name="SSN.txt_Issue_Place"/>
		<input type="hidden" name="TIN.txt_ID"/>
		<input type="hidden" name="TIN.txt_Issue_Date"/>
		<input type="hidden" name="TIN.txt_Valid_Date"/>
		<input type="hidden" name="TIN.txt_Issue_Place"/>
		<input type="hidden" name="National Card Number.txt_ID"/>
		<input type="hidden" name="National Card Number.txt_Issue_Date"/>
		<input type="hidden" name="National Card Number.txt_Valid_Date"/>
		<input type="hidden" name="National Card Number.txt_Issue_Place"/>
		<input type="hidden" name="Election ID Card.txt_ID"/>
		<input type="hidden" name="Election ID Card.txt_Issue_Date"/>
		<input type="hidden" name="Election ID Card.txt_Valid_Date"/>
		<input type="hidden" name="Election ID Card.txt_Issue_Place"/>
		<input type="hidden" name="Driving Licence.txt_ID"/>
		<input type="hidden" name="Driving Licence.txt_Issue_Date"/>
		<input type="hidden" name="Driving Licence.txt_Valid_Date"/>
		<input type="hidden" name="Driving Licence.txt_Issue_Place"/>
		<input type="hidden" name="Passport Number.txt_ID"/>
		<input type="hidden" name="Passport Number.txt_Issue_Date"/>
		<input type="hidden" name="Passport Number.txt_Valid_Date"/>
		<input type="hidden" name="Passport Number.txt_Issue_Place"/>
<!--saving identifier_type (unique id, Issue_Date, Valid_Date) in EntityTable for Retail end-->

		<input type="hidden" name="unique_id" value=""/>
		<input type="hidden" name="dateofissue" value=""/>
		<input type="hidden" name="validity_date" value=""/>
		<input type="hidden" name="IDRemoved" value=""/>
		<input type="hidden" name="hidEntityDocumentID" value=""/>
		<input type="hidden" name="hidEntityDocumentURL" value=""/>
		<input type="hidden" name="hidDocCode" value=""/>
		<input type="hidden" name="hidDocDescr" value=""/>
		<input type="hidden" name="hidDocTypeCode" value=""/>
		<input type="hidden" name="hidDocTypeCode_alt1" value=""/>
		<input type="hidden" name="hidDocTypeDescr" value=""/>
		<input type="hidden" name="hidDocTypeDescr_alt1" value=""/>
		<input type="hidden" name="hidDocReceivedDate" value=""/>
		<input type="hidden" name="hidDocRemarks" value=""/>
		<input type="hidden" name="hidStatus" value=""/>
		<input type="hidden" name="hidIsMandatory" value=""/>
		<input type="hidden" name="hidScanRequired" value=""/>
		<input type="hidden" name="identifier_type_Code" value=""/>
		<input type="hidden" name="placeofissue" value=""/>
		<input type="hidden" name="countryofissue" value=""/>
		<input type="hidden" name="hidEDoc_IsDirty" value=""/>
		<input type="hidden" name="placeofissue_cat" value=""/>
		<input type="hidden" name="countryofissue_cat" value=""/>
		<input type="hidden" name="hidIsDocumentVerified" value=""/>
		<input type="hidden" name="hidIDIssuedOrg" value=""/>
<!--IDENTIFICATION DOCUMENT CHANGES end-->
		<input type="hidden" name="hidUniqueID" value=""/>
		<input type="hidden" name="hidUniqueIDType" value=""/>

			<!-- Hidden variables for identification tab end-->
			   <input type="hidden" name="boName" value="{$boName}"/>
			   <input type="hidden" name="apprFlag" value="{$apprFlag}"/>
			   <!--CIF LOS Bypass change:Start-->
			   <input type="hidden" name="byPassFlag" value="{$byPassFlag}"/>
              		   <!--CIF LOS Bypass change:End-->

                           <input type="hidden" name="DemographicBO.MiscellaneousInfo.url_" value=""/>
                           <input type="hidden" name="DemographicBO.Qualification" value=""/>
                           <input type="hidden" name="readonly" value="{$readMode}"/>
                           <!-- CRM62MNT:TRACKER# 55562 **BEGIN   CHANGES** -->
                           <input type="hidden" name="DemographicBO.CU_Annual_Total_Income" value=""/>
						   <input type="hidden" name="DemographicBO.CU_Annual_Total_Exp" value=""/>
						   <!-- CRM62MNT:TRACKER# 55562 **BEGIN   CHANGES** -->
          	   <!--  Tracker ID:144522   -->
		           <!-- Tracker id : 253845   -->
		           <input type="hidden" name="convToCust" value="{$convToCust}"/> 
		           <input type="hidden" name="oldEntityType" value="{$oldEntityType}"/> 
		           <input type="hidden" name="oldEntityID" value="{$oldEntityID}"/> 
		           <!-- Tracker id : 253845   -->
			   <input type="hidden" name="AdvanceAsOnDate" value=""/>
			   <input type="hidden" name="CustAssetsAsOnDate" value=""/>
			   <input type="hidden" name="TDSExcemptEndDate" value=""/>
			   <input type="hidden" name="holdMailStartDate" value=""/>
			   <input type="hidden" name="holdMailEndDate" value=""/>
			   <input type="hidden" name="TDSExcemptSubmitDate" value=""/>
			   <input type="hidden" name="residenceSince" value=""/>
			   <input type="hidden" name="retirementDate" value=""/>
			   <input type="hidden" name="incorporationDate" value=""/>
			 <input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
                <xsl:choose>
                   <xsl:when test="normalize-space($acctID)='' and normalize-space($suspID)=''">
				<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
				   <!-- Changes For call id: 416309 start--> 
				    <xsl:with-param name="tabPageHeight">490</xsl:with-param>
				   <!-- Changes For call id: 416309 end--> 				</xsl:call-template>
			</xsl:when>
 		<xsl:when test="(not(normalize-space($acctID)='') or not(normalize-space($suspID)='')) and $boName ='DemographicModBO'">
				<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
				   <!-- Changes For call id: 416309 start--> 
				    <xsl:with-param name="tabPageHeight">490</xsl:with-param>
				   <!-- Changes For call id: 416309 end--> 
				 </xsl:call-template>
                 </xsl:when>
                <xsl:when test="($byPassFlag) ='Y'">
				<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
				   <!-- Changes For call id: 416309 start--> 
				    <xsl:with-param name="tabPageHeight">490</xsl:with-param>
				   <!-- Changes For call id: 416309 end--> 
				 </xsl:call-template>
                   </xsl:when>
                        <xsl:otherwise>
                        	<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
				    <xsl:with-param name="colSpan">6</xsl:with-param>
				   <!-- Changes For callid:398839 start--> 
				    <xsl:with-param name="tabPageHeight">400</xsl:with-param>
				    <!-- Changes For callid:398839 end--> 
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
                <!-- View : DemographicContactInfo :Start   -->
	<xsl:choose>
             <xsl:when test= "not(normalize-space($byPassFlag)='Y')">
                <xsl:call-template name="BeginTabPage">
                    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                    <xsl:with-param name="tabPageName">tpageCont</xsl:with-param>
                    <xsl:with-param name="spanWidth">3</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_1[@name='Header']"/>
                    <!-- Changes For Trackerid:-182510 Changes Start(the focus method was not been called) -->
                    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
                    <!-- Changes For Trackerid:-182510 Changes End(the focus method was not been called) -->
                </xsl:call-template>
                                <xsl:call-template name="apply1">
                     <xsl:with-param name="apply_head">
                     <xsl:value-of select="$configLabels_1[@name='Header']/@configLabel"/>
                     </xsl:with-param>
                            </xsl:call-template>
	      <!-- commented for cif changes begin-->
              <!--  <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.Phone_Work"/>
                    <xsl:call-template name="DemographicBO.Extension"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.Phone_Home"/>
                    <xsl:call-template name="DemographicBO.Phone_Cell"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.Fax_Work"/>
                    <xsl:call-template name="DemographicBO.PagerNo"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.PhoneOther"/>
                    <xsl:call-template name="DemographicBO.prefDaytimeContNo"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.Email_Work"/>
                    <xsl:call-template name="DemographicBO.Email_Palm"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.Email_Home"/>
                    <xsl:call-template name="DemographicBO.URL"/>
                <xsl:call-template name="End"/> -->
<!-- TRACKER# 92380 START: 2 column changes and button allignment changes-->
		<!-- commented for cif changes end-->

		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.Nationality"/>
		<xsl:call-template name="DemographicBO.CustCaste"/>
		<xsl:call-template name="End"/>

		<xsl:call-template name="Begin"/>
		 <xsl:call-template name="DemographicBO.Residence_Country"/>
                 <xsl:call-template name="DemographicBO.Residence_Since"/>
		 <xsl:call-template name="End"/>


		<xsl:call-template name="Begin"/>
				 <xsl:call-template name="DemographicBO.Marital_Status"/>
				 <xsl:call-template name="DemographicBO.NRERelative"/>
		 <xsl:call-template name="End"/>

		<xsl:call-template name="Begin"/>
				 <xsl:call-template name="DemographicBO.NRECountryType"/>
				 <xsl:call-template name="DemographicBO.NRERelativeName"/>
                 <xsl:call-template name="End"/>


		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.doNotMailFlag"/>
		<xsl:call-template name="DemographicBO.doNotCallFlag"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.holdMailFlag"/>
		<xsl:call-template name="DemographicBO.holdMailDescription"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.doNotSendEMailFlg"/>
		<xsl:call-template name="DemographicBO.prefContTime"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.holdMailStartDate"/>
		<xsl:call-template name="DemographicBO.holdMailEndDate"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.TotalFundBase"/>
		<xsl:call-template name="DemographicBO.TotalNonFundBase"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.OtherLimits"/>
		<xsl:call-template name="DemographicBO.CustNetWorth"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>

		<xsl:call-template name="DemographicBO.CustAssetsAsOnDate"/>
		<xsl:call-template name="DemographicBO.CustFinYearEndMonth"/>
		<xsl:call-template name="End"/>

		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.ShareholderType"/>
		<xsl:call-template name="DemographicBO.CustDepositsInOtherBanks"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
				<xsl:call-template name="DemographicBO.TDSExcemptRefNo"/>
				<xsl:call-template name="DemographicBO.TDSExcemptSubmitDate"/>
		<xsl:call-template name="End"/>

		 <!-- changes  For TDS Enhancement start --> 
				<xsl:call-template name="Begin"/>		
				<xsl:call-template name="DemographicBO.Tax_Exmpt_Start_Date"/>
				<xsl:call-template name="DemographicBO.TDSExcemptEndDate"/>
				<xsl:call-template name="End"/>
		
		
				<xsl:call-template name="Begin"/>
				<xsl:call-template name="DemographicBO.Tax_Rate_Table_Code"/>
				<xsl:call-template name="DemographicBO.No_Tax_Recal_Beyond_Date"/>
				 <xsl:call-template name="End"/>
		
						 
				
				
				<xsl:call-template name="Begin"/>
				<xsl:call-template name="DemographicBO.TDSExcemptRemarks"/>
				<xsl:call-template name="End"/>
				
                <!-- changes For TDS Enhancement end -->

		<xsl:call-template name="Begin"/>
                    <xsl:call-template name="addemptycell"/>
		<xsl:call-template name="End"/>
<!-- Header for Channels (Tracker ID 113276) -->
		<xsl:call-template name="apply1">
			<xsl:with-param name="apply_head">
				<xsl:value-of select="$configLabels_1[@name='CHANNEL']/@configLabel"/>
			</xsl:with-param>
		</xsl:call-template>

<!-- Tracker ID 113276-->
<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
<TR >
		<!--Ticket ID: 190700 Changes Begin -->
		<TD nowrap="true" align="left" valign ="top" class="d1" ><xsl:value-of select="$configLabels_1[@name='AvailableChannels']/@configLabel"/></TD>
		<!--Ticket ID: 190700 Changes end -->
		<TD  width="20%"  align='left' >
			<xsl:call-template name="AvailableChannels"/>
		</TD>

		<TD align='center' width="14%">
			<TABLE align="center" >
			<!-- Defect Fix:Ticket ID:219760 : Changes Start  -->
			<TR>
			<TD align='center'>
			<input class="frmBttnsAddRmv" Type='button' name='add' value='&gt;&gt;'
				onclick="selfield(AvailableChannels, ChannelsAccessed)"/>
			</TD>
			</TR>
			<TR>
			<TD align='center'>
			<input class="frmBttnsAddRmv" Type='button' name='remove' value='&lt;&lt;'
				onclick="selfield(ChannelsAccessed, AvailableChannels)"/>
			</TD>
			</TR>
			</TABLE>
			<!-- Defect Fix:Ticket ID:219760 : Changes Ends  -->
		</TD>
		<!--Ticket ID: 190700 Changes Begin -->
		<TD  nowrap="true" valign ="top" class="d1" style='width:17%'><xsl:value-of select="$configLabels_1[@name='DemographicBO.ChannelsAccessed']/@configLabel"/></TD>
		<TD width="17%" >
		<!--Ticket ID: 190700 Changes end -->
			<xsl:call-template name="ChannelsAccessed"/>
		</TD>
		<td>&#160;</td>
	</TR>
</table>
<!--TrackerID: 113227 Defect no. -355 start of changes-->
<!--TrackerID: 113227 start of changes-->
<xsl:choose>
<xsl:when test="normalize-space($altLocaleActv)='true'">
	<xsl:variable name="DEMO">Details in Alternate Language</xsl:variable>
	<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
		<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rowdemo" name="rowdemo">
		<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
		<td onclick="Toggle('demo','all');" colspan = "5" NOWRAP="true" class="LabelFont">
		     <A HREF="javascript:Toggle('DEMO','all');"><IMG onclick="Toggle('demo','all');" SRC="../reports/images/minus.gif" ID="demogif"
		      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
		     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$DEMO"/>
		     </label>
		</td>
		</tr>
	</table>
	<DIV ID = 'native' STYLE= 'visibility:visible;'>

	 <table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

		<TR ID='rowdemo' name='rowdemo'>
		<xsl:call-template name="DemographicBO.NRERelativeName_alt1">
		</xsl:call-template>

		</TR>
	 </table>
	</DIV>
 </xsl:when>

</xsl:choose>
<!--TrackerID: 113227 end of changes-->
<!--TrackerID: 113227 Defect no. -355 end of changes-->
<!-- TRACKER# 92380 END-->
<!-- Field Rationalization end -->
                <xsl:call-template name="EndTabPage"/>
      	</xsl:when>
	<xsl:otherwise>
          <xsl:call-template name="BeginTabPage">
	   <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
	   <xsl:with-param name="tabPageName">tpageIExp</xsl:with-param>
	   <xsl:with-param name="spanWidth">3</xsl:with-param>
	   <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_3[@name='Header']"/>
          </xsl:call-template>
       <xsl:call-template name="apply1">
	    <xsl:with-param name="apply_head">
	   <xsl:value-of select="$configLabels_3[@name='Header']/@configLabel"/>
	    </xsl:with-param>
		   </xsl:call-template>

	   <xsl:call-template name="Begin"/>
				<xsl:call-template name="addemptycell"/>
				<xsl:call-template name="DemographicBO.Employment_Status_Empl"/>
				<xsl:call-template name="addemptycell"/>
	   <xsl:call-template name="End"/>

		       <TR ID='rowSelfEmployed' name='rowSelfEmployed'>
			   <xsl:call-template name="DemographicBO.SelfempTaxReturnField">
			   <xsl:with-param name="ele_name">DemographicBO.SelfempTaxReturnField</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="DemographicBO.SelfempGrossReciptCurrentYR">
			   <xsl:with-param name="ele_name">DemographicBO.SelfempGrossReciptCurrentYR</xsl:with-param>
			   </xsl:call-template>
			</TR>
		        <TR ID='rowSelfEmployed' name='rowSelfEmployed'>
			   <xsl:call-template name="DemographicBO.SelfempGrossReceiptPriorYear">
			   <xsl:with-param name="ele_name">DemographicBO.SelfempDepreciationPriorYear</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="DemographicBO.SelfempNetProfitCurrentYR">
                           <xsl:with-param name="ele_name">DemographicBO.SelfempNetProfitCurrentYR</xsl:with-param>
			  </xsl:call-template>
		        </TR>
		        <TR ID='rowSelfEmployed' name='rowSelfEmployed'>

			  <xsl:call-template name="DemographicBO.SelfempNetProfitPriorYR">
			  <xsl:with-param name="ele_name">DemographicBO.SelfempNetProfitPriorYR</xsl:with-param>
			  </xsl:call-template>
			  <xsl:call-template name="DemographicBO.SelfempDepreciationCurrentYear">
			  <xsl:with-param name="ele_name">DemographicBO.SelfempDepreciationCurrentYear</xsl:with-param>
			  </xsl:call-template>
		        </TR>
		        <TR ID='rowSelfEmployed' name='rowSelfEmployed'>
			   <xsl:call-template name="DemographicBO.SelfempDepreciationPriorYear">
			   <xsl:with-param name="ele_name">DemographicBO.SelfempDepreciationPriorYear</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="DemographicBO.SelfempAverageAnnualTurnover">
			   <xsl:with-param name="ele_name">DemographicBO.SelfempAverageAnnualTurnover</xsl:with-param>
			   </xsl:call-template>
			 </TR>
		        <TR ID='rowSelfEmployed' name='rowSelfEmployed'>
			   <xsl:call-template name="DemographicBO.TotalEstAccountValue_SelfEmployed">
			   <xsl:with-param name="ele_name">DemographicBO.TotalEstAccountValue_SelfEmployed</xsl:with-param>
			   </xsl:call-template>
		        </TR>
		        <TR ID='rowSalaried' name='rowSalaried'>
			   <xsl:call-template name="DemographicBO.Annual_Salary_Income">
			   <xsl:with-param name="ele_name">DemographicBO.Annual_Salary_Income</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="DemographicBO.SalAllowances">
			   <xsl:with-param name="ele_name">DemographicBO.SalAllowances</xsl:with-param>
			   </xsl:call-template>
			 </TR>
		       <TR ID='rowSalaried' name='rowSalaried'>
			   <xsl:call-template name="DemographicBO.SalProrataMonthlyIncentive">
			   <xsl:with-param name="ele_name">DemographicBO.SalProrataMonthlyIncentive</xsl:with-param>
			   </xsl:call-template>
		       </TR>
		       <TR ID='rowSalaried' name='rowSalaried'>
			   <xsl:call-template name="DemographicBO.SalInterestSubsidy">
			   <xsl:with-param name="ele_name">DemographicBO.SalInterestSubsidy</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="DemographicBO.Annual_Others_Income">
			   <xsl:with-param name="ele_name">DemographicBO.Annual_Others_Income</xsl:with-param>
			   </xsl:call-template>
			   </TR>
		       <TR ID='rowSalaried' name='rowSalaried'>
			   <xsl:call-template name="DemographicBO.Annual_Rental_Income">
			   <xsl:with-param name="ele_name">DemographicBO.Annual_Rental_Income</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="DemographicBO.SalOtherIncome2">
	                   <xsl:with-param name="ele_name">DemographicBO.SalOtherIncome2</xsl:with-param>
			   </xsl:call-template>

		       </TR>
		       <TR ID='rowSalaried' name='rowSalaried'>
			   <xsl:call-template name="DemographicBO.SalOtherIncome3">
			   <xsl:with-param name="ele_name">DemographicBO.SalOtherIncome3</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="DemographicBO.TotalEstAccountValue">
			   <xsl:with-param name="ele_name">DemographicBO.TotalEstAccountValue</xsl:with-param>
			   </xsl:call-template>
		       </TR>
		       <TR ID='rowSalaried/selfEmployed' name='rowSalaried/selfEmployed'>
			   <xsl:call-template name="DemographicBO.TotalInvestmentInSharesandUnits">
			   <xsl:with-param name="ele_name">DemographicBO.TotalInvestmentInSharesandUnits</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="DemographicBO.Annual_Stock_Bond_Income">
			   <xsl:with-param name="ele_name">DemographicBO.Annual_Stock_Bond_Income</xsl:with-param>
			   </xsl:call-template>
			</TR>
		       <TR ID='rowSalaried/selfEmployed' name='rowSalaried/selfEmployed'>
			<!-- shanmuga -field addn-->
		    <xsl:call-template name="DemographicBO.SourceOfIncome">
		    <xsl:with-param name="ele_name">DemographicBO.SourceOfIncome</xsl:with-param>
		    </xsl:call-template>
		    	   <!-- shanmuga -field addn-->
			   <xsl:call-template name="DemographicBO.TotalHouseholdIncm">
                           <xsl:with-param name="ele_name">DemographicBO.TotalHouseholdIncm</xsl:with-param>
			   </xsl:call-template>
		       </TR>
		       <TR ID='rowSalaried/selfEmployed' name='rowSalaried/selfEmployed'>
			   <!-- CRM62MNT:TRACKER# 55270 **BEGIN   CHANGES** -->
			   <td class="d1"><span id="lbl_DemographicBO.Annual_Total_Income" name="lbl_DemographicBO.Annual_Total_Income"></span></td>
			   <xsl:call-template name="DemographicBO.Annual_Total_Income">
			   <xsl:with-param name="ele_name">DemographicBO.Annual_Total_Income</xsl:with-param>
			   </xsl:call-template>
							<td class="d4"><xsl:value-of select="$BaseCurrency"/></td>
							<!-- CRM62MNT:TRACKER# 55270 **END   CHANGES** -->
		       </TR>
		       <!--Field Addition Tracker 172089:start of Changes-->
		       <!--start of changes as a fix for ticket 316574-->
 			<xsl:call-template name="Begin"/>
			<xsl:call-template name="DemographicBO.income_from"/>
			<xsl:call-template name="DemographicBO.income_to"/>
			<xsl:call-template name="End"/>
			<!--End of changes as a fix for ticket 316574-->
			<!--Field Addition Tracker 172089:end of Changes-->
                          <xsl:call-template name="Begin"/>
                              <xsl:call-template name="addemptycell"/>
                              <xsl:call-template name="addemptycell"/>
                              <xsl:call-template name="addemptycell"/>
                          <xsl:call-template name="End"/>

                          <xsl:call-template name="apply1">
                            <xsl:with-param name="apply_head">
                            Expenses Details
                            </xsl:with-param>
                                   </xsl:call-template>
                          <!-- Tracker Id 92380 -->
                          <xsl:call-template name="Begin"/>
                           <xsl:call-template name="DemographicBO.Annual_Operating_Exp"/>
                           <xsl:call-template name="DemographicBO.Annual_IntProd_Exp"/>
                          <xsl:call-template name="End"/>
                       <xsl:call-template name="Begin"/>
                           <xsl:call-template name="DemographicBO.Annual_Loan_Instal"/>
                           <xsl:call-template name="DemographicBO.Annual_ExtProd_Exp"/>
                            <xsl:call-template name="End"/>
                       <xsl:call-template name="Begin"/>

                           <xsl:call-template name="DemographicBO.Annual_Commit_Exp"/>
                           <xsl:call-template name="DemographicBO.Annual_Other_Exp"/>
                                      <xsl:call-template name="End"/>

                       <xsl:call-template name="Begin"/>
                           <xsl:call-template name="DemographicBO.TotalMonthlyDebtServiceAmt"/>
                           <xsl:call-template name="DemographicBO.Annual_Total_Exp"/>
       					<!-- CRM62MNT:TRACKER# 55270 **BEGIN   CHANGES** -->
       				<!--	<td class="d4"><xsl:value-of select="$BaseCurrency"/></td> -->
       					<!-- CRM62MNT:TRACKER# 55270 **END   CHANGES** -->
                       <xsl:call-template name="End"/>

                       <xsl:call-template name="Begin"/>
                            <xsl:call-template name="addemptycell"/>
                            <xsl:call-template name="addemptycell"/>
                       <xsl:call-template name="End"/>

                       <xsl:call-template name="Begin"/>
                       <xsl:call-template name="End"/>
                <xsl:call-template name="EndTabPage"/>

          </xsl:otherwise>

       </xsl:choose>
                <xsl:call-template name="BeginTabView">
		    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
		    <xsl:with-param name="tabPageHeight">277</xsl:with-param>
		</xsl:call-template>
                <xsl:call-template name="BeginTabPage">
                    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                    <xsl:with-param name="tabPageName">tpageQual</xsl:with-param>
                    <xsl:with-param name="spanWidth">3</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_2[@name='Header']"/>
         <!-- CRM11.0:TRACKER:113058:BEGINOFCHANGES -->
                    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
         <!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->
                </xsl:call-template>
             <!--  CRM10:TICKET:69348:BEGINOFCHANGES -->
             <!--  Table Presentation for Education Details.
              -->
             <table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
               <!-- Tracker Id 92380 -->
               <tr align="left">
                    <td>
                        <xsl:call-template name="user_button_withText">
                            <xsl:with-param name="button_name">ADD_EDUDET</xsl:with-param>
                            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_2[@name='ADD_EDUDET']/@configLabel"/></xsl:with-param>
                            <xsl:with-param name="button_fnc">addEduDet()</xsl:with-param>
                        </xsl:call-template>&#160;
                        <xsl:call-template name="user_button_withText">
                            <xsl:with-param name="button_name">REMOVE_EDUDET</xsl:with-param>
                            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_2[@name='REMOVE_EDUDET']/@configLabel"/></xsl:with-param>
                            <xsl:with-param name="button_fnc">removeEduDet()</xsl:with-param>
                        </xsl:call-template>
                    </td>
                </tr>
            </table>
            <xsl:call-template name="mainbody">
                <xsl:with-param name="tablename">EduDetRecordSet</xsl:with-param>
                <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_2[@name='EDUDET']/@configLabel"/></xsl:with-param>
                <xsl:with-param name="align">center</xsl:with-param>
                <xsl:with-param name="button">true</xsl:with-param>
                <xsl:with-param name="width">100%</xsl:with-param>
                <xsl:with-param name="name">...</xsl:with-param>
                <xsl:with-param name="onClick">editEduDetDetails()</xsl:with-param>
                <xsl:with-param name="rowhighlight">true</xsl:with-param>
                <xsl:with-param name="rsfilenm" select="$fileName2"/>
                <xsl:with-param name="extra_colheader">Select</xsl:with-param>
                <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="EndTabPage"/>
                <!-- View : DemographicEducationQualification : END   -->
				<!-- CRM62MNT:TRACKER# 55270 **BEGIN   CHANGES** -->
                <!-- View : DemographicEmploymentDetails : START   -->

                <xsl:call-template name="BeginTabView">
		    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
		    <xsl:with-param name="tabPageHeight">490</xsl:with-param>
		</xsl:call-template>
                <xsl:call-template name="BeginTabPage">
                        <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                        <xsl:with-param name="tabPageName">tpageEDet</xsl:with-param>
                        <xsl:with-param name="spanWidth">3</xsl:with-param>
                        <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_4[@name='EMP_DET']"/>
 			<xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
                </xsl:call-template>
<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>

	   <!-- Tracker ID 113276 changes start -->
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.Employment_Status"/>
		    <xsl:call-template name="DemographicBO.Payment_Mode"/>  <!-- TRACKER# : 59373  -->
                <xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
	            <xsl:call-template name="DemographicBO.Income_Nature"/> <!-- TRACKER# : 59373  -->
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText2"/>
                <xsl:call-template name="End"/>
<!--Field Addition Tracker 172089:start of Changes-->
                <xsl:call-template name="Begin"/>
		    <xsl:call-template name="DemographicBO.income_freq"/>
                <xsl:call-template name="End"/>
<!--Field Addition Tracker 172089:end of Changes-->
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText26"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText4"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.EmployerID"/>
		    <xsl:call-template name="DemographicBO.MiscellaneousInfo.EmployeeID"/>
                <xsl:call-template name="End"/>

              <!--  <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText17"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.dtDate2"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText5"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText6"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText18"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText20"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText21"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText19"/>

                <xsl:call-template name="End"/> -->
                <xsl:call-template name="Begin"/>
                   <!-- <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText11"/> -->
                    <xsl:call-template name="DemographicBO.Pensioner_Flag"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText1"/>
                <xsl:call-template name="End"/>
              <!--  <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText8"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText1"/> -->
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText9"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText10"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.dtDate1"/>
                    <!-- Tracker ID 113276 changes start -->
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText3"/>
                    <!--  <xsl:call-template name="DemographicBO.MiscellaneousInfo.dtDate3"/> -->

                <xsl:call-template name="End"/>
               <!--  <xsl:call-template name="Begin"/>
                   <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText3"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText23"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText24"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText25"/>

                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText27"/>
                    <xsl:call-template name="addemptycell"/>
                <xsl:call-template name="End"/>	-->
				   <!-- Tracker ID 113276 changes end -->

          <!--TrackerID: 113227 start of changes-->
         <xsl:choose>
	<xsl:when test="normalize-space($altLocaleActv)='true'">
	<xsl:variable name="DEMO1">Details in Alternate Language</xsl:variable>
	<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
		<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rowdemo1" name="rowdemo1">

		<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>

		<td onclick="Toggle('demo1','all');" colspan = "5" NOWRAP="true" class="LabelFont">

		     <A HREF="javascript:Toggle('DEMO1','all');"><IMG onclick="Toggle('demo1','all');" SRC="../reports/images/minus.gif" ID="demo1gif"
		      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
		     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$DEMO1"/>
		     </label>
		</td>
		</tr>
	</table>

	<DIV ID = 'native' STYLE= 'visibility:visible;'>

	 <table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

		<TR ID='rowdemo1' name='rowdemo1'>
		<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText4_alt1">
		</xsl:call-template>

		</TR>

	</table>

</DIV>

   </xsl:when>

  </xsl:choose>
       <!--TrackerID: 113227 end of changes-->

<!-- Tracker ID 113276 changes start-->
<!-- Tracker ID 113277 Defect no.-355 changes start-->
	<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
			  <xsl:call-template name="apply1">
				     <xsl:with-param name="apply_head">
				     <xsl:value-of select="$configLabels_4[@name='ADDRESS']/@configLabel"/>
				     </xsl:with-param>
</xsl:call-template>
	</table>
			  <!-- <xsl:call-template name="apply">
				      <xsl:with-param name="apply_head">
				      <xsl:value-of select="$configLabels_4[@name='ADDRESS']/@configLabel"/>
				      </xsl:with-param>
		          </xsl:call-template>-->
	<DIV ID = 'native' STYLE= 'visibility:visible;'>

	 <table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
	 <!-- Tracker ID 113277 Defect no. -355changes end-->
				<xsl:call-template name="Begin"/>
					<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText5"/>
					<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText6"/>

                <xsl:call-template name="End"/>


				<xsl:call-template name="Begin"/>
					<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText28"/>
					<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText18"/>
				<xsl:call-template name="End"/>

		<xsl:call-template name="Begin"/>
					<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText20"/>
					<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText21"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText19"/>
					<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText11"/>
                    		<xsl:call-template name="End"/>
				<xsl:call-template name="Begin"/>
					<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText8"/>
				<xsl:call-template name="End"/>
	<!-- Tracker ID 113277 defect no. -355 changes start-->
	</table>

	</DIV>
	<!-- Tracker ID 113277 defect no. -355 changes end-->

			<!-- Tracker ID 113276 changes end-->

                <!-- Employer History -->
	<!-- CIF Changes - EmploymentHistory MultiRec Start -->
	<!-- Tracker ID 113276 changes start-->
		<!--  <xsl:call-template name="apply1">
		                     <xsl:with-param name="apply_head">
		                     <xsl:value-of select="$configLabels_4[@name='GENERAL']/@configLabel"/>
		                     </xsl:with-param>
                  </xsl:call-template> -->
                  <!-- Tracker ID 113276 changes end-->
		  <!-- Tracker ID 113277 defect no. -355 changes start-->
		<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
		  <xsl:call-template name="apply1">
		                     <xsl:with-param name="apply_head">
		                     <xsl:value-of select="$configLabels_4[@name='MLHeader1']/@configLabel"/>
		                     </xsl:with-param>
                  </xsl:call-template>
		</table>
		<!-- Tracker ID 113277 defect no. -355 changes end-->


             <table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
             <!-- Tracker Id 92380 -->
               <tr align="left">
                    <td>
                        <xsl:call-template name="user_button_withText">
                            <xsl:with-param name="button_name">Add EmploymentHistory</xsl:with-param>
                            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_4[@name='Add EmploymentHistory']/@configLabel"/></xsl:with-param>
                            <xsl:with-param name="button_fnc">addEmploymentHistoryDetails()</xsl:with-param>
                        </xsl:call-template>&#160;
                        <xsl:call-template name="user_button_withText">
                            <xsl:with-param name="button_name">Remove EmploymentHistory</xsl:with-param>
                            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_4[@name='Remove EmploymentHistory']/@configLabel"/></xsl:with-param>
                            <xsl:with-param name="button_fnc">removeEmploymentHistory()</xsl:with-param>
                        </xsl:call-template>
                    </td>
                </tr>
            </table>
            <xsl:call-template name="mainbody">
                <xsl:with-param name="tablename">RowRecordSet</xsl:with-param>
                <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_4[@name='MLHeader2']/@configLabel"/></xsl:with-param>
                <xsl:with-param name="align">center</xsl:with-param>
                <xsl:with-param name="button">true</xsl:with-param>
                <xsl:with-param name="width">100%</xsl:with-param>
                <xsl:with-param name="name">...</xsl:with-param>
                <xsl:with-param name="onClick">editEmploymentHistory()</xsl:with-param>
                <xsl:with-param name="rowhighlight">true</xsl:with-param>
                <xsl:with-param name="rsfilenm" select="$fileName"/>
                <xsl:with-param name="extra_colheader">Select</xsl:with-param>
                <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
            </xsl:call-template>
	<!-- CIF Changes - EmploymentHistory MultiRec End -->
             <xsl:call-template name="EndTabPage"/>


             <!-- View : DemographicEmploymentDetails : END   -->
                <!-- View : DemographicIncomeExpense : Start   -->
	<xsl:choose>
   	  <xsl:when test= "not(normalize-space($byPassFlag)='Y')">
   	  	<xsl:call-template name="BeginTabView">
		    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
			<!-- Changes For call id: 416309 start--> 
		    <xsl:with-param name="tabPageHeight">400</xsl:with-param>
		    <!-- Changes For call id: 416309 end--> 
		</xsl:call-template>
                <xsl:call-template name="BeginTabPage">
                    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                    <xsl:with-param name="tabPageName">tpageIExp</xsl:with-param>
                    <xsl:with-param name="spanWidth">3</xsl:with-param>
                     <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_3[@name='Header']"/>
           	    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="apply1">
                     <xsl:with-param name="apply_head">
                     <xsl:value-of select="$configLabels_3[@name='INC_EXP']/@configLabel"/>
                     </xsl:with-param>
                            </xsl:call-template>
                    <xsl:call-template name="Begin"/>
                                         <xsl:call-template name="DemographicBO.Employment_Status_Empl"/>
                    <xsl:call-template name="End"/>

                                <TR ID='rowSelfEmployed' name='rowSelfEmployed'>
                                    <xsl:call-template name="DemographicBO.SelfempTaxReturnField">
                                    <xsl:with-param name="ele_name">DemographicBO.SelfempTaxReturnField</xsl:with-param>
                                    </xsl:call-template>
                                    <xsl:call-template name="DemographicBO.SelfempGrossReciptCurrentYR">
                                    <xsl:with-param name="ele_name">DemographicBO.SelfempGrossReciptCurrentYR</xsl:with-param>
                                    </xsl:call-template>
                                </TR>
                                <TR ID='rowSelfEmployed' name='rowSelfEmployed'>
                                   <xsl:call-template name="DemographicBO.SelfempGrossReceiptPriorYear">
                                    <xsl:with-param name="ele_name">DemographicBO.SelfempDepreciationPriorYear</xsl:with-param>
                                    </xsl:call-template>
                                    <xsl:call-template name="DemographicBO.SelfempNetProfitCurrentYR">
				    <xsl:with-param name="ele_name">DemographicBO.SelfempNetProfitCurrentYR</xsl:with-param>
                                   </xsl:call-template>
                                </TR>
                                <TR ID='rowSelfEmployed' name='rowSelfEmployed'>
                                   <xsl:call-template name="DemographicBO.SelfempNetProfitPriorYR">
                                   <xsl:with-param name="ele_name">DemographicBO.SelfempNetProfitPriorYR</xsl:with-param>
                                   </xsl:call-template>
                                   <xsl:call-template name="DemographicBO.SelfempDepreciationCurrentYear">
                                   <xsl:with-param name="ele_name">DemographicBO.SelfempDepreciationCurrentYear</xsl:with-param>
                                   </xsl:call-template>
                                </TR>
                                <TR ID='rowSelfEmployed' name='rowSelfEmployed'>
                                    <xsl:call-template name="DemographicBO.SelfempDepreciationPriorYear">
                                    <xsl:with-param name="ele_name">DemographicBO.SelfempDepreciationPriorYear</xsl:with-param>
                                    </xsl:call-template>
                                    <xsl:call-template name="DemographicBO.SelfempAverageAnnualTurnover">
                                    <xsl:with-param name="ele_name">DemographicBO.SelfempAverageAnnualTurnover</xsl:with-param>
                                    </xsl:call-template>
                                </TR>
                                <TR ID='rowSelfEmployed' name='rowSelfEmployed'>
                                    <xsl:call-template name="DemographicBO.TotalEstAccountValue_SelfEmployed">
                                    <xsl:with-param name="ele_name">DemographicBO.TotalEstAccountValue_SelfEmployed</xsl:with-param>
                                    </xsl:call-template>
                                </TR>
                                <TR ID='rowSalaried' name='rowSalaried'>
                                    <xsl:call-template name="DemographicBO.Annual_Salary_Income">
                                    <xsl:with-param name="ele_name">DemographicBO.Annual_Salary_Income</xsl:with-param>
                                    </xsl:call-template>
                                    <xsl:call-template name="DemographicBO.SalAllowances">
                                    <xsl:with-param name="ele_name">DemographicBO.SalAllowances</xsl:with-param>
                                    </xsl:call-template>
                                </TR>
                                <TR ID='rowSalaried' name='rowSalaried'>
                                    <xsl:call-template name="DemographicBO.SalProrataMonthlyIncentive">
                                    <xsl:with-param name="ele_name">DemographicBO.SalProrataMonthlyIncentive</xsl:with-param>
                                    </xsl:call-template>
                                    <xsl:call-template name="DemographicBO.SalInterestSubsidy">
				    <xsl:with-param name="ele_name">DemographicBO.SalInterestSubsidy</xsl:with-param>
                                    </xsl:call-template>
                                </TR>
                                <TR ID='rowSalaried' name='rowSalaried'>
                                    <xsl:call-template name="DemographicBO.Annual_Others_Income">
                                    <xsl:with-param name="ele_name">DemographicBO.Annual_Others_Income</xsl:with-param>
                                    </xsl:call-template>
                                    <xsl:call-template name="DemographicBO.Annual_Rental_Income">
                                    <xsl:with-param name="ele_name">DemographicBO.Annual_Rental_Income</xsl:with-param>
                                    </xsl:call-template>
                                </TR>
                                <TR ID='rowSalaried' name='rowSalaried'>
                                    <xsl:call-template name="DemographicBO.SalOtherIncome2">
                                    <xsl:with-param name="ele_name">DemographicBO.SalOtherIncome2</xsl:with-param>
                                    </xsl:call-template>
                                    <xsl:call-template name="DemographicBO.SalOtherIncome3">
                                    <xsl:with-param name="ele_name">DemographicBO.SalOtherIncome3</xsl:with-param>
                                    </xsl:call-template>
                                 </TR>
                                <TR ID='rowSalaried' name='rowSalaried'>
                                    <xsl:call-template name="DemographicBO.TotalEstAccountValue">
                                    <xsl:with-param name="ele_name">DemographicBO.TotalEstAccountValue</xsl:with-param>
                                    </xsl:call-template>
                                </TR>
                                <TR ID='rowSalaried/selfEmployed' name='rowSalaried/selfEmployed'>
                                    <xsl:call-template name="DemographicBO.TotalInvestmentInSharesandUnits">
                                    <xsl:with-param name="ele_name">DemographicBO.TotalInvestmentInSharesandUnits</xsl:with-param>
                                    </xsl:call-template>
                                    <xsl:call-template name="DemographicBO.Annual_Stock_Bond_Income">
                                    <xsl:with-param name="ele_name">DemographicBO.Annual_Stock_Bond_Income</xsl:with-param>
                                    </xsl:call-template>
                                </TR>
                                <TR ID='rowSalaried/selfEmployed' name='rowSalaried/selfEmployed'>
                                 <!-- shanmuga -field addn-->
				    <xsl:call-template name="DemographicBO.SourceOfIncome">
				    <xsl:with-param name="ele_name">DemographicBO.SourceOfIncome</xsl:with-param>
				    </xsl:call-template>
                                    <!-- shanmuga -field addn-->
                                    <xsl:call-template name="DemographicBO.TotalHouseholdIncm">
				    <xsl:with-param name="ele_name">DemographicBO.TotalHouseholdIncm</xsl:with-param>
                                    </xsl:call-template>

                                </TR>
                                <TR ID='rowSalaried/selfEmployed' name='rowSalaried/selfEmployed'>
                                    <!-- CRM62MNT:TRACKER# 55270 **BEGIN   CHANGES** -->
                                    <td class="d1"><span id="lbl_DemographicBO.Annual_Total_Income" name="lbl_DemographicBO.Annual_Total_Income"></span></td>
				   <xsl:call-template name="DemographicBO.Annual_Total_Income">
                                    <xsl:with-param name="ele_name">DemographicBO.Annual_Total_Income</xsl:with-param>
                                    </xsl:call-template>
				   <!-- <td class="d4"><xsl:value-of select="$BaseCurrency"/></td>-->
			           <!-- CRM62MNT:TRACKER# 55270 **END   CHANGES** -->
                                </TR>
		<!--Field Addition Tracker 172089:start of Changes-->
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.income_from"/>
		<xsl:call-template name="DemographicBO.income_to"/>
		<xsl:call-template name="End"/>
		<!--Field Addition Tracker 172089:end of Changes-->

                     <xsl:call-template name="apply1">
                     <xsl:with-param name="apply_head">
                     Expenses Details
                     </xsl:with-param>
                            </xsl:call-template>
                   <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.Annual_Operating_Exp"/>
                    <xsl:call-template name="DemographicBO.Annual_IntProd_Exp"/>
                   <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.Annual_Loan_Instal"/>
                    <xsl:call-template name="DemographicBO.Annual_ExtProd_Exp"/>
                    <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.Annual_Commit_Exp"/>
                    <xsl:call-template name="DemographicBO.Annual_Other_Exp"/>
                    <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.TotalMonthlyDebtServiceAmt"/>
                    <xsl:call-template name="DemographicBO.Annual_Total_Exp"/>
					<!-- CRM62MNT:TRACKER# 55270 **BEGIN   CHANGES** -->
				<!--	<td class="d4"><xsl:value-of select="$BaseCurrency"/></td> -->
					<!-- CRM62MNT:TRACKER# 55270 **END   CHANGES** -->
                <xsl:call-template name="End"/>
                <xsl:call-template name="EndTabPage"/>

           </xsl:when>
	   <xsl:otherwise>

                <xsl:call-template name="BeginTabPage">
		    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
		    <xsl:with-param name="tabPageName">tpageCont</xsl:with-param>
		    <xsl:with-param name="spanWidth">3</xsl:with-param>
		    <xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
		    <xsl:with-param name="tabPageDisplayNameRes">Contact Information</xsl:with-param>
		</xsl:call-template>
				<xsl:call-template name="apply1">
		     <xsl:with-param name="apply_head">
		     <xsl:value-of select="$configLabels_1[@name='Header']/@configLabel"/>
		     </xsl:with-param>
			    </xsl:call-template>
	      <!-- commented for cif changes begin-->
	      <!--  <xsl:call-template name="Begin"/>
		    <xsl:call-template name="DemographicBO.Phone_Work"/>
		    <xsl:call-template name="DemographicBO.Extension"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		    <xsl:call-template name="DemographicBO.Phone_Home"/>
		    <xsl:call-template name="DemographicBO.Phone_Cell"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		    <xsl:call-template name="DemographicBO.Fax_Work"/>
		    <xsl:call-template name="DemographicBO.PagerNo"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		    <xsl:call-template name="DemographicBO.PhoneOther"/>
		    <xsl:call-template name="DemographicBO.prefDaytimeContNo"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		    <xsl:call-template name="DemographicBO.Email_Work"/>
		    <xsl:call-template name="DemographicBO.Email_Palm"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		    <xsl:call-template name="DemographicBO.Email_Home"/>
		    <xsl:call-template name="DemographicBO.URL"/>
		<xsl:call-template name="End"/> -->
		<!-- commented for cif changes end-->
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.doNotMailFlag"/>
		<xsl:call-template name="DemographicBO.doNotCallFlag"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.holdMailFlag"/>
		<xsl:call-template name="DemographicBO.holdMailDescription"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.doNotSendEMailFlg"/>
		<xsl:call-template name="DemographicBO.prefContTime"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.holdMailStartDate"/>
		<xsl:call-template name="DemographicBO.holdMailEndDate"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.userField1"/>
		<xsl:call-template name="DemographicBO.userField2"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.userField3"/>
		<xsl:call-template name="DemographicBO.AdvanceAsOnDate"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.TotalFundBase"/>
		<xsl:call-template name="DemographicBO.TotalNonFundBase"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.OtherLimits"/>
		<xsl:call-template name="DemographicBO.CustNetWorth"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.CustCaste"/>
		<xsl:call-template name="DemographicBO.CustAssetsAsOnDate"/>
		<xsl:call-template name="End"/>
		<!-- CRM70t-St Tracker# 78444, Begin of Changes -->
		<!-- <xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.TDSTable"/>
		<xsl:call-template name="DemographicBO.TDSCustId"/>
		<xsl:call-template name="End"/> -->
<!-- CRM70t-St Tracker# 78444, End of Changes -->
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.TDSExcemptRefNo"/>
		<xsl:call-template name="DemographicBO.TDSExcemptRemarks"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.TDSExcemptEndDate"/>
		<xsl:call-template name="DemographicBO.TDSExcemptSubmitDate"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.CustFinYearEndMonth"/>
		<xsl:call-template name="DemographicBO.ShareholderType"/>
		<xsl:call-template name="End"/>

<!-- Changes for Tracker # 88712 Start-->
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.CustBusinessAssets"/>
		<xsl:call-template name="DemographicBO.CustPropertyAssets"/>
		<xsl:call-template name="End"/>

		<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.CustDepositsInOtherBanks"/>
		<xsl:call-template name="End"/>
<!-- Changes for Tracker # 88712 End-->
<!-- Field Rationalization start -->


	<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
	<TR >
			<TD nowrap="true" align="left" valign ="top" class="d1" style='width:27%'><xsl:value-of select="$configLabels_1[@name='AvailableChannels']/@configLabel"/></TD>
			<TD  width="20%"  align='left' >
				<xsl:call-template name="AvailableChannels"/>
			</TD>

			<TD align='center' width="8%">
				<TABLE align="center" >

				<TR>
				<TD align='center'>
				<input class="frmBttnsAddRmv" Type='button' value='&gt;&gt;'
					onclick="selfield1(AvailableChannels, ChannelsAccessed)"/>
				</TD>
				</TR>
				<TR>
				<TD align='center'>
				<input class="frmBttnsAddRmv" Type='button' value='&lt;&lt;'
					onclick="selfield1(ChannelsAccessed, AvailableChannels)"/>
				</TD>
				</TR>
				</TABLE>

			</TD>
			<TD  nowrap="true" valign ="top" class="d1" style='width:27%'><xsl:value-of select="$configLabels_1[@name='DemographicBO.ChannelsAccessed']/@configLabel"/></TD>
			<TD width="10%">
				<xsl:call-template name="ChannelsAccessed"/>
			</TD>
			<td>&#160;</td>
		</TR>
</table>
                <xsl:call-template name="EndTabPage"/>

          </xsl:otherwise>
	</xsl:choose>


<!-- TRACKER# 92380 END: 2 column changes and button allignment changes-->




                <!-- View : DemographicIncomeExpense : END   -->
				<!-- CRM62MNT:TRACKER# 55270 **END   CHANGES** -->
                <!-- View : DemographicDemographicOtherDetails : Start   -->


<!--TrackerID113276 This Tab has to be removed -->
<!--                <xsl:call-template name="BeginTabPage">
                    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                    <xsl:with-param name="tabPageName">tpageODet</xsl:with-param>
                    <xsl:with-param name="spanWidth">3</xsl:with-param>
                                  <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_5[@name='Header']"/>
                </xsl:call-template>
                <xsl:call-template name="apply1">
                     <xsl:with-param name="apply_head">
                     <xsl:value-of select="$configLabels_5[@name='Header']/@configLabel"/>
                     </xsl:with-param>
                            </xsl:call-template>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.Nationality"/>
                    <xsl:call-template name="DemographicBO.Residence_Country"/>
                               <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.Residence_Since"/>
                    <xsl:call-template name="DemographicBO.Marital_Status"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.NRERelative"/>
                    <xsl:call-template name="DemographicBO.NRECountryType"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="DemographicBO.NRERelativeName"/>
                    <xsl:call-template name="addemptycell"/>
                <xsl:call-template name="End"/>-->
                  <!--commented for IDENTIFICATION DOCUMENT CHANGES start
                <xsl:call-template name="Customer_ID"/>
                commented for IDENTIFICATION DOCUMENT CHANGES end-->
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="addemptycell"/>
                            <xsl:call-template name="addemptycell"/>
                 <xsl:call-template name="End"/>

		<xsl:call-template name="EndTabPage"/>


      <!-- View : DemographicDemographicOtherDetails : end   -->
    <xsl:choose>
   	<xsl:when test= "not(normalize-space($byPassFlag)='Y')">
	    <xsl:call-template name="EndTabView">
		<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
		<xsl:with-param name="selectedTabPageName">tpageCont</xsl:with-param>
	    </xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
 	    <xsl:call-template name="EndTabView">
		<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
		<xsl:with-param name="selectedTabPageName">tpageIExp</xsl:with-param>
	    </xsl:call-template>
	</xsl:otherwise>
    </xsl:choose>
<!-- Start DataArray -->
   <script>
       //CRM10.2 SPE
        var DataArray = new Array;
        var DataCount = 0;
        <xsl:for-each select="$PresCurrData/SRMComposite[@n='CurrencyRecordSet']/SRMRow">
            DataArray[DataCount] = '<xsl:value-of select="./Z[@n='CurrencyBO.CurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.Format']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.NumberOfDecimals']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.MantissaSeperator']"/>'+"|"+'<xsl:value-of select="./Z[@n='CurrencyBO.DecimalSeperator']"/>';
            DataCount++;
        </xsl:for-each>
        var iCount = 0;
        ExArray = new Array;
          <xsl:for-each   select="$PresExData/SRMComposite[@n='ExRateRecordSet']/SRMRow"><!--Recon ticket 274080 tracker 165700	-->
            ExArray[iCount] = '<xsl:value-of select="./Z[@n='ExchangeRateBO.FixedCurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.VariableCurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.NumberOfUnits']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.ExchangeRate']"/>'
            iCount++;
        </xsl:for-each>
         var iCount1 = 0;
	         <xsl:for-each select="/SRM/SRMData[@SRMDataSpace='ExRate']/SRMComposite[@n='ExRateRecordSet']/SRMRow">

		      var ele ='<xsl:value-of select="./Z[@n='ExchangeRateBO.ExchangeRate']"/>';
		      var value = ExArray[iCount1];
		      ExArray[iCount1] = ExArray[iCount1] + ele;
		      iCount1++;
        </xsl:for-each>
</script>
<!-- End DataArray -->
                        </form>
                       <!--  TrackerID:209607,CHANGES START -->
                        <p id="myPar"></p>
                        <!-- TrackerID:209607,CHANGES START -->
                </td>
                <xsl:call-template name="End"/>

                <!-- CIF Changes - EmploymentHistory MultiRec Start -->
		<form name="frm3"  method="post">
			<input type="hidden" name="miscInfoType" value=""/>
			<input type="hidden" name="Profession" value=""/>
			<!--Tracker ID 113259-Fix for MATPT Defect Start-On providing details for CIF Retail>New Entity>Prospect>Demographic>Employement Details and Click on save button-Joining date is going in Hijri format in Miscelleneousinfo_mod table.-->
			<!--<input type="hidden" name="currEmpDOJ" value=""/>-->
			<!--Tracker ID 113259-Fix for MATPT Defect END-On providing details for CIF Retail>New Entity>Prospect>Demographic>Employement Details and Click on save button-Joining date is going in Hijri format in Miscelleneousinfo_mod table.-->
			<!-- fix for ticket 203359 start-->
			<input type="hidden" name="currEmpDOJ" value=""/>
			<!-- fix for ticket 203359 ends-->
			<input type="hidden" name="Industry" value=""/>
			<input type="hidden" name="EmployerName" value=""/>
			<!--changes for Tracker 120416 start-->
			<input type="hidden" name="EmployerName_alt1" value=""/>
			<!--changes for Tracker 120416 end-->
			<input type="hidden" name="Fax" value=""/>
			<input type="hidden" name="Address" value=""/>
			<input type="hidden" name="Phone" value=""/>
			<input type="hidden" name="Designation" value=""/>
			<input type="hidden" name="dateOfJoining" value=""/>
			<input type="hidden" name="dateOfLeaving" value=""/>
			<input type="hidden" name="Period" value=""/>
			<input type="hidden" name="strText17" value=""/>
			<input type="hidden" name="strText18" value=""/>
			<input type="hidden" name="strText19" value=""/>
			<input type="hidden" name="strText20" value=""/>
			<input type="hidden" name="strText21" value=""/>
			<input type="hidden" name="strText22" value=""/>
			<input type="hidden" name="strText23" value=""/>
			<input type="hidden" name="strText24" value=""/>
			<input type="hidden" name="strText25" value=""/>
			<input type="hidden" name="readOnly" value="{$readMode}"/>
			<!--employer details -->
			<input type="hidden" name="strText26" value=""/>
			<input type="hidden" name="EmployerID" value=""/>
			<input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>
		</form>
		<!-- CIF Changes - EmploymentHistory MultiRec End -->
                </xsl:template>
        <xsl:template match="SRM">
        <xsl:for-each select=".">
             <xsl:call-template name="startTable"/>
                <!-- <table bgcolor='ffffff' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
                   <tr>
                     <xsl:call-template name="apply">
                     <xsl:with-param name="apply_head">
                     <b><xsl:value-of select="$configLabels_1[@name='Header']/@configLabels_1"/></b>
                     </xsl:with-param>
                     </xsl:call-template>
                 </tr>
              </table>   -->
                <table bgcolor='ffffff' width="100%" border="0" cellspacing="0" cellpadding="0">
                  <xsl:apply-templates select="." mode="mode1"/>
                </table>
             <xsl:call-template name="endTable"/>
         </xsl:for-each>
        </xsl:template>
</xsl:stylesheet>






















