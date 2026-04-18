<?xml version="1.0"?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <!--impoting variables wich hold the jvm properties-->
<!--IDENTIFICATION DOCUMENT CHANGES start changed to relative url-->
    <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
    <xsl:import href="../Renderer/common/display/CommonEntityDetails.xsl"/>
<!--IDENTIFICATION DOCUMENT CHANGES end-->
     <!--including file for label names-->
    <!-- <xsl:variable name="fileName">../Renderer/corpcif/resource/CorpListofModID_<xsl:value-of select="$locale"/>.xml</xsl:variable> -->
        <xsl:param name="locale"/>
            <!--tracker id 113227 starts-->
    <xsl:param name="altLocaleType"/>
    <xsl:param name="baseLocaleType"/>
    <xsl:param name="altLocaleActv"/>
        <!--tracker id 113227 ends-->
     <xsl:param name="fileName"/>
      <!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
                <xsl:param name="ALTCALENDAR_TYPE"/>
             <!--ERPBOCF1:TRACKER113259: STORAGE OF DATES :ENDOFCHANGES-->

     <xsl:variable name="fileNameID" select="$fileName"/>
     <xsl:variable name="configFileID" select="document(concat($fileName,''))"/>
     <xsl:variable name="configLabelsID" select="$configFileID/SRMBO/*"/>

   <!--  <xsl:variable name="fileName1">../Renderer/corpcif/resource/CorpListofModAddress_<xsl:value-of select="$locale"/>.xml</xsl:variable> -->
     <xsl:param name="fileName1"/>
     <xsl:variable name="fileNameAdr" select="$fileName1"/>
     <xsl:param name="fileName2"/>
     <xsl:variable name="fileNameIntro" select="$fileName2"/>
     <xsl:param name="fileName3"/>
     <xsl:variable name="fileNameGrp" select="$fileName3"/>
     <!-- CIF PhoneEmail Changes : Start -->
     <xsl:param name="filePhoneEmail"/>
     <xsl:variable name="fileNamePhoneEmail" select="$filePhoneEmail"/>
     <!-- CIF PhoneEmail Changes : End -->
	<!--CORPCIF - Changes for the ticketid:374030 Starts Concession - Begin-->
	<xsl:param name="fileName_Concession"/>
	<xsl:variable name="fileName_concession" select="$fileName_Concession"/>
     <!-- Changes for the ticketid:374030 Ends -->
     
     <!-- Fix for ticket id 623612 start-->
     <xsl:variable name="HASHKEY" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='HASHKEY']"></xsl:variable>
     <xsl:variable name="KEYFIELD" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='FLDHASHKEY']"></xsl:variable>
    <!-- Fix for ticket id 623612 end-->

    <!-- vasanth's changes start -->

<!--    <xsl:variable name="BlackListed" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BlackListed']"></xsl:variable>
    <xsl:variable name="Suspended" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Suspended']"></xsl:variable>
    <xsl:variable name="Negated" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Negated']"></xsl:variable>
    -->
   <xsl:variable name="BlackListed" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.blacklist_Flag')]"></xsl:variable>
   <xsl:variable name="Suspended" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.suspend_Flag')]"></xsl:variable>
   <xsl:variable name="Negated" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.negative_Flag')]"></xsl:variable>
<!-- Changes for the ticketid:374030 Starts -->
<xsl:variable name="CurrencyAccList" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CurrencyAccList']"></xsl:variable>
<!-- Changes for the ticketid:374030 Ends -->
   <!-- TrackerId: 131246 Begin of Changes by neha_goel03
     Changes for User privelege access and Multi Entity -->
      <xsl:variable name="GcifIdAccess" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='GcifIdAccess']"></xsl:variable>
      <xsl:variable name="MultiEntity" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MultiEntity']"></xsl:variable>
      <xsl:variable name="GcifId" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n='CorporateBO.GCIFID']"></xsl:variable>
   <!--TrackerId: 131246 Changes end -->
  <xsl:variable name="chkBSN" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='chkBSN']"></xsl:variable>
    <xsl:variable name="IsDummy" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n='CorporateBO.IsDummy']"></xsl:variable>
 <xsl:variable name="TabValidator" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n='CorporateBO.TabValidator']"></xsl:variable>
    <xsl:variable name="ModIsDummy" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n='CorporateModBO.IsDummy']"></xsl:variable>

    <!-- vasanth's changes end -->
    <xsl:variable name="segmentValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='segmentValues']"/>
    <xsl:variable name="segmentRating" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='segmentRating']"/>
    <!-- changes for ticket 297269 starts -->
    <xsl:variable name="chargeCode" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='chargeCode']"/>
    <!-- changes for ticket 297269 ends -->
	<!-- CRM102BETA:TrackerID:194036 Being of Change -->
	<xsl:variable name="codechargeCode" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='code_chargeCode']"/>
	<!-- CRM102BETA:TrackerID:194036 End of Change -->
    <xsl:variable name="ratingValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='ratingValues']"/>
    <xsl:variable name="strCountryValue" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strCountryValue']"></xsl:variable>
    <xsl:variable name="subSegmentValues" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='subSegmentValues']"/>
    <xsl:variable name="subSegmentCodeVal" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='subSegmentCodeVal']"/>
    <xsl:variable name="SubSegment" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.subSegment')]"></xsl:variable>
    <xsl:variable name="Segment" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.segment')]"></xsl:variable>
    <!-- tracker 336728: adding variable -->
    <xsl:variable name="saved_chargeCode" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.ChargeLevelCode')]"></xsl:variable>
    <xsl:variable name="bcName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcName']"></xsl:variable>
    <xsl:variable name="Cat_bcName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_bcName']"></xsl:variable>
    <!-- Ticket 323409 -->
    <xsl:variable name="Cat_lineof" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_lineof']"></xsl:variable>
    <!-- Changes for call id 336466 and recon for call id 335111 STARTS -->
	<xsl:variable name="Cat_segmentof" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_segmentof']"></xsl:variable>
    <!-- Changes for call id 336466 and recon for call id 335111 ENDS -->
    <!-- Changes for call id 396783 recon of 393574 STARTS -->
    	<xsl:variable name="Cat_business_Typeof" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_business_Typeof']"></xsl:variable>
    <!-- Changes for call id 396783 recon of 393574 ENDS -->
    <xsl:variable name="lineof" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='lineof']"></xsl:variable>
    <!-- changes for Tracker id: 292552 starts-->
    <xsl:variable name="Cat_sector" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_sector']"></xsl:variable>
    <xsl:variable name="sector" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='sector']"></xsl:variable>
    <!-- changes for Tracker id: 292552 ends-->
 <xsl:variable name="LastUpdateDate" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='LastUpdateDate']"></xsl:variable>
 <xsl:variable name="LastUpdate_Date" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='LastUpdate_Date']"></xsl:variable>
 <xsl:variable name="accountKey1" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.corp_Key')]"/>


<!-- General header label Fix : -->
    <xsl:variable name="file11">../Renderer/Customization/corpcif/resource/CorpGenCustomer_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_11" select="document(concat($file11,''))"/>
     <xsl:variable name="configLabels_11" select="$configFile_11/SRMBO/*"/>

<!-- Fix : 16 -->

<!-- Fix : 16 -->
    <xsl:variable name="file1">../Renderer/corpcif/resource/CorpIntroRelatedAs_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_1" select="document(concat($file1,''))"/>
     <xsl:variable name="configLabels_1" select="$configFile_1/SRMBO/*"/>
     <xsl:variable name="fileName_Introducer">../Renderer/corpcif/resource/CorpIntroRelatedAs_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!-- Fix : 16 -->
     <!-- Changes for the ticketid:374030 Starts -->
	  <xsl:variable name="file3">../Renderer/corpcif/resource/CorpList_Concession_<xsl:value-of select="$locale"/>.xml</xsl:variable>
	 <xsl:variable name="configFile_3" select="document(concat($file3, ''))"/>
	 	    <xsl:variable name="configLabels_6" select="$configFile_3/SRMBO/*"/>
	   <!-- Changes for the ticketid:374030 Ends -->
    <!-- caching changes start -->
    <xsl:param name="viewname"/>
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.corpcif.CorpCIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
    <xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
    <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
<!-- CRM10.2SPE -->
    <xsl:variable name="PresCurrData" select="$PresFile/SRM/SRMData[@SRMDataSpace='Currency']"/>
    <xsl:variable name="PresExData" select="$PresFile/SRM/SRMData[@SRMDataSpace='ExRate']"/>
    <!-- caching changes end -->

     <!--Access Control Changes-->
      <xsl:variable name="PrimBCID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcID']"></xsl:variable>
      <xsl:variable name="PrimBCCODE" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcCode']"></xsl:variable>
      <xsl:variable name="priGrpID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='priGrpID']"></xsl:variable>
      <xsl:variable name="priSegName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='priSegName']"></xsl:variable>
     <!--Access Control End of Changes-->
     <xsl:variable name="AccessOwnerGroup" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccessOwnerGroup']"></xsl:variable>
     <xsl:param name="configCoreInter"/>
     <xsl:variable name="configFileCore" select="document(concat($configCoreInter,''))"/>
     <xsl:variable name="configLabelsCore" select="$configFileCore/SRMBO/*"/>
     <xsl:variable name="entityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityType']"></xsl:variable>
     <xsl:variable name="PrevEntityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PrevEntityType']"></xsl:variable>
     <xsl:variable name="PrimLogID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PLogID']"></xsl:variable>
     <xsl:variable name="PLogName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PLogName']"></xsl:variable>
     <xsl:variable name="DefAdress" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='DefAdress']"></xsl:variable>
     <xsl:variable name="SecLogID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='SLogID']"></xsl:variable>
     <xsl:variable name="TerLogID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='TLogID']"></xsl:variable>
     <xsl:variable name="tsavailedFlg" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='tsavailedFlg']"></xsl:variable>
     <xsl:variable name="RelationshipCreatedBy" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RelationshipCreatedBy']"></xsl:variable>
     <xsl:variable name="ConvToCust" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ConvToCust']"></xsl:variable>
     <xsl:variable name="corpID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='corpID']"></xsl:variable>
     <!--Changes for Tracker:163001:Start-->
     <xsl:variable name="fetchFrom" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='fetchFrom']"></xsl:variable>
     <!--Changes for Tracker:163001:End-->
     <xsl:param name="configFileName"/>
     <xsl:variable name="configFile" select="document(concat($configFileName,''))"/>
     <xsl:variable name="configLabels" select="$configFile/SRMBO/*"/>
     <xsl:variable name="BOName">CorporateBO</xsl:variable>
     <xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"></xsl:variable>
     <xsl:variable name="boNameCI" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boNameCI']"></xsl:variable>
     <!-- Changes for the ticketid:374030 Starts -->
     <xsl:variable name="boNamePM" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boNamePM']"></xsl:variable>
     <!-- Changes for the ticketid:374030 Ends -->
     <xsl:variable name="allfields" select="//SRMData//Z"/>
     <xsl:variable name="corporateURL" select="//SRMData//Z[@n=concat($boName,'.url_')]"></xsl:variable>
     <xsl:variable name="assignedBackEndID" select="//SRMData//Z[@n=concat($boName,'.BackEndID')]"></xsl:variable>
     <xsl:variable name="dtValid" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtValid']"/>
     <!-- CIF GroupHouseHold Changes Start : Naved -->
     <xsl:variable name="globalRM" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='GlobalRM']"></xsl:variable>
     <xsl:variable name="NatName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='NatName']"></xsl:variable>
<!--tracker id 231104 changes starts-->
     <xsl:variable name="strBaselMand" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='strBaselMand']"/>
<!--tracker id 231104 changes starts-->
    <!-- CIF GroupHouseHold Changes End : Naved -->

     <!--CoreInterface Details:start-->
    <xsl:variable name="coreURL" select="//SRMData//Z[@n=concat($boNameCI,'.url_')]"></xsl:variable>
     <!--CoreInterface Details:end-->
     <!-- Changes for the ticketid:374030 Starts -->
     <xsl:variable name="preferenceURL" select="//SRMData//Z[@n=concat($boNamePM,'.url_')]"></xsl:variable>
     <!-- Changes for the ticketid:374030 Ends -->
     <xsl:variable name="priorityCode" select="//SRMData//Z[@n=concat($boName,'.priorityCode')]"></xsl:variable>
     <xsl:variable name="concurDetectX" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n=concat($boName,'.ConcurDetect_X')]"></xsl:variable>
     <xsl:variable name="isAutoGenKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isAutoGenKey']"></xsl:variable>
     <xsl:variable name="keyGeneration" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='keyGeneration']"></xsl:variable>
<!--Key Generation Changes STart-->
<xsl:variable name="entityCreflg" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityCreflg']"/>
<!--Key Generation Changes end-->
     <xsl:variable name="TDSCustID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='TDSCustID']"></xsl:variable>
     <xsl:variable name="TDSCIFID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='TDSCIFID']"></xsl:variable>
     <!--Changes for tracker 333586:Start-->
     <!--Changes for call id 422890 :Starts-->
	 <xsl:variable name="tblDesc" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='tbldesc']"></xsl:variable>
	    
	<!--<xsl:variable name="tblDesc" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='tblDesc']"></xsl:variable>-->
	<!--Changes for call id 422890 :ends--> <!-- Changes for 354790, case of customData was wrong -->
     <xsl:variable name="tblCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='tblCode']"></xsl:variable>
     <!--Changes for tracker 333586:End-->
     <xsl:variable name="purge" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='purge']"></xsl:variable>
     <!-- CIF Changes : variable for Copy : START-->
     <xsl:variable name="isCopy" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsCopy']"></xsl:variable>
     <!-- CIF Changes : variable for Copy : END-->
     <!--Doc Rec changes: start-->
     <xsl:variable name="docRecvd" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='docRecvd']"></xsl:variable>
     <!--Doc Rec changes: end-->
     <xsl:variable name="tpHeight"></xsl:variable>
     <xsl:variable name="flagRelType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='flagRelType']"></xsl:variable>
     <xsl:variable name="ID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ID']"/>
     <xsl:variable name="noOfDaysIntro" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='INTRO_DATE_VALIDATE']"></xsl:variable>
     <!-- CIF PhoneEmail Changes : Start -->
     <xsl:variable name="preferredAddressType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredAddressType']"></xsl:variable>
     <xsl:variable name="preferredPhone" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredPhone']"></xsl:variable>
     <xsl:variable name="preferredEmail" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredEmail']"></xsl:variable>
     <!-- CIF PhoneEmail Changes : End -->
	 <!-- Change for ticket ID 451953:starts -->
 	<xsl:variable name="preferenceCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='prefCode']"/>
 	<!-- Change for Ticket ID 451953: ends -->

     <!-- Changes for 'WFlow' POC start -->
     <xsl:variable name="IntWFID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strIntWFID']"></xsl:variable>
     <!-- Changes for 'WFlow' POC end -->

         <!--REFCODE changes :start-->
         <xsl:variable name="boDetCI" select="/SRM/SRMData[@SRMDataSpace='Main']/SRMComposite [@n=$boNameCI]/Z"/>
        <xsl:variable name="FreeCode1Desc"      select="$boDetCI[@n=concat($boNameCI,'.FreeCode1Desc')]"/>
         <xsl:variable name="FreeCode2Desc"     select="$boDetCI[@n=concat($boNameCI,'.FreeCode2Desc')]"/>
         <xsl:variable name="FreeCode3Desc"     select="$boDetCI[@n=concat($boNameCI,'.FreeCode3Desc')]"/>
         <xsl:variable name="FreeCode4Desc"     select="$boDetCI[@n=concat($boNameCI,'.FreeCode4Desc')]"/>
         <xsl:variable name="FreeCode5Desc"     select="$boDetCI[@n=concat($boNameCI,'.FreeCode5Desc')]"/>
         <xsl:variable name="FreeCode6Desc"     select="$boDetCI[@n=concat($boNameCI,'.FreeCode6Desc')]"/>
         <xsl:variable name="FreeCode7Desc"     select="$boDetCI[@n=concat($boNameCI,'.FreeCode7Desc')]"/>
         <xsl:variable name="FreeCode8Desc"     select="$boDetCI[@n=concat($boNameCI,'.FreeCode8Desc')]"/>
         <xsl:variable name="FreeCode9Desc"     select="$boDetCI[@n=concat($boNameCI,'.FreeCode9Desc')]"/>
         <xsl:variable name="FreeCode10Desc"        select="$boDetCI[@n=concat($boNameCI,'.FreeCode10Desc')]"/>
         <!-- REFCODE changes  : end -->

<!-- Changes for KYC Enhancement Start-->
     <xsl:variable name="riskRating" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.riskRating')]"></xsl:variable>
     <xsl:variable name="KYC_ReviewDate" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.KYC_ReviewDate')]" ></xsl:variable>
     <xsl:variable name="KYC_Date" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.KYC_Date')]" ></xsl:variable>
     <xsl:variable name="submitForKYC" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.submitForKYC')]"></xsl:variable>
<!-- Changes for KYC Enhancement End-->


    <!-- Changes for Tracker # 98769 begin -->
    <xsl:variable name="getRole" select="/SRM/SRMData[@SRMDataSpace='RoleCode']//Z"/>
    <xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"></xsl:variable>
    <xsl:variable name="mcJNDIFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mcJNDIFlag']"></xsl:variable>
    <xsl:variable name="isMCEdited" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isMCEdited']"></xsl:variable>
    <!-- Changes for Tracker # 98769 end -->

    <xsl:variable name="SRMTips" select="$configLabels[@name='Tips']/@value"/>
    <xsl:variable name="custom_fields" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z"/>
    <xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
    <xsl:variable name="BaseCurrency" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrency']"/>
     <!--Changes for call id 406159 recon of 402339 start -->
     <xsl:variable name="BaseCurrency_Desc" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrency_Desc']"/>
   <!--Changes for call id 406159 recon of 402339 end -->
    <xsl:variable name="CorpCurrency" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorpCurrency']"/>
    <xsl:variable name="queueFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='queueFlag']"/>
    <!-- Save & submit  changes :Getting from Det or ModDet file : Start -->
    <xsl:variable name="operationType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operationType']"/>
    <xsl:variable name="approval" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='approval']"/>
	 <!--10.2.14 enhancements starts-->
	<xsl:variable name="allowMulti" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='allowMulti']" />
	<xsl:variable name="isGrpAvail" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isGrpAvail']" />
	<xsl:variable name="grouph_id" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.GroupHouseHold.GROUP_ID']" />
	
	

	 <!--10.2.14 enhancements ends-->
    <!--Begin of changes for tracker 131243 by sneha kaul  - BANKID - -->
      <xsl:variable name="bank_id" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bank_id']"></xsl:variable>
	<!-- 451152 -->
	<xsl:variable name="lang_desc" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Lang_Desc']"></xsl:variable>
	<!-- 451152 -->
   <!--End of changes for tracker 131243 by sneha kaul  - BANKID - -->
    <!-- Save & submit  changes :Getting from Det or ModDet file : End -->
    <xsl:variable name="tabPgName" select="tabDemoForm"/>
    <xsl:template match="/">
     <html>
     <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
     <head>
     <!--Changes by Niharika for CR356016-->
	 <script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
	 
	 <!--End of changes by Niharika for CR356016-->

     <!-- vasanth's changes start -->
     <script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>
     <script type="text/javascript" src="../Customization/js/CorporateCustom.js" language="javascript"></script>
     <!-- vasanth's changes end -->

    <!--Begin of changes for tracker 131243  by sumeet gandhok - BANKID - -->
    <script language="javascript" src="../cif/js/CrossEntityCopyValidation.js"></script>
    <!--End of changes for tracker 131243  by sumeet gandhok - BANKID - -->
        <script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
        <!--Fix for ticket ID 294704 -->
        <script type="text/javascript" src="../common/js/TabMessage_{$locale}.js" language="javascript"></script>
         <!--Fix for ticket ID 294704 -->
<script type="text/javascript" src="../corpcif/js/Message_corpcif_{$locale}.js" language="javascript"></script>
        <script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/MLValidate.js" language="javascript"></script>
        <!-- Tracker ID Begins : 209607 -->
        <script type="text/javascript" src="../common/js/Rendcurrency_cif.js" language="javascript"></script>
        <!-- Tracker ID Ends : 209607 -->
        <script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
    <script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
    <script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>
    <script type="text/javascript" src="../common/html/Rendvalidate.js" language="javascript"></script>
    <!-- Changes for the ticketid:374030 Starts -->
	    <script type="text/javascript" src="../corpcif/js/AccForm.js" language="javascript"></script>
	    <!-- Changes for the ticketid:374030 Ends -->
    <!-- Field Rationalization changes start -->
    <script type="text/javascript" src="../common/js/SSOUtils.js"></script>
    <!-- Field Rationalization changes end -->
<!-- Memo padding -->
    <script type="text/javascript" src="../common/js/ContextSwitch.js" language="javascript"></script>
    <script>
	
	/* 451152 */
	var lang_desc = '<xsl:value-of select="$lang_desc"/>'; 
	/* 451152 */
	var allowMulti = '<xsl:value-of select="$allowMulti"></xsl:value-of>'; 
	var grouph_id = '<xsl:value-of select="$grouph_id"></xsl:value-of>';
    var locale = '<xsl:value-of select="$locale"/>'; 
	 /*tracker id 231104 changes starts*/
     var strBaselMand = '<xsl:value-of select="$strBaselMand"/>'; 
	 /*tracker id 231104 changes starts*/
     <!--Begin of changes for tracker 131243 by sneha kaul  - BANKID - -->
        var bank_id = '<xsl:value-of select="$bank_id"/>';
    <!--End of changes for tracker 131243 by sneha kaul  - BANKID - -->
          <!--tracker id 113227 starts-->
          
 <!-- Changes starts for CallId:337741 is econ for 336347 -->
		var preferredAddressType = '<xsl:value-of select="$preferredAddressType"/>';
<!-- Changes ends for CallId:337741 is econ for 336347 -->

<!-- TrackerId: 131246 Begin of Changes by Sonali_narula-->
    var bGcifIdAccess = '<xsl:value-of select="$GcifIdAccess"/>';
    var bMultiEntity = '<xsl:value-of select="$MultiEntity"/>';
        var gcifId = '<xsl:value-of select="$GcifId"/>';
<!-- TrackerId: 131246 end of Changes by -->

        <!-- TrackerId 145437: changes start -->
        <!-- dualFlag is by default set to 1 -->
            var dualflag =1;
            <!-- TrackerId 145437: changes end-->
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
               /* TrackerId 145437: changes start
              * The following code is commented
              */
           }
                /*else if (locale==baseLocaleType){
                    dualflag=1;
                }
            }
            else{
                dualflag=1;

            }*/
            <!-- TrackerId 145437: changes end-->

     <!--tracker id 113227 ends-->
    var boName = '<xsl:value-of select="$boName"/>';
    var TabValidator = '<xsl:value-of select="$TabValidator"/>';
    var ModIsDummy = '<xsl:value-of select="$ModIsDummy"/>';
    var bcName = '<xsl:value-of select="$bcName"/>';
    var Cat_bcName = '<xsl:value-of select="$Cat_bcName"/>';
    var AccKEY = '<xsl:value-of select="$accountKey1"/>';
    <!-- ticket 323409 -->
    var Cat_lineof = '<xsl:value-of select="$Cat_lineof"/>';
    <!-- Changes for call id 336466 and recon for call id 335111 STARTS -->
	var Cat_segmentof = '<xsl:value-of select="$Cat_segmentof"/>';
    <!-- Changes for call id 336466 and recon for call id 335111 ENDS -->
    <!-- Changes for call id 396783 recon of 393574 STARTS -->
    	var Cat_business_Typeof = '<xsl:value-of select="$Cat_business_Typeof"/>';
    <!-- Changes for call id 396783 recon of 393574 ENDS -->
    var lineof = '<xsl:value-of select="$lineof"/>';
    
//IDENTIFICATION DOCUMENT CHANGES start
            var entityDocumentBO_Name;
            if(boName=='CorporateBO')
                entityDocumentBO_Name='EntityDocumentBO';
            else if(boName=='CorporateModBO')
                entityDocumentBO_Name='EntityDocumentModBO';
//IDENTIFICATION DOCUMENT CHANGES end

    var boNameCI = '<xsl:value-of select="$boNameCI"/>';
    <!-- Changes for the ticketid:374030 Starts -->
    var boNamePM = '<xsl:value-of select="$boNamePM"/>';
    <!-- Changes for the ticketid:374030 Ends -->
    var relCreatedBy = '<xsl:value-of select="$custom_fields[@n='RelationshipCreatedBy']"/>';
    var corporateURL = '<xsl:value-of select="$corporateURL"/>';
    var isCopy = '<xsl:value-of select="$isCopy"/>';
    var readMode = '<xsl:value-of select="$readMode"/>';
    var PrimLogID = '<xsl:value-of select="$PrimLogID"/>';
    var queueFlag = '<xsl:value-of select="$queueFlag"/>';
    /************* Save and Submit Changes : start***********/
    var operationType = '<xsl:value-of select="$operationType"/>';
    var approval = '<xsl:value-of select="$approval"/>';
    /************* Save and Submit Changes : End***********/
    var SecLogID = '<xsl:value-of select="$SecLogID"/>';
    var TerLogID = '<xsl:value-of select="$TerLogID"/>';
    var DefAdress = '<xsl:value-of select="$DefAdress"/>';
    <!-- changes for call id :399519 recon of 397408 starts-->
    var preferredPhone = '<xsl:value-of select="$preferredPhone"/>';
    var preferredEmail = '<xsl:value-of select="$preferredEmail"/>';
   <!-- changes for call id : 399519 recon of 397408 ends-->
    var baseCurrency = '<xsl:value-of select="$BaseCurrency"/>';
     <!-- changes for call id : 406159 recon of 402339 starts-->
       var BaseCurrency_Desc='<xsl:value-of select="$BaseCurrency_Desc"/>';
    <!-- changes for call id : 406159 recon of 402339 ends-->
   var strCountryValue = '<xsl:value-of select="$strCountryValue"/>';
    var corpCur = '<xsl:value-of select="$CorpCurrency"/>';
    var isAutoGenKey = '<xsl:value-of select="$isAutoGenKey"/>';
	var convToCust = ''; <!-- change for FS 786033 -->
    var ConvToCust = '<xsl:value-of select="$ConvToCust"/>';
    var TDSCustID = '<xsl:value-of select="$TDSCustID"/>';
    var TDSCIFID = '<xsl:value-of select="$TDSCIFID"/>';
    /* Fix for ticket 209849 start*/
    /* Fix for ticket tracker 333586 start*/
    var tblDesc = '<xsl:value-of select="$tblDesc"/>';
     var tblCode = '<xsl:value-of select="$tblCode"/>';
      /* Fix for ticket tracker 333586 ends*/
    var purge = '<xsl:value-of select="$purge"/>';
    /* Fix for ticket 209849 ends*/
    var tsavailedFlg = '<xsl:value-of select="$tsavailedFlg"/>';
    var locDate = '<xsl:value-of select = "$dtValid"/>';
    <!--Key Genration Changes Start-->
    var entityCreflg ='<xsl:value-of select="$entityCreflg"/>';
    <!--Key Genration Changes End-->

    var keyGeneration = '<xsl:value-of select="$keyGeneration"/>';
    var reserved ="";
    var reservedval ="";
        var assignedBackEndID = '<xsl:value-of select="$assignedBackEndID"/>';
        var entityType = '<xsl:value-of select="$entityType"/>';

<!-- Changes for call id:453365 starts-->
		var PrevEntityType = '<xsl:value-of select="$PrevEntityType"/>';
		

<!-- Changes for call id:453365 ends-->
    var corpIDSwift = '<xsl:value-of select = "$corpID"/>';
    var corpID = '<xsl:value-of select = "$corpID"/>';
    <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
    var AccessOwnerGroup = '<xsl:value-of select="$AccessOwnerGroup"/>';
    <!-- Tracker ID : 90197 End of Changes -->
    <!-- Change for ticket ID 451953:starts -->
	var preferenceCode = '<xsl:value-of select="$preferenceCode"/>';
    <!-- Change for ticket ID :451953ends -->

    <!-- vasanth's changes start -->

        var BlackListed = '<xsl:value-of select="$BlackListed"/>';
        var Suspended = '<xsl:value-of select="$Suspended"/>';
        var Negated =  '<xsl:value-of select="$Negated"/>';
        var chkBSNFlg = '<xsl:value-of select="$chkBSN"/>';
    <!-- vasanth's changes end -->
    <!-- Changes for the ticketid:374030 Starts -->
    var curraccList = '<xsl:value-of select="$CurrencyAccList"/>';
    <!-- Changes for the ticketid:374030 Ends -->
    chkBSNFlg='true';
    var segment = '<xsl:value-of select="$segmentValues"/>';
    <!--tracker 336728:adding variable -->
    var saved_chargeCode = '<xsl:value-of select="$saved_chargeCode"/>';
    var segmentRating = '<xsl:value-of select="$segmentRating"/>';
    <!-- changes for ticket 297269 starts -->
    var chargeCode = '<xsl:value-of select="$chargeCode"/>';
    <!-- changes for ticket 297269 ends -->
	<!-- CRM102BETA:TrackerID:194036 Being of Change -->
	var codechargeCode = '<xsl:value-of select="$codechargeCode"/>';
	<!-- CRM102BETA:TrackerID:194036 End of Change -->
    var subSegmentRating = '<xsl:value-of select="$ratingValues"/>';
    var subSegment = '<xsl:value-of select="$subSegmentValues"/>';
    var subSegmentCode = '<xsl:value-of select="$subSegmentCodeVal"/>';
    var SubSegment = '<xsl:value-of select="$SubSegment"/>';
    var Segment = '<xsl:value-of select="$Segment"/>';
    var LastUpdateDate = '<xsl:value-of select="$LastUpdateDate"/>';
     var LastUpdate_Date = '<xsl:value-of select="$LastUpdate_Date"/>';
     <!-- Changes for the ticketid:374030 Starts -->
     var fileName_concession = '<xsl:value-of select="document(concat($fileName_concession, ''))"/>';
     <!-- Changes for the ticketid:374030 Ends -->
    var delAddrtypes       = new Array();

    var IntWFID = '<xsl:value-of select="$IntWFID"/>'; /* Changes for WFlow POC */

<!--Access Control Changes-->
    var primBCID = '<xsl:value-of select="$PrimBCID"/>';
    var primBCCODE = '<xsl:value-of select="$PrimBCCODE"/>';
    var priGrpID = '<xsl:value-of select="$priGrpID"/>';
    var priSegName = '<xsl:value-of select="$priSegName"/>';

    var SegmentChanged='';
    var defaultOwnerSegment='';
    var RMChanged='';
    var defaultPrimaryRM='';
    var defaultSecondaryRM='';
    // fix for ticket 334796 starts
    <!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Starts-->
    var defaultTertiaryRM='';
    <!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Ends-->
    // fix for ticket 334796 ends

<!--End of Changes-->

 <!-- CIF Group Changes Start Naved -->
          var cntry_oper='';
          <xsl:variable name="str4Code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.CountryOfPrincipalOperation']"/>
    cntry_oper = '<xsl:value-of select="$str4Code"/>';
    var globalRM = '<xsl:value-of select="$globalRM"/>';
    var NatName =  '<xsl:value-of select="$NatName"/>';
    var bSelected = false;
        <!-- CIF Group Changes End Naved -->

    var btnFrmSize=45;
    /*tracker 336728 changes start*/
    
    var first='y';
        
    /*tracker 336728 changes end*/



    </script>
        <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>  <!-- file included by tessa
        <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>-->
        <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
    <script type="text/javascript" language="javascript">

<![CDATA[
<!-- Core dependency changes start-->
function changeSubSeg () {

try {
    var segrating= loadSubSeg();
/*changes for ticket id 432983 start */    
    /*tracker 336728 changes start*/
//if(segrating != null && segrating != 'null' && segrating!='') {
  /*changes for ticket id 432983 end */       
//      document.getElementsByName("Cat_CorporateBO.ChargeLevelCode")[0].value = segrating;
//    }
//    else {
//       document.getElementsByName("Cat_CorporateBO.ChargeLevelCode")[0].value ='';
   // }
    /*tracker 336728 changes end*/
}
catch (e) {
}
}
<!-- Core dependency changes end-->
function loadSubSeg(){
    var ele1 = document.getElementsByName(boName+".segment")[0];
    var ele2 = document.getElementsByName(boName+".subSegment")[0];
    /*tracker 336728 changes start*/
    var code=saved_chargeCode;
    /*tracker 336728 changes end*/
  
    ele2.options.length = 0;
    ele2.options[0] = new Option('','');
    /*Changes for Tracker:138505*/
 /*Changes for Ticket ID :403903*/
        /*changes for ticket id 432983 start*/
        //var segValues = Segment.split("$");
        var segValues = segment.split("$");
        /*changes for ticket id 432983 end*/
        //changes for ticket 297269 starts
    /*tracker 336728 changes start*/
       /* //var segRat = segmentRating.split("$");
        var segRat = chargeCode;*/
        var segRat = segmentRating.split("$");
    /*tracker 336728 changes end*/
       
        //changes for ticket 297269 ends
        var subSeg = subSegment.split("$");
        var subSegCode = subSegmentCode.split("$");
        var subSegRat = subSegmentRating.split("$");
    /*Changes for Tracker:138505*/

    //var segValues = segment.split("|");
    //var segRat = segmentRating.split("|");
    //var subSeg = subSegment.split("|");
    //var subSegCode = subSegmentCode.split("|");
    //var subSegRat = subSegmentRating.split("|");

    var segrating = '';
    /*tracker 336728 changes start*/
    var seg_code='';
    /*tracker 336728 changes end*/
    
 	/*tracker 336728 changes start*/ 
  	var code_chargeCode= codechargeCode.split("$");
        var charge_Code=chargeCode.split("$");
 	/*tracker 336728 changes end*/
  
    if(ele1.value != '' && ele1.value != null ){
        for(i=0; i<segValues.length; i++){
            if(segValues[i] == ele1.value){
   
    //changes for ticket 297269 starts
    /*tracker 336728 changes start*/
              //  segrating = segRat;
                   
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
              
    /*tracker 336728 changes end*/
    //changes for ticket 297269 ends
            }
        }
    k=1;
    for(j=0; j<subSegRat.length ; j++){
    /*Changes for Tracker:138505*/
        var sub2rat=subSegRat[j].split("|");

        if(sub2rat.length>1)
        {
          for(m=0;m<sub2rat.length ; m++){
        if(sub2rat[m] == ele1.value){
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
<!-- Core dependency changes start-->


    if(segrating != null && segrating != 'null')
		<!-- CRM102BETA:TrackerID:194036 Being of Change -->
		{/*changes start for tracker 336728 to automatically populate chargecode in UI*/

		if(readMode!='Y')
		{
				if(readMode=='N' && first=='y')
				{
				first='n';
				}
				else
				{
				document.getElementsByName("CorporateBO.ChargeLevelCode")[0].value = seg_code;
				document.getElementsByName("Cat_CorporateBO.ChargeLevelCode")[0].value = segrating;
				}
			/*changes end for tracker 336728 to automatically populate chargecode in UI*/
		}
		}
	<!-- CRM102BETA:TrackerID:194036 End of Change -->
    else
       {
       
       /*changes start for tracker 336728 to automatically populate chargecode in UI*/
      
       		document.getElementsByName("Cat_CorporateBO.ChargeLevelCode")[0].value ='';
       	  	
	/*changes end for tracker 336728 to automatically populate chargecode in UI*/
	
        document.getElementsByName("CorporateBO.ChargeLevelCode")[0].value = '';
       }
    return segrating;
<!-- Core dependency changes end-->

}
/* Changes for Call id 312826  starts */
function setPrefValue(Selvalue,elmenName){
     
    var elem1 = document.getElementsByName(elmenName)[0];
        	for(i=0;i<elem1.options.length;i++)
        		{
        			if(elem1.options[i].value==Selvalue)
        			{
        			elem1.selectedIndex=i
        			break;
        			}
		}
    
  }
  /* Changes for Call id 312826  Ends */
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
	// Change for ticket ID 451953:starts
	
	if(boNameCI=='CoreInterfaceBO'){
	var ele3 = document.getElementsByName("CoreInterfaceBO.PrefCode")[0];
	}else if(boNameCI=='CoreInterfaceModBO'){	
	var ele3 = document.getElementsByName("CoreInterfaceModBO.PrefCode")[0];
	}
	if( preferenceCode!= '' && preferenceCode!= null){
		for(i=0;i<ele3.options.length;i++)
		{	
			if(ele3.options[i].value==preferenceCode)
			{
			ele3.selectedIndex=i
			break;
			}

		}
	}
	// Change for ticket Id 451953: ends
    }
]]>
    //CIF Tabbing and Saving Changes

   <!-- FATCA Changes Begin -->
    
    
    function focusFirstFatcaField(){
  
   
      if(readMode !='Y')
       {
   
    var v=document.getElementsByName(boName+".ForeignAccTaxReportingReq")[0].value;
 
          if(v=='Y'){
           document.getElementsByName("mandStarCorporateBO.ForeignTaxReportingCountry")[0].style.visibility="visible";
           document.getElementsByName("Cat_CorporateBO.ForeignTaxReportingCountry")[0].IsMandatory = "true";
           document.getElementsByName("Cat_CorporateBO.ForeignTaxReportingCountry")[0].disabled = false;
            document.getElementsByName("CorporateBO.ForeignTaxReportingCountry")[0].disabled = false;
           document.getElementsByName("btnone_CorporateBO.ForeignTaxReportingCountry")[0].disabled = false;
           document.getElementsByName("btntwo_CorporateBO.ForeignTaxReportingCountry")[0].disabled = false;
           document.getElementsByName("Cat_CorporateBO.ForeignTaxReportingCountry")[0].value=strCountryValue;   
           
           
            document.getElementsByName("mandStar"+boName+".ForeignTaxReportingStatus")[0].style.visibility="visible";
   	  document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].IsMandatory = "true";
   	    document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].disabled = false;
   	      document.getElementsByTagName("img")[10].style.visibility="visible";
	    		  document.getElementsByTagName("img")[10].style.display=""; 
	    		  document.getElementsByTagName("img")[11].style.visibility="visible";
		  document.getElementsByTagName("img")[11].style.display=""; 
      
         
           document.getElementsByName("3_CorporateBO.LastForeignTaxReviewDate")[0].disabled = false;
           document.getElementsByName("3_CorporateBO.NextForeignTaxReviewDate")[0].disabled = false;
           document.getElementsByName("CorporateBO.FatcaRemarks")[0].disabled = false;
    
    }
    else{
    
      document.getElementsByName("mandStarCorporateBO.ForeignTaxReportingCountry")[0].style.visibility="hidden";
          
           document.getElementsByName("Cat_CorporateBO.ForeignTaxReportingCountry")[0].IsMandatory = "false";
           
    document.getElementsByName('Cat_CorporateBO.ForeignTaxReportingCountry')[0].value="";
     
     document.getElementsByName('CorporateBO.ForeignTaxReportingCountry')[0].value="";
            
          document.getElementsByName("Cat_CorporateBO.ForeignTaxReportingCountry")[0].disabled = true;
        
          document.getElementsByName("CorporateBO.ForeignTaxReportingCountry")[0].disabled = true;
           document.getElementsByName("btnone_CorporateBO.ForeignTaxReportingCountry")[0].disabled = true;
           
           document.getElementsByName("btntwo_CorporateBO.ForeignTaxReportingCountry")[0].disabled = true;
           
    
           
           	  document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].value="";
   		       
   		  document.getElementsByName("mandStar"+boName+".ForeignTaxReportingStatus")[0].style.visibility="hidden";
   		 	     
   		 	document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].IsMandatory = "false";
   		 	    
   		 	document.getElementsByName(boName+".ForeignTaxReportingStatus")[0].disabled = true;
   		    
            
   		      document.getElementsByTagName("img")[10].style.visibility="hidden";
		        		  document.getElementsByTagName("img")[10].style.display="none"; 
		        		         
		        		   document.getElementsByTagName("img")[11].style.visibility="hidden";
		  document.getElementsByTagName("img")[11].style.display="none"; 
           
           document.getElementsByName('3_CorporateBO.LastForeignTaxReviewDate')[0].value="";
	      document.getElementsByName('CorporateBO.LastForeignTaxReviewDate')[0].value="";
	      document.getElementsByName('CorporateBO.NextForeignTaxReviewDate')[0].value="";
           
           document.getElementsByName("3_CorporateBO.LastForeignTaxReviewDate")[0].disabled = true;
            document.getElementsByName('3_CorporateBO.NextForeignTaxReviewDate')[0].value="";
          
           document.getElementsByName("3_CorporateBO.NextForeignTaxReviewDate")[0].disabled = true;
     document.getElementsByName('CorporateBO.FatcaRemarks')[0].value="";
    document.getElementsByName("CorporateBO.FatcaRemarks")[0].disabled = true;
    
    }
    }
     else{
     var v=document.getElementsByName(boName+".ForeignAccTaxReportingReq")[0].value;
           if(v=='Y'){
     document.getElementsByName("Cat_CorporateBO.ForeignTaxReportingCountry")[0].value=strCountryValue;
    }
    }
    
    }
    
    
    <!-- FATCA chnages Ends -->


<!-- Tracker ID: 108385: Begin of changes : For focus on first field -->
function focusFirstField()
{
    try
    {   //MATT Bug Fxing for Defect Ticket Id 201416 and 201425 - Begin
        //The hard coded BO name is changed to varaible boname
        document.getElementsByName("CorporateBO.corporate_Name")[0].focus();
/* Tracker id 113276 changes start for ST bug fixing */
if(isCopy =="Y")
        {
        /*Fix For Sanity Changes Begin-Commented this line*/
        //document.getElementsByName("CorporateBO.corp_Key")[0].value = "";
        /*Fix For Sanity Changes End*/
}
/* Tracker id 113276 changes end for ST bug fixing */
        //MATT Bug Fxing for Defect Ticket Id 201416 and 201425 - End
    }
    catch (e)
    {
        try
        {
            document.getElementsByName("CorporateBO.Address.preferredAddress")[0].focus();
        }
        catch (e)
        {
            try
            {
                document.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType")[0].focus();
            }
            catch (e)
            {
                try
                {
                    document.getElementsByName(boName + ".PrimaryParentCompany")[0].focus();
                }
                catch (e)
                {
                    try
                    {
                        document.getElementsByName(boNameCI +".CU_OFFLINECUMDEBITLIMIT")[0].focus();
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
  }
}

<!-- Tracker ID: 108385: End of changes -->
    function checkKeys() {
        if (event.keyCode == 42 || event.keyCode ==37) {
            event.keyCode=0;
        }
    }

 /*  CRM70T-ST:TRACKER:80386:BEGINOFCHANGES */
        function refreshParent(){
        frm = top.opener.parent.frames(1);
        frm.navigate (frm.location.href);
    }

    function shouldRefresh()
    {
        return true;
    }

    function showManagerInfo(agent,elename){
    //Field Rationalization changes
        var chkvar = elename;
        var manager = agent;
        if(manager == null || manager == ''){
            showMessage(MSGJ50095);
        }
        else{
        //Field Rationalization fix
        loadURL = '../servlet/com.infy.cis.ui.security.User_det?isReadOnly=Y&amp;loginId='+ manager;
        Ornaments = 'height=450,left=200,top=140,width =600';
        writeToNewWindow();
        }
    }
    /*tracker id 231104 changes starts*/
    function loadBasel(){  
                var sType='No';                 
	       if(document.getElementsByName("BaselProfiling")[0]!=undefined){
		    sType = document.getElementsByName("BaselProfiling")[0].options.value;
	       }
                   var tabID =parent.parent.parent.parent.frames(0).selectTab1("Basel_Profiling");   
                    if(tabID==0){
		     tabID =parent.parent.parent.parent.frames(0).selectTab1("Basel Profiling");                
                } 
                var object = eval("parent.parent.IFrm"+tabID);
    		if(sType=='Yes'){
    		   bSelected=true;
    		   parent.parent.parent.parent.frames(0).selectTab1("Basel_Profiling"); 		    
    		   eval("parent.parent.parent.parent.tabViewFrm." + tabID + ".style.display = '';");
    		   parent.parent.parent.parent.frames(0).selectTab("General");
    		}else if(sType=='No'  &amp;&amp; bSelected==true &amp;&amp; object!=undefined){
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
    		if((strBaselMand=='N'|| strBaselMand=='') || readMode=='Y' || isCopy=='Y'){
			if(tabID!=0){
			    eval("parent.parent.parent.parent.tabViewFrm." + tabID + ".style.display = 'none';");			
			}		
    		}
    		}
    		
    		
    		
    		
    		
	}
   /*tracker id 231104 changes ends*/
    function isTFPartyFlag(){
            var tfpFlg = document.getElementsByName(boName+".trade_Services_Availed")[0].value;
	    /* Changes for tracker 220229 starts*/
	    /* Fix for ticket ID 294704*/
	    //tabName='Trade_Finance';
	    //tabName =eval(tabName);
	    //parent.parent.parent.parent.frames(0).selectTab(tabName);
	    /*Fix for ticket ID 294704 */
	    parent.parent.parent.parent.frames(0).selectTab("Trade Finance");
	    /* Changes for tracker 220229 ends*/
            var tabID =parent.parent.parent.parent.frames(0).getSelectedTabId();
            if( tabID != 'tab0' ){
                if(tfpFlg == 'N' || tfpFlg == '' ){
            eval("parent.parent.parent.parent.tabViewFrm." + tabID + ".style.display = 'none';");
                }
                else{
            eval("parent.parent.parent.parent.tabViewFrm." + tabID + ".style.display = '';");
            }
            parent.parent.parent.parent.frames(0).selectTab("General");
            }
            document.frm2.TfFlag.value = tfpFlg;
    }

    <!-- Field Rationalization ends -->



  <!--// Tracker ID : 68932 End of Changes-->

    // ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 start
    // Function hideFields is written to disable zakat_deduction field when user selects
    // "N" or "None" in islamic_banking_customer field dropdowns

    function hideFields(){

            var mydata = new Array();
            /*Fix For Sanity Changes Begin*/
            //The 4 new fields have not been added for Prospect
            //so the fields will not be hidden for Prospect/Prospect QDE
            if(entityType != 'Prospect'){
            /*Fix For Sanity Changes End*/
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
        /*Fix For Sanity Changes Begin*/
        }
        /*Fix For Sanity Changes End*/
    }


    // ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 end




   <!--Access Control Changes-->
   function  openBCCodeLookup(type)
   {
           bcCodeLookup = type;
           var url = "com.infy.cis.ui.common.Lookup?Mode=ForBCCode&amp;isActive=Y&amp;isAutomated=N";
<!--Tracker:108380: Changes for centering popup -->
           wid=900;
           ht=460;
           topCord=(screen.height-ht)/2;
           leftCord=(screen.width-wid)/2;
           var style = "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes";
<!--Tracker:108380: End of Changes-->
           window.open (url, "Lookup", style);
   }
   function  onBCCodeSelect()
   {
           setBCCodeValues ( bcCodeLookup , getCookie("bCCode"), getCookie("bCID"));
           /* Changes for Tracker # 98769 begin */
           document.getElementsByName("CorporateBO.accessOwnerBC")[0].fireEvent("onChange");
           /* Changes for Tracker # 98769 end */
   }

   function  setBCCodeValues (type, bCCode, bCID)
   {
           eval("document.frm2." + type).value = bCID;
           eval("document.getElementsByName('CorporateBO.accessOwnerBC')[0]").value  = bCCode;
   }

   function setAccessOwnerGroup()
   {
           document.frm2.accessOwnerGroup.value=document.getElementsByName('CorporateBO.accessOwnerGroup')[0].value;
           return
   /* Changes for Tracker # 98769 begin */
   } function setMCAttModifyFlag(){
        document.frm2.isMCEditedGeneral.value="Y";
   /* Changes for Tracker # 98769 end */
   }

    function setAccessOwnerSegment()
    {
        var ownerSegment= document.getElementsByName('CorporateBO.accessOwnerSegment')[0].value;
        if (ownerSegment!="" &amp;&amp; ownerSegment!= defaultOwnerSegment &amp;&amp; ownerSegment!=null &amp;&amp; ownerSegment!="null" ) {
            SegmentChanged='true';
        }
        else {
            SegmentChanged='false';
        }
    }

   <!--End of Changes-->


    function resubmit(){
        parent.parent.parent.parent.parent.parent.frames(0).submit();
    }

    /*  CRM70T-ST:TRACKER:80386:ENDOFCHANGES */
    /*  CRM95-ST:TRACKER:101879:BEGINOFCHANGES */
    function makeSwiftFldMand()
    {
		<!--RECON Changes for ticket id 383428 / Tracker id 233709 / Changes for 400757 and recon for 392665 begins-->
		var swift = document.getElementsByName(boName+".Is_Swift_Code_of_Bank")[0].value;

		if(swift == 'y' || swift == 'Y')
        {
           document.getElementsByName("mandStarCorporateBO.Cust_Swift_Code_Desc")[0].style.visibility="visible";
           document.getElementsByName("mandStarCorporateBO.Cust_Swift_Code_Desc")[0].IsMandatory = "true";
		   document.getElementsByName("CorporateBO.Cust_Swift_Code_Desc")[0].disabled = false;
        }

        else
        {
           document.getElementsByName("mandStarCorporateBO.Cust_Swift_Code_Desc")[0].style.visibility="hidden";
           document.getElementsByName("mandStarCorporateBO.Cust_Swift_Code_Desc")[0].IsMandatory = "false";
		    document.getElementsByName("CorporateBO.Cust_Swift_Code_Desc")[0].disabled = true;
        }
		<!--RECON Changes for ticket id 383428 / Tracker id 233709 / Changes for 400757 and recon for 392665 ends-->
    }
    /*  CRM95-ST:TRACKER:101879:ENDOFCHANGES */

    //CIF Tabbing and Saving Changes
    function clear() {
      /*  CRM70T-ST:TRACKER:80386:BEGINOFCHANGES */

      if(queueFlag == "Y"){
//      top.window.opener.location.reload(true);
          }
          /*  CRM70T-ST:TRACKER:80386:ENDOFCHANGES */
      if(corporateURL=='' || isCopy=='Y' || ConvToCust=='Y'){
        document.getElementsByName("corpID")[0].value = parent.formSaveFrame.savedValue;
        document.getElementsByName("corpkey")[0].value = parent.formSaveFrame.corpkey;
        document.getElementsByName("corpName")[0].value = parent.formSaveFrame.savedName;
        document.getElementsByName("ProcID")[0].value = parent.formSaveFrame.savedProcID;
        document.getElementsByName("MainTableID")[0].value = parent.formSaveFrame.MainTableID;
        document.getElementsByName("CoreCustID")[0].value = parent.formSaveFrame.CoreCustID;


        if(parent.formSaveFrame.savedValue == null){
            if(isCopy == 'Y')
            {
            parent.parent.parent.parent.parent.parent.frames(0).submit();
            }
        }
     }
     else{
     try{
        parent.parent.parent.parent.parent.parent.frames(0).submit();
        }
        catch(e)
        { //DebugMessage(e.message)
        }
         }
        }

        function showbuttonsVisible(btnFrmSize) {
            try{
                parent.parent.parent.parent.setCifButtonsVisible(true,btnFrmSize);
            }catch(e)
            {}
        }


 //changes made by anwesha for document_received

            function isDocument_Received() {
            if(document.frm2.Document_Received.checked) {
            document.frm2.ckDocument_Received.value = "Y";

            } else {
            document.frm2.ckDocument_Received.value = "N";

                                    }
            }
function makekeyMand(){
    if(isAutoGenKey == 'false' || isAutoGenKey == '') {
        // changes for call id 388699 and recon of call id 387378 starts
        //document.getElementsByName("mandStarCorporateBO.corp_Key")[0].style.visibility="visible";
        document.getElementsByName("CorporateBO.corp_Key")[0].style.visibility="visible";
        // changes for call id 388699 and recon of call id 387378 ends
        document.getElementsByName("CorporateBO.corp_Key")[0].IsMandatory = "true";
    }
}
function loadrel()
{

/* Fix for ticket 209849 start*/
//Commented for tracker 333586:Start
//document.getElementsByName(boName+".Tds_Tbl_Desc")[0].value =tbldesc;
//Commented for tracker 333586:End
document.getElementsByName(boName+".Purge_Allowed_Flag")[0].value =purge;
/* Fix for ticket 209849 ends*/
document.getElementsByName("Tds_Cust_Id")[0].value = TDSCustID;
document.getElementsByName("CorporateBO.Tds_CIF_Id")[0].value = TDSCIFID;
//Changes for 278663:Start
//Changes for tracker 337168:Start
try{
//changes for call id: 347943 start
if(boName=="CorporateBO")
document.getElementsByName("CorporateBO.Tds_Tbl_Desc")[0].value =tblDesc;
else
document.getElementsByName("CorporateBO.tds_Tbl_Code")[0].value =tblCode;
}catch(e){
	//alert(e);
}
//changes for call id: 347943 end
//Changes for tracker 337168:End
//Changes for 278663:End
document.getElementsByName("CorporateBO.relationship_CreatedBy")[0].value = relCreatedBy;
document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].value = PrimLogID;
document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].value = SecLogID;
document.getElementsByName("CorporateBO.TertiaryRMLogin_ID")[0].value = TerLogID;



if(corporateURL=='' || isCopy=='Y'){
    document.getElementsByName(boName+".Purge_Allowed_Flag")[0].value = "N";
    // changes for call id 388699 and recon of call id 387378 starts
    document.getElementsByName(boName+".Purge_Allowed_Flag")[0].disabled = true;
    // changes for call id 388699 and recon of call id 387378 ends
	  /*tracker id 231104 changes starts*/
       document.getElementsByName("copyKey")[0].value=document.getElementsByName("CorporateBO.corp_Key")[0].value ;
    /*tracker id 231104 changes ends*/
    document.getElementsByName("CorporateBO.corp_Key")[0].value = "";
    //Changes for TOL# 258635 starts
    document.getElementsByName("CorporateBO.DefaultAddressType")[0].value = DefAdress;
    //Changes for TOL# 258635 ends
}
/* Changes for Tracker 260553 -  Start */
if(operationType=='EditEntity' || operationType=='Queue'){
document.getElementsByName("CorporateBO.DefaultAddressType")[0].value = DefAdress;
// changes for call id 388699 and recon of call id 387378 starts
document.getElementsByName(boName+".Purge_Allowed_Flag")[0].disabled = true;
// changes for call id 388699 and recon of call id 387378 ends
}
/* Changes for Tracker 260553 - End */
}


// ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 start
// To disable zakat_deduction field when form loads

function loadZakat()
    {
    //ERPBOCF1  - Bug Fixing - Ticket Id 201155 Begin
    // Adding try catch block to the zakat_deduction field.
    try{
     document.getElementsByName(boName+".zakat_deduction")[0].disabled = true;
    }
     catch(e)
     {
     }
     //ERPBOCF1  - Bug Fixing - Ticket Id 201155 End

    }

// ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 end

 function loadBaseCurrency()
    {
       if(corporateURL=='' || isCopy=='Y'){
    document.getElementsByName(boName+".Crncy_Code")[0].value = "<xsl:value-of select="$BaseCurrency"/>";
     /*changes for Tracker ID 266314 Starts*/
     //changes for ticket 406159 recon of 402339 Starts
    // document.getElementsByName("Cat_"+boName+".Crncy_Code")[0].value = "<xsl:value-of select="$BaseCurrency"/>";
     document.getElementsByName("Cat_"+boName+".Crncy_Code")[0].value = BaseCurrency_Desc;
     /*changes for Tracker ID 266314 Ends*/
     //changes for Ticket 406159 recon of 402339 end
    }
    else
    {
    document.getElementsByName(boName+".Crncy_Code")[0].value = corpCur;
    }
    // Changes for call id 443826 starts here
    var BaseCurr = document.getElementsByName(boNameCI+".CU_OFFLINECUMDEBITLIMIT")[0].value;
    if(BaseCurr == null || BaseCurr == '' || BaseCurr == 'null')
    {
    document.getElementsByName(boNameCI+".CU_OFFLINECUMDEBITLIMIT")[0].value = "<xsl:value-of select="$BaseCurrency"/>";
	
//442781
	//document.getElementsByName("3_CoreInterfaceBO.OFFLINECUMDEBITLIMIT")[0].disabled=false;

    
	}
	
    // Changes for call id 443826 ends here
       formatCorpAmount("3_CorporateBO.average_AnnualIncome","genCurncy","N");
       formatCorpAmount("3_CorporateBO.TotalFundBase","genCurncy","N");
       formatCorpAmount("3_CorporateBO.TotalNonFundBase","genCurncy","N");
       formatCorpAmount("3_CoreInterfaceBO.OfflineCumDebitLimit",boNameCI+".CU_OFFLINECUMDEBITLIMIT","N");
}
function formatCorpAmount(amtObj,dropObj,place) {
            formatAmount(amtObj,boName+".Crncy_Code", place);
}

<![CDATA[function validCorpDate(cDate){

/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
/* DBS Enhancement tracker ID :-402520 by rattandeep_singh01 */
/* calling the function isGregDate for on blur functionality*/
/* isGregDate_IOC("3_CorporateBO.date_Of_Incorporation");*/
isGregDate_IOC("3_CorporateBO.date_Of_Incorporation");
/* DBS Enhancement tracker ID :-402520 by rattandeep_singh01 */

/* ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/



    var todaydate = new String();
    //todaydate.value = getTodayDate();
    todaydate.value = getTodayDate1(locDate);

/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
/* calling the function isGregDate for on blur functionality*/
    var date = document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0];
            if (date.value != '')
{
    todaydate.value = convertDate(todaydate.value);
    }
       /* ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/


    elem1 = document.getElementsByName(cDate)[0];

    var mill1 = changetoMillisForToday(todaydate.value);

    var mill2 = changetoMillis(elem1.value);

        if (mill1 < mill2){
                    showMessage(MSG302);
                    elem1.value = "";
                    //elem1.focus();
            }
    }
    ]]>

function storeSegment() {

    defaultOwnerSegment=document.getElementsByName('CorporateBO.accessOwnerSegment')[0].value;
    defaultPrimaryRM=document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].value;
    defaultSecondaryRM=document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].value;
  // fix for ticket 334796 starts
   // defaultTertiaryRM=document.getElementsByName("CorporateBO.TertiaryRMLogin_ID")[0].value;
   // fix for ticket 334796 ends
}

<!-- Changes for KYC Enhancement Start-->

function EnableSubmitKYC()
{
var operationType = '<xsl:value-of select="$operationType"/>';

 if(operationType =='EditEntity' || operationType=='Queue')
 {
 if(trim(document.getElementsByName(boName+".riskRating")[0].value)!='')
    {
    document.getElementsByName(boName+".submitForKYC")[0].disabled = false;
   }
   else
   {
   document.getElementsByName(boName+".submitForKYC")[0].disabled = true;
   }
  }
}

function loadKYC()
{
<!-- Changes for tracker id 349409-->
if(entityType != 'Prospect'){
document.getElementsByName(boName+".submitForKYC")[0].disabled = true;
//Changes for tracker id 356560 Start
if(readMode!='Y'){
// Changes for tracker id 423012 start
//document.getElementsByName("3_CorporateBO.KYC_Date")[0].disabled=true;
document.getElementsByName("3_CorporateBO.KYC_Date")[0].readOnly=true;
// Changes for tracker id 423012 end
}
else{
document.getElementsByName("CorporateBO.KYC_Date")[0].disabled=true;
}
if(readMode!='Y'){
// Changes for tracker id 423012 starts
//document.getElementsByName("3_CorporateBO.KYC_ReviewDate")[0].disabled=true;
document.getElementsByName("3_CorporateBO.KYC_ReviewDate")[0].readOnly=true;
// Changes for tracker id 423012 end
}
else{
document.getElementsByName("CorporateBO.KYC_ReviewDate")[0].disabled=true;	
}
 
if(document.getElementsByTagName("img")[7]!= null &amp;&amp; document.getElementsByTagName("img")[7]!= '') {
document.getElementsByTagName("img")[7].style.display='none';
}
if(document.getElementsByTagName("img")[8]!= null &amp;&amp; document.getElementsByTagName("img")[8]!= '') {
document.getElementsByTagName("img")[8].style.display='none';
}
if(readMode!='Y'){
document.getElementsByName("3_CorporateBO.KYC_ReviewDate")[0].value='<xsl:value-of select="$KYC_ReviewDate"/>';
}
else{
document.getElementsByName("CorporateBO.KYC_ReviewDate")[0].value='<xsl:value-of select="$KYC_ReviewDate"/>';	
}
if(readMode!='Y'){
document.getElementsByName("3_CorporateBO.KYC_Date")[0].value='<xsl:value-of select="$KYC_Date"/>';
}
else{
document.getElementsByName("CorporateBO.KYC_Date")[0].value='<xsl:value-of select="$KYC_Date"/>';	
}
//Changes for tracker id 356560 End
}
}
<!-- Changes for KYC Enhancement End-->

<!--Changes for Tracker id: 292552 starts-->
    var Cat_sector = '<xsl:value-of select="$Cat_sector"/>';
    var sector = '<xsl:value-of select="$sector"/>';
<!--Changes for Tracker id: 292552 ends-->

//address -CIF
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
		document.getElementsByName("CorporateBO.Address.preferredAddress")[0].value = DefAdress1;
	}else{
		document.getElementsByName("CorporateBO.Address.preferredAddress")[0].value = "Registered";
	}
}
/* Corp CIF changes for Call id: 346336 : End */
function loadGen(){
if (Cat_sector != 'null' &amp;&amp; Cat_sector != ''){
	// Changes for tracker id 337375 STARTS
	//Changes for 354790 Starts
	var index = Cat_sector.indexOf('#');
	var Cat_Value = Cat_sector.substring(0,index);
	var Cat_textValue = Cat_sector.substring(index+1);
	document.getElementsByName("CorporateBO.sector")[0].value = sector;
	document.getElementsByName("Cat_CorporateBO.sector")[0].value = Cat_textValue;
	//Changes for 354790 Ends
	// Changes for tracker id 337375 ENDS
}
if (isCopy == 'Y')
{
document.getElementsByName("CorporateBO.corp_Key")[0].value='';
}
document.getElementsByName("3_CoreInterfaceBO.OFFLINECUMDEBITLIMIT")[0].disabled=true;

<!--Tracker id 113227 start here-->
 document.frm2.altLocaleActv.value='<xsl:value-of select="$altLocaleActv"/>';
 <!--Tracker id 113227 end here-->
try{


    if(corporateURL == "") {
        if (keyGeneration == 'Both'|| (keyGeneration=="" &amp;&amp; (isAutoGenKey== 'false' || isAutoGenKey == ''))) {
            document.getElementsByName("CorporateBO.corp_Key")[0].readOnly = false;
            if (keyGeneration != 'Both') {
                keyGeneration ='Manual';
            }
        }
    }
    //Key Generation changes start
    else {
        document.getElementsByName("hid_cifid")[0].value = document.getElementsByName("CorporateBO.corp_Key")[0].value;
        //Ticket 323409
	//Changes for 354790 Starts
	if(Cat_lineof != 'null' &amp;&amp; Cat_lineof != ''){
		var index = Cat_lineof.indexOf('#');
		var Cat_Value = Cat_lineof.substring(0,index);
		var Cat_textValue = Cat_lineof.substring(index+1);	
		document.getElementsByName("CorporateBO.Line_of_Activity_Desc")[0].value = lineof;
		document.getElementsByName("Cat_CorporateBO.Line_of_Activity_Desc")[0].value = Cat_textValue;
	}
	//Changes for 354790 Ends
	<!--Changes for Tracker id: 292552 starts-->
		<!--changes for tracker id 349409 BEGIN-->
	if (Cat_sector != 'null' &amp;&amp; Cat_sector != ''){
	document.getElementsByName("CorporateBO.sector")[0].value = sector;
	document.getElementsByName("Cat_CorporateBO.sector")[0].value = Cat_sector;
	}
		<!--changes for tracker id 349409 END-->
	<!--Changes for Tracker id: 292552 ends-->
// Changes for call id 336466 and recon for call id 335111 STARTS
//Changes for tracker ID 430871 begin
	if (Cat_segmentof != 'null' &amp;&amp; Cat_segmentof != '')
	{	
		var index = Cat_segmentof.indexOf('#');
		var Cat_Value = Cat_segmentof.substring(0,index);
		var Cat_textValue = Cat_segmentof.substring(index+1);
		document.getElementsByName("Cat_CorporateBO.segment")[0].value = Cat_textValue;
	}
// Changes for call id 336466 and recon for call id 335111 ENDS 
 <!-- Changes for call id 396783 recon of 393574 STARTS -->
     if (Cat_business_Typeof != 'null' &amp;&amp; Cat_business_Typeof != '')
     	{
			// Change for TOL 667690 starts
    	 	//document.getElementsByName("CorporateBO.business_Type")[0].value = Cat_business_Typeof;
        	//document.getElementsByName("Cat_CorporateBO.business_Type")[0].value = Cat_business_Typeof;
			document.getElementsByName("Cat_"+boName+".business_Type")[0].value = Cat_business_Typeof;
			// Change for TOL 667690 ends
    	}
//Changes for tracker ID 430871 end    	
<!-- Changes for call id 396783 recon of 393574 end -->
        if(isCopy!='Y') {
            /* Changes for Tracker # 166716 BEGIN */
            /*if(entityCreflg == 'N'){
            document.getElementsByName("CorporateBO.corp_Key")[0].disabled = false;
            document.getElementsByName("CorporateBO.corp_Key")[0].readOnly = false;
            }else{*/
            document.getElementsByName("CorporateBO.corp_Key")[0].readOnly = true;
            //}
            /* Changes for Tracker # 166716 END */
        }else{

           /* Changes for tracker 157193 */
             parent.parent.parent.parent.copyCust(isCopy);
           /* End of changes for tracker 157193 */

            if (keyGeneration == 'Both'|| (keyGeneration=="" &amp;&amp; (isAutoGenKey== 'false' || isAutoGenKey == ''))) {
                document.getElementsByName("CorporateBO.corp_Key")[0].readOnly = false;
                if (keyGeneration != 'Both') {
                    keyGeneration ='Manual';
                }
                }
            }
    }

    /* Tracker Id: 160831 Changes Begin*/
        /* Tracker Id: 236094 Changes Begin*/
       //var trade_Services_Availed = document.getElementsByName(boName+".trade_Services_Availed")[0].value;
        if(corporateURL==""  || tsavailedFlg!='Y'){
         /* Tracker Id: 236094 Changes End*/
    document.getElementsByName(boName+".trade_Services_Availed")[0].value="N";
        }
		<!-- Changes for call id:453365 starts-->
		if(PrevEntityType == "Non Customer" &amp;&amp; ConvToCust == 'Y'  &amp;&amp; entityType == "Customer")
	   {
	    document.getElementsByName(boName+".trade_Services_Availed")[0].value="Y";
		loadprimesolid();
		}
<!-- Changes for call id:453365 ends -->

        var TreasuryCounterParty = document.getElementsByName(boNameCI+".TreasuryCounterParty")[0].value;
        //change for callid 396341 begins
        if(TreasuryCounterParty==""){
        //change for callid 396341 ends
        document.getElementsByName(boNameCI+".TreasuryCounterParty")[0].value = "N";
        }
    /* Tracker Id: 160831 Changes End*/
    //Key Generation changes end
    // tracker 104841
    if(readMode=='Y')
    {
           document.getElementsByName("CorporateBO.phone.cntrycode")[0].disabled=true;
               document.getElementsByName("CorporateBO.phone.areacode")[0].disabled=true;
           document.getElementsByName("CorporateBO.phone.localcode")[0].disabled=true;
           document.getElementsByName("Document_Received")[0].disabled=true;
           document.getElementsByName("Assigned_BackendID")[0].disabled=true;

    }
        //formatNumber("2_CorporateBO.registration_Number");
        var tsAvailed = document.getElementsByName("ckTSAvailed")[0];
        tsAvailed.disabled = true;
        var temp = document.getElementsByName("CorporateBO.trade_Services_Availed")[0].value;
    if((temp == null)||(temp == "null")||(temp == ""))
    {
        document.getElementsByName(boNameCI+".TreasuryCounterParty")[0].value = "N";
        //document.getElementsByName(boName+".trade_Services_Availed")[0].value = "N";
    }

customLoad();
}catch(e)
{
}
try{
    var obj = parent.parent.parent.parent.frames(3);
    obj.enableButton_Ub();
}catch(e)
{ }

<!-- Changes DONE for Ticket ID: 242789 and Tracker ID:146625 -->

try{

    sortList('AdrRecordSet');
    deleteList('AdrRecordSet');
    addAddressList('AdrRecordSet');

}
catch(e){}
<!-- Changes ENDS for Ticket ID: 242789 and Tracker ID:146625 -->

try{
  if(document.frm2.hid_corporateURL.value != '') {
editMode = true;
// GroupHouseHold Changes Start
//xml encoding changes- Start
if(boName=='CorporateBO'){
// CIF 10.6 Group Enhancement change 
if(allowMulti=='Y')
{
for (i=0; i &lt; document.all.GroupRecordSet.rows.length; i++) {
    var sGroupID ='';
    var sGroupMasterID='';
    var sPercentShare = '';

    //CRM101UB Changes
    var sGroup_ID = '';
    var sPrim_Grp_ID = '';
    //CRM101UB Changes

        sGroupID = document.all.GroupRecordSet.rows(i).getAttribute("CorporateBO.GroupHouseHold.GroupHouseHoldID");

    if ((sGroupID != null) &amp;&amp; (sGroupID != 'undefined')) {
            sGroupName          = trim(document.all.GroupRecordSet.rows(i).getAttribute("CorporateBO.GroupHouseHold.GroupHouseHoldName"));
            sGroupMasterID      = trim(document.all.GroupRecordSet.rows(i).getAttribute("CorporateBO.GroupHouseHold.GroupHouseHoldMasterID"));
            sPercentShare       = trim(document.all.GroupRecordSet.rows(i).getAttribute("CorporateBO.GroupHouseHold.Shareholding_in_percentage"));
            sGroupCode          = trim(document.all.GroupRecordSet.rows(i).getAttribute("CorporateBO.GroupHouseHold.GroupHouseHoldCode"));
        //CRM101UB Changes
            sGroup_ID       = trim(document.all.GroupRecordSet.rows(i).getAttribute("CorporateBO.GroupHouseHold.GROUP_ID"));
            sPrim_Grp_ID            = trim(document.all.GroupRecordSet.rows(i).getAttribute("CorporateBO.GroupHouseHold.PRIMARY_GROUP_INDICATOR"));
        //CRM101UB Changes
        if(sPercentShare=="") sPercentShare=0;

        GroupName[GroupName.length]         = sGroupName;
        GroupID[GroupID.length]             = sGroupID;
        GroupCode[GroupCode.length]         = sGroupCode;
        GroupMasterID[GroupMasterID.length] = sGroupMasterID;
        PercentShare[PercentShare.length]   = sPercentShare;
        GroupURL[GroupURL.length]           = sGroupName + sGroupCode;
        LinkedGroups[LinkedGroups.length]   = sGroupCode;

        //CRM101UB changes
        Group_ID[Group_ID.length]       = sGroup_ID;
        Prim_Grp_ID[Prim_Grp_ID.length]     = sPrim_Grp_ID;
        //CRM101UB changes

        TotalPercent = TotalPercent + eval(sPercentShare);
        document.all.GroupRecordSet.rows(i).setAttribute('RowID', i-2);
            document.all.GroupRecordSet.rows(i).setAttribute("CorporateBO.GroupHouseHold.url_", sGroupName + sGroupCode);

    }

    recordIndex1 = i-2;
}
}
// GroupHouseHold Changes End
    /* CIF PhoneEmail Changes : Start */
    for (i=0; i &lt; document.all.PhoneEmailRecordSet.rows.length; i++) {
            var phoneEmailId ='';
        phoneEmailId = document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateBO.PhoneEmail.PhoneEmailID");
        if ((phoneEmailId != null) &amp;&amp; (phoneEmailId != 'undefined') &amp;&amp; phoneEmailId != "") {

            email  = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateBO.PhoneEmail.Email"));
            phoneNo = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateBO.PhoneEmail.PhoneNo"));
            phoneOrEmail = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateBO.PhoneEmail.PhoneOrEmail"));
            if(phoneOrEmail == "PHONE")
            {
                phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateBO.PhoneEmail.PhoneEmailType"));
                phoneEmail_URL[phoneEmail_URL.length] = phoneNo + phoneEmailType;
                document.all.PhoneEmailRecordSet.rows(i).setAttribute("CorporateBO.PhoneEmail.url_", phoneNo + phoneEmailType);
                document.all.PhoneEmailRecordSet.rows(i).setAttribute("CorporateBO.PhoneEmail.PhoneEmailType",phoneEmailType);
            }
            else
            {
                phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateBO.PhoneEmail.PhoneEmailType"));
                phoneEmail_URL[phoneEmail_URL.length] = email + phoneEmailType;
                document.all.PhoneEmailRecordSet.rows(i).setAttribute("CorporateBO.PhoneEmail.url_", email + phoneEmailType);
                document.all.PhoneEmailRecordSet.rows(i).setAttribute("CorporateBO.PhoneEmail.PhoneEmailType1",phoneEmailType);

            }
            phoneNoCountryCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateBO.PhoneEmail.PhoneNoCountryCode"));
            phoneNoCityCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateBO.PhoneEmail.PhoneNoCityCode"));
            phoneNoLocalCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateBO.PhoneEmail.PhoneNoLocalCode"));
            extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateBO.PhoneEmail.WorkExtension"));
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
            /* Begin changes Tracker ID: 181584*/
            //ad_extension[ad_extension.length] = extension;
            /* End changes Tracker ID: 181584*/
            phoneEmail_Status[phoneEmail_Status.length] = "Add";
        }
    }
    /* changes STARTfor ticket no-602725*/
    preferredPhone='<xsl:value-of select = "$preferredPhone"/>';
    //alert("preferredPhone1111111111"+preferredPhone);
    setPrefValue(preferredPhone,'CorporateBO.PhoneEmail.PhoneEmailType');
    preferredEmail='<xsl:value-of select = "$preferredEmail"/>';
    //alert("preferredEmail1111111111111"+preferredEmail);
setPrefValue(preferredEmail,'CorporateBO.PhoneEmail.PhoneEmailType1');
/* changes END for ticket no-602725*/
    		if(preferredAddressType != ""){
    			document.getElementsByName("CorporateBO.Address.preferredAddress")[0].value = '<xsl:value-of select = "$preferredAddressType"/>';
    		}else{
    			document.getElementsByName("CorporateBO.Address.preferredAddress")[0].value = '<xsl:value-of select = "Registered"/>';
    		}
}else if(boName=='CorporateModBO'){
	// CIF 10.6 Group Enhancement change
	if(allowMulti=='Y')
	{
    for (i=0; i &lt; document.all.GroupRecordSet.rows.length; i++) {
        var sGroupID ='';
        var sGroupMasterID='';
        var sPercentShare = '';

        //CRM101UB Changes
        var sGroup_ID = '';
        var sPrim_Grp_ID = '';
        //CRM101UB Changes

        sGroupID = document.all.GroupRecordSet.rows(i).getAttribute("CorporateModBO.GroupHouseHold.GroupHouseHoldID");

        if ((sGroupID != null) &amp;&amp; (sGroupID != 'undefined')) {
            sGroupName          = trim(document.all.GroupRecordSet.rows(i).getAttribute("CorporateModBO.GroupHouseHold.GroupHouseHoldName"));
            sGroupMasterID      = trim(document.all.GroupRecordSet.rows(i).getAttribute("CorporateModBO.GroupHouseHold.GroupHouseHoldMasterID"));
            sPercentShare       = trim(document.all.GroupRecordSet.rows(i).getAttribute("CorporateModBO.GroupHouseHold.Shareholding_in_percentage"));
            sGroupCode          = trim(document.all.GroupRecordSet.rows(i).getAttribute("CorporateModBO.GroupHouseHold.GroupHouseHoldCode"));
            //CRM101UB Changes
            sGroup_ID       = trim(document.all.GroupRecordSet.rows(i).getAttribute("CorporateModBO.GroupHouseHold.GROUP_ID"));
            sPrim_Grp_ID            = trim(document.all.GroupRecordSet.rows(i).getAttribute("CorporateModBO.GroupHouseHold.PRIMARY_GROUP_INDICATOR"));
            //CRM101UB Changes
            if(sPercentShare=="") sPercentShare=0;

            GroupName[GroupName.length]         = sGroupName;
            GroupID[GroupID.length]             = sGroupID;
            GroupCode[GroupCode.length]         = sGroupCode;
            GroupMasterID[GroupMasterID.length] = sGroupMasterID;
            PercentShare[PercentShare.length]   = sPercentShare;
            GroupURL[GroupURL.length]           = sGroupName + sGroupCode;
            LinkedGroups[LinkedGroups.length]   = sGroupCode;

            //CRM101UB changes
            Group_ID[Group_ID.length]       = sGroup_ID;
            Prim_Grp_ID[Prim_Grp_ID.length]     = sPrim_Grp_ID;
            //CRM101UB changes

            TotalPercent = TotalPercent + eval(sPercentShare);
            document.all.GroupRecordSet.rows(i).setAttribute('RowID', i-2);
            document.all.GroupRecordSet.rows(i).setAttribute("CorporateModBO.GroupHouseHold.url_", sGroupName + sGroupCode);
        }

        recordIndex1 = i-2;
    }
    // GroupHouseHold Changes End
    /* CIF PhoneEmail Changes : Start */
    for (i=0; i &lt; document.all.PhoneEmailRecordSet.rows.length; i++) {
            var phoneEmailId ='';
        phoneEmailId = document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateModBO.PhoneEmail.PhoneEmailID");
        if ((phoneEmailId != null) &amp;&amp; (phoneEmailId != 'undefined') &amp;&amp; phoneEmailId != "") {

            email  = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateModBO.PhoneEmail.Email"));
            phoneNo = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateModBO.PhoneEmail.PhoneNo"));
            phoneOrEmail = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateModBO.PhoneEmail.PhoneOrEmail"));
            if(phoneOrEmail == "PHONE")
            {
                phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateModBO.PhoneEmail.PhoneEmailType"));
                phoneEmail_URL[phoneEmail_URL.length] = phoneNo + phoneEmailType;
                document.all.PhoneEmailRecordSet.rows(i).setAttribute("CorporateModBO.PhoneEmail.url_", phoneNo + phoneEmailType);
                document.all.PhoneEmailRecordSet.rows(i).setAttribute("CorporateModBO.PhoneEmail.PhoneEmailType",phoneEmailType);
            }
            else
            {
                phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateModBO.PhoneEmail.PhoneEmailType"));
                phoneEmail_URL[phoneEmail_URL.length] = email + phoneEmailType;
                document.all.PhoneEmailRecordSet.rows(i).setAttribute("CorporateModBO.PhoneEmail.url_", email + phoneEmailType);
                document.all.PhoneEmailRecordSet.rows(i).setAttribute("CorporateModBO.PhoneEmail.PhoneEmailType1",phoneEmailType);

            }
            phoneNoCountryCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateModBO.PhoneEmail.PhoneNoCountryCode"));
            phoneNoCityCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateModBO.PhoneEmail.PhoneNoCityCode"));
            phoneNoLocalCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateModBO.PhoneEmail.PhoneNoLocalCode"));
            extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("CorporateModBO.PhoneEmail.WorkExtension"));
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
            /* Begin changes Tracker ID: 181584*/
            //ad_extension[ad_extension.length] = extension;
            /* End changes Tracker ID: 181584*/
            phoneEmail_Status[phoneEmail_Status.length] = "Add";
        }
//xml encoding changes- end
        }
    }
 <!-- changes for recon 386149,call id : 384588 starts-->
}
 <!-- changes for recon 386149,call id : 384588 ends-->
    //document.getElementsByName("CorporateBO.Address.preferredAddress")[0].value = '<xsl:value-of select = "$preferredAddressType"/>';
    
    //changes for tracker 353400 starts --- when address is not added the preferredAddressType would be null so inorder to set it to default address as per admin we placed a null check for preferredAddressType
    		if(preferredAddressType != ""){
    			document.getElementsByName("CorporateBO.Address.preferredAddress")[0].value = '<xsl:value-of select = "$preferredAddressType"/>';
    		}else{
    			document.getElementsByName("CorporateBO.Address.preferredAddress")[0].value = '<xsl:value-of select = "Registered"/>';
    		}
    	//changes for tracker 353400 ends
/* Changes for Call id 312826  starts */

    /*document.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType")[0].value = '<xsl:value-of select = "$preferredPhone"/>'; */
    /*document.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType1")[0].value = '<xsl:value-of select = "$preferredEmail"/>'; */
preferredPhone='<xsl:value-of select = "$preferredPhone"/>';
setPrefValue(preferredPhone,'CorporateBO.PhoneEmail.PhoneEmailType');
preferredEmail='<xsl:value-of select = "$preferredEmail"/>';
setPrefValue(preferredEmail,'CorporateBO.PhoneEmail.PhoneEmailType1');
/* Changes for Call id 312826  Ends */
    /* CIF PhoneEmail Changes : End */
} else {
//xml encoding changes- Start
    if(boName=='CorporateBO'){
for (i=0; i &lt; document.all.AdrRecordSet.rows.length; i++) {
            var addrID = document.all.AdrRecordSet.rows(i).getAttribute("CorporateBO.Address.addressID");
            if ((addrID != null) &amp;&amp; (addrID != 'undefined')) {
            address_type = document.all.AdrRecordSet.rows(i).getAttribute("CorporateBO.Address.addressCategory");
            end_date  = document.all.AdrRecordSet.rows(i).getAttribute("CorporateBO.Address.End_Date");
            start_date = document.all.AdrRecordSet.rows(i).getAttribute("CorporateBO.Address.Start_Date");
            document.all.AdrRecordSet.rows(i).setAttribute("CorporateBO.Address.addressCategory", address_type);
            document.all.AdrRecordSet.rows(i).setAttribute("CorporateBO.Address.End_Date", end_date);
            document.all.AdrRecordSet.rows(i).setAttribute("CorporateBO.Address.Start_Date", start_date);
            ad_address_type[ad_address_type.length] = address_type;
            ad_end_date[ad_end_date.length] = ad_end_date;
            ad_start_date[ad_start_date.length] = ad_start_date;
            ad_addrID[ad_addrID.length] = addrID;
            ad_city_code[ad_city_code.length] = ad_city_code;
            ad_state_code[ad_state_code.length] = ad_state_code;
            ad_cntry_code[ad_cntry_code.length] = ad_cntry_code;
            }
        }

    }else if(boName=='CorporateModBO'){
        for (i=0; i &lt; document.all.AdrRecordSet.rows.length; i++) {
    var addrID = document.all.AdrRecordSet.rows(i).getAttribute("CorporateModBO.Address.addressID");
    if ((addrID != null) &amp;&amp; (addrID != 'undefined')) {
            address_type = document.all.AdrRecordSet.rows(i).getAttribute("CorporateModBO.Address.addressCategory");
            end_date  = document.all.AdrRecordSet.rows(i).getAttribute("CorporateModBO.Address.End_Date");
            start_date = document.all.AdrRecordSet.rows(i).getAttribute("CorporateModBO.Address.Start_Date");
            document.all.AdrRecordSet.rows(i).setAttribute("CorporateModBO.Address.addressCategory", address_type);
            document.all.AdrRecordSet.rows(i).setAttribute("CorporateModBO.Address.End_Date", end_date);
    document.all.AdrRecordSet.rows(i).setAttribute("CorporateModBO.Address.Start_Date", start_date);
    ad_address_type[ad_address_type.length] = address_type;
    ad_end_date[ad_end_date.length] = ad_end_date;
    ad_start_date[ad_start_date.length] = ad_start_date;
    ad_addrID[ad_addrID.length] = addrID;
    ad_city_code[ad_city_code.length] = ad_city_code;
    ad_state_code[ad_state_code.length] = ad_state_code;
    ad_cntry_code[ad_cntry_code.length] = ad_cntry_code;
    }
}
    }
   //xml encoding changes- end
    var locDate = getCurrentDate();
    <!--ERPBOCF1:TRACKER:113259:MATPT FIX FOR DEFECT START-->
    <!--Relationship start date was not coming according to SSO calendar type-->
    if(calType=='H')
    {
        locDate = convertGregToHij(locDate);
    }
    <!--ERPBOCF1:TRACKER:113259:MATPT FIX FOR DEFECT END-->
    document.getElementsByName('3_CorporateBO.relationship_StartDate')[0].value = locDate;
}
 <!-- changes for recon 386149,call id : 384588 starts-->
//}
 <!-- changes for recon 386149,call id : 384588 ends-->
}catch(e){
}
}
//address- corpCIF
//ID details- corpCIF
//function loadID() moved to CorpGenCust.js -IDENTIFICATION DOCUMENT CHANGES
//ID details- corpCIF
<!-- Changes for call id:453365 starts-->
function loadprimesolid(){
       
         var indexValue= Cat_bcName.indexOf('#');  
			
			
         var Cat_value=Cat_bcName.substring(0,indexValue); 
			
         var Cat_textValue = Cat_bcName.substring(indexValue+1);   
			
         document.getElementsByName("Cat_CorporateBO.primary_Service_Center")[0].value = Cat_textValue;   
         document.getElementsByName("CorporateBO.primary_Service_Center")[0].value = Cat_value;   
         

}
<!-- Changes for call id:453365 ends -->
function loadCode() {
//xml encoding changes- Start
    if(boNameCI=='CoreInterfaceBO'){
        document.getElementsByName('CoreInterfaceBO.FreeCode1Desc')[0].value = '<xsl:value-of select="$FreeCode1Desc"/>';
            document.getElementsByName('CoreInterfaceBO.FreeCode2Desc')[0].value = '<xsl:value-of select="$FreeCode2Desc"/>';
            document.getElementsByName('CoreInterfaceBO.FreeCode3Desc')[0].value = '<xsl:value-of select="$FreeCode3Desc"/>';
            document.getElementsByName('CoreInterfaceBO.FreeCode4Desc')[0].value = '<xsl:value-of select="$FreeCode4Desc"/>';
            document.getElementsByName('CoreInterfaceBO.FreeCode5Desc')[0].value = '<xsl:value-of select="$FreeCode5Desc"/>';
            document.getElementsByName('CoreInterfaceBO.FreeCode6Desc')[0].value = '<xsl:value-of select="$FreeCode6Desc"/>';
            document.getElementsByName('CoreInterfaceBO.FreeCode7Desc')[0].value = '<xsl:value-of select="$FreeCode7Desc"/>';
            document.getElementsByName('CoreInterfaceBO.FreeCode8Desc')[0].value = '<xsl:value-of select="$FreeCode8Desc"/>';
            document.getElementsByName('CoreInterfaceBO.FreeCode9Desc')[0].value = '<xsl:value-of select="$FreeCode9Desc"/>';
            document.getElementsByName('CoreInterfaceBO.FreeCode10Desc')[0].value = '<xsl:value-of select="$FreeCode10Desc"/>';
    }else if(boNameCI=='CoreInterfaceModBO'){

            document.getElementsByName('CoreInterfaceModBO.FreeCode1Desc')[0].value = '<xsl:value-of select="$FreeCode1Desc"/>';
            document.getElementsByName('CoreInterfaceModBO.FreeCode2Desc')[0].value = '<xsl:value-of select="$FreeCode2Desc"/>';
            document.getElementsByName('CoreInterfaceModBO.FreeCode3Desc')[0].value = '<xsl:value-of select="$FreeCode3Desc"/>';
            document.getElementsByName('CoreInterfaceModBO.FreeCode4Desc')[0].value = '<xsl:value-of select="$FreeCode4Desc"/>';
            document.getElementsByName('CoreInterfaceModBO.FreeCode5Desc')[0].value = '<xsl:value-of select="$FreeCode5Desc"/>';
            document.getElementsByName('CoreInterfaceModBO.FreeCode6Desc')[0].value = '<xsl:value-of select="$FreeCode6Desc"/>';
            document.getElementsByName('CoreInterfaceModBO.FreeCode7Desc')[0].value = '<xsl:value-of select="$FreeCode7Desc"/>';
            document.getElementsByName('CoreInterfaceModBO.FreeCode8Desc')[0].value = '<xsl:value-of select="$FreeCode8Desc"/>';
            document.getElementsByName('CoreInterfaceModBO.FreeCode9Desc')[0].value = '<xsl:value-of select="$FreeCode9Desc"/>';
            document.getElementsByName('CoreInterfaceModBO.FreeCode10Desc')[0].value = '<xsl:value-of select="$FreeCode10Desc"/>';
            }
}
var isReadOnly;
function swifta()
{
    try{
        document.getElementsByName("Swift Address Details")[0].disabled = false;
        }catch(e){
        alert(e.message);
        }
    isReadOnly="Y";
	<!-- CRM102BETA:TrackerID:194036 Being of Change -->
	//document.getElementsByName("Close")[0].disabled = false;
	<!-- CRM102BETA:TrackerID:194036 End of Change -->
    }
//xml encoding changes- end
function clearSwift()
{
    expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));
    setCookie('SwiftAddressDetails', "", expirationdate);
}
function loadbutton() {
    try{
        var obj = parent.parent.parent.parent.frames(3);
        obj.enableButton_Ub();
    }catch(e)
    { }

}
function setFocusOnComp(compName) {

   var object = "";


        // vasanth's changes start
        if(Screen == 5){
        //Demographic


        var tabname='Trade Finance'
            parent.parent.parent.parent.tabViewFrm.selectTab(tabname);
            object = "parent.parent.IFrmtab5.formDispFrame.";
        }else if(Screen == 2){
        //psychographic
            parent.parent.parent.parent.tabViewFrm.selectTab('Preferences');
            object = "parent.parent.IFrmtab2.formDispFrame."
        }else if(Screen == 3){
        //Trade Finance
            parent.parent.parent.parent.tabViewFrm.selectTab('Financial');
            object = "parent.parent.IFrmtab3.formDispFrame."
        }else{
        }
        // vasanth's changes end


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

        function showDeleteButton()
        {
            if(document.frm2.hid_corporateURL.value != '')
            {
               parent.parent.parent.parent.showDelButton(true);
            }
            else
            {
                 parent.parent.parent.parent.showDelButton(false);
            }
        }
<![CDATA[
function closebtnNew(){
/* tracker Id: 173412 Changes begin */
/*Changes for tracker 231796 starts*/
parent.frames(0).location.href = parent.frames(0).location.href;
//document.location.reload(true);
/*Changes for tracker 231796 ends*/
/* tracker Id: 173412 Changes end */
}
function closebtn(){
if(corporateURL=='')
{
		//parent.frames(0).location.href = parent.frames(0).location.href;
		/*Changes by Niharika to call a new screen like Customer Onboard*/	
		var dataArea = parent.parent.parent.parent.parent;
		var screenTitle= parent.parent.parent.parent.parent.parent.ScreenTitleFrm;
		screenTitle.titleMsg.innerHTML = "CIF Retail > New Entity > Customer Onboarding";
		dataArea.location.href="../../../servlet/com.infy.cis.custom.OnboardDetWizard?type=Corporate";
		/*End of changes by Niharika to call a new screen like Customer Onboard*/
}
else
if ((isCopy=='Y')||(readMode=='Y') ||(ConvToCust=='Y') || ((corporateURL!='')&&(boName=='CorporateModBO')) ||  ((corporateURL!='')&&(boName=='CorporateBO')))
{
top.window.close();
}
else
history.go(-1);
}
]]>
    </script>
<!-- Changes done by Bharath -->
<script type="text/javascript" language="javascript">
function crncyDefaultPop()
{
	document.getElementsByName("CorporateBO.StrUserField14")[0].selectedIndex = 1;
	var URL = "";
	var CustomerCurrency = '<xsl:value-of select="$BaseCurrency"/>'
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
				CustomerCurrency);
}
</script>
     </head>
     
<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 -->
     <body class="popup"  onkeypress="onLoadSetTime()" onclick="onLoadSetTime()">
<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 -->


     <xsl:choose>
     <xsl:when test="normalize-space($corporateURL)=''">
        <!-- Tracker ID 131246 CHANGES BEGIN BY Sonali -->
    <!-- Calling the DisableGcifIdLookUp function to disable GCIF ID lookup in Edit and View mode -->
    <!-- Tracker ID-153485;Sanity Fix  -->
    <!-- load() function is renamed to loadGen() -->  
     <!--ticket id 231104 changes starts-->
     <!--tracker id 304731 changes starts-->
     <!--tracker id 554568 changes starts-->
      <!--Changes for not auto populating Primary Sol id starts-->
			<!--Changes for call id 346337 Start -->
        <xsl:attribute name="onload">crncyDefaultPop();langDesc();populateAccContAttr();loadID();loadGen();makekeyMand();loadKYC();focusFirstField();loadrel();DisableGcifIdLookUp();loadZakat();loadBaseCurrency();isTFPartyFlag();loadBasel();makeSwiftFldMand();storeSegment();showbuttonsVisible(45);swifta();loadAddressType();
			<!--Changes for call id 346337 Ends -->
         <!--Changes for not auto populating Primary Sol id ends-->
     <!--tracker id 554568 changes ends-->
     <!--tracker id 304731 changes ends-->
<!--tracker id 231104 changes ends-->
        <!-- Tracker ID-153485;Sanity Fix  -->
            <!-- Tracker ID 131246 CHANGES END BY sonali -->
        </xsl:attribute>
     </xsl:when>
     <xsl:when test="normalize-space($IsDummy)='Y'">
        <!-- Tracker ID 131246 CHANGES BEGIN BY Sonali -->
        <!-- Tracker ID-153485;Sanity Fix  --> 
        <!--tracker id 231104 changes starts-->
        <!--tracker id 554568 changes starts-->        
             <xsl:attribute name="onload">langDesc();loadID();loadKYC();loadGen();changeSubSeg();loadrel();DisableGcifIdLookUp();focusFirstField();loadBackEnd();showbuttonsVisible(30);showFormTips();loadSubSeg();loadSegVal();clearDummyAddress('<xsl:value-of select="$IsDummy"/>');fnNullifyDummyCustFlds('<xsl:value-of select="$IsDummy"/>');chkBSN();populateAccContAttr();loadBaseCurrency();makekeyMand();storeSegment();loadCode();makeSwiftFldMand();isTFPartyFlag();loadBasel();swifta();
    <!--tracker id 554568 changes ends-->
    <!--tracker id 231104 changes ends-->
    <!-- Tracker ID 131246 CHANGES END BY sonali -->
             </xsl:attribute>
      </xsl:when>
     <xsl:when test="normalize-space($readMode)='Y'">
        <!-- Tracker ID 131246 CHANGES BEGIN BY Sonali -->
        <!-- Tracker ID-153485;Sanity Fix  -->
        <!-- Fix for Ticket 297282 - START -->
        <!-- Changes for the ticket 305073 starts --> 
	   <!--tracker id 231104 changes starts-->
	   <!--fix for 554284 changes starts-->
<!-- changes for tracker 336728: removing call to loadSubSeg() -->
<!--tracker id 554568 changes starts-->
<!--ticket id 438296 changes starts-->
	   <!-- Changes for the tracker id 351596 STARTS -->
        <xsl:attribute name="onload">langDesc();loadID();showInReadOnlyMode('<xsl:value-of select="$readMode"/>');loadGen();changeSubSeg();loadSegVal();loadrel();loadKYC();loadBaseCurrency();DisableGcifIdLookUp();populateAccContAttr();swifta();loadBackEnd();chkBSN();isTFPartyFlag();loadBasel();loadCode();makeSwiftFldMand();
     <!-- Changes for the tracker id 351596 ENDS -->
<!--ticket id 438296 changes ends-->
    <!--tracker id 554568 changes ends-->
    <!--tracker id 231104 changes ends-->
     <!--fix for 554284 changes ends-->
        <!-- Changes for the ticket 305073 ends -->
        <!-- Fix for Ticket 297282 - END -->
        <!-- Tracker ID 131246 CHANGES END BY sonali -->
        </xsl:attribute>
     </xsl:when>
     <xsl:otherwise>
        <!--CRM95BETA : TRACKER#:121447 - START OF CHANGES-->
    <!-- Added makeSwiftFldMand in onload to make mandatory star appear while editing  -->
    <!-- Tracker ID-153485;Sanity Fix  --> 
 <!--224053 Changes start-->
<!--changes for ticket id 432983 start --> 
<!--changes for ticket id 438296 start -->
<!-- Changes for ticket id 510098 starts-->
<!-- changes for tracker 336728: removing call to loadSubSeg() -->

 <!--tracker id 554568 changes starts-->
 <xsl:attribute name="onload">langDesc();loadID();changeSubSeg();loadSegVal();loadGen();onLoadCurrency();loadrel();DisableGcifIdLookUp();loadbutton();focusFirstField();hideFields();loadBackEnd();showbuttonsVisible(30);showFormTips();clearDummyAddress('<xsl:value-of select="$IsDummy"/>');fnNullifyDummyCustFlds('<xsl:value-of select="$IsDummy"/>');chkBSN();populateAccContAttr();loadBaseCurrency();makekeyMand();storeSegment();loadCode();makeSwiftFldMand();isTFPartyFlag();loadBasel();swifta();loadKYC();loadAddressType();
<!--tracker id 554568 changes ends-->
<!-- Changes for ticket id 510098 ends-->
<!--changes for ticket id 438296 end --> 
<!--changes for ticket id 432983 end -->  
<!--224053 Changes ends-->
         <!--CRM95BETA : TRACKER#:121447 - END OF CHANGES-->
            <!-- Tracker ID 131246 CHANGES END BY sonali -->
<!-- ERPBOCF1: ticket id 204295 changes end  -->
 <!-- ticket id 202173 changes end -->
          </xsl:attribute>
     </xsl:otherwise>
     </xsl:choose>

        <script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>

        <!--CIF Ret-Corp-Syncup Changes Start-->
         <script type="text/javascript" src="../common/js/ContextSwitch.js" language="javascript"></script>
        <!--CIF Ret-Corp-Syncup Changes End-->

        <script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
        <script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
        <script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/ListBoxFunctions.js" language="javascript"></script>
        <!-- Fix for defect Ticket id : 204734 part(a) Begin of Changes -->
      <!--  <script type="text/javascript" src="../common/js/PopupMenu.js"></script> -->
        <!-- Fix for defect Ticket id : 204734 part(a) end of Changes -->
        <script type="text/html" src="../Renderer/wizards/html/CorpCifShowButtons.html"></script>
        <script type="text/html" src="../Renderer/wizards/html/ShowButtons.html"></script>
        <!-- Tracker ID Begins : 209607 -->
        <!--Division of js start-->
        <script type="text/javascript" language="javascript" src="../corpcif/js/CorpGenCust_QDE.js"></script>
        <script type="text/javascript" language="javascript" src="../Customization/corpcif/js/CorpGenCust.js"></script>
        <!--Division of js end-->
        <!-- Tracker ID ends : 209607 -->
        <!--CIF GroupHouseHold Changes Start-->
        <script type="text/javascript" language="javascript" src="../corpcif/js/Group.js"></script>
        <!--CIF GroupHouseHold Changes Start-->
    <!-- CIF PhoneEmail Changes : Start -->
        <!-- tracker ID Begins : 209607 -->
    <!--Division of js start-->
       <script type="text/javascript" language="javascript" src="../Customization/corpcif/js/CorpCIFAddress.js"></script>
       <script type="text/javascript" language="javascript" src="../corpcif/js/CorpCIFAddress_RCL.js"></script>
	   <!-- 10.2.14 Changes : Start -->
	  <script type="text/javascript" src="../cif/js/CifGroupLookup_System.js" language="javascript"></script> 
       <script type="text/javascript" src="../cif/js/Group.js" language="javascript"></script> 
	   <!-- 10.2.14 Changes : end -->
    <!--Division of js end-->
        <!-- Tracker ID ends : 209607 -->
       <script type="text/javascript" language="javascript" src="../corpcif/js/CorpCIFPhoneEmail.js"></script>
    <!-- CIF PhoneEmail Changes : End -->
        <script type="text/javascript" language="javascript">
        var DataArray = new Array;
        var baseCurrency = null;

        // vasanth's changes start
            var Screen = "";
        // vasanth's changes end

<![CDATA[function showFormTips() {
parent.parent.parent.parent.removeTips(parent.parent.parent.parent.frames(0).getSelectedTabId());
parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(),"]]><xsl:value-of select="$SRMTips"/><![CDATA[");
parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames(0).getSelectedTabId());
parent.parent.parent.parent.showTipsButton();
}
]]>



    /*Fix for 286045, so that the same function in RendValidate is called
    function txtLimit(field, max,str1,str2) {
                if (field.value.length > max + 1){
                var tempList = new Array();
    tempList[0] = str2;
    tempList[1] = max;
    showUserMessage(MSGX0037,tempList);
                document.getElementsByName(str1)[0].focus();
                return "interactive"
                }
            }*/


       function Toggle_func(id){
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


function clos(f){
    var newwin = window.open('../common/html/SSOblank.html', 'Save', 'directories=No, height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
    f.target='Save';
    f.submit();
 }
                function cls(){
                     self.close();
                }

        <!--// Tracker ID : 68932 Begin of Changes  -->
        function validateKeys(){

            if((event.keyCode&gt;47&amp;&amp;event.keyCode&lt;58)||(event.keyCode&gt;96&amp;&amp;event.keyCode&lt;123)||(event.keyCode&gt;64&amp;&amp;event.keyCode&lt;91)){
                }
            else{
                showMessage(MSGX0038);
                event.keyCode = 0;
                return false;
            }
        }
	//Validate Tax PIN--------CHG0031878-------start-->
		function validatetaxID(StrUserField8)
		{
				var krapin= StrUserField8.value;
				var regex = /^B[0-9A-Z]{14}$/;

				if(! regex.test(krapin)){
					alert('TAX PIN should be 15 characters containing any letter(s) A-Z and number(s) 0-9');
					setTimeout(function() { StrUserField8.focus(); }, 0);
					return false;
				}

				return true;

						
		}
	//Validate Tax PIN--------CHG0031878-------End -->

        <!--// Tracker ID : 68932 End of Changes-->
                </script>
                 <!--javascript ends here-->
                <table align='center' width="100%" cellpadding="0" cellspacing="0">
                     <xsl:apply-templates select="SRM"/>
                 </table>
      </body>
                </html>







                        </xsl:template>
                                  <xsl:template name="show_account_buttons">
                                  <xsl:choose>
                                        <xsl:when test= "normalize-space($corporateURL)=''">
                                            <xsl:call-template name="user_button_withText">
                                            <xsl:with-param name="button_name">Save</xsl:with-param>
                                            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Save']/@configLabel"/></xsl:with-param>
                                            <xsl:with-param name="button_fnc">SaveAccount(document.frm2)</xsl:with-param>
                                           </xsl:call-template>&#160;
                                            <xsl:call-template name="user_button_withText">
                                            <xsl:with-param name="button_name">Cancel</xsl:with-param>
                                            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Cancel']/@configLabel"/></xsl:with-param>
                                            <xsl:with-param name="button_fnc">cls()</xsl:with-param>
                                           </xsl:call-template>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:call-template name="user_button_withText">
                                            <xsl:with-param name="button_name">Update</xsl:with-param>
                                            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Update']/@configLabel"/></xsl:with-param>
                                            <xsl:with-param name="button_fnc">SaveAccount(document.frm2)</xsl:with-param>
                                </xsl:call-template>&#160;
                                            <xsl:call-template name="user_button_withText">
                                            <xsl:with-param name="button_name">Cancel</xsl:with-param>
                                            <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Cancel']/@configLabel"/></xsl:with-param>
                                            <xsl:with-param name="button_fnc">cls()</xsl:with-param>
                                    </xsl:call-template>
                                        </xsl:otherwise>
                                  </xsl:choose>
</xsl:template>
        <!--<xsl:template name="CorporateBO.entityClass">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.entityClass']"/>
        <xsl:with-param name="ele_name">CorporateBO.entityClass</xsl:with-param>
        <xsl:with-param name="ele_val">CorporateBO.entityClass</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        </xsl:call-template>
        </xsl:template> -->
        <xsl:template name="CorporateBO.corporate_Name">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.corporate_Name']"/>
        <xsl:with-param name="ele_name">CorporateBO.corporate_Name</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.corporate_Name</xsl:with-param>
        <xsl:with-param name="checkASCII">false</xsl:with-param>
        <!-- Field Rationalization changes start -->
	<!--changes for call id::572933 begins-->
        <!--<xsl:with-param name="max_length">100</xsl:with-param> -->
	<!--changes for call id::572933 ends-->
        <!-- Field Rationalization changes end -->
		<xsl:with-param name="fn_onBlur">corpNameTrim();</xsl:with-param>
<!-- Fix for call id: 428627 Ends -->
        </xsl:call-template>
        </xsl:template>
               <!-- Tracker 113227 changes BEGIN-->
  <!--Begin Of Changes, ME Phase 3 Tracker ID:131246
            Changes by neha_goel03 for GCIF LookUp
            Added this template for GCIF LookUp
            -->
                <xsl:template name="CorporateBO.GCIFID">
                <xsl:call-template name="lookup">
                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.GCIFID']"/>
                <xsl:with-param name="elename">CorporateBO.GcifId</xsl:with-param>
                <xsl:with-param name="ele_name">CorporateBO.GCIFID</xsl:with-param>
                <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
                <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
                <xsl:with-param name="buttonone_fnc">fnCorpGCIFLookup()</xsl:with-param>
                <xsl:with-param name="buttontwo_fnc">clearGCIFLookupOne()</xsl:with-param>
                </xsl:call-template>
                </xsl:template>

<!--End of changes by neha_goel03 for GCIF LookUp-->
<!--tracker id 231104 changes starts-->
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
 <!--tracker id 231104 changes ends-->
        <xsl:template name="CorporateBO.corporate_Name_alt1">
                <xsl:call-template name="label_alternate">
                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.corporate_Name']"/>
                <xsl:with-param name="ele_name">CorporateBO.corporate_Name_alt1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.corporate_Name_alt1</xsl:with-param>
                <xsl:with-param name="checkASCII">false</xsl:with-param>
<!-- Fix for call id: 428627 Starts -->
				<xsl:with-param name="max_length">80</xsl:with-param>
<!-- Fix for call id: 428627 Ends -->
                </xsl:call-template>
                </xsl:template>
<!--10.2.14 enhancements starts-->

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
                   <xsl:with-param name="max_length">10</xsl:with-param> 
                   <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.GroupHouseHold.GROUP_ID']" /> 
    
                   <xsl:with-param name="starshow">false</xsl:with-param> 
           </xsl:call-template> 
   </xsl:template>

				
<!--10.2.14 enhancements ends-->


        <xsl:template name="CorporateBO.short_Name_alt1">
            <xsl:call-template name="label_alternate">
            <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.short_Name']"/>
            <xsl:with-param name="ele_name">CorporateBO.short_Name_alt1</xsl:with-param>
            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_Name_alt1</xsl:with-param>
            <xsl:with-param name="checkASCII">false</xsl:with-param>
            <xsl:with-param name="max_length">10</xsl:with-param>
            </xsl:call-template>
            </xsl:template>


        <xsl:template name="CorporateBO.keyContact_PersonName_alt1">
                <xsl:call-template name="label_alternate">
                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.keyContact_PersonName']"/>
                <xsl:with-param name="ele_name">CorporateBO.keyContact_PersonName_alt1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.keyContact_PersonName_alt1</xsl:with-param>
                <xsl:with-param name="checkASCII">false</xsl:with-param>
                <xsl:with-param name="max_length">30</xsl:with-param>
                </xsl:call-template>
        </xsl:template>


        <!-- Tracker 113227 changes END-->
        <xsl:template name="CorporateBO.corp_Key">
        <xsl:choose>
        <xsl:when test= "normalize-space($keyGeneration)='Reserved' or normalize-space($keyGeneration)='Both' and (normalize-space($corporateURL)='' or normalize-space($entityCreflg) = 'N' or normalize-space($isCopy) = 'Y')">
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
        <xsl:when test= "normalize-space($keyGeneration)='Manual' and (normalize-space($corporateURL)='' or normalize-space($entityCreflg) = 'N' or normalize-space($isCopy) = 'Y')">
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




       <!--CIF Ret-Corp-Syncup Changes Start-->

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

       <!--CIF Ret-Corp-Syncup Changes End-->

        <xsl:template name="CorporateBO.status">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.status']"/>
        <xsl:with-param name="selectdisp">CorporateBO.status</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.status</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.status</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <!-- caching changes start -->
                <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.relationship_StartDate">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.relationship_StartDate']"/>
        <xsl:with-param name="ele_name">CorporateBO.relationship_StartDate</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.relationship_StartDate</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
        <!-- calling the function isGregDate for on blur functionality-->
        <xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.relationship_StartDate");</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
        </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.short_Name">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.short_Name']"/>
        <xsl:with-param name="ele_name">CorporateBO.short_Name</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_Name</xsl:with-param>
        <xsl:with-param name="checkASCII">false</xsl:with-param>
        <xsl:with-param name="max_length">10</xsl:with-param>
        <!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
        <xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
        <!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
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


        <xsl:template name="CorporateBO.priority">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.priority']"/>
        <xsl:with-param name="selectdisp">CorporateBO.priority</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.priority</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.priority</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <!-- caching changes start -->
        <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.delinquency_Flag">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.delinquency_Flag']"/>
        <xsl:with-param name="selectdisp">CorporateBO.delinquency_Flag</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.delinquency_Flag</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.delinquency_Flag</xsl:with-param>
        <xsl:with-param name="disable_val">true</xsl:with-param>
        <xsl:with-param name="max_length">1</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <!-- caching changes start -->
        <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
        </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.legalEntity_Type">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.legalEntity_Type_Code']"/>
        <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.legalEntity_Type</xsl:with-param>-->
        <xsl:with-param name="selectdisp">CorporateBO.legalEntity_Type_Code</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.legalEntity_Type</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.legalEntity_Type_Code</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <xsl:with-param name="search_type">url</xsl:with-param>
        <!-- caching changes start -->
        <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.keyContact_PersonName">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.keyContact_PersonName']"/>
        <xsl:with-param name="ele_name">CorporateBO.keyContact_PersonName</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.keyContact_PersonName</xsl:with-param>
        <xsl:with-param name="checkASCII">false</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
        <xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
        <!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
        </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.website_Address">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.website_Address']"/>
        <xsl:with-param name="ele_name">CorporateBO.website_Address</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.website_Address</xsl:with-param>
        <xsl:with-param name="max_length">100</xsl:with-param>
        <xsl:with-param name="fn_onBlur">fn_checkASCIIForEnglish(this)</xsl:with-param>
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

        <!-- Customization Change: changes for dropdown to lookup starts:CallID 226755  -->
        
        <xsl:template name="CorporateBO.segment">
	        <xsl:call-template name="lookup">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.segment']"/>
		<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.segment</xsl:with-param>
		<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.segment</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		<xsl:with-param name="buttonone_fnc">categoryLookup('CORP_SEGMENTATION_CLASS', '<xsl:value-of select="$boName"/>.segment')</xsl:with-param>
		<!-- Changes for tracker id 338046 STARTS -->
		<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.segment');loadSubSeg();</xsl:with-param>
		<!-- Changes for tracker id 338046 ENDS -->
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="code_req">true</xsl:with-param>
		<xsl:with-param name="toUpperCase">false</xsl:with-param>
		</xsl:call-template>
	        </xsl:template>
<!-- Customization Change: changes for dropdown to lookup Ends:CallID 226755  -->

        <xsl:template name="CorporateBO.old_Entity_Type">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.old_Entity_Type']"/>
        <xsl:with-param name="ele_name">CorporateBO.old_Entity_Type</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.old_Entity_Type</xsl:with-param>
        <xsl:with-param name="disable_val">true</xsl:with-param>
        </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.ChargeLevelCode">
        <!--Ticket id : 204734 part (b) and part (c) begin of changes-->
        <!-- Tracker 122429: Bug fixed for TicketID 204259 START -->
        <!-- Following code commented and made it as "label" -->
             <xsl:call-template name="lookup">
        <!--<xsl:call-template name="label">-->
        <!--Ticket id : 204734 part (b) and part (c) end of changes-->
        <!-- Tracker 122429: Bug fixed for TicketID 204259 END -->
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.ChargeLevelCode']"/>
        <!--Ticket id : 204734 part (b) and part (c) begin of changes-->
        <xsl:with-param name="elename">CorporateBO.ChargeLevelCode</xsl:with-param>
        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.ChargeLevelCode</xsl:with-param>
        <!--Ticket id : 204734 part (b) and part (c) end of changes-->
             <xsl:with-param name="buttonone_fnc">categoryLookup('CHARGE_LEVEL_CODE', 'CorporateBO.ChargeLevelCode')</xsl:with-param>
             <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.ChargeLevelCode')</xsl:with-param>
             <xsl:with-param name="checkASCII">false</xsl:with-param>
        </xsl:call-template>
        </xsl:template>

        <!-- Field Rationalization end -->

        <xsl:template name="CorporateBO.notes">
        <xsl:call-template name="mtextarea">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.notes']"/>
        <xsl:with-param name="mname">CorporateBO.notes</xsl:with-param>
        <xsl:with-param name="mvalue"><xsl:value-of select="$boName"/>.notes</xsl:with-param>
        <xsl:with-param name="mwrap">on</xsl:with-param>
        <xsl:with-param name="mrows">2</xsl:with-param>
        <xsl:with-param name="mcols">77</xsl:with-param>
        <xsl:with-param name="mcolspan">5</xsl:with-param>
        <xsl:with-param name="fn_onblur">txtLimit(this,255,"CorporateBO.notes","Notes")</xsl:with-param>
        <xsl:with-param name="checkASCII">false</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.phone">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.phone']"/>
        <xsl:with-param name="ele_name">CorporateBO.phone</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.phone</xsl:with-param>
        <xsl:with-param name="max_length">20</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
    <!-- Field Rationalization starts -->

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
	 			<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.business_Type</xsl:with-param>
	 			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.business_Type</xsl:with-param>
	 			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	 			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
	 			<xsl:with-param name="buttonone_fnc">categoryLookup('BUS_TYPE', '<xsl:value-of select="$boName"/>.business_Type')</xsl:with-param>
	 			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.business_Type')</xsl:with-param>
	 			<xsl:with-param name="checkASCII">false</xsl:with-param>
	 		</xsl:call-template>
        </xsl:template>
		<!--changes for tracker id 349409 END-->
        <!-- Tracker : 79071 -->
        <xsl:template name="CorporateBO.business_Group">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.business_Group']"/>
        <xsl:with-param name="selectdisp">CorporateBO.business_Group</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.business_Group</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.business_Group</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <!-- caching changes start -->
                <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
        </xsl:call-template>
        </xsl:template>

        <!--
        <xsl:template name="CorporateBO.business_Group">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.business_Group']"/>
        <xsl:with-param name="ele_name">CorporateBO.business_Group</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.business_Group</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
        -->
        <!-- Tracker : 79071 -->

         <!-- Field Rationization changes start -->
        <xsl:template name="CorporateBO.trade_Services_Availed">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.trade_Services_Availed']"/>
        <xsl:with-param name="selectdisp">CorporateBO.trade_Services_Availed</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.trade_Services_Availed</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.trade_Services_Availed</xsl:with-param>
        <xsl:with-param name="onchangefn">isTFPartyFlag();</xsl:with-param>
        <xsl:with-param name="defValByUrl">true</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="presdata" select="$PresData"/>
        </xsl:call-template>
        </xsl:template>
    <!-- Field Rationization changes end -->

        <xsl:template name="CorporateBO.corporateName_Native">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.corporateName_Native']"/>
        <xsl:with-param name="ele_name">CorporateBO.corporateName_Native</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.corporateName_Native</xsl:with-param>
<!-- Fix for call id: 428627 Starts -->
		<xsl:with-param name="max_length">80</xsl:with-param>
<!-- Fix for call id: 428627 Ends -->
        <xsl:with-param name="checkASCII">false</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
<!--Native Language Changes:start-->
        <xsl:template name="CorporateBO.CorporateName_Native1">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorporateName_Native1']"/>
        <xsl:with-param name="ele_name">CorporateBO.CorporateName_Native1</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CorporateName_Native1</xsl:with-param>
        <xsl:with-param name="max_length">80</xsl:with-param>
        </xsl:call-template>
        </xsl:template>

        <!-- Changes Done for Ticket ID 243534  -->

        <xsl:template name="CorporateBO.Short_Name_Native1">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Short_Name_Native1']"/>
        <xsl:with-param name="ele_name">CorporateBO.Short_Name_Native1</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Short_Name_Native1</xsl:with-param>
        <xsl:with-param name="max_length">10</xsl:with-param>
        </xsl:call-template>
        </xsl:template>


        <!-- Changes ENDS for Ticket ID 243534  -->

<!--fix for ticket 334796 starts-->
<!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Starts-->
       <xsl:template name="CorporateBO.TertiaryRMLogin_ID">
        <xsl:call-template name="lookup">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.TertiaryRMLogin_ID']"/>
        <xsl:with-param name="elename">CorporateBO.TertiaryRMLogin_ID</xsl:with-param>
        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.TertiaryRMLogin_ID</xsl:with-param>
        <xsl:with-param name="max_length">50</xsl:with-param>
        <!-- Field Rationalization changes start-->
        <xsl:with-param name="linkshow">true</xsl:with-param>
        <xsl:with-param name="fncname">agentDetails(document.getElementsByName("CorporateBO.TertiaryRMLogin_ID")[0].value);</xsl:with-param>
        <!-- Field Rationalization changes end-->
        <xsl:with-param name="buttonone_name" select="$configLabels_1[@name='LOOKUP']/@configLabel"/>
        <xsl:with-param name="buttontwo_name" select="$configLabels_1[@name='CLEAR']/@configLabel"/>
        <!--<xsl:with-param name="buttonone_fnc">AccMgrLookup("TRM")</xsl:with-param>-->
        <xsl:with-param name="buttonone_fnc">fnBlurCorpLookup("TRM")</xsl:with-param>
        <xsl:with-param name="buttontwo_fnc">clearGenLookup("TRM")</xsl:with-param>
        </xsl:call-template>
            <!-- Field Rationalization fix -->
            <input type="hidden" name="trmURL" value=""/>
        </xsl:template>
<!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Ends-->
<!--fix for ticket 334796 ends-->

<!--Native Language Changes:end-->

        <xsl:template name="CorporateBO.SecondRMLogin_ID">
        <xsl:call-template name="lookup">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.SecondRMLogin_ID']"/>
        <xsl:with-param name="elename">CorporateBO.SecondRMLogin_ID</xsl:with-param>
        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.SecondRMLogin_ID</xsl:with-param>
        <xsl:with-param name="max_length">50</xsl:with-param>
        <!-- Field Rationalization changes start-->
        <xsl:with-param name="linkshow">true</xsl:with-param>
        <xsl:with-param name="fncname">agentDetails(document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].value);</xsl:with-param>
        <!-- Field Rationalization changes end-->
        <xsl:with-param name="buttonone_name" select="$configLabels_1[@name='LOOKUP']/@configLabel"/>
        <xsl:with-param name="buttontwo_name" select="$configLabels_1[@name='CLEAR']/@configLabel"/>
        <!--xsl:with-param name="buttonone_fnc">AccMgrLookup("SRM")</xsl:with-param-->
        <xsl:with-param name="buttonone_fnc">fnBlurCorpLookup("SRM")</xsl:with-param>
        <xsl:with-param name="buttontwo_fnc">clearGenLookup("SRM")</xsl:with-param>
        </xsl:call-template>
            <!-- Field Rationalization fix -->
            <input type="hidden" name="srmURL" value=""/>
        </xsl:template>

        <xsl:template name="CorporateBO.PrimaryRMLogin_ID">
                <xsl:call-template name="lookup">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.PrimaryRMLogin_ID']"/>
        <xsl:with-param name="elename">CorporateBO.PrimaryRMLogin_ID</xsl:with-param>
        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.PrimaryRMLogin_ID</xsl:with-param>
        <xsl:with-param name="max_length">50</xsl:with-param>
        <!-- Field Rationalization changes start-->
        <xsl:with-param name="linkshow">true</xsl:with-param>
        <xsl:with-param name="fncname">agentDetails(document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].value);</xsl:with-param>
        <!-- Field Rationalization changes end-->
        <xsl:with-param name="buttonone_name" select="$configLabels_1[@name='LOOKUP']/@configLabel"/>
        <xsl:with-param name="buttontwo_name" select="$configLabels_1[@name='CLEAR']/@configLabel"/>
        <!--xsl:with-param name="buttonone_fnc">AccMgrLookup("PRM")</xsl:with-param-->
        <xsl:with-param name="buttonone_fnc">fnBlurCorpLookup("PRM")</xsl:with-param>
            <xsl:with-param name="buttontwo_fnc">clearGenLookup("PRM")</xsl:with-param>
        </xsl:call-template>
            <!-- Field Rationalization fix -->
            <input type="hidden" name="prmURL" value=""/>
        </xsl:template>

        <xsl:template name="CorporateBO.short_Name_Native">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.short_Name_Native']"/>
        <xsl:with-param name="ele_name">CorporateBO.short_Name_Native</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_Name_Native</xsl:with-param>
        <xsl:with-param name="max_length">10</xsl:with-param>
        <xsl:with-param name="checkASCII">false</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.date_Of_Incorporation">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.date_Of_Incorporation']"/>
        <xsl:with-param name="fn_onBlur">validCorpDate("3_CorporateBO.date_Of_Incorporation");</xsl:with-param>
        <xsl:with-param name="ele_name">CorporateBO.date_Of_Incorporation</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.date_Of_Incorporation</xsl:with-param>

        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.registration_Number">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.registration_Number']"/>
        <xsl:with-param name="ele_name">CorporateBO.registration_Number</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.registration_Number</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.relationship_Type">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.relationship_Type']"/>
        <xsl:with-param name="selectdisp">CorporateBO.relationship_Type</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.relationship_Type</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.relationship_Type</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <!-- DEF-578 Begin of changes-->
        <!--<xsl:with-param name="defValByUrl">true</xsl:with-param>-->
        <!-- DEF-578 End of changes-->
        <!-- caching changes start -->
        <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
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
               <xsl:with-param name="code_req">true</xsl:with-param>   <!-- change for callid 318169 -->
             </xsl:call-template>
         </xsl:template>


<!-- Field Rationalization changes end -->
         <!-- customization changes for dropdown to lookup starts:CallID 226755 -->
        
         <xsl:template name="CorporateBO.region">
	     <xsl:call-template name="lookup">
	     <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.region']"/>
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
	 
	 <!-- customization changes for dropdown to lookup ends:CallID 226755 -->

        <xsl:template name="CorporateBO.date_Of_Commencement">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.date_Of_Commencement']"/>
        <xsl:with-param name="ele_name">CorporateBO.date_Of_Commencement</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.date_Of_Commencement</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
        <!-- calling the function isGregDate for on blur functionality-->
        <xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.date_Of_Commencement");</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
        </xsl:call-template>
        </xsl:template>
        <!-- Changes for the ticket id 208599 starts-->
        <!-- customization changes for dropdown to lookup starts:CallID 226755 -->
        <xsl:template name="CorporateBO.sector">
		<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.sector']"/>
			<!--Changes for Tracker id: 292552 starts-->
			<xsl:with-param name="elename">CorporateBO.sector</xsl:with-param>
			<!--Changes for Tracker id: 292552 ends-->
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.sector</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			<!-- changes for Tracker Id 263534 begin here -->
			<!--Changes for Call Id: 254701 starts-->
			<!--<xsl:with-param name="buttonone_fnc">categoryLookup('SECTOR_CODE', '<xsl:value-of select="$boName"/>.sector')</xsl:with-param>-->
			<xsl:with-param name="buttonone_fnc">categoryLookup('SECTOR_CODE', 'CorporateBO.sector')</xsl:with-param>
			<!--Changes for Call Id: 254701 ends-->
			<!-- changes for Tracker Id 263534 end here -->
			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.sector')</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
			<xsl:with-param name="code_req">true</xsl:with-param>
		</xsl:call-template>
        </xsl:template>
        
        <!-- customization changes for dropdown to lookup ends:CallID 226755 -->

        <xsl:template name="CorporateBO.Cust_Grp_Desc">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Cust_Grp']"/>
        <!-- <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.Cust_Grp_Desc</xsl:with-param>-->
        <xsl:with-param name="selectdisp">CorporateBO.Cust_Grp</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Cust_Grp_Desc</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.Cust_Grp</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <xsl:with-param name="search_type">url</xsl:with-param>
        <!-- caching changes start -->
        <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.StrUserField10">
	        <xsl:call-template name="mdrpdown">
	        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField10']"/>
	        <!-- <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.StrUserField10</xsl:with-param>-->
	        <xsl:with-param name="selectdisp">CorporateBO.StrUserField10</xsl:with-param>
	        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.StrUserField10</xsl:with-param>
	        <xsl:with-param name="choice_name">CorporateBO.StrUserField10</xsl:with-param>
	        <xsl:with-param name="max_length">30</xsl:with-param>
	        <xsl:with-param name="search_type">url</xsl:with-param>
	        <!-- caching changes start -->
	        <xsl:with-param name="presdata" select="$PresData"/>
	        <!-- caching changes end -->
	        </xsl:call-template>
        </xsl:template>
		
		<xsl:template name="CorporateBO.StrUserField8">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.StrUserField8']"/>
        <xsl:with-param name="ele_name">CorporateBO.StrUserField8</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.StrUserField8</xsl:with-param>
        <xsl:with-param name="checkASCII">false</xsl:with-param>
        <xsl:with-param name="max_length">20</xsl:with-param>
        <!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
         <xsl:with-param name="fn_onBlur">set_isName(this,true);validatetaxID(document.getElementsByName('CorporateBO.StrUserField8')[0]);</xsl:with-param>
        <!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
        </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.relationship_CreatedBy">
        <xsl:call-template name="lookup">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.relationship_CreatedBy']"/>
        <xsl:with-param name="elename">CorporateBO.relationship_CreatedBy</xsl:with-param>
        <xsl:with-param name="eleval">RelationshipCreatedBy</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
	<!--changes for callid 700282 starts -->
	<xsl:with-param name="disable_val">true</xsl:with-param>
	<!--changes for callid 700282 ends -->
        <xsl:with-param name="buttonone_name" select="$configLabels_1[@name='LOOKUP']/@configLabel"/>
        <xsl:with-param name="buttontwo_name" select="$configLabels_1[@name='CLEAR']/@configLabel"/>
        <xsl:with-param name="buttonone_fnc">fnBlurCorpLookup("RelCrea")</xsl:with-param>
        <xsl:with-param name="buttontwo_fnc">clearGenLookup("RelCrea")</xsl:with-param>
        <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
        </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.dsaID">
        <xsl:call-template name="lookup">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.dsaID']"/>
        <xsl:with-param name="elename">CorporateBO.dsaID</xsl:with-param>
        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.dsaID</xsl:with-param>
        <xsl:with-param name="max_length">12</xsl:with-param>
        <xsl:with-param name="buttonone_name" select="$configLabels_1[@name='LOOKUP']/@configLabel"/>
        <xsl:with-param name="buttontwo_name" select="$configLabels_1[@name='CLEAR']/@configLabel"/>
        <!--xsl:with-param name="buttonone_fnc">openAgentLookup("DSAID")</xsl:with-param-->
        <xsl:with-param name="buttonone_fnc">fnBlurCorpLookup('DSAID')</xsl:with-param>
        <xsl:with-param name="buttontwo_fnc">clearGenLookup("DSAID")</xsl:with-param>
        </xsl:call-template>
        </xsl:template>


        <xsl:template name="CorporateBO.taxID">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.taxID']"/>
        <xsl:with-param name="ele_name">CorporateBO.taxID</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.taxID</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        </xsl:call-template>
        </xsl:template>

        <!-- Customization Change: changes for dropdown to lookup starts:CallID 226755  -->
        <xsl:template name="CorporateBO.subSector">
		<xsl:call-template name="lookup">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Subsector_Code']"/>
		<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.subSector</xsl:with-param>
		<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.subSector</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		<xsl:with-param name="buttonone_fnc">categoryLookup('SUB_SECTOR_CODE', '<xsl:value-of select="$boName"/>.subSector')</xsl:with-param>
		<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.subSector')</xsl:with-param>
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="code_req">true</xsl:with-param>
		</xsl:call-template>
		</xsl:template>
<!-- Customization Change: changes for dropdown to lookup Ends:CallID 226755  -->


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
        <xsl:with-param name="ele_name">CorporateBO.source_Of_Funds</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.source_Of_Funds</xsl:with-param>
        <xsl:with-param name="checkASCII">false</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
        <!-- Customization Change: changes for dropdown to lookup starts:CallID 226755  -->
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
			<xsl:with-param name="code_req">true</xsl:with-param>
		</xsl:call-template>
	        </xsl:template>
<!-- Customization Change: changes for dropdown to lookup Ends:CallID 226755  -->

<!-- pep status james.M  starts-->
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

<!-- pep status james.M  ends-->



        <xsl:template name="CorporateBO.average_AnnualIncome">
        <xsl:call-template name="amountlabel">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.average_AnnualIncome']"/>
        <xsl:with-param name="ele_name">CorporateBO.average_AnnualIncome</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.average_AnnualIncome</xsl:with-param>
        <!-- Tracker ID 113058 Changes Start -->
        <!-- <xsl:with-param name="max_length">13</xsl:with-param> -->
        <!-- Tracker ID 113058 Changes End -->
        <xsl:with-param name="fncname">rate("3_CorporateBO.average_AnnualIncome",boName+".Crncy_Code",'<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
        <xsl:with-param name="showdropdown">false</xsl:with-param>
        <xsl:with-param name="fn_onBlur">formatCorpAmount("3_CorporateBO.average_AnnualIncome",boName+".Crncy_Code","N");</xsl:with-param>
                </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.TotalFundBase">
        <xsl:call-template name="amountlabel">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.TotalFundBase']"/>
        <xsl:with-param name="ele_name">CorporateBO.TotalFundBase</xsl:with-param>
        <!-- Tracker ID 113058 Changes Start -->
        <!-- <xsl:with-param name="max_length">13</xsl:with-param> -->
        <!-- Tracker ID 113058 Changes End -->
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TotalFundBase</xsl:with-param>
        <xsl:with-param name="fncname">rate("3_CorporateBO.TotalFundBase",boName+".Crncy_Code",'<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
        <xsl:with-param name="showdropdown">false</xsl:with-param>
        <xsl:with-param name="fn_onBlur">formatCorpAmount("3_CorporateBO.TotalFundBase",boName+".Crncy_Code","N");</xsl:with-param>
        </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.TotalNonFundBase">
        <xsl:call-template name="amountlabel">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.TotalNonFundBase']"/>
        <xsl:with-param name="ele_name">CorporateBO.TotalNonFundBase</xsl:with-param>
        <!-- Tracker ID 113058 Changes Start -->
        <!-- <xsl:with-param name="max_length">13</xsl:with-param> -->
        <!-- Tracker ID 113058 Changes End -->
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TotalNonFundBase</xsl:with-param>
        <xsl:with-param name="fncname">rate("3_CorporateBO.TotalNonFundBase",boName+".Crncy_Code",'<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
        <xsl:with-param name="showdropdown">false</xsl:with-param>
        <xsl:with-param name="fn_onBlur">formatCorpAmount("3_CorporateBO.TotalNonFundBase",boName+".Crncy_Code","N");</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.parent_CIF">
                <xsl:call-template name="lookup">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.parent_CIF']"/>
        <xsl:with-param name="elename">CorporateBO.parent_CIF</xsl:with-param>
        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.parent_CIF</xsl:with-param>
        <xsl:with-param name="max_length">5</xsl:with-param>
        <xsl:with-param name="buttonone_name" select="$configLabels_1[@name='LOOKUP']/@configLabel"/>
        <xsl:with-param name="buttontwo_name" select="$configLabels_1[@name='CLEAR']/@configLabel"/>
        <xsl:with-param name="buttonone_fnc">openParentLookup()</xsl:with-param>
        <xsl:with-param name="buttontwo_fnc">clearGenLookup("Parent")</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
        <!-- GroupHouseHold Comment Start
        <xsl:template name="CorporateBO.Group_ID_Code">
                <xsl:call-template name="lookup">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Group_ID_Code']"/>
        <xsl:with-param name="elename">CorporateBO.Group_ID_Code</xsl:with-param>
        <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Group_ID_Code</xsl:with-param>
        <xsl:with-param name="max_length">50</xsl:with-param>
        <xsl:with-param name="buttonone_name" select="$configLabels_1[@name='LOOKUP']/@configLabel"/>
        <xsl:with-param name="buttontwo_name" select="$configLabels_1[@name='CLEAR']/@configLabel"/>
        <xsl:with-param name="buttonone_fnc">openGroupLookup()</xsl:with-param>
        <xsl:with-param name="buttontwo_fnc">clearLookup("Group")</xsl:with-param>
        <xsl:with-param name="UsrData">CustomData</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
        GroupHouseHold Comment End -->
        <xsl:template name="CorporateBO.effective_Date">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.effective_Date']"/>
        <xsl:with-param name="ele_name">CorporateBO.effective_Date</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.effective_Date</xsl:with-param>
        <xsl:with-param name="max_length">23</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
        <!-- calling the function isGregDate for on blur functionality-->
        <xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.effective_Date");</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
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
        <!-- customization changes for dropdown to lookup starts:CallID 226755 -->
        <xsl:template name="CorporateBO.customer_Rating">
	     <xsl:call-template name="lookup">
		    <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.customer_Rating_Code']"/>
		    <!-- Changes for tracker 333586:Start-->
		    <xsl:with-param name="elename">CorporateBO.customer_Rating_Code</xsl:with-param>
		    <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.customer_Rating</xsl:with-param>
		    <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
		    <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
		    <xsl:with-param name="buttonone_fnc">categoryLookup('PRIORITY_IDENTIFIER', 'CorporateBO.customer_Rating_Code')</xsl:with-param>
		    <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.customer_Rating_Code')</xsl:with-param>
		    <!-- Changes for tracker 333586:End-->
		    <xsl:with-param name="code_req">true</xsl:with-param>
	     </xsl:call-template>
	</xsl:template>  

        <!-- customization changes for dropdown to lookup ends:CallID 226755 -->
        <xsl:template name="CorporateBO.classified_On">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.classified_On']"/>
        <xsl:with-param name="ele_name">CorporateBO.classified_On</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.classified_On</xsl:with-param>
        <xsl:with-param name="max_length">23</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
        <!-- calling the function isGregDate for on blur functionality-->
        <xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.classified_On");</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.cust_Creation_Mode">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.cust_Creation_Mode']"/>
        <xsl:with-param name="ele_name">CorporateBO.cust_Creation_Mode</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.cust_Creation_Mode</xsl:with-param>
        <xsl:with-param name="max_length">1</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.IncrementalDateUpdate">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.IncrementalDateUpdate']"/>
        <xsl:with-param name="ele_name">CorporateBO.IncrementalDateUpdate</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.IncrementalDateUpdate</xsl:with-param>
        <xsl:with-param name="max_length">23</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
        <!-- calling the function isGregDate for on blur functionality-->
        <xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.IncrementalDateUpdate");</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.Health_Desc">
                <xsl:choose>
                <xsl:when test= "normalize-space($boName)='CorporateBO'">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.health_Code']"/>
        <!-- <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.Health_Desc</xsl:with-param>-->
        <xsl:with-param name="selectdisp">CorporateBO.health_Code</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Health_Desc</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.health_Code</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <xsl:with-param name="search_type">url</xsl:with-param>
        <!-- caching changes start -->
        <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
        </xsl:call-template>
                 </xsl:when>
                 <xsl:otherwise>
                 <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.health_Code']"/>
        <xsl:with-param name="selectdisp">CorporateBO.health_Code</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.health_Desc</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.health_Code</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <xsl:with-param name="search_type">url</xsl:with-param>
        <xsl:with-param name="presdata" select="$PresData"/>
        </xsl:call-template>
           </xsl:otherwise>
             </xsl:choose>
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


        <!-- Field Rationalization changes start -->
             <xsl:template name="CorporateBO.Line_of_Activity_Desc">
             <xsl:call-template name="lookup">
             <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Line_of_Activity_Desc']"/>
             <xsl:with-param name="elename">CorporateBO.Line_of_Activity_Desc</xsl:with-param>
             <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Line_of_Activity_Desc</xsl:with-param>
             <xsl:with-param name="code_req">true</xsl:with-param>
         <xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
             <xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
             <xsl:with-param name="buttonone_fnc">categoryLookup('INDUSTRY_TYPE', 'CorporateBO.Line_of_Activity_Desc')</xsl:with-param>
             <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.Line_of_Activity_Desc')</xsl:with-param>
             <!--<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>-->
         <xsl:with-param name="checkASCII">false</xsl:with-param>
             </xsl:call-template>
             </xsl:template>

        <!-- Field Rationalization changes end -->
		<!-- Fix for 437564 changes start  -->
        <xsl:template name="CorporateBO.Lang_Desc">
		<!--<xsl:choose>
			<xsl:when test= "normalize-space($boName)='CorporateBO'">  -->
                <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Lang_Desc']"/>
        <xsl:with-param name="selectdisp">CorporateBO.Lang_Desc</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Lang_Desc</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.Lang_Desc</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <!-- caching changes start -->
        <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
        </xsl:call-template>
			<!--		</xsl:when>
					<xsl:otherwise>
							<xsl:call-template name="mdrpdown">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Lang_Desc']"/>
				<xsl:with-param name="selectdisp">CorporateBO.Lang_Desc</xsl:with-param>
				<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.lang_Desc</xsl:with-param>
				<xsl:with-param name="choice_name">CorporateBO.Lang_Desc</xsl:with-param>
				<xsl:with-param name="max_length">30</xsl:with-param>
				<xsl:with-param name="search_type">value</xsl:with-param> -->
				<!-- caching changes start -->
		      	<!-- <xsl:with-param name="presdata" select="$PresData"/> -->
				<!-- caching changes end -->
				<!-- </xsl:call-template>
					</xsl:otherwise>
		</xsl:choose> -->
		</xsl:template>
		<!-- Fix for 437564 changes end  -->
        <xsl:template name="CorporateBO.Cust_Type_Desc">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Cust_Type_Code']"/>
        <!-- <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.Cust_Type_Desc</xsl:with-param>-->
        <xsl:with-param name="selectdisp">CorporateBO.Cust_Type_Code</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Cust_Type_Desc</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.Cust_Type_Code</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <xsl:with-param name="search_type">url</xsl:with-param>
        <!-- caching changes start -->
        <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
        </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.Status_Desc">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Status_Code']"/>
        <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.Status_Desc</xsl:with-param>-->
        <xsl:with-param name="selectdisp">CorporateBO.Status_Code</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Status_Desc</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.Status_Code</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <xsl:with-param name="search_type">url</xsl:with-param>
        <!-- caching changes start -->
        <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
        </xsl:call-template>
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
        <!--ERPBOCF1:TRACKER:113259:ENDOFCHANGES(HJRI)-->

        <!--Begin of changes by Bharath for hidden field for currency default population -->
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
	<!--End of changes by Bharath for hidden field for currency default population -->
        <xsl:template name="CorporateBO.remarks">
        <xsl:call-template name="mtextarea">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.remarks']"/>
        <xsl:with-param name="mname">CorporateBO.remarks</xsl:with-param>
        <xsl:with-param name="mvalue"><xsl:value-of select="$boName"/>.remarks</xsl:with-param>
        <xsl:with-param name="mwrap">on</xsl:with-param>
        <xsl:with-param name="mrows">2</xsl:with-param>
        <xsl:with-param name="mcols">77</xsl:with-param>
        <xsl:with-param name="mcolspan">5</xsl:with-param>
        <xsl:with-param name="fn_onblur">txtLimit(this,75,"CorporateBO.remarks","Remarks")</xsl:with-param>
        <xsl:with-param name="checkASCII">false</xsl:with-param>
        </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.Cust_Stat_Chg_Date">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Cust_Stat_Chg_Date']"/>
        <xsl:with-param name="ele_name">CorporateBO.Cust_Stat_Chg_Date</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Stat_Chg_Date</xsl:with-param>
        <xsl:with-param name="max_length">23</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
        <!-- calling the function isGregDate for on blur functionality-->
        <xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.Cust_Stat_Chg_Date");</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
        </xsl:call-template>
        </xsl:template>

        <!--
        <xsl:template name="CorporateBO.DefaultAddressType">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.DefaultAddressType']"/>
        <xsl:with-param name="selectdisp">CorporateBO.DefaultAddressType</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.DefaultAddressType</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.DefaultAddressType</xsl:with-param>
        <xsl:with-param name="max_length">30</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>

        <xsl:with-param name="presdata" select="$PresData"/>

        </xsl:call-template>
        </xsl:template>
        -->

        <xsl:template name="CorporateBO.customer_Asset_Classification">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CustAsset_Clsftion_Code']"/>
        <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.customer_Asset_Classification</xsl:with-param>-->
        <xsl:with-param name="selectdisp">CorporateBO.CustAsset_Clsftion_Code</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.customer_Asset_Classification</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.CustAsset_Clsftion_Code</xsl:with-param>
        <xsl:with-param name="max_length">5</xsl:with-param>
        <xsl:with-param name="search_type">url</xsl:with-param>
        <!-- caching changes start -->
            <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.AdvanceAsOnDate">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.AdvanceAsOnDate']"/>
        <xsl:with-param name="ele_name">CorporateBO.AdvanceAsOnDate</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.AdvanceAsOnDate</xsl:with-param>
        <xsl:with-param name="max_length">23</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
        <!-- calling the function isGregDate for on blur functionality-->
        <xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.AdvanceAsOnDate");</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.Tds_CIF_Id">
        <xsl:choose>
            <xsl:when test= "normalize-space($entityType)='Prospect'">
                <xsl:call-template name="lookup">
                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Tds_CIF_Id']"/>
                <xsl:with-param name="elename">CorporateBO.Tds_CIF_Id</xsl:with-param>
                <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Tds_CIF_Id</xsl:with-param>
                <xsl:with-param name="buttonone_name" select="$configLabels_1[@name='LOOKUP']/@configLabel"/>
                <xsl:with-param name="buttontwo_name" select="$configLabels_1[@name='CLEAR']/@configLabel"/>
                <!--xsl:with-param name="buttonone_fnc">Lookup()</xsl:with-param-->
                <xsl:with-param name="buttonone_fnc">fnBlurCorpLookup("Tds_CIF_Id_corpPros")</xsl:with-param>
                <xsl:with-param name="buttontwo_fnc">clearGenLookup("Tds_CIF_Id")</xsl:with-param>
                <xsl:with-param name="checkASCII">false</xsl:with-param>
                <xsl:with-param name="disable_val">false</xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="lookup">
                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Tds_CIF_Id']"/>
                <xsl:with-param name="elename">CorporateBO.Tds_CIF_Id</xsl:with-param>
                <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Tds_CIF_Id</xsl:with-param>
                <xsl:with-param name="buttonone_name" select="$configLabels_1[@name='LOOKUP']/@configLabel"/>
                <xsl:with-param name="buttontwo_name" select="$configLabels_1[@name='CLEAR']/@configLabel"/>
                <!--xsl:with-param name="buttonone_fnc">Lookup()</xsl:with-param-->
                <xsl:with-param name="buttonone_fnc">fnBlurCorpLookup("Tds_CIF_Id_corpCust")</xsl:with-param>
                <xsl:with-param name="buttontwo_fnc">clearGenLookup("Tds_CIF_Id")</xsl:with-param>
                <xsl:with-param name="checkASCII">false</xsl:with-param>
                <xsl:with-param name="disable_val">false</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:template>
        <!-- GroupHouseHold Comment Start
        <xsl:template name="CorporateBO.group_ID">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.group_ID']"/>
        <xsl:with-param name="ele_name">CorporateBO.group_ID</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.group_ID</xsl:with-param>
        <xsl:with-param name="max_length">50</xsl:with-param>

        <xsl:with-param name="disable_val">true</xsl:with-param>
        <xsl:with-param name="checkASCII">false</xsl:with-param>

        </xsl:call-template>
        </xsl:template>
        GroupHouseHold Comment End-->
<!--        <xsl:template name="CorporateBO.parent_CIF">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.parent_CIF']"/>
        <xsl:with-param name="ele_name">CorporateBO.parent_CIF</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.parent_CIF</xsl:with-param>
        <xsl:with-param name="max_length">38</xsl:with-param>
        </xsl:call-template>
        </xsl:template> -->
        <xsl:template name="CorporateBO.Purge_Allowed_Flag">
        <xsl:choose>
            <xsl:when test= "normalize-space($boName)='CorporateBO'">
                <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Purge_Allowed_Flag']"/>
                <xsl:with-param name="selectdisp">CorporateBO.Purge_Allowed_Flag</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Purge_Allowed_Flag</xsl:with-param>
                <xsl:with-param name="choice_name">CorporateBO.Purge_Allowed_Flag</xsl:with-param>
                <xsl:with-param name="max_length">1</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>

                <!-- caching changes start -->
                <xsl:with-param name="presdata" select="$PresData"/>
                <!-- caching changes end -->
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Purge_Allowed_Flag']"/>
                <xsl:with-param name="selectdisp">CorporateBO.Purge_Allowed_Flag</xsl:with-param>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Purge_Allowed_Flag</xsl:with-param>
                <xsl:with-param name="choice_name">CorporateBO.Purge_Allowed_Flag</xsl:with-param>
                <xsl:with-param name="max_length">1</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>

                <!-- caching changes start -->
                <xsl:with-param name="presdata" select="$PresData"/>
                <!-- caching changes end -->
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:template>
        <xsl:template name="CorporateBO.Email2">
        <xsl:choose>
            <xsl:when test= "normalize-space($boName)='CorporateBO'">
                <xsl:call-template name="label">

        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Email2']"/>
        <xsl:with-param name="ele_name">CorporateBO.Email2</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Email2</xsl:with-param>
        <xsl:with-param name="max_length">50</xsl:with-param>
        <xsl:with-param name="fn_onBlur">fn_checkASCIIForEnglish(this)</xsl:with-param>
        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Email2']"/>
                <xsl:with-param name="ele_name">CorporateBO.Email2</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Email2</xsl:with-param>
                <xsl:with-param name="max_length">50</xsl:with-param>
                </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
                </xsl:template>


        <xsl:template name="CorporateBO.Introd_Name">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Introd_Name']"/>
        <xsl:with-param name="ele_name">CorporateBO.Introd_Name</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Introd_Name</xsl:with-param>
        <xsl:with-param name="max_length">10</xsl:with-param>
        <!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: STARTS  -->
        <xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
        <!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
        </xsl:call-template>
        </xsl:template>

    <!-- Customization Change: changes for dropdown to lookup starts:CallID 226755  -->    
<!-- Changes for tracker id 349409 begin-->
        
  <xsl:template name="CorporateBO.Tds_Tbl_Desc">
  	  <xsl:choose>
		<xsl:when test= "normalize-space($boName)='CorporateBO'">
			<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Tds_Tbl_Code']"/>
			<!-- Changes for tracker 333586 Start-->
			<xsl:with-param name="elename">CorporateBO.Tds_Tbl_Desc</xsl:with-param>
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Tds_Tbl_Desc</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			<xsl:with-param name="buttonone_fnc">categoryLookup('TAX_SLAB', 'CorporateBO.Tds_Tbl_Desc')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.Tds_Tbl_Desc')</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
			<xsl:with-param name="code_req">true</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Tds_Tbl_Code']"/>
			<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.tds_Tbl_Desc</xsl:with-param>
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.tds_Tbl_Desc</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			<xsl:with-param name="buttonone_fnc">categoryLookup('TAX_SLAB', '<xsl:value-of select="$boName"/>.tds_Tbl_Desc')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.tds_Tbl_Desc')</xsl:with-param>
			<!-- Changes for tracker 333586 End-->			
<!-- Changes for tracker id 349409 end-->
			<xsl:with-param name="checkASCII">false</xsl:with-param>
			<xsl:with-param name="code_req">true</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
	  </xsl:choose>
          </xsl:template>


<!-- Customization Change: changes for dropdown to lookup Ends:CallID 226755  -->

        <xsl:template name="CorporateBO.Cust_Swift_Code_Desc">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Cust_Swift_Code_Desc']"/>
        <xsl:with-param name="ele_name">CorporateBO.Cust_Swift_Code_Desc</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Swift_Code_Desc</xsl:with-param>
        <!--CRM95BETA : TRACKER#:121447 - START OF CHANGES-->
        <!-- Increase the maximum length of field to 11 -->
        <xsl:with-param name="max_length">11</xsl:with-param>
        <!--CRM95BETA : TRACKER#:121447 - END OF CHANGES-->
        <!--CRM102AUTO: TrackerID:168805 Begin of Change -->
        <xsl:with-param name="starshow">true</xsl:with-param>
        <!--CRM102AUTO: TrackerID:168805 End of Change -->
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.Is_Swift_Code_of_Bank">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Is_Swift_Code_of_Bank']"/>
        <xsl:with-param name="selectdisp">CorporateBO.Is_Swift_Code_of_Bank</xsl:with-param>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Is_Swift_Code_of_Bank</xsl:with-param>
        <xsl:with-param name="choice_name">CorporateBO.Is_Swift_Code_of_Bank</xsl:with-param>
        <xsl:with-param name="max_length">1</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
		<!--RECON Changes for ticket id 383428 / Tracker id 233709 begins-->
		<xsl:with-param name="onchangefn">makeSwiftFldMand();</xsl:with-param>
		<!--RECON Changes for ticket id 383428 / Tracker id 233709  ends-->
        <!-- caching changes start -->
        <xsl:with-param name="presdata" select="$PresData"/>
        <!-- caching changes end -->
        </xsl:call-template>
        </xsl:template>

        <!-- Customization Change: changes for dropdown to lookup starts:CallID 226755  -->
        <xsl:template name="CorporateBO.Cust_Const">
	        <xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Cust_Const_Code']"/>
			<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.Cust_Const</xsl:with-param>
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Cust_Const</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			<xsl:with-param name="buttonone_fnc">categoryLookup('CONSTITUTION_CODE', '<xsl:value-of select="$boName"/>.Cust_Const')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.Cust_Const')</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
			<xsl:with-param name="code_req">true</xsl:with-param>
	        </xsl:call-template>
	        </xsl:template>
<!-- Customization Change: changes for dropdown to lookup Ends:CallID 226755  -->
        <xsl:template name="CorporateBO.Cust_Mgr_Opin">
        <xsl:call-template name="mtextarea">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Cust_Mgr_Opin']"/>
        <xsl:with-param name="mname">CorporateBO.Cust_Mgr_Opin</xsl:with-param>
        <xsl:with-param name="mvalue"><xsl:value-of select="$boName"/>.Cust_Mgr_Opin</xsl:with-param>
        <xsl:with-param name="mwrap">on</xsl:with-param>
        <xsl:with-param name="mrows">2</xsl:with-param>
        <xsl:with-param name="mcols">77</xsl:with-param>
        <xsl:with-param name="mcolspan">5</xsl:with-param>
        <xsl:with-param name="fn_onblur">txtLimit(this,240,"CorporateBO.Cust_Mgr_Opin","Manager Opinion")</xsl:with-param>
        <xsl:with-param name="checkASCII">false</xsl:with-param>
        </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.converted_Date">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.converted_Date']"/>
        <xsl:with-param name="ele_name">CorporateBO.converted_Date</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.converted_Date</xsl:with-param>
        <xsl:with-param name="max_length">10</xsl:with-param>
        <xsl:with-param name="disable_val">true</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
        <!-- calling the function isGregDate for on blur functionality-->
        <xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.converted_Date");</xsl:with-param>
        <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
        </xsl:call-template>
        </xsl:template>
        <xsl:template name="CorporateBO.Introd_Stat_Desc">
        <xsl:call-template name="label">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Introd_Stat_Desc']"/>
        <xsl:with-param name="ele_name">CorporateBO.Introd_Stat_Desc</xsl:with-param>
        <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Introd_Stat_Desc</xsl:with-param>
        <xsl:with-param name="max_length">50</xsl:with-param>
        </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.Purge_Text">
        <xsl:call-template name="mtextarea">
        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Purge_Text']"/>
        <xsl:with-param name="mname">CorporateBO.Purge_Text</xsl:with-param>
        <xsl:with-param name="mvalue"><xsl:value-of select="$boName"/>.Purge_Text</xsl:with-param>
        <xsl:with-param name="mwrap">on</xsl:with-param>
        <xsl:with-param name="mrows">2</xsl:with-param>
        <xsl:with-param name="mcols">77</xsl:with-param>
        <xsl:with-param name="mcolspan">5</xsl:with-param>
        <xsl:with-param name="fn_onblur">txtLimit(this,240,"CorporateBO.Purge_Text","Purge_Text")</xsl:with-param>
        <xsl:with-param name="checkASCII">false</xsl:with-param>
        </xsl:call-template>
        </xsl:template>
         <!-- GroupHouseHold Details changes Start -->

        <xsl:template name="CorporateBO.PrimaryParentCompany">
            <xsl:call-template name="lookup">
                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.PrimaryParentCompany']"/>
                <xsl:with-param name="elename">CorporateBO.PrimaryParentCompany</xsl:with-param>
                <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.PrimaryParentCompany</xsl:with-param>
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
                <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.CountryOfPrincipalOperation</xsl:with-param>
                <xsl:with-param name="max_length">50</xsl:with-param>
                <xsl:with-param name="code_req">true</xsl:with-param>
                <xsl:with-param name="buttonone_fnc">categoryLookupCode('COUNTRY', 'CorporateBO.CountryOfPrincipalOperation','cntry_oper')</xsl:with-param>
                <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.CountryOfPrincipalOperation')</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <!-- GroupHouseHold Details changes End -->



       <!-- CoreInterface Details:start-->


 <xsl:template name="CoreInterfaceBO.OfflineCumDebitLimit">
    <xsl:call-template name="amountlabel">
          <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.OFFLINECUMDEBITLIMIT']"/>
          <xsl:with-param name="ele_name">CoreInterfaceBO.OFFLINECUMDEBITLIMIT</xsl:with-param>
          <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.OFFLINECUMDEBITLIMIT</xsl:with-param>
          <xsl:with-param name="fncname">rate("3_CoreInterfaceBO.OFFLINECUMDEBITLIMIT",boNameCI+".CU_OFFLINECUMDEBITLIMIT",'<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
          <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.CU_OFFLINECUMDEBITLIMIT</xsl:with-param>
          <xsl:with-param name="amountselectname"><xsl:value-of select="$boNameCI"/>.CU_OFFLINECUMDEBITLIMIT</xsl:with-param>
          <xsl:with-param name="onchangefn">checkDropValue("3_CoreInterfaceBO.OfflineCumDebitLimit",'<xsl:value-of select="$boNameCI"/>.CU_OFFLINECUMDEBITLIMIT');</xsl:with-param>
          <xsl:with-param name="fn_onBlur">formatCorpAmount("3_CoreInterfaceBO.OFFLINECUMDEBITLIMIT",boNameCI+".CU_OFFLINECUMDEBITLIMIT","N");</xsl:with-param>
          <xsl:with-param name="choicename">CoreInterfaceBO.CU_OFFLINECUMDEBITLIMIT</xsl:with-param>
    </xsl:call-template>
 </xsl:template>








                 <xsl:template name="CoreInterfaceBO.CustLevelChargesAcct">
                      <xsl:call-template name="label">
                       <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.CUSTLEVELCHARGESACCT']"/>
                       <xsl:with-param name="ele_name">CoreInterfaceBO.CustLevelChargesAcct</xsl:with-param>
                       <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.CUSTLEVELCHARGESACCT</xsl:with-param>
                       <xsl:with-param name="max_length">11</xsl:with-param>
                      </xsl:call-template>
                 </xsl:template>

                 <xsl:template name="CoreInterfaceBO.SourceOfIncome">
                       <xsl:call-template name="label">
                    <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.SOURCEOFINCOME']"/>
                    <xsl:with-param name="ele_name">CoreInterfaceBO.SourceOfIncome</xsl:with-param>
                    <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.SOURCEOFINCOME</xsl:with-param>
                    <xsl:with-param name="checkASCII">false</xsl:with-param>
                       </xsl:call-template>
                 </xsl:template>

                                <!--  RefCode Changes   -->

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

                         <xsl:template name="CoreInterfaceBO.FreeCode3Desc">
                                <xsl:call-template name="mdrpdown">
                                <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE3']"/>
                                <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boNameCI"/>.FreeCode3Desc</xsl:with-param>-->
                                <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.FreeCode3Desc</xsl:with-param>
                                <xsl:with-param name="selectdisp">CoreInterfaceBO.FREECODE3</xsl:with-param>
                                <xsl:with-param name="choice_name">CoreInterfaceBO.FREECODE3</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                                </xsl:call-template>
                        </xsl:template>

                         <xsl:template name="CoreInterfaceBO.FreeCode4Desc">
                                <xsl:call-template name="mdrpdown">
                                <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE4']"/>
                                <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boNameCI"/>.FreeCode4Desc</xsl:with-param>-->
                                <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.FreeCode4Desc</xsl:with-param>
                                <xsl:with-param name="selectdisp">CoreInterfaceBO.FREECODE4</xsl:with-param>
                                <xsl:with-param name="choice_name">CoreInterfaceBO.FREECODE4</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                                </xsl:call-template>
                        </xsl:template>

                         <xsl:template name="CoreInterfaceBO.FreeCode5Desc">
                                <xsl:call-template name="mdrpdown">
                                <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE5']"/>
                                <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boNameCI"/>.FreeCode5Desc</xsl:with-param>-->
                                <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.FreeCode5Desc</xsl:with-param>
                                <xsl:with-param name="selectdisp">CoreInterfaceBO.FREECODE5</xsl:with-param>
                                <xsl:with-param name="choice_name">CoreInterfaceBO.FREECODE5</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
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
                                <xsl:call-template name="mdrpdown">
                                <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE8']"/>
                                <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boNameCI"/>.FreeCode8Desc</xsl:with-param>-->
                                <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.FreeCode8Desc</xsl:with-param>
                                <xsl:with-param name="selectdisp">CoreInterfaceBO.FREECODE8</xsl:with-param>
                                <xsl:with-param name="choice_name">CoreInterfaceBO.FREECODE8</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                                </xsl:call-template>
                        </xsl:template>

                         <xsl:template name="CoreInterfaceBO.FreeCode9Desc">
                                <xsl:call-template name="mdrpdown">
                                <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE9']"/>
                                <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boNameCI"/>.FreeCode9Desc</xsl:with-param>-->
                                <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.FreeCode9Desc</xsl:with-param>
                                <xsl:with-param name="selectdisp">CoreInterfaceBO.FREECODE9</xsl:with-param>
                                <xsl:with-param name="choice_name">CoreInterfaceBO.FREECODE9</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                                </xsl:call-template>
                        </xsl:template>

                         <xsl:template name="CoreInterfaceBO.FreeCode10Desc">
                                <xsl:call-template name="mdrpdown">
                                <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.FREECODE10']"/>
                                <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boNameCI"/>.FreeCode10Desc</xsl:with-param>-->
                                <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.FreeCode10Desc</xsl:with-param>
                                <xsl:with-param name="selectdisp">CoreInterfaceBO.FREECODE10</xsl:with-param>
                                <xsl:with-param name="choice_name">CoreInterfaceBO.FREECODE10</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                                </xsl:call-template>
                        </xsl:template>

                        <!--  RefCode Changes   -->

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
              <!--Tracker ID :79179 this field changed to a dropdown-->
              <xsl:template name="CoreInterfaceBO.PrimarySolID">
            <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.PrimarySolID']"/>
            <xsl:with-param name="selectdisp"><xsl:value-of select="$boNameCI"/>.PrimarySolID</xsl:with-param>
            <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.PrimarySolID</xsl:with-param>
            <xsl:with-param name="choice_name">CoreInterfaceBO.PrimarySolID</xsl:with-param>
            <xsl:with-param name="search_type">value</xsl:with-param>

            </xsl:call-template>
                </xsl:template>
                <!-- Tracker ID :79179 end -->
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

                 <xsl:template name="CoreInterfaceBO.TreasuryCounterParty">
                     <xsl:call-template name="mdrpdown">
                      <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.TreasuryCounterParty']"/>
                      <xsl:with-param name="selectdisp"><xsl:value-of select="$boNameCI"/>.TreasuryCounterParty</xsl:with-param>
                      <xsl:with-param name="selectname"><xsl:value-of select="$boNameCI"/>.TreasuryCounterParty</xsl:with-param>
                      <xsl:with-param name="choice_name">CoreInterfaceBO.TreasuryCounterParty</xsl:with-param>
                      <xsl:with-param name="search_type">value</xsl:with-param>

                     </xsl:call-template>
                 </xsl:template>
                 <xsl:template name="CoreInterfaceBO.TreasuryCounterPartyMne">
                      <xsl:call-template name="label">
                       <xsl:with-param name="res_name" select="$configLabelsCore[@name='CoreInterfaceBO.TreasuryCounterPartyMne']"/>
                       <xsl:with-param name="ele_name">CoreInterfaceBO.TreasuryCounterPartyMne</xsl:with-param>
                       <xsl:with-param name="ele_val"><xsl:value-of select="$boNameCI"/>.TreasuryCounterPartyMne</xsl:with-param>
                       <xsl:with-param name="checkASCII">false</xsl:with-param>
                      </xsl:call-template>
                 </xsl:template>


                 <!--CoreInterface Details:end -->
           <!-- CIF PhoneEmail Changes : Start -->
        <xsl:template name="CorporateBO.Address.preferredAddress">
            <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.preferredAddress']"/>
            <xsl:with-param name="selectname">CorporateBO.Address.preferredAddress</xsl:with-param>
            <xsl:with-param name="selectdisp">CorporateBO.Address.preferredAddress</xsl:with-param>
            <xsl:with-param name="search_type">value</xsl:with-param>
            <xsl:with-param name="defValByUrl">true</xsl:with-param>
                <xsl:with-param name="presdata" select="$PresData"/>
            </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.PhoneEmail.PhoneEmailType">
            <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels[@name='PREFERRED_PHONE']"/>
            <xsl:with-param name="selectname">CorporateBO.PhoneEmail.PhoneEmailType</xsl:with-param>
            <xsl:with-param name="selectdisp">CorporateBO.PhoneEmail.PhoneEmailType</xsl:with-param>
            <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="presdata" select="$PresData"/>
            </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.PhoneEmail.PhoneEmailType1">
            <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels[@name='PREFERRED_EMAIL']"/>
            <xsl:with-param name="selectname">CorporateBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
            <xsl:with-param name="selectdisp">CorporateBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
            <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="presdata" select="$PresData"/>
            </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.AccessOwnerGroup">
             <xsl:call-template name="mdrpdown">
                 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.accessOwnerGroup']"/>
                 <xsl:with-param name="selectname">CorporateBO.accessOwnerGroup</xsl:with-param>
                 <xsl:with-param name="selectdisp">CorporateBO.accessOwnerGroup</xsl:with-param>
                 <xsl:with-param name="search_type">value</xsl:with-param>
                 <xsl:with-param name="choice_name">CorporateBO.accessOwnerGroup</xsl:with-param>
                     <xsl:with-param name="onchangefn">setAccessOwnerGroup();</xsl:with-param>
                 <!-- CIF Changes for Caching Views : Start -->
                 <xsl:with-param name="presdata" select="$PresData"/>
                 <!-- CIF Changes for Caching Views : End -->

             </xsl:call-template>
         </xsl:template>

         <xsl:template name="CorporateBO.AccessOwnerSegment">
             <xsl:call-template name="mdrpdown">
                 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.accessOwnerSegment']"/>
                 <xsl:with-param name="selectname">CorporateBO.accessOwnerSegment</xsl:with-param>
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
            <xsl:with-param name="eleval">CorporateBO.accessOwnerBC</xsl:with-param>
            <!--xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param-->
            <xsl:with-param name="buttonone_name" ><xsl:value-of select="$configLabels[@name='LOOKUP']/@configLabel"/></xsl:with-param>
            <xsl:with-param name="buttontwo_name" ><xsl:value-of select="$configLabels[@name='CLEAR']/@configLabel"/></xsl:with-param>
            <xsl:with-param name="buttonone_fnc">fnBlurCorpLookup("accessOwnerBC")</xsl:with-param>
            <!--xsl:with-param name="buttonone_fnc">openBCCodeLookup('accessOwnerBC')</xsl:with-param-->
            <xsl:with-param name="buttontwo_fnc">setBCCodeValues('accessOwnerBC','','')</xsl:with-param>

        </xsl:call-template>
        </xsl:template>

       <!-- Tracker # 97236 Tracker# 97236 CIF - EBanking changes : Start -->
      <xsl:template name="CorporateBO.IsEbankingEnabled">
             <xsl:call-template name="mdrpdown">
             <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.IsEbankingEnabled']"/>
             <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.IsEbankingEnabled</xsl:with-param>
             <xsl:with-param name="selectdisp">CorporateBO.IsEbankingEnabled</xsl:with-param>
             <xsl:with-param name="ele_name">CorporateBO.IsEbankingEnabled</xsl:with-param>
             <xsl:with-param name="choice_name">CorporateBO.IsEbankingEnabled</xsl:with-param>
             <xsl:with-param name="defaultValue">N</xsl:with-param>
             <xsl:with-param name="presdata" select="$PresData"/>
             </xsl:call-template>
     </xsl:template>
     <!-- Tracker # 97236 Tracker# 97236 CIF - EBanking changes : End -->



        <!-- CIF PhoneEmail Changes : End -->

  <!--   Field Rationalization changes start-->

        <xsl:template name="CorporateBO.CountryOfOrigin">
            <xsl:call-template name="lookup">
                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CountryOfOrigin']"/>
                <xsl:with-param name="elename">CorporateBO.CountryOfOrigin</xsl:with-param>
                <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.CountryOfOrigin</xsl:with-param>
                <xsl:with-param name="code_req">true</xsl:with-param>
                <xsl:with-param name="max_length">50</xsl:with-param>
                <xsl:with-param name="buttonone_fnc">categoryLookupCode('COUNTRY', 'CorporateBO.CountryOfOrigin','cntry_oper')</xsl:with-param>
                <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.CountryOfOrigin')</xsl:with-param>
            </xsl:call-template>
        </xsl:template>

        <xsl:template name="CorporateBO.CountryOfIncorporation">
            <xsl:call-template name="lookup">
                <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CountryOfIncorporation']"/>
                <xsl:with-param name="elename">CorporateBO.CountryOfIncorporation</xsl:with-param>
                <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.CountryOfIncorporation</xsl:with-param>
                <xsl:with-param name="code_req">true</xsl:with-param>
                <xsl:with-param name="max_length">50</xsl:with-param>
                <xsl:with-param name="buttonone_fnc">categoryLookupCode('COUNTRY', 'CorporateBO.CountryOfIncorporation','cntry_oper')</xsl:with-param>
                <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.CountryOfIncorporation')</xsl:with-param>
            </xsl:call-template>
        </xsl:template>

  <!--   Field Rationalization changes end -->
<!-- Memo padding begin -->
     <xsl:template name="MEMOPAD">
        <xsl:call-template name="hyperlink">
        <xsl:with-param name="res_name">MEMO PAD</xsl:with-param>
        <xsl:with-param name="fncname">showMemo('CorpEdit');</xsl:with-param>
        </xsl:call-template>
      </xsl:template>
<!-- Memo padding end -->

<!-- Changes for KYC Enhancement Start-->

<xsl:template name="CorporateBO.riskRating">
	     <xsl:call-template name="mdrpdown">
		     <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.riskRating']"/>
		     <xsl:with-param name="selectDesc">riskRating</xsl:with-param>
		     <xsl:with-param name="selectdisp">CorporateBO.riskRating</xsl:with-param>
		     <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.riskRating</xsl:with-param>
		     <xsl:with-param name="search_type">value</xsl:with-param>
		     <xsl:with-param name="presdata" select="$PresData"/>
		     <xsl:with-param name="choice_name">CorporateBO.riskRating</xsl:with-param>
		     <xsl:with-param name="onchangefn">EnableSubmitKYC()</xsl:with-param>
	    </xsl:call-template>
</xsl:template>

   <xsl:template name="CorporateBO.KYC_ReviewDate">
	       	                     <xsl:call-template name="label">
	       	                     <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.KYC_ReviewDate']"/>
	       	                     <xsl:with-param name="ele_name">CorporateBO.KYC_ReviewDate</xsl:with-param>
	       	                     <xsl:with-param name="ele_val">CorporateBO.KYC_ReviewDate</xsl:with-param>
	       	                     <xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.KYC_ReviewDate");</xsl:with-param>
	       	                     </xsl:call-template>
	                             </xsl:template>
	               
	               <xsl:template name="CorporateBO.KYC_Date">
	       		       <xsl:call-template name="label">
	       		           <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.KYC_Date']"/>
	       		           <xsl:with-param name="ele_name">CorporateBO.KYC_Date</xsl:with-param>
	       		           <xsl:with-param name="ele_val">CorporateBO.KYC_Date</xsl:with-param>
	       		           <xsl:with-param name="fn_onBlur">isGregDate("3_CorporateBO.KYC_Date");</xsl:with-param>
	       		        </xsl:call-template>
	                </xsl:template>
	                           
<xsl:template name="CorporateBO.submitForKYC">
	     <xsl:call-template name="mdrpdown">
		     <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.submitForKYC']"/>
		     <xsl:with-param name="selectDesc">submitForKYC</xsl:with-param>
		     <xsl:with-param name="selectdisp">CorporateBO.submitForKYC</xsl:with-param>
		     <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.submitForKYC</xsl:with-param>
		     <xsl:with-param name="search_type">value</xsl:with-param>
		     <xsl:with-param name="presdata" select="$PresData"/>
		     <xsl:with-param name="defaultValue">N</xsl:with-param>
		     <xsl:with-param name="choice_name">CorporateBO.submitForKYC</xsl:with-param>
		  
	    </xsl:call-template>
</xsl:template> 


<!-- Changes for KYC Enhancement end-->


 <!--***** FATCA Template Definitions Begins Here*****-->
        
        
        
        
        
       <xsl:template name="CorporateBO.ForeignAccTaxReportingReq">
        	<xsl:call-template name="mdrpdown">
        			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.ForeignAccTaxReportingReq']"/>
        			<!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.ForeignAccTaxReportingReq</xsl:with-param>-->
        			<xsl:with-param name="selectdisp">CorporateBO.ForeignAccTaxReportingReq</xsl:with-param>
        			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.ForeignAccTaxReportingReq</xsl:with-param>
        			<xsl:with-param name="choice_name">CorporateBO.ForeignAccTaxReportingReq</xsl:with-param>
        			<xsl:with-param name="search_type">url</xsl:with-param>
        		  <xsl:with-param name="onchangefn">checkForeignAccTaxReport()</xsl:with-param> 
         
        			<xsl:with-param name="presdata" select="$PresData"/>
           </xsl:call-template>
			</xsl:template>
        
        
        
        
        
        
        
        
         <xsl:template name="CorporateBO.ForeignTaxReportingCountry">
	          <xsl:call-template name="lookup">
	          <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.ForeignTaxReportingCountry']"/>
	          <xsl:with-param name="elename">CorporateBO.ForeignTaxReportingCountry</xsl:with-param>
	          <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.ForeignTaxReportingCountry</xsl:with-param>
	          <xsl:with-param name="UsrDataSpace">Main</xsl:with-param>
	          <!-- Field Rationalization changes start-->
	          
	          <xsl:with-param name="code_req">true</xsl:with-param> 
	          <!-- Field Rationalization changes end-->
	          
	  	<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
	  	<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
	          <xsl:with-param name="buttonone_fnc">categoryLookup('FATCA_COUNTRY', 'CorporateBO.ForeignTaxReportingCountry')</xsl:with-param>
	          <xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.ForeignTaxReportingCountry')</xsl:with-param>
	          <xsl:with-param name="checkASCII">false</xsl:with-param>
	          <xsl:with-param name="starshow">true</xsl:with-param>
	          </xsl:call-template>
                </xsl:template>
                     
                     
        
     <xsl:template name="CorporateBO.ForeignTaxReportingStatus">
      	<xsl:call-template name="mdrpdown">
      			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.ForeignTaxReportingStatus']"/>
      			<!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.ForeignTaxReportingStatus</xsl:with-param>-->
      			<xsl:with-param name="selectdisp">CorporateBO.ForeignTaxReportingStatus</xsl:with-param>
      			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.ForeignTaxReportingStatus</xsl:with-param>
      			<xsl:with-param name="choice_name">CorporateBO.ForeignTaxReportingStatus</xsl:with-param>
      			<xsl:with-param name="search_type">url</xsl:with-param>
      		   <xsl:with-param name="starshow">true</xsl:with-param>
      			<xsl:with-param name="presdata" select="$PresData"/>
         </xsl:call-template>
			</xsl:template>
                     
                     
                     
     <xsl:template name="CorporateBO.LastForeignTaxReviewDate">
   	<xsl:call-template name="label">
   		<xsl:with-param name="ele_name">CorporateBO.LastForeignTaxReviewDate</xsl:with-param>
   		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"></xsl:value-of>.LastForeignTaxReviewDate</xsl:with-param>
   		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.LastForeignTaxReviewDate']" />
   
         <xsl:with-param name="fn_onBlur">validateLastTaxReprtReviewDate();</xsl:with-param>
	
   		<xsl:with-param name="starshow">true</xsl:with-param>
   	</xsl:call-template>
</xsl:template> 
        
        
      <xsl:template name="CorporateBO.NextForeignTaxReviewDate">
    	<xsl:call-template name="label">
    		<xsl:with-param name="ele_name">CorporateBO.NextForeignTaxReviewDate</xsl:with-param>
    		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"></xsl:value-of>.NextForeignTaxReviewDate</xsl:with-param>
    		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.NextForeignTaxReviewDate']" />
        <xsl:with-param name="fn_onBlur">validateNextTaxReprtReviewDate();</xsl:with-param>
	 
    		<xsl:with-param name="starshow">true</xsl:with-param>
    	</xsl:call-template>
</xsl:template> 
        
   <xsl:template name="CorporateBO.FatcaRemarks">
   	<xsl:call-template name="mtextarea">
   		<xsl:with-param name="mname">CorporateBO.FatcaRemarks</xsl:with-param>
   		<xsl:with-param name="mvalue"><xsl:value-of select="$boName"></xsl:value-of>.FatcaRemarks</xsl:with-param>
   		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.FatcaRemarks']" />
                 <xsl:with-param name="mrows">2</xsl:with-param>
                   <xsl:with-param name="mcols">16</xsl:with-param>
                    <xsl:with-param name="mcolspan">0</xsl:with-param>
   	</xsl:call-template>
</xsl:template>
 <!--***** FATCA Template Definitions END Here********-->
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

       <xsl:template match="*" mode="mode1">
        <form name="frm2"  method="post" >
     <IFRAME name="hdifrm_empform" width="0" height="0" src="../common/html/SSOblank.html"/>
        <!--Tracker id 113227 changes start-->
        <input type="hidden" name="altLocaleActv" />
        <!--Tracker id 113227 changes end-->
    <IFRAME name="hdifrm_rescifid" width="0" height="0" src="../common/html/SSOblank.html"/>
        <!--Key generation changes start-->
        <input type="hidden" name="hid_cifid" value=""/>
        <input type="hidden" name="hid_reservestatus" value=""/>
        <!--Key generation changes end-->

        <input type="hidden" name="TfFlag" value=""/>
        <input type="hidden" name="sct_Available" value="Y"/>
        <input type="hidden" name="hid_corporateURL" value="{$corporateURL}"/>
        
         <!--Fix for Ticket id 623612 start-->
         <input type="hidden" name="SECUREHKEY"  value="{$HASHKEY}"/>
  	  <input type="hidden" name="FLDHASHKEY"  value="{$KEYFIELD}"/>
            <!--Fix for Ticket id 623612 end-->
        
        <input type="hidden" name="hid_concurDetectX" value="{$concurDetectX}"/>
        <input type="hidden" name="hid_UserID" value=""/>
        <input type="hidden" value="{$isAutoGenKey}" name="isAutoGenKey"/>
        <input type="hidden" value="{$PrimLogID}" name="PrimLogID"/>
        <input type="hidden" value="{$PLogName}" name="PrimLogName"/>
        <!-- Begin of changes by Tracker : 141576 -->
        <input type="hidden" name="isQDE" value="N"/>
        <!-- End of changes by Tracker : 141576 -->
        <!--Changes for minor validations: start-->
        <input type="hidden" name="minorLoaded" value=""/>
        <!--Changes for minor validations: end-->
        <input type="hidden" name="attachedProducts" value=""/>
        <input type="hidden" name="Lookup_label" value=""/>
        <input type="hidden" name="hreadOnly" value="{$readMode}"/>
        <input type="hidden" name="ID" value="{$ID}"/>
        <input type="hidden" name="flagRelType" value="{$flagRelType}"/>
        <input type="hidden" name="hTodayDate" value=""/>
        <input type="hidden" name="genCurncy" value="{$BaseCurrency}"/>
       <!-- new added hidden : for :Copy :start -->
             <input type="hidden" name="IsCopy" value="{$isCopy}"/>
           <!-- new added hidden : for :Copy :end -->
           <input type="hidden" name="tsaFlag" value="{$tsavailedFlg}"/>

           <!-- new added hidden : for :CorpType/Entity :begin -->
           <input type="hidden" name="hid_EntityType" value="{$entityType}"/>
           <input type="hidden" name="hid_PrevEntityType" value="{$PrevEntityType}"/>
           <input type="hidden" name="hid_convTocust" value="{$ConvToCust}"/>
           <!--Changes for Tracker:163001:Start-->
           <input type="hidden" name="fetchFrom" value="{$fetchFrom}"/>
           <!--Changes for Tracker:163001:End-->
           <!-- new added hidden : for :CorpType/Entity :end -->

           <!-- new added hidden : for :Group :begin -->
       <input type="hidden" name="newGrpVal" value=""/>
       <input type="hidden" name="prim_id" value=""/>
       <input type="hidden" name="sec_id" value=""/>
           <!-- new added hidden : for :Group :end -->
           <input type="hidden" name="noOfDaysIntro" value="{$noOfDaysIntro}"/>
        <input type="hidden" name="selAvailBackendID" value=""/>
       <input type="hidden" name="CorporateBO.DefaultAddressType" value=""/>

           <!-- new added hidden : for :relation Lookup :start -->
                        <input type="hidden" name="InputTypeFromLookup" value=""/>
                        <input type="hidden" name="attachedConts" value=""/>
                        <input type="hidden" name="detachedConts" value=""/>
            <input type="hidden" name="corpID" value=""/>
            <input type="hidden" name="corpkey" value=""/>
            <input type="hidden" name="corpName" value=""/>
            <input type="hidden" name="ProcID" value=""/>
            <input type="hidden" name="MainTableID" value=""/>
                    <input type="hidden" name="CoreCustID" value=""/>
           <!-- new added hidden : for :relation Lookup :end -->
        <!-- CoreInterface Details:start-->
        <input type="hidden" name="boNameCI" value="{$boNameCI}"/>
        <input type="hidden" name="hid_coreURL" value="{$coreURL}"/>
        <input type="hidden" name="orgkey" value=""/>
        <input type="hidden" name="entitytype" value=""/>
        <!-- <input type="hidden" name="FreeCode1" value=""/>
        <input type="hidden" name="FreeCode2" value=""/>
        <input type="hidden" name="FreeCode3" value=""/>
        <input type="hidden" name="FreeCode4" value=""/>
        <input type="hidden" name="FreeCode5" value=""/>
        <input type="hidden" name="FreeCode6" value=""/>
        <input type="hidden" name="FreeCode7" value=""/>
        <input type="hidden" name="FreeCode8" value=""/>
        <input type="hidden" name="FreeCode9" value=""/>
        <input type="hidden" name="FreeCode10" value=""/> -->
        <input type="hidden" name="Core_cust_id" value=""/>
        <input type="hidden" name="copyKey" value=""/>
        <!-- CoreInterface Details:end-->
             <!-- CRM6206RECON:TRACKER# 59146 **BEGIN   CHANGES-->
             <input type="hidden" name="isDemoLoaded" value="false"/>
             <input type="hidden" name="isPsychoLoaded" value="false"/>
             <!-- CRM6206RECON:TRACKER# 59146 **END   CHANGES-->

         <!-- Changes for 'WFlow' POC start -->
         <input type="hidden" name="IntWFID" value="{$IntWFID}"/>
         <input type="hidden" name="operationType" value="{$operationType}"/>
         <!-- Changes for 'WFlow' POC end -->

             <!-- Hidden variables for address tab begin-->
             <input type="hidden" name="address_type" value=""/>
             <input type="hidden" name="screenname" value="CIF"/>

            <!-- CRM70T-ST TRACKER:79152:BEGINOFCHANGES -->
        <input type="hidden" name="addType" value=""/>
        <!-- CRM70T-ST TRACKER:79152:ENDOFCHANGES -->
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
            <input type="hidden" name="vAddTypeLT" value=""/>
        <input type="hidden" name="swiftcode" value=""/>
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
            <input type="hidden" name="faxno_local" value=""/> -->
            <input type="hidden" name="IsAddressProofRcvd" value=""/>

            <input type="hidden" name="extension" value=""/>

            <input type="hidden" name="adrURL" value=""/>
            <input type="hidden" name="EduRemoved" value=""/>
            <input type="hidden" name="addr_city_code" value=""/>
            <input type="hidden" name="addr_state_code" value=""/>
            <input type="hidden" name="addr_cntry_code" value=""/>
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
<!--        <input type="hidden" name="EmailPalm" value=""/> -->
        <input type="hidden" name="PhoneEmailRemoved" value=""/>
        <input type="hidden" name="PreferredAddress" value=""/>
        <input type="hidden" name="PreferredPhone" value=""/>
        <input type="hidden" name="PreferredEmail" value=""/>
        <!-- CIF PhoneEmail Changes : End-->
             <!-- Hidden variables for address tab end-->
        <!-- Hidden variables for identification tab end-->
<!--IDENTIFICATION DOCUMENT CHANGES start-->
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

            <!-- Tracker # 97236 Tracker# 97236 CIF - EBanking changes : Start -->
            <input type="hidden" name="IDIssuedOrg" value=""/>
            <!-- Tracker # 97236 Tracker# 97236 CIF - EBanking changes : End -->



            <!-- Hidden variables for identification tab end-->

          <!-- hidden variable for the Introducers :Start -->
         <input type="hidden" name="hIntroducerPsychoURL" value=""/>
         <input type="hidden" name="hIntroducerBankRelation" value=""/>
         <input type="hidden" name="hIntroducerContact" value=""/>
         <input type="hidden" name="hIntroducerRelation" value=""/>
         <input type="hidden" name="hIntroducerFirstName" value=""/>
         <input type="hidden" name="hIntroducerLastName" value=""/>
         <input type="hidden" name="hIntroducerGender" value=""/>
         <input type="hidden" name="hIntroducerIsDependent" value=""/>
         <input type="hidden" name="hIntroducerGuardinType" value=""/>
         <input type="hidden" name="hIntroducerDateOfBirth" value=""/>
         <input type="hidden" name="hIntroducerCIFType" value=""/>
         <input type="hidden" name="hIntroducerIsPrimaryIntro" value=""/>
         <input type="hidden" name="hIntroducerStatus" value=""/>
         <input type="hidden" name="hIntroducerBODateCreated" value=""/>
         <input type="hidden" name="hIntroducerChildcoreCustID" value=""/>
         <input type="hidden" name="hDeletedIntroducerID" value=""/>

         <input type="hidden" name="hIntroducerPsychoURL1" value=""/>
         <input type="hidden" name="hIntroducerBankRelation1" value=""/>
         <input type="hidden" name="hIntroducerContact1" value=""/>
         <input type="hidden" name="hIntroducerRelation1" value=""/>
         <input type="hidden" name="hIntroducerFirstName1" value=""/>
         <input type="hidden" name="hIntroducerLastName1" value=""/>
         <input type="hidden" name="hIntroducerGender1" value=""/>
         <input type="hidden" name="hIntroducerIsDependent1" value=""/>
         <input type="hidden" name="hIntroducerGuardinType1" value=""/>
         <input type="hidden" name="hIntroducerDateOfBirth1" value=""/>
         <input type="hidden" name="hIntroducerCIFType1" value=""/>
         <input type="hidden" name="hIntroducerIsPrimaryIntro1" value=""/>
         <input type="hidden" name="hIntroducerBODateCreated1" value=""/>
         <input type="hidden" name="hIntroducerStatus1" value=""/>
         <input type="hidden" name="hIntroducerChildcoreCustID1" value=""/>
         <input type="hidden" name="hDeletedIntroducerID1" value=""/>
         <input type="hidden" name="Tds_Cust_Id" value=""/>
    <!-- hidden variable for the Introducers :End -->


    <!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->

        <input type="hidden" name="relationship_StartDate" value=""/>
        <input type="hidden" name="date_Of_Commencement" value=""/>
        <input type="hidden" name="RiskProfileExpiryDate" value=""/>
        <input type="hidden" name="date_Of_Incorporation" value=""/>
        <input type="hidden" name="AdvanceAsOnDate" value=""/>
        <input type="hidden" name="Cust_Stat_Chg_Date" value=""/>
        <input type="hidden" name="converted_Date" value=""/>
        <input type="hidden" name="classified_On" value=""/>
        <input type="hidden" name="effective_Date" value=""/>

    <input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
    <!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :ENDOFCHANGES-->


    <!-- CIF Group HouseHold Changes Start -->
        <input type="hidden" name="cntry_oper" value=""/>
        <input type="hidden" name="GroupName" value=""/>
        <input type="hidden" name="GroupID" value=""/>
        <input type="hidden" name="GroupCode" value=""/>
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

    <!-- CIF GroupHouseHold Changes End  -->
        <!-- Changes for Tracker # 98769 begin -->
        <input type="hidden" name="isMCEditedGeneral" value="N"/>
        <input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
        <input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
        <input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>
        <input type="hidden" name="getRole" value="{$getRole}"/>
        <!-- Changes for Tracker # 98769 end -->

        <!-- Changes for the ticketid:374030 Starts -hidden paramters for currency tab -->
        	<input type="hidden" name="CurrencyAccList" value="{$CurrencyAccList}"/>
        	<input type="hidden" name="hid_preferenceURL" value="{$preferenceURL}"/>
        	<input type="hidden" name="hConcessionPsychoURL" value=""/>
			<input type="hidden" name="hConcessioncreditDiscountPercentage" value=""/>
			<input type="hidden" name="hConcessiondebitDiscountPercentage" value=""/>
			<input type="hidden" name="hConcessionwithTaxPercentage" value=""/>
			<input type="hidden" name="hConcessionwithTaxFloorLimit" value=""/>
			<input type="hidden" name="hConcessionpreferentialExpiryDate" value=""/>
			<input type="hidden" name="hConcessionCurrency" value=""/>
			<input type="hidden" name="hDeletedConcessionID" value=""/>
		<!-- Changes for the ticketid:374030 Ends -->
<!--Hidden variables for StrUserFields for tracker id : 251100 / ticket id : 413564 start-->
<input type="hidden" name="StrUserField29" value=""/>
<!--Hidden variables for StrUserFields for tracker id : 251100 / ticket id : 413564 end-->
        <!--Access Control Changes-->
        <input type="hidden" name="accessOwnerGroup" value=""/>
        <input type="hidden" name="accessOwnerBC" value=""/>
        <!--End of Changes-->
        <input type="hidden" name="boName" value="{$boName}"/>
		<!-- Changes for DBS ticket 325152 -->
		<input type="hidden" name="SwiftAddressDetails" value=""/>

    <!-- CIF Changes following added for display of tabs -->
        <xsl:choose>
                    <xsl:when test= "normalize-space($corporateURL)=''">
                <xsl:call-template name="BeginTabView">
                    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                    <xsl:with-param name="tabPageHeight">1300</xsl:with-param>
                </xsl:call-template>
            </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="BeginTabView">
                    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                    <xsl:with-param name="colSpan">6</xsl:with-param>
                    <xsl:with-param name="tabPageHeight">1300</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
<!-- View : General Details :Start   -->

<xsl:call-template name="BeginTabPage">
    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
    <xsl:with-param name="tabPageName">tpageCont</xsl:with-param>
    <xsl:with-param name="spanWidth">1</xsl:with-param>
    <xsl:with-param name="isTabNameHardCoded">false</xsl:with-param>
    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels[@name='GENERAL']"/>
    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
 <!-- CRM11.0:TRACKER:113058:BEGINOFCHANGES -->
    <xsl:with-param name="isInnerToInnerTab" select="'Y'"/>
 <!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->
</xsl:call-template>

    <xsl:call-template name="apply">
             <xsl:with-param name="apply_head">
             <b><xsl:value-of select="$configLabels_11[@name='MLHeader']/@configLabel"/></b>
             </xsl:with-param>
    </xsl:call-template>
<table width="100%" bgcolor='ffffff' cellspacing="0" vspace="0" hspace="0" border="0">
<!-- View : General Details :START -->

<!--Begin Of Changes, ME Phase 3 Tracker ID:131246
Changes by neha_goel03 for GCIF LookUp
Added this template for GCIF LookUp
-->
<!--Begin Of Changes for fix of Tracker ID:138340 -->
<xsl:choose>
    <xsl:when test= "$entityType='Customer'">
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.GCIFID"/>
<xsl:choose>
     <xsl:when test="normalize-space($corporateURL)=''">
<xsl:choose>
<!--tracker id 231104 changes starts-->
<xsl:when test= "normalize-space($strBaselMand)='N'">
	 <xsl:call-template name="BaselProfiling"/>
	   </xsl:when>
</xsl:choose>
<xsl:call-template name="End"/>
</xsl:when>
</xsl:choose>
</xsl:when>
</xsl:choose>
<!--tracker id 231104 changes ends-->
<!--End Of Changes for fix of Tracker ID:138340 -->
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
<xsl:call-template name="CorporateBO.Status_Desc"/>
<xsl:call-template name="CorporateBO.priority"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.delinquency_Flag"/>
<xsl:call-template name="CorporateBO.legalEntity_Type"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.keyContact_PersonName"/>
<!--Field Rationalization starts -->
<xsl:call-template name="CorporateBO.ChargeLevelCode"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.segment"/>
<xsl:call-template name="CorporateBO.subSegment"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<!-- Field Rationalization ends -->
<xsl:call-template name="CorporateBO.phone"/>
<xsl:call-template name="CorporateBO.website_Address"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.business_Type"/>
<xsl:call-template name="CorporateBO.principle_PlaceOperation"/>
<xsl:call-template name="End"/>

<!-- Field Rationalization changes start -->
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.CountryOfIncorporation"/>
<xsl:call-template name="CorporateBO.notes"/>
<xsl:call-template name="End"/>
<!-- Field Rationalization changes end -->

<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.registration_Number"/>
<xsl:call-template name="CorporateBO.date_Of_Incorporation"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.date_Of_Commencement"/>
<xsl:call-template name="CorporateBO.region"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.primary_Service_Center"/>
<xsl:call-template name="CorporateBO.relationship_Type"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.relationship_CreatedBy"/>
<xsl:call-template name="CorporateBO.sector"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<!-- Changes starts for TrackerID:262312 -->
<xsl:call-template name="CorporateBO.subSector"/>
<!--<xsl:call-template name="CorporateBO.Subsector_Code"/>-->
<!-- Changes ends for TrackerID:262312 -->
<xsl:call-template name="CorporateBO.taxID"/>
<xsl:call-template name="End"/>
<!-- Bank customization SearchStatus/PIN by kate Start-->
<xsl:call-template name="Begin"/>
    <xsl:call-template name="CorporateBO.StrUserField10"/>
	<xsl:call-template name="CorporateBO.StrUserField8"/>
    <xsl:call-template name="End"/>
<!-- Bank customization SearchStatus by Kate Ends-->
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.dsaID"/>
<xsl:call-template name="CorporateBO.entityClass"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.source_Of_Funds"/>
<xsl:call-template name="CorporateBO.remarks"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.Crncy_Code"/>
<xsl:call-template name="CorporateBO.average_AnnualIncome"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.TotalFundBase"/>
<xsl:call-template name="CorporateBO.TotalNonFundBase"/>
<xsl:call-template name="End"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.effective_Date"/>
<xsl:call-template name="CorporateBO.customer_Rating"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.classified_On"/>
<xsl:call-template name="CorporateBO.cust_Creation_Mode"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.Cust_Grp_Desc"/>
<xsl:call-template name="CorporateBO.Line_of_Activity_Desc"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.Lang_Desc"/>
<xsl:call-template name="CorporateBO.Health_Desc"/>
<xsl:call-template name="End"/>
<!--ML3 changes end-->
<xsl:call-template name="Begin"/>
    <xsl:call-template name="CorporateBO.NativeLangCode"/>
    <xsl:call-template name="CorporateBO.AdvanceAsOnDate"/>
 <xsl:call-template name="End"/>
<!--ML3 changes end-->
<xsl:call-template name="Begin"/>
<!--<xsl:call-template name="CorporateBO.IncrementalDateUpdate"/> -->

<xsl:call-template name="CorporateBO.Tds_CIF_Id"/>
<xsl:call-template name="CorporateBO.Tds_Tbl_Desc"/>
<xsl:call-template name="End"/>


<!-- ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 start -->

<!-- These templates will be called when entity type is customer -->
<xsl:if test= "normalize-space($entityType)='Customer'">

<!-- Call Templates for 4 new dropdown fields -->

<xsl:call-template name="Begin"/>
    <xsl:call-template name="CorporateBO.islamic_banking_customer"/>
    <xsl:call-template name="CorporateBO.zakat_deduction"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="CorporateBO.asset_classification"/>
    <xsl:call-template name="CorporateBO.Customer_Level_Provisioning"/>
<xsl:call-template name="End"/>
<!--Fix for defect ticket 209648: starts
</xsl:if>
Fix for defect ticket 209648: ends-->
<!-- ERPBOCF1 : CIF addition of fields changes Tracker ID 113276 end -->

<!--ERPBOCF1:TRACKER:113259:BEGINOFCHANGES(HIJRI)-->
<!-- calling template Preferred Calendar-->
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.preferredCalendar"/>
<!-- Changes done by Bharath -->
<xsl:call-template name="CorporateBO.StrUserField14"/>
<xsl:call-template name="End"/>
<!--ERPBOCF1:TRACKER:113259:ENDOFCHANGES(HIJRI)-->
<!--Fix for defect ticket 209648: starts-->
</xsl:if>
<!--Fix for defect ticket 209648: ends-->
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.Purge_Allowed_Flag"/>
<xsl:call-template name="CorporateBO.Purge_Text"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>

<xsl:call-template name="CorporateBO.Cust_Stat_Chg_Date"/>
<xsl:call-template name="CorporateBO.Cust_Swift_Code_Desc"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.converted_Date"/>
<xsl:call-template name="CorporateBO.Cust_Mgr_Opin"/>

<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>

<!-- Field Rationalization starts -->
<xsl:call-template name="CorporateBO.Cust_Const"/>
<xsl:call-template name="CorporateBO.Cust_Type_Desc"/>
<xsl:call-template name="End"/>
<xsl:call-template name="Begin"/>
 <xsl:call-template name="CorporateBO.Is_Swift_Code_of_Bank"/>
 <xsl:call-template name="CorporateBO.old_Entity_Type"/>
<xsl:call-template name="End"/>
<!-- Field Rationalization end -->
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.Email2"/>
<xsl:call-template name="CorporateBO.trade_Services_Availed"/>
<xsl:call-template name="End"/>
<!-- Field Rationalization end -->

<!-- Changes for KYC Enhancement Start-->

<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.riskRating"/>
<xsl:call-template name="CorporateBO.KYC_Date"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
    <xsl:call-template name="CorporateBO.KYC_ReviewDate"/>
    <xsl:call-template name="CorporateBO.submitForKYC"/>
<xsl:call-template name="End"/>

<!-- Changes for KYC Enhancement Ends-->

<!-- pep status james M starts -->

       	 <xsl:call-template name="Begin"/>
			<xsl:call-template name="CorporateBO.StrUserField9"/>		
       	 <xsl:call-template name="End"/>
<!-- pep status james M ends  -->



<!--WMS Field additions: start-->
<xsl:call-template name="Begin"/>
<xsl:call-template name="CorporateBO.RiskProfileScore"/>
<xsl:call-template name="CorporateBO.RiskProfileExpiryDate"/>
<xsl:call-template name="End"/>
<!--WMS Field additions: end-->

<xsl:call-template name="Begin"/>
        <xsl:call-template name="LastUpdateDate"/>
        <xsl:call-template name="CorporateBO.CountryOfOrigin"/>
    <xsl:call-template name="End"/>

<!-- Changes For Ticketid:-286305 Begin
      PrefCode been introduced in General Basic Info tab instead of coreinterface tab--> 
<xsl:call-template name="Begin"/>
<xsl:call-template name="CoreInterfaceBO.PrefCode"/>
<xsl:call-template name="End"/>
<!-- Changes For Ticketid:-286305 End-->

<xsl:call-template name="Begin"/>

<xsl:choose>
  <xsl:when test="normalize-space($docRecvd)='Y'">
  <td class='d1' >
     <xsl:value-of select="$configLabels[@name='CorporateBO.document_Received_Flag']/@configLabel"/>
   </td>
   <td>
     <input type="hidden" name="ckDocument_Received" value="Y"/>
     <INPUT type="checkbox" checked="yes" id="Document_Received" onclick="isDocument_Received()"/>
     </td>
  </xsl:when>
 <xsl:otherwise>
 <td class='d1' >
   <xsl:value-of select="$configLabels[@name='CorporateBO.document_Received_Flag']/@configLabel"/>
   </td>
   <td>
   <input type="hidden" name="ckDocument_Received" value="N"/>
   <INPUT type="checkbox" id="Document_Received" onclick="isDocument_Received()"/>
   </td>
 </xsl:otherwise>
</xsl:choose>
<xsl:call-template name="End"/>

   <!--CIF Ret-Corp-Syncup Changes Start-->

   <xsl:choose>
   <xsl:when test= "not(normalize-space($corporateURL)='')">
   <xsl:call-template name="Begin"/>
           <xsl:call-template name="Signature"/>
   <xsl:call-template name="End"/>
   </xsl:when>
   </xsl:choose>

   <xsl:choose>
   <xsl:when test= "not(normalize-space($corporateURL)='')">
   <xsl:call-template name="Begin"/>
           <xsl:call-template name="CRV"/>
   <xsl:call-template name="End"/>
   </xsl:when>
   </xsl:choose>

   <xsl:choose>
   <xsl:when test= "not(normalize-space($corporateURL)='')">
   <xsl:call-template name="Begin"/>
           <xsl:call-template name="HCCFM"/>
   <xsl:call-template name="End"/>
   </xsl:when>
   </xsl:choose>

   <xsl:call-template name="Begin"/>
   <xsl:call-template name="addemptycell"/>
   <xsl:call-template name="addemptycell"/>
   <xsl:call-template name="End"/>

 <!--CIF Ret-Corp-Syncup Changes End-->
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


<xsl:call-template name="apply">
         <xsl:with-param name="apply_head">
          <b><xsl:value-of select="$configLabels[@name='AccessControl']/@configLabel"/></b>
          </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="Begin"/>
        <xsl:call-template name="CorporateBO.AccessOwnerGroup"/>
        <xsl:call-template name="CorporateBO.accessOwnerBC"/>

    <xsl:call-template name="End"/>
    <xsl:call-template name="Begin"/>
        <xsl:call-template name="CorporateBO.AccessOwnerSegment"/>

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
<table width="100%" bgcolor='ffffff' cellspacing="0" vspace="15" hspace="0" border="0" align = "center">
<TR >

        <TD nowrap="true" align="left" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='Available_BackendID']/@configLabel"/></TD>
        <TD style="width:0.05%">
            <xsl:call-template name="Assigned_BackendID"/>
        </TD>
        <TD width="19%" align="center">
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

</table>
    </xsl:when>
</xsl:choose>



<xsl:variable name="REL_MAN_INFO"><xsl:value-of select="$configLabels[@name='REL_MAN_INFO']/@configLabel"/></xsl:variable>
<table  bgcolor='ffffff' width="100%" border = "0" cellspacing="2" vspace="0" hspace="0">
<tr STYLE="border-bottom: 10px black;" ID="row{$REL_MAN_INFO}" name="row{$REL_MAN_INFO}">
<td colspan = "2" NOWRAP="true" class="LabelFont">

<label FOR="CPD" class="LabelFont"><xsl:value-of select="$REL_MAN_INFO"/>
</label>
</td>
</tr>
</table>


<DIV ID = 'REL_MAN_INFO' STYLE= 'visibility:visible;'>
<table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
<TR ID='rowRelManInfo' name='rowRelManInfo'>
<xsl:call-template name="CorporateBO.PrimaryRMLogin_ID">
<xsl:with-param name="ele_name">CorporateBO.PrimaryRMLogin_ID</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="CorporateBO.SecondRMLogin_ID">
<xsl:with-param name="ele_name">CorporateBO.SecondRMLogin_ID</xsl:with-param>
</xsl:call-template>
</TR>
<TR ID='rowRelManInfo' name='rowRelManInfo'>
<!--fix for ticket 334796 starts-->

    <!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Starts-->
<xsl:call-template name="CorporateBO.TertiaryRMLogin_ID">
	<xsl:with-param name="ele_name">CorporateBO.TertiaryRMLogin_ID</xsl:with-param>
</xsl:call-template>
    <!--Uncommenting fields For CALL ID 353224 and Recon for call id 357852 Ends-->
<!--fix for ticket 334796 ends-->

</TR>
</table>
 </DIV>


<!-- Tracker # 97236 Tracker# 97236 CIF - EBanking changes : Start -->
<xsl:choose>
<xsl:when test= "normalize-space($entityType)='Customer'">
<table bgcolor='E5E5E5' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0">
<xsl:call-template name="Begin"/>
        <xsl:call-template name="apply">
        <xsl:with-param name="apply_head">
        <b><xsl:value-of select="$configLabels[@name='EBanking']/@configLabel"/></b>
        </xsl:with-param>
        </xsl:call-template>
 <xsl:call-template name="End"/>

</table>
 <!-- Tracker #  120249 to align  Enable E Banking: Start -->
<table bgcolor='E5E5E5' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0">
<xsl:call-template name="Begin"/>
    <xsl:call-template name="addemptycell"/>
    <xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="CorporateBO.IsEbankingEnabled"/>
<xsl:call-template name="addemptycell"/>

</table>
</xsl:when>
</xsl:choose>
<!-- Tracker # 97236 Tracker# 97236 CIF - EBanking changes : End -->
           <!--Tracker 113227 changes BEGIN-->
<xsl:choose>
<xsl:when test="normalize-space($altLocaleActv)='true'">
    <table bgcolor='E5E5E5' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0">
    <xsl:call-template name="Begin"/>
            <xsl:call-template name="apply">
            <xsl:with-param name="apply_head">
            <b><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></b>
            </xsl:with-param>
            </xsl:call-template>
     <xsl:call-template name="End"/>

    </table>

    <table bgcolor='WHITE' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0">



<TR ID='rowdual' name='rowdual'>
            <xsl:call-template name="CorporateBO.corporate_Name_alt1">
            </xsl:call-template>
            <xsl:call-template name="CorporateBO.short_Name_alt1">
            </xsl:call-template>

        </TR>

        <TR ID='rowdual' name='rowdual'>
            <xsl:call-template name="CorporateBO.keyContact_PersonName_alt1">
            </xsl:call-template>
            <!--    <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str5_alt1">
            </xsl:call-template>-->
        </TR>

    <!-- TRACKER ID 113276 Changes Begin For Bug Fixing -->
    <!-- For Proper loading of Customer Screen -->
    <!-- Table tag closed -->
    </table>
    <!-- DIV Tag Closure unrequired so commented -->
    <!-- </DIV> -->
    <!-- TRACKER ID 113276 Changes End -->
</xsl:when>

</xsl:choose>
<!-- Tracker 113227 changes : End -->

<xsl:call-template name="EndTabPage"/>
<xsl:call-template name="BeginTabView">
                    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                    <xsl:with-param name="tabPageHeight">335</xsl:with-param>
        </xsl:call-template>
<xsl:call-template name="BeginTabPage">
                <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                <xsl:with-param name="tabPageName">tpageCont1</xsl:with-param>
                <xsl:with-param name="spanWidth">3</xsl:with-param>
                <xsl:with-param name="isTabNameHardCoded">false</xsl:with-param>
                <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels[@name='IDENT']"/>
              <!-- CRM11.0:TRACKER:113058:BEGINOFCHANGES -->
                <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
              <!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->
        </xsl:call-template>
                           <xsl:call-template name="apply">
                 <xsl:with-param name="apply_head">
                 <b><xsl:value-of select="$configLabelsID[@name='Header']/@configLabel"/></b>
                 </xsl:with-param>
            </xsl:call-template>
        <table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
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

        <xsl:call-template name="mainbody">
<!--IDENTIFICATION DOCUMENT CHANGES start-->
        <xsl:with-param name="tablename">EDocRecordSet</xsl:with-param>
        <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='MLHeader6']/@configLabel"/></xsl:with-param>
<!--IDENTIFICATION DOCUMENT CHANGES end-->
        <xsl:with-param name="align">center</xsl:with-param>
        <xsl:with-param name="button">true</xsl:with-param>
        <xsl:with-param name="width">100%</xsl:with-param>
        <xsl:with-param name="name">...</xsl:with-param>
<!--IDENTIFICATION DOCUMENT CHANGES start-->
        <xsl:with-param name="UsrDataSpace">EntityDocument</xsl:with-param>
<!--IDENTIFICATION DOCUMENT CHANGES end-->
        <xsl:with-param name="rowhighlight">true</xsl:with-param>
            <xsl:with-param name="rsfilenm" select="$fileNameID"/>
        <xsl:with-param name="jscriptfnc">,callID()</xsl:with-param>
        <xsl:with-param name="extra_colheader">Select</xsl:with-param>
        <xsl:with-param name="onClick">editIdentificationDetails()</xsl:with-param>
        <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
        <xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
        <xsl:with-param name="PrefixVal">2</xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="EndTabPage"/>

            <!-- Rachit CIF PhoneEmail changes: Start -->

               <xsl:call-template name="BeginTabPage">
                <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                <xsl:with-param name="tabPageName">tpageCont2</xsl:with-param>
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
    <td align="left">
    <xsl:call-template name="user_button_withText">
    <xsl:with-param name="button_name">Add Address</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Add Address']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">addAddressdetails()</xsl:with-param>
        </xsl:call-template>&#160;

        <xsl:call-template name="user_button_withText">
    <xsl:with-param name="button_name">Remove Address</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Remove Address']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">removeAddressdetails()</xsl:with-param>
        </xsl:call-template>&#160;

        <xsl:call-template name="user_button_withText">
    <xsl:with-param name="button_name">Copy Address</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Copy Address']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">copyAddressdetails()</xsl:with-param>
        </xsl:call-template>&#160;
    <xsl:call-template name="user_button_withText">
    <xsl:with-param name="button_name">Swift Address Details</xsl:with-param>
    <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Swift Address Details']/@configLabel"/></xsl:with-param>
    <xsl:with-param name="button_fnc">createSwiftAddress(corpIDSwift,readMode)</xsl:with-param>

    </xsl:call-template>&#160;
        </td>
      </tr>
</table>

    <xsl:call-template name="mainbody">
    <xsl:with-param name="tablename">AdrRecordSet</xsl:with-param>
    <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='MLHeader7']/@configLabel"/></xsl:with-param>
    <xsl:with-param name="align">center</xsl:with-param>
    <xsl:with-param name="button">true</xsl:with-param>
    <xsl:with-param name="width">100%</xsl:with-param>
    <xsl:with-param name="name">...</xsl:with-param>
    <xsl:with-param name="UsrDataSpace">Address</xsl:with-param>
    <xsl:with-param name="rowhighlight">true</xsl:with-param>
          <xsl:with-param name="rsfilenm" select="$fileNameAdr"/>
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
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='ADD_PHONE_EMAIL']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">addPhoneEmail()</xsl:with-param>
        </xsl:call-template>&#160;

        <xsl:call-template name="user_button_withText">
    <xsl:with-param name="button_name">DELETE_PHONE</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='DELETE_PHONE_EMAIL']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">removePhoneEmail()</xsl:with-param>
        </xsl:call-template>&#160;

        <xsl:call-template name="user_button_withText">
    <xsl:with-param name="button_name">COPY_PHONE</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='COPY_PHONE_EMAIL']/@configLabel"/></xsl:with-param>
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

<!--                    <xsl:call-template name="BeginTabPage">
                <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                <xsl:with-param name="tabPageName">tpageCont2</xsl:with-param>
                <xsl:with-param name="spanWidth">3</xsl:with-param>
                <xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
                <xsl:with-param name="tabPageDisplayNameRes">Address</xsl:with-param>
                    </xsl:call-template>

                    <xsl:call-template name="apply">
                 <xsl:with-param name="apply_head">
                 <b><xsl:value-of select="$configLabels_1[@name='MLHeader2']/@configLabel"/></b>
                 </xsl:with-param>
            </xsl:call-template>
<xsl:call-template name="Begin"/>
<xsl:call-template name="addemptycell"/>
<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>
        <table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
                        <tr align="left">
                            <td>
                        <xsl:call-template name="user_button_withText">
                        <xsl:with-param name="button_name">Add Address</xsl:with-param>
                        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Add Address']/@configLabel"/></xsl:with-param>
                        <xsl:with-param name="button_fnc">addAddressdetails()</xsl:with-param>
                        </xsl:call-template>&#160;

                        <xsl:call-template name="user_button_withText">
                        <xsl:with-param name="button_name">Remove Address</xsl:with-param>
                        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Remove Address']/@configLabel"/></xsl:with-param>
                        <xsl:with-param name="button_fnc">removeAddressdetails()</xsl:with-param>
                        </xsl:call-template>&#160;

                        <xsl:call-template name="user_button_withText">
                    <xsl:with-param name="button_name">Copy Address</xsl:with-param>
                    <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Copy Address']/@configLabel"/></xsl:with-param>
                    <xsl:with-param name="button_fnc">copyAddressdetails()</xsl:with-param>
                        </xsl:call-template>&#160;
                        </td>
                    </tr>
        </table>

        <xsl:call-template name="mainbody">
        <xsl:with-param name="tablename">AdrRecordSet</xsl:with-param>
        <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='MLHeader7']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="align">center</xsl:with-param>
        <xsl:with-param name="button">true</xsl:with-param>
        <xsl:with-param name="width">100%</xsl:with-param>
        <xsl:with-param name="name">...</xsl:with-param>
        <xsl:with-param name="UsrDataSpace">Address</xsl:with-param>
        <xsl:with-param name="rowhighlight">true</xsl:with-param>
            <xsl:with-param name="rsfilenm" select="$fileNameAdr"/>
        <xsl:with-param name="jscriptfnc">,call()</xsl:with-param>
        <xsl:with-param name="extra_colheader">Select</xsl:with-param>
        <xsl:with-param name="onClick">editAddressDetails()</xsl:with-param>
        <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
        <xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
        <xsl:with-param name="PrefixVal">2</xsl:with-param>
        </xsl:call-template>

                    <xsl:call-template name="EndTabPage"/>-->
<!-- House hold CIF changes : Begin-->
<xsl:call-template name="BeginTabView">
        <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
        <xsl:with-param name="tabPageHeight">295</xsl:with-param>
    </xsl:call-template>
            <xsl:call-template name="BeginTabPage">
                    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                    <xsl:with-param name="tabPageName">tpageHouseHolds</xsl:with-param>
                    <xsl:with-param name="spanWidth">3</xsl:with-param>
                    <xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameRes">Group Details</xsl:with-param>
                        <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="apply">
             <xsl:with-param name="apply_head">
             <b><xsl:value-of select="$configLabels_11[@name='MLHeader3']/@configLabel"/></b>
             </xsl:with-param>
            </xsl:call-template>

            <tr><td>

			<!-- 10.2.14 enhancements starts here-->
           <xsl:if test="$allowMulti='Y' ">
            <xsl:call-template name="Begin"/>
                <xsl:call-template name="CorporateBO.PrimaryParentCompany"/>
                <xsl:call-template name="CorporateBO.CountryOfPrincipalOperation"/>
            <xsl:call-template name="End"/>
            <table bgcolor="ffffff" align="center" cellpadding="2" width="100%">
            <tr align="left">
            <td >
            <!-- 10.6 enhancements 
			<xsl:call-template name="user_button_withText">
                <xsl:with-param name="button_name">Create New Group</xsl:with-param>
                <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Create New Group']/@configLabel"/></xsl:with-param>
                <xsl:with-param name="button_fnc">createNewGroup()</xsl:with-param>
           </xsl:call-template>&#160; -->

            <xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_fnc">GroupLookup()</xsl:with-param>
                <xsl:with-param name="button_name">Link Group</xsl:with-param>
                <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Link Group']/@configLabel"/></xsl:with-param>
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
        <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='List Of Groups']/@configLabel"/></xsl:with-param>
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
	<xsl:call-template name="End" />
	
<!-- 10.2.14 enhancements ends here-->

<!-- House hold CIF changes : End -->
    </td></tr>

        <xsl:call-template name="EndTabPage"/>

<!--Changes by Ramsurendar -->
<!--        <xsl:call-template name="BeginTabPage">
        <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
        <xsl:with-param name="tabPageName">tpageCont4</xsl:with-param>
        <xsl:with-param name="spanWidth">3</xsl:with-param>
        <xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
        <xsl:with-param name="tabPageDisplayNameRes">Relationships</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="apply">
        <xsl:with-param name="apply_head">
        <b><xsl:value-of select="$configLabels_11[@name='MLHeader4']/@configLabel"/></b>
        </xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="Begin"/>
        <xsl:call-template name="addemptycell"/>
        <xsl:call-template name="addemptycell"/>
        <xsl:call-template name="End"/>
        <table bgcolor="ffffff" align="left" cellpadding="0" width="100%">
        <tr align="left">
        <td>
        <xsl:call-template name="user_button_withText">
        <xsl:with-param name="button_name">Add Relationship</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Add Relationship']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">addIntroducer()</xsl:with-param>
        </xsl:call-template>&#160;
        <xsl:call-template name="user_button_withText">
        <xsl:with-param name="button_name">Remove Relationship</xsl:with-param>
        <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_1[@name='Remove Relationship']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="button_fnc">removeIntroducer()</xsl:with-param>
        </xsl:call-template>&#160;
        </td>
        </tr>
        </table>
        <xsl:call-template name="mainbody">
        <xsl:with-param name="tablename">IntroducerRecordSet</xsl:with-param>
-->
        <!-- Fix : 6 -->
<!--         <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='MLHeader8']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="align">center</xsl:with-param>
        <xsl:with-param name="button">true</xsl:with-param>
        <xsl:with-param name="width">100%</xsl:with-param>
        <xsl:with-param name="name">...</xsl:with-param>
        <xsl:with-param name="UsrDataSpace">IntroducerInfo</xsl:with-param>
        <xsl:with-param name="rowhighlight">true</xsl:with-param>
        <xsl:with-param name="rsfilenm" select="$fileNameIntro"/>
        <xsl:with-param name="jscriptfnc">,call()</xsl:with-param>
        <xsl:with-param name="extra_colheader">Select</xsl:with-param>
-->
        <!-- Fix :10 -->
<!--
        <xsl:with-param name="jscriptfnc">,rowHighLight_Introducer()</xsl:with-param>
        <xsl:with-param name="onClick">editIntroducer()</xsl:with-param>
        <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
        <xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
        <xsl:with-param name="PrefixVal">2</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="Begin"/>
        <xsl:call-template name="addemptycell"/>
        <xsl:call-template name="addemptycell"/>
        <xsl:call-template name="End"/>
        <xsl:call-template name="Begin"/>
        <xsl:call-template name="addemptycell"/>
        <xsl:call-template name="addemptycell"/>
        <xsl:call-template name="End"/>


        <xsl:call-template name="mainbody">
        <xsl:with-param name="tablename">IntroducerToRecordSet</xsl:with-param>
-->
        <!-- Fix : 6 -->
<!--        <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='MLHeader9']/@configLabel"/></xsl:with-param>
        <xsl:with-param name="align">center</xsl:with-param>
        <xsl:with-param name="UsrDataSpace">IntroducerToInfo</xsl:with-param>
        <xsl:with-param name="rowhighlight">true</xsl:with-param>
        <xsl:with-param name="rsfilenm" select="$fileName_Introducer"/>
        <xsl:with-param name="jscriptfnc">,call()</xsl:with-param>
        <xsl:with-param name="onClick">editIntroducer()</xsl:with-param>
        <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
        <xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
        <xsl:with-param name="PrefixVal">2</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="EndTabPage"/>
 -->
<!-- Changes by Ramsurendar end-->

    <!--CoreInterface Details:start-->
    <xsl:call-template name="BeginTabView">
                        <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                        <xsl:with-param name="tabPageHeight">450</xsl:with-param>
                </xsl:call-template>
    <xsl:call-template name="BeginTabPage">
                    <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
                    <xsl:with-param name="tabPageName">tpageCont5</xsl:with-param>
                    <xsl:with-param name="spanWidth">3</xsl:with-param>
                    <xsl:with-param name="isTabNameHardCoded">false</xsl:with-param>
            <!-- Changes start for Ticket Id: 209458 -->
                    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels[@name='MLHeader5']"/>
            <!-- Changes end for Ticket Id: 209458 -->
                        <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
                </xsl:call-template>
      <xsl:call-template name="apply">
    <xsl:with-param name="apply_head">
    <b><xsl:value-of select="$configLabels_11[@name='MLHeader5']/@configLabel"/></b>
    </xsl:with-param>
    </xsl:call-template>
    <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

        <xsl:call-template name="Begin"/>
            <!-- <xsl:call-template name="CoreInterfaceBO.CU_OfflineCumDebitLimit"/>   -->
            <xsl:call-template name="CoreInterfaceBO.OfflineCumDebitLimit"/>
            <xsl:call-template name="CoreInterfaceBO.CustLevelChargesAcct"/>
        <xsl:call-template name="End"/>

        <xsl:call-template name="Begin"/>
            <xsl:call-template name="CoreInterfaceBO.SourceOfIncome"/>
            <xsl:call-template name="CoreInterfaceBO.FreeCode1Desc"/>
        <xsl:call-template name="End"/>
        <xsl:call-template name="Begin"/>
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
            <xsl:call-template name="CoreInterfaceBO.Cust_free_text"/>
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
        <xsl:call-template name="Begin"/>
            <xsl:call-template name="CoreInterfaceBO.Free_text_15"/>
        <!-- Tracker ID: 110739: Begin of changes : For realigning the fields -->
          <!-- Changes For Ticketid:-286305 Begin
      		PrefCode been removed from coreinterface tab-->
          <!--<xsl:call-template name="CoreInterfaceBO.PrefCode"/>-->
          <!-- Changes For Ticketid:-286305 End -->
        <xsl:call-template name="End"/>
        <xsl:call-template name="Begin"/>
            <!--   <xsl:call-template name="CoreInterfaceBO.PrimarySolID"/>  -->

            <xsl:call-template name="CoreInterfaceBO.TreasuryCounterParty"/>


            <xsl:call-template name="CoreInterfaceBO.TreasuryCounterPartyMne"/>
        <!-- Tracker ID: 110739: End of changes -->
        <xsl:call-template name="End"/>
    </table>
    <xsl:call-template name="EndTabPage"/>
    <!--CoreInterface Details:end-->

		<!-- Changes for the ticketid:374030 Starts -For loading the currency tab in general screen-->

		 <xsl:call-template name="BeginTabView">
						<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
						<xsl:with-param name="tabPageHeight">295</xsl:with-param>
				</xsl:call-template>

					<xsl:call-template name="BeginTabPage">
							<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
							<xsl:with-param name="tabPageName">tpageCurr</xsl:with-param>
							<xsl:with-param name="spanWidth">4</xsl:with-param>
							<xsl:with-param name="isTabNameHardCoded">Yes</xsl:with-param>
							<xsl:with-param name="tabPageDisplayNameRes">Currency Details</xsl:with-param>
						<!-- CRM11.0:TRACKER:113058:BEGINOFCHANGES -->
						 <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
						<!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->
			</xsl:call-template>

			<table bgcolor = "ffffff" align="center" border = "0"  cellspacing="0" cellpadding="2" width="100%">

							<tr align="left">
								<td>
									<xsl:call-template name="user_button_withText">
											<xsl:with-param name="button_name">Add Currency</xsl:with-param>
											<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_6[@name='ADD_CONCESSION']/@configLabel"/></xsl:with-param>
									<xsl:with-param name="button_fnc">addConcession()</xsl:with-param>
									</xsl:call-template>&#160;
									<xsl:call-template name="user_button_withText">
											<xsl:with-param name="button_name">Remove Currency</xsl:with-param>
											<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_6[@name='REMOVE_CONCESSION']/@configLabel"/></xsl:with-param>
									<xsl:with-param name="button_fnc">removeConcession()</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
						</table>
						<xsl:call-template name="mainbody">
							<xsl:with-param name="tablename">ConcessionRecordSet</xsl:with-param>
							<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='MLHeader13']/@configLabel"/></xsl:with-param>
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
						<br></br>



						<xsl:call-template name="EndTabPage"/>


						<xsl:call-template name="EndTabView">
							<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
							<xsl:with-param name="selectedTabPageName">tpageBasic</xsl:with-param>
						</xsl:call-template>

		<!-- Changes for the ticketid:374030 Ends -->
		<!-- CHANGE FOR FATCA -->
			
			<xsl:if test= "normalize-space($entityType)='Customer'">
			
			    
			
					<!-- Changes for the ticketid:374030 Starts -For loading the currency tab in general screen-->
			
					 <xsl:call-template name="BeginTabView">
									<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
									<xsl:with-param name="tabPageHeight">295</xsl:with-param>
							</xsl:call-template>
			
								<xsl:call-template name="BeginTabPage">
										<xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
										<xsl:with-param name="tabPageName">tpageTest</xsl:with-param>
										<xsl:with-param name="spanWidth">4</xsl:with-param>
										<xsl:with-param name="isTabNameHardCoded">false</xsl:with-param>
									<xsl:with-param name="tabPageDisplayNameRes" select="$configLabels[@name='TaxCertificationDetails']"/>	
									
									<xsl:with-param name="fn_tabSelect">focusFirstFatcaField();</xsl:with-param>
						</xsl:call-template>
			
						 <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
		
						
						    			<xsl:call-template name="apply">
						    		     <xsl:with-param name="apply_head">
						    		     <b><xsl:value-of select="$configLabels[@name='TaxCertificationDetails']/@configLabel"/></b>
						    		     </xsl:with-param>
						    			</xsl:call-template>
		
						    
						    
						    
						    
						    <xsl:call-template name="Begin"/>
						            <xsl:call-template name="CorporateBO.ForeignAccTaxReportingReq"/>	
						           <xsl:call-template name="CorporateBO.ForeignTaxReportingCountry"/>
		                                         <xsl:call-template name="End"/>
		                                         
		                                         
							 				     <xsl:call-template name="Begin"/>
							 				         <xsl:call-template name="CorporateBO.ForeignTaxReportingStatus"/>
							 	
							 				          <xsl:call-template name="CorporateBO.LastForeignTaxReviewDate"/>
		                                         <xsl:call-template name="End"/>
		                                         
							 				     <xsl:call-template name="Begin"/>
							 				           <xsl:call-template name="CorporateBO.NextForeignTaxReviewDate"/>
							 				          <xsl:call-template name="CorporateBO.FatcaRemarks"/>
		                                         <xsl:call-template name="End"/>
		                                         
					</table>
					
			
								<xsl:call-template name="EndTabPage"/>
								
								</xsl:if>
			
	<!-- CHANGE ENDS FOR FATCA -->
		

        <xsl:call-template name="EndTabView">
        <xsl:with-param name="tabViewName">tabDemoForm</xsl:with-param>
        <xsl:with-param name="selectedTabPageName">tpageCont</xsl:with-param>
        </xsl:call-template>
    <script>

        var DataCount = 0;

        <xsl:for-each select="$PresCurrData/SRMComposite[@n='CurrencyRecordSet']/SRMRow">
            DataArray[DataCount] = '<xsl:value-of select="./Z[@n='CurrencyBO.CurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.Format']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.NumberOfDecimals']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.MantissaSeperator']"/>'+"|"+'<xsl:value-of select="./Z[@n='CurrencyBO.DecimalSeperator']"/>';
            DataCount++;

        </xsl:for-each>

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
        <!-- Tracker ID Begins : 209607 -->
    <p id="myPar"></p>
        <!-- Tracker ID Ends : 209607 -->
 <!-- GroupHouseHold Changes start -->
    <form name="frm3"  method="post" action='../servlet/com.infy.cis.ui.admin.GroupHouseHoldForm?isPopup=Yes&amp;isLinked=Yes&amp;isEdit=Yes&amp;GroupHouseHoldFlag=G&amp;isNew=N&amp;details=null'>
        <input type="hidden" name="GroupName" value=""/>
        <input type="hidden" name="PercentShare" value=""/>
        <input type="hidden" name="GlobalRM" value=""/>
	<!-- Recon from CRM10301BSUPP-Listing changes-->
	<input type="hidden" name="SubScreen" value="{$entityType}"/>
	<!-- Recon from CRM10301BSUPP-Listing changes-->        
        <input type="hidden" name="Name_Nat" value=""/>

        <!-- CRM101UB Start  -->
        <input type="hidden" name="Group_ID" value=""/>
        <input type="hidden" name="Prim_Grp_ID" value=""/>
        <!-- CRM101UB Start  -->

        <input type="hidden" name="readMode" value="{$readMode}"/>
    </form>
<!-- GroupHouseHold Changes end -->
                </xsl:template>
        <xsl:template match="SRM">
        <xsl:for-each select=".">
             <xsl:call-template name="startTable"/>
               <!-- COMMENTED FOR INCORPORATING MULTITAB CONCEPT
               <table bgcolor='ffffff' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
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
<!--<table  class="background" align='center' width="98%" cellpadding="0" cellspacing="0"> -->
 <!-- <xsl:apply-templates select="SRM"/>
</table>  -->
              <table bgcolor='ffffff' width="100%" border="0" cellspacing="0" cellpadding="0">
                  <xsl:apply-templates select="." mode="mode1"/>

                </table>

             <xsl:call-template name="endTable"/>
        </xsl:for-each>

        </xsl:template>
</xsl:stylesheet>