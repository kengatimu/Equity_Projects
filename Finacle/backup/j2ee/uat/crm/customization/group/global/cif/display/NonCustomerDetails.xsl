<?xml version="1.0"?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <!--impoting variables wich hold the jvm properties-->
<!--IDENTIFICATION DOCUMENT CHANGES start changed to relative url-->
     <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
<!--Changes for save submit not appearing on the screen Tracker : 159776-->
     <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
     <xsl:import href="../Renderer/common/display/CommonEntityDetails.xsl"/>
<!--IDENTIFICATION DOCUMENT CHANGES end-->
        <xsl:param name="locale"/>
        <!--tracker id 113227 starts-->
	<xsl:param name="altLocaleType"/>
	<xsl:param name="baseLocaleType"/>
	<xsl:param name="altLocaleActv"/>
        <!--tracker id 113227 ends-->
    <xsl:variable name="file1">../Renderer/Customization/cif/resource/NonCustomerDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <!--<xsl:variable name="file1" select="../Renderer/cif/resource/NonCustomerDetails.xml')"/>-->
<xsl:variable name="configFile_1" select="document(concat($file1,''))"/>
     <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
<!--IDENTIFICATION DOCUMENT CHANGES start-->
	<xsl:param name="fileNameID"/>
	<xsl:variable name="configFileID" select="document(concat($fileNameID,''))"/>
	<xsl:variable name="configLabelsID" select="$configFileID/SRMBO/*"/>
<!--IDENTIFICATION DOCUMENT CHANGES end-->

<!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
	<xsl:param name="ALTCALENDAR_TYPE"/>
<!--ERPBOCF1:TRACKER113259: STORAGE OF DATES :ENDOFCHANGES-->

     <xsl:variable name="BOName">NonCustomerBO</xsl:variable>

<xsl:variable name="LastUpdate_Date" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='LastUpdate_Date']"></xsl:variable>

     <xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"></xsl:variable>
     <xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"></xsl:variable>
     <!-- Save and Submit Getting the operationType from Det/ModDet java : Start  -->
     <xsl:variable name="operationType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operationType']"></xsl:variable>
     <!-- Save and Submit Getting the operationType : End  -->
     <xsl:variable name="allfields" select="//SRMData//Z"/>
     <xsl:variable name="nonCustURL" select="//SRMData//Z[@n=concat($boName,'.url_')]"></xsl:variable>
     <xsl:variable name="nonCustID" select="//SRMData//Z[@n=concat($boName,'.NonCustomerID')]"></xsl:variable>
     <xsl:variable name="priorityCode" select="//SRMData//Z[@n=concat($boName,'.priorityCode')]"></xsl:variable>
     <xsl:variable name="concurDetectX" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n=concat($boName,'.ConcurDetect_X')]"></xsl:variable>
    <xsl:variable name="isAutoGenKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isAutoGenKey']"></xsl:variable>
     <!-- 113066 changes start -->
     <!-- Tracker Id 332256 changes STARTS -->
     <!-- Call Id 262072 changes STARTS -->
     <xsl:variable name="occupationType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='occupationType']"></xsl:variable>
     <xsl:variable name="Nationality" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Nationality']"></xsl:variable>
     <xsl:variable name="NationalityVal" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='NationalityVal']"></xsl:variable>
     <!-- Call Id 262072 changes ENDS -->
     <!-- Tracker Id 332256 changes ENDS -->
<!--CRM ALERT CHANGES START-->
<xsl:variable name="defaultChannel_Alert" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='defaultChannel_Alert']" />
<xsl:variable name="Enable_Alerts" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Enable_Alerts']" />
<xsl:variable name="PreferredMobileAlert_Type" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PreferredMobileAlert_Type']" />

<xsl:variable name="isAlert" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isAlert2']" />

<!--CRM ALERT CHANGES END-->
    	     <xsl:variable name="strAcrossSearch" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strAcrossSearch']"></xsl:variable>
    	     <xsl:variable name="strSearchInBank" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strSearchInBank']"></xsl:variable>
    	     <xsl:variable name="strLoggedInBank" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strLoggedInBank']"></xsl:variable>
    	      <xsl:variable name="boDet" select="/SRM/SRMData[@SRMDataSpace='Main']/SRMComposite [@n=$boName]/Z"/>
     <!-- 113066 changes end -->
     <!-- Changes for Tracker id: 292525 starts -->
     <xsl:variable name="defAddress" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='defAddress']"/>
     <!-- Changes for Tracker id: 292525 ends -->
    <!-- Changes for 'WFlow' POC start -->
    	<xsl:variable name="IntWFID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strIntWFID']"></xsl:variable>
    <!-- Changes for 'WFlow' POC end -->

      <xsl:variable name="SRMTips" select="$configLabels[@name='Tips']/@value"/>
	     <xsl:variable name="custom_fields" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z"/>
	     <xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
	<xsl:variable name="isCopy" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsCopy']"></xsl:variable>
	<!--Access Control Changes-->
	<xsl:variable name="PrimBCID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcID']"></xsl:variable>
	<xsl:variable name="PrimBCCODE" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcCode']"></xsl:variable>
	<xsl:variable name="priGrpID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='priGrpID']"></xsl:variable>
	<xsl:variable name="priSegName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='priSegName']"></xsl:variable>
	<!--End of Changes-->
    <xsl:variable name="fileName">../Renderer/cif/resource/ListOfIdent_Details_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <xsl:variable name="fileNameMod">../Renderer/cif/resource/ListOfIdent_Details_Mod_<xsl:value-of select="$locale"/>.xml</xsl:variable>
   <!-- CIF PhoneEmail Changes : Start -->
		<xsl:param name="fileNameAddress"/>
		<xsl:param name="fileNamePhoneEmail"/>
   <!-- CIF PhoneEmail Changes : End -->
  <!-- changes shanmuga New Field Addn - Start-->
   <xsl:variable name="BaseCurrency" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrency']"></xsl:variable>
  <!-- changes shanmuga New Field Addn - End-->
<!-- vasanth's changes start -->

<!--    <xsl:variable name="BlackListed" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BlackListed']"></xsl:variable>
    <xsl:variable name="Suspended" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Suspended']"></xsl:variable>
    <xsl:variable name="Negated" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Negated']"></xsl:variable>
    -->
    <xsl:variable name="chkBSN" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='chkBSN']"></xsl:variable>
 <xsl:variable name="BlackListed" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.BlackListed')]"></xsl:variable>
          <xsl:variable name="Suspended" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.Suspended')]"></xsl:variable>
          <xsl:variable name="Negated" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.Negated')]"></xsl:variable>

	<!-- vasanth's changes end -->
   <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
  <xsl:variable name="AccessOwnerGroup" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccessOwnerGroup']"></xsl:variable>
   <!-- Tracker ID : 90197 End of Changes -->
     <!-- KeyGeneration Start -->
     <xsl:variable name="keyGeneration" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='keyGeneration']"></xsl:variable>
     <!-- KeyGeneration End -->
	<!--Doc Rec changes: start-->
	<xsl:variable name="docRecvd" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='docRecvd']"></xsl:variable>
	<!--Doc Rec changes: end-->
<!-- Fix for Tracker #: SIDDHARTH Begins -->
<xsl:variable name="dtMinor" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtMinor']"/>
<!-- Fix for Tracker #: SIDDHARTH Ends -->
<!-- refCode changes  -->
     <xsl:variable name="HomeAddCity_code" select="//SRMData//Z[@n=concat($boName,'.HomeAddCity_code')]/@av"></xsl:variable>
     <xsl:variable name="HomeAddState_code" select="//SRMData//Z[@n=concat($boName,'.HomeAddState_code')]/@av"></xsl:variable>
     <xsl:variable name="HomeAddCountry_code" select="//SRMData//Z[@n=concat($boName,'.HomeAddCountry_code')]/@av"></xsl:variable>
     <xsl:variable name="WorkAddCity_code" select="//SRMData//Z[@n=concat($boName,'.WorkAddCity_code')]/@av"></xsl:variable>
     <xsl:variable name="WorkAddState_code" select="//SRMData//Z[@n=concat($boName,'.WorkAddState_code')]/@av"></xsl:variable>
     <xsl:variable name="WorkAddCountry_code" select="//SRMData//Z[@n=concat($boName,'.WorkAddCountry_code')]/@av"></xsl:variable>
     <xsl:variable name="MailAddCity_code" select="//SRMData//Z[@n=concat($boName,'.MailAddCity_code')]/@av"></xsl:variable>
     <xsl:variable name="MailAddState_code" select="//SRMData//Z[@n=concat($boName,'.MailAddState_code')]/@av"></xsl:variable>
     <xsl:variable name="MailAddCountry_code" select="//SRMData//Z[@n=concat($boName,'.MailAddCountry_code')]/@av"></xsl:variable>
<!-- refCode changes  -->
<!--Key Generation Changes STart-->
<xsl:variable name="entityCreflg" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityCreflg']"/>
<!--Key Generation Changes end-->

<!-- CIF Changes for Caching Views : Start -->
    <xsl:param name="viewname"/>
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.CIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
    <xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
    <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
<!-- CIF Changes for Caching Views : End -->
     <!-- CIF PhoneEmail Changes : Start -->
     <xsl:variable name="preferredAddressType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredAddressType']"></xsl:variable>
     <xsl:variable name="preferredPhone" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredPhone']"></xsl:variable>
     <xsl:variable name="preferredEmail" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredEmail']"></xsl:variable>
     <!-- CIF PhoneEmail Changes : End -->

	<xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"></xsl:variable>
	<xsl:variable name="mcJNDIFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mcJNDIFlag']"></xsl:variable>
	<xsl:variable name="isMCEdited" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isMCEdited']"></xsl:variable>




	    <xsl:template match="/">

	     <html>
	     <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>

	     <head>
     <!-- vasanth's changes start -->
     <script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>
	<!-- vasanth's changes end -->

	     	<script type="text/javascript" src="../common/js/Rendcurrency.js" language="javascript"></script>
		<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
		<!-- Changes for WFlow POC start -->
		<script type="text/javascript" src="../common/js/WorkFlow.js" language="javascript"></script>
	    	<!-- Changes for WFlow POC end -->
<script>
    var locale = '<xsl:value-of select="$locale"/>';
    /* Tracker Id 332256 changes STARTS */
    /* Call Id 262072 changes STARTS */
    var occupation = '<xsl:value-of select="$occupationType"/>';	
    var Nationality = '<xsl:value-of select="$Nationality"/>';
        /* Call Id 451068 changes  */
    var NationalityVal = '<xsl:value-of select="$NationalityVal"/>';
    /* Call Id 262072 changes ENDS */
    /* Tracker Id 332256 changes ENDS */
    var isCopy = '<xsl:value-of select="$isCopy"/>';
    var IntWFID = '<xsl:value-of select="$IntWFID"/>'; /* Changes for WFlow POC */
       <!--tracker id 113227 starts-->

         	/*ticket id 219597 tracker id 132339 changes starts*/
         	var dualflag=1;
         	/*ticket id 219597 tracker id 132339 changes ends*/
          	var altLocaleType = '<xsl:value-of select="$altLocaleType"/>';
           	var baseLocaleType = '<xsl:value-of select="$baseLocaleType"/>';
             var altLocaleActv = '<xsl:value-of select="$altLocaleActv"/>';
             var nonCustID = '<xsl:value-of select="$nonCustID"/>';
	     /*changes for Tracker id: 292525 starts*/
	      var defAddress = '<xsl:value-of select="$defAddress"/>';
             /*changes for Tracker id: 292525 ends*/
              <!--ticket id 202064 tracker id 120789 changes starts-->
		/*if (altLocaleActv==true){*/
		if (altLocaleActv=="true"){
		<!--ticket id 202064 tracker id 120789 changes ends-->
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

     <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
            var AccessOwnerGroup = '<xsl:value-of select="$AccessOwnerGroup"/>';
     <!-- Tracker ID : 90197 End of Changes -->
    var nonCustomerUrl = '<xsl:value-of select="$nonCustURL"/>';
    var boName = '<xsl:value-of select="$boName"/>';
//IDENTIFICATION DOCUMENT CHANGES start
    var readMode = '<xsl:value-of select="$readMode"/>';
    var LastUpdate_Date = '<xsl:value-of select="$LastUpdate_Date"/>';
	var entityDocumentBO_Name;
	if(boName=='NonCustomerBO')
		entityDocumentBO_Name='EntityDocumentBO';
	else if(boName=='NonCustomerModBO')
		entityDocumentBO_Name='EntityDocumentModBO';
//IDENTIFICATION DOCUMENT CHANGES end
    var btnSize=45;
    var appFlag = '<xsl:value-of select="$apprFlag"/>';
   /********* Save and Submit Changes : Start**********/
    var operationType = '<xsl:value-of select="$operationType"/>';
   /********* Save and Submit Changes : End**********/
    var docRecvd = '<xsl:value-of select="$docRecvd"/>';
    var submit=false;
    //MATPT Rachit Changes:Start
    var preferredAddressType = '<xsl:value-of select="$preferredAddressType"/>';
    var preferredPhone = '<xsl:value-of select="$preferredPhone"/>';
    var preferredEmail = '<xsl:value-of select="$preferredEmail"/>';
    //MATPT Rachit Changes:End
<!--CRM ALERT CHANGES STARTS-->

var isAlert = '<xsl:value-of disable-output-escaping="yes" select="$isAlert"></xsl:value-of>';
var defAddress = '<xsl:value-of disable-output-escaping="yes" select="$defAddress"></xsl:value-of>';
var catValue    = '<xsl:value-of disable-output-escaping="yes" select="$defaultChannel_Alert"></xsl:value-of>';
var enableAlert   = '<xsl:value-of disable-output-escaping="yes" select="$Enable_Alerts"></xsl:value-of>';
var preferredMobileAlert_Type   = '<xsl:value-of disable-output-escaping="yes" select="$PreferredMobileAlert_Type"></xsl:value-of>';


<!--CRM ALERT CHANGES ENDS-->
<!-- KeyGeneration start -->
	var keyGeneration = '<xsl:value-of select="$keyGeneration"/>';
	var entityCreflg ='<xsl:value-of select="$entityCreflg"/>';
<!-- KeyGeneration end-->

     <!-- vasanth's changes start -->

		var BlackListed = '<xsl:value-of select="$BlackListed"/>';
		var Suspended = '<xsl:value-of select="$Suspended"/>';
		var chkBSNFlg = '<xsl:value-of select="$chkBSN"/>';
		var Negated =  '<xsl:value-of select="$Negated"/>';

	<!-- vasanth's changes end -->
	<!-- 113066 changes start -->
			var strAcrossSearch = '<xsl:value-of select="$strAcrossSearch"/>';
			var strLoggedInBank = '<xsl:value-of select="$strLoggedInBank"/>';
			var strSearchInBank = '<xsl:value-of select="$strSearchInBank"/>';
	<!-- 113066 changes end -->

chkBSNFlg='true';
    <!--Access Control Changes-->
	var primBCID = '<xsl:value-of select="$PrimBCID"/>';
	var primBCCODE = '<xsl:value-of select="$PrimBCCODE"/>';
	var priGrpID = '<xsl:value-of select="$priGrpID"/>';
	var priSegName = '<xsl:value-of select="$priSegName"/>';
    <!--End of Changes-->
	var isAutoGenKey = '<xsl:value-of select="$isAutoGenKey"/>';

    /*Fix for Tracker #: SIDDHARTH Begins*/
    var locDate = '<xsl:value-of select="$dtMinor"/>';
    /*Fix for Tracker #: SIDDHARTH Ends*/
 </script>
        <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
        <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
        <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
    <script type="text/javascript" language="javascript">



    </script>




     	<script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>
		        <script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
		        <script type="text/javascript" src="../common/js/ListBoxFunctions.js" language="javascript"></script>
		        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>
	<!-- CIF PhoneEmail Changes : Start -->
	<script type="text/javascript" src="../cif/js/CIFNonCustomerAddress.js"></script>
	<script type="text/javascript" src="../cif/js/CIFPhoneEmail.js"></script>
	<!-- CIF PhoneEmail Changes : End -->
        <script type="text/javascript" src="../cif/js/NonCustomer.js"></script>
	<script type="text/javascript" language="javascript" src="../cif/js/AccountAddressRCLOptions_{$locale}.js"></script>
	 <script type="text/javascript" language="javascript" src="../cif/js/NonCustomerCreateRightClick.js"></script>
       <script type="text/javascript" src="../Customization/js/NonCustomerCustom.js" language="javascript"></script>
       <script type="text/javascript" src="../Customization/cif/js/EquityNonCustomerRetailProcessCustom.js" language="javascript"></script>
        <script type="text/javascript" language="javascript">

<![CDATA[function showFormTips() {
parent.parent.parent.parent.removeTips(parent.parent.parent.parent.frames(0).getSelectedTabId());
parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(),"]]><xsl:value-of select="$SRMTips"/><![CDATA[");
parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames(0).getSelectedTabId());
parent.parent.parent.parent.showTipsButton();
parent.parent.parent.parent.toggleTipDetails();

}
]]>

     function swifta()
     {
		try{
		document.getElementsByName("SWIFT_ADDRESS_DETAILS")[0].disabled = false;

		readMode="Y";
		document.getElementsByName("Close")[0].disabled = false;
		}catch(e){
		}
	  }
	  function validateDOB2(){

	  			var todaydate = new String();
	  			todaydate.value = getTodayDate1(locDate);

	  		var elem1 = document.getElementsByName("3_NonCustomerBO.DOB")[0];

	  		if (elem1.value != '')
	  		{
	  			todaydate.value = convertDate(todaydate.value);
	  		}

	  			var mill1 = changetoMillisForToday(todaydate.value);
	  		        var mill2 = changetoMillis(elem1.value);
	  			if (mill1 &lt; mill2){

	  				showMessage(MSGX0060);
	  				document.getElementsByName("3_NonCustomerBO.DOB")[0].value='';
	  				document.getElementsByName("3_NonCustomerBO.DOB")[0].focus();
	  				return;
	  			}

		}


<!-- Tracker ID: 108385: Begin of changes : For focus on first field -->
function focusFirstField()
{
	try
	{
		document.getElementsByName("NonCustomerBO.OrgKey")[0].focus();
	}
	catch (e)
	{
		try
		{
			
			document.getElementsByName("NonCustomerBO.Address.preferredAddress")[0].focus();
			//changes for Ticket id: 566732 starts
			//changes for Tracker id: 292525 starts
			//document.getElementsByName("NonCustomerBO.Address.preferredAddress")[0].value = defAddress;
			//changes for Tracker id: 292525 ends
			//changes for Ticket id: 566732 starts
		}
		catch (e)
		{
			try
			{
				document.getElementsByName("NonCustomerBO.PhoneEmail.PhoneEmailType")[0].focus();
			}
			catch (e)
			{
			}
/* CRM11.0:TRACKER:113058:BEGINOFCHANGES */
			              try
					{
						document.getElementsByName("AddIdentificationDetails")[0].focus();
					}
					catch (e)
					{
			                }

/* CRM11.0:TRACKER:113058:ENDOFCHANGES */
		}
	}
}




<!-- Tracker ID: 108385: End of changes -->
	// KeyGeneration start
	function checkKeys() {
		if (event.keyCode == 42 || event.keyCode ==37) {
			event.keyCode=0;
		}
	}
	// KeyGeneration end
        function Toggle_Address(id){
	          try{
	            var gif = document.all[id + "gif"];
	            var tbl = document.all[id];
	            if (tbl.style.display == "")
	            {
	                tbl.style.display = "none";
	                gif.src = '../reports/images/plus.gif';
	            }
	            else
	            {
	                tbl.style.display = "";
	                gif.src = '../reports/images/minus.gif';
	            }
	        }catch(e){
	        }

        }



        function clear() {
			try{
			/* Changes for WFlow POC -- start */
			if ((IntWFID != null) &amp; (IntWFID != undefined) &amp; (IntWFID != '')) {
				Updatedb(IntWFID,"Non_Customers_Mod");
			}
			/* Changes for WFlow POC -- end */
		if(nonCustomerUrl==''|| isCopy=='Y')
		{
        	 document.getElementsByName("accID")[0].value = parent.formSaveFrame.savedValue;
        	 document.getElementsByName("AddressFields")[0].value = parent.formSaveFrame.AddressFields;
        	 /*TrackerID;161933 Changes Begin */
        	  document.getElementsByName("OtherTFFields")[0].value = unescape(parent.formSaveFrame.OtherTFFields);
        	  /*TrackerID;161933 Changes End */
        	 document.getElementsByName("CoreCustID")[0].value = parent.formSaveFrame.CoreCustID;
        	 }
		}
		catch(e){}
	 }

	function closebtn(){
	
		if(nonCustomerUrl==''){
		   		parent.frames(0).location.href = parent.frames(0).location.href;
		}
		else
		/* Changes for ticketid-685032 -- starts */
		if ((isCopy=='Y')||(readMode=='Y') ||((nonCustomerUrl!='')&amp;&amp;(boName=='NonCustomerModBO')) ||((nonCustomerUrl!='')&amp;&amp;(boName=='NonCustomerBO')))
		{
		top.window.close();
		}
		else
		history.go(-1);
		/* Changes for ticketid-685032 -- ends */
}



	function isDocument_Received() {
	    var docRecv= document.getElementsByName("ckDocument_Received")[0];
	    if(docRecvd=='Y') {
	    docRecv.checked = true;
	    }
	}

	<!--Access Control Changes-->
	function  openBCCodeLookup(type)
	{
	    /*Tracker:108379:Changes for Centering popup*/
		var wh = 460;
		var ww = 900;
		var left_x = (screen.width - ww) / 2 ;
		var left_y = (screen.height - wh) / 2 ;
	    /*Tracker:108379:End of changes*/

		bcCodeLookup = type;
		var url = "com.infy.cis.ui.common.Lookup?Mode=ForBCCode&amp;isActive=Y&amp;isAutomated=N";

	    /*Tracker:108379:Changes for Centering popup*/
		var style = 'height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes';
	    /*Tracker:108379:End of changes*/
		window.open (url, "Lookup", style);
	}
	function  onBCCodeSelect()
	{
		setBCCodeValues ( bcCodeLookup , getCookie("bCCode"), getCookie("bCID"));
		document.getElementsByName("NonCustomerBO.accessOwnerBC")[0].fireEvent("onChange");
	}

	function  setBCCodeValues (type, bCCode, bCID)
	{
		eval("document.frm2." + type).value = bCID;
		eval("document.getElementsByName('NonCustomerBO.accessOwnerBC')[0]").value  = bCCode;
	}

	function setAccessOwnerGroup()
	{
		document.frm2.accessOwnerGroup.value=document.getElementsByName('NonCustomerBO.accessOwnerGroup')[0].value;
		return
	}
	<!--End of Changes-->

	function resubmit(){
		parent.parent.parent.parent.parent.parent.frames(0).submit();
	}

        function selectProcess(){
		if(document.frm2.isMCEditedGeneral.value=="N"){
       			appFlag="false";
       		}
        	submit = true;
        	var entityType = "";
        	var accountId=0;
		accountId  = parent.formSaveFrame.savedValue;

		//...added by vishal....
		if( appFlag=='true')
		  {
		  entityType = "NonCustomerMod";
		  }
		else
		  {
		  entityType = "NonCustomer";

		  }
		//accountId  = parent.formSaveFrame.savedValue;
		//Checksum Recon from 10.3 SUPP
		var secureHKey = document.getElementsByName("SECUREHKEY")[0].value;	
		var keyField = document.getElementsByName("FLDHASHKEY")[0].value;
		/*Tracker :93811 Fix start */
		//Changes for call id 453678
		//window.open('../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+accountId+'&amp;entityType='+entityType+'&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField+'&amp;isPopup=Yes','save','directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no');
		//Checksum Recon from 10.3 SUPP
		/*Tracker :93811 Fix end */
		  //Changes for call id 373394 Starts : Process window was not coming in focus
		 // window.showModalDialog('../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+accountId+'&amp;entityType='+entityType+'&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField+'&amp;isPopup=Yes','save','dialogHeight:360px; dialogLeft:'+ (screen.width - 900) / 2 +'px;dialogTop:'+ (screen.height - 360) / 2+'px; dialogWidth:500px;center:yes;resizable:no;status:no;scroll:no;help:no;');
		  
               //Changes for call id 373394 Ends : Process window was not coming in focus
	//453678
		//if(nonCustomerUrl != '' &amp;&amp; nonCustomerUrl !=null &amp;&amp; nonCustomerUrl != 'null'){
		//top.close();
       			//}
		//Changes for call id 453678
		//Checksum Recon from 10.3 SUPP
		/*Tracker :93811 Fix end */
		var strProcessURL = '../servlet/com.infy.cis.custom.EquityRetailProcessSelection?entityId='+accountId+'&amp;entityType='+entityType;
		var strBOURL = "";
		fnProcessSelection(strProcessURL, strBOURL);
       		/*End of changes by Niharika for CR356016*/
        }

function shouldRefresh()
{
 	var oprType = '<xsl:value-of select="$operationType"/>';
 	if(oprType == 'Queue'){
 		return true;
 	}
 	else{
 		return false;
 	}
}

function refreshParent(){
	    
	      	frm = top.opener.parent.frames(1);
	      	frm.navigate (frm.location.href);
}


        function formatPage(){

        <!--Tracker id 113227 start here-->
	 document.frm2.altLocaleActv.value='<xsl:value-of select="$altLocaleActv"/>';
 	<!--Tracker id 113227 end here-->
        	Toggle_Address('work');
        	Toggle_Address('home');
        }

        function showButtons(btnSize){
        	parent.parent.parent.parent.setCifButtonsVisible(true,btnSize);
        }

        function closeView(){
        	parent.parent.parent.parent.parent.parent.parent.frames(0).submit();
        }

        <!-- changes shanmuga New Field Addn - Start-->
	// Function to load the Currency dropdown field
	function loadBaseCurrency()
	{

		var baseCurrency = '<xsl:value-of select="$BaseCurrency"/>';
		document.getElementsByName(boName+".CU_AnnualIncome")[0].value = baseCurrency;
	}function setMCAttModifyFlag(){
		document.frm2.isMCEditedGeneral.value="Y";

	}

	//function to load refCodes
	function loadCode()
	{
		var temp = '<xsl:value-of select="//SRMData//Z[@n=concat($boName,'.Legal_Status')]"/>';
		document.getElementsByName(boName + '.Legal_Status')[0].value = temp;
		temp = '<xsl:value-of select="//SRMData//Z[@n=concat($boName,'.LineOfActivity')]"/>';
		document.getElementsByName(boName + '.LineOfActivity')[0].value = temp;
	}

	// Functon to format the Annual Salary Income field value
	function formatDemographyAmount()
	{
		try{
			baseCurrency = '<xsl:value-of select="$BaseCurrency"/>';
			//document.frm2.elements("NonCustomerBO.CU_AnnualIncome").value =baseCurrency;
			formatAmount("3_NonCustomerBO.annualIncome",boName+".CU_AnnualIncome","N");
		}
		catch(e)
		{
		}
	}
	<!-- changes shanmuga New Field Addn - End-->


 	function SetLocCookies(){
		try{
			onLoadSetLocCookies('NonCustomerBO.HomeAddCity','NonCustomerBO.HomeAddState','NonCustomerBO.HomeAddCountry');
			onLoadSetLocCookies('NonCustomerBO.WorkAddCity','NonCustomerBO.WorkAddState','NonCustomerBO.WorkAddCountry');
		}catch(e){
 		}
	}

        </script>
        </head>
<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 start-->
     <body class="popup" onkeypress="onLoadSetTime()" onclick="onLoadSetTime()">
     <!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 end-->
     
     <!-- changes shanmuga New Field Addn - Start-->
     <xsl:choose>
     <xsl:when test="normalize-space($nonCustURL)=''">
                  <xsl:attribute name="onload">focusFirstField();loadID();SetLocCookies();populateAccContAttr();loadBaseCurrency();formatDemographyAmount();formatPage();load();showButtons(45);setFocusOnComp(NonCustomerBO.Last_Name);concatName();showFormTips();fnPrivacyValidate();disableDefaultAlert();selectFieldDefaultChannel();</xsl:attribute>
     </xsl:when>
     <xsl:when test="normalize-space($readMode)='Y'">
     	     <!-- Changes for ticket id: 666514 starts-->
			 <!--456818-->
             <xsl:attribute name="onload">showInReadOnlyMode('<xsl:value-of select="$readMode"/>');loadID();chkBSN();populateAccContAttr();loadBaseCurrency();formatDemographyAmount();formatPage();load();swifta();concatName();</xsl:attribute>
			 <!--456818-->
     	     <!-- Changes for ticket id: 666514 ends-->
     </xsl:when>
     <xsl:otherwise>
     <!-- changes for ticket id 629419 BEGIN -->
     <!-- changes for tracker 378548 --><!--Changes for call id 425426-recon for 423993 adding phoneEmail();-->
     <!-- changes for callid 443405 begin -->
             <xsl:attribute name="onload">loadID();chkBSN();populateAccContAttr();loadBaseCurrency();formatDemographyAmount();formatPage();load();focusFirstField();selectFieldDefaultChannel();checkEnableAlertsNonCustomer();SetLocCookies();isDocument_Received();loadCode();showButtons(30);concatName();showFormTips();fnPrivacyValidate();</xsl:attribute>
      <!-- changes for callid 443405 ends -->
      <!-- changes for ticket id 629419 END -->
     </xsl:otherwise>
     </xsl:choose>
     <!-- changes shanmuga New Field Addn - End-->


		                     <xsl:apply-templates select="SRM"/>



		      </body>
                </html>

           </xsl:template>

         <!-- shanmuga CIF changes - Name fields are called seperately
         <xsl:template name="NonCustomerBO.NAME">
	                 <xsl:call-template name="personname">
	                    <xsl:with-param name="res_name4" select="$configLabels[@name='NonCustomerBO.Salutation']"/>
	                    <xsl:with-param name="sal_val">NonCustomerBO.Salutation</xsl:with-param>
	                    <xsl:with-param name="sal_dispname">Salutation</xsl:with-param>

	                    <xsl:with-param name="res_name1" select="$configLabels[@name='NonCustomerBO.Last_Name']"/>
	                    <xsl:with-param name="ele_lastname">NonCustomerBO.Last_Name</xsl:with-param>
	                    <xsl:with-param name="ele_lastval">NonCustomerBO.Last_Name</xsl:with-param>
	                    <xsl:with-param name="IsMandatory1">true</xsl:with-param>

	                    <xsl:with-param name="res_name2" select="$configLabels[@name='NonCustomerBO.Middle_Name']"/>
	                    <xsl:with-param name="ele_middlename">NonCustomerBO.Middle_Name</xsl:with-param>
	                    <xsl:with-param name="ele_middleval">NonCustomerBO.Middle_Name</xsl:with-param>

	                    <xsl:with-param name="res_name3" select="$configLabels[@name='NonCustomerBO.First_Name']"/>
	                    <xsl:with-param name="ele_firstname">NonCustomerBO.First_Name</xsl:with-param>
	                    <xsl:with-param name="ele_firstval">NonCustomerBO.First_Name</xsl:with-param>
						<xsl:with-param name="checkASCII">false</xsl:with-param>
	                 </xsl:call-template>
        </xsl:template>
        shanmuga CIF changes -->

        <!-- shanmuga CIF changes Call for the Name fields - Start -->
	<xsl:template name="NonCustomerBO.Salutation">
	        <xsl:call-template name="mdrpdown">
	                <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Salutation']"/>
	                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Salutation</xsl:with-param>
	                <xsl:with-param name="selectdisp">NonCustomerBO.Salutation</xsl:with-param>
	                <xsl:with-param name="search_type">value</xsl:with-param>
	                <xsl:with-param name="choice_name">NonCustomerBO.Salutation</xsl:with-param>
                        <xsl:with-param name="onchangefn">changeGender('<xsl:value-of select="$boName"/>');checkSalutation('S')</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
	        </xsl:call-template>
	 </xsl:template>


	<xsl:template name="NonCustomerBO.Last_Name">
	        <xsl:call-template name="label">
	                <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Last_Name']"/>
	                <xsl:with-param name="ele_name">NonCustomerBO.Last_Name</xsl:with-param>
	                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Last_Name</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
                	<xsl:with-param name="fn_onBlur">concatName();set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	        </xsl:call-template>
	</xsl:template>

	<xsl:template name="NonCustomerBO.Middle_Name">
	        <xsl:call-template name="label">
	                <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Middle_Name']"/>
	                <xsl:with-param name="ele_name">NonCustomerBO.Middle_Name</xsl:with-param>
	                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Middle_Name</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
                	<xsl:with-param name="fn_onBlur">concatName();set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	        </xsl:call-template>
	</xsl:template>

	<xsl:template name="NonCustomerBO.First_Name">
	        <xsl:call-template name="label">
	                <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.First_Name']"/>
	                <xsl:with-param name="ele_name">NonCustomerBO.First_Name</xsl:with-param>
	                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.First_Name</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
                	<xsl:with-param name="fn_onBlur">concatName();set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	        </xsl:call-template>
	</xsl:template>

<!--TrackerID: 113227  Start of changes-->

	<xsl:template name="NonCustomerBO.First_Name_alt1">
	        <xsl:call-template name="label_alternate">
	                <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.First_Name']"/>
	                <xsl:with-param name="ele_name">NonCustomerBO.First_Name_alt1</xsl:with-param>
	                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.First_Name_alt1</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>
                	<xsl:with-param name="fn_onBlur">concatName();set_isName(this,true);</xsl:with-param>

	        </xsl:call-template>
	</xsl:template>
	<xsl:template name="NonCustomerBO.Middle_Name_alt1">
	        <xsl:call-template name="label_alternate">
	                <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Middle_Name']"/>
	                <xsl:with-param name="ele_name">NonCustomerBO.Middle_Name_alt1</xsl:with-param>
	                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Middle_Name_alt1</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>
                	<xsl:with-param name="fn_onBlur">concatName();set_isName(this,true);</xsl:with-param>

	        </xsl:call-template>
	</xsl:template>

	<xsl:template name="NonCustomerBO.Last_Name_alt1">
	        <xsl:call-template name="label_alternate">
	                <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Last_Name']"/>
	                <xsl:with-param name="ele_name">NonCustomerBO.Last_Name_alt1</xsl:with-param>
	                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Last_Name_alt1</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>
                	<xsl:with-param name="fn_onBlur">concatName();set_isName(this,true);</xsl:with-param>

	        </xsl:call-template>
	</xsl:template>

       <xsl:template name="NonCustomerBO.EmployerName_alt1">
			             <xsl:call-template name="label_alternate">
			                 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.EmployerName']"/>
			                 <xsl:with-param name="ele_name">NonCustomerBO.EmployerName_alt1</xsl:with-param>
			                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.EmployerName_alt1</xsl:with-param>
							 <xsl:with-param name="checkASCII">false</xsl:with-param>
					<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>

			             </xsl:call-template>
        </xsl:template>

<!--TrackerID: 113227  End of changes-->

	<!-- shanmuga CIF changes Call for the Name fields - End -->



	<xsl:template name="NonCustomerBO.Gender">
	        <xsl:call-template name="mdrpdown">
	             <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Gender']"/>
	             <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Gender</xsl:with-param>
	             <xsl:with-param name="search_type">value</xsl:with-param>
	             <xsl:with-param name="selectdisp">Gender</xsl:with-param>
	             <xsl:with-param name="defaultValue">Male</xsl:with-param>
	             <xsl:with-param name="choice_name">NonCustomerBO.Gender</xsl:with-param>
                     <xsl:with-param name="onchangefn">checkSalutation('G')</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
	        </xsl:call-template>
        </xsl:template>


<!-- KeyGeneration start -->
        <xsl:template name="NonCustomerBO.OrgKey">
	  <xsl:choose>
	  <!-- Changes for ticket id :365470 starts here  -->
	    <xsl:when test= "normalize-space($keyGeneration)='Reserved' or normalize-space($keyGeneration)='Both' and (normalize-space($nonCustURL)='' or normalize-space($entityCreflg) = 'N' or normalize-space($isCopy) = 'Y')">
	  <!-- Changes for ticket id :365470 ends here  -->
		<xsl:call-template name="lookup">
		 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.OrgKey']"/>
			<xsl:with-param name="elename">NonCustomerBO.OrgKey</xsl:with-param>
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.OrgKey</xsl:with-param>
			<xsl:with-param name="buttonone_fnc">openReservation('NonCustomerBO.OrgKey','Retail')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearReservation('NonCustomerBO.OrgKey')</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="fn_onKeyPress">checkKeys()</xsl:with-param>
			<xsl:with-param name="toUpperCase">false</xsl:with-param>
		    <!-- Changes done by sonali for 286045 Begin -->
<!--changes for ticket id 596967 and recon for call id 306383 starts-->
			<xsl:with-param name="fn_onBlur">checkStatus('NonCustomerBO.OrgKey',keyGeneration);set_key();txtLimit_CIF(this,"NonCustomerBO.OrgKey","CIF ID");</xsl:with-param>
<!--changes for ticket id 596967 and recon for call id 306383 ends-->
		    <!-- Changes done by sonali for 286045 End -->
		 </xsl:call-template>
	    </xsl:when>
	    <xsl:when test= "normalize-space($keyGeneration)='Manual' and (normalize-space($nonCustURL)='' or normalize-space($entityCreflg) = 'N')">
	        <xsl:call-template name="label">
		       <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.OrgKey']"/>
		       <xsl:with-param name="selectdisp">NonCustomerBO.OrgKey</xsl:with-param>
		       <xsl:with-param name="ele_name">NonCustomerBO.OrgKey</xsl:with-param>
		       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.OrgKey</xsl:with-param>
		       <xsl:with-param name="starshow">true</xsl:with-param>
		    <!-- Changes done by sonali for 286045 Begin -->
<!--changes for ticket id 596967 and recon for call id 306383 starts-->
		       <xsl:with-param name="fn_onBlur">checkStatus('NonCustomerBO.OrgKey',keyGeneration);set_key();txtLimit_CIF(this,"NonCustomerBO.OrgKey","CIF ID");</xsl:with-param>
<!--changes for ticket id 596967 and recon for call id 306383 ends-->
		       <xsl:with-param name="fn_onKeyPress">checkKeys()</xsl:with-param>
		    <!-- Changes done by sonali for 286045 End -->
		</xsl:call-template>
	    </xsl:when>
	    <!-- ticket 277597 changes start -->
	   <xsl:when test= "normalize-space($isAutoGenKey)='true'">
           	<xsl:call-template name="label">
           		<xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.OrgKey']"/>
            	 	<xsl:with-param name="mand">true</xsl:with-param>
             		<xsl:with-param name="ele_name">NonCustomerBO.OrgKey</xsl:with-param>
             		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.OrgKey</xsl:with-param>
             		<xsl:with-param name="read_val">true</xsl:with-param>
            		<xsl:with-param name="IsMandatory" select="No"/>
            		<xsl:with-param name="starshow">true</xsl:with-param>
             	</xsl:call-template>
            </xsl:when>
	    <!-- ticket 277597 changes end -->
	    <xsl:otherwise>
		<xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.OrgKey']"/>
		    <xsl:with-param name="selectdisp">NonCustomerBO.OrgKey</xsl:with-param>
		 <xsl:with-param name="ele_name">NonCustomerBO.OrgKey</xsl:with-param>
		 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.OrgKey</xsl:with-param>
		 <!-- 277597 changes start commenting out <xsl:with-param name="read_val">true</xsl:with-param> 277597 end -->
		 <xsl:with-param name="IsMandatory" select="No"/>
		 <xsl:with-param name="starshow">true</xsl:with-param>
		    <xsl:with-param name="fn_onKeyPress">checkKeys()</xsl:with-param>
		    <!-- Changes done by sonali for 286045 Begin -->
<!--changes for ticket id 596967 and recon for call id 306383 starts-->
		    <xsl:with-param name="fn_onBlur">checkStatus('NonCustomerBO.OrgKey',keyGeneration);set_key();txtLimit_CIF(this,"NonCustomerBO.OrgKey","CIF ID");</xsl:with-param>
<!--changes for ticket id 596967 and recon for call id 306383 ends-->
		    <!-- Changes done by sonali for 286045 End -->
		 </xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
         </xsl:template>
<!-- KeyGeneration end -->

	    <xsl:template name="Document_Received">
		<xsl:call-template name="checkbox1">
		    <xsl:with-param name="name">ckDocument_Received</xsl:with-param>
		    <xsl:with-param name="checkbox_val">true</xsl:with-param>
		</xsl:call-template>
	    </xsl:template>


        <xsl:template name="NonCustomerBO.Flg1">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Flg1']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Flg1</xsl:with-param>
                <xsl:with-param name="selectdisp">NonCustomerBO.Flg1</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="choice_name">NonCustomerBO.Flg1</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
        </xsl:template>

        <xsl:template name="NonCustomerBO.Flg2">
	            <xsl:call-template name="mdrpdown">
	                <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Flg2']"/>
	                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Flg2</xsl:with-param>
	                <xsl:with-param name="selectdisp">NonCustomerBO.Flg2</xsl:with-param>
	                <xsl:with-param name="search_type">value</xsl:with-param>
	                <xsl:with-param name="choice_name">NonCustomerBO.Flg2</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
	            </xsl:call-template>
        </xsl:template>


        <xsl:template name="NonCustomerBO.Alert1">
		             <xsl:call-template name="label">
		                 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Alert1']"/>
		                 <xsl:with-param name="ele_name">NonCustomerBO.Alert1</xsl:with-param>
		                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Alert1</xsl:with-param>
	        </xsl:call-template>
	  </xsl:template>



	<xsl:template name="NonCustomerBO.Alert2">
		             <xsl:call-template name="label">
		                 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Alert2']"/>
		                 <xsl:with-param name="ele_name">NonCustomerBO.Alert2</xsl:with-param>
		                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Alert2</xsl:with-param>
		             </xsl:call-template>
	 </xsl:template>


         <xsl:template name="NonCustomerBO.DtDate1">
	             <xsl:call-template name="label">
	                 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.DtDate1']"/>
	                 <xsl:with-param name="ele_name">NonCustomerBO.DtDate1</xsl:with-param>
	                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.DtDate1</xsl:with-param>
	                 <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
			 <!-- calling the function isGregDate for on blur functionality-->
	                 <xsl:with-param name="fn_onBlur">isGregDate("3_NonCustomerBO.DtDate1");</xsl:with-param>
	                 <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
	             </xsl:call-template>
	         </xsl:template>

	 <xsl:template name="NonCustomerBO.DtDate2">
	             <xsl:call-template name="label">
	                 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.DtDate2']"/>
	                 <xsl:with-param name="ele_name">NonCustomerBO.DtDate2</xsl:with-param>
	                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.DtDate2</xsl:with-param>
	                 <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
			 <!-- calling the function isGregDate for on blur functionality-->
	                 <xsl:with-param name="fn_onBlur">isGregDate("3_NonCustomerBO.DtDate2");</xsl:with-param>
	                 <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
	             </xsl:call-template>
	 </xsl:template>

	 <xsl:template name="NonCustomerBO.DOB">
	 	             <xsl:call-template name="label">
	 	                 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.DOB']"/>
	 	                 <xsl:with-param name="ele_name">NonCustomerBO.DOB</xsl:with-param>
	 	                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.DOB</xsl:with-param>
	 	                 <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
			         <!-- calling the function isGregDate for on blur functionality-->
	 	                 <xsl:with-param name="fn_onBlur">isGregDate("3_NonCustomerBO.DOB");validateDOB2();</xsl:with-param>
	 	                 <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
	 	             </xsl:call-template>
	 </xsl:template>

	<!-- changes shanmuga New Field Addn - Start-->
         <xsl:template name="NonCustomerBO.annualIncome">
	 		<xsl:call-template name="amountlabel">
	 			  <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.annualIncome']"/>
	 			  <xsl:with-param name="ele_name">NonCustomerBO.annualIncome</xsl:with-param>
	 			  <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.annualIncome</xsl:with-param>
	 			  <xsl:with-param name="fncname">rate("3_NonCustomerBO.annualIncome",boName+".CU_AnnualIncome",'<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
	 			  <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CU_AnnualIncome</xsl:with-param>
	 			  <xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.CU_AnnualIncome</xsl:with-param>
	 			  <xsl:with-param name="fn_onBlur">formatAmount("3_NonCustomerBO.annualIncome",boName+".CU_AnnualIncome","N");</xsl:with-param>
	 			  <xsl:with-param name="choicename">NonCustomerBO.CU_AnnualIncome</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
	 		</xsl:call-template>
	</xsl:template>
	<!-- changes shanmuga New Field Addn - End-->

	 <xsl:template name="NonCustomerBO.Amount1">
	            <xsl:call-template name="label">
	             <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Amount1']"/>
	             <xsl:with-param name="ele_name">NonCustomerBO.Amount1</xsl:with-param>
	             <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Amount1</xsl:with-param>
	            </xsl:call-template>
         </xsl:template>

         <xsl:template name="NonCustomerBO.Amount2">
	            <xsl:call-template name="label">
	             <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Amount2']"/>
	             <xsl:with-param name="ele_name">NonCustomerBO.Amount2</xsl:with-param>
	             <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Amount2</xsl:with-param>
	            </xsl:call-template>
         </xsl:template>


	 <xsl:template name="NonCustomerBO.strfield1">
	             <xsl:call-template name="label">
	                 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.strfield1']"/>
	                 <xsl:with-param name="ele_name">NonCustomerBO.strfield1</xsl:with-param>
	                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.strfield1</xsl:with-param>

	             </xsl:call-template>
	         </xsl:template>


	<xsl:template name="NonCustomerBO.strfield2">
	             <xsl:call-template name="label">
	                 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.strfield2']"/>
	                 <xsl:with-param name="ele_name">NonCustomerBO.strfield2</xsl:with-param>
	                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.strfield2</xsl:with-param>
	             </xsl:call-template>
        </xsl:template>


        <!-- Field Rationalization changes start -->
           <!-- CODE ADDED BY KAMAL for tracker id 349409 -->
			      <xsl:template name="NonCustomerBO.OccupationType">
					    <xsl:call-template name="lookup">
						   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.OccupationType']"/>
							   <xsl:with-param name="elename">NonCustomerBO.OccupationType</xsl:with-param>
							   <xsl:with-param name="eleval">NonCustomerBO.OccupationType</xsl:with-param>
							    <!-- Field Rationalization changes start -->
									 <!--   <xsl:with-param name="code_req">true</xsl:with-param> -->
											 <!-- Field Rationalization changes end -->
									 <!--  TRACKER ID:150150  CHANGES BEGIN   -->
											 <xsl:with-param name="buttonone_name" select="$configLabels[@name='BTN_LOOKUP']/@configLabel"/>
											 <xsl:with-param name="buttontwo_name" select="$configLabels[@name='BTN_CLEAR']/@configLabel"/>
											 <xsl:with-param name="buttonone_fnc">categoryLookup('CONTACT_OCCUPATION', 'NonCustomerBO.OccupationType')</xsl:with-param>
											 <xsl:with-param name="buttontwo_fnc">clearCategoryValue('NonCustomerBO.OccupationType')</xsl:with-param>
											 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
											 <xsl:with-param name="checkASCII">false</xsl:with-param>
									 <!--  TRACKER ID:150150  CHANGES END  -->
											 <!-- CIF Changes for Caching Views : Start -->
							 <xsl:with-param name="presdata" select="$PresData"/>
							 <!-- CIF Changes for Caching Views : End -->
								</xsl:call-template>
			     </xsl:template>
	         
  <!-- CODE ADDED BY KAMAL for tracker id 349409 -->
             

        <!-- Field Rationalization changes end -->
        
       
        <!--CRM ALERT CHANGES START-->

	<xsl:template name="NonCustomerBO.DefaultChannelAlert">
		<xsl:call-template name="listview">
			<xsl:with-param name="ISXSSCHECK">type1</xsl:with-param>
			<xsl:with-param name="class">listBox</xsl:with-param>
			<xsl:with-param name="ele_name">NonCustomerBO.DefaultChannelAlert</xsl:with-param>
			<xsl:with-param name="label" select="$configLabels[@name='NonCustomerBO.DefaultChannelAlert']/@configLabel" />
			<xsl:with-param name="multiple">true</xsl:with-param>
			<xsl:with-param name="onchangefn">savefieldDefaultChannel('NonCustomerBO.DefaultChannelAlert');mandatoryPreferredMobAlert();</xsl:with-param>
			<xsl:with-param name="selectdisp">true</xsl:with-param>
			<xsl:with-param name="selectname">NonCustomerBO.DefaultChannelAlert</xsl:with-param>
			<xsl:with-param name="size">3</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
		
	<xsl:template name="NonCustomerBO.EnableAlerts">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="ISXSSCHECK">type1</xsl:with-param>
			<xsl:with-param name="choice_name">NonCustomerBO.EnableAlerts</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData" />
			<xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.enableAlerts']" />
		       <xsl:with-param name="onchangefn">disableConditionally('<xsl:value-of disable-output-escaping="yes" select="$boName"></xsl:value-of>.enableAlerts', 'NonCustomerBO.defaultChannelAlert');checkEnableAlertsNonCustomer();</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="selectdisp">NonCustomerBO.EnableAlerts</xsl:with-param>
			<xsl:with-param name="selectname">NonCustomerBO.EnableAlerts</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="NonCustomerBO.PreferredMobileAlertType">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="ISXSSCHECK">type1</xsl:with-param>
			<xsl:with-param name="choice_name">NonCustomerBO.PreferredMobileAlertType</xsl:with-param>
			<!--<xsl:with-param name="onchangefn">selecthid();</xsl:with-param>-->
			<xsl:with-param name="presdata" select="$PresData" />
			<xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.preferredMobileAlert_Type']" />
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="selectdisp">NonCustomerBO.PreferredMobileAlertType</xsl:with-param>
			<xsl:with-param name="selectname">NonCustomerBO.PreferredMobileAlertType</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
<!--CRM ALERT CHANGES ENDS-->
        <!-- changes shanmuga New Field Addn - Start-->

         <xsl:template name="NonCustomerBO.SourceOfIncome">
	     <xsl:call-template name="label">
		 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.SourceOfIncome']"/>
		 <xsl:with-param name="ele_name">NonCustomerBO.SourceOfIncome</xsl:with-param>
		 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SourceOfIncome</xsl:with-param>
		 <xsl:with-param name="checkASCII">false</xsl:with-param>
	     </xsl:call-template>
        </xsl:template>
        <!-- changes shanmuga New Field Addn - End -->

        <xsl:template name="LastUpdateDate">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='LastUpdateDate']"/>
			<xsl:with-param name="disable_val">true</xsl:with-param>
			<xsl:with-param name="ele_name">LastUpdateDate</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="ele_val">LastUpdateDate</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
		</xsl:call-template>
        </xsl:template>
        <xsl:template name="NonCustomerBO.EmployerName">
			             <xsl:call-template name="label">
			                 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.EmployerName']"/>
			                 <xsl:with-param name="ele_name">NonCustomerBO.EmployerName</xsl:with-param>
			                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.EmployerName</xsl:with-param>
							 <xsl:with-param name="checkASCII">false</xsl:with-param>
		<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
					<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
		<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
			             </xsl:call-template>
        </xsl:template>

        <!-- Field Rationalization changes start -->
             <xsl:template name="NonCustomerBO.Nationality">
             <xsl:call-template name="lookup">
             <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Nationality']"/>
             <xsl:with-param name="elename">NonCustomerBO.Nationality</xsl:with-param>
             <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Nationality</xsl:with-param>
             <xsl:with-param name="code_req">true</xsl:with-param>
	     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
             <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
             <xsl:with-param name="buttonone_fnc">categoryLookup('NATIONALITY', 'NonCustomerBO.Nationality')</xsl:with-param>
             <xsl:with-param name="buttontwo_fnc">clearCategoryValue('NonCustomerBO.Nationality')</xsl:with-param>
	     <xsl:with-param name="checkASCII">false</xsl:with-param>
             </xsl:call-template>
             </xsl:template>

        <!-- Field Rationalization changes end -->

        <xsl:template name="NonCustomerBO.MLUserField10">
			<xsl:call-template name="label">
				<xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.MLUserField10']"/>
				<xsl:with-param name="ele_name">NonCustomerBO.MLUserField10</xsl:with-param>
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MLUserField10</xsl:with-param>
				<xsl:with-param name="checkASCII">false</xsl:with-param>
			</xsl:call-template>
	</xsl:template>

	<xsl:template name="NonCustomerBO.MLUserField11">
			<xsl:call-template name="label">
				<xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.MLUserField11']"/>
				<xsl:with-param name="ele_name">NonCustomerBO.MLUserField11</xsl:with-param>
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MLUserField11</xsl:with-param>
				<xsl:with-param name="checkASCII">false</xsl:with-param>
			</xsl:call-template>
	</xsl:template>


	<xsl:template name="NonCustomerBO.Home_house_no">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Home_house_no']"/>
			<xsl:with-param name="ele_name">NonCustomerBO.Home_house_no</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Home_house_no</xsl:with-param>
			<xsl:with-param name="idval">homeAdd</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

        <xsl:template name="NonCustomerBO.Home_premise_name">
		<xsl:call-template name="label">
		 	<xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Home_premise_name']"/>
		   	<xsl:with-param name="ele_name">NonCustomerBO.Home_premise_name</xsl:with-param>
		   	<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Home_premise_name</xsl:with-param>
		   	<xsl:with-param name="idval">homeAdd</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
	       </xsl:call-template>
	 </xsl:template>

        <xsl:template name="NonCustomerBO.Home_building_level">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Home_building_level']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Home_building_level</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Home_building_level</xsl:with-param>
			                   <xsl:with-param name="idval">homeAdd</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Home_street_no">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Home_street_no']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Home_street_no</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Home_street_no</xsl:with-param>
			                   <xsl:with-param name="idval">homeAdd</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Home_street_name">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Home_street_name']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Home_street_name</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Home_street_name</xsl:with-param>
			                   <xsl:with-param name="idval">homeAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Home_suburb">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Home_suburb']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Home_suburb</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Home_suburb</xsl:with-param>
			                   <xsl:with-param name="idval">homeAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Home_locality_name">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Home_locality_name']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Home_locality_name</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Home_locality_name</xsl:with-param>
			                   <xsl:with-param name="idval">homeAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Home_town">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Home_town']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Home_town</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Home_town</xsl:with-param>
			                   <xsl:with-param name="idval">homeAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Home_domicile">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Home_domicile']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Home_domicile</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Home_domicile</xsl:with-param>
			                   <xsl:with-param name="idval">homeAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.HomeAddCity">
	<xsl:call-template name="lookup">
		        <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.HomeAddCity']"/>
		        <xsl:with-param name="elename">NonCustomerBO.HomeAddCity</xsl:with-param>
		        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.HomeAddCity</xsl:with-param>
		        <xsl:with-param name="idval">homeAdd</xsl:with-param>
		        <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
		        <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		        <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		        <xsl:with-param name="buttonone_fnc">categoryLookupCode('CITY', 'NonCustomerBO.HomeAddCity','HomeAddCity_code')</xsl:with-param>

				 <!-- vasanth's changes start-->

				   <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('CITY', 'NonCustomerBO.HomeAddCity','HomeAddCity_code','NonCustomerBO.HomeAddState','NonCustomerBO.HomeAddCountry')</xsl:with-param>
				   <xsl:with-param name="buttontwo_fnc">clearLocValue('NonCustomerBO.HomeAddCity','CITY')</xsl:with-param>

					<!--<xsl:with-param name="buttonone_fnc">categoryLookupCode('CITY', 'NonCustomerBO.HomeAddCity','HomeAddCity_code')</xsl:with-param>
					<xsl:with-param name="buttontwo_fnc">clearCategoryValue('NonCustomerBO.HomeAddCity')</xsl:with-param>-->

				 <!-- vasanth's changes end-->
            </xsl:call-template>
		<input type="hidden" name="HomeAddCity_code" value="{$HomeAddCity_code}"/>
	</xsl:template>

	<!--Access Control changes-->
	 <xsl:template name="NonCustomerBO.accessOwnerGroup">
		     <xsl:call-template name="mdrpdown">
			 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.accessOwnerGroup']"/>
			 <xsl:with-param name="selectname">NonCustomerBO.accessOwnerGroup</xsl:with-param>
			 <xsl:with-param name="selectdisp">NonCustomerBO.accessOwnerGroup</xsl:with-param>
			 <xsl:with-param name="search_type">value</xsl:with-param>
			 <xsl:with-param name="presdata" select="$PresData"/>
			 <xsl:with-param name="choice_name">NonCustomerBO.accessOwnerGroup</xsl:with-param>
			 <xsl:with-param name="onchangefn">setAccessOwnerGroup();</xsl:with-param>
		     </xsl:call-template>
	 </xsl:template>

	 <xsl:template name="NonCustomerBO.accessOwnerSegment">
		     <xsl:call-template name="mdrpdown">
			 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.accessOwnerSegment']"/>
			 <xsl:with-param name="selectname">NonCustomerBO.accessOwnerSegment</xsl:with-param>
			 <xsl:with-param name="selectdisp">NonCustomerBO.accessOwnerSegment</xsl:with-param>
			 <xsl:with-param name="presdata" select="$PresData"/>
			 <xsl:with-param name="search_type">value</xsl:with-param>
			 <xsl:with-param name="choice_name">NonCustomerBO.accessOwnerSegment</xsl:with-param>
		     </xsl:call-template>
	</xsl:template>

	<xsl:template name="NonCustomerBO.accessOwnerBC">
		<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.accessOwnerBC']"/>

			<xsl:with-param name="elename">NonCustomerBO.accessOwnerBC</xsl:with-param>
			<xsl:with-param name="eleval">NonCustomerBO.accessOwnerBC</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="buttonone_name" ><xsl:value-of select="$configLabels[@name='LOOKUP']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="buttontwo_name" ><xsl:value-of select="$configLabels[@name='CLEAR']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			<!--xsl:with-param name="buttonone_fnc">openBCCodeLookup('accessOwnerBC')</xsl:with-param-->
			<xsl:with-param name="buttonone_fnc">fnBlurFunctionNon('BusinessCenter')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">setBCCodeValues('accessOwnerBC','','')</xsl:with-param>

		</xsl:call-template>
	</xsl:template>

	<!--End of changes-->

        <xsl:template name="NonCustomerBO.HomeAddState">
	<xsl:call-template name="lookup">
	        <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.HomeAddState']"/>
	        <xsl:with-param name="elename">NonCustomerBO.HomeAddState</xsl:with-param>
	        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.HomeAddState</xsl:with-param>
	        <xsl:with-param name="idval">homeAdd</xsl:with-param>
	        <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
	        <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	        <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>

				 <!-- vasanth's changes start-->

				<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('STATE', 'NonCustomerBO.HomeAddState','HomeAddState_code','NonCustomerBO.HomeAddCity','NonCustomerBO.HomeAddCountry')</xsl:with-param>
				<xsl:with-param name="buttontwo_fnc">clearLocValue('NonCustomerBO.HomeAddState','STATE','NonCustomerBO.HomeAddCity')</xsl:with-param>

				<!--<xsl:with-param name="buttonone_fnc">categoryLookupCode('STATE', 'NonCustomerBO.HomeAddState','HomeAddState_code')</xsl:with-param>
				<xsl:with-param name="buttontwo_fnc">clearCategoryValue('NonCustomerBO.HomeAddState')</xsl:with-param>-->

				 <!-- vasanth's changes end-->

        	<xsl:with-param name="checkASCII">false</xsl:with-param>
        </xsl:call-template>
	<input type="hidden" name="HomeAddState_code" value="{$HomeAddState_code}"/>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.HomeAddCountry">
		<xsl:call-template name="lookup">
			        <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.HomeAddCountry']"/>
			        <xsl:with-param name="elename">NonCustomerBO.HomeAddCountry</xsl:with-param>
			        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.HomeAddCountry</xsl:with-param>
			        <xsl:with-param name="idval">homeAdd</xsl:with-param>
			        <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
		       		 <!-- Field Rationalization changes start-->
        			<xsl:with-param name="code_req">true</xsl:with-param>
       				 <!-- Field Rationalization changes end-->
			        <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			        <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>

						 <!-- vasanth's changes start-->

						 <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('COUNTRY', 'NonCustomerBO.HomeAddCountry','HomeAddCountry_code','NonCustomerBO.HomeAddState','NonCustomerBO.HomeAddCity')</xsl:with-param>
						<xsl:with-param name="buttontwo_fnc">clearLocValue('NonCustomerBO.HomeAddCountry','COUNTRY','NonCustomerBO.HomeAddState','NonCustomerBO.HomeAddCity')</xsl:with-param>

						<!--<xsl:with-param name="buttonone_fnc">categoryLookupCode('COUNTRY', 'NonCustomerBO.HomeAddCountry','HomeAddCountry_code')</xsl:with-param>
						<xsl:with-param name="buttontwo_fnc">clearCategoryValue('NonCustomerBO.HomeAddCountry')</xsl:with-param>-->

						<!-- vasanth's changes end-->

	       			<xsl:with-param name="checkASCII">false</xsl:with-param>
	        </xsl:call-template>
	<input type="hidden" name="HomeAddCountry_code" value="{$HomeAddCountry_code}"/>
	</xsl:template>

        <xsl:template name="NonCustomerBO.HomeAddPinCode">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.HomeAddPinCode']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.HomeAddPinCode</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.HomeAddPinCode</xsl:with-param>
			                   <xsl:with-param name="idval">homeAdd</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>


        <xsl:template name="NonCustomerBO.EMailAdd">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.EMailAdd']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.EMailAdd</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.EMailAdd</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

 	<xsl:template name="NonCustomerBO.Work_house_no">
 	               <xsl:call-template name="label">
 	                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Work_house_no']"/>
 	                   <xsl:with-param name="ele_name">NonCustomerBO.Work_house_no</xsl:with-param>
 	                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Work_house_no</xsl:with-param>
 	                   <xsl:with-param name="idval">workAdd</xsl:with-param>
 	               </xsl:call-template>
         </xsl:template>

         <xsl:template name="NonCustomerBO.Work_premise_name">
 			               <xsl:call-template name="label">
 			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Work_premise_name']"/>
 			                   <xsl:with-param name="ele_name">NonCustomerBO.Work_premise_name</xsl:with-param>
 			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Work_premise_name</xsl:with-param>
 			                   <xsl:with-param name="idval">workAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
 			               </xsl:call-template>
 		        </xsl:template>

         <xsl:template name="NonCustomerBO.Work_building_level">
 			               <xsl:call-template name="label">
 			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Work_building_level']"/>
 			                   <xsl:with-param name="ele_name">NonCustomerBO.Work_building_level</xsl:with-param>
 			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Work_building_level</xsl:with-param>
 			                   <xsl:with-param name="idval">workAdd</xsl:with-param>
 			               </xsl:call-template>
 		        </xsl:template>

         <xsl:template name="NonCustomerBO.Work_street_no">
 			               <xsl:call-template name="label">
 			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Work_street_no']"/>
 			                   <xsl:with-param name="ele_name">NonCustomerBO.Work_street_no</xsl:with-param>
 			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Work_street_no</xsl:with-param>
 			                   <xsl:with-param name="idval">workAdd</xsl:with-param>
 			               </xsl:call-template>
 		        </xsl:template>

         <xsl:template name="NonCustomerBO.Work_street_name">
 			               <xsl:call-template name="label">
 			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Work_street_name']"/>
 			                   <xsl:with-param name="ele_name">NonCustomerBO.Work_street_name</xsl:with-param>
 			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Work_street_name</xsl:with-param>
 			                   <xsl:with-param name="idval">workAdd</xsl:with-param>
 			                   <xsl:with-param name="checkASCII">false</xsl:with-param>
 			               </xsl:call-template>
 		        </xsl:template>

         <xsl:template name="NonCustomerBO.Work_suburb">
 			               <xsl:call-template name="label">
 			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Work_suburb']"/>
 			                   <xsl:with-param name="ele_name">NonCustomerBO.Work_suburb</xsl:with-param>
 			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Work_suburb</xsl:with-param>
 			                   <xsl:with-param name="idval">workAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
 			               </xsl:call-template>
 		        </xsl:template>

         <xsl:template name="NonCustomerBO.Work_locality_name">
 			               <xsl:call-template name="label">
 			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Work_locality_name']"/>
 			                   <xsl:with-param name="ele_name">NonCustomerBO.Work_locality_name</xsl:with-param>
 			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Work_locality_name</xsl:with-param>
 			                   <xsl:with-param name="idval">workAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
 			               </xsl:call-template>
 		        </xsl:template>

         <xsl:template name="NonCustomerBO.Work_town">
 			               <xsl:call-template name="label">
 			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Work_town']"/>
 			                   <xsl:with-param name="ele_name">NonCustomerBO.Work_town</xsl:with-param>
 			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Work_town</xsl:with-param>
 			                   <xsl:with-param name="idval">workAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
 			               </xsl:call-template>
 		        </xsl:template>

         <xsl:template name="NonCustomerBO.Work_domicile">
 			               <xsl:call-template name="label">
 			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Work_domicile']"/>
 			                   <xsl:with-param name="ele_name">NonCustomerBO.Work_domicile</xsl:with-param>
 			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Work_domicile</xsl:with-param>
 			                   <xsl:with-param name="idval">workAdd</xsl:with-param>
 			                   <xsl:with-param name="checkASCII">false</xsl:with-param>
 			               </xsl:call-template>
 		        </xsl:template>

         <xsl:template name="NonCustomerBO.WorkAddCity">
 			<xsl:call-template name="lookup">
				        <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.WorkAddCity']"/>
				        <xsl:with-param name="elename">NonCustomerBO.WorkAddCity</xsl:with-param>
				        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.WorkAddCity</xsl:with-param>
				        <xsl:with-param name="idval">workAdd</xsl:with-param>
				        <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
				        <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
				        <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>

         		         <!-- vasanth's changes start-->

         		           <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('CITY', 'NonCustomerBO.WorkAddCity','WorkAddCity_code','NonCustomerBO.WorkAddState','NonCustomerBO.WorkAddCountry')</xsl:with-param>
		       		       <xsl:with-param name="buttontwo_fnc">clearLocValue('NonCustomerBO.WorkAddCity','CITY')</xsl:with-param>

				        <!--<xsl:with-param name="buttonone_fnc">categoryLookupCode('CITY', 'NonCustomerBO.WorkAddCity','WorkAddCity_code')</xsl:with-param>
				        <xsl:with-param name="buttontwo_fnc">clearCategoryValue('NonCustomerBO.WorkAddCity')</xsl:with-param>-->

		       		     <!-- vasanth's changes end-->
				        <xsl:with-param name="checkASCII">false</xsl:with-param>
          		</xsl:call-template>
		<input type="hidden" name="WorkAddCity_code" value="{$WorkAddCity_code}"/>
 		        </xsl:template>

         <xsl:template name="NonCustomerBO.WorkAddState">
	<xsl:call-template name="lookup">
	        <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.WorkAddState']"/>
	        <xsl:with-param name="elename">NonCustomerBO.WorkAddState</xsl:with-param>
	        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.WorkAddState</xsl:with-param>
	        <xsl:with-param name="idval">workAdd</xsl:with-param>
	        <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
	        <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	        <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>

         		         <!-- vasanth's changes start-->

         		        <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('STATE', 'NonCustomerBO.WorkAddState','WorkAddState_code','NonCustomerBO.WorkAddCity','NonCustomerBO.WorkAddCountry')</xsl:with-param>
		       	        <xsl:with-param name="buttontwo_fnc">clearLocValue('NonCustomerBO.WorkAddState','STATE','NonCustomerBO.WorkAddCity')</xsl:with-param>

						<!--<xsl:with-param name="buttonone_fnc">categoryLookupCode('STATE', 'NonCustomerBO.WorkAddState','WorkAddState_code')</xsl:with-param>
						<xsl:with-param name="buttontwo_fnc">clearCategoryValue('NonCustomerBO.WorkAddState')</xsl:with-param>-->

         		         <!-- vasanth's changes end-->
        	<xsl:with-param name="checkASCII">false</xsl:with-param>
        </xsl:call-template>
	<input type="hidden" name="WorkAddState_code" value="{$WorkAddState_code}"/>
 		        </xsl:template>

         <xsl:template name="NonCustomerBO.WorkAddCountry">
 			              <xsl:call-template name="lookup">
				              <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.WorkAddCountry']"/>
				              <xsl:with-param name="elename">NonCustomerBO.WorkAddCountry</xsl:with-param>
				              <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.WorkAddCountry</xsl:with-param>
				              <xsl:with-param name="idval">workAdd</xsl:with-param>
				              <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
				               <!-- Field Rationalization changes start-->
  					       <xsl:with-param name="code_req">true</xsl:with-param>
     					       <!-- Field Rationalization changes end-->
				              <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
						<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>

         		         <!-- vasanth's changes start-->

         		         <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('COUNTRY', 'NonCustomerBO.WorkAddCountry','WorkAddCountry_code','NonCustomerBO.WorkAddState','NonCustomerBO.WorkAddCity')</xsl:with-param>
		       	        <xsl:with-param name="buttontwo_fnc">clearLocValue('NonCustomerBO.WorkAddCountry','COUNTRY','NonCustomerBO.WorkAddState','NonCustomerBO.WorkAddCity')</xsl:with-param>

						<!--<xsl:with-param name="buttonone_fnc">categoryLookupCode('COUNTRY', 'NonCustomerBO.WorkAddCountry','WorkAddCountry_code')</xsl:with-param>
						<xsl:with-param name="buttontwo_fnc">clearCategoryValue('NonCustomerBO.WorkAddCountry')</xsl:with-param>-->

						<!-- vasanth's changes end-->

				              <xsl:with-param name="checkASCII">false</xsl:with-param>
       					 </xsl:call-template>
	<input type="hidden" name="WorkAddCountry_code" value="{$WorkAddCountry_code}"/>
 		        </xsl:template>

         <xsl:template name="NonCustomerBO.WorkAddPinCode">
 			               <xsl:call-template name="label">
 			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.WorkAddPinCode']"/>
 			                   <xsl:with-param name="ele_name">NonCustomerBO.WorkAddPinCode</xsl:with-param>
 			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.WorkAddPinCode</xsl:with-param>
 			                   <xsl:with-param name="idval">workAdd</xsl:with-param>
 			               </xsl:call-template>
 		        </xsl:template>



<!-- 		<xsl:template name="NonCustomerBO.Mailing_house_no">
	               <xsl:call-template name="label">
	                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Mailing_house_no']"/>
	                   <xsl:with-param name="ele_name">NonCustomerBO.Mailing_house_no</xsl:with-param>
	                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Mailing_house_no</xsl:with-param>
	                   <xsl:with-param name="idval">mailingAdd</xsl:with-param>
	               </xsl:call-template>
        </xsl:template>

        <xsl:template name="NonCustomerBO.Mailing_premise_name">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Mailing_premise_name']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Mailing_premise_name</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Mailing_premise_name</xsl:with-param>
			                   <xsl:with-param name="idval">mailingAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Mailing_building_level">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Mailing_building_level']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Mailing_building_level</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Mailing_building_level</xsl:with-param>
			                   <xsl:with-param name="idval">mailingAdd</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Mailing_street_no">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Mailing_street_no']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Mailing_street_no</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Mailing_street_no</xsl:with-param>
			                   <xsl:with-param name="idval">mailingAdd</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Mailing_street_name">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Mailing_street_name']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Mailing_street_name</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Mailing_street_name</xsl:with-param>
			                   <xsl:with-param name="idval">mailingAdd</xsl:with-param>
			                   <xsl:with-param name="checkASCII">false</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Mailing_suburb">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Mailing_suburb']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Mailing_suburb</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Mailing_suburb</xsl:with-param>
			                   <xsl:with-param name="idval">mailingAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Mailing_locality_name">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Mailing_locality_name']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Mailing_locality_name</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Mailing_locality_name</xsl:with-param>
			                   <xsl:with-param name="idval">mailingAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Mailing_town">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Mailing_town']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Mailing_town</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Mailing_town</xsl:with-param>
			                   <xsl:with-param name="idval">mailingAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.Mailing_domicile">
			               <xsl:call-template name="label">
			                   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Mailing_domicile']"/>
			                   <xsl:with-param name="ele_name">NonCustomerBO.Mailing_domicile</xsl:with-param>
			                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Mailing_domicile</xsl:with-param>
			                   <xsl:with-param name="idval">mailingAdd</xsl:with-param>
							   <xsl:with-param name="checkASCII">false</xsl:with-param>
			               </xsl:call-template>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.MailingAddCity">
		<xsl:call-template name="lookup">
			        <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.MailingAddCity']"/>
			        <xsl:with-param name="elename">NonCustomerBO.MailingAddCity</xsl:with-param>
			        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MailingAddCity</xsl:with-param>
			        <xsl:with-param name="idval">mailingAdd</xsl:with-param>
			        <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
			        <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			        <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>

				   <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('CITY', 'NonCustomerBO.MailingAddCity','MailAddCity_code','NonCustomerBO.MailingAddState','NonCustomerBO.MailingAddCountry')</xsl:with-param>
				   <xsl:with-param name="buttontwo_fnc">clearLocValue('NonCustomerBO.MailingAddCity','CITY')</xsl:with-param>

			        <xsl:with-param name="checkASCII">false</xsl:with-param>
            		</xsl:call-template>
	<input type="hidden" name="MailAddCity_code" value="{$MailAddCity_code}"/>
		        </xsl:template>

        <xsl:template name="NonCustomerBO.MailingAddState">
		<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.MailingAddState']"/>
			<xsl:with-param name="elename">NonCustomerBO.MailingAddState</xsl:with-param>
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MailingAddState</xsl:with-param>
			<xsl:with-param name="idval">mailingAdd</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>

				<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('STATE', 'NonCustomerBO.MailingAddState','MailAddState_code','NonCustomerBO.MailingAddCity','NonCustomerBO.MailingAddCountry')</xsl:with-param>
				<xsl:with-param name="buttontwo_fnc">clearLocValue('NonCustomerBO.MailingAddState','STATE','NonCustomerBO.MailingAddCity')</xsl:with-param>

			<xsl:with-param name="checkASCII">false</xsl:with-param>
        	</xsl:call-template>
	<input type="hidden" name="MailAddState_code" value="{$MailAddState_code}"/>
	</xsl:template>

        <xsl:template name="NonCustomerBO.MailingAddCountry">
		<xsl:call-template name="lookup">
		        <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.MailingAddCountry']"/>
		        <xsl:with-param name="elename">NonCustomerBO.MailingAddCountry</xsl:with-param>
		        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MailingAddCountry</xsl:with-param>
		        <xsl:with-param name="idval">mailingAdd</xsl:with-param>
		        <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
		        <xsl:with-param name="code_req">true</xsl:with-param>
		        <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		        <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>


				 <xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('COUNTRY', 'NonCustomerBO.MailingAddCountry','MailAddCountry_code','NonCustomerBO.MailingAddState','NonCustomerBO.MailingAddCity')</xsl:with-param>
				<xsl:with-param name="buttontwo_fnc">clearLocValue('NonCustomerBO.MailingAddCountry','COUNTRY','NonCustomerBO.MailingAddState','NonCustomerBO.MailingAddCity')</xsl:with-param>

		        <xsl:with-param name="checkASCII">false</xsl:with-param>
        	</xsl:call-template>
	<input type="hidden" name="MailAddCountry_code" value="{$MailAddCountry_code}"/>
	 </xsl:template>

        <xsl:template name="NonCustomerBO.MailingAddPinCode">
		<xsl:call-template name="label">
			   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.MailingAddPinCode']"/>
			   <xsl:with-param name="ele_name">NonCustomerBO.MailingAddPinCode</xsl:with-param>
			   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MailingAddPinCode</xsl:with-param>
			   <xsl:with-param name="idval">mailingAdd</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
 -->
<!--  RefCode Changes	-->
            <xsl:template name="NonCustomerBO.Legal_Status">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.LegalStatus_code']"/>
                            <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.Legal_Status</xsl:with-param>
                            <xsl:with-param name="selectdisp">NonCustomerBO.LegalStatus_code</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.LegalStatus_code</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                            <xsl:with-param name="choice_name">NonCustomerBO.LegalStatus_code</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>
        <xsl:template name="NonCustomerBO.LineOfActivity">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.LineOfActivity_code']"/>
                            <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.LineOfActivity</xsl:with-param>
                            <xsl:with-param name="selectdisp">NonCustomerBO.LineOfActivity_code</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.LineOfActivity_code</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                            <xsl:with-param name="choice_name">NonCustomerBO.LineOfActivity_code</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>

<!--  RefCode Changes	-->
<!--Native Language Fields:start-->
<xsl:template name="NonCustomerBO.First_Name_Native">
	       <xsl:call-template name="label">
		   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.First_Name_Native']"/>
		   <xsl:with-param name="ele_name">NonCustomerBO.First_Name_Native</xsl:with-param>
		   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.First_Name_Native</xsl:with-param>
		   <!--<xsl:with-param name="idval">workAdd</xsl:with-param>-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	       </xsl:call-template>
</xsl:template>
<xsl:template name="NonCustomerBO.Middle_Name_Native">
	       <xsl:call-template name="label">
		   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Middle_Name_Native']"/>
		   <xsl:with-param name="ele_name">NonCustomerBO.Middle_Name_Native</xsl:with-param>
		   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Middle_Name_Native</xsl:with-param>
		   <!--<xsl:with-param name="idval">workAdd</xsl:with-param>-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	       </xsl:call-template>
</xsl:template>
<xsl:template name="NonCustomerBO.Last_Name_Native">
	       <xsl:call-template name="label">
		   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Last_Name_Native']"/>
		   <xsl:with-param name="ele_name">NonCustomerBO.Last_Name_Native</xsl:with-param>
		   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Last_Name_Native</xsl:with-param>
		   <!--<xsl:with-param name="idval">workAdd</xsl:with-param>-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	       </xsl:call-template>
</xsl:template>
<xsl:template name="NonCustomerBO.First_Name_Native1">
	       <xsl:call-template name="label">
		   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.First_Name_Native1']"/>
		   <xsl:with-param name="ele_name">NonCustomerBO.First_Name_Native1</xsl:with-param>
		   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.First_Name_Native1</xsl:with-param>
		   <!--<xsl:with-param name="idval">workAdd</xsl:with-param>-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	       </xsl:call-template>
</xsl:template>
<xsl:template name="NonCustomerBO.Middle_Name_Native1">
	       <xsl:call-template name="label">
		   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Middle_Name_Native1']"/>
		   <xsl:with-param name="ele_name">NonCustomerBO.Middle_Name_Native1</xsl:with-param>
		   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Middle_Name_Native1</xsl:with-param>
		   <!--<xsl:with-param name="idval">workAdd</xsl:with-param>-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	       </xsl:call-template>
</xsl:template>
<xsl:template name="NonCustomerBO.Last_Name_Native1">
	       <xsl:call-template name="label">
		   <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Last_Name_Native1']"/>
		   <xsl:with-param name="ele_name">NonCustomerBO.Last_Name_Native1</xsl:with-param>
		   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Last_Name_Native1</xsl:with-param>
		   <!--<xsl:with-param name="idval">workAdd</xsl:with-param>-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	       </xsl:call-template>
</xsl:template>
<!--Native Language Fields:end-->


        <xsl:template name="NonCustomerBO.Currency_code">
	            <xsl:call-template name="mdrpdown">
	                <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Currency_code']"/>
	                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Currency_code</xsl:with-param>
	                <xsl:with-param name="selectdisp">NonCustomerBO.Currency_code</xsl:with-param>
	                <xsl:with-param name="search_type">value</xsl:with-param>
	                <xsl:with-param name="choice_name">NonCustomerBO.Currency_code</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
	            </xsl:call-template>
        </xsl:template>

	<!-- CIF PhoneEmail Changes : Start -->
	<xsl:template name="NonCustomerBO.Address.preferredAddress">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.Address.preferredAddress']"/>
		<xsl:with-param name="selectname">NonCustomerBO.Address.preferredAddress</xsl:with-param>
		<xsl:with-param name="selectdisp">NonCustomerBO.Address.preferredAddress</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<!-- Changes for Tracker id: 292525 starts -->
		<xsl:with-param name="defaultValue"><xsl:value-of select="$defAddress"/></xsl:with-param>
                <!-- Changes for Tracker id: 292525 ends -->
         	<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="NonCustomerBO.PhoneEmail.PhoneEmailType">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='PREFERRED_PHONE']"/>
		<xsl:with-param name="selectname">NonCustomerBO.PhoneEmail.PhoneEmailType</xsl:with-param>
		<xsl:with-param name="selectdisp">NonCustomerBO.PhoneEmail.PhoneEmailType</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
         	<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="NonCustomerBO.PhoneEmail.PhoneEmailType1">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='PREFERRED_EMAIL']"/>
		<xsl:with-param name="selectname">NonCustomerBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
		<xsl:with-param name="selectdisp">NonCustomerBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
         	<xsl:with-param name="presdata" select="$PresData"/>
         	<xsl:with-param name="starshow">true</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!-- CIF PhoneEmail Changes : End -->

	<xsl:template name="NonCustomerBO.AccessOwnerGroup">
		 <xsl:call-template name="mdrpdown">
			 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.ACCESSOWNERGROUP']"/>
			 <xsl:with-param name="selectname">NonCustomerBO.ACCESSOWNERGROUP</xsl:with-param>
			 <xsl:with-param name="selectdisp">NonCustomerBO.ACCESSOWNERGROUP</xsl:with-param>
			 <xsl:with-param name="search_type">value</xsl:with-param>
			 <xsl:with-param name="choice_name">NonCustomerBO.ACCESSOWNERGROUP</xsl:with-param>
				 <xsl:with-param name="onchangefn">setAccessOwnerGroup();</xsl:with-param>
			 <!-- CIF Changes for Caching Views : Start -->
			 <xsl:with-param name="presdata" select="$PresData"/>
			 <!-- CIF Changes for Caching Views : End -->

		 </xsl:call-template>
	 </xsl:template>

	 <xsl:template name="NonCustomerBO.AccessOwnerSegment">
		 <xsl:call-template name="mdrpdown">
			 <xsl:with-param name="res_name" select="$configLabels[@name='NonCustomerBO.AccessOwnerSegment']"/>
			 <xsl:with-param name="selectname">NonCustomerBO.AccessOwnerSegment</xsl:with-param>
			 <xsl:with-param name="selectdisp">NonCustomerBO.AccessOwnerSegment</xsl:with-param>
			 <xsl:with-param name="search_type">value</xsl:with-param>
			 <xsl:with-param name="choice_name">NonCustomerBO.AccessOwnerSegment</xsl:with-param>
			 <!-- CIF Changes for Caching Views : Start -->
			 <xsl:with-param name="presdata" select="$PresData"/>
			 <!-- CIF Changes for Caching Views : End -->

		 </xsl:call-template>
	</xsl:template>

	<xsl:template match="*" mode="mode1">
        <form name="frm2"  method="post" >
        <!--Tracker id 113227 changes start-->
	<input type="hidden" name="altLocaleActv" />
 	<!--Tracker id 113227 changes end-->
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
	<input name="IsAddressVerified" type="hidden" value=""/>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
        <input type="hidden" name="hid_NonCustomerURL" value="{$nonCustURL}"/>
        <input type="hidden" name="hid_concurDetectX" value="{$concurDetectX}"/>
	<!-- KeyGeneration start -->
		<!--Ticket 349330 changes start-->
	<IFRAME name="hdifrm_rescifid" width="0" height="0" src="../common/html/SSOblank.html"/>
		<!--Ticket 349330 changes end-->
	<input type="hidden" name="hid_cifid" value=""/>
	<input type="hidden" name="hid_reservestatus" value=""/>
	<!-- KeyGeneration end -->
<!--commented for IDENTIFICATION DOCUMENT CHANGES start
        <input type="hidden" name="IdentDetailID" value=""/>
        <input type="hidden" name="identifierType" value=""/>
	<input type="hidden" name="ID" value=""/>
	<input type="hidden" name="dateOfIssue" value=""/>
	<input type="hidden" name="validityDate" value=""/>
	<input type="hidden" name="placeOfIssue" value=""/>
	<input type="hidden" name="string1" value=""/>
	<input type="hidden" name="string2" value=""/>
	<input type="hidden" name="string3" value=""/>
	<input type="hidden" name="int1" value=""/>
	<input type="hidden" name="int2" value=""/>
	<input type="hidden" name="int3" value=""/>
	<input type="hidden" name="date1" value=""/>
	<input type="hidden" name="date2" value=""/>
	<input type="hidden" name="date3" value=""/>
commented for IDENTIFICATION DOCUMENT CHANGES end-->
<!--CRM ALERT CHANGES STARTS-->

	<input type="hidden" name="DefaultChannel_Alert" value=""/>
         <input type="hidden" name="PreferredAlert" value=""/>

<!--CRM ALERT CHANGES ENDS-->
	<input type="hidden" name="accID" value=""/>
	<input type="hidden" name="AddressFields" value=""/>
	<input type="hidden" name="OtherTFFields" value=""/>
	<input type="hidden" name="CoreCustID" value=""/>
	<input type="hidden" name="Name" value=""/>
	<input type="hidden" name="isTFLoaded" value="false"/>
   	<input type="hidden" value="{$isAutoGenKey}" name="isAutoGenKey"/>
   	<input type="hidden" name="hreadOnly" value="{$readMode}"/>	<!-- changes for multirec readonly  -->

        <input type="hidden" name="boName" value="{$boName}"/>
        <input type="hidden" name="apprFlag" value="{$apprFlag}"/>
        <!-- Save and Submit Passing the operationType & saveFlag to the Writer : Start  -->
        <input type="hidden" name="operationType" value="{$operationType}"/>
        <input type="hidden" name="saveFlag" value=""/>
        <input type="hidden" name="isCopy" value="{$isCopy}"/>
        <!-- Save and Submit Passing the operationType & saveFlag to the Writer: End  -->
        <input type="hidden" name="NonCustomerID" value="{$nonCustID}"/>
        <input type="hidden" name="NonCustomerKey" value=""/>
	<!-- Core Fields Inclusion -->
	<input type="hidden" name="Home_Addr1" value=""/>
	<input type="hidden" name="Work_Addr1" value=""/>
	<input type="hidden" name="Home_Addr2" value=""/>
	<input type="hidden" name="Work_Addr2" value=""/>
	<input type="hidden" name="CurrencyCode" value=""/>
<!--commented for IDENTIFICATION DOCUMENT CHANGES start
	<input type="hidden" name="CountryOfIssue" value=""/>
	<input type="hidden" name="CountryOfIssue_code" value=""/>
	<input type="hidden" name="PlaceOfIssue_code" value=""/>
	<input type="hidden" name="IdentifierType_code" value=""/>
	<input type="hidden" name="String1_code" value=""/>
	<input type="hidden" name="Core_cust_id" value=""/>
commented for IDENTIFICATION DOCUMENT CHANGES end-->
	<!-- Core Fields Inclusion -->
		<!-- Hidden variables for identification tab end-->
<!--IDENTIFICATION DOCUMENT CHANGES start-->
		<input type="hidden" name="SSN.txt_ID"/>
		<input type="hidden" name="SSN.txt_Issue_Date"/>
		<input type="hidden" name="SSN.txt_Valid_Date"/>
		<input type="hidden" name="SSN.txt_Issue_Place"/>
		<input type="hidden" name="PAN.txt_ID"/>
		<input type="hidden" name="PAN.txt_Issue_Date"/>
		<input type="hidden" name="PAN.txt_Valid_Date"/>
		<input type="hidden" name="PAN.txt_Issue_Place"/>
		<!-- TRACKER ID: 113279 Begins -->
		<!-- changes for adhar for tracker 375136 starts -->
		<input type="hidden" name="Unique Identification Number.txt_ID"/>
		<input type="hidden" name="Unique Identification Number.txt_Issue_Date"/>
		<input type="hidden" name="Unique Identification Number.txt_Valid_Date"/>
		<input type="hidden" name="Unique Identification Number.txt_Issue_Place"/>
		<!-- changes for adhar for tracker 375136 ends -->
		<input type="hidden" name="IDTypeR1.txt_ID"/>
		<input type="hidden" name="IDTypeR1.txt_Issue_Date"/>
		<input type="hidden" name="IDTypeR1.txt_Valid_Date"/>
		<input type="hidden" name="IDTypeR1.txt_Issue_Place"/>
		<input type="hidden" name="IDTypeR2.txt_ID"/>
		<input type="hidden" name="IDTypeR2.txt_Issue_Date"/>
		<input type="hidden" name="IDTypeR2.txt_Valid_Date"/>
		<input type="hidden" name="IDTypeR2.txt_Issue_Place"/>
		<input type="hidden" name="IDTypeR3.txt_ID"/>
		<input type="hidden" name="IDTypeR3.txt_Issue_Date"/>
		<input type="hidden" name="IDTypeR3.txt_Valid_Date"/>
		<input type="hidden" name="IDTypeR3.txt_Issue_Place"/>
		<input type="hidden" name="IDTypeR4.txt_ID"/>
		<input type="hidden" name="IDTypeR4.txt_Issue_Date"/>
		<input type="hidden" name="IDTypeR4.txt_Valid_Date"/>
		<input type="hidden" name="IDTypeR4.txt_Issue_Place"/>
		<input type="hidden" name="IDTypeR5.txt_ID"/>
		<input type="hidden" name="IDTypeR5.txt_Issue_Date"/>
		<input type="hidden" name="IDTypeR5.txt_Valid_Date"/>
		<input type="hidden" name="IDTypeR5.txt_Issue_Place"/>
		<!-- TRACKER ID: 113279 Ends -->
		<input type="hidden" name="unique_id" value=""/>
		<input type="hidden" name="dateofissue" value=""/>
		<input type="hidden" name="validity_date" value=""/>
		<input type="hidden" name="IDRemoved" value=""/>
		<input type="hidden" name="hidEntityDocumentID" value=""/>
		<input type="hidden" name="hidEntityDocumentURL" value=""/>
		<input type="hidden" name="hidDocCode" value=""/>
		<input type="hidden" name="hidDocDescr" value=""/>
		<input type="hidden" name="hidDocTypeCode" value=""/>
		<input type="hidden" name="hidDocTypeDescr" value=""/>
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
		<!--408052	changes starts-->
		<input type="hidden" name="hidIsPreferredDocCode" value=""/>
		<!--408052	changes ends-->

			<!-- Hidden variables for identification tab end-->
        <!-- CIF PhoneEmail Changes : Start -->
       <input type="hidden" name="mainAccId" value=""/>
       <!-- Hidden variables for address tab begin-->
       <input type="hidden" name="address_type" value=""/>
       <input type="hidden" name="screenname" value="CIF"/>
       <input type="hidden" name="houseno" value=""/>
       <input type="hidden" name="premiseno" value=""/>
       <input type="hidden" name="building" value=""/>
       <input type="hidden" name="country" value=""/>
       <input type="hidden" name="city" value=""/>
       <input type="hidden" name="state" value=""/>
       <input type="hidden" name="start_date" value=""/>
       <input type="hidden" name="zip" value=""/>
       <input type="hidden" name="end_date" value=""/>
       <input type="hidden" name="LastUpdate_Date" value=""/>
       <input type="hidden" name="addrID" value=""/>
       <input type="hidden" name="streetno" value=""/>
       <input type="hidden" name="town" value=""/>
       <input type="hidden" name="locality" value=""/>
       <input type="hidden" name="domicile" value=""/>
       <input type="hidden" name="website" value=""/>
       <input type="hidden" name="mailstop" value=""/>
       <input type="hidden" name="streetname" value=""/>
       <input type="hidden" name="suburb" value=""/>
       <input type="hidden" name="hidSt" value=""/>
       <input type="hidden" name="AdrRemoved" value=""/>

<!-- changes for Tracker ID 456637 - TOL ID 455246 -->
	<input type="hidden" name="vAddTypeLT" value=""/>
<!-- changes for Tracker ID 456637 - TOL ID 455246 -->
        <input type="hidden" name="extension" value=""/>
        <input type="hidden" name="eduURL" value=""/>
        <input type="hidden" name="EduRemoved" value=""/>
<!--         <input type="hidden" name="accountID" value="{$accountID}"/> -->
        <input type="hidden" name="newHouseVal" value=""/>
        <input type="hidden" name="country_code" value=""/>
        <input type="hidden" name="state_code" value=""/>
        <input type="hidden" name="city_code" value=""/>
        <input type="hidden" name="core_cust_id" value=""/>
        <input type="hidden" name="salutation_code" value=""/>
        <input type="hidden" name="name" value=""/>
<!--         <input type="hidden" name="isTFFlag" value="{$tfpartyFlag}"/> -->
        <input type="hidden" name="MLUSERFIELD1" value=""/>
        <input type="hidden" name="MLUSERFIELD2" value=""/>
        <input type="hidden" name="MLUSERFIELD3" value=""/>
	<input type="hidden" name="MLUSERFIELD4" value=""/>
	<input type="hidden" name="MLUSERFIELD5" value=""/>
	<input type="hidden" name="MLUSERFIELD6" value=""/>
	<input type="hidden" name="MLUSERFIELD7" value=""/>
	<input type="hidden" name="MLUSERFIELD8" value=""/>
	<input type="hidden" name="MLUSERFIELD9" value=""/>
	<input type="hidden" name="MLUSERFIELD10" value=""/>
	<input type="hidden" name="MLUSERFIELD11" value=""/>
	<input type="hidden" name="MLUSERFIELD12" value=""/>
	<input type="hidden" name="MLUSERFIELD13" value=""/>
	<input type="hidden" name="MLUSERFIELD14" value=""/>
	<input type="hidden" name="MLUSERFIELD15" value=""/>
	<input type="hidden" name="MLUSERFIELD16" value=""/>
	<input type="hidden" name="MLUSERFIELD17" value=""/>
	<input type="hidden" name="MLUSERFIELD18" value=""/>
	<input type="hidden" name="MLUSERFIELD19" value=""/>
	<input type="hidden" name="MLUSERFIELD20" value=""/>
	<input type="hidden" name="MLUSERFIELD21" value=""/>
	<input type="hidden" name="MLUSERFIELD22" value=""/>
	<input type="hidden" name="MLUSERFIELD23" value=""/>
	<input type="hidden" name="MLUSERFIELD24" value=""/>
	<input type="hidden" name="MLUSERFIELD25" value=""/>
	<input type="hidden" name="MLUSERFIELD26" value=""/>
	<input type="hidden" name="MLUSERFIELD27" value=""/>
	<input type="hidden" name="MLUSERFIELD28" value=""/>
	<input type="hidden" name="MLUSERFIELD29" value=""/>
	<input type="hidden" name="MLUSERFIELD30" value=""/>
	<input type="hidden" name="PreferredFormat" value=""/>
	<input type="hidden" name="HoldMailReason" value=""/>
	<input type="hidden" name="BusinessCenter" value=""/>
	<input type="hidden" name="HoldMailInitiatedBy" value=""/>
	<input type="hidden" name="HoldMailFlag" value=""/>
<!-- AdressLine changes: START -->
	<input type="hidden" name="AddressLine1" value=""/>
	<input type="hidden" name="AddressLine2" value=""/>
	<input type="hidden" name="AddressLine3" value=""/>
<!-- AdressLine changes: END -->
	<input type="hidden" name="FreeTextLabel" value=""/>
	<input type="hidden" name="PhoneOrEmail" value=""/>
	<input type="hidden" name="PhoneNoCountryCode" value=""/>
	<input type="hidden" name="PhoneNoCityCode" value=""/>
	<input type="hidden" name="PhoneNoLocalCode" value=""/>
	<input type="hidden" name="PhoneNo" value=""/>
	<input type="hidden" name="PhoneEmailID" value=""/>
	<input type="hidden" name="PhoneEmailType" value=""/>
	<input type="hidden" name="Email" value=""/>
<!-- 		<input type="hidden" name="EmailPalm" value=""/> -->
	<input type="hidden" name="PhoneEmailRemoved" value=""/>
	<input type="hidden" name="PreferredAddress" value=""/>
	<input type="hidden" name="PreferredPhone" value=""/>
	<input type="hidden" name="PreferredEmail" value=""/>
	<!-- CIF PhoneEmail Changes : End -->
	<!--Access Control Changes-->
	<input type="hidden" name="accessOwnerGroup" value=""/>
	<input type="hidden" name="accessOwnerBC" value=""/>
	<!--End of Changes-->
	<input type="hidden" name="isMCEditedGeneral" value="N"/>
	<input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
	<input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
	<input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>
	<input type="hidden" name="IntWFID" value="{$IntWFID}"/> <!-- Changes for 'WFlow' POC  -->
<!-- Tracker# 97236 - ID Issued Organization changes : Start -->
        <input type="hidden" name="IDIssuedOrganisation" value=""/>
<!-- Tracker# 97236 - ID Issued Organization changes : End -->

<!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES-->


<input type="hidden" name="DOB" value=""/>
<input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
<!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES-->


  	<!-- Shanmuga CIF changes
	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="addemptycell"/>
	    <xsl:call-template name="addemptycell"/>
	<xsl:call-template name="End"/>
	-->

	<!-- shanmuga CIF changes - Name fields are called seperately
	<table width="100%" bgcolor='FFFFFF' cellspacing="0" vspace="0" hspace="0" border="0">
		<xsl:call-template name="Begin"/>
		    <xsl:call-template name="NonCustomerBO.NAME"/>
		<xsl:call-template name="End"/>
	</table>
	shanmuga CIF changes -->


 	<!-- CIF PhoneEmail Changes : Start -->
<!-- 	<table width="100%" bgcolor='FFFFFF' cellspacing="0" vspace="0" hspace="0" border="0"> -->
	<xsl:call-template name="BeginTabView">
		    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
		    <!-- Recon for call id 372307 and changes for call id 370151 starts -->
		    <xsl:with-param name="tabPageHeight">400</xsl:with-param>
	 <!-- Recon for call id 372307 changes for call id 370151 ends -->
	 </xsl:call-template>
	 <xsl:call-template name="BeginTabPage">
	            <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
	            <xsl:with-param name="tabPageName">tpageCont</xsl:with-param>
	            <xsl:with-param name="spanWidth">4</xsl:with-param>
	            <xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
	            <xsl:with-param name="tabPageDisplayNameRes">General</xsl:with-param>
		    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
         </xsl:call-template>

         <!-- Tracker ID 113276 changes start (field rearrangement )-->
 	 <xsl:choose>
	<xsl:when test="normalize-space($nonCustURL)=''">

         <xsl:call-template name="Begin"/>
         	<xsl:call-template name="NonCustomerBO.OrgKey"/>
         <xsl:call-template name="End"/>
	 <xsl:call-template name="apply">
	     <xsl:with-param name="apply_head">
	     <b><xsl:value-of select="$configLabels[@name='PERSONAL']/@configLabel"/></b>
	     </xsl:with-param>
	     <!-- <xsl:with-param name="priorityCode"><xsl:value-of select="$priorityCode"/>
	     </xsl:with-param> -->
	</xsl:call-template>



	<!-- Shanmuga CIF Changes - Call for the Name fields - Start -->
	<xsl:call-template name="Begin"/>
			<xsl:call-template name="NonCustomerBO.Gender"/>
	            <xsl:call-template name="NonCustomerBO.Salutation"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	            <xsl:call-template name="NonCustomerBO.First_Name"/>
	            <xsl:call-template name="NonCustomerBO.Middle_Name"/>
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
	            <xsl:call-template name="NonCustomerBO.Last_Name"/>
	            <xsl:call-template name="NonCustomerBO.DOB"/>
	<xsl:call-template name="End"/>
	<!-- Shanmuga CIF Changes - Call for the Name fields - End -->

	<xsl:call-template name="Begin"/>
		    <xsl:call-template name="NonCustomerBO.Nationality"/>
			<xsl:call-template name="NonCustomerBO.OccupationType"/>

			 <!--   <xsl:call-template name="NonCustomerBO.OrgKey"/> -->
	<xsl:call-template name="End"/>
<!--CRM ALERT CHANGES STARTS-->


<xsl:call-template name="Begin" />

	
		<!--<xsl:value-of disable-output-escaping="yes" select="$configLabels[@name='NonCustomerBO.enableAlerts']/@configLabel" /> -->
		<xsl:call-template name="NonCustomerBO.EnableAlerts" />
	
	
	
	<xsl:call-template name="BeginCellWithParams">
		<xsl:with-param name="align">left</xsl:with-param>
		<xsl:with-param name="class">d1</xsl:with-param>
		<xsl:with-param name="style">width:22%</xsl:with-param>
		<xsl:with-param name="valign">top</xsl:with-param>
		<!--xsl:with-param name="bgcolor">red</xsl:with-param-->
	</xsl:call-template>
 <xsl:value-of disable-output-escaping="yes" select="$configLabels[@name='NonCustomerBO.defaultChannelAlert']/@configLabel" />
	
	<!--Uncommenting for ticket # 766387 starts here-->
	<xsl:call-template name="CRMMandatoryStar">
		<xsl:with-param name="font_id">mandStarNonCustomerBO.defaultChannelAlert</xsl:with-param>
		<xsl:with-param name="font_name">mandStarNonCustomerBO.defaultChannelAlert</xsl:with-param>
		<xsl:with-param name="style">visibility:hidden</xsl:with-param>
	</xsl:call-template>
	<!--uncomment for ticket # 766387 ends here-->

	<xsl:call-template name="EndCell" />

	<xsl:call-template name="BeginCellWithParams">
		<xsl:with-param name="style">width:22%</xsl:with-param>
		<!--xsl:with-param name="bgcolor">red</xsl:with-param-->
	</xsl:call-template>

		<xsl:call-template name="NonCustomerBO.DefaultChannelAlert" />
	<xsl:call-template name="EndCell" />
	<xsl:call-template name="End" />
<!--CRM ALERT CHANGES ENDS-->
	<xsl:call-template name="Begin"/>
		<xsl:call-template name="NonCustomerBO.EmployerName"/>
		    <xsl:call-template name="NonCustomerBO.SourceOfIncome"/>
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
		    <!-- <xsl:call-template name="NonCustomerBO.Legal_Status"/> -->
		    <xsl:call-template name="NonCustomerBO.annualIncome"/>

	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
		<!-- <xsl:call-template name="NonCustomerBO.Occupation"/> -->
	<!-- <xsl:call-template name="NonCustomerBO.EMailAdd"/> -->
	<xsl:call-template name="End"/>

	<!--
	<xsl:call-template name="Begin"/>
		    <xsl:call-template name="NonCustomerBO.Currency_code"/>
		    <xsl:call-template name="NonCustomerBO.LineOfActivity"/>
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
	<xsl:call-template name="LastUpdateDate"/>
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
	<td class='d1' align='center'><xsl:value-of select="$configLabels[@name='NonCustomerBO.Document_Received']/@configLabel"/></td>
	<td class='d1' align='center' style='TEXT-ALIGN: left;padding-left:0px'><xsl:call-template name="Document_Received"/></td>
	<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="End"/>
	-->
	</xsl:when>

	<xsl:otherwise>
	  	 <xsl:call-template name="Begin"/>
		         	<xsl:call-template name="NonCustomerBO.OrgKey"/>
		         <xsl:call-template name="End"/>
			 <xsl:call-template name="apply">
			     <xsl:with-param name="apply_head">
			     <b><xsl:value-of select="$configLabels[@name='PERSONAL']/@configLabel"/></b>
			     </xsl:with-param>
			     <!-- <xsl:with-param name="priorityCode"><xsl:value-of select="$priorityCode"/>
			     </xsl:with-param> -->
			</xsl:call-template>



			<!-- Shanmuga CIF Changes - Call for the Name fields - Start -->
			<xsl:call-template name="Begin"/>
						<xsl:call-template name="NonCustomerBO.Gender"/>
				            <xsl:call-template name="NonCustomerBO.Salutation"/>
				<xsl:call-template name="End"/>
				<xsl:call-template name="Begin"/>
				            <xsl:call-template name="NonCustomerBO.First_Name"/>
				            <xsl:call-template name="NonCustomerBO.Middle_Name"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
				            <xsl:call-template name="NonCustomerBO.Last_Name"/>
				            <xsl:call-template name="NonCustomerBO.DOB"/>
				<xsl:call-template name="End"/>
				<!-- Shanmuga CIF Changes - Call for the Name fields - End -->

				<xsl:call-template name="Begin"/>
						<xsl:call-template name="NonCustomerBO.Nationality"/>
						<xsl:call-template name="NonCustomerBO.OccupationType"/>

						 <!--   <xsl:call-template name="NonCustomerBO.OrgKey"/> -->
				<xsl:call-template name="End"/>


<!--CRM ALERT CHANGES STARTS-->


<xsl:call-template name="Begin" />

	
		<!--<xsl:value-of disable-output-escaping="yes" select="$configLabels[@name='NonCustomerBO.enableAlerts']/@configLabel" /> -->
		<xsl:call-template name="NonCustomerBO.EnableAlerts" />
	
	
	
	<xsl:call-template name="BeginCellWithParams">
		<xsl:with-param name="align">left</xsl:with-param>
		<xsl:with-param name="class">d1</xsl:with-param>
		<xsl:with-param name="style">width:22%</xsl:with-param>
		<xsl:with-param name="valign">top</xsl:with-param>
		<!--xsl:with-param name="bgcolor">red</xsl:with-param-->
	</xsl:call-template>
 <xsl:value-of disable-output-escaping="yes" select="$configLabels[@name='NonCustomerBO.defaultChannelAlert']/@configLabel" />

	<!--Uncommenting for ticket # 766387 starts here-->
	<xsl:call-template name="CRMMandatoryStar">
		<xsl:with-param name="font_id">mandStarNonCustomerBO.defaultChannelAlert</xsl:with-param>
		<xsl:with-param name="font_name">mandStarNonCustomerBO.defaultChannelAlert</xsl:with-param>
		<xsl:with-param name="style">visibility:hidden</xsl:with-param>
	</xsl:call-template>-->
	<!--uncomment for ticket # 766387 ends here-->

	<xsl:call-template name="EndCell" />

	<xsl:call-template name="BeginCellWithParams">
		<xsl:with-param name="style">width:22%</xsl:with-param>
		<!--xsl:with-param name="bgcolor">red</xsl:with-param-->
	</xsl:call-template>

		<xsl:call-template name="NonCustomerBO.DefaultChannelAlert" />
	<xsl:call-template name="EndCell" />
	<xsl:call-template name="End" />
<!--CRM ALERT CHANGES ENDS-->

				<xsl:call-template name="Begin"/>
						<xsl:call-template name="NonCustomerBO.EmployerName"/>
						<xsl:call-template name="NonCustomerBO.SourceOfIncome"/>
				<xsl:call-template name="End"/>
				<xsl:call-template name="Begin"/>
					    <!-- <xsl:call-template name="NonCustomerBO.Legal_Status"/> -->
					    <xsl:call-template name="NonCustomerBO.annualIncome"/>
				            <xsl:call-template name="LastUpdateDate"/>
				<xsl:call-template name="End"/>




	</xsl:otherwise>
	</xsl:choose>






	<!-- Tracker ID 113276 changes end(field rearrangement )-->
	<!-- CIF PhoneEmail Changes : Start -->
	<!-- </table> -->
	<!-- CIF PhoneEmail Changes : End -->


<!-- Tracker ID 113276 changes start (Native language tab removed) -->
<!--Native Language Fields:start-->
<!--
<xsl:variable name="NATIVE">Native Language Fields</xsl:variable>

	<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rownative" name="rownative">
	<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
	<td onclick="Toggle('native','all');" colspan = "5" NOWRAP="true" class="LabelFont">
	     <A HREF="javascript:Toggle('native','all');"><IMG onclick="Toggle('native','all');" SRC="../reports/images/minus.gif" ID="nativegif"
	      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$NATIVE"/>
	     </label>
	</td>
	</tr>

<DIV ID = 'native' STYLE= 'visibility:visible;'>



	<TR ID='rownative' name='rownative'>
		<xsl:call-template name="NonCustomerBO.Last_Name_Native">
			   <xsl:with-param name="ele_name">NonCustomerBO.Last_Name_Native</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="NonCustomerBO.Middle_Name_Native">
			   <xsl:with-param name="ele_name">NonCustomerBO.Middle_Name_Native</xsl:with-param>
		</xsl:call-template>
	</TR>
	<TR ID='rownative' name='rownative'>
		<xsl:call-template name="NonCustomerBO.First_Name_Native">
			   <xsl:with-param name="ele_name">NonCustomerBO.First_Name_Native</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="NonCustomerBO.Last_Name_Native1">
					   <xsl:with-param name="ele_name">NonCustomerBO.Last_Name_Native1</xsl:with-param>
		</xsl:call-template>

	</TR>
	<TR ID='rownative' name='rownative'>
		<xsl:call-template name="NonCustomerBO.Middle_Name_Native1">
			   <xsl:with-param name="ele_name">NonCustomerBO.Middle_Name_Native1</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="NonCustomerBO.First_Name_Native1">
					   <xsl:with-param name="ele_name">NonCustomerBO.First_Name_Native1</xsl:with-param>
		</xsl:call-template>
	</TR>


</DIV>
-->
<!-- Tracker ID 113276 changes end -->

<!--Native Language Fields:end-->


<!--   	 <xsl:variable name="ADDRESS1">Work Address</xsl:variable>
         	<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
                	<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="row{$ADDRESS1}" name="row{$ADDRESS1}">
                        <xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
                        <td onclick="Toggle_Address('work');" colspan = "2" NOWRAP="true" class="LabelFont">
                             <A HREF="javascript:Toggle_Address('work');"><IMG onclick="Toggle_Address('work');" SRC="../reports/images/minus.gif" ID="workgif"
                              BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
                             <label FOR="CPD" class="LabelFont"><xsl:value-of select="$ADDRESS1"/>
                             </label>
                        </td>
                        </tr>
         	</table>

        <DIV ID = 'work' STYLE= 'visibility:visible;'>

       		 <table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

                 	<TR ID='rowwork' name='rowwork'>
                       		<xsl:call-template name="NonCustomerBO.Work_house_no">
                             		   <xsl:with-param name="ele_name">NonCustomerBO.Work_house_no</xsl:with-param>
                             	 </xsl:call-template>

                             	<xsl:call-template name="NonCustomerBO.Work_premise_name">
                             	   	<xsl:with-param name="ele_name">NonCustomerBO.Work_premise_name</xsl:with-param>
                             	</xsl:call-template>

                      	</TR>

                       	<TR ID='rowwork' name='rowwork'>
                          	<xsl:call-template name="NonCustomerBO.Work_building_level">
                            		<xsl:with-param name="ele_name">NonCustomerBO.Work_building_level</xsl:with-param>
                            	</xsl:call-template>

                            	<xsl:call-template name="NonCustomerBO.Work_street_no">
                            		<xsl:with-param name="ele_name">NonCustomerBO.Work_street_no</xsl:with-param>
                            	</xsl:call-template>
                      	</TR>

                        <TR ID='rowwork' name='rowwork'>

                                <xsl:call-template name="NonCustomerBO.Work_street_name">
                                	<xsl:with-param name="ele_name">NonCustomerBO.Work_street_name</xsl:with-param>
                                </xsl:call-template>



                                <xsl:call-template name="NonCustomerBO.Work_suburb">
                                	<xsl:with-param name="ele_name">NonCustomerBO.Work_suburb</xsl:with-param>
                                </xsl:call-template>
                        </TR>
                        <TR ID='rowwork' name='rowwork'>
				    <xsl:call-template name="NonCustomerBO.Work_locality_name">
					    <xsl:with-param name="ele_name">NonCustomerBO.Work_street_name</xsl:with-param>
				    </xsl:call-template>

				    <xsl:call-template name="NonCustomerBO.Work_town">
					    <xsl:with-param name="ele_name">NonCustomerBO.Work_suburb</xsl:with-param>
				    </xsl:call-template>
                         </TR>

                         <TR ID='rowwork' name='rowwork'>
				    <xsl:call-template name="NonCustomerBO.WorkAddPinCode">
					    <xsl:with-param name="ele_name">NonCustomerBO.WorkAddPinCode</xsl:with-param>
				    </xsl:call-template>

				    <xsl:call-template name="NonCustomerBO.Work_domicile">
					    <xsl:with-param name="ele_name">NonCustomerBO.Work_domicile</xsl:with-param>
				    </xsl:call-template>
                       	</TR>

                        <TR ID='rowwork' name='rowwork'>
				    <xsl:call-template name="NonCustomerBO.WorkAddCity">
					    <xsl:with-param name="ele_name">NonCustomerBO.WorkAddCity</xsl:with-param>
				    </xsl:call-template>

				    <xsl:call-template name="NonCustomerBO.WorkAddState">
					    <xsl:with-param name="ele_name">NonCustomerBO.WorkAddState</xsl:with-param>
				    </xsl:call-template>
			</TR>
                        <TR ID='rowwork' name='rowwork'>
				    <xsl:call-template name="NonCustomerBO.WorkAddCountry">
					    <xsl:with-param name="ele_name">NonCustomerBO.WorkAddCountry</xsl:with-param>
				    </xsl:call-template>

			</TR>
                 </table>
	</DIV>





	<xsl:variable name="ADDRESS2">Home Address</xsl:variable>
	         	<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
	                	<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="row{$ADDRESS2}" name="row{$ADDRESS2}">
	                        <xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
	                        <td onclick="Toggle_Address('home');" colspan = "2" NOWRAP="true" class="LabelFont">
	                             <A HREF="javascript:Toggle_Address('home');"><IMG onclick="Toggle_Address('home');" SRC="../reports/images/minus.gif" ID="homegif"
	                              BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	                             <label FOR="CPD" class="LabelFont"><xsl:value-of select="$ADDRESS2"/>
	                             </label>
	                        </td>
	                        </tr>
	         	</table>

	        <DIV ID = 'home' STYLE= 'visibility:visible;'>

	       		 <table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

	                 	<TR ID='rowhome' name='rowhome'>
	                       		<xsl:call-template name="NonCustomerBO.Home_house_no">
	                             		   <xsl:with-param name="ele_name">NonCustomerBO.Home_house_no</xsl:with-param>
	                             		   </xsl:call-template>


	                             	<xsl:call-template name="NonCustomerBO.Home_premise_name">
	                             	   	<xsl:with-param name="ele_name">NonCustomerBO.Home_premise_name</xsl:with-param>
	                             	</xsl:call-template>

	                      	</TR>

	                       	<TR ID='rowhome' name='rowhome'>
	                          	<xsl:call-template name="NonCustomerBO.Home_building_level">
	                            		<xsl:with-param name="ele_name">NonCustomerBO.Home_building_level</xsl:with-param>
	                            	</xsl:call-template>


	                            	<xsl:call-template name="NonCustomerBO.Home_street_no">
	                            		<xsl:with-param name="ele_name">NonCustomerBO.Home_street_no</xsl:with-param>
	                            	</xsl:call-template>
	                      	</TR>

	                        <TR ID='rowhome' name='rowhome'>

	                                <xsl:call-template name="NonCustomerBO.Home_street_name">
	                                	<xsl:with-param name="ele_name">NonCustomerBO.Home_street_name</xsl:with-param>
	                                </xsl:call-template>



	                                <xsl:call-template name="NonCustomerBO.Home_suburb">
	                                	<xsl:with-param name="ele_name">NonCustomerBO.Home_suburb</xsl:with-param>
	                                </xsl:call-template>
	                        </TR>
	                        <TR ID='rowhome' name='rowhome'>
					    <xsl:call-template name="NonCustomerBO.Home_locality_name">
						    <xsl:with-param name="ele_name">NonCustomerBO.Home_locality_name</xsl:with-param>
					    </xsl:call-template>



					    <xsl:call-template name="NonCustomerBO.Home_town">
						    <xsl:with-param name="ele_name">NonCustomerBO.Home_town</xsl:with-param>
					    </xsl:call-template>
	                         </TR>

	                         <TR ID='rowhome' name='rowhome'>
					    <xsl:call-template name="NonCustomerBO.HomeAddPinCode">
						    <xsl:with-param name="ele_name">NonCustomerBO.HomeAddPinCode</xsl:with-param>
					    </xsl:call-template>



					    <xsl:call-template name="NonCustomerBO.Home_domicile">
						    <xsl:with-param name="ele_name">NonCustomerBO.Home_domicile</xsl:with-param>
					    </xsl:call-template>
	                       	</TR>

	                        <TR ID='rowhome' name='rowhome'>
					    <xsl:call-template name="NonCustomerBO.HomeAddCity">
						    <xsl:with-param name="ele_name">NonCustomerBO.HomeAddCity</xsl:with-param>
					    </xsl:call-template>



					    <xsl:call-template name="NonCustomerBO.HomeAddState">
						    <xsl:with-param name="ele_name">NonCustomerBO.HomeAddState</xsl:with-param>
					    </xsl:call-template>
				</TR>
	                        <TR ID='rowhome' name='rowhome'>
					    <xsl:call-template name="NonCustomerBO.HomeAddCountry">
						    <xsl:with-param name="ele_name">NonCustomerBO.HomeAddCountry</xsl:with-param>
					    </xsl:call-template>


				</TR>
	                 </table>

	</DIV>







	<xsl:variable name="ADDRESS3">Mailing Address</xsl:variable>
	         	<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
	                	<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="row{$ADDRESS3}" name="row{$ADDRESS3}">
	                        <xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
	                        <td onclick="Toggle_Address('mailing');" colspan = "2" NOWRAP="true" class="LabelFont">
	                             <A HREF="javascript:Toggle_Address('mailing');"><IMG onclick="Toggle_Address('mailing');" SRC="../reports/images/minus.gif" ID="mailinggif"
	                              BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	                             <label FOR="CPD" class="LabelFont"><xsl:value-of select="$ADDRESS3"/>
	                             </label>
	                        </td>
	                        </tr>
	         	</table>

	        <DIV ID = 'mailing' STYLE= 'visibility:visible;'>

	       		 <table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

	                 	<TR ID='rowmailing' name='rowmailing'>
	                       		<xsl:call-template name="NonCustomerBO.Mailing_house_no">
	                             		   <xsl:with-param name="ele_name">NonCustomerBO.Mailing_house_no</xsl:with-param>
	                             	</xsl:call-template>


	                             	<xsl:call-template name="NonCustomerBO.Mailing_premise_name">
	                             	   	<xsl:with-param name="ele_name">NonCustomerBO.Mailing_premise_name</xsl:with-param>
	                             	</xsl:call-template>

	                      	</TR>

	                       	<TR ID='rowmailing' name='rowmailing'>
	                          	<xsl:call-template name="NonCustomerBO.Mailing_building_level">
	                            		<xsl:with-param name="ele_name">NonCustomerBO.Mailing_building_level</xsl:with-param>
	                            	</xsl:call-template>


	                            	<xsl:call-template name="NonCustomerBO.Mailing_street_no">
	                            		<xsl:with-param name="ele_name">NonCustomerBO.Mailing_street_no</xsl:with-param>
	                            	</xsl:call-template>
	                      	</TR>

	                        <TR ID='rowmailing' name='rowmailing'>

	                                <xsl:call-template name="NonCustomerBO.Mailing_street_name">
	                                	<xsl:with-param name="ele_name">NonCustomerBO.Mailing_street_name</xsl:with-param>
	                                </xsl:call-template>


	                                <xsl:call-template name="NonCustomerBO.Mailing_suburb">
	                                	<xsl:with-param name="ele_name">NonCustomerBO.Mailing_suburb</xsl:with-param>
	                                </xsl:call-template>
	                        </TR>
	                        <TR ID='rowmailing' name='rowmailing'>
					    <xsl:call-template name="NonCustomerBO.Mailing_locality_name">
						    <xsl:with-param name="ele_name">NonCustomerBO.Mailing_locality_name</xsl:with-param>
					    </xsl:call-template>


					    <xsl:call-template name="NonCustomerBO.Mailing_town">
						    <xsl:with-param name="ele_name">NonCustomerBO.Mailing_town</xsl:with-param>
					    </xsl:call-template>
	                         </TR>

	                         <TR ID='rowmailing' name='rowmailing'>
					    <xsl:call-template name="NonCustomerBO.MailingAddPinCode">
						    <xsl:with-param name="ele_name">NonCustomerBO.MailingAddPinCode</xsl:with-param>
					    </xsl:call-template>


					    <xsl:call-template name="NonCustomerBO.Mailing_domicile">
						    <xsl:with-param name="ele_name">NonCustomerBO.Mailing_domicile</xsl:with-param>
					    </xsl:call-template>
	                       	</TR>

	                        <TR ID='rowmailing' name='rowmailing'>
					    <xsl:call-template name="NonCustomerBO.MailingAddCity">
						    <xsl:with-param name="ele_name">NonCustomerBO.MailingAddCity</xsl:with-param>
					    </xsl:call-template>


					    <xsl:call-template name="NonCustomerBO.MailingAddState">
						    <xsl:with-param name="ele_name">NonCustomerBO.MailingAddState</xsl:with-param>
					    </xsl:call-template>
				</TR>
	                        <TR ID='rowmailing' name='rowmailing'>
					    <xsl:call-template name="NonCustomerBO.MailingAddCountry">
						    <xsl:with-param name="ele_name">NonCustomerBO.MailingAddCountry</xsl:with-param>
					    </xsl:call-template>


				</TR><tr/>
	                 </table>
		</DIV>
 -->
<!-- 		<xsl:call-template name="BeginTabView">
						<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
						<xsl:with-param name="tabPageHeight">200</xsl:with-param>
					</xsl:call-template> -->

		<!--Access Control Changes-->


<tr></tr>


<!--
			<xsl:call-template name="EndTabPage"/>

					<xsl:call-template name="BeginTabPage">
						<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
						<xsl:with-param name="tabPageName">tpageIDs</xsl:with-param>
						<xsl:with-param name="spanWidth">3</xsl:with-param>
						<xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
						<xsl:with-param name="tabPageDisplayNameRes">Identification Details</xsl:with-param>
					</xsl:call-template>
					<table bgcolor="FFFFFF" align="center" cellpadding="2" width="100%">
					   <tr align="left">
					   <td >
						<xsl:call-template name="user_button_withText">
							<xsl:with-param name="button_name">Add Identification Details</xsl:with-param>
								<xsl:with-param name="button_text"><xsl:value-of select="$configLabelsID[@name='Add Identification Details']/@configLabel"/></xsl:with-param>
								<xsl:with-param name="button_fnc">addIdentDetail(dualflag);</xsl:with-param>
								<xsl:with-param name="class">sbttn</xsl:with-param>
						</xsl:call-template>&#160;&#160;

						<xsl:call-template name="user_button_withText">
							 <xsl:with-param name="button_name">Remove Identification Details</xsl:with-param>
								<xsl:with-param name="button_text"><xsl:value-of select="$configLabelsID[@name='Remove Identification Details']/@configLabel"/></xsl:with-param>
								<xsl:with-param name="button_fnc">removeIdentDetail()</xsl:with-param>
								<xsl:with-param name="class">sbttn</xsl:with-param>
							</xsl:call-template>

					   </td>
					  </tr>
					 <tr>
					 <td>
					 <xsl:if test="normalize-space($boName)='NonCustomerBO'">
					    	<xsl:call-template name="mainbody">
					       		<xsl:with-param name="tablename">RowRecordSet</xsl:with-param>
					            	<xsl:with-param name="tableHeader">IdentDetails</xsl:with-param>
					            	<xsl:with-param name="align">center</xsl:with-param>
						      	<xsl:with-param name="button">true</xsl:with-param>
						       	<xsl:with-param name="width">100%</xsl:with-param>
						        <xsl:with-param name="name">...</xsl:with-param>
						        <xsl:with-param name="onClick">editIdentDetail()</xsl:with-param>
						        <xsl:with-param name="rsfilenm"  select="$fileName"/>
							<xsl:with-param name="callcalme">1</xsl:with-param>
						        <xsl:with-param name="extra_colheader">Select</xsl:with-param>
							<xsl:with-param name="jscriptfnc">,rowHighLight()</xsl:with-param>
							<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
						        <xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
							<xsl:with-param name="PrefixVal">1</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					 <xsl:if test="normalize-space($boName)='NonCustomerModBO'">
					    	<xsl:call-template name="mainbody">
					       		<xsl:with-param name="tablename">RowRecordSet</xsl:with-param>
					            	<xsl:with-param name="tableHeader">IdentDetails</xsl:with-param>
					            	<xsl:with-param name="align">center</xsl:with-param>
						      	<xsl:with-param name="button">true</xsl:with-param>
						       	<xsl:with-param name="width">100%</xsl:with-param>
						        <xsl:with-param name="name">...</xsl:with-param>
						        <xsl:with-param name="onClick">editIdentDetail()</xsl:with-param>
						        <xsl:with-param name="rsfilenm"  select="$fileNameMod"/>
							<xsl:with-param name="callcalme">1</xsl:with-param>
						        <xsl:with-param name="extra_colheader">Select</xsl:with-param>
							<xsl:with-param name="jscriptfnc">,rowHighLight()</xsl:with-param>
							<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
						        <xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
							<xsl:with-param name="PrefixVal">1</xsl:with-param>
						</xsl:call-template>
					</xsl:if>

					</td>
					</tr>
					</table>

					<xsl:call-template name="EndTabPage"/>
-->
<!--IDENTIFICATION DOCUMENT CHANGES start-->



<!-- Tracker ID 113276 changes start -->
	<!-- <xsl:call-template name="BeginTabView">
	    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
	    <xsl:with-param name="tabPageHeight">317</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="BeginTabPage">
		<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
		<xsl:with-param name="tabPageName">tpageIDs</xsl:with-param>
		<xsl:with-param name="spanWidth">3</xsl:with-param>
                <xsl:with-param name="isTabNameHardCoded">false</xsl:with-param>
                <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels[@name='IDENT']"/>
	</xsl:call-template> -->
<!-- Tracker ID 113276 changes end -->


	<table bgcolor="FFFFFF" align="center" cellpadding="2" width="100%">
	   <tr align="left">
	   <td >
		<xsl:call-template name="user_button_withText">
			<xsl:with-param name="button_name">AddIdentificationDetails</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Add Identification Details']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">addIdentdetails();</xsl:with-param>
				<xsl:with-param name="class">sbttn</xsl:with-param>
		</xsl:call-template>&#160;&#160;
		<xsl:call-template name="user_button_withText">
			 <xsl:with-param name="button_name">RemoveIdentificationDetails</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Remove Identification Details']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">removeIDdetails()</xsl:with-param>
				<xsl:with-param name="class">sbttn</xsl:with-param>
			</xsl:call-template>
	   </td>
	  </tr>
	 <tr>
	 <td>
        <xsl:call-template name="mainbody">
        <xsl:with-param name="tablename">EDocRecordSet</xsl:with-param>
        <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='MLHeader6']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="align">center</xsl:with-param>
        <xsl:with-param name="button">true</xsl:with-param>
        <xsl:with-param name="width">100%</xsl:with-param>
        <xsl:with-param name="name">...</xsl:with-param>
        <xsl:with-param name="UsrDataSpace">EntityDocument</xsl:with-param>
        <xsl:with-param name="rowhighlight">true</xsl:with-param>
            <xsl:with-param name="rsfilenm" select="$fileNameID"/>
        <xsl:with-param name="jscriptfnc">,callID()</xsl:with-param>
        <xsl:with-param name="extra_colheader">Select</xsl:with-param>
        <xsl:with-param name="onClick">editIdentificationDetails()</xsl:with-param>
      <xsl:with-param name="extra_colheader3">IsPreferred</xsl:with-param>
      <xsl:with-param name="radiobutton">true</xsl:with-param>
      <xsl:with-param name="radiobuttonOnClick">AddSelectedRowToList()</xsl:with-param>
      <xsl:with-param name="radiobutton_name">radio1</xsl:with-param>
      <xsl:with-param name="radiobutton_isPerformance">true</xsl:with-param>
        <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
        <xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
        <xsl:with-param name="PrefixVal">1</xsl:with-param>
        </xsl:call-template>
	</td>
	</tr>
	</table>

	<!-- tracker id 113276 changes start for access owner tab -->
	<table bgcolor="FFFFFF" align="center" cellpadding="2" width="100%">

		  <tr align="left">
				<xsl:call-template name="apply">
					 <xsl:with-param name="apply_head">
					  <b><xsl:value-of select="$configLabels[@name='AccessControl']/@configLabel"/></b>
					  </xsl:with-param>
				</xsl:call-template>



				<xsl:call-template name="Begin"/>
					<xsl:call-template name="NonCustomerBO.accessOwnerGroup"/>
					<xsl:call-template name="NonCustomerBO.accessOwnerSegment"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="NonCustomerBO.accessOwnerBC"/>
			<xsl:call-template name="End"/>
		</tr>

		<!--TrackerID: 113227  Alternate Fields Call here -->
		<tr>
		 	<xsl:choose>
		 		<xsl:when test="normalize-space($altLocaleActv)='true'">

					<xsl:variable name="DUAL"><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>
				  	 <tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rowdual" name="rowdual">
						<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
					  <td onclick="Toggle('dual','all');" colspan = "5" NOWRAP="true" class="LabelFont">
			     		   <A HREF="javascript:Toggle('dual','all');"><IMG onclick="Toggle('dual','all');" SRC="../reports/images/minus.gif" ID="dualgif"
			      		   BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
			     		   <label FOR="CPD" class="LabelFont"><xsl:value-of select="$DUAL"/>
			     		   </label>
					  </td>
					</tr>

					<DIV ID = 'dual' STYLE= 'visibility:visible;'>

					<TR ID='rowdual' name='rowdual'>
						<xsl:call-template name="NonCustomerBO.Last_Name_alt1">
					   	</xsl:call-template>

						<xsl:call-template name="NonCustomerBO.Middle_Name_alt1">
					   	</xsl:call-template>
					</TR>
					<TR ID='rowdual' name='rowdual'>
						<xsl:call-template name="NonCustomerBO.First_Name_alt1">
					   	</xsl:call-template>
						<xsl:call-template name="NonCustomerBO.EmployerName_alt1">
						</xsl:call-template>

					</TR>

		      			</DIV>
		 		</xsl:when>

		   </xsl:choose>
		   </tr>
		   </table>
<!-- tracker id 113276 changes end for access owner tab -->
<!--TrackerID: 113227  Alternate Fields call end here-->




	<xsl:call-template name="EndTabPage"/>
			<!-- CIF PhoneEmail Changes : Start -->
<!-- 			<xsl:call-template name="EndTabView">
				<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
						<xsl:with-param name="selectedTabPageName">tpageIDs</xsl:with-param>
			</xsl:call-template> -->
			<xsl:call-template name="EndTabPage"/>
			<!-- Rachit CIF PhoneEmail changes: Start -->

			<xsl:call-template name="BeginTabPage">
			    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
			    <xsl:with-param name="tabPageName">tpageCont3</xsl:with-param>
			    <xsl:with-param name="spanWidth">3</xsl:with-param>
                            <xsl:with-param name="isTabNameHardCoded">false</xsl:with-param>
			    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels[@name='CONTACT']"/>
			    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
			</xsl:call-template>

					<xsl:call-template name="BeginTabView">
							    <xsl:with-param name="tabViewName">tabContactDetails</xsl:with-param>
							    <xsl:with-param name="tabPageHeight">270</xsl:with-param>
					</xsl:call-template>

					<xsl:call-template name="BeginTabPage">
					    <xsl:with-param name="tabViewName">tabContactDetails</xsl:with-param>
					    <xsl:with-param name="tabPageName">tpageAddr</xsl:with-param>
					    <xsl:with-param name="tabPageDisplayNameRes" select="'Address'"/>
					    <xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
					    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
					</xsl:call-template>

			<tr ><td>
			<!--fix for ticket 201864 start-->
			<xsl:choose>
			<xsl:when test="normalize-space($nonCustURL)=''">
			<table bgcolor="FFFFFF" align="center" cellpadding="2" width="100%">
				<tr align="left">
				<td>
					<xsl:call-template name="NonCustomerBO.Address.preferredAddress"/>
				</td>
				<td>
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">ADD_ADDRESS</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='ADD_ADDRESS']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">addAddress()</xsl:with-param>
				</xsl:call-template>&#160;

				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">DELETE_ADDRESS</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='DELETE_ADDRESS']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">removeAddress()</xsl:with-param>
				</xsl:call-template>&#160;

				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">COPY_ADDRESS</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='COPY_ADDRESS']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">copyAddress()</xsl:with-param>
				</xsl:call-template>&#160;
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">SWIFT_ADDRESS_DETAILS</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='SWIFT_ADDRESS_DETAILS']/@configLabel"/></xsl:with-param>
				<!-- Tracker 146614: added the variable readMode -->
				<xsl:with-param name="button_fnc">createSwiftAddress(readMode)</xsl:with-param>
				</xsl:call-template>&#160;

				</td>
			      </tr>
			</table>

			</xsl:when>
    			 <xsl:otherwise>


			<table bgcolor="FFFFFF" align="center" cellpadding="2" width="100%">
			<tr align="left">
			<xsl:call-template name="NonCustomerBO.Address.preferredAddress"/>
			<td>
			<xsl:call-template name="user_button_withText">
			<xsl:with-param name="button_name">ADD_ADDRESS</xsl:with-param>
			<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='ADD_ADDRESS']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="button_fnc">addAddress()</xsl:with-param>
			</xsl:call-template>&#160;

			<xsl:call-template name="user_button_withText">
			<xsl:with-param name="button_name">DELETE_ADDRESS</xsl:with-param>
			<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='DELETE_ADDRESS']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="button_fnc">removeAddress()</xsl:with-param>
			</xsl:call-template>&#160;

			<xsl:call-template name="user_button_withText">
			<xsl:with-param name="button_name">COPY_ADDRESS</xsl:with-param>
			<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='COPY_ADDRESS']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="button_fnc">copyAddress()</xsl:with-param>
			</xsl:call-template>&#160;
			<xsl:call-template name="user_button_withText">
			<xsl:with-param name="button_name">SWIFT_ADDRESS_DETAILS</xsl:with-param>
			<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='SWIFT_ADDRESS_DETAILS']/@configLabel"/></xsl:with-param>
			<!-- Tracker 146614: added the variable readMode -->
			<xsl:with-param name="button_fnc">createSwiftAddress(readMode)</xsl:with-param>
			</xsl:call-template>&#160;

			</td>
		      </tr>
			</table>

    			 </xsl:otherwise>
     			</xsl:choose>
     			<!--fix for ticket 201864 ends-->


			    <xsl:call-template name="mainbody">
			    <xsl:with-param name="tablename">RecordSet</xsl:with-param>
			    <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='MLHeader2']/@configLabel"/></xsl:with-param>
			    <xsl:with-param name="align">center</xsl:with-param>
			    <xsl:with-param name="button">true</xsl:with-param>
			    <xsl:with-param name="width">100%</xsl:with-param>
			    <xsl:with-param name="name">...</xsl:with-param>
			    <xsl:with-param name="UsrDataSpace">Address</xsl:with-param>
			    <xsl:with-param name="rowhighlight">true</xsl:with-param>
				  <xsl:with-param name="rsfilenm" select="$fileNameAddress"/>
			    <xsl:with-param name="jscriptfnc">,addressRowHighLight()</xsl:with-param>
			    <xsl:with-param name="extra_colheader">Select</xsl:with-param>
			    <xsl:with-param name="onClick">editAddressDetails()</xsl:with-param>
			    <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
			    <xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
			    <xsl:with-param name="PrefixVal">2</xsl:with-param>
			    </xsl:call-template>

			</td></tr>
					<xsl:call-template name="EndTabPage"/>

					<xsl:call-template name="BeginTabPage">
					    <xsl:with-param name="tabViewName">tabContactDetails</xsl:with-param>
					    <xsl:with-param name="tabPageName">tpagePhone</xsl:with-param>
					    <xsl:with-param name="isTabNameHardCoded">false</xsl:with-param>
                        <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels[@name='PHONEMAIL']"/>
					    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
					</xsl:call-template>


					<xsl:call-template name="NonCustomerBO.PhoneEmail.PhoneEmailType"/>
					<xsl:call-template name="NonCustomerBO.PhoneEmail.PhoneEmailType1"/>

<!--CRM ALERT CHANGES STARTS-->
<xsl:call-template name="Begin" />
		<xsl:call-template name="NonCustomerBO.PreferredMobileAlertType" />
	<xsl:call-template name="End" />


<!--CRM ALERT CHANGES ENDS-->
				<table bgcolor="FFFFFF" align="center" cellpadding="2" width="100%">
				<td align="left">
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">ADD_PHONE_EMAIL</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='ADD_PHONE_EMAIL']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">addPhoneEmail()</xsl:with-param>
				</xsl:call-template>&#160;

				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">DELETE_PHONE_EMAIL</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='DELETE_PHONE_EMAIL']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">removePhoneEmail()</xsl:with-param>
				</xsl:call-template>&#160;

				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">COPY_PHONE_EMAIL</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='COPY_PHONE_EMAIL']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">copyPhoneEmail()</xsl:with-param>
				</xsl:call-template>&#160;
				</td>

			</table>

			    <xsl:call-template name="mainbody">
			    <xsl:with-param name="tablename">PhoneEmailRecordSet</xsl:with-param>
			    <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='MLHeader1']/@configLabel"/></xsl:with-param>
			    <xsl:with-param name="align">center</xsl:with-param>
			    <xsl:with-param name="button">true</xsl:with-param>
			    <xsl:with-param name="width">100%</xsl:with-param>
			    <xsl:with-param name="name">...</xsl:with-param>
			    <xsl:with-param name="UsrDataSpace">Phone</xsl:with-param>
			    <xsl:with-param name="rowhighlight">true</xsl:with-param>
				  <xsl:with-param name="rsfilenm" select="$fileNamePhoneEmail"/>
			    <xsl:with-param name="jscriptfnc">,callPhoneEmail()</xsl:with-param>
			    <xsl:with-param name="extra_colheader">Select</xsl:with-param>
			    <xsl:with-param name="onClick">editPhoneEmailDetails()</xsl:with-param>
			    <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
			    <xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
			    <xsl:with-param name="PrefixVal">2</xsl:with-param>
			    </xsl:call-template>


					<xsl:call-template name="EndTabPage"/>

				     <xsl:call-template name="EndTabView">
						   <xsl:with-param name="tabViewName">tabContactDetails</xsl:with-param>
						   <xsl:with-param name="selectedTabPageName">tpageAddr</xsl:with-param>
			       </xsl:call-template>

			<xsl:call-template name="EndTabPage"/>
			<!-- Rachit CIF PhoneEmail changes: End -->

			 <xsl:call-template name="EndTabView">
				<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
				<xsl:with-param name="selectedTabPageName">tpageCont</xsl:with-param>
			  </xsl:call-template>
			<!-- CIF PhoneEmail Changes : End -->
<!-- Start DataArray -->
   <script>
        var DataArray = new Array;
        var DataCount = 0;
        <xsl:for-each select="/SRM/SRMData[@SRMDataSpace='Currency']/SRMComposite[@n='CurrencyRecordSet']/SRMRow">
            DataArray[DataCount] = '<xsl:value-of select="./Z[@n='CurrencyBO.CurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.Format']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.NumberOfDecimals']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.MantissaSeperator']"/>'+"|"+'<xsl:value-of select="./Z[@n='CurrencyBO.DecimalSeperator']"/>';
            DataCount++;
        </xsl:for-each>
        var iCount = 0;
        ExArray = new Array;
        <xsl:for-each                                            select="/SRM/SRMData[@SRMDataSpace='ExRate']/SRMComposite[@n='ExRateRecordSet']/SRMRow">
            ExArray[iCount] = '<xsl:value-of select="./Z[@n='ExchangeRateBO.FixedCurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.VariableCurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.NumberOfUnits']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.ExchangeRate']"/>'
            iCount++;
        </xsl:for-each>
</script>
<!-- End DataArray -->

</form>
<form name="frm3"  method="post" action="../servlet/com.infy.cis.ui.cif.IdentDetails">
	<input type="hidden" name="identifierType" value=""/>
	<input type="hidden" name="ID" value=""/>
	<input type="hidden" name="dateOfIssue" value=""/>
	<input type="hidden" name="validityDate" value=""/>
	<input type="hidden" name="placeOfIssue" value=""/>
	<input type="hidden" name="string1" value=""/>
	<input type="hidden" name="string2" value=""/>
	<input type="hidden" name="string3" value=""/>
	<input type="hidden" name="int1" value=""/>
	<input type="hidden" name="int2" value=""/>
	<input type="hidden" name="int3" value=""/>
	<input type="hidden" name="date1" value=""/>
	<input type="hidden" name="date2" value=""/>
	<input type="hidden" name="date3" value=""/>
	<input type="hidden" name="hreadOnly" value="{$readMode}"/> <!-- changes for multirec readonly  -->

	<!-- Core Fields Inclusion -->
	<input type="hidden" name="CountryOfIssue" value=""/>
	<input type="hidden" name="CountryOfIssue_code" value=""/>
	<input type="hidden" name="PlaceOfIssue_code" value=""/>
	<input type="hidden" name="IdentifierType_code" value=""/>
	<input type="hidden" name="String1_code" value=""/>
	<!-- Core Fields Inclusion -->
<!-- Tracker# 97236 - ID Issued Organization changes : Start -->
	<input type="hidden" name="IDIssuedOrganisation" value=""/>
<!-- Tracker# 97236 - ID Issued Organization changes : End -->

</form>

         </xsl:template>
        <xsl:template match="SRM">
        <xsl:for-each select=".">
             <xsl:call-template name="startTable"/>
                <table bgcolor='FFFFFF' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
                    <tr>
                     <!-- <xsl:call-template name="apply">
                     <xsl:with-param name="apply_head">
                     <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
                     </xsl:with-param>

                     </xsl:call-template> -->
                    </tr>
                 </table>

                <table bgcolor='FFFFFF' width="100%" border="0" cellspacing="0" cellpadding="0">
                  <xsl:apply-templates select="." mode="mode1"/>
                </table>
             <xsl:call-template name="endTable"/>
        </xsl:for-each>
        </xsl:template>
</xsl:stylesheet>















