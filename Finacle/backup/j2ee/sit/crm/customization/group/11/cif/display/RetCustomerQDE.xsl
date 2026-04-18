<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--importing variables wich hold the jvm properties-->
<!--IDENTIFICATION DOCUMENT CHANGES start, absolute url changed to relative url-->
<xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
<!--importing templates for widgets-->
<xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
<!--importing templates for tables,rows,cells,styles-->
<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
<xsl:import href="../Renderer/sales/display/FCRMApplFormDisplay.xsl"/>
<!--IDENTIFICATION DOCUMENT CHANGES end-->
<!--IDENTIFICATION DOCUMENT CHANGES start-->
	<xsl:param name="fileNameID"/>
	<!--tracker id 113227 starts-->
	<xsl:param name="altLocaleType"/>
	<xsl:param name="baseLocaleType"/>
	<xsl:param name="altLocaleActv"/>
        <!--tracker id 113227 ends-->
	<xsl:variable name="configFileID" select="document(concat($fileNameID,''))"/>
	<xsl:variable name="configLabelsID" select="$configFileID/SRMBO/*"/>
	<xsl:variable name="resFile_ML6">../Renderer/cif/resource/RetCustomerQDE</xsl:variable>
<xsl:variable name="resConfigFile6" select="document(concat($resFile_ML6,'_',$locale,'.xml'))"/>
<xsl:variable name="configLabels6" select="$resConfigFile6/SRMBO/*"/>
<!--IDENTIFICATION DOCUMENT CHANGES end-->

<!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
	<xsl:param name="ALTCALENDAR_TYPE"/>
<!--ERPBOCF1:TRACKER113259: STORAGE OF DATES :ENDOFCHANGES-->

<xsl:variable name="file3">../Renderer/common/resource/TabMessage_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_3" select="document(concat($file3,''))"/>
<xsl:variable name="configLabels_3" select="$configFile_3/SRMBO/*"/>
<xsl:param name="fileName4"/>
	<xsl:variable name="configFile_10" select="document(concat($fileName4,''))"/>
	<xsl:variable name="configLabels_12" select="$configFile_10/SRMBO/*"/>


<!--including file for label names-->
        <xsl:param name="locale"/>
<xsl:variable name="fileName">../Renderer/Customization/cif/resource/RetCustomerQDE_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!-- CIF HouseHold Change Start -->
<!-- Last Edited Page changes starts -->
<!--<xsl:variable name="HouseHoldFileName">../Renderer/cif/resource/ListofHouseHold_<xsl:value-of select="$locale"/>.xml</xsl:variable>-->
<!-- CIF HouseHold Change End -->
     <!-- CRM101UB changes start -->
    <xsl:variable name="file5">../Renderer/corpcif/resource/CorpIntroRelatedAs_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_5" select="document(concat($file5,''))"/>
     <xsl:variable name="configLabels_1" select="$configFile_5/SRMBO/*"/>
     <xsl:variable name="fileName_Introducer">../Renderer/corpcif/resource/CorpIntroRelatedAs_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!-- CRM101UB end -->
<!-- 	CIF PhoneEmail Changes : Start -->
<!--<xsl:variable name="fileName1">../Renderer/cif/resource/RetCustAddressList_<xsl:value-of select="$locale"/>.xml</xsl:variable>-->
<!--<xsl:variable name="filePhoneEmail">../Renderer/cif/resource/RetCustPhoneEmail_<xsl:value-of select="$locale"/>.xml</xsl:variable>-->
<!-- CIF PhoneEmail Changes : End -->
<xsl:param name="AddFileName"/>
<xsl:variable name="fileName1" select="$AddFileName"/>
<xsl:param name="fileName2"/>
<xsl:variable name="fileNameHousehold" select="$fileName2"/>
<xsl:param name="fileName3"/>
<xsl:variable name="filePhoneEmail" select="$fileName3"/>
<!--LastEdited end-->
	<!-- CRM101UB changes :start -->
     <xsl:param name="fileName5"/>
     <xsl:variable name="fileNameGrp" select="$fileName5"/>
     <!-- CRM101UB changes end -->
<!--Relationship Manager Changes:Start-->
<xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"></xsl:variable>
     <xsl:variable name="assignedBackEndID" select="//SRMData//Z[@n=concat($boName,'.BackEndID')]"></xsl:variable>
<xsl:variable name="boDet" select="/SRM/SRMData[@SRMDataSpace='Main']/SRMComposite [@n=$boName]/Z"/>
<!--Relationship Manager Changes:End-->
<!--Key Generation Changes STart-->
<xsl:variable name="entityCreflg" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityCreflg']"/>
<xsl:variable name="isCopy" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsCopy']"></xsl:variable>
<!--Key Generation Changes end-->

<!-- Last Edited Page changes start -->
<xsl:variable name="boNameDemo" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boNameDemo']"></xsl:variable>
<xsl:variable name="boNamePsycho" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boNamePsycho']"></xsl:variable>
<xsl:variable name="accountURL" select="//SRMData//Z[@n=concat($boName,'.url_')]"></xsl:variable>
<!-- Changes done by vikas for tracker id 260279 starts -->
<xsl:variable name="contactURL" select="//SRMData//Z[@n=concat($boName,'.url_')]"></xsl:variable>
<!-- Changes done by vikas for tracker id 260279 ends -->
<xsl:variable name="accountID" select="$boDet[@n=concat($boName,'.accountID')]"/>
<xsl:variable name="mainAccId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mainAccId']"></xsl:variable>
<xsl:variable name="custom_fields" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z"/>
<xsl:variable name="flagRelType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='flagRelType']"></xsl:variable>
<!-- Last Edited Page changes end -->
<xsl:variable name="Tds_tbl"   		select="$boDet[@n=concat($boName,'.Tds_tbl')]"/>
<xsl:variable name="LastUpdate_Date" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='LastUpdate_Date']"></xsl:variable>
    <xsl:variable name="file1">../Renderer/Customization/cif/resource/RetCustomerQDE_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_1" select="document(concat($file1,''))"/>
<xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
    <xsl:variable name="file2">../Renderer/cif/resource/RetGeneralMinor_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_2" select="document(concat($file2,''))"/>
<xsl:variable name="configLabelsMinor" select="$configFile_2/SRMBO/*"/>
<xsl:variable name="allfields" select="/SRM/SRMData//Z"/>
<xsl:variable name="IsCustDefaulted" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsCustDefaulted']"></xsl:variable>
<xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
<xsl:variable name="locked" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='lockstate']"/>
<xsl:variable name="selectCategory" select="$configLabels[@name='SELECT_CATEGORY']/@configLabel"/>
<xsl:variable name="ViewName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='productName']"></xsl:variable>
<xsl:variable name="productCategory" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='productCategory']"></xsl:variable>
<xsl:variable name="ID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ID']"/>
<!--Access Control Changes-->
<xsl:variable name="PrimBCID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcID']"></xsl:variable>
<xsl:variable name="PrimBCCODE" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcCode']"></xsl:variable>
<xsl:variable name="priGrpID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='priGrpID']"></xsl:variable>
<xsl:variable name="priSegName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='priSegName']"></xsl:variable>
 <!--End of Changes-->
<!-- CIF Changes Tessa - Start -->
<xsl:variable name="isAutoGenKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isAutoGenKey']"></xsl:variable>
<!-- CIF Changes Tessa - End -->
<!-- KeyGeneration Start -->
<xsl:variable name="keyGeneration" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='keyGeneration']"></xsl:variable>
<!-- KeyGeneration End -->


<!-- TRACKER ID 122174 CHANGES BEGIN -->
<!-- Get the values set in Custom Data For Minor Tab Templates -->
<xsl:variable name="fName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.firstName']"></xsl:variable>
<xsl:variable name="lName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.lastName']"></xsl:variable>
<xsl:variable name="mName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.middleName']"></xsl:variable>
<xsl:variable name="relation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RelationshipBO.Relationship']"></xsl:variable>
<xsl:variable name="key" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.contactsKey']"></xsl:variable>
	 	 <xsl:variable name="Guard" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Guard_code']"></xsl:variable>
	 	 <xsl:variable name="Gender" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Gender']"></xsl:variable>
                 <xsl:variable name="Dob" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Dob']"></xsl:variable>
                 <xsl:variable name="Salutation1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Salutation']"></xsl:variable>
                 <xsl:variable name="CifId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CifID']"></xsl:variable>
                 <xsl:variable name="FirstName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='FirstName']"></xsl:variable>
                 <xsl:variable name="MiddleName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MiddleName']"></xsl:variable>
<!-- TRACKER ID 122174 CHANGES END -->

<!-- TrackerId: 131246 Begin of Changes by Sonali_narula-->
<xsl:variable name="GcifIdAccess" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='GcifIdAccess']"></xsl:variable>
<xsl:variable name="MultiEntity" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MultiEntity']"></xsl:variable>
<!--TrackerId: 131246 Changes end -->

<!--Minor Age changes: start-->
<xsl:variable name="MINOR_YEAR" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MINOR_YEAR']"></xsl:variable>
<!--Minor Age changes: end-->
     <!--Senior Age changes: start-->
          <xsl:variable name="SENIOR_YEAR" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='SENIOR_YEAR']"></xsl:variable>
     <!--Senior Age changes: end-->
<xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"></xsl:variable>
 <xsl:variable name="mcJNDIFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mcJNDIFlag']"></xsl:variable>
 <xsl:variable name="isMCEdited" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isMCEdited']"></xsl:variable>
 <xsl:variable name="getRole" select="/SRM/SRMData[@SRMDataSpace='RoleCode']//Z"/>

    <xsl:variable name="defAddress" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='defAddress']"/>
<!-- Fix for Ticket ID 286386 Begins -->
<xsl:variable name="aRetRelValues" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='aRetRelns']"></xsl:variable>
<xsl:variable name="aAllowBlklisted" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='aBlklist']"></xsl:variable>
<xsl:variable name="aAllowNegated" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='aNegated']"></xsl:variable>
<xsl:variable name="aAllowSuspended" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='aSuspend']"></xsl:variable>
<!-- Fix for Ticket ID 286386 Ends -->

<!--Chanses By Suman for Approval:Start-->
    <xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"/>
 <!--Chanses By Suman for Approval:End-->
<!--CIF Changes Shanmuga - Getting the BaseCurrency value - Start-->
<xsl:variable name="BaseCurrency" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrency']"></xsl:variable>
<!--CIF Changes  Shanmuga - Getting the BaseCurrency value - End-->
 <xsl:variable name="noOfDaysIntro" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='INTRO_DATE_VALIDATE']"></xsl:variable>
<!-- CIF GroupHouseHold Changes Start  -->
	 <xsl:variable name="globalRM" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='GlobalRM']"></xsl:variable>
<!-- CIF GroupHouseHold Changes End -->
 <!-- CRM101UB Group changes start  -->
	 <xsl:variable name="grpglobalRM" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='grpGlobalRM']"></xsl:variable>
	 <xsl:variable name="grpNatName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='grpNatName']"></xsl:variable>
<!-- CRM101UB Group changes end -->
<!-- LastEdited change -->
     <!-- CIF PhoneEmail Changes : Start -->
     <xsl:variable name="preferredAddressType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredAddressType']"></xsl:variable>
     <xsl:variable name="preferredPhone" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredPhone']"></xsl:variable>
     <xsl:variable name="preferredEmail" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredEmail']"></xsl:variable>
     <!-- CIF PhoneEmail Changes : End -->
     <!--Save & submit  change:Starts-->
     <xsl:variable name="operationType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operationType']"></xsl:variable>
     <!--Save & submit  change:ends-->
	<!--Doc Rec changes: start-->
     <xsl:variable name="docRecvd" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='docRecvd']"></xsl:variable>
	<!--Doc Rec changes: end-->
		<!-- Changes for Track ID 223945 Begin-->		
	<xsl:variable name="isSMSBanking" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.IsSMSBankingEnabled')]"></xsl:variable>
	<xsl:variable name="isWAPBanking" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.IsWAPBankingEnabled')]"></xsl:variable>
	<!-- Changes for Track ID 223945 End-->
	<xsl:variable name="CurrencyDet" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CurrencyDet']"></xsl:variable>
	 <xsl:variable name="ChildEntity" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ChildEntity']"></xsl:variable>
	 <xsl:variable name="ChildEntityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ChildEntityType']"></xsl:variable>
	 <xsl:variable name="IntoLastName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IntoLastName']"></xsl:variable>
	 <xsl:variable name="IntroIDValue" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IntroIDValue']"></xsl:variable>
<!-- LastEdited change-->
	<xsl:variable name="segmentValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='segmentValues']"/>
	<xsl:variable name="segmentRating" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='segmentRating']"/>
	<xsl:variable name="ratingValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='ratingValues']"/>
	<xsl:variable name="subSegmentValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='subSegmentValues']"/>
	<xsl:variable name="subSegmentCodeVal" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='subSegmentCodeVal']"/>
	<xsl:variable name="SubSegment" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.SubSegment')]"></xsl:variable>
	<xsl:variable name="Segment" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.Segmentation_Class')]"></xsl:variable>
        <!-- changes for Tracker 297900 begins-->
        <xsl:variable name="NativeLanguageName" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.NativeLangName')]"></xsl:variable>
	<!-- changes for Tracker 297900 ends-->
	<xsl:variable name="Salutation"   		select="$boDet[@n=concat($boName,'.Salutation')]"/>
	<xsl:variable name="Marital_Status"   		select="$boDet[@n=concat($boNameDemo,'.Marital_Status')]"/>
	<xsl:variable name="IntroducerSalutation"   select="$boDet[@n=concat($boName,'.IntroducerSalutation')]"/>
	<xsl:variable name="Introd_Status"         	select="$boDet[@n=concat($boName,'.Introd_Status')]"/>
	<xsl:variable name="bcName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcName']"></xsl:variable>
	<xsl:variable name="Cat_bcName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_bcName']"></xsl:variable>
	<!-- Start of change for 324098 -->
	<xsl:variable name="bank_id" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bank_id']"></xsl:variable>
	<!-- End of change for 324098 -->
<!-- CIF Changes for Caching Views : Start -->
    <xsl:param name="viewname"/>
    <!-- Start of change for 324098 -->
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.RetCustQDE_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/>&amp;BankId=<xsl:value-of select="$bank_id"/></xsl:variable>
    <!-- <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.RetCustQDE_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable> -->
    <!-- End of change for 324098 -->
    <xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
    <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
    <xsl:variable name="SRMTips" select="$configLabels[@name='Tips']/@value"/>
    <!-- CRM10.2 SPE  -->
     <xsl:variable name="PresCurrData" select="$PresFile/SRM/SRMData[@SRMDataSpace='Currency']"/>
    <xsl:variable name="PresExData" select="$PresFile/SRM/SRMData[@SRMDataSpace='ExRate']"/>
<!-- CIF Changes for Caching Views : End -->
<!-- Fix for Tracker #: SIDDHARTH Begins -->
<xsl:variable name="dtValid" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtValid']"/>
<!-- Fix for Tracker #: SIDDHARTH Ends -->
<!-- Changes for 'WFlow' POC start -->
<xsl:variable name="IntWFID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strIntWFID']"></xsl:variable>
<!-- Changes for 'WFlow' POC end -->
<!-- Changes 10.2.14 enhancements start -->
<xsl:variable name="allowMulti" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='allowMulti']" />
<!-- Changes 10.2.14 enhancements end -->
<xsl:template match="/">
	<html>
    	<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
      	<head>
			<!-- Product Spaecific js -->
			<xsl:call-template name="Product_specificjs"/>
<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
	<!-- Field Rationalization changes start -->
	<!-- Field Rationalization changes end -->
	<!--Changes by Niharika for CR356016-->
	<script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
	<!--End of changes by Niharika for CR356016-->
<!-- Memo padding -->
	<script type="text/javascript" src="../common/js/ContextSwitch.js" language="javascript"></script>
	<!-- Linking custom javascrit file -->
	<script type="text/javascript" src="../Customization/cif/js/CustNameLength.js" language="javascript"></script>
			<script>
			var allowMulti = '<xsl:value-of select="$allowMulti"></xsl:value-of>'; 
				<!--Key Genration Changes Start-->
				var entityCreflg ='<xsl:value-of select="$entityCreflg"/>';
				<!--Key Genration Changes End-->
				var IntWFID = '<xsl:value-of select="$IntWFID"/>'; /* Changes for WFlow POC */
				var bcName = '<xsl:value-of select="$bcName"/>';
				var Cat_bcName = '<xsl:value-of select="$Cat_bcName"/>';
				var locale = '<xsl:value-of select="$locale"/>';
				var srmx_mode = '<xsl:value-of select="$SRMX_MODE"/>';
				var lite_mode = '<xsl:value-of select="$LITE_MODE"/>';
				var offline_mode = '<xsl:value-of select="$OFFLINE_MODE"/>';
				var online_mode = '<xsl:value-of select="$ONLINE_MODE"/>';
			        var appFlag = '<xsl:value-of select="$apprFlag"/>';

			        var isCopy = '<xsl:value-of select="$isCopy"/>';
        var assignedBackEndID = '<xsl:value-of select="$assignedBackEndID"/>';

		<!-- TrackerId: 131246 Begin of Changes by Sonali_narula-->
			var bGcifIdAccess = '<xsl:value-of select="$GcifIdAccess"/>';
			var bMultiEntity = '<xsl:value-of select="$MultiEntity"/>';
		<!-- TrackerId: 131246 end of Changes by -->

                        /*Added for currency issue*/
                        var Currency ='';
                        /*Added for currency issue*/


//IDENTIFICATION DOCUMENT CHANGES start
    			var readMode = '<xsl:value-of select="$readMode"/>';	//added by abhinav
    			<!-- Last Edited Page changes starts -->
//				entityDocumentBO_Name='EntityDocumentBO';
var LastUpdate_Date = '<xsl:value-of select="$LastUpdate_Date"/>';
<!-- Last Edited Page changes starts -->
//IDENTIFICATION DOCUMENT CHANGES end


	<!-- TRACKER ID 122174 CHANGES BEGIN -->
	<!-- Get the values of minor tab templates into variables -->
	var lName = '<xsl:value-of select="$lName"/>';
	var mName = '<xsl:value-of select="$mName"/>';
	var fName = '<xsl:value-of select="$fName"/>';
	var relation = '<xsl:value-of select="$relation"/>';
	var key = '<xsl:value-of select="$key"/>';
	<!-- TRACKER ID 122174 CHANGES END -->








				/*Fix for Tracker #: SIDDHARTH Begins*/
				var locDate = '<xsl:value-of select = "$dtValid"/>'
				/*Fix for Tracker #: SIDDHARTH Ends*/

				<!-- CIF GroupHouseHold Changes Start -->
				var globalRM = '<xsl:value-of select="$globalRM"/>';
				<!-- CIF GroupHouseHold Changes End -->
				<!--tracker id 113227 starts-->

				    	var dualflag;
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
					        else if (locale==baseLocaleType){
					           dualflag=1;
					        }
					}
					else{
					        dualflag=1;

				        }

				    <!--tracker id 113227 ends-->

  <!--Access Control Changes-->
				var primBCID = '<xsl:value-of select="$PrimBCID"/>';
				var primBCCODE = '<xsl:value-of select="$PrimBCCODE"/>';
				var priGrpID = '<xsl:value-of select="$priGrpID"/>';
				var priSegName = '<xsl:value-of select="$priSegName"/>';
   				<!--End of Changes-->
				/* ***** Tracker# 97236 - SMS Banking Mobile Number changes : Start **** */
			        var currDefAddrMobile='';
                    		/* ***** Tracker# 97236 - SMS Banking Mobile Number changes : End **** */
				<!-- Last Edited changes -->
				var accountURL = '<xsl:value-of select="$accountURL"/>';
				var defAddress = '<xsl:value-of select="$defAddress"/>';
				var boName 	   = '<xsl:value-of select="$boName"/>';
				var boNameDemo = '<xsl:value-of select="$boNameDemo"/>';
				var boNamePsycho = '<xsl:value-of select="$boNamePsycho"/>';
	var SegmentChanged='';
	var defaultOwnerSegment='';
	var RMChanged='';
	var defaultPrimaryRM='';
	var defaultSecondaryRM='';
	var defaultTertiaryRM='';
	<!-- changes for callid 418876, RECON 419597 -->
	var convToCust = '';
	var oldEntityType = '';



	// Fix for Ticket ID 286386 Begins
			var aRetRelValues      = 	'<xsl:value-of select="$aRetRelValues"/>';
			var aAllowBlklisted    = 	'<xsl:value-of select="$aAllowBlklisted"/>';
			var aAllowNegated      = 	'<xsl:value-of select="$aAllowNegated"/>';
			var aAllowSuspended    =    	'<xsl:value-of select="$aAllowSuspended"/>';

			var RetRelValues      = 	new Array();
			var AllowBlklisted    = 	new Array();
			var AllowNegated      = 	new Array();
			var AllowSuspended    =    	new Array();

			RetRelValues          = 	aRetRelValues.split(":");
			AllowBlklisted        = 	aAllowBlklisted.split(":");
			AllowNegated          = 	aAllowNegated.split(":");
			AllowSuspended        =    	aAllowSuspended.split(":");
	// Fix for Ticket ID 286386 Ends
			    	var operationType = '<xsl:value-of select="$operationType"/>';
			    	<!-- CRM101UB group change start -->
				var grpNatName ='<xsl:value-of select="$grpNatName"/>';
				var grpglobalRM = '<xsl:value-of select="$grpglobalRM"/>';
				<!-- CRM101UB group change end -->

			    var relManager = '<xsl:value-of select="$custom_fields[@n='SecRelationshipMgr']"/>';
				var relCreatedBy = '<xsl:value-of select="$custom_fields[@n='RelationshipCreatedBy']"/>';
				var accManager = '<xsl:value-of select="$custom_fields[@n='Acc_manager']"/>';
		   	    var flagRelType = '<xsl:value-of select="$flagRelType"/>';
		        var custURL = '<xsl:value-of select="$accountURL"/>';
		        var docRecvd = '<xsl:value-of select="$docRecvd"/>';

		       	var CurrencyDet = '<xsl:value-of select="$CurrencyDet"/>';
		       	var isAutoGenKey = '<xsl:value-of select="$isAutoGenKey"/>';
<!-- KeyGeneration start -->
			var keyGeneration = '<xsl:value-of select="$keyGeneration"/>';
<!-- KeyGeneration end-->
			var entityDocumentBO_Name;
			if(boName=='AccountBO')
				entityDocumentBO_Name='EntityDocumentBO';
			else if(boName=='AccountModBO')
				entityDocumentBO_Name='EntityDocumentModBO';

				<!-- Last Edited changes -->

			var accountID;
	var segment = '<xsl:value-of select="$segmentValues"/>';
	var segmentRating = '<xsl:value-of select="$segmentRating"/>';
	var subSegmentRating = '<xsl:value-of select="$ratingValues"/>';
	var subSegment = '<xsl:value-of select="$subSegmentValues"/>';
	var subSegmentCode = '<xsl:value-of select="$subSegmentCodeVal"/>';
	var SubSegment = '<xsl:value-of select="$SubSegment"/>';
	var Segment = '<xsl:value-of select="$Segment"/>';
	var bank_id = '<xsl:value-of select="$bank_id"/>';
			</script>
            <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
		    <link rel="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
            <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
            <script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>
	    <script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js"></script>
            <script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
<!-- Changes Done by bharath start -->
<script type="text/javascript">
function custIsNumber()
{
	var provVal = document.getElementsByName("2_" + boName+".Amount2")[0].value;
	if(provVal != "")
	{
		if(isNaN(provVal)) 
		{
			showUserMessage('MSGJ50161','');
			document.getElementsByName("2_" + boName+".Amount2")[0].value = "";
			document.getElementsByName("2_" + boName+".Amount2")[0].focus();
			return "interactive";		
		}
	}
}

function custFnLoad()
{
	var bank_id = '<xsl:value-of select="$bank_id"/>';
	document.getElementsByName("custBankId")[0].value = bank_id;
        document.getElementsByName("AccountBO.StrUserField11")[0].selectedIndex = 1;
        custCrncyPopulate();
        var v1=Currency;
	//document.getElementsByName("AccountBO.StrUserField13")[0].value = baseCurrency;
	document.getElementsByName("AccountBO.StrUserField13")[0].value = Currency;
	//bharath
}

/*Added for currency issue*/
function fnEquityGetCurrency(strProcessURL)
{ 
    try{
        
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
	   
	  }
	  }
      catch(e)
           {
		alert(e.message);
	   }
} 
/*Added for currency issue*/

function custCrncyPopulate()
{
                var URL = "";
                /*Added for currency issue*/
                
                var accountid="";
                var strProcessURL = '../servlet/com.infy.cis.custom.EquityGetCurrency?entityId='+accountid;
                fnEquityGetCurrency(strProcessURL);
                var propCurrency=Currency;
                
                /*Added for currency issue*/
                //var CustomerCurrency = '<xsl:value-of select="$BaseCurrency"/>';
                var CustomerCurrency = propCurrency;
                var CreditDiscountPercent = "0";
                var DebitDiscountPercent = "0";
                var WithholdTaxPcnt = document.getElementsByName("AccountBO.StrUserField11")[0].value;
                var WithholdTaxFloorLmt = "0";
                var PreferentialExpiryDate = "31/12/2099";
                CurrencyappendTRChild(URL,
                                        CustomerCurrency,
                                        CreditDiscountPercent,
                                        DebitDiscountPercent,
                                        WithholdTaxPcnt,
                                        WithholdTaxFloorLmt,
                                        PreferentialExpiryDate);
}

function custCheckNationalID()
{
        if(document.getElementById("DemographicBO.Nationality").value != "INDIAN")
        {
                if (accountURL!='')     //checking passport details for existing NREcustomer
                {
                        if(document.getElementsByName("National Card Number.txt_ID")[0].value=="")
                        {
                                if(uniqueIDType != 'National Card Number' )
                                {
                                        if( (uniqueIDType!="National Card Number") )
                                        {
                                                showMessage(MSGJ0059);
                                                return "false";
                                        }
                                }
                        }
                }
                else //checking passport details for new Entity
                {
                        if(document.getElementsByName("National Card Number.txt_ID")[0].value=="")
                        {
                                parent.parent.parent.parent.tabViewFrm.selectTabForID(0);
                                parent.parent.parent.parent.messageFrm.removeMessages(selTabId);
                                parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("Please add Identification Detail for National Id Card",""),parent.parent.IFrmtab0.formDispFrame.TBODY_EDocRecordSet.rows ,'NO_HLINK');
                                parent.parent.parent.parent.messageFrm.showMessages(selTabId);
                                parent.parent.IFrmtab0.formDispFrame.showTabFortabDemoForm('tpageCont5');
                                parent.parent.IFrmtab0.formDispFrame.document.all.AddIdentificationDetails.focus();
                                return "false";
                        }
                }
        }
}


</script>
<!-- Changes Done by Bharath end -->
		</head>
<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 start-->
        <body class="popup" onkeypress="onLoadSetTime()" onclick="onLoadSetTime()">
<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 end-->
<!-- Last Edited Page changes starts -->
     <xsl:choose>
     <xsl:when test="normalize-space($accountURL)=''">
	    <!-- CIF Changes Shanmuga - Start - Adding the call for formatDemographyAmount(),loadCurrency() functions -->
	    <!-- Ticket id 204903 Changes begin -->
	    <!-- TRACKER ID 124165 CHANGES BEGIN -->
	    <!-- loadZakat function called before hideMinor to disable the Zakat Deduction drop down when CustomerQDE screen loads -->
	    <!-- <xsl:attribute name="onload">Toggle('primintro');focusFirstField();disable_LookUp();load();hideMinor();loadZakat();showFormTips();loadID();LoadCurr();makeDateMand();checkEbankFields();populateAccContAttr();showFormTips();checkEmp();introCreate();formatDemographyAmount();hideMinor();formatUser();storeSegment();isLock();prodload();showInReadOnlyMode('<xsl:value-of select="$readMode"/>');load('<xsl:value-of select="$readMode"/>');getExistingDocVar();fnScanNow();</xsl:attribute> -->
	    <!-- TRACKER ID 124165 CHANGES END -->
		 <!-- Ticket id 205867 Changes begin -->
 <!--TrackerID:131246 Start of Changes by sonali_narula Added function
     DisableGcifIdLookUp to disble gcifId lookup on access -->
		<!-- Changes for Tracker id 148280 Start  -->
	    <xsl:attribute name="onload">custFnLoad();introdSalutation();DisableGcifIdLookUp();populateAccContAttr();loadBaseCurrency();Toggle('primintro');focusFirstField();disable_LookUp();load();loadZakat();hideMinor();showFormTips();loadID();LoadCurr();makeDateMand();checkEbankFields();showFormTips();checkEmp();formatDemographyAmount();hideMinor();formatUser();storeSegment();isLock();prodload();showInReadOnlyMode('<xsl:value-of select="$readMode"/>');load('<xsl:value-of select="$readMode"/>');getExistingDocVar();fnScanNow();swifta();</xsl:attribute>
		<!-- Changes for Tracker id 148280 End  -->
  <!--TrackerID:131246 End of Changes-->
	     <!-- Ticket id 205867 Changes end -->
        <!-- Ticket id 204903 Changes End -->
	    <!-- CIF Changes Shanmuga - End -->
     </xsl:when>
     <xsl:otherwise>
     	 <!-- Ticket id 205867 Changes begin -->
		<!-- Changes for Tracker id 148280 Start  -->
		<!-- Changes for Tracker id 195924 Start  -->
		<!-- Changes for Track ID 223945  Begin-->
                <!-- Changes for Tracker ID 261154  Begin-->		
        <xsl:attribute name="onload">introdSalutation();checkEbankFields();isSMSOrWAPEnabled();changeSMSBanking();changeWAPBanking();Toggle('primintro');load();populateAccContAttr();focusFirstField();disable_LookUp();loadBackEnd();loadSubSeg();loadSegVal();makeDateMand();formatUser();storeSegment();hideMinor();checkEmp();introEdit();loadID();LoadCurr();checkAge();checkAgeSC();loadCode();currencyOnLoad();isDocument_Received();loadBaseCurrency();formatDemographyAmount();isLock();prodload();showInReadOnlyMode('<xsl:value-of select="$readMode"/>');load('<xsl:value-of select="$readMode"/>');getExistingDocVar();fnScanNow();</xsl:attribute>
	<!-- Changes for Tracker ID 261154  Begin-->
        <!-- Changes for Track ID 223945 End--> 
        	<!-- Changes for Tracker id 195924 Ends  -->
		<!-- Changes for Tracker id 148280 End  -->
        <!-- Ticket id 205867 Changes end -->
     </xsl:otherwise>
     </xsl:choose>
 <!-- Last Edited Page changes ends -->
	    <!--<xsl:attribute name="onunload">closeAllWindow();</xsl:attribute>-->
            <!-- Changes Shanmuga - Including Currency.js for the function CheckDropValue() -->
            <script type="text/javascript" src="../common/js/Rendcurrency_cif.js" language="javascript"></script>
            <!-- CIF Changes Shanmuga - End -->
	<!-- CRM101UB changes -->
	    <script type="text/javascript" language="javascript" src="../cif/js/Group.js"></script>
	<!-- CRM101UB change end -->
    	    <!--CIF PhoneEmail Changes : Start -->
	    <script type="text/javascript" language="javascript" src="../Customization/cif/js/CIFCustomerAddress.js"></script>
	    	<!-- Changes for Ticket 725047 begin -->
	    <script type="text/javascript" language="javascript" src="../cif/js/CIFCustomerAddress_Reduced.js"></script>
	    	<!-- Changes for Ticket 725047 ends -->
	    <script type="text/javascript" language="javascript" src="../cif/js/CIFPhoneEmail.js"></script>
	    <!--CIF PhoneEmail Changes : End -->


	    <script type="text/javascript" language="javascript" src="../cif/js/CurrencyDetails.js"></script>

	    <!-- changes rajan -->
	     <script type="text/javascript" language="javascript" src="../Customization/cif/js/CustomerAddress_Form.js"></script>
		<!--CIF Changes Start -->
	     <script type="text/javascript" language="javascript" src="../cif/js/HouseHold.js"></script>
		<!--CIF Changes  End -->
		<script type="text/javascript" language="javascript" src="../Customization/cif/js/Minor.js"></script>		

	    <!-- changes rajan -->
<!--IDENTIFICATION DOCUMENT CHANGES start-->
		<script type="text/javascript" language="javascript" src="../cif/js/EntityDocument_Form.js"></script>
<!--IDENTIFICATION DOCUMENT CHANGES end-->
	    <!-- Shanmuga NRE Changes -->
	    <!-- Shanmuga NRE Changes -->
           <script type="text/javascript" src="../Customization/js/AccountCustom.js" language="javascript"></script>
           <!-- Changes for WFlow POC start -->
           <!-- Changes for tracker id 334810 starts -->
	   <!--          <script type="text/javascript" src="../cif/js/RetCustomerQDE_System.js" language="javascript"></script> -->
           <!-- Changes for tracker id 334810 ends -->
	    <script type="text/javascript" src="../common/js/WorkFlow.js" language="javascript"></script>
	    <!-- Changes for WFlow POC end -->
 <!--<script type="text/javascript" language="javascript" src="../cif/js/Account.js"></script>-->
<!--   JAVASCRIPT FUNCTIONS    -->
		<script type="text/javascript" language="javascript">

// Tracker #: 123062 BEGIN of Changes
var isMinor = null;
// Tracker #: 123062 END of Changes
<!-- Senior Citizen--> var isSenior=null;

<![CDATA[function showFormTips() {
parent.parent.parent.parent.removeTips(parent.parent.parent.parent.frames(0).getSelectedTabId());
parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(),"]]><xsl:value-of select="$SRMTips"/><![CDATA[");
parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames(0).getSelectedTabId());
parent.parent.parent.parent.showTipsButton();

}
]]>

     var isReadOnly;
     function swifta()
     {

            try{document.getElementsByName("SWIFT_ADDRESS_DETAILS")[0].disabled = false;}catch(e){alert(e.message);}


		isReadOnly="Y";
		document.getElementsByName("Close")[0].disabled = false;
	    }

//Access Control Changes
<![CDATA[
<!-- Core dependency changes start-->
function changeSubSeg () {
try {
	var segrating= loadSubSeg();
	if(segrating != null && segrating != 'null' ) {
		document.getElementsByName("Cat_AccountBO.ChargeLevelCode")[0].value = segrating;
	}
	else {
		document.getElementsByName("Cat_AccountBO.ChargeLevelCode")[0].value = '';
	}
}
catch (e) {
}
}
<!-- Core dependency changes end-->

function loadSubSeg(){
	var ele1 = document.getElementsByName(boName+".Segmentation_Class")[0];
	var ele2 = document.getElementsByName(boName+".SubSegment")[0];
	ele2.options.length = 0;
	ele2.options[0] = new Option('','');
	/*Changes for Tracker:138505*/
		var segValues = segment.split("$");
		var segRat = segmentRating.split("$");
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
	if(ele1.value != '' && ele1.value != null ){
		for(i=0; i<segValues.length; i++){
			if(segValues[i] == ele1.value){
				segrating = segRat[i];
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
		/*Changes for 195764:Recon Ticket[235575] Start*/
		ele2.options[k] = new Option(subSeg[j], subSegCode[j]);
			k++;
		}

		}
		}
	/*Changes for Tracker:138505END*/
	if(subSegRat[j] == ele1.value){
		ele2.options[k] = new Option(subSeg[j], subSegCode[j]);
		/*Changes for 195764:Recon Ticket[235575] End*/
		k++;
	}
	}
	}
<!-- Core dependency changes start-->
	return segrating;
<!-- Core dependency changes end-->
}
function loadSegVal(){
	var ele2 = document.getElementsByName(boName+".SubSegment")[0];
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
          //Function to populate default values in access control attributes
 <![CDATA[
	function populateAccContAttr()
	{
	//TrackerID: 235202 changes starts
	 		try{
	var calType = getCookie('SRMCalendar');
if(calType == null)	{
	
		var expires = new Date ();
        expires.setTime(expires.getTime() + ( 160 * 60 * 60 * 1000));
        setCookie('SRMCalendar',strSessionCalType,expires);
	}
	}
	catch(e1){
	 	}
		//TrackerID: 235202 changes ends

		if(trim(document.frm2.accountID.value) == "" && boName == "AccountBO"){
		
		            /*Changes for firestone tracker id 350964 Starts*/ 
		            
		               var indexValue= Cat_bcName.indexOf('#'); 
		               //changes for call id 366454 starts
		               var indexValue1= bcName.indexOf('#');
		               //var Cat_value=Cat_bcName.substring(0,indexValue);
		               var Cat_value=bcName.substring(indexValue1+1);
		               //changes for call id 366454 end
		               var Cat_textValue = Cat_bcName.substring(indexValue+1); 
		               document.getElementsByName("Cat_AccountBO.Primary_sol_id")[0].value = Cat_textValue; 
		               document.getElementsByName("AccountBO.Primary_sol_id")[0].value = Cat_value; 
		               
		           /*Changes for firestone tracker id 350964 Ends*/ 
		                 }                 

		elem1=eval("document.getElementsByName(boName+'.accessOwnerGroup')[0]");

		for(i=0;i<elem1.options.length;i++)
			{

				if(elem1.options[i].value==priGrpID)
				{
				elem1.selectedIndex=i
				break;
				}

			}

		elem2=eval("document.getElementsByName(boName+'.accessOwnerSegment')[0]");

		for(i=0;i<elem2.options.length;i++)
			{

				if(elem2.options[i].value==priSegName)
				{
				elem2.selectedIndex=i
				break;
				}

			}

			setAccessOwnerGroup()
			setBCCodeValues('accessOwnerBC',primBCCODE,primBCID)
  	}function setMCAttModifyFlag(){
		document.frm2.isMCEditedGeneral.value="Y";

		}

  	  	function checkSalutation(check){
			var gender = document.getElementsByName(boName+".Gender")[0].value;
			var Salutation = ""; 
                           if(document.getElementsByName(boName+".Salutation")[0]!=null && document.getElementsByName(boName+".Salutation")[0]!=undefined){ 
                                   Salutation = document.getElementsByName(boName+".Salutation")[0].value; 
                            } 
                            else{ 
                                   if(document.getElementsByName(boName+".Salutation_code")[0]!=null && document.getElementsByName(boName+".Salutation_code")[0]!=undefined) 
                                           Salutation = document.getElementsByName(boName+".Salutation_code")[0].value; 
                            } 


			var found = "false";
			if(gender != '' && Salutation != '' && gender == 'F'){
				for(i=0;i<Male.length;i++){

				/* change for ticket id 207373 start*/
					if(Male[i].toUpperCase() == Salutation.toUpperCase()){
					/* change for ticket id 207373 end*/
						found = "true";
						break;
					}
				}

			}
			if(gender != '' && Salutation != '' && gender == 'M'){
				for(i=0;i<Female.length;i++){
				/* change for ticket id 207373 start*/
					if(Female[i].toUpperCase() == Salutation.toUpperCase()){
					/* change for ticket id 207373 end*/
						found = "true";
						break;
					}
				}

			}

			if(found == "true"){
				showMessage(MSG_GEN_SAL);
				if(check == 'S'){
					document.getElementsByName(boName+".Salutation")[0].value="";
				}else{
					document.getElementsByName(boName+".Gender")[0].value="";
				}
			}
	     }

  	]]>
 //End of Access Control Changes

<!-- Tracker ID: 108385: Begin of changes : For focus on first field -->
function focusFirstField()
{
	try
	{
		document.getElementsByName(boName + ".Salutation")[0].focus();
	}
	catch (e)
	{
		try
		{
			document.getElementsByName(boName + ".Address.preferredAddress")[0].focus();
		}
		catch (e)
		{
			try
			{
				document.getElementsByName(boName + ".PhoneEmail.PhoneEmailType")[0].focus();
			}
			catch (e)
			{
			}
/* CRM11.0:TRACKER:113058:BEGINOFCHANGES */
				try
				{
					document.getElementsByName("Create New Group")[0].focus();
				}
				catch (e)
				{
				}

					try
					{
						document.getElementsByName("Create New HouseHold")[0].focus();
					}
					catch (e)
					{
				        }
/* CRM11.0:TRACKER:113058:ENDOFCHANGES */
		}
	}
}
/* TRACKER:225185:BEGIN OFCHANGES */
function fnBlurFunctionmin(type) {

		var chk1 = chkBlurFrom1();
		
		if(chk1== true) {
		fnTabOutMinorQDE();
		return;
	        }
                minor="true";
                intro = false;
                TDS = false;
                lookup = document.getElementsByName("RelationshipBO.Bank_Entity")[0].value;
                if (lookup == ""){
                   document.getElementsByName("ContactBO.DOB")[0].value = '';
                   showUserMessage("MSG_BANKRELFOR","");
                }
               if(lookup == 'CUSTOMER') {
                   lookupFor = 'CUSTOMER';
                    accLookUpWin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForAccount',
                            'Lookup',
                            'height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
               }
               if(lookup == 'CONTACT') {
                   lookupFor = 'CONTACT';
                    accLookUpWin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForContact',
                    'lookup',
                    'height=height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');    updateContact = false;
               }
               if(lookup == 'PROSPECT') {
                   lookupFor = 'PROSPECT';
                    accLookUpWin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForSuspect',
                    'lookup',
                    'height=436, left=50, top=120, width=900,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');    updateContact = false;
               }
        }

function fnTabOutMinorQDE(){
   
   		lookup = document.getElementsByName("RelationshipBO.Bank_Entity")[0].value;
   		
   		/* ticket id: 334896  changes Begin */
        var strCIFId4 = '' + document.getElementsByName("ContactBO.contactsKey")[0].value;
      
   		 /* ticket id: 334896  changes End */
   		var flag = '';
   		var recFlag='';
   		if(strCIFId4==''){
   			return;
   		}
   	         if (lookup == ""){
   		 	   showUserMessage("MSG_BANKRELFOR","");
   	             }
   		     	if(lookup == 'CUSTOMER' || lookup == 'Customer') {
   			     lookupFor = 'CUSTOMER';
   			 }
   			 if(lookup == 'CONTACT' || lookup == 'Contact') {
   			     lookupFor = 'CONTACT';
   			   }
   			 if(lookup == 'PROSPECT' || lookup == 'Prospect') {
   			     lookupFor = 'PROSPECT';
   				   }
   			      var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
   				var Relation = "MinorQDE";
	          		var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?cifID='+strCIFId4+"&amp;lookup="+lookupFor+"&amp;RELATION="+Relation;
   				s_xmlHttp.open("POST",strURL,false);
   				s_xmlHttp.send();
   				if(s_xmlHttp.status == 200)
   				{
   					recFlag   = getColorCookie('sManyRecords');
   					flag   = getColorCookie('sBooleans');
   					if ((recFlag=="True")){
   					flag='';
   					}
   				}
   				s_xmlHttp.open("GET",strURL,false);
   				s_xmlHttp.send();
   				
			 if(recFlag=='True'){
  				flag=='';
  				document.getElementsByName("ContactBO.firstName")[0].value= "";
  				document.getElementsByName("ContactBO.lastName")[0].value= "";
  				document.getElementsByName("ContactBO.gender")[0].value= "";
  				document.getElementsByName("3_ContactBO.DOB")[0].value= "";
  				document.getElementsByName("ContactBO.contactsKey")[0].value= "";
  				/* ticket id: 334896  changes Begin */
                //document.getElementsByName("RelationshipBO.Bank_Entity_Name")[0].value= "";
  				/* ticket id: 334896  changes End */  
  				  if( lookup == "CUSTOMER" ) {
			    	    	lookupFor = 'CUSTOMER';
			    	  	vMode='ForAccount';
			    	  	}
			    	  else if ( lookup == "CONTACT" ) {
			    	  	lookupFor = 'CONTACT';
			    	  	vMode='ForContact';
			    	  	}
			    	  else if( lookup == "PROSPECT" ) {
			    	  	lookupFor = 'PROSPECT';
			    	  	vMode='ForSuspect';
			    	  	}
			    	  	var strCorpLastName1;
			    	  	var the_length=strCIFId4.length;
					var last_char=strCIFId4.charAt(the_length-1);
					if(last_char=='*'){
					strCorpLastName1=strCIFId4;
					}
			    	  	else{
			    	  	 	strCorpLastName1 = strCIFId4 + '*';
			    	  	 }
			    	  	minor="true";
			    	  	intro = false;
			    	  	TDS = false;
			    	  	wid=900;
			    	  	ht=460;
			    	  	topCord=(screen.height-ht)/2;
			    	  	leftCord=(screen.width-wid)/2;
			    	    	var newwin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode='+vMode+"&amp;lastName="+strCorpLastName1,
			    	    	     'Lookup',
			    	    	     'height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
			    	  }
   			if(flag=='False'){
   					showUserMessage("MSGJ50716","");
   				document.getElementsByName("ContactBO.firstName")[0].value= "";
   				document.getElementsByName("ContactBO.lastName")[0].value= "";
   				document.getElementsByName("ContactBO.gender")[0].value= "";
   				document.getElementsByName("3_ContactBO.DOB")[0].value= "";
   				document.getElementsByName("ContactBO.contactsKey")[0].value= "";
   			/* ticket id: 334896  changes Begin */	
               //document.getElementsByName("RelationshipBO.Bank_Entity_Name")[0].value= "";
   		    /* ticket id: 334896  changes End */	
   			}
   			else if(flag=='True'){
   				var firstname   = getColorCookie('strFirstName');
   				var lastName    = getColorCookie('lastName');
   				var gender      = getColorCookie('gender');
   				var dob         = getColorCookie('dob');
   				var IDcif = getColorCookie('cif');
   				var primaryCustomerID = getColorCookie('cifID');
   				 document.frm2.hid_accountIDvalue.value = primaryCustomerID;
   					if(!firstname== "undefined"){
   				document.getElementsByName("ContactBO.firstName")[0].value= firstname;
   					}
   					else{
   					document.getElementsByName("ContactBO.firstName")[0].value= "";
   					}
   				document.getElementsByName("ContactBO.contactsKey")[0].value= IDcif;
   				document.getElementsByName("ContactBO.lastName")[0].value= lastName;
   				document.getElementsByName("ContactBO.gender")[0].value= gender;
   					if(dob != "undefined"){
   				document.getElementsByName('3_ContactBO.DOB')[0].value = dob;
   					}
   					else
   					{
   					document.getElementsByName('3_ContactBO.DOB')[0].value= "";
   					}
   			    }
        }
        /* TRACKER:225185:END OFCHANGES */
function loadCode()
	{
		document.getElementsByName(boName + '.Salutation')[0].value = '<xsl:value-of select="$Salutation"/>';
		document.getElementsByName(boName + '.IntroducerSalutation')[0].value = '<xsl:value-of select="$IntroducerSalutation"/>';
		document.getElementsByName(boName + '.Introd_Status')[0].value = '<xsl:value-of select="$Introd_Status"/>';
}

// ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 start
// Function hideFields is written to disable zakat_deduction field when user selects
// "N" or "None" in islamic_banking_customer field dropdowns

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


function checkEmp()
{
	//staff id validations for 10.2.13
	disableStaffFieldConditionally('<xsl:value-of select="$boName"/>.StaffFlag', 'AccountBO.StaffEmployeeID');
	var staffFlag = '<xsl:value-of select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.StaffFlag')]"/>';
	if(readMode!='Y'){
		if(staffFlag == 'Y' || staffFlag == 'EXSTF')
		    setStaffEmployeeIdMandatory(true);
		else
		    setStaffEmployeeIdMandatory(false);
	}
}



	<!--Access Control Changes-->
	function  openBCCodeLookup(type)
	{
		bcCodeLookup = type;
                 /* Tracker: 108382: Changes for centering popup */
                 windowAlign();
		var url = "com.infy.cis.ui.common.Lookup?Mode=ForBCCode&amp;isActive=Y&amp;isAutomated=N";
		var style = 'height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes';
		/* Tracker: 108382: End of Changes */
		window.open (url, "Lookup", style);
	}
	function  onBCCodeSelect()
	{
		setBCCodeValues ( bcCodeLookup , getCookie("bCCode"), getCookie("bCID"));
		document.getElementsByName("AccountBO.accessOwnerBC")[0].fireEvent("onChange");
	}

	function  setBCCodeValues (type, bCCode, bCID)
	{
		eval("document.frm2." + type).value = bCID;
		eval("document.getElementsByName(boName+'.accessOwnerBC')[0]").value  = bCCode;
	}

	function setAccessOwnerGroup()
	{
	document.frm2.accessOwnerGroup.value=document.getElementsByName(boName+'.accessOwnerGroup')[0].value;
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

function setAgentValues(type,agentName,loginId)
{
	eval("document.frm2." + type).value = loginId;
	if(type == 'Acc_manager'){
		//Field Rationalization fix
		Acc_managerURL = getCookie("AgentURL");
		document.getElementsByName("AccountBO.RelationshipMgrID")[0].value = getCookie("LookupAccManagerID");
	}
	//Field Rationalization fix  start
	else if(type == 'Sec_manager')
		Sec_managerURL = getCookie("AgentURL");
	//Field Rationalization fix  end


	var primaryRM=document.getElementsByName("Acc_manager")[0].value;
	var secondaryRM=document.getElementsByName("Sec_manager")[0].value;
	if ( (primaryRM!="" &amp;&amp; primaryRM != defaultPrimaryRM &amp;&amp; primaryRM!=null &amp;&amp; primaryRM!="null") || (secondaryRM !="" &amp;&amp; secondaryRM != defaultSecondaryRM &amp;&amp; secondaryRM !=null &amp;&amp; secondaryRM!="null") ) {
		RMChanged='true';
	}
	else {
		RMChanged='false';
	}
}
	<!-- CIF Changes Tessa - Start -->
	function closebtn(){
// Last Edited Page change starts
		if(accountURL==''){
		parent.frames(0).location.href = parent.frames(0).location.href;
		} else {
			top.window.close();
		}
		// Fix for ticket ID 302196
		/*Changes for tracker 231779 starts*/
		//parent.location.reload(true);
		parent.parent.frames(0).location.href = parent.parent.frames(0).location.href;
		/*Changes for tracker 231779 ends*/
		// Fix for ticket ID 302196
//		parent.frames(0).location.href = parent.frames(0).location.href;
var dataArea = parent.parent.parent.parent.parent;
var screenTitle= parent.parent.parent.parent.parent.parent.ScreenTitleFrm;
screenTitle.titleMsg.innerHTML = "CIF Retail > New Entity > Customer Onboarding";
dataArea.location.href="../../../servlet/com.infy.cis.custom.OnboardDetWizard?type=Retail";
// Last Edited Page change ends
	}
	<!-- CIF Changes Tessa - End -->
	function clear()
	{
		/* Changes for WFlow POC -- start */
		if ((IntWFID != null) &amp; (IntWFID != undefined) &amp; (IntWFID != '')) {
			Updatedb(IntWFID,"Accounts_Mod");
		}
		/* Changes for WFlow POC -- end */
		//document.location.reload(true);
		// Fix for ticket ID 302196
		//parent.location.reload(true);
		// Fix for ticket ID 302196
		parent.parent.parent.parent.setButtonsVisible(true);
// Last Edited Page change starts
//		parent.frames(0).location.href= parent.frames(0).location.href
// Last Edited Page change end;
	}

        function selectProcess(){

        	var entityType = "";
		//10.2 Fix Tracker 187440
		//if(document.frm2.isMCEditedGeneral.value=="N")
		if(document.frm2.mcJNDIFlag.value=="true" &amp;&amp; document.frm2.isMCEditedGeneral.value=="N"){
       			appFlag="false";
       		}

		//...added by vishal....
		if( appFlag=='true')
		  {
		  entityType = "AccountMod";
		  }
		else
		  {
		  entityType = "Account";
		  }
		var accountId  = parent.formSaveFrame.savedValue;
		//Recon for Security Audit Changes from CRM10301BSUPP
		var secureHKey = document.getElementsByName("SECUREHKEY")[0].value;	
		var keyField = document.getElementsByName("FLDHASHKEY")[0].value;						
		//Recon for Security Audit Changes from CRM10301BSUPP
		
		/*Tracker :93811 Fix start */
		/*Changes by Niharika for CR356016*/
		//window.open('../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+accountId+'&amp;entityType='+entityType+'&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField+'&amp;IntWFID='+IntWFID+'&amp;isPopup=Yes','save','directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');//Changes for 'WFlow' - 'IntWFID' also being passed
		var strProcessURL = '../servlet/com.infy.cis.custom.EquityRetailProcessSelection?entityId='+accountId+'&amp;entityType='+entityType;
		var strBOURL = accountURL;
		//alert('strBOURL    '+strBOURL);
		//alert('strProcessURL     '+strProcessURL);
		fnProcessSelection(strProcessURL, strBOURL);
		/*End of changes by Niharika for CR356016*/
		/*Tracker :93811 Fix End */
		//parent.location.reload(true);
		 
     //Changes for call id 373394 Starts : Process window was not coming in focus
	//	window.showModalDialog('../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+accountId+'&amp;entityType='+entityType+'&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField+'&amp;IntWFID='+IntWFID+'&amp;isPopup=Yes','save','dialogHeight:360px; dialogLeft:'+ (screen.width - 900) / 2 +'px;dialogTop:'+ (screen.height - 360) / 2+'px; dialogWidth:500px;center:yes;resizable:no;status:no;scroll:no;help:no;');
		  
               //Changes for call id 373394 Ends : Process window was not coming in focus
        }


				function sortMe(sortColumn,sortOrder)
				{
				// later.
				}

	// ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 start
	// To disable zakat_deduction field when form loads

	function loadZakat()
	{
	document.getElementsByName(boName+".zakat_deduction")[0].disabled = true;
	}
	// ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 end


		function hideMinor(){
		        	//Changes for minor validations: start
		        	document.frm2.minorLoaded.value="false";
		        	//Changes for minor validations: end
		        	document.getElementById("td_tpageCont2").disabled = true;
				document.getElementById("td_tpageCont2").style.visibility="hidden";
				document.getElementById("det_tpageCont2").style.visibility="hidden";
				document.getElementsByName("ContactBO.lastName")[0].IsMandatory = "false";
				document.getElementsByName("3_ContactBO.DOB")[0].IsMandatory = "false";
				document.getElementsByName("ContactBO.gender")[0].IsMandatory = "false";
				document.getElementsByName("ContactBO.salutation")[0].IsMandatory = "false";
				document.getElementsByName("RelationshipBO.Guard_Code")[0].IsMandatory = "false";

				<!-- CIF Changes Tessa - Start -->
				document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "false";
				if(document.getElementsByName("ContactBO.contactsKey")[0].value == "") {
					if(document.all.isAutoGenKey.value == 'true') {
						document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "false";
					}

				}
				<!-- CIF Changes Tessa - End -->

				document.getElementsByName("RelationshipBO.Relationship")[0].IsMandatory = "false";
				document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].IsMandatory = "false";

				//Changes for minor validations: start
				document.getElementsByName("RelationshipBO.Bank_Entity")[0].value="";
				document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].value="";
				document.getElementsByName("ContactBO.salutation")[0].value="";
				document.getElementsByName("ContactBO.firstName")[0].value="";
				document.getElementsByName("ContactBO.lastName")[0].value="";
				document.getElementsByName("ContactBO.middleName")[0].value="";
				document.getElementsByName("ContactBO.gender")[0].value="";
				document.getElementsByName("3_ContactBO.DOB")[0].value="";
				document.getElementsByName("RelationshipBO.Guard_Code")[0].value="";
				document.getElementsByName("ContactBO.contactsKey")[0].value="";
				//Native Language Changes:start
				document.getElementsByName("ContactBO.Contact_First_Name_Native")[0].value="";
				document.getElementsByName("ContactBO.Contact_Middle_Name_Native")[0].value="";
				document.getElementsByName("ContactBO.Contact_Last_Name_Native")[0].value="";

				//Native Language Changes:end

				//Changes for minor validations: end

				hideDetailstabEntityFieldDetails('tpageCont2');
        		 }



         function checkAge(){
		         	var minor = document.getElementsByName(boName+".CustomerMinor")[0].value;
		         	if(document.getElementsByName("3_AccountBO.Cust_DOB")[0].value=='')
				  {
				  if(minor !=null &amp; minor != ''){
				 showMessage(MSGX0004);
				  // Last Edited page changes starts
				  document.getElementsByName(boName+".CustomerMinor")[0].value='';
				  // Last Edited page changes ends
				  document.getElementsByName("3_AccountBO.Cust_DOB")[0].focus();
				  return;
				  }
		  		}
		  		else
		  		{
		         	var checkDate=validateDOB();
		          	if(checkDate=="true"){

		          	var DOB = document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
		          	var dtFormDOB = gettingDateFormats();
				if(dtFormDOB == 'MM/dd/yyyy' || dtFormDOB == 'MM-dd-yyyy'){
					var  bday=DOB.substring(3,5);
					var  bmonth=DOB.substring(0,2);
					var  bYear=DOB.substring(6,10);
				}
				else{
					var  bday=DOB.substring(0,2);
					var  bmonth=DOB.substring(3,5);
					var  bYear=DOB.substring(6,10);
			  	}
			  	/*Fix for Tracker #: SIDDHARTH Begins*/
			  	isMinor = IsMinor_loc(bday,bmonth,bYear);
			  	/*Fix for Tracker #: SIDDHARTH Ends*/

				if(isMinor=='false'){
				  	document.frm2.CustomerMinor.value="N";
				  	hideMinor();
				  	// Last Edited page changes starts
				  	if(document.getElementsByName(boName+".CustomerMinor")[0].value=='Y')
					{
						 showMessage(MSGX0005);
						 document.getElementsByName(boName+".CustomerMinor")[0].value='N';
						 //Ticket id 430877 and Tracker id 259230 Recon Call id 227206 changes starts
						document.getElementsByName("MinorAttainMajorDate")[0].value =  '';
						//Ticket id 430877 and Tracker id 259230 Recon Call id 227206 changes ends
					 }
					 else
					 {
						document.getElementsByName(boName+".CustomerMinor")[0].value='N';

					}

				  }

<![CDATA[  else if(custURL!="" && flagRelType=="true"){
		<!-- CRM70t-ST :TRACKER# 79264 **BEGIN OF CHANGES ** -->
				if(document.getElementsByName(boName+".CustomerMinor")[0].value=='N')
				{
					 showMessage(MSGX0006);
					 document.getElementsByName(boName+".CustomerMinor")[0].value='Y';
					 document.frm2.CustomerMinor.value="Y";
					 document.getElementById("td_tpageCont2").disabled = false;
				     document.getElementById("td_tpageCont2").style.visibility="visible";
					 document.getElementById("det_tpageCont2").style.visibility="visible";
				     showTabFortabEntityFieldDetails('tpageCont2');
				     loadMinor();
				}
				else{
					document.getElementsByName(boName+".CustomerMinor")[0].value='Y';
					document.frm2.CustomerMinor.value="Y";
					document.getElementById("td_tpageCont2").disabled = false;
					document.getElementById("td_tpageCont2").style.visibility="visible";
					document.getElementById("det_tpageCont2").style.visibility="visible";
					showTabFortabEntityFieldDetails('tpageCont2');
					loadMinor();
					}
		<!-- CRM70t-ST :TRACKER# 79264 **END OF CHANGES ** -->
				//hideMinor();
				//to calculate majorYear start
				   var strMonth = document.getElementsByName(boName+".Birth_Month")[0].value;
				   var dobMonth = strMonth.substring(0,3);
				   dobMonth = parent.parent.parent.parent.ret_month(dobMonth) + 1;
				   var dobDay = document.getElementsByName(boName+".Birth_Day")[0].value ;
				   var dobYear = document.getElementsByName(boName+".Birth_Year")[0].value ;
				   var majorDate = MajorDate(dobDay,dobMonth,dobYear);
				   document.getElementsByName("MinorAttainMajorDate")[0].value	=  majorDate;
				//to calculate majorYear end
			  }]]>
			  //Last Edited Pages changes ends
				else {

// Last Edited page changes starts
					if(document.getElementsByName(boName+".CustomerMinor")[0].value=='N')
					{
						 showMessage(MSGX0006);
						 document.getElementsByName(boName+".CustomerMinor")[0].value='Y';
					 }
					 else
					 {
						document.getElementsByName(boName+".CustomerMinor")[0].value='Y';
					}
// Last Edited page changes ends






					document.frm2.CustomerMinor.value="Y";
					document.getElementById("td_tpageCont2").disabled = false;
					document.getElementById("td_tpageCont2").style.visibility="visible";
					document.getElementById("det_tpageCont2").style.visibility="visible";
					showTabFortabEntityFieldDetails('tpageCont2');
					loadMinor();

					}

				}
				else{
				       hideMinor();
				       showMessage(MSGX0060);
				       document.getElementsByName("3_AccountBO.Cust_DOB")[0].value='';

				    }
		     	  }
					/** TRACKERID #106384 : BEGIN OF CHANGE **/
		     	 	 if(isMinor=='true'){
						var majorDate = MajorDate(bday,bmonth,bYear);
						document.getElementsByName("MinorAttainMajorDate")[0].value	=  majorDate;
				  	}
				  	/** TRACKERID #106384 : END OF CHANGE **/
		     	  }





<!-- Senior Citizen Starts-->
	    
	      function checkAgeSC(){
	     					var senior = document.getElementsByName(boName+".SeniorCitizen")[0].value;
	      	    		         	if(document.getElementsByName("3_AccountBO.Cust_DOB")[0].value=='')
	      	    				  {
	      	    				  if(senior !=null &amp; senior != ''){
	      	    				  showMessage(MSGX0004);
	      	    				  document.getElementsByName(boName+".SeniorCitizen")[0].value='';
	      	    				  document.getElementsByName("3_AccountBO.Cust_DOB")[0].focus();
	      	    				  return;
	      	    				  }
	    		  		}
	    		         	else
	    		  		{
	    		         	var checkDate=validateDOB();
	    		          	if(checkDate=="true"){
	    		          	
	    		          	var DOB = document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
	    		          	var dtFormDOB = gettingDateFormats();
	    				if(dtFormDOB == 'MM/dd/yyyy' || dtFormDOB == 'MM-dd-yyyy'){
	    				//Changes  for call id 350482 and recon for call id 363385 Starts 
	    					//var  bday=DOB.substring(3,5);
	    					//var  bmonth=DOB.substring(0,2);
	    					//var  bYear=DOB.substring(6,10);
	    					var  dobDay=DOB.substring(3,5);
						var  strMonth=DOB.substring(0,2);
	    					var  dobYear=DOB.substring(6,10);
	    				//Changes  for call id 350482 and recon for call id 363385 Ends
	    				}
	    				else{
	    					var  dobDay=DOB.substring(0,2);
	    					var  strMonth=DOB.substring(3,5);
	    					var  dobYear=DOB.substring(6,10);
	    			  	}
	    			  	isSenior = IsSenior(dobDay,strMonth,dobYear);
	    				if(isSenior=='false'){
	    				  	document.frm2.SeniorCitizen.value="N";
	    				  	if(readMode=='Y')
						{
							document.getElementsByName("AccountBO.SenCitizenApplicableDate")[0].value = '';
						}
						else
						{
							document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].value	;
						}
						if(document.getElementsByName(boName+".SeniorCitizen")[0].value=='Y')
						{
							 showMessage(MSGJ62344);
							 document.getElementsByName(boName+".SeniorCitizen")[0].value='N';
							 document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].value =  '';
						 }
						 else
						 {
							document.getElementsByName(boName+".SeniorCitizen")[0].value='N';
							document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].value = "";
	    	    				 }
	    	    				 var seniorDate = SeniorDate(dobDay,strMonth,dobYear);
	    	    			 document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].value	=  seniorDate;
	    				  }
	    	    			  
	    			  
	    <![CDATA[  else if(custURL!="" && flagRelType=="true"){
	    				if(document.getElementsByName(boName+".SeniorCitizen")[0].value=='N')
	    				{
	    					 showMessage(MSGJ62343);
	    					 document.getElementsByName(boName+".SeniorCitizen")[0].value='Y';
	    				}
					   var seniorDate = SeniorDate(dobDay,strMonth,dobYear);
					   document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].value	=  seniorDate;
					   isGregDate("3_AccountBO.SenCitizenApplicableDate");


	    	    
	    			  }]]>
	    				else {
	    
	    					if(document.getElementsByName(boName+".SeniorCitizen")[0].value=='N')
	    					{
	    						 showMessage(MSGJ62343);
	    						 document.getElementsByName(boName+".SeniorCitizen")[0].value='Y';
	    					 }
	    					 else
	    					 {    
	    						document.getElementsByName(boName+".SeniorCitizen")[0].value='Y';
							var seniorDate = SeniorDate(dobDay,strMonth,dobYear);
							document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].value	=  seniorDate;
							if(readMode=='Y')
							{

								document.getElementsByName("AccountBO.SenCitizenApplicableDate")[0].disabled = false;
								document.getElementsByName("AccountBO.SenCitizenApplicableDate")[0].value	=  seniorDate;
								isGregDate("AccountBO.SenCitizenApplicableDate");

							}
							else
							{
							   document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].value	=  seniorDate;

							  isGregDate("3_AccountBO.SenCitizenApplicableDate");
							  }


											  	    
	    					}
	    
	    					var currDate = getCurrentDate();
						if(calType=='H'){
							currDate = convertGregToHij(currDate);
							}
						document.getElementsByName('3_AccountBO.SenCitizenApplicableDate')[0].value = currDate;
	    					}
	    
	    				}
	    				else{
	    				       showMessage(MSGX0060);
	    				       document.getElementsByName("3_AccountBO.Cust_DOB")[0].value='';
	    
	    				    }
	    		     	  }
	    				  	document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].disabled = false;
	    
	    		     	  }

	
	    <!-- Senior Citizen Ends-->

	    
		
		
		function MajorDate(dobDay,dobMonth,dobYear){
			try{
				var MINOR_YEAR = document.all.MINOR_YEAR.value;
				var majorYear 	= parseInt(dobYear) + parseInt(MINOR_YEAR);
				var majorDate   = dobDay + "/" + dobMonth + "/" + majorYear;
				return majorDate;
			}catch(e){}
		}

/** TRACKERID #106384 : END OF CHANGE **/

	  	function loadMinor(){
	  	var primaryCustomerID = '<xsl:value-of select="$IntroIDValue"/>';
   				 document.frm2.hid_accountIDvalue.value = primaryCustomerID;
	  		    //Changes for minor validations: start
	  		    document.frm2.minorLoaded.value="true";
	  		    //Changes for minor validations: end
	  		     document.getElementsByName('RelationshipBO.Guard_Code')[0].value = '<xsl:value-of select="$Guard"/>';
			     document.getElementsByName('ContactBO.lastName')[0].value = '<xsl:value-of select="$IntoLastName"/>';
			     document.getElementsByName('ContactBO.firstName')[0].value = '<xsl:value-of select="$FirstName"/>';
			     document.getElementsByName('ContactBO.middleName')[0].value = '<xsl:value-of select="$MiddleName"/>';
			     document.getElementsByName("ContactBO.gender")[0].value = '<xsl:value-of select="$Gender"/>';
			     document.getElementsByName("ContactBO.salutation")[0].value = '<xsl:value-of select="$Salutation1"/>';
			     document.getElementsByName("3_ContactBO.DOB")[0].value = '<xsl:value-of select="$Dob"/>';
			     document.getElementsByName("ContactBO.contactsKey")[0].value = '<xsl:value-of select="$CifId"/>';
   	                     document.getElementsByName('RelationshipBO.ChildEntityType')[0].value = '<xsl:value-of select="$ChildEntityType"/>';
   	                     document.getElementsByName('RelationshipBO.Bank_Entity')[0].value = '<xsl:value-of select="$ChildEntity"/>';
	  		    loading = "true";
	  		    DisplayLookUP();
				 //Ticket id 441192 and Tracker id 266380 changes starts
				 //Changes for call id 429540 starts
	  		    document.getElementsByName("RelationshipBO.Relationship")[0].value="Guardian";
				//Changes for call id 429540 ends
				 //Ticket id 441192 and Tracker id 266380 changes ends

	  		   document.getElementsByName("RelationshipBO.Relationship")[0].disabled = true;
	  		    document.getElementsByName("RelationshipBO.Guard_Code")[0].disabled = false;
	  		    document.getElementsByName("ContactBO.lastName")[0].IsMandatory = "true";
					//Fix for callid:430243 Starts
					//to disable autopopolated fields on load of minor tab
				document.getElementsByName("ContactBO.lastName")[0].disabled = true;//priya
				document.getElementsByName("ContactBO.firstName")[0].disabled = true;//priya
				document.getElementsByName("ContactBO.middleName")[0].disabled = true;//priya
	  		    document.getElementsByName("3_ContactBO.DOB")[0].IsMandatory = "true";
				document.getElementsByName("3_ContactBO.DOB")[0].disabled = true;//priya
	  		    document.getElementsByName("ContactBO.gender")[0].IsMandatory = "true";
				document.getElementsByName("ContactBO.gender")[0].disabled = true;//priya
	  		    document.getElementsByName("ContactBO.salutation")[0].IsMandatory = "true";
				document.getElementsByName("ContactBO.salutation")[0].disabled = true;//priya
	  		    document.getElementsByName("RelationshipBO.Guard_Code")[0].IsMandatory = "true";
				document.getElementsByName("ContactBO.Contact_Last_Name_Native")[0].disabled = true;//priya
				document.getElementsByName("ContactBO.Contact_Middle_Name_Native")[0].disabled = true;//priya
				document.getElementsByName("ContactBO.Contact_First_Name_Native")[0].disabled = true;//priya
				//making the contactskey field mandatory as it has been converted to a lookup
				document.getElementsByName("ContactBO.contactsKey")[0].disabled = true;
				document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "true";//priya
				document.getElementsByName("mandStarContactBO.contactsKey")[0].style.visibility="visible";//priya
			    /*if(document.getElementsByName("ContactBO.contactsKey")[0].value == "") {
			       if(document.all.isAutoGenKey.value == 'true') {
			       document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "false";
			       }
				else{
			       document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "true";
				}

			     }*/
				//Fix for callid:430243 ends
	  		    document.getElementsByName("RelationshipBO.Relationship")[0].IsMandatory = "true";
	  		    sSelectType = document.getElementsByName("RelationshipBO.Bank_Entity")[0].value;
	  		    if( document.getElementsByName("RelationshipBO.Bank_Entity")[0].value != ''){
	  			document.getElementsByName("RelationshipBO.Bank_Entity_Name")[0].value = document.getElementsByName("ContactBO.LastName")[0].value
	  		    }

	  		   try{
	  			if(document.getElementsByName("RelationshipBO.Bank_Entity")[0].value != ''){
	  			   // lbDynamic.innerText = document.getElementsByName("RelationshipBO.Bank_Entity")[0].value + " :";
	  			   lbDynamic.innerText = "Entity Last Name";
	  			}else{
	  			    //lbDynamic.innerText = document.getElementsByName("RelationshipBO.Bank_Entity")[0].value;
	  			    lbDynamic.innerText = "Entity Last Name";
	  			}
	  	                }catch(e){}
		   }

/*Last Edited page changes starts */
    function formatUser()
    {
	document.frm2.Acc_manager.value = accManager;
   	document.frm2.Sec_manager.value = relManager;
   	
	/*Changes for Call Id:269631 Start*/
		//Fix for ticket 338288 by tracker 220538 - 10.2.05  Starts
	   	//document.frm2.RelationshipCreatedById.value=relCreatedby;
	   	document.frm2.RelationshipCreatedById.value=relCreatedBy;
	   	//Fix for ticket 338288 by tracker 220538 - 10.2.05 Ends
	/*Changes for Call Id:269631 End*/

   	document.getElementsByName('RelationshipBO.ChildEntityType')[0].value = '<xsl:value-of select="$ChildEntityType"/>';
   	document.getElementsByName('RelationshipBO.Bank_Entity1')[0].value = '<xsl:value-of select="$ChildEntity"/>';
   	document.getElementsByName('RelationshipBO.Bank_Entity_Name1')[0].value = '<xsl:value-of select="$IntoLastName"/>';
    }
	function isDocument_Received() {
	/* Tracker ID 113276 Changes - CIF Usability: Begin */
	//document recieved tab has been removed from UI
	 /*var docRecv= document.getElementsByName("ckDocument_Received")[0];
	    if(docRecvd=='Y') {
	    docRecv.checked = true;
	    }*/
    }
/*Last Edited Page changes ends*/


    function setFocusOnComp(compName) {

			   var object = "";
			    var elementName = eval(object + "document.getElementsByName(compName)[0]");
			    if(elementName) {
				if(elementName.displayFieldName){
				    elementName = eval(object + "document.getElementsByName(elementName.displayFieldName)[0]");
				}
				try{
				    var ids = elementName.parentElement.parentElement.parentElement.parentElement.parentElement.id;
				    ids = trim(ids.replace("det_",""));
				    eval(object + "showTabFortabEntityFieldDetails('" + ids +"')");
				}catch(e){
				}
				if (elementName.type == "text" || elementName.type == "textarea"){
				    elementName.select();
				}else{
				    elementName.focus();
				}
			    }
		}
	// KeyGeneration start
	function checkKeys() {
		if (event.keyCode == 42 || event.keyCode ==37) {
			event.keyCode=0;
		}
	}
	// KeyGeneration end
	function validateMinorDOB(){
	/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
	/* calling the function isGregDate for on blur functionality*/

		isGregDate("3_AccountBO.Cust_DOB");
		;
	/*  ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/

		var todaydate = new String();

		/*Fix for Tracker #: SIDDHARTH Begins*/
		todaydate.value =  getTodayDate1(locDate);
		/*Fix for Tracker #: SIDDHARTH Ends*/
	/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
	/* calling the function isGregDate for on blur functionality*/

		       var date = document.getElementsByName("3_AccountBO.Cust_DOB")[0];
		if (date.value != '')
{

				todaydate.value = convertDate(todaydate.value);
				}

		/* ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/


		var elem1 = document.getElementsByName("3_AccountBO.Cust_DOB")[0];
		var mill1 = changetoMillisForToday(todaydate.value);
	        var mill2 = changetoMillis(elem1.value);
		if (mill1 &lt; mill2){

			showMessage(MSGX0060);
			document.getElementsByName("3_AccountBO.Cust_DOB")[0].value='';
			document.getElementsByName("3_AccountBO.Cust_DOB")[0].focus();
			return;
		}

	}


	function changetoMillisForToday(datevalue){
 		if(datevalue.length == 0){
 			return 0;
		}
		else{
			date1 = new Date(datevalue.substring(3,5) + "/" + datevalue.substring(0,2) + "/" + datevalue.substring(6,10));
			var millis = date1.valueOf();
			return millis;
		}



	}
	function introdSalutation(){
document.getElementsByName(boName+".IntroducerSalutation")[0].value = '<xsl:value-of select="$IntroducerSalutation"/>';
document.getElementsByName("Cat_"+boName+".IntroducerSalutation")[0].value = '<xsl:value-of select="$IntroducerSalutation"/>';
}

	function changetoMillis(datevalue){

		if(datevalue.length == 0){
			return 0;
		}
		else{
			var dtForm = gettingDateFormats();
			if(dtForm == 'MM/dd/yyyy' || dtForm == 'MM-dd-yyyy'){
				date1 = new Date(datevalue.substring(0,2) + "/" + datevalue.substring(3,5) + "/" + datevalue.substring(6,10));
			}
			else{
				date1 = new Date(datevalue.substring(3,5) + "/" + datevalue.substring(0,2) + "/" + datevalue.substring(6,10));
			}

			var millis = date1.valueOf();
			return millis;
		}

	}


function validateDOB(){

		var todaydate = new String();

		/*Fix for Tracker #: SIDDHARTH Begins*/
		todaydate.value =  getTodayDate1(locDate);
		/*Fix for Tracker #: SIDDHARTH Ends*/
		var elem1 = document.getElementsByName("3_AccountBO.Cust_DOB")[0];
		var mill1 = changetoMillis(todaydate.value);
	        var mill2 = changetoMillis(elem1.value);
		if (mill1 &lt; mill2){

			return "false";
		}
		else{
			return "true";
		 }
	}
//Native Language Changes:start
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
	<!-- changes for SPE tickets 10.2.12 starts -->
	gif.src = '../Renderer/reports/images/minus.gif';
	<!-- changes for SPE tickets 10.2.12 ends -->
    }
}catch(e){
}

}


function storeSegment() {

	defaultOwnerSegment=document.getElementsByName(boName+'.accessOwnerSegment')[0].value;
	defaultPrimaryRM=document.getElementsByName("Acc_manager")[0].value;
	defaultSecondaryRM=document.getElementsByName("Sec_manager")[0].value;
}

/******************Last Edited changes start********************/
function load(){

document.getElementsByName("AccountBO.IntroducerName")[0].readOnly=true;
document.getElementsByName("AccountBO.NativeLangCode")[0].value = "INFENG";
document.getElementsByName("AccountBO.asset_classification")[0].value = "S";
document.getElementsByName("AccountBO.accessOwnerGroup")[0].disabled = true;
document.getElementsByName("AccountBO.accessOwnerSegment")[0].disabled = true;
document.getElementsByName("AccountBO.accessOwnerBC")[0].disabled = true;


//360106

document.getElementsByName("AccountBO.Cust_Language")[0].value = "UK (English)";


 if(!(bcName=='000'||bcName=='1000'||bcName=='2000'||bcName=='3000'||bcName=='4000'))
{
document.getElementsByName("AccountBO.Primary_sol_id")[0].disabled = true;

document.getElementsByName("Cat_AccountBO.Primary_sol_id")[0].disabled = true;

// document.getElementsByName(boName+".Primary_sol_id")[0].disabled=true;
// document.getElementsByName("Cat_"+ boName+".Primary_sol_id")[0].disabled=true;
 document.getElementsByName("btnone_AccountBO.Primary_sol_id")[0].disabled = true;
 document.getElementsByName("btntwo_AccountBO.Primary_sol_id")[0].disabled = true;
}


document.getElementsByName("AccountBO.Tds_tbl")[0].value = "ZERO";


      try{
		var todaydate = new String();

		todaydate.value =  getTodayDate1(locDate);
		todaydate.value = convertDate(todaydate.value);

//alert("date"+todaydate.value);
		document.getElementsByName("3_"+boName+".RelationshipOpeningDate")[0].value = todaydate.value;
}
catch(e){

	alert(e.message);

	}
	
/******************kate Last Edited changes end********************/
  <!-- changes for callid 350809 starts-->
    if (altLocaleActv=="true"){
  <!-- changes for Tracker 297900 begins-->
  var nativelangname= '<xsl:value-of select="$NativeLanguageName"/>';
  
  document.getElementsByName('AccountBO.NativeLangName')[0].value= nativelangname;
  document.getElementsByName('AccountBO.Name')[0].readOnly=true;
<!-- changes for Tracker 345696 begins-->
  //document.getElementsByName('AccountBO.Name_alt1')[0].readOnly=true;
<!-- changes for Tracker 345696 ends-->
<!-- changes for Tracker 297900 ends-->
}
  <!-- changes for callid 350809 ends-->
 <!--Tracker id 113227 start here-->
 document.frm2.altLocaleActv.value='<xsl:value-of select="$altLocaleActv"/>';
 <!--Tracker id 113227 end here-->
 //Changes for tracker ID 456748 start
 try{
 var currDate = getCurrentDate();
 if(calType=='H'){
 currDate = convertGregToHij(currDate);
 }
 if(operationType!="Queue"){
document.getElementsByName('3_AccountBO.RelationshipOpeningDate')[0].value = currDate;
 }
 }
 catch(e){}
 //Changes for tracker ID 456748 end
 try{
 	  document.getElementsByTagName("img")[1].style.display="none";
 	  if(readMode!='Y')
 	  	{
 	  		document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].readOnly = true;
 	  		
 	  	}else
 	  	{
 	  		document.getElementsByName("AccountBO.SenCitizenApplicableDate")[0].readOnly = true;
 		}
}catch(e){ }
try{
customLoad();
}catch(e)
{ }
try{
	var obj = parent.parent.parent.parent.frames(3);
	obj.enableButton_Ub();
}catch(e)
{ }
try
{
	sortList('RecordSet');
	deleteList('RecordSet');
	addAddressList('RecordSet');
}
catch(e){
}
if(isAutoGenKey == 'false' || isAutoGenKey == '') {
		document.getElementsByName("AccountBO.AccountKey")[0].IsMandatory = "true";
		document.getElementsByName("mandStarAccountBO.AccountKey")[0].style.visibility="visible";
	}
<!-- CRM102ST:TrackerID:180428 Being of Change -->
else if (isAutoGenKey == 'true'){
	document.getElementsByName("AccountBO.IntroducerID")[0].readOnly = true;
	document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="hidden";
}
<!-- CRM102ST:TrackerID:180428 End of Change -->
if(accountURL == "") {
	document.getElementsByName("AccountBO.AccountKey")[0].value = "";
	// KeyGeneration start
	if (keyGeneration == 'Both'|| (keyGeneration=="" &amp;&amp; (isAutoGenKey== 'false' || isAutoGenKey == ''))) {
		document.getElementsByName("AccountBO.AccountKey")[0].readOnly = false;
		if (keyGeneration != 'Both') {
			keyGeneration ='Manual';
		}
	}
	// KeyGeneration end
}
else {
					if(defAddress == "M")
						defAddress = "Mailing";
					else if(defAddress == "H")
						defAddress = "Home";
					else if(defAddress == "W")
						defAddress = "Work";
	//document.getElementsByName(boName+".DefaultAddressType")[0].value = defAddress;
}
/* fix by vijayakesavan for call_id:438735 for customer QDE screen Starts*/ 
try{
var currDate = getCurrentDate();

if(calType=='H')
			{
				currDate = convertGregToHij(currDate);
			}
		
		document.getElementsByName('3_AccountBO.RelationshipOpeningDate')[0].value = currDate;
}
catch(e){}
/* fix by vijayakesavan for call_id:438735 for customer QDE screen Ends*/
try{
	concatName();

	/* Start of fix for ticket Id : 337804 */

		if(altLocaleActv == "true"){
			concatName_alt();
		}

	/* End of fix for ticket Id : 337804 */


	if(accountURL!='')
	{
		if(entityCreflg == 'N'){
		document.getElementsByName("AccountBO.AccountKey")[0].disabled = false;
		document.getElementsByName("AccountBO.AccountKey")[0].readOnly = false;
		document.getElementsByName("hid_cifid")[0].value = document.getElementsByName("AccountBO.AccountKey")[0].value;
		}else
		document.getElementsByName("AccountBO.AccountKey")[0].disabled = true;
	}
  if(document.frm2.hid_accountURL.value != '') {
	editMode = true;

// CRM101UB Group Changes Start
try{
 //xml encoding changes-- start

	if(boName=='AccountBO')
	{
for (i=0; i &lt; document.all.GroupRecordSet.rows.length; i++) {
	var sGroupID ='';
	var sGroupMasterID='';
	var sPercentShare = '';
	var sGroup_ID ='';
	var sPrimary = '';

			sGroupID = document.all.GroupRecordSet.rows(i).getAttribute("AccountBO.GroupHouseHold.GroupHouseHoldID");
	if ((sGroupID != null) &amp;&amp; (sGroupID != 'undefined')) {
				sGroupName 	        = trim(document.all.GroupRecordSet.rows(i).getAttribute("AccountBO.GroupHouseHold.GroupHouseHoldName"));
				sGroupMasterID	    = trim(document.all.GroupRecordSet.rows(i).getAttribute("AccountBO.GroupHouseHold.GroupHouseHoldMasterID"));
				sGroup_ID	    = trim(document.all.GroupRecordSet.rows(i).getAttribute("AccountBO.GroupHouseHold.GROUP_ID"));
				sPrimary 	    = trim(document.all.GroupRecordSet.rows(i).getAttribute("AccountBO.GroupHouseHold.PRIMARY_GROUP_INDICATOR"));
				sPercentShare	    = trim(document.all.GroupRecordSet.rows(i).getAttribute("AccountBO.GroupHouseHold.Shareholding_in_percentage"));
				sGroupCode			= trim(document.all.GroupRecordSet.rows(i).getAttribute("AccountBO.GroupHouseHold.GroupHouseHoldCode"));
		if(sPercentShare=="") sPercentShare=0;

		GroupName[GroupName.length]    		= sGroupName;
		GroupID[GroupID.length] 		= sGroupID;
		GroupCode[GroupCode.length] 		= sGroupCode;
		GroupMasterID[GroupMasterID.length] 	= sGroupMasterID;
		PercentShare[PercentShare.length]   	= sPercentShare;
		GroupURL[GroupURL.length] 		= sGroupName + sGroupCode;
		LinkedGroups[LinkedGroups.length]	= sGroupCode;
		Prim_Grp_ID[Prim_Grp_ID.length]		= sPrimary;
		Group_ID[Group_ID.length]		= sGroup_ID;
		TotalPercent = TotalPercent + eval(sPercentShare);
		document.all.GroupRecordSet.rows(i).setAttribute('RowID', i-2);
				document.all.GroupRecordSet.rows(i).setAttribute("AccountBO.GroupHouseHold.url_", sGroupName + sGroupCode);
			}
	recordIndexGrp = i-2;
}
	}else if(boName=='AccountModBO')
	{

		for (i=0; i &lt; document.all.GroupRecordSet.rows.length; i++) {
			var sGroupID ='';
			var sGroupMasterID='';
			var sPercentShare = '';
			var sGroup_ID ='';
			var sPrimary = '';

			sGroupID = document.all.GroupRecordSet.rows(i).getAttribute("AccountModBO.GroupHouseHold.GroupHouseHoldID");
			if ((sGroupID != null) &amp;&amp; (sGroupID != 'undefined')) {
				sGroupName 	        = trim(document.all.GroupRecordSet.rows(i).getAttribute("AccountModBO.GroupHouseHold.GroupHouseHoldName"));
				sGroupMasterID	    = trim(document.all.GroupRecordSet.rows(i).getAttribute("AccountModBO.GroupHouseHold.GroupHouseHoldMasterID"));
				sGroup_ID	    = trim(document.all.GroupRecordSet.rows(i).getAttribute("AccountModBO.GroupHouseHold.GROUP_ID"));
				sPrimary 	    = trim(document.all.GroupRecordSet.rows(i).getAttribute("AccountModBO.GroupHouseHold.PRIMARY_GROUP_INDICATOR"));
				sPercentShare	    = trim(document.all.GroupRecordSet.rows(i).getAttribute("AccountModBO.GroupHouseHold.Shareholding_in_percentage"));
				sGroupCode			= trim(document.all.GroupRecordSet.rows(i).getAttribute("AccountModBO.GroupHouseHold.GroupHouseHoldCode"));
				if(sPercentShare=="") sPercentShare=0;

				GroupName[GroupName.length]    		= sGroupName;
				GroupID[GroupID.length] 		= sGroupID;
				GroupCode[GroupCode.length] 		= sGroupCode;
				GroupMasterID[GroupMasterID.length] 	= sGroupMasterID;
				PercentShare[PercentShare.length]   	= sPercentShare;
				GroupURL[GroupURL.length] 		= sGroupName + sGroupCode;
				LinkedGroups[LinkedGroups.length]	= sGroupCode;
				Prim_Grp_ID[Prim_Grp_ID.length]		= sPrimary;
				Group_ID[Group_ID.length]		= sGroup_ID;
				TotalPercent = TotalPercent + eval(sPercentShare);
				document.all.GroupRecordSet.rows(i).setAttribute('RowID', i-2);
				document.all.GroupRecordSet.rows(i).setAttribute("AccountModBO.GroupHouseHold.url_", sGroupName + sGroupCode);
			}
			recordIndexGrp = i-2;
		}
	}
 //xml encoding changes-- end
}
catch (ex) {
	alert("ERROR7: "+ex.message);
	}

// CRM101UB Group Changes End

//GroupHouseHold Inclusion:start
 //xml encoding changes-- start
	if(boName=='AccountBO')
	{
for (i=0; i &lt; document.all.RowRecordSet.rows.length; i++) {
	var sHouseHoldID ='';
	if(mainAccId != ""){
				sHouseHoldID = document.all.RowRecordSet.rows(i).getAttribute("AccountBO.GroupHouseHold.MainTableID");
	}else {
				sHouseHoldID = document.all.RowRecordSet.rows(i).getAttribute("AccountBO.GroupHouseHold.GroupHouseHoldID");
	}
	if ((sHouseHoldID != null) &amp;&amp; (sHouseHoldID != 'undefined')) {
				sHouseHoldName 	        = trim(document.all.RowRecordSet.rows(i).getAttribute("AccountBO.GroupHouseHold.GroupHouseHoldName"));
				sHouseHoldCode      		= trim(document.all.RowRecordSet.rows(i).getAttribute("AccountBO.GroupHouseHold.GroupHouseHoldCode"));
				sHouseHoldMasterID		= trim(document.all.RowRecordSet.rows(i).getAttribute("AccountBO.GroupHouseHold.GroupHouseHoldMasterID"));
		HouseHoldName[HouseHoldName.length]   		 = sHouseHoldName;
		HouseHoldCode[HouseHoldCode.length] 			 = sHouseHoldCode;
		HouseHoldMasterID[HouseHoldMasterID.length]  = sHouseHoldMasterID;
		HouseHoldURL[HouseHoldURL.length] 			 = sHouseHoldName + sHouseHoldCode;
		HouseHoldID[HouseHoldID.length]				 = sHouseHoldID;
		document.all.RowRecordSet.rows(i).setAttribute('RowID', i-2);
				document.all.RowRecordSet.rows(i).setAttribute("AccountBO.GroupHouseHold.url_", sHouseHoldName + sHouseHoldCode);
	}
	recordIndex1 = i-2;
}
	}else if(boName=='AccountModBO')
	{
		for (i=0; i &lt; document.all.RowRecordSet.rows.length; i++)
		{
			var sHouseHoldID ='';
			if(mainAccId != ""){
				sHouseHoldID = document.all.RowRecordSet.rows(i).getAttribute("AccountModBO.GroupHouseHold.MainTableID");
			}else {
				sHouseHoldID = document.all.RowRecordSet.rows(i).getAttribute("AccountModBO.GroupHouseHold.GroupHouseHoldID");
			}
			if ((sHouseHoldID != null) &amp;&amp; (sHouseHoldID != 'undefined')) {
				sHouseHoldName 	        = trim(document.all.RowRecordSet.rows(i).getAttribute("AccountModBO.GroupHouseHold.GroupHouseHoldName"));
				sHouseHoldCode      		= trim(document.all.RowRecordSet.rows(i).getAttribute("AccountModBO.GroupHouseHold.GroupHouseHoldCode"));
				sHouseHoldMasterID		= trim(document.all.RowRecordSet.rows(i).getAttribute("AccountModBO.GroupHouseHold.GroupHouseHoldMasterID"));
				HouseHoldName[HouseHoldName.length]   		 = sHouseHoldName;
				HouseHoldCode[HouseHoldCode.length] 			 = sHouseHoldCode;
				HouseHoldMasterID[HouseHoldMasterID.length]  = sHouseHoldMasterID;
				HouseHoldURL[HouseHoldURL.length] 			 = sHouseHoldName + sHouseHoldCode;
				HouseHoldID[HouseHoldID.length]				 = sHouseHoldID;
				document.all.RowRecordSet.rows(i).setAttribute('RowID', i-2);
				document.all.RowRecordSet.rows(i).setAttribute("AccountModBO.GroupHouseHold.url_", sHouseHoldName + sHouseHoldCode);
			}
			recordIndex1 = i-2;
		}
	}
    //xml encoding changes-- end
// HouseHold fields inclusion :End
	/* CIF PhoneEmail Changes : Start */
 //xml encoding changes-- start
	if(boName=='AccountBO')
	{
	for (i=0; i &lt; document.all.PhoneEmailRecordSet.rows.length; i++) {
	    	var phoneEmailId ='';
			phoneEmailId = document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneEmailID");
		if ((phoneEmailId != null) &amp;&amp; (phoneEmailId != 'undefined') &amp;&amp; phoneEmailId != "") {
				email  = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.Email"));
				phoneNo = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneNo"));
				phoneOrEmail = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneOrEmail"));
				extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.WorkExtension"));
			if(phoneOrEmail == "PHONE")
			{
					phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneEmailType"));
				phoneEmail_URL[phoneEmail_URL.length] = phoneNo + phoneEmailType;
					document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountBO.PhoneEmail.url_", phoneNo + phoneEmailType);
			}
			else
			{
					phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneEmailType"));
				phoneEmail_URL[phoneEmail_URL.length] = email + phoneEmailType;
					document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountBO.PhoneEmail.url_", email + phoneEmailType);
				}
				phoneNoCountryCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneNoCountryCode"));
				phoneNoCityCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneNoCityCode"));
				phoneNoLocalCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneNoLocalCode"));
				extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.WorkExtension"));
			phoneEmailId = trim(phoneEmailId);
			ad_PhoneOrEmail[ad_PhoneOrEmail.length] = phoneOrEmail
			ad_PhoneEmailType[ad_PhoneEmailType.length] = phoneEmailType
			ad_PhoneEmailID[ad_PhoneEmailID.length] = phoneEmailId
			ad_extension[ad_extension.length] = extension;
			ad_Email[ad_Email.length] = email;
			ad_PhoneNo[ad_PhoneNo.length] = phoneNo;
			ad_PhoneNoCountryCode[ad_PhoneNoCountryCode.length] = phoneNoCountryCode;
			ad_PhoneNoCityCode[ad_PhoneNoCityCode.length] = phoneNoCityCode;
			ad_PhoneNoLocalCode[ad_PhoneNoLocalCode.length] = phoneNoLocalCode;
			ad_extension[ad_extension.length] = extension;
			phoneEmail_Status[phoneEmail_Status.length] = "Add";
		}
		}

	}else if(boName=='AccountModBO')
	{
		for (i=0; i &lt; document.all.PhoneEmailRecordSet.rows.length; i++) {
		    	var phoneEmailId ='';
			phoneEmailId = document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.PhoneEmailID");
			if ((phoneEmailId != null) &amp;&amp; (phoneEmailId != 'undefined') &amp;&amp; phoneEmailId != "") {
				email  = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.Email"));
				phoneNo = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.PhoneNo"));
				phoneOrEmail = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.PhoneOrEmail"));
				extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.WorkExtension"));
				if(phoneOrEmail == "PHONE")
				{
					phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.PhoneEmailType"));
					phoneEmail_URL[phoneEmail_URL.length] = phoneNo + phoneEmailType;
					document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountModBO.PhoneEmail.url_", phoneNo + phoneEmailType);
				}
				else
				{
					phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.PhoneEmailType"));
					phoneEmail_URL[phoneEmail_URL.length] = email + phoneEmailType;
					document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountModBO.PhoneEmail.url_", email + phoneEmailType);
				}
				phoneNoCountryCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.PhoneNoCountryCode"));
				phoneNoCityCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.PhoneNoCityCode"));
				phoneNoLocalCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.PhoneNoLocalCode"));
				extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.WorkExtension"));
				phoneEmailId = trim(phoneEmailId);
				ad_PhoneOrEmail[ad_PhoneOrEmail.length] = phoneOrEmail
				ad_PhoneEmailType[ad_PhoneEmailType.length] = phoneEmailType
				ad_PhoneEmailID[ad_PhoneEmailID.length] = phoneEmailId
				ad_extension[ad_extension.length] = extension;
				ad_Email[ad_Email.length] = email;
				ad_PhoneNo[ad_PhoneNo.length] = phoneNo;
				ad_PhoneNoCountryCode[ad_PhoneNoCountryCode.length] = phoneNoCountryCode;
				ad_PhoneNoCityCode[ad_PhoneNoCityCode.length] = phoneNoCityCode;
				ad_PhoneNoLocalCode[ad_PhoneNoLocalCode.length] = phoneNoLocalCode;
				ad_extension[ad_extension.length] = extension;
				phoneEmail_Status[phoneEmail_Status.length] = "Add";
			}
		}
 //xml encoding changes-- end
	}
	document.getElementsByName("AccountBO.Address.preferredAddress")[0].value = '<xsl:value-of select = "$preferredAddressType"/>';
	document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value = '<xsl:value-of select = "$preferredPhone"/>';
	document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value = '<xsl:value-of select = "$preferredEmail"/>';
} else {
 //xml encoding changes-- start
	if(boName=='AccountBO')
	{
for (i=0; i &lt; document.all.RecordSet.rows.length; i++) {
	var addrID ='';
	if(mainAccId != ""){
				addrID = document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.MainTableID");
	} else {
				addrID = document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.addressID");
	}
    if ((addrID != null) &amp;&amp; (addrID != 'undefined')) {
			address_type = document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.AddressCategory");
			end_date  = document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.End_Date");
			start_date = document.all.RecordSet.rows(i).getAttribute("AccountBO.Address.Start_Date");
			document.all.RecordSet.rows(i).setAttribute("AccountBO.Address.AddressCategory", address_type);
			document.all.RecordSet.rows(i).setAttribute("AccountBO.Address.End_Date", end_date);
			document.all.RecordSet.rows(i).setAttribute("AccountBO.Address.Start_Date", start_date);
	ad_address_type[ad_address_type.length] = address_type;
	ad_end_date[ad_end_date.length] = ad_end_date;
	ad_start_date[ad_start_date.length] = ad_start_date;
	ad_addrID[ad_addrID.length] = addrID;
    }
}

	}else if(boName=='AccountModBO')
	{
		for (i=0; i &lt; document.all.RecordSet.rows.length; i++)
		{
			var addrID ='';
			if(mainAccId != ""){
				addrID = document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.MainTableID");
			} else {
				addrID = document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.addressID");
			}
		        if ((addrID != null) &amp;&amp; (addrID != 'undefined')) {
			    address_type = document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.AddressCategory");
			    end_date  = document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.End_Date");
			    start_date = document.all.RecordSet.rows(i).getAttribute("AccountModBO.Address.Start_Date");
			    document.all.RecordSet.rows(i).setAttribute("AccountModBO.Address.AddressCategory", address_type);
			    document.all.RecordSet.rows(i).setAttribute("AccountModBO.Address.End_Date", end_date);
			    document.all.RecordSet.rows(i).setAttribute("AccountModBO.Address.Start_Date", start_date);
			    ad_address_type[ad_address_type.length] = address_type;
			    ad_end_date[ad_end_date.length] = ad_end_date;
			    ad_start_date[ad_start_date.length] = ad_start_date;
			    ad_addrID[ad_addrID.length] = addrID;
		        }
		}
	}
 //xml encoding changes-- end
}
}catch(e){
}
}

//Native Language Changes:end

// CIF Changes Shanmuga - Start
// Function to load the Currency dropdown field
function loadBaseCurrency()
{
	//var baseCurrency = '<xsl:value-of select="$BaseCurrency"/>';
	var baseCurrency = Currency;
	document.getElementsByName("DemographicBO.CU_Annual_Salary_Income")[0].value = baseCurrency;
	//house hold id changes-begin
	//document.frm2.newHouseVal.value = document.getElementsByName("AccountBO.householdName")[0].value;
	//house hold id changes-end
	}
// Functon to format the Annual Salary Income field value
function formatDemographyAmount()
{
	try{
		baseCurrency = '<xsl:value-of select="$BaseCurrency"/>';
		formatAmount("3_PsychographicBO.MiscellaneousInfo.dbFloat1","PsychographicBO.MiscellaneousInfo.strText4","N");
		formatAmount("3_DemographicBO.Annual_Salary_Income","DemographicBO.CU_Annual_Salary_Income","N");
	}
	catch(e)
	{
	}
}
// CIF Cahnges Shanmuga - End
	// CIF Changes Shanmuga - NRE Changes - Start
	function makePassportMandatory(){
		var nreFlag = document.getElementsByName(boName+".CustomerNREFlg")[0];
		//Last Edited Page starts
		if ((nreFlag.value) == 'Y'){
			document.getElementsByName(boNameDemo+".MiscellaneousInfo.Type_code")[0].value="PSPOT";
			document.getElementsByName("DemographicBO.MiscellaneousInfo.Type")[0].value="Passport Number";
			document.getElementsByName(boNameDemo+".MiscellaneousInfo.Type_code")[0].disabled=true;
		}
		else{
			document.getElementsByName(boNameDemo+".MiscellaneousInfo.Type_code")[0].value="";
			document.getElementsByName(boNameDemo+".MiscellaneousInfo.Type_code")[0].disabled=false;
		}
		//Last Edited Page ends
	}

	// CIF Changes Shanmuga - NRE Changes - End

	// CIF Changes - Shanmuga - to fix a object expected bug
	function validateKeys()
	{
		if((event.keyCode&gt;47&amp;&amp;event.keyCode&lt;58)||(event.keyCode&gt;96&amp;&amp;event.keyCode&lt;123)||(event.keyCode&gt;64&amp;&amp;event.keyCode&lt;91))
		{
		}
		else
		{
			showMessage(MSGX0008);
			event.keyCode = 0;
			return false;
		}
	}
	// CIF Changes - Shanmuga

	// Start of changes by rozy for currency

	function currencyOnLoad()
	{
	formatPercent("3_PsychographicBO.MiscellaneousInfo.dbFloat1");
	formatPercent("3_PsychographicBO.MiscellaneousInfo.dbFloat2");
	formatPercent("3_PsychographicBO.MiscellaneousInfo.dbFloat3");
	formatNumber("3_PsychographicBO.MiscellaneousInfo.dbFloat4");

	var WithholdTaxFloor = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat4")[0].value;
	try{
	if(WithholdTaxFloor=='')
	document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat4")[0].value='0';
	else
	document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat4")[0].value=WithholdTaxFloor;
	}catch(e)
	{}
	}
	// End of changes by rozy for currency

	// CIF Changes - Primary Introducer
	function introCreate(){
		<!--TRACKER ID : 78621 : BEGIN OF CHANGES-->
		// Last Edited page changes starts
		<!--TRACKER ID : 78621 : END OF CHANGES-->

	/* Tracker ID- 150493, Ticket ID : 249521 Changes Start
		document.getElementsByName(boName+".IntroducerSalutation")[0].disabled = false;



		document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = false;
		if(document.getElementsByName("AccountBO.IntroducerID")[0].value == "") {
		       if(document.all.isAutoGenKey.value == 'true') {
		       document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory = "false";
		       document.getElementsByName("AccountBO.IntroducerID")[0].readOnly = true;
		       }
		       else{
		       document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory = "true";
		       }
		}
		else{
		document.getElementsByName("AccountBO.IntroducerID")[0].IsMandatory = "true";
		}
		document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="visible";
		//Last Edited Page change

		document.getElementsByName(boName+".IntroducerSalutation")[0].IsMandatory="false";
		document.getElementsByName(boName+".IntroducerSalutation")[0].style.visibility="visible";
		//Last Edited Page change

		document.getElementsByName("mandStarAccountBO.IntroducerName")[0].style.visibility="visible";
		document.getElementsByName("AccountBO.IntroducerName")[0].IsMandatory="true";
	* Tracker ID- 150493, Ticket ID : 249521 Changes Start */

	fvDisableObjectIntro();

	}
// Last Edited page changes starts
	function introEdit(){

		document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = true;

		document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = true;

		document.getElementsByName("AccountBO.IntroducerID")[0].readOnly = true;

// Last Edited page changes ends
	}
/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
function checkEbankFields()
{
 		<!-- Changes for Track ID 223945 Begin-->
 		var isEbankingEnabled=document.getElementsByName(boName+".IsEbankingEnabled")[0].value;
 		<!-- Changes for Track ID 223945 End-->
 	if(isEbankingEnabled=='Y')
	{
 		document.getElementsByName("IsSMSBankingEnabled")[0].disabled=false;
		document.getElementsByName("IsWAPBankingEnabled")[0].disabled=false;
		/* Changes Begin for Tracker 126433 : SMS Banking Mobile Number should
		be enabled only after we check the SMS Banking check box */

		document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].disabled=true;

		/* Changes Begin for Tracker 126433 */
	}
	else
	{
		document.getElementsByName("IsSMSBankingEnabled")[0].checked=false;
		document.getElementsByName("IsSMSBankingEnabled")[0].disabled=true;
		document.getElementsByName("IsWAPBankingEnabled")[0].checked=false;
		document.getElementsByName("IsWAPBankingEnabled")[0].disabled=true;
 		document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].disabled=true;
	}

}
	<!-- Changes for Track ID 223945 Begin-->
function changeWAPBanking(){
		if(document.getElementsByName("IsWAPBankingEnabled")[0].checked){
			document.getElementsByName("IsWAPBankingEnabled")[0].value = true ;		
			}
			else{
				document.getElementsByName("IsWAPBankingEnabled")[0].value = false ;
				}
	}
	
	function isSMSOrWAPEnabled()
{
	var isSMSBanking = '<xsl:value-of select="$isSMSBanking"/>';
	
	var isWAPBanking = '<xsl:value-of select="$isWAPBanking"/>';
	
	var SMSBanking = document.getElementsByName("IsSMSBankingEnabled")[0];
	var WAPBanking = document.getElementsByName("IsWAPBankingEnabled")[0];

	if(isSMSBanking=='Y')
	{
		SMSBanking.checked=true;
    document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].readOnly=false;
	}
	if(isWAPBanking=='Y')
	{
		WAPBanking.checked=true;
	}
}

// code changes starts for CallId:580758
function changeGender(boName) { 
   // code changes ends for CallId:580758 

	var salutation = document.getElementsByName(boName+".Salutation_code")[0].value;
	//Ticket Id  - 203648 : Begin
	var sal = salutation.toLowerCase();
	if (sal == 'mr.' ) {
		document.getElementsByName(boName+".Gender")[0].value ='M';
	}
	else if (sal == 'mrs.' ||sal == 'ms.') {
	//Ticket Id  - 203648 : End
		document.getElementsByName(boName+".Gender")[0].value ='F';
	}
	
}
	
	<!-- Changes for Track ID 223945 End-->
function changeSMSBanking()
{
 	if(document.getElementsByName("IsSMSBankingEnabled")[0].checked)
	{
		//document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].disabled=false;
		document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].readOnly=false;
		//IUT fix for SSV, IsSMSBanking flag should be made true if checked
		<!-- Changes for Track ID 223945  Begin-->
		document.getElementsByName("IsSMSBankingEnabled")[0].value = true;
		<!-- Changes for Track ID 223945  End-->
		//IUT fix for SSV
		
		 /* Changes Begin for Tracker 126433 SMS Banking Mobile Number should
		be enabled only after we check the SMS Banking check box  */

		document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].disabled=false;

        /* Changes End for Tracker 126433 */

		document.getElementsByName("mandStarAccountBO.SMSBankingMobileNumber")[0].style.visibility = "";
	}
	else
	{	//IUT fix for SSV, IsSMSBanking flag should be made false if unchecked
				<!-- Changes for Track ID 223945  Begin-->
		document.getElementsByName("IsSMSBankingEnabled")[0].value = false;
        document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].value = "";
        <!-- Changes for Track ID 223945  End-->
		//IUT fix for SSV
		//document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].disabled=true;
		document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].readOnly=true;
		document.getElementsByName("mandStarAccountBO.SMSBankingMobileNumber")[0].style.visibility = "hidden";
	}
}

/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
/* Fix for Tracker#79170 Starts: Dummy SortMe function is added to avoid js error */
	<![CDATA[
          function sortMe(sortColumn,sortOrder) {
           }]]>
/* Fix for Tracker#79170 Ends */
</script>
<!--JAVASCRIPT FUNCTIONS ends here-->

			<xsl:apply-templates select="SRM"/>

	</body>
</html>
</xsl:template>
<!-- Templates For General Tab Start -->
<!--CIF Changes for new fields added in QDE: Start-->
<!-- LastEdited change :start-->
 	<xsl:template name="AccountBO.CustomerMinor">
 	                        <xsl:call-template name="mdrpdown">
 	                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.CustomerMinor']"/>
 	                       <!-- Last Edited page changes starts-->
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CustomerMinor</xsl:with-param>
 	                        <xsl:with-param name="selectdisp">AccountBO.CustomerMinor</xsl:with-param>
 	                        <xsl:with-param name="onchangefn">checkAge();</xsl:with-param>
 	                        <xsl:with-param name="search_type">value</xsl:with-param>
 	                        <xsl:with-param name="choice_name">AccountBO.CustomerMinor</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
 	                        </xsl:call-template>
                 </xsl:template>
<!-- LastEdited change :end-->




                      <!-- Senior Citizen Starts-->
		                      <xsl:template name="AccountBO.SeniorCitizen">
				                  <xsl:call-template name="mdrpdown">
				                                                  <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.SeniorCitizen']"/>
				                                                  <xsl:with-param name="selectdisp">AccountBO.SeniorCitizen</xsl:with-param>
				                                                  <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.SeniorCitizen</xsl:with-param>
				                                                  <xsl:with-param name="choice_name">AccountBO.SeniorCitizen</xsl:with-param>
				                                                  <xsl:with-param name="search_type">url</xsl:with-param>
				                                  <xsl:with-param name="onchangefn">checkAgeSC();</xsl:with-param> 
				      
				                                                  <xsl:with-param name="presdata" select="$PresData"/>
				                               </xsl:call-template>
				                            </xsl:template>               
		                  
		                  <xsl:template name="AccountBO.SenCitizenApplicableDate"> 
				             <xsl:call-template name="label"> 
				          	   <xsl:with-param name="ele_name">AccountBO.SenCitizenApplicableDate</xsl:with-param>
				          	   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"></xsl:value-of>.SenCitizenApplicableDate</xsl:with-param>
				          	   <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.SenCitizenApplicableDate");</xsl:with-param>
				          	   <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.SenCitizenApplicableDate']" />
				             </xsl:call-template> 
                                 </xsl:template> 
                 <!-- Senior Citizen Ends-->
                 
      <!--  <xsl:template name="AccountBO.StaffEmployeeID">
		  <xsl:call-template name="label">
			  <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StaffEmployeeID']"/>
			    <xsl:with-param name="ele_name">AccountBO.StaffEmployeeID</xsl:with-param>
			    <xsl:with-param name="ele_val">AccountBO.StaffEmployeeID</xsl:with-param>
			    <xsl:with-param name="fn_onKeyPress">validateKeys()</xsl:with-param>
			    <xsl:with-param name="fn_onBlur">setEmploymentProof();</xsl:with-param>
			    <xsl:with-param name="starshow">true</xsl:with-param>
		  </xsl:call-template>
	</xsl:template> -->

	<xsl:template name="AccountBO.StaffEmployeeID">
		 	<xsl:call-template name="lookup">
		 	<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StaffEmployeeID']"/>
		 	<xsl:with-param name="elename">AccountBO.StaffEmployeeID</xsl:with-param>
		  		 	<!-- Last Edited Page changes starts -->
		  		 	<!--<xsl:with-param name="eleval">AccountBO.StaffEmployeeID</xsl:with-param>-->
		  		 	<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.StaffEmployeeID</xsl:with-param>
		  		 	<!-- Last Edited Page changes ends-->
		 	<xsl:with-param name="starshow">true</xsl:with-param>
		 	<xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
		 	<xsl:with-param name="buttonone_name">LookUp</xsl:with-param>
		 	<xsl:with-param name="buttontwo_name">Clear</xsl:with-param>
		 	<xsl:with-param name="buttonone_fnc">openEmployeeIDLookup()</xsl:with-param>
		 	<xsl:with-param name="buttontwo_fnc">clearLookup("EmpID")</xsl:with-param>
		 	<xsl:with-param name="checkASCII">false</xsl:with-param>
		 	</xsl:call-template>
	</xsl:template>

<!--ERPBOCF1:TRACKER:113259:BEGINOFCHANGES(HIJRI)-->
<!-- declaring template Preferred Calendar-->
<xsl:template name="AccountBO.preferredCalendar">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.preferredCalendar']"/>
		<xsl:with-param name="selectdisp">AccountBO.preferredCalendar</xsl:with-param>
		<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.preferredCalendar</xsl:with-param>
		<xsl:with-param name="choice_name">AccountBO.preferredCalendar</xsl:with-param>
		<xsl:with-param name="max_length">50</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
		</xsl:template>
<!--ERPBOCF1:TRACKER:113259:ENDOFCHANGES(HIJRI)-->

	 <xsl:template name="AccountBO.DateOfBecomingNRE">
	             <xsl:call-template name="label">
	                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.DateOfBecomingNRE']"/>
	                <xsl:with-param name="ele_name">AccountBO.DateOfBecomingNRE</xsl:with-param>
	                <!-- Last Edited Page changes starts -->
	               <!-- <xsl:with-param name="ele_val">AccountBO.DateOfBecomingNRE</xsl:with-param>-->
	               <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.DateOfBecomingNRE</xsl:with-param>
	               <!-- Last Edited Page changes starts -->
	 		<xsl:with-param name="starshow">true</xsl:with-param>
	 		<xsl:with-param name="fn_onBlur">validateDate();</xsl:with-param>
	             </xsl:call-template>
        </xsl:template>
	 <xsl:template name="AccountBO.NREBecomingOrdDate">
	             <xsl:call-template name="label">
	                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.NREBecomingOrdDate']"/>
	                <xsl:with-param name="ele_name">AccountBO.NREBecomingOrdDate</xsl:with-param>
	                <!-- Last Edited Page changes starts -->
	                <!--<xsl:with-param name="ele_val">AccountBO.NREBecomingOrdDate</xsl:with-param>-->
	                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.NREBecomingOrdDate</xsl:with-param>
	                <!-- Last Edited Page changes ends-->
	 		<xsl:with-param name="starshow">true</xsl:with-param>
	 		<xsl:with-param name="fn_onBlur">validateDate();</xsl:with-param>
	             </xsl:call-template>
        </xsl:template>

	<xsl:template name="DemographicBO.Employment_Status">
	      <xsl:call-template name="mdrpdown">
	      <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.Employment_Status']"/>
	      <!-- Last Edited Page changes starts -->
		      <!--<xsl:with-param name="selectname">DemographicBO.Employment_Status</xsl:with-param>-->
		      <xsl:with-param name="selectname"><xsl:value-of select="$boNameDemo"/>.Employment_Status</xsl:with-param>
	      <xsl:with-param name="selectdisp">DemographicBO.Employment_Status</xsl:with-param>
	      <xsl:with-param name="ele_name">DemographicBO.Employment_Status</xsl:with-param>
		      <xsl:with-param name="choice_name">DemographicBO.Employment_Status</xsl:with-param>
		      <!-- Last Edited Page changes ends-->
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
	      </xsl:call-template>
	 </xsl:template>

	    <!-- CODE ADDED BY KAMAL for tracker id 349409 -->
	     <xsl:template name="DemographicBO.MiscellaneousInfo.strText2">
	   <xsl:call-template name="lookup">
		  <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.StrText2_code']"/>
			  <xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.strText2</xsl:with-param>
			  <xsl:with-param name="eleval">DemographicBO.MiscellaneousInfo.strText2</xsl:with-param>
			   <!-- Field Rationalization changes start -->
					<!--   <xsl:with-param name="code_req">true</xsl:with-param> -->
							<!-- Field Rationalization changes end -->
					<!--  TRACKER ID:150150  CHANGES BEGIN   -->
							<xsl:with-param name="buttonone_name" select="$configLabels[@name='BTN_LOOKUP']/@configLabel"/>
							<xsl:with-param name="buttontwo_name" select="$configLabels[@name='BTN_CLEAR']/@configLabel"/>
							<xsl:with-param name="buttonone_fnc">categoryLookup('CONTACT_OCCUPATION', 'DemographicBO.MiscellaneousInfo.strText2')</xsl:with-param>
							<xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.MiscellaneousInfo.strText2')</xsl:with-param>
							<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
							<xsl:with-param name="checkASCII">false</xsl:with-param>
					<!--  TRACKER ID:150150  CHANGES END  -->
				<!-- CIF Changes for Caching Views : Start -->
			<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
			       </xsl:call-template>
			    </xsl:template>
	        
  <!-- CODE ADDED BY KAMAL for tracker id 349409 -->

<!--CIF Changes for new fields added in QDE: End-->

	<xsl:template name="AccountBO.RelationshipOpeningDate">
	            <xsl:call-template name="label">
	              <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.RelationshipOpeningDate']"/>
	               <xsl:with-param name="selectname">AccountBO.RelationshipOpeningDate</xsl:with-param>
	               <xsl:with-param name="selectdisp">AccountBO.RelationshipOpeningDate</xsl:with-param>
	               <xsl:with-param name="ele_name">AccountBO.RelationshipOpeningDate</xsl:with-param>
	               <!-- Last Edited Page changes starts -->
	               <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.RelationshipOpeningDate</xsl:with-param>
	               <!-- Last Edited Page changes ends-->
	               <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
	               <!-- calling the function isGregDate for on blur functionality-->
	               <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.RelationshipOpeningDate");</xsl:with-param>
	               <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
	            </xsl:call-template>
      </xsl:template>


      <xsl:template name="AccountBO.rm_group_id">
                 <xsl:call-template name="label">
                   <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.rm_group_id']"/>
                    <xsl:with-param name="selectname">AccountBO.rm_group_id</xsl:with-param>
                    <xsl:with-param name="selectdisp">AccountBO.rm_group_id</xsl:with-param>
                    <xsl:with-param name="ele_name">AccountBO.rm_group_id</xsl:with-param>
                    <!-- Last Edited Page changes starts -->
                    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.rm_group_id</xsl:with-param>
                    <!-- Last Edited Page changes ends-->
            </xsl:call-template>
     </xsl:template>


     <xsl:template name="AccountBO.PreferredName">
                 <xsl:call-template name="label">
                    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PreferredName']"/>
                    <xsl:with-param name="selectname">AccountBO.PreferredName</xsl:with-param>
                    <xsl:with-param name="selectdisp">AccountBO.PreferredName</xsl:with-param>
                    <xsl:with-param name="ele_name">AccountBO.PreferredName</xsl:with-param>
                    <!-- Last Edited Page changes starts -->
                    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.PreferredName</xsl:with-param>
                    <!-- Last Edited Page changes ends-->
					<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
                 </xsl:call-template>
     </xsl:template>
<!-- LastEdited change :start-->
<!--changes for 371155 begin-->
     <xsl:template name="AccountBO.region">
      	        <xsl:call-template name="lookup">
      			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.region']"/>
      			<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.region</xsl:with-param>
      			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.region</xsl:with-param>
      			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
      			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
      			<xsl:with-param name="buttonone_fnc">categoryLookup('REGION', 'AccountBO.region')</xsl:with-param>
      			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.region')</xsl:with-param>
      			<xsl:with-param name="checkASCII">false</xsl:with-param>
      			<xsl:with-param name="code_req">true</xsl:with-param>
      		</xsl:call-template>
</xsl:template>
<!--changes for 371155 ends-->
<!-- LastEdited change :end-->
	<!--CIF GroupHousehold changes Start
	<xsl:template name="AccountBO.householdID">
	<xsl:call-template name="lookup">
	<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.householdID']"/>
	<xsl:with-param name="elename">AccountBO.householdID</xsl:with-param>
	<xsl:with-param name="eleval">AccountBO.householdID</xsl:with-param>
	<xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
	<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
	<xsl:with-param name="buttonone_fnc">openHouseHldLookup()</xsl:with-param>
	<xsl:with-param name="buttontwo_fnc">clearLookup("HsHld")</xsl:with-param>
	<xsl:with-param name="checkASCII">false</xsl:with-param>
	</xsl:call-template>
	</xsl:template>
	<xsl:template name="AccountBO.householdName">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.householdName']"/>
	<xsl:with-param name="selectname">AccountBO.householdName</xsl:with-param>
	<xsl:with-param name="selectdisp">AccountBO.householdName</xsl:with-param>
	<xsl:with-param name="ele_name">AccountBO.householdName</xsl:with-param>
	<xsl:with-param name="max_length">50</xsl:with-param>
	<xsl:with-param name="disable_val">true</xsl:with-param>
	<xsl:with-param name="checkASCII">false</xsl:with-param>
	</xsl:call-template>
	</xsl:template>
	CIF GroupHousehold changes: End -->
 <!--Native Language Changes:start-->
	  <xsl:template name="AccountBO.Cust_First_Name_Native">
		   <xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_First_Name_Native']"/>
		    <xsl:with-param name="ele_name">AccountBO.Cust_First_Name_Native</xsl:with-param>
		    <!-- Last Edited Page change Starts-->
		    <!--<xsl:with-param name="ele_val">AccountBO.Cust_First_Name_Native</xsl:with-param>-->
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name_Native</xsl:with-param>
		    <!-- Last Edited Page change ends-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	     </xsl:call-template>
	 </xsl:template>
	  	  <xsl:template name="AccountBO.Cust_Middle_Name_Native">
		   <xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Middle_Name_Native']"/>
		    <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_Native</xsl:with-param>
		    <!-- Last Edited Page change Starts-->
		    <!--<xsl:with-param name="ele_val">AccountBO.Cust_Middle_Name_Native</xsl:with-param>-->
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name_Native</xsl:with-param>
		    <!-- Last Edited Page change ends-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		</xsl:call-template>
		</xsl:template>
	 <xsl:template name="AccountBO.accessOwnerSegment">
	     <xsl:call-template name="mdrpdown">
		 <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.accessOwnerSegment']"/>
		 <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.accessOwnerSegment</xsl:with-param>
		 <xsl:with-param name="selectdisp">AccountBO.accessOwnerSegment</xsl:with-param>
		 <xsl:with-param name="presdata" select="$PresData"/>
		 <xsl:with-param name="search_type">value</xsl:with-param>
		 <xsl:with-param name="choice_name">AccountBO.accessOwnerSegment</xsl:with-param>
		 <xsl:with-param name="onchangefn">setAccessOwnerSegment();</xsl:with-param>
	     </xsl:call-template>
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

	<xsl:template name="AccountBO.accessOwnerBC">
	<xsl:call-template name="lookup">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.accessOwnerBC']"/>
		<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.accessOwnerBC</xsl:with-param>
		<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.accessOwnerBC</xsl:with-param>
		<!--xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param-->
		<xsl:with-param name="buttonone_name" ><xsl:value-of select="$configLabels[@name='LOOKUP']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="buttontwo_name" ><xsl:value-of select="$configLabels[@name='CLEAR']/@configLabel"/></xsl:with-param>
		<!--xsl:with-param name="buttonone_fnc">openBCCodeLookup('accessOwnerBC')</xsl:with-param-->
		<xsl:with-param name="buttonone_fnc">fnBlurFunction('BusinessCenter')</xsl:with-param>
		<xsl:with-param name="buttontwo_fnc">setBCCodeValues('accessOwnerBC','','')</xsl:with-param>

	</xsl:call-template>
	</xsl:template>

	 	  <xsl:template name="AccountBO.Cust_Last_Name_Native">
		   <xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Last_Name_Native']"/>
		    <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_Native</xsl:with-param>
		    <!-- Last Edited Page change Starts-->
		    <!--<xsl:with-param name="ele_val">AccountBO.Cust_Last_Name_Native</xsl:with-param>-->
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name_Native</xsl:with-param>
		    <!-- Last Edited Page change ends-->
<!-- Fix for call id: 428627 Starts -->
		    <xsl:with-param name="max_length">80</xsl:with-param>
<!-- Fix for call id: 428627 Ends -->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		</xsl:call-template>
		</xsl:template>

	  <xsl:template name="AccountBO.Short_Name_Native">
		   <xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Short_Name_Native']"/>
		    <xsl:with-param name="ele_name">AccountBO.Short_Name_Native</xsl:with-param>
		    <xsl:with-param name="max_length">10</xsl:with-param>
		    <!-- Last Edited Page change Starts-->
		    <!--<xsl:with-param name="ele_val">AccountBO.Short_Name_Native</xsl:with-param>-->
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Short_Name_Native</xsl:with-param>
		    <!-- Last Edited Page change ends-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		   </xsl:call-template>
	  </xsl:template>
	  <xsl:template name="AccountBO.Cust_First_Name_Native1">
		   <xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_First_Name_Native1']"/>
		    <xsl:with-param name="ele_name">AccountBO.Cust_First_Name_Native1</xsl:with-param>
		    <!-- Last Edited Page change Starts-->
		    <!--<xsl:with-param name="ele_val">AccountBO.Cust_First_Name_Native1</xsl:with-param>-->
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name_Native1</xsl:with-param>
		    <!-- Last Edited Page change ends-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		   </xsl:call-template>
	  </xsl:template>
	  <xsl:template name="AccountBO.Cust_Middle_Name_Native1">
		   <xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Middle_Name_Native1']"/>
		    <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_Native1</xsl:with-param>
		    <!-- Last Edited Page changes starts -->
		    <!--<xsl:with-param name="ele_val">AccountBO.Cust_Middle_Name_Native1</xsl:with-param>-->
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name_Native1</xsl:with-param>
		    <!-- Last Edited Page changes ends-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		   </xsl:call-template>
	  </xsl:template>
	  <xsl:template name="AccountBO.Cust_Last_Name_Native1">
		   <xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Last_Name_Native1']"/>
		    <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_Native1</xsl:with-param>
		    <!-- Last Edited Page changes starts -->
		    <!--<xsl:with-param name="ele_val">AccountBO.Cust_Last_Name_Native1</xsl:with-param>-->
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name_Native1</xsl:with-param>
		    <!-- Last Edited Page changes ends-->
<!-- Fix for call id: 428627 Starts -->
		    <xsl:with-param name="max_length">80</xsl:with-param>
<!-- Fix for call id: 428627 Ends -->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		   </xsl:call-template>
	  </xsl:template>
	  <xsl:template name="AccountBO.Short_Name_Native1">
		   <xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Short_Name_Native1']"/>
		    <xsl:with-param name="ele_name">AccountBO.Short_Name_Native1</xsl:with-param>
		    <xsl:with-param name="max_length">10</xsl:with-param>
		    <!-- Last Edited Page changes starts -->
		    <!--<xsl:with-param name="ele_val">AccountBO.Short_Name_Native1</xsl:with-param>-->
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Short_Name_Native1</xsl:with-param>
		    <!-- Last Edited Page changes ends-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		   </xsl:call-template>
	  </xsl:template>
<!--Native Language Changes:end-->

     <xsl:template name="AccountBO.Gender">
                      <xsl:call-template name="mdrpdown">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Gender']"/>
          <!-- LastEdited change :start-->
       	  <!--<xsl:with-param name="selectname">AccountBO.Gender</xsl:with-param>-->
          <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Gender</xsl:with-param>
          <xsl:with-param name="search_type">value</xsl:with-param>
              <!-- Fix for tracker id 338124 : begin -->
	      <!-- <xsl:with-param name="defaultValue">Male</xsl:with-param> -->
	      <!-- Fix for tracker id 338124 : end -->
		  <xsl:with-param name="choice_name">AccountBO.Gender</xsl:with-param>
          <!-- LastEdited change :end-->
                         <xsl:with-param name="selectdisp">AccountBO.Gender</xsl:with-param>
                         <xsl:with-param name="ele_name">AccountBO.Gender</xsl:with-param>
                         <xsl:with-param name="onchangefn">checkSalutation('G')</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
                      </xsl:call-template>
     </xsl:template>

     <!--CIF Changes for new fields added in QDE: Start-->
<!-- LastEdited change :start-->
     	<xsl:template name="AccountBO.StaffFlag">
     	     <xsl:call-template name="mdrpdown">
     		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StaffFlag']"/>
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StaffFlag</xsl:with-param>
     		<xsl:with-param name="selectdisp">AccountBO.StaffFlag</xsl:with-param>


	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
                        <xsl:with-param name="onchangefn">disableStaffFieldConditionally('<xsl:value-of select="$boName"/>.StaffFlag', 'AccountBO.StaffEmployeeID');validateEmploymentProof();</xsl:with-param>
                        <xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="choice_name">AccountBO.StaffFlag</xsl:with-param>
     	      </xsl:call-template>
     	</xsl:template>
<!-- LastEdited change :end-->

<!-- LastEdited change :start-->
     	<xsl:template name="AccountBO.CustomerNREFlg">
     	      <xsl:call-template name="mdrpdown">
     		      <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.CustomerNREFlg']"/>
				  <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CustomerNREFlg</xsl:with-param>
     		      <xsl:with-param name="selectdisp">AccountBO.CustomerNREFlg</xsl:with-param>
				  <!-- CIF Changes for Caching Views : Start -->
				  <xsl:with-param name="presdata" select="$PresData"/>
		          <!-- CIF Changes for Caching Views : End -->
     		      <xsl:with-param name="search_type">value</xsl:with-param>
     		      <!--  CIF Changes Shanmuga - NRE Changes - Start -->
<!--commented for IDENTIFICATION DOCUMENT CHANGES start
     		      <xsl:with-param name="onchangefn">makeDateMand();makePassportMandatory();</xsl:with-param>
commented for IDENTIFICATION DOCUMENT CHANGES end-->
				  <xsl:with-param name="onchangefn">makeDateMand();</xsl:with-param>
				<xsl:with-param name="choice_name">AccountBO.CustomerNREFlg</xsl:with-param>
     	      	      <!--  CIF Changes Shanmuga - NRE Changes - End -->



     	      </xsl:call-template>
     	</xsl:template>
<!-- LastEdited change :end-->
     <!--CIF Changes for new fields added in QDE: End-->


        <xsl:template name="AccountBO.Cust_DOB">
	                 <xsl:call-template name="label">
	                   <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_DOB']"/>
	                    <xsl:with-param name="selectname">AccountBO.Cust_DOB</xsl:with-param>
	                    <xsl:with-param name="selectdisp">AccountBO.Cust_DOB</xsl:with-param>
	                    <xsl:with-param name="ele_name">AccountBO.Cust_DOB</xsl:with-param>
	                    <!-- Last Edited Page changes starts -->
	                    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_DOB</xsl:with-param>
	                    <!-- Last Edited Page changes ends-->
	                   <xsl:with-param name="fn_onBlur">validateMinorDOB();checkAge();checkAgeSC();</xsl:with-param>
	                 </xsl:call-template>
     </xsl:template>

     <xsl:template name="AccountBO.Cust_First_Name">
		  <xsl:call-template name="label">
		  <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_First_Name']"/>
		  <xsl:with-param name="selectname">AccountBO.Cust_First_Name</xsl:with-param>
		  <xsl:with-param name="selectdisp">AccountBO.Cust_First_Name</xsl:with-param>
		  <xsl:with-param name="ele_name">AccountBO.Cust_First_Name</xsl:with-param>
		  <!-- Last Edited Page changes starts -->
		  <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name</xsl:with-param>
		  <!-- Last Edited Page changes ends-->
		  <xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
                <xsl:with-param name="fn_onBlur">concatName();</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		   </xsl:call-template>
     </xsl:template>

<!-- TrackerID: 113227  begins  -->

				<xsl:template name="AccountBO.Cust_First_Name_alt1">
				  <xsl:call-template name="label_alternate">
				  <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_First_Name']"/>
				  <xsl:with-param name="ele_name">AccountBO.Cust_First_Name_alt1</xsl:with-param>
				  <!-- Last Edited Page changes starts -->
				  <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name_alt1</xsl:with-param>
				  <!-- Last Edited Page changes ends-->
				  <xsl:with-param name="checkASCII">false</xsl:with-param>
		  <xsl:with-param name="fn_onBlur">concatName_alt();set_isName(this,true);</xsl:with-param>
				   </xsl:call-template>
			     </xsl:template>


			<xsl:template name="AccountBO.Cust_Middle_Name_alt1">
			      <xsl:call-template name="label_alternate">
			       <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Middle_Name']"/>
			        <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_alt1</xsl:with-param>
			        <!-- Last Edited Page changes starts -->
			        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name_alt1</xsl:with-param>
			        <!-- Last Edited Page changes ends-->
							<xsl:with-param name="checkASCII">false</xsl:with-param>
	      <xsl:with-param name="fn_onBlur">concatName_alt();set_isName(this,true);</xsl:with-param>
			      </xsl:call-template>
			</xsl:template>

			<xsl:template name="AccountBO.Cust_Last_Name_alt1">
			          <xsl:call-template name="label_alternate">
				    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Last_Name']"/>
				    <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_alt1</xsl:with-param>
				    <!-- Last Edited Page changes starts -->
				    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name_alt1</xsl:with-param>
				    <!-- Last Edited Page changes ends-->
<!-- Fix for call id: 428627 Starts -->
				    <xsl:with-param name="max_length">80</xsl:with-param>
<!-- Fix for call id: 428627 Ends -->
					<xsl:with-param name="checkASCII">false</xsl:with-param>
	      <xsl:with-param name="fn_onBlur">concatName_alt();set_isName(this,true);</xsl:with-param>
			          </xsl:call-template>
			</xsl:template>

			<xsl:template name="AccountBO.short_name_alt1">
			          <xsl:call-template name="label_alternate">
				    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.short_name']"/>
				    <xsl:with-param name="ele_name">AccountBO.short_name_alt1</xsl:with-param>
				    <xsl:with-param name="max_length">10</xsl:with-param>
				    <!-- Last Edited Page changes starts -->
				    <!--<xsl:with-param name="ele_val">AccountBO.short_name</xsl:with-param>-->
				    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_name_alt1</xsl:with-param>
				    <!-- Last Edited Page changes ends-->
					<xsl:with-param name="checkASCII">false</xsl:with-param>
				<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
			          </xsl:call-template>
     			</xsl:template>

<!-- Code Commented out. Fix for tracker ID 119588
			<xsl:template name="AccountBO.PreferredName_alt1">
	                 	<xsl:call-template name="label_alternate">
				    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PreferredName']"/>
				    <xsl:with-param name="ele_name">AccountBO.PreferredName_alt1</xsl:with-param> -->
				    <!-- Last Edited Page changes starts -->
				  <!--  <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.PreferredName_alt1</xsl:with-param>-->
				    <!-- Last Edited Page changes ends-->
						<!--<xsl:with-param name="checkASCII">false</xsl:with-param>
					<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
					 </xsl:call-template>
		     </xsl:template>

Fix for tracker ID 119588 changes end -->
		     <xsl:template name="ContactBO.firstName_alt1">
		     		<xsl:call-template name="label_alternate">
		     		<xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.firstName']"/>
			      <!-- TrackerID: 119723 Changes  Start  -->
			       <xsl:with-param name="selectname">ContactBO.firstName_alt1</xsl:with-param>
			       <xsl:with-param name="selectdisp">ContactBO.firstName_alt1</xsl:with-param>
			       <!-- TrackerID: 119723 Changes  End  -->
		     		<xsl:with-param name="ele_name">ContactBO.firstName_alt1</xsl:with-param>
		     	<!-- 	<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param> -->
		     		</xsl:call-template>
		     	 </xsl:template>

		     	 <xsl:template name="ContactBO.middleName_alt1">
		     	        <xsl:call-template name="label_alternate">
		     	        <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.middleName']"/>
			     <!-- TrackerID: 119723 Changes  Start  -->
			    <xsl:with-param name="selectname">ContactBO.middleName_alt1</xsl:with-param>
			    <xsl:with-param name="selectdisp">ContactBO.middleName_alt1</xsl:with-param>
			     <!-- TrackerID: 119723 Changes  End  -->
			    <xsl:with-param name="ele_name">ContactBO.middleName_alt1</xsl:with-param>
		     	        </xsl:call-template>
		     	 </xsl:template>

		     	 <xsl:template name="ContactBO.lastName_alt1">
		     	        <xsl:call-template name="label_alternate">
		     	        <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.lastName']"/>
		         <!-- TrackerID: 119723 Changes  Start  -->
		       <xsl:with-param name="selectname">ContactBO.lastName_alt1</xsl:with-param>
		       <xsl:with-param name="selectdisp">ContactBO.lastName_alt1</xsl:with-param>
		        <!-- TrackerID: 119723 Changes  End  -->
		       <xsl:with-param name="ele_name">ContactBO.lastName_alt1</xsl:with-param>
		     	        </xsl:call-template>
	 		</xsl:template>
	   <!-- TrackerID: 119723 Changes  Start  -->
			<!-- <xsl:template name="RelationshipBO.Relationship_alt1">
			  	<xsl:call-template name="label_alternate">
			      <xsl:with-param name="res_name" select="$configLabelsMinor[@name='RelationshipBO.Relationship']"/>
			       <xsl:with-param name="ele_name">RelationshipBO.Relationship_alt1</xsl:with-param>
				 </xsl:call-template>
    			</xsl:template> -->
  <!-- TrackerID: 119723 Changes  End  -->
<!-- TrackerID: 113227  ENDS  -->

<!--  RefCode Changes	-->
	<xsl:template name="DemographicBO.Marital_Status">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.Marital_status_code']"/>
		<!-- Last Edited Page changes starts -->
		<!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boNameDemo"/>.Marital_Status</xsl:with-param>-->
		<xsl:with-param name="selectdisp">DemographicBO.Marital_status_code</xsl:with-param>
		<xsl:with-param name="selectname"><xsl:value-of select="$boNameDemo"/>.Marital_Status</xsl:with-param>
		<xsl:with-param name="choice_name">DemographicBO.Marital_status_code</xsl:with-param>
		<!-- Last Edited Page changes ends-->
		<xsl:with-param name="search_type">url</xsl:with-param>
		<!-- CIF Changes for Caching Views : Start -->
		<xsl:with-param name="presdata" select="$PresData"/>
		<!-- CIF Changes for Caching Views : End -->
		<xsl:with-param name="ele_name">DemographicBO.Marital_status_code</xsl:with-param>
		</xsl:call-template>
     </xsl:template>
     <!--  RefCode Changes	-->

     <xsl:template name="AccountBO.Cust_Middle_Name">
                      <xsl:call-template name="label">
                       <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Middle_Name']"/>
                        <xsl:with-param name="selectname">AccountBO.Cust_Middle_Name</xsl:with-param>
                        <xsl:with-param name="selectdisp">AccountBO.Cust_Middle_Name</xsl:with-param>
                        <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name</xsl:with-param>
                        <!-- Last Edited Page changes starts -->
                        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name</xsl:with-param>
                        <!-- Last Edited Page changes ends-->
						<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
                <xsl:with-param name="fn_onBlur">concatName();</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
                      </xsl:call-template>
     </xsl:template>

    <xsl:template name="AccountBO.Cust_Last_Name">
                          <xsl:call-template name="label">
			    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Last_Name']"/>
			    <xsl:with-param name="selectname">AccountBO.Cust_Last_Name</xsl:with-param>
			    <xsl:with-param name="selectdisp">AccountBO.Cust_Last_Name</xsl:with-param>
			    <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name</xsl:with-param>
			    <!-- Last Edited Page changes starts -->
 			    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name</xsl:with-param>
 			    <!-- Last Edited Page changes ends-->
				<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
                <xsl:with-param name="fn_onBlur">concatName();</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
                          </xsl:call-template>
     </xsl:template>
    <xsl:template name="AccountBO.short_name">
                          <xsl:call-template name="label">
			    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.short_name']"/>
			    <xsl:with-param name="selectname">AccountBO.short_name</xsl:with-param>
			    <xsl:with-param name="selectdisp">AccountBO.short_name</xsl:with-param>
			    <xsl:with-param name="ele_name">AccountBO.short_name</xsl:with-param>
			    <xsl:with-param name="max_length">10</xsl:with-param>
			    <!-- Last Edited Page changes starts -->
			    <!--<xsl:with-param name="ele_val">AccountBO.short_name</xsl:with-param>-->
			    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_name</xsl:with-param>
			    <!-- Last Edited Page changes ends-->
				<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
			<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
                          </xsl:call-template>
     </xsl:template>
<!--  RefCode Changes	-->
<!--Inclusion of Full Name field:start-->
	  <xsl:template name="AccountBO.Name">
		   <xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Name']"/>
		    <xsl:with-param name="ele_name">AccountBO.Name</xsl:with-param>
		    <!-- Last Edited Page changes starts -->
		    <!--<xsl:with-param name="ele_val">AccountBO.Name</xsl:with-param>-->
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Name</xsl:with-param>
		    <!-- Last Edited Page changes ends-->
		    <xsl:with-param name="starshow">true</xsl:with-param>
		    <xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
			<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		   </xsl:call-template>
	  </xsl:template>
<!--Inclusion of Full Name field:end-->

<!--Tracker ID 113227 starts-->
		 <xsl:template name="AccountBO.Name_alt1">
			<xsl:call-template name="label_alternate">
			    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Name_alt1']"/>
			    <xsl:with-param name="ele_name">AccountBO.Name_alt1</xsl:with-param>
			    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Name_alt1</xsl:with-param>
			    <xsl:with-param name="starshow">true</xsl:with-param>
			    <xsl:with-param name="checkASCII">false</xsl:with-param>
			    <xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
			</xsl:call-template>
		</xsl:template>
<!--Tracker ID 113227 ends-->
<!--Khushi changes from lookup to dropdown starts-->
<!-- TRACKER:371155:BEGINOFCHANGES -->
<!--          <xsl:template name="AccountBO.Salutation">
<xsl:call-template name="lookup">
<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Salutation_code']"/>
<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Salutation_code</xsl:with-param>
<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Salutation</xsl:with-param>
<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
<xsl:with-param name="buttonone_fnc">categoryLookup('PERSONSALUTATION','<xsl:value-of select="$boName"/>.Salutation_code');checkSalutation('S');changeGender('AccountBO');</xsl:with-param>
<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Salutation_code')</xsl:with-param>
<xsl:with-param name="checkASCII">false</xsl:with-param>
<xsl:with-param name="code_req">true</xsl:with-param>
</xsl:call-template>
</xsl:template> -->

            <xsl:template name="AccountBO.Salutation">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Salutation_code']"/>
                            <!-- Last Edited Page changes starts -->
                          <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.Salutation</xsl:with-param>-->
                            <xsl:with-param name="selectdisp">AccountBO.Salutation_code</xsl:with-param>
                          <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Salutation</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                          <xsl:with-param name="choice_name">AccountBO.Salutation_code</xsl:with-param>
                          <!-- Last Edited Page changes ends-->
                        <xsl:with-param name="onchangefn">checkSalutation('S');changeGender('AccountBO');</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>

<!--Khushi changes from lookup to dropdown ends-->

<!--  RefCode Changes	-->
<!-- TRACKER:371155:ENDOFCHANGES -->
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

     <!-- CIF Changes Shanmuga - Template for Annual Salary Income field - Start -->
	<xsl:template name="DemographicBO.Annual_Salary_Income">
		<xsl:call-template name="amountlabel">
			  <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.Annual_Salary_Income']"/>
			  <xsl:with-param name="ele_name">DemographicBO.Annual_Salary_Income</xsl:with-param>
			  <!-- Last Edited Page changes starts -->
			  <xsl:with-param name="ele_val"><xsl:value-of select="$boNameDemo"/>.Annual_Salary_Income</xsl:with-param>
			  <!-- Last Edited Page changes ends-->
			  <xsl:with-param name="fncname">rate("3_DemographicBO.Annual_Salary_Income","DemographicBO.CU_Annual_Salary_Income",'<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
			  <xsl:with-param name="selectname">DemographicBO.CU_Annual_Salary_Income</xsl:with-param>
			  <xsl:with-param name="amountselectname">DemographicBO.CU_Annual_Salary_Income</xsl:with-param>
			  <xsl:with-param name="onchangefn">checkDropValue("3_DemographicBO.Annual_Salary_Income","DemographicBO.CU_Annual_Salary_Income");</xsl:with-param>
			  <xsl:with-param name="choicename">DemographicBO.CU_Annual_Salary_Income</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
		</xsl:call-template>
	</xsl:template>
      <!-- CIF Changes Shanmuga - Template for Annual Salary Income field - End -->

<!--  RefCode Changes	-->
<!--  RefCode Changes	-->
<!-- Change done by Bharath start -->
	<xsl:template name="AccountBO.StrUserField11">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField11']"/>
		<xsl:with-param name="selectname">AccountBO.StrUserField11</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.StrUserField11</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="choice_name">AccountBO.StrUserField11</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<xsl:template name="AccountBO.Amount2">
	<xsl:call-template name="amountlabel">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Amount2']"/>
		<xsl:with-param name="ele_name">AccountBO.Amount2</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.Amount2</xsl:with-param>
		<xsl:with-param name="fncname">rate("2_AccountBO.Amount2","AccountBO.StrUserField13",'<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
		<xsl:with-param name="selectname">AccountBO.StrUserField13</xsl:with-param>
		<xsl:with-param name="amountselectname"><xsl:value-of select="$boName"/>.StrUserField13</xsl:with-param>
		<xsl:with-param name="onchangefn">checkDropValue("2_AccountBO.Amount2","AccountBO.StrUserField13");</xsl:with-param>
		<xsl:with-param name="fn_onBlur">formatAmount("2_AccountBO.Amount2","AccountBO.StrUserField13","N");</xsl:with-param>
		<xsl:with-param name="choicename">AccountBO.StrUserField13</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
	</xsl:call-template>
</xsl:template>

<!-- Change done by Bharath end -->

      	  <!--jane customizing start -->
	<xsl:template name="AccountBO.StrUserField25">
			<xsl:call-template name="lookup">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField25']"/>
					<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.StrUserField25</xsl:with-param>
					<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.StrUserField25</xsl:with-param>
					<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
					<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
					<xsl:with-param name="buttonone_fnc">categoryLookup('CONSTITUTION_CODE', '<xsl:value-of select="$boName"/>.StrUserField25')</xsl:with-param>
					<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.StrUserField25')</xsl:with-param>
					<xsl:with-param name="code_req">true</xsl:with-param>
			</xsl:call-template>
	</xsl:template>

	<!--jane customizing end -->
	<!-- Field Rationalization changes start -->
     <xsl:template name="DemographicBO.Nationality">
             <xsl:call-template name="lookup">
             <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.Nationality']"/>
             <xsl:with-param name="elename">DemographicBO.Nationality</xsl:with-param>
             <xsl:with-param name="eleval"><xsl:value-of select="$boNameDemo"/>.Nationality</xsl:with-param>
             <xsl:with-param name="code_req">true</xsl:with-param>
             <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
             <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
             <xsl:with-param name="buttonone_fnc">categoryLookup('NATIONALITY', 'DemographicBO.Nationality')</xsl:with-param>
             <xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.Nationality')</xsl:with-param>
             <xsl:with-param name="checkASCII">false</xsl:with-param>
		    </xsl:call-template>
     </xsl:template>
        <!-- Field Rationalization changes end -->
	   <!-- Religion dropdown customization by kate start -->

	<!--  RefCode Changes	-->
	<!-- Equity Cust_Type change start -->
            <xsl:template name="AccountBO.StrUserField28">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField28']"/>
                           <!-- <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.StrUserField28</xsl:with-param>-->
                           <xsl:with-param name="onchangefn">fnCheckCustStatus('N');fnShowInfoTip();</xsl:with-param>
                            <xsl:with-param name="selectdisp">AccountBO.StrUserField28</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField28</xsl:with-param>
<!-- ticket 214549 changes start -->
                             <!-- <xsl:with-param name="onchangefn">makeStatDateMand()</xsl:with-param> -->
<!-- ticket 214549 changes end -->
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                            <xsl:with-param name="choice_name">AccountBO.StrUserField28</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>

 <!-- Religion dropdown customization by kate end -->

 

	
			<!--<xsl:template name="AccountBO.Cust_type_code">
		     	     <xsl:call-template name="lookup">
		     	     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_type_code']"/>
		     	     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.StrUserField23</xsl:with-param>
		     	     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.StrUserField23</xsl:with-param>
		     	     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		     	     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		     	     <xsl:with-param name="buttonone_fnc">categoryLookup('ACCOUNT_TYPE', '<xsl:value-of select="$boName"/>.StrUserField23')</xsl:with-param>
		     	     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.Cust_type_code')</xsl:with-param>
		     	     <xsl:with-param name="checkASCII">false</xsl:with-param>
		     	     </xsl:call-template>
		       </xsl:template>-->


                                     
                    
                    
                     <xsl:template name="AccountBO.Cust_Type">
		    		  		<xsl:call-template name="mdrpdown">
		    		  		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Type']"/>
		    		  		<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Cust_Type</xsl:with-param>
		    		  		<xsl:with-param name="selectdisp">AccountBO.Cust_Type</xsl:with-param>
		    		  		<xsl:with-param name="ele_name">Cust_Type</xsl:with-param>
		    		  		<xsl:with-param name="choice_name">AccountBO.Cust_Type</xsl:with-param>
		    		  		<xsl:with-param name="checkASCII">false</xsl:with-param>
		    		  		<xsl:with-param name="presdata" select="$PresData"/>
		    		  		</xsl:call-template>
	            </xsl:template>
                    
 
<!--  Kate Customization Sector starts	-->

			<xsl:template name="AccountBO.StrUserField29">
		     	     <xsl:call-template name="lookup">
		     	     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField29']"/>
		     	     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.StrUserField29</xsl:with-param>
		     	     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.StrUserField29</xsl:with-param>
		     	     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		     	     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		     	     <xsl:with-param name="buttonone_fnc">categoryLookup('SECTOR_CODE', '<xsl:value-of select="$boName"/>.StrUserField29')</xsl:with-param>
		     	     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.StrUserField29')</xsl:with-param>
		     	     <xsl:with-param name="checkASCII">false</xsl:with-param>
		     	     </xsl:call-template>
		       </xsl:template>

     <!--  Kate Customization Sector Ends  -->


	 	<xsl:template name="AccountBO.StrUserField19">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField19']"/>
		<xsl:with-param name="selectname">AccountBO.StrUserField19</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.StrUserField19</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="choice_name">AccountBO.StrUserField19</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

     
     <!-- Equity Sector change start -->
     
     <xsl:template name="AccountBO.Sector">
     		     	     <xsl:call-template name="lookup">
     		     	     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Sector']"/>
     		     	     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Sector</xsl:with-param>
     		     	     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Sector</xsl:with-param>
     		     	     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
     		     	     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
     		     	     <xsl:with-param name="buttonone_fnc">categoryLookup('SECTOR_CODE', '<xsl:value-of select="$boName"/>.Sector')</xsl:with-param>
     		     	     <!--Changes for tracker id 349611 STARTS -->
     		     	     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Sector')</xsl:with-param>
     		     	     <!--Changes for tracker id 349611 ENDS -->
     		     	     <xsl:with-param name="checkASCII">false</xsl:with-param>
     		     	     </xsl:call-template>
		        </xsl:template>
     
 
     
     
     <!-- Equity religion change end -->

          <!--  Kate Customization Country of residence starts -->

			<xsl:template name="AccountBO.StrUserField27">
		     	     <xsl:call-template name="lookup">
		     	     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField27']"/>
		     	     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.StrUserField27</xsl:with-param>
		     	     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.StrUserField27</xsl:with-param>
		     	     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		     	     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		     	     <xsl:with-param name="buttonone_fnc">categoryLookup('COUNTRY', '<xsl:value-of select="$boName"/>.StrUserField27')</xsl:with-param>
		     	     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.StrUserField27')</xsl:with-param>
		     	     <xsl:with-param name="checkASCII">false</xsl:with-param>
		     	     </xsl:call-template>
		       </xsl:template>



         <!--  Kate Customization Country of residence Ends -->
     
		<!--jane customization CUSTOMER STATUS  start -->

			<!--<xsl:template name="AccountBO.Status_code">
		     	     <xsl:call-template name="lookup">
		     	     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Status_code']"/>
		     	     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Status_code</xsl:with-param>
		     	     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Status_code</xsl:with-param>
		     	     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		     	     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		     	     <xsl:with-param name="buttonone_fnc">categoryLookup('CUSTOMER_STATUS', '<xsl:value-of select="$boName"/>.Status_code')</xsl:with-param>
		     	     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.Status_code')</xsl:with-param>
		     	     <xsl:with-param name="checkASCII">false</xsl:with-param>
		     	     </xsl:call-template>
		       </xsl:template> -->
	<!--jane customization end -->

 <!--  Kate change Custome Status from lookup to dropdown starts-->
  <!--  <xsl:template name="AccountBO.Status_code">
  	                           <xsl:call-template name="mdrpdown">
  	                           <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Status_code']"/>
  	                           <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.status</xsl:with-param>
  	                           <xsl:with-param name="selectdisp">AccountBO.status</xsl:with-param>
  	   			
  	   				<xsl:with-param name="presdata" select="$PresData"/>
  	   			
  	                           <xsl:with-param name="search_type">value</xsl:with-param>
  	   			   <xsl:with-param name="choice_name">AccountBO.Status_code</xsl:with-param>
  	                           
  	                           </xsl:call-template> 
  	                           
                    </xsl:template> 
                    -->
                    
                    
                    <!-- Equity status change start -->
                    
                     <xsl:template name="AccountBO.status">
		    	                           <xsl:call-template name="mdrpdown">
		    	                           <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.status']"/>
		    	                           <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.status</xsl:with-param>
		    	                           <xsl:with-param name="selectdisp">AccountBO.status</xsl:with-param>
		    	   			
		    	   				<xsl:with-param name="presdata" select="$PresData"/>
		    	   			
		    	                           <xsl:with-param name="search_type">value</xsl:with-param>
		    	   			   <xsl:with-param name="choice_name">AccountBO.status</xsl:with-param>
		    	                           
		    	                           </xsl:call-template> 
		    	                           
                    </xsl:template> 
                    <!-- Equity status change end -->


  <!--  Kate change Custome Status from lookup to dropdown ends-->


	<!-- Preffered communication mode dropdown customization by kate start -->

	<!--  RefCode Changes	-->
            <xsl:template name="AccountBO.StrUserField26">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField26']"/>
                           <!-- <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.status</xsl:with-param>-->
                           <xsl:with-param name="onchangefn">fnCheckCustStatus('N');fnShowInfoTip();</xsl:with-param>
                            <xsl:with-param name="selectdisp">AccountBO.StrUserField26</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField26</xsl:with-param>
<!-- ticket 214549 changes start -->
                             <!-- <xsl:with-param name="onchangefn">makeStatDateMand()</xsl:with-param> -->
<!-- ticket 214549 changes end -->
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                            <xsl:with-param name="choice_name">AccountBO.StrUserField26</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>

 <!-- Preffered communication mode dropdown customization by kate end -->

<!--  RefCode Changes	-->

    <xsl:template name="Document_Received">
        <xsl:call-template name="checkbox1">
            <xsl:with-param name="name">ckDocument_Received</xsl:with-param>
            <xsl:with-param name="checkbox_val">true</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
<!-- KeyGeneration start -->


<!--Begin Of Changes, ME Phase 3 Tracker ID:131246
Changes by sonali_narula for GCIF LookUp
Added this look up for GcifId in customer creation screen for customer and customerQDE-->

      <xsl:template name="AccountBO.GCIFID">
    	    <xsl:call-template name="lookup">
    	                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.GCIFID']"/>
    	                <xsl:with-param name="elename">AccountBO.GCIFID</xsl:with-param>
    	                <xsl:with-param name="eleval">AccountBO.GCIFID</xsl:with-param>
    	                <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
    	                <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
    	                <xsl:with-param name="buttonone_fnc">accountLookupGcif()</xsl:with-param>
    	                <xsl:with-param name="buttontwo_fnc">clearLookup("AccountBO_GcifId")</xsl:with-param>
		 	<xsl:with-param name="checkASCII">false</xsl:with-param>
    	     </xsl:call-template>
      </xsl:template>
<!--Ends of changes for GCIF LookUp-->


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
		    <!-- Changes done by sonali for 286045 Begin -->
		<!--Changes for ticket id:690997 starts-->
			<xsl:with-param name="fn_onBlur">checkStatus('AccountBO.AccountKey',keyGeneration);txtLimit_CIF(this,"AccountBO.AccountKey","CIF ID");</xsl:with-param>
		<!--Changes for ticket id:690997 ends-->
		    <!-- Changes done by sonali for 286045 End -->
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
		    <!-- Changes done by sonali for 286045 Begin -->
		<!--Changes for ticket id:690997 starts-->
		       <xsl:with-param name="fn_onBlur">checkStatus('AccountBO.AccountKey',keyGeneration);txtLimit_CIF(this,"AccountBO.AccountKey","CIF ID");</xsl:with-param>
		<!--Changes for ticket id:690997 ends-->
		    <!-- Changes done by sonali for 286045 End -->
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
		    <!-- Changes done by sonali for 286045 Begin -->
		<!--Changes for ticket id:690997 starts-->
		    <xsl:with-param name="fn_onBlur">checkStatus('AccountBO.AccountKey',keyGeneration);txtLimit_CIF(this,"AccountBO.AccountKey","CIF ID");</xsl:with-param>
		<!--Changes for ticket id:690997 ends-->
		    <!-- Changes done by sonali for 286045 End -->
		</xsl:call-template>
	    </xsl:otherwise>
	 </xsl:choose>
      </xsl:template>
<!-- KeyGeneration end -->
 <!-- Changes 10.2.14 enhancements start -->

			<xsl:template name="AccountBO.GroupHouseHold.GROUP_ID">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">CifGroupLookup()</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels6[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearLookUpMinor()</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels6[@name='CLEAR']/@configLabel" />
		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="elename">AccountBO.GroupHouseHold.GROUP_ID</xsl:with-param>
		<xsl:with-param name="eleval">AccountBO.GroupHouseHold.GROUP_ID</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels6[@name='AccountBO.GroupHouseHold.GROUP_ID']" />
		
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
			 <!-- Changes 10.2.14 enhancements end -->
 	<!--TRACKER ID : 78621 : BEGIN OF CHANGES-->
<!-- LastEdited change :start-->
<!-- LastEdited change :end-->
	<!--TRACKER ID : 78621 : BEGIN OF CHANGES-->
      <!-- Shanmuga NRE changes - start -->
      	<xsl:template name="DemographicBO.MiscellaneousInfo.Type">
      		<xsl:call-template name="mdrpdown">
      			<xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.Type_code']"/>
			<!--<xsl:with-param name="selectDesc">DemographicBO.MiscellaneousInfo.Type</xsl:with-param>-->
			<!-- Last Edited Page changes starts -->
      			<xsl:with-param name="selectname"><xsl:value-of select="$boNameDemo"/>.MiscellaneousInfo.Type</xsl:with-param>
      			<xsl:with-param name="selectdisp">DemographicBO.MiscellaneousInfo.Type_code</xsl:with-param>
      			<xsl:with-param name="choice_name">DemographicBO.MiscellaneousInfo.Type_code</xsl:with-param>
      			<!-- Last Edited Page changes ends-->
			<xsl:with-param name="search_type">url</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
      		</xsl:call-template>
      	</xsl:template>

      	<xsl:template name="DemographicBO.MiscellaneousInfo.strText1">
      		<xsl:call-template name="label">
      			<xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText1']"/>
      			<xsl:with-param name="selectname">DemographicBO.MiscellaneousInfo.strText1</xsl:with-param>
      			<xsl:with-param name="selectdisp">DemographicBO.MiscellaneousInfo.strText1</xsl:with-param>
      			<xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText1</xsl:with-param>
      			<!-- Last Edited Page changes starts -->
      			<xsl:with-param name="ele_val"><xsl:value-of select="$boNameDemo"/>.MiscellaneousInfo.strText1</xsl:with-param>
      			<!-- Last Edited Page changes ends-->
      		</xsl:call-template>
      	</xsl:template>

      	<xsl:template name="DemographicBO.MiscellaneousInfo.strText2A">
	      		<xsl:call-template name="lookup">
	      			<xsl:with-param name="res_name" select="$configLabels[@name='URL']"/>
	      			<xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.strText2A</xsl:with-param>
	      			<!--<xsl:with-param name="eleval">DemographicBO.MiscellaneousInfo.strText2A</xsl:with-param>-->
					<xsl:with-param name="ele_val"><xsl:value-of select="$boNameDemo"/>.MiscellaneousInfo.strText2A</xsl:with-param>
	      			<xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
	      			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	      			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
	      			<xsl:with-param name="buttonone_fnc">categoryLookupCode('CITY', 'DemographicBO.MiscellaneousInfo.strText2A', 'issue_city_code')</xsl:with-param>
	      			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.MiscellaneousInfo.strText2A')</xsl:with-param>
	      			<xsl:with-param name="checkASCII">false</xsl:with-param>
	      		</xsl:call-template>
				<input type="hidden" name="issue_city_code" value=""/>
      	</xsl:template>

      	<xsl:template name="DemographicBO.MiscellaneousInfo.dtDate1">
      		<xsl:call-template name="label">
      			<xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.dtDate1']"/>
      			<xsl:with-param name="selectname">DemographicBO.MiscellaneousInfo.dtDate1</xsl:with-param>
      			<xsl:with-param name="selectdisp">DemographicBO.MiscellaneousInfo.dtDate1</xsl:with-param>
      			<xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.dtDate1</xsl:with-param>
      			<!-- Last Edited Page changes starts -->
      			<xsl:with-param name="ele_val"><xsl:value-of select="$boNameDemo"/>.MiscellaneousInfo.dtDate1</xsl:with-param>
      			<!-- Last Edited Page changes ends-->
      			<!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
      			<!-- calling the function isGregDate for on blur functionality-->
      			 <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.MiscellaneousInfo.dtDate1");</xsl:with-param>
      			 <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
      		</xsl:call-template>
      	</xsl:template>

      	<xsl:template name="DemographicBO.MiscellaneousInfo.dtDate2">
      		<xsl:call-template name="label">
      			<xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.dtDate2']"/>
      			<xsl:with-param name="selectname">DemographicBO.MiscellaneousInfo.dtDate2</xsl:with-param>
      			<xsl:with-param name="selectdisp">DemographicBO.MiscellaneousInfo.dtDate2</xsl:with-param>
      			<xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.dtDate2</xsl:with-param>
      			<!-- Last Edited Page changes starts -->
      			<xsl:with-param name="ele_val"><xsl:value-of select="$boNameDemo"/>.MiscellaneousInfo.dtDate2</xsl:with-param>
      			<!-- Last Edited Page changes ends-->
      			<!--<xsl:with-param name="fn_onBlur">validateDates();</xsl:with-param>-->
      			</xsl:call-template>
      	</xsl:template>
      	<!-- Shanmuga NRE changes - end -->

<!-- templates for general - End -->
<!--Start of changes: Minor -->
	<xsl:template name="RelationshipBO.Bank_Entity_Name">
    		<xsl:call-template name="lookup">
         		<xsl:with-param name="res_name" select="$configLabelsMinor[@name='URL']"/>


         		<xsl:with-param name="elename">RelationshipBO.Bank_Entity_Name</xsl:with-param>
         		<xsl:with-param name="eleval">RelationshipBO.Bank_Entity_Name</xsl:with-param>
         		<xsl:with-param name="buttonone_name"><xsl:value-of select="$configLabelsMinor[@name='LookUp']/@configLabel"/></xsl:with-param>
         		<xsl:with-param name="buttontwo_name"><xsl:value-of select="$configLabelsMinor[@name='Clear']/@configLabel"/></xsl:with-param>
         		<!--xsl:with-param name="buttonone_fnc">accountLookup()</xsl:with-param-->
         		<xsl:with-param name="buttonone_fnc">fnBlurFunctionmin('Minor')</xsl:with-param>
         		<xsl:with-param name="buttontwo_fnc">clearLookUpMinor()</xsl:with-param>
         		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
         		<xsl:with-param name="checkASCII">false</xsl:with-param>
    			<xsl:with-param name="starshow">true</xsl:with-param>
    		</xsl:call-template>
    	</xsl:template>


	<xsl:template name="RelationshipBO.Bank_Entity">
	    		<xsl:call-template name="mdrpdown">
	    			<xsl:with-param name="res_name" select="$configLabelsMinor[@name='Relationship_Bank_Entity']"/>
	    			<xsl:with-param name="selectname">RelationshipBO.Bank_Entity</xsl:with-param>
	    			<xsl:with-param name="selectdisp">RelationshipBO.Bank_Entity</xsl:with-param>
	    			<xsl:with-param name="onchangefn">DisplayLookUP()</xsl:with-param>
	    			<xsl:with-param name="search_type">value</xsl:with-param>
	    			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
	    		</xsl:call-template>
    	</xsl:template>


    	<xsl:template name="RelationshipBO.Relationship">
	  <xsl:call-template name="label">
	  		              <xsl:with-param name="res_name" select="$configLabelsMinor[@name='RelationshipBO.Relationship']"/>
	  		               <xsl:with-param name="selectname">RelationshipBO.Relationship</xsl:with-param>
	  		               <xsl:with-param name="selectdisp">RelationshipBO.Relationship</xsl:with-param>
	  		               <xsl:with-param name="ele_name">RelationshipBO.Relationship</xsl:with-param>
		 </xsl:call-template>
    	</xsl:template>

    	  	<!--<xsl:template name="RelationshipBO.Relationship">
	  	    		<xsl:call-template name="mdrpdown">
	  	    			<xsl:with-param name="res_name" select="$configLabelsMinor[@name='RelationshipBO.Relationship']"/>
	  	    			<xsl:with-param name="selectname">RelationshipBO.Relationship</xsl:with-param>
	  	    			<xsl:with-param name="selectdisp">RelationshipBO.Relationship</xsl:with-param>
	  	    			<xsl:with-param name="onchangefn">EnableMinorGuardCode()</xsl:with-param>
	  	    			<xsl:with-param name="search_type">value</xsl:with-param>
	  	    			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	  			// CIF Changes for Caching Views : Start
	  				<xsl:with-param name="presdata" select="$PresData"/>
	  			// CIF Changes for Caching Views : End
	  	    		</xsl:call-template>
	      	</xsl:template>-->


	<xsl:template name="RelationshipBO.Guard_Code">
	    <xsl:call-template name="mdrpdown">
	    <xsl:with-param name="res_name" select="$configLabelsMinor[@name='RelationshipBO.Guard_Code']"/>
	    <xsl:with-param name="selectname">RelationshipBO.Guard_Code</xsl:with-param>
	    <xsl:with-param name="selectdisp">RelationshipBO.Guard_Code</xsl:with-param>
	    <xsl:with-param name="search_type">value</xsl:with-param>
	    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	    <xsl:with-param name="starshow">true</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
	    </xsl:call-template>
    	</xsl:template>
	<xsl:template name="ContactBO.firstName">
			<xsl:call-template name="label">
		              <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.firstName']"/>
		               <xsl:with-param name="selectname">ContactBO.firstName</xsl:with-param>
		               <xsl:with-param name="selectdisp">ContactBO.firstName</xsl:with-param>
		               <xsl:with-param name="ele_name">ContactBO.firstName</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
				<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		         </xsl:call-template>
	 </xsl:template>


	 <xsl:template name="ContactBO.middleName">
	                 <xsl:call-template name="label">
	                   <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.middleName']"/>
	                    <xsl:with-param name="selectname">ContactBO.middleName</xsl:with-param>
	                    <xsl:with-param name="selectdisp">ContactBO.middleName</xsl:with-param>
	                    <xsl:with-param name="ele_name">ContactBO.middleName</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
				<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	                 </xsl:call-template>
	 </xsl:template>

	 <xsl:template name="ContactBO.lastName">
	            <xsl:call-template name="label">
	              <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.lastName']"/>
	               <xsl:with-param name="selectname">ContactBO.lastName</xsl:with-param>
	               <xsl:with-param name="selectdisp">ContactBO.lastName</xsl:with-param>
	               <xsl:with-param name="ele_name">ContactBO.lastName</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
				<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->

	            </xsl:call-template>
	 </xsl:template>


	  <xsl:template name="ContactBO.DOB">
	      <xsl:call-template name="label">
	      <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.DOB']"/>
	      <xsl:with-param name="ele_name">ContactBO.DOB</xsl:with-param>
	      <xsl:with-param name="ele_val">ContactBO.DOB</xsl:with-param>
	      <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	      <xsl:with-param name="fn_onBlur">validateDateMinor();</xsl:with-param>
	      </xsl:call-template>
    	</xsl:template>








	   <xsl:template name="ContactBO.salutation">
	                 <xsl:call-template name="mdrpdown">
	                   <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.salutation']"/>
	                    <xsl:with-param name="selectname">ContactBO.salutation</xsl:with-param>
	                    <xsl:with-param name="selectdisp">ContactBO.salutation</xsl:with-param>
	                    <xsl:with-param name="ele_name">ContactBO.salutation</xsl:with-param>
	                    <xsl:with-param name="starshow">true</xsl:with-param>

	                    <!-- TRACKER ID 122174 CHANGES BEGIN -->
	                    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	                    <!-- TRACKER ID 122174 CHANGES END -->



	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
	                 </xsl:call-template>
	    </xsl:template>

	    <xsl:template name="ContactBO.gender">
	                      <xsl:call-template name="mdrpdown">
	                        <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.gender']"/>
	                         <xsl:with-param name="selectname">ContactBO.gender</xsl:with-param>
	                         <xsl:with-param name="selectdisp">ContactBO.gender</xsl:with-param>
	                         <xsl:with-param name="ele_name">ContactBO.gender</xsl:with-param>
			    <!-- TRACKER ID 122174 CHANGES BEGIN -->
			    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	                    <!-- TRACKER ID 122174 CHANGES END -->
	                      	 <xsl:with-param name="starshow">true</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
	                      </xsl:call-template>
	     </xsl:template>

		<!-- CIF Changes - Tessa - Start -->
		<xsl:template name="ContactBO.contactsKey">
			<xsl:choose>
				<xsl:when test= "normalize-space($isAutoGenKey)='true'">
					<xsl:call-template name="lookup">
					<xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.contactsKey']"/>
						<xsl:with-param name="selectname">ContactBO.CONTACTSKEY</xsl:with-param>
					<xsl:with-param name="elename">ContactBO.contactsKey</xsl:with-param>
					<xsl:with-param name="eleval">ContactBO.contactsKey</xsl:with-param>
					<xsl:with-param name="buttonone_name"><xsl:value-of select="$configLabelsMinor[@name='LookUp']/@configLabel"/></xsl:with-param>
					<xsl:with-param name="buttontwo_name"><xsl:value-of select="$configLabelsMinor[@name='Clear']/@configLabel"/></xsl:with-param>
					<xsl:with-param name="buttonone_fnc">accountLookup()</xsl:with-param>
					<xsl:with-param name="buttontwo_fnc">clearLookUpMinor()</xsl:with-param>
					<xsl:with-param name="starshow">true</xsl:with-param>
						<xsl:with-param name="read_val">true</xsl:with-param>
						<xsl:with-param name="IsMandatory" select="No"/>
					</xsl:call-template>

				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="lookup">
					<xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.contactsKey']"/>
					<xsl:with-param name="elename">ContactBO.contactsKey</xsl:with-param>
					<xsl:with-param name="eleval">ContactBO.contactsKey</xsl:with-param>
					<xsl:with-param name="buttonone_name"><xsl:value-of select="$configLabelsMinor[@name='LookUp']/@configLabel"/></xsl:with-param>
					<xsl:with-param name="buttontwo_name"><xsl:value-of select="$configLabelsMinor[@name='Clear']/@configLabel"/></xsl:with-param>
					<!-- Tracker ID:225185 Begin of Change -->
					<!--Changes for ticket id 385229:Start-->
					<!-- Recon for Ticket id 384668 start-->
					<!--<xsl:with-param name="buttonone_fnc">fnBlurFunctionmin('Minor')</xsl:with-param>-->
					<xsl:with-param name="buttonone_fnc">accountLookup()</xsl:with-param>
					<!-- Recon for Ticket id 384668 end-->
					<!--Changes for ticket id 385229:End-->
					<!-- Tracker ID:225185 End of Change -->
					<xsl:with-param name="buttontwo_fnc">clearLookUpMinor()</xsl:with-param>
					<xsl:with-param name="starshow">true</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
		<!-- CIF Changes - Tessa - End -->
<!--Native Language Changes:start-->

<xsl:template name="ContactBO.Contact_First_Name_Native">
		<xsl:call-template name="label">
		      <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.Contact_First_Name_Native']"/>
		       <xsl:with-param name="selectname">ContactBO.Contact_First_Name_Native</xsl:with-param>
		       <xsl:with-param name="selectdisp">ContactBO.Contact_First_Name_Native</xsl:with-param>
		       <xsl:with-param name="ele_name">ContactBO.Contact_First_Name_Native</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
			<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		 </xsl:call-template>
 </xsl:template>
<xsl:template name="ContactBO.Contact_Middle_Name_Native">
		<xsl:call-template name="label">
		      <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.Contact_Middle_Name_Native']"/>
		       <xsl:with-param name="selectname">ContactBO.Contact_Middle_Name_Native</xsl:with-param>
		       <xsl:with-param name="selectdisp">ContactBO.Contact_Middle_Name_Native</xsl:with-param>
		       <xsl:with-param name="ele_name">ContactBO.Contact_Middle_Name_Native</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
			<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		 </xsl:call-template>
 </xsl:template>
<xsl:template name="ContactBO.Contact_Last_Name_Native">
		<xsl:call-template name="label">
		      <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.Contact_Last_Name_Native']"/>
		       <xsl:with-param name="selectname">ContactBO.Contact_Last_Name_Native</xsl:with-param>
		       <xsl:with-param name="selectdisp">ContactBO.Contact_Last_Name_Native</xsl:with-param>
		       <xsl:with-param name="ele_name">ContactBO.Contact_Last_Name_Native</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
			<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		 </xsl:call-template>
 </xsl:template>

<!--Native Language Changes:end-->

<!--End of changes: Minor -->
<!--Begin of changes: Primary Introducer -->
<!-- LastEdited change :start-->
<!--changes from dropdown to lookup ends-->
<!-- TRACKER:371155:BEGINOFCHANGES -->
   <xsl:template name="AccountBO.IntroducerSalutation">
	    			        <xsl:call-template name="lookup">
	    					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Introd_Salutation_code']"/>
	    					<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.IntroducerSalutation</xsl:with-param>
	    					<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Introd_Salutation_code</xsl:with-param>
	    					<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	    					<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
	    					<xsl:with-param name="buttonone_fnc">categoryLookup('PERSONSALUTATION', '<xsl:value-of select="$boName"/>.IntroducerSalutation')</xsl:with-param>
	    					<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.IntroducerSalutation')</xsl:with-param>
	    					<xsl:with-param name="checkASCII">false</xsl:with-param>
	    					<xsl:with-param name="starshow">true</xsl:with-param>
	    					<xsl:with-param name="code_req">true</xsl:with-param>
	    				</xsl:call-template>
		</xsl:template> 
		<!-- TRACKER:371155:ENDOFCHANGES -->
<!-- LastEdited change :end-->

<xsl:template name="AccountBO.IntroducerName">
	   <xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.IntroducerName']"/>
	    <xsl:with-param name="ele_name">AccountBO.IntroducerName</xsl:with-param>
	    <!-- Last Edited Page changes starts -->
	    <!--xsl:with-param name="ele_val">AccountBO.IntroducerName</xsl:with-param>-->
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.IntroducerName</xsl:with-param>
	    <!-- Last Edited Page changes ends-->
	    <xsl:with-param name="starshow">true</xsl:with-param>
	    <xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	   </xsl:call-template>
	</xsl:template>

	<!-- Tracker 122228 Changes start-->
	<xsl:template name="AccountBO.IntroducerName_alt1">
		   <xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.IntroducerName']"/>
		    <xsl:with-param name="ele_name">AccountBO.IntroducerName_alt1</xsl:with-param>
		    <!-- Last Edited Page changes starts -->
		    <!--xsl:with-param name="ele_val">AccountBO.IntroducerName_alt1</xsl:with-param>-->
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.IntroducerName</xsl:with-param>
		    <!-- Last Edited Page changes ends-->
		    <xsl:with-param name="starshow">true</xsl:with-param>
		    <xsl:with-param name="checkASCII">false</xsl:with-param>
	<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
			<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
	<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
		   </xsl:call-template>
	</xsl:template>
	<!-- Tracker 122228 Changes end-->

 <xsl:template name="RelationshipBO.Bank_Entity_Name1">
	<xsl:call-template name="lookup">
		<xsl:with-param name="res_name" select="$configLabelsMinor[@name='URL']"/>
		<xsl:with-param name="elename">RelationshipBO.Bank_Entity_Name1</xsl:with-param>
		<xsl:with-param name="eleval">RelationshipBO.Bank_Entity_Name1</xsl:with-param>
		<xsl:with-param name="buttonone_name"><xsl:value-of select="$configLabelsMinor[@name='LookUp']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="buttontwo_name"><xsl:value-of select="$configLabelsMinor[@name='Clear']/@configLabel"/></xsl:with-param>
		<!--xsl:with-param name="buttonone_fnc">accountLookupIntro()</xsl:with-param-->
		<xsl:with-param name="buttonone_fnc">fnBlurAccountLookupIntro('Intro')</xsl:with-param>
		<xsl:with-param name="buttontwo_fnc">clearLookUpIntro()</xsl:with-param>
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
 </xsl:template>

<xsl:template name="RelationshipBO.ChildEntityType">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabelsMinor[@name='RelationshipBO.ChildEntityType']"/>
		<xsl:with-param name="selectname">RelationshipBO.ChildEntityType</xsl:with-param>
		<xsl:with-param name="selectdisp">RelationshipBO.ChildEntityType</xsl:with-param>
		<xsl:with-param name="onchangefn">cifTypeIntro()</xsl:with-param>
        <xsl:with-param name="choice_name">RelationshipBO.ChildEntityType</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	</xsl:call-template>
 </xsl:template>

 <xsl:template name="RelationshipBO.Bank_Entity1">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabelsMinor[@name='Relationship_Bank_Entity']"/>
		<xsl:with-param name="selectname">RelationshipBO.Bank_Entity1</xsl:with-param>
		<xsl:with-param name="selectdisp">RelationshipBO.Bank_Entity1</xsl:with-param>
		<xsl:with-param name="onchangefn">DisplayLookUPIntro()</xsl:with-param>
		<xsl:with-param name="choice_name">RelationshipBO.Bank_Entity</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	</xsl:call-template>
 </xsl:template>
	<xsl:template name="AccountBO.IntroducerID">
	   <xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.IntroducerID']"/>
	    <xsl:with-param name="ele_name">AccountBO.IntroducerID</xsl:with-param>
	    <!-- Last Edited Page changes starts -->
	    <!--<xsl:with-param name="ele_val">AccountBO.IntroducerID</xsl:with-param>-->
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.IntroducerID</xsl:with-param>
	    <!-- Last Edited Page changes ends-->
	    <xsl:with-param name="starshow">true</xsl:with-param>
	    <xsl:with-param name="checkASCII">false</xsl:with-param>
	   </xsl:call-template>
	</xsl:template>
<!-- LastEdited change :start-->
<xsl:template name="AccountBO.Introd_Status">
	<xsl:call-template name="mdrpdown">
	<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.IntroducerStatusCode']"/>
	<!--<xsl:with-param name="selectDesc">AccountBO.Introd_Status</xsl:with-param>-->
	<xsl:with-param name="selectname">AccountBO.Introd_Status</xsl:with-param>
	<xsl:with-param name="selectdisp">AccountBO.IntroducerStatusCode</xsl:with-param>
	<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Introd_Status</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
	<xsl:with-param name="choice_name">AccountBO.IntroducerStatusCode</xsl:with-param>
	<xsl:with-param name="search_type">url</xsl:with-param>
	</xsl:call-template>
</xsl:template>
	<!-- LastEdited change :end-->
<!--End of changes: Primary Introducer -->
	<!-- CRM70t-ST :TRACKER# 79632 **BEGIN OF CHANGES ** -->

<!-- Field Rationalization changes start -->

	<xsl:template name="AccountBO.Primary_sol_id">
             <xsl:call-template name="lookup">
	    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Primary_sol_id']"/>
             <xsl:with-param name="elename">AccountBO.Primary_sol_id</xsl:with-param>
             <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Primary_sol_id</xsl:with-param>
             <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
             <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
             <xsl:with-param name="buttonone_fnc">categoryLookup('SERVICE_OUTLET', 'AccountBO.Primary_sol_id')</xsl:with-param>
             <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.Primary_sol_id')</xsl:with-param>
             <xsl:with-param name="checkASCII">false</xsl:with-param>
               <xsl:with-param name="code_req">true</xsl:with-param>    <!-- change for callid 318169 -->
	    </xsl:call-template>
	</xsl:template>
<!--Added as part of 10.2 ENH -->
<!--changes from dropdown to lookup ends-->
<!-- TRACKER:371155:BEGINOFCHANGES -->
<xsl:template name="AccountBO.Tds_tbl">
		     <xsl:call-template name="lookup">
		     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Tds_tbl_code']"/>
		     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Tds_tbl</xsl:with-param>
		     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Tds_tbl</xsl:with-param>
		     <xsl:with-param name="code_req">true</xsl:with-param>
		     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		     <xsl:with-param name="buttonone_fnc">categoryLookup('TAX_SLAB', '<xsl:value-of select="$boName"/>.Tds_tbl')</xsl:with-param>
	     <!--Changes for tracker id 349611 STARTS-->
	     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Tds_tbl')</xsl:with-param>
	     <!--Changes for tracker id 349611 ENDS-->
		     <xsl:with-param name="checkASCII">false</xsl:with-param>
		     </xsl:call-template>
      </xsl:template>        
<!-- TRACKER:371155:ENDOFCHANGES -->
<!--changes  of 10.2 ENH end-->

<!-- Field Rationalization changes end -->
	<!-- CIF PhoneEmail Changes : Start -->
		<xsl:template name="AccountBO.Address.preferredAddress">
			<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.preferredAddress']"/>
			<xsl:with-param name="selectname">AccountBO.Address.preferredAddress</xsl:with-param>
			<xsl:with-param name="selectdisp">AccountBO.Address.preferredAddress</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<!-- Changes for Tracker id: 292525 starts -->
			<xsl:with-param name="defaultValue"><xsl:value-of select="$defAddress"/></xsl:with-param>
                        <!-- Changes for Tracker id: 292525 ends -->
			<xsl:with-param name="presdata" select="$PresData"/>
			</xsl:call-template>
		</xsl:template>

		<xsl:template name="AccountBO.PhoneEmail.PhoneEmailType">
			<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='PREFERRED_PHONE']"/>
			<xsl:with-param name="selectname">AccountBO.PhoneEmail.PhoneEmailType</xsl:with-param>
			<xsl:with-param name="selectdisp">AccountBO.PhoneEmail.PhoneEmailType</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			</xsl:call-template>
		</xsl:template>

		<xsl:template name="AccountBO.PhoneEmail.PhoneEmailType1">
			<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='PREFERRED_EMAIL']"/>
			<xsl:with-param name="selectname">AccountBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
			<xsl:with-param name="selectdisp">AccountBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			</xsl:call-template>
		</xsl:template>

		<!-- CIF PhoneEmail Changes : End -->

	<xsl:template name="AccountBO.accessOwnerGroup">
		 <xsl:call-template name="mdrpdown">
			 <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.accessOwnerGroup']"/>
			 <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.accessOwnerGroup</xsl:with-param>
			 <xsl:with-param name="selectdisp">AccountBO.accessOwnerGroup</xsl:with-param>
			 <xsl:with-param name="search_type">value</xsl:with-param>
			 <xsl:with-param name="choice_name">AccountBO.accessOwnerGroup</xsl:with-param>
				 <xsl:with-param name="onchangefn">setAccessOwnerGroup();</xsl:with-param>
			 <!-- CIF Changes for Caching Views : Start -->
			 <xsl:with-param name="presdata" select="$PresData"/>
			 <!-- CIF Changes for Caching Views : End -->

		 </xsl:call-template>
	 </xsl:template>


<!--Relationship Manager Changes:Start-->
<xsl:template name="AccountBO.Manager">
    <xsl:call-template name="lookup">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Manager']"/>
    <xsl:with-param name="elename">Acc_manager</xsl:with-param>
    <!-- Last Edited Page changes starts -->
    <!--<xsl:with-param name="eleval">Acc_manager</xsl:with-param>-->
    <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Manager</xsl:with-param>
    <!-- Last Edited Page changes ends-->
    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
    <!-- Field Rationalization changes start-->
    <xsl:with-param name="linkshow">true</xsl:with-param>
    <xsl:with-param name="fncname">agentDetails(document.frm2.Acc_manager.value);</xsl:with-param>
    <!-- Field Rationalization changes end-->
    <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
    <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
    <!--113276 changes start -->
    <xsl:with-param name="buttonone_fnc">fnBluropenAgentLookup('Acc_manager')</xsl:with-param>
    <!--113276 changes end -->
    <xsl:with-param name="buttontwo_fnc">setAgentValues('Acc_manager','','')</xsl:with-param>
    </xsl:call-template>
    <!-- Field Rationalization fix -->
    <input type="hidden" name="Acc_managerURL" value=""/>
    <!-- TRACKERID #106384 : BEGIN OF CHANGE -->
    <input type="hidden" name="MinorAttainMajorDate" value=""/>
    <!-- TRACKERID #106384 : END OF CHANGE -->
    <input type="hidden" name="AccountBO.Manager" value="{$boDet[@n=concat($boName,'.Manager')]}"/>
    <input type="hidden" name="AccountBO.RelationshipMgrID" value="{$boDet[@n=concat($boName,'.RelationshipMgrID')]}"/>
</xsl:template>

<xsl:template name="AccountBO.SecondaryRM_ID">
    <xsl:call-template name="lookup">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.SecondaryRM_ID']"/>
    <xsl:with-param name="elename">Sec_manager</xsl:with-param>
    <xsl:with-param name="eleval">Sec_manager</xsl:with-param>
    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
    <!-- Field Rationalization changes start-->
    <xsl:with-param name="linkshow">true</xsl:with-param>
    <xsl:with-param name="fncname">agentDetails(document.frm2.Sec_manager.value);</xsl:with-param>
    <!-- Field Rationalization changes end-->
    <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
    <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
    <!--113276 changes start -->
    <xsl:with-param name="buttonone_fnc">fnBluropenAgentLookup('Sec_manager')</xsl:with-param>
    <!--113276 changes end -->
    <xsl:with-param name="buttontwo_fnc">setAgentValues('Sec_manager','','')</xsl:with-param>
    </xsl:call-template>
    <!-- Field Rationalization fix -->
    <input type="hidden" name="Sec_managerURL" value=""/>
</xsl:template>


<!--Relationship Manager Changes:End-->

<!--ML3 changes start-->
	<xsl:template name="AccountBO.DelinquencyFlg">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.DelinquencyFlg']"/>
			<xsl:with-param name="selectdisp">AccountBO.DelinquencyFlg</xsl:with-param>
			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.DelinquencyFlg</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.DelinquencyFlg</xsl:with-param>
			<xsl:with-param name="disable_val">true</xsl:with-param>
			<xsl:with-param name="max_length">1</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
	</xsl:template>
<!--changes from dropdown to lookup ends-->
<!-- TRACKER:371155:BEGINOFCHANGES -->
<xsl:template name="AccountBO.Cust_Language">
<xsl:call-template name="lookup">
<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Language']"/>
<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Cust_Language</xsl:with-param>
<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Cust_Language</xsl:with-param>
<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
<xsl:with-param name="buttonone_fnc">categoryLookup('CONTACT_LANGUAGE', '<xsl:value-of select="$boName"/>.Cust_Language')</xsl:with-param>
<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Cust_Language')</xsl:with-param>
<xsl:with-param name="checkASCII">false</xsl:with-param>
<xsl:with-param name="code_req">true</xsl:with-param>
</xsl:call-template>
</xsl:template>
<!-- TRACKER:371155:ENDOFCHANGES -->
 <!-- ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 start -->

        <!-- Templates for 4 new dropdown fields -->

<xsl:template name="AccountBO.islamic_banking_customer">
			<xsl:call-template name="mdrpdown">
				<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.islamic_banking_customer']"/>
				<xsl:with-param name="selectdisp">AccountBO.islamic_banking_customer</xsl:with-param>
				<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.islamic_banking_customer</xsl:with-param>
				<xsl:with-param name="choice_name">AccountBO.islamic_banking_customer</xsl:with-param>
				<xsl:with-param name="onchangefn">hideFields()</xsl:with-param>
				<!-- <xsl:with-param name="onchangefn">disableConditionally('AccountBO.islamic_banking_customer, 'AccountBO.zakat_deduction');</xsl:with-param>-->
				<xsl:with-param name="search_type">value</xsl:with-param>
				<xsl:with-param name="presdata" select="$PresData"/>
			</xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.zakat_deduction">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.zakat_deduction']"/>
					<xsl:with-param name="selectdisp">zakat_deduction</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.zakat_deduction</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.zakat_deduction</xsl:with-param>
					<!--<xsl:with-param name="onchangefn"> disableConditionally('<xsl:value-of select="$boName"/>. zakat_deduction, 'AccountBO.zakat_deduction')</xsl:with-param>-->
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.asset_classification">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.asset_classification']"/>
					<xsl:with-param name="selectdisp">AccountBO.asset_classification</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.asset_classification</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.asset_classification</xsl:with-param>
					<!--<xsl:with-param name="onchangefn"> disableConditionally('<xsl:value-of select="$boName"/>. asset_classification, 'AccountBO.zakat_deduction')</xsl:with-param>-->
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.Customer_Level_Provisioning">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Customer_Level_Provisioning']"/>
					<xsl:with-param name="selectdisp">AccountBO.Customer_Level_Provisioning</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Customer_Level_Provisioning</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.Customer_Level_Provisioning</xsl:with-param>
					<!--<xsl:with-param name="onchangefn"> disableConditionally('<xsl:value-of select="$boName"/>. Customer_Level_Provisioning, 'AccountBO.zakat_deduction')</xsl:with-param>-->
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
	</xsl:template>


      <!-- ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 end -->

	<xsl:template name="AccountBO.Cust_hlth">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_hlth']"/>
			<xsl:with-param name="selectdisp">AccountBO.Cust_hlth</xsl:with-param>
			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Cust_hlth</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			<xsl:with-param name="choice_name">AccountBO.Cust_hlth</xsl:with-param>
			<xsl:with-param name="search_type">url</xsl:with-param>
	   </xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.NativeLangCode">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.NativeLangCode']"/>
			<xsl:with-param name="selectdisp">AccountBO.NativeLangCode</xsl:with-param>
			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.NativeLangCode</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			<xsl:with-param name="choice_name">AccountBO.NativeLangCode</xsl:with-param>
			<xsl:with-param name="search_type">url</xsl:with-param>
		 </xsl:call-template>
	 </xsl:template>

	<!-- Tracker ID 113276 Changes - CIF Usability: Begin -->
	<!--Native Language Changes adding NativeLangTitle and name in native language using view:start-->
	<xsl:template name="AccountBO.NativeLangName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.NativeLangName']"/>
			<xsl:with-param name="ele_name">AccountBO.NativeLangName</xsl:with-param>
			<xsl:with-param name="ele_val">AccountBO.NativeLangName</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
			<xsl:with-param name="starshow">false</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.NativeLangTitle">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.NativeLangTitle']"/>
			<xsl:with-param name="selectdisp">AccountBO.NativeLangTitle</xsl:with-param>
			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.NativeLangTitle</xsl:with-param>
			<xsl:with-param name="ele_name">AccountBO.NativeLangTitle</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			<xsl:with-param name="ele_val">AccountBO.NativeLangTitle</xsl:with-param>
		<!--Tracker ID:123910 Changes Begin-->
		 <!--"choice-name " added to the template -->
			<xsl:with-param name="choice_name">AccountBO.NativeLangTitle</xsl:with-param>
		<!--Tracker ID:123910 Changes End-->

			<xsl:with-param name="starshow">false</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
<!--Native Language Changes adding title and name in native language:end-->
<!-- Tracker ID 113276 Changes - CIF Usability: End -->
	<xsl:template name="AccountBO.Cust_Swift_Code_Desc">
	    <xsl:call-template name="label">
	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Swift_Code_Desc']"/>
	        <xsl:with-param name="ele_name">AccountBO.Cust_Swift_Code_Desc</xsl:with-param>
	        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Swift_Code_Desc</xsl:with-param>


	    </xsl:call-template>
	</xsl:template>
 <!-- Tracker# 97236 CIF - EBanking Changes : Start -->
  <xsl:template name="AccountBO.IsEbankingEnabled">
         <xsl:call-template name="mdrpdown">
         <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.IsEbankingEnabled']"/>
          <!-- Changes for Track ID 223945  Begin-->
         <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.IsEbankingEnabled</xsl:with-param>
          <!-- Changes for Track ID 223945  End-->
         <xsl:with-param name="selectdisp">AccountBO.IsEbankingEnabled</xsl:with-param>
          <xsl:with-param name="choice_name">AccountBO.IsEbankingEnabled</xsl:with-param>
           <!-- Changes for Track ID 223945  Begin-->
         <xsl:with-param name="onchangefn">checkEbankFields();changeSMSBanking();</xsl:with-param>
          <!-- Changes for Track ID 223945  End-->
	 <xsl:with-param name="defaultValue">N</xsl:with-param>
         <xsl:with-param name="presdata" select="$PresData"/>
         </xsl:call-template>
 </xsl:template>
 <xsl:template name="AccountBO.IsSMSBankingEnabled">
         <xsl:call-template name="checkbox1">
             <xsl:with-param name="name">IsSMSBankingEnabled</xsl:with-param>
             <xsl:with-param name="checkbox_val">false</xsl:with-param>
             <xsl:with-param name="fncname">changeSMSBanking();</xsl:with-param>
          </xsl:call-template>
 </xsl:template>
 <xsl:template name="AccountBO.IsWAPBankingEnabled">
         <xsl:call-template name="checkbox1">
             <xsl:with-param name="name">IsWAPBankingEnabled</xsl:with-param>
             <xsl:with-param name="checkbox_val">false</xsl:with-param>
             <!-- Changes for Track ID 223945 Begin-->
             <xsl:with-param name="fncname">changeWAPBanking();</xsl:with-param>
             <!-- Changes for Track ID 223945 End-->
          </xsl:call-template>
 </xsl:template>
<!-- Tracker# 97236 CIF - EBanking Changes : End -->
<!-- Tracker# 97236 SMS Banking Mobile Number : Start -->
      	<xsl:template name="AccountBO.SMSBankingMobileNumber">
       		<xsl:call-template name="label">
		        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.SMSBankingMobileNumber']"/>
       			<xsl:with-param name="ele_name">AccountBO.SMSBankingMobileNumber</xsl:with-param>
       			<!-- Changes for track id:223945 Begin-->
       			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SMSBankingMobileNumber</xsl:with-param>
       			<!-- Changes for track id:223945 End-->
       			<xsl:with-param name="max_length">15</xsl:with-param>
       			<xsl:with-param name="starshow">true</xsl:with-param>
       			<!-- Changes Begin for Tracker 126433 Begin -->
			<xsl:with-param name="fn_onBlur">formatMobile();</xsl:with-param>
			<!-- Changes End for Tracker 126433 End -->

       			</xsl:call-template>
      	</xsl:template>
<!-- Tracker# 97236 SMS Banking Mobile Number : End -->
<!--ML3 changes end-->

	<!-- CRM70t-ST :TRACKER# 79632 **END OF CHANGES ** -->

           <xsl:template name="AccountBO.ChargeLevelCode">
<!--
               <xsl:call-template name="label">
                    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.ChargeLevelCode']"/>
                    <xsl:with-param name="read_val">true</xsl:with-param>
                    <xsl:with-param name="ele_name">AccountBO.ChargeLevelCode</xsl:with-param>
                    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.ChargeLevelCode</xsl:with-param>
               </xsl:call-template>
-->
<!-- Core dependency changes  begin -->
		     <xsl:call-template name="lookup">
		     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.ChargeLevelCode']"/>
		     <xsl:with-param name="elename">AccountBO.ChargeLevelCode</xsl:with-param>
		     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.ChargeLevelCode</xsl:with-param>
		     <xsl:with-param name="buttonone_fnc">categoryLookup('CHARGE_LEVEL_CODE', 'AccountBO.ChargeLevelCode')</xsl:with-param>
		     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.ChargeLevelCode')</xsl:with-param>
		     <xsl:with-param name="checkASCII">false</xsl:with-param>
		    </xsl:call-template>
<!-- Core dependency changes end -->
           <!-- changes for Tracker 297900 begins-->
           </xsl:template>
                   <xsl:template name="AccountBO.Segmentation_Class">
		   <xsl:call-template name="lookup">
		   <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Segmentation_Class']"/>
		   <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Segmentation_Class</xsl:with-param>
		   <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Segmentation_Class</xsl:with-param>
		   <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		   <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		   <xsl:with-param name="buttonone_fnc">categoryLookup('SEGMENTATION_CLASS', '<xsl:value-of select="$boName"/>.Segmentation_Class')</xsl:with-param>
		   <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Segmentation_Class')</xsl:with-param>
		   <xsl:with-param name="checkASCII">false</xsl:with-param>
		   <xsl:with-param name="code_req">true</xsl:with-param>
		   </xsl:call-template>
	 </xsl:template>
	 <!-- changes for Tracker 297900 ends-->
                   <xsl:template name="AccountBO.SubSegment">
                            <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.SubSegment']"/>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.SubSegment</xsl:with-param>
                            <xsl:with-param name="selectdisp">AccountBO.SubSegment</xsl:with-param>
    				<xsl:with-param name="presdata" select="$PresData"/>
                            <xsl:with-param name="search_type">value</xsl:with-param>
    			<xsl:with-param name="choice_name">AccountBO.SubSegment</xsl:with-param>
                            </xsl:call-template>
                     </xsl:template>
                     <!--Equity bank adding new field for non cif introducer name TOI 360106-->
		     	<xsl:template name="AccountBO.StrUserField21">
		     		   <xsl:call-template name="label">
		     		    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField21']"/>
		     		    <xsl:with-param name="ele_name">AccountBO.StrUserField21</xsl:with-param>
		     		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.StrUserField21</xsl:with-param>
		     		    <xsl:with-param name="starshow">false</xsl:with-param>
		     		    <xsl:with-param name="checkASCII">false</xsl:with-param>
		     		   </xsl:call-template>
		     	</xsl:template>
	              <!--Equity bank adding new field for non cif introducer name TOI 360106-->
	              
	              <!--Equity bank adding new field for non cif introducer name TOI 356581-->
			<xsl:template name="AccountBO.StrUserField22">
				   <xsl:call-template name="label">
				    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField22']"/>
				    <xsl:with-param name="ele_name">AccountBO.StrUserField22</xsl:with-param>
				    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.StrUserField22</xsl:with-param>
				    <xsl:with-param name="starshow">false</xsl:with-param>
				    <xsl:with-param name="checkASCII">false</xsl:with-param>
				   </xsl:call-template>
			</xsl:template>
	              <!--Equity bank adding new field for non cif introducer name TOI 356581-->

 <!--WMS fields:start-->
 	<xsl:template name="AccountBO.RiskProfileScore">
 	   <xsl:call-template name="label">
 		 <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.RiskProfileScore']"/>
 		 <xsl:with-param name="ele_name">AccountBO.RiskProfileScore</xsl:with-param>
 		 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.RiskProfileScore</xsl:with-param>
 	    </xsl:call-template>
 	</xsl:template>
	<xsl:template name="AccountBO.RiskProfileExpiryDate">
	      <xsl:call-template name="label">
	       <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.RiskProfileExpiryDate']"/>
	       <xsl:with-param name="ele_name">AccountBO.RiskProfileExpiryDate</xsl:with-param>
	       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.RiskProfileExpiryDate</xsl:with-param>
	       <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
	        <!-- calling the function isGregDate for on blur functionality-->
	       	 <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.RiskProfileExpiryDate");</xsl:with-param>
	       <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
	      </xsl:call-template>
	 </xsl:template>

<!--WMS fields:end-->

<!-- Memo padding begin -->
	 <xsl:template name="MEMOPAD">
		<xsl:call-template name="hyperlink">
		<xsl:with-param name="res_name">MEMO PAD</xsl:with-param>
		<xsl:with-param name="fncname">showMemo('Edit');</xsl:with-param>
		</xsl:call-template>
	  </xsl:template>
<!-- Memo padding end -->

<xsl:template match="*" mode="mode1" >
	<form name="frm2" method="post" >
	<!-- changes for SPE tickets 10.2.12 starts -->
		<!--Ticket 349330 changes start-->
	<IFRAME name="hdifrm_empform" width="0" height="0" />
	<!-- changes for SPE tickets 10.2.12 ends -->
		<!--Ticket 349330 changes end-->
	<!-- KeyGeneration start -->
	<!-- changes for SPE tickets 10.2.12 starts -->
		<!--Ticket 349330 changes start-->
	<IFRAME name="hdifrm_rescifid" width="0" height="0" />
	<!-- changes for SPE tickets 10.2.12 ends -->
		<!--Ticket 349330 changes end-->
	<!-- KeyGeneration end -->
	<!--Key generation changes start-->
	<input type="hidden" name="hid_cifid" value=""/>
	<input type="hidden" name="hid_reservestatus" value=""/>
	<!--Key generation changes end-->
    <!--Tracker id 113227 changes start-->
	<input type="hidden" name="altLocaleActv" />
 	<!--Tracker id 113227 changes end-->
	<!-- CIF CHANGES Suman-->
	<input type="hidden" name="Bank_Entity" value=""/>
	<input type="hidden" name="ID" value="{$ID}"/>
	<input type="hidden" name="hid_accountIDvalue" value=""/>
	<input type="hidden" name="hid_introIDvalue" value="{$IntroIDValue}"/>
	<input type="hidden" name="Bank_Entity1" value=""/>
	<input type="hidden" name="CustomerMinor" value=""/>
	
	<input type="hidden" name="SeniorCitizen" value=""/>
<!--Access Control Changes-->
	<input type="hidden" name="accessOwnerGroup" value=""/>
	<input type="hidden" name="accessOwnerBC" value=""/>
	<!--End of Changes-->
	<!--Tracker id 224978, begin of changes-->
	<input type="hidden" name="IntroducerFirstName" value=""/>
	<input type="hidden" name="Gender" value=""/>
	<!--Tracker id 224978, End of changes-->
	<!--Changes for minor validations: start-->
	<input type="hidden" name="minorLoaded" value=""/>
	<!--Changes for minor validations: end-->
	<!-- CIF Changes Tessa - Start -->
	<!-- addition of hidden variable if key is autogenerated -->
	<input type="hidden" value="{$isAutoGenKey}" name="isAutoGenKey"/>
	<!-- CIF Changes Tessa - End -->

	<input type="hidden" name="selAvailBackendID" value=""/>

	<!-- CIF CHANGES anwesha-->
	<!-- CIF Changes Bharath - End -->
		<input type="hidden" name="custBankId" value="0"/>
	<!-- CIF CHANGES anwesha-->
	<input type="hidden" name="address_type" value=""/>
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
	<input type="hidden" name="address_proof" value=""/>
	<input type="hidden" name="home_phone" value=""/>
	<input type="hidden" name="work_phone" value=""/>
	<input type="hidden" name="cellno" value=""/>
	<input type="hidden" name="faxno" value=""/>
	<input type="hidden" name="email" value=""/>
	<input type="hidden" name="website" value=""/>
	<input type="hidden" name="mailstop" value=""/>
	<input type="hidden" name="streetname" value=""/>
	<input type="hidden" name="suburb" value=""/>
	<input type="hidden" name="hidSt" value=""/>
	<input type="hidden" name="work_phone_cntry" value=""/>
	<input type="hidden" name="work_phone_area" value=""/>
	<input type="hidden" name="work_phone_local" value=""/>
<!-- changes for Tracker ID 456637 - TOL ID 455246 -->
<input type="hidden" name="vAddTypeLT" value=""/>
<!-- changes for Tracker ID 456637 - TOL ID 455246 -->
	<input type="hidden" name="home_phone_cntry" value=""/>
	<input type="hidden" name="home_phone_area" value=""/>
	<input type="hidden" name="home_phone_local" value=""/>

	<input type="hidden" name="cellno_cntry" value=""/>
	<input type="hidden" name="cellno_area" value=""/>
	<input type="hidden" name="cellno_local" value=""/>

	<input type="hidden" name="faxno_cntry" value=""/>
	<input type="hidden" name="faxno_area" value=""/>
	<input type="hidden" name="faxno_local" value=""/>

	<input type="hidden" name="extension" value=""/>
	<!--CORE Fields Inclusion:start-->
	<input type="hidden" name="telex" value=""/>
	<input type="hidden" name="telex_cntry" value=""/>
	<input type="hidden" name="telex_area" value=""/>
	<input type="hidden" name="telex_local" value=""/>
	<input type="hidden" name="country_code" value=""/>
	<input type="hidden" name="state_code" value=""/>
	<input type="hidden" name="city_code" value=""/>
         <!-- 383261 tracker changes starts -->
	<input type="hidden" name="hid_introRelation" value="INTRODUCER"/>
	<input type="hidden" name="core_cust_id" value=""/>
	<input type="hidden" name="salutation_code" value=""/>
	<!--CORE Fields Inclusion:end-->
	<input type="hidden" name="eduURL" value=""/>
	<input type="hidden" name="EduRemoved" value=""/>
	<!-- House hold ID changes : Begin -->
	<input type="hidden" name="newHouseVal" value=""/>
	<!-- House hold ID changes : End -->
		<!-- Hidden variables for identification tab end-->
<!--IDENTIFICATION DOCUMENT CHANGES start-->
<!--saving identifier_type (unique id, Issue_Date, Valid_Date) in EntityTable for Retail start-->
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
		<!-- Changes done by vikas for tracker id 260279 starts-->
	        <input type="hidden" name="hid_contactURL" value="{$contactURL}"/>
	        <!-- Changes done by vikas for tracker id 260279 ends-->
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
		<input type="hidden" name="hidDocTypeDescr" value=""/>
		<input type="hidden" name="hidDocReceivedDate" value=""/>
		<input type="hidden" name="hidDocRemarks" value=""/>
		<input type="hidden" name="hidStatus" value=""/>
		<!--317919 changes starts-->
		<input type="hidden" name="hidCustomerStatus" value=""/>
		<!--3179191 changes ends-->
		<input type="hidden" name="hidIsMandatory" value=""/>
		<input type="hidden" name="hidScanRequired" value=""/>
		<input type="hidden" name="identifier_type_Code" value=""/>
		<!-- Changes for 228518 Start-->
		<input type="hidden" name="hididentifier_type_Code" value=""/>
		<!-- Changes for 228518 End-->
		<input type="hidden" name="placeofissue" value=""/>
		<input type="hidden" name="countryofissue" value=""/>
		<input type="hidden" name="placeofissue_cat" value=""/>
		<input type="hidden" name="countryofissue_cat" value=""/>
		<input type="hidden" name="hidIsDocumentVerified" value=""/>
		<!--  Changes for trackerid - 261095 starts -->
		<!-- Changes for trackerid - 257673 starts -->
		<input type="hidden" name="hididentifier_type_Code" value=""/>
		<!-- Changes for trackerid - 257673 ends -->
		<!--  Changes for trackerid - 261095 ends -->
		<input type="hidden" name="hidIDIssuedOrg" value=""/>
		<!-- Last Edited Page changes starts -->
		<input type="hidden" name="hidEDoc_IsDirty" value=""/>
		<!-- Last Edited Page changes ends-->
<!--IDENTIFICATION DOCUMENT CHANGES end-->
		<input type="hidden" name="hidUniqueID" value=""/>
		<input type="hidden" name="hidUniqueIDType" value=""/>


			<!-- Hidden variables for identification tab end-->
		<input type="hidden" name="hType" value=""/>
		<input type="hidden" name="hCurrencyPsychoURL" value=""/>
		<input type="hidden" name="hCore_cust_id" value=""/>
		<input type="hidden" name="hDeletedCurrencyID" value=""/>
		<input type="hidden" name="hDeletedCustomerCurrency" value=""/>

		<input type="hidden" name="hCustomerCurrency" value=""/>
		<input type="hidden" name="hCreditDiscountPercent" value=""/>
		<input type="hidden" name="hDebitDiscountPercent" value=""/>
		<input type="hidden" name="hWithholdTaxPcnt" value=""/>
		<input type="hidden" name="hWithholdTaxFloorLmt" value=""/>
		<input type="hidden" name="hPreferentialExpiryDate" value=""/>
	<!--Minor Age changes: start-->
	<input type="hidden" value="{$MINOR_YEAR}" name="MINOR_YEAR"/>
	<!--Minor Age changes: end-->
	   <!--Senior Age changes: start-->
		     <input type="hidden" value="{$SENIOR_YEAR}" name="SENIOR_YEAR"/>
           <!--Senior Age changes: end-->
	<!--Approval change:Suman:Start-->
	<input type="hidden" name="apprFlag" value="{$apprFlag}"/>
	<!--Approval change:Suman:End-->
<!-- CRM101UB group changes start -->
		<input type="hidden" name="GroupName" value=""/>
		<input type="hidden" name="GroupID" value=""/>
		<input type="hidden" name="GroupCode" value=""/>
		<input type="hidden" name="GroupMasterID" value=""/>
	    	<input type="hidden" name="GroupURL" value=""/>
	    	<input type="hidden" name="PercentShare" value=""/>
	    	<input type="hidden" name="GroupRemoved" value=""/>
		<input type="hidden" name="GlobalRM" value=""/>
		<input type="hidden" name="Group_ID" value=""/>
		<input type="hidden" name="Prim_Grp_ID" value=""/>
<!-- CRM101UB group changes end -->
	<!-- Changes for 'WFlow' POC start -->
	<input type="hidden" name="IntWFID" value="{$IntWFID}"/>
	<!-- Changes for 'WFlow' POC  end -->

	<input type="hidden" name="hid_bodateCreated" value=""/>
	<input type="hidden" name="noOfDaysIntro" value="{$noOfDaysIntro}"/>
	<!-- Last Edited Page changes starts -->
    <input type="hidden" name="boName" value="{$boName}"/>
    	<!-- new added hidden : for :Copy :start -->
    	 <input type="hidden" name="IsCopy" value="{$isCopy}"/>
        <!-- new added hidden : for :Copy :end -->
	<input type="hidden" name="hid_accountURL" value="{$accountURL}"/>
	 <input type="hidden" name="accountID" value="{$accountID}"/>
     <input type="hidden" name="operationType" value="{$operationType}"/>
     <input type="hidden" name="AdrRemoved" value=""/>
     <input type="hidden" name="boNameDemo" value="{$boNameDemo}"/>
     <input type="hidden" name="Nationality_Code" value=""/>
     <input type="hidden" name="Marital_status_code" value=""/>
	<!-- Last Edited Page changes -->

	<!-- Hidden variables for HouseHold tab start -->
	<input type="hidden" name="HouseHoldName" 		value=""/>
	<input type="hidden" name="HouseHoldID" 		value=""/>
	<input type="hidden" name="HouseHoldCode" 		value=""/>
	<input type="hidden" name="HouseHoldMasterID" 	value=""/>
	<input type="hidden" name="HouseHoldRemoved" 	value=""/>
	<input type="hidden" name="HouseHoldURL" 		value=""/>
	<!-- Hidden variables for HouseHold tab end  -->
        <!--Save & submit  change:Starts-->
	<input type="hidden" name="saveFlag" value=""/>
	<!--Save & submit change:End-->
	<!-- Changes for PhoneEmail :Start-->

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
	<input type="hidden" name="IsAddressProofRcvd" value=""/>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
<input name="IsAddressVerified" type="hidden" value=""/>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->

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
	<input type="hidden" name="mainAccId" value=""/>
	<input type="hidden" name="isMCEditedGeneral" value="N"/>
	<input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
	<input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
	<input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>
	<input type="hidden" name="getRole" value="{$getRole}"/>
	<!-- Change for DBS ticket 325152 -->
	<input type="hidden" name="SwiftAddressDetails" value=""/>

	<!-- Changes for PhoneEmail :End-->
<!-- Tab in Tab -->

<!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES-->

<input type="hidden" name="Cust_DOB" value=""/>
<input type="hidden" name="RelationshipOpeningDate" value=""/>
<input type="hidden" name="RiskProfileExpiryDate" value=""/>
<input type="hidden" name="DateOfBecomingNRE" value=""/>
<input type="hidden" name="NREBecomingOrdDate" value=""/>
<input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
<!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES-->

<!-- Senior Citizen--><input type="hidden" name="seniorAttainSeniorDateHij" value="DEFAULT"/>

<!--Hidden variables for StrUserFields for tracker id : 251240 / ticket id : 413744 start-->
<input type="hidden" name="StrUserField13" value=""/>
<!--Hidden variables for StrUserFields for tracker id : 251240 / ticket id : 413744 end-->

<!--Fix for ticket 338288 by tracker 220538 - 10.2.05 Starts -->
<input type="hidden" name="RelationshipCreatedById" value=""/>
<!--Fix for ticket 338288 by tracker 220538 - 10.2.05 Ends -->

	<xsl:call-template name="BeginTabView">
		<xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
		<xsl:with-param name="tabPageHeight">1150</xsl:with-param>
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
		<xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
	</xsl:call-template>

	<!-- CIF Changes Shanmuga-->
	<script>
		//CRM10.2 SPE
		var DataArray = new Array;
		var DataCount = 0;
		<xsl:for-each select="$PresCurrData/SRMComposite[@n='CurrencyRecordSet']/SRMRow">
		    DataArray[DataCount] = '<xsl:value-of select="./Z[@n='CurrencyBO.CurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.Format']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.NumberOfDecimals']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.MantissaSeperator']"/>'+"|"+'<xsl:value-of select="./Z[@n='CurrencyBO.DecimalSeperator']"/>';
		    DataCount++;
		</xsl:for-each>

		//Tracker 105341
		var iCount = 0;
		ExArray = new Array;
		<xsl:for-each select="$PresExData/SRMComposite[@n='ExRateRecordSet']/SRMRow">
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
	 <!-- CIF Changes Shanmuga -->

<!--CIF Changes for new fields added in QDE: Start-->

<!-- Tracker ID 113276 Changes - CIF Usability: Begin -->
<!--CIF Changes for changing the position of fields in QDE: Start-->
<!-- Moving CIF ID field to the top of screen -->
<!-- DEF-565 Begin of Changes-->
<table width="100%" bgcolor='ffffff' cellspacing="0" vspace="0" hspace="0" border="0">
<!-- DEF-565 End of Changes-->
       	 <xsl:call-template name="Begin"/>

<!--Begin Of Changes, ME Phase 3 Tracker ID:131246
Changes by sonali_narula for GCIF LookUp
Added this look up for GcifId in customer creation screen for customer and customerQDE-->
       		<xsl:call-template name="AccountBO.GCIFID"/>
<!--End of Changes For GCIF LookUp-->

       		<xsl:call-template name="AccountBO.AccountKey"/>
		<!--<xsl:call-template name="addemptycell"/>-->

       	 <xsl:call-template name="End"/>
<!--Recon of Changes for FS :716201 TOL 444472  -->
<xsl:call-template name="apply1">
			      <xsl:with-param name="apply_head">
		    <!-- changed General details to personal below -->
			      Personal Details
			     </xsl:with-param>
	 </xsl:call-template>
          <xsl:call-template name="Begin"/>
         <!--CIF Changes for changing the position of gender field -->
       		<xsl:call-template name="AccountBO.Gender"/>
               		<xsl:call-template name="AccountBO.Salutation"/>

       	 <xsl:call-template name="End"/>

       	<xsl:call-template name="Begin"/>
       		<xsl:call-template name="AccountBO.Cust_First_Name"/>
       		<xsl:call-template name="AccountBO.Cust_Middle_Name"/>



       	 <xsl:call-template name="End"/>

       	 <xsl:call-template name="Begin"/>
       	 	<xsl:call-template name="AccountBO.Cust_Last_Name"/>
       	 	<!-- CIF ID filed moved from here to above -->
       		<!--<xsl:call-template name="AccountBO.AccountKey"/>-->

       		<xsl:call-template name="AccountBO.short_name"/>

       		<!-- <xsl:call-template name="AccountBO.PreferredName"/> -->
       	 <xsl:call-template name="End"/>

       	 <xsl:call-template name="Begin"/>
       	 	<xsl:call-template name="AccountBO.Name"/>
       		<xsl:call-template name="AccountBO.PreferredName"/>
       		<!--CIF Changes gender field moved from here -->
       	 <xsl:call-template name="End"/>

       	 <xsl:call-template name="Begin"/>

       		<xsl:call-template name="AccountBO.Cust_DOB"/>
       	 	<xsl:call-template name="AccountBO.CustomerMinor"/>


       	 <xsl:call-template name="End"/>
<!-- Senior Citizen Starts-->
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.SeniorCitizen"/>
    <xsl:call-template name="AccountBO.SenCitizenApplicableDate"/>
<xsl:call-template name="End"/>
<!-- Senior Citizen Ends-->
       	 <xsl:call-template name="Begin"/>
       	 	<xsl:call-template name="DemographicBO.Nationality"/>
       	 	<!-- Changes done by Bharath start -->
		<xsl:call-template name="AccountBO.StrUserField11"/>
       	 	<!-- Changes done by Bharath start -->
       	 <xsl:call-template name="End"/>

	 <xsl:call-template name="Begin"/>
       	 	<xsl:call-template name="AccountBO.StrUserField27"/>
		<xsl:call-template name="AccountBO.StrUserField25"/>
       	 <xsl:call-template name="End"/>

	 <!-- Religion\Economic Sector Customization by Kate Starts-->
	<xsl:call-template name="Begin"/>
	 <xsl:call-template name="AccountBO.StrUserField28"/>
	  
	  <!-- Equity change start -->
	  <!-- <xsl:call-template name="AccountBO.StrUserField29"/> -->
	        <xsl:call-template name="AccountBO.CustomerNREFlg"/>
       	 <xsl:call-template name="End"/>


       	 <xsl:call-template name="Begin"/>

       	 	<xsl:call-template name="AccountBO.DateOfBecomingNRE"/>
	        <xsl:call-template name="AccountBO.StaffFlag"/>
       	 <xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
		 <xsl:call-template name="AccountBO.Cust_Type"/>
		  <!-- Equity change start -->
		  <!-- <xsl:call-template name="AccountBO.Status_code"/> -->
		  <xsl:call-template name="AccountBO.status"/>
		  
		  <!-- Equity change end -->

       	 <xsl:call-template name="End"/>

       	 <xsl:call-template name="Begin"/>
     
       		<xsl:call-template name="AccountBO.StaffEmployeeID"/>
                <xsl:call-template name="AccountBO.Primary_sol_id"/>
       	 <xsl:call-template name="End"/>


       	 <xsl:call-template name="Begin"/>
       	 		<xsl:call-template name="AccountBO.Segmentation_Class"/>
		<xsl:call-template name="AccountBO.SubSegment"/>
       	 <xsl:call-template name="End"/>

       	<xsl:call-template name="Begin"/>
		    <xsl:call-template name="AccountBO.ChargeLevelCode"/>
		    <xsl:call-template name="AccountBO.Cust_hlth"/>
       	 <xsl:call-template name="End"/>

       	 <xsl:call-template name="Begin"/>
       	 	
       	 	<xsl:call-template name="AccountBO.Cust_Swift_Code_Desc"/>
		<xsl:call-template name="AccountBO.RiskProfileScore"/>
       	 <xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
		
		<xsl:call-template name="AccountBO.RiskProfileExpiryDate"/>
		<xsl:call-template name="AccountBO.region"/>
	<xsl:call-template name="End"/>


	<xsl:call-template name="Begin"/>
		
       	 	<xsl:call-template name="DemographicBO.Marital_Status"/>
            <xsl:call-template name="DemographicBO.MiscellaneousInfo.strText2"/>
       	 <xsl:call-template name="End"/>

       	 <!-- Shanmuga CIF Changes - Call for the Annual Salary Income field template -->
	<xsl:call-template name="Begin"/>
		
       	 	<xsl:call-template name="DemographicBO.Employment_Status"/>

	<xsl:call-template name="End"/>





	<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.Annual_Salary_Income"/>
		<!-- Change done by Bharath start -->
		<xsl:call-template name="AccountBO.Amount2"/>
		<!-- Change done by Bharath end -->
	<xsl:call-template name="End"/>
	 <!-- Shanmuga CIF Changes -->




       	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="AccountBO.asset_classification"/>
	    <xsl:call-template name="AccountBO.Customer_Level_Provisioning"/>
       	<xsl:call-template name="End"/>
       	<xsl:call-template name="Begin"/>
		    <xsl:call-template name="AccountBO.islamic_banking_customer"/>
		    <xsl:call-template name="AccountBO.zakat_deduction"/>
       	<xsl:call-template name="End"/>


				<xsl:call-template name="Begin"/>
				<xsl:call-template name="AccountBO.preferredCalendar"/>
				<xsl:call-template name="AccountBO.Tds_tbl"/>
		<xsl:call-template name="End"/>


	<xsl:call-template name="Begin"/>
		 <xsl:call-template name="AccountBO.StrUserField19"/>
	  <xsl:call-template name="AccountBO.Sector"/>
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
<!--Recon of Changes for FS :716201 TOL 444472  -->
		<xsl:call-template name="apply1">
			<xsl:with-param name="apply_head">
			<b><xsl:value-of select="$configLabels[@name='EBanking']/@configLabel"/></b><br/>
			</xsl:with-param>
		</xsl:call-template>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountBO.IsEbankingEnabled"/>
	<xsl:call-template name="AccountBO.SMSBankingMobileNumber"/>
	<xsl:call-template name="End"/>
	<!--Changes for Ticket 717947 begin-->
	<xsl:call-template name="Begin" />
	
	<xsl:call-template name="BeginCellWithParams">
		<xsl:with-param name="align">center</xsl:with-param>
		<xsl:with-param name="class">d1</xsl:with-param>
		<xsl:with-param name="style">TEXT-ALIGN: left;</xsl:with-param>
	</xsl:call-template>	
	<xsl:value-of select="$configLabels[@name='AccountBO.IsWAPBankingEnabled']/@configLabel"/>
	<xsl:call-template name="EndCell" />
	
	<xsl:call-template name="BeginCellWithParams">
		<xsl:with-param name="align">left</xsl:with-param>
		<xsl:with-param name="class">d1TD</xsl:with-param>
		<xsl:with-param name="style">TEXT-ALIGN: left;</xsl:with-param>
	</xsl:call-template>
		<xsl:call-template name="AccountBO.IsWAPBankingEnabled" />
	<xsl:call-template name="EndCell" />
	
	<xsl:call-template name="BeginCellWithParams">
		<xsl:with-param name="align">center</xsl:with-param>
		<xsl:with-param name="class">d1</xsl:with-param>
		<xsl:with-param name="style">TEXT-ALIGN: left;</xsl:with-param>
	</xsl:call-template>
		<xsl:value-of select="$configLabels[@name='AccountBO.IsSMSBankingEnabled']/@configLabel"/>
	<xsl:call-template name="EndCell" />
	
	<xsl:call-template name="BeginCellWithParams">
		<xsl:with-param name="align">center</xsl:with-param>
		<xsl:with-param name="class">d1TD</xsl:with-param>
		<xsl:with-param name="style">TEXT-ALIGN: left;</xsl:with-param>
	</xsl:call-template>
		<xsl:call-template name="AccountBO.IsSMSBankingEnabled" />
	<xsl:call-template name="EndCell" />	
	
	<xsl:call-template name="End" />
	<!--Changes for Ticket 717947 Ends-->


<!--Recon of Changes for FS :716201 TOL 444472  -->
	 <xsl:call-template name="apply1">
	 	<xsl:with-param name="apply_head">
		          Relationship Manager Details
	 	</xsl:with-param>
 	</xsl:call-template>
<!-- Tracker ID 113276 - Adding Relationship Manager Details Tab: End-->

     <!--Relationship Manager Changes:Start-->
       	 <xsl:call-template name="Begin"/>
	       		<xsl:call-template name="AccountBO.Manager"/>
	       		<xsl:call-template name="AccountBO.SecondaryRM_ID"/>
	 <xsl:call-template name="End"/>
       <!--Relationship Manager Changes:End-->


       	 <xsl:call-template name="Begin"/>

       	 	<xsl:call-template name="AccountBO.RelationshipOpeningDate"/>
			<xsl:call-template name="AccountBO.StrUserField26"/>
       	<xsl:call-template name="End"/>


  <xsl:call-template name="Begin"/>

		<!-- <xsl:call-template name="AccountBO.rm_group_id"/> -->

         <xsl:call-template name="End"/>

<!--Recon of Changes for FS :716201 TOL 444472  -->
	 <xsl:call-template name="apply1">
		 <xsl:with-param name="apply_head">
		          Language Preference
		 </xsl:with-param>
 	</xsl:call-template>
<!-- Tracker ID 113276 - Adding Language Preference Tab: End-->

<!--ML3 changes start-->
	<xsl:call-template name="Begin"/>
	<!-- Tracker ID 113276 - Adding Fileds Native Langauge Title and Native Lang Name : Begin-->
	       		<xsl:call-template name="AccountBO.NativeLangCode"/>
	       	<xsl:call-template name="AccountBO.NativeLangTitle"/>
	 <xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
		<xsl:call-template name="AccountBO.NativeLangName"/>
	       		<xsl:call-template name="AccountBO.Cust_Language"/>
	<!-- Tracker ID 113276 - Adding Fileds Native Langauge Title and Native Lang Name : End-->
	 <xsl:call-template name="End"/>
<!--ML3 changes end-->

	<xsl:call-template name="Begin"/>
	<xsl:choose>
		<xsl:when test= "not(normalize-space($accountURL)='')">
	<xsl:call-template name="Begin"/>
		<xsl:call-template name="LastUpdateDate"/>
	        <xsl:call-template name="End"/>
	      </xsl:when>

	</xsl:choose>
	<!-- Tracker ID: 110739: Begin of changes : For realigning the fields -->
	<!-- Tracker ID 113276 - Charge level code field Moved from Here -->
	<!-- <xsl:call-template name="AccountBO.ChargeLevelCode"/> -->
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
	<!-- Tracker ID: 110739: End of changes -->
	<!-- Tracker ID 113276 - Removal of document received tab from UI begins here -->
	<!--	<td class='d1' align='center'><xsl:value-of select="$configLabels[@name='AccountBO.Document_Received']/@configLabel"/></td>
		<td class='d1' align='center' style='TEXT-ALIGN: left;padding-left:0px;'><xsl:call-template name="Document_Received"/></td>
	-->
	<xsl:call-template name="End"/>
	<!-- Tracker ID 113276 - Removal of document received tab from UI begins here -->
<!-- Memo pad begin -->
<xsl:choose>
	<xsl:when test= "not(normalize-space($accountURL)='')">
	<xsl:call-template name="Begin"/>
		<xsl:call-template name="MEMOPAD"/>
	<xsl:call-template name="End"/>
	</xsl:when>
</xsl:choose>
<!-- Memo pad end -->

<!-- Tracker ID 113276 - Ebanking section Moved up from here - Start -->
	<!-- Tracker# 97236 CIF - EBanking Changes : Start -->
	<!--<xsl:call-template name="Begin"/>
		<xsl:call-template name="apply1">
			<xsl:with-param name="apply_head">
			<b><xsl:value-of select="$configLabels[@name='EBanking']/@configLabel"/></b><br/>
			</xsl:with-param>
		</xsl:call-template>
	<xsl:call-template name="End"/>


	<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountBO.IsEbankingEnabled"/>
	<xsl:call-template name="AccountBO.SMSBankingMobileNumber"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
		<td class='d1' align='center' style='TEXT-ALIGN: right;'><xsl:value-of select="$configLabels[@name='AccountBO.IsSMSBankingEnabled']/@configLabel"/></td>
		<td class='d1' align='center' style='TEXT-ALIGN: left;'><xsl:call-template name="AccountBO.IsSMSBankingEnabled"/></td>
  		<td class='d1' align='center' style='TEXT-ALIGN: right;'><xsl:value-of select="$configLabels[@name='AccountBO.IsWAPBankingEnabled']/@configLabel"/></td>
		<td class='d1' align='center' style='TEXT-ALIGN: left;'><xsl:call-template name="AccountBO.IsWAPBankingEnabled"/></td>
	<xsl:call-template name="End"/>	 -->


 	<!-- Tracker# 97236 CIF - EBanking Changes : End -->
 <!-- Tracker ID 113276 - Ebanking section Moved up here - End -->
<!--CIF Changes for new fields added in QDE: End-->
<!--Native Language Changes:start-->
<!-- Tracker ID 113276 - Hiding Entire Native Langaugae Section : Begin-->
<!--<xsl:variable name="NATIVE"><xsl:value-of select="$configLabels[@name='NativeLanguageFields']/@configLabel"/></xsl:variable>

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
		<xsl:call-template name="AccountBO.Cust_Last_Name_Native">
			   <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_Native</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="AccountBO.Cust_Middle_Name_Native">
			   <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_Native</xsl:with-param>
		</xsl:call-template>
	</TR>
	<TR ID='rownative' name='rownative'>
		<xsl:call-template name="AccountBO.Cust_First_Name_Native">
			   <xsl:with-param name="ele_name">AccountBO.Cust_First_Name_Native</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="AccountBO.Short_Name_Native">
			   <xsl:with-param name="ele_name">AccountBO.Short_Name_Native</xsl:with-param>
		</xsl:call-template>

	</TR>
	<TR ID='rownative' name='rownative'>
		<xsl:call-template name="AccountBO.Cust_Last_Name_Native1">
			   <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_Native1</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="AccountBO.Cust_Middle_Name_Native1">
			   <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_Native1</xsl:with-param>
		</xsl:call-template>
	</TR>
	<TR ID='rownative' name='rownative'>
		<xsl:call-template name="AccountBO.Cust_First_Name_Native1">
			   <xsl:with-param name="ele_name">AccountBO.Cust_First_Name_Native1</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="AccountBO.Short_Name_Native1">
			   <xsl:with-param name="ele_name">AccountBO.Short_Name_Native1</xsl:with-param>
		</xsl:call-template>

	</TR>


</DIV>-->
<!-- Tracker ID 113276 - Hiding Entire Native Langaugae Section : End-->

<!--Native Language Changes:end-->
<tr></tr>
<!-- Tracker ID 113276 - Primary Introduse Details Section Moved from here to below -->
<!-- <xsl:call-template name="Begin"/>
	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head">
		<b><xsl:value-of select="$configLabels[@name='MLHeader']/@configLabel"/></b><br/>
		</xsl:with-param>
		</xsl:call-template>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="RelationshipBO.ChildEntityType"/>
    <xsl:call-template name="RelationshipBO.Bank_Entity1"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="RelationshipBO.Bank_Entity_Name1"/>
    <xsl:call-template name="AccountBO.Introd_Status"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.IntroducerSalutation"/>
    <xsl:call-template name="AccountBO.IntroducerID"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.IntroducerName"/>
    	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>-->


<!--CIF Changes - BackEnd Changes Begins -->
<!-- Tracker ID 113276 - Hiding Backend ID details from UI - Begin -->
<!--<table width="100%" bgcolor='ffffff' cellspacing="0" vspace="15" hspace="0" border="0" align = "center">
<xsl:variable name="NATIVE"><xsl:value-of select="$configLabels[@name='MLHeader4']/@configLabel"/></xsl:variable>
<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rownative" name="rownative">
	<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
	<td onclick="Toggle('native','all');" colspan = "5" NOWRAP="true" class="LabelFont">
	     <A HREF="javascript:Toggle('native','all');"><IMG onclick="Toggle('native','all');" SRC="../reports/images/minus.gif" ID="nativegif"
	      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$NATIVE"/>
	     </label>
	</td>
	</tr>

<TR ID='rownative' name='rownative'>

		<TD nowrap="true" align="left" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='Available_BackendID']/@configLabel"/></TD>
		<TD style="width:22%">
			<xsl:call-template name="Assigned_BackendID"/>
		</TD>
		<TD style='padding-top=10px' class="AddRemove" width="5%" align="center">
			<xsl:value-of select="$configLabels[@name='ADD']/@configLabel"/><br/>
			<input class='sbttn' Type='button' value='&gt;&gt;'
			onclick="selfield(Assigned_BackendID,Available_BackendID, false)"/><BR/>
			<xsl:value-of select="$configLabels[@name='REMOVE']/@configLabel"/><br/>
			<input class='sbttn' Type='button' value='&lt;&lt;'
			onclick="selfield(Available_BackendID, Assigned_BackendID, true)"/>
			</TD>
		<TD  nowrap="true" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='Assigned_BackendID']/@configLabel"/></TD>
		<TD>
			<xsl:call-template name="Available_BackendID"/>
		</TD>

	</TR>

</table>-->
<!-- Tracker ID 113276 - Hiding Backend ID details from UI - End -->

	 <!-- Shanmuga NRE changes - start -->
	<table width="100%" bgcolor='ffffff' align="center" cellspacing="0" vspace="0" hspace="0" border="0">
 <!-- commented for IDENTIFICATION DOCUMENT CHANGES start
	<xsl:call-template name="Begin"/>
		<xsl:call-template name="apply">
			<xsl:with-param name="apply_head">
			<b><xsl:value-of select="$configLabels[@name='MLHeader1']/@configLabel"/></b><br/>
			</xsl:with-param>
			</xsl:call-template>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.MiscellaneousInfo.Type"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText1"/>
		<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText2A"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
		<xsl:call-template name="DemographicBO.MiscellaneousInfo.dtDate1"/>
		<xsl:call-template name="DemographicBO.MiscellaneousInfo.dtDate2"/>
	<xsl:call-template name="End"/>
	commented for IDENTIFICATION DOCUMENT CHANGES end-->
<!--IDENTIFICATION DOCUMENT CHANGES starts-->
</table>
<table width="100%" bgcolor='ffffff' cellspacing="0" vspace="0" hspace="0" border="0">

	<xsl:call-template name="apply">
					<xsl:with-param name="apply_head">
					<b><xsl:value-of select="$configLabels_3[@name='Identification Details']/@configLabel"/></b><br/>
					</xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="Begin"/>
	<td colspan="4">
	<table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
	<!-- Tracker ID 92380 -->
		<tr align="left">
			<td>
		<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_name">AddIdentificationDetails</xsl:with-param>
		<xsl:with-param name="button_text"><xsl:value-of select="$configLabelsID[@name='Add Identification Details']/@configLabel"/></xsl:with-param>
		  <!--tracker id 113227 starts-->
		<xsl:with-param name="button_fnc">addIdentdetails(dualflag)</xsl:with-param>
		  <!--tracker id 113227 ends-->
		</xsl:call-template>&#160;

		<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_name">RemoveIdentificationDetails</xsl:with-param>
		<xsl:with-param name="button_text"><xsl:value-of select="$configLabelsID[@name='Remove Identification Details']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="button_fnc">removeIDdetails()</xsl:with-param>
		</xsl:call-template>&#160;
		</td>
	</tr>
	</table>
	</td>
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/><td colspan="4">
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
	<xsl:with-param name="PrefixVal">2</xsl:with-param>
	</xsl:call-template>
	</td>
	<xsl:call-template name="End"/>


</table>

<table width="100%" bgcolor='ffffff' align="center" cellspacing="0" vspace="20" hspace="0" border="0">
<tr></tr>
<tr>
	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head">
<!-- TRACKERID 97779 : START -->
	 		  <b><xsl:value-of select="$configLabels[@name='CURRENCY_DETAILS']/@configLabel"/></b>
<!-- TRACKERID 97779: End -->
		</xsl:with-param>
		</xsl:call-template>
        </tr>


      <td colspan="4">
      	<table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
      	<!-- Tracker ID 92380 -->
      		<tr align="left">
      			<td>
      		<xsl:call-template name="user_button_withText">
      		<xsl:with-param name="button_name">ADD_CURRENCY</xsl:with-param>
      		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_12[@name='ADD_CURRENCYDET']/@configLabel"/></xsl:with-param>
      		<xsl:with-param name="button_fnc">addCurrencyDet()</xsl:with-param>
      		</xsl:call-template>&#160;

      		<xsl:call-template name="user_button_withText">
      		<xsl:with-param name="button_name">REMOVE_CURRENCY</xsl:with-param>
      		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_12[@name='REMOVE_CURRENCYDET']/@configLabel"/></xsl:with-param>
      		<xsl:with-param name="button_fnc">removeCurrencyDet()</xsl:with-param>
      		</xsl:call-template>&#160;
      		</td>
      	</tr>
      	</table>
	</td>



	<xsl:call-template name="Begin"/><td colspan="4">
	<xsl:call-template name="mainbody">
	<xsl:with-param name="tablename">CurrencyDetRecordSet</xsl:with-param>
	<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_12[@name='CURRENCYDET']/@configLabel"/></xsl:with-param>
	<xsl:with-param name="align">center</xsl:with-param>
	<xsl:with-param name="button">true</xsl:with-param>
	<xsl:with-param name="width">100%</xsl:with-param>
	<xsl:with-param name="name">...</xsl:with-param>
	<xsl:with-param name="UsrDataSpace">CurrencyDetInfo</xsl:with-param>
	<xsl:with-param name="rowhighlight">true</xsl:with-param>
	<xsl:with-param name="rsfilenm" select="$fileName4"/>
	<xsl:with-param name="jscriptfnc">,callCurrencyDet()</xsl:with-param>
	<xsl:with-param name="extra_colheader">Select</xsl:with-param>
	<xsl:with-param name="onClick">editCurrencyDet()</xsl:with-param>
	<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
	<xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
	<xsl:with-param name="PrefixVal">2</xsl:with-param>
	</xsl:call-template>
	</td>
	<xsl:call-template name="End"/>



</table>
 <table width="100%" bgcolor='ffffff' cellspacing="0" vspace="0" hspace="0" border="0">
<!--IDENTIFICATION DOCUMENT CHANGES ends-->
	 <!-- Shanmuga NRE changes - End -->


<!-- Tracker ID 113276 - CIF Usability Changes : Begin-->
<!-- Primary Intoducer section moved here -->
<xsl:variable name="PRIMINTRO"><xsl:value-of select="$configLabels[@name='MLHeader']/@configLabel"/></xsl:variable>
	<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="primnative" name="primnative">
	<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
	<td onclick="Toggle('primintro','all');" colspan = "5" NOWRAP="true" class="LabelFont">
	     <!-- changes for SPE tickets 10.2.12 starts -->
	     <A HREF="javascript:Toggle('primintro','all');"><IMG onclick="Toggle('primintro','all');" SRC="../Renderer/reports/images/minus.gif" ID="primintrogif"
	      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	     <!-- changes for SPE tickets 10.2.12 ends -->
	     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$PRIMINTRO"/>
	     </label>
	</td>
	</tr>

<DIV ID = 'primintro' STYLE= 'visibility:visible;'>
<TR ID='rowprimintro' name='rowprimintro'>
</TR>
<TR ID='rowprimintro' name='rowprimintro'>
<xsl:call-template name="RelationshipBO.ChildEntityType">
        	   <xsl:with-param name="ele_name">RelationshipBO.ChildEntityType</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="RelationshipBO.Bank_Entity1">
			   <xsl:with-param name="ele_name">RelationshipBO.Bank_Entity1</xsl:with-param>
	</xsl:call-template>

</TR>
<TR ID='rowprimintro' name='rowprimintro'>
<xsl:call-template name="RelationshipBO.Bank_Entity_Name1">
        	   <xsl:with-param name="ele_name">RelationshipBO.Bank_Entity_Name1</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="AccountBO.Introd_Status">
			   <xsl:with-param name="ele_name">AccountBO.Introd_Status</xsl:with-param>
	</xsl:call-template>
	<!--<xsl:call-template name="Begin"/>
	    <xsl:call-template name="RelationshipBO.Bank_Entity_Name1"/>
	    <xsl:call-template name="AccountBO.Introd_Status"/>
	<xsl:call-template name="End"/>
	-->
</TR>
<TR ID='rowprimintro' name='rowprim_ntro'>
<xsl:call-template name="AccountBO.IntroducerSalutation">
        	   <xsl:with-param name="ele_name">AccountBO.IntroducerSalutation</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="AccountBO.IntroducerID">
			   <xsl:with-param name="ele_name">AccountBO.IntroducerID</xsl:with-param>
	</xsl:call-template>
	<!--<xsl:call-template name="Begin"/>
	    <xsl:call-template name="AccountBO.IntroducerSalutation"/>
	    <xsl:call-template name="AccountBO.IntroducerID"/>
	<xsl:call-template name="End"/>
	-->
</TR>
<TR ID='rowprimintro' name='rowprimintro'>
<xsl:call-template name="AccountBO.IntroducerName">
        	   <xsl:with-param name="ele_name">AccountBO.IntroducerName</xsl:with-param>
	</xsl:call-template>

	<!--Equity bank adding new field for non cif introducer name TOI 360106-->
	
	<!--<xsl:call-template name="Begin"/>
		    <xsl:call-template name="AccountBO.IntroducerName"/>
			<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="End"/>-->
	
	<xsl:call-template name="AccountBO.StrUserField21">
	        	   <xsl:with-param name="ele_name">AccountBO.StrUserField21</xsl:with-param>
	</xsl:call-template>
	<!--Equity bank adding new field for non cif introducer name TOI 360106-->
</TR>
 <!--Equity bank adding new field for non cif introducer name TOI 356581-->

<TR ID='rowprimintro' name='rowprim_ntro'>
<xsl:call-template name="AccountBO.StrUserField22">
        	   <xsl:with-param name="ele_name">AccountBO.StrUserField22</xsl:with-param>
	</xsl:call-template>
	
</TR>

 <!--Equity bank adding new field for non cif introducer name TOI 356581-->
</DIV>


<xsl:call-template name="apply">
	 		 <xsl:with-param name="apply_head">
	 		  <b><xsl:value-of select="$configLabels[@name='AccessControl']/@configLabel"/></b>
	 		  </xsl:with-param>
	 	</xsl:call-template>

	 	<xsl:call-template name="Begin"/>
	 		<xsl:call-template name="AccountBO.accessOwnerGroup"/>
	 		<xsl:call-template name="AccountBO.accessOwnerSegment"/>
	 	<xsl:call-template name="End"/>

	 	<xsl:call-template name="Begin"/>
	 	        <xsl:call-template name="AccountBO.accessOwnerBC"/>
	 		<!--<xsl:call-template name="addemptycell"/>-->
	 	<xsl:call-template name="End"/>


<!-- Tracker ID 113276 - CIF Usability Changes : Begin-->



<!-- TRACKER ID 113276 MATP BUG CHANGES START :- CIF Retail -> New Entity ->
Customer QDE Access Control details is coming at the last. It should be above Details in alternate language -->


<!-- TrackerID: 113227  Begin of Changes-->
<table width="100%" bgcolor='ffffff' cellspacing="0"  vspace="20" hspace="0" border="0" align = "center">
  <xsl:choose>
	<xsl:when test="normalize-space($altLocaleActv)='true'">


		<xsl:variable name="DUAL"><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>

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

	<DIV ID = 'native' STYLE= 'visibility:visible;'>
		<TR ID='rowdual' name='rowdual'>
			<xsl:call-template name="AccountBO.Cust_First_Name_alt1">
			</xsl:call-template>
			<td></td>
	 <!-- Fix for Tracker ID 119588 -->
			<xsl:call-template name="AccountBO.Cust_Middle_Name_alt1">
			</xsl:call-template>
		</TR>
		<TR ID='rowdual' name='rowdual'>
			<xsl:call-template name="AccountBO.Cust_Last_Name_alt1">
			</xsl:call-template>

			<td></td>
	<!-- Fix for Tracker ID 119588 changes end -->
			<xsl:call-template name="AccountBO.short_name_alt1">
			</xsl:call-template>
		</TR>
		<TR ID='rowdual' name='rowdual'>
		<!-- Commented Out. Fix for Tracker ID 119588
			<xsl:call-template name="AccountBO.PreferredName_alt1">
			</xsl:call-template>
			<td></td>
		Fix for Tracker ID 119588 changes end -->
			<xsl:call-template name="AccountBO.Name_alt1">
			<xsl:with-param name="ele_name">AccountBO.Name_alt1</xsl:with-param>
			</xsl:call-template>

			<!-- Tracker 122228 Changes start-->
			<td></td>
			<!-- Change for ticket 339439 start -->
			<!--<xsl:call-template name="AccountBO.IntroducerName_alt1">
			        	   <xsl:with-param name="ele_name">AccountBO.IntroducerName_alt1</xsl:with-param>
				</xsl:call-template>-->
				    <!-- Change for ticket 339439 end -->
				<!--<xsl:call-template name="Begin"/>-->
				    <!--<xsl:call-template name="AccountBO.IntroducerName_alt1"/>-->
					<!--<xsl:call-template name="addemptycell"/>-->
				<!--<xsl:call-template name="End"/>-->
				<!-- Tracker 122228 Changes end-->


		</TR>
	</DIV>
		 </xsl:when>

  </xsl:choose>
<tr></tr>

</table>
<!-- TrackerID: 113227  End of Changes-->
<!-- TRACKER ID 113276 MATP BUG CHANGES END :- CIF Retail -> New Entity ->
Customer QDE Access Control details is coming at the last. It should be above Details in alternate language -->







</table>
<!-- changes by rozy for currency : End -->


<!--CIF Changes - BackEnd Changes Begins
<table width="100%" bgcolor='ffffff' cellspacing="0" vspace="0" hspace="0" border="0" >
	<xsl:call-template name="apply">
		 <xsl:with-param name="apply_head">
		  <b><xsl:value-of select="$configLabels[@name='MLHeader4']/@configLabel"/></b>
		  </xsl:with-param>
	</xsl:call-template>
	<TR >
		<td></td>
		<TD width="30%" nowrap="true" align="center" class="textOnly"><xsl:value-of select="$configLabels[@name='Available_BackendID']/@configLabel"/></TD>
		<TD align='center' width="20%"></TD>
		<TD width="30%" nowrap="true" align="center" class="textOnly"><xsl:value-of select="$configLabels[@name='Assigned_BackendID']/@configLabel"/></TD>
		<td></td>
	</TR>
	<tr >
		<td></td>
		<TD rowSpan='4' align='center' class="d3">
			<xsl:call-template name="Assigned_BackendID"/>
		</TD>
		<TD>
			<TABLE align="center" >
				<TR>
				<TD class="AddRemove" align='center'>Add</TD>
				</TR>
				<TR>
				<TD align='center'>
				<input class='frmBttns' Type='button' value=' &gt; '
				onclick="selfield(Assigned_BackendID,Available_BackendID, false)"/>
				</TD>
				</TR>
				<TR>
				<TD class='AddRemove' align='center'>Remove</TD>
				</TR>
				<TR>
				<TD align='center'>
				<input class='frmBttns' Type='button' value=' &lt; '
				onclick="selfield(Available_BackendID, Assigned_BackendID, true)"/>
				</TD>
				</TR>
			</TABLE>
		</TD>
		<TD rowSpan='4' align='center' class="d3">
			<xsl:call-template name="Available_BackendID"/>
		</TD>
		<td></td>
   	</tr>
</table> -->

<table width="100%" bgcolor='ffffff' align="center" cellspacing="0" vspace="0" hspace="0" border="0">


       	<!-- <xsl:call-template name="Begin"/>
	 <xsl:call-template name="PsychographicBO.MiscellaneousInfo.strText10"/>
	 <xsl:call-template name="PsychographicBO.MiscellaneousInfo.dbFloat1"/>
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
	 <xsl:call-template name="PsychographicBO.MiscellaneousInfo.dbFloat3"/>
	 <xsl:call-template name="PsychographicBO.MiscellaneousInfo.dbFloat2"/>
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
	 <xsl:call-template name="PsychographicBO.MiscellaneousInfo.dbFloat4"/>
	<xsl:call-template name="End"/>-->

  </table>
 <!-- changes by rozy for currency : Begin -->

<!--Access Control Changes-->
	 	<table width="100%" bgcolor='ffffff' cellspacing="0" vspace="0" hspace="0" border="0">


	 	</table>
	 <!--End of Chnages-->
	<xsl:call-template name="EndTabPage"/>

	<!-- Rachit CIF PhoneEmail changes: Start -->

	<xsl:call-template name="BeginTabPage">
		<xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
			    <xsl:with-param name="tabPageName">tpageCont1</xsl:with-param>
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
		<xsl:with-param name="isInnerToInnerTab" select="'N'"/>
<!-- CRM11.0:TRACKER:113058:BEGINOFCHANGES -->
	        <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
<!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->
	</xsl:call-template>

<tr ><td>
		<table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
		<!-- Tracker ID 92380 -->
        		<tr align="left">
        			<td>
	      	<xsl:call-template name="AccountBO.Address.preferredAddress"/>
	</td>
	<!-- Tracker ID 92380 -->
	<td align="left">
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
				<xsl:with-param name="button_fnc">createSwiftAddress()</xsl:with-param>

	    				</xsl:call-template>&#160;
				</td>
			</tr>
		</table>

		<xsl:call-template name="mainbody">
		<xsl:with-param name="tablename">RecordSet</xsl:with-param>
		<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='ADDRESS']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="align">center</xsl:with-param>
		<xsl:with-param name="button">true</xsl:with-param>
		<xsl:with-param name="width">100%</xsl:with-param>
		<xsl:with-param name="name">...</xsl:with-param>
    <xsl:with-param name="UsrDataSpace">Address</xsl:with-param>
		<xsl:with-param name="rowhighlight">true</xsl:with-param>
		    <xsl:with-param name="rsfilenm" select="$fileName1"/>
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
		    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
                </xsl:call-template>



	      	<xsl:call-template name="AccountBO.PhoneEmail.PhoneEmailType"/>
	      	<xsl:call-template name="AccountBO.PhoneEmail.PhoneEmailType1"/>

	<!-- Tracker ID 92380 -->

<table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
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
    <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='PHONELISTING']/@configLabel"/></xsl:with-param>
    <xsl:with-param name="align">center</xsl:with-param>
    <xsl:with-param name="button">true</xsl:with-param>
    <xsl:with-param name="width">100%</xsl:with-param>
    <xsl:with-param name="name">...</xsl:with-param>
    <xsl:with-param name="UsrDataSpace">Phone</xsl:with-param>
    <xsl:with-param name="rowhighlight">true</xsl:with-param>
          <xsl:with-param name="rsfilenm" select="$filePhoneEmail"/>
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
<!-- Rachit CIF PhoneEmail changes: End -->
<xsl:call-template name="EndTabPage"/>
	<!-- House hold CIF changes : Begin -->
	<!-- Tracker # 114614 : Begin -->
	<xsl:call-template name="BeginTabView">
		    <xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
		    <xsl:with-param name="tabPageHeight">295</xsl:with-param>
	</xsl:call-template>
	<!-- Tracker # 114614 : end -->
					<xsl:call-template name="BeginTabPage">
						<xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
						<xsl:with-param name="tabPageName">tpageHouseHold</xsl:with-param>
						<xsl:with-param name="spanWidth">3</xsl:with-param>
						<xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
						<xsl:with-param name="tabPageDisplayNameRes">HouseHold</xsl:with-param>
				<!-- CRM11.0:TRACKER:113058:BEGINOFCHANGES -->
						<xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
						<xsl:with-param name="isInnerToInnerTab" select="'Y'"/>
				<!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->
				</xsl:call-template>
				<tr><td>
				<table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
				<!-- Tracker ID 92380 -->
				<tr align="left">
				<td >
				<xsl:call-template name="user_button_withText">
					<xsl:with-param name="button_name">Create New HouseHold</xsl:with-param>
					<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Create New HouseHold']/@configLabel"/></xsl:with-param>
					<xsl:with-param name="button_fnc">createHouseHold()</xsl:with-param>
			   </xsl:call-template>&#160;

				<xsl:call-template name="user_button_withText">
					<xsl:with-param name="button_name">Link HouseHold</xsl:with-param>
					<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Link HouseHold']/@configLabel"/></xsl:with-param>
					<xsl:with-param name="button_fnc">HouseHoldLookup()</xsl:with-param>
			   </xsl:call-template>&#160;

			   <xsl:call-template name="user_button_withText">
			   		<xsl:with-param name="button_name">Unlink HouseHold</xsl:with-param>
			   		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Unlink HouseHold']/@configLabel"/></xsl:with-param>
			   		<xsl:with-param name="button_fnc">unlinkHouseHold()</xsl:with-param>
			   </xsl:call-template>&#160;

				</td>
				</tr>
				<tr>

				<td>
			<xsl:call-template name="mainbody">
			<xsl:with-param name="tablename">RowRecordSet</xsl:with-param>
			<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='MLHeader2']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="align">center</xsl:with-param>
			<xsl:with-param name="button">false</xsl:with-param>
			<xsl:with-param name="width">100%</xsl:with-param>
			<xsl:with-param name="name">...</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">HouseHold</xsl:with-param>
			<xsl:with-param name="rowhighlight">true</xsl:with-param>
			<!-- LastEdited Page change-->
			<xsl:with-param name="rsfilenm" select="$fileNameHousehold"/>
			<!-- LastEdited Page change-->
			<xsl:with-param name="jscriptfnc">,call()</xsl:with-param>
			<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
			<xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
			<xsl:with-param name="PrefixVal">2</xsl:with-param>
			</xsl:call-template>

				</td>
				</tr>
		</table>
		</td></tr>
	<xsl:call-template name="EndTabPage"/>

<!-- House hold CIF changes-->

<!-- House hold CIF changes-->
      <!--      <xsl:call-template name="EndTabView">
                           <xsl:with-param name="tabViewName">tabContactDetails</xsl:with-param>
                           <xsl:with-param name="selectedTabPageName">tpageAddr</xsl:with-param>
       </xsl:call-template> -->

<!-- Rachit CIF PhoneEmail changes: End -->

<!--<xsl:call-template name="EndTabPage"/>-->

<!-- CRM101UB changes : start -->
<xsl:call-template name="BeginTabView">
	    <xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
	    <xsl:with-param name="tabPageHeight">295</xsl:with-param>
	</xsl:call-template>
			<xsl:call-template name="BeginTabPage">
					<xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
					<xsl:with-param name="tabPageName">tpageGroups</xsl:with-param>
					<xsl:with-param name="spanWidth">3</xsl:with-param>
					<xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
					<xsl:with-param name="tabPageDisplayNameRes">Group Details</xsl:with-param>
			<!-- CRM11.0:TRACKER:113058:BEGINOFCHANGES -->
					<xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
			 <!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->
			</xsl:call-template>
			<xsl:call-template name="apply">
		     <xsl:with-param name="apply_head">
		     <b><xsl:value-of select="$configLabels_1[@name='Related Companies']/@configLabel"/></b>
		     </xsl:with-param>
			</xsl:call-template>
			<tr><td>

<!-- 10.2.14 enhancements  starts -->
			<xsl:if test="$allowMulti='Y'">
			<table align="center" bgcolor="ffffff" cellpadding="2" condition="$allowMulti='Y'" endlogic="if" logic="if" width="100%">
			<tr align="left">
			<td >
			<!-- 10.6 enhancements   
			   <xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">Create New Group</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Create New Group']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">createNewGroup()</xsl:with-param>
		   </xsl:call-template>&#160;-->

			<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">Link Group</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Link Group']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">GroupLookup()</xsl:with-param>
		   </xsl:call-template>&#160;

		   <xsl:call-template name="user_button_withText">
		   		<xsl:with-param name="button_name">Unlink Group</xsl:with-param>
		   		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Unlink Group']/@configLabel"/></xsl:with-param>
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
	</table>
			</xsl:if>
	<xsl:if test="$allowMulti='N'">
		<xsl:call-template name="AccountBO.GroupHouseHold.GROUP_ID" />
	</xsl:if>
	<!-- 10.2.14 enhancements  ends -->
	</td></tr>
<xsl:call-template name="EndTabPage"/>

<!-- CRM101UB changes : end -->

	<!--Start Of changes Minor-->
	 <xsl:call-template name="BeginTabPage">
				    <xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
				    <xsl:with-param name="tabPageName">tpageCont2</xsl:with-param>
				    <xsl:with-param name="spanWidth">3</xsl:with-param>
				    <xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
				    <xsl:with-param name="tabPageDisplayNameRes">Minor</xsl:with-param>
			<!-- CRM11.0:TRACKER:113058:BEGINOFCHANGES -->
				    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
			 <!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->
		                </xsl:call-template>
		        	<xsl:call-template name="apply">
				     <xsl:with-param name="apply_head">
				     <b><xsl:value-of select="$configLabels[@name='MLHeader3']/@configLabel"/></b><br/>
				     </xsl:with-param>
				</xsl:call-template>


		                <xsl:call-template name="Begin"/>
				    <xsl:call-template name="RelationshipBO.Bank_Entity"/>
				    <xsl:call-template name="ContactBO.contactsKey"/>
				<!--    <xsl:call-template name="RelationshipBO.Bank_Entity_Name"/> -->
				<xsl:call-template name="End"/>

	 			<xsl:call-template name="Begin"/>
				    <xsl:call-template name="RelationshipBO.Relationship"/>
				    <xsl:call-template name="ContactBO.salutation"/>
				<xsl:call-template name="End"/>

		                <xsl:call-template name="Begin"/>
				    <xsl:call-template name="ContactBO.firstName"/>
				    <xsl:call-template name="ContactBO.lastName"/>
				<xsl:call-template name="End"/>


		                <xsl:call-template name="Begin"/>
				    <xsl:call-template name="ContactBO.middleName"/>
				    <xsl:call-template name="ContactBO.gender"/>
				<xsl:call-template name="End"/>

		                <xsl:call-template name="Begin"/>
				    <xsl:call-template name="ContactBO.DOB"/>
				    <xsl:call-template name="RelationshipBO.Guard_Code"/>
				<xsl:call-template name="End"/>

		                <xsl:call-template name="Begin"/>

				<xsl:call-template name="End"/>

<!--Native Language Changes:start-->
</table>
<xsl:variable name="NMINOR"><xsl:value-of select="$configLabels[@name='NativeLanguageFields']/@configLabel"/></xsl:variable>
<table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
	<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="row{$NMINOR}" name="row{$NMINOR}">
	<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
	<td onclick="Toggle_Address('nminor');" colspan = "2" NOWRAP="true" class="LabelFont">
	     <!-- changes for SPE tickets 10.2.12 starts -->
	     <A HREF="javascript:Toggle_Address('nminor');"><IMG onclick="Toggle_Address('nminor');" SRC="../Renderer/reports/images/minus.gif" ID="nminorgif"
	      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	     <!-- changes for SPE tickets 10.2.12 ends -->
	     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$NMINOR"/>
	     </label>
	</td>
	</tr>
</table>
<DIV ID = 'nminor' STYLE= 'visibility:visible;'>

 <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

	<TR ID='rowminor' name='rowminor'>
		<xsl:call-template name="ContactBO.Contact_Last_Name_Native">
			   <xsl:with-param name="ele_name">ContactBO.Contact_Last_Name_Native</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ContactBO.Contact_Middle_Name_Native">
			   <xsl:with-param name="ele_name">ContactBO.Contact_Middle_Name_Native</xsl:with-param>
		</xsl:call-template>
	</TR>
	<TR ID='rowminor' name='rowminor'>
		<xsl:call-template name="ContactBO.Contact_First_Name_Native">
			   <xsl:with-param name="ele_name">ContactBO.Contact_First_Name_Native</xsl:with-param>
		</xsl:call-template>
	</TR>

 </table>
</DIV>
<!--Native Language Changes:end-->
<!--
<table width="100%" bgcolor='ffffff' cellspacing="0" vspace="0" hspace="0" border="0">
	<xsl:call-template name="Begin"/>
		<xsl:call-template name="addemptycell"/>
		<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="End"/>

	<xsl:call-template name="apply">
		 <xsl:with-param name="apply_head">
		  <b><xsl:value-of select="$configLabels[@name='AccessControl']/@configLabel"/></b>
		  </xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="Begin"/>
		<xsl:call-template name="addemptycell"/>
		<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
		<xsl:call-template name="AccountBO.accessOwnerGroup"/>
		<xsl:call-template name="AccountBO.accessOwnerSegment"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
		<xsl:call-template name="AccountBO.accessOwnerBC"/>
		<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>

	<xsl:call-template name="End"/>

</table>

-->

<!-- TrackerID: 113227  Begin-->

<!-- Tracker 121396 Changes Start-->
<xsl:choose>
<xsl:when test="normalize-space($altLocaleActv)='true'">
<!-- Tracker 121396 Changes End-->
<xsl:variable name="NMINOR1"><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>
<table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
	<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="row{$NMINOR1}" name="row{$NMINOR1}">
	<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
	<td onclick="Toggle_Address('nminor1');" colspan = "2" NOWRAP="true" class="LabelFont">
	     <!-- changes for SPE tickets 10.2.12 starts -->
	     <A HREF="javascript:Toggle_Address('nminor1');"><IMG onclick="Toggle_Address('nminor1');" SRC="../Renderer/reports/images/minus.gif" ID="nminor1gif"
	      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	     <!-- changes for SPE tickets 10.2.12 ends -->
	     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$NMINOR1"/>
	     </label>
	</td>
	</tr>
</table>
<DIV ID = 'nminor1' STYLE= 'visibility:visible;'>

 <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

	<TR ID='rowdual' name='rowdual'>
			<xsl:call-template name="ContactBO.firstName_alt1">
			<xsl:with-param name="ele_name">ContactBO.firstName_alt1</xsl:with-param>
	</xsl:call-template>
			<xsl:call-template name="ContactBO.middleName_alt1">
			<xsl:with-param name="ele_name">ContactBO.middleName_alt1</xsl:with-param>
		</xsl:call-template>
		</TR>
		<TR ID='rowdual' name='rowdual'>
			<xsl:call-template name="ContactBO.lastName_alt1">
			<xsl:with-param name="ele_name">ContactBO.lastName_alt1</xsl:with-param>
		</xsl:call-template>
		  <!-- TrackerID: 119723 Changes  Start  -->
			<!--<xsl:call-template name="RelationshipBO.Relationship_alt1">
			<xsl:with-param name="ele_name">RelationshipBO.Relationship_alt1</xsl:with-param>
		</xsl:call-template>  -->
		  <!-- TrackerID: 119723 Changes  End  -->
	</TR>

</table>
</DIV>
<!-- Tracker 121396 Changes Start-->
</xsl:when>
</xsl:choose>
<!-- Tracker 121396 Changes End-->
<!-- TrackerID: 113227  End-->
	                <xsl:call-template name="EndTabPage"/>

	<!--End Of changes Minor-->

	  <xsl:call-template name="EndTabView">
		                    <xsl:with-param name="tabViewName">tabEntityFieldDetails</xsl:with-param>
		                    <xsl:with-param name="selectedTabPageName">tpageCustDetails</xsl:with-param>
         </xsl:call-template>
	</form>
	<p id="myPar"></p>
<!-- CRM101UB group changes start -->
    <form name="frm3"  method="post" action='../servlet/com.infy.cis.ui.admin.GroupHouseHoldForm?isPopup=Yes&amp;isLinked=Yes&amp;isEdit=Yes&amp;GroupHouseHoldFlag=G&amp;isNew=N&amp;details=null'>
		<input type="hidden" name="GroupName" value=""/>
	    	<input type="hidden" name="PercentShare" value=""/>
		<input type="hidden" name="GlobalRM" value=""/>
		<!-- Recon from CRM10301BSUPP-Listing changes-->
		<input type="hidden" name="SubScreen" value="CustomerQDE"/>
		<!-- Recon from CRM10301BSUPP-Listing changes-->		
		<input type="hidden" name="Name_Nat" value=""/>
		<input type="hidden" name="Group_ID" value=""/>
		<input type="hidden" name="Prim_Grp_ID" value=""/>
		<input type="hidden" name="readMode" value="{$readMode}"/>
	</form>
	<!--  changes for tracker id 336884 starts -->
	
			<form name="frmIdent" method="post">	<input name="dateofissue" type="hidden" value="">
				</input>	<input name="validity_date" type="hidden" value="">
				</input>	<input name="hidDocCode" type="hidden" value="">
				</input>	<input name="hidDocDescr" type="hidden" value="">
				</input>	<input name="hidDocTypeCode" type="hidden" value="">
				</input>	<input name="hidDocTypeDescr" type="hidden" value="">
				</input>	<input name="hidDocReceivedDate" type="hidden" value="">
				</input>	<input name="hidDocRemarks" type="hidden" value="">
				</input>	<input name="hidStatus" type="hidden" value="">
				</input>	<input name="hidIsMandatory" type="hidden" value="">
				</input>	<input name="hidScanRequired" type="hidden" value="">
				</input>	<input name="placeofissue" type="hidden" value="">
				</input>	<input name="placeofissue_cat" type="hidden" value="">
				</input>	<input name="countryofissue" type="hidden" value="">
				</input>	<input name="countryofissue_cat" type="hidden" value="">
				</input>	<input name="hidIsDocumentVerified" type="hidden" value="">
				</input>	<input name="hidIDIssuedOrg" type="hidden" value="">
				</input>	<input name="hidEntityDocumentID" type="hidden" value="">
				</input>	<input name="unique_id" type="hidden" value="">
				</input>	<input name="identifier_type_Code" type="hidden" value="">
				</input>	<input name="getMCRequired" type="hidden" value="{$getMCRequired}">
				</input>	<!-- <input name="SavedSubmitted" type="hidden" value="{$SavedSubmitted}"></input> -->
			</form>	
   <!--  changes for tracker id 336884 ends -->
<!-- CRM101UB group changes end -->
</xsl:template>
<xsl:template match="SRM">
	<xsl:for-each select=".">
		<xsl:call-template name="startTable"/>
			<table border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
			<tr>
			<!-- TRACKER# 92380 START-->
			<!--<xsl:call-template name="apply">
				<xsl:with-param name="apply_head">
				<b><xsl:call-template name="ApplHeader"/></b>
				</xsl:with-param>
			</xsl:call-template>-->
			<!-- TRACKER# 92380 END-->
			</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<xsl:apply-templates select="." mode="mode1"/>
			</table>
             	<xsl:call-template name="endTable"/>
       		</xsl:for-each>
</xsl:template>
</xsl:stylesheet>