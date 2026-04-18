<?xml version="1.0"?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <!--impoting variables wich hold the jvm properties-->
     <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
     <!--Changes for the js error in the customer screen Tracker: 159776-->
     <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
     <xsl:import href="../Renderer/common/display/CommonEntityDetails.xsl"/>
     <!--including file for label names-->
        <xsl:param name="locale"/>
 	<!--tracker id 113227 starts-->
	 <xsl:param name="altLocaleActv"/>
	 <xsl:param name="altLocaleType"/>
	<xsl:param name="baseLocaleType"/>
        <!--tracker id 113227 ends-->
	<xsl:param name="fileName2"/>


	<!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
	<!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
	<xsl:param name="ALTCALENDAR_TYPE"/>
	<!--ERPBOCF1:TRACKER113259: STORAGE OF DATES :ENDOFCHANGES-->

	<xsl:variable name="fileName" select="$fileName2"/>

	<xsl:param name="fileName3"/>
	<xsl:variable name="filePhoneEmail" select="$fileName3"/>

	<!--IDENTIFICATION DOCUMENT CHANGES TRACKER ID 321176 start-->
			<xsl:param name="fileNameID"/>
			<xsl:variable name="configFileID" select="document(concat($fileNameID,''))"/>
			<xsl:variable name="configLabelsID" select="$configFileID/SRMBO/*"/>
			<xsl:variable name="file9">../Renderer/common/resource/TabMessage_<xsl:value-of select="$locale"/>.xml</xsl:variable>
			<xsl:variable name="configFile_9" select="document(concat($file9,''))"/>
			<xsl:variable name="configLabels_9" select="$configFile_9/SRMBO/*"/>
	<!--IDENTIFICATION DOCUMENT CHANGES TRACKER ID 321176 end-->


	<!-- CRM101UB changes :start -->
     <xsl:param name="fileName4"/>
     <xsl:variable name="fileNameGrp" select="$fileName4"/>
     <!--Changes for call id:413958 and recon of call id 411963 starts-->
     <!--Changes for call id:425507 and recon of call id 413599 starts-->
     <xsl:param name="fileName5"/>
     <xsl:variable name="fileHouseHold" select="$fileName5"/>
     <!--Changes for call id:425507 and recon of call id 413599 ends-->
     <!--Changes for call id: 413958 and recon of call id 411963 ends-->
     <!-- CRM101UB changes end -->
    <xsl:variable name="file1">../Renderer/Customization/54/cif/resource/AccountFields_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_1" select="document(concat($file1,''))"/>
    <xsl:variable name="file2">../Renderer/cif/resource/RetGeneralMinor_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_2" select="document(concat($file2,''))"/>
     <!--CoreInterface Details:start-->
    <xsl:variable name="file3">../Renderer/cif/resource/CoreInterfaceDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_3" select="document(concat($file3,''))"/>
     <!--CoreInterface Details:end-->
     <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
     <xsl:variable name="configLabelsMinor" select="$configFile_2/SRMBO/*"/>
     <!--CoreInterface Details:end-->
     <!-- CRM101UB changes start -->
     <xsl:variable name="file5">../Renderer/corpcif/resource/CorpIntroRelatedAs_<xsl:value-of select="$locale"/>.xml</xsl:variable>
     <xsl:variable name="configFile_5" select="document(concat($file5,''))"/>
     <xsl:variable name="configLabels_1" select="$configFile_5/SRMBO/*"/>
     <xsl:variable name="fileName_Introducer">../Renderer/corpcif/resource/CorpIntroRelatedAs_<xsl:value-of select="$locale"/>.xml</xsl:variable>
     <!-- CRM101UB end -->

     <xsl:variable name="configLabelsCore" select="$configFile_3/SRMBO/*"/>
     <xsl:variable name="BOName">AccountBO</xsl:variable>

<!-- TrackerId: 131246 Begin of Changes by Sonali_narula-->
<xsl:variable name="GcifIdAccess" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='GcifIdAccess']"></xsl:variable>
<xsl:variable name="MultiEntity" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MultiEntity']"></xsl:variable>
<!--10.2.14 enhancements starts -->
<xsl:variable name="allowMulti" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='allowMulti']" />
<!--10.2.14 enhancementsend -->
<!--TrackerId: 131246 Changes end -->

     <xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"></xsl:variable>
      <xsl:variable name="boNameCI" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boNameCI']"></xsl:variable>
     <!-- Fix for ticket id 624014 start-->
     <xsl:variable name="HASHKEY" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='HASHKEY']"></xsl:variable>
     <xsl:variable name="KEYFIELD" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='FLDHASHKEY']"></xsl:variable>
    <!-- Fix for ticket id 624014 end-->
<!--changes for call id 407866 and recon of call id 400498 starts-->
<!--changes for call id 414534-recon of 412591 starts-->
<xsl:variable name="salutationcode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Salutation_code']"></xsl:variable>
<xsl:variable name="Cat_salutation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_AccountBO.Salutation_code']"></xsl:variable>
<!--changes for call id 407866 and recon of call id 400498 ends-->
<!--changes for call id 414534-recon of 412591 ends-->

      <!-- TRACKER ID 321176 currency changes start -->

             <!--CIF Changes: CurrencyTab: Start-->



            	      <xsl:variable name="AccessType" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='AccessType']"/>
                      <xsl:variable name="boName3" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName3']"></xsl:variable>
                      <xsl:variable name="boName2" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName2']"></xsl:variable>
                      <xsl:variable name="CurrencyList" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CurrencyList']"></xsl:variable>
                      <xsl:variable name="CurrencyAccList" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CurrencyAccList']"></xsl:variable>


                      <xsl:variable name="file10">../Renderer/cif/resource/PsychoCurrencyTable_<xsl:value-of select="$locale"/>.xml</xsl:variable>
                      <xsl:variable name="configFile_10" select="document(concat($file10,''))"/>
                      <xsl:variable name="configLabels_12" select="$configFile_10/SRMBO/*"/>
                      <xsl:variable name="fileName_Currency">../../../cif/resource/PsychoCurrencyTable_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!-- Fix for Ticket ID 286386 Begins -->
<xsl:variable name="aRetRelValues" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='aRetRelns']"></xsl:variable>
<xsl:variable name="aAllowBlklisted" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='aBlklist']"></xsl:variable>
<xsl:variable name="aAllowNegated" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='aNegated']"></xsl:variable>
<xsl:variable name="aAllowSuspended" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='aSuspend']"></xsl:variable>
<!-- Fix for Ticket ID 286386 Ends -->

          <!--CIF Changes: CurrencyTab: End-->

      <!-- TRACKER ID 321176 currency changes end -->
	<!-- Change for ticket 341194 start -->
	<xsl:variable name="Bank_Entity1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RelationshipBO.Bank_Entity1']"></xsl:variable>
	<xsl:variable name="ChildEntityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RelationshipBO.ChildEntityType']"></xsl:variable>
	<!-- Change for ticket 341194 end -->
<!--Changes for call id call id 428461 and recon of call id 425465,400878 starts-->
	<xsl:variable name="ChildEntityId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RelationshipBO.ChildEntityId']"></xsl:variable>
<!--Changes for call id 428461 and recon of call id 425465,400878 ends-->
     <xsl:variable name="Bank_Entity" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RelationshipBO.Bank_Entity']"></xsl:variable>
	<!--Begin of changes for tracker 131243 by sneha kaul  - BANKID - -->
          <xsl:variable name="bank_id" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bank_id']"></xsl:variable>
	<!--End of changes for tracker 131243 by sneha kaul  - BANKID - -->



      <!-- TRACKER ID 122174 CHANGES BEGIN -->
      <!-- Get the values set in Custom Data For Minor Tab Templates -->
      <xsl:variable name="fName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.firstName']"></xsl:variable>
      <xsl:variable name="lName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.lastName']"></xsl:variable>
      <xsl:variable name="mName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.middleName']"></xsl:variable>
      <xsl:variable name="relation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RelationshipBO.Relationship']"></xsl:variable>
      <xsl:variable name="key" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.contactsKey']"></xsl:variable>
      <!-- TRACKER ID 122174 CHANGES END -->
      <!-- TRACKER ID 148769 CHANGES BEGIN -->
      <xsl:variable name="dob" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.DOB']"></xsl:variable>
      <xsl:variable name="gender" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.gender']"></xsl:variable>
      <xsl:variable name="salutation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ContactBO.salutation']"></xsl:variable>
      <xsl:variable name="gCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RelationshipBO.Guard_Code']"></xsl:variable>
     <!-- TRACKER ID 148769 CHANGES END -->
     <xsl:variable name="LastUpdate_Date" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='LastUpdate_Date']"></xsl:variable>
<!-- SIT Fix   -->
     <xsl:variable name="currId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='currId']"></xsl:variable>
     <xsl:variable name="currText10" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='currText10']"></xsl:variable>
     <xsl:variable name="currFlt1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='currFlt1']"></xsl:variable>
     <xsl:variable name="currFlt2" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='currFlt2']"></xsl:variable>
     <xsl:variable name="currFlt3" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='currFlt3']"></xsl:variable>
     <xsl:variable name="currFlt4" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='currFlt4']"></xsl:variable>
     <xsl:variable name="currDate" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='currDate']"></xsl:variable>
 <!-- SIT Fix   -->
     <xsl:variable name="BankEntityID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RelationshipBO.BankEntityID']"></xsl:variable>
     <xsl:variable name="mainAccId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mainAccId']"></xsl:variable>
     <xsl:variable name="allfields" select="//SRMData//Z"/>
     <xsl:variable name="accountURL" select="//SRMData//Z[@n=concat($boName,'.url_')]"></xsl:variable>
     <xsl:variable name="assignedBackEndID" select="//SRMData//Z[@n=concat($boName,'.BackEndID')]"></xsl:variable>
      <!--CoreInterface Details:start-->
      <xsl:variable name="coreURL" select="//SRMData//Z[@n=concat($boNameCI,'.url_')]"></xsl:variable>
      <!--CoreInterface Details:end-->
     <xsl:variable name="priorityCode" select="//SRMData//Z[@n=concat($boName,'.priorityCode')]"></xsl:variable>
     <xsl:variable name="concurDetectX" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n=concat($boName,'.ConcurDetect_X')]"></xsl:variable>
     <xsl:variable name="parentAccountURL" select="//SRMData[@SRMDataSpace='ContactInfo']//Z[@n='AccountBO.url_']"></xsl:variable>
     <xsl:variable name="contactURL" select="//SRMData[@SRMDataSpace='ContactInfo']//Z[@n='ContactBO.url_']"></xsl:variable>
     <xsl:variable name="isAutoGenKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isAutoGenKey']"></xsl:variable>
     <xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"></xsl:variable>
     <!--Save & submit  change:Starts-->
     <xsl:variable name="operationType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operationType']"></xsl:variable>
     <!--Save & submit  change:ends-->
     <!-- Changes for Deceased CIF Starts-->
     <xsl:variable name="creFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='creFlag']" />
      <!-- Changes for Deceased CIF Ends-->
     <!-- CRM101UB changes -->
     <!-- KeyGeneration Start -->
     <xsl:variable name="keyGeneration" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='keyGeneration']"></xsl:variable>
     <!-- KeyGeneration End -->
     <xsl:variable name="dtCurr" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtCurr']"/>
      <!-- NRE Changes shanmuga in edit mode-->
     <xsl:variable name="PassportId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PassportId']"></xsl:variable>
     <!-- Ticket id 207511 changes start -->
     <xsl:variable name="entityDocumentBO_Name" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityDocumentBO_Name']"></xsl:variable>
<!-- Ticket id 207511 changes end -->
     <xsl:variable name="PassportPlace" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PassportPlace']"></xsl:variable>
     <xsl:variable name="PassportIdate" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PassportIdate']"></xsl:variable>
     <xsl:variable name="PassportVdate" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PassportVdate']"></xsl:variable>
      <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
     <xsl:variable name="AccessOwnerGroup" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccessOwnerGroup']"></xsl:variable>
      <!-- Tracker ID : 90197 End of Changes -->
     <!-- NRE Changes shanmuga in edit mode -->
     <!--Minor Age changes: start-->
     <xsl:variable name="MINOR_YEAR" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MINOR_YEAR']"></xsl:variable>
     <!--Minor Age changes: end-->
     <!--Senior Age changes: start-->
          <xsl:variable name="SENIOR_YEAR" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='SENIOR_YEAR']"></xsl:variable>
     <!--Senior Age changes: end-->
     <!--ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI: MINOR TO MAJOR CONVERSION)-->
     <!--Calendar Type changes: start-->

     <xsl:variable name="CONV_CALENDAR_TYPE" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CONV_CALENDAR_TYPE']"></xsl:variable>

     <!--<xsl:variable name="ALTCALENDAR_TYPE" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ALTCALENDAR_TYPE']"></xsl:variable>-->

     <!--Calendar Type changes: end-->
     <!--ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI: MINOR TO MAJOR CONVERSION)-->

     <!--Access Control Changes-->
        <xsl:variable name="PrimBCID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcID']"></xsl:variable>
	<xsl:variable name="PrimBCCODE" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcCode']"></xsl:variable>
	<xsl:variable name="priGrpID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='priGrpID']"></xsl:variable>
	<xsl:variable name="priSegName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='priSegName']"></xsl:variable>
     <!--End of Changes-->
	<xsl:variable name="bcName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcName']"></xsl:variable>
	<xsl:variable name="Cat_bcName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_bcName']"></xsl:variable>
	<!--Field based maker check changes-->
	<xsl:variable name="getRole" select="/SRM/SRMData[@SRMDataSpace='RoleCode']//Z"/>
      	<xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"></xsl:variable>
      	<xsl:variable name="strCountryValue" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strCountryValue']"></xsl:variable>
      	<xsl:variable name="mcJNDIFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mcJNDIFlag']"></xsl:variable>
      	<xsl:variable name="isMCEdited" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isMCEdited']"></xsl:variable>
	<!--Field based maker check changes-->
	<!--Changes for Tracker id: 347074 starts-->
	<xsl:variable name="strSolId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.Primary_sol_id']"></xsl:variable>
	<xsl:variable name="solId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='solId']"></xsl:variable>
	<!--Changes for Tracker id: 347074 ends-->
	<!--Doc Rec changes: start-->
     <xsl:variable name="docRecvd" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='docRecvd']"></xsl:variable>
	<!--Doc Rec changes: end-->
	<!-- Tracker# 97236 CIF - EBanking Changes : Start -->
	<xsl:variable name="isSMSBanking" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isSMSBanking']"></xsl:variable>
	<xsl:variable name="isWAPBanking" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isWAPBanking']"></xsl:variable>
	<!-- Tracker# 97236 CIF - EBanking Changes : End-->
    <!-- CORE Fields Inclusion:start -->
        <xsl:variable name="purgeFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='purgeFlag']"></xsl:variable>
        <xsl:variable name="tfpartyFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='tfpartyFlag']"></xsl:variable>
     	<!-- Card_Holder Changes:Start-->
     	<xsl:variable name="card_holder" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='card_holder']"></xsl:variable>
     	<!-- Card_Holder Changes:End-->

     	<!-- TRACKER ID 113276 Changes Begin For Bug Fixing-->
     	<!-- Get the value to be populated by default in RelationshipCreatedBy lookup -->
	<xsl:variable name="rCreatedBy" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='rCreatedBy']"></xsl:variable>
     	<!-- TRACKER ID 113276 Changes End -->

<!-- added by pradeep_sathyamurthy as a part of ticket 326008 Begings-->
		<xsl:variable name="relCreat" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RelationshipCreatedBy']"></xsl:variable>
<!-- added by pradeep_sathyamurthy as a part of ticket 326008 Ends -->
<!-- Changes for KYC Enhancement Start-->

           <!--  <xsl:variable name="riskRating" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n='AccountBO.riskRating']"></xsl:variable> -->
           <!--  <xsl:variable name="KYC_ReviewDate" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n='AccountBO.KYC_ReviewDate']"></xsl:variable> -->
           <!--  <xsl:variable name="KYC_Date" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n='AccountBO.KYC_Date']"></xsl:variable> -->
           <!--  <xsl:variable name="submitForKYC" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n='AccountBO.submitForKYC']"></xsl:variable> -->

   <xsl:variable name="riskRating" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.riskRating')]"></xsl:variable>
   <xsl:variable name="KYC_ReviewDate" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.KYC_ReviewDate')]"></xsl:variable>
   <xsl:variable name="KYC_Date" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.KYC_Date')]"></xsl:variable>
   <xsl:variable name="submitForKYC" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.submitForKYC')]"></xsl:variable>

<!-- Changes for KYC Enhancement End-->
     <!--Changes for alert server recon in 10.2.14 starts-->
     <xsl:variable name="Enable_Alerts" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Enable_Alerts']"></xsl:variable>
     <xsl:variable name="DefaultChannel_Alert" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='DefaultChannel_Alert']" />
     <xsl:variable name="PreferredMobileAlert_Type" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PreferredMobileAlert_Type']" />
     <xsl:variable name="isAlert" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isAlert2']" />
     <!--Changes for alert server recon in 10.2.14 ends-->
     <!-- CORE Fields Inclusion:end -->
     <!-- CIF Changes : variable for Copy : START-->
     <xsl:variable name="isCopy" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsCopy']"></xsl:variable>
     <!-- CIF Changes : variable for Copy : END-->
     <!--CIF Changes variable for account Key:start-->
     <xsl:variable name="accKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='accKey']"></xsl:variable>
     <!--CIF Changes variable for account Key:end-->
     <xsl:variable name="flagRelType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='flagRelType']"></xsl:variable>
      <xsl:variable name="flagRelType1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='flagRelType1']"></xsl:variable>
     <xsl:variable name="ID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ID']"/>
     <!--CIF LOS Bypass change:Start-->
     <xsl:variable name="byPassFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='byPassFlag']"></xsl:variable>
     <!--CIF LOS Bypass change:End-->
     <!-- CIF PhoneEmail Changes : Start -->
     <xsl:variable name="preferredAddressType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredAddressType']"></xsl:variable>
     <xsl:variable name="preferredPhone" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredPhone']"></xsl:variable>
     <xsl:variable name="preferredEmail" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredEmail']"></xsl:variable>
     <!-- CIF PhoneEmail Changes : End -->
     <!-- Change for 374326 and 374328 start -->
     <xsl:variable name="PreferredLocale" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PreferredLocale']"></xsl:variable>
     <xsl:variable name="Cat_PreferredLocale" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_PreferredLocale']"></xsl:variable>
     <!-- Change for 374326 and 374328 end -->

     <xsl:variable name="noOfDaysIntro" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='INTRO_DATE_VALIDATE']"></xsl:variable>

	<!-- Changes for 'WFlow' POC start -->
	<xsl:variable name="IntWFID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IntWFID']"></xsl:variable>
	<!-- Changes for 'WFlow' POC end -->

	 <!-- CIF GroupHouseHold Changes Start -->
	 <xsl:variable name="globalRM" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='GlobalRM']"></xsl:variable>
	<!-- CIF GroupHouseHold Changes End -->
	 <!-- CRM101UB Group changes start  -->
	 <xsl:variable name="grpglobalRM" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='grpGlobalRM']"></xsl:variable>
	 <xsl:variable name="grpNatName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='grpNatName']"></xsl:variable>
	<!-- CRM101UB Group changes end -->
<!--sonali changes 131246-->
	<xsl:variable name="gcifID" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='gcifID']"/>

	<xsl:variable name="segmentValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='segmentValues']"/>
	<xsl:variable name="isBasel" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='isBasel']"/>
	<xsl:variable name="segmentRating" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='segmentRating']"/>
	<xsl:variable name="ratingValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='ratingValues']"/>
	<xsl:variable name="subSegmentValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='subSegmentValues']"/>
	<xsl:variable name="subSegmentCodeVal" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='subSegmentCodeVal']"/>
	<xsl:variable name="SubSegment" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.SubSegment')]"></xsl:variable>
	<!--Changes for tracker id: 333740 starts-->
<!--Changes for tracker id 338696 starts-->	
	<xsl:variable name="Segment" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.Segmentation_Class')]"></xsl:variable>
	<!--<xsl:variable name="Segment" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='Segmentation_Class']"/>-->
	<!--Changes for Tracker id: 361921 starts-->
	<xsl:variable name="Constitution_Code" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='Constitution_Code']"/>
	<!--Changes for Tracker id: 361921 ends-->
	<!--Changes for tracker id: 333740 ends-->
     	<!--Changes for tracker id 338696 ends-->
	<!--Changes for Tracker id:355038 starts-->
	<xsl:variable name="Sector" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='Sector']"/>
	<xsl:variable name="Subsector" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='Subsector']"/>

	<!--Changes for Tracker id:355038 ends-->

     <!--sonali-->
     <!--Changes for tracker id 350214 starts-->
     <xsl:variable name="Mgr" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='Mgr']"/>
     <xsl:variable name="Charge" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='Charge']"/>
     <!--Changes for tracker id 350214 ends-->
     	<xsl:variable name="ChargeLevelCode" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.ChargeLevelCode')]"></xsl:variable>
		<!-- Changes starts for TrackerID: 234910 -->
         <xsl:variable name="serviceLevelCode" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='serviceLevelCode']"/>
		<xsl:variable name="chargeCode" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='chargeCode']"/>
		<!-- Changes starts for TrackerID: 235202 -->
		<xsl:variable name="strSessionCalType" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='strSessionCalType']"/>
		<!-- Changes ends for TrackerID: 235202 -->
		<xsl:variable name="codechargeCode" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='code_chargeCode']"/>
		<!-- Changes ends for TrackerID: 234910 -->
     	<xsl:variable name="MinorAttainMajorDate" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.MinorAttainMajorDate')]"></xsl:variable>
     	<xsl:variable name="SenCitizenApplicableDate" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.SenCitizenApplicableDate')]"></xsl:variable>
      <!--commented by for CIF Changes removal of address fields
     <xsl:variable name="selectval" select="//SRMData//SRMComposite[@n='Address']/SRMRow/Z"/>
     <xsl:variable name="addressval" select="$selectval[@n='AccountBO.Address.addressCategory']"/>
-->
<!-- changes for tracker 356432 starts -->
<xsl:variable name="CustTCode" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='Custtypecode']"/>
<xsl:variable name="custTypeLang" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='Custtypelang']"/>
<xsl:variable name="CustStatCode" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='CusStatCode']"/>
<xsl:variable name="custStatLang" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='cusStatLang']"/>
<xsl:variable name="ConCode" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='CCode']"/>
<xsl:variable name="constLang" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='CLang']"/>
<!-- changes for tracker 356432 starts -->
    <!-- FCRM6201RECON Tracker# 49443, Begin of Changes -->
    <xsl:variable name="boDet" select="/SRM/SRMData[@SRMDataSpace='Main']/SRMComposite [@n=$boName]/Z"/>
    <xsl:variable name="boDetCI" select="/SRM/SRMData[@SRMDataSpace='Main']/SRMComposite [@n=$boNameCI]/Z"/>
    <xsl:variable name="phonework"   select="$boDet[@n=concat($boName,'.phone')]"/>
    <xsl:variable name="phonehome"   select="$boDet[@n=concat($boName,'.Phone_Home')]"/>
    <xsl:variable name="phonecell"   select="$boDet[@n=concat($boName,'.Phone_Cell')]"/>
    <xsl:variable name="extension"   select="$boDet[@n=concat($boName,'.extension')]"/>
    <xsl:variable name="emailwork"   select="$boDet[@n=concat($boName,'.Email')]"/>
    <xsl:variable name="emailhome"   select="$boDet[@n=concat($boName,'.Email_Home')]"/>
    <xsl:variable name="emailpalm"   select="$boDet[@n=concat($boName,'.Email_Palm')]"/>
    <xsl:variable name="fax"         select="$boDet[@n=concat($boName,'.fax')]"/>
    <xsl:variable name="ssn"         select="$boDet[@n=concat($boName,'.ssn')]"/>
    <xsl:variable name="pan"         select="$boDet[@n=concat($boName,'.PAN')]"/>
    <!-- Adhar changes for tracker 375136 starts  -->
    <xsl:variable name="UniqueIDNumber" select="$boDet[@n=concat($boName,'.UniqueIDNumber')]"/>
     <!-- Adhar changes for tracker 375136 ends  -->
    <!-- TRACKER ID: 113279 Begins -->
    <xsl:variable name="IDTypeR1"         select="$boDet[@n=concat($boName,'.IDTypeR1')]"/>
    <xsl:variable name="IDTypeR2"         select="$boDet[@n=concat($boName,'.IDTypeR2')]"/>
    <xsl:variable name="IDTypeR3"         select="$boDet[@n=concat($boName,'.IDTypeR3')]"/>
    <xsl:variable name="IDTypeR4"         select="$boDet[@n=concat($boName,'.IDTypeR4')]"/>
    <xsl:variable name="IDTypeR5"         select="$boDet[@n=concat($boName,'.IDTypeR5')]"/>
    <!-- TRACKER ID: 113279 Ends -->


    <xsl:variable name="licence"     select="$boDet[@n=concat($boName,'.LicenseNo')]"/>
    <xsl:variable name="passport"    select="$boDet[@n=concat($boName,'.PassportNo')]"/>
    <!-- Tracker 85215 Begin Of changes -->
    <xsl:variable name="Nat_id_card_num"     select="$boDet[@n=concat($boName,'.Nat_id_card_num')]"/>
    <!-- Tracker 85215 End Of changes -->
	<xsl:variable name="ppIssDate"    select="$boDet[@n=concat($boName,'.Psprt_issue_date')]"/>
	<xsl:variable name="ppExpDate"    select="$boDet[@n=concat($boName,'.Psprt_exp_date')]"/>
    <xsl:variable name="industry"    select="$boDet[@n=concat($boName,'.industry')]"/>
    <xsl:variable name="education"   select="$boDet[@n=concat($boName,'.Education')]"/>
    <xsl:variable name="occupation"  select="$boDet[@n=concat($boName,'.Occupation')]"/>
    <xsl:variable name="occupation_code"  select="$boDet[@n=concat($boName,'.Occupation_code')]"/>
    <xsl:variable name="companyurl"  select="$boDet[@n=concat($boName,'.companyURL')]"/>
    <xsl:variable name="designation" select="$boDet[@n=concat($boName,'.Designation')]"/>
    <xsl:variable name="accountID" select="$boDet[@n=concat($boName,'.accountID')]"/>
    <xsl:variable name="accountKey1" select="$boDet[@n=concat($boName,'.AccountKey')]"/>
   <!--CORE Fields Inclusion:start-->
    <xsl:variable name="telex"       select="$boDet[@n=concat($boName,'.telex')]"/>
    <!-- CORE Fields Inclusion : end -->
	<!-- vasanth's changes start -->

   <!-- <xsl:variable name="BlackListed" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BlackListed']"></xsl:variable>
    <xsl:variable name="Suspended" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Suspended']"></xsl:variable>
    <xsl:variable name="Negated" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Negated']"></xsl:variable>-->
    <xsl:variable name="chkBSN" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='chkBSN']"></xsl:variable>
    <xsl:variable name="IsDummy" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n='AccountBO.IsDummy']"></xsl:variable>
    <xsl:variable name="TabValidator" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n='AccountBO.TabValidator']"></xsl:variable>
    <xsl:variable name="ModIsDummy" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n='AccountModBO.IsDummy']"></xsl:variable>
	<!-- vasanth's changes end -->
<xsl:variable name="BlackListed" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.BlackListed')]"></xsl:variable>
     <xsl:variable name="Suspended" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.Suspended')]"></xsl:variable>
     <xsl:variable name="Negated" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.Negated')]"></xsl:variable>
  <xsl:variable name="IntroducerSalutation" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.IntroducerSalutation')]"></xsl:variable>	
 <!--Changes for call id 410026 and recon of call id 407523 starts-->
 <xsl:variable name="IntroSalText" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CatIntroducerSalutation']"></xsl:variable>
 <!--Changes for call id 410026 and recon of call id 407523 ends-->
   <!--REFCODE changes :start-->
    <xsl:variable name="Salutation"   		select="$boDet[@n=concat($boName,'.Salutation')]"/>
    <xsl:variable name="Cust_Type"   		select="$boDet[@n=concat($boName,'.Cust_Type')]"/>
    <xsl:variable name="status"   		select="$boDet[@n=concat($boName,'.status')]"/>
    <xsl:variable name="Cust_community"   	select="$boDet[@n=concat($boName,'.Cust_community')]"/>
   <!-- <xsl:variable name="IntroducerSalutation"   select="$boDet[@n=concat($boName,'.IntroducerSalutation')]"/>-->
    <!--Changes for tracker id: 333741 starts-->
    <!--Changes for  call id: tracker id 338696 starts-->    
    <xsl:variable name="Tds_tbl"   		select="$boDet[@n=concat($boName,'.Tds_tbl')]"/>
   <!-- <xsl:variable name="Tds_tbl" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='Tds_tbl']"/>-->
    <!--Changes for tracker id: 333741 ends-->
   <!--Changes for tracker id 338696 ends-->      
    <xsl:variable name="Cust_hlth"   		select="$boDet[@n=concat($boName,'.Cust_hlth')]"/>
    <xsl:variable name="Introd_Status"         	select="$boDet[@n=concat($boName,'.Introd_Status')]"/>
    <xsl:variable name="NativeLangTitle"        select="$boDet[@n=concat($boName,'.NativeLangTitle')]"/>
    <xsl:variable name="NativeLangCode"         select="$boDet[@n=concat($boName,'.NativeLangCode')]"/>
    <!--Changes for Tracker id:355038 starts-->
    <!--<xsl:variable name="Sector"         	select="$boDet[@n=concat($boName,'.Sector')]"/>-->
    <!--<xsl:variable name="Subsector"     		select="$boDet[@n=concat($boName,'.Subsector')]"/>-->
    <!--Changes for Tracker id:355038 ends-->
    <xsl:variable name="FreeCode1Desc"    	select="$boDetCI[@n=concat($boNameCI,'.FreeCode1Desc')]"/>
    <xsl:variable name="FreeCode2Desc"    	select="$boDetCI[@n=concat($boNameCI,'.FreeCode2Desc')]"/>
    <xsl:variable name="FreeCode3Desc"    	select="$boDetCI[@n=concat($boNameCI,'.FreeCode3Desc')]"/>
    <xsl:variable name="FreeCode4Desc"    	select="$boDetCI[@n=concat($boNameCI,'.FreeCode4Desc')]"/>
    <xsl:variable name="FreeCode5Desc"    	select="$boDetCI[@n=concat($boNameCI,'.FreeCode5Desc')]"/>
    <xsl:variable name="FreeCode6Desc"    	select="$boDetCI[@n=concat($boNameCI,'.FreeCode6Desc')]"/>
    <xsl:variable name="FreeCode7Desc"    	select="$boDetCI[@n=concat($boNameCI,'.FreeCode7Desc')]"/>
    <xsl:variable name="FreeCode8Desc"    	select="$boDetCI[@n=concat($boNameCI,'.FreeCode8Desc')]"/>
    <xsl:variable name="FreeCode9Desc"    	select="$boDetCI[@n=concat($boNameCI,'.FreeCode9Desc')]"/>
    <xsl:variable name="FreeCode10Desc"    	select="$boDetCI[@n=concat($boNameCI,'.FreeCode10Desc')]"/>
    <xsl:variable name="tds_cifId"    		select="$boDet[@n=concat($boName,'.TDS_CIFID')]"/>
    <xsl:variable name="tds_corecustid"    	select="$boDet[@n=concat($boName,'.Tds_cust_id')]"/>
    <xsl:variable name="defAddress" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='defAddress']"/>
	<!--changes for callID 686015 starts-->
	<xsl:variable name="defAddress_Value" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='defAddress_Value']"/>
	<!--changes for callID 686015 ends-->
<!-- Changes for Tracker # 88712 Start -->
    <xsl:variable name="Groupid"     		select="$boDet[@n=concat($boName,'.Groupid')]"/>
    <!--<xsl:variable name="Constitution_Code"     	select="$boDet[@n=concat($boName,'.Constitution_Code')]"/> Changes for Tracker id: 361921-->
    <xsl:variable name="Rating"     		select="$boDet[@n=concat($boName,'.Rating')]"/>
<!-- Changes for Tracker # 88712 End-->
    <xsl:variable name="SMSBankingMobileNo" select="$boDet[@n=concat($boName,'.SMSBankingMobileNumber')]"/>
    <!-- REFCODE changes  : end -->
    <!-- FCRM6201RECON Tracker# 49443, End of Changes -->
    <xsl:variable name="SRMTips" select="$configLabels[@name='Tips']/@value"/>
    <xsl:variable name="custom_fields" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z"/>
    <xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
    <xsl:variable name="BaseCurrency" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrency']"/>
          <!--Changes for call id 406159 recon of 402339 start -->
    <xsl:variable name="BaseCurrency_Desc" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrency_Desc']"/>
             <!--Changes for call id 406159 recon of 402339 end -->
	<!--Audit Fixes recon from 10.4:BEGIN -->	
	<xsl:variable name="offlineCCY" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='offlineCCY']" />
	<!--Audit Fixes recon from 10.4:END	-->
    <!-- Change for ticket 367607 starts -->
    <xsl:variable name="preferenceCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='prefCode']"/>
    <!-- Change for ticket 367607 ends -->
    <xsl:variable name="tabPgName" select="tabDemoForm"/>
<!-- CIF Changes for Caching Views : Start -->
    <xsl:param name="viewname"/>
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.Acc_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;BOName=<xsl:value-of select="$boName"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
    <xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
    <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
    <!-- CRM 10.2 SPE Changes -->
     <xsl:variable name="PresCurrData" select="$PresFile/SRM/SRMData[@SRMDataSpace='Currency']"/>
    <xsl:variable name="PresExData" select="$PresFile/SRM/SRMData[@SRMDataSpace='ExRate']"/>
<!-- CIF Changes for Caching Views : End -->
<!--Key Generation Changes STart-->
	<xsl:variable name="entityCreflg" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityCreflg']"/>
<!--Key Generation Changes end-->
<!-- Fix for Tracker #: SIDDHARTH Begins -->
<xsl:variable name="dtMinor" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtMinor']"/>
<xsl:variable name="drpYear" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='drpYear']"/>
<!-- Fix for Tracker #: SIDDHARTH Ends -->
<!-- Changes for tracker id 253845   Start -->
<xsl:variable name="convToCust" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='convToCust']"></xsl:variable>
<xsl:variable name="oldEntityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='oldEntityType']"></xsl:variable>
<xsl:variable name="oldEntityID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='oldEntityID']"></xsl:variable>
<!-- Recon of Changes for Call 391057   Start -->
<xsl:variable name="Cat_prefcode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='hidprefCode']"></xsl:variable>
<xsl:variable name="prefcode" select="$boDet[@n=concat($boName,'.Pref_code')]"/>
 <!-- Recon of Changes for Call 391057   End -->

<!-- Changes for tracker id 253845   End  -->
<!-- Recon for call id 372928 and CHANGES For Call Id 371274 STARTS -->
<xsl:variable name="FreeCode3Desc1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='FreeCode3Desc1']"></xsl:variable>
<xsl:variable name="FreeCode4Desc1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='FreeCode4Desc1']"></xsl:variable>
<xsl:variable name="FreeCode5Desc1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='FreeCode5Desc1']"></xsl:variable>
<xsl:variable name="FreeCode8Desc1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='FreeCode8Desc1']"></xsl:variable>
<xsl:variable name="FreeCode9Desc1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='FreeCode9Desc1']"></xsl:variable>
<xsl:variable name="FreeCode10Desc1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='FreeCode10Desc1']"></xsl:variable>
<!-- Recon for call id 372928 and CHANGES For Call Id 371274 ENDS -->
    <xsl:template match="/">
     <html>
     <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
     <head>
     <script>  //var SwiftName
     function f1()
     {
     alert(accountID);
     }

     </script>
<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/Rendcurrency_cif.js" language="javascript"></script>
	 <script type="text/javascript" language="javascript" src="../Customization/54/cif/js/Account.js"></script>
	<!-- Deceased Start-->
	<script type="text/javascript" src="../cif/js/Account_System.js" language="javascript"></script>
	<!-- changes for 404 error -->
	<!-- <script type="text/javascript" src="../Account/js/Account_System.js" language="javascript"></script> -->
	<!-- changes for 404 error -->
	<!-- Deceased End-->
	<!--Changes by Niharika for CR356016-->
<script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
	<!--End of changes by Niharika for CR356016-->
	<!-- TRACKER ID 321176 currency changes start -->
	          <script type="text/javascript" language="javascript" src="../Customization/cif/js/CIFCustomerAddress.js"></script>
	<!-- Changes for Ticket 725047 begin -->
	          <script type="text/javascript" language="javascript" src="../cif/js/CIFCustomerAddress_Reduced.js"></script>
	<!-- Changes for Ticket 725047 ends -->
	          <!--TrackerID:209607,Division of js start-->
    		  <script type="text/javascript" src="../cif/js/AccForm_RCL.js" language="javascript"></script>
    		  <!--Changes for Alert Server recon in 10.2.14 starts-->
    		  <script type="text/javascript" src="../cif/js/AccForm.js" language="javascript"></script>
    		  <!--Changes for Alert Server recon in 10.2.14 ends-->
    		  <!--TrackerID:209607,Division of js end-->
		  <!-- <script type="text/javascript" language="javascript" src="../cif/js/CurrencyDetails.js"></script> -->



	<!-- TRACKER ID 321176 currency changes end -->

	<!--Begin of changes for tracker 131243  by sumeet gandhok - BANKID - -->
	<script language="javascript" src="../cif/js/CrossEntityCopyValidation.js"></script>
	<!--End of changes for tracker 131243  by sumeet gandhok - BANKID - -->

        <!-- changes for ticket no 183689 start -->
        <!-- <script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>  -->
       <!-- changes for ticket no 183689  end -->
<!--CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES-->
        <script type="text/javascript" src="../Customization/js/AccountCustom.js" language="javascript"></script>
        <!--TrackerID:209607,Division of js Start-->
		<!--ISIC change by Silvester start-->
		<script type="text/javascript" src="../Customization/js/ISICValidation.js" language="javascript"></script>
		<!--ISIC change by Silvester ENDs-->


        <script type="text/javascript" src="../cif/js/Minor_RCL.js" language="javascript"></script>
        <script type="text/javascript" src="../Customization/cif/js/Minor.js" language="javascript"></script>
        <!--TrackerID:209607,Division of js End-->
<!--CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES-->
	<script type="text/javascript" src="../common/js/ContextSwitch.js" language="javascript"></script>
<!-- Field Rationalization changes start -->
<!--performance patch:Commenting duplicate js call:354529-->
<!--<script type="text/javascript" src="../common/js/SSOUtils.js"></script>-->
<!-- Field Rationalization changes end -->
     <!-- vasanth's changes start -->
     <script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>
	<!-- vasanth's changes end -->

	<!--IDENTIFICATION DOCUMENT CHANGES TRACKER ID 321176 start-->
		<script type="text/javascript" language="javascript" src="../cif/js/EntityDocument_Form.js"></script>
	<!--IDENTIFICATION DOCUMENT CHANGES TRACKER ID 321176 end-->


         <!-- TrackerID:209607,CHANGES START -->
  	<script type="text/javascript" src="../common/js/Rendcurrency_cif.js" language="javascript"></script>
  	<!-- TrackerID:209607,CHANGES END -->
	<!-- CRM101UB changes -->
	<script type="text/javascript" language="javascript" src="../cif/js/Group.js"></script>
	<!-- CRM101UB change end -->
<!-- Changes done by Bharath start -->
<script type="text/javascript">
function custFnLoad()
{
        var bank_id = '<xsl:value-of select="$bank_id"/>';
       // bank_id = "54";
        document.getElementsByName("custBankId")[0].value = bank_id;
        var bkid = document.getElementsByName("custBankId")[0].value;
        //alert(bkid);
	document.getElementsByName("AccountBO.StrUserField10")[0].selectedIndex = 1;
	//custCrncyPopulate();
}

<!--Isic function changes by Silveste starts-->
function LoadSector()
{
	if(operationType =='Edit Entity')
	{
		
		document.getElementsByName('AccountBO.Sector_code')[0].value = Sector;


		var acckey = document.getElementsByName('AccountBO.AccountKey')[0].value
	
		ISICValidation('SUB_SECTOR_CODE','.Sector_code','.Subsector','SECTOR_CODE');
		document.getElementsByName("AccountBO.Subsector")[0].value = Subsector;

		ISICValidation('ISICP1','.Subsector','.StrField16','SUB_SECTOR_CODE');
		ISICValue(acckey,'StrField16');		
			
		ISICValidation('ISICP2','.StrField16','.StrField18','ISICP1');		
		ISICValue(acckey,'StrField18');

		ISICValidation('ISIC_DEMAND2','.StrField19','.StrField21','ISIC_DEMAND1');		
		ISICValue(acckey,'StrField21');

		ISICValidation('SUB_SECTOR_CODE','.StrUserField6','.StrUserField7','SECTOR_CODE')
		ISICValue(acckey,'StrUserField7');
		
		ISICValidation('ISICP1','.StrUserField7','.StrUserField2','SUB_SECTOR_CODE')
		ISICValue(acckey,'StrUserField2');
		
		ISICValidation('ISICP2','.StrUserField2','.StrUserField23','ISICP1')
		ISICValue(acckey,'StrUserField23');

		ISICValidation('ISIC_DEMAND1','.StrUserField23','.StrUserField3','ISICP2')
		ISICValue(acckey,'StrUserField3');

		ISICValidation('ISIC_DEMAND2','.StrUserField3','.StrUserField9','ISIC_DEMAND1')
		ISICValue(acckey,'StrUserField9');
	
		
		
	}

}

<!--Isic function changes by Silveste ends-->

function custCrncyPopulate()
{
	document.getElementsByName("AccountBO.StrUserField10")[0].selectedIndex = 1;
		var URL = "";
		var CustomerCurrency = '<xsl:value-of select="$BaseCurrency"/>';
		var CreditDiscountPercent = "0";
		var DebitDiscountPercent = "0";
		var WithholdTaxPcnt = document.getElementsByName("AccountBO.StrUserField10")[0].value;
		var WithholdTaxFloorLmt = "0";
		var PreferentialExpiryDate = '31/12/2099';
		CurrencyappendTRChild(URL,
					CustomerCurrency,
					CreditDiscountPercent,
					DebitDiscountPercent,
					WithholdTaxPcnt,
					WithholdTaxFloorLmt,
					PreferentialExpiryDate);
}
function custCrncyPopulate1()
{
	document.getElementsByName("AccountBO.StrUserField10")[0].selectedIndex = 1;
		var URL = "";
		var CustomerCurrency = "USD";
		var CreditDiscountPercent = "0";
		var DebitDiscountPercent = "0";
		var WithholdTaxPcnt = document.getElementsByName("AccountBO.StrUserField10")[0].value;
		var WithholdTaxFloorLmt = "0";
		var PreferentialExpiryDate = '31/12/2099';
		CurrencyappendTRChild(URL,
					CustomerCurrency,
					CreditDiscountPercent,
					DebitDiscountPercent,
					WithholdTaxPcnt,
					WithholdTaxFloorLmt,
					PreferentialExpiryDate);
}

function custCrncyPopulate2()
{
	document.getElementsByName("AccountBO.StrUserField10")[0].selectedIndex = 1;
		var URL = "";
		var CustomerCurrency = "EUR";
		var CreditDiscountPercent = "0";
		var DebitDiscountPercent = "0";
		var WithholdTaxPcnt = document.getElementsByName("AccountBO.StrUserField10")[0].value;
		var WithholdTaxFloorLmt = "0";
		var PreferentialExpiryDate = '31/12/2099';
		CurrencyappendTRChild(URL,
					CustomerCurrency,
					CreditDiscountPercent,
					DebitDiscountPercent,
					WithholdTaxPcnt,
					WithholdTaxFloorLmt,
					PreferentialExpiryDate);
}

function custCrncyPopulate3()
{
	document.getElementsByName("AccountBO.StrUserField10")[0].selectedIndex = 1;
		var URL = "";
		var CustomerCurrency = "GBP";
		var CreditDiscountPercent = "0";
		var DebitDiscountPercent = "0";
		var WithholdTaxPcnt = document.getElementsByName("AccountBO.StrUserField10")[0].value;
		var WithholdTaxFloorLmt = "0";
		var PreferentialExpiryDate = '31/12/2099';
		CurrencyappendTRChild(URL,
					CustomerCurrency,
					CreditDiscountPercent,
					DebitDiscountPercent,
					WithholdTaxPcnt,
					WithholdTaxFloorLmt,
					PreferentialExpiryDate);
}

function fnCrncyTabSelect()
{
	return true;
}

function isNumber()
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

</script>
<!-- Changes done by Bharath end -->
    <script>
	//Changes starts for TrackerID: 234910
	var allowMulti = '<xsl:value-of select="$allowMulti"></xsl:value-of>';
	var chargeCode = '<xsl:value-of select="$chargeCode"/>';
	var serviceLevelCode = '<xsl:value-of select="$serviceLevelCode"/>';
	//Recon for call id 372928 and changes for call id 371274 starts
	var FreeCode3Desc1 = '<xsl:value-of select="$FreeCode3Desc1"/>';
	var FreeCode3Desc = '<xsl:value-of select="$FreeCode3Desc"/>';
	var FreeCode4Desc1 = '<xsl:value-of select="$FreeCode4Desc1"/>';
	var FreeCode4Desc = '<xsl:value-of select="$FreeCode4Desc"/>';
	var FreeCode5Desc1 = '<xsl:value-of select="$FreeCode5Desc1"/>';
	//Changes for TOL 667690 starts
	var FreeCode5Desc = '<xsl:value-of select="$FreeCode5Desc"/>';
	//Changes for TOL 667690 ends
	var FreeCode8Desc1 = '<xsl:value-of select="$FreeCode8Desc1"/>';
	var FreeCode8Desc = '<xsl:value-of select="$FreeCode8Desc"/>';
	var FreeCode9Desc1 = '<xsl:value-of select="$FreeCode9Desc1"/>';
	var FreeCode9Desc = '<xsl:value-of select="$FreeCode9Desc"/>';
	var FreeCode10Desc1 = '<xsl:value-of select="$FreeCode10Desc1"/>';
	var FreeCode10Desc = '<xsl:value-of select="$FreeCode10Desc"/>';
	//Recon for call id 372928 and changes for call id 371274 ends
	var codechargeCode = '<xsl:value-of select="$codechargeCode"/>';
	//Changes starts for TrackerID: 235202
	var strSessionCalType = '<xsl:value-of select="$strSessionCalType"/>';
//Changes ends for TrackerID: 235202
<!-- changes for tracker 356432 starts -->
var custtypecode='<xsl:value-of select="$CustTCode"/>'
var custTypeLang = '<xsl:value-of select="$custTypeLang"/>';
var custstatcode='<xsl:value-of select="$CustStatCode"/>'
var custstatLang = '<xsl:value-of select="$custStatLang"/>';
var constcode='<xsl:value-of select="$ConCode"/>'
var constLang = '<xsl:value-of select="$constLang"/>';
<!-- Recon of changes for Call 391057 starts -->
var prefcode = '<xsl:value-of select="$prefcode"/>';
var Cat_prefcode = '<xsl:value-of select="$Cat_prefcode"/>';  
<!-- Recon of changes for Call 391057 end -->
var IntroducerSalutation = '<xsl:value-of select="$IntroducerSalutation"/>';
 //Changes for call id 410026 and recon of call id 407523 starts
var IntroSalText = '<xsl:value-of select="$IntroSalText"/>';
 //Changes for call id 410026 and recon of call id 407523 ends
<!-- changes for tracker 356432 ends -->
	//Changes starts for TrackerID: 234910
	var bcName = '<xsl:value-of select="$bcName"/>';
	var Cat_bcName = '<xsl:value-of select="$Cat_bcName"/>';
	<!--Changes for Tracker id: 347074 starts-->
	var strSolId = '<xsl:value-of select="$strSolId"/>';
	var solId = '<xsl:value-of select="$solId"/>';
	<!--Changes for Tracker id: 347074 ends-->
	var segment = '<xsl:value-of select="$segmentValues"/>';
	var segmentRating = '<xsl:value-of select="$segmentRating"/>';
	var subSegmentRating = '<xsl:value-of select="$ratingValues"/>';
	var subSegment = '<xsl:value-of select="$subSegmentValues"/>';
	var strCountryValue = '<xsl:value-of select="$strCountryValue"/>';
	<!-- Change for ticket 367607 starts -->
	var preferenceCode = '<xsl:value-of select="$preferenceCode"/>';
	<!-- Change for ticket 367607 ends -->
	var subSegmentCode = '<xsl:value-of select="$subSegmentCodeVal"/>';
<!-- TRACKER ID 122174 CHANGES BEGIN -->
	<!-- Get the values of minor tab templates into variables -->
	var lName = '<xsl:value-of select="$lName"/>';
	var mName = '<xsl:value-of select="$mName"/>';
	var fName = '<xsl:value-of select="$fName"/>';
	var relation = '<xsl:value-of select="$relation"/>';
	var currList = '<xsl:value-of select="$CurrencyList"/>';
	var curraccList = '<xsl:value-of select="$CurrencyAccList"/>';
	var key = '<xsl:value-of select="$key"/>';
	<!--Changes for Tracker id: 361921 starts-->
	var Constitution_Code='<xsl:value-of select="$Constitution_Code"/>';
	  <!-- Adhar changes  for tracker 375136 starts  -->
	var UniqueIDNumber = '<xsl:value-of select="$UniqueIDNumber"/>';
	  <!-- Adhar changes  for tracker 375136 ends  -->
	<!--Changes for Tracker id: 361921 ends-->

	<!--Changes for Tracker id:355038 starts-->
	var Sector='<xsl:value-of select="$Sector"/>';
	var Subsector='<xsl:value-of select="$Subsector"/>';
	<!--Changes for Tracker id:355038 ends-->
<!-- Change for 374326 and 374328 start -->
	var Cat_PreferredLocale = '<xsl:value-of select="$Cat_PreferredLocale"/>';
	var PreferredLocale = '<xsl:value-of select="$PreferredLocale"/>';
<!-- Change for 374326 and 374328 end -->
	<!--Audit Fixes recon from 10.4:BEGIN -->	
var varofflineCCY= '<xsl:value-of disable-output-escaping="yes" select="$offlineCCY"></xsl:value-of>';
	<!--Audit Fixes recon from 10.4:END -->	
		<!--Changes for tracker id: 333741 starts-->
		var Tds_tbl='<xsl:value-of select="$Tds_tbl"/>';
		<!--Changes for tracker id: 333741 ends-->
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
	//Fix for Ticket ID 286386 Ends

	<!-- TRACKER ID 122174 CHANGES END -->

	//IDENTIFICATION DOCUMENT CHANGES TRACKER ID 321176 start
var readMode = '<xsl:value-of select="$readMode"/>';	//added by abhinav
		    			<!-- Last Edited Page changes starts -->
		var LastUpdate_Date = '<xsl:value-of select="$LastUpdate_Date"/>';
/*************************SIT fix******************start**************************/
		var currId = '<xsl:value-of select="$currId"/>';
		var currText10 = '<xsl:value-of select="$currText10"/>';
		var currFlt1 = '<xsl:value-of select="$currFlt1"/>';
		var currFlt2 = '<xsl:value-of select="$currFlt2"/>';
		var currFlt3 = '<xsl:value-of select="$currFlt3"/>';
		var currFlt4 = '<xsl:value-of select="$currFlt4"/>';
		var currDate = '<xsl:value-of select="$currDate"/>';
/*************************SIT fix******************end**************************/
		<!-- Last Edited Page changes starts -->
        //IDENTIFICATION DOCUMENT CHANGES TRACKER ID 321176 end
	<!--tracker id 113227 starts-->
	<!-- Ticket id 207511 changes start -->
	    	var entityDocumentBO_Name = '<xsl:value-of select="$entityDocumentBO_Name"/>';
	    	<!-- Ticket id 207511 changes end -->
	    	/*ticket id 219597 tracker id 132339 changes starts*/
	    	var dualflag=1;
	    	/*ticket id 219597 tracker id 132339 changes ends*/
	     	var altLocaleType = '<xsl:value-of select="$altLocaleType"/>';
	      	var baseLocaleType = '<xsl:value-of select="$baseLocaleType"/>';
	        var altLocaleActv = '<xsl:value-of select="$altLocaleActv"/>';
 <!--Tracker Id 126417 starts-->
	       	var locale = '<xsl:value-of select="$locale"/>';
	       	 var bSelected = false;


	/*Changes Done for Ticket ID: 246054 */
		var uniqueID = "";
		var uniqueIDType = "";
	       	/*Changes Done for Ticket ID: 246054 */


<!-- TrackerId: 131246 Begin of Changes by Sonali_narula-->
	var bGcifIdAccess = '<xsl:value-of select="$GcifIdAccess"/>';
	var bMultiEntity = '<xsl:value-of select="$MultiEntity"/>';
<!-- TrackerId: 131246 end of Changes by -->

	        <!--Tracker Id 126417 ends-->
	        <!--ticket id 202064 tracker id 120789 changes starts-->
	       		/*if (altLocaleActv==true){*/
	       		if (altLocaleActv=="true"){
		<!--ticket id 202064 tracker id 120789 changes ends-->
		        if (locale==altLocaleType){
		        dualflag=0;
		        }
		  }
		 /*ticket id 219597 tracker id 132339 changes starts*/
		       /* else if (locale==baseLocaleType){
		        dualflag=1;
		        }
		 }
		 else{
		        dualflag=1;

	        }
	        */
		/*ticket id 219597 tracker id 132339 changes ends*/

          <!--tracker id 113227 ends-->

	var SubSegment = '<xsl:value-of select="$SubSegment"/>';
	var Segment = '<xsl:value-of select="$Segment"/>';

	//Sonali
	var chrgLvlCode = '<xsl:value-of select="$ChargeLevelCode"/>';
	//alert("ChargeLevelCode>>>>>>>>"+chrgLvlCode);

	var MinorAttainMajorDate = '<xsl:value-of select="$MinorAttainMajorDate"/>';
	var SenCitizenApplicableDate = '<xsl:value-of select="$SenCitizenApplicableDate"/>';
	//alert("MinorAttainMajorDate>>>>>>>>"+MinorAttainMajorDate);



    var locale = '<xsl:value-of select="$locale"/>';
    <!--Key Generation Changes Start-->
    var entityCreflg ='<xsl:value-of select="$entityCreflg"/>';
    <!--Key Generation Changes End-->
     <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
    var AccessOwnerGroup = '<xsl:value-of select="$AccessOwnerGroup"/>';
     <!-- Tracker ID : 90197 End of Changes -->
    var relManager = '<xsl:value-of select="$custom_fields[@n='RelationshipMgr']"/>';
	var accManager = '<xsl:value-of select="$custom_fields[@n='Acc_manager']"/>';
	var secManager = '<xsl:value-of select="$custom_fields[@n='Sec_manager']"/>';
	var terManager = '<xsl:value-of select="$custom_fields[@n='Ter_manager']"/>';
    var relCreatedBy = '<xsl:value-of select="$custom_fields[@n='RelationshipCreatedBy']"/>';
    var accountURL = '<xsl:value-of select="$accountURL"/>';
        var assignedBackEndID = '<xsl:value-of select="$assignedBackEndID"/>';
    var boName = '<xsl:value-of select="$boName"/>';
    var BOName = '<xsl:value-of select="$BOName"/>';
    var boNameCI = '<xsl:value-of select="$boNameCI"/>';
    var mainAccId = '<xsl:value-of select="$mainAccId"/>';
    var isCopy = '<xsl:value-of select="$isCopy"/>';
	var ppIssDate = '<xsl:value-of select="$ppIssDate"/>';
	var ppExpDate = '<xsl:value-of select="$ppExpDate"/>';
    var submit=false;
    var btnFrmSize=45;
	<!--Begin of changes for tracker 131243 by sneha kaul  - BANKID - -->
	var bank_id = '<xsl:value-of select="$bank_id"/>';
	<!--End of changes for tracker 131243 by sneha kaul  - BANKID - -->


	var SegmentChanged='';
	var defaultOwnerSegment='';
	var RMChanged='';
	var defaultPrimaryRM='';
	var defaultSecondaryRM='';
	var defaultTertiaryRM='';
	var defAddress = '<xsl:value-of select="$defAddress"/>';
	<!--changes for callID 686015 starts-->
	var defAddress_Value = '<xsl:value-of select="$defAddress_Value"/>';
	<!--changes for callID 686015 ends-->
//changes for recon 386149,call id : 384588 starts 
	var preferredAddressType = '<xsl:value-of select="$preferredAddressType"/>';
//changes for recon 386149,call id : 384588 ends 
	var isAutoGenKey = '<xsl:value-of select="$isAutoGenKey"/>';
	var LastUpdate_Date = '<xsl:value-of select="$LastUpdate_Date"/>';
	<!-- CRM101UB changes start -->
	var currentDate = '<xsl:value-of select="$dtCurr"/>';
	var grpNatName ='<xsl:value-of select="$grpNatName"/>';
	var grpglobalRM = '<xsl:value-of select="$grpglobalRM"/>';
	<!-- CRM101UB changes end -->
	<!-- vasanth's changes start -->

		var BlackListed = '<xsl:value-of select="$BlackListed"/>';
		var Suspended = '<xsl:value-of select="$Suspended"/>';
		var chkBSNFlg = '<xsl:value-of select="$chkBSN"/>';
		var Negated =  '<xsl:value-of select="$Negated"/>';

	<!-- vasanth's changes end -->
	chkBSNFlg='true';

    <!-- NRE Changes shanmuga in edit mode -->
    var PassportId = '<xsl:value-of select="$PassportId"/>';
    var PassportPlace = '<xsl:value-of select="$PassportPlace"/>';
    var PassportIdate = '<xsl:value-of select="$PassportIdate"/>';
    var PassportVdate = '<xsl:value-of select="$PassportVdate"/>';
    var readMode = '<xsl:value-of select="$readMode"/>';
    var isBasel = '<xsl:value-of select="$isBasel"/>';
     var appFlag = '<xsl:value-of select="$apprFlag"/>';
     var docRecvd = '<xsl:value-of select="$docRecvd"/>';
     <!-- Tracker# 97236 CIF - EBanking Changes : Start -->
     var isSMSBanking = '<xsl:value-of select="$isSMSBanking"/>';
     var isWAPBanking = '<xsl:value-of select="$isWAPBanking"/>';
     var currDefAddrMobile = '';
     <!-- Tracker# 97236 CIF - EBanking Changes : End -->
    <!-- NRE Changes shanmuga in edit mode -->
    <!--CORE Fields Inclusion:start-->
    var purgeFlag = '<xsl:value-of select="$purgeFlag"/>';
    <!--Alert server recon changes starts-->
    var Enable_Alerts = '<xsl:value-of select="$Enable_Alerts"/>';
    var catValue = '<xsl:value-of select="$DefaultChannel_Alert"/>';
   var preferredMobileAlert_Type   = '<xsl:value-of disable-output-escaping="yes" select="$PreferredMobileAlert_Type"></xsl:value-of>';
   
    var isAlert = '<xsl:value-of select="$isAlert"/>';
    <!--Alerts erver recon changes starts-->
    var tfpartyFlag = '<xsl:value-of select="$tfpartyFlag"/>';
    <!--added for callid 676473-->
	var IsDummy = '<xsl:value-of select="$IsDummy"/>';
    <!--CORE Fields Inclusion:end-->

    <!-- Card_Holder Changes:Start-->
    var card_holder = '<xsl:value-of select="$card_holder"/>';
    <!-- Card_Holder Changes:End-->

    <!-- TRACKER ID 113276 Changes Begin For Bug Fixing-->
    <!-- Get the value to be populated by default in RelationshipCreatedBy lookup in a variable-->
    var rCreatedBy = '<xsl:value-of select="$rCreatedBy"/>';
    <!-- TRACKER ID 113276 Changes End -->

	<!-- added by pradeep_sathyamurthy as a part of ticket 326008 Begings-->
	var relCreat = '<xsl:value-of select="$relCreat"/>';
	<!-- added by pradeep_sathyamurthy as a part of ticket 326008 Ends -->
   <!-- Fix for Tracker #: SIDDHARTH Begins  -->

   var locDate = '<xsl:value-of select="$dtMinor"/>';
   var drpYear = '<xsl:value-of select="$drpYear"/>';
   var AccKEY = '<xsl:value-of select="$accountKey1"/>';
   var accountID = '<xsl:value-of select="$accountID"/>';
   var delAddrtypes	   = new Array();


					//Changes done by kanika for Cif Deceased start
					var creFlag = '<xsl:value-of select="$creFlag"></xsl:value-of>';
					
					var operationType = '<xsl:value-of select="$operationType"></xsl:value-of>';
					
					//Changes done by kanika for Cif Deceased end

   <!-- Fix for Tracker #: SIDDHARTH Ends -->
	var cifMessage = '<xsl:value-of select="$configLabels[@name='CIFMESSAGE']/@configLabel"/>';

<!-- CIF GroupHouseHold Changes Start  -->
var globalRM = '<xsl:value-of select="$globalRM"/>';
<!-- CIF GroupHouseHold Changes End  -->
<!-- KeyGeneration start -->
	var keyGeneration = '<xsl:value-of select="$keyGeneration"/>';
<!-- KeyGeneration end-->
   <!--Access Control Changes-->
	var primBCID = '<xsl:value-of select="$PrimBCID"/>';
	var primBCCODE = '<xsl:value-of select="$PrimBCCODE"/>';
	var priGrpID = '<xsl:value-of select="$priGrpID"/>';
	var priSegName = '<xsl:value-of select="$priSegName"/>';
    <!--End of Changes-->
    <!-- Changes for tracker id 253845   Start -->
    	var convToCust = '<xsl:value-of select="$convToCust"/>';
    <!--changes for sanity tracker 430797 begin-->
    var oldEntityType = '<xsl:value-of select="$oldEntityType"/>';
    <!--changes for sanity tracker 430797 end-->
    <!-- Changes for tracker id 253845   End  -->

    	 var IntWFID = '<xsl:value-of select="$IntWFID"/>'; //Changes for 'WFlow' POC
 //var SMSBankMobileOnLoad = '<xsl:value-of select="$SMSBankingMobileNo"/>';
    </script>
        <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>	<!-- file included by tessa
        <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>-->
        <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
    <script type="text/javascript" language="javascript">
/* Fix for Tracker#79170 Starts: Dummy SortMe function is added to avoid js error */
	<![CDATA[
          function sortMe(sortColumn,sortOrder) {
           }]]>
/* Fix for Tracker#79170 Ends */
	//function to load refCodes


	 <!-- Tracker 113058 Changes Begin -->

/*******************************

	This function first calls formatAmount, if the return is not false then setNextComp is called to set the focus

	********************************/

	function formatAmountNextComp(amtField, currency, str, segment)

	{

	            var result = formatAmount(amtField, currency, str);

	            if(result != false)

	            {

	                        setNextComp(segment);

	            }

	}// function formatAmountNextComp ends


 <!-- Tracker 113058 Changes End -->
 <!-- FATCA Changes Begin -->
 
  	function ISICValidation(Type,ID,TID,RType)
	{
		ValidateISIC(Type,ID,TID,RType);	
	}

 function focusFirstFatcaField(){



       if(readMode !='Y')
       {
       
 var v=document.getElementsByName(boName+".ForeignAccTaxReportingReq")[0].value;
       if(v=='Y'){
  
        document.getElementsByName("mandStarAccountBO.ForeignTaxReportingCountry")[0].style.visibility="visible";
         document.getElementsByName("Cat_AccountBO.ForeignTaxReportingCountry")[0].IsMandatory = "true";
    
        document.getElementsByName("Cat_AccountBO.ForeignTaxReportingCountry")[0].disabled = false;
           document.getElementsByName("AccountBO.ForeignTaxReportingCountry")[0].disabled = false;
        document.getElementsByName("btnone_AccountBO.ForeignTaxReportingCountry")[0].disabled = false;
        document.getElementsByName("btntwo_AccountBO.ForeignTaxReportingCountry")[0].disabled = false;
        
       document.getElementsByName("Cat_AccountBO.ForeignTaxReportingCountry")[0].value=strCountryValue;
         
         document.getElementsByName("mandStar"+boName+".ForeignTaxReportingStatus")[0].style.visibility="visible";
	
	 document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].IsMandatory = "true";
	
	document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].disabled = false;
          document.getElementsByTagName("img")[11].style.visibility="visible";
  		  document.getElementsByTagName("img")[11].style.display=""; 
  		  document.getElementsByTagName("img")[12].style.visibility="visible";
		  document.getElementsByTagName("img")[12].style.display=""; 
      
        document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0].disabled = false;
       
       document.getElementsByName("3_AccountBO.NextForeignTaxReviewDate")[0].disabled = false;
      
       document.getElementsByName("AccountBO.FatcaRemarks")[0].disabled = false;
 
 }
 else{
 
  document.getElementsByName("mandStarAccountBO.ForeignTaxReportingCountry")[0].style.visibility="hidden";
     document.getElementsByName("Cat_AccountBO.ForeignTaxReportingCountry")[0].IsMandatory = "false";
      
 document.getElementsByName('Cat_AccountBO.ForeignTaxReportingCountry')[0].value="";

  document.getElementsByName('AccountBO.ForeignTaxReportingCountry')[0].value="";
         
       document.getElementsByName("Cat_AccountBO.ForeignTaxReportingCountry")[0].disabled = true;
      document.getElementsByName("AccountBO.ForeignTaxReportingCountry")[0].disabled = true;
             
        document.getElementsByName("btnone_AccountBO.ForeignTaxReportingCountry")[0].disabled = true;
        
        document.getElementsByName("btntwo_AccountBO.ForeignTaxReportingCountry")[0].disabled = true;
        
        
        
        	  document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].value="";
		       
		  document.getElementsByName("mandStar"+boName+".ForeignTaxReportingStatus")[0].style.visibility="hidden";
		 	    
		 	document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].IsMandatory = "false";
		 	    
		 	document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].disabled = true;
		    
    
        
     document.getElementsByTagName("img")[11].style.visibility="hidden";
    		  document.getElementsByTagName("img")[11].style.display="none"; 
    		         
    		   document.getElementsByTagName("img")[12].style.visibility="hidden";
		  document.getElementsByTagName("img")[12].style.display="none"; 
        document.getElementsByName('3_AccountBO.LastForeignTaxReviewDate')[0].value="";
        
      document.getElementsByName('AccountBO.LastForeignTaxReviewDate')[0].value="";
	      document.getElementsByName('AccountBO.NextForeignTaxReviewDate')[0].value="";
       
        document.getElementsByName("3_AccountBO.LastForeignTaxReviewDate")[0].disabled = true;
      
        
        document.getElementsByName('3_AccountBO.NextForeignTaxReviewDate')[0].value="";
      
        document.getElementsByName("3_AccountBO.NextForeignTaxReviewDate")[0].disabled = true;
  document.getElementsByName('AccountBO.FatcaRemarks')[0].value="";
 document.getElementsByName("AccountBO.FatcaRemarks")[0].disabled = true;
 
 }
 }
 else{
 var v=document.getElementsByName(boName+".ForeignAccTaxReportingReq")[0].value;
       if(v=='Y'){
 document.getElementsByName("Cat_AccountBO.ForeignTaxReportingCountry")[0].value=strCountryValue;
 }
 }
 }
 
 
 <!-- FATCA chnages Ends -->


<!-- Tracker ID: 108385: Begin of changes : For focus on first field -->
function focusFirstField()
{
	/* MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 - Begin */
	//The salutaion field of general tab has been moved
	//So it is no longer the first field and therefore it should not be focussed on form load.

	//try
	//{
		//document.getElementsByName(boName + ".Salutation")[0].focus();
	//}
	//catch (e)
	//{
	try
	{

			document.getElementsByName("AccountBO.Address.preferredAddress")[0].focus();

		}
		catch (e)
		{
			try
			{
				document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].focus();

			}
			catch (e)
			{
				//MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240
				//The offline debit limit field has been moved
				//So it is no longer the first field and therefore it should not be focussed on form load.

				//try
				//{
				//	document.getElementsByName(boNameCI +".CU_OFFLINECUMDEBITLIMIT")[0].focus();
				//}
				//catch (e)
				//{
					try
					{
						document.getElementsByName("Create New Group")[0].focus();
					}
					catch (e)
					{
						try
						{
							document.getElementsByName("Create New HouseHold")[0].focus();
						}
						catch (e)
						{
							try
							{
								//MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240
								//The Account Key has been made the first filed of general tab
								//Therefore it should focussed on form load.
								//If auto generation is true , CIf Id is non editable.
								//The next field Gender should be focused in that case
								if (isAutoGenKey == "true")
								{ 	document.getElementsByName(boName+".Gender")[0].focus();

								}
								else
								{ //If auto generation is disabled,CIF id should be focussed
									document.getElementsByName(BOName+".AccountKey")[0].focus();
								}

							}
							catch (e)
							{
								try
								{
									//MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240
									//The Identification details tab has been moved into General screen
									//Therefore it should focussed on form load.
									document.getElementsByName("AddIdentificationDetails")[0].focus();
								}
								catch (e)
								{
									try
									{

										//MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240
										//The Currency tab has been moved into General screen
										//Therefore it should focussed on form load.
										document.getElementsByName("ADD_CURRENCYDET")[0].focus();
									}
									catch (e)
									{
										try
										{
										  //MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240
										  //The tab is the first tab of the screen
										  //Therefore it should focussed on form load.
											document.getElementsByName("CoreInterfaceBO.CustLevelChargesAcct")[0].focus();
										}
										catch (e)
										{
										}
									}
								}
							}
						}

					}

				//}
			}
		}
	//}
	/* MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 - End */
}

<!-- Tracker ID: 108385: End of changes -->
	// KeyGeneration start
	function checkKeys() {
		if (event.keyCode == 42 || event.keyCode ==37) {
			event.keyCode=0;
		}
	}
	// KeyGeneration end
	<!--Access Control Changes-->
		function  openBCCodeLookup(type)
		{
			bcCodeLookup = type;
			/* Tracker-id:108379 Changes for centering Lookup BEGIN */
			// hardcoded values
			var wh = 460;
			var ww = 900;
			// end hardcoded values
			var left_x = (screen.width - ww) / 2 ;
			var left_y = (screen.height - wh) / 2 ;
			var url = "com.infy.cis.ui.common.Lookup?Mode=ForBCCode&amp;isActive=Y&amp;isAutomated=N";
			var style = 'height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes';
			/* Tracker-id:108379 Changes for centering Lookup END */
			window.open (url, "Lookup", style);
		}
		function  onBCCodeSelect()
		{
			setBCCodeValues ( bcCodeLookup , getCookie("bCCode"), getCookie("bCID"));
			//Field based Maker checker changes
			document.getElementsByName("AccountBO.accessOwnerBC")[0].fireEvent("onChange");

		}

		function  setBCCodeValues (type, bCCode, bCID)
		{
			eval("document.frm2." + type).value = bCID;
			eval("document.getElementsByName('AccountBO.accessOwnerBC')[0]").value  = bCCode;
		}

		function setAccessOwnerGroup()
		{
			document.frm2.accessOwnerGroup.value=document.getElementsByName('AccountBO.accessOwnerGroup')[0].value;
	}

	function setAccessOwnerSegment()
	{
		var ownerSegment= document.getElementsByName('AccountBO.accessOwnerSegment')[0].value;
		if (ownerSegment!="" &amp;&amp; ownerSegment!= defaultOwnerSegment &amp;&amp; ownerSegment!=null &amp;&amp; ownerSegment!="null" ) {
			SegmentChanged='true';
		}
		else {
			SegmentChanged='false';
		}
	}

	<!--End of Access Control Changes-->


	//Field based Maker checker changes
	function setMCAttModifyFlag(){
		document.frm2.isMCEditedGeneral.value="Y";

	}
         function validateDate()
         {

		var final = document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
		elem4 = document.getElementsByName("3_AccountBO.DateOfBecomingNRE")[0];
		/*ticket id 210760 tracker id 126360 changes starts*/
		if(elem4.value!=""){
		//Date of NRE Becoming Ordinary validation:start
		//elem5 = document.getElementsByName("3_AccountBO.NREBecomingOrdDate")[0];//Tracker ID 113276

		//Date of NRE Becoming Ordinary validation:end


		/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
		/* calling the function isGregDate for on blur functionality*/

		         isGregDate("3_AccountBO.DateOfBecomingNRE");

		         /* ticket id 207187 changes for ST Fix start */
		         /*isGregDate("3_AccountBO.NREBecomingOrdDate");*/
		         /* ticket id 207187 changes for ST Fix end */
         	/* ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/


		var sum=changetoMillisInUSFormat(final);
		var mill4 = changetoMillis(elem4.value);
		//Date of NRE Becoming Ordinary validation:start
		//var mill5 = changetoMillis(elem5.value);//Commented By Tracker ID 113276
		//Date of NRE Becoming Ordinary validation:end

		if (mill4 != 0 &amp;&amp; sum &gt; mill4){
			 showMessage(MSGX0001);
			elem4.value = "";
		}

		//Date of NRE Becoming Ordinary validation:start
		/*if (mill5 != 0 &amp;&amp; sum &gt; mill5){
			showMessage(MSGX0002);
			elem5.value = "";

		}Tracker ID 113276*/
		//check for Date of NRE lesser than Date of Ord:start
		/*Tracker ID 113276
		if (mill5 != 0 &amp;&amp; mill4 &gt; mill5){
			showMessage(MSGX0003);
			elem5.value = "";
		}*/
		//Date of NRE Becoming Ordinary validation:end

		}
	    /*ticket id 210760 tracker id 126360 changes ends*/
		//TrackerID:238834 changes starts
		
			var todaydate = new String();
			todaydate.value = getTodayDate();
			todaydate.value = convertDate(todaydate.value);
			var mill1 = changetoMillisInUSFormat(todaydate.value);
				
			if (mill4 &gt; mill1)
	{
		showMessage(MSGX0042);
		elem4.value = "";
		elem4.focus();
		return "false";
	}
	

		//TrackerID:238834 changes ends
	}


	/* THE loadid() FUNCTION HAS BEEN MOVED FROM Account.xsl to RendAccount.js */

	//IDENTIFICATION DOCUMENT CHANGES TRACKER ID 321176 start

		/*	function loadID()//deleted from CorpNonCustomer.xsl
			{
				try
				{
					customLoad();
				}
				catch(e)
				{}
				if(document.frm2.hid_accountURL.value != '')
				{
					editMode = true;
//xml encoding changes --start
					if(entityDocumentBO_Name=='EntityDocumentBO'){
					for (i=2; i &lt; document.all.EDocRecordSet.rows.length; i++)
					{
							var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.EntityDocumentID");

						// Chanegs for ticket id 206326 start

						if(EntityDocumentID == null)
						{
						 entityDocumentBO_Name='EntityDocumentModBO';
							 var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.EntityDocumentID");
						 }
						 // Chanegs for ticket id 206326 end
						if ((EntityDocumentID != null) &amp;&amp; (EntityDocumentID != 'undefined'))
						{
								identifier_type_Code			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IdentificationType"));
								unique_id 						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.ReferenceNumber"));
								placeofissue 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.PlaceOfIssue"));
								placeofissue_cat 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentBO.PlaceOfIssue"));
								countryofissue 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.CountryOfIssue"));
								countryofissue_cat 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentBO.CountryOfIssue"));
								dateofissue  					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocIssueDate"));
								validity_date 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocExpiryDate"));
								EntityDocumentID 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.EntityDocumentID"));
								EntityDocumentURL 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.url_"));

								docCode							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocCode"));
								docDescr						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocDescr"));
								docTypeCode						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocTypeCode"));
								docTypeDescr					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocTypeDescr"));
								docReceivedDate					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocReceivedDate"));
								docRemarks						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocRemarks"));
								status							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.Status"));
								isMandatory						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IsMandatory"));
							//Ticket Id 202790 - Begin
							//Adding the value of isDocumentVerified to loadId called on form load
								isDocumentVerified	 			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.isDocumentVerified"));
							//Ticket Id 202790 - Begin
								scanRequired					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.ScanRequired"));
							EDoc_identifier_type_Code[i-2] 	= identifier_type_Code;
							EDoc_docCode[i-2] 				= docCode;
							EDoc_docDescr[i-2] 				= docDescr;
							EDoc_docTypeCode[i-2] 			= docTypeCode;
							EDoc_docTypeDescr[i-2] 			= docTypeDescr;
							EDoc_docReceivedDate[i-2] 		= docReceivedDate;
							EDoc_docRemarks[i-2]		 	= docRemarks;
							EDoc_Status[i-2] 				= status;
							EDoc_isMandatory[i-2] 			= isMandatory;
							//Ticket Id 202790 - Begin
							//Adding the value of isDocumentVerified to loadId called on form load
							EDoc_isDocumentVerified[i-2] 			= isDocumentVerified;
							//Ticket Id 202790 - End
							EDoc_scanRequired[i-2] 			= scanRequired;
							EDoc_unique_id[i-2] 			= unique_id;
							EDoc_placeofissue[i-2] 			= placeofissue;
							EDoc_countryofissue[i-2] 		= countryofissue;
							EDoc_placeofissue_cat[i-2] 		= placeofissue_cat;
							EDoc_countryofissue_cat[i-2] 	= countryofissue_cat;
							EDoc_dateofissue[i-2] 			= dateofissue;
							EDoc_validity_date[i-2] 		= validity_date;
							EDoc_EntityDocumentID[i-2] 		= EntityDocumentID;
							EDoc_EntityDocumentURL[i-2] 	= EntityDocumentURL;

							EDoc_URL[i-2] 					= identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue;
							EDoc_IsDirty[i-2] 				= 'N';


								document.all.EDocRecordSet.rows(i).setAttribute("EntityDocumentBO.url", identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue);
			//loading identifier_type (unique id, Issue_Date, Valid_Date) in EntityTable for Retail start
							var objHidUniqueID=document.getElementsByName(identifier_type_Code + ".txt_ID")[0];
							if(objHidUniqueID!=null)
							{
								objHidUniqueID.value=unique_id;
							}
							var objHidIssueDate=document.getElementsByName(identifier_type_Code + ".txt_Issue_Date")[0];
							if(objHidIssueDate!=null)
							{
								objHidIssueDate.value=dateofissue;
							}
							var objHidValidDate=document.getElementsByName(identifier_type_Code + ".txt_Valid_Date")[0];
							if(objHidValidDate!=null)
							{
								objHidValidDate.value=validity_date;
							}
							var objHidIssuePlace=document.getElementsByName(identifier_type_Code + ".txt_Issue_Place")[0];
							if(objHidIssuePlace!=null)
							{
								objHidIssuePlace.value=placeofissue;
							}
						}
					}
					}
					else if(entityDocumentBO_Name=='EntityDocumentModBO'){
						for (i=2; i &lt; document.all.EDocRecordSet.rows.length; i++)
						{
							var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.EntityDocumentID");

							// Chanegs for ticket id 206326 start

							if(EntityDocumentID == null)
							{
							 entityDocumentBO_Name='EntityDocumentModBO';
							 var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.EntityDocumentID");
							 }
							 // Chanegs for ticket id 206326 end
							//alert("EntityDocumentID"+EntityDocumentID);
							if ((EntityDocumentID != null) &amp;&amp; (EntityDocumentID != 'undefined'))
							{
								identifier_type_Code			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IdentificationType"));
								unique_id 						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.ReferenceNumber"));
								placeofissue 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.PlaceOfIssue"));
								placeofissue_cat 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentModBO.PlaceOfIssue"));
								countryofissue 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.CountryOfIssue"));
								countryofissue_cat 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentModBO.CountryOfIssue"));
								dateofissue  					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocIssueDate"));
								validity_date 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocExpiryDate"));
								EntityDocumentID 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.EntityDocumentID"));
								EntityDocumentURL 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.url_"));

								docCode							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocCode"));
								docDescr						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocDescr"));
								docTypeCode						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocTypeCode"));
								docTypeDescr					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocTypeDescr"));
								docReceivedDate					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocReceivedDate"));
								docRemarks						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocRemarks"));
								status							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.Status"));
								isMandatory						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IsMandatory"));
								//Ticket Id 202790 - Begin
								//Adding the value of isDocumentVerified to loadId called on form load
								isDocumentVerified	 			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.isDocumentVerified"));
								//Ticket Id 202790 - Begin
								scanRequired					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.ScanRequired"));
								EDoc_identifier_type_Code[i-2] 	= identifier_type_Code;
								EDoc_docCode[i-2] 				= docCode;
								EDoc_docDescr[i-2] 				= docDescr;
								EDoc_docTypeCode[i-2] 			= docTypeCode;
								EDoc_docTypeDescr[i-2] 			= docTypeDescr;
								EDoc_docReceivedDate[i-2] 		= docReceivedDate;
								EDoc_docRemarks[i-2]		 	= docRemarks;
								EDoc_Status[i-2] 				= status;
								EDoc_isMandatory[i-2] 			= isMandatory;
								//Ticket Id 202790 - Begin
								//Adding the value of isDocumentVerified to loadId called on form load
								EDoc_isDocumentVerified[i-2] 			= isDocumentVerified;
								//Ticket Id 202790 - End
								EDoc_scanRequired[i-2] 			= scanRequired;
								EDoc_unique_id[i-2] 			= unique_id;
								EDoc_placeofissue[i-2] 			= placeofissue;
								EDoc_countryofissue[i-2] 		= countryofissue;
								EDoc_placeofissue_cat[i-2] 		= placeofissue_cat;
								EDoc_countryofissue_cat[i-2] 	= countryofissue_cat;
								EDoc_dateofissue[i-2] 			= dateofissue;
								EDoc_validity_date[i-2] 		= validity_date;
								EDoc_EntityDocumentID[i-2] 		= EntityDocumentID;
								EDoc_EntityDocumentURL[i-2] 	= EntityDocumentURL;

								EDoc_URL[i-2] 					= identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue;
								EDoc_IsDirty[i-2] 				= 'N';

								document.all.EDocRecordSet.rows(i).setAttribute("EntityDocumentModBO.url", identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue);
				//loading identifier_type (unique id, Issue_Date, Valid_Date) in EntityTable for Retail start
								var objHidUniqueID=document.getElementsByName(identifier_type_Code + ".txt_ID")[0];
								if(objHidUniqueID!=null)
								{
									objHidUniqueID.value=unique_id;
								}
								var objHidIssueDate=document.getElementsByName(identifier_type_Code + ".txt_Issue_Date")[0];
								if(objHidIssueDate!=null)
								{
									objHidIssueDate.value=dateofissue;
								}
								var objHidValidDate=document.getElementsByName(identifier_type_Code + ".txt_Valid_Date")[0];
								if(objHidValidDate!=null)
								{
									objHidValidDate.value=validity_date;
								}
								var objHidIssuePlace=document.getElementsByName(identifier_type_Code + ".txt_Issue_Place")[0];
								if(objHidIssuePlace!=null)
								{
									objHidIssuePlace.value=placeofissue;
								}
							}
						}
					}
	//xml encoding changes --end

				}
			} */
//IDENTIFICATION DOCUMENT CHANGES TRACKER ID 321176 end

	/* THE loadid() FUNCTION HAS BEEN MOVED FROM Account.xsl to RendAccount.js */




       function selectProcess(){

        	var operationType = '<xsl:value-of select="$operationType"/>';
        	submit = true;
              	var accountId = "";
               	var mainID ='<xsl:value-of select="$mainAccId"/>';
		//Field based Maker checker changes
		if(document.frm2.isMCEditedGeneral.value=="N"){
       			appFlag="false";
       		}

       		//...added by vishal....
       		if( appFlag=='true')
       		  {
       		  	entityType = "AccountMod";
       		// CRM70t-ST :TRACKER# 79731 **BEGIN OF CHANGES **
		// Changes for tracker id 253845   Start 
		if(accountURL=='' || mainID !='' || isCopy =='Y' || convToCust == 'Y' ){
		// Changes for tracker id 253845   End 
       		// CRM70t-ST :TRACKER# 79731 **END OF CHANGES **
			  accountId  = parent.formSaveFrame.savedModID;
		//NNTM MATT Fix start
			  if (accountId== '' || accountId ==null ) {
			  	accountId  = parent.formSaveFrame.savedValue;
			  }
		//NNTM MATT Fix end
			} else {
			  accountId  = parent.formSaveFrame.savedValue;
			}
       		}else
       		  {
       		 	 entityType = "Account";
			 accountId  = parent.formSaveFrame.savedValue;
       		  }
       		if(!(document.frm2.byPassFlag.value=="Y")){
       			/* Changes for 'WFlow' POC -- start */
			var frmEditEnt = '';
			if (operationType == 'Queue') {
				frmEditEnt = 'Yes';
			}
			/* Changes for 'WFlow' POC -- end */
			//Checksum recon
			var secureHKey = document.getElementsByName("SECUREHKEY")[0].value;	
			var keyField = document.getElementsByName("FLDHASHKEY")[0].value;
			/*Tracker :93811 Fix start */
			/*Changes by Niharika for CR356016*/
       			//window.open('../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+accountId+'&amp;entityType='+entityType+'&amp;IntWFID='+IntWFID+'&amp;isPopup=Yes'+'&amp;frmEditEnt=Yes'+'&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField,'save','directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no'); /* Changes for 'WFlow' POC -- 'IntWFID' and 'frmEditEnt' being passed */
       			     //Changes for call id 373394 Start : Process window was not coming in focus

    // window.showModalDialog('../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+accountId+'&amp;entityType='+entityType+'&amp;IntWFID='+IntWFID+'&amp;isPopup=Yes'+'&amp;frmEditEnt=Yes'+'&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField,'save','dialogHeight:360px; dialogLeft:'+ (screen.width - 900) / 2 +'px;dialogTop:'+ (screen.height - 360) / 2+'px; dialogWidth:500px;center:yes;resizable:no;status:no;scroll:no;help:no;');
       		var strProcessURL = '../servlet/com.infy.cis.custom.EquityRetailProcessSelection?entityId='+accountId+'&amp;entityType='+entityType;
			var strBOURL = accountURL;
			//alert('strBOURL    '+strBOURL);
			//alert('strProcessURL     '+strProcessURL);
			fnProcessSelection(strProcessURL, strBOURL);
       		/*End of changes by Niharika for CR356016*/
     //Changes for call id 373394 Ends : Process window was not coming in focus
       		// Recon of 412429 changes
			if(accountURL != '' &amp;&amp; accountURL !=null &amp;&amp; accountURL != 'null'){
       			top.close();
       			}
       			//Checksum recon
			/*Tracker :93811 Fix End */
       		/*Tracker 143566 Fix start */
       		//changing reload as it was not taking from cache.
		//parent.location.reload(true);
		<!-- CRM102ST: TrackerID:180649 Being of Change -->
		//No need to refresh from select process as closebtn() is called for refreshing
		//parent.frames(0).location.href= parent.frames(0).location.href;
		<!-- CRM102ST: TrackerID:180649 End of Change  -->
		/*Tracker 143566 Fix End */
       		}

        }

function refreshParent(){
	frm = top.opener.parent.frames(1);
	frm.navigate (frm.location.href);
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

       function convertMonth(str){
          var monStr = "";
          if(	str ==	"January"){
       	monStr = "01";
          }else if(str == "February"){
       	monStr = "02";
          }else if(str =="March"){
       	monStr = "03";
          }else if(str =="April"){
       	monStr = "04";
          }else if(str =="May"){
       	monStr = "05";
          }else if(str =="June"){
          	monStr = "06";
          }else if(str =="July"){
       	monStr = "07";
          }else if(str =="August"){
       	monStr = "08";
          }else if(str == "September"){
       	monStr = "09";
          }else if(str =="October"){
       	monStr = "10";
          }else if (str =="November"){
       	monStr = "11";
          }else if(str =="December"){
       	monStr = "12";
          }

           return monStr;
}


       function setDefStatus() {
            if(document.frm2.hid_accountURL.value == '') {
                document.getElementsByName(boName+'.status')[0].selectedIndex = 1;
            }
        }
	//CIF Tabbing and Saving Changes
	function closebtn(){

		if(accountURL==''){
		// Tracker id 160390: Changes start
			//parent.frames(0).location.href = parent.frames(0).location.href;
			//parent.parent.frames(0).location.href = parent.parent.frames(0).location.href;
		// Tracker id 160390: Changes end
		} else if(!submit){
			top.window.close();

		}
	/*Changes by Niharika to call a new screen like Customer Onboard*/		
	var dataArea = parent.parent.parent.parent.parent;
	var screenTitle= parent.parent.parent.parent.parent.parent.ScreenTitleFrm;
	screenTitle.titleMsg.innerHTML = "CIF Retail > New Entity > Customer Onboarding";
	dataArea.location.href="../../../servlet/com.infy.cis.custom.OnboardDetWizard?type=Retail";

	/*End of changes by Niharika to call a new screen like Customer Onboard*/		
	}


		function openDSALookup()
       	{
       	lookupFor = "TDS"
       	intro= false;
        minor="false";
       	TDS = true;
	/* Tracker: 108382: Changes for centering popup */
	windowAlign();
       	var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForPartner";
       	window.open (url, "Lookup", 'height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
       	/* Tracker: 108382: End of Changes */
       	}

	//CIF Tabbing and Saving Changes
	function clear() {
	 // Changes for tracker id 253845   Start 
	 	 if(accountURL=='' || isCopy=='Y' || convToCust == 'Y' ){
	 // Changes for tracker id 253845   End 
		document.getElementsByName("accID")[0].value = parent.formSaveFrame.savedValue;
		//TrackerID-161933,Changes Begin
		document.getElementsByName("accKey")[0].value = unescape(parent.formSaveFrame.savedKey);
		document.getElementsByName("ModAccID")[0].value = parent.formSaveFrame.savedModID;
		document.getElementsByName("AddressFields")[0].value = parent.formSaveFrame.AddressFields;
		document.getElementsByName("OtherTFFields")[0].value = unescape(parent.formSaveFrame.OtherTFFields);
		//TrackerID-161933,Changes End
		document.getElementsByName("CoreCustID")[0].value = parent.formSaveFrame.CoreCustID;
	 }
        }


	function resubmit(){
		parent.parent.parent.parent.parent.parent.frames(0).submit();
	}


        function showbuttonsVisible(btnFrmSize) {
            try{
                 parent.parent.parent.parent.setCifButtonsVisible(true,btnFrmSize);
   //Tracker ID 113276 Changes Start
            	//document.getElementsByName('AccountBO.Alert1')[0].readOnly = true;
               // document.getElementsByName('AccountBO.Alert2')[0].readOnly = true;
    //Tracker ID 113276 Changes End

                parent.parent.parent.parent.frames(3).setCheckTipsSelection(false);
            }catch(e)
            {}
        }


        //address -CIF
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


function storeSegment() {

	defaultOwnerSegment=document.getElementsByName('AccountBO.accessOwnerSegment')[0].value;
	defaultPrimaryRM=document.getElementsByName("Acc_manager")[0].value;
	defaultSecondaryRM=document.getElementsByName("Sec_manager")[0].value;
	defaultTertiaryRM=document.getElementsByName("Ter_manager")[0].value;
}

//to clear Primary_sol_id value

 function clearsol(){

 if(accountURL == "")

	clearCategoryValue('AccountBO.Primary_sol_id');

 }

 function load(){
      try{
	
			document.getElementsByName(boName+".NativeLangCode")[0].value = "ENGLISH";
			document.getElementsByName(boName+".Cust_Language")[0].value = "UK (English)";
			
			document.getElementsByName(boName+".asset_classification")[0].value = "S";
			//document.getElementsByName("AccountModBO.NativeLangCode")[0].value = "INFENG";
			if(!(bcName=='000'||bcName=='1000'||bcName=='2000'||bcName=='3000'||bcName=='4000'))
                        {
			document.getElementsByName("AccountBO.Primary_sol_id")[0].disabled = true;
			document.getElementsByName("Cat_AccountBO.Primary_sol_id")[0].disabled = true;
			//document.getElementsByName("btnone_AccountBO.Primary_sol_id")[0].disabled = true;
			//document.getElementsByName("btntwo_AccountBO.Primary_sol_id")[0].disabled = true;
			}

			document.getElementsByName(boName+".Tds_tbl")[0].value = "ZERO";
			document.getElementsByName("Cat_"+boName+".Tds_tbl")[0].value = "ZERO";

			//document.getElementsByName("Cat_PsychographicBO.Preferred_Locale")[0].value = "en_US";
			document.getElementsByName("PsychographicBO.Preferred_Locale")[0].value = "en_US";
			

}
catch(e){

	alert(e.message);

	}
}

//tracker ID 113276
function load2(){
	//Changes for tracker id: 333741 starts
	//changes for ticket id 574011 starts
	//document.getElementsByName(boName+".Tds_tbl")[0].value=Tds_tbl;
	//changes for ticket id 574011 ends
	//Changes for tracker id: 333741 ends
//TrackerID: 235202 changes starts

/*Changes for call id 406431*/
if(document.frm2.byPassFlag.value!='Y')
{
	if(accountURL!='')
	{

		document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value = '<xsl:value-of select = "$preferredPhone"/>';
		document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value = '<xsl:value-of select = "$preferredEmail"/>';
	}
}

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
	try{
  		var obj = parent.parent.parent.parent.frames(3);
              	obj.enableButton_Ub();
	}catch(e)
	{ }
	// changes for Tracker id: 299243 starts
	if(readMode == 'Y')
		document.getElementsByName("RelationshipBO.Bank_Entity_Name1")[0].disabled = true;
	// changes for Tracker id: 299243 ends

	//changes by Rozy for CNF
	if(isAutoGenKey == 'false' || isAutoGenKey == '') {
 // Fix for Ticket Id 487186 start
		if(readMode == 'Y')
			{
			document.getElementsByName("AccountBO.AccountKey")[0].IsMandatory = "false";
			document.getElementsByName("mandStarAccountBO.AccountKey")[0].style.visibility="hidden";
			}
			else
			{
			if(document.getElementsByName("AccountBO.AccountKey")[0]!=undefined){
			document.getElementsByName("AccountBO.AccountKey")[0].IsMandatory = "true";
			document.getElementsByName("mandStarAccountBO.AccountKey")[0].style.visibility="visible";
			}
            }
//Fix for ticket id 498186 - End
	}
	<!-- CRM102ST: TrackerID:182172 Begin of Change -->
	else if (isAutoGenKey == 'true'){
	document.getElementsByName("AccountBO.IntroducerID")[0].readOnly = true;
	document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="hidden";
	}
	<!-- CRM102ST: TrackerID:182172 End of Change -->
	<!-- changes for tracker 356432 starts -->
	<!-- changes for tracker 361545 starts -->

	try{
	 if(readMode=='Y'){
					  		document.getElementsByName("Cat_AccountBO.Cust_type_code")[0].value = custTypeLang;
							//document.getElementsByName("AccountBO.Cust_type_code")[0].value = CustTCode;
							document.getElementsByName("AccountBO.Cust_type_code")[0].value = custtypecode;
							
							document.getElementsByName("Cat_AccountBO.Status_code")[0].value = custstatLang;
							document.getElementsByName("AccountBO.Status_code")[0].value = custstatcode;
							
							document.getElementsByName("Cat_AccountBO.Constitution_Code")[0].value = constLang;
			document.getElementsByName("AccountBO.Constitution_Code")[0].value = constcode;
					  
			  }
	
	}
	catch(e){}
	<!-- changes for tracker 356432 ends -->
	<!-- changes for tracker 361545 ends-->
	try
	{
/* Changes for ticket 357124 starts */
	if(readMode!='Y')
	{
		document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].disabled = true;
		document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].disabled = true;
		
	}else
	{
		document.getElementsByName("AccountBO.MinorAttainMajorDate")[0].disabled = true;
		document.getElementsByName("AccountBO.SenCitizenApplicableDate")[0].disabled = true;
	}
	/* Change for 374326 and 374328 start */
	if(PreferredLocale != null || PreferredLocale != '' || PreferredLocale != 'undefined')
	{
		document.getElementsByName("Cat_PsychographicBO.Preferred_Locale")[0].value = Cat_PreferredLocale;
		document.getElementsByName("PsychographicBO.Preferred_Locale")[0].value = PreferredLocale;
		/* Fix for CallId 338339 : begin */
				document.getElementsByName("Cat_PsychographicBO.Preferred_Locale")[0].onblur="";
		/* Fix for CallId 338339 : end */
	}
	else
	{
		document.getElementsByName("Cat_PsychographicBO.Preferred_Locale")[0].value = "";
		document.getElementsByName("PsychographicBO.Preferred_Locale")[0].value = "";
		 /* Change for tracker id 336884  start */ 
		                   /* Change for Call Id: 252117  start */ 
		                                   document.getElementsByName("Cat_PsychographicBO.Preferred_Locale")[0].onblur=""; 
		                   /* Change for Call Id: 252117  end */ 
		                   /* Change for tracker id 336884  end */ 
	}
	/* Fix for CallId 338339 : Added editmode condition  */
	if(readMode == 'Y'|| editMode == 'false')
	/* Fix for CallId 338339 : end */
	{
		document.getElementsByName("btnone_PsychographicBO.Preferred_Locale")[0].disabled = true;
          	document.getElementsByName("btntwo_PsychographicBO.Preferred_Locale")[0].disabled = true;
          	          	//change for callid 354092
//change for recon 388443,callid 385767 starts
          	//document.getElementsByName("Cat_PsychographicBO.Preferred_Locale")[0].readOnly = false;
          	document.getElementsByName("Cat_PsychographicBO.Preferred_Locale")[0].readOnly = true;
//change for  recon 388443,callid 385767 ends	
	}
	/* Fix for CallId 338339 : begin */
	else
	{
	          	//change for callid 354092
//change for  recon 388443,callid 385767 starts
		//document.getElementsByName("Cat_PsychographicBO.Preferred_Locale")[0].readOnly = false;
		document.getElementsByName("Cat_PsychographicBO.Preferred_Locale")[0].readOnly = true;
//change for  recon 388443,callid 385767 ends		
		document.getElementsByName("Cat_PsychographicBO.Preferred_Locale")[0].onblur="";
	}
	/* CFix for CallId 338339 : end */
	/* Change for 374326 and 374328 end */
	document.getElementsByTagName("img")[1].style.display='none';
	formatNumber("AccountBO.RelationshipValue");
	formatNumber("AccountBO.NumberOfProducts");
	<!-- TrackerID:209607,CHANGES START -->
	formatNumber("2_AccountBO.Offline_cum_debit_limit");
	<!-- TrackerID:209607,CHANGES END -->
	// Line commented as the field was not used
	//	document.getElementById("MinorToMajorDate").style.visibility = "hidden";
/* Changes for ticket 357124 ends */
	}
	catch (e)
	{
	}
	try
	{

	// Card_Holder Changes:Start
	// fix for defect id:210006 starts
	if(document.getElementsByName("ckCard_holder")[0] != undefined)
	{
	var vcard_holder = document.getElementsByName("ckCard_holder")[0];
	vcard_holder.disabled = true;
	}
	// fix for defect id:210006 ends
	// Card_Holder Changes:End
	if(accountURL!=''){
 		document.getElementsByName("AccountBO.Tds_cust_id")[0].value = '<xsl:value-of select="$tds_cifId"/>';
		document.frm2.TDS_CORECUSTID.value= '<xsl:value-of select="$tds_corecustid"/>';
	}
	}catch(e){}
// CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES **
try{
customLoad();
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
// CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES  **
//house hold id changes-begin
try{
//GroupHouseHold Change : start
//document.frm2.newHouseVal.value = document.getElementsByName("AccountBO.householdName")[0].value;
//GroupHouseHold change : End
}
catch(e)
{}
//house hold id changes-end
// Changes for tracker id 253845   Start 
//Changes done for ticket 491105
//if(accountURL == "" || isCopy == "Y" || convToCust == 'Y' ) {
if(accountURL == "" || isCopy == "Y" ) {
	document.getElementsByName(boName+".PurgeFlag")[0].value = "N";
	//changes for call id 388699 and recon of call id 387378 starts
	document.getElementsByName(boName+".PurgeFlag")[0].disabled = true;
	//changes for call id 388699 and recon of call id 387378 ends
	if(convToCust !='Y')
		{
			document.getElementsByName("AccountBO.AccountKey")[0].value = "";
		}  
	//Basel Copy
	document.getElementsByName("copyKey")[0].value=document.getElementsByName("AccountBO.AccountKey")[0].value ;
// Changes for tracker id 253845   End 
	
	/*Changes for Tracker : 291569 Starts*/
	//document.getElementsByName("AccountBO.AccountKey")[0].value = "";
	/*Changes for Tracker : 291569 End*/
	document.getElementsByName(boNameCI+".TreasuryCounterParty")[0].value = "N";
	// KeyGeneration start
	//Changes done for ticket 491105
	if ((keyGeneration == 'Both'|| (keyGeneration=="" &amp;&amp; (isAutoGenKey== 'false' || isAutoGenKey == ''))) &amp;&amp; convToCust!='Y') {
		document.getElementsByName("AccountBO.AccountKey")[0].readOnly = false;
		if (keyGeneration != 'Both') {
			keyGeneration ='Manual';
		}
	}
	// KeyGeneration end
}
else {
	//changes for call id 388699 and recon of call id 387378 starts
	//changes for ticket 705617 begin
	if(document.getElementsByName(boName+".PurgeFlag")[0]!=undefined){
		document.getElementsByName(boName+".PurgeFlag")[0].disabled = true;
	}
	//changes for ticket 705617 ends
	//changes for call id 388699 and recon of call id 387378 ends
	//document.getElementsByName("CoreInterfaceBO.TreasuryCounterParty")[0].value = "N";
}
try{

	document.getElementsByName(boName + '.NativeLangCode')[0].value = '<xsl:value-of select="$NativeLangCode"/>';
	document.getElementsByName(boName + '.NativeLangCode')[0].value = 'INFENG';
 	// changes for tracker id 406546
 	
 	if(accountURL == ""){
	concatName();
	}
	if(altLocaleActv == "true"){
	concatName_alt();
	}
	if(accountURL!='')
	{
		// Changes for tracker id 253845   Start 
		// if(isCopy!='Y')
		<![CDATA[if(isCopy!='Y' && convToCust != 'Y')]]>
		// Changes for tracker id 253845   End 
		{
		/* Changes for Tracker # 166716 BEGIN */
			/*if(entityCreflg == 'N'){
				document.getElementsByName("AccountBO.AccountKey")[0].disabled = false;
				document.getElementsByName("AccountBO.AccountKey")[0].readOnly = false;
				document.getElementsByName("hid_cifid")[0].value = document.getElementsByName("AccountBO.AccountKey")[0].value;
			}else {*/
			document.getElementsByName("AccountBO.AccountKey")[0].disabled = true;
		//}
		/* Changes for Tracker # 166716 END */
		}
		else
		{
			document.getElementsByName("AccountBO.AccountKey")[0].disabled = false;
		}
	}

   // Changes for tracker id 253845   start 
    if(document.frm2.hid_accountURL.value != '' || convToCust=='Y') {
  	editMode = true;
  // Changes for tracker id 253845   End 
if(document.frm2.byPassFlag.value!='Y'){
// CRM101UB Group Changes Start
try{
//xml encoding changes- Start
if(boName=='AccountBO'){
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

}else if(boName=='AccountModBO'){
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
}
//xml encoding changes- end
catch (ex) {

	}

// CRM101UB Group Changes End
//xml encoding changes- Start
if(document.frm2.byPassFlag.value!='Y'){
if(boName=='AccountBO'){
//GroupHouseHold Inclusion:start
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
// HouseHold fields inclusion :End


	/* CIF PhoneEmail Changes : Start */
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
				document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountBO.PhoneEmail.PhoneEmailType",phoneEmailType);
				//Changes for tracker ID 447704 begin
				<![CDATA[
				var temp = document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value;
				document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value = phoneEmailType;
				var localetext = document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].options[document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].selectedIndex].text;
				document.all.PhoneEmailRecordSet.rows(i).childNodes(1).innerHTML="<font class='fntColData'>"+localetext+"</font>";
				document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value=temp;						
				]]>
			}
			else
			{
				phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneEmailType"));
				phoneEmail_URL[phoneEmail_URL.length] = email + phoneEmailType;
				document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountBO.PhoneEmail.url_", email + phoneEmailType);
				document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountBO.PhoneEmail.PhoneEmailType1",phoneEmailType);
				<![CDATA[
				var temp = document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value;
				document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value = phoneEmailType;
				var localetext = document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].options[document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].selectedIndex].text;
				document.all.PhoneEmailRecordSet.rows(i).childNodes(1).innerHTML="<font class='fntColData'>"+localetext+"</font>";
				document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value=temp;						
				]]>
				//Changes for tracker ID 447704 end
			}
			phoneNoCountryCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneNoCountryCode"));
			phoneNoCityCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneNoCityCode"));
			phoneNoLocalCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneNoLocalCode"));
			extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.WorkExtension"));
//			emailPalm = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.EmailPalm"));
			phoneEmailId = trim(phoneEmailId);
			ad_PhoneOrEmail[ad_PhoneOrEmail.length] = phoneOrEmail
			ad_PhoneEmailType[ad_PhoneEmailType.length] = phoneEmailType
			ad_PhoneEmailID[ad_PhoneEmailID.length] = phoneEmailId
			/* Ticket 273652  changes start*/
     			//ad_extension[ad_extension.length] = extension;
     			/* Ticket 273652  changes end*/
//			ad_EmailPalm[ad_EmailPalm.length] = emailPalm;
			ad_Email[ad_Email.length] = email;
			ad_PhoneNo[ad_PhoneNo.length] = phoneNo;
			ad_PhoneNoCountryCode[ad_PhoneNoCountryCode.length] = phoneNoCountryCode;
			ad_PhoneNoCityCode[ad_PhoneNoCityCode.length] = phoneNoCityCode;
			ad_PhoneNoLocalCode[ad_PhoneNoLocalCode.length] = phoneNoLocalCode;
			ad_extension[ad_extension.length] = extension;
			phoneEmail_Status[phoneEmail_Status.length] = "Add";

		}
	}

	}else if(boName=='AccountModBO'){
		for (i=0; i &lt; document.all.RowRecordSet.rows.length; i++) {
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
	// HouseHold fields inclusion :End


		/* CIF PhoneEmail Changes : Start */
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
					document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountModBO.PhoneEmail.PhoneEmailType",phoneEmailType);
					//Changes for tracker ID 447704 begin
					<![CDATA[
					var temp = document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value;
					document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value = phoneEmailType;
					var localetext = document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].options[document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].selectedIndex].text;
					document.all.PhoneEmailRecordSet.rows(i).childNodes(1).innerHTML="<font class='fntColData'>"+localetext+"</font>";
					document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value=temp;						
					]]>
				}
				else
				{
					phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.PhoneEmailType"));
					phoneEmail_URL[phoneEmail_URL.length] = email + phoneEmailType;
					document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountModBO.PhoneEmail.url_", email + phoneEmailType);
					document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountModBO.PhoneEmail.PhoneEmailType1",phoneEmailType);
				<![CDATA[
				var temp = document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value;
				document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value = phoneEmailType;
				var localetext = document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].options[document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].selectedIndex].text;
				document.all.PhoneEmailRecordSet.rows(i).childNodes(1).innerHTML="<font class='fntColData'>"+localetext+"</font>";
				document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value=temp;						
				]]>
				//Changes for tracker ID 447704 end
				}
				phoneNoCountryCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.PhoneNoCountryCode"));
				phoneNoCityCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.PhoneNoCityCode"));
				phoneNoLocalCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.PhoneNoLocalCode"));
				extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.WorkExtension"));
	//			emailPalm = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountModBO.PhoneEmail.EmailPalm"));
				phoneEmailId = trim(phoneEmailId);
				ad_PhoneOrEmail[ad_PhoneOrEmail.length] = phoneOrEmail
				ad_PhoneEmailType[ad_PhoneEmailType.length] = phoneEmailType
				ad_PhoneEmailID[ad_PhoneEmailID.length] = phoneEmailId
	     ad_extension[ad_extension.length] = extension;
	//			ad_EmailPalm[ad_EmailPalm.length] = emailPalm;
				ad_Email[ad_Email.length] = email;
				ad_PhoneNo[ad_PhoneNo.length] = phoneNo;
				ad_PhoneNoCountryCode[ad_PhoneNoCountryCode.length] = phoneNoCountryCode;
				ad_PhoneNoCityCode[ad_PhoneNoCityCode.length] = phoneNoCityCode;
				ad_PhoneNoLocalCode[ad_PhoneNoLocalCode.length] = phoneNoLocalCode;
				/* Change for tracker 180758 */
				/* Commented as it was overwriting the value of extension set above */
				//ad_extension[ad_extension.length] = extension;
				/*End of change */
				phoneEmail_Status[phoneEmail_Status.length] = "Add";

			}
//xml encoding changes- end
		}
	}
		// changes for recon 386149,call id : 384588 starts 
		if(preferredAddressType != ""){
			document.getElementsByName("AccountBO.Address.preferredAddress")[0].value = '<xsl:value-of select = "$preferredAddressType"/>';
		}else{
			document.getElementsByName("AccountBO.Address.preferredAddress")[0].value = '<xsl:value-of select = "$defAddress"/>';
		}
	// changes for recon 386149,call id : 384588 ends
//changes for call id 348769 starts
	document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value = '<xsl:value-of select = "$preferredPhone"/>';
	document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value = '<xsl:value-of select = "$preferredEmail"/>';
		//Changes for tracker id: 333740 starts
//Changes for tracker id 338696 starts	
//	document.getElementsByName(boName+".Segmentation_Class")[0].value=Segment;
		//Changes for tracker id: 333740 ends
//Changes for tracker id 338696 ends	
	//Changes for Tracker id: 361921 starts
	document.getElementsByName(boName+".Constitution_Code")[0].value=Constitution_Code;
	//Changes for Tracker id: 361921 ends

	//Changes for Tracker id:355038 starts
	document.getElementsByName(boName+".Sector")[0].value=Sector;
	document.getElementsByName(boName+".Subsector")[0].value=Subsector;
	//Changes for Tracker id:355038 ends

	//document.getElementsByName("AccountBO.Address.preferredAddress")[0].value = '<xsl:value-of select = "$preferredAddressType"/>';
	//changes for tracker 353400 starts --- when address is not added the preferredAddressType would be null so inorder to set it to default address as per admin we placed a null check for preferredAddressType
		if(preferredAddressType != ""){
			document.getElementsByName("AccountBO.Address.preferredAddress")[0].value = '<xsl:value-of select = "$preferredAddressType"/>';
		}else{
			document.getElementsByName("AccountBO.Address.preferredAddress")[0].value = '<xsl:value-of select = "$defAddress"/>';
		}
	//changes for tracker 353400 ends
	//document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value = '<xsl:value-of select = "$preferredPhone"/>';
	//document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value = '<xsl:value-of select = "$preferredEmail"/>';
//changes for call id 348769 ends
	}
	}
<!--CIF LOS Bypass change:Start-->
	if(document.frm2.byPassFlag.value=='Y'){
		hideGenAndMinor();
	}
<!--CIF LOS Bypass change:End-->
} else {
//xml encoding changes- Start
if(boName=='AccountBO'){
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

}else if(boName=='AccountModBO'){
	for (i=0; i &lt; document.all.RecordSet.rows.length; i++) {
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
//xml encoding changes- end
    }
}
}
}catch(e){
}
if(convToCust=='Y'){

document.getElementsByName("AccountBO.AccountKey")[0].readOnly = false;
hideMinor();
loadID();
}
}
// Changes for 390769 Starts HERE
function hidedata()
{
if(document.frm2.hid_accountURL.value != ''){
     if(document.frm2.byPassFlag.value=='Y'){
			hideGenAndMinor();
	}
	}
}
// Changes for 390769 Ends HERE
	<!--CIF LOS Bypass change:Start-->
	function hideGenAndMinor(){
	// Changes for 390769 Starts HERE
		try{document.getElementById("td_tpageCont").disabled = true;
		document.getElementById("td_tpageCont").style.visibility="hidden";
		document.getElementById("det_tpageCont").style.visibility="hidden";
		document.getElementsByName("AccountBO.Salutation_code")[0].IsMandatory = "false";
		document.getElementsByName("AccountBO.Cust_Last_Name")[0].IsMandatory = "false";
		document.getElementsByName("AccountBO.PreferredName")[0].IsMandatory = "false";
		document.getElementsByName("AccountBO.AccountKey")[0].IsMandatory = "false";
		// CRM101UB changes
		document.getElementsByName("3_AccountBO.Cust_DOB")[0].IsMandatory= "false";
		document.getElementsByName("AccountBO.CustomerMinor")[0].IsMandatory = "false";
		document.getElementsByName("AccountBO.CustomerNREFlg")[0].IsMandatory = "false";
		document.getElementsByName("AccountBO.StaffFlag")[0].IsMandatory = "false";
		hideDetailstabDemoForm('tpageCont');
		document.getElementById("td_tpageCont2").disabled = true;
		document.getElementById("td_tpageCont2").style.visibility="hidden";
		document.getElementById("det_tpageCont2").style.visibility="hidden";
		document.getElementsByName("ContactBO.lastName")[0].IsMandatory = "false";
		document.getElementsByName("3_ContactBO.DOB")[0].IsMandatory = "false";
		document.getElementsByName("ContactBO.gender")[0].IsMandatory = "false";
		document.getElementsByName("ContactBO.salutation")[0].IsMandatory = "false";
		document.getElementsByName("RelationshipBO.Guard_Code")[0].IsMandatory = "false";
		document.getElementsByName("RelationshipBO.Relationship")[0].IsMandatory = "false";
		/* ticket id:334896 changes Begin */
		//document.getElementsByName("RelationshipBO.Bank_Entity_Name")[0].IsMandatory = "false";
		/* ticket id: 334896 changes End */
		hideDetailstabDemoForm('tpageCont2');

		//Hiding CoreInterface Tab:start
		document.getElementById("td_tpageCore").disabled = true;
		document.getElementById("td_tpageCore").style.visibility="hidden";
		document.getElementById("det_tpageCore").style.visibility="hidden";
		hideDetailstabDemoForm('tpageCore');
		//Hiding CoreInterface Tab:end
    <!-- CRM70t-ST TrackerId : 80201 ** BEGIN OF CHANGES ** -->
		showbuttonsVisible(45);
		}
		catch(e){
		 //DebugMessage(e.message);
		 }
    <!-- CRM70t-ST TrackerId : 80201 ** END OF CHANGES ** -->
	}
// Changes for 390769 Ends HERE
	<!--CIF LOS Bypass change:End-->
//address- CIF
        function showDeleteButton()
        {
            if(document.frm2.hid_accountURL.value != '')
            {
               parent.parent.parent.parent.showDelButton(true);
            }
            else
            {
                 parent.parent.parent.parent.showDelButton(false);
            }
        }
       /* function canDelete()
        {
              return document.frm2.hid_accountURL.value;
        }*/
        function bodyOnLoad()
        {
        //changes for ticket id 600064 -- placing the code in try/catch block so that other functions also load
try{
//Recon for call id 372928 and changes for call id 371274 starts
document.getElementsByName("Cat_CoreInterfaceBO.FreeCode3Desc")[0].value =FreeCode3Desc1;
document.getElementsByName("CoreInterfaceBO.FreeCode3Desc")[0].value =FreeCode3Desc;
document.getElementsByName("Cat_CoreInterfaceBO.FreeCode4Desc")[0].value =FreeCode4Desc1;
document.getElementsByName("CoreInterfaceBO.FreeCode4Desc")[0].value =FreeCode4Desc;
document.getElementsByName("Cat_CoreInterfaceBO.FreeCode5Desc")[0].value =FreeCode5Desc1;
document.getElementsByName("CoreInterfaceBO.FreeCode5Desc")[0].value =FreeCode5Desc;
document.getElementsByName("Cat_CoreInterfaceBO.FreeCode8Desc")[0].value =FreeCode8Desc1;
document.getElementsByName("CoreInterfaceBO.FreeCode8Desc")[0].value =FreeCode8Desc;
document.getElementsByName("Cat_CoreInterfaceBO.FreeCode9Desc")[0].value =FreeCode9Desc1;
document.getElementsByName("CoreInterfaceBO.FreeCode9Desc")[0].value =FreeCode9Desc;
document.getElementsByName("Cat_CoreInterfaceBO.FreeCode10Desc")[0].value =FreeCode10Desc1;
document.getElementsByName("CoreInterfaceBO.FreeCode10Desc")[0].value =FreeCode10Desc;
//Recon for call id 372928 and changes for call id 371274 ends
        //Changes for Tracker id 148280 Start
	 //Fix for Ticket ID 259664
	    //Fix for Ticket 290490 Begin : Reverted the changes of ticket 259664
	    <!-- CRM102ST: TrackerID:182172 Begin of Change -->
	    //DisplayLookUPIntro();
		/* Changes for ticket 336240 starts */
		/* Change for ticket 341194 start */
		//360106
		document.getElementsByName("AccountBO.IntroducerName")[0].readOnly=true;
		//360106
		document.getElementsByName("RelationshipBO.Bank_Entity1")[0].value = '<xsl:value-of select="$Bank_Entity1"/>';
		document.getElementsByName("RelationshipBO.ChildEntityType")[0].value = '<xsl:value-of select="$ChildEntityType"/>';
		/* Change for ticket 341194 end */
		/* Changes for ticket 336240 starts */
	    <!-- CRM102ST: TrackerID:182172 End of Change -->
	    //Fix for Ticket 290490 End : Reverted the changes of ticket 259664
	//Fix for Ticket ID 259664
//alert("loadd  preferredMobileAlert_Type"+preferredMobileAlert_Type);
//CRM ALERT CHANGES BEGIN
	document.getElementsByName("AccountBO.Preferred_Mobile_Alert_Type")[0].value=preferredMobileAlert_Type;
	
	//Changes for callid 434605 starts
	//document.getElementsByName("AccountBO.DefaultChannel_Alert")[0].value=catValue;
	document.getElementsByName("AccountBO.DefaultChannel_Alert").value=catValue;	
	//Changes for callid 434605 ends
	//Changes for TOL 667690 starts
	//document.getElementsByName("AccountBO.Enable_Alerts")[0].value=Enable_Alerts;
	document.getElementsByName(boName + ".Enable_Alerts")[0].value=Enable_Alerts;
	//Changes for TOL 667690 ends
	document.getElementsByName("DefaultChannel_Alert")[0].value=catValue;
//CRM ALERT CHANGES ENDS
        //Changes for Tracker id 148280 End
	//Sonali Fix for 297571
	//Changes starts for TrackerID: 234910
		//Changes for tracker id 350214 Starts Here
			if(convToCust){
				var Charge='<xsl:value-of select="$Charge"/>'
				document.getElementsByName("Cat_AccountBO.ChargeLevelCode")[0].value = Charge;
			}else
				document.getElementsByName("Cat_AccountBO.ChargeLevelCode")[0].value = chargeCode;
		//Changes for tracker id 350214 Ends Here
	document.getElementsByName("AccountBO.ChargeLevelCode")[0].value = codechargeCode;
	//Changes starts for TrackerID: 234910
	<!-- changes for tracker 356432 starts -->
	document.getElementsByName("Cat_AccountBO.Cust_type_code")[0].value = custTypeLang;
	//document.getElementsByName("AccountBO.Cust_type_code")[0].value = CustTCode;
	document.getElementsByName("AccountBO.Cust_type_code")[0].value = custtypecode;
	
	document.getElementsByName("Cat_AccountBO.Status_code")[0].value = custstatLang;
	document.getElementsByName("AccountBO.Status_code")[0].value = custstatcode;
	
	document.getElementsByName("Cat_AccountBO.Constitution_Code")[0].value = constLang;
	document.getElementsByName("AccountBO.Constitution_Code")[0].value = constcode;	
	<!-- changes for tracker 356432 ends -->
	//Tracker 194595 - START
	if(readMode=='Y')
		{
	document.getElementsByName("AccountBO.MinorAttainMajorDate")[0].value	= MinorAttainMajorDate;
	document.getElementsByName("AccountBO.SenCitizenApplicableDate")[0].value	= SenCitizenApplicableDate;
	
		}
	else{
	document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].value	= MinorAttainMajorDate;
	document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].value	= SenCitizenApplicableDate;
		}
	//Tracker 194595 - END
	//Changes for call id 408886 Starts Here
	if(readMode!='Y'){
	try
							{
								//MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240
								//The Account Key has been made the first filed of general tab
								//Therefore it should focussed on form load.
								//If auto generation is true , CIf Id is non editable.
								//The next field Gender should be focused in that case
								if (isAutoGenKey == "true")
								{ 	document.getElementsByName(boName+".Gender")[0].focus();

								}
								else
								{ //If auto generation is disabled,CIF id should be focussed
									document.getElementsByName(BOName+".AccountKey")[0].focus();
								}

							}
							catch (e)
							{
							}
							}
//Changes for call id 408886 Ends Here
        	 <!--Tracker id 113227 start here-->
 		document.frm2.altLocaleActv.value='<xsl:value-of select="$altLocaleActv"/>';
 		<!--Tracker id 113227 end here-->

                var temp = '<xsl:value-of select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.extension')]"/>';
                document.getElementsByName('WorkExtension')[0].value = temp;
               
                <!-- Tracker 140900 Begin of Changes-->
		document.getElementsByName("AccountBO.Name")[0].readOnly = true;
                <!-- Tracker 140900 End of Changes-->
                <!-- Tracker 61888 Begin of Changes-->
	        //Staff id validations for 10.2.13
		if(readMode!='Y'){
			disableStaffFieldConditionally(boName+'.StaffFlag', 'AccountBO.StaffEmployeeID');
                var staffFlag = '<xsl:value-of select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.StaffFlag')]"/>';
			if(staffFlag == 'Y' || staffFlag == 'EXSTF')
                    setStaffEmployeeIdMandatory(true);
                else
                    setStaffEmployeeIdMandatory(false);
		}
                <!-- Tracker 61888 End of Changes-->
                disableConditionally(boName+'.ProofOfAgeFlag', boName+'.ProofOfAgeDocument');

            }catch(e){
            }
        }
    function formatUser()
    {
    	//Call id tracker id 350214 Changes Start
    	if(convToCust)
		document.frm2.Acc_manager.value = '<xsl:value-of select="$Mgr"/>';
		else
		document.frm2.Acc_manager.value = accManager;
		//Call id tracker id 350214 Changes Start
	document.frm2.Sec_manager.value = secManager;
//Tracker ID 113276 Changes Start
//document.frm2.Ter_manager.value = terManager;
//Tracker ID 113276 Changes End
    	document.frm2.RelationshipMgr.value = relManager;
        //document.frm2.RelationshipCreatedBy.value = relCreatedBy;
        /*TRACKER ID 113276 Changes Begin For Bug Fixing*/
        //Set the default value of RelationshipCreatedBy lookup
        /* modified by pradeep for 326008 */
        if(relCreat != '' &amp; relCreat != null){
        document.frm2.RelationshipCreatedBy.value = relCreat;
        eval("document.getElementsByName('RelationshipCreatedBy')[0]").value  = relCreat;
        }
        else{
        document.frm2.RelationshipCreatedBy.value = relCreatedBy;
        eval("document.getElementsByName('RelationshipCreatedBy')[0]").value  = rCreatedBy;
        }
        /* modified by pradeep for 326008 ends */
        /*TRACKER ID 113276 Changes End*/

    }

        function hideMinor(){
		// Changes for call id 354543 STARTS
		var MinorFlag = document.getElementsByName(boName+".CustomerMinor")[0].value;
		// Changes for call id 354543 ENDS
        	document.frm2.minorLoaded.value="false";
		document.getElementById("td_tpageCont2").disabled = true;
		document.getElementById("td_tpageCont2").style.visibility="hidden";
		document.getElementById("det_tpageCont2").style.visibility="hidden";
		// Changes for call id 354543 STARTS
		if(MinorFlag != null &amp;&amp; MinorFlag == 'Y' &amp;&amp; convToCust){
		document.getElementsByName("ContactBO.lastName")[0].IsMandatory = "true";
		}else{
		document.getElementsByName("ContactBO.lastName")[0].IsMandatory = "false";
		}
		try{
		if(MinorFlag != null &amp;&amp; MinorFlag == 'Y' &amp;&amp; convToCust){
		document.getElementsByName("3_ContactBO.DOB")[0].IsMandatory = "true";
		}else{
		document.getElementsByName("3_ContactBO.DOB")[0].IsMandatory = "false";
		}
		}catch(e){}
		document.getElementsByName("ContactBO.gender")[0].IsMandatory = "false";
		document.getElementsByName("ContactBO.salutation")[0].IsMandatory = "false";
		if(MinorFlag != null &amp;&amp; MinorFlag == 'Y' &amp;&amp; convToCust){
		document.getElementsByName("RelationshipBO.Guard_Code")[0].IsMandatory = "true";
		}else{
		document.getElementsByName("RelationshipBO.Guard_Code")[0].IsMandatory = "false";
		}
		document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "false";
		if(document.getElementsByName("ContactBO.contactsKey")[0].value == "") {
				   if(document.all.isAutoGenKey.value == 'true') {
						document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "false";
					}
				else{
				     document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "false";
					}
				}
				else
				{
				     document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "false";
            	}
            	if(MinorFlag != null &amp;&amp; MinorFlag == 'Y' &amp;&amp; convToCust){
// Recon of 393528 Callid changes	for 396515	
document.getElementsByName("RelationshipBO.Relationship")[0].value="GUARDIAN";
		document.getElementsByName("RelationshipBO.Relationship")[0].disabled = true;
		}else{
		document.getElementsByName("RelationshipBO.Relationship")[0].IsMandatory = "false";
		}
		// Changes for call id 354543 ENDS
		/* ticket id: 334896 changes Begin */
		//document.getElementsByName("RelationshipBO.Bank_Entity_Name")[0].IsMandatory = "false";
		//document.getElementsByName("RelationshipBO.Bank_Entity_Name")[0].value="";
		/* ticket id:334896 changes end */
		document.getElementsByName("RelationshipBO.Bank_Entity")[0].value="";

		document.getElementsByName("ContactBO.salutation")[0].value="";
		document.getElementsByName("ContactBO.firstName")[0].value="";
		document.getElementsByName("ContactBO.lastName")[0].value="";
		document.getElementsByName("ContactBO.middleName")[0].value="";
		document.getElementsByName("ContactBO.gender")[0].value="";
		try{
		document.getElementsByName("3_ContactBO.DOB")[0].value="";
		}catch(e){}
		document.getElementsByName("RelationshipBO.Guard_Code")[0].value="";
		document.getElementsByName("ContactBO.contactsKey")[0].value="";
		hideDetailstabDemoForm('tpageCont2');
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

        function formatAmountCust()
        {
            try{
            baseCurrency = '<xsl:value-of select="$BaseCurrency"/>';
        //Changes for call id 406159 recon of 402339 start
            BaseCurrency_Desc='<xsl:value-of select="$BaseCurrency_Desc"/>';
             //Changes for call id 406159 recon of 402339 ends
            //defect fix for defect number 681 tracker id 113227 starts
	    document.getElementsByName(boName+".revenueUnits").value=baseCurrency;
	    //document.frm2.elements(boName+".revenueUnits").value =baseCurrency;
       // CRM70t-ST :TRACKER# 78380 **BEGIN OF CHANGES **
	    //Ticket 204898 Changes Start
		//Changes for Tracker Id 337885 Starts
	    document.getElementsByName(boName+".Crncy_code")[0].value =baseCurrency;
             //Changes for call id 406159 recon of 402339 start
	   // document.getElementsByName("Cat_"+boName+".Crncy_Code")[0].value = baseCurrency;
               document.getElementsByName("Cat_"+boName+".Crncy_Code")[0].value = BaseCurrency_Desc;
                //Changes for call id 406159 recon of 402339 Ends
		//Changes for Tracker Id 337885 ends
	    // Fix for Ticket ID 289706
	    document.frm2.elements(boName+".Crncy_code").IsReadOnly =true;
	    // Fix for Ticket ID 289706
	    //Ticket 204898 Changes End

	   //changes for ticket 330755 starts
	  document.getElementsByName(boNameCI+".CU_OFFLINECUMDEBITLIMIT")[0].value = baseCurrency;
	  // changes for ticket 330755 ends
	    //defect fix for defect number 681 tracker id 113227 Ends

       // CRM70t-ST :TRACKER# 78380 **END OF CHANGES **
	    formatAmount("3_AccountBO.currentCrExposure",boName+".revenueUnits","N");
            formatAmount("3_AccountBO.customerProfitability",boName+".revenueUnits","N");
            formatAmount("3_AccountBO.totalCrExposure",boName+".revenueUnits","N");
            formatAmount("3_AccountBO.availableCrLimit",boName+".revenueUnits","N");
            formatAmount("3_AccountBO.potentialCrLine",boName+".revenueUnits","N");
            formatAmount("3_CoreInterfaceBO.OfflineCumDebitLimit",boNameCI+".CU_OFFLINECUMDEBITLIMIT","N");
            }catch(e){
            DebugMessage(e.message);
            }
        }
function isDocument_Received() {
	    var docRecv= document.getElementsByName("ckDocument_Received")[0];
	    if(docRecvd=='Y') {
	    docRecv.checked = true;
	    }
	}
	//CORE Fields Inclusion:start
	function isPurgeFlag() {
	    /*var purgeFlg= document.getElementsByName("ckPurgeFlag")[0];
	    if(purgeFlag=='Y') {
	    purgeFlg.checked = true;
	    }*/
	}

	//Card_Holder Changes:Start
	function isCard_holder(){
	// fix for defect id:210006 starts
	if(document.getElementsByName("ckCard_holder")[0] != undefined)
	{
		    var tcard = document.getElementsByName("ckCard_holder")[0];

		    if(card_holder == 'Y'){

			tcard.checked = true;

		    }
		    tcard.disabled = true;
	}
	// fix for defect id:210006 ends
	}
	// Card_Holder Changes:End

	function introCreate(){
		//Tracker ID 113276 Changes Start
		//document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = false;
		//document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = false;
		//document.getElementsByName("mandStarAccountBO.IntroducerID")[0].style.visibility="visible";
		//document.getElementsByName(boName +".IntroducerSalutation")[0].IsMandatory="true";
		//document.getElementsByName("mandStar" + boName +".IntroducerSalutation")[0].style.visibility="visible";
		//document.getElementsByName("mandStarAccountBO.IntroducerName")[0].style.visibility="visible";
		//document.getElementsByName("AccountBO.IntroducerName")[0].IsMandatory="true";
		/*if(document.getElementsByName("AccountBO.IntroducerID")[0].value == "") {
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
		} */
//Tracker ID 113276 Changes End
		var currDate = getCurrentDate();
		/* Tracker-ID 113259:ERPBOCF1:Hijri:BEGIN OF CHANGES*/
		//convert date to hijri format
			if(calType=='H')
			{
				currDate = convertGregToHij(currDate);
			}
		/* Tracker-ID 113259:ERPBOCF1:Hijri:END OF CHANGES*/
		document.getElementsByName('3_AccountBO.RelationshipOpeningDate')[0].value = currDate;
		//changes for 574426 start - call to following function made the Introducer ID mandatory
		//fvDisableObjectIntro();
		//changes for 574426 end
	}

	<!-- Change done as a part of ticket 296094 Starts the below function is not used in any files and the same has no functionality mentioned inside as all coded are commented allready inside this function-->
	/*function introEdit(){
//Tracker ID 113276 Changes Start
	//document.getElementsByName(boName +".IntroducerSalutation")[0].disabled = true;
		//document.getElementsByName("AccountBO.IntroducerName")[0].readOnly = true;
		//document.getElementsByName("AccountBO.IntroducerID")[0].readOnly = true;
//Tracker ID 113276 Changes End

	}*/
    <!-- Change done as a part of ticket 296094 Ends-->
	//CORE Fields Inclusion:end

	// ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 start
	// To disable zakat_deduction field when form loads

	function loadZakat()
	{
	document.getElementsByName(boName+".zakat_deduction")[0].disabled = true;
	}
	// ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 end
	
	function customersocialstatus()
	{
		if(readMode!='Y')
		{	
			var custstatus = document.getElementsByName("AccountBO.StrUserField30")[0].options.value;
			if(custstatus !=''&amp;&amp;custstatus=='N')
			{
			document.getElementsByName('AccountBO.Cust_Swift_Code_Desc')[0].value = ".";
		    	}
			else
			{
			document.getElementsByName('AccountBO.Cust_Swift_Code_Desc')[0].value = '';
			}
		}

	}

	
/* ***** Changes done by sundar for HighRisk category check and mandatory kyc fields : Start ***** */
//Recon for KYC Highrisk start
function Makekycfieldmand()
{
	if(readMode!='Y')
	{
		var highriskcat = document.getElementsByName("AccountBO.StrUserField12")[0].options.value;
		if(highriskcat !=''&amp;&amp;highriskcat!=undefined)
		{
		var today = new Date();

		var date = today.getDate()+'/'+("0"+(today.getMonth()+1))+'/'+ today.getFullYear();
		var next_date = today.getDate()+'/'+("0"+(today.getMonth()+1))+'/'+ (today.getFullYear()+1);


		document.getElementsByName("AccountBO.submitForKYC")[0].value = "Y";
		document.getElementsByName("3_AccountBO.KYC_Date")[0].value = date;
		document.getElementsByName("3_AccountBO.KYC_ReviewDate")[0].value = next_date;
		
		}
		else
		{
			document.getElementsByName("AccountBO.submitForKYC")[0].value = 'N';
			document.getElementsByName("3_AccountBO.KYC_Date")[0].value = '';
			document.getElementsByName("3_AccountBO.KYC_ReviewDate")[0].value = '';
			document.getElementsByName("3_AccountBO.RiskProfileExpiryDate")[0].value = '';
			document.getElementsByName("3_AccountBO.RatingDate")[0].value= '';
		}

	}	
}
//Recon for KYC Highrisk End

/* ***** Changes done by sundar for HighRisk category check and mandatory kyc fields : END ***** */

/* ***** Tracker# 97236 CIF - EBanking Changes : Start ***** */
function checkEbankFields()
{
//Adding If Condition under callId 383435 and recon of call id 370445
if(readMode!='Y')
	{

 	var isEbankingEnabled=document.getElementsByName(boName+".IsEbankingEnabled")[0].value;
  	if(isEbankingEnabled=='Y')
	{	// Changes for the Tracker id: 361934 START
 		document.getElementsByName(boName+".IsSMSBankingEnabled")[0].disabled=false;
		document.getElementsByName(boName+".IsWAPBankingEnabled")[0].disabled=false;
		// Changes for the Tracker id: 361934 END
		/* Changes Begin for Tracker 126433 : SMS Banking Mobile Number should
		be enabled only after we check the SMS Banking check box */
		//Changes for the call id 296094 starts
		document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].disabled=false;
		//Changes for the call id 296094 ends

		/* Changes Begin for Tracker 126433 */
	}
	else
	{
		// Changes for the Tracker id: 361934 START
		document.getElementsByName(boName+".IsSMSBankingEnabled")[0].checked=false;
		document.getElementsByName(boName+".IsSMSBankingEnabled")[0].disabled=true;
		document.getElementsByName(boName+".IsWAPBankingEnabled")[0].checked=false;
		document.getElementsByName(boName+".IsWAPBankingEnabled")[0].disabled=true;
		// Changes for the Tracker id: 361934 END
		document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].disabled=true;
	}

}
}

function isSMSOrWAPEnabled()
{	// Changes for the Tracker id: 361934 START
	var SMSBanking = document.getElementsByName(boName+".IsSMSBankingEnabled")[0];
	var WAPBanking = document.getElementsByName(boName+".IsWAPBankingEnabled")[0];
	// Changes for the Tracker id: 361934 END
	if(isSMSBanking=='Y')
	{
		SMSBanking.checked=true;
        document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].readOnly=false;
	}
	if(isWAPBanking=='Y')
	{
		WAPBanking.checked=true;
	}

	if(readMode=='Y')
	{
		SMSBanking.disabled=true;
		WAPBanking.disabled=true;
        document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].readOnly=true;
	}

}
/* ***** Tracker# 228683  CIF - Basel Changes : Start ***** */
function loadBasel(){
               var sType='No';                 
               if(document.getElementsByName("BaselProfiling")[0]!=undefined){
	            sType = document.getElementsByName("BaselProfiling")[0].options.value;
	       }
	      /* TRACKER ID 232263 changes start */
               var tabID =parent.parent.parent.parent.frames(0).selectTab1("Basel Profiling");
              /* TRACKER ID 232263 changes end */
               var object = eval("parent.parent.IFrm"+tabID);              
		if(sType=='Yes'){
		   bSelected=true;
		   /* TRACKER ID 232263 changes start */
		   parent.parent.parent.parent.frames(0).selectTab1("Basel Profiling");
		   /* TRACKER ID 232263 changes end */
		   eval("parent.parent.parent.parent.tabViewFrm." + tabID + ".style.display = '';");
		   parent.parent.parent.parent.frames(0).selectTab("General");
		}else if(sType=='No' &amp;&amp; bSelected==true &amp;&amp; object!=undefined){
		  ConfirmFlag = showConfirmMessage(MSGJ51929);
		  		if(ConfirmFlag == true)
		  		{
		  		   eval("parent.parent.IFrm" + tabID + ".formDispFrame.closebtn();");
		  		   eval("parent.parent.parent.parent.tabViewFrm." + tabID + ".style.display = 'none';");	
				}else {
				document.getElementsByName("BaselProfiling")[0].value = 'Yes';
				}
		}
		else{		
		if(((isBasel=='N' || isBasel=='') &amp;&amp; tabID!=0) || readMode=='Y'|| isCopy =='Y' ){
			eval("parent.parent.parent.parent.tabViewFrm." + tabID + ".style.display = 'none';");			
		}		
		}
		
		
	}
	<!-- Changes for Track ID 260026 Begin-->
function changeWAPBanking(){
		// Changes for the Tracker id: 361934 START
		var IsWAPBankingEnabled=document.getElementsByName(boName+".IsWAPBankingEnabled")[0].checked;
		if(IsWAPBankingEnabled == true){
		document.getElementsByName(boName+".IsWAPBankingEnabled")[0].value = true ;
		}
		else{
		document.getElementsByName(boName+".IsWAPBankingEnabled")[0].value = false ;
		}
		
		document.frm2.IsWAPBankingEnabled.value=document.getElementsByName(boName+".IsWAPBankingEnabled")[0].value;
		
		// Changes for the Tracker id: 361934 END
	}
	<!-- Changes for Track ID 260026 End-->
/* ***** Tracker# 228683  CIF - Basel Changes : End ***** */
function changeSMSBanking()
{
	// Changes for the Tracker id: 361934 START
 	var IsSMSBankingEnable =document.getElementsByName(boName+".IsSMSBankingEnabled")[0].checked;
 	if(IsSMSBankingEnable == true)
 	// Changes for the Tracker id: 361934 END
	{
        document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].readOnly=false;
        <!-- Changes for Track ID 260026  Begin-->
        	/* Changes for the Tracker id: 361934 START */
		document.getElementsByName(boName+".IsSMSBankingEnabled")[0].value = true ;
		/* Changes for the Tracker id: 361934 	END */
        <!-- Changes for Track ID 260026  End-->
       /* Changes Begin for Tracker 126433 SMS Banking Mobile Number should
	  	be enabled only after we check the SMS Banking check box  */

		document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].disabled=false;
        /* Changes End for Tracker 126433 */
		document.getElementsByName("mandStarAccountBO.SMSBankingMobileNumber")[0].style.visibility = "";
	}
	else{
		    <!-- Changes for Track ID 260026  Begin-->
		    /* Changes for the Tracker id: 361934 START */
        document.getElementsByName(boName+".IsSMSBankingEnabled")[0].value = false;
        	    /* Changes for the Tracker id: 361934 END */
        /*changes for Tracker id:300588 starts here */
        document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].value = "";
         /*changes for Tracker id:300588 Ends here */
        <!-- Changes for Track ID 260026  End-->
		//document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].disabled=true;
        document.getElementsByName("AccountBO.SMSBankingMobileNumber")[0].readOnly=true;
		document.getElementsByName("mandStarAccountBO.SMSBankingMobileNumber")[0].style.visibility = "hidden";
	}
			/* Changes for the Tracker id: 361934 START */
			document.frm2.IsSMSBankingEnabled.value=document.getElementsByName(boName+".IsSMSBankingEnabled")[0].value;
		/* Changes for the Tracker id: 361934 END */
}


<!-- Changes for KYC Enhancement Start-->
function EnableSubmitKYC()
{
var operationType = '<xsl:value-of select="$operationType"/>';

 if(operationType =='Edit Entity' || operationType == 'Queue')
 {
    if(trim(document.getElementsByName("AccountBO.riskRating")[0].value)!='')
    {
    //alert("operationType is "+operationType);
       showMessage(MSG61022);
    document.getElementsByName("AccountBO.submitForKYC")[0].disabled=false;
   }
   else
   {
   document.getElementsByName("AccountBO.submitForKYC")[0].disabled=true;
   }
  }
}
//changes for call id 407866 and recon of call id 400498 starts
<!--changes for call id 414534-recon of 412591 starts-->
function loadSalutation(){ 
	var oType=oldEntityType.toUpperCase();
	if (convToCust == 'Y' &amp;&amp; oType=='NONCUSTOMER'){
		document.getElementsByName("AccountBO.Salutation_code")[0].value = '<xsl:value-of select="$salutationcode"/>';
		document.getElementsByName("Cat_AccountBO.Salutation_code")[0].value ='<xsl:value-of select="$Cat_salutation"/>';
	}
}
<!--changes for call id 414534-recon of 412591 ends-->
//changes for call id 407866 and recon of call id 400498 ends

function loadDisable()
{
//Adding If Condition under callId 383435 and recon of call id 370445
if(readMode!='Y')
{
if( document.getElementsByName("AccountBO.submitForKYC")[0]!=undefined){
//changes done by sundar for KYC submit start
 //document.getElementsByName("AccountBO.submitForKYC")[0].disabled = true;
// changes starts for 508043 start
 //document.getElementsByName("3_AccountBO.KYC_ReviewDate")[0].disabled=true;
 //document.getElementsByName("3_AccountBO.KYC_Date")[0].disabled=true;
 //Changes for Call Id 646570 starts
// document.getElementsByName("cal_AccountBO.KYC_ReviewDate")[0].style.visibility="hidden";
// document.getElementsByName("cal_AccountBO.KYC_Date")[0].style.visibility="hidden";
 //Changes for Call Id 646570 ends
 //document.getElementsByName("AccountBO.KYC_ReviewDate")[0].disabled=true;
 //document.getElementsByName("AccountBO.KYC_Date")[0].disabled=true;
//Fix for ticket id: 666945 starts
 //document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0].disabled=true;
//Fix for ticket id: 666945 ends
 try{
 //document.getElementsByTagName("img")[5].style.display="none";
 <!-- Changes for call id 449231  -->
 //document.getElementsByTagName("img")[6].style.display="none";
 }
 catch(e){}
 //changes done sundar for KYC submit END
// document.getElementsByName("3_AccountBO.KYC_ReviewDate")[0].value='<xsl:value-of select="$KYC_ReviewDate"/>';
// document.getElementsByName("3_AccountBO.KYC_Date")[0].value='<xsl:value-of select="$KYC_Date"/>';
// document.getElementsByName("AccountBO.submitForKYC")[0].value = '<xsl:value-of select="$submitForKYC"/>';
 document.getElementsByName("AccountBO.KYC_ReviewDate")[0].value='<xsl:value-of select="$KYC_ReviewDate"/>';
 document.getElementsByName("AccountBO.KYC_Date")[0].value='<xsl:value-of select="$KYC_Date"/>';
 document.getElementsByName("AccountBO.riskRating")[0].value = '<xsl:value-of select="$riskRating"/>';
}
}
}
<!-- Changes for KYC Enhancement End-->

/* Ticket Id 203095 - Begin
   function sets the value of isPreffered radio button of Identification docs to true.
   fn is also called on form load */
function introdSalutation(){
/*Changes for call id 406431*/
	if(document.frm2.byPassFlag.value!='Y')
	{
		document.getElementsByName(boName+".IntroducerSalutation")[0].value = '<xsl:value-of select="$IntroducerSalutation"/>';
		 //Changes for call id 410026 and recon of call id 407523 starts
		//document.getElementsByName("Cat_"+boName+".IntroducerSalutation")[0].value = '<xsl:value-of select="$IntroducerSalutation"/>';
		document.getElementsByName("Cat_"+boName+".IntroducerSalutation")[0].value = IntroSalText;
		 //Changes for call id 410026 and recon of call id 407523 ends
	}
}

function setDefaultRadio(){
// fix for defect id:210006 starts

if(document.frm2.radio1 != undefined){
// Begin Of Call ID 297589
for (i=2; i &lt; document.all.EDocRecordSet.rows.length; i++){
var isPref = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.PreferredUniqueId");
if(isPref == 'Y'){
 var radio_ident = document.getElementsByName("radio1")[i-2];
 radio_ident.checked = true;
 break;
}
}
//End Of Call ID 297589
}
}
/* Ticket Id 203095 - End */


/* ***** Tracker# 97236 CIF - EBanking Changes : End ***** */
    </script>
     </head>
     <!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 start-->
     <body class="popup"  onkeypress="onLoadSetTime()" onclick="onLoadSetTime()">
	<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 end-->
     <xsl:choose>
     <xsl:when test="normalize-space($accountURL)=''">
     <!-- adding loadID() and load2() for identification changes by tracker ID 113276 -->
     <!-- changes for ticket no  183689 start -->
        <!-- <xsl:attribute name="onload">checkEbankFields();populateAccContAttr();load();introCreate();hideMinor();makeDateMand();showbuttonsVisible(45);formatAmountCust();formatUser();storeSegment();bodyOnLoad();setFocusOnComp(boName+'.Cust_First_Name');setDefStatus();showFormTips();isTFPartyFlag(); -->
        <!-- DEF-333 Begin of Changes-->
	<!--Changes for alert server recon in 10.2.14 starts-->
	<!--changes for call id 407866 and recon of call id 400498 starts added function loadSalutation()-->
	<!--changes for call id 414534-recon for 412591 starts-same as 407866-->
	<xsl:attribute name="onload">LoadSector();custCrncyPopulate();custCrncyPopulate1();custCrncyPopulate2();custCrncyPopulate3();load();validateStaffFlag();loadDisable();custFnLoad();loadSalutation();introdSalutation();selectFieldAcc();
	<!--changes for call id 414534-recon for 412591 ends-->
	<!--changes for call id 407866 and recon of call id 400498 ends-->
	<!--Changes for alert server recon in 10.2.14 ends-->
	<!-- Changes for Tracker id 148280 Start  -->
	<!--Tracker 149090 changes starts -->
	<!--Tracker 239165 changes starts -->
	<!-- Changes for 400757 and recon for 392665 and 561329 start-->
	<!-- Fix for ticket 297660 ,removed call to function clearsol()--><!--Changes for tracker id 336788 STARTS-->load2();fnSetCustStatus();fnCheckCustStatus('Y');checkEbankFields();loadSubSeg();changeSubSeg();loadSegVal();DisableGcifIdLookUp();bodyOnLoad();Toggle('native');focusFirstField();populateAccContAttr();disable_LookUp();loadZakat();setCurrencyArraysOnConvToCust();loadID();isTFPartyFlag();loadBasel();hideMinor();checkAge();checkAgeSC();makeDateMand();showbuttonsVisible(45);introCreate();formatAmountCust();formatUser();storeSegment();bodyOnLoad();setFocusOnComp(boName+'.Cust_First_Name');setDefStatus();showFormTips();DisplayLookUPIntro();swifta();SwiftCodeOnLoad();<!--Changes for tracker id 336788 ENDS-->
	<!-- Changes for 400757 and recon for 392665 and 561329 end -->
	<!--Tracker 239165 changes ends -->
	<!-- Changes for Tracker id 148280 End  -->
	<!--Tracker 149090 changes ends -->
	<!-- DEF-333 End of Changes-->
		<!-- changes for ticket no 183689 end -->
        </xsl:attribute>
     </xsl:when>
     <xsl:when test="normalize-space($readMode)='Y'">
     <!--Fix for ticket no.200873:Starts-->

        <!--Fix for ticket no.200873:Starts-->
        <!-- changes for ticket 238226  start -->
	<!-- <xsl:attribute name="onload">loadSubSeg();loadSegVal();Toggle('native');chkBSN();isSMSOrWAPEnabled();populateAccContAttr();isCard_holder();showInReadOnlyMode('  <xsl:value-of select="$readMode" /> ');load2();loadID();hideMinor();formatAmountCust();formatUser();bodyOnLoad();isTFPartyFlag(); -->
      <!-- Fix for ticket 200301 start-->
     <!-- changing the position of calls to function loadID() and load2()-->
     <!-- Ticket Id 203095 - Begin
   	  function setDefaultRadio() is added It sets the value of isPreffered radio button of Identification docs to true. -->
   	  <!--Tracker 204611 changes starts -->
   	  <!-- changes for ticket 238226  start -->
	  <!--Tracker 144178 changes starts -->
	  <!--Tracker 161937 changes starts for minor tab not to load -->
      <!-- Change done as a part of ticket 296094 Starts disable_LookUp() function is added on load in read mode alone-->
	  <!--Tracker 239165 changes starts -->
	  <!-- changes for tracker 258351 starts -->
	  <!-- changes for tracker 438296 starts -->
      <!-- Changes for Ticket id 488498 -->
<!--   Fix for ticket id 549260 starts    -->
<!-- Changes for tracker id 334116 starts-->
     <!-- Changes for tracker id 356459 starts for minor not to load loadDisable() is called after hideMinor() & checkAge() functions  -->
	<!-- changes for tracker 361545-->
	<!--Changes for Alert Serve rrecon in 10.2.14 starts-->
<!-- Changes for 400757 and recon for 392665 and 561329 starts -->
      <xsl:attribute name="onload">bodyOnLoad();showInReadOnlyMode('<xsl:value-of select="$readMode" />');introdSalutation();LoadSector();validateStaffFlag();load2();loadSubSeg();changeSubSeg();loadSegVal();setCurrencyArraysOnConvToCust();loadID();hideMinor();checkAge();loadDisable();setDefaultRadio();disable_LookUp();populateAccContAttr();checkEbankFields();isTFPartyFlag();loadBasel();Toggle('native');swifta();chkBSN();isSMSOrWAPEnabled();isCard_holder();formatAmountCust();formatUser();bodyOnLoad();getSelectedItem();selectFieldAcc();SwiftCodeOnLoad();<!--fix for ticket 281657 -->
<!-- Changes for 400757 and recon for 392665 and 561329 ends -->
      <!--Changes for Alert Serve rrecon in 10.2.14 ends-->
      <!-- Changes for tracker id 356459 ends -->
<!--   Fix for ticket id 549260 ends    -->
	  <!-- Changes for Ticket id 488498 end-->
          <!-- changes for tracker 258351 starts -->
      <!-- changes for tracker 258351 ends -->
	  <!--Tracker 239165 changes ends -->
      <!-- Change done as a part of ticket 296094 Ends -->
     <!-- checkEbankFields();loadSubSeg();loadSegVal();bodyOnLoad();isTFPartyFlag();hideMinor();checkAge();checkAgeSC();Toggle('native');load2();swifta();loadID();chkBSN();isSMSOrWAPEnabled();setDefaultRadio();populateAccContAttr();isCard_holder();formatAmountCust();formatUser();bodyOnLoad();-->
        </xsl:attribute>
        <!--Tracker 161937 changes end -->
       <!--Tracker 144178 changes end -->
<!--Changes for recon 399817,callid 395609 starts -->
     </xsl:when>
      <xsl:when test="($apprFlag) ='false'">
      <xsl:attribute name="onload">loadCurr();LoadSector();bodyOnLoad();showInReadOnlyMode('<xsl:value-of select="$readMode" />');introdSalutation();validateStaffFlag();load2();loadSubSeg();changeSubSeg();loadSegVal();loadID();hideMinor();checkAge();loadDisable();setDefaultRadio();disable_LookUp();populateAccContAttr();checkEbankFields();isTFPartyFlag();loadBasel();Toggle('native');swifta();chkBSN();isSMSOrWAPEnabled();isCard_holder();formatAmountCust();formatUser();bodyOnLoad();getSelectedItem();selectFieldAcc();</xsl:attribute>
      </xsl:when>
     <xsl:otherwise>
<!--Changes for recon 399817,callid 395609 ends -->
     <!-- Fix for ticket 200301 start-->
     <!-- changing the position of calls to function loadID() and load2()-->
		<!-- Ticket Id 203095 - Begin-->
		<!--function setDefaultRadio() is added It sets the value of isPreffered radio button of Identification docs to true. -->
	<!-- changes for ticket 238226  start -->
	<!-- changes for tracker 147545 start : clearDummyAddress() is called before fnNullifyDummyCustFlds -->
	<!-- Changes for Tracker id 148280 Start  -->
	<!-- Changes for Tracker 161937 Start  -->
   	<!-- ticket id: 330818 changes begin -->
	<!-- Changes for ticket 336240 starts -->
	<!--Tracker 239165 changes starts -->
  <!-- changes for tracker id : 254121  / ticket id : 418189  and tracker id 258516 start -->
    <!--<xsl:attribute name="onload">load2();loadSubSeg();changeSubSeg();showbuttonsVisible(30);DisableGcifIdLookUp();bodyOnLoad();focusFirstField();loadID();hideFields();Toggle('native');hideMinor();checkAge();checkAgeSC();loadSegVal();makeDateMand();clearDummyAddress('<xsl:value-of select="$IsDummy"/>');fnNullifyDummyCustFlds('<xsl:value-of select="$IsDummy"/>');chkBSN();isSMSOrWAPEnabled();changeSMSBanking();checkEbankFields();populateAccContAttr();isTFPartyFlag();loadBasel();showbuttonsVisible(30);showFormTips();isDocument_Received();isPurgeFlag();isCard_holder();introEdit();formatAmountCust();formatUser();bodyOnLoad();load();--><!-- fix for ticket 281657-->
          <!-- Changes for Track ID 223945  Begin-->	
        <!--Changes for Tracker id 336800 starts-->
		        <!--Changes for Tracker id 344214 starts-->
		        <!--Changes for Tracker id 353397 starts-->
	 <!-- Changes for Call id: 348408 and recon for 340338 starts-->
   	<!-- Changes for 400757 and recon for 392665 and 561329 start -->
	<xsl:attribute name="onload">introdSalutation();chkBSN();LoadSector();validateStaffFlag();loadDisable();load2();hidedata();loadSubSeg();changeSubSeg();loadSegVal();setCurrencyArraysOnConvToCust();loadID();fnSetCustStatus();fnCheckCustStatus('Y');showbuttonsVisible(30);DisableGcifIdLookUp();bodyOnLoad();focusFirstField();hideFields();Toggle('native');hideMinor();checkAge();checkAgeSC();makeDateMand();clearDummyAddress('<xsl:value-of select="$IsDummy"/>');fnNullifyDummyCustFlds('<xsl:value-of select="$IsDummy"/>');isSMSOrWAPEnabled();checkEbankFields();changeSMSBanking();changeWAPBanking();populateAccContAttr();isTFPartyFlag();loadBasel();showbuttonsVisible(30);showFormTips();isDocument_Received();isPurgeFlag();selectFieldAcc();mandateDefault();isCard_holder();formatAmountCust();formatUser();bodyOnLoad();SwiftCodeOnLoad();load();<!-- fix for ticket 281657-->
   	<!-- Changes for 400757 and recon for 392665 and 561329 end -->
     <!-- Changes for Call id: 348408 and recon for 340338 ends-->
		        <!--Changes for Tracker id 353397 ends-->
		        <!--Changes for Tracker id 344214 ends-->
	 <!--Changes for Tracker id 336800 ends-->
	<!-- Changes for Track ID 223945 End-->
	<!--Tracker 239165 and 258516 changes ends -->
	<!-- Changes for ticket 336240 ends -->
	<!-- ticket id: 330818 changes end -->
	<!-- Changes for Tracker 161937 End  -->
	<!-- Changes for Tracker id 148280 End  -->
	<!--Ticket Id 203095 - End -->
		<!-- changes for ticket 238226  Ends Finally -->
     <!-- Fix for ticket 200301 end-->
        </xsl:attribute>
        <!-- changes for tracker id : 254121  / ticket id : 418189 end -->
     </xsl:otherwise>
     </xsl:choose>
     	<!-- changes for tracker id 338859 starts-->
        <!--<script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>-->
        <script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
        <!--performance patch:Commenting duplicate js call:354529-->
        <!--<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>-->
        <!--<script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>-->
        <script type="text/javascript" src="../common/js/ListBoxFunctions.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>
        <!--<script type="text/html" src="../Renderer/wizards/html/CifShowButtons.html"></script>
        <script type="text/html" src="../Renderer/wizards/html/ShowButtons.html"></script>-->
        <!-- changes for tracker id 338859 ends-->
        <script type="text/javascript" language="javascript" src="../Customization/54/cif/js/Account.js"></script>
	<!-- CIF PhoneEmail Changes : Start -->
	<script type="text/javascript" language="javascript" src="../Customization/cif/js/CIFCustomerAddress.js"></script>
	<!-- Changes for Ticket 725047 begin -->
	 <script type="text/javascript" language="javascript" src="../cif/js/CIFCustomerAddress_Reduced.js"></script>
	<!-- Changes for Ticket 725047 ends -->
	<script type="text/javascript" language="javascript" src="../Customization/cif/js/CIFPhoneEmail.js"></script>
	<!-- CIF PhoneEmail Changes : End -->

        <!--CIF Changes Naved Start -->
        <script type="text/javascript" language="javascript" src="../cif/js/HouseHold.js"></script>
     	<!--CIF Changes Naved End -->
     	<!-- changes by bharath to import custom javascrit file -->
	<script type="text/javascript" src="../Customization/cif/js/CustNameLength.js" language="javascript"></script>
     	<script type="text/javascript" language="javascript">
        var lookupFor = '';
        var accLookUpWin = null;
        var DataArray = new Array;
        var baseCurrency = null;
        <!--Changes for call id 406159 recon of 402339 start-->
        var BaseCurrency_Desc=null;
        <!--Changes for call id 406159 recon of 402339 ends-->
        var isMinor = null;
        <!-- Senior Citizen--> var isSenior=null;
        var Screen = 0;
		var TabValidator = '<xsl:value-of select="$TabValidator"/>';
		var ModIsDummy = '<xsl:value-of select="$ModIsDummy"/>';
		<!-- Deceased CIF Starts-->
		var variable9 = "<xsl:value-of select="$SRMTips"></xsl:value-of>";
		<!-- Deceased CIF Ends-->
<![CDATA[function showFormTips() {
parent.parent.parent.parent.removeTips(parent.parent.parent.parent.frames(0).getSelectedTabId());
parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(),"]]><xsl:value-of select="$SRMTips"/><![CDATA[");
parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(), cifMessage);
parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames(0).getSelectedTabId());
parent.parent.parent.parent.showTipsButton();
}
]]>

     var isReadOnly;
     function swifta()
     {

            try{document.getElementsByName("SWIFT_ADDRESS_DETAILS")[0].disabled = false;}

            catch(e){alert(e.message);}


		isReadOnly="Y";

		/* CHANGES FOR TICKET ID :  247324 */

		//document.getElementsByName("Close")[0].disabled = false;
	    }
     function checkAge()
	    {
	     	//Fix for tracker 361528
	     	var minor1 = document.getElementsByName(boName+".CustomerMinor")[0].value;
	     	//Fix for ticket 383028 starts
	    		 if(editMode==true &amp; minor1!='Y'){
	    		hideMinor();
			 }
		//Fix for ticket 383028 ends
	    /*ticket id 330318 changes Begin */
			//if(editMode==false){//Fix for ticket 383028
		/*ticket id 330318 changes end */
		  var acc= '<xsl:value-of select="$accountID"/>';

		  var flagRelType = '<xsl:value-of select="$flagRelType"/>';
		//Changes for call id 348199 starts
		  var flagRelType1 = '<xsl:value-of select="$flagRelType1"/>';
		//Changes for call id 348199 ends
		  var custURL = '<xsl:value-of select="$accountURL"/>';
		// CRM101UB changes
		// fix for defect id:210006 starts
				if(readMode=='Y')
				{
				var dob = document.getElementsByName("AccountBO.Cust_DOB")[0].value;
				}
				else
				{
				var dob = document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
		}
		// fix for defect id:210006 ends

		   var minor = document.getElementsByName(boName+".CustomerMinor")[0].value;
		if (dob == '' )
		  {
		  if(minor !=null &amp; minor != ''){
		  showMessage(MSGX0004);
		  document.getElementsByName(boName+".CustomerMinor")[0].value='';
		  document.getElementsByName("3_AccountBO.Cust_DOB")[0].focus();
		  return;
		  }
		   }
		  else{
		  // CRM101UB changes : start
			var dtFormDOB = gettingDateFormats();

			if(dtFormDOB == 'MM/dd/yyyy' || dtFormDOB == 'MM-dd-yyyy'){
				var  dobDay=dob.substring(3,5);
				var  strMonth=dob.substring(0,2);
				var  dobYear=dob.substring(6,10);
			}
			else{
				var  dobDay=dob.substring(0,2);
				var  strMonth=dob.substring(3,5);
				var  dobYear=dob.substring(6,10);
			}
			// CRM101 UB changes : end
			  <!--TRACKER# 98518 CHANGES -->
			  isMinor = IsMinor(dobDay,strMonth,dobYear);
			  if(isMinor=='false')
			  {
			  hideMinor();

			// fix for defect id:209637 starts
			 //document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].value =  '';
				if(readMode=='Y')
				{
					//Changes for call id 383435 and recon of call id 370445 starts
					if (document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0])
					document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].value =  '';
					//Changes for call id 383435 and recon of call id 370445 ends
				}
				else
				{
				//changes for the ticket id 296094 starts
			 	 	document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].value	= '';
			 	//changes for the ticket id 296094 ends
				}
			// fix for defect id:209637 ends


				if(document.getElementsByName(boName+".CustomerMinor")[0].value=='Y')
				{
					 showMessage(MSGX0005);
					 document.getElementsByName(boName+".CustomerMinor")[0].value='N';
					 /****Fix for tracker 186307*****/
					 //Changes for call id 383435 and recon of call id 370445 starts
					 if (document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0])
					 document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].value =  '';
					 //Changes for call id 383435 and recon of call id 370445 ends
					 /****Fix for tracker 186307*****/
				 }
				 else
				 {
					document.getElementsByName(boName+".CustomerMinor")[0].value='N';
					/*******recon changes for tracker id 274712 start *************/
					//Changes for call id 383435 and recon of call id 370445 ends
					if (document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0])
					document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].value ="";
					//Changes for call id 383435 and recon of call id 370445 ends
					/*******recon changes for tracker id 274712 end *************/
				}
			  }
			<![CDATA[  else if(custURL!="" && flagRelType=="true"){
		<!-- CRM70t-ST :TRACKER# 79264 **BEGIN OF CHANGES ** -->
				if(document.getElementsByName(boName+".CustomerMinor")[0].value=='N')
				{
					 showMessage(MSGX0006);
					 document.getElementsByName(boName+".CustomerMinor")[0].value='Y';
				}
		<!-- CRM70t-ST :TRACKER# 79264 **END OF CHANGES ** -->
				hideMinor();


				//to calculate majorYear start

				   var majorDate = MajorDate(dobDay,strMonth,dobYear);
				   document.getElementsByName("MinorAttainMajorDate")[0].value	=  majorDate;
				   document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].disabled = false;
				   document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].readOnly = true;
				   document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].value	=  majorDate;
				<!-- Tracker id 113276 MATP FIX changes start for Auto pouplated date Minor Turned Major On date (CIF retail->New Entity> Customer> Genreal>Basic info)is coming in Gregorian when SSO Calender is Hijri for retail Customer.-->

				isGregDate("3_AccountBO.MinorAttainMajorDate");
				<!-- Tracker id 113276 MATP FIX changes end for Auto pouplated date Minor Turned Major On date (CIF retail->New Entity> Customer> Genreal>Basic info)is coming in Gregorian when SSO Calender is Hijri for retail Customer.-->


				//to calculate majorYear end

			  }]]>
			else {

			if(document.getElementsByName(boName+".CustomerMinor")[0].value=='N')
			{
				 showMessage(MSGX0006);
				 document.getElementsByName(boName+".CustomerMinor")[0].value='Y';
				 /****recon changes for tracker id 274712 start******/
			if(MinorAttainMajorDate=="")//saved major->minor in edit screen
			{document.getElementById("td_tpageCont2").disabled = false;
			document.getElementById("td_tpageCont2").style.visibility="visible";
			document.getElementById("det_tpageCont2").style.visibility="visible";
			showTabFortabDemoForm('tpageCont2');
			loadMinor();
			}
			var majorDate = MajorDate(dobDay,strMonth,dobYear);
			 document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].value	=  majorDate;
			/***** tracker id 274712 recon changes end****/
			}
			else		//new minor or minor->minor
			{
			/*********recon for tracker id 274712 changes start**************/
			
			if(MinorAttainMajorDate=="" &amp; document.getElementsByName(boName+".CustomerMinor")[0].value=='' )//new minor in create screen
			{
			document.getElementsByName(boName+".CustomerMinor")[0].value='Y';
			document.getElementById("td_tpageCont2").disabled = false;
			document.getElementById("td_tpageCont2").style.visibility="visible";
			document.getElementById("det_tpageCont2").style.visibility="visible";
			loadMinor();
			showTabFortabDemoForm('tpageCont2');
			showMessage(MSGX0006);
			
			}			
			

			else		//minor to minor change	
			{	
			
			// Ticket 281657 changes end
			if(readMode!='Y')
			{
			if(MinorAttainMajorDate=="") //we are not editing a minor entity
			{
				
			document.getElementById("td_tpageCont2").disabled = false;
			document.getElementById("td_tpageCont2").style.visibility="visible";
			document.getElementById("det_tpageCont2").style.visibility="visible";
			//showTabFortabDemoForm('tpageCont2');
			//loadMinor();
			
			}
			else{	//editing a minor entity
			
			//Changes for call id 348199 starts
			if(flagRelType1=="false")
			{
			
			document.getElementById("td_tpageCont2").disabled = false;
						document.getElementById("td_tpageCont2").style.visibility="visible";
						document.getElementById("det_tpageCont2").style.visibility="visible";
						loadMinor();
			showTabFortabDemoForm('tpageCont2');
			
			}else{
			document.getElementById("td_tpageCont2").disabled = true;
			document.getElementById("td_tpageCont2").style.visibility="hidden";
			document.getElementById("det_tpageCont2").style.visibility="hidden";
			}
			}
			}else{
			document.getElementById("td_tpageCont2").disabled = true;
			document.getElementById("td_tpageCont2").style.visibility="hidden";
			document.getElementById("det_tpageCont2").style.visibility="hidden";
			}
			}
			// Ticket 281657 changes end
			//to calculate majorYear start

			   var majorDate = MajorDate(dobDay,strMonth,dobYear);
			   document.getElementsByName("MinorAttainMajorDate")[0].value	=  majorDate;


			// fix for defect id:209637 starts

			if(readMode=='Y')
			{

			 	document.getElementsByName("AccountBO.MinorAttainMajorDate")[0].disabled = false;
			 	document.getElementsByName("AccountBO.MinorAttainMajorDate")[0].readOnly = true;
			 	document.getElementsByName("AccountBO.MinorAttainMajorDate")[0].value	=  majorDate;
			 	isGregDate("AccountBO.MinorAttainMajorDate");

			}
			else
			{

			   document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].disabled = false;
			   document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].readOnly = true;
			   document.getElementsByName("3_AccountBO.MinorAttainMajorDate")[0].value	=  majorDate;
			   <!-- Fix as a part of tracker 186088 starts -->
 		   	   <!-- Fix as a part of tracker 186088 Ends -->
 		   	<!-- Tracker id 113276 MATP FIX changes start for Auto pouplated date Minor Turned Major On date (CIF retail->New Entity> Customer> Genreal>Basic info)is coming in Gregorian when SSO Calender is Hijri for retail Customer.-->

			  isGregDate("3_AccountBO.MinorAttainMajorDate");
			  }

		  // fix for defect id:209637 ends

			 <!--Tracker id 113276 MATP FIX changes end for Auto pouplated date Minor Turned Major On date (CIF retail->New Entity> Customer> Genreal>Basic info)is coming in Gregorian when SSO Calender is Hijri for retail Customer.-->

 		   	//to calculate majorYear end
			}
		  }
		    /*ticket id 330318 changes Begin */
		 // }//Fix for ticket 383028
		 /*ticket id 330318 chnages end*/

	    }
	    }
	    
	 <!-- Senior Citizen Starts-->
	    
	    function checkAgeSC()
	    	    {
	    		  var acc= '<xsl:value-of select="$accountID"/>';
	    
	    		  var flagRelType = '<xsl:value-of select="$flagRelType"/>';
	    		  var custURL = '<xsl:value-of select="$accountURL"/>';
	    		  
	    				if(readMode=='Y')
	    				{
	    				var dob = document.getElementsByName("AccountBO.Cust_DOB")[0].value;
	    				}
	    				else
	    				{
	    				var dob = document.getElementsByName("3_AccountBO.Cust_DOB")[0].value;
	    				}
	    		
	    
	    		   var senior = document.getElementsByName(boName+".SeniorCitizen")[0].value;
	    		if (dob == '' )
	    		  {
	    		  if(senior !=null &amp; senior != ''){
	    		  showMessage(MSGX0004);
	    		  document.getElementsByName(boName+".SeniorCitizen")[0].value='';
	    		  document.getElementsByName("3_AccountBO.Cust_DOB")[0].focus();
	    		  return;
	    		  }
	    		   }
	    		  else{
	    			var dtFormDOB = gettingDateFormats();
	    
	    			if(dtFormDOB == 'MM/dd/yyyy' || dtFormDOB == 'MM-dd-yyyy'){
	    				var  dobDay=dob.substring(3,5);
	    				var  strMonth=dob.substring(0,2);
	    				var  dobYear=dob.substring(6,10);
	    			}
	    			else{
	    				var  dobDay=dob.substring(0,2);
	    				var  strMonth=dob.substring(3,5);
	    				var  dobYear=dob.substring(6,10);
	    			}
	    			 isSenior = IsSenior(dobDay,strMonth,dobYear);
	    			  if(isSenior=='false')
	    			  {	    			  
	    			  if(readMode=='Y')
	    				{
	    					document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].value = '';
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
	    				   document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].disabled = false;
	    				   document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].readOnly = true;
	    
	    				isGregDate("3_AccountBO.SenCitizenApplicableDate");	    
	    			  }]]>
	    			else {
	    			if(document.getElementsByName(boName+".SeniorCitizen")[0].value=='N')
	    			{
	    			
	    			 showMessage(MSGJ62343);
	    				 document.getElementsByName(boName+".SeniorCitizen")[0].value='Y';
	    			var seniorDate = SeniorDate(dobDay,strMonth,dobYear);
	    			 document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].value	=  seniorDate;
	    			}
	    			else		
	    			{
	    			document.getElementsByName(boName+".SeniorCitizen")[0].value='Y';
	    			
	    			   var seniorDate = SeniorDate(dobDay,strMonth,dobYear);
	    			   document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].value	=  seniorDate;
	    			   showMessage(MSGJ62343);
	    	    
	    			if(readMode=='Y')
	    			{
	    			 	document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].value	=  seniorDate;
	    			 	isGregDate("3_AccountBO.SenCitizenApplicableDate");
	    
	    			}
	    			else
	    			{
	    
	    			  document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].disabled = false;
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
	    		 document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].disabled = false;
	    		 document.getElementsByName("3_AccountBO.SenCitizenApplicableDate")[0].readOnly = true;
	    	    }
	    }
	    
	    
	    <!-- Senior Citizen Ends-->
	    
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
	/* BEGIN OF CHANGES BY SUBODH_MALIK
	 * DRopdown value should get refreshed each time this is called
	 * HENCE UN COMMENTING THE CODE
	 */
	ele2.options.length = 0;
	/* END OF CHANGES */
	ele2.options[0] = new Option('','');
	/*Changes for Tracker:138505*/
	var segValues = segment.split("$");
	//Changes starts for TrackerID: 234910
	//var segRat = segmentRating.split("$");
	var segRat = chargeCode ;
	//Changes starts for TrackerID: 234910
	var subSeg = subSegment.split("$");
	var subSegCode = subSegmentCode.split("$");
	//alert("...subSeg.."+subSegment);
	//alert("...subSegmentRating.."+subSegmentRating);
	var subSegRat = subSegmentRating.split("$");
	/*Changes for Tracker:138505*/
	var segrating = '';
	if(ele1.value != '' && ele1.value != null ){
		for(i=0; i<segValues.length; i++){
			if(segValues[i] == ele1.value){
			//Changes starts for TrackerID: 234910
				segrating = segRat;
				//Changes starts for TrackerID: 234910
			}
		}
		//Changes starts for TrackerID: 234910
		if(serviceLevelCode == ele1.value)
		   segrating = segRat;
		   //Changes starts for TrackerID: 234910
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
	ele2.options[k] = new Option( subSeg[j],subSegCode[j]);
	k++;
	}

	}
	}
	/*Changes for Tracker:138505END*/

	/*change for ticket 262742*/
	if(subSegRat[j] == ele1.value){
		ele2.options[k] = new Option(subSeg[j],subSegCode[j]);
		k++;
	}

	}
	}
//Fix for ticket 211061 changes start
<!-- Change done as a part of ticket 296094 Starts below condition used for IF loop is alllready been done in the calling function-->
	<!-- 10.2 fix Tracker 186973 - Reverting change for ticket 296094, as this area of code is called in onload itself -->
	if(segrating != null && segrating != 'null') {
		<!-- TrackerID:209607,CHANGES START -->
		//Changes starts for TrackerID: 234910
		document.getElementsByName("AccountBO.ChargeLevelCode")[0].value = codechargeCode;
	//document.getElementsByName("AccountBO.ChargeLevelCode")[0].value = segrating;
	//Changes starts for TrackerID: 234910
	}
	else {
		document.getElementsByName("AccountBO.ChargeLevelCode")[0].value = '';
		<!-- TrackerID:209607,CHANGES END -->
	}
<!-- Change done as a part of ticket 296094 Ends-->
//Fix for ticket 211061 changes end
	<!-- Core dependency changes start-->
	return segrating;
        <!-- Core dependency changes end-->

}

<!--Isic function by Silveste starts-->
	function SegmentValidation()
	{
		//alert("james test 7");
		var source = document.getElementsByName(boName+".strField9")[0].value;	
		//alert(source);	
		if(source =='Y')
		{
		//alert("segmentvalidation works");
		document.getElementsByName(boName+".StrUserField6")[0].IsMandatory = "true";
		document.getElementsByName(boName+".StrUserField7")[0].IsMandatory = "true";
		document.getElementsByName(boName+".StrUserField2")[0].IsMandatory = "true";
		document.getElementsByName(boName+".StrUserField23")[0].IsMandatory = "true";
		document.getElementsByName(boName+".StrUserField3")[0].IsMandatory = "true";
		document.getElementsByName(boName+".StrUserField9")[0].IsMandatory = "true";
		}
	}

<!--Isic function by Silveste ends-->

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
	// Change for ticket 367607 starts	
 // Recon of Changes for Call 391057 starts
	/*var ele3 = document.getElementsByName(boName+".Pref_code")[0];
	if( preferenceCode!= '' && preferenceCode!= null){
		for(i=0;i<ele3.options.length;i++)
		{
			if(ele3.options[i].value==preferenceCode)
			{
			ele3.selectedIndex=i
			break;
			}

		}
	} */
	// Change for ticket 367607 ends
  
try{
	
	if( Cat_prefcode!= '' && Cat_prefcode!= null)
       document.getElementsByName("Cat_AccountBO.Pref_code")[0].value =Cat_prefcode;
       if( prefcode!= '' && prefcode!= null)
	document.getElementsByName("AccountBO.Pref_code")[0].value =prefcode;
	}catch(e){
	
	} 
// Recon of Change for Call 391057 end

	}
]]>
	function loadMinor(){


		    document.frm2.minorLoaded.value="true";

		    loading = "true";
		    DisplayLookUP();
			 // Recon of 393528 Callid changes	for 396515	
			document.getElementsByName("RelationshipBO.Relationship")[0].value="GUARDIAN";
		    document.getElementsByName("RelationshipBO.Relationship")[0].disabled = true;
		    document.getElementsByName("RelationshipBO.Guard_Code")[0].disabled = false;

		    document.getElementsByName("ContactBO.lastName")[0].IsMandatory = "true";
		   //Fix for callid:430243 Starts
		   //to disable autopopulated fields on load of minor tab
			document.getElementsByName("ContactBO.lastName")[0].readOnly = true;//Change for call id 709346
			document.getElementsByName("ContactBO.middleName")[0].disabled = true;//priya
			document.getElementsByName("ContactBO.firstName")[0].disabled = true;//priya
			document.getElementsByName("ContactBO.Contact_Last_Name_Native")[0].disabled = true;//priya
			document.getElementsByName("ContactBO.Contact_Middle_Name_Native")[0].disabled = true;//priya
			document.getElementsByName("ContactBO.Contact_First_Name_Native")[0].disabled = true;//priya
			document.getElementsByName("3_ContactBO.DOB")[0].disabled = true;//priya
			document.getElementsByName("ContactBO.salutation")[0].disabled = true;//priya
			document.getElementsByName("ContactBO.gender")[0].disabled = true;//priya
			document.getElementsByName("ContactBO.contactsKey")[0].disabled = true;
			//Fix for callid:430243 ends

		// fix for defect id:209637 starts

			if(readMode != 'Y')
			{
		    document.getElementsByName("3_ContactBO.DOB")[0].IsMandatory = "true";
			}
			  <!-- TRACKER ID 148769 CHANGES BEGIN -->
		else{
				document.getElementsByName("ContactBO.salutation")[0].value='<xsl:value-of select="$salutation"/>';
				document.getElementsByName("ContactBO.firstName")[0].value='<xsl:value-of select="$fName"/>';
				document.getElementsByName("ContactBO.lastName")[0].value='<xsl:value-of select="$lName"/>';
				document.getElementsByName("ContactBO.middleName")[0].value='<xsl:value-of select="$mName"/>';
				document.getElementsByName("ContactBO.gender")[0].value='<xsl:value-of select="$gender"/>';
				document.getElementsByName("ContactBO.contactsKey")[0].value ='<xsl:value-of select="$key"/>';
			 	document.getElementsByName("RelationshipBO.Bank_Entity")[0].value='<xsl:value-of select="$Bank_Entity"/>';
			 	document.getElementsByName("RelationshipBO.Relationship")[0].value='<xsl:value-of select="$relation"/>';
			 	document.getElementsByName("RelationshipBO.Guard_Code")[0].value='<xsl:value-of select="$gCode"/>';
			 	//document.getElementsByName("3_ContactBO.DOB")[0].value='<xsl:value-of select="$dob"/>';

			 // For making these fields ReadOnly
				document.getElementsByName("ContactBO.salutation")[0].disabled="true";
				document.getElementsByName("ContactBO.firstName")[0].readOnly="true";
				document.getElementsByName("ContactBO.lastName")[0].readOnly="true";
				document.getElementsByName("ContactBO.middleName")[0].readOnly="true";
				document.getElementsByName("ContactBO.gender")[0].disabled="true";
				document.getElementsByName("ContactBO.contactsKey")[0].readOnly ="true";
				//document.getElementsByName("RelationshipBO.Bank_Entity")[0].disabled="true";
				document.getElementsByName("RelationshipBO.Relationship")[0].readOnly="true";
				document.getElementsByName("RelationshipBO.Guard_Code")[0].disabled="true";
				//document.getElementsByName("3_ContactBO.DOB")[0].disabled="true";
			}
			//alert('editMode>>>>>'+editMode);
			if (editMode == true){
			document.getElementsByName("ContactBO.salutation")[0].value='<xsl:value-of select="$salutation"/>';
			document.getElementsByName("ContactBO.firstName")[0].value='<xsl:value-of select="$fName"/>';
			document.getElementsByName("ContactBO.lastName")[0].value='<xsl:value-of select="$lName"/>';
			document.getElementsByName("ContactBO.middleName")[0].value='<xsl:value-of select="$mName"/>';
			document.getElementsByName("ContactBO.gender")[0].value='<xsl:value-of select="$gender"/>';
			document.getElementsByName("ContactBO.contactsKey")[0].value ='<xsl:value-of select="$key"/>';
			document.getElementsByName("RelationshipBO.Bank_Entity")[0].value='<xsl:value-of select="$Bank_Entity"/>';
			//Changed by Bala on 1/5/2009 for Ticket 265092 --- Start
			if('<xsl:value-of select="$relation"/>'!= "" &amp;&amp; '<xsl:value-of select="$relation"/>'!= null)
			{
			document.getElementsByName("RelationshipBO.Relationship")[0].value='<xsl:value-of select="$relation"/>';
			}
			//Changed by Bala on 1/5/2009 for Ticket 265092 --- End
			document.getElementsByName("RelationshipBO.Guard_Code")[0].value='<xsl:value-of select="$gCode"/>';

			}
			  <!-- TRACKER ID 148769 CHANGES END -->
		// fix for defect id:209637 ends
		    document.getElementsByName("ContactBO.gender")[0].IsMandatory = "true";
		    document.getElementsByName("ContactBO.salutation")[0].IsMandatory = "true";
		    document.getElementsByName("RelationshipBO.Guard_Code")[0].IsMandatory = "true";
			//Fix for callid:430243 Starts
			//making the contactskey field mandatory as it has been converted to a lookup
			document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "true";//priya
			document.getElementsByName("mandStarContactBO.contactsKey")[0].style.visibility="visible";//priya
		
			/*if(document.getElementsByName("ContactBO.contactsKey")[0].value == "") {
				if(document.all.isAutoGenKey.value == 'true') {
					document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "false";
				}
			else{
				document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "false";

			}
			  }
			  else
			  {
				  document.getElementsByName("ContactBO.contactsKey")[0].IsMandatory = "false";
			}*/
				//Fix for callid:430243 ends
		    document.getElementsByName("RelationshipBO.Relationship")[0].IsMandatory = "true";


		   // sSelectType = document.getElementsByName("RelationshipBO.Bank_Entity")[0].value;
		   /*ticket id: 334896 changes Begin */
		   /*if( document.getElementsByName("RelationshipBO.Bank_Entity")[0].value != ''){
			document.getElementsByName("RelationshipBO.Bank_Entity_Name")[0].value = document.getElementsByName("ContactBO.LastName")[0].value
		    }*/
		/*ticket id:334896 changes end */
		   try{
			if(document.getElementsByName("RelationshipBO.Bank_Entity")[0].value != ''){
			    lbDynamic.innerText = document.getElementsByName("RelationshipBO.Bank_Entity")[0].value + " :";
			}else{
			    lbDynamic.innerText = document.getElementsByName("RelationshipBO.Bank_Entity")[0].value;
			}
	                }catch(e){}
	}


/* Changes done by sonali for 286045
This function has been moved to RendValidate.js
	function txtLimit(field, max,str1,str2) {
				if (field.value.length > max + 1){
				var tempList = new Array();
    tempList[0] = str2;
    tempList[1] = max;
    showUserMessage(MSGX0007,tempList);
				document.getElementsByName(str1)[0].focus();
				return "interactive"
				}
			}
*/
            function setFocusOnComp(compName) {

                        if(compName==''){
                        if(gaurdianErr=="true" ){
                        	 parent.parent.parent.parent.tabViewFrm.selectTab('Psychographic Details');
                        	 return;
                        	}
	    		}


	                    var object = "";


	                    if(Screen == 1){
	                    //Demographic


	                    var tabname='Demographic Details'
	                        parent.parent.parent.parent.tabViewFrm.selectTab(tabname);
	                        object = "parent.parent.IFrmtab1.formDispFrame.";
	                    }else if(Screen == 2){
	                    //psychographic
	                        parent.parent.parent.parent.tabViewFrm.selectTab('Psychographic Details');
	                        object = "parent.parent.IFrmtab2.formDispFrame."
	                    }else if(Screen == 4){
	                    //Trade Finance
	                        parent.parent.parent.parent.tabViewFrm.selectTab('Trade Finance');
	                        object = "parent.parent.IFrmtab4.formDispFrame."
	                    }else{
	                    }

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
		function ValidateMinor(compName){
			try{
			var object = "parent.parent.IFrmtab0.formDispFrame."
			var elementName = eval(object + "document.getElementsByName(compName)[0]");
			var ids = elementName.parentElement.parentElement.parentElement.parentElement.parentElement.id;
			    ids = trim(ids.replace("det_",""));
			    eval(object + "showTabFortabDemoForm('" + ids +"')");
			     elementName.select();
			}catch(e){
	                        }
	             }
                function SaveAccount(f){

                //changes by Rozy for CNF
		FormatBeforeSave_Number('AccountBO.RelationshipValue');
		FormatBeforeSave_Number('AccountBO.NumberOfProducts');
		//TrackerID:209607,CHANGES START
		FormatBeforeSave_Number("2_AccountBO.Offline_cum_debit_limit");
		//TrackerID:209607,CHANGES END

                // CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES **
                    try{
                        customSaveAccount();
                    }catch(e){
                    }
               // CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES  **
                    var newwin = window.open('../common/html/SSOblank.html', 'Save', 'directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
                    f.target='Save';
                    f.submit();
                }
                function clos(f){
                    var newwin = window.open('../common/html/SSOblank.html', 'Save', 'directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
                    f.target='Save';
                    f.submit();
                 }
               function clearAccount() {
                document.frm2.hid_parentAccountURL.value= "";
                PrimaryAccountName=document.getElementsByName("AccountBO.parentAccount")[0]
                PrimaryAccountName.value="";
                }
                function cls(){
                     self.close();
                }

		<!--// Tracker ID : 68932 Begin of Changes  -->
		function validateKeys(){

			if((event.keyCode&gt;47&amp;&amp;event.keyCode&lt;58)||(event.keyCode&gt;96&amp;&amp;event.keyCode&lt;123)||(event.keyCode&gt;64&amp;&amp;event.keyCode&lt;91)){
				}
			else{
				showMessage(MSGX0008);
				event.keyCode = 0;
				return false;
			}
		}
		<!--// Tracker ID : 113193/ Changes for 400757 and recon for 392665 Begining of Changes-->
		function SwiftCode(eleName1,eleName2){
			if(document.getElementsByName(eleName1)[0].value == 'Y'){
				document.getElementsByName(eleName2)[0].IsMandatory = "true";
				document.getElementsByName("mandStar"+eleName2)[0].style.visibility="visible";
				document.getElementsByName(eleName2)[0].disabled=false; //Changes for DBS 10215 enhancements
				document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0].disabled = false;
			}else{
				document.getElementsByName(eleName2)[0].IsMandatory = "false";
				document.getElementsByName("mandStar"+eleName2)[0].style.visibility="hidden";
				document.getElementsByName(eleName2)[0].disabled=true;//Changes for DBS 10215 enhancements
				document.getElementsByName(eleName2)[0].value="";//Changes for DBS 10215 enhancements
				document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0].disabled = false;
			}
		}
		<!--// Tracker ID : 113193 / Changes for 400757 and recon for 392665 End of Changes-->
		<!--// Changes for 400757 and recon for 392665 Start-->
		
		function SwiftCodeOnLoad(){
			
			var swift = document.getElementsByName(boName+".Is_Swift_Code_of_Bank")[0].value;
			
			if(swift == 'y' || swift == 'Y')
			{
			   document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0].disabled = false;
			}
			else
			{
				document.getElementsByName("AccountBO.Cust_Swift_Code_Desc")[0].disabled = false;
			}
			
		}
		
		<!--// Changes for 400757 and recon for 392665 end -->

		<!--// Tracker ID : 68932 End of Changes-->
		<!--tracker id 113227 defect fix starts here-->
		function setvalue(){
			  var tfpFlg = document.getElementsByName(boName+".TFPartyFlag")[0].value;
			  if(tfpFlg == 'Y'){

				parent.parent.IFrmtab4.formDispFrame.document.getElementsByName("TradeFinanceBO.OrgKey")[0].value=parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("AccountBO.AccountKey")[0].value;

			}

		}
		function set(){
			var tfpFlg = document.getElementsByName(boName+".TFPartyFlag")[0].value;
			if(tfpFlg == 'Y'){
				parent.parent.IFrmtab4.formDispFrame.document.getElementsByName("TradeFinanceBO.Name")[0].value=parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("AccountBO.Name")[0].value;

			}

		}
		function set_alt(){
			var tfpFlg = document.getElementsByName(boName+".TFPartyFlag")[0].value;
			if(tfpFlg == 'Y'){
				parent.parent.IFrmtab4.formDispFrame.document.getElementsByName("TradeFinanceBO.Name_alt1")[0].value=parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("AccountBO.Name_alt1")[0].value;

			}

		}
	/*Changes Begin for Tracker 126433 */
		function formatMobile (){
			 var Phone = document.frm2.elements("AccountBO.SMSBankingMobileNumber").value;
				if(isNaN(Phone)) {
						  showUserMessage('MSGJ50161','');
				  }
		}
		/*Changes End for Tracker 126433 */
		/* Changes for tracker 356432 starts */
		function validatecustype(){
		try{
								
								elem1 = document.getElementsByName("AccountBO.Cust_type_code")[0];
								
								
								elem2 = document.getElementsByName(boName+".Staffflag")[0];
						//Changes for tracker 600300 start		
						if(elem1.value != ''){
						//Changes for tracker 600300 end
								if((elem1.value== "EX")||(elem1.value== "EX-STAFF")){
									//Changes for tracker 600300 start
									document.getElementsByName(boName+".Staffflag")[0].value = 'Y';
									//Changes for tracker 600300 end
								    	elem2.disabled = true;
								} else {
								//Changes for tracker 600300 start
							                //document.getElementsByName(boName+".Staffflag")[0].value = 'N';
							                //Changes for tracker 600300 end
							                elem2.disabled = false;
					                              }
					        }
								disableStaffFieldConditionally(boName+".StaffFlag", "AccountBO.StaffEmployeeID");
								
								validateEmploymentProof();
								
							}catch(e){
							
                	}
                	}
		
		/* Changes for tracker 356432 ends */
		<!--tracker id 113227 defect fix ends here-->
                </script>
                 <!--javascript ends here-->

                     <xsl:apply-templates select="SRM"/>

      </body>
                </html>
                        </xsl:template>
                                  <xsl:template name="show_account_buttons">
                                  <xsl:choose>
                                       <xsl:when test= "normalize-space($accountURL)=''">
                                            <xsl:call-template name="user_button_withText">
                                            <xsl:with-param name="button_name">Save</xsl:with-param>
                                            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Save']/@configLabel"/></xsl:with-param>
                                            <xsl:with-param name="button_fnc">SaveAccount(document.frm2)</xsl:with-param>
                                           </xsl:call-template>&#160;
                                            <xsl:call-template name="user_button_withText">
                                            <xsl:with-param name="button_name">Cancel</xsl:with-param>
                                            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Cancel']/@configLabel"/></xsl:with-param>
                                            <xsl:with-param name="button_fnc">cls()</xsl:with-param>
                                           </xsl:call-template>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:call-template name="user_button_withText">
                                            <xsl:with-param name="button_name">Update</xsl:with-param>
                                            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Update']/@configLabel"/></xsl:with-param>
                                            <xsl:with-param name="button_fnc">SaveAccount(document.frm2)</xsl:with-param>
                                </xsl:call-template>&#160;
                                            <xsl:call-template name="user_button_withText">
                                            <xsl:with-param name="button_name">Cancel</xsl:with-param>
                                            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Cancel']/@configLabel"/></xsl:with-param>
                                            <xsl:with-param name="button_fnc">cls()</xsl:with-param>
                                    </xsl:call-template>
                                        </xsl:otherwise>
                                  </xsl:choose>
</xsl:template>
<!--  RefCode Changes	-->

<!--  Changes for tracker id 338696 starts -->

	<xsl:template name="AccountBO.Salutation">
	     <xsl:call-template name="lookup">
	     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Salutation_code']"/>
	     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Salutation_code</xsl:with-param>
	     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Salutation</xsl:with-param>
	     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
	     <!-- Changes for Call Id 355758 and Recon For Tracker id 391911 Starts -->
	     <xsl:with-param name="buttonone_fnc">categoryLookup('PERSONSALUTATION', '<xsl:value-of select="$boName"/>.Salutation_code');changeGender('<xsl:value-of select="$boName"/>');checkSalutation('S')</xsl:with-param>
	     <!-- Changes for Call Id 355758 and Recon For Tracker id 391911 Ends -->
	     <!--Changes for tracker id 349611 STARTS-->
	     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Salutation_code')</xsl:with-param>
	     <!--Changes for tracker id 349611 ENDS-->
	     <xsl:with-param name="checkASCII">false</xsl:with-param>
	     <xsl:with-param name="code_req">true</xsl:with-param>
	     </xsl:call-template>
      </xsl:template>   	

<!--  Changes for tracker id 338696 ends  -->
   <!--  RefCode Changes	-->
   <!--***** FATCA Template Definitions Begins Here*****-->
   
   
   
  
   
   
   
    <xsl:template name="AccountBO.ForeignAccTaxReportingReq">
   	<xsl:call-template name="mdrpdown">
   			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.ForeignAccTaxReportingReq']"/>
   			<!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.ForeignAccTaxReportingReq</xsl:with-param>-->
   			<xsl:with-param name="selectdisp">AccountBO.ForeignAccTaxReportingReq</xsl:with-param>
   			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.ForeignAccTaxReportingReq</xsl:with-param>
   			<xsl:with-param name="choice_name">AccountBO.ForeignAccTaxReportingReq</xsl:with-param>
   			<xsl:with-param name="search_type">url</xsl:with-param>
   		  <xsl:with-param name="onchangefn">checkForeignAccTaxReport()</xsl:with-param> 
    
   			<xsl:with-param name="presdata" select="$PresData"/>
      </xsl:call-template>
			</xsl:template>
   
   
   
   
   
   
   
   
   
      <xsl:template name="AccountBO.ForeignTaxReportingCountry">
          <xsl:call-template name="lookup">
          <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.ForeignTaxReportingCountry']"/>
          <xsl:with-param name="elename">AccountBO.ForeignTaxReportingCountry</xsl:with-param>
          <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.ForeignTaxReportingCountry</xsl:with-param>
          <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
          <!-- Field Rationalization changes start-->
          
           <xsl:with-param name="code_req">true</xsl:with-param> 
          <!-- Field Rationalization changes end-->
          
  	<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
  	<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
          <xsl:with-param name="buttonone_fnc">categoryLookup('FATCA_COUNTRY', 'AccountBO.ForeignTaxReportingCountry')</xsl:with-param>
          <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.ForeignTaxReportingCountry')</xsl:with-param>
          <xsl:with-param name="checkASCII">false</xsl:with-param>
          <xsl:with-param name="starshow">true</xsl:with-param>
          </xsl:call-template>
                </xsl:template>
                
    <xsl:template name="AccountBO.ForeignTaxReportingStatus">
     	<xsl:call-template name="mdrpdown">
     			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.ForeignTaxReportingStatus']"/>
     			<!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.ForeignTaxReportingStatus</xsl:with-param>-->
     			<xsl:with-param name="selectdisp">AccountBO.ForeignTaxReportingStatus</xsl:with-param>
     			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.ForeignTaxReportingStatus</xsl:with-param>
     			<xsl:with-param name="choice_name">AccountBO.ForeignTaxReportingStatus</xsl:with-param>
     			<xsl:with-param name="search_type">url</xsl:with-param>
     		   <xsl:with-param name="starshow">true</xsl:with-param>
     			<xsl:with-param name="presdata" select="$PresData"/>
        </xsl:call-template>
			</xsl:template>
               
  <xsl:template name="AccountBO.LastForeignTaxReviewDate">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">AccountBO.LastForeignTaxReviewDate</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"></xsl:value-of>.LastForeignTaxReviewDate</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.LastForeignTaxReviewDate']" />
                 <xsl:with-param name="fn_onBlur">validateLastTaxReprtReviewDate();</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>              
                
   

   
     <xsl:template name="AccountBO.NextForeignTaxReviewDate">
   	<xsl:call-template name="label">
   		<xsl:with-param name="ele_name">AccountBO.NextForeignTaxReviewDate</xsl:with-param>
   		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"></xsl:value-of>.NextForeignTaxReviewDate</xsl:with-param>
   		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.NextForeignTaxReviewDate']" />
                <xsl:with-param name="fn_onBlur">validateNextTaxReprtReviewDate();</xsl:with-param>
	   	<xsl:with-param name="starshow">true</xsl:with-param>
   	</xsl:call-template> 
</xsl:template> 
   
         <xsl:template name="AccountBO.FatcaRemarks">
	 	<xsl:call-template name="mtextarea">
	 		<xsl:with-param name="mname">AccountBO.FatcaRemarks</xsl:with-param>
	 		<xsl:with-param name="mvalue"><xsl:value-of select="$boName"></xsl:value-of>.FatcaRemarks</xsl:with-param>
	 		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.FatcaRemarks']" />
	                  
	               <xsl:with-param name="mrows">2</xsl:with-param>
			<xsl:with-param name="mcols">16</xsl:with-param>
                        <xsl:with-param name="mcolspan">0</xsl:with-param>
	 
	 
	 	</xsl:call-template>
</xsl:template>
   
		<!--*****  FATCA Template Definitions END Here********-->

 	<xsl:template name="AccountBO.Cust_Last_Name">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Last_Name']"/>
                <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name</xsl:with-param>
				<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
                <xsl:with-param name="fn_onBlur">fnDefaultShortName();set_isName(this,true);fnNameLength(this);concatName();</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
            </xsl:call-template>
        </xsl:template>

        <!-- CIF Changes following fields added in General Details  -->
        <xsl:template name="AccountBO.Cust_Middle_Name">
    	    <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Middle_Name']"/>
	        <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name</xsl:with-param>
    	        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name</xsl:with-param>
				<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
                <xsl:with-param name="fn_onBlur">set_isName(this,true);fnNameLength(this);concatName();</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	    </xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.Cust_First_Name">
	    <xsl:call-template name="label">
	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_First_Name']"/>
	        <xsl:with-param name="ele_name">AccountBO.Cust_First_Name</xsl:with-param>
	        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name</xsl:with-param>
	        <xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
                <xsl:with-param name="fn_onBlur">set_isName(this,true);fnNameLength(this);concatName();</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	    </xsl:call-template>
	</xsl:template>
        <xsl:template name="AccountBO.strField6">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.strField6']"/>
                <xsl:with-param name="ele_name">AccountBO.strField6</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.strField6</xsl:with-param>
				<xsl:with-param name="checkASCII">false</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <!-- CIF Changes following fields added in General Details  -->
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

	<xsl:template name="AccountBO.nick_name">
	    <xsl:call-template name="label">
	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.nick_name']"/>
	        <xsl:with-param name="ele_name">AccountBO.nick_name</xsl:with-param>
	        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.nick_name</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	    </xsl:call-template>
	</xsl:template>
	<!--Religion customization by Kate start -->
	
	   <xsl:template name="AccountBO.StrField17">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrField17']"/>
		<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrField17</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.StrField17</xsl:with-param>
		<xsl:with-param name="ele_name">StrField17</xsl:with-param>
		<xsl:with-param name="choice_name">AccountBO.StrField17</xsl:with-param>
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
	</xsl:template>

	<!--Religion customization  end-->
	<xsl:template name="AccountBO.Cust_Swift_Code_Desc">
	    <xsl:call-template name="label">
	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Swift_Code_Desc']"/>
	        <xsl:with-param name="ele_name">AccountBO.Cust_Swift_Code_Desc</xsl:with-param>
	        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Swift_Code_Desc</xsl:with-param>
	    	<xsl:with-param name="starshow">true</xsl:with-param>
	    </xsl:call-template>
	</xsl:template>
	<xsl:template name="AccountBO.Is_Swift_Code_Of_Bank">
	    <xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Is_Swift_Code_Of_Bank']"/>
		<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Is_Swift_Code_Of_Bank</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.Is_Swift_Code_Of_Bank</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
				<xsl:with-param name="onchangefn">SwiftCode('<xsl:value-of select="$boName"/>.Is_Swift_Code_Of_Bank','AccountBO.Cust_Swift_Code_Desc')</xsl:with-param>
			<!-- CIF Changes for Caching Views : End -->
		<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.Is_Swift_Code_Of_Bank</xsl:with-param>
	    </xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.mother_name">
	    <xsl:call-template name="label">
	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.mother_name']"/>
	        <xsl:with-param name="ele_name">AccountBO.mother_name</xsl:with-param>
	        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.mother_name</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	    </xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.father_husband_name">
	    <xsl:call-template name="label">
	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.father_husband_name']"/>
		<xsl:with-param name="ele_name">AccountBO.father_husband_name</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.father_husband_name</xsl:with-param>
		<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	    </xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.previous_name">
	    <xsl:call-template name="label">
	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.previous_name']"/>
		<xsl:with-param name="ele_name">AccountBO.previous_name</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.previous_name</xsl:with-param>
		<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
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

	<xsl:template name="AccountBO.lead_source">
	    <xsl:call-template name="label">
	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.lead_source']"/>
	        <xsl:with-param name="ele_name">AccountBO.lead_source</xsl:with-param>
	 	<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.lead_source</xsl:with-param>
	    </xsl:call-template>
	</xsl:template>

<!-- Fix for Ticket#134146 Starts: Template change from label to mdrpdown for card_holder -->
<!--
	<xsl:template name="AccountBO.card_holder">
	    <xsl:call-template name="label">
	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.card_holder']"/>
	        <xsl:with-param name="ele_name">AccountBO.card_holder</xsl:with-param>
	 	<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.card_holder</xsl:with-param>
	    </xsl:call-template>
	</xsl:template>
-->
        <xsl:template name="AccountBO.card_holder">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.card_holder']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.card_holder</xsl:with-param>
                <xsl:with-param name="selectdisp">AccountBO.card_holder</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                <xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.card_holder</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
<!-- Fix for Ticket#134146 Ends -->


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


	<xsl:template name="AccountBO.Secure_id">
	    <xsl:call-template name="label">
	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Secure_id']"/>
	        <xsl:with-param name="ele_name">AccountBO.Secure_id</xsl:with-param>
	 	<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Secure_id</xsl:with-param>
	    </xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.PreferredName">
	    <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PreferredName']"/>
		<xsl:with-param name="ele_name">AccountBO.PreferredName</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.PreferredName</xsl:with-param>
		<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	    </xsl:call-template>
	</xsl:template>

	<!-- <xsl:template name="AccountBO.DSA_ID">
	    <xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.DSA_ID']"/>
		<xsl:with-param name="ele_name">AccountBO.DSA_ID</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.DSA_ID</xsl:with-param>
	    </xsl:call-template>
	</xsl:template> -->

	<xsl:template name="AccountBO.DSA_ID">
    <xsl:call-template name="lookup">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.DSA_ID']"/>
    <xsl:with-param name="elename">AccountBO.DSA_ID</xsl:with-param>
    <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.DSA_ID</xsl:with-param>
    <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
    <xsl:with-param name="buttonone_name">Lookup</xsl:with-param>
    <xsl:with-param name="buttontwo_name">Clear</xsl:with-param>
    <xsl:with-param name="buttonone_fnc">openDSALookup()</xsl:with-param>
    <xsl:with-param name="buttontwo_fnc">clearLookupDSA()</xsl:with-param>
    </xsl:call-template>
    <input type="hidden" name="AccountBO.DSA_ID" value="{$boDet[@n=concat($boName,'.DSA_ID')]}"/>
	</xsl:template>

	<xsl:template name="AccountBO.photograph_id">
	    <xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.photograph_id']"/>
		<xsl:with-param name="ele_name">AccountBO.photograph_id</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.photograph_id</xsl:with-param>
	    </xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.rm_group_id">
	    <xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.rm_group_id']"/>
		<xsl:with-param name="ele_name">AccountBO.rm_group_id</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.rm_group_id</xsl:with-param>
	    </xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.relationship_type">
	    <xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.relationship_type']"/>
		<xsl:with-param name="ele_name">AccountBO.relationship_type</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.relationship_type</xsl:with-param>
	    	<!-- TRACKERID:140828 CRM9.5 recon to CRM10.2 CHANGES BEGIN -->
	    	<xsl:with-param name="max_length">5</xsl:with-param>
	    	<!-- TRACKERID:140828 CRM9.5 recon to CRM10.2 CHANGES ENDS -->
	    </xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.relationship_level">
	    <xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.relationship_level']"/>
		<xsl:with-param name="ele_name">AccountBO.relationship_level</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.relationship_level</xsl:with-param>
	    	<!-- TRACKERID:140828 CRM9.5 recon to CRM10.2 CHANGES BEGIN -->
	    	<xsl:with-param name="max_length">5</xsl:with-param>
	    	<!-- TRACKERID:140828 CRM9.5 recon to CRM10.2 CHANGES ENDS -->
	    </xsl:call-template>
	</xsl:template>

	<!-- end of changes  -->
        <xsl:template name="AccountBO.NameSuffix">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.NameSuffix']"/>
                <xsl:with-param name="ele_name">AccountBO.NameSuffix</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.NameSuffix</xsl:with-param>
				<xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.strfield1">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.strfield1']"/>
                <xsl:with-param name="ele_name">AccountBO.strfield1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.strfield1</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.strfield2">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.strfield2']"/>
                <xsl:with-param name="ele_name">AccountBO.strfield2</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.strfield2</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.strfield3">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.strfield3']"/>
                <xsl:with-param name="ele_name">AccountBO.strfield3</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.strfield3</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.strfield4">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.strfield4']"/>
                <xsl:with-param name="ele_name">AccountBO.strfield4</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.strfield4</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.strfield5">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.strfield5']"/>
                <xsl:with-param name="ele_name">AccountBO.strfield5</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.strfield5</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.DateOfBecomingNRE">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.DateOfBecomingNRE']"/>
                <xsl:with-param name="ele_name">AccountBO.DateOfBecomingNRE</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.DateOfBecomingNRE</xsl:with-param>
		<!-- Tracker 61887 Begin of Changes-->
		<xsl:with-param name="starshow">true</xsl:with-param>
		<xsl:with-param name="fn_onFocus">fnCheckNreStatus();</xsl:with-param>
		<xsl:with-param name="fn_onBlur">validateDate();</xsl:with-param>
		<!-- Tracker 61887 End of Changes-->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.dtDate6">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.dtDate6']"/>
                <xsl:with-param name="ele_name">AccountBO.dtDate6</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.dtDate6</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		<!-- calling the function isGregDate for on blur functionality-->
                <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.DtDate6");</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.DtDate1">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.DtDate1']"/>
                <xsl:with-param name="ele_name">AccountBO.DtDate1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.DtDate1</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		<!-- calling the function isGregDate for on blur functionality-->
		<xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.DtDate1");</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.DtDate2">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.DtDate2']"/>
                <xsl:with-param name="ele_name">AccountBO.DtDate2</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.DtDate2</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
	        <!-- calling the function isGregDate for on blur functionality-->
	        <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.DtDate2");</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.DtDate3">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.DtDate3']"/>
                <xsl:with-param name="ele_name">AccountBO.DtDate3</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.DtDate3</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		<!-- calling the function isGregDate for on blur functionality-->
		<xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.DtDate3");</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.userFlag1">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.userFlag1']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.userFlag1</xsl:with-param>
                <xsl:with-param name="selectdisp">AccountBO.userFlag1</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                <xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.userFlag1</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.userFlag2">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.userFlag2']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.userFlag2</xsl:with-param>
                <xsl:with-param name="selectdisp">AccountBO.userFlag2</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                <xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.userFlag2</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.userFlag3">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.userFlag3']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.userFlag3</xsl:with-param>
                <xsl:with-param name="selectdisp">AccountBO.userFlag3</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                <xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.userFlag3</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.userFlag4">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.userFlag4']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.userFlag4</xsl:with-param>
                <xsl:with-param name="selectdisp">AccountBO.userFlag4</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                <xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.userFlag4</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <!--changes from dropdown to lookup ends-->
<!-- TRACKER:371155:BEGINOFCHANGES -->
        <xsl:template name="AccountBO.revenueUnits">
	<xsl:call-template name="lookup">
	<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.revenueUnits']"/>
	<xsl:with-param name="elename">AccountBO.revenueUnits</xsl:with-param>
	<xsl:with-param name="eleval">AccountBO.revenueUnits</xsl:with-param>
	<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
	<!-- CIF Changes for Caching Views : Start -->
					<xsl:with-param name="presdata" select="$PresData"/>
				<!-- CIF Changes for Caching Views : End -->
	<xsl:with-param name="buttonone_fnc">categoryLookup('CURRENCY', 'AccountBO.revenueUnits')</xsl:with-param>
	<xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.revenueUnits')</xsl:with-param>
	 <xsl:with-param name="disable_val">false</xsl:with-param>
	<xsl:with-param name="checkASCII">false</xsl:with-param>
	</xsl:call-template>
        </xsl:template>
      <!-- TRACKER:371155:ENDOFCHANGES -->
        <xsl:template name="AccountBO.customerProfitability">
           <xsl:call-template name="amountlabel">
            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.customerProfitability']"/>
            <xsl:with-param name="ele_name">AccountBO.customerProfitability</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.customerProfitability</xsl:with-param>
            <xsl:with-param name="fncname">rate("3_AccountBO.customerProfitability",'<xsl:value-of select="$boName"/>.revenueUnits','<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
            <xsl:with-param name="showdropdown">false</xsl:with-param>
            <xsl:with-param name="fn_onBlur">formatAmount("3_AccountBO.customerProfitability",'<xsl:value-of select="$boName"/>.revenueUnits',"N");</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
           </xsl:call-template>
         </xsl:template>
      <!--  <xsl:template name="AccountBO.householdID">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.householdID']"/>
                <xsl:with-param name="ele_name">AccountBO.householdID</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.householdID</xsl:with-param>
            </xsl:call-template>
        </xsl:template> -->
<!--Native Language Changes:start-->
<xsl:template name="AccountBO.NativeShortName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeShortName']"/>
			<xsl:with-param name="ele_name">NativeShortName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Short_Name_Native</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>

 	<xsl:template name="AccountBO.Cust_Last_Name_Native">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Last_Name_Native']"/>
                <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_Native</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name_Native</xsl:with-param>
<!-- Fix for call id: 428627 Starts -->
                <xsl:with-param name="max_length">80</xsl:with-param>
<!-- Fix for call id: 428627 Ends -->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
            </xsl:call-template>
        </xsl:template>
 	<xsl:template name="AccountBO.Cust_First_Name_Native">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_First_Name_Native']"/>
                <xsl:with-param name="ele_name">AccountBO.Cust_First_Name_Native</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name_Native</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
            </xsl:call-template>
        </xsl:template>
 	<xsl:template name="AccountBO.Cust_Middle_Name_Native">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Middle_Name_Native']"/>
                <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_Native</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name_Native</xsl:with-param>
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
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Short_Name_Native</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
            </xsl:call-template>
        </xsl:template>
 	<xsl:template name="AccountBO.Cust_Last_Name_Native1">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Last_Name_Native1']"/>
                <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_Native1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name_Native1</xsl:with-param>
<!-- Fix for call id: 428627 Starts -->
                <xsl:with-param name="max_length">80</xsl:with-param>
<!-- Fix for call id: 428627 Ends -->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
            </xsl:call-template>
        </xsl:template>
 	<xsl:template name="AccountBO.Cust_First_Name_Native1">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_First_Name_Native1']"/>
                <xsl:with-param name="ele_name">AccountBO.Cust_First_Name_Native1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name_Native1</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
            </xsl:call-template>
        </xsl:template>
 	<xsl:template name="AccountBO.Cust_Middle_Name_Native1">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Middle_Name_Native1']"/>
                <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_Native1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name_Native1</xsl:with-param>
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
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Short_Name_Native1</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
            </xsl:call-template>
        </xsl:template>

<!--Native Language Changes:end-->

        <xsl:template name="AccountBO.currentCrExposure">
           <xsl:call-template name="amountlabel">
            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.currentCrExposure']"/>
            <xsl:with-param name="ele_name">AccountBO.currentCrExposure</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.currentCrExposure</xsl:with-param>
            <xsl:with-param name="fncname">rate("3_AccountBO.currentCrExposure",'<xsl:value-of select="$boName"/>.revenueUnits','<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
            <xsl:with-param name="showdropdown">false</xsl:with-param>
            <xsl:with-param name="fn_onBlur">formatAmount("3_AccountBO.currentCrExposure",'<xsl:value-of select="$boName"/>.revenueUnits',"N");</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
           </xsl:call-template>
         </xsl:template>
        <xsl:template name="AccountBO.totalCrExposure">
           <xsl:call-template name="amountlabel">
            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.totalCrExposure']"/>
            <xsl:with-param name="ele_name">AccountBO.totalCrExposure</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.totalCrExposure</xsl:with-param>
            <xsl:with-param name="fncname">rate("3_AccountBO.totalCrExposure",'<xsl:value-of select="$boName"/>.revenueUnits','<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
            <xsl:with-param name="showdropdown">false</xsl:with-param>
            <xsl:with-param name="fn_onBlur">formatAmount("3_AccountBO.totalCrExposure",'<xsl:value-of select="$boName"/>.revenueUnits',"N");</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
           </xsl:call-template>
         </xsl:template>
        <xsl:template name="AccountBO.potentialCrLine">
           <xsl:call-template name="amountlabel">
            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.potentialCrLine']"/>
            <xsl:with-param name="ele_name">AccountBO.potentialCrLine</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.potentialCrLine</xsl:with-param>
            <xsl:with-param name="fncname">rate("3_AccountBO.potentialCrLine",'<xsl:value-of select="$boName"/>.revenueUnits','<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
            <xsl:with-param name="showdropdown">false</xsl:with-param>
            <xsl:with-param name="fn_onBlur">formatAmount("3_AccountBO.potentialCrLine",'<xsl:value-of select="$boName"/>.revenueUnits',"N");</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
           </xsl:call-template>
         </xsl:template>
        <xsl:template name="AccountBO.availableCrLimit">
           <xsl:call-template name="amountlabel">
            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.availableCrLimit']"/>
            <xsl:with-param name="ele_name">AccountBO.availableCrLimit</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.availableCrLimit</xsl:with-param>
            <xsl:with-param name="fncname">rate("3_AccountBO.availableCrLimit",'<xsl:value-of select="$boName"/>.revenueUnits','<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
            <xsl:with-param name="showdropdown">false</xsl:with-param>
             <!-- Tracker 113058 Changes Begin -->
            <xsl:with-param name="fn_onBlur">formatAmountNextComp("3_AccountBO.availableCrLimit",'<xsl:value-of select="$boName"/>.revenueUnits',"N",'<xsl:value-of select="$boName"/>.Segmentation_Class')</xsl:with-param>
             <!-- Tracker 113058 Changes End -->
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
           </xsl:call-template>
         </xsl:template>
        <xsl:template name="AccountBO.maidenName">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.maidenName']"/>
                <xsl:with-param name="ele_name">AccountBO.maidenName</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.maidenName</xsl:with-param>
                <xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.spouseID">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.spouseID']"/>
                <xsl:with-param name="ele_name">AccountBO.spouseID</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.spouseID</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.creditScoreRequestedFlag">
            <xsl:call-template name="label">
                 <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.creditScoreRequestedFlag']"/>
                 <xsl:with-param name="read_val">true</xsl:with-param>
                 <xsl:with-param name="ele_name">AccountBO.creditScoreRequestedFlag</xsl:with-param>
                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.creditScoreRequestedFlag</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.creditHistoryRequestedFlag">
            <xsl:call-template name="label">
                 <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.creditHistoryRequestedFlag']"/>
                 <xsl:with-param name="read_val">true</xsl:with-param>
                 <xsl:with-param name="ele_name">AccountBO.creditHistoryRequestedFlag</xsl:with-param>
                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.creditHistoryRequestedFlag</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
         <xsl:template name="AccountBO.Gender">
            <xsl:call-template name="mdrpdown">
             <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Gender']"/>
         <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Gender</xsl:with-param>
             <xsl:with-param name="search_type">value</xsl:with-param>
             <xsl:with-param name="selectdisp">Gender</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
			<!--  vasanth's change start -->
			<xsl:with-param name="onchangefn">checkSalutation('G')</xsl:with-param>
			<!--  vasanth's change end -->
			<!-- commenting on behalf of tracker id 338124-->
         <!--<xsl:with-param name="defaultValue">Male</xsl:with-param>-->
		<xsl:with-param name="choice_name">AccountBO.Gender</xsl:with-param>
            </xsl:call-template>
         </xsl:template>

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

<!--  RefCode Changes	-->
	<!-- Changes for tracker 356432 starts -->
        <xsl:template name="AccountBO.Cust_Type">
		           <xsl:call-template name="lookup">
		          <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_type_code']"/>
		           <xsl:with-param name="elename">AccountBO.Cust_type_code</xsl:with-param>
		           <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Cust_Type</xsl:with-param>
		           <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		           <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		           <xsl:with-param name="buttonone_fnc">categoryLookup('ACCOUNT_TYPE', 'AccountBO.Cust_type_code');validatecustype();</xsl:with-param>
		           <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.Cust_type_code')</xsl:with-param>
		           <xsl:with-param name="fn_onBlur">validatecustype()</xsl:with-param>
		           <xsl:with-param name="checkASCII">true</xsl:with-param>
		          </xsl:call-template>
   	</xsl:template>
	<!-- Changes for tracker 356432 ends -->
        <xsl:template name="AccountBO.Cust_DOB">
	                 <xsl:call-template name="label">
	                   <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_DOB']"/>
	                    <xsl:with-param name="selectname">AccountBO.Cust_DOB</xsl:with-param>
	                    <xsl:with-param name="selectdisp">AccountBO.Cust_DOB</xsl:with-param>
	                    <xsl:with-param name="ele_name">AccountBO.Cust_DOB</xsl:with-param>
	                    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_DOB</xsl:with-param>
	                    <!-- ERPBOCF1:TRACKER:113259:MATPT:BEGIN OF CHANGES(HIJRI)-->
			    <!-- calling the function isGregDate for on blur functionality-->
	                    <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.Cust_DOB");validateDOB();checkAge();checkAgeSC();</xsl:with-param>
			    <!-- ERPBOCF1:TRACKER:113259:MATPT:END OF CHANGES(HIJRI)-->


        </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.DateOfDeath"> 
	           <xsl:call-template name="label"> 
	        	   <xsl:with-param name="ele_name">AccountBO.DateOfDeath</xsl:with-param>
	        	   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"></xsl:value-of>.DateOfDeath</xsl:with-param>
	        	   <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.DateOfDeath");fnValidateDeathDate();</xsl:with-param>
	        	   <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.DateOfDeath']" />
	           </xsl:call-template> 
	   </xsl:template> 
	   <xsl:template name="AccountBO.DateOfNotification"> 
	           <xsl:call-template name="label">
	           		<xsl:with-param name="ele_name">AccountBO.DateOfNotification</xsl:with-param>
		   		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"></xsl:value-of>.DateOfNotification</xsl:with-param>
		   		<xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.DateOfNotification");fnValidateNotificationDate();</xsl:with-param>
		   		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.DateOfNotification']" />
				<xsl:with-param name="starshow">true</xsl:with-param>
	           </xsl:call-template> 
	   </xsl:template> 
	

    <!--sample for multidrop down ends here-->
         <xsl:template name="AccountBO.CIN">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.CIN']"/>
              <xsl:with-param name="ele_name">AccountBO.CIN</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CIN</xsl:with-param>
              <!-- Tracker 68932 Begin of Changes-->
	      <xsl:with-param name="fn_onKeyPress">validateKeys()</xsl:with-param>
	      <!-- Tracker 68932 End of Changes-->
            </xsl:call-template>
         </xsl:template>
         <xsl:template name="AccountBO.Alert1">
            <xsl:call-template name="mtextarea">
            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Alert1']"/>
        <xsl:with-param name="mname">AccountBO.Alert1</xsl:with-param>
             <xsl:with-param name="mvalue"><xsl:value-of select="$boName"/>.Alert1</xsl:with-param>
              <xsl:with-param name="mrows">2</xsl:with-param>
                        <xsl:with-param name="mcols">16</xsl:with-param>
                        <xsl:with-param name="mcolspan">0</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
         <xsl:template name="AccountBO.Alert2">
            <xsl:call-template name="mtextarea">
            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Alert2']"/>
        <xsl:with-param name="mname">AccountBO.Alert2</xsl:with-param>
             <xsl:with-param name="mvalue"><xsl:value-of select="$boName"/>.Alert2</xsl:with-param>
              <xsl:with-param name="mrows">2</xsl:with-param>
                        <xsl:with-param name="mcols">16</xsl:with-param>
                        <xsl:with-param name="mcolspan">0</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
        <xsl:template name="Account_Address">
        	<xsl:call-template name="addresswidget">
        		<xsl:with-param name="addressBO"><xsl:value-of select="$boName"/></xsl:with-param>
        		<xsl:with-param name="ShowAllFields">true</xsl:with-param>
				<xsl:with-param name="AddressLine1Mandatory">true</xsl:with-param>
				<xsl:with-param name="AddressLine2Mandatory">true</xsl:with-param>
				<xsl:with-param name="AddressLine3Mandatory">true</xsl:with-param>
				<xsl:with-param name="CityMandatory">true</xsl:with-param>
				<xsl:with-param name="StateMandatory">true</xsl:with-param>
				<xsl:with-param name="ZipMandatory">true</xsl:with-param>
				<xsl:with-param name="CountryMandatory">true</xsl:with-param>
				<xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/></xsl:with-param>
				<xsl:with-param name="checkASCII">false</xsl:with-param>
	        </xsl:call-template>
    	</xsl:template>
    <xsl:template name="AccountBO.CustomerRelationshipNo">
                         <xsl:call-template name="label">
                         <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.CustomerRelationshipNo']"/>
                           <xsl:with-param name="ele_name">AccountBO.CustomerRelationshipNo</xsl:with-param>
                           <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CustomerRelationshipNo</xsl:with-param>
                         </xsl:call-template>
             </xsl:template>
             <xsl:template name="AccountBO.RelationshipOpeningDate">
                    <xsl:call-template name="label">
                    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.RelationshipOpeningDate']"/>
                    <xsl:with-param name="ele_name">AccountBO.RelationshipOpeningDate</xsl:with-param>
                    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.RelationshipOpeningDate</xsl:with-param>
                    <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		    <!-- calling the function isGregDate for on blur functionality-->
		    <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.RelationshipOpeningDate");</xsl:with-param>
                    <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
                    </xsl:call-template>
    </xsl:template>
             <xsl:template name="AccountBO.RelationshipValue">
                    <xsl:call-template name="label">
                    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.RelationshipValue']"/>
                    <xsl:with-param name="ele_name">AccountBO.RelationshipValue</xsl:with-param>
                    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.RelationshipValue</xsl:with-param>
               	    <xsl:with-param name="fn_onBlur">formatNumber("AccountBO.RelationshipValue");</xsl:with-param>
                    <xsl:with-param name="read_val">true</xsl:with-param>
                    </xsl:call-template>
    </xsl:template>
             <xsl:template name="AccountBO.NumberOfProducts">
                                 <xsl:call-template name="label">
                                 <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.NumberOfProducts']"/>
                                   <xsl:with-param name="ele_name">AccountBO.NumberOfProducts</xsl:with-param>
                                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.NumberOfProducts</xsl:with-param>
                                   <xsl:with-param name="read_val">true</xsl:with-param>
				   <xsl:with-param name="fn_onBlur">formatNumber("AccountBO.NumberOfProducts");</xsl:with-param>

                                 </xsl:call-template>
             </xsl:template>
             <xsl:template name="AccountBO.sicCode">
                 <xsl:call-template name="label">
                 <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.sicCode']"/>
                   <xsl:with-param name="ele_name">AccountBO.sicCode</xsl:with-param>
                   <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.sicCode</xsl:with-param>
                 </xsl:call-template>
             </xsl:template>
             <xsl:template name="AccountBO.MaidenNameOfMother">
                 <xsl:call-template name="label">
                 	<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.MaidenNameOfMother']"/>
                 	<xsl:with-param name="ele_name">AccountBO.MaidenNameOfMother</xsl:with-param>
                    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MaidenNameOfMother</xsl:with-param>
                    <xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
                 </xsl:call-template>
             </xsl:template>
<!-- Changes Start for Tracker# 88635-->
             <xsl:template name="AccountBO.strField7">
                <xsl:call-template name="label">
               	<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.strField7']"/>
               	<xsl:with-param name="ele_name">AccountBO.strField7</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.strField7</xsl:with-param>
                 </xsl:call-template>
             </xsl:template>
<!-- Changes End for Tracker#  88635-->


             <xsl:template name="AccountBO.tickerSymbol">
                         <xsl:call-template name="label">
                         <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.tickerSymbol']"/>
                           <xsl:with-param name="ele_name">AccountBO.tickerSymbol</xsl:with-param>
                           <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.tickerSymbol</xsl:with-param>
                         </xsl:call-template>
             </xsl:template>

            <!-- <xsl:template name="AccountBO.StaffEmployeeID">
                         <xsl:call-template name="label">
                         <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StaffEmployeeID']"/>
                           <xsl:with-param name="ele_name">AccountBO.StaffEmployeeID</xsl:with-param>
	                             <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.StaffEmployeeID</xsl:with-param> -->
                           <!-- Tracker 68932 Begin of Changes-->
	                           <!--  <xsl:with-param name="fn_onKeyPress">validateKeys()</xsl:with-param> -->
                           <!-- Tracker 68932 End of Changes-->
	                          <!--   <xsl:with-param name="fn_onBlur">setEmploymentProof();</xsl:with-param> -->
                          <!-- <xsl:with-param name="fn_onBlur">txtLimit(this,10,'<xsl:value-of select="$boName"/>.StaffEmployeeID',"StaffEmployeeID");</xsl:with-param>-->

                           <!-- Tracker 61888 Begin of Changes-->
	                          <!--   <xsl:with-param name="starshow">true</xsl:with-param> -->
                           <!-- Tracker 61888 End of Changes-->
	                          <!-- </xsl:call-template>
	           </xsl:template>
	           -->


	  	 	<xsl:template name="AccountBO.StaffEmployeeID">
	  	 	<xsl:call-template name="lookup">
	  	 	<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StaffEmployeeID']"/>
	  	 	<xsl:with-param name="elename">AccountBO.StaffEmployeeID</xsl:with-param>
	  	 	<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.StaffEmployeeID</xsl:with-param>
	  	 	<xsl:with-param name="starshow">true</xsl:with-param>
	  	 	<xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
	  	 	<xsl:with-param name="buttonone_name">LookUp</xsl:with-param>
	  	 	<xsl:with-param name="buttontwo_name">Clear</xsl:with-param>
	  	 	<!--Tracker id : 119498 begin of changes
				Description : CIF retail -> New Entity ->Customer
				In general> sub tab basic info not able to enter the
				value in  the field EmployeeID.Its displaying null
				for all the entered values.
				Expected result:
				AS per the 11.0 Usability enhancement,User should be allowed to enter values . -->
	  	 	<xsl:with-param name="buttonone_fnc">fnBluropenEmployeeIDLookup('StaffEmployeeID')</xsl:with-param>
	  	 	<!--Tracker id : 119498 end of changes-->
	  	 	<xsl:with-param name="buttontwo_fnc">clearLookup("EmpID")</xsl:with-param>
	  	 	<xsl:with-param name="checkASCII">false</xsl:with-param>
                         </xsl:call-template>
         </xsl:template>
         <xsl:template name="AccountBO.CombinedStatementFlg">
                 <xsl:call-template name="mdrpdown">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.CombinedStatementFlg']"/>
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CombinedStatementFlg</xsl:with-param>
                        <xsl:with-param name="selectdisp">AccountBO.CombinedStatementFlg</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                        <xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.CombinedStatementFlg</xsl:with-param>
                </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.PlaceOfBirth">
            <!-- Tracker Id 62416 Begin of changes-->
            <!-- Converting text box to city lookup-->
            <xsl:call-template name="lookup">
	        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PlaceOfBirth']"/>
	        <xsl:with-param name="elename">AccountBO.PlaceOfBirth</xsl:with-param>
	        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.PlaceOfBirth</xsl:with-param>
	        <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
	        <xsl:with-param name="buttonone_fnc">categoryLookup('CITY', 'AccountBO.PlaceOfBirth')</xsl:with-param>
	        <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.PlaceOfBirth')</xsl:with-param>
	        <xsl:with-param name="checkASCII">false</xsl:with-param>
            </xsl:call-template>
            <!-- Tracker Id 62416 End of changes-->
        </xsl:template>
         <xsl:template name="AccountBO.CountryOfBirth">
        <xsl:call-template name="lookup">
        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.CountryOfBirth']"/>
        <xsl:with-param name="elename">AccountBO.CountryOfBirth</xsl:with-param>
        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.CountryOfBirth</xsl:with-param>
        <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
        <!-- Field Rationalization changes start-->
        <xsl:with-param name="code_req">true</xsl:with-param>
        <!-- Field Rationalization changes end-->
	<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
        <xsl:with-param name="buttonone_fnc">categoryLookup('COUNTRY', 'AccountBO.CountryOfBirth')</xsl:with-param>
        <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.CountryOfBirth')</xsl:with-param>
        <xsl:with-param name="checkASCII">false</xsl:with-param>
        </xsl:call-template>
                </xsl:template>
         <xsl:template name="AccountBO.ProofOfAgeFlag">
                <xsl:call-template name="mdrpdown">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.ProofOfAgeFlag']"/>
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.ProofOfAgeFlag</xsl:with-param>
                        <xsl:with-param name="selectdisp">AccountBO.ProofOfAgeFlag</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                        <xsl:with-param name="onchangefn">disableConditionally('<xsl:value-of select="$boName"/>.ProofOfAgeFlag', '<xsl:value-of select="$boName"/>.ProofOfAgeDocument');validateAgeProof();</xsl:with-param>
                        <xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="choice_name">AccountBO.ProofOfAgeFlag</xsl:with-param>
                </xsl:call-template>
         </xsl:template>
         <xsl:template name="AccountBO.ProofOfAgeDocument">
                <xsl:call-template name="mdrpdown">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.ProofOfAgeDocument']"/>
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.ProofOfAgeDocument</xsl:with-param>
                        <xsl:with-param name="selectdisp">AccountBO.ProofOfAgeDocument</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                        <xsl:with-param name="onchangefn">setAgeProof();</xsl:with-param>
                        <xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="choice_name">AccountBO.ProofOfAgeDocument</xsl:with-param>
                </xsl:call-template>
         </xsl:template>
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
			<xsl:with-param name="defValByUrl">true</xsl:with-param>
                </xsl:call-template>
        </xsl:template>
        <xsl:template name="AccountBO.CreditBureauScore">
            <xsl:call-template name="label">
                 <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.CreditBureauScore']"/>
                 <xsl:with-param name="read_val">true</xsl:with-param>
                 <xsl:with-param name="ele_name">AccountBO.CreditBureauScore</xsl:with-param>
                 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CreditBureauScore</xsl:with-param>
            </xsl:call-template>
        </xsl:template>

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
<!--ML3 changes end-->
                 <xsl:template name="AccountBO.CustomerNREFlg">
                        <xsl:call-template name="mdrpdown">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.CustomerNREFlg']"/>
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CustomerNREFlg</xsl:with-param>
                        <xsl:with-param name="selectdisp">AccountBO.CustomerNREFlg</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                        <xsl:with-param name="search_type">value</xsl:with-param>
			<!-- Tracker 61887 Begin of Changes-->
			<xsl:with-param name="onchangefn">makeDateMand()</xsl:with-param>
			<!-- Tracker 61887 Begin of Changes-->
			<xsl:with-param name="choice_name">AccountBO.CustomerNREFlg</xsl:with-param>
                        </xsl:call-template>
                 </xsl:template>
                 <xsl:template name="AccountBO.CustomerMinor">
                        <xsl:call-template name="mdrpdown">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.CustomerMinor']"/>
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CustomerMinor</xsl:with-param>
                        <xsl:with-param name="selectdisp">AccountBO.CustomerMinor</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                        <xsl:with-param name="onchangefn">checkAge();</xsl:with-param>
                        <xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.CustomerMinor</xsl:with-param>
                        </xsl:call-template>
                 </xsl:template>
                    <!-- Senior Citizen Starts-->
		 <xsl:template name="AccountBO.SeniorCitizen">
			<xsl:call-template name="mdrpdown">
			  <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.SeniorCitizen']"/>
			  <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.SeniorCitizen</xsl:with-param>-->
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
                 <xsl:template name="AccountBO.CustomerTrade">
                        <xsl:call-template name="mdrpdown">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.CustomerTrade']"/>
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CustomerTrade</xsl:with-param>
                        <xsl:with-param name="selectdisp">AccountBO.CustomerTrade</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                        <xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.CustomerTrade</xsl:with-param>
                        </xsl:call-template>
                 </xsl:template>
<!--  RefCode Changes	-->
	<!-- Changes for tracker 356432 starts -->
       <xsl:template name="AccountBO.status">
	           <xsl:call-template name="lookup">
	          <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Status_code']"/>
	           <xsl:with-param name="elename">AccountBO.Status_code</xsl:with-param>
	           <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.status</xsl:with-param>
	           <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	           <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
	           <xsl:with-param name="buttonone_fnc">categoryLookup('CUSTOMER_STATUS', 'AccountBO.Status_code')</xsl:with-param>
	           <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.Status_code')</xsl:with-param>
	           <xsl:with-param name="checkASCII">false</xsl:with-param>
	          </xsl:call-template>
   	</xsl:template>
	<!-- Changes for tracker 356432 ends -->
<!--  RefCode Changes	-->
                 <xsl:template name="AccountBO.Cust_Staff_Status">
                        <xsl:call-template name="mdrpdown">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Staff_Status']"/>
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Cust_Staff_Status</xsl:with-param>
                        <xsl:with-param name="selectdisp">AccountBO.Cust_Staff_Status</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                        <xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="choice_name">AccountBO.Cust_Staff_Status</xsl:with-param>
                        </xsl:call-template>
                 </xsl:template>
          <!-- Customization Change: changes for dropdown to lookup Starts:CallID 226569  -->
           <xsl:template name="AccountBO.region">
		     <xsl:call-template name="lookup">
		     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.region']"/>
		     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.region</xsl:with-param>
		     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.region</xsl:with-param>
		     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		     <xsl:with-param name="buttonone_fnc">categoryLookup('REGION', '<xsl:value-of select="$boName"/>.region')</xsl:with-param>
		     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.region')</xsl:with-param>
		     <xsl:with-param name="checkASCII">false</xsl:with-param>
		     <xsl:with-param name="code_req">true</xsl:with-param>
		     </xsl:call-template>
	 </xsl:template>   
           <!-- Customization Change: changes for dropdown to lookup ends:CallID 226569  -->

  <!-- Field Rationalization start-->
           <xsl:template name="AccountBO.converted_Date">
               <xsl:call-template name="label">
                    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.converted_Date']"/>
                    <xsl:with-param name="read_val">true</xsl:with-param>
                    <xsl:with-param name="disable_val">true</xsl:with-param>
                    <xsl:with-param name="ele_name">AccountBO.converted_Date</xsl:with-param>
                    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.converted_Date</xsl:with-param>
                    <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		    <!-- calling the function isGregDate for on blur functionality-->
                    <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.converted_Date");</xsl:with-param>
                    <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
               </xsl:call-template>
           </xsl:template>

           <xsl:template name="AccountBO.OldEntityType">
               <xsl:call-template name="label">
                    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.OldEntityType']"/>
                    <xsl:with-param name="read_val">true</xsl:with-param>
                    <xsl:with-param name="disable_val">true</xsl:with-param>
                    <xsl:with-param name="ele_name">AccountBO.OldEntityType</xsl:with-param>
                    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.OldEntityType</xsl:with-param>
               </xsl:call-template>
           </xsl:template>

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
           		    <!-- DEF-333 Begin of Changes-->
           		    </xsl:template>
           		    <!-- DEF-333 End of Changes-->
           		    <!-- Changes for Tracker id:294484 and Ticket Id:483780 Starts Here -->
                    <!-- <xsl:template name="AccountBO.Segmentation_Class">
                           <xsl:call-template name="mdrpdown">
                           <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Segmentation_Class']"/>
                           <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Segmentation_Class</xsl:with-param>
                           <xsl:with-param name="selectdisp">AccountBO.Segmentation_Class</xsl:with-param>
   			
   				<xsl:with-param name="presdata" select="$PresData"/>
   			
                           <xsl:with-param name="search_type">value</xsl:with-param>
   			   <xsl:with-param name="choice_name">AccountBO.Segmentation_Class</xsl:with-param>
                           <xsl:with-param name="onchangefn">loadSubSeg();</xsl:with-param>
                           </xsl:call-template> 
                           
                    </xsl:template> -->
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
		    		     <!-- Changes for Tracker id:294484 and Ticket Id:483780 Ends Here -->
<!--Isic changes by Silvester starts-->
		 <xsl:template name="AccountBO.strField9">
			<xsl:call-template name="mdrpdown">
			  <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.strField9']"/>
			  <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.strField9</xsl:with-param>-->
			  <xsl:with-param name="selectdisp">.strField9</xsl:with-param>
			  <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.strField9</xsl:with-param>
			  <xsl:with-param name="choice_name">AccountBO.strField9</xsl:with-param>
			  <xsl:with-param name="search_type">url</xsl:with-param>
			  <xsl:with-param name="onchangefn">SegmentValidation();</xsl:with-param>			    
			    <xsl:with-param name="presdata" select="$PresData"/>
			  </xsl:call-template>
		</xsl:template>

		<xsl:template name="AccountBO.StrField16">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrField16']"/>
					<xsl:with-param name="selectdisp">AccountBO.StrField16</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrField16</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.StrField16</xsl:with-param>
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="onchangefn">ISICValidation('ISICP2','.StrField16','.StrField18','ISICP1')</xsl:with-param> 
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
		</xsl:template>  

	  	<xsl:template name="AccountBO.StrField18">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrField18']"/>
					<xsl:with-param name="selectdisp">AccountBO.StrField18</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrField18</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.StrField18</xsl:with-param>
					<xsl:with-param name="search_type">value</xsl:with-param>
					<!--<xsl:with-param name="onchangefn">ISICValidation('ISIC_DEMAND1','.StrField18','.StrField19','ISICP2')</xsl:with-param> -->
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
		</xsl:template>
	  	<xsl:template name="AccountBO.StrField19">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrField19']"/>
					<xsl:with-param name="selectdisp">AccountBO.StrField19</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrField19</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.StrField19</xsl:with-param>
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="onchangefn">ISICValidation('ISIC_DEMAND2','.StrField19','.StrField21','ISIC_DEMAND1')</xsl:with-param> 
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
		</xsl:template>

		  <xsl:template name="AccountBO.StrField21">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrField21']"/>
					<xsl:with-param name="selectdisp">AccountBO.StrField21</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrField21</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.StrField21</xsl:with-param>
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
		</xsl:template>

<!--Isic changes by Silvester ends-->

		<xsl:template name="AccountBO.StrUserField24">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField24']"/>
					<xsl:with-param name="selectdisp">AccountBO.StrUserField24</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField24</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.StrUserField24</xsl:with-param>
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
		</xsl:template>

		<xsl:template name="AccountBO.StrUserField25">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField25']"/>
					<xsl:with-param name="selectdisp">AccountBO.StrUserField25</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField25</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.StrUserField25</xsl:with-param>
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
		</xsl:template>

		<xsl:template name="AccountBO.StrUserField26">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField26']"/>
					<xsl:with-param name="selectdisp">AccountBO.StrUserField26</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField26</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.StrUserField26</xsl:with-param>
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
		</xsl:template>


<!--Isic Secondary Economic Activity changes by Silvester starts-->

	<xsl:template name="AccountBO.StrUserField6">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField6']"/>
		   	<xsl:with-param name="selectdisp">AccountBO.StrUserField6</xsl:with-param>
			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField6</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.StrUserField6</xsl:with-param>
			<xsl:with-param name="onchangefn">ISICValidation('SUB_SECTOR_CODE','.StrUserField6','.StrUserField7','SECTOR_CODE')</xsl:with-param> 
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
		 </xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.StrUserField7">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField7']"/>
			<xsl:with-param name="selectdisp">AccountBO.StrUserField7</xsl:with-param>
			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField7</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.StrUserField7</xsl:with-param>
			<!-- Changes for ISIC Subsector Starts  -->
			<xsl:with-param name="onchangefn">ISICValidation('ISICP1','.StrUserField7','.StrUserField2','SUB_SECTOR_CODE')</xsl:with-param> 
			<!-- Changes for ISIC Subsector by Sundar ENDS  -->
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
	</xsl:template>

		<xsl:template name="AccountBO.StrUserField2">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField2']"/>
					<xsl:with-param name="selectdisp">AccountBO.StrUserField2</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField2</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.StrUserField2</xsl:with-param>
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="onchangefn">ISICValidation('ISICP2','.StrUserField2','.StrUserField23','ISICP1')</xsl:with-param> 
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
		</xsl:template>



		  <xsl:template name="AccountBO.StrUserField23">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField23']"/>
					<xsl:with-param name="selectdisp">AccountBO.StrUserField23</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField23</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.StrUserField23</xsl:with-param>
					<xsl:with-param name="search_type">value</xsl:with-param>
					<!--<xsl:with-param name="onchangefn">ISICValidation('ISIC_DEMAND1','.StrUserField23','.StrUserField3','ISICP2')</xsl:with-param> -->
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
		</xsl:template>


	  	<xsl:template name="AccountBO.StrUserField3">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField3']"/>
					<xsl:with-param name="selectdisp">AccountBO.StrUserField3</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField3</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.StrUserField3</xsl:with-param>
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="onchangefn">ISICValidation('ISIC_DEMAND2','.StrUserField3','.StrUserField9','ISIC_DEMAND1')</xsl:with-param> 
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
		</xsl:template>


		<xsl:template name="AccountBO.StrUserField9">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField9']"/>
					<xsl:with-param name="selectdisp">AccountBO.StrUserField9</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField9</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.StrUserField9</xsl:with-param>
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
		</xsl:template>

<!--Isic Secondary Economic Activity changes by Silvester ends-->
                   <xsl:template name="AccountBO.SubSegment">
                            <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.SubSegment']"/>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.SubSegment</xsl:with-param>
                            <xsl:with-param name="selectdisp">AccountBO.SubSegment</xsl:with-param>
    			<!-- CIF Changes for Caching Views : Start -->
    				<xsl:with-param name="presdata" select="$PresData"/>
    			<!-- CIF Changes for Caching Views : End -->
                            <xsl:with-param name="search_type">value</xsl:with-param>
    			<xsl:with-param name="choice_name">AccountBO.SubSegment</xsl:with-param>
                            </xsl:call-template>
                     </xsl:template>

 <!-- Field Rationalization end-->
                 <xsl:template name="AccountBO.Category">
                        <xsl:call-template name="mdrpdown">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Category']"/>
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Category</xsl:with-param>
                        <xsl:with-param name="selectdisp">AccountBO.Category</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                        <xsl:with-param name="search_type">value</xsl:with-param>
	<xsl:with-param name="choice_name">AccountBO.Category</xsl:with-param>
                        </xsl:call-template>
                 </xsl:template>
                 <xsl:template name="AccountBO.AutoApproval">
                        <xsl:call-template name="mdrpdown">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.AutoApproval']"/>
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.AutoApproval</xsl:with-param>
                        <xsl:with-param name="selectdisp">AccountBO.AutoApproval</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                        <xsl:with-param name="search_type">value</xsl:with-param>
	<xsl:with-param name="choice_name">AccountBO.AutoApproval</xsl:with-param>
                        </xsl:call-template>
                 </xsl:template>
                <xsl:template name="AccountBO.priorityCode">
                        <xsl:call-template name="mdrpdown">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.priorityCode']"/>
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.priorityCode</xsl:with-param>
                        <xsl:with-param name="search_type">value</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                        <xsl:with-param name="selectdisp">PriorityCode</xsl:with-param>
		<xsl:with-param name="choice_name">AccountBO.priorityCode</xsl:with-param>
                        </xsl:call-template>
                </xsl:template>
<xsl:template name="AccountBO.preferredChannelID">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.preferredChannelID']"/>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.preferredChannelID</xsl:with-param>
        <xsl:with-param name="selectdisp">AccountBO.preferredChannelID</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
        <xsl:with-param name="search_type">url</xsl:with-param>
	<xsl:with-param name="choice_name">AccountBO.preferredChannelID</xsl:with-param>
        </xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.FreezeProductSale">
    <xsl:call-template name="mdrpdown">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.FreezeProductSale']"/>
    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.FreezeProductSale</xsl:with-param>
    <xsl:with-param name="selectdisp">AccountBO.FreezeProductSale</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
    <xsl:with-param name="search_type">value</xsl:with-param>
	<xsl:with-param name="choice_name">AccountBO.FreezeProductSale</xsl:with-param>
	<xsl:with-param name="defValByUrl">true</xsl:with-param>
    </xsl:call-template>
</xsl:template>
<!-- <xsl:template name="AccountBO.RelationshipMgrID">
    <xsl:call-template name="lookup">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.RelationshipMgrID']"/>
    <xsl:with-param name="elename">RelationshipMgr</xsl:with-param>
    <xsl:with-param name="eleval">RelationshipMgr</xsl:with-param>
    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
    <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
    <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
    <xsl:with-param name="buttonone_fnc">openAgentLookup('RelationshipMgr')</xsl:with-param>
    <xsl:with-param name="buttontwo_fnc">setAgentValues('RelationshipMgr','','')</xsl:with-param>
    </xsl:call-template>
    <input type="hidden" name="AccountBO.RelationshipMgrID" value="{$boDet[@n=concat($boName,'.RelationshipMgrID')]}"/>

</xsl:template>
 -->
<xsl:template name="AccountBO.Manager">
    <xsl:call-template name="lookup">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Manager']"/>
    <xsl:with-param name="elename">Acc_manager</xsl:with-param>
    <xsl:with-param name="eleval">Acc_manager</xsl:with-param>
    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
    <!-- Field Rationalization starts -->
    <xsl:with-param name="linkshow">true</xsl:with-param>
    <xsl:with-param name="fncname">agentDetails(document.frm2.Acc_manager.value);</xsl:with-param>
    <!-- Field Rationalization ends -->
    <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
    <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
    <!-- Tracker id 120008 changes for MATT BUG FIXES start -->
    <xsl:with-param name="buttonone_fnc">fnBluropenAgentLookup('Acc_manager')</xsl:with-param>
    <!-- Tracker id 120008 changes for MATT BUG FIXES end -->
    <xsl:with-param name="buttontwo_fnc">setAgentValues('Acc_manager','','')</xsl:with-param>
    </xsl:call-template>
    <!-- Field Rationalization fix -->
    <input type="hidden" name="Acc_managerURL" value=""/>
    <input type="hidden" name="AccountBO.Manager" value="{$boDet[@n=concat($boName,'.Manager')]}"/>

		<!-- Tracker# 89187, Begin of Changes -->
		<input type="hidden" name="AccountBO.RelationshipMgrID" value="{$boDet[@n=concat($boName,'.RelationshipMgrID')]}"/>
		<!-- Tracker# 89187, End of Changes -->
	 <!--Fix for Ticket id 624014 start-->
         <input type="hidden" name="SECUREHKEY"  value="{$HASHKEY}"/>
  	 <input type="hidden" name="FLDHASHKEY"  value="{$KEYFIELD}"/>
         <!--Fix for Ticket id 624014 end-->	

</xsl:template>
<xsl:template name="AccountBO.SecondaryRM_ID">
    <xsl:call-template name="lookup">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.SecondaryRM_ID']"/>
    <xsl:with-param name="elename">Sec_manager</xsl:with-param>
    <xsl:with-param name="eleval">Sec_manager</xsl:with-param>
    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
    <!-- Field Rationalization starts -->
    <xsl:with-param name="linkshow">true</xsl:with-param>
    <xsl:with-param name="fncname">agentDetails(document.frm2.Sec_manager.value);</xsl:with-param>
    <!-- Field Rationalization ends -->
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

<xsl:template name="AccountBO.TertiaryRM_ID">
    <xsl:call-template name="lookup">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.TertiaryRM_ID']"/>
    <xsl:with-param name="elename">Ter_manager</xsl:with-param>
    <xsl:with-param name="eleval">Ter_manager</xsl:with-param>
    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
    <!-- Field Rationalization starts -->
    <xsl:with-param name="linkshow">true</xsl:with-param>
    <xsl:with-param name="fncname">agentDetails(document.frm2.Ter_manager.value);</xsl:with-param>
    <!-- Field Rationalization ends -->
    <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
    <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
    <!-- Tracker id 120008 changes for MATT BUG FIXES start -->
    <xsl:with-param name="buttonone_fnc">fnBluropenAgentLookup('Ter_manager')</xsl:with-param>
    <!-- Tracker id 120008 changes for MATT BUG FIXES end -->
    <xsl:with-param name="buttontwo_fnc">setAgentValues('Ter_manager','','')</xsl:with-param>
    </xsl:call-template>
    <!-- Field Rationalization fix -->
    <input type="hidden" name="Ter_managerURL" value=""/>
</xsl:template>

<xsl:template name="AccountBO.RelationshipCreatedByID">
    <xsl:call-template name="lookup">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.RelationshipCreatedByID']"/>
    <xsl:with-param name="elename">RelationshipCreatedBy</xsl:with-param>
    <xsl:with-param name="eleval">RelationshipCreatedBy</xsl:with-param>
    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
    <!-- Tracker 191577 changes start -->
    <xsl:with-param name="disable_val">true</xsl:with-param>
    <!-- Tracker 191577 changes end -->
    <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
    <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
    <!--113276 changes start for bug fix -->
    <xsl:with-param name="buttonone_fnc">fnBluropenAgentLookup('RelationshipCreatedBy')</xsl:with-param>
    <!--113276 changes end for bug fix-->
    <xsl:with-param name="buttontwo_fnc">setAgentValues('RelationshipCreatedBy','','')</xsl:with-param>
    </xsl:call-template>
    <input type="hidden" name="AccountBO.RelationshipCreatedByID" value="{$boDet[@n=concat($boName,'.RelationshipCreatedByID')]}"/>
    <!-- Tracker# 49738, End of Changes -->
</xsl:template>
<xsl:template name="AccountBO.notes">
 <xsl:call-template name="mtextarea">
	<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.notes']"/>
	<xsl:with-param name="mname">AccountBO.notes</xsl:with-param>
	 <xsl:with-param name="mvalue"><xsl:value-of select="$boName"/>.notes</xsl:with-param>
	 <xsl:with-param name="mwrap">on</xsl:with-param>
	 <xsl:with-param name="mrows">2</xsl:with-param>
	 <xsl:with-param name="mcols">77</xsl:with-param>
     <xsl:with-param name="mcolspan">5</xsl:with-param>
     <!-- tracker 68935 begin of changes -->
     <xsl:with-param name="fn_onblur">txtLimit(this,4000,'<xsl:value-of select="$boName"/>.notes',"Notes")</xsl:with-param>
     <!-- tracker 68935 end of changes -->
     <xsl:with-param name="checkASCII">false</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
<!--  addition of CORE Fields :start -->
<xsl:template name="AccountBO.Name">
	   <xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Name']"/>
	    <xsl:with-param name="ele_name">AccountBO.Name</xsl:with-param>
	    <!-- Reverting change done by Aditya as part of 318135 -->
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Name</xsl:with-param>
	    <xsl:with-param name="starshow">true</xsl:with-param>
	    <xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
<!--tracker id 113227 defect fix start here-->
	    <!--<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>-->
	    <xsl:with-param name="fn_onBlur">set();set_isName(this,true);</xsl:with-param>
<!--tracker id 113227 defect fix ends here-->
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	   </xsl:call-template>
</xsl:template>
<!--Tracker ID 113227 starts-->
<xsl:template name="AccountBO.Name_alt1">
	   <xsl:call-template name="label_alternate">
	   <!-- Change for tracker 196316 : Begin -->
	   <!-- Change done to display the value of AccountBO.Name_alt1 instead of AccountBO.Name -->
	   <!--Changes begin for ticket id# 328581-->
	    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Name']"/>
	    <!--Changes end for ticket id# 328581-->
	    <xsl:with-param name="ele_name">AccountBO.Name_alt1</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Name_alt1</xsl:with-param>
	    <!-- Change for tracker 196316 : End -->
	    <xsl:with-param name="starshow">true</xsl:with-param>
	    <xsl:with-param name="checkASCII">false</xsl:with-param>
	    <!--tracker id 113227 defect fix start here-->
	    <xsl:with-param name="fn_onBlur">set_alt();set_isName(this,true);</xsl:with-param>
	    <!--tracker id 113227 defect fix ends here-->
	   </xsl:call-template>
</xsl:template>
<!--Tracker ID 113227 ends-->
<!--  RefCode Changes	-->
            <xsl:template name="AccountBO.Cust_community">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_commu_code']"/>
                            <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.Cust_community</xsl:with-param>-->
                            <xsl:with-param name="selectdisp">AccountBO.Cust_commu_code</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Cust_community</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                            <xsl:with-param name="choice_name">AccountBO.Cust_commu_code</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>

<!--  RefCode Changes	-->
<!--  RefCode Changes	-->
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
<!--  RefCode Changes	-->
<xsl:template name="AccountBO.IntroducerName">
	   <xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.IntroducerName']"/>
	    <xsl:with-param name="ele_name">AccountBO.IntroducerName</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.IntroducerName</xsl:with-param>
	    <xsl:with-param name="starshow">true</xsl:with-param>
	    <xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
	    <xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	   </xsl:call-template>
	</xsl:template>
 	<!--Access Control changes-->
	 <xsl:template name="AccountBO.accessOwnerGroup">
		     <xsl:call-template name="mdrpdown">
			 <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.accessOwnerGroup']"/>
			 <xsl:with-param name="selectname">AccountBO.accessOwnerGroup</xsl:with-param>
			 <xsl:with-param name="selectdisp">AccountBO.accessOwnerGroup</xsl:with-param>
			 <xsl:with-param name="search_type">value</xsl:with-param>
			 <xsl:with-param name="presdata" select="$PresData"/>
			 <xsl:with-param name="choice_name">AccountBO.accessOwnerGroup</xsl:with-param>
			 <xsl:with-param name="onchangefn">setAccessOwnerGroup();</xsl:with-param>
		     </xsl:call-template>
	 </xsl:template>

	 <xsl:template name="AccountBO.accessOwnerSegment">
		     <xsl:call-template name="mdrpdown">
			 <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.accessOwnerSegment']"/>
			 <xsl:with-param name="selectname">AccountBO.accessOwnerSegment</xsl:with-param>
			 <xsl:with-param name="selectdisp">AccountBO.accessOwnerSegment</xsl:with-param>
			 <xsl:with-param name="presdata" select="$PresData"/>
			 <xsl:with-param name="search_type">value</xsl:with-param>
			 <xsl:with-param name="choice_name">AccountBO.accessOwnerSegment</xsl:with-param>
			 <xsl:with-param name="onchangefn">setAccessOwnerSegment();</xsl:with-param>
		     </xsl:call-template>
	</xsl:template>

	<xsl:template name="AccountBO.accessOwnerBC">
		<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.accessOwnerBC']"/>

			<xsl:with-param name="elename">AccountBO.accessOwnerBC</xsl:with-param>
			<xsl:with-param name="eleval">AccountBO.accessOwnerBC</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="buttonone_name" ><xsl:value-of select="$configLabels[@name='LOOKUP']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="buttontwo_name" ><xsl:value-of select="$configLabels[@name='CLEAR']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			<!--xsl:with-param name="buttonone_fnc">openBCCodeLookup('accessOwnerBC')</xsl:with-param-->
			<xsl:with-param name="buttonone_fnc">fnBlurFunction('BusinessCenter')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">setBCCodeValues('accessOwnerBC','','')</xsl:with-param>

		</xsl:call-template>
	</xsl:template>

	<!--End of changes-->
<xsl:template name="RelationshipBO.Bank_Entity_Name1">
	<xsl:call-template name="lookup">
		<xsl:with-param name="res_name" select="$configLabelsMinor[@name='URL']"/>
		<xsl:with-param name="elename">RelationshipBO.Bank_Entity_Name1</xsl:with-param>
		<xsl:with-param name="eleval">RelationshipBO.Bank_Entity_Name1</xsl:with-param>
		<!--Tracker id:145001 changes begin-->
		<xsl:with-param name="buttonone_name"><xsl:value-of select="$configLabelsMinor[@name='LookUp']/@configLabel"/></xsl:with-param>
 		<xsl:with-param name="buttontwo_name"><xsl:value-of select="$configLabelsMinor[@name='Clear']/@configLabel"/></xsl:with-param>
 		<!--xsl:with-param name="buttonone_fnc">accountLookupIntro()</xsl:with-param-->
 		<xsl:with-param name="buttonone_fnc">fnBlurAccountLookupIntro('Intro')</xsl:with-param>
		<xsl:with-param name="buttontwo_fnc">clearLookUpIntro()</xsl:with-param>
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
 		<!--Tracker id:145001 changes begin-->
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
		<xsl:with-param name="defValByUrl">true</xsl:with-param>
	</xsl:call-template>
 </xsl:template>

 <xsl:template name="RelationshipBO.Bank_Entity1">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabelsMinor[@name='Relationship_Bank_Entity']"/>
		<!-- Start of Changes for Ticket - 249521  -->
		<xsl:with-param name="selectname">RelationshipBO.Bank_Entity1</xsl:with-param>
		<!-- end of changes for Ticket - 249521  -->
		<xsl:with-param name="selectdisp">RelationshipBO.Bank_Entity1</xsl:with-param>
		<xsl:with-param name="onchangefn">DisplayLookUPIntro()</xsl:with-param>
        <xsl:with-param name="choice_name">RelationshipBO.Bank_Entity</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="defValByUrl">true</xsl:with-param>
	</xsl:call-template>
 </xsl:template>
	<xsl:template name="AccountBO.IntroducerID">
	   <xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.IntroducerID']"/>
	    <xsl:with-param name="ele_name">AccountBO.IntroducerID</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.IntroducerID</xsl:with-param>
	    <xsl:with-param name="starshow">true</xsl:with-param>
	    <xsl:with-param name="checkASCII">false</xsl:with-param>
	   </xsl:call-template>
	</xsl:template>
<!--  RefCode Changes	-->
<!-- Changes for Tracker id:294484 and Ticket Id:483780 Starts Here -->
            <!-- <xsl:template name="AccountBO.Tds_tbl">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Tds_tbl_code']"/>
                           
                            <xsl:with-param name="selectdisp">AccountBO.Tds_tbl_code</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Tds_tbl</xsl:with-param>
		
				<xsl:with-param name="presdata" select="$PresData"/>
			
                            <xsl:with-param name="choice_name">AccountBO.Tds_tbl_code</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template> -->
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
			      <!-- Changes for Tracker id:294484 and Ticket Id:483780 ends Here -->

<!--  RefCode Changes	-->
<!--ML3 changes start-->
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
<!--ML3 changes end-->
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

<!--  RefCode Changes	-->
            <xsl:template name="AccountBO.Cust_hlth">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_hlth_code']"/>
                            <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.Cust_hlth</xsl:with-param>-->
                            <xsl:with-param name="selectdisp">AccountBO.Cust_hlth_code</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Cust_hlth</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                            <xsl:with-param name="choice_name">AccountBO.Cust_hlth_code</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>

<!--  RefCode Changes	-->

<!--<xsl:template name="AccountBO.Tds_cust_id">
   <xsl:call-template name="label">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Tds_cust_id']"/>
    <xsl:with-param name="ele_name">AccountBO.Tds_cust_id</xsl:with-param>
    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Tds_cust_id</xsl:with-param>
    <xsl:with-param name="checkASCII">false</xsl:with-param>
   </xsl:call-template>
</xsl:template>-->
<xsl:template name="AccountBO.Tds_cust_id">
    <xsl:call-template name="lookup">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Tds_cust_id']"/>
    <xsl:with-param name="elename">AccountBO.Tds_cust_id</xsl:with-param>
    <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.TDS_CIFID</xsl:with-param>
    <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
    <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
    <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
    <!--xsl:with-param name="buttonone_fnc">openTDSLookup()</xsl:with-param-->
    <!--changes for callid 709300-->
    <xsl:with-param name="buttonone_fnc">fnBlurFunctionNew('Tds_cust_id_retail','1')</xsl:with-param>
    <xsl:with-param name="buttontwo_fnc">clearLookupTds()</xsl:with-param>
    </xsl:call-template>
    <input type="hidden" name="AccountBO.Tds_cust_id" value="{$boDet[@n=concat($boName,'.Tds_cust_id')]}"/>
</xsl:template>
<!--<xsl:template name="AccountBO.Crncy_code">
    <xsl:call-template name="mdrpdown">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Crncy_code']"/>
    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Crncy_code</xsl:with-param>
    <xsl:with-param name="selectdisp">AccountBO.Crncy_code</xsl:with-param>
    <xsl:with-param name="choice_name">AccountBO.Crncy_code</xsl:with-param>-->
    <!-- Ticket Id:260622 Changes Start -->
   <!-- <xsl:with-param name="read_val">true</xsl:with-param>-->
    <!-- Ticket Id:260622 Changes End -->
			<!-- CIF Changes for Caching Views : Start -->
				<!--<xsl:with-param name="presdata" select="$PresData"/>-->
			<!-- CIF Changes for Caching Views : End -->
   <!-- <xsl:with-param name="search_type">value</xsl:with-param>
    </xsl:call-template>
</xsl:template>-->


<!-- Customization Change: changes for dropdown to lookup Starts:CallID 226569  -->
<xsl:template name="AccountBO.Crncy_code">
     <xsl:call-template name="lookup">
     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Crncy_code']"/>
     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Crncy_code</xsl:with-param>
     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Crncy_code</xsl:with-param>
     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
     <xsl:with-param name="buttonone_fnc">categoryLookup('CURRENCY', '<xsl:value-of select="$boName"/>.Crncy_code')</xsl:with-param>
     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Crncy_code')</xsl:with-param>
     <xsl:with-param name="checkASCII">false</xsl:with-param>
     <xsl:with-param name="code_req">true</xsl:with-param>
     </xsl:call-template>
 </xsl:template> 
 
 <!-- Customization Change: changes for dropdown to lookup ends:CallID 226569  -->

<!-- Field Rationalization changes start-->
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
     <xsl:with-param name="code_req">true</xsl:with-param>  <!-- change for callid 318169 -->
    </xsl:call-template>
</xsl:template>
<!-- Field Rationalization changes end-->

<xsl:template name="AccountBO.Offline_cum_debit_limit">
   <xsl:call-template name="label">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Offline_cum_debit_limit']"/>
    <xsl:with-param name="ele_name">AccountBO.Offline_cum_debit_limit</xsl:with-param>
    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Offline_cum_debit_limit</xsl:with-param>
    <xsl:with-param name="checkASCII">false</xsl:with-param>
    <!-- TrackerID:209607,CHANGES START -->
    <xsl:with-param name="fn_onBlur">formatNumber("2_AccountBO.Offline_cum_debit_limit");</xsl:with-param>
    <!-- TrackerID:209607,CHANGES END -->

   </xsl:call-template>
</xsl:template>
<!-- Changes for Tracker 566808 Changing from Dropdown to Lookup Start -->
<!-- Recon of Changes for Call 391057 start -->
   <xsl:template name="AccountBO.Pref_code">
	             <xsl:call-template name="lookup">
		     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Pref_code_rcode']"/>
	             <xsl:with-param name="elename">AccountBO.Pref_code</xsl:with-param>
	             <xsl:with-param name="eleval">AccountBO.Pref_code</xsl:with-param>
	             <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	             <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
	             <xsl:with-param name="buttonone_fnc">categoryLookup('PREF_CODE', 'AccountBO.Pref_code')</xsl:with-param>
	             <xsl:with-param name="buttontwo_fnc">clearCategoryValue('AccountBO.Pref_code')</xsl:with-param>
	             <xsl:with-param name="checkASCII">false</xsl:with-param>
		     <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
			     
		     
		     </xsl:call-template>
    </xsl:template>
<!-- Recon of Changes for Call 391057  end-->
<!-- Changes for Tracker 566808 Changing from Dropdown to Lookup End -->
            <xsl:template name="AccountBO.Introd_Status">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.IntroducerStatusCode']"/>
                            <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.Introd_Status</xsl:with-param>-->
                            <xsl:with-param name="selectdisp">AccountBO.IntroducerStatusCode</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Introd_Status</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                            <xsl:with-param name="choice_name">AccountBO.IntroducerStatusCode</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>

<!--  RefCode Changes	-->
 <xsl:template name="AccountBO.RatingDate">
    <xsl:call-template name="label">
     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.RatingDate']"/>
     <xsl:with-param name="ele_name">AccountBO.RatingDate</xsl:with-param>
     <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.RatingDate</xsl:with-param>
     <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
     <!-- calling the function isGregDate for on blur functionality-->
     <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.RatingDate");</xsl:with-param>
     <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
    </xsl:call-template>
 </xsl:template>

  <xsl:template name="AccountBO.ManagerOpinion">
     <xsl:call-template name="label">
      <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.ManagerOpinion']"/>
      <xsl:with-param name="ele_name">AccountBO.ManagerOpinion</xsl:with-param>
      <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.ManagerOpinion</xsl:with-param>
	  <xsl:with-param name="checkASCII">false</xsl:with-param>
     </xsl:call-template>
 </xsl:template>

 <xsl:template name="AccountBO.CustStatusChgDate">
      <xsl:call-template name="label">
       <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.CustStatusChgDate']"/>
       <xsl:with-param name="ele_name">AccountBO.CustStatusChgDate</xsl:with-param>
       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CustStatusChgDate</xsl:with-param>
       <xsl:with-param name="starshow">true</xsl:with-param>
       <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
       <!-- calling the function isGregDate for on blur functionality-->
       <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.CustStatusChgDate");</xsl:with-param>
       <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
      </xsl:call-template>
 </xsl:template>

 <xsl:template name="AccountBO.PurgeRemarks">
    <xsl:call-template name="label">
     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PurgeRemarks']"/>
     <xsl:with-param name="ele_name">AccountBO.PurgeRemarks</xsl:with-param>
     <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.PurgeRemarks</xsl:with-param>
	 <xsl:with-param name="checkASCII">false</xsl:with-param>
    </xsl:call-template>
 </xsl:template>

 <xsl:template name="AccountBO.NativeLangName">
     <xsl:call-template name="label">
      <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.NativeLangName']"/>
      <xsl:with-param name="ele_name">AccountBO.NativeLangName</xsl:with-param>
      <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.NativeLangName</xsl:with-param>
	  <xsl:with-param name="checkASCII">false</xsl:with-param>
	  <xsl:with-param name="max_length">10</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
	<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
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
<!--ERPBOCF1:TRACKER:113259:ENDOFCHANGES(HJRI)-->

<!--  RefCode Changes	-->
<!-- Changes for tracker id 338696 Starts  -->
  		<xsl:template name="AccountBO.NativeLangTitle">
		     <xsl:call-template name="lookup">
		     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.NativeLangTitle_code']"/>
		     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.NativeLangTitle</xsl:with-param>
		     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.NativeLangTitle</xsl:with-param>
		     <xsl:with-param name="code_req">true</xsl:with-param>
		     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		     <xsl:with-param name="buttonone_fnc">categoryLookup('PERSONSALUTATION', '<xsl:value-of select="$boName"/>.NativeLangTitle')</xsl:with-param>
		     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.NativeLangTitle')</xsl:with-param>
		     <xsl:with-param name="checkASCII">false</xsl:with-param>
		     </xsl:call-template>
		 </xsl:template> 
<!-- Changes for tracker id 338696 Ends  -->

<!--  RefCode Changes	-->
<xsl:template name="AccountBO.NativeLangCode">
	    <xsl:call-template name="mdrpdown">
		    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.NativeLangCode_code']"/>
		   <!-- <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.NativeLangCode</xsl:with-param>-->
		    <xsl:with-param name="selectdisp">AccountBO.NativeLangCode_code</xsl:with-param>
		    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.NativeLangCode</xsl:with-param>
		<!-- CIF Changes for Caching Views : Start -->
			<xsl:with-param name="presdata" select="$PresData"/>
		<!-- CIF Changes for Caching Views : End -->
		    <xsl:with-param name="choice_name">AccountBO.NativeLangCode_code</xsl:with-param>
		    <xsl:with-param name="search_type">url</xsl:with-param>
     </xsl:call-template>
 </xsl:template>
<xsl:template name="AccountBO.NREBecomingOrdDate">
     <xsl:call-template name="label">
      <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.NREBecomingOrdDate']"/>
      <xsl:with-param name="ele_name">AccountBO.NREBecomingOrdDate</xsl:with-param>
      <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.NREBecomingOrdDate</xsl:with-param>
      <xsl:with-param name="starshow">true</xsl:with-param>
      <xsl:with-param name="fn_onBlur">validateDate();</xsl:with-param>

     </xsl:call-template>
 </xsl:template>

<!--  RefCode Changes	-->
<!-- Changes for tracker id 338696 Starts  -->
			<!--<xsl:template name="AccountBO.Sector">
		     	     <xsl:call-template name="lookup">
		     	     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Sector_code']"/>
		     	     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Sector</xsl:with-param>
		     	     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Sector</xsl:with-param>
		     	     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		     	     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		     	     <xsl:with-param name="buttonone_fnc">categoryLookup('SECTOR_CODE', '<xsl:value-of select="$boName"/>.Sector')</xsl:with-param>-->
		     	     <!--Changes for tracker id 349611 STARTS-->
		     	    <!-- <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Sector')</xsl:with-param>-->
		     	     <!--Changes for tracker id 349611 ENDS-->
		     	    <!-- <xsl:with-param name="checkASCII">false</xsl:with-param>
		     	     </xsl:call-template>
		        </xsl:template>-->

			<xsl:template name="AccountBO.Sector">
		    		<xsl:call-template name="mdrpdown">
		    		     	<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Sector_code']"/>
		    		     	<xsl:with-param name="selectdisp">AccountBO.Sector_code</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Sector_code</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.Sector_code</xsl:with-param>
					<xsl:with-param name="onchangefn">ISICValidation('SUB_SECTOR_CODE','.Sector_code','.Subsector','SECTOR_CODE')</xsl:with-param> 
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
		    		</xsl:call-template>
		    	</xsl:template>
<!-- Changes for tracker id 338696 Ends  -->

<!--  RefCode Changes	-->
<!--  RefCode Changes	-->
<!--  Changes for tracker id 338696 starts	-->
         	<!--<xsl:template name="AccountBO.Subsector">
		     <xsl:call-template name="lookup">
		     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Subsector_code']"/>
		     <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Subsector</xsl:with-param>
		     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Subsector</xsl:with-param>
		     <xsl:with-param name="code_req">true</xsl:with-param>
		     <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		     <xsl:with-param name="buttonone_fnc">categoryLookup('SUB_SECTOR_CODE', '<xsl:value-of select="$boName"/>.Subsector')</xsl:with-param>-->
		     <!--Changes for tracker id 349611 STARTS-->
		    <!-- <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Subsector')</xsl:with-param>-->
		     <!--Changes for tracker id 349611 ENDS-->
		    <!-- <xsl:with-param name="checkASCII">false</xsl:with-param>
		     </xsl:call-template>
        	</xsl:template>-->

                 <xsl:template name="AccountBO.Subsector">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Subsector_code']"/>
					<xsl:with-param name="selectdisp">AccountBO.Subsector</xsl:with-param>
					<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Subsector</xsl:with-param>
					<xsl:with-param name="choice_name">AccountBO.Subsector</xsl:with-param>
					<!-- Changes for ISIC Subsector by Sundar Starts  -->
					<xsl:with-param name="onchangefn">ISICValidation('ISICP1','.Subsector','.StrField16','SUB_SECTOR_CODE')</xsl:with-param> 
					 <!-- Changes for ISIC Subsector by Sundar ENDS  -->
					<xsl:with-param name="search_type">value</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
		</xsl:template>

<!-- Changes for tracker id 338696 Ends  -->

<!-- Changes for Tracker # 88712 Start-->

            <xsl:template name="AccountBO.Groupid">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Groupid_code']"/>
                            <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.Groupid</xsl:with-param>-->
                            <xsl:with-param name="selectdisp">AccountBO.Groupid_code</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.groupID</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                            <xsl:with-param name="choice_name">AccountBO.Groupid_code</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>

<!--  Changes for tracker id 338696 starts  -->

<xsl:template name="AccountBO.Constitution_Code">
                <xsl:call-template name="lookup">
                                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Constitution_ref_code']"/>
                                <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Constitution_ref_code</xsl:with-param>
                                <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Constitution_Code</xsl:with-param>
                                <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
                                <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
                                <xsl:with-param name="buttonone_fnc">categoryLookup('CONSTITUTION_CODE', '<xsl:value-of select="$boName"/>.Constitution_ref_code')</xsl:with-param>
                                <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Constitution_ref_code')</xsl:with-param>
                                <xsl:with-param name="code_req">true</xsl:with-param>
                </xsl:call-template>
</xsl:template>


<!--  Changes for tracker id 338696 ends  -->

<!--  Changes for tracker id 338696 starts  -->
<xsl:template name="AccountBO.Rating">
     <xsl:call-template name="lookup">
	    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Rating_code']"/>
	    <xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Rating</xsl:with-param>
	    <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Rating</xsl:with-param>
	    <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	    <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
	    <xsl:with-param name="buttonone_fnc">categoryLookup('PRIORITY_IDENTIFIER', '<xsl:value-of select="$boName"/>.Rating')</xsl:with-param>
	    <xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Rating')</xsl:with-param>
	    <xsl:with-param name="code_req">true</xsl:with-param>
     </xsl:call-template>
</xsl:template>  
<!--  Changes for tracker id 338696 ends  -->
<!-- Changes for Tracker # 88712 End-->

<!--  RefCode Changes	-->

	<xsl:template name="AccountBO.MinorAttainMajorDate">
	   <xsl:call-template name="label">
		 <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.MinorAttainMajorDate']"/>
		 <xsl:with-param name="ele_name">AccountBO.MinorAttainMajorDate</xsl:with-param>
		 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MinorAttainMajorDate</xsl:with-param>
		 <!-- <xsl:with-param name="datehidden">MinorToMajorDate</xsl:with-param> --><!-- Tracker ID 113276 -->
		 <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		 <!-- calling the function isGregDate for on blur functionality-->
		 <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.MinorAttainMajorDate");</xsl:with-param>
		 <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
	    </xsl:call-template>
	</xsl:template>

  <!-- <xsl:template name="PurgeFlag">
     <xsl:call-template name="checkbox1">
	<xsl:with-param name="name">ckPurgeFlag</xsl:with-param>
	<xsl:with-param name="checkbox_val">true</xsl:with-param>
     </xsl:call-template>
  </xsl:template> -->

  <xsl:template name="AccountBO.PurgeFlag">
    <xsl:call-template name="mdrpdown">
    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PurgeFlag']"/>
    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.PurgeFlag</xsl:with-param>
    <xsl:with-param name="selectdisp">AccountBO.PurgeFlag</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
    <xsl:with-param name="choice_name">AccountBO.PurgeFlag</xsl:with-param>
    <xsl:with-param name="search_type">value</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
<!--Changes for Alert-Server recon in 10.2.14 starts-->
<xsl:template name="AccountBO.Enable_Alerts">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Enable_Alerts']" />
		<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Enable_Alerts</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.Enable_Alerts</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		<xsl:with-param name="choice_name">AccountBO.Enable_Alerts</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
		<xsl:with-param name="onchangefn">mandateDefault();</xsl:with-param>
	</xsl:call-template>

</xsl:template>
 <xsl:template name="AccountBO.DefaultChannel_Alert">
	<xsl:call-template name="listview">
		<xsl:with-param name="class">listBox</xsl:with-param>
		<xsl:with-param name="ele_name">AccountBO.DefaultChannel_Alert</xsl:with-param>
		<xsl:with-param name="label" select="$configLabels[@name='AccountBO.DefaultChannel_Alert']/@configLabel" />
		<xsl:with-param name="multiple">true</xsl:with-param>
		<xsl:with-param name="onchangefn"> savefieldAcc('AccountBO.DefaultChannel_Alert');</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.DefaultChannel_Alert</xsl:with-param>
		<xsl:with-param name="selectname">AccountBO.DefaultChannel_Alert</xsl:with-param>
		<xsl:with-param name="size">3</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
		<xsl:with-param name="search_type">url</xsl:with-param>
	    	<xsl:with-param name="presdata" select="$PresData"/>
	</xsl:call-template>		
</xsl:template>
<!--Changes for Alert-Server recon in 10.2.14 ends-->
<!--  addition of CORE Fields :end -->
  <!-- Card Holder Changes:Start-->

   <!-- Field Rationalization  changes start -->
    <xsl:template name="AccountBO.TFPartyFlag">
      <xsl:call-template name="mdrpdown">
      <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.TFPartyFlag']"/>
      <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.TFPartyFlag</xsl:with-param>
      <xsl:with-param name="selectdisp">AccountBO.TFPartyFlag</xsl:with-param>
      <!--<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>-->
      <xsl:with-param name="presdata" select="$PresData"/>
      <xsl:with-param name="onchangefn">isTFPartyFlag();</xsl:with-param>
      <xsl:with-param name="choice_name">AccountBO.TFPartyFlag</xsl:with-param>
      <xsl:with-param name="search_type">value</xsl:with-param>
      <xsl:with-param name="defValByUrl">true</xsl:with-param>
      </xsl:call-template>
    </xsl:template>

  <!-- Field Rationalization  changes end -->

  <xsl:template name="CardHolderFlag">
           <xsl:call-template name="checkbox1">
      	<xsl:with-param name="name">ckCard_holder</xsl:with-param>
      	<xsl:with-param name="checkbox_val">true</xsl:with-param>
           </xsl:call-template>
  </xsl:template>

   <!-- Card Holder Changes:End-->


	 <xsl:template name="Signature">
		<xsl:call-template name="hyperlink">
		<xsl:with-param name="res_name">Signature</xsl:with-param>
		<xsl:with-param name="fncname">showSVS('Edit');</xsl:with-param>
		</xsl:call-template>
	  </xsl:template>

	 <xsl:template name="CRV">
		 <xsl:call-template name="hyperlink">
		<xsl:with-param name="res_name">ALLACCI</xsl:with-param>
		 <xsl:with-param name="fncname">showCRV('Edit');</xsl:with-param>
		 </xsl:call-template>
	  </xsl:template>
	 <xsl:template name="HCCFM">
		<xsl:call-template name="hyperlink">
		<xsl:with-param name="res_name">HCCFM</xsl:with-param>
		<xsl:with-param name="fncname">showHCCFM('Edit');</xsl:with-param>
		</xsl:call-template>
	  </xsl:template>
<!-- Memo padding begin -->
	 <xsl:template name="MEMOPAD">
		<xsl:call-template name="hyperlink">
		<xsl:with-param name="res_name">MEMO PAD</xsl:with-param>
		<xsl:with-param name="fncname">showMemo('Edit');</xsl:with-param>
		</xsl:call-template>
	  </xsl:template>
<!-- Memo padding end -->
    <xsl:template name="Document_Received">
        <xsl:call-template name="checkbox1">
            <xsl:with-param name="name">ckDocument_Received</xsl:with-param>
            <xsl:with-param name="checkbox_val">true</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
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

<!-- Changes for KYC Enhancement Start-->

<xsl:template name="AccountBO.riskRating">
	     <xsl:call-template name="mdrpdown">
		     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.riskRating']"/>
		     <xsl:with-param name="selectDesc">riskRating</xsl:with-param>
		     <xsl:with-param name="selectdisp">AccountBO.riskRating</xsl:with-param>
		     <xsl:with-param name="selectname">AccountBO.riskRating</xsl:with-param>
		     <xsl:with-param name="search_type">value</xsl:with-param>
		     <xsl:with-param name="presdata" select="$PresData"/>
		     <xsl:with-param name="choice_name">AccountBO.riskRating</xsl:with-param>
		     <xsl:with-param name="onchangefn">EnableSubmitKYC()</xsl:with-param>
	    </xsl:call-template>
</xsl:template>

   <xsl:template name="AccountBO.KYC_ReviewDate">
	       	                     <xsl:call-template name="label">
	       	                     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.KYC_ReviewDate']"/>
	       	                     <xsl:with-param name="ele_name">AccountBO.KYC_ReviewDate</xsl:with-param>
	       	                     <xsl:with-param name="ele_val">AccountBO.KYC_ReviewDate</xsl:with-param>
	       	                     <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.KYC_ReviewDate");</xsl:with-param>
	       	                     </xsl:call-template>
	                             </xsl:template>
	               
	               <xsl:template name="AccountBO.KYC_Date">
	       		       <xsl:call-template name="label">
	       		           <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.KYC_Date']"/>
	       		           <xsl:with-param name="ele_name">AccountBO.KYC_Date</xsl:with-param>
	       		           <xsl:with-param name="ele_val">AccountBO.KYC_Date</xsl:with-param>
	       		           <xsl:with-param name="fn_onBlur">isGregDate("3_AccountBO.KYC_Date");</xsl:with-param>
	       		        </xsl:call-template>
	                </xsl:template>
	                           
             <xsl:template name="AccountBO.submitForKYC">
	     <xsl:call-template name="mdrpdown">
		     <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.submitForKYC']"/>
		     <xsl:with-param name="selectDesc">submitForKYC</xsl:with-param>
		     <xsl:with-param name="selectdisp">AccountBO.submitForKYC</xsl:with-param>
		     <xsl:with-param name="selectname">AccountBO.submitForKYC</xsl:with-param>
		     <xsl:with-param name="search_type">value</xsl:with-param>
		     <xsl:with-param name="presdata" select="$PresData"/>
		     <xsl:with-param name="defaultValue">N</xsl:with-param>
		     <xsl:with-param name="choice_name">AccountBO.submitForKYC</xsl:with-param>
		  
	    </xsl:call-template>
</xsl:template> 


<!-- Changes for KYC Enhancement end-->



<!--TrackerID:131246 sonali-->
      <xsl:template name="AccountBO.GCIFID">
    	    <xsl:call-template name="lookup">
    	                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.GCIFID']"/>
    	                <xsl:with-param name="elename">AccountBO.GcifId</xsl:with-param>
    	          <!-- Fix for disabling GCIF ID lookup -->
    	                <xsl:with-param name="disable_val">true</xsl:with-param>
    	                <xsl:with-param name="eleval">AccountBO.GCIFID</xsl:with-param>
    	                <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
    	                <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
    	                <xsl:with-param name="buttonone_fnc">accountLookupGcif()</xsl:with-param>
    	                <xsl:with-param name="buttontwo_fnc">clearLookup("AccountBO_GcifId")</xsl:with-param>
		 	<xsl:with-param name="checkASCII">false</xsl:with-param>
    	     </xsl:call-template>
      </xsl:template>


<xsl:template name="AccountBO.Physical_State">
                 <xsl:call-template name="mdrpdown">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Physical_State']"/>
                        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Physical_State</xsl:with-param>
                        <xsl:with-param name="selectdisp">AccountBO.Physical_State</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.Physical_State</xsl:with-param>
			
                </xsl:call-template>
        </xsl:template>

<!-- KeyGeneration start -->
      <xsl:template name="AccountBO.AccountKey">
	<xsl:choose>
	<!-- Changes for ticket id :365470 starts here  -->
	    <xsl:when test= "normalize-space($keyGeneration)='Reserved' or normalize-space($keyGeneration)='Both' and (normalize-space($accountURL)='' or normalize-space($entityCreflg) = 'N' or normalize-space($isCopy) = 'Y')">
	<!-- Changes for ticket id :365470 ends here  -->
		<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.AccountKey']"/>
			<xsl:with-param name="elename">AccountBO.AccountKey</xsl:with-param>
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.AccountKey</xsl:with-param>
			<xsl:with-param name="buttonone_fnc">openReservation('AccountBO.AccountKey','Retail')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearReservation('AccountBO.AccountKey')</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="fn_onKeyPress">checkKeys()</xsl:with-param>
			<xsl:with-param name="toUpperCase">false</xsl:with-param>
			<!--tracker id 113227 defect fix start here-->
			<!--<xsl:with-param name="fn_onBlur">checkStatus('AccountBO.AccountKey',keyGeneration);</xsl:with-param>-->
			 <!-- Changes done by sonali for 286045 Begin -->
			<xsl:with-param name="fn_onBlur">setvalue();checkStatus('AccountBO.AccountKey',keyGeneration);txtLimit_CIF(this,"AccountBO.AccountKey","CIF ID");</xsl:with-param>
		 	 <!-- Changes done by sonali for 286045 End -->
		 	<!--tracker id 113227 defect fix ends here-->
		 </xsl:call-template>
	    </xsl:when>
	    <xsl:when test= "normalize-space($keyGeneration)='Manual' and (normalize-space($accountURL)='' or normalize-space($entityCreflg) = 'N')">
	        <xsl:call-template name="label">
		       <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.AccountKey']"/>
		       <xsl:with-param name="selectname">AccountBO.ACCOUNTKEY</xsl:with-param>
		       <xsl:with-param name="selectdisp">AccountBO.AccountKey</xsl:with-param>
		       <xsl:with-param name="ele_name">AccountBO.AccountKey</xsl:with-param>
		       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.AccountKey</xsl:with-param>
		       <xsl:with-param name="starshow">true</xsl:with-param>
		       <xsl:with-param name="fn_onKeyPress">checkKeys()</xsl:with-param>
		       <!--tracker id 113227 defect fix start here-->
		       <!--<xsl:with-param name="fn_onBlur">checkStatus('AccountBO.AccountKey',keyGeneration);</xsl:with-param>-->
		       <!--<xsl:with-param name="fn_onBlur">setvalue();checkStatus('AccountBO.AccountKey',keyGeneration);</xsl:with-param>-->
		       <!--Added by sonali as a part of fix for 286045-->
		       <xsl:with-param name="fn_onBlur">setvalue();checkStatus('AccountBO.AccountKey',keyGeneration);txtLimit_CIF(this,"AccountBO.AccountKey","CIF ID");</xsl:with-param>
		        <!-- Changes done by sonali for 286045 End -->
		       <!--tracker id 113227 defect fix ends here-->
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
		    <!--tracker id 113227 defect fix start here-->
		    <!--<xsl:with-param name="fn_onBlur">checkStatus('AccountBO.AccountKey',keyGeneration);</xsl:with-param>-->
		    <!-- Changes done by sonali for 286045 Begin -->
		    <xsl:with-param name="fn_onBlur">setvalue();checkStatus('AccountBO.AccountKey',keyGeneration);txtLimit_CIF(this,"AccountBO.AccountKey","CIF ID");</xsl:with-param>
		    <!-- Changes done by sonali for 286045 End -->
		    <!--tracker id 113227 defect fix ends here-->
		</xsl:call-template>
	    </xsl:otherwise>
	 </xsl:choose>
      </xsl:template>
<!-- KeyGeneration end -->
<!-- Tracker ID 228683 changes for Basel -->
<xsl:template name="BaselProfiling">
           <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels[@name='BaselProfiling']"/>
                <xsl:with-param name="selectname">BaselProfiling</xsl:with-param>
                <xsl:with-param name="selectdisp">BaselProfiling</xsl:with-param>
                <xsl:with-param name="presdata" select="$PresData"/>
                <xsl:with-param name="choice_name">BaselProfiling</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>                               
                <xsl:with-param name="defValByUrl">true</xsl:with-param>
                <xsl:with-param name="onchangefn">loadBasel()</xsl:with-param>
             </xsl:call-template>
</xsl:template>
<!--Start of changes: Minor -->
	<xsl:template name="RelationshipBO.Bank_Entity_Name">
    		<xsl:call-template name="lookup">
         		<xsl:with-param name="res_name" select="$configLabelsMinor[@name='URL']"/>


         		<xsl:with-param name="elename">RelationshipBO.Bank_Entity_Name</xsl:with-param>
         		<xsl:with-param name="eleval">RelationshipBO.Bank_Entity_Name</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
                        <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
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
	    			<!-- ticket id: 330818 changes begin -->
                    <!-- ticket id: 335752 changes begin -->
					<xsl:with-param name="onchangefn">clearLookUpMinor()</xsl:with-param>
                     <!-- ticket id: 335752 changes End -->
	    			 <!-- ticket id: 330818 changes End -->
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

	<!-- <xsl:template name="RelationshipBO.Relationship">
  	    		<xsl:call-template name="mdrpdown">
  	    			<xsl:with-param name="res_name" select="$configLabelsMinor[@name='RelationshipBO.Relationship']"/>
  	    			<xsl:with-param name="selectname">RelationshipBO.Relationship</xsl:with-param>
  	    			<xsl:with-param name="selectdisp">RelationshipBO.Relationship</xsl:with-param>
  	    			<xsl:with-param name="onchangefn">EnableMinorGuardCode()</xsl:with-param>
  	    			<xsl:with-param name="search_type">value</xsl:with-param>
  	    			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>

  	    		</xsl:call-template>
      	</xsl:template>  -->


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
		<xsl:template name="AccountBO.GroupHouseHold.GROUP_ID">
	<xsl:call-template name="lookup">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">CifGroupLookup()</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearLookUpMinor()</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel" />
		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="elename">AccountBO.GroupHouseHold.GROUP_ID</xsl:with-param>
		<xsl:with-param name="eleval">AccountBO.GroupHouseHold.GROUP_ID</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.GroupHouseHold.GROUP_ID']" />
		
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
	<xsl:template name="ContactBO.firstName">
			<xsl:call-template name="label">
		              <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.firstName']"/>
		               <xsl:with-param name="selectname">ContactBO.firstName</xsl:with-param>
		               <xsl:with-param name="selectdisp">ContactBO.firstName</xsl:with-param>
		               <xsl:with-param name="ele_name">ContactBO.firstName</xsl:with-param>
		               <!-- Tracker No: 100752 Begin of changes-->
			         <xsl:with-param name="checkASCII">false</xsl:with-param>
	                	<!-- Tracker No:100752 End of changes-->
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
	 <!-- ticket id: 330818 changes begin -->
	 <xsl:template name="ContactBO.lastName">
	           <xsl:call-template name="lookup">
	              <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.lastName']"/>

	           <xsl:with-param name="elename">ContactBO.lastName</xsl:with-param>
			<xsl:with-param name="eleval">ContactBO.lastName</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		                           <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		                           <!-- changes for ticket 373655 starts -->
					<!-- Recon for Ticket id 384668 start -->
					<xsl:with-param name="buttonone_fnc">fnBlurFunctionmin('Minor')</xsl:with-param>
					<!--<xsl:with-param name="buttonone_fnc">fnTabOutMinor(),accountLookup()</xsl:with-param>-->
					<!-- Recon for Ticket id 384668 end -->
		            		<!-- changes for ticket 373655 ends -->
		            		<xsl:with-param name="buttontwo_fnc">clearLookUpMinor()</xsl:with-param>
		            		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       <xsl:with-param name="checkASCII">false</xsl:with-param>
    			<xsl:with-param name="starshow">true</xsl:with-param>
	          <!-- ticket id: 330818 changes End -->
	               <!-- Tracker No:100752 End of changes-->

<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
				<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
	            </xsl:call-template>
	 </xsl:template>

<!--TrackerID: 113227 start of changes-->
	<xsl:template name="ContactBO.lastName_alt1">
		            <xsl:call-template name="label_alternate">
		              <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.lastName']"/>
		               <xsl:with-param name="ele_name">ContactBO.lastName_alt1</xsl:with-param>
				<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
		            </xsl:call-template>
	 </xsl:template>

	 <xsl:template name="ContactBO.middleName_alt1">
		            <xsl:call-template name="label_alternate">
		              <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.middleName']"/>
		               <xsl:with-param name="ele_name">ContactBO.middleName_alt1</xsl:with-param>
				<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>

		            </xsl:call-template>
	 </xsl:template>

	  <xsl:template name="ContactBO.firstName_alt1">
		            <xsl:call-template name="label_alternate">
		              <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.firstName']"/>
		               <xsl:with-param name="ele_name">ContactBO.firstName_alt1</xsl:with-param>
					<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
		            </xsl:call-template>
	 </xsl:template>

<!--TrackerID: 113227 end of changes-->

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
	<!--Begin of changes by Bharath for hidden field for currency default population -->
	<xsl:template name="AccountBO.StrUserField10">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField10']"/>
		<xsl:with-param name="selectname">AccountBO.StrUserField10</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.StrUserField10</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="choice_name">AccountBO.StrUserField10</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


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

	<xsl:template name="AccountBO.StrUserField12">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField12']"/>
		<xsl:with-param name="selectname">AccountBO.StrUserField12</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.StrUserField12</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<!--Changes done by sundar for HighRisk category check and mandatory kyc fields start-->
		<xsl:with-param name="onchangefn">Makekycfieldmand();</xsl:with-param>
		<!--Changes done by sundar for HighRisk category check and mandatory kyc fields END-->
		<xsl:with-param name="choice_name">AccountBO.StrUserField12</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Customer social status Recon start-->
	<xsl:template name="AccountBO.StrUserField30">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField30']"/>
		<xsl:with-param name="selectDesc">StrUserField30</xsl:with-param>
		<xsl:with-param name="selectname">AccountBO.StrUserField30</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.StrUserField30</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<!--<xsl:with-param name="defaultValue">N</xsl:with-param>-->
		<xsl:with-param name="onchangefn">customersocialstatus();</xsl:with-param>
		<xsl:with-param name="choice_name">AccountBO.StrUserField30</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
<!-- Customer social status recon end-->

	
	<xsl:template name="AccountBO.StrUserField28">
			<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField28']"/>
			<xsl:with-param name="selectname">AccountBO.StrUserField28</xsl:with-param>
			<xsl:with-param name="selectdisp">AccountBO.StrUserField28</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="choice_name">AccountBO.StrUserField28</xsl:with-param>
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

	<!--End of changes by Bharath for hidden field for currency default population -->	     

	    <xsl:template name="ContactBO.contactsKey">
			 <xsl:choose>
			   <xsl:when test= "normalize-space($isAutoGenKey)='true'">
			   <xsl:call-template name="label">
			       <xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.contactsKey']"/>
			       <xsl:with-param name="selectname">ContactBO.CONTACTSKEY</xsl:with-param>
			       <xsl:with-param name="selectdisp">ContactBO.contactsKey</xsl:with-param>
			       <xsl:with-param name="ele_name">ContactBO.contactsKey</xsl:with-param>
			       <xsl:with-param name="starshow">true</xsl:with-param>
			       <xsl:with-param name="read_val">true</xsl:with-param>
			       <xsl:with-param name="IsMandatory" select="No"/>
			       </xsl:call-template>
			    </xsl:when>
			     <xsl:otherwise>
			       <xsl:call-template name="label">
				<xsl:with-param name="res_name" select="$configLabelsMinor[@name='ContactBO.contactsKey']"/>
				<xsl:with-param name="selectname">ContactBO.CONTACTSKEY</xsl:with-param>
				<xsl:with-param name="selectdisp">ContactBO.contactsKey</xsl:with-param>
				<xsl:with-param name="ele_name">ContactBO.contactsKey</xsl:with-param>
				<xsl:with-param name="starshow">true</xsl:with-param>
				</xsl:call-template>
			    </xsl:otherwise>
	  	</xsl:choose>
	     </xsl:template>
<!-- End of Minor changes -->
<!--Native Language Changes:start-->
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

<!--Native Language Changes:end-->


<!-- CoreInterface Details:start-->
         <!-- Changes for ticket 330755 starts-->
	 <!-- boNameCI is fetched from CoreInterfaceModBO which is used in this template -->

	  <xsl:template name="CoreInterfaceBO.OfflineCumDebitLimit">
	 	 		<xsl:call-template name="amountlabel">
	 	 			  <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.OFFLINECUMDEBITLIMIT']"/>
	 	 			  <xsl:with-param name="ele_name">CoreInterfaceBO.OfflineCumDebitLimit</xsl:with-param>
	 	 			  <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.OFFLINECUMDEBITLIMIT</xsl:with-param>
	 	 			  <xsl:with-param name="fncname">rate('3_CoreInterfaceBO.OfflineCumDebitLimit','<xsl:value-of select="$boNameCI"/>.CU_OFFLINECUMDEBITLIMIT','<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
	 	 			  <xsl:with-param name="fn_onBlur">formatAmount("3_CoreInterfaceBO.OfflineCumDebitLimit",boNameCI+".CU_OFFLINECUMDEBITLIMIT","N");</xsl:with-param>
	 	 			  <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.CU_OFFLINECUMDEBITLIMIT</xsl:with-param>
	 	 			  <xsl:with-param name="amountselectname"><xsl:value-of select="$boNameCI"/>.CU_OFFLINECUMDEBITLIMIT</xsl:with-param>
	 		  <xsl:with-param name="onchangefn">checkDropValue('3_CoreInterfaceBO.OfflineCumDebitLimit','<xsl:value-of select="$boNameCI"/>.CU_OFFLINECUMDEBITLIMIT');</xsl:with-param>

	 	 			  <xsl:with-param name="choicename">CoreInterfaceBO.CU_OFFLINECUMDEBITLIMIT</xsl:with-param>
	 	 		</xsl:call-template>
	 	</xsl:template>
	 	<!-- Changes for ticket 330755 ends-->


 <xsl:template name="CoreInterfaceBO.CustLevelChargesAcct">
      <xsl:call-template name="label">
       <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.CUSTLEVELCHARGESACCT']"/>
       <xsl:with-param name="ele_name">CoreInterfaceBO.CustLevelChargesAcct</xsl:with-param>
       <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.CUSTLEVELCHARGESACCT</xsl:with-param>
      </xsl:call-template>
 </xsl:template>

 <xsl:template name="CoreInterfaceBO.SourceOfIncome">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.SOURCEOFINCOME']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.SourceOfIncome</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.SOURCEOFINCOME</xsl:with-param>
       </xsl:call-template>
 </xsl:template>


<!--  RefCode Changes	-->
 <xsl:template name="CoreInterfaceBO.FreeCode1Desc">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE1']"/>
        <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boNameCI"/>.FreeCode1Desc</xsl:with-param>-->
        <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.FreeCode1Desc</xsl:with-param>
        <xsl:with-param name="selectdisp">CoreInterfaceBO.FREECODE1</xsl:with-param>
        <xsl:with-param name="choice_name">CoreInterfaceBO.FREECODE1</xsl:with-param>
        <xsl:with-param name="search_type">url</xsl:with-param>
        </xsl:call-template>
</xsl:template>
 <xsl:template name="CoreInterfaceBO.FreeCode2Desc">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE2']"/>
        <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boNameCI"/>.FreeCode2Desc</xsl:with-param>-->
        <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.FreeCode2Desc</xsl:with-param>
        <xsl:with-param name="selectdisp">CoreInterfaceBO.FREECODE2</xsl:with-param>
        <xsl:with-param name="choice_name">CoreInterfaceBO.FREECODE2</xsl:with-param>

        <xsl:with-param name="search_type">url</xsl:with-param>
        </xsl:call-template>
</xsl:template>
<!--changes from dropdown to lookup ends-->
<!-- TRACKER:371155:BEGINOFCHANGES -->
 <xsl:template name="CoreInterfaceBO.FreeCode3Desc">
<xsl:call-template name="lookup">
<xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE3']"/>
<xsl:with-param name="elename">CoreInterfaceBO.FreeCode3Desc</xsl:with-param>
<xsl:with-param name="eleval">CoreInterfaceBO.FreeCode3Desc</xsl:with-param>
<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
<xsl:with-param name="buttonone_fnc">categoryLookup('FREE_CODE3', 'CoreInterfaceBO.FreeCode3Desc')</xsl:with-param>
<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CoreInterfaceBO.FreeCode3Desc')</xsl:with-param>
<xsl:with-param name="checkASCII">false</xsl:with-param>
</xsl:call-template>
</xsl:template>
 <xsl:template name="CoreInterfaceBO.FreeCode4Desc">
<xsl:call-template name="lookup">
<xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE4']"/>
<xsl:with-param name="elename">CoreInterfaceBO.FreeCode4Desc</xsl:with-param>
<xsl:with-param name="eleval">CoreInterfaceBO.FreeCode4Desc</xsl:with-param>
<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
<xsl:with-param name="buttonone_fnc">categoryLookup('FREE_CODE4', 'CoreInterfaceBO.FreeCode4Desc')</xsl:with-param>
<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CoreInterfaceBO.FreeCode4Desc')</xsl:with-param>
<xsl:with-param name="checkASCII">false</xsl:with-param>
</xsl:call-template>
</xsl:template>
<!-- TRACKER:371155:ENDOFCHANGES -->
<!--changes from dropdown to lookup ends-->

			<!--changes for tracker id 349409 BEGIN-->
 <xsl:template name="CoreInterfaceBO.FreeCode5Desc">
        <xsl:call-template name="lookup">
					<xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE5']"/>
					<xsl:with-param name="elename">CoreInterfaceBO.FreeCode5Desc</xsl:with-param>
					<xsl:with-param name="eleval">CoreInterfaceBO.FreeCode5Desc</xsl:with-param>
					<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
					<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
					<xsl:with-param name="buttonone_fnc">categoryLookup('FREE_CODE5', 'CoreInterfaceBO.FreeCode5Desc')</xsl:with-param>
					<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CoreInterfaceBO.FreeCode5Desc')</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
 <xsl:template name="CoreInterfaceBO.FreeCode6Desc">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE6']"/>
        <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boNameCI"/>.FreeCode6Desc</xsl:with-param>-->
        <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.FreeCode6Desc</xsl:with-param>
        <xsl:with-param name="selectdisp">CoreInterfaceBO.FREECODE6</xsl:with-param>
        <xsl:with-param name="choice_name">CoreInterfaceBO.FREECODE6</xsl:with-param>
        <xsl:with-param name="search_type">url</xsl:with-param>
        </xsl:call-template>
</xsl:template>
 <xsl:template name="CoreInterfaceBO.FreeCode7Desc">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE7']"/>
        <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boNameCI"/>.FreeCode7Desc</xsl:with-param>-->
        <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.FreeCode7Desc</xsl:with-param>
        <xsl:with-param name="selectdisp">CoreInterfaceBO.FREECODE7</xsl:with-param>
        <xsl:with-param name="choice_name">CoreInterfaceBO.FREECODE7</xsl:with-param>
        <xsl:with-param name="search_type">url</xsl:with-param>
        </xsl:call-template>
</xsl:template>
 <xsl:template name="CoreInterfaceBO.FreeCode8Desc">
        <xsl:call-template name="lookup">
		<xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE8']"/>
		<xsl:with-param name="elename">CoreInterfaceBO.FreeCode8Desc</xsl:with-param>
		<xsl:with-param name="eleval">CoreInterfaceBO.FreeCode8Desc</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		<xsl:with-param name="buttonone_fnc">categoryLookup('FREE_CODE8', 'CoreInterfaceBO.FreeCode8Desc')</xsl:with-param>
		<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CoreInterfaceBO.FreeCode8Desc')</xsl:with-param>
		<xsl:with-param name="checkASCII">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
 <xsl:template name="CoreInterfaceBO.FreeCode9Desc">
        <xsl:call-template name="lookup">
					<xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE9']"/>
					<xsl:with-param name="elename">CoreInterfaceBO.FreeCode9Desc</xsl:with-param>
					<xsl:with-param name="eleval">CoreInterfaceBO.FreeCode9Desc</xsl:with-param>
					<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
					<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
					<xsl:with-param name="buttonone_fnc">categoryLookup('FREE_CODE9', 'CoreInterfaceBO.FreeCode9Desc')</xsl:with-param>
					<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CoreInterfaceBO.FreeCode9Desc')</xsl:with-param>
					<xsl:with-param name="checkASCII">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
 <xsl:template name="CoreInterfaceBO.FreeCode10Desc">
        <xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE10']"/>
			<xsl:with-param name="elename">CoreInterfaceBO.FreeCode10Desc</xsl:with-param>
			<xsl:with-param name="eleval">CoreInterfaceBO.FreeCode10Desc</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			<xsl:with-param name="buttonone_fnc">categoryLookup('FREE_CODE10', 'CoreInterfaceBO.FreeCode10Desc')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CoreInterfaceBO.FreeCode10Desc')</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
			<!--changes for tracker id 349409 END-->
<!--  RefCode Changes	-->
<xsl:template name="CoreInterfaceBO.Cust_free_text">
      <xsl:call-template name="label">
       <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Cust_free_text']"/>
       <xsl:with-param name="ele_name">CoreInterfaceBO.Cust_free_text</xsl:with-param>
       <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Cust_free_text</xsl:with-param>
      </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_1">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_1']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_1</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_1</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_2">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_2']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_2</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_2</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_3">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_3']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_3</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_3</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_4">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_4']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_4</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_4</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_5">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_5']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_5</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_5</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_6">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_6']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_6</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_6</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_7">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_7']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_7</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_7</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_8">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_8']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_8</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_8</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_9">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_9']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_9</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_9</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_10">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_10']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_10</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_10</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_11">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_11']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_11</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_11</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_12">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_12']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_12</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_12</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_13">
       <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_13']"/>
        <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_13</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_13</xsl:with-param>
       </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_14">
        <xsl:call-template name="label">
         <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_14']"/>
         <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_14</xsl:with-param>
         <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_14</xsl:with-param>
        </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.Free_text_15">
        <xsl:call-template name="label">
         <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.Free_text_15']"/>
         <xsl:with-param name="ele_name">CoreInterfaceBO.Free_text_15</xsl:with-param>
         <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.Free_text_15</xsl:with-param>
        </xsl:call-template>
 </xsl:template>
 <xsl:template name="CoreInterfaceBO.PrimarySolID">
         <xsl:call-template name="label">
          <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.PrimarySolID']"/>
          <xsl:with-param name="ele_name">CoreInterfaceBO.PrimarySolID</xsl:with-param>
          <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.PrimarySolID</xsl:with-param>
         </xsl:call-template>
 </xsl:template>
 <!-- <xsl:template name="CoreInterfaceBO.PrefCode">
         <xsl:call-template name="label">
          <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.PrefCode']"/>
          <xsl:with-param name="ele_name">CoreInterfaceBO.PrefCode</xsl:with-param>
          <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.PrefCode</xsl:with-param>
         </xsl:call-template>
 </xsl:template> -->

<xsl:template name="CoreInterfaceBO.PrefCode">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.PrefCode_code']"/>
		<!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boNameCI"/>.PrefCode</xsl:with-param>-->
        <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.PrefCode</xsl:with-param>
		<!-- CIF Changes for Caching Views : Start -->
			<!-- <xsl:with-param name="presdata" select="$PresData"/>    -->
		<!-- CIF Changes for Caching Views : End -->
        <xsl:with-param name="selectdisp">CoreInterfaceBO.PrefCode_code</xsl:with-param>
        <xsl:with-param name="choice_name">CoreInterfaceBO.PrefCode_code</xsl:with-param>
        <xsl:with-param name="search_type">url</xsl:with-param>
        </xsl:call-template>
 </xsl:template>
 <!-- Change for 374326 and 374328 start -->
    <xsl:template name="PsychographicBO.Preferred_Locale">
 		<xsl:call-template name="lookup">
 			<xsl:with-param name="res_name" select="$configLabels[@name='PsychographicBO.Preferred_Locale']"/>
 			<xsl:with-param name="elename">PsychographicBO.Preferred_Locale</xsl:with-param>
 			<xsl:with-param name="eleval">PsychographicBO.Preferred_Locale</xsl:with-param>
 			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
 			<xsl:with-param name="buttonone_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
 			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
 			<xsl:with-param name="buttonone_fnc">categoryLookup('LOCALE', 'PsychographicBO.Preferred_Locale')</xsl:with-param>
 			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('PsychographicBO.Preferred_Locale')</xsl:with-param>
 			<!-- Fix for CallId 338339 : begin -->
			 <xsl:with-param name="fn_onBlur">false</xsl:with-param>
 			<!-- Fix for CallId 338339 : end -->
 		</xsl:call-template>
 		
 	
         </xsl:template>
         <!-- change for 374326 and 374328 end -->
<!--  <xsl:template name="CoreInterfaceBO.TreasuryCounterParty">
         <xsl:call-template name="label">
          <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.TreasuryCounterParty']"/>
          <xsl:with-param name="ele_name">CoreInterfaceBO.TreasuryCounterParty</xsl:with-param>
          <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.TreasuryCounterParty</xsl:with-param>
         </xsl:call-template>
 </xsl:template> -->
 <xsl:template name="CoreInterfaceBO.TreasuryCounterParty">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.TreasuryCounterParty']"/>
        <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.TreasuryCounterParty</xsl:with-param>
        <xsl:with-param name="selectdisp">CoreInterfaceBO.TreasuryCounterParty</xsl:with-param>
        <xsl:with-param name="choice_name">CoreInterfaceBO.TreasuryCounterParty</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        </xsl:call-template>
</xsl:template>
 <xsl:template name="CoreInterfaceBO.TreasuryCounterPartyMne">
          <xsl:call-template name="label">
           <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.TreasuryCounterPartyMne']"/>
           <xsl:with-param name="ele_name">CoreInterfaceBO.TreasuryCounterPartyMne</xsl:with-param>
           <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.TreasuryCounterPartyMne</xsl:with-param>
          </xsl:call-template>
 </xsl:template>
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
 <!--CoreInterface Details:end -->


<!-- CIF PhoneEmail Changes : Start -->
<xsl:template name="AccountBO.Address.preferredAddress">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Address.preferredAddress']"/>
        <xsl:with-param name="selectname">AccountBO.Address.preferredAddress</xsl:with-param>
        <xsl:with-param name="selectdisp">AccountBO.Address.preferredAddress</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <!-- Changes for tracker id: 292525 starts -->
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
        <xsl:with-param name="starshow">true</xsl:with-param>
        </xsl:call-template>
</xsl:template>
<!--Changes for Alert server recon in 10.2.14 starts-->
<xsl:template name="AccountBO.Preferred_Mobile_Alert_Type">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="choice_name">AccountBO.Preferred_Mobile_Alert_Type</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData" />
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Preferred_Mobile_Alert_Type']" />
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">AccountBO.Preferred_Mobile_Alert_Type</xsl:with-param>
		<xsl:with-param name="selectname">AccountBO.Preferred_Mobile_Alert_Type</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template> 
<!--Changes for Alert server recon in 10.2.14 ends-->
<!-- CIF PhoneEmail Changes : End --> <!-- Tracker# 97236 CIF- EBanking changes : Start -->
  <xsl:template name="AccountBO.IsEbankingEnabled">
         <xsl:call-template name="mdrpdown">
         <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.IsEbankingEnabled']"/>
         <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.IsEbankingEnabled</xsl:with-param>
          <xsl:with-param name="selectdisp">AccountBO.IsEbankingEnabled</xsl:with-param>
          <xsl:with-param name="choice_name">AccountBO.IsEbankingEnabled</xsl:with-param>
         <xsl:with-param name="defaultValue">N</xsl:with-param>
         <!-- changes for tracker id : 254121  / ticket id : 418189 start -->
       	 <!-- <xsl:with-param name="onchangefn">checkEbankFields();</xsl:with-param>-->
         <xsl:with-param name="onchangefn">checkEbankFields();changeSMSBanking();</xsl:with-param>
          <!-- changes for tracker id : 254121  / ticket id : 418189 end -->
         <xsl:with-param name="presdata" select="$PresData"/>
         </xsl:call-template>
 </xsl:template>
 <xsl:template name="AccountBO.IsSMSBankingEnabled">
         <xsl:call-template name="checkbox1">
         	<!-- Changes for the Tracker id: 361934 START -->
             <xsl:with-param name="name"><xsl:value-of select="$boName"/>.IsSMSBankingEnabled</xsl:with-param>
             	<!-- Changes for the Tracker id: 361934 END -->
             <xsl:with-param name="checkbox_val">false</xsl:with-param>
             <xsl:with-param name="fncname">changeSMSBanking();</xsl:with-param>
          </xsl:call-template>
 </xsl:template>
 <xsl:template name="AccountBO.IsWAPBankingEnabled">
         <xsl:call-template name="checkbox1">
         	<!-- Changes for the Tracker id: 361934 START -->         
             <xsl:with-param name="name"><xsl:value-of select="$boName"/>.IsWAPBankingEnabled</xsl:with-param>
             	<!-- Changes for the Tracker id: 361934 END -->
             <xsl:with-param name="checkbox_val">false</xsl:with-param>
             <!-- Changes for Track ID 260026 Begin-->
             <xsl:with-param name="fncname">changeWAPBanking();</xsl:with-param>
             <!-- Changes for Track ID 260026 End-->
          </xsl:call-template>
 </xsl:template>
 <xsl:template name="AccountBO.SMSBankingMobileNumber">
       	<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.SMSBankingMobileNumber']"/>
       		<xsl:with-param name="ele_name">AccountBO.SMSBankingMobileNumber</xsl:with-param>
       		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.SMSBankingMobileNumber</xsl:with-param>
       		<xsl:with-param name="max_length">15</xsl:with-param>
       		<xsl:with-param name="starshow">true</xsl:with-param>
  		<!-- Changes Begin for Tracker 126433 Begin -->
		<xsl:with-param name="fn_onBlur">formatMobile();</xsl:with-param>
       		<!-- Changes End for Tracker 126433 End -->

       	</xsl:call-template>
 </xsl:template>
<!-- Tracker# 97236 CIF - EBanking Changes : End -->


	<!--TrackerID: 113227 start of changes-->
     <xsl:template name="AccountBO.Cust_Last_Name_alt1">
                 <xsl:call-template name="label_alternate">
                   <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Last_Name']"/>
                    <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_alt1</xsl:with-param>
                    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name_alt1</xsl:with-param>
     			   <xsl:with-param name="checkASCII">false</xsl:with-param>
     			   <xsl:with-param name="starshow">false</xsl:with-param>
<!-- Fix for call id: 428627 Starts -->
     			   <xsl:with-param name="max_length">80</xsl:with-param>
<!-- Fix for call id: 428627 Ends -->
    	            <xsl:with-param name="fn_onBlur">concatName_alt();;set_isName(this,true);</xsl:with-param>
                 </xsl:call-template>
     </xsl:template>

          <xsl:template name="AccountBO.Cust_First_Name_alt1">
                      <xsl:call-template name="label_alternate">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_First_Name']"/>
                         <xsl:with-param name="ele_name">AccountBO.Cust_First_Name_alt1</xsl:with-param>
                         <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name_alt1</xsl:with-param>
          			   <xsl:with-param name="checkASCII">false</xsl:with-param>
          			   <xsl:with-param name="starshow">false</xsl:with-param>
          		 <xsl:with-param name="fn_onBlur">concatName_alt();;set_isName(this,true);</xsl:with-param>
                      </xsl:call-template>
          </xsl:template>

          <xsl:template name="AccountBO.Cust_Middle_Name_alt1">
                      <xsl:call-template name="label_alternate">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Cust_Middle_Name']"/>
                         <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_alt1</xsl:with-param>
                         <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name_alt1</xsl:with-param>
          			   <xsl:with-param name="checkASCII">false</xsl:with-param>
          			   <xsl:with-param name="starshow">false</xsl:with-param>
          		 <xsl:with-param name="fn_onBlur">concatName_alt();;set_isName(this,true);</xsl:with-param>

                      </xsl:call-template>
          </xsl:template>

          <xsl:template name="AccountBO.short_name_alt1">
                      <xsl:call-template name="label_alternate">
                        <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.short_name']"/>
                         <xsl:with-param name="ele_name">AccountBO.short_name_alt1</xsl:with-param>
                         <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_name_alt1</xsl:with-param>
          			   <xsl:with-param name="checkASCII">false</xsl:with-param>
          			   <xsl:with-param name="starshow">false</xsl:with-param>
          			   <xsl:with-param name="max_length">10</xsl:with-param>
          		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>

                      </xsl:call-template>
          </xsl:template>


          <!--TrackerID: 113227 end of changes-->


        <xsl:template match="*" mode="mode1">
        <form name="frm2"  method="post" >
        <IFRAME name="hdifrm_empform" width="0" height="0" src="../common/html/SSOblank.html"/>
	<!-- KeyGeneration start -->
	<IFRAME name="hdifrm_rescifid" width="0" height="0" src="../common/html/SSOblank.html"/>
	<!-- KeyGeneration end -->
	<!-- Changes for Tracker # 93931 Begin -->
	<!-- Changes for Tracker # 93931 End -->
		<!--Key generation changes start-->
		<!-- ERPBOCF1 - Bug fixing - Begin -->
		<!-- Tracker Id 200830 -->
		<!-- Adding the value of variable hidUniqueID -->
		<!-- It is used while checking wheather Identification details are entered while submit of customer -->
		<!-- This variable was present in demographic.xsl and has been moved to Account.xsl
		     since Identification docs were moved to General from Demographic screen -->
		<input type="hidden" name="hidUniqueID" value=""/>
		<input type="hidden" name="hidUniqueIDType" value=""/><!-- Fix for ticket 296425 -->
		<!-- ERPBOCF1 - Bug fixing - End-->
		<!--Changes for Alert Server recon in 10.2.14 starts-->
		<input name="DefaultChannel_Alert" type="hidden" value=""></input>
		<!--Changes for Alert Server recon in 10.2.14 ends-->
		<input type="hidden" name="hid_cifid" value=""/>
		<input type="hidden" name="custBankId" value="0"/>
         	<!-- Changes for the Tracker id: 361934 START -->		
		<input type="hidden" name="IsWAPBankingEnabled" value=""/>
		<input type="hidden" name="IsSMSBankingEnabled" value=""/>
         	<!-- Changes for the Tracker id: 361934 END -->		
		<input type="hidden" name="hid_reservestatus" value=""/>
		<!-- Change for 374326 and 374328 start -->
		<input type="hidden" name="hid_preflocale" value=""/>
		<!-- Change for 374326 and 374328 end -->
		<!-- Change for tracker id 337846 starts -->
		<input type="hidden" name="hid_IntroducerName" value=""/>
		<input type="hidden" name="hid_IntroducerId" value=""/>
		<!-- Change for tracker id 337846 end -->
				<!-- Change for callid 358638 starts -->
                 <input type="hidden" name="hid_Introdstatus" value=""/>
		<input type="hidden" name="hid_Introdsalutation" value=""/>
		<!-- Change for callid 358638 ends -->
		<!--Key generation changes end-->
		<input type="hidden" name="TfFlag" value=""/>
		<!--Tracker id 113227 changes start-->
		<input type="hidden" name="altLocaleActv" />
 		<!--Tracker id 113227 changes end-->
		<input type="hidden" name="hid_contactURL" value="{$contactURL}"/>
		<input type="hidden" name="sct_Available" value="Y"/>
		<input type="hidden" name="hid_accountURL" value="{$accountURL}"/>
		<!-- CoreInterface Details:start-->
		<input type="hidden" name="hid_coreURL" value="{$coreURL}"/>
		<input type="hidden" name="orgkey" value=""/>
		<input type="hidden" name="entitytype" value=""/>
		<input type="hidden" name="Core_cust_id" value=""/>
		<input type="hidden" name="TDS_CORECUSTID" value=""/>
<!-- Changes for Deceased CIF Starts-->
	<input name="hidOldCustStatus" type="hidden" value=""/>
<!-- Changes for Deceased CIF Ends-->
		<input type="hidden" name="selAvailBackendID" value=""/>
		<!-- CoreInterface Details:end-->
		<input type="hidden" name="hid_concurDetectX" value="{$concurDetectX}"/>
		<input type="hidden" name="hid_parentAccountURL" value="{$parentAccountURL}"/>
		<input type="hidden" name="hid_UserID" value=""/>
		<input type="hidden" value="{$isAutoGenKey}" name="isAutoGenKey"/>

		<input type="hidden" value="{$MINOR_YEAR}" name="MINOR_YEAR"/>
	     <!--Senior Age changes: start-->
	     <input type="hidden" value="{$SENIOR_YEAR}" name="SENIOR_YEAR"/>
         <!--Senior Age changes: end-->

		<!--ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI: MINOR TO MAJOR CONVERSION)-->
		<input type="hidden" value="{$CONV_CALENDAR_TYPE}" name="CONV_CALENDAR_TYPE"/>

		<!-- fix for ticket 202190 start -->
		<!--<input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>-->
		<!-- fix for ticket 202190 ends-->
		<input type="hidden" name="minorAttainMajorDateHij" value="DEFAULT"/>
		<!-- Senior Citizen--><input type="hidden" name="seniorAttainSeniorDateHij" value="DEFAULT"/>
		<!--ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI: MINOR TO MAJOR CONVERSION)-->

		<input type="hidden" name="minorLoaded" value=""/>
		<input type="hidden" name="attachedProducts" value=""/>
		<input type="hidden" name="Bank_Entity" value=""/>
		<input type="hidden" name="Bank_Entity1" value=""/>
		<!--Changes for call id call id 428461 and recon of call id 425465,400878 starts-->
		<input type="hidden" name="hid_introIDvalue" value="{$ChildEntityId}"/>
		<!--Changes for call id call id 428461 and recon of call id 425465,400878 ends-->
		<input type="hidden" name="Lookup_label" value=""/>
		<input type="hidden" name="hreadOnly" value="{$readMode}"/>
		<input type="hidden" name="ID" value="{$ID}"/>
		<input type="hidden" name="hid_accountIDvalue" value="{$BankEntityID}"/>
		<input type="hidden" name="flagRelType" value="{$flagRelType}"/>
		<input type="hidden" name="hTodayDate" value=""/>
		<input type="hidden" name="isTFLoaded" value="false"/>
		<input type="hidden" name="AddressFields" value=""/>
		<input type="hidden" name="OtherTFFields" value=""/>
		<input type="hidden" name="CoreCustID" value=""/>
		<input type="hidden" name="hid_bodateCreated" value=""/>
		<input type="hidden" name="noOfDaysIntro" value="{$noOfDaysIntro}"/>
		<!--Access Control Changes-->
		<input type="hidden" name="accessOwnerGroup" value=""/>
		<input type="hidden" name="accessOwnerBC" value=""/>
		<!--End of Changes-->
		<!--Changes for tkt 351073 start-->
                <input type="hidden" name="IntroducerFirstName" value=""/>
		<input type="hidden" name="Gender" value=""/>
		<!--Changes for tkt 351073 end-->

	   <!-- new added hidden : for :Copy :start -->
	         <input type="hidden" name="IsCopy" value="{$isCopy}"/>
	         <!-- Changes for tracker id 253845   Start -->
		 	<input type="hidden" name="convToCust" value="{$convToCust}"/>
		 	<input type="hidden" name="oldEntType" value="{$oldEntityType}"/>
		 	<input type="hidden" name="oldEntID" value="{$oldEntityID}"/>
			  <!-- Changes for tracker id 253845   End  -->
           <!-- new added hidden : for :Copy :end -->
           <!--hidden variable for account key:start-->
	         <input type="hidden" name="accKey" value="{$accKey}"/>
           <!--hidden variable for account key:end-->
           <!-- new added hidden : for :relation Lookup :start -->
                        <input type="hidden" name="InputTypeFromLookup" value=""/>
                        <input type="hidden" name="attachedConts" value=""/>
                        <input type="hidden" name="detachedConts" value=""/>
			<input type="hidden" name="accID" value=""/>
           <!-- new added hidden : for :relation Lookup :end -->
           <!-- new added hidden : for :CORE CIF Approval :start -->
			<input type="hidden" name="ModAccID" value=""/>
			<input type="hidden" name="mainAccId" value="{$mainAccId}"/>
           <!-- new added hidden : for :CORE CIF Approval :end -->
	   <!-- CORE Fields Inclusion : start -->
	   <input type="hidden" name="Core_introd_cust_id" value=""/>
	   <!-- Tracker 85215 Begin Of changes -->
	   <input type="hidden" name="Nat_id_card_num" value="{$Nat_id_card_num}"/>
	   <!-- Tracker 85215 End Of changes -->
	  <!--  <input type="hidden" name="Psprt_issue_date" value=""/> -->
	   <input type="hidden" name="Psprt_det" value=""/>
	   <!-- <input type="hidden" name="Psprt_exp_date" value=""/> -->
	   <input type="hidden" name="Name" value=""/>
	   <input type="hidden" name="MinorAttainMajorDate" value=""/>
	   <!-- <input type="hidden" name="DefaultAddressType" value="M"/> -->
	   <input type="hidden" name="Core_cust_id" value=""/>
	   <input type="hidden" name="Entity_cre_flag" value=""/>
	   <input type="hidden" name="Groupid_code" value=""/>
	   <input type="hidden" name="Rating_code" value=""/>
	   <input type="hidden" name="Constitution_ref_code" value=""/>
	<!--Changes for Tracker id:355038 starts -->
	   <input type="hidden" name="Sector" value=""/>
	   <input type="hidden" name="Subsector" value=""/>
	<!--Changes for Tracker id:355038 ends-->
	   <input type="hidden" name="CustCreationMode" value="N"/>
	   <input type="hidden" name="Minor_guard_code" value=""/>
	   <input type="hidden" name="Minor_guard_name" value=""/>
	   <input type="hidden" name="Cust_pref_till_date" value=""/>
      <!-- Change for DBS ticket 325152 -->
      <input type="hidden" name="SwiftAddressDetails" value=""/>


	   <!-- CORE Fields Inclusion : end -->
           <!-- Hidden Variable for the duplication of data -->
           <!-- FCRM6201RECON Tracker# 49443, Begin of Changes -->
             <input type="hidden" name="DemographicBO_Phone_Work" value="{$phonework}"/>
             <input type="hidden" name="DemographicBO_Phone_Home" value="{$phonehome}"/>
             <input type="hidden" name="DemographicBO_Phone_Cell" value="{$phonecell}"/>
             <input type="hidden" name="DemographicBO_Fax_Work" value="{$fax}"/>
             <input type="hidden" name="DemographicBO_URL" value="{$companyurl}"/>
             <input type="hidden" name="DemographicBO_Email_Work" value="{$emailwork}"/>
             <input type="hidden" name="DemographicBO_Email_Home" value="{$emailhome}"/>
             <input type="hidden" name="DemographicBO_Email_Palm" value="{$emailpalm}"/>
             <input type="hidden" name="PAN_txt_ID" value="{$pan}"/>
              <!-- changes for adhar for tracker 375136 starts -->
              <input type="hidden" name="UniqueIDNumber_txt_ID" value="{$UniqueIDNumber}"/>
              <!-- changes for adhar for tracker 375136 ends -->
             <!-- TRACKER ID: 113279 Begins -->
             <input type="hidden" name="IDTypeR1_txt_ID" value="{$IDTypeR1}"/>
             <input type="hidden" name="IDTypeR2_txt_ID" value="{$IDTypeR2}"/>
             <input type="hidden" name="IDTypeR3_txt_ID" value="{$IDTypeR3}"/>
             <input type="hidden" name="IDTypeR4_txt_ID" value="{$IDTypeR4}"/>
             <input type="hidden" name="IDTypeR5_txt_ID" value="{$IDTypeR5}"/>
             <!-- TRACKER ID: 113279 Ends -->
             <input type="hidden" name="SSN_txt_ID" value="{$ssn}"/>
             <input type="hidden" name="Driving_Licence_txt_ID" value="{$licence}"/>
             <input type="hidden" name="Passport_Number_txt_ID" value="{$passport}"/>
			 <input type="hidden" name="Psprt_issue_date" value="{$ppIssDate}"/>
			 <input type="hidden" name="Psprt_exp_date" value="{$ppExpDate}"/>
             <input type="hidden" name="DemographicBO_Qualification" value="{$education}"/>
             <input type="hidden" name="DemographicBO_MiscellaneousInfo_strText2" value="{$occupation}"/>
             <input type="hidden" name="AccountBO.Occupation_code" value="{$occupation_code}"/>
             <input type="hidden" name="DemographicBO_MiscellaneousInfo_strText3" value="{$industry}"/>
             <input type="hidden" name="DemographicBO_MiscellaneousInfo_strText9" value="{$designation}"/>
             <input type="hidden" name="WorkExtension" value="{$extension}"/>
           <!-- FCRM6201RECON Tracker# 49443, End of Changes -->
             <!-- CRM6206RECON:TRACKER# 59146 **BEGIN   CHANGES-->
             <input type="hidden" name="isDemoLoaded" value="false"/>
             <input type="hidden" name="isPsychoLoaded" value="false"/>
             <!-- CRM6206RECON:TRACKER# 59146 **END   CHANGES-->

             <input type="hidden" name="boName" value="{$boName}"/>
             <input type="hidden" name="boNameCI" value="{$boNameCI}"/>
             <input type="hidden" name="apprFlag" value="{$apprFlag}"/>

             <!-- Save & submit  change:Start-->
	      <input type="hidden" name="operationType" value="{$operationType}"/>
	      <input type="hidden" name="saveFlag" value=""/>
	     <!-- Save & submit  change:Ends-->

              <!--CIF LOS Bypass change:Start-->
             <input type="hidden" name="byPassFlag" value="{$byPassFlag}"/>
              <!--CIF LOS Bypass change:End-->

              <!-- Changes for 'WFlow' POC start -->
	    <input type="hidden" name="IntWFID" value="{$IntWFID}"/>
              <!-- Changes for 'WFlow' POC end -->

             <!-- Hidden variables for address tab begin-->
             <input type="hidden" name="address_type" value=""/>
             <input type="hidden" name="screenname" value="CIF"/>
		<input type="hidden" name="copyKey" value=""/>
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
	     	<input type="hidden" name="AdrRemoved" value=""/>

	     	<input type="hidden" name="work_phone_cntry" value=""/>
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

	     	<input type="hidden" name="extension" value=""/>

	     	<input type="hidden" name="eduURL" value=""/>
	        <input type="hidden" name="EduRemoved" value=""/>
<!-- changes for call id 561860-->
	        <input type="hidden" name="vAddTypeLT" value=""/>
<!-- changes for 561860 -->
	        <input type="hidden" name="accountID" value="{$accountID}"/>
		<!-- House hold ID changes : Begin -->
		<input type="hidden" name="newHouseVal" value=""/>
		<!-- House hold ID changes : End -->

	        <!--hidden variables for CORE Fields in Address : start-->
	        <input type="hidden" name="telex" value=""/>
	        <input type="hidden" name="telex_cntry" value=""/>
	        <input type="hidden" name="telex_area" value=""/>
	        <input type="hidden" name="telex_local" value=""/>
	        <input type="hidden" name="country_code" value=""/>
	        <input type="hidden" name="state_code" value=""/>
	        <input type="hidden" name="city_code" value=""/>
	      	<input type="hidden" name="core_cust_id" value=""/>
	        <input type="hidden" name="salutation_code" value=""/>
    <!--added for callid 676473-->
			  <input type="hidden" name="IsDummy" value="{$IsDummy}"/>
	        <input type="hidden" name="name" value=""/>
		<input type="hidden" name="isTFFlag" value="{$tfpartyFlag}"/>
		<input type="hidden" name="noOfCreditCard" value=""/>

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
	     	<input type="hidden" name="IsAddressProofRcvd" value=""/>

<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
<input name="IsAddressVerified" type="hidden" value=""/>
<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->

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
<!--IDENTIFICATION DOCUMENT CHANGES start-->
<!--saving identifier_type (unique id, Issue_Date, Valid_Date) in EntityTable for Retail start-->
		<input type="hidden" name="PAN.txt_ID"/>
		<input type="hidden" name="PAN.txt_Issue_Date"/>
		<input type="hidden" name="PAN.txt_Valid_Date"/>
		<input type="hidden" name="PAN.txt_Issue_Place"/>
		<!-- TRACKER ID: 113279 Begins -->
		  <!-- Adhar changes for tracker 375136 starts  -->
		<input type="hidden" name="Unique Identification Number.txt_ID"/>
		<input type="hidden" name="Unique Identification Number.txt_Issue_Date"/>
		<input type="hidden" name="Unique Identification Number.txt_Valid_Date"/>
		<input type="hidden" name="Unique Identification Number.txt_Issue_Place"/>
		  <!-- Adhar changes for tracker 375136 ends  -->
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
		<input type="hidden" name="hidIsMandatory" value=""/>
		<input type="hidden" name="hidScanRequired" value=""/>
		<input type="hidden" name="identifier_type_Code" value=""/>
		<!--Ticket id 387769 and Tracker id 235921 Changes Starts-->
		<input type="hidden" name="hididentifier_type_Code" value=""/>
		<!--Ticket id 387769 and Tracker id 235921 Changes Ends-->
		<input type="hidden" name="placeofissue" value=""/>
		<input type="hidden" name="countryofissue" value=""/>
		<input type="hidden" name="placeofissue_cat" value=""/>
		<input type="hidden" name="countryofissue_cat" value=""/>
		<input type="hidden" name="hidIsDocumentVerified" value=""/>
		<input type="hidden" name="hidEDoc_IsDirty" value=""/>
		<input type="hidden" name="hidIDIssuedOrg" value=""/>


<!-- TRACKER ID 321176 Identification changes end -->


<!-- TRACKER ID 321176 currency changes start -->

		<input type="hidden" name="boName3" value="{$boName3}"/>
			<input type="hidden" name="boName2" value="{$boName2}"/>
			<input type="hidden" name="AccessType" value="{$AccessType}"/>

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



<!-- TRACKER ID 321176 currrency changes end -->


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

             <!-- Hidden variables for address tab end-->

        <!-- Hidden variables for HouseHold tab start : Naved -->
		<input type="hidden" name="HouseHoldName" value=""/>
		<input type="hidden" name="HouseHoldID" value=""/>
		<input type="hidden" name="HouseHoldCode" value=""/>
		<input type="hidden" name="HouseHoldMasterID" value=""/>
		<input type="hidden" name="HouseHoldRemoved" value=""/>
		<input type="hidden" name="HouseHoldURL" value=""/>
		<input type="hidden" name="RelationshipMgr" value=""/>
		<!-- Hidden variables for HouseHold tab end : Naved -->

<!-- CRM101UB changes start -->
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
<!-- CRM101UB changes end -->
		<!--Field based maker checker changes-->
		<input type="hidden" name="isMCEditedGeneral" value="N"/>
		<input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
		<input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
		<input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>
		<input type="hidden" name="getRole" value="{$getRole}"/>

<!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES-->

<input type="hidden" name="Cust_DOB" value=""/>
<input type="hidden" name="converted_Date" value=""/>
<input type="hidden" name="CustStatusChgDate" value=""/>
<input type="hidden" name="RatingDate" value=""/>
<input type="hidden" name="RelationshipOpeningDate" value=""/>
<input type="hidden" name="RiskProfileExpiryDate" value=""/>
<input type="hidden" name="DateOfBecomingNRE" value=""/>
<input type="hidden" name="NREBecomingOrdDate" value=""/>

<input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
<!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES-->

<!--Hidden variables for StrUserFields for tracker id : 251100 / ticket id : 413564 start-->
<input type="hidden" name="StrUserField13" value=""/>
<!--Hidden variables for StrUserFields for tracker id : 251100 / ticket id : 413564 end-->

	<!-- CIF Changes following added for display of tabs -->
		<xsl:choose>
                    <xsl:when test= "normalize-space($accountURL)=''">
				<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
				    <xsl:with-param name="tabPageHeight">550</xsl:with-param>
				    <!-- Reducing the tab page height to remove extra space : Tracker ID 113276 -->
				</xsl:call-template>
			</xsl:when>
 		<xsl:when test= "not(normalize-space($accountURL)='') and $boName ='AccountModBO'">
                       		<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
				    <xsl:with-param name="tabPageHeight">550</xsl:with-param>
				    <!-- Reducing the tab page height to remove extra space : Tracker ID 113276 -->
				</xsl:call-template>
			</xsl:when>
		<xsl:when test="($byPassFlag) ='Y'">
				<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
				    <xsl:with-param name="tabPageHeight">550</xsl:with-param>
				    <!-- Reducing the tab page height to remove extra space : Tracker ID 113276 -->
				 </xsl:call-template>
                </xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="BeginTabView">
			    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
			    <xsl:with-param name="colSpan">6</xsl:with-param>
			    <xsl:with-param name="tabPageHeight">550</xsl:with-param>
			    <!-- Reducing the tab page height to remove extra space : Tracker ID 113276 -->
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		  		<!-- View : General Details :Start   -->
		<xsl:choose>
                    <xsl:when test= "not(normalize-space($byPassFlag)='Y')">

		                <xsl:call-template name="BeginTabPage">
		                    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
		                    <xsl:with-param name="tabPageName">tpageCont</xsl:with-param>
		                    <xsl:with-param name="spanWidth">4</xsl:with-param>
		                    <xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
		                    <!-- TRACKER ID 321176 basic info changes start -->

				    	    			    <xsl:with-param name="tabPageDisplayNameRes">Basic Info</xsl:with-param>

				    <!-- TRACKER ID 321176 basic info changes end -->

		                    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
		                </xsl:call-template>

	<xsl:call-template name="apply">
	     <xsl:with-param name="apply_head">
	     <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
	     </xsl:with-param>
	     <xsl:with-param name="priorityCode"><xsl:value-of select="$priorityCode"/>
	     </xsl:with-param>
	</xsl:call-template>
                 <!-- end of General  -->
<!--<table width="100%" bgcolor='FFFFFF' cellspacing="0" vspace="0" hspace="0" border="0">
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.NAME"/>
<xsl:call-template name="End"/>
</table>
-->

<!-- View : General Details :START -->
<!-- TRACKER# 92380 START: 2 column changes and button allignment changes-->

<!-- **********Tracker ID 113276 changes start here ******* -->

<xsl:call-template name="Begin"/>
       		<xsl:call-template name="AccountBO.GCIFID"/>
    <xsl:call-template name="AccountBO.AccountKey"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<!-- ***** Tracker# 228683  CIF - Basel Changes : Start -->
<xsl:choose>
     <xsl:when test="normalize-space($accountURL)=''">
<xsl:choose>
<xsl:when test= "normalize-space($isBasel)='N'">
	<xsl:call-template name="BaselProfiling"/>
	   </xsl:when>
</xsl:choose>
	   </xsl:when>
</xsl:choose>
<!-- ***** Tracker# 228683  CIF - Basel Changes : End -->	
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	 	<xsl:call-template name="apply">
	 		<xsl:with-param name="apply_head">
	 		<b><xsl:value-of select="$configLabels[@name='PersonalDetails']/@configLabel"/></b><br/>
	 		</xsl:with-param>
	 		</xsl:call-template>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Gender"/>
    <xsl:call-template name="AccountBO.Salutation"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Cust_First_Name"/>
    <xsl:call-template name="AccountBO.Cust_Middle_Name"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Cust_Last_Name"/>
   <xsl:call-template name="AccountBO.short_name"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Name"/>
    <xsl:call-template name="AccountBO.PreferredName"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.nick_name"/>
    <xsl:call-template name="AccountBO.StrUserField28"/>

<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Cust_DOB"/>
   <xsl:call-template name="AccountBO.CustomerMinor"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.MinorAttainMajorDate"/>
    <xsl:call-template name="AccountBO.PlaceOfBirth"/>
<xsl:call-template name="End"/>


<!-- Senior Citizen Starts-->
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.SeniorCitizen"/>
    <xsl:call-template name="AccountBO.SenCitizenApplicableDate"/>
<xsl:call-template name="End"/>
<!-- Senior Citizen Ends-->


<xsl:call-template name="Begin"/>
     <xsl:call-template name="AccountBO.CustomerNREFlg"/>
    <xsl:call-template name="AccountBO.DateOfBecomingNRE"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
     <xsl:call-template name="AccountBO.StaffFlag"/>
    <xsl:call-template name="AccountBO.StaffEmployeeID"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.MaidenNameOfMother"/>
    <xsl:call-template name="AccountBO.Primary_sol_id"/>
<xsl:call-template name="End"/>

<!-- ticket 214549 changes start -->
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Cust_Type"/>
 	<xsl:call-template name="AccountBO.status"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin" />
	<xsl:if test="not((normalize-space($operationType)='null' and not(normalize-space($readMode)='Y')) or ((normalize-space($operationType)='Queue') and normalize-space($entityCreflg)='N')) and not(normalize-space($convToCust)='Y')">
		<xsl:call-template name="AccountBO.DateOfDeath" />
		</xsl:if>

	<xsl:if test="not((normalize-space($operationType)='null' and not(normalize-space($readMode)='Y')) or ((normalize-space($operationType)='Queue') and normalize-space($entityCreflg)='N')) and not(normalize-space($convToCust)='Y')">
		<xsl:call-template name="AccountBO.DateOfNotification" />
		</xsl:if>

	<xsl:call-template name="End" />
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Segmentation_Class"/>
    <xsl:call-template name="AccountBO.SubSegment"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.ChargeLevelCode"/>
    <xsl:call-template name="AccountBO.RatingDate"/>
<xsl:call-template name="End"/>
<!-- ticket 214549 changes end -->

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Cust_hlth"/>
    <xsl:call-template name="AccountBO.priorityCode"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Physical_State"/>
    <xsl:call-template name="AccountBO.Cust_Swift_Code_Desc"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.StrUserField12"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.StrUserField30"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Is_Swift_Code_Of_Bank"/>
    <xsl:call-template name="AccountBO.Offline_cum_debit_limit"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Cust_community"/>
    <xsl:call-template name="AccountBO.Rating"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Pref_code"/>
           <xsl:call-template name="AccountBO.TFPartyFlag"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Sector"/>    
    <xsl:call-template name="AccountBO.Subsector"/>
<xsl:call-template name="End"/>

<!--Isic field call by Silvester starts-->
<xsl:call-template name="Begin"/>
   	<xsl:call-template name="AccountBO.StrField16"/>
	<xsl:call-template name="AccountBO.StrField18"/> 
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.StrField19"/>
    <xsl:call-template name="AccountBO.StrField21"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.StrUserField24"/>
    <xsl:call-template name="AccountBO.StrUserField25"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.strField9"/>
	<xsl:call-template name="AccountBO.StrUserField26"/>
<xsl:call-template name="End"/>

<!--Isic field call by Silvester ends-->

<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountBO.Secure_id"/>
	<xsl:call-template name="AccountBO.RiskProfileScore"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.RiskProfileExpiryDate"/>
    <xsl:call-template name="AccountBO.CreditBureauScore"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
<xsl:call-template name="AccountBO.creditScoreRequestedFlag"/>
<xsl:call-template name="AccountBO.riskRating"/>
<xsl:call-template name="End"/>

<!-- Changes for KYC Enhancement Start-->

<xsl:call-template name="Begin"/>
<xsl:call-template name="AccountBO.KYC_Date"/>
<xsl:call-template name="AccountBO.KYC_ReviewDate"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.submitForKYC"/>
    <xsl:call-template name="AccountBO.region"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountBO.TertiaryRM_ID"/>

<xsl:call-template name="End"/>

<!-- Changes for KYC Enhancement Ends-->

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Constitution_Code"/>
    <xsl:call-template name="AccountBO.Tds_cust_id"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Tds_tbl"/>
    <xsl:call-template name="AccountBO.asset_classification"/>
<xsl:call-template name="End"/>


<!-- ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 start -->
<!-- Call Templates for 4 new dropdown fields -->

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Customer_Level_Provisioning"/>
    <xsl:call-template name="AccountBO.islamic_banking_customer"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.zakat_deduction"/>
    <xsl:call-template name="AccountBO.preferredCalendar"/>
<xsl:call-template name="End"/>
<!-- ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 end -->



<xsl:call-template name="Begin"/>
<!--ERPBOCF1:TRACKER:113259:BEGINOFCHANGES(HIJRI)-->
<!-- calling template Preferred Calendar-->

 <xsl:call-template name="AccountBO.preferredChannelID"/>

<!--ERPBOCF1:TRACKER:113259:ENDOFCHANGES(HIJRI)-->

    <xsl:call-template name="AccountBO.Crncy_code"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.PurgeRemarks"/>
    <xsl:call-template name="AccountBO.PurgeFlag"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.DelinquencyFlg"/>
<!-- Change for 374326 and 374328 start -->
    <xsl:call-template name="PsychographicBO.Preferred_Locale"/>
<!-- Change for 374326 and 374328 end -->
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<!-- Change done by Bharath start -->
<xsl:call-template name="AccountBO.Amount2"/>
<xsl:call-template name="AccountBO.StrUserField10"/>
<!-- Change done by Bharath end -->
<xsl:call-template name="End"/>
<!--Changes for Alert-Server recon in 10.2.14 starts-->
<!--<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountBO.Enable_Alerts" />

	<xsl:call-template name="BeginCellWithParams">
		<xsl:with-param name="align">left</xsl:with-param>
		<xsl:with-param name="class">d1</xsl:with-param>
		<xsl:with-param name="style">width:22%</xsl:with-param>
		<xsl:with-param name="valign">top</xsl:with-param>
	</xsl:call-template>
<label for="AccountBO.DefaultChannel_Alert"><xsl:value-of select="$configLabels[@name='AccountBO.DefaultChannel_Alert']/@configLabel" /></label>
<xsl:call-template name="EndCell" />
<xsl:call-template name="BeginCellWithParams">
		<xsl:with-param name="style">width:22%</xsl:with-param>
	</xsl:call-template>

		<xsl:call-template name="AccountBO.DefaultChannel_Alert" />
	<xsl:call-template name="EndCell" />
<xsl:call-template name="End"/>-->
<!--Changes for Alert-Server recon in 10.2.14 ends-->

<!-- Changes For Ticketid:- 371367 Begin
      Commenting the changes done for Ticketid:-286305 -->

<!-- Changes For Ticketid:-286305 Begin
      PrefCode been introduced in General Basic Info tab instead of coreinterface tab-->
<!-- <xsl:call-template name="Begin"/>
<xsl:call-template name="CoreInterfaceBO.PrefCode"/> -->
<!-- Changes For Ticketid:- 371367 end -->
<!-- Changes For Ticketid:-286305 End-->
<xsl:call-template name="Begin" />
		<xsl:call-template name="AccountBO.Enable_Alerts" />

	<xsl:call-template name="BeginCellWithParams">
		<xsl:with-param name="class">d1</xsl:with-param>
		<xsl:with-param name="nowrap">true</xsl:with-param>
	</xsl:call-template>
<label for="AccountBO.DefaultChannel_Alert"><xsl:value-of disable-output-escaping="yes" select="$configLabels[@name='AccountBO.DefaultChannel_Alert']/@configLabel" /></label>

	<xsl:call-template name="CRMMandatoryStar">
		<xsl:with-param name="font_id">mandStarAccountBO.DefaultChannel_Alert</xsl:with-param>
		<xsl:with-param name="font_name">mandStarAccountBO.DefaultChannel_Alert</xsl:with-param>
		<xsl:with-param name="style">visibility:hidden</xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="EndCell" />

	<xsl:call-template name="BeginCellWithParams">
		<xsl:with-param name="style">width:22%</xsl:with-param>
	</xsl:call-template>

		<xsl:call-template name="AccountBO.DefaultChannel_Alert" />
	<xsl:call-template name="EndCell" />
	<xsl:call-template name="End" />

<xsl:choose>
    <xsl:when test= "not(normalize-space($accountURL)='')">
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.OldEntityType"/>
    <xsl:call-template name="AccountBO.converted_Date"/>
<xsl:call-template name="End"/>
</xsl:when>
    </xsl:choose>


<xsl:call-template name="Begin"/>

    <xsl:choose>
    <xsl:when test= "not(normalize-space($accountURL)='')">
    	<xsl:call-template name="LastUpdateDate"/>
    </xsl:when>
    </xsl:choose>
<!-- Change done by Timothy start -->
<xsl:call-template name="AccountBO.StrUserField19"/>
<!-- Change done by Timothy end -->
<xsl:call-template name="End"/>


<!--Isic secondary Economic activity changes By Silvester starts-->
<xsl:call-template name="apply">
<xsl:with-param name="apply_head">
   Secondary Economic Activity 
</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="Begin"/>
<xsl:call-template name="AccountBO.StrUserField6"/>
<xsl:call-template name="AccountBO.StrUserField7"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
<xsl:call-template name="AccountBO.StrUserField2"/>
<xsl:call-template name="AccountBO.StrUserField23"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
<xsl:call-template name="AccountBO.StrUserField3"/>
<xsl:call-template name="AccountBO.StrUserField9"/>
<xsl:call-template name="End"/>

<!--Isic secondary Economic activity changes By Silvester ends-->


<xsl:call-template name="Begin"/>
	<xsl:call-template name="apply">
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
<td class='d1' align='center' style='TEXT-ALIGN: right;'><xsl:value-of select="$configLabels[@name='AccountBO.IsWAPBankingEnabled']/@configLabel"/></td>
<td class='d1' align='center' style='TEXT-ALIGN: left;'><xsl:call-template name="AccountBO.IsWAPBankingEnabled"/></td>
<td class='d1' align='center' style='TEXT-ALIGN: right;'><xsl:value-of select="$configLabels[@name='AccountBO.IsSMSBankingEnabled']/@configLabel"/></td>
<td class='d1' align='center' style='TEXT-ALIGN: left;'><xsl:call-template name="AccountBO.IsSMSBankingEnabled"/></td>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
	 	<xsl:call-template name="apply">
	 	<xsl:with-param name="apply_head">
	 	<b><xsl:value-of select="$configLabels[@name='RelationshipManagerDetails']/@configLabel"/></b><br/>
	 	</xsl:with-param>
	 	</xsl:call-template>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountBO.Manager"/>
	<xsl:call-template name="AccountBO.SecondaryRM_ID"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.RelationshipOpeningDate"/>
    <xsl:call-template name="AccountBO.RelationshipCreatedByID"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.relationship_level"/>
    <xsl:call-template name="AccountBO.lead_source"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
	 	<xsl:call-template name="apply">
	 	<xsl:with-param name="apply_head">
	 	<b><xsl:value-of select="$configLabels[@name='LanguagePreference']/@configLabel"/></b><br/>
	 	</xsl:with-param>
	 	</xsl:call-template>
 <xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.NativeLangCode"/>
    <xsl:call-template name="AccountBO.Cust_Language"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.NativeLangTitle"/>
    <xsl:call-template name="AccountBO.NativeLangName"/>

<xsl:call-template name="End"/>



<DIV ID = 'native' STYLE= 'visibility:visible;'>

		<TR ID='rownative' name='rownative'>
			<xsl:call-template name="AccountBO.Cust_First_Name_Native">
				   <xsl:with-param name="ele_name">AccountBO.Cust_First_Name_Native</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="AccountBO.Cust_Middle_Name_Native">
				   <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_Native</xsl:with-param>
			</xsl:call-template>
		</TR>
		<TR ID='rownative1' name='rownative1'>
			<xsl:call-template name="AccountBO.Cust_Last_Name_Native">
				   <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_Native</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="AccountBO.Short_Name_Native">
				   <xsl:with-param name="ele_name">AccountBO.Short_Name_Native</xsl:with-param>
			</xsl:call-template>
		</TR>
	</DIV>

<!-- Tracker 148370 -->


<DIV ID = 'native' STYLE= 'visibility:visible;'>
			<xsl:call-template name="Begin"/>
				<xsl:call-template name="AccountBO.Cust_Last_Name_Native1">
					  <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_Native1</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="AccountBO.Cust_Middle_Name_Native1">
					   <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_Native1</xsl:with-param>
				</xsl:call-template>
			<xsl:call-template name="End"/>

			<xsl:call-template name="Begin"/>
				<xsl:call-template name="AccountBO.Cust_First_Name_Native1">
					   <xsl:with-param name="ele_name">AccountBO.Cust_First_Name_Native1</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="AccountBO.Short_Name_Native1">
					   <xsl:with-param name="ele_name">AccountBO.Short_Name_Native1</xsl:with-param>
				</xsl:call-template>
			<xsl:call-template name="End"/>

</DIV>

<!-- Tracker 148370 -->



<!--Access Control Changes Begins -->

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

	<xsl:call-template name="End"/>

<!--Access Control Changes Ends -->

<!-- ************************************************************************************************************************
*************************************************************************************************************************
************************************************************************************************************************ -->

<!-- Commented as these need to be removed from UI :  -->
<!-- <xsl:call-template name="Begin"/>

    <xsl:call-template name="AccountBO.NameSuffix"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.maidenName"/>
    <xsl:call-template name="AccountBO.previous_name"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.short_name"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.strField6"/>

<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.spouseID"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
     <xsl:call-template name="AccountBO.CountryOfBirth"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
      <xsl:call-template name="AccountBO.ProofOfAgeFlag"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.ProofOfAgeDocument"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>

        <xsl:call-template name="AccountBO.strField7"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.mother_name"/>

<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Groupid"/>

<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
     <xsl:call-template name="AccountBO.father_husband_name"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.RelationshipValue"/>
    <xsl:call-template name="AccountBO.NumberOfProducts"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>

        <xsl:call-template name="AccountBO.relationship_type"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.preferredChannelID"/>
    <xsl:call-template name="AccountBO.status"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountBO.TertiaryRM_ID"/>

<xsl:call-template name="End"/>



<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.AutoApproval"/>
    <xsl:call-template name="AccountBO.FreezeProductSale"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.revenueUnits"/>
    <xsl:call-template name="AccountBO.customerProfitability"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.currentCrExposure"/>
    <xsl:call-template name="AccountBO.totalCrExposure"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.potentialCrLine"/>
    <xsl:call-template name="AccountBO.availableCrLimit"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Alert1"/>
    <xsl:call-template name="AccountBO.Alert2"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>

    <xsl:call-template name="AccountBO.creditHistoryRequestedFlag"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.strfield1"/>
    <xsl:call-template name="AccountBO.strfield2"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.strfield3"/>
    <xsl:call-template name="AccountBO.strfield4"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.strfield5"/>
    <xsl:call-template name="AccountBO.DtDate1"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.DtDate2"/>
    <xsl:call-template name="AccountBO.DtDate3"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.dtDate6"/>
    <xsl:call-template name="AccountBO.userFlag1"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.userFlag2"/>
    <xsl:call-template name="AccountBO.userFlag3"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.userFlag4"/>
    <xsl:call-template name="AccountBO.Cust_Staff_Status"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.CIN"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <td class='d1' align='left' valign ="top" ><xsl:value-of select="$configLabels[@name='AccountBO.card_holder']/@configLabel"/></td>
    <td class='d1' align='left' valign ="top" style='TEXT-ALIGN: left;padding-left:0px;'><xsl:call-template name="CardHolderFlag"/></td>
    <xsl:call-template name="AccountBO.notes"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
   Naved Fix <xsl:call-template name="AccountBO.primary_service_centre"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>

     <xsl:call-template name="AccountBO.rm_group_id"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.DSA_ID"/>
    <xsl:call-template name="AccountBO.photograph_id"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Tds_cust_id"/>
    <xsl:call-template name="AccountBO.Tds_tbl"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>

    <xsl:call-template name="AccountBO.RatingDate"/>
    <xsl:call-template name="AccountBO.ManagerOpinion"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.CustStatusChgDate"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>

    <xsl:call-template name="AccountBO.NREBecomingOrdDate"/>

<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.PurgeFlag"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
 <td class='d1' align='center' style='TEXT-ALIGN: right;'><xsl:value-of select="$configLabels[@name='AccountBO.PurgeFlag']/@configLabel"/></td>
<td class='d1' align='center' style='TEXT-ALIGN: left;'><xsl:call-template name="PurgeFlag"/></td>

<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
<td class='d1' align='center'><xsl:value-of select="$configLabels[@name='AccountBO.Document_Received']/@configLabel"/></td>
<td class='d1' align='center' style='TEXT-ALIGN: left;padding-left:0px'><xsl:call-template name="Document_Received"/></td>

<xsl:call-template name="End"/>-->


<xsl:choose>
<xsl:when test= "not(normalize-space($accountURL)='')">
<xsl:call-template name="Begin"/>
	<xsl:call-template name="Signature"/>
<xsl:call-template name="End"/>
</xsl:when>
</xsl:choose>

<xsl:choose>
<xsl:when test= "not(normalize-space($accountURL)='')">
<xsl:call-template name="Begin"/>
	<xsl:call-template name="CRV"/>
<xsl:call-template name="End"/>
</xsl:when>
</xsl:choose>

<xsl:choose>
<xsl:when test= "not(normalize-space($accountURL)='')">
<xsl:call-template name="Begin"/>
	<xsl:call-template name="HCCFM"/>
<xsl:call-template name="End"/>
</xsl:when>
</xsl:choose>

<xsl:choose>
<xsl:when test= "not(normalize-space($accountURL)='')">
<xsl:call-template name="Begin"/>
	<xsl:call-template name="MEMOPAD"/>
<xsl:call-template name="End"/>
</xsl:when>
</xsl:choose>

<!-- Commented as these need to be removed from UI : Tracker ID 113276 -->

<!-- Changes made by Tracker ID 113276 : Start -->

<!--Native Language Changes:start-->
	<xsl:variable name="NATIVE"><xsl:value-of select="$configLabels[@name='NativeLanguageFields']/@configLabel"/></xsl:variable>
<!--Tracker 131224 fix :starts-->
	<!--<TR style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rownative2" name="rownative2">
	    <TD onclick="Toggle('native','all');" VALIGN="top" colspan="9" NOWRAP="true" class="LabelFont">
	        <A HREF="javascript:Toggle('native','all');"><IMG onclick="Toggle('native','all');" SRC="../reports/images/minus.gif" ID="nativegif"
	        BORDER="0" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	        <label FOR="CPD" class="LabelFont"><xsl:value-of select="$NATIVE"/> </label>
	    </TD>
</TR>-->
<!-- CRM102ST: Tracker ID:182172 Begin of Change -->
<TR style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rownative2" name="rownative2">
	    <xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
	    <TD onclick="Toggle('native','all');" colspan="9" NOWRAP="true" class="LabelFont">
	        <A HREF="javascript:Toggle('native','all');"><IMG onclick="Toggle('native','all');" SRC="../reports/images/minus.gif" ID="nativegif"
	        BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	        <label FOR="CPD" class="LabelFont"><xsl:value-of select="$NATIVE"/> </label>
	    </TD>
</TR>

<!-- CRM102ST: Tracker ID:182172 End of Change -->

	<DIV ID = 'native' STYLE= 'visibility:visible;'>
		<TR ID='rownative' name='rownative'>
</TR>
<TR ID='rownative' name='rownative'>
<xsl:call-template name="RelationshipBO.ChildEntityType">
		  <xsl:with-param name="ele_name">RelationshipBO.ChildEntityType</xsl:with-param>
			</xsl:call-template>
<xsl:call-template name="RelationshipBO.Bank_Entity1">
		  <xsl:with-param name="ele_name">RelationshipBO.Bank_Entity1</xsl:with-param>
			</xsl:call-template>
		</TR>
		<TR ID='rownative' name='rownative'>
<xsl:call-template name="RelationshipBO.Bank_Entity_Name1">
		  <xsl:with-param name="ele_name">RelationshipBO.Bank_Entity_Name1</xsl:with-param>
			</xsl:call-template>
<xsl:call-template name="AccountBO.Introd_Status">
		  <xsl:with-param name="ele_name">AccountBO.Introd_Status</xsl:with-param>
			</xsl:call-template>
		</TR>
<TR ID='rownative' name='rownative'>
<xsl:call-template name="AccountBO.IntroducerSalutation">
		  <xsl:with-param name="ele_name">AccountBO.IntroducerSalutation</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="AccountBO.IntroducerID">
		  <xsl:with-param name="ele_name">AccountBO.IntroducerID</xsl:with-param>
</xsl:call-template>
</TR>
<TR ID='rownative' name='rownative'>
<xsl:call-template name="AccountBO.IntroducerName">
		  <xsl:with-param name="ele_name">AccountBO.IntroducerName</xsl:with-param>
</xsl:call-template>
<!--Equity bank adding new field for non cif introducer name TOI 360106-->
<xsl:call-template name="AccountBO.StrUserField21">
		  <xsl:with-param name="ele_name">AccountBO.StrUserField21</xsl:with-param>
</xsl:call-template>
<!--Equity bank adding new field for non cif introducer name TOI 360106-->
</TR>
<!--Equity bank adding new field for non cif introducer name TOI 356581-->
<TR ID='rownative' name='rownative'>
<xsl:call-template name="AccountBO.StrUserField22">
		  <xsl:with-param name="ele_name">AccountBO.StrUserField22</xsl:with-param>
</xsl:call-template>
</TR>
<!--Equity bank adding new field for non cif introducer name TOI 356581-->
</DIV>






	        <tr></tr>

<!--Native Language Changes:end-->
<!-- <table width="100%" bgcolor='ffffff' cellspacing="0" vspace="15" hspace="0" border="0" align = "center">
<xsl:call-template name="apply">
		 <xsl:with-param name="apply_head">
		  <b><xsl:value-of select="$configLabels[@name='MLHeader4']/@configLabel"/></b>
		  </xsl:with-param>
	</xsl:call-template>
<TR >

		<TD nowrap="true" align="left" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='Available_BackendID']/@configLabel"/></TD>
		<TD style="width:22%">
			<xsl:call-template name="Assigned_BackendID"/>
		</TD>
		<TD width="5%" align="center">
			<input class='frmBttnsAddRmv' Type='button' value='&gt;&gt;'
			onclick="selfield(Assigned_BackendID,Available_BackendID, false)"/><BR/>
			<input class='frmBttnsAddRmv' Type='button' value='&lt;&lt;'
			onclick="selfield(Available_BackendID, Assigned_BackendID, true)"/>
			</TD>
		<TD  nowrap="true" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='Assigned_BackendID']/@configLabel"/></TD>
		<TD>
			<xsl:call-template name="Available_BackendID"/>
		</TD>

	</TR>

</table> -->

<!-- TrackerID: 113227 start of changes-->
   <xsl:choose>
	<xsl:when test="normalize-space($altLocaleActv)='true'">

	<xsl:variable name="DUAL"><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>

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

		<TR ID='rowdual' name='rowdual'>
			<xsl:call-template name="AccountBO.Cust_Last_Name_alt1">
			</xsl:call-template>

			<xsl:call-template name="AccountBO.Cust_First_Name_alt1">
			</xsl:call-template>
		</TR>

		<TR ID='rowdual' name='rowdual'>
					<xsl:call-template name="AccountBO.Cust_Middle_Name_alt1">
					</xsl:call-template>


					<xsl:call-template name="AccountBO.short_name_alt1">
					</xsl:call-template>
		</TR>

				<TR ID='rowdual' name='rowdual'>
					<xsl:call-template name="AccountBO.Name_alt1">
					</xsl:call-template>

				</TR>
	</table>
	</DIV>
 </xsl:when>

  </xsl:choose>



<!-- TrackerID: 113227 end of changes-->

<!--CIF Changes - BackEnd Changes Ends -->
<!-- Changes made by Tracker ID 113276 : End -->

<xsl:call-template name="EndTabPage"/>

	</xsl:when>
<xsl:otherwise>
<xsl:call-template name="BeginTabPage">
    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
    <xsl:with-param name="tabPageName">tpageCont1</xsl:with-param>
    <xsl:with-param name="spanWidth">3</xsl:with-param>
    <xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
    <xsl:with-param name="tabPageDisplayNameRes">Address</xsl:with-param>
    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
</xsl:call-template>

	    <table bgcolor="FFFFFF" align="center" cellpadding="2" width="100%">
	            		<tr align="left">
	            			<td>
	    				<!-- CIF address changes anwesha -->
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
	    				<!-- Swift Address Changes Begin -->

	    				<xsl:call-template name="user_button_withText">
					<xsl:with-param name="button_name">SWIFT_ADDRESS_DETAILS</xsl:with-param>
					<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='SWIFT_ADDRESS_DETAILS']/@configLabel"/></xsl:with-param>
					<!-- Tracker 146819: Passed the new variable readMode -->
					<xsl:with-param name="button_fnc">createSwiftAddress(readMode)</xsl:with-param>

	    				</xsl:call-template>&#160;

	    				<!-- End of Swift Address Changes -->
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
	        <xsl:with-param name="rsfilenm" select="$fileName"/>
		<xsl:with-param name="jscriptfnc">,call()</xsl:with-param>
		<xsl:with-param name="extra_colheader">Select</xsl:with-param>
		<xsl:with-param name="onClick">editAddressDetails()</xsl:with-param>
		<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
		<xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
		<xsl:with-param name="PrefixVal">2</xsl:with-param>
		</xsl:call-template>


	    <xsl:call-template name="EndTabPage"/>
</xsl:otherwise>
</xsl:choose>
<xsl:choose>
   <xsl:when test= "not(normalize-space($byPassFlag)='Y')">

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
				    <xsl:with-param name="tabPageHeight">250</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="BeginTabPage">
                    <xsl:with-param name="tabViewName">tabContactDetails</xsl:with-param>
                    <xsl:with-param name="tabPageName">tpageAddr</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameRes" select="'Address'"/>
                    <xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
		    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
                </xsl:call-template>

<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
<tr ><td>
	    	<!--fix for ticket 201864 start-->
	    			<xsl:choose>
	    			<xsl:when test="normalize-space($accountURL)=''">
	    <table bgcolor="FFFFFF" align="center" cellpadding="2" width="100%">
	            		<tr align="left">
	            			<td>
	      	<xsl:call-template name="AccountBO.Address.preferredAddress"/>
	</td>
	<td>
	<xsl:call-template name="user_button">
        <xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='ADD_ADDRESS']/@configLabel"/></xsl:with-param>
	    				<xsl:with-param name="button_fnc">addAddress()</xsl:with-param>
	    				</xsl:call-template>&#160;

        <xsl:call-template name="user_button">
        <xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='DELETE_ADDRESS']/@configLabel"/></xsl:with-param>
	    				<xsl:with-param name="button_fnc">removeAddress()</xsl:with-param>
	    				</xsl:call-template>&#160;

        <xsl:call-template name="user_button">
        <xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='COPY_ADDRESS']/@configLabel"/></xsl:with-param>
	    				<xsl:with-param name="button_fnc">copyAddress()</xsl:with-param>
	    				</xsl:call-template>&#160;
	    				<!-- Swift Address Changes Begin -->

	    				<xsl:call-template name="user_button_withText">
					<xsl:with-param name="button_name">SWIFT_ADDRESS_DETAILS</xsl:with-param>
					<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='SWIFT_ADDRESS_DETAILS']/@configLabel"/></xsl:with-param>
					<!-- Tracker 146819: Passed the new variable readMode -->
					<xsl:with-param name="button_fnc">createSwiftAddress(readMode)</xsl:with-param>

	    				</xsl:call-template>&#160;

	    				<!-- End of Swift Address Changes -->


	    				</td>
	    			</tr>
		</table>

	    			</xsl:when>
	        			 <xsl:otherwise>

	    			<table bgcolor="FFFFFF" align="center" cellpadding="2" width="100%">
	    			<tr align="left">
	    			<xsl:call-template name="AccountBO.Address.preferredAddress"/>
	    			<td>
				<xsl:call-template name="user_button">
				<xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='ADD_ADDRESS']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">addAddress()</xsl:with-param>
				</xsl:call-template>&#160;

				<xsl:call-template name="user_button">
				<xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='DELETE_ADDRESS']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">removeAddress()</xsl:with-param>
				</xsl:call-template>&#160;

				<xsl:call-template name="user_button">
				<xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='COPY_ADDRESS']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">copyAddress()</xsl:with-param>
				</xsl:call-template>&#160;

		 		<!-- Swift Address Changes Begin -->

				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">SWIFT_ADDRESS_DETAILS</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='SWIFT_ADDRESS_DETAILS']/@configLabel"/></xsl:with-param>
				<!-- Tracker 146819: Passed the new variable readMode -->
				<xsl:with-param name="button_fnc">createSwiftAddress(readMode)</xsl:with-param>

	  			</xsl:call-template>&#160;

	    			<!-- End of Swift Address Changes -->

				</td>
	    		      </tr>
	    		      	</table>
	    		      	<br/>

	        			 </xsl:otherwise>
	         			</xsl:choose>
     			<!--fix for ticket 201864 ends-->

		<xsl:call-template name="mainbody">
		<xsl:with-param name="tablename">RecordSet</xsl:with-param>
		<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='ADDRESS']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="align">center</xsl:with-param>
		<xsl:with-param name="button">true</xsl:with-param>
		<xsl:with-param name="width">100%</xsl:with-param>
		<xsl:with-param name="name">...</xsl:with-param>
		<xsl:with-param name="UsrDataSpace">Address</xsl:with-param>
		<xsl:with-param name="rowhighlight">true</xsl:with-param>
	        <xsl:with-param name="rsfilenm" select="$fileName"/>
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


       <xsl:call-template name="Begin"/>
	      	<xsl:call-template name="AccountBO.PhoneEmail.PhoneEmailType"/>
	      	<xsl:call-template name="AccountBO.PhoneEmail.PhoneEmailType1"/>
       <xsl:call-template name="End"/>
       <!--Changes for Alert Server recon in 10.2.14 starts-->
       <xsl:call-template name="Begin" />
       		<xsl:call-template name="AccountBO.Preferred_Mobile_Alert_Type" />
	<xsl:call-template name="End" />
	<!--Changes for Alert Server recon in 10.2.14 ends-->
<table bgcolor="FFFFFF" align="center" cellpadding="2" width="100%">
	<td>
        <xsl:call-template name="user_button">
        <xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='Add Phone/Email']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">addPhoneEmail()</xsl:with-param>
        </xsl:call-template>&#160;

        <xsl:call-template name="user_button">
        <xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='Delete Phone/Email']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">removePhoneEmail()</xsl:with-param>
        </xsl:call-template>&#160;

        <xsl:call-template name="user_button">
        <xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='Copy Phone/Email']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">copyPhoneEmail()</xsl:with-param>
        </xsl:call-template>&#160;
        </td>
</table>
<!-- TRACKER# 92380 END: 2 column changes and button allignment changes-->
    <xsl:call-template name="mainbody">
    <xsl:with-param name="tablename">PhoneEmailRecordSet</xsl:with-param>
    <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='PHONE']/@configLabel"/></xsl:with-param>
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

<xsl:call-template name="EndTabPage"/>
<!-- Rachit CIF PhoneEmail changes: End -->



<!-- TRACKER ID 321176 Identification changes start -->
<!-- View : Identification Details :Start   -->


		                <xsl:call-template name="BeginTabPage">
		                    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
		                    <xsl:with-param name="tabPageName">tpageCont5</xsl:with-param>
		                    <xsl:with-param name="spanWidth">4</xsl:with-param>
		                    <xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
		                    <xsl:with-param name="tabPageDisplayNameRes">Identification Details</xsl:with-param>
		                    <!--MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 BEGIN -->
				    <!-- The function focus first should be called on the tab selection -->
				     <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
		                    <!--MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240  -->
		                </xsl:call-template>

	 <!-- Shanmuga NRE changes - start -->
	<table width="100%" bgcolor='ffffff' align="center" cellspacing="0" vspace="20" hspace="0" border="0">
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

	<!-- Tracker id 120008 changes for MATT BUG FIXES start -->
	<!-- <xsl:call-template name="apply">
					<xsl:with-param name="apply_head">
					<b><xsl:value-of select="$configLabels_9[@name='Identification Details']/@configLabel"/></b><br/>
					</xsl:with-param>
	</xsl:call-template> -->
	<!-- Tracker id 120008 changes for MATT BUG FIXES end -->
	<xsl:call-template name="Begin"/>
	<td colspan="4">
	<table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
	<!-- Tracker ID 92380 -->
		<tr align="left">
			<td>
		<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_name">AddIdentificationDetails</xsl:with-param>
		<xsl:with-param name="button_text"><xsl:value-of select="$configLabelsID[@name='Add Identification Details']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="button_fnc">addIdentdetails(dualflag)</xsl:with-param>
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
	<!--TrackerId 113259 MATPT Begin defect CIF Retail > New Entity > Customer>general>idetification>add identification doc details>after adding and submitting documents the allignment of the listed data is incorrect.'is prefered'  column name is missing but data is being populated.-->

	<xsl:with-param name="radiobutton">true</xsl:with-param>
	<xsl:with-param name="radiobuttonOnClick">AddSelectedRowToList()</xsl:with-param>
	<xsl:with-param name="radiobutton_name">radio1</xsl:with-param>
	<xsl:with-param name="radiobutton_isPerformance">true</xsl:with-param>
	<!--TrackerId 113259 MATPT End defect CIF Retail > New Entity > Customer>general>idetification>add identification doc details>after adding and submitting documents the allignment of the listed data is incorrect.'is prefered'  column name is missing but data is being populated.-->

	<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
	<xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
	<xsl:with-param name="PrefixVal">2</xsl:with-param>
	</xsl:call-template>
	</td>
	<xsl:call-template name="End"/>


</table>

<xsl:call-template name="EndTabPage"/>

<!-- TRACKER ID 321176 Identification changes end -->


<!-- TRACKER ID 321176 currency changes start -->

<!-- CIF Changes: Currency Details :Start-->

    	<xsl:call-template name="BeginTabPage">
  		    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
		    <xsl:with-param name="tabPageName">tpageCont6</xsl:with-param>
		    <xsl:with-param name="spanWidth">4</xsl:with-param>
		    <xsl:with-param name="tabPageDisplayNameHardCoded">Yes</xsl:with-param>
		    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_12[@name='CURRENCY_DETAILS']"/>
		    <!--MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 BEGIN -->
		    <!-- The function focus first should be called on the tab selection -->
		    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
		    <!--MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 END -->
  	</xsl:call-template>

   	<!--Currency Table Template: Start-->

    	<table bgcolor = "ffffff" align="center" border = "0"  cellspacing="0" cellpadding="2" width="100%">
    	 <!-- Tracker Id 92380 -->
    	 <tr align="left">
    	     <td>
    	      <xsl:call-template name="user_button_withText">
    		<xsl:with-param name="button_name">ADD_CURRENCYDET</xsl:with-param>
    		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_12[@name='ADD_CURRENCYDET']/@configLabel"/></xsl:with-param>
    		<xsl:with-param name="button_fnc">addCurrencyDet()</xsl:with-param>
    		</xsl:call-template>&#160;

          <xsl:call-template name="user_button_withText">
          <xsl:with-param name="button_name">REMOVE_CURRENCYDET</xsl:with-param>
		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_12[@name='REMOVE_CURRENCYDET']/@configLabel"/></xsl:with-param>
    		<xsl:with-param name="button_fnc">removeCurrencyDet()</xsl:with-param>
    		</xsl:call-template>
    	     </td>
    	  </tr>

    	</table>

    	  <xsl:call-template name="mainbody">
    	  <xsl:with-param name="tablename">CurrencyDetRecordSet</xsl:with-param>
    		<xsl:with-param name="tableHeader">Currency Details</xsl:with-param>
    		<xsl:with-param name="align">Center</xsl:with-param>
    	  <xsl:with-param name="width">100%</xsl:with-param>

          <!-- Manupulation for the table representation : Start-->

    	<xsl:with-param name="IsInnerComposite">true</xsl:with-param>

          <!-- Manupulation for the table representation : End-->

    	  <xsl:with-param name="UsrDataSpace">CurrencyDetInfo</xsl:with-param>
    	  <xsl:with-param name="button">true</xsl:with-param>
    	  <xsl:with-param name="name">...</xsl:with-param>
    	  <xsl:with-param name="jscriptfnc">,callCurrencyDet()</xsl:with-param>
    	  <xsl:with-param name="onClick">editCurrencyDet()</xsl:with-param>
    	  <xsl:with-param name="rowhighlight">true</xsl:with-param>
				<!-- changes for tracker id 355007 begin-->
    	  <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
				<!-- changes for tracker id 355007 ends-->
	  <xsl:with-param name="rsfilenm" select="$fileName_Currency"/>
    	  <xsl:with-param name="extra_colheader">Select</xsl:with-param>
    	  </xsl:call-template>
    	  <br></br>

    <xsl:call-template name="EndTabPage"/>

    <!--Currency Table Template : End-->

         <!-- CIF Changes: Currency Details :End-->




           <!-- Currency Changes:Start DataArray  -->

          	   <script>



          		//CRM10.2 SPE Changes
          		var DataArray = new Array;
          		var DataCount = 0;

          		<!-- changes for ticket id 330755 starts -->
			<!-- currency information is taken from cached file PresCurrData for poulating the DataArray -->

			<xsl:for-each select="$PresCurrData/SRMComposite[@n='CurrencyRecordSet']/SRMRow">
          		<!-- changes end for ticket 330755  -->

          		    DataArray[DataCount] = '<xsl:value-of select="./Z[@n='CurrencyBO.CurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.Format']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.NumberOfDecimals']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.MantissaSeperator']"/>'+"|"+'<xsl:value-of select="./Z[@n='CurrencyBO.DecimalSeperator']"/>';
          		    DataCount++;
          		</xsl:for-each>

          		var iCount = 0;
          		ExArray = new Array;
          		<xsl:for-each select="$PresExData/SRMData[@SRMDataSpace='ExRate']/SRMComposite[@n='ExRateRecordSet']/SRMRow">
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
           <!-- Currency Changes:End DataArray -->


<!-- TRACKER ID 321176 currency changes end -->



</xsl:when>
<xsl:otherwise>
<!-- changes for ticket 466328 -->
<!-- changes for call id 390769 -->
<!--<xsl:if test="not(normalize-space($byPassFlag)='Y')">-->
<!-- changes for ticket 466328 ends-->
<!-- changes for call id 390769 -->
   	<xsl:call-template name="BeginTabPage">
	    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
	    <xsl:with-param name="tabPageName">tpageCont</xsl:with-param>
	    <xsl:with-param name="spanWidth">4</xsl:with-param>
	    <xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
	    <!--MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 BEGIN -->
	    <!-- The function focus first should be called on the tab selection -->
	    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
	    <!--MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 END -->

	   <!-- TRACKER ID 321176 basic info changes start -->

	   	    	    <xsl:with-param name="tabPageDisplayNameRes">Basic Info.</xsl:with-param>

	   <!-- TRACKER ID 321176 basic info changes end -->

	</xsl:call-template>
	<xsl:call-template name="apply">
	     <xsl:with-param name="apply_head">
	     <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
	     </xsl:with-param>
	     <xsl:with-param name="priorityCode"><xsl:value-of select="$priorityCode"/>
	     </xsl:with-param>
        </xsl:call-template>
                 <!-- end of General  -->

<table width="100%" bgcolor='FFFFFF' cellspacing="0" vspace="0" hspace="0" border="0">
<!-- View : General Details :START -->
<!-- **********Tracker ID 113276 changes start here ******* -->

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.AccountKey"/>
<xsl:call-template name="End"/>

	 <xsl:call-template name="Begin"/>
	 	<xsl:call-template name="apply">
	 		<xsl:with-param name="apply_head">
	 		<b><xsl:value-of select="$configLabels[@name='PersonalDetails']/@configLabel"/></b><br/>
	 		</xsl:with-param>
	 		</xsl:call-template>
	 <xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Gender"/>
    <xsl:call-template name="AccountBO.Salutation"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Cust_Last_Name"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Cust_Middle_Name"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Cust_First_Name"/>
   <xsl:call-template name="AccountBO.short_name"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Name"/>
    <xsl:call-template name="AccountBO.strField6"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.nick_name"/>
    <xsl:call-template name="AccountBO.Cust_DOB"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.CustomerMinor"/>
    <xsl:call-template name="AccountBO.MinorAttainMajorDate"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.PlaceOfBirth"/>
    <!-- <xsl:call-template name="AccountBO.Nationality"/> -->
<xsl:call-template name="End"/>

<!-- Senior Citizen Starts-->
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.SeniorCitizen"/>
    <xsl:call-template name="AccountBO.SenCitizenApplicableDate"/>
<xsl:call-template name="End"/>
<!-- Senior Citizen Ends-->

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.MaidenNameOfMother"/>
    <xsl:call-template name="AccountBO.Primary_sol_id"/>
<xsl:call-template name="End"/>

<!-- ticket 214549 changes start -->
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Cust_Type"/>
 	<xsl:call-template name="AccountBO.status"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Segmentation_Class"/>
    <xsl:call-template name="AccountBO.SubSegment"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.ChargeLevelCode"/>
    <xsl:call-template name="AccountBO.RatingDate"/>
<xsl:call-template name="End"/>
<!-- ticket 214549 changes end -->

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Cust_hlth"/>
    <xsl:call-template name="AccountBO.priorityCode"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Physical_State"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Cust_Swift_Code_Desc"/>
    <xsl:call-template name="AccountBO.Is_Swift_Code_Of_Bank"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Offline_cum_debit_limit"/>
    <xsl:call-template name="AccountBO.Cust_community"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Rating"/>
    <xsl:call-template name="AccountBO.Pref_code"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Sector"/>
    <xsl:call-template name="AccountBO.Subsector"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountBO.TFPartyFlag"/>
	<xsl:call-template name="AccountBO.Secure_id"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.RiskProfileScore"/>
    <xsl:call-template name="AccountBO.RiskProfileExpiryDate"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
<xsl:call-template name="AccountBO.CreditBureauScore"/>
<xsl:call-template name="AccountBO.creditScoreRequestedFlag"/>
<xsl:call-template name="End"/>

<!-- Changes for KYC Enhancement Start-->

<xsl:call-template name="Begin"/>
<xsl:call-template name="AccountBO.riskRating"/>
<xsl:call-template name="AccountBO.KYC_Date"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.KYC_ReviewDate"/>
    <xsl:call-template name="AccountBO.submitForKYC"/>
<xsl:call-template name="End"/>

<!-- Changes for KYC Enhancement Ends-->


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.region"/>
    <xsl:call-template name="AccountBO.Constitution_Code"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.CustomerNREFlg"/>
    <xsl:call-template name="AccountBO.DateOfBecomingNRE"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>

     <xsl:call-template name="AccountBO.StaffFlag"/>
    <xsl:call-template name="AccountBO.StaffEmployeeID"/>
<xsl:call-template name="End"/>

 <xsl:choose>
    <xsl:when test= "not(normalize-space($accountURL)='')">
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.OldEntityType"/>
    <xsl:call-template name="AccountBO.converted_Date"/>
<xsl:call-template name="End"/>
</xsl:when>
    </xsl:choose>


<!-- <xsl:call-template name="Begin"/>

    <xsl:call-template name="AccountBO.DSA_ID"/>
<xsl:call-template name="End"/> -->



<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.PurgeRemarks"/>
    <xsl:call-template name="AccountBO.DelinquencyFlg"/>
<xsl:call-template name="End"/>


    <xsl:choose>
    <xsl:when test= "not(normalize-space($accountURL)='')">
     <xsl:call-template name="Begin"/>
     	<xsl:call-template name="LastUpdateDate"/>
    <xsl:call-template name="End"/>
    </xsl:when>
    </xsl:choose>


<xsl:call-template name="Begin"/>
	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head">
		<b><xsl:value-of select="$configLabels[@name='EBanking']/@configLabel"/></b><br/>
		</xsl:with-param>
		</xsl:call-template>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="AccountBO.IsEbankingEnabled"/>
<td class='d1' align='center' style='TEXT-ALIGN: right;'><xsl:value-of select="$configLabels[@name='AccountBO.IsWAPBankingEnabled']/@configLabel"/></td>
<td class='d1' align='center' style='TEXT-ALIGN: left;'><xsl:call-template name="AccountBO.IsWAPBankingEnabled"/></td>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
<td class='d1' align='center' style='TEXT-ALIGN: right;'><xsl:value-of select="$configLabels[@name='AccountBO.IsSMSBankingEnabled']/@configLabel"/></td>
<td class='d1' align='center' style='TEXT-ALIGN: left;'><xsl:call-template name="AccountBO.IsSMSBankingEnabled"/></td>
<xsl:call-template name="AccountBO.SMSBankingMobileNumber"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
	 	<xsl:call-template name="apply">
	 	<xsl:with-param name="apply_head">
	 	<b><xsl:value-of select="$configLabels[@name='RelationshipManagerDetails']/@configLabel"/></b><br/>
	 	</xsl:with-param>
	 	</xsl:call-template>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountBO.Manager"/>
	<xsl:call-template name="AccountBO.SecondaryRM_ID"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.RelationshipOpeningDate"/>
    <xsl:call-template name="AccountBO.RelationshipCreatedByID"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.relationship_level"/>
    <xsl:call-template name="AccountBO.lead_source"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
	 	<xsl:call-template name="apply">
	 	<xsl:with-param name="apply_head">
	 	<b><xsl:value-of select="$configLabels[@name='LanguagePreference']/@configLabel"/></b><br/>
	 	</xsl:with-param>
	 	</xsl:call-template>
 <xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.NativeLangCode"/>
    <xsl:call-template name="AccountBO.NativeLangTitle"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.NativeLangName"/>
    <xsl:call-template name="AccountBO.Cust_Language"/>
<xsl:call-template name="End"/>

<DIV ID = 'native' STYLE= 'visibility:visible;'>



		<TR ID='rownative' name='rownative'>
			<xsl:call-template name="AccountBO.Cust_First_Name_Native">
				   <xsl:with-param name="ele_name">AccountBO.Cust_First_Name_Native</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="AccountBO.Cust_Middle_Name_Native">
				   <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_Native</xsl:with-param>
			</xsl:call-template>
		</TR>
		<TR ID='rownative' name='rownative'>
			<xsl:call-template name="AccountBO.Cust_Last_Name_Native">
				   <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_Native</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="AccountBO.Short_Name_Native">
				   <xsl:with-param name="ele_name">AccountBO.Short_Name_Native</xsl:with-param>
			</xsl:call-template>
		</TR>



	</DIV>

<!-- Tracker 148370 -->


<DIV ID = 'native' STYLE= 'visibility:visible;'>
			<xsl:call-template name="Begin"/>
				<xsl:call-template name="AccountBO.Cust_Last_Name_Native1">
					  <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_Native1</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="AccountBO.Cust_Middle_Name_Native1">
					   <xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_Native1</xsl:with-param>
				</xsl:call-template>
			<xsl:call-template name="End"/>

			<xsl:call-template name="Begin"/>
				<xsl:call-template name="AccountBO.Cust_First_Name_Native1">
					   <xsl:with-param name="ele_name">AccountBO.Cust_First_Name_Native1</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="AccountBO.Short_Name_Native1">
					   <xsl:with-param name="ele_name">AccountBO.Short_Name_Native1</xsl:with-param>
				</xsl:call-template>
			<xsl:call-template name="End"/>

</DIV>

<!-- Tracker 148370 -->
<!--Access Control Changes Begins -->

	<xsl:call-template name="apply">
		 <xsl:with-param name="apply_head">
		  <b><xsl:value-of select="$configLabels[@name='AccessControl']/@configLabel"/></b>
		  </xsl:with-param>
	</xsl:call-template>


	<xsl:call-template name="Begin"/>
		<xsl:call-template name="AccountBO.accessOwnerGroup"/>
		<xsl:call-template name="AccountBO.accessOwnerBC"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountBO.accessOwnerSegment"/>

	<xsl:call-template name="End"/>

<!--Access Control Changes Ends -->

<!-- ************************************************************************************************************************
*************************************************************************************************************************
************************************************************************************************************************ -->

<!-- Commented as these need to be removed from UI : Sumit -->
<!-- <xsl:call-template name="Begin"/>

    <xsl:call-template name="AccountBO.NameSuffix"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.maidenName"/>
    <xsl:call-template name="AccountBO.previous_name"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.short_name"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.PreferredName"/>

<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.spouseID"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.CountryOfBirth"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.ProofOfAgeFlag"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.ProofOfAgeDocument"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>

    <xsl:call-template name="AccountBO.strField7"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.mother_name"/>

<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Groupid"/>

<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.father_husband_name"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.RelationshipValue"/>
    <xsl:call-template name="AccountBO.NumberOfProducts"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>

    <xsl:call-template name="AccountBO.relationship_type"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.preferredChannelID"/>
    <xsl:call-template name="AccountBO.status"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountBO.TertiaryRM_ID"/>

<xsl:call-template name="End"/>



<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.AutoApproval"/>
    <xsl:call-template name="AccountBO.FreezeProductSale"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.revenueUnits"/>
    <xsl:call-template name="AccountBO.customerProfitability"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.currentCrExposure"/>
    <xsl:call-template name="AccountBO.totalCrExposure"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.potentialCrLine"/>
    <xsl:call-template name="AccountBO.availableCrLimit"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Alert1"/>
    <xsl:call-template name="AccountBO.Alert2"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>

    <xsl:call-template name="AccountBO.creditHistoryRequestedFlag"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.strfield1"/>
    <xsl:call-template name="AccountBO.strfield2"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.strfield3"/>
    <xsl:call-template name="AccountBO.strfield4"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.strfield5"/>
    <xsl:call-template name="AccountBO.DtDate1"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.DtDate2"/>
    <xsl:call-template name="AccountBO.DtDate3"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.dtDate6"/>
    <xsl:call-template name="AccountBO.userFlag1"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.userFlag2"/>
    <xsl:call-template name="AccountBO.userFlag3"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.userFlag4"/>
    <xsl:call-template name="AccountBO.Cust_Staff_Status"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.CIN"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <td class='d1' align='left' valign ="top" ><xsl:value-of select="$configLabels[@name='AccountBO.card_holder']/@configLabel"/></td>
    <td class='d1' align='left' valign ="top" style='TEXT-ALIGN: left;padding-left:0px;'><xsl:call-template name="CardHolderFlag"/></td>
    <xsl:call-template name="AccountBO.notes"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
   Naved Fix <xsl:call-template name="AccountBO.primary_service_centre"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>

     <xsl:call-template name="AccountBO.rm_group_id"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.DSA_ID"/>
    <xsl:call-template name="AccountBO.photograph_id"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Tds_cust_id"/>
    <xsl:call-template name="AccountBO.Tds_tbl"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.Crncy_code"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>

    <xsl:call-template name="AccountBO.RatingDate"/>
    <xsl:call-template name="AccountBO.ManagerOpinion"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
    <xsl:call-template name="AccountBO.CustStatusChgDate"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>

    <xsl:call-template name="AccountBO.NREBecomingOrdDate"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountBO.PurgeFlag"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
 <td class='d1' align='center' style='TEXT-ALIGN: right;'><xsl:value-of select="$configLabels[@name='AccountBO.PurgeFlag']/@configLabel"/></td>
<td class='d1' align='center' style='TEXT-ALIGN: left;'><xsl:call-template name="PurgeFlag"/></td>

<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
<td class='d1' align='center'><xsl:value-of select="$configLabels[@name='AccountBO.Document_Received']/@configLabel"/></td>
<td class='d1' align='center' style='TEXT-ALIGN: left;padding-left:0px'><xsl:call-template name="Document_Received"/></td>

<xsl:call-template name="End"/>


<xsl:choose>
<xsl:when test= "not(normalize-space($accountURL)='')">
<xsl:call-template name="Begin"/>
	<xsl:call-template name="Signature"/>
<xsl:call-template name="End"/>
</xsl:when>
</xsl:choose>


<xsl:choose>
<xsl:when test= "not(normalize-space($accountURL)='')">
<xsl:call-template name="Begin"/>
	<xsl:call-template name="CRV"/>
<xsl:call-template name="End"/>
</xsl:when>
</xsl:choose>

<xsl:choose>
<xsl:when test= "not(normalize-space($accountURL)='')">
<xsl:call-template name="Begin"/>
	<xsl:call-template name="HCCFM"/>
<xsl:call-template name="End"/>
</xsl:when>
</xsl:choose>
<xsl:choose>
<xsl:when test= "not(normalize-space($accountURL)='')">
<xsl:call-template name="Begin"/>
	<xsl:call-template name="MEMOPAD"/>
<xsl:call-template name="End"/>
</xsl:when>
</xsl:choose> -->

<!-- Commented as these need to be removed from UI : Sumit -->

<!-- Changes made by Sumit : Start -->

<!--Native Language Changes:start-->
 	<xsl:variable name="NATIVE"><xsl:value-of select="$configLabels[@name='NativeLanguageFields']/@configLabel"/></xsl:variable>
<!-- CRM102ST: Tracker ID:182172 Begin of Change -->
	<TR style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rownative2" name="rownative2">
	    <xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
	    <TD onclick="Toggle('native','all');" colspan="9" NOWRAP="true" class="LabelFont">
	        <A HREF="javascript:Toggle('native','all');"><IMG onclick="Toggle('native','all');" SRC="../reports/images/minus.gif" ID="nativegif"
	        BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	        <label FOR="CPD" class="LabelFont"><xsl:value-of select="$NATIVE"/> </label>
	    </TD>
	</TR>
<!-- CRM102ST: Tracker ID:182172 End of Change -->


<DIV ID = 'native' STYLE= 'visibility:visible;'>
<TR ID='rownative' name='rownative'>
</TR>
<TR ID='rownative' name='rownative'>
<xsl:call-template name="RelationshipBO.ChildEntityType">
		  <xsl:with-param name="ele_name">RelationshipBO.ChildEntityType</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="RelationshipBO.Bank_Entity1">
		  <xsl:with-param name="ele_name">RelationshipBO.Bank_Entity1</xsl:with-param>
</xsl:call-template>
</TR>
<TR ID='rownative' name='rownative'>
<xsl:call-template name="RelationshipBO.Bank_Entity_Name1">
		  <xsl:with-param name="ele_name">RelationshipBO.Bank_Entity_Name1</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="AccountBO.Introd_Status">
		  <xsl:with-param name="ele_name">AccountBO.Introd_Status</xsl:with-param>
</xsl:call-template>
</TR>
<TR ID='rownative' name='rownative'>
<xsl:call-template name="AccountBO.IntroducerSalutation">
		  <xsl:with-param name="ele_name">AccountBO.IntroducerSalutation</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="AccountBO.IntroducerID">
		  <xsl:with-param name="ele_name">AccountBO.IntroducerID</xsl:with-param>
</xsl:call-template>
</TR>
<TR ID='rownative' name='rownative'>
<xsl:call-template name="AccountBO.IntroducerName">
		  <xsl:with-param name="ele_name">AccountBO.IntroducerName</xsl:with-param>
</xsl:call-template>
<!--Equity bank adding new field for non cif introducer name TOI 360106-->
<xsl:call-template name="AccountBO.StrUserField21">
		  <xsl:with-param name="ele_name">AccountBO.StrUserField21</xsl:with-param>
</xsl:call-template>
<!--Equity bank adding new field for non cif introducer name TOI 360106-->
</TR>
<!--Equity bank adding new field for non cif introducer name TOI 356581-->
<TR ID='rownative' name='rownative'>
<xsl:call-template name="AccountBO.StrUserField22">
		  <xsl:with-param name="ele_name">AccountBO.StrUserField22</xsl:with-param>
</xsl:call-template>
</TR>
<!--Equity bank adding new field for non cif introducer name TOI 356581-->
</DIV>







	        <tr></tr>

<!--Native Language Changes:end-->
<!-- <table width="100%" bgcolor='ffffff' cellspacing="0" vspace="15" hspace="0" border="0" align = "center">
	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head">
		<b><xsl:value-of select="$configLabels[@name='MLHeader']/@configLabel"/></b><br/>
		</xsl:with-param>
		</xsl:call-template>
<TR >

		<TD nowrap="true" align="left" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='Available_BackendID']/@configLabel"/></TD>
		<TD style="width:22%">
			<xsl:call-template name="Assigned_BackendID"/>
		</TD>
		<TD width="5%" align="center">
			<input class='frmBttnsAddRmv' Type='button' value='&gt;&gt;'
			onclick="selfield(Assigned_BackendID,Available_BackendID, false)"/><BR/>
			<input class='frmBttnsAddRmv' Type='button' value='&lt;&lt;'
			onclick="selfield(Available_BackendID, Assigned_BackendID, true)"/>
			</TD>
		<TD  nowrap="true" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='Assigned_BackendID']/@configLabel"/></TD>
		<TD>
			<xsl:call-template name="Available_BackendID"/>
		</TD>

	</TR>

</table> -->

<!--CIF Changes - BackEnd Changes Ends -->
<!-- Changes made by Sumit : End -->
	</table>
<xsl:call-template name="EndTabPage"/>
<!-- changes for ticket 466328 -->
<!-- change for call id 390769 start -->
<!-- </xsl:if> -->
<!-- change for call id 390769 end -->
<!-- changes for ticket 466328 ends-->
</xsl:otherwise>
</xsl:choose>
<xsl:choose>
<xsl:when test= "not(normalize-space($byPassFlag)='Y')">
<!--CoreInterface Details:start-->
<xsl:call-template name="BeginTabView">
	    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
	    <xsl:with-param name="tabPageHeight">380</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="BeginTabPage">
    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
    <xsl:with-param name="tabPageName">tpageCore</xsl:with-param>
    <xsl:with-param name="spanWidth">3</xsl:with-param>
    <xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
    <xsl:with-param name="tabPageDisplayNameRes">CoreInterface</xsl:with-param>
    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
</xsl:call-template>
	<xsl:call-template name="apply1">
	     <xsl:with-param name="apply_head">
	     Core Interface Details
	     </xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="Begin"/>
	<!-- Tracker ID 113276 Changes Start -->

	    <xsl:call-template name="CoreInterfaceBO.OfflineCumDebitLimit"/>

	<!-- Tracker ID 113276 Changes End -->
	    <xsl:call-template name="CoreInterfaceBO.CustLevelChargesAcct"/>

	<!-- Tracker ID 113276 Changes Start -->
	 <!-- Uncommenting the following lines for CallId 367941 --> 
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	<!-- Changes done for CallId 367941 End -->
	<!-- Tracker ID 113276 Changes End -->
	    <xsl:call-template name="CoreInterfaceBO.SourceOfIncome"/>
	<!-- Tracker ID 113276 Changes Start -->
		 <!-- Uncommenting the following lines for CallId 367941 --> 
	    <xsl:call-template name="CoreInterfaceBO.FreeCode1Desc"/>
	         <!-- Changes done for CallId 367941 End -->
	<!-- Tracker ID 113276 Changes End -->
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
	<!-- Tracker ID 113276 Changes Start -->
	 <!-- Uncommenting the following lines for CallId 367941 -->
	   <xsl:call-template name="CoreInterfaceBO.FreeCode2Desc"/>
	    <xsl:call-template name="CoreInterfaceBO.FreeCode3Desc"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="CoreInterfaceBO.FreeCode4Desc"/>
	    <xsl:call-template name="CoreInterfaceBO.FreeCode5Desc"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="CoreInterfaceBO.FreeCode6Desc"/>
	    <xsl:call-template name="CoreInterfaceBO.FreeCode7Desc"/>

	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="CoreInterfaceBO.FreeCode8Desc"/>
	    <xsl:call-template name="CoreInterfaceBO.FreeCode9Desc"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="CoreInterfaceBO.FreeCode10Desc"/> 
	 <!-- Changes done for CallId 367941 End -->
	<!-- Tracker ID 113276 Changes End -->
	<xsl:call-template name="CoreInterfaceBO.Cust_free_text"/>
	<!-- Tracker ID 113276 Changes Start -->
	 <!-- Uncommenting the following lines for CallId 367941 -->
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_1"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_2"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_3"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_4"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_5"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_6"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_7"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_8"/>

	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_9"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_10"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>

	    <xsl:call-template name="CoreInterfaceBO.Free_text_11"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_12"/>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_13"/>
	    <xsl:call-template name="CoreInterfaceBO.Free_text_14"/>
	<xsl:call-template name="End"/>
	 <!-- Changes done for CallId 367941 End -->
	<!-- Tracker ID 113276 Changes End -->
	<!--TRACKER ID : 78376 : BEGIN OF CHANGES-->
	<!-- Tracker ID 113276 Changes Start -->
	 <!-- Uncommenting the following lines for CallId 367941 -->
	<xsl:call-template name="Begin"/>
	   <!-- <xsl:call-template name="CoreInterfaceBO.PrimarySolID"/>-->
	    <xsl:call-template name="CoreInterfaceBO.Free_text_15"/> 
	 <!-- Changes done for CallId 367941 End -->
	<!-- Tracker ID 113276 Changes End -->
	    <!-- Changes For Ticketid:-286305 Begin
      		PrefCode been removed from coreinterface tab-->
	    <!--<xsl:call-template name="CoreInterfaceBO.PrefCode"/>-->
	    <!-- Changes For Ticketid:-286305 End -->
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	    <xsl:call-template name="CoreInterfaceBO.TreasuryCounterParty"/>
	    <xsl:call-template name="CoreInterfaceBO.TreasuryCounterPartyMne"/>

	<xsl:call-template name="End"/>
	<!--TRACKER ID : 78376 :END OF CHANGES-->


<xsl:call-template name="EndTabPage"/>
</xsl:when>
</xsl:choose>
<!--CoreInterface Details:end-->
<xsl:choose>
<xsl:when test= "not(normalize-space($byPassFlag)='Y')">
<xsl:call-template name="BeginTabView">
	    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
	    <xsl:with-param name="tabPageHeight">200</xsl:with-param>
</xsl:call-template>
<!-- House hold CIF changes : Begin by Naved-->
	                <xsl:call-template name="BeginTabPage">
					<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
					<xsl:with-param name="tabPageName">tpageHouseHolds</xsl:with-param>
					<xsl:with-param name="spanWidth">3</xsl:with-param>
					<xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
					<xsl:with-param name="tabPageDisplayNameRes">HouseHold</xsl:with-param>
					<xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
			</xsl:call-template>
			<tr><td>
			<table bgcolor="FFFFFF" align="center" cellpadding="2" width="100%">
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
		<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='HouseHold Details']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="align">center</xsl:with-param>
		<xsl:with-param name="button">false</xsl:with-param>
		<xsl:with-param name="width">100%</xsl:with-param>
		<xsl:with-param name="name">...</xsl:with-param>
		<xsl:with-param name="UsrDataSpace">HouseHold</xsl:with-param>
		<xsl:with-param name="rowhighlight">true</xsl:with-param>
	    <xsl:with-param name="rsfilenm" select="$fileName"/>
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
</xsl:when>
</xsl:choose>
<!-- House hold CIF changes : End by Naved-->
<!-- CRM101UB changes : start -->
<xsl:choose>
<xsl:when test= "not(normalize-space($byPassFlag)='Y')">
<xsl:call-template name="BeginTabView">
	    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
	    <xsl:with-param name="tabPageHeight">295</xsl:with-param>
	</xsl:call-template>
			<xsl:call-template name="BeginTabPage">
					<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
					<xsl:with-param name="tabPageName">tpageGroups</xsl:with-param>
					<xsl:with-param name="spanWidth">3</xsl:with-param>
					<xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
					<xsl:with-param name="tabPageDisplayNameRes">Group Details</xsl:with-param>
					<xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="apply">
		     <xsl:with-param name="apply_head">
		     <b><xsl:value-of select="$configLabels_1[@name='Related Companies']/@configLabel"/></b>
		     </xsl:with-param>
			</xsl:call-template>

			<tr><td>
<!--Changes for call id:425507 and recon of call id 413599 starts-->
<!-- Removed for call id:413958 and recon of call id 411963 starts-->
<!-- Change for Ticket id 775774 starts-->
			<xsl:if test="$allowMulti='Y'">
<!-- Change for Ticket id 775774 ends-->
			<!--Changes for call id:425507 and recon of call id 413599 ends-->
	    <table align="center" bgcolor="ffffff" cellpadding="2" condition="$allowMulti='Y'" endlogic="if" logic="if" width="100%">
			<tr align="left">
			<td >
			<!-- 10.6 enhancements <xsl:call-template name="user_button_withText">
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
<!--Removed for call id:425507 and recon of call id 413599 -->
<!-- Removed for call id:413958 and recon of call id 411963 -->
<!-- Change for Ticket id 775774 starts-->
	</xsl:if>
<!-- Change for Ticket id 775774 ends-->
	<xsl:if test="$allowMulti='N'">
		<xsl:call-template name="AccountBO.GroupHouseHold.GROUP_ID" />
	</xsl:if>
	</td></tr>
<xsl:call-template name="EndTabPage"/>
</xsl:when>
</xsl:choose>
<!-- CRM101UB changes : end -->
<!-- FATCA Changes for Template calling Begin -->



<xsl:choose>
<xsl:when test= "not(normalize-space($byPassFlag)='Y')">
<xsl:call-template name="BeginTabView">
	    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
	    <xsl:with-param name="tabPageHeight">295</xsl:with-param>
	</xsl:call-template>
			        <xsl:call-template name="BeginTabPage">
					<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
					<xsl:with-param name="tabPageName">tpagefatca</xsl:with-param>
					<xsl:with-param name="spanWidth">4</xsl:with-param>
					<xsl:with-param name="isTabNameHardCoded">false</xsl:with-param>
					<!-- <xsl:with-param name="tabPageDisplayNameRes">HouseHold</xsl:with-param> -->
					<xsl:with-param name="tabPageDisplayNameRes" select="$configLabels[@name='TaxCertificationDetails']"/>			
					<xsl:with-param name="fn_tabSelect">focusFirstFatcaField();</xsl:with-param>
	</xsl:call-template>



<tr>

		<td>
			<xsl:call-template name="apply">
		     <xsl:with-param name="apply_head">
		     <b><xsl:value-of select="$configLabels[@name='TaxCertificationDetails']/@configLabel"/></b>
		     </xsl:with-param>
			</xsl:call-template>
		</td>
</tr>

<tr><td></td></tr>
<tr>

		<td>
			<xsl:call-template name="AccountBO.ForeignAccTaxReportingReq"/>
	   </td>
	   
	   <td>
	   		<xsl:call-template name="AccountBO.ForeignTaxReportingCountry"/>
	   </td>
	   	   
	   
</tr>
<tr>


		<td>
			<xsl:call-template name="AccountBO.ForeignTaxReportingStatus"/>
	   </td>
	   
	   
	 
	   
	   
	   
	   
	   <td>
	   		<xsl:call-template name="AccountBO.LastForeignTaxReviewDate"/>
	   </td>
</tr>
<tr>

		<td>
		<xsl:call-template name="AccountBO.NextForeignTaxReviewDate"/>
		</td>
		<td>
		
			<xsl:call-template name="AccountBO.FatcaRemarks"/>
	   </td>

</tr>

<xsl:call-template name="EndTabPage"/>
</xsl:when>
</xsl:choose>



<!-- FATCA Changes Ends -->
<xsl:choose>
<xsl:when test= "not(normalize-space($byPassFlag)='Y')">
	                <xsl:call-template name="BeginTabPage">
			    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
			    <xsl:with-param name="tabPageName">tpageCont2</xsl:with-param>
			    <xsl:with-param name="spanWidth">3</xsl:with-param>
			    <xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
			    <xsl:with-param name="tabPageDisplayNameRes">Minor</xsl:with-param>
	                </xsl:call-template>

	              	<xsl:call-template name="apply">
			     <xsl:with-param name="apply_head">
			     <b><xsl:value-of select="$configLabels[@name='MLHeader2']/@configLabel"/></b><br/>
			     </xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="Begin"/>
			    <xsl:call-template name="RelationshipBO.Bank_Entity"/>
			    <!-- ticket id: 330818 changes begin -->
                <xsl:call-template name="ContactBO.lastName"/>
			    <!--<xsl:call-template name="RelationshipBO.Bank_Entity_Name"/>-->
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
			    <xsl:call-template name="RelationshipBO.Relationship"/>
			    <xsl:call-template name="ContactBO.salutation"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
			    <xsl:call-template name="ContactBO.firstName"/>
			    <xsl:call-template name="ContactBO.middleName"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
			    <xsl:call-template name="ContactBO.gender"/>
			    <xsl:call-template name="ContactBO.DOB"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
			    <xsl:call-template name="RelationshipBO.Guard_Code"/>
			  <!-- ticket id: 330818 changes end -->
			    <xsl:call-template name="ContactBO.contactsKey"/>
			<xsl:call-template name="End"/>
<!--Native Language Changes:start-->
<!--Tracker 148592:start of changes-->
<!--
<xsl:variable name="NMINOR"><xsl:value-of select="$configLabels[@name='NativeLanguageFields']/@configLabel"/></xsl:variable>
<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
	<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="row{$NMINOR}" name="row{$NMINOR}">
	<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
	<td onclick="Toggle_Address('nminor');" colspan = "2" NOWRAP="true" class="LabelFont">
	     <A HREF="javascript:Toggle_Address('nminor');"><IMG onclick="Toggle_Address('nminor');" SRC="../reports/images/minus.gif" ID="nminorgif"
	      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$NMINOR"/>
	     </label>
	</td>
	</tr>
</table>
<DIV ID = 'nminor' STYLE= 'visibility:visible;'>

 <table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

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
</DIV>-->
<!--Tracker 148592:end of changes-->
<!--Native Language Changes:end-->

				<!--Tracker ID : 223255, Changes Begins-->
<xsl:variable name="NMINOR">Details in Preferred Language<xsl:value-of select="$configLabels[@name='Details in Preferred Language']/@configLabel"/></xsl:variable>
<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
	<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="row{$NMINOR}" name="row{$NMINOR}">
	<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
	<td onclick="Toggle_Address('nminor');" colspan = "2" NOWRAP="true" class="LabelFont">
	     <A HREF="javascript:Toggle_Address('nminor');"><IMG onclick="Toggle_Address('nminor');" SRC="../reports/images/minus.gif" ID="nminorgif"
	      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$NMINOR"/>
	     </label>
	</td>
	</tr>
</table>
<DIV ID = 'nminor' STYLE= 'visibility:visible;'>

 <table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

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
				<!--Tracker ID : 223255, Changes Ends-->
<!--Tracker id 113227 starts -->
<xsl:choose>
	<xsl:when test="normalize-space($altLocaleActv)='true'">
	<!--Native Language Changes:start-->
	<!-- Tracker ID: 163446  changes Begin -->
	<!--Changes begin for ticket id# 328581-->
	<xsl:variable name="NMINOR1">Details in Alternate Language</xsl:variable>

	<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
		<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rownminor1" name="rownminor1">
			<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
		<td onclick="Toggle('nminor1','all');" colspan = "5" NOWRAP="true" class="LabelFont">
		     <A HREF="javascript:Toggle('NMINOR1','all');"><IMG onclick="Toggle('nminor1','all');" SRC="../reports/images/minus.gif" ID="nminor1gif"
		      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
	     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$NMINOR1"/>
	     <!--Changes end for ticket id# 328581-->

	     <!-- Tracker ID: 163446  changes End -->
		     </label>
		</td>
		</tr>
		</table>

	<DIV ID = 'native' STYLE= 'visibility:visible;'>

	 <table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

	<TR ID='rownminor1' name='rownminor1'>
		<xsl:call-template name="ContactBO.lastName_alt1">
			   <xsl:with-param name="ele_name">Contact.lastName_alt1</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ContactBO.firstName_alt1">
					   <xsl:with-param name="ele_name">ContactBO.firstName_alt1</xsl:with-param>
		</xsl:call-template>
	</TR>
	<TR ID='rownminor1' name='rownminor1'>
		<xsl:call-template name="ContactBO.middleName_alt1">
					   <xsl:with-param name="ele_name">ContactBO.middleName_alt1</xsl:with-param>
		</xsl:call-template>
	</TR>
 </table>

</DIV>
 </xsl:when>

  </xsl:choose>

<!--Native Language Changes:end-->

<!--Tracker id 113227 ends -->

<!--
<table width="100%" bgcolor='FFFFFF' cellspacing="0" vspace="0" hspace="0" border="0">


	<xsl:call-template name="apply">
		 <xsl:with-param name="apply_head">
		  <b><xsl:value-of select="$configLabels[@name='AccessControl']/@configLabel"/></b>
		  </xsl:with-param>
	</xsl:call-template>



	<xsl:call-template name="Begin"/>
		<xsl:call-template name="AccountBO.accessOwnerGroup"/>
	<xsl:call-template name="End"/>



	<xsl:call-template name="Begin"/>
		<xsl:call-template name="AccountBO.accessOwnerSegment"/>
	<xsl:call-template name="End"/>



	<xsl:call-template name="Begin"/>
		<xsl:call-template name="AccountBO.accessOwnerBC"/>
	<xsl:call-template name="End"/>


</table>
-->

	                <xsl:call-template name="EndTabPage"/>

</xsl:when>
</xsl:choose>
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
		<xsl:with-param name="selectedTabPageName">tpageCont1</xsl:with-param>
	    </xsl:call-template>
</xsl:otherwise>
</xsl:choose>
<!-- View : General Details :END -->
<!-- commented for removal of address fields
<table width="100%" bgcolor='FFFFFF' cellspacing="0" vspace="0" hspace="0" border="0">
    <xsl:call-template name="Account_Address"/>
</table>
<table width="100%" bgcolor='FFFFFF' cellspacing="0" vspace="0" hspace="0" border="0">
    <xsl:call-template name="MultiLinugalDetails"/>
</table>
-->
    <script>
        var DataCount = 0;
        <xsl:for-each select="/SRM/SRMData[@SRMDataSpace='Currency']/SRMComposite[@n='CurrencyRecordSet']/SRMRow">
            DataArray[DataCount] = '<xsl:value-of select="./Z[@n='CurrencyBO.CurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.Format']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.NumberOfDecimals']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.MantissaSeperator']"/>'+"|"+'<xsl:value-of select="./Z[@n='CurrencyBO.DecimalSeperator']"/>';
            DataCount++;

        </xsl:for-each>

	/*Fix for Tracker #: SIDDHARTH Begins*/
	/*Fix for Tracker #: SIDDHARTH Ends*/
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
    </form>
    <!-- TrackerID:209607,CHANGES START -->
    <p id="myPar"></p>
    <!-- TrackerID:209607,CHANGES END -->
<!-- CRM101UB group changes start -->
    <form name="frm3"  method="post" action='../servlet/com.infy.cis.ui.admin.GroupHouseHoldForm?isPopup=Yes&amp;isLinked=Yes&amp;isEdit=Yes&amp;GroupHouseHoldFlag=G&amp;isNew=N&amp;details=null'>
		<input type="hidden" name="GroupName" value=""/>
	    	<input type="hidden" name="PercentShare" value=""/>
		<input type="hidden" name="GlobalRM" value=""/>
		<!-- Recon from CRM10301BSUPP-Listing changes-->
		<input type="hidden" name="SubScreen" value="Customer"/>
		<!-- Recon from CRM10301BSUPP-Listing changes-->		
		<input type="hidden" name="Name_Nat" value=""/>
		<input type="hidden" name="Group_ID" value=""/>
		<input type="hidden" name="Prim_Grp_ID" value=""/>
		<input type="hidden" name="readMode" value="{$readMode}"/>
	</form>
	 <!-- Change for tracker id 336884  start --> 
	   <form name="frmIdent" method="post">    <input name="dateofissue" type="hidden" value=""> 
	           </input>        <input name="validity_date" type="hidden" value=""> 
	           </input>        <input name="hidDocCode" type="hidden" value=""> 
	           </input>        <input name="hidDocDescr" type="hidden" value=""> 
	           </input>        <input name="hidDocTypeCode" type="hidden" value=""> 
	           </input>        <input name="hidDocTypeDescr" type="hidden" value=""> 
	           </input>        <input name="hidDocReceivedDate" type="hidden" value=""> 
	           </input>        <input name="hidDocRemarks" type="hidden" value=""> 
	           </input>        <input name="hidStatus" type="hidden" value=""> 
	           </input>        <input name="hidIsMandatory" type="hidden" value=""> 
	           </input>        <input name="hidScanRequired" type="hidden" value=""> 
	           </input>        <input name="placeofissue" type="hidden" value=""> 
	           </input>        <input name="placeofissue_cat" type="hidden" value=""> 
	           </input>        <input name="countryofissue" type="hidden" value=""> 
	           </input>        <input name="countryofissue_cat" type="hidden" value=""> 
	           </input>        <input name="hidIsDocumentVerified" type="hidden" value=""> 
	           </input>        <input name="hidIDIssuedOrg" type="hidden" value=""> 
	           </input>        <input name="hidEntityDocumentID" type="hidden" value=""> 
	           </input>        <input name="unique_id" type="hidden" value=""> 
	           </input>        <input name="identifier_type_Code" type="hidden" value=""> 
	           </input>        <input name="getMCRequired" type="hidden" value="{$getMCRequired}"> 
	           </input>        <input name="hidEntityDocumentBO_Name" type="hidden" value="{$entityDocumentBO_Name}"> 
	           </input>        <!--<input name="SavedSubmitted" type="hidden" value="{$SavedSubmitted}">       </input> --> 
	    
	   </form> 
	                   <!-- Change for tracker id 336884  end --> 
<!-- CRM101UB group changes end -->
                </xsl:template>
        <xsl:template match="SRM">
        <xsl:for-each select=".">
             <xsl:call-template name="startTable"/>
               <!-- COMMENTED FOR INCORPORATING MULTITAB CONCEPT
               <table bgcolor='FFFFFF' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
                    <tr>
                     <xsl:call-template name="apply">
                     <xsl:with-param name="apply_head">
                     <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
                     </xsl:with-param>
                     <xsl:with-param name="priorityCode"><xsl:value-of select="$priorityCode"/>
                     </xsl:with-param>
                     </xsl:call-template>
                    </tr>
                 </table>
                 -->
                <table bgcolor='FFFFFF' width="100%" border="0" cellspacing="0" cellpadding="0">
                  <xsl:apply-templates select="." mode="mode1"/>

                </table>

             <xsl:call-template name="endTable"/>
        </xsl:for-each>

        </xsl:template>
</xsl:stylesheet>











