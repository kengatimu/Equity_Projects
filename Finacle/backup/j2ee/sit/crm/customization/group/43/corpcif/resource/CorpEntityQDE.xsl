<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--importing variables wich hold the jvm properties-->
<xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
<!--importing templates for widgets-->
<xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
<!--importing templates for tables,rows,cells,styles-->
<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
<xsl:import href="../Renderer/sales/display/FCRMApplFormDisplay.xsl"/>
 <!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
     	<xsl:param name="ALTCALENDAR_TYPE"/>
     <!--ERPBOCF1:TRACKER113259: STORAGE OF DATES :ENDOFCHANGES-->


<!--including file for label names-->

        <xsl:param name="locale"/>
       	<!--tracker id 113227 starts-->
	 <xsl:param name="altLocaleType"/>
	 <xsl:param name="baseLocaleType"/>
	 <xsl:param name="altLocaleActv"/>
        <!--tracker id 113227 ends-->

<!-- Changes for Tracker # 98769 begin -->
<xsl:variable name="getRole" select="/SRM/SRMData[@SRMDataSpace='RoleCode']//Z"/>
<xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"></xsl:variable>
<xsl:variable name="mcJNDIFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mcJNDIFlag']"></xsl:variable>
<xsl:variable name="isMCEdited" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isMCEdited']"></xsl:variable>
<!-- Changes for Tracker # 98769 end -->

<xsl:variable name="fileName">../Renderer/Customization/43/corpcif/resource/CorpEntityQDE_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
<!-- CIF PhoneEmail Changes : Start -->
<!--
<xsl:variable name="fileNamePhoneEmail">../Renderer/corpcif/resource/CorpListofPhoneEmail_<xsl:value-of select="$locale"/>.xml</xsl:variable>
-->
<!-- CIF PhoneEmail Changes : End -->
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
<xsl:variable name="configFile_1" select="document(concat($fileName,''))"/>

<xsl:variable name="configLabels11" select="$configFile_1/SRMBO/*"/>

  <xsl:param name="configFileName"/>
     <xsl:variable name="configFile" select="document(concat($configFileName,''))"/>
     <xsl:variable name="configLabels" select="$configFile/SRMBO/*"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
<!--
<xsl:variable name="fileName1">../Renderer/common/resource/Entity_Document_List_<xsl:value-of select="$locale"/>.xml</xsl:variable>

	<xsl:variable name="fileNameID" select="$fileName1"/>
-->
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->

<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
<!--
 <xsl:param name="fileNameML2"/>
	<xsl:variable name="fileNameGrp" select="$fileNameML2"/>
-->
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->

	<!-- caching changes start -->
    <xsl:param name="viewname"/>
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.corpcif.CorpCIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
    <xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
    <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
	<!-- caching changes end -->

     <!--Access Control Changes-->
	  <xsl:variable name="PrimBCID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcID']"></xsl:variable>
	  <xsl:variable name="PrimBCCODE" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcCode']"></xsl:variable>
	  <xsl:variable name="priGrpID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='priGrpID']"></xsl:variable>
	  <xsl:variable name="priSegName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='priSegName']"></xsl:variable>
		<xsl:variable name="saved_chargeCode" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.ChargeLevelCode')]"></xsl:variable>
	  <!-- TrackerId: 131246 Begin of Changes by neha_goel03
	  	Changes for User privelege access and Multi Entity -->
	  <xsl:variable name="GcifIdAccess" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='GcifIdAccess']"></xsl:variable>
	  <xsl:variable name="MultiEntity" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MultiEntity']"></xsl:variable>
	<!--TrackerId: 131246 Changes end -->
     <!--Access Control End of Changes-->
	<xsl:variable name="segmentValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='segmentValues']"/>
	<xsl:variable name="segmentRating" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='segmentRating']"/>
	<xsl:variable name="ratingValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='ratingValues']"/>
	<xsl:variable name="subSegmentValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='subSegmentValues']"/>
	<xsl:variable name="subSegmentCodeVal" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='subSegmentCodeVal']"/>
	<xsl:variable name="SubSegment" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.subSegment')]"></xsl:variable>
	<xsl:variable name="Segment" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.segment')]"></xsl:variable>

<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
<!--  <xsl:param name="configFileName"/>
     <xsl:variable name="configFile" select="document(concat($configFileName,''))"/>
     <xsl:variable name="configLabels" select="$configFile/SRMBO/*"/> -->
 <xsl:param name="grpFileName"/>
	<xsl:variable name="fileNameGrp" select="$grpFileName"/>
 <xsl:param name="addrFileName"/>
	<xsl:variable name="fileNameAddr" select="$addrFileName"/>
 <xsl:param name="phoneEmailFileName"/>
	<xsl:variable name="fileNamePhoneEmail" select="$phoneEmailFileName"/>
 <xsl:param name="eDocFileName"/>
	<xsl:variable name="fileNameEDoc" select="$eDocFileName"/>
	<xsl:param name="fileName_Concession"/>
		<xsl:variable name="fileName_concession" select="$fileName_Concession"/>

<xsl:variable name="LastUpdate_Date" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='LastUpdate_Date']"></xsl:variable>
<xsl:variable name="boNameRep" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boNameRep']"></xsl:variable>
<xsl:variable name="editFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='editFlag']"/>
<xsl:variable name="legalEntType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='legalEntType']"/>
<xsl:variable name="accessOwnSeg" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='accessOwnSeg']"/>
<xsl:variable name="introStr1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='introStr1']"/>
<xsl:variable name="introStr2" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='introStr2']"/>
<xsl:variable name="introStr4" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='introStr4']"/>
<xsl:variable name="introStr5" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='introStr5']"/>
<xsl:variable name="introStr9" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='introStr9']"/>
<xsl:variable name="introDate1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='introDate1']"/>
<xsl:variable name="preferredAddressType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredAddressType']"/>
<xsl:variable name="preferredPhone" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredPhone']"/>
<xsl:variable name="preferredEmail" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredEmail']"/>
<xsl:variable name="BaseCurrency" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrency']"></xsl:variable>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->

<xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"></xsl:variable>
<xsl:variable name="boNamePrefe" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boNamePrefe']"></xsl:variable>
<!-- Naved CIF Group changes start-->
<xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
<!-- Naved CIF Group changes end-->
<xsl:variable name="productCategory" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='productCategory']"></xsl:variable>
<xsl:variable name="corporateURL" select="//SRMData//Z[@n=concat($boName,'.url_')]"></xsl:variable>
<xsl:variable name="preferenceURL" select="//SRMData//Z[@n=concat($boNamePrefe,'.url_')]"></xsl:variable>
<xsl:variable name="isAutoGenKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isAutoGen']"></xsl:variable>
<xsl:variable name="keyGeneration" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='keyGeneration']"></xsl:variable>
<xsl:variable name="entityCreflg" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityCreflg']"/>
<xsl:variable name="entityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityType']"></xsl:variable>
<xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"/>
<xsl:variable name="custom_fields" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z"/>
<xsl:variable name="assignedBackEndID" select="//SRMData//Z[@n=concat($boName,'.BackEndID')]"></xsl:variable>
<xsl:variable name="DefAdress" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='DefAdress']"></xsl:variable>
<xsl:variable name="SubsecCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='SubsecCode']"></xsl:variable>
<xsl:variable name="SecCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='SecCode']"></xsl:variable>
<xsl:variable name="LegalCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='LegalCode']"></xsl:variable>
<xsl:variable name="PriserCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PriserCode']"></xsl:variable>
<xsl:variable name="operationType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operationType']"></xsl:variable>
<!-- CIF GroupHouseHold Changes Start : Naved -->
<xsl:variable name="globalRM" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='GlobalRM']"></xsl:variable>
<xsl:variable name="NatName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='NatName']"></xsl:variable>
<!-- CIF GroupHouseHold Changes End : Naved -->
<!-- Remove Address Changes Start : Ramsurendar -->
<xsl:variable name="corpID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='corpID']"></xsl:variable>
<!-- Remove Address Changes End : Ramsurendar -->
<xsl:variable name="allowMulti" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='allowMulti']" />
<xsl:variable name="isGrpAvail" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isGrpAvail']" />
<xsl:variable name="cifAddrEntity" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateRepModBO.cifAddrEntity']"></xsl:variable>
<xsl:variable name="addressCategory" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateRepModBO.addressCateogry']"></xsl:variable>
<xsl:variable name="SRMTips" select="$configLabels[@name='Tips']/@value"/>
<xsl:variable name="bcName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcName']"></xsl:variable>
<xsl:variable name="Cat_bcName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_bcName']"></xsl:variable>
 <!-- Changes for 'WFlow' POC start -->
<xsl:variable name="IntWFID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strIntWFID']"></xsl:variable>
<!-- Changes for 'WFlow' POC start -->
<!-- CRM102BETA:TrackerID:194036 Being of Change -->
<xsl:variable name="chargeCode" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='chargeCode']"/>
<xsl:variable name="codechargeCode" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='code_chargeCode']"/>
<!-- CRM102BETA:TrackerID:194036 End of Change -->


<xsl:template match="/">
	<html>
    	<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
      	<head>
      	<!--Changes by Niharika for CR356016-->
		<script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
		
<!--End of changes by Niharika for CR356016-->

					<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
					<!-- CIF PhoneEmail Changes : Start -->
					
	<!-- Equity bank DRC CGCR19 changes start -->
       <script type="text/javascript" language="javascript" src="../Customization/43/corpcif/js/CorpCIFAddress.js"></script>
	   <!-- Equity bank DRC CGCR19 changes end -->
	   <script type="text/javascript" language="javascript" src="../corpcif/js/CorpCIFPhoneEmail.js"></script>
<!--  START  Changes for Tracker # 209607 -->
				       <script type="text/javascript" language="javascript" src="../corpcif/js/CorpGenCust_QDE.js"></script>
<!--  END  Changes for Tracker # 209607 -->
				       <script type="text/javascript" src="../common/html/Rendvalidate.js" language="javascript"></script>
					<!-- CIF PhoneEmail Changes : End -->
					<!-- Changes for WFlow POC start -->
					    <script type="text/javascript" src="../common/js/WorkFlow.js" language="javascript"></script>
	    				<!-- Changes for WFlow POC end -->

					<script>
					var allowMulti = '<xsl:value-of select="$allowMulti"></xsl:value-of>'; 
					<!-- Remove Address Changes Start : Ramsurendar -->
					var corpID = '<xsl:value-of select="$corpID"/>';
					<!-- Remove Address Changes End : Ramsurendar -->
					var LastUpdate_Date = '<xsl:value-of select="$LastUpdate_Date"/>';
					var apprFlag = '<xsl:value-of select="$apprFlag"/>';
					var boName = '<xsl:value-of select="$boName"/>';
					var boNamePrefe = '<xsl:value-of select="$boNamePrefe"/>';
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
					var boNameRep = '<xsl:value-of select="$boNameRep"/>';
					var editFlag = '<xsl:value-of select="$editFlag"/>';
					var preferredAddressType = '<xsl:value-of select="$preferredAddressType"/>';
					var SegmentChanged='';
					var defaultOwnerSegment='';
					var RMChanged='';
					var defaultPrimaryRM='';
					var defaultSecondaryRM='';
					var preferredPhone = '<xsl:value-of select="$preferredPhone"/>';
					var preferredEmail = '<xsl:value-of select="$preferredEmail"/>';
					var introStr1 = '<xsl:value-of select="$introStr1"/>';
					var introStr2 = '<xsl:value-of select="$introStr2"/>';
					var introStr4 = '<xsl:value-of select="$introStr4"/>';
					var introStr5 = '<xsl:value-of select="$introStr5"/>';
					var introStr9 = '<xsl:value-of select="$introStr9"/>';
					var introDate1 = '<xsl:value-of select="$introDate1"/>';
					var legalEntType = '<xsl:value-of select="$legalEntType"/>';
					var accessOwnSeg = '<xsl:value-of select="$accessOwnSeg"/>';
                                        var locale = '<xsl:value-of select="$locale"/>';
					var cifAddrEntity = '<xsl:value-of select="$cifAddrEntity"/>';
					var addressCategory = '<xsl:value-of select="$addressCategory"/>';
					<!-- CRM102BETA:TrackerID:194036 Being of Change -->
					var chargeCode = '<xsl:value-of select="$chargeCode"/>';
					var codechargeCode = '<xsl:value-of select="$codechargeCode"/>';
					<!-- CRM102BETA:TrackerID:194036 End of Change -->
					<!-- Changes for TOL 663535 starts -->
					var convToCust = '';
					<!-- Changes for TOL 663535 ends -->
					<!-- changes for Tracker Id: 356558 --> 
					           var saved_chargeCode = '<xsl:value-of select="$saved_chargeCode"/>'; 

					 <!--tracker id 113227 starts-->

					     /*ticket id 219597 tracker id 132339 changes starts*/
					    	var dualflag=1;
					      /*ticket id 219597 tracker id 132339 changes ends*/

					     	var altLocaleType = '<xsl:value-of select="$altLocaleType"/>';
					      	var baseLocaleType = '<xsl:value-of select="$baseLocaleType"/>';
					        var altLocaleActv = '<xsl:value-of select="$altLocaleActv"/>';

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


//IDENTIFICATION DOCUMENT CHANGES start
					var entityDocumentBO_Name;

					/* Changes for WFlow POC -- start */
					var IntWFID = '<xsl:value-of select="$IntWFID"/>';
					/* Changes for WFlow POC -- end */

					if(editFlag =='N'){
						entityDocumentBO_Name='EntityDocumentBO';
					}
					else{
						entityDocumentBO_Name='EntityDocumentModBO';
					}
//IDENTIFICATION DOCUMENT CHANGES end
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
									var corpURL = '<xsl:value-of select="$corporateURL"/>';
									var isAutoGenKey = '<xsl:value-of select="$isAutoGenKey"/>';
									var entityType = '<xsl:value-of select="$entityType"/>';

    								var DefAdress = '<xsl:value-of select="$DefAdress"/>';
   									var relCreatedBy = '<xsl:value-of select="$custom_fields[@n='RelationshipCreatedBy']"/>';

    								var SubsecCode = '<xsl:value-of select="$SubsecCode"/>';
    								var SecCode = '<xsl:value-of select="$SecCode"/>';
    								var PriserCode = '<xsl:value-of select="$PriserCode"/>';


        var assignedBackEndID = '<xsl:value-of select="$assignedBackEndID"/>';
    								var LegalCode = '<xsl:value-of select="$LegalCode"/>';
								<!--Access Control Changes-->
									var primBCID = '<xsl:value-of select="$PrimBCID"/>';
									var primBCCODE = '<xsl:value-of select="$PrimBCCODE"/>';
									var priGrpID = '<xsl:value-of select="$priGrpID"/>';
									var priSegName = '<xsl:value-of select="$priSegName"/>';
								<!--End of Changes-->
	<!-- CIF Integration Fix -->
	var BaseCurrency ='<xsl:value-of select="$BaseCurrency"/>';
									var operationType = '<xsl:value-of select="$operationType"/>';
								 <!-- CIF Group Changes Start Naved -->
									var cntry_oper='';
									<xsl:variable name="str4Code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.CountryOfPrincipalOperation']"/>
									cntry_oper = '<xsl:value-of select="$str4Code"/>';
									var globalRM = '<xsl:value-of select="$globalRM"/>';
									var NatName =  '<xsl:value-of select="$NatName"/>';
							     <!-- CIF Group Changes End Naved -->
	var keyGeneration = '<xsl:value-of select="$keyGeneration"/>';
	var entityCreflg ='<xsl:value-of select="$entityCreflg"/>';
	var segment = '<xsl:value-of select="$segmentValues"/>';
	var segmentRating = '<xsl:value-of select="$segmentRating"/>';
	var subSegmentRating = '<xsl:value-of select="$ratingValues"/>';
	var subSegment = '<xsl:value-of select="$subSegmentValues"/>';
	var subSegmentCode = '<xsl:value-of select="$subSegmentCodeVal"/>';
	var SubSegment = '<xsl:value-of select="$SubSegment"/>';
	var Segment = '<xsl:value-of select="$Segment"/>';
	var bcName = '<xsl:value-of select="$bcName"/>';
	var Cat_bcName = '<xsl:value-of select="$Cat_bcName"/>';
	                        var Currency ='';
							<!-- Tracker ID :756914 - Chrome Porting Changes -->
					function functionBodyOnload(){
						makekeyMand();
						DisableGcifIdLookUp();
						changeSubSeg();
						loadBackEnd();
						loadSubSeg();
						loadSegVal();
						loadBaseCurrency();
						onAddrSelect();
						showbuttonsVisible(45);
						showFormTips();
						populateAccContAttr();
						storeSegment();
						onCIFSelect();
						load();
						MakeEnable();
						disableCorpRep();
						loadID();
						loadrel();
						loadZakat();
						loadAddressType();
						focusFirstField1();
					}

					</script>

					<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
					<link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
					<link rel="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
					<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>


					<script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>
					<script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
					<script type="text/html" src="../Renderer/wizards/html/CorpCifShowButtons.html"></script>
					<script type="text/html" src="../Renderer/wizards/html/ShowButtons.html"></script>
					<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>

					<!-- Memo padding -->
					<script type="text/javascript" src="../common/js/ContextSwitch.js" language="javascript"></script>
					<!-- Changes done by Bharath  -->
					
					<script type="text/javascript">
					function loadGen()
					{					
					document.getElementsByName("CorporateBO.NativeLangCode")[0].value = "INFENG";
					document.getElementsByName("CorporateBO.Lang_Desc")[0].value = "UK (English)";
					document.getElementsByName(boName+".asset_classification")[0].value = "S";
					}
					
			/*Added for currency issue*/
			function fnEquityGetCurrency(strProcessURL)
			{ 
			    try{
                                //alert("fnEquityGetCurrency");
				var xmlhttp;
				if (window.XMLHttpRequest)
				{
					// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp=new XMLHttpRequest();
				}
				else if (window.ActiveXObject)
				{
					// code for IE6, IE5
					xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
				else
				{
					alert("Your browser does not support XMLHTTP!");
				}

				xmlhttp.abort();
				xmlhttp.open("GET",strProcessURL,false);
				xmlhttp.send();
				if(xmlhttp.status == 200)
				  { 
				   Currency = xmlhttp.responseXML.selectSingleNode("XML/Currency").text;
                                   //alert("fnEquityGetCurrency Currency "+Currency); 
				  }
				  }
			      catch(e)
				   {
					alert(e.message);
				   }
			} 
                      /*Added for currency issue*/

					
					function custFnOnload()
					{
					try{
    var obj = parent.parent.parent.parent.frames(3);
    
	obj.hideSaveButton('true');
}catch(e)
{ }
						document.getElementsByName("CorporateBO.short_Name")[0].readOnly = true;
						
						document.getElementsByName("CorporateBO.primary_Service_Center")[0].disabled=true;
						document.getElementsByName("Cat_CorporateBO.primary_Service_Center")[0].disabled=true;
						document.getElementsByName("btnone_CorporateBO.primary_Service_Center")[0].disabled=true;
						document.getElementsByName("btntwo_CorporateBO.primary_Service_Center")[0].disabled=true;
						
						document.getElementsByName("CorporateBO.Health_Desc")[0].value="NML";
						
						 /*Added for currency issue*/
						                
						                var accountid="";
						                var strProcessURL = '../servlet/com.infy.cis.custom.EquityGetCurrency?entityId='+accountid;
						                fnEquityGetCurrency(strProcessURL);
						                //alert("Currency QDE "+Currency);
						                var propCurrency=Currency;
						                //alert("propCurrency QDE "+propCurrency);
						                
                                                 /*Added for currency issue*/
						
						
						
						document.getElementsByName("CorporateBO.StrUserField14")[0].selectedIndex = 1;
						var URL = "";
						//var CustomerCurrency = '<xsl:value-of select="$BaseCurrency"/>';
						var CustomerCurrency = propCurrency;
					setCookie('PreferencesBO.CorpMiscellaneousInfo.str1',CustomerCurrency);
						var CreditDiscountPercent = "0";
						var DebitDiscountPercent = "0";
						var WithholdTaxPcnt = document.getElementsByName("CorporateBO.StrUserField14")[0].value;
						var WithholdTaxFloorLmt = "0";
						var PreferentialExpiryDate = "31/12/2099";
						ConcessionappendTRChild(URL,
									CreditDiscountPercent,
									DebitDiscountPercent,
									WithholdTaxPcnt,
									WithholdTaxFloorLmt,
									PreferentialExpiryDate,
									'CDF');
									setCookie('PreferencesBO.CorpMiscellaneousInfo.str1','USD');
					     ConcessionappendTRChild(URL,
									CreditDiscountPercent,
									DebitDiscountPercent,
									WithholdTaxPcnt,
									WithholdTaxFloorLmt,
									PreferentialExpiryDate,
									'USD');
									
									setCookie('PreferencesBO.CorpMiscellaneousInfo.str1','EUR');
						  ConcessionappendTRChild(URL,
									CreditDiscountPercent,
									DebitDiscountPercent,
									WithholdTaxPcnt,
									WithholdTaxFloorLmt,
									PreferentialExpiryDate,
									'EUR');
					}
</script>
		</head>
		
<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 -->
        <body class="popup" onkeypress="onLoadSetTime()" onclick="onLoadSetTime()">      
<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 -->

<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
         <!--TRACKER ID:149968 START -->
         <!-- CRM102BETA:TrackerID:194036 Begin of Change -->
			<!--RECON Changes for Ticket id 383447 and Tracker id 233726  begins-->
			<!-- fix for tracker id:337378  START-->
			<!--Recon changes for firestone tracker id  351567 starts -->
			<!--Changes for call id 346337 Starts-->
	      <xsl:attribute name="onload">loadSector();loadGen();custFnOnload();makekeyMand();DisableGcifIdLookUp();focusFirstField1();changeSubSeg();loadBackEnd();loadSubSeg();loadSegVal();loadBaseCurrency();onAddrSelect();showbuttonsVisible(45);showFormTips();populateAccContAttr();storeSegment();onCIFSelect();load();MakeEnable();disableCorpRep();loadID();loadrel();loadZakat();loadAddressType();</xsl:attribute>
			<!--Changes for call id 346337 Ends -->
			<!--Recon changes for firestone tracker id 351567 ends -->
			<!-- fix for tracker id:337378  END-->
			<!--RECON Changes for Ticket id 383447 and Tracker id 233726 ends-->
	 <!-- CRM102BETA:TrackerID:194036 End of Change -->
	 <!--TRACKER ID:149968 END -->
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->

					<script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
					<script type="text/javascript" src="../common/html/Rendvalidate.js" language="javascript"></script>
					<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
					<script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>
					<script type="text/javascript" language="javascript" src="../Customization/43/corpcif/js/CorpEntityQDE.js"></script>
					<script type="text/javascript" language="javascript" src="../corpcif/js/Group.js"></script>

					<script type="text/javascript" src="../common/js/MLValidate.js" language="javascript"></script>
<!--  START  Changes for Tracker # 209607 -->
					<script type="text/javascript" src="../common/js/Rendcurrency_cif.js" language="javascript"></script>
<!--  END  Changes for Tracker # 209607 -->
					<script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
					<script type="text/javascript" src="../corpcif/js/Message_corpcif_{$locale}.js" language="javascript"></script>
					<!-- Field Rationalization changes start -->
					<script type="text/javascript" src="../common/js/SSOUtils.js"></script>
					<script type="text/javascript" src="../cif/js/CifGroupLookup_System.js" language="javascript"></script> 
                        <script type="text/javascript" src="../cif/js/Group.js" language="javascript"></script> 
					<!-- Field Rationalization changes end -->

<script type="text/javascript" src="../Customization/js/ISICValidation.js" language="javascript"></script>


					<!--   JAVASCRIPT FUNCTIONS    -->
					<script type="text/javascript" language="javascript">

				var forRet 			= new Array();
//113227 changes starts
				var forRet1 			= new Array();
//113227 changes ends
				var forCorp  			= new Array();

				var iCount1 = 0;
				var RetAddr   =  new Array();
//113227 changes starts
				   // Tracker ID: 122044 Changes START
				var RetAddr1   =  new Array();
//113227 changes ends
				var CorpAddr1  = new Array();
				// Tracker ID: 122044 Changes END


				var CorpAddr  = new Array();
				var refreshParentToParent = true;

				'<xsl:for-each select="$PresFile/SRM/SRMPresentation/L1[@n='RetailBankEntity']/C1">'
					forRet[iCount1] 		= '<xsl:value-of select="@value"/>'
//113227 changes starts
					forRet1[iCount1] 		= '<xsl:value-of select="@url"/>'
//113227 changes ends

					iCount1++;
				'</xsl:for-each>'
				//alert(forRet);

				var iCount2 = 0;
				'<xsl:for-each select="$PresFile/SRM/SRMPresentation/L1[@n='CorporateBankEntity']/C1">'
				// Tracker 130944 Changes Start
					// forCorp[iCount2] 		= '<xsl:value-of select="@value"/>'
					   forCorp[iCount2] 		= '<xsl:value-of select="@url"/>'
				// Tracker 130944 Changes End
					iCount2++;
				'</xsl:for-each>'

				//alert(forCorp);

				var iCount3 = 0;
				'<xsl:for-each select="$PresFile/SRM/SRMPresentation/L1[@n='RetailAddr']/C1">'
					RetAddr[iCount3] 		= '<xsl:value-of select="@value"/>'
					// Tracker ID: 122044 Changes START
					RetAddr1[iCount3] 		= '<xsl:value-of select="@url"/>'
					// Tracker ID: 122044 Changes END
					iCount3++;
				'</xsl:for-each>'

				 var iCount = 0;
				ExArray = new Array;
				<xsl:for-each select="/SRM/SRMData[@SRMDataSpace='ExRate']/SRMComposite[@n='ExRateRecordSet']/SRMRow">
				    ExArray[iCount] = '<xsl:value-of select="./Z[@n='ExchangeRateBO.FixedCurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.VariableCurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.NumberOfUnits']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.ExchangeRate']"/>'
				    iCount++;
        			</xsl:for-each>


				var iCount4 = 0;
				'<xsl:for-each select="$PresFile/SRM/SRMPresentation/L1[@n='CorporateAddr']/C1">'
					CorpAddr[iCount4] 		= '<xsl:value-of select="@value"/>'
					// Tracker ID: 122044 Changes START
					CorpAddr1[iCount4] 		= '<xsl:value-of select="@url"/>'
					// Tracker ID: 122044 Changes END
					iCount4++;
				'</xsl:for-each>'

<![CDATA[
<!-- Core dependency changes start-->
function changeSubSeg () {
try {
	var segrating= loadSubSeg();
	/*if(segrating != null && segrating != 'null' ) {
		document.getElementsByName("Cat_CorporateBO.ChargeLevelCode")[0].value = segrating;
		<!-- CRM102BETA:TrackerID:194036 Begin of Change -->
		document.getElementsByName("CorporateBO.ChargeLevelCode")[0].value = codechargeCode;
		<!-- CRM102BETA:TrackerID:194036 End of Change -->

	}
	else {
		document.getElementsByName("Cat_CorporateBO.ChargeLevelCode")[0].value = '';
		<!-- CRM102BETA:TrackerID:194036 Begin of Change -->
		document.getElementsByName("CorporateBO.ChargeLevelCode")[0].value = '';
		<!-- CRM102BETA:TrackerID:194036 End of Change -->
	}*/
}
catch (e) {
}
}
<!-- Core dependency changes end-->
function loadSubSeg(){
	var ele1 = document.getElementsByName(boName+".segment")[0];
	var ele2 = document.getElementsByName(boName+".subSegment")[0];
	 var code=saved_chargeCode;          /* changes for Tracker Id: 356558*/
	ele2.options.length = 0;
	ele2.options[0] = new Option('','');
	/*Changes for Tracker:138505*/
		var segValues = segment.split("$");
		<!-- CRM102BETA:TrackerID:194036 Begin of Change -->
		//var segRat = segmentRating.split("$");
		//var segRat = chargeCode;
		 var segRat = segmentRating.split("$");                  /* changes for Tracker Id: 356558*/
		<!-- CRM102BETA:TrackerID:194036 End of Change -->
		var subSeg = subSegment.split("$");
		var subSegCode = subSegmentCode.split("$");
		//alert("...subSeg.."+subSegment);
		//alert("...subSegmentRating.."+subSegmentRating);
		var subSegRat = subSegmentRating.split("$");
	/*Changes for Tracker:138505*/
	//var segValues = segment.split("|");
	//var segRat = segmentRating.split("|");
	//var subSeg = subSegment.split("|");
	//var subSegCode = subSegmentCode.split("|");
	//var subSegRat = subSegmentRating.split("|");

	var segrating = '';
/* changes for Tracker Id: 356558 Start*/ 
       /*changes for 298759 start*/ 
       var seg_code=''; 
           var code_chargeCode= codechargeCode.split("$"); 
           var charge_Code=chargeCode.split("$"); 
         if(ele1.value != '' && ele1.value != null ){ 
                for(i=0; i<segValues.length; i++){ 
                        if(segValues[i] == ele1.value){ 
                              <!-- CRM102BETA:TrackerID:194036 Begin of Change --> 
                               //  segrating = segRat; 
                               <!-- CRM102BETA:TrackerID:194036 End of Change --> 
                            for(j=0; j<code_chargeCode.length; j++) 
                 { 
                   if(segRat[i]==code_chargeCode[j]) 
                   {segrating =charge_Code[j]; 
                   seg_code=code_chargeCode[j]; 
                   } 
                   if(code==code_chargeCode[j]) 
                   { 
                   document.getElementsByName("Cat_CorporateBO.ChargeLevelCode")[0].value =charge_Code[j]; 
                   document.getElementsByName("CorporateBO.ChargeLevelCode")[0].value =code; 
                 }                  
                 } 
    
           /* changes for Tracker Id: 356558 end*/ 
               } 
           } 

	k=1;
	for(j=0; j<subSegRat.length ; j++){
	/*Changes for Tracker:138505*/
		var sub2rat=subSegRat[j].split("|");

		if(sub2rat.length>1)
		{
		//alert("...sub2rat.."+sub2rat);
		 for(m=0;m<sub2rat.length ; m++){
		if(sub2rat[m] == ele1.value){
		//alert("...if multiple.");
		/*change for ticket 262742*/
		ele2.options[k] = new Option(subSeg[j],subSegCode[j] );
			k++;
		}

		}
		}
	/*Changes for Tracker:138505END*/
	/*change for ticket 262742*/
	if(subSegRat[j] == ele1.value){
		ele2.options[k] = new Option(subSeg[j],subSegCode[j] );
		k++;
	}

	}
	}
	
	/* changes for Tracker Id: 356558 Start*/ 
		           if(segrating != null && segrating != 'null' && segrating!='') { 
		                   /*214489 changes end*/ 
		                           document.getElementsByName("Cat_CorporateBO.ChargeLevelCode")[0].value = segrating; 
		                           <!-- CRM102BETA:TrackerID:194036 Begin of Change --> 
		                           document.getElementsByName("CorporateBO.ChargeLevelCode")[0].value = seg_code; 
		                           <!-- CRM102BETA:TrackerID:194036 End of Change --> 
		    
		                   } 
		                   else { 
		                           document.getElementsByName("Cat_CorporateBO.ChargeLevelCode")[0].value = ''; 
		                           <!-- CRM102BETA:TrackerID:194036 Begin of Change --> 
		                           document.getElementsByName("CorporateBO.ChargeLevelCode")[0].value = ''; 
		                           <!-- CRM102BETA:TrackerID:194036 End of Change --> 
		           /* changes for Tracker Id: 356558 End*/ 
	           } 
<!-- Core dependency changes start-->
	return segrating;
<!-- Core dependency changes end-->


}

// ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 start
// To disable zakat_deduction field when form loads

function loadZakat()
	{

	/*TRACKER ID 124192 CHANGES BEGIN*/
	//Add a condition to disable Zakat Deduction only in case of Customer QDE
	if(entityType == 'Customer'){
	/*TRACKER ID 124192 CHANGES END*/
	 document.getElementsByName(boName+".zakat_deduction")[0].disabled = true;
	/*TRACKER ID 124192 CHANGES BEGIN*/
	}
	/*TRACKER ID 124192 CHANGES END*/

	}

// ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 end

function loadSegVal(){
	var ele2 = document.getElementsByName(boName+".subSegment")[0];

	if( SubSegment!= '' && SubSegment!= null){
	for(i=0;i<ele2.options.length;i++)
		{

			if(ele2.options[i].value==SubSegment)
			{
			ele2.selectedIndex=i
			break;
			}
		}
	}
	}
]]>
<![CDATA[function showFormTips() {
parent.parent.parent.parent.removeTips(parent.parent.parent.parent.frames(0).getSelectedTabId());
parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(),"]]><xsl:value-of select="$SRMTips"/><![CDATA[");
parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames(0).getSelectedTabId());
parent.parent.parent.parent.showTipsButton();

}
]]>


// ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 start
// Function hideFields is written to disable zakat_deduction field when user selects
// "N" or "None" in islamic_banking_customer field dropdowns

/* Corp CIF changes for Call id: 346336 : Start */
function loadAddressType(){
	var DefAdress1;
	
	if(DefAdress == 'H')
		DefAdress1='Head Office';

	else if(DefAdress=='A')
		DefAdress1='Alt Lang Address';
				
	else if(DefAdress=='M')
		DefAdress1='Mailing';
				
	else if(DefAdress=='R')
		DefAdress1='Registered';
												
	if(DefAdress1 != ""){
	
		document.getElementsByName("CorporateModBO.Address.preferredAddress")[0].value = DefAdress1;
	}else{
		document.getElementsByName("CorporateModBO.Address.preferredAddress")[0].value = "Registered";
	}	
}
/* Corp CIF changes for Call id: 346336 : End */

function ISICValidation(Type,ID,TID,RType)
{
	ValidateISIC(Type,ID,TID,RType);	
}

function loadSector()
{
	//alert(operationType);
	if(operationType =='EditEntity')
	{
		document.getElementsByName('CorporateBO.sector')[0].value = sector;
		
		var Acckey1 = document.getElementsByName('CorporateBO.corp_Key')[0].value

		ISICValidation('SUB_SECTOR_CODE','.sector','.Subsector','SECTOR_CODE');
		CorpISICValue(Acckey1,'Subsector');

		ISICValidation('ISICP1','.Subsector','.StrUserField29','SUB_SECTOR_CODE');
		CorpISICValue(Acckey1,'StrUserField29');
			
		ISICValidation('ISICP2','.StrUserField29','.StrUserField7','ISICP1');		
		CorpISICValue(Acckey1,'StrUserField7');

		ISICValidation('ISIC_DEMAND2','.StrUserField27','.StrUserField28','ISIC_DEMAND1');
		CorpISICValue(Acckey1,'StrUserField28');


		ISICValidation('SUB_SECTOR_CODE','.str1','.str10','SECTOR_CODE')
		CorpISICValue(Acckey1,'str10');
		
		ISICValidation('ISICP1','.str10','.str11','SUB_SECTOR_CODE')
		CorpISICValue(Acckey1,'str11');
		
		ISICValidation('ISICP2','.str11','.str12','ISICP1')
		CorpISICValue(Acckey1,'str12');

		ISICValidation('ISIC_DEMAND2','.str13','.str14','ISIC_DEMAND1')
		CorpISICValue(Acckey1,'str14');		
		
	}
}

function hideFields(){
		var mydata = new Array();
		if(document.getElementsByName(boName+".islamic_banking_customer")[0].value == "N")
		{
		document.getElementsByName(boName+".zakat_deduction")[0].disabled = true;
		document.getElementsByName(boName+".zakat_deduction")[0].value="";
		}
		else if(document.getElementsByName(boName+".islamic_banking_customer")[0].value == "Y")
		{
		document.getElementsByName(boName+".zakat_deduction")[0].disabled = false;
		}else
		{
		document.getElementsByName(boName+".zakat_deduction")[0].disabled = true;
		document.getElementsByName(boName+".zakat_deduction")[0].value="";
		}
	}

// ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 end

	<!--Access Control Changes-->
<!-- Tracker ID: 108385: Begin of changes : For focus on first field -->
var prefAddress;
<!-- fix for tracker id:337378  START-->
function focusFirstField1()
{ //fix for tracker id:337378  END

	var tempPre_Add = document.getElementsByName("CorporateModBO.Address.preferredAddress")[0].value;

	if(tempPre_Add != ''){
		prefAddress = tempPre_Add;
	}

	try
	{
		document.getElementsByName("CorporateBO.corporate_Name")[0].focus();
	}
	catch (e)
	{
		try
		{
			document.getElementsByName("CorporateModBO.Address.preferredAddress")[0].focus();

			if(tempPre_Add == ''){
				document.getElementsByName("CorporateModBO.Address.preferredAddress")[0].value = prefAddress;
			}

		}
		catch (e)
		{
			try
			{
				document.getElementsByName("CorporateModBO.PhoneEmail.PhoneEmailType")[0].focus();
			}
			catch (e)
			{
				try
				{
					document.getElementsByName("CorporateBO.PrimaryParentCompany")[0].focus();
				}
				catch (e)
				{
				}
			}
		}
	}
}
	function checkKeys() {
		if (event.keyCode == 42 || event.keyCode ==37) {
			event.keyCode=0;
		}
	}


<!-- TrackerId: 131246 Begin of Changes by neha_goel03-->
				var bGcifIdAccess ='<xsl:value-of select="$GcifIdAccess"/>';
				var bMultiEntity ='<xsl:value-of select="$MultiEntity"/>';
<!--TrackerId: 131246 Changes end -->
<!-- Tracker ID: 108385: End of changes -->


	function  openBCCodeLookup(type)
	{
		bcCodeLookup = type;
		var url = "com.infy.cis.ui.common.Lookup?Mode=ForBCCode&amp;isActive=Y&amp;isAutomated=N";
<!--Tracker:108380: Changes for centering popup -->
	wid=900;
		ht=360;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	var style = "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=yes,titlebar=no,toolbar=no,status=yes,scrollbars=yes";
<!--Tracker:108380: End of Changes-->

		window.open (url, "Lookup", style);
	}
	function  onBCCodeSelect()
	{
		setBCCodeValues ( bcCodeLookup , getCookie("bCCode"), getCookie("bCID"));
		<!-- Changes for Tracker # 98769 begin -->
		document.getElementsByName("CorporateBO.accessOwnerBC")[0].fireEvent("onChange");
		<!-- Changes for Tracker # 98769 end -->
	}

	function  setBCCodeValues (type, bCCode, bCID)
	{
		eval("document.frm2." + type).value = bCID;
		eval("document.getElementsByName('CorporateBO.accessOwnerBC')[0]").value  = bCCode;
	<!-- Changes for Tracker # 98769 begin -->
	}

	function setMCAttModifyFlag(){
		document.frm2.isMCEditedGeneral.value="Y";
	}
	<!-- Changes for Tracker # 98769 end -->
	function setAccessOwnerGroup()
	{
/* Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START */
		document.frm2.accessOwnerGroup.value=document.getElementsByName(boName+'.accessOwnerGroup')[0].value;
/* Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END */
	}
	function setAccessOwnerSegment()
	{
		var ownerSegment= document.getElementsByName(boName+'.accessOwnerSegment')[0].value;

		if (ownerSegment!="" &amp;&amp; ownerSegment!= defaultOwnerSegment &amp;&amp; ownerSegment!=null &amp;&amp; ownerSegment!="null" ) {
			SegmentChanged='true';
		}
		else {
			SegmentChanged='false';
		}
	}

	<!--End of Access Control Changes-->
        function showbuttonsVisible(btnFrmSize) {

		 <!--Tracker id 113227 start here-->
		 document.frm2.altLocaleActv.value='<xsl:value-of select="$altLocaleActv"/>';
		 <!--Tracker id 113227 end here-->

            try{
                parent.parent.parent.parent.setCifButtonsVisible(true,btnFrmSize);
            }catch(e)
            {}
        }
       //sanity testing bug fix:start
        function refreshParent()
		{
			return false;
		}

	function shouldRefresh()
		{
			return false;
		}
	function clear(){

		top.window.close();
}
//sanity testing bug fix:end
					function sortMe(sortColumn,sortOrder)
						{
						// later.
						}


					<![CDATA[
					function sortMe(sortColumn,sortOrder) {
					}]]>


					</script>

	<!--JAVASCRIPT FUNCTIONS ends here-->



				<table width="100%" border="0" cellpadding="0" cellspacing="0" vspace="0" hspace="0">
						<xsl:apply-templates select="SRM"/>
				</table>
		</body>
	</html>
</xsl:template>



<!-- Templates For General Tab Start -->
   <!--  satish Changes	-->


		<xsl:template name="CorporateBO.corporate_Name">
			<xsl:call-template name="label">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.corporate_Name']"/>
				<xsl:with-param name="selectname">CorporateBO.corporate_Name</xsl:with-param>
				<xsl:with-param name="selectdisp">CorporateBO.corporate_Name</xsl:with-param>
				<xsl:with-param name="ele_name">CorporateBO.corporate_Name</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.corporate_Name</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
<!-- Fix for call id: 428627 Starts -->
				<xsl:with-param name="fn_onBlur">corpNameTrim();fnDefaultShortName();set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
                <!--Changes for call id::572933 begins -->
				<!--<xsl:with-param name="max_length">100</xsl:with-param>-->
				<!--changes for call id::572933 ends -->
			</xsl:call-template>
		</xsl:template>



<!--Begin Of Changes, ME Phase 3 Tracker ID:131246
Changes by neha_goel03 for GCIF LookUp
Added this template for GCIF LookUp
-->
		<xsl:template name="CorporateBO.GCIFID">
		   		<xsl:call-template name="lookup">
		   		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.GCIFID']"/>
		   		<xsl:with-param name="elename">CorporateBO.GCIFID</xsl:with-param>
				<xsl:with-param name="ele_name">CorporateBO.GCIFID</xsl:with-param>
		   		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		   		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		   		<xsl:with-param name="buttonone_fnc">fnCorpGCIFLookup()</xsl:with-param>
		   		<xsl:with-param name="buttontwo_fnc">clearGCIFLookupOne()</xsl:with-param>
		   		</xsl:call-template>
		</xsl:template>

<!--End of changes by neha_goel03 for GCIF LookUp-->

		<!--Tracker 113227 changes BEGIN-->

		<xsl:template name="CorporateBO.corporate_Name_alt1">
					<xsl:call-template name="label_alternate">
						<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.corporate_Name']"/>
						<xsl:with-param name="ele_name">CorporateBO.corporate_Name_alt1</xsl:with-param>
						<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.corporate_Name_alt1</xsl:with-param>
						<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- Fix for call id: 428627 Starts -->
						<xsl:with-param name="max_length">80</xsl:with-param>
<!-- Fix for call id: 428627 Ends -->
					</xsl:call-template>
		</xsl:template>




		<xsl:template name="CorporateBO.short_Name_alt1">
					<xsl:call-template name="label_alternate">
						<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.short_Name']"/>
						<xsl:with-param name="ele_name">CorporateBO.short_Name_alt1</xsl:with-param>
						<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_Name_alt1</xsl:with-param>
						<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
						<xsl:with-param name="max_length">10</xsl:with-param>
					</xsl:call-template>
		</xsl:template>



		<xsl:template name="CorporateBO.keyContact_PersonName_alt1">
					<xsl:call-template name="label_alternate">
						<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.keyContact_PersonName']"/>
						<xsl:with-param name="ele_name">CorporateBO.keyContact_PersonName_alt1</xsl:with-param>
						<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.keyContact_PersonName_alt1</xsl:with-param>
						<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
						<xsl:with-param name="presdata" select="$PresData"/>
						<xsl:with-param name="max_length">30</xsl:with-param>
					</xsl:call-template>
		</xsl:template>




		<xsl:template name="CorporateBO.CorpMiscellaneousInfo.str5_alt1">
				<xsl:call-template name="label_alternate">
					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str5']"/>
					<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str5_alt1</xsl:with-param>
					<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CorpMiscellaneousInfo.str5_alt1</xsl:with-param>

				</xsl:call-template>
				</xsl:template>

                <!--Tracker 113227 changes Ends-->
		<xsl:template name="CorporateBO.corp_Key">
		<xsl:choose>
	    <xsl:when test= "normalize-space($keyGeneration)='Reserved' or normalize-space($keyGeneration)='Both' and (normalize-space($corporateURL)='' or normalize-space($entityCreflg) != 'Y')">
		<xsl:call-template name="lookup">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.corp_Key']"/>
			<xsl:with-param name="elename">CorporateBO.corp_Key</xsl:with-param>
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.corp_Key</xsl:with-param>
			<xsl:with-param name="buttonone_fnc">openReservation('CorporateBO.corp_Key','Corporate')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearReservation('CorporateBO.corp_Key')</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="fn_onKeyPress">checkKeys()</xsl:with-param>
			<xsl:with-param name="toUpperCase">false</xsl:with-param>
		    <!-- Changes done by sonali for 286045 Begin -->
			<xsl:with-param name="fn_onBlur">checkStatus('CorporateBO.corp_Key',keyGeneration);txtLimit_CIF(this,"CorporateBO.corp_Key","CIF ID");</xsl:with-param>
		    <!-- Changes done by sonali for 286045 End -->
		</xsl:call-template>
		</xsl:when>
	    <xsl:when test= "normalize-space($keyGeneration)='Manual' and (normalize-space($corporateURL)='' or normalize-space($entityCreflg) != 'Y')">
			<xsl:call-template name="label">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.corp_Key']"/>
			<xsl:with-param name="selectname">CorporateBO.corp_Key</xsl:with-param>
			<xsl:with-param name="selectdisp">CorporateBO.corp_Key</xsl:with-param>
				<xsl:with-param name="ele_name">CorporateBO.corp_Key</xsl:with-param>
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.corp_Key</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		    <!-- Changes done by sonali for 286045 Begin -->
			<xsl:with-param name="fn_onBlur">checkStatus('CorporateBO.corp_Key',keyGeneration);txtLimit_CIF(this,"CorporateBO.corp_Key","CIF ID");</xsl:with-param>
		    <!-- Changes done by sonali for 286045 End -->
			<xsl:with-param name="fn_onKeyPress">checkKeys()</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.corp_Key']"/>
			<xsl:with-param name="selectname">CorporateBO.corp_Key</xsl:with-param>
			<xsl:with-param name="selectdisp">CorporateBO.corp_Key</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.corp_Key</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.corp_Key</xsl:with-param>
			<xsl:with-param name="read_val">true</xsl:with-param>
			<xsl:with-param name="IsMandatory" select="No"/>
		<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="fn_onKeyPress">checkKeys()</xsl:with-param>
		    <!-- Changes done by sonali for 286045 Begin -->
			<xsl:with-param name="fn_onBlur">checkStatus('CorporateBO.corp_Key',keyGeneration);txtLimit_CIF(this,"CorporateBO.corp_Key","CIF ID");</xsl:with-param>
		    <!-- Changes done by sonali for 286045 End -->
		</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		</xsl:template>

<!--ERPBOCF1:TRACKER:113259:BEGINOFCHANGES(HIJRI)-->
<!-- declaring template Preferred Calendar-->
<xsl:template name="CorporateBO.preferredCalendar">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.preferredCalendar']"/>
		<xsl:with-param name="selectdisp">CorporateBO.preferredCalendar</xsl:with-param>
		<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.preferredCalendar</xsl:with-param>
		<xsl:with-param name="choice_name">CorporateBO.preferredCalendar</xsl:with-param>
		<xsl:with-param name="max_length">50</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
</xsl:template>
<!--ERPBOCF1:TRACKER:113259:ENDOFCHANGES(HIJRI)-->





			<xsl:template name="CorporateBO.relationship_StartDate">
				<xsl:call-template name="label">
					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.relationship_StartDate']"/>
					<xsl:with-param name="selectname">CorporateBO.relationship_StartDate</xsl:with-param>
					<xsl:with-param name="selectdisp">CorporateBO.relationship_StartDate</xsl:with-param>
					<xsl:with-param name="ele_name">CorporateBO.relationship_StartDate</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
					<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.relationship_StartDate</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
					<!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
					<!-- calling the function isGregDate for on blur functionality-->
					<xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.relationship_StartDate");</xsl:with-param>
			                <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
				</xsl:call-template>
			</xsl:template>




		<xsl:template name="CorporateBO.short_Name">
			<xsl:call-template name="label">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.short_Name']"/>
				<xsl:with-param name="selectname">CorporateBO.short_Name</xsl:with-param>
				<xsl:with-param name="selectdisp">CorporateBO.short_Name</xsl:with-param>
				<xsl:with-param name="ele_name">CorporateBO.short_Name</xsl:with-param>
				<xsl:with-param name="max_length">10</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_Name</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
				<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
				<xsl:with-param name="max_length">10</xsl:with-param>
			</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.keyContact_PersonName">
			<xsl:call-template name="label">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.keyContact_PersonName']"/>
				<xsl:with-param name="selectname">CorporateBO.keyContact_PersonName</xsl:with-param>
				<xsl:with-param name="selectdisp">CorporateBO.keyContact_PersonName</xsl:with-param>
				<xsl:with-param name="ele_name">CorporateBO.keyContact_PersonName</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.keyContact_PersonName</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
				<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
				<xsl:with-param name="presdata" select="$PresData"/>
				<xsl:with-param name="max_length">30</xsl:with-param>
			</xsl:call-template>
		</xsl:template>




		<xsl:template name="CorporateBO.priority">
			<xsl:call-template name="mdrpdown">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.priority']"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
				<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.priority</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
				<xsl:with-param name="selectdisp">CorporateBO.priority</xsl:with-param>
				<xsl:with-param name="search_type">value</xsl:with-param>
				<xsl:with-param name="presdata" select="$PresData"/>
				<xsl:with-param name="choice_name">CorporateBO.priority</xsl:with-param>
				<xsl:with-param name="max_length">30</xsl:with-param>
			</xsl:call-template>
		</xsl:template>

		<!--CGCR16: Country of Birth changes by Bhaswanth M Begin -->
		
		    <xsl:template name="CorporateBO.StrUserField20">
	        <xsl:call-template name="mdrpdown">
	        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField20']"/>
	        <!-- <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.StrUserField20</xsl:with-param>-->
	        <xsl:with-param name="selectdisp">CorporateBO.StrUserField20</xsl:with-param>
	        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField20</xsl:with-param>
	        <xsl:with-param name="choice_name">CorporateBO.StrUserField20</xsl:with-param>
	        <xsl:with-param name="max_length">30</xsl:with-param>
	        <xsl:with-param name="search_type">url</xsl:with-param>
	        <!-- caching changes start -->
	        <xsl:with-param name="presdata" select="$PresData"/>
	        <!-- caching changes end -->
	        </xsl:call-template>
        </xsl:template>

<!--CGCR16: Country of Birth changes by Bhaswanth M End -->
		
<!--Equity DRC, Customization changes for CGCR22 starts-->	
	 <xsl:template name="CorporateBO.StrUserField30">
	        <xsl:call-template name="mdrpdown">
	        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField30']"/>
	        <xsl:with-param name="selectdisp">CorporateBO.StrUserField30</xsl:with-param>
	        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField30</xsl:with-param>
	        <xsl:with-param name="choice_name">CorporateBO.StrUserField30</xsl:with-param>
	        <xsl:with-param name="search_type">url</xsl:with-param>
	        <xsl:with-param name="presdata" select="$PresData"/>
	        </xsl:call-template>
        </xsl:template>
		
		 <xsl:template name="CorporateBO.amount3">
        <xsl:call-template name="amountlabel">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.amount3']"/>
        <xsl:with-param name="ele_name">CorporateBO.amount3</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.amount3</xsl:with-param>
       <xsl:with-param name="showdropdown">false</xsl:with-param>
	     <xsl:with-param name="linkshow">false</xsl:with-param>
		 <xsl:with-param name="fn_onBlur">formatCorpAmount("3_CorporateBO.amount3",boName+".Crncy_Code","N");</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
      
	<!--Begin of changes bcc category -->
						<xsl:template name="CorporateBO.StrUserField12">
                                 <xsl:call-template name="mdrpdown">
                                         <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField12']"/>
                                         <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField12</xsl:with-param>
                                         <xsl:with-param name="selectdisp">CorporateBO.StrUserField12</xsl:with-param>
                                         <xsl:with-param name="search_type">value</xsl:with-param>
                                         <xsl:with-param name="choice_name">CorporateBO.StrUserField12</xsl:with-param>
                                         <xsl:with-param name="presdata" select="$PresData"/>
                                 </xsl:call-template>
                         </xsl:template>

	<!--Equity DRC, Customization changes for CGCR22 end-->	
	<!--Equity DRC, Customization changes for CGCR46 starts-->	
	<xsl:template name="CorporateBO.StrUserField15">
				 <xsl:call-template name="mdrpdown">
					 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField15']"/>
					 <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField15</xsl:with-param>
					 <xsl:with-param name="selectdisp">CorporateBO.StrUserField15</xsl:with-param>
					 <xsl:with-param name="search_type">value</xsl:with-param>
					 <xsl:with-param name="choice_name">CorporateBO.StrUserField15</xsl:with-param>
					 <xsl:with-param name="presdata" select="$PresData"/>
				 </xsl:call-template>
			 </xsl:template>
			 
			 
			 <xsl:template name="CorporateBO.StrUserField16">
				 <xsl:call-template name="mdrpdown">
					 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField16']"/>
					 <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField16</xsl:with-param>
					 <xsl:with-param name="selectdisp">CorporateBO.StrUserField16</xsl:with-param>
					 <xsl:with-param name="search_type">value</xsl:with-param>
					 <xsl:with-param name="choice_name">CorporateBO.StrUserField16</xsl:with-param>
					 <xsl:with-param name="presdata" select="$PresData"/>
				 </xsl:call-template>
			 </xsl:template>
			 
			  <xsl:template name="CorporateBO.StrUserField21">
				 <xsl:call-template name="mdrpdown">
					 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField21']"/>
					 <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField21</xsl:with-param>
					 <xsl:with-param name="selectdisp">CorporateBO.StrUserField21</xsl:with-param>
					 <xsl:with-param name="search_type">value</xsl:with-param>
					 <xsl:with-param name="choice_name">CorporateBO.StrUserField21</xsl:with-param>
					 <xsl:with-param name="presdata" select="$PresData"/>
				 </xsl:call-template>
			 </xsl:template>
			 
			 <xsl:template name="CorporateBO.StrUserField22">
 	   <xsl:call-template name="label">
 		 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField22']"/>
 		 <xsl:with-param name="ele_name">CorporateBO.StrUserField22</xsl:with-param>
 		 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.StrUserField22</xsl:with-param>
 	    </xsl:call-template>
 	</xsl:template>
	
			 <xsl:template name="CorporateBO.StrUserField23">
 	   <xsl:call-template name="label">
 		 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField23']"/>
 		 <xsl:with-param name="ele_name">CorporateBO.StrUserField23</xsl:with-param>
 		 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.StrUserField23</xsl:with-param>
 	    </xsl:call-template>
 	</xsl:template>
	
	
	 <xsl:template name="CorporateBO.StrUserField24">
 	   <xsl:call-template name="label">
 		 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField24']"/>
 		 <xsl:with-param name="ele_name">CorporateBO.StrUserField24</xsl:with-param>
 		 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.StrUserField24</xsl:with-param>
 	    </xsl:call-template>
 	</xsl:template>
	
	
	 <xsl:template name="CorporateBO.StrUserField25">
 	   <xsl:call-template name="label">
 		 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField25']"/>
 		 <xsl:with-param name="ele_name">CorporateBO.StrUserField25</xsl:with-param>
 		 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.StrUserField25</xsl:with-param>
 	    </xsl:call-template>
 	</xsl:template>
	 
	 <xsl:template name="CorporateBO.StrUserField26">
 	   <xsl:call-template name="label">
 		 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField26']"/>
 		 <xsl:with-param name="ele_name">CorporateBO.StrUserField26</xsl:with-param>
 		 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.StrUserField26</xsl:with-param>
 	    </xsl:call-template>
 	</xsl:template>
	
	 <xsl:template name="CorporateBO.amount4">
        <xsl:call-template name="amountlabel">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.amount4']"/>
        <xsl:with-param name="ele_name">CorporateBO.amount4</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.amount4</xsl:with-param>
       <xsl:with-param name="showdropdown">false</xsl:with-param>
	     <xsl:with-param name="linkshow">false</xsl:with-param>
		 <xsl:with-param name="fn_onBlur">formatCorpAmount("3_CorporateBO.amount4",boName+".Crncy_Code","N");</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
		
		 <xsl:template name="CorporateBO.amount5">
        <xsl:call-template name="amountlabel">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.amount5']"/>
        <xsl:with-param name="ele_name">CorporateBO.amount5</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.amount5</xsl:with-param>
       <xsl:with-param name="showdropdown">false</xsl:with-param>
	     <xsl:with-param name="linkshow">false</xsl:with-param>
		 <xsl:with-param name="fn_onBlur">formatCorpAmount("3_CorporateBO.amount5",boName+".Crncy_Code","N");</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
		
		<xsl:template name="CorporateBO.riskRating">
	     <xsl:call-template name="mdrpdown">
		     <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.riskRating']"/>
		     <xsl:with-param name="selectDesc">riskRating</xsl:with-param>
		     <xsl:with-param name="selectdisp">CorporateBO.riskRating</xsl:with-param>
		     <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.riskRating</xsl:with-param>
		     <xsl:with-param name="search_type">value</xsl:with-param>
		     <xsl:with-param name="presdata" select="$PresData"/>
		     <xsl:with-param name="choice_name">CorporateBO.riskRating</xsl:with-param>
		     <xsl:with-param name="onchangefn"></xsl:with-param>
	    </xsl:call-template>
</xsl:template>
		
	<!--Equity DRC, Customization changes for CGCR46 ends-->	
		
	<xsl:template name="CorporateBO.StrUserField10">
				 <xsl:call-template name="mdrpdown">
					 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField10']"/>
					 <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField10</xsl:with-param>
					 <xsl:with-param name="selectdisp">CorporateBO.StrUserField10</xsl:with-param>
					 <xsl:with-param name="search_type">value</xsl:with-param>
					 <xsl:with-param name="choice_name">CorporateBO.StrUserField10</xsl:with-param>
					 <xsl:with-param name="onchangefn">setStrUserField10();</xsl:with-param>
					 <xsl:with-param name="presdata" select="$PresData"/>

				 </xsl:call-template>
			 </xsl:template>

 		<xsl:template name="CorporateBO.StrUserField8">
			<xsl:call-template name="label">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField8']"/>
				<xsl:with-param name="selectname">CorporateBO.StrUserField8</xsl:with-param>
				<xsl:with-param name="selectdisp">CorporateBO.StrUserField8</xsl:with-param>
				<xsl:with-param name="ele_name">CorporateBO.StrUserField8</xsl:with-param>
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.StrUserField8</xsl:with-param>
				<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
				<xsl:with-param name="max_length">100</xsl:with-param>
			</xsl:call-template>
		</xsl:template>

		<!-- Field Rationalization start -->
		<xsl:template name="CorporateBO.subSegment">
				<xsl:call-template name="mdrpdown">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.subSegment']"/>
				<xsl:with-param name="selectdisp">CorporateBO.subSegment</xsl:with-param>
				<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.subSegment</xsl:with-param>
				<xsl:with-param name="choice_name">CorporateBO.subSegment</xsl:with-param>
				<xsl:with-param name="max_length">30</xsl:with-param>
				<xsl:with-param name="search_type">value</xsl:with-param>
				<!-- caching changes start -->
				<xsl:with-param name="presdata" select="$PresData"/>
				<!-- caching changes end -->
				</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.segment">
				<xsl:call-template name="mdrpdown">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.segment']"/>
				<xsl:with-param name="selectdisp">CorporateBO.segment</xsl:with-param>
				<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.segment</xsl:with-param>
				<xsl:with-param name="choice_name">CorporateBO.segment</xsl:with-param>
				<xsl:with-param name="max_length">30</xsl:with-param>
				<xsl:with-param name="search_type">value</xsl:with-param>
				<!-- caching changes start -->
				<xsl:with-param name="presdata" select="$PresData"/>
				<!-- caching changes end -->
<!-- Core dependency changes start -->
   				<xsl:with-param name="onchangefn">changeSubSeg();</xsl:with-param>
<!-- Core dependency changes end -->
				</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.ChargeLevelCode">
<!--
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.ChargeLevelCode']"/>
		<xsl:with-param name="ele_name">CorporateBO.ChargeLevelCode</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.ChargeLevelCode</xsl:with-param>
		<xsl:with-param name="read_val">true</xsl:with-param>
				</xsl:call-template>
-->
<!-- Core dependency changes  begin -->
		     <xsl:call-template name="lookup">
		     <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.ChargeLevelCode']"/>
		     <xsl:with-param name="elename">CorporateBO.ChargeLevelCode</xsl:with-param>
		     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.ChargeLevelCode</xsl:with-param>
		     <xsl:with-param name="buttonone_fnc">categoryLookup('CHARGE_LEVEL_CODE', 'CorporateBO.ChargeLevelCode')</xsl:with-param>
		     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.ChargeLevelCode')</xsl:with-param>
		     <xsl:with-param name="checkASCII">false</xsl:with-param>
		    </xsl:call-template>
<!-- Core dependency changes end -->
		</xsl:template>
        <xsl:template name="LastUpdateDate">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='LastUpdateDate']"/>
			<xsl:with-param name="disable_val">true</xsl:with-param>
			<xsl:with-param name="ele_name">LastUpdateDate</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="ele_val">LastUpdateDate</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
			<!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
			<!-- calling the function isGregDate for on blur functionality-->
			<xsl:with-param name="fn_onBlur">isGregDate("3_LastUpdateDate");</xsl:with-param>
			<!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
		</xsl:call-template>
        </xsl:template>

		<xsl:template name="CorporateBO.principle_PlaceOperation">
			<xsl:call-template name="lookup">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.principle_PlaceOperation']"/>
				<xsl:with-param name="elename">CorporateBO.principle_PlaceOperation</xsl:with-param>
				<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.principle_PlaceOperation</xsl:with-param>
				<xsl:with-param name="max_length">50</xsl:with-param>
				<xsl:with-param name="code_req">true</xsl:with-param>
				<xsl:with-param name="buttonone_fnc">categoryLookupCode('COUNTRY', 'CorporateBO.principle_PlaceOperation','cntry_oper')</xsl:with-param>
				<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.principle_PlaceOperation')</xsl:with-param>
			</xsl:call-template>
		</xsl:template>

         <!-- Field Rationalization ends -->

		<!--changes for tracker id 349409 BEGIN-->
		<xsl:template name="CorporateBO.business_Type">
			<xsl:call-template name="lookup">
			 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.business_Type']"/>
			 <xsl:with-param name="elename">CorporateBO.business_Type</xsl:with-param>
			 <xsl:with-param name="eleval">CorporateBO.business_Type</xsl:with-param>
			 <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			 <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			 <xsl:with-param name="buttonone_fnc">categoryLookup('BUS_TYPE', 'CorporateBO.business_Type')</xsl:with-param>
			 <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.business_Type')</xsl:with-param>
			 <xsl:with-param name="checkASCII">false</xsl:with-param>
 		</xsl:call-template>
		</xsl:template>

		<!--changes for tracker id 349409 END-->

		<xsl:template name="CorporateBO.relationship_Type">
			<xsl:call-template name="mdrpdown">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.relationship_Type']"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
				<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.relationship_Type</xsl:with-param>
				<xsl:with-param name="choice_name">CorporateBO.relationship_Type</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
				<xsl:with-param name="selectdisp">CorporateBO.relationship_Type</xsl:with-param>
				<xsl:with-param name="search_type">value</xsl:with-param>
				<xsl:with-param name="presdata" select="$PresData"/>
				<xsl:with-param name="max_length">30</xsl:with-param>
			</xsl:call-template>
		</xsl:template>



		<!--changes for tracker id 349409 BEGIN-->
		<!-- <xsl:template name="CorporateBO.Subsector_Code">
		<xsl:call-template name="lookup">
					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Subsector_Code']"/>
					<xsl:with-param name="elename">CorporateBO.Subsector_Code</xsl:with-param>
					<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.subSector</xsl:with-param>
					<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
					<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
					<xsl:with-param name="buttonone_fnc">categoryLookup('SUB_SECTOR_CODE', 'CorporateBO.Subsector_Code')</xsl:with-param>
					<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.Subsector_Code')</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>
					<xsl:with-param name="code_req">true</xsl:with-param>
		</xsl:call-template>
		</xsl:template> -->

<!-- CRM102ST: Tracker ID:179582 Being of Change -->
		<!-- <xsl:template name="CorporateBO.sector">
		<xsl:call-template name="lookup">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.sector']"/>
				<xsl:with-param name="elename">CorporateBO.sector</xsl:with-param>
				<xsl:with-param name="eleval">CorporateBO.sector</xsl:with-param>
				<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
				<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
				<xsl:with-param name="buttonone_fnc">categoryLookup('SECTOR_CODE', 'CorporateBO.sector')</xsl:with-param>
				<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.sector')</xsl:with-param>
				<xsl:with-param name="checkASCII">false</xsl:with-param>
				<xsl:with-param name="code_req">true</xsl:with-param>
			</xsl:call-template>
		</xsl:template> -->
<!-- CRM102ST: Tracker ID:179582 End of Change -->
		<!--changes for tracker id 349409 END-->


<xsl:template name="CorporateBO.sector">
    <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.sector']"/>
        <xsl:with-param name="selectdisp">CorporateBO.sector</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.sector</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.sector</xsl:with-param>
        <xsl:with-param name="onchangefn">ISICValidation('SUB_SECTOR_CODE','.sector','.Subsector','SECTOR_CODE')</xsl:with-param> 
        <xsl:with-param name="search_type">value</xsl:with-param>
        <xsl:with-param name="presdata" select="$PresData"/>
    </xsl:call-template>
</xsl:template> 

 <xsl:template name="CorporateBO.Subsector_Code">
    <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Subsector_Code']"/>
        <xsl:with-param name="selectdisp">CorporateBO.Subsector_Code</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Subsector</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.Subsector_Code</xsl:with-param>
        <xsl:with-param name="onchangefn">ISICValidation('ISICP1','.Subsector','.StrUserField29','SUB_SECTOR_CODE')</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <xsl:with-param name="presdata" select="$PresData"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="CorporateBO.StrUserField29">
    <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField29']"/>
        <xsl:with-param name="selectdisp">CorporateBO.StrUserField29</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField29</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.StrUserField29</xsl:with-param>
        <xsl:with-param name="onchangefn">ISICValidation('ISICP2','.StrUserField29','.StrUserField7','ISICP1')</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <xsl:with-param name="presdata" select="$PresData"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="CorporateBO.StrUserField7">
    <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField7']"/>
        <xsl:with-param name="selectdisp">CorporateBO.StrUserField7</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField7</xsl:with-param>
        <xsl:with-param name="choice_name">.StrUserField7</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <xsl:with-param name="presdata" select="$PresData"/>
    </xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.StrUserField27">
    <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField27']"/>
        <xsl:with-param name="selectdisp">CorporateBO.StrUserField27</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField27</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.StrUserField27</xsl:with-param>
        <xsl:with-param name="onchangefn">ISICValidation('ISIC_DEMAND2','.StrUserField27','.StrUserField28','ISIC_DEMAND1')</xsl:with-param> 
        <xsl:with-param name="search_type">value</xsl:with-param>
        <xsl:with-param name="presdata" select="$PresData"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="CorporateBO.StrUserField28">
    <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField28']"/>
        <xsl:with-param name="selectdisp">CorporateBO.StrUserField28</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField28</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.StrUserField28</xsl:with-param>
        <!-- Changes for ISIC Subsector by James Starts  -->
        <!--<xsl:with-param name="onchangefn">ISICValidation('ISICP1','.Subsector','.StrField16','SUB_SECTOR_CODE')</xsl:with-param> -->
         <!-- Changes for ISIC Subsector by James ENDS  -->
        <xsl:with-param name="search_type">value</xsl:with-param>
        <xsl:with-param name="presdata" select="$PresData"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="CorporateBO.StrUserField18">
    <xsl:call-template name="mdrpdown">
    <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField18']"/>
    <xsl:with-param name="selectdisp">CorporateBO.StrUserField18</xsl:with-param>
    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField18</xsl:with-param>
    <xsl:with-param name="choice_name">CorporateBO.StrUserField18</xsl:with-param>
    <xsl:with-param name="search_type">value</xsl:with-param>
    <xsl:with-param name="presdata" select="$PresData"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="CorporateBO.StrUserField17">
    <xsl:call-template name="mdrpdown">
    <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField17']"/>
    <xsl:with-param name="selectdisp">CorporateBO.StrUserField17</xsl:with-param>
    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField17</xsl:with-param>
    <xsl:with-param name="choice_name">CorporateBO.StrUserField17</xsl:with-param>
    <xsl:with-param name="search_type">value</xsl:with-param>
    <xsl:with-param name="presdata" select="$PresData"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="CorporateBO.StrUserField11">
    <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField11']"/>
        <xsl:with-param name="selectdisp">CorporateBO.StrUserField11</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField11</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.StrUserField11</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <xsl:with-param name="presdata" select="$PresData"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="CorporateBO.StrUserField3">
    <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField3']"/>
        <xsl:with-param name="selectdisp">CorporateBO.StrUserField3</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField3</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.StrUserField3</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <xsl:with-param name="presdata" select="$PresData"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="CorporateBO.StrUserField19">
    <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField19']"/>
        <xsl:with-param name="ele_name">CorporateBO.StrUserField19</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.StrUserField19</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template name="CorporateBO.str1">
        <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.str1']"/>
            <xsl:with-param name="selectdisp">CorporateBO.str1</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.str1</xsl:with-param>
            <xsl:with-param name="choice_name">CorporateBO.str1</xsl:with-param>
            <xsl:with-param name="onchangefn">ISICValidation('SUB_SECTOR_CODE','.str1','.str10','SECTOR_CODE')</xsl:with-param>
            <xsl:with-param name="search_type">value</xsl:with-param>
            <xsl:with-param name="presdata" select="$PresData"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="CorporateBO.str10">
        <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.str10']"/>
            <xsl:with-param name="selectdisp">CorporateBO.str10</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.str10</xsl:with-param>
            <xsl:with-param name="choice_name">CorporateBO.str10</xsl:with-param>
            <xsl:with-param name="onchangefn">ISICValidation('ISICP1','.str10','.str11','SUB_SECTOR_CODE')</xsl:with-param>
            <xsl:with-param name="search_type">value</xsl:with-param>
            <xsl:with-param name="presdata" select="$PresData"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="CorporateBO.str11">
        <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.str11']"/>
            <xsl:with-param name="selectdisp">CorporateBO.str11</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.str11</xsl:with-param>
            <xsl:with-param name="choice_name">CorporateBO.str11</xsl:with-param>
            <xsl:with-param name="onchangefn">ISICValidation('ISICP2','.str11','.str12','ISICP1')</xsl:with-param>
            <xsl:with-param name="search_type">value</xsl:with-param>
            <xsl:with-param name="presdata" select="$PresData"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="CorporateBO.str12">
        <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.str12']"/>
            <xsl:with-param name="selectdisp">CorporateBO.str12</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.str12</xsl:with-param>
            <xsl:with-param name="choice_name">CorporateBO.str12</xsl:with-param>
            <xsl:with-param name="search_type">value</xsl:with-param>
            <xsl:with-param name="presdata" select="$PresData"/>
        </xsl:call-template>
    </xsl:template>


    <xsl:template name="CorporateBO.str13">
        <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.str13']"/>
            <xsl:with-param name="selectdisp">CorporateBO.str13</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.str13</xsl:with-param>
            <xsl:with-param name="choice_name">CorporateBO.str13</xsl:with-param>
            <xsl:with-param name="onchangefn">ISICValidation('ISIC_DEMAND2','.str13','.str14','ISIC_DEMAND1')</xsl:with-param>
            <xsl:with-param name="search_type">value</xsl:with-param>
            <xsl:with-param name="presdata" select="$PresData"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="CorporateBO.str14">
        <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.str14']"/>
            <xsl:with-param name="selectdisp">CorporateBO.str14</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.str14</xsl:with-param>
            <xsl:with-param name="choice_name">CorporateBO.str14</xsl:with-param>
            <xsl:with-param name="search_type">value</xsl:with-param>
            <xsl:with-param name="presdata" select="$PresData"/>
        </xsl:call-template>
    </xsl:template>



<!-- Field Rationalization changes start -->

			<xsl:template name="CorporateBO.primary_Service_Center">
		     <xsl:call-template name="lookup">
		     <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.primary_Service_Center']"/>
		     <xsl:with-param name="elename">CorporateBO.primary_Service_Center</xsl:with-param>
		     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.primary_Service_Center</xsl:with-param>
		     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		     <xsl:with-param name="buttonone_fnc">categoryLookup('SERVICE_OUTLET', 'CorporateBO.primary_Service_Center')</xsl:with-param>
		     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.primary_Service_Center')</xsl:with-param>
		     <xsl:with-param name="checkASCII">false</xsl:with-param>
         <xsl:with-param name="code_req">true</xsl:with-param>  <!-- change for callid 318169 -->
		     </xsl:call-template>
		 </xsl:template>

<!-- Field Rationalization changes end  -->

	<xsl:template name="Assigned_BackendID">
		<xsl:call-template name="listview">
		        <xsl:with-param name="res_name" select="$configLabels[@name='Assigned_BackendID']"/>
			<xsl:with-param name="ele_name">Assigned_BackendID</xsl:with-param>
			<xsl:with-param name="size">4</xsl:with-param>
			<xsl:with-param name="multiple">false</xsl:with-param>
			<xsl:with-param name="ondblclick">selfield(Assigned_BackendID, Available_BackendID, false)</xsl:with-param>
			<xsl:with-param name="selectname">Assigned_BackendID</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="Available_BackendID">
		<xsl:call-template name="listview">
			<xsl:with-param name="res_name" select="$configLabels[@name='Available_BackendID']"/>
			<xsl:with-param name="ele_name">Available_BackendID</xsl:with-param>
			<xsl:with-param name="size">4</xsl:with-param>
			<xsl:with-param name="multiple">false</xsl:with-param>
			<xsl:with-param name="ondblclick">selfield(Available_BackendID,Assigned_BackendID, true)</xsl:with-param>
			<xsl:with-param name="selectname">Available_BackendID</xsl:with-param>
	 	</xsl:call-template>
	</xsl:template>

		<!--changes for tracker id 349409 BEGIN-->
		<xsl:template name="CorporateBO.Crncy_Code">
			        <xsl:call-template name="lookup">
					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Crncy_Code']"/>
					<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Crncy_Code</xsl:with-param>
					<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Crncy_Code</xsl:with-param>
					<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
					<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
					<xsl:with-param name="buttonone_fnc">categoryLookup('CURRENCY', '<xsl:value-of select="$boName"/>.Crncy_Code')</xsl:with-param>
					<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Crncy_Code')</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>
				</xsl:call-template>
		</xsl:template>
		<!--changes for tracker id 349409 END-->

<!--changes for 371155 begin-->

		<xsl:template name="CorporateBO.region">
			        <xsl:call-template name="lookup">
					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.region']"/>
					<xsl:with-param name="elename">CorporateBO.region</xsl:with-param>
					<xsl:with-param name="eleval">CorporateBO.region</xsl:with-param>
					<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
					<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
					<xsl:with-param name="buttonone_fnc">categoryLookup('REGION', 'CorporateBO.region')</xsl:with-param>
					<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.region')</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>
					<xsl:with-param name="code_req">true</xsl:with-param>
				</xsl:call-template>
		</xsl:template> 

<!--changes for 371155 ends-->


		<xsl:template name="CorporateBO.business_Group">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.business_Group']"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.business_Group</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="selectdisp">CorporateBO.business_Group</xsl:with-param>
			<xsl:with-param name="choice_name">CorporateBO.business_Group</xsl:with-param>
			<xsl:with-param name="max_length">30</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>						        	         	<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
		</xsl:template>







		<xsl:template name="CorporateBO.legalEntity_Type_Code">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.legalEntity_Type_Code']"/>
			<xsl:with-param name="selectDesc">CorporateBO.legalEntity_Type</xsl:with-param>
			<xsl:with-param name="selectdisp">CorporateBO.legalEntity_Type_Code</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
<!-- Tracker 138976 start-->
			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.legalEntity_Type</xsl:with-param>
<!-- Tracker 138976 end-->
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="choice_name">CorporateBO.legalEntity_Type_Code</xsl:with-param>
			<xsl:with-param name="search_type">url</xsl:with-param>
			<xsl:with-param name="max_length">30</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
		</xsl:template>




		<xsl:template name="CorporateBO.CorpMiscellaneousInfo.str9">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str9']"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CorpMiscellaneousInfo.str9</xsl:with-param>
			<xsl:with-param name="choice_name">CorporateBO.CorpMiscellaneousInfo.str9</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="selectdisp">CorporateBO.CorpMiscellaneousInfo.str9</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="onchangefn">onCIFSelect();MakeEnable();</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
		</xsl:template>

		<xsl:template name="Corp">
			<xsl:call-template name="mdrpdown">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str1']"/>
				<xsl:with-param name="selectname">Corp</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
				<xsl:with-param name="choice_name">CorporateBO.CorpMiscellaneousInfo.str1</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
				<xsl:with-param name="selectdisp">CorporateBO.CorpMiscellaneousInfo.str1</xsl:with-param>
				<xsl:with-param name="search_type">value</xsl:with-param>
				<xsl:with-param name="onchangefn">clearvalinprimary();</xsl:with-param>
			</xsl:call-template>
		</xsl:template>





		<xsl:template name="CorporateBO.date_Of_Incorporation">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.date_Of_Incorporation']"/>
		<xsl:with-param name="selectname">CorporateBO.date_Of_Incorporation</xsl:with-param>
		<xsl:with-param name="selectdisp">CorporateBO.date_Of_Incorporation</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.date_Of_Incorporation</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.date_Of_Incorporation</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->

		<!-- TRACKER 106008 : BEGIN -->
		<xsl:with-param name="fn_onBlur">validateDOI();</xsl:with-param>
		<!-- TRACKER 106008 : END -->
		</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.registration_Number">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.registration_Number']"/>
		<xsl:with-param name="selectname">CorporateBO.registration_Number</xsl:with-param>
		<xsl:with-param name="selectdisp">CorporateBO.registration_Number</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.registration_Number</xsl:with-param>
		<xsl:with-param name="max_length">30</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.registration_Number</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->

		</xsl:call-template>
		</xsl:template>



		<xsl:template name="CorporateBO.relationship_CreatedBy">
		<xsl:call-template name="lookup">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.relationship_CreatedBy']"/>
		<xsl:with-param name="elename">CorporateBO.relationship_CreatedBy</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
		<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.relationship_CreatedBy</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
		<xsl:with-param name="max_length">30</xsl:with-param>
		<!--xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/-->
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		<!--xsl:with-param name="buttonone_fnc">openAgentLookup("RelCrea")</xsl:with-param-->
		<xsl:with-param name="buttonone_fnc">fnBlurCorpLookup('RelCrea')</xsl:with-param>
		<xsl:with-param name="buttontwo_fnc">clearLookupOne("RelCrea")</xsl:with-param>
		</xsl:call-template>
		</xsl:template>



		<xsl:template name="CorporateBO.dsaID">
		<xsl:call-template name="lookup">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.dsaID']"/>
		<xsl:with-param name="elename">CorporateBO.dsaID</xsl:with-param>
		<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.dsaID</xsl:with-param>
		<xsl:with-param name="max_length">12</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		<!--xsl:with-param name="buttonone_fnc">openAgentLookup("DSAID")</xsl:with-param-->
		<xsl:with-param name="buttonone_fnc">fnBlurCorpLookup('DSAID')</xsl:with-param>
		<xsl:with-param name="buttontwo_fnc">clearLookupOne("DSAID")</xsl:with-param>
		</xsl:call-template>
		</xsl:template>


		<xsl:template name="CorporateBO.taxID">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.taxID']"/>
		<xsl:with-param name="selectname">CorporateBO.taxID</xsl:with-param>
		<xsl:with-param name="selectdisp">CorporateBO.taxID</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.taxID</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.taxID</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->

		</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.entityClass">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.entityClass']"/>
		<xsl:with-param name="selectdisp">CorporateBO.entityClass</xsl:with-param>
		<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.entityClass</xsl:with-param>
		<xsl:with-param name="choice_name">CorporateBO.entityClass</xsl:with-param>
		<xsl:with-param name="max_length">30</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<!-- caching changes start -->
		<xsl:with-param name="presdata" select="$PresData"/>
		<!-- caching changes end -->
		</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.source_Of_Funds">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.source_Of_Funds']"/>
		<xsl:with-param name="selectname">CorporateBO.source_Of_Funds</xsl:with-param>
		<xsl:with-param name="selectdisp">CorporateBO.source_Of_Funds</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.source_Of_Funds</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.source_Of_Funds</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
		</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.average_AnnualIncome">
		<xsl:call-template name="amountlabel">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.average_AnnualIncome']"/>
		<xsl:with-param name="ele_name">CorporateBO.average_AnnualIncome</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.average_AnnualIncome</xsl:with-param>
		<xsl:with-param name="max_length">13</xsl:with-param>
		<xsl:with-param name="fncname">rate("3_CorporateBO.average_AnnualIncome",boName+".Crncy_Code",'<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
		<xsl:with-param name="showdropdown">false</xsl:with-param>
<!--  START  Changes for Tracker # 209607 -->
		<xsl:with-param name="fn_onBlur">formatCorpAmount("3_CorporateBO.average_AnnualIncome",boName+".crncy_Code","N");</xsl:with-param> 
<!--  END  Changes for Tracker # 209607 -->
		</xsl:call-template>
		</xsl:template>


		<!-- Field Rationalization start -->
		<xsl:template name="CorporateBO.SecondRMLogin_ID">
			<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.SecondRMLogin_ID']"/>
			<xsl:with-param name="elename">CorporateBO.SecondRMLogin_ID</xsl:with-param>
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.SecondRMLogin_ID</xsl:with-param>
			<xsl:with-param name="max_length">50</xsl:with-param>
			<xsl:with-param name="linkshow">true</xsl:with-param>
			<xsl:with-param name="fncname">agentDetails(document.getElementsByName('CorporateBO.SecondRMLogin_ID')[0].value);</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			<!--xsl:with-param name="buttonone_fnc">AccMgrLookup("SRM")</xsl:with-param-->
			<xsl:with-param name="buttonone_fnc">fnBlurCorpLookup("SRM")</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearLookupOne("SRM")</xsl:with-param>
			</xsl:call-template>
		   	<!-- Field Rationalization fix -->
		    	<input type="hidden" name="srmURL" value=""/>
			</xsl:template>

		<xsl:template name="CorporateBO.PrimaryRMLogin_ID">
                <xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.PrimaryRMLogin_ID']"/>
			<xsl:with-param name="elename">CorporateBO.PrimaryRMLogin_ID</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
		<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.PrimaryRMLogin_ID</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.PrimaryRMLogin_ID</xsl:with-param>
			<xsl:with-param name="max_length">50</xsl:with-param>
			<xsl:with-param name="linkshow">true</xsl:with-param>
			<xsl:with-param name="fncname">agentDetails(document.getElementsByName('CorporateBO.PrimaryRMLogin_ID')[0].value);</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			<!--xsl:with-param name="buttonone_fnc">AccMgrLookup("PRM")</xsl:with-param-->
			<xsl:with-param name="buttonone_fnc">fnBlurCorpLookup("PRM")</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearLookupOne("PRM")</xsl:with-param>
			</xsl:call-template>
		    	<!-- Field Rationalization fix -->
		    	<input type="hidden" name="prmURL" value=""/>
			</xsl:template>
		<!-- Field Rationalization end -->


<!--ML3 changes start-->
	<xsl:template name="CorporateBO.delinquency_Flag">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.delinquency_Flag']"/>
			<xsl:with-param name="selectdisp">CorporateBO.delinquency_Flag</xsl:with-param>
			<xsl:with-param name="selectname">CorporateBO.delinquency_Flag</xsl:with-param>
			<xsl:with-param name="choice_name">CorporateBO.delinquency_Flag</xsl:with-param>
			<xsl:with-param name="disable_val">true</xsl:with-param>
			<xsl:with-param name="max_length">1</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
	      	<xsl:with-param name="presdata" select="$PresData"/>
	      	<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="CorporateBO.Lang_Desc">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Lang_Desc']"/>
			<xsl:with-param name="selectdisp">CorporateBO.Lang_Desc</xsl:with-param>
			<xsl:with-param name="selectname">CorporateBO.Lang_Desc</xsl:with-param>
			<xsl:with-param name="choice_name">CorporateBO.Lang_Desc</xsl:with-param>
			<xsl:with-param name="max_length">30</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="CorporateBO.Health_Desc">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Health_Desc']"/>
			<xsl:with-param name="selectdisp">CorporateBO.Health_Desc</xsl:with-param>
			<xsl:with-param name="selectname">CorporateBO.Health_Desc</xsl:with-param>
			<xsl:with-param name="choice_name">CorporateBO.Health_Desc</xsl:with-param>
			<xsl:with-param name="max_length">30</xsl:with-param>
			<xsl:with-param name="search_type">url</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="CorporateBO.NativeLangCode">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.NativeLangCode']"/>
			<xsl:with-param name="selectdisp">CorporateBO.NativeLangCode</xsl:with-param>
			<xsl:with-param name="selectname">CorporateBO.NativeLangCode</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			<xsl:with-param name="choice_name">CorporateBO.NativeLangCode</xsl:with-param>
			<xsl:with-param name="search_type">url</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		 </xsl:call-template>
	 </xsl:template>

	<xsl:template name="CorporateBO.Cust_Swift_Code_Desc">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Cust_Swift_Code_Desc']"/>
			<xsl:with-param name="ele_name">CorporateBO.Cust_Swift_Code_Desc</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Swift_Code_Desc</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
<!--ML3 changes end-->

<!-- ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 start -->
<!-- Templates for 4 new dropdown fields -->

<xsl:template name="CorporateBO.islamic_banking_customer">
			<xsl:call-template name="mdrpdown">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.islamic_banking_customer']"/>
				<xsl:with-param name="selectdisp">CorporateBO.islamic_banking_customer</xsl:with-param>
				<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.islamic_banking_customer</xsl:with-param>
				<xsl:with-param name="choice_name">CorporateBO.islamic_banking_customer</xsl:with-param>
				<xsl:with-param name="onchangefn">hideFields()</xsl:with-param>
				<!-- <xsl:with-param name="onchangefn">disableConditionally('CorporateBO.islamic_banking_customer, 'CorporateBO.zakat_deduction');</xsl:with-param>-->
				<xsl:with-param name="search_type">value</xsl:with-param>
				<xsl:with-param name="presdata" select="$PresData"/>
			</xsl:call-template>
	</xsl:template>

	<xsl:template name="CorporateBO.zakat_deduction">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.zakat_deduction']"/>
					<xsl:with-param name="selectdisp">zakat_deduction</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.zakat_deduction</xsl:with-param>
					<xsl:with-param name="choice_name">CorporateBO.zakat_deduction</xsl:with-param>
					<!--<xsl:with-param name="onchangefn"> disableConditionally('<xsl:value-of select="$boName"/>. zakat_deduction, 'CorporateBO.zakat_deduction')</xsl:with-param>-->
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
	</xsl:template>

	<xsl:template name="CorporateBO.asset_classification">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.asset_classification']"/>
					<xsl:with-param name="selectdisp">CorporateBO.asset_classification</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.asset_classification</xsl:with-param>
					<xsl:with-param name="choice_name">CorporateBO.asset_classification</xsl:with-param>
					<!--<xsl:with-param name="onchangefn"> disableConditionally('<xsl:value-of select="$boName"/>. asset_classification, 'CorporateBO.zakat_deduction')</xsl:with-param>-->
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
	</xsl:template>

	<xsl:template name="CorporateBO.Customer_Level_Provisioning">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Customer_Level_Provisioning']"/>
					<xsl:with-param name="selectdisp">CorporateBO.Customer_Level_Provisioning</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Customer_Level_Provisioning</xsl:with-param>
					<xsl:with-param name="choice_name">CorporateBO.Customer_Level_Provisioning</xsl:with-param>
					<!--<xsl:with-param name="onchangefn"> disableConditionally('<xsl:value-of select="$boName"/>. Customer_Level_Provisioning, 'CorporateBO.zakat_deduction')</xsl:with-param>-->
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
	</xsl:template>


<!-- ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 end -->


		<xsl:template name="CorporateBO.corporateName_Native">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.corporateName_Native']"/>
			<xsl:with-param name="selectname">CorporateBO.corporateName_Native</xsl:with-param>
			<xsl:with-param name="selectdisp">CorporateBO.corporateName_Native</xsl:with-param>
			<xsl:with-param name="ele_name">CorporateBO.corporateName_Native</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.corporateName_Native</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
<!-- Fix for call id: 428627 Starts -->
			<xsl:with-param name="max_length">80</xsl:with-param>
<!-- Fix for call id: 428627 Ends -->
		</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.short_Name_Native">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.short_Name_Native']"/>
			<xsl:with-param name="selectname">CorporateBO.short_Name_Native</xsl:with-param>
			<xsl:with-param name="selectdisp">CorporateBO.short_Name_Native</xsl:with-param>
			<xsl:with-param name="ele_name">CorporateBO.short_Name_Native</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_Name_Native</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="max_length">10</xsl:with-param>
		</xsl:call-template>
		</xsl:template>



		<xsl:template name="CorporateBO.CorporateName_Native1">
 		<xsl:call-template name="label">
 			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorporateName_Native1']"/>
 			<xsl:with-param name="selectname">CorporateBO.CorporateName_Native1</xsl:with-param>
 			<xsl:with-param name="selectdisp">CorporateBO.CorporateName_Native1</xsl:with-param>
 			<xsl:with-param name="ele_name">CorporateBO.CorporateName_Native1</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CorporateName_Native1</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
<!-- Fix for call id: 428627 Starts -->
 			<xsl:with-param name="max_length">80</xsl:with-param>
<!-- Fix for call id: 428627 Ends -->
 		</xsl:call-template>
		</xsl:template>




		<xsl:template name="CorporateBO.Short_Name_Native1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Short_Name_Native1']"/>
			<xsl:with-param name="selectname">CorporateBO.Short_Name_Native1</xsl:with-param>
			<xsl:with-param name="selectdisp">CorporateBO.Short_Name_Native1</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
			<xsl:with-param name="ele_name">CorporateBO.Short_Name_Native1</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Short_Name_Native1</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="max_length">10</xsl:with-param>
		</xsl:call-template>
		</xsl:template>




		<xsl:template name="CorporateBO.CorpMiscellaneousInfo.str5">
				<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str5']"/>
			<xsl:with-param name="elename">CorporateBO.CorpMiscellaneousInfo.str5</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.CorpMiscellaneousInfo.str5</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
					<xsl:with-param name="buttonone_name" select="$configLabels[@name='BTN_LOOKUP']/@configLabel"/>
					<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
					<!-- Ticket#: 214635 FIX STARTS -->
					<!-- <xsl:with-param name="buttonone_fnc">openprimarylookup()</xsl:with-param> -->
					<xsl:with-param name="buttonone_fnc">fnBluropenEntityLookup("INTORDUCER")</xsl:with-param>
					<!-- Ticket#: 214635 FIX ENDS -->
			<xsl:with-param name="buttontwo_fnc">clearLookupOne("str5")</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>

		</xsl:call-template>

		<!-- changes for SPE tickets 10.2.12 starts -->
		<IFRAME name="hdifrm_empform" width="0" height="0" src="../common/js/SSOParameter.js"/>
		<!-- changes for SPE tickets 10.2.12 ends -->
		<!-- changes for SPE tickets 10.2.12 starts -->
		<!-- frame added for population of corporate fields -->
		<IFRAME name="hdifrm_rescifid" width="0" height="0" src="../common/js/SSOParameter.js"/>
		<!-- changes for SPE tickets 10.2.12 ends -->

		</xsl:template>


		<xsl:template name="CorporateBO.CorpMiscellaneousInfo.str2">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str2']"/>
			<xsl:with-param name="selectname">CorporateBO.CorpMiscellaneousInfo.str2</xsl:with-param>
			<xsl:with-param name="selectdisp">CorporateBO.CorpMiscellaneousInfo.str2</xsl:with-param>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str2</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CorpMiscellaneousInfo.str2</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
		</xsl:call-template>
		</xsl:template>


		<xsl:template name="CorporateBO.CorpMiscellaneousInfo.date1">
			<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.date1']"/>
			<xsl:with-param name="selectname">CorporateBO.CorpMiscellaneousInfo.date1</xsl:with-param>
			<!--<xsl:with-param name="selectdisp">CorporateBO.CorpMiscellaneousInfo.date1</xsl:with-param>-->
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.date1</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CorpMiscellaneousInfo.date1</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
<!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
<!-- calling the function isGregDate for on blur functionality-->
			<xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.CorpMiscellaneousInfo.date1");</xsl:with-param>
			<!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
			</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.CorpMiscellaneousInfo.str4">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str4']"/>
			<xsl:with-param name="selectname">CorporateBO.CorpMiscellaneousInfo.str4</xsl:with-param>
			<xsl:with-param name="selectdisp">CorporateBO.CorpMiscellaneousInfo.str4</xsl:with-param>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str4</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CorpMiscellaneousInfo.str4</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
		</xsl:call-template>
		</xsl:template>






		<xsl:template name="CorporateRepBO.last_Name">
		<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateRepBO.last_Name']"/>
			<xsl:with-param name="elename">CorporateRepBO.last_Name</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="eleval"><xsl:value-of select="$boNameRep"/>.last_Name</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="max_length">30</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			<!--Look up CR changes -->
			<xsl:with-param name="buttonone_fnc">fnBluropenLastLookup("Lastname")</xsl:with-param>
			<!--Look up CR changes -->
			<xsl:with-param name="IsMandatory">false</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearLookupOne("Lastname")</xsl:with-param>
		</xsl:call-template>
		</xsl:template>

		 <!--ticker id 206142 changes starts-->
		<xsl:template name="CorporateRepBO.last_Name_alt1">
		<xsl:call-template name="label_alternate">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateRepBO.last_Name']"/>
			<xsl:with-param name="ele_name">CorporateRepBO.last_Name_alt1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boNameRep"/>.last_Name_alt1</xsl:with-param>
		</xsl:call-template>
		</xsl:template>
		 <!--ticker id 206142 changes ends-->
		<xsl:template name="CorporateRepBO.entity_Type">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateRepBO.entity_Type']"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
		<xsl:with-param name="selectname"><xsl:value-of select="$boNameRep"/>.entity_Type</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="selectdisp">CorporateRepBO.entity_Type</xsl:with-param>
			<xsl:with-param name="choice_name">CorporateRepBO.entity_Type</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="IsMandatory">false</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="onchangefn">clearval();</xsl:with-param>
			<!--<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>-->
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
		</xsl:template>





		<xsl:template name="CorporateRepBO.dob">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateRepBO.dob']"/>
			<xsl:with-param name="selectname">CorporateRepBO.dob</xsl:with-param>
			<xsl:with-param name="selectdisp">CorporateRepBO.dob</xsl:with-param>
			<xsl:with-param name="ele_name">CorporateRepBO.dob</xsl:with-param>
			<!-- Fix for defect Ticket id : 204734 part d begin of changes -->
			<!--<xsl:with-param name="read_val">true</xsl:with-param>-->
			<!-- Fix for defect Ticket id : 204734 part d end of changes -->
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="ele_val"><xsl:value-of select="$boNameRep"/>.dob</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="IsMandatory">false</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
			<!-- calling the function isGregDate for on blur functionality-->
			<xsl:with-param name="fn_onBlur">isGregDate("3_CorporateRepBO.dob");</xsl:with-param>
			<!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
		</xsl:call-template>
		</xsl:template>




		<!--changes for tracker id 349409 BEGIN-->
		<xsl:template name="CorporateRepBO.designation">
				   <xsl:call-template name="lookup">
					  <xsl:with-param name="res_name" select="$configLabels[@name='CorporateRepBO.designation']"/>
						  <xsl:with-param name="elename">CorporateRepBO.designation</xsl:with-param>
						  <xsl:with-param name="eleval">CorporateRepBO.designation</xsl:with-param>
						   <!-- Field Rationalization changes start -->
								<!--   <xsl:with-param name="code_req">true</xsl:with-param> -->
										<!-- Field Rationalization changes end -->
								<!--  TRACKER ID:150150  CHANGES BEGIN   -->
										<xsl:with-param name="buttonone_name" select="$configLabels[@name='BTN_LOOKUP']/@configLabel"/>
										<xsl:with-param name="buttontwo_name" select="$configLabels[@name='BTN_CLEAR']/@configLabel"/>
										<xsl:with-param name="buttonone_fnc">categoryLookup('DESIGNATION', 'CorporateRepBO.designation')</xsl:with-param>
										<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateRepBO.designation')</xsl:with-param>
										<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
										<xsl:with-param name="checkASCII">false</xsl:with-param>
								<!--  TRACKER ID:150150  CHANGES END  -->
										<!-- CIF Changes for Caching Views : Start -->
						<xsl:with-param name="presdata" select="$PresData"/>
						<!-- CIF Changes for Caching Views : End -->
						       </xsl:call-template>
		</xsl:template>

		<!--changes for tracker id 349409 END-->




		<xsl:template name="CorporateRepBO.isSignatory">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateRepBO.isSignatory']"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="selectname"><xsl:value-of select="$boNameRep"/>.isSignatory</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="selectdisp">CorporateRepBO.isSignatory</xsl:with-param>
			<!--<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>-->
			<xsl:with-param name="choice_name">CorporateRepBO.isSignatory</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
<!--
			<xsl:with-param name="eleval">CorporateRepBO.isSignatory</xsl:with-param>
-->
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
		</xsl:template>

		<xsl:template name="addressCategory">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateRepBO.addressCateogry']"/>
			<xsl:with-param name="selectname">addressCategory</xsl:with-param>
			<xsl:with-param name="selectdisp">CorporateRepBO.addressCateogry</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="choice_name">CorporateRepBO.addressCateogry</xsl:with-param>
			<xsl:with-param name="IsMandatory">false</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<!-- TRACKER 97917 : BEGIN -->
			<xsl:with-param name="onchangefn">addrCheck();</xsl:with-param>
			<!-- TRACKER 97917 : END -->
			<xsl:with-param name="eleval">CorporateRepBO.addressCateogry</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateRepBO.cifAddrEntity">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateRepBO.cifAddrEntity']"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="selectname"><xsl:value-of select="$boNameRep"/>.cifAddrEntity</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="selectdisp">CorporateRepBO.cifAddrEntity</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="choice_name">CorporateRepBO.cifAddrEntity</xsl:with-param>
			<xsl:with-param name="onchangefn">onAddrSelect();</xsl:with-param>
			<xsl:with-param name="IsMandatory">false</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="eleval">CorporateRepBO.cifAddrEntity</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
		</xsl:template>

 	<xsl:template name="CorporateRepBO.entityKey">
 		<xsl:call-template name="label">
 			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateRepBO.entityKey']"/>
 			<xsl:with-param name="ele_name">CorporateRepBO.entityKey</xsl:with-param>
 			<xsl:with-param name="ele_val">CorporateRepBO.entityKey</xsl:with-param>
 			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
 			<xsl:with-param name="max_length">20</xsl:with-param>
			<xsl:with-param name="IsMandatory">false</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="read_val">true</xsl:with-param>
 		</xsl:call-template>
 	</xsl:template>



		<xsl:template name="CorporateBO.notes">
		<xsl:call-template name="mtextarea">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.notes']"/>
			<xsl:with-param name="mname">CorporateBO.notes</xsl:with-param>
			<xsl:with-param name="mwrap">on</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="mvalue"><xsl:value-of select="$boName"/>.notes</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="mrows">2</xsl:with-param>
			<xsl:with-param name="mcols">70</xsl:with-param>
			<xsl:with-param name="mcolspan">5</xsl:with-param>
			<xsl:with-param name="fn_onblur">txtLimit(this,75,"CorporateBO.notes","Notes")</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
		</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.AccessOwnerGroup">
			 <xsl:call-template name="mdrpdown">
				 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.accessOwnerGroup']"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
				 <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.accessOwnerGroup</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
				 <xsl:with-param name="selectdisp">CorporateBO.accessOwnerGroup</xsl:with-param>
				 <xsl:with-param name="search_type">value</xsl:with-param>
				 <xsl:with-param name="choice_name">CorporateBO.accessOwnerGroup</xsl:with-param>
				 <xsl:with-param name="onchangefn">setAccessOwnerGroup();</xsl:with-param>
				 <!-- CIF Changes for Caching Views : Start -->
				 <xsl:with-param name="presdata" select="$PresData"/>
				 <!-- CIF Changes for Caching Views : End -->

			 </xsl:call-template>
		 </xsl:template>
					<xsl:template name="CorporateBO.StrUserField13">
						 <xsl:call-template name="mdrpdown">
							 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField13']"/>
							 <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField13</xsl:with-param>
							 <xsl:with-param name="selectdisp">CorporateBO.StrUserField13</xsl:with-param>
							 <xsl:with-param name="search_type">value</xsl:with-param>
							 <xsl:with-param name="choice_name">CorporateBO.StrUserField13</xsl:with-param>
							 <xsl:with-param name="onchangefn">setStrUserField13();</xsl:with-param>
							 <xsl:with-param name="presdata" select="$PresData"/>

						 </xsl:call-template>
					 </xsl:template>
			 
			<!--  Kate Customization Communication mode Ends	-->

 <xsl:template name="CorporateBO.StrUserField9">
	<xsl:call-template name="mdrpdown">
	<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField9']"/>
	<xsl:with-param name="selectname">CorporateBO.StrUserField9</xsl:with-param>
	<xsl:with-param name="selectdisp">CorporateBO.StrUserField9</xsl:with-param>
	<xsl:with-param name="presdata" select="$PresData"/>
	<xsl:with-param name="search_type">value</xsl:with-param>
	<xsl:with-param name="choice_name">CorporateBO.StrUserField9</xsl:with-param>
						 </xsl:call-template>
					 </xsl:template>

		 <xsl:template name="CorporateBO.AccessOwnerSegment">
			 <xsl:call-template name="mdrpdown">
				 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.accessOwnerSegment']"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
				 <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.accessOwnerSegment</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
				 <xsl:with-param name="selectdisp">CorporateBO.accessOwnerSegment</xsl:with-param>
				 <xsl:with-param name="search_type">value</xsl:with-param>
				 <xsl:with-param name="choice_name">CorporateBO.accessOwnerSegment</xsl:with-param>
			 	<xsl:with-param name="onchangefn">setAccessOwnerSegment();</xsl:with-param>
				 <!-- CIF Changes for Caching Views : Start -->
				 <xsl:with-param name="presdata" select="$PresData"/>
				 <!-- CIF Changes for Caching Views : End -->

			 </xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.accessOwnerBC">
		<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.accessOwnerBC']"/>
			<xsl:with-param name="elename">CorporateBO.accessOwnerBC</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.accessOwnerBC</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<!--xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param-->
			<xsl:with-param name="buttonone_name" ><xsl:value-of select="$configLabels[@name='LOOKUP']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="buttontwo_name" ><xsl:value-of select="$configLabels[@name='CLEAR']/@configLabel"/></xsl:with-param>
			<!--xsl:with-param name="buttonone_fnc">openBCCodeLookup('accessOwnerBC')</xsl:with-param-->
			<xsl:with-param name="buttonone_fnc">fnBlurCorpLookup("accessOwnerBC")</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">setBCCodeValues('accessOwnerBC','','')</xsl:with-param>

		</xsl:call-template>
		</xsl:template>


		 <!-- GroupHouseHold Details Start :-->

		<xsl:template name="CorporateBO.PrimaryParentCompany">
			<xsl:call-template name="lookup">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.PrimaryParentCompany']"/>
				<xsl:with-param name="elename">CorporateBO.PrimaryParentCompany</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
		<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.PrimaryParentCompany</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
				<xsl:with-param name="max_length">50</xsl:with-param>
				<!--xsl:with-param name="buttonone_fnc">PrimCompanyLookup()</xsl:with-param-->
				<xsl:with-param name="buttonone_fnc">fnBlurCorpLookup("PrimCompany")</xsl:with-param>
				<xsl:with-param name="buttontwo_fnc">clearLookup()</xsl:with-param>
			</xsl:call-template>
		</xsl:template>
		<xsl:template name="CorporateBO.CountryOfPrincipalOperation">
			<xsl:call-template name="lookup">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CountryOfPrincipalOperation']"/>
				<xsl:with-param name="elename">CorporateBO.CountryOfPrincipalOperation</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
		<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.CountryOfPrincipalOperation</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
				<xsl:with-param name="max_length">50</xsl:with-param>
				<!-- Field Rationalization changes start-->
				<xsl:with-param name="code_req">true</xsl:with-param>
				<!-- Field Rationalization changes end-->
				<xsl:with-param name="buttonone_fnc">categoryLookupCode('COUNTRY', 'CorporateBO.CountryOfPrincipalOperation','cntry_oper')</xsl:with-param>
				<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.CountryOfPrincipalOperation')</xsl:with-param>
			</xsl:call-template>
		</xsl:template>
		<!-- GroupHouseHold Details End : -->


		<xsl:template name="CorporateBO.GroupHouseHold.GROUP_ID">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">CifGroupLookup()</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearLookUpMinor()</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel" />
		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="elename">CorporateBO.GroupHouseHold.GROUP_ID</xsl:with-param>
		<xsl:with-param name="eleval">CorporateBO.GroupHouseHold.GROUP_ID</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.GroupHouseHold.GROUP_ID']" />
		
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- templates for general - End -->
		<!-- CIF PhoneEmail Changes : Start -->
		<xsl:template name="CorporateBO.Address.preferredAddress">
			<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.preferredAddress']"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Address.preferredAddress</xsl:with-param>
			<xsl:with-param name="choice_name">CorporateBO.Address.preferredAddress</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="selectdisp">CorporateBO.Address.preferredAddress</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="defValByUrl">true</xsl:with-param>
	         	<xsl:with-param name="presdata" select="$PresData"/>
			</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.PhoneEmail.PhoneEmailType">
			<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='PREFERRED_PHONE']"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.PhoneEmail.PhoneEmailType</xsl:with-param>
			<xsl:with-param name="choice_name">CorporateBO.PhoneEmail.PhoneEmailType</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="selectdisp">CorporateBO.PhoneEmail.PhoneEmailType</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
	         	<xsl:with-param name="presdata" select="$PresData"/>
			</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.PhoneEmail.PhoneEmailType1">
			<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='PREFERRED_EMAIL']"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.PhoneEmail.PhoneEmailType1</xsl:with-param>
			<xsl:with-param name="choice_name">CorporateBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
			<xsl:with-param name="selectdisp">CorporateBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
	         	<xsl:with-param name="presdata" select="$PresData"/>
			</xsl:call-template>
		</xsl:template>

		<!-- CIF PhoneEmail Changes : End -->
	<!--WMS Field additions: start-->

	<xsl:template name="CorporateBO.RiskProfileScore">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.RiskProfileScore']"/>
			<xsl:with-param name="ele_name">CorporateBO.RiskProfileScore</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.RiskProfileScore</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="CorporateBO.RiskProfileExpiryDate">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.RiskProfileExpiryDate']"/>
			<xsl:with-param name="ele_name">CorporateBO.RiskProfileExpiryDate</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.RiskProfileExpiryDate</xsl:with-param>
			<!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
			<!-- calling the function isGregDate for on blur functionality-->
			<xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.RiskProfileExpiryDate");</xsl:with-param>
			<!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
		</xsl:call-template>
	</xsl:template>

	<!--WMS Field additions: end-->
	 <xsl:template name="CorporateBO.IsEbankingEnabled">
		 <xsl:call-template name="mdrpdown">
		 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.IsEbankingEnabled']"/>
		 <xsl:with-param name="selectname">CorporateBO.IsEbankingEnabled</xsl:with-param>
		 <xsl:with-param name="selectdisp">CorporateBO.IsEbankingEnabled</xsl:with-param>
		 <xsl:with-param name="ele_name">CorporateBO.IsEbankingEnabled</xsl:with-param>
		 <xsl:with-param name="choice_name">CorporateBO.IsEbankingEnabled</xsl:with-param>
		 <xsl:with-param name="defaultValue">N</xsl:with-param>
		 <xsl:with-param name="presdata" select="$PresData"/>
		 </xsl:call-template>
	 </xsl:template>
	<xsl:template name="CorporateBO.StrUserField14">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField14']"/>
		<xsl:with-param name="selectname">CorporateBO.StrUserField14</xsl:with-param>
		<xsl:with-param name="selectdisp">CorporateBO.StrUserField14</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="choice_name">CorporateBO.StrUserField14</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!-- Memo padding begin -->
	 <xsl:template name="MEMOPAD">
		<xsl:call-template name="hyperlink">
		<xsl:with-param name="res_name">MEMO PAD</xsl:with-param>
		<xsl:with-param name="fncname">showMemo('CorpEdit');</xsl:with-param>
		</xsl:call-template>
	  </xsl:template>
<!-- Memo padding end -->

<xsl:template match="*" mode="mode1" >
	<form name="frm2" method="post" >
				<!-- Tracker 129381  changes Start-->
				<!--Tracker id 113227 changes start-->
				<input type="hidden" name="altLocaleActv" value="{$altLocaleActv}"/>
 				<!--Tracker id 113227 changes end-->
 				<!-- Tracker 129381  changes End-->
				<!-- Equity bank DRC CGCR19 changes begin -->        
				<input type="hidden" name="ADDR_USERFIELD1" value=""/>
				<!-- Equity bank DRC CGCR19 changes end -->  
				<input type="hidden" name="operationType" value="{$operationType}"/>
				<input type="hidden" name="apprFlag" value="{$apprFlag}"/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
				<input type="hidden" name="editFlag" value="{$editFlag}"/>
				<input type="hidden" name="corpRepDate" value=""/>
<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
				<input type="hidden" name="hid_cifid" value=""/>
				<input type="hidden" name="hid_reservestatus" value=""/>

				<input type="hidden" name="hid_corporateURL" value="{$corporateURL}"/>
				<input type="hidden" name="hid_preferenceURL" value="{$preferenceURL}"/>
				<input type="hidden" value="{$isAutoGenKey}" name="isAutoGenKey"/>
				<input type="hidden" value="{$entityType}" name="entityType"/>

				<!-- Hidden variables for address tab -->
				<input type="hidden" name="address_type" value=""/>
				<input type="hidden" name="screenname" value="CIF"/>

				<input type="hidden" name="newGrpVal" value=""/>
				<input type="hidden" name="prim_id" value=""/>
				<input type="hidden" name="sec_id" value=""/>
				<!-- Begin of changes by Tracker : 141576 -->
				<input type="hidden" name="isQDE" value="Y"/>
				<!-- End of changes by Tracker : 141576 -->

				<!-- Added by Ramsurendar -->
				<input type="hidden" name="hRepSalutation" value=""/>
				<input type="hidden" name="hRepGender" value=""/>
				<input type="hidden" name="hRepPreName" value=""/>
				<!-- Added by Ramsurendar -->

				<!-- Fix for ticket 214674 start-->
				<input type="hidden" name="hAltname" value=""/>
				<!-- Fix for ticket 214674 ends-->

				<input type="hidden" name="addType" value=""/>
				<!--Access Control Changes-->
				<input type="hidden" name="accessOwnerGroup" value=""/>
				<input type="hidden" name="accessOwnerBC" value=""/>
				<!--End of Changes-->
				<input type="hidden" name="IsAddressProofRcvd" value=""/>
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
				<input type="hidden" name="hidSt" value=""/>
				<input type="hidden" name="addrID" value=""/>
				<input type="hidden" name="streetno" value=""/>
				<input type="hidden" name="town" value=""/>
				<input type="hidden" name="locality" value=""/>
				<input type="hidden" name="domicile" value=""/>
				<input type="hidden" name="entitytype" value=""/>
<!-- changes for Tracker ID 456637 - TOL ID 455246 -->
				<input type="hidden" name="vAddTypeLT" value=""/>
<!-- changes for Tracker ID 456637 - TOL ID 455246 -->
				<!-- <input type="hidden" name="address_proof" value=""/>
				<input type="hidden" name="home_phone" value=""/>
				<input type="hidden" name="work_phone" value=""/>
				<input type="hidden" name="cellno" value=""/>
				<input type="hidden" name="faxno" value=""/>
				<input type="hidden" name="email" value=""/>-->
				<input type="hidden" name="website" value=""/>
				<input type="hidden" name="mailstop" value=""/>
				<input type="hidden" name="streetname" value=""/>
				<input type="hidden" name="suburb" value=""/>
				<input type="hidden" name="AdrRemoved" value=""/>
				<input type="hidden" name="swiftcode" value=""/>
				<!-- CIF PhoneEmail Changes :Start-->
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
                <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin-->
                <input type="hidden" name="IsAddressVerified" value=""/>
                <!--Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end-->
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
				<!-- CIF PhoneEmail Changes : End-->
				<!-- <input type="hidden" name="work_phone_cntry" value=""/>
				<input type="hidden" name="work_phone_area" value=""/>
				<input type="hidden" name="work_phone_local" value=""/>

				<input type="hidden" name="home_phone_cntry" value=""/>
				<input type="hidden" name="home_phone_area" value=""/>
				<input type="hidden" name="home_phone_local" value=""/>

				<input type="hidden" name="cellno_cntry" value=""/>
				<input type="hidden" name="cellno_area" value=""/>
				<input type="hidden" name="cellno_local" value=""/>

				<input type="hidden" name="faxno_cntry" value=""/>
				<input type="hidden" name="faxno_area" value=""/>
				<input type="hidden" name="faxno_local" value=""/>

				<input type="hidden" name="telex_cntry" value=""/>
				<input type="hidden" name="telex_area" value=""/>
				<input type="hidden" name="telex_local" value=""/> -->

				<input type="hidden" name="extension" value=""/>

				<input type="hidden" name="adrURL" value=""/>
				<input type="hidden" name="EduRemoved" value=""/>

				<input type="hidden" name="addr_city_code" value=""/>
				<input type="hidden" name="addr_state_code" value=""/>
				<input type="hidden" name="addr_cntry_code" value=""/>

				<!-- Changes for Tracker # 98769 begin -->
				<input type="hidden" name="isMCEditedGeneral" value="N"/>
				<input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
				<input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
				<input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>
				<input type="hidden" name="getRole" value="{$getRole}"/>
				<!-- Changes for Tracker # 98769 end -->

				<input type="hidden" name="Bank_Entity1" value=""/>

				<!--abhinav start-->
				<input type="hidden" name="hidDocCode" value=""/>
				<input type="hidden" name="hidDocDescr" value=""/>
				<input type="hidden" name="hidDocTypeCode" value=""/>
				<input type="hidden" name="hidDocTypeDescr" value=""/>
				<input type="hidden" name="hidDocReceivedDate" value=""/>
				<input type="hidden" name="hidDocRemarks" value=""/>
				<input type="hidden" name="hidStatus" value=""/>
				<input type="hidden" name="hidIsMandatory" value=""/>
				<input type="hidden" name="hidScanRequired" value=""/>
				<input type="hidden" name="hidIsDocumentVerified" value=""/>
				<!--abhinav end-->
				<input type="hidden" name="hidIDIssuedOrg" value=""/><!-- Fix for ticket 296523 -->
				<input type="hidden" name="hidUserField5" value=""/>
				<input type="hidden" name="identifier_type_Code" value=""/>
				<input type="hidden" name="placeofissue" value=""/>
				<input type="hidden" name="countryofissue" value=""/>
		<input type="hidden" name="hidEDoc_IsDirty" value=""/>
				<input type="hidden" name="placeofissue_cat" value=""/>
				<input type="hidden" name="countryofissue_cat" value=""/>
				<input type="hidden" name="unique_id" value=""/>
				<input type="hidden" name="dateofissue" value=""/>
				<input type="hidden" name="validity_date" value=""/>
				<input type="hidden" name="IDRemoved" value=""/>
				<input type="hidden" name="hidEntityDocumentID" value=""/>
				<input type="hidden" name="hidEntityDocumentURL" value=""/>

				<input type="hidden" name="hidCorprepID" value=""/>
				<input type="hidden" name="hidEntID" value=""/>
			<!-- CIF Group Changes Start  -->
				<input type="hidden" name="cntry_oper" value=""/>
				<input type="hidden" name="GroupName" value=""/>
				<input type="hidden" name="GroupID" value=""/>
				<!-- MATPT Group Changes Start  -->
				<input type="hidden" name="GroupCode" value=""/>
				<!-- MATPT Group Changes end  -->
				<input type="hidden" name="GroupMasterID" value=""/>
				<input type="hidden" name="GroupURL" value=""/>
				<input type="hidden" name="PercentShare" value=""/>
				<input type="hidden" name="GroupRemoved" value=""/>
				<input type="hidden" name="GlobalRM" value=""/>
				<input type="hidden" name="Parent_Cif_id" value=""/>

				<!-- CRM101UB Start  -->
				<input type="hidden" name="Group_ID" value=""/>
				<input type="hidden" name="Prim_Grp_ID" value=""/>
 				<!-- CRM101UB End  -->

			<!-- CIF Group Changes End  -->

				<!-- Changes for 'WFlow' POC start -->
				<input type="hidden" name="IntWFID" value="{$IntWFID}"/>
				<!-- Changes for 'WFlow' POC end -->

		<input type="hidden" name="selAvailBackendID" value=""/>
		<input type="hidden" name="CorporateBO.DefaultAddressType" value=""/>
	   		<input type="hidden" name="hConcessionPsychoURL" value=""/>
				<input type="hidden" name="hConcessioncreditDiscountPercentage" value=""/>
				<input type="hidden" name="hConcessiondebitDiscountPercentage" value=""/>
				<input type="hidden" name="hConcessionwithTaxPercentage" value=""/>
				<input type="hidden" name="hConcessionwithTaxFloorLimit" value=""/>
				<input type="hidden" name="hConcessionpreferentialExpiryDate" value=""/>
				<input type="hidden" name="hConcessionCurrency" value=""/>
				<input type="hidden" name="hDeletedConcessionID" value=""/>
				<!--ticket id 219135 tracker id 131350 changes starts for toggle functionality-->
				 <input type="hidden" name="boName" value="{$boName}"/>
				<!--ticket id 219135 tracker id 131350 changes ends-->
				<input type="hidden" name="hid_CorporateBO.CorpMiscellaneousInfo.str50" value=""/>
				<input type="hidden" name="hid_CorporateBO.CorpMiscellaneousInfo.str4" value=""/>
				<!-- Change for DBS ticket 325152 -->
				<input type="hidden" name="SwiftAddressDetails" value=""/>

				<!--Tracker 129381 changes Start-->

				<input type="hidden" name="hid_CorporateBO.CorpMiscellaneousInfo.str4_alt1" value=""/>
				<input type="hidden" name="hid_CorporateRepBO.first_Name" value=""/>
				<input type="hidden" name="hid_CorporateRepBO.first_Name_alt1" value=""/>

				<!--Tracker 129381  changes Start-->

			<!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
				<input type="hidden" name="relationship_StartDate" value=""/>
				<input type="hidden" name="date_Of_Incorporation" value=""/>
				<input type="hidden" name="RiskProfileExpiryDate" value=""/>
				<input type="hidden" name="date1" value=""/>
				<input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
                        <!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :ENDOFCHANGES-->


<!--Hidden variables for StrUserFields for tracker id : 251240 / ticket id : 413744 start-->
<input type="hidden" name="StrUserField29" value=""/>
<!--Hidden variables for StrUserFields for tracker id : 251240 / ticket id : 413744 end-->



                <input type="hidden" name="IDTypeC1.txt_ID"/>
		<input type="hidden" name="IDTypeC1.txt_Issue_Date"/>
		<input type="hidden" name="IDTypeC1.txt_Valid_Date"/>
		<input type="hidden" name="IDTypeC1.txt_Issue_Place"/>


<!--Hidden variables for Str for tracker id : 251201 / ticket id : 413662 start-->
<input type="hidden" name="str11" value=""/>
<input type="hidden" name="str12" value=""/>
<input type="hidden" name="str13" value=""/>
<input type="hidden" name="str14" value=""/>
<!--Hidden variables for Str for tracker id : 251201 / ticket id : 413662 end-->

				<xsl:choose>
				<xsl:when test= "normalize-space($corpID)=''">
					 <input type="hidden" name="RecStatus" value="Create"/>
				</xsl:when>
				<xsl:otherwise>
					 <input type="hidden" name="RecStatus" value="Edit"/>
				</xsl:otherwise>
				</xsl:choose>


<!-- Tab in Tab -->


	<xsl:call-template name="BeginTabView">
		<xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
		<xsl:with-param name="tabPageHeight">1300</xsl:with-param>
		<xsl:with-param name="colSpan">20</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="BeginTabPage">
		<xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
		<xsl:with-param name="tabPageName">tpageCustDetails</xsl:with-param>
		<xsl:with-param name="tabPageDisplayNameRes" select="'General'"/>
		<xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
<!-- CRM11.0:TRACKER:113058:BEGINOFCHANGES -->
		<xsl:with-param name="isInnerToInnerTab" select="'Y'"/>
<!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->
<!-- fix for tracker id:337378  START-->
	    <xsl:with-param name="fn_tabSelect">focusFirstField1();</xsl:with-param>
	    <!-- fix for tracker id:337378  END-->
	</xsl:call-template>
	<xsl:call-template name="Begin"/>
	 	<xsl:call-template name="apply">
	 		<xsl:with-param name="apply_head">
	               <xsl:value-of select="$configLabels[@name='MLHeader']/@configLabel"/>
	 		</xsl:with-param>
	 		</xsl:call-template>
 <xsl:call-template name="End"/>



<!-- Changes for Amount fields. Tracker ID :113058 Start -->

<script>
	var DataArray = new Array;
	var DataCount = 0;
	<xsl:for-each select="/SRM/SRMData[@SRMDataSpace='Currency']/SRMComposite[@n='CurrencyRecordSet']/SRMRow">
	    DataArray[DataCount] = '<xsl:value-of select="./Z[@n='CurrencyBO.CurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.Format']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.NumberOfDecimals']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.MantissaSeperator']"/>'+"|"+'<xsl:value-of select="./Z[@n='CurrencyBO.DecimalSeperator']"/>';
	    DataCount++;
	</xsl:for-each>

 </script>

<!-- Changes for Amount fields. Tracker ID :113058 End -->



<!--CIF Changes for new fields added in QDE: Start-->
 <table width="100%" bgcolor='ffffff' cellspacing="0" vspace="0" hspace="0" border="0">



<!--Begin Of Changes, ME Phase 3 Tracker ID:131246
Changes by neha_goel03 for GCIF LookUp
Added this template for GCIF LookUp
-->

<!--Begin Of Changes for fix of Tracker ID:138340 -->
<xsl:choose>
	<xsl:when test= "$entityType='Customer'">
        <xsl:call-template name="Begin"/>
			<xsl:call-template name="CorporateBO.GCIFID"/>
	<xsl:call-template name="End"/>
	</xsl:when>
</xsl:choose>

<!--End Of Changes for fix of Tracker ID:138340  -->
<!--End of changes by neha_goel03 for GCIF LookUp-->


        <xsl:call-template name="Begin"/>
               		<xsl:call-template name="CorporateBO.corporate_Name"/>
               		<xsl:call-template name="CorporateBO.corp_Key"/>
       	 <xsl:call-template name="End"/>



       	 <xsl:call-template name="Begin"/>
       		<xsl:call-template name="CorporateBO.short_Name"/>
       		<xsl:call-template name="CorporateBO.relationship_StartDate"/>
       	 <xsl:call-template name="End"/>

       	 <xsl:call-template name="Begin"/>
       		<xsl:call-template name="CorporateBO.keyContact_PersonName"/>
       		<xsl:call-template name="CorporateBO.priority"/>
       	<xsl:call-template name="End"/>

       <!--  Tracker ID 100035 Begin of Changes -->
	 <xsl:call-template name="Begin"/>
		<xsl:call-template name="CorporateBO.segment"/>
		<xsl:call-template name="CorporateBO.subSegment"/>
	 <xsl:call-template name="End"/>
       <!--  Tracker ID 100035 End of Changes -->

       	 <xsl:call-template name="Begin"/>
       		<xsl:call-template name="CorporateBO.principle_PlaceOperation"/>
       		<xsl:call-template name="CorporateBO.legalEntity_Type_Code"/>

       	 <xsl:call-template name="End"/>

       	<xsl:call-template name="Begin"/>
       	 	<xsl:call-template name="CorporateBO.date_Of_Incorporation"/>
       	 <xsl:call-template name="CorporateBO.business_Type"/>

       	 <xsl:call-template name="End"/>

       	 <xsl:call-template name="Begin"/>
       	 	<xsl:call-template name="CorporateBO.business_Group"/>
       	 	<xsl:call-template name="CorporateBO.notes"/>
       	 <xsl:call-template name="End"/>
       	 <xsl:call-template name="Begin"/>
	  	         	 	<xsl:call-template name="CorporateBO.registration_Number"/>
	  	          	 	<xsl:call-template name="CorporateBO.region"/>
  	 <xsl:call-template name="End"/>

	  	 <xsl:call-template name="Begin"/>
			  	 <xsl:call-template name="CorporateBO.relationship_CreatedBy"/>
			   	 <xsl:call-template name="CorporateBO.relationship_Type"/>

  	 <xsl:call-template name="End"/>

<!--ML3 changes start-->
	  	 <xsl:call-template name="Begin"/>
	       		<xsl:call-template name="CorporateBO.Lang_Desc"/>
	       		<xsl:call-template name="CorporateBO.Health_Desc"/>
	 <xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
	       		<xsl:call-template name="CorporateBO.NativeLangCode"/>
	       		<xsl:call-template name="CorporateBO.Cust_Swift_Code_Desc"/>
	 <xsl:call-template name="End"/>
<!--ML3 changes end-->

 <xsl:call-template name="Begin"/> <!-- code changes starts for CallId:580758 -->
	 <xsl:call-template name="CorporateBO.sector"/>
	 <!-- code changes starts for CallId:580758 --> 
	 <xsl:call-template name="CorporateBO.Subsector_Code"/> 
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/> 
	<xsl:call-template name="CorporateBO.StrUserField29"/>
	<xsl:call-template name="CorporateBO.StrUserField7"/> 
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/> 
	<xsl:call-template name="CorporateBO.StrUserField27"/>
	<xsl:call-template name="CorporateBO.StrUserField28"/> 
<xsl:call-template name="End"/>		 
<xsl:call-template name="Begin"/> 
	<xsl:call-template name="CorporateBO.StrUserField18"/>
	<xsl:call-template name="CorporateBO.StrUserField17"/> 
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/> 
	<xsl:call-template name="CorporateBO.StrUserField11"/>
	<xsl:call-template name="CorporateBO.StrUserField3"/> 
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/> 
	<xsl:call-template name="CorporateBO.StrUserField19"/> 
<xsl:call-template name="End"/>

      <xsl:call-template name="Begin"/>
	         		<xsl:call-template name="CorporateBO.dsaID"/>
	         		<xsl:call-template name="CorporateBO.taxID"/>
       	 <xsl:call-template name="End"/>

       <xsl:call-template name="Begin"/>
	  	         		<xsl:call-template name="CorporateBO.source_Of_Funds"/>
	  	         		<xsl:call-template name="CorporateBO.entityClass"/>
       	 <xsl:call-template name="End"/>



       	 <xsl:call-template name="Begin"/>
	  		<xsl:call-template name="CorporateBO.average_AnnualIncome"/>
	  		<xsl:call-template name="CorporateBO.Crncy_Code"/>
  	 <xsl:call-template name="End"/>

         <!-- TRACKER ID 124192 CHANGES BEGIN -->
         <!-- Add a condition to call the templates only for Customer QDE screen -->
         <xsl:choose>
         <xsl:when test= "(normalize-space($corporateURL)='') and $entityType='Customer'">
         <!-- TRACKER ID 124192 CHANGES END -->

          	 <xsl:call-template name="Begin"/>
<!-- ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 start -->
	 <!-- Call Templates for 4 new dropdown fields -->
	     <xsl:call-template name="CorporateBO.islamic_banking_customer"/>
	     <xsl:call-template name="CorporateBO.zakat_deduction"/>
	 <xsl:call-template name="End"/>


	 <xsl:call-template name="Begin"/>
	     <xsl:call-template name="CorporateBO.asset_classification"/>
	     <xsl:call-template name="CorporateBO.Customer_Level_Provisioning"/>
	 <xsl:call-template name="End"/>
	  <xsl:call-template name="Begin"/>

<!-- ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 end -->

	<!--ERPBOCF1:TRACKER:113259:BEGINOFCHANGES(HIJRI)-->
	       <xsl:call-template name="Begin"/>
	       	<xsl:call-template name="CorporateBO.preferredCalendar"/>
	<!-- TRACKER ID 124192 CHANGES BEGIN -->
	</xsl:when>
	</xsl:choose>
	<!-- TRACKER ID 124192 CHANGES END -->
	  	<xsl:call-template name="CorporateBO.ChargeLevelCode"/>
  	 <xsl:call-template name="End"/>
 <!--WMS Field additions: start-->
	<xsl:call-template name="Begin"/>
	  	 <xsl:call-template name="CorporateBO.primary_Service_Center"/>

		<xsl:call-template name="CorporateBO.RiskProfileExpiryDate"/>
	<xsl:call-template name="End"/>
<!--WMS Field additions: end-->
<!-- Field additions Constitution code: end-->
       	 <xsl:call-template name="Begin"/>
			<xsl:call-template name="CorporateBO.StrUserField9"/>
			<xsl:call-template name="CorporateBO.StrUserField13"/>
		
       	 <xsl:call-template name="End"/>
	 <xsl:call-template name="Begin"/>
		<xsl:call-template name="CorporateBO.StrUserField10"/>	
		<xsl:call-template name="CorporateBO.StrUserField8"/>
	 <xsl:call-template name="End"/>
       	 <xsl:call-template name="Begin"/>
			<xsl:call-template name="CorporateBO.RiskProfileScore"/>
		    <xsl:call-template name="LastUpdateDate"/>
       	 <xsl:call-template name="End"/>
		 	  <!--CGCR16: Country of Birth changes by Bhaswanth M Begin -->
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.StrUserField20"/>
<xsl:call-template name="End"/>
<!--CGCR16: Country of Birth changes by Bhaswanth M End -->
<!--Equity DRC, Customization changes for CGCR22 starts-->	
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.StrUserField30"/>
<xsl:call-template name="CorporateBO.amount3"/>
<xsl:call-template name="End"/>
<!--Equity DRC, Customization changes for CGCR22 end-->	

<!--Equity DRC, Customization changes for CGCR46 starts-->	
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.StrUserField15"/>
<xsl:call-template name="CorporateBO.StrUserField16"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.StrUserField21"/>
<xsl:call-template name="CorporateBO.StrUserField22"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.StrUserField23"/>
<xsl:call-template name="CorporateBO.StrUserField24"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.amount4"/>
<xsl:call-template name="CorporateBO.amount5"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.StrUserField25"/>
<xsl:call-template name="CorporateBO.StrUserField26"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.riskRating"/>

<xsl:call-template name="End"/>


<!--Equity DRC, Customization changes for CGCR46 end-->	

<!-- Memo pad begin -->
<xsl:choose>
	<xsl:when test= "not(normalize-space($corporateURL)='') and $entityType='Customer'">
	<xsl:call-template name="Begin"/>
		<xsl:call-template name="MEMOPAD"/>
	<xsl:call-template name="End"/>
	</xsl:when>
</xsl:choose>
<!-- Memo pad end -->
<xsl:variable name="MULTI_LING"><xsl:value-of select="$configLabels[@name='MULTI_LING']/@configLabel"/></xsl:variable>
	<td FOR="CPD" class="LabelFont" colspan="5"><xsl:value-of select="$MULTI_LING"/>
	</td>
	<xsl:call-template name="Begin"/>
	<xsl:call-template name="CorporateBO.corporateName_Native">
	<xsl:with-param name="ele_name">CorporateBO.corporateName_Native</xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="CorporateBO.short_Name_Native">
	<xsl:with-param name="ele_name">CorporateBO.short_Name_Native</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	<xsl:call-template name="CorporateBO.CorporateName_Native1">
	<xsl:with-param name="ele_name">CorporateBO.CorporateName_Native1</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="CorporateBO.Short_Name_Native1">
	<xsl:with-param name="ele_name">CorporateBO.Short_Name_Native1</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head">
				Secondary Economic activity 
		</xsl:with-param>
	</xsl:call-template>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
		<xsl:call-template name="CorporateBO.str1"/>
		<xsl:call-template name="CorporateBO.str10"/>			
	<xsl:call-template name="End"/>


	<xsl:call-template name="Begin"/>
		<xsl:call-template name="CorporateBO.str11"/>
		<xsl:call-template name="CorporateBO.str12"/>				
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
		<xsl:call-template name="CorporateBO.str13"/>
		<xsl:call-template name="CorporateBO.str14"/>				
	<xsl:call-template name="End"/>


	<xsl:variable name="EBanking"><xsl:value-of select="$configLabels[@name='EBanking']/@configLabel"/></xsl:variable>
	<td FOR="CPD" class="LabelFont" colspan="5"><xsl:value-of select="$EBanking"/>
	</td>

	<!--Begin of changes bcc category -->
	<xsl:call-template name="Begin"/>
    <xsl:call-template name="CorporateBO.StrUserField12"/>        
    <xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
		<xsl:call-template name="CorporateBO.IsEbankingEnabled"/>
		<xsl:call-template name="CorporateBO.StrUserField14"/>
	<xsl:call-template name="End"/>

	<xsl:variable name="REL_MAN_INFO"><xsl:value-of select="$configLabels[@name='REL_MAN_INFO']/@configLabel"/></xsl:variable>
	<td FOR="CPD" class="LabelFont" colspan="5"><xsl:value-of select="$REL_MAN_INFO"/>

	</td>



	<xsl:call-template name="Begin"/>
	<xsl:call-template name="CorporateBO.PrimaryRMLogin_ID">
	<xsl:with-param name="ele_name">CorporateBO.PrimaryRMLogin_ID</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="CorporateBO.SecondRMLogin_ID">
	<xsl:with-param name="ele_name">CorporateBO.SecondRMLogin_ID</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="End"/>






      <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="2" cellpadding="0" vspace="0" hspace="0" >



<!--CIF satish - Primary Introducer -->

<xsl:call-template name="Begin"/>
	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head">
              <xsl:value-of select="$configLabels[@name='MLHEADER1']/@configLabel"/>
		</xsl:with-param>
		</xsl:call-template>
<xsl:call-template name="End"/>





            <xsl:call-template name="Begin"/>
            <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str9"/>
            <xsl:call-template name="Corp"/>
            <xsl:call-template name="End"/>









<xsl:call-template name="Begin"/>
    <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str2"/>
    <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str5"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.date1"/>
<xsl:call-template name="End"/>











	<xsl:call-template name="Begin"/>
		<xsl:call-template name="apply">
		<xsl:with-param name="apply_head">
              <xsl:value-of select="$configLabels[@name='MLHEADER2']/@configLabel"/>
		</xsl:with-param>
		</xsl:call-template>
     <xsl:call-template name="End"/>





        <xsl:call-template name="Begin"/>
			<xsl:call-template name="CorporateRepBO.entity_Type"/>
			<xsl:call-template name="CorporateRepBO.last_Name"/>
		<xsl:call-template name="End"/>




			<xsl:call-template name="Begin"/>
				<xsl:call-template name="CorporateRepBO.entityKey"/>
				<xsl:call-template name="CorporateRepBO.dob"/>
			<xsl:call-template name="End"/>


			<xsl:call-template name="Begin"/>
				<xsl:call-template name="CorporateRepBO.designation"/>
				<xsl:call-template name="CorporateRepBO.isSignatory"/>

			<xsl:call-template name="End"/>




				<xsl:call-template name="Begin"/>
				<xsl:call-template name="CorporateRepBO.cifAddrEntity"/>
				<xsl:call-template name="addressCategory"/>
				<xsl:call-template name="End"/>


		<td align="left">
		<xsl:call-template name="user_button">
			<xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='VIEW_DET']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="button_fnc">addrdetails();</xsl:with-param>
		</xsl:call-template>
		</td>
		<xsl:call-template name="End"/>








<!--Tracker 113227 changes BEGIN-->




 <!-- Identification : Begin -->







	<xsl:call-template name="Begin"/>
	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head">
              <xsl:value-of select="$configLabels[@name='MLHEADER4']/@configLabel"/>
		</xsl:with-param>
		</xsl:call-template>
		    <xsl:call-template name="End"/>


</table>

<table bgcolor="ffffff" align="center" cellpadding="0" width="100%">
	<tr align="left">
		<td>

		<xsl:call-template name="user_button">
						<xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='ADD_IDEN']/@configLabel"/></xsl:with-param>
						<!--tracker id 113227 starts-->
						<xsl:with-param name="button_fnc">addIdendetails(dualflag)</xsl:with-param>
						<!--tracker id 113227 ends-->
						</xsl:call-template>&#160;

						<xsl:call-template name="user_button">
						<xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='DELETE_IDEN']/@configLabel"/></xsl:with-param>
						<xsl:with-param name="button_fnc">removeIDdetails()</xsl:with-param>
				</xsl:call-template>&#160;



		</td>
	</tr>
</table>

 <xsl:call-template name="mainbody">
        <xsl:with-param name="tablename">EDocRecordSet</xsl:with-param>
        <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='MLHeader6']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="align">center</xsl:with-param>
        <xsl:with-param name="button">true</xsl:with-param>
        <xsl:with-param name="width">100%</xsl:with-param>
        <xsl:with-param name="name">...</xsl:with-param>
        <xsl:with-param name="UsrDataSpace">EntityDocument</xsl:with-param>
        <xsl:with-param name="rowhighlight">true</xsl:with-param>
            <xsl:with-param name="rsfilenm" select="$fileNameEDoc"/>
        <xsl:with-param name="jscriptfnc">,callID()</xsl:with-param>
        <xsl:with-param name="extra_colheader">Select</xsl:with-param>
        <xsl:with-param name="onClick">editIdentificationDetails()</xsl:with-param>
        <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
        <xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
        <xsl:with-param name="PrefixVal">2</xsl:with-param>
        </xsl:call-template>






 <table bgcolor="ffffff" align="center" cellpadding="0" width="100%">

     <xsl:call-template name="Begin"/>
	<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="addemptycell"/>
        <xsl:call-template name="End"/>





 </table>





<xsl:choose>
	<xsl:when test= "normalize-space($entityType)='Customer'">
<table width="100%" bgcolor='ffffff' cellspacing="2" vspace="0" hspace="0" border="0">

<xsl:call-template name="apply">
		 <xsl:with-param name="apply_head">
		  <b><xsl:value-of select="$configLabels[@name='MLHeader10']/@configLabel"/></b>
		  </xsl:with-param>
	</xsl:call-template>
</table>
<table width="100%" bgcolor='ffffff' cellspacing="2" vspace="0" hspace="0" border="0">
<TR>

		<TD nowrap="true" align="left" valign ="top" class="d1" style='width:22%'><xsl:value-of select="$configLabels[@name='Available_BackendID']/@configLabel"/></TD>
		<TD  width="20%"  align='left' >

			<xsl:call-template name="Assigned_BackendID"/>
		</TD>
		<TD align='center' width="10%">
		<TABLE align="center" >
		<TR>
		<TD align='center'>
		<input class='frmBttns' Type='button' value=' &gt; '
		onclick="selfield(Assigned_BackendID,Available_BackendID, false)"/>
		</TD>
		</TR>
		<TR>
		<TD align='center'>
		<input class='frmBttns' Type='button' value=' &lt; '
		onclick="selfield(Available_BackendID, Assigned_BackendID, true)"/>
		</TD>
		</TR>
		</TABLE>

		</TD>
		<TD  valign ="top" class="d1" style='width:26%'><xsl:value-of select="$configLabels[@name='Assigned_BackendID']/@configLabel"/></TD>

		<TD width="9%"  align='left'>
			<xsl:call-template name="Available_BackendID"/>
		</TD>
		<td>&#160;</td>
	</TR>

</table>
	</xsl:when>
</xsl:choose>
	 <!-- BEGIN  OF  CURRENCY CHANGES-->

<xsl:if test="$entityType='Customer'">

<table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >


<xsl:call-template name="Begin"/>
	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head">
              <xsl:value-of select="$configLabels[@name='MLHEADER7']/@configLabel"/>
		</xsl:with-param>
		</xsl:call-template>
		    <xsl:call-template name="End"/>





<tr align="left">
			<td>
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">Add Currency</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Add Currency']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">addConcession()</xsl:with-param>
				</xsl:call-template>&#160;
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">Remove Currency</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Remove Currency']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">removeConcession()</xsl:with-param>
				</xsl:call-template>
			</td>
		</tr>

</table>
<xsl:call-template name="mainbody">
		<xsl:with-param name="tablename">ConcessionRecordSet</xsl:with-param>
        <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='CURRENCYDET']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="align">Center</xsl:with-param>
		<xsl:with-param name="width">100%</xsl:with-param>
		<xsl:with-param name="IsInnerComposite">true</xsl:with-param>
		<xsl:with-param name="jscriptfnc">,rowHighLight_Concession()</xsl:with-param>
		<xsl:with-param name="UsrDataSpace">ConcessionInfo</xsl:with-param>
		<xsl:with-param name="button">true</xsl:with-param>
		<xsl:with-param name="name">...</xsl:with-param>
		<xsl:with-param name="onClick">editConcession()</xsl:with-param>
		<xsl:with-param name="rowhighlight">true</xsl:with-param>
		<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
		<xsl:with-param name="rsfilenm" select="$fileName_concession"/>
		<xsl:with-param name="extra_colheader">Select</xsl:with-param>
	</xsl:call-template>




	</xsl:if>

<!--Tracker 113227 changes BEGIN-->
	<!--Tracker 127218 changes BEGIN-->
	  <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="2" cellpadding="0" vspace="0" hspace="0" >
	  	<xsl:call-template name="apply">
	  		<xsl:with-param name="apply_head">
	  		<b><xsl:value-of select="$configLabels[@name='AccessControl']/@configLabel"/></b>
	  		</xsl:with-param>
	  	</xsl:call-template>
	  	<xsl:call-template name="Begin"/>
	  		<xsl:call-template name="CorporateBO.AccessOwnerGroup"/>
	  		<xsl:call-template name="CorporateBO.AccessOwnerSegment"/>
	  	<xsl:call-template name="End"/>
	  	<xsl:call-template name="Begin"/>
	  		<xsl:call-template name="CorporateBO.accessOwnerBC"/>
	  	<xsl:call-template name="End"/>

         </table>
         <!--Tracker 127218 changes BEGIN-->

	 <xsl:choose>
	<xsl:when test="normalize-space($altLocaleActv)='true'">
	<xsl:variable name="DUAL"><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>
	<!--ticket id 219135 tracker id 131350 changes starts-->
	<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
	<!--ticket id 219135 tracker id 131350 changes ends-->
		<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rowdual" name="rowdual">
		 <xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
		 <td onclick="Toggle('dual','all');" colspan = "5" NOWRAP="true" class="LabelFont">
		 <!-- changes for SPE tickets 10.2.12 starts -->
		 <A HREF="javascript:Toggle('DUAL','all');"><IMG onclick="Toggle('dual','all');" SRC="../Renderer/reports/images/minus.gif" ID="dualgif"
		  BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
		 <!-- changes for SPE tickets 10.2.12 ends -->
		 <label FOR="CPD" class="LabelFont"><xsl:value-of select="$DUAL"/>
		</label>
		 </td>
		 </tr>
	<!--ticket id 219135 tracker id 131350 changes starts-->
	</table>
	<!--ticket id 219135 tracker id 131350 changes ends-->

		 <DIV ID = 'native' STYLE= 'visibility:visible;'>

			<!--ticket id 219135 tracker id 131350 changes starts-->
			<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
			<!--ticket id 219135 tracker id 131350 changes ends-->
		 <TR ID='rowdual' name='rowdual'>
		 	<xsl:call-template name="CorporateBO.corporate_Name_alt1">
		 	</xsl:call-template>
		 	<xsl:call-template name="CorporateBO.short_Name_alt1">
		 	</xsl:call-template>

		 </TR>

		 <TR ID='rowdual' name='rowdual'>
			<xsl:call-template name="CorporateBO.keyContact_PersonName_alt1">
			</xsl:call-template>
			<xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str5_alt1">
			</xsl:call-template>



		 </TR>

		 <!-- Tracker 129316 Changes Start-->
		 <TR ID='rowdual' name='rowdual'>
		 <xsl:call-template name="CorporateRepBO.last_Name_alt1">
		 </xsl:call-template>
		 </TR>
		 <!-- Tracker 129316 Changes End-->
			<!--ticket id 219135 tracker id 131350 changes starts-->
			</table>
			<!--ticket id 219135 tracker id 131350 changes ends-->
		</DIV>
	 </xsl:when>

  </xsl:choose>
  <!--//Tracker 113227 changes Ends-->



	</table>


	<xsl:call-template name="EndTabPage"/>
<!-- Rachit CIF PhoneEmail changes: Start -->
<xsl:call-template name="BeginTabPage">
			    <xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
			    <xsl:with-param name="tabPageName">tpageCont3</xsl:with-param>
			    <xsl:with-param name="spanWidth">3</xsl:with-param>
			    <xsl:with-param name="isTabNameHardCoded">false</xsl:with-param>
			    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels[@name='CONTACT']"/>
			    <!-- fix for tracker id:337378  START-->
			    <xsl:with-param name="fn_tabSelect">focusFirstField1();</xsl:with-param>
			    <!-- fix for tracker id:337378  END-->
	    </xsl:call-template>

		<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabContactDetails</xsl:with-param>
				    <xsl:with-param name="tabPageHeight">220</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="BeginTabPage">
                    <xsl:with-param name="tabViewName">tabContactDetails</xsl:with-param>
                    <xsl:with-param name="tabPageName">tpageAddr</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameRes" select="'Address'"/>
                    <xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
                    <!-- fix for tracker id:337378  START-->
		    <xsl:with-param name="fn_tabSelect">focusFirstField1();</xsl:with-param>
		    <!-- fix for tracker id:337378  END-->
                </xsl:call-template>
                <xsl:call-template name="Begin"/>
			 	<xsl:call-template name="apply">
			 		<xsl:with-param name="apply_head">
			                <xsl:value-of select="$configLabels[@name='MLHeader11']/@configLabel"/>
			 		</xsl:with-param>
			 	</xsl:call-template>
                <xsl:call-template name="End"/>
<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
<tr ><td>
<table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
        <tr align="left">
        <td>
	      	<xsl:call-template name="CorporateBO.Address.preferredAddress"/>
	</td>
	<td>
	<xsl:call-template name="user_button_withText">
	<xsl:with-param name="button_name">ADD_ADDRESS</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='ADD_ADDRESS']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">addAddressdetails()</xsl:with-param>
        </xsl:call-template>&#160;

        <xsl:call-template name="user_button_withText">
	<xsl:with-param name="button_name">DELETE_ADDRESS</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='DELETE_ADDRESS']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">removeAddressdetails()</xsl:with-param>
        </xsl:call-template>&#160;

        <xsl:call-template name="user_button_withText">
	<xsl:with-param name="button_name">COPY_ADDRESS</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='COPY_ADDRESS']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">copyAddressdetails()</xsl:with-param>
        </xsl:call-template>&#160;
        <xsl:call-template name="user_button_withText">
	<xsl:with-param name="button_name">SWIFT_ADDRESS</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='SWIFT_ADDRESS']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">createSwiftAddress()</xsl:with-param>
        </xsl:call-template>&#160;

        </td>
      </tr>
</table>

    <xsl:call-template name="mainbody">
    <xsl:with-param name="tablename">AdrRecordSet</xsl:with-param>
    <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='ADDRESS']/@configLabel"/></xsl:with-param>
    <xsl:with-param name="align">center</xsl:with-param>
    <xsl:with-param name="button">true</xsl:with-param>
    <xsl:with-param name="width">100%</xsl:with-param>
    <xsl:with-param name="name">...</xsl:with-param>
    <xsl:with-param name="UsrDataSpace">Address</xsl:with-param>
    <xsl:with-param name="rowhighlight">true</xsl:with-param>
          <xsl:with-param name="rsfilenm" select="$fileNameAddr"/>
    <xsl:with-param name="jscriptfnc">,call()</xsl:with-param>
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
		    <!-- fix for tracker id:337378  START-->
		    <xsl:with-param name="fn_tabSelect">focusFirstField1();</xsl:with-param>
		    <!-- fix for tracker id:337378  END-->
                </xsl:call-template>
                <xsl:call-template name="Begin"/>
					 	<xsl:call-template name="apply">
					 		<xsl:with-param name="apply_head">
					                <xsl:value-of select="$configLabels[@name='MLHeader12']/@configLabel"/>
					 		</xsl:with-param>
					 	</xsl:call-template>
                <xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
      	<xsl:call-template name="CorporateBO.PhoneEmail.PhoneEmailType"/>
	<xsl:call-template name="CorporateBO.PhoneEmail.PhoneEmailType1"/>
<xsl:call-template name="End"/>
	<table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
	<td align="left">
        <xsl:call-template name="user_button_withText">
	<xsl:with-param name="button_name">ADD_PHONE_EMAIL</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Add Phone/Email']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">addPhoneEmail()</xsl:with-param>
        </xsl:call-template>&#160;

        <xsl:call-template name="user_button_withText">
	<xsl:with-param name="button_name">DELETE_PHONE_EMAIL</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Delete Phone/Email']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">removePhoneEmail()</xsl:with-param>
        </xsl:call-template>&#160;

        <xsl:call-template name="user_button_withText">
	<xsl:with-param name="button_name">COPY_PHONE_EMAIL</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Copy Phone/Email']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">copyPhoneEmail()</xsl:with-param>
        </xsl:call-template>&#160;
        </td>

</table>

    <xsl:call-template name="mainbody">
    <xsl:with-param name="tablename">PhoneEmailRecordSet</xsl:with-param>
    <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='PHONE']/@configLabel"/></xsl:with-param>
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

<!-- House hold CIF changes : Begin -->
<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
				    <xsl:with-param name="tabPageHeight">270</xsl:with-param>
		</xsl:call-template>
			<xsl:call-template name="BeginTabPage">
					<xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
					<xsl:with-param name="tabPageName">tpageHouseHolds</xsl:with-param>
					<xsl:with-param name="spanWidth">3</xsl:with-param>
					<xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
					<xsl:with-param name="tabPageDisplayNameRes">Group Details</xsl:with-param>
					<!-- fix for tracker id:337378  START-->
					<xsl:with-param name="fn_tabSelect">focusFirstField1();</xsl:with-param>
					<!-- fix for tracker id:337378  END-->
			</xsl:call-template>
			<xsl:call-template name="Begin"/>
								 	<xsl:call-template name="apply">
								 		<xsl:with-param name="apply_head">
								                <xsl:value-of select="$configLabels[@name='MLHeader13']/@configLabel"/>
								 		</xsl:with-param>
								 	</xsl:call-template>
                <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
			<xsl:if test="$allowMulti='Y'">
				<xsl:call-template name="CorporateBO.PrimaryParentCompany"/>
				<xsl:call-template name="CorporateBO.CountryOfPrincipalOperation"/>
			<xsl:call-template name="End"/>
		<table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
			<tr align="left">
			<td >
			<!-- 10.6 enhancements 
			<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">Create New Group</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Create New Group']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">createNewGroup()</xsl:with-param>
		   </xsl:call-template>&#160; -->

			<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_fnc">GroupLookup()</xsl:with-param>
				<xsl:with-param name="button_name">Link Group</xsl:with-param>
				<xsl:with-param name="button_text" select="$configLabels[@name='Link Group']/@configLabel" />
		   </xsl:call-template>&#160;

		   <xsl:call-template name="user_button_withText">
		   		<xsl:with-param name="button_name">Unlink Group</xsl:with-param>
		   		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Unlink Group']/@configLabel"/></xsl:with-param>
		   		<xsl:with-param name="button_fnc">unlinkGroup()</xsl:with-param>
		   </xsl:call-template>&#160;

			</td>
			</tr>
			<tr>

			<td>
		<xsl:call-template name="mainbody">
		<xsl:with-param name="tablename">GroupRecordSet</xsl:with-param>
		<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='List of Group']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="align">center</xsl:with-param>
		<xsl:with-param name="button">true</xsl:with-param>
		<xsl:with-param name="width">100%</xsl:with-param>
		<xsl:with-param name="name">...</xsl:with-param>
		<xsl:with-param name="UsrDataSpace">Group</xsl:with-param>
		<xsl:with-param name="rowhighlight">true</xsl:with-param>
	    <xsl:with-param name="rsfilenm" select="$fileNameGrp"/>
		<xsl:with-param name="jscriptfnc">,call()</xsl:with-param>
		<xsl:with-param name="extra_colheader">Select</xsl:with-param>
		<xsl:with-param name="onClick">editGroup()</xsl:with-param>
		<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
		<xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
		<xsl:with-param name="PrefixVal">2</xsl:with-param>
		</xsl:call-template>

			</td>
			</tr>
			<tr><td>
			 <tr><td>
			 <tr><td>
			 </td></tr>
			 </td></tr>
            </td></tr>
		</table>
		</xsl:if>
  <xsl:if test="$allowMulti='N'">
		<table>
			<tr><td>
				<xsl:call-template name="CorporateBO.PrimaryParentCompany" />
				<xsl:call-template name="CorporateBO.CountryOfPrincipalOperation" />
			</td></tr>
			<tr><td>
		    <xsl:call-template name="CorporateBO.GroupHouseHold.GROUP_ID" />
			</td></tr>
	</table>
	</xsl:if>
	<xsl:call-template name="EndTabPage"/>


	  <xsl:call-template name="EndTabView">
		                    <xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
		                    <xsl:with-param name="selectedTabPageName">tpageCustDetails</xsl:with-param>
         </xsl:call-template>

	</form>
<!--  START  Changes for Tracker # 209607 -->
        <p id="myPar"></p>
<!--  END  Changes for Tracker # 209607 -->
 <!-- Naved Changes start -->
    <form name="frm3"  method="post" action='../servlet/com.infy.cis.ui.admin.GroupHouseHoldForm?isPopup=Yes&amp;isLinked=Yes&amp;isEdit=Yes&amp;GroupHouseHoldFlag=G&amp;isNew=N&amp;details=null'>
		<input type="hidden" name="GroupName" value=""/>
	    <input type="hidden" name="PercentShare" value=""/>
		<input type="hidden" name="GlobalRM" value=""/>
		<!-- Recon from CRM10301BSUPP-Listing changes-->
		<input type="hidden" name="SubScreen" value="{$entityType}"/>
		<!-- Recon from CRM10301BSUPP-Listing changes-->		
		<input type="hidden" name="Name_Nat" value=""/>
		<input type="hidden" name="readMode" value="{$readMode}"/>
		<!-- Changes for Tracker # 98769 begin -->
		<input type="hidden" name="isMCEditedGeneral" value="N"/>
		<input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
		<input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
		<input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>
		<input type="hidden" name="getRole" value="{$getRole}"/>

		<!-- CRM101UB Start  -->
		<input type="hidden" name="Group_ID" value=""/>
		<input type="hidden" name="Prim_Grp_ID" value=""/>
		<!-- CRM101UB End  -->

		<!-- Changes for Tracker # 98769 end -->
	</form>
<!-- Naved Changes end -->
</xsl:template>

<xsl:template match="SRM">
	<xsl:for-each select=".">
		<xsl:call-template name="startTable"/>

			<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<xsl:apply-templates select="." mode="mode1"/>
			</table>
             	<xsl:call-template name="endTable"/>
       		</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
